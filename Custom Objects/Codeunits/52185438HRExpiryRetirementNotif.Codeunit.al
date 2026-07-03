codeunit 52185438 "HR Expiry & Retirement Notif"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        RunDailyNotificationCheck();
    end;

    procedure RunDailyNotificationCheck()
    var
        HRSetup: Record "HR Setup";
    begin
        if not HRSetup.Get() then
            exit;

        if HRSetup."Enable Contract Notifications" then
            CheckContractExpiries();

        if HRSetup."Enable Retire Notifications" then
            CheckRetirements();
    end;

    local procedure CheckContractExpiries()
    var
        HREmployee: Record "HR Employees";
        HRSetup: Record "HR Setup";
        HRNotifLog: Record "HR Notification Log";
        WarningDate: Date;
        DaysRemaining: Integer;
    begin
        if not HRSetup.Get() then
            exit;

        if HRSetup."Contract Expiry Warning Days" <= 0 then
            exit;

        HREmployee.Reset();
        HREmployee.SetFilter("Contract End Date", '<>%1', 0D);
        HREmployee.SetRange(Status, HREmployee.Status::Active);
        if HREmployee.FindSet() then
            repeat
                WarningDate := HREmployee."Contract End Date";
                DaysRemaining := WarningDate - Today;

                if (DaysRemaining > 0) and (DaysRemaining <= HRSetup."Contract Expiry Warning Days") then begin
                    if not NotificationAlreadySent(HREmployee."No.", HRNotifLog."Notification Type"::"Contract Expiry", WarningDate) then begin
                        SendContractExpiryEmail(HREmployee, DaysRemaining);
                    end;
                end;
            until HREmployee.Next() = 0;
    end;

    local procedure CheckRetirements()
    var
        HREmployee: Record "HR Employees";
        HRSetup: Record "HR Setup";
        HRNotifLog: Record "HR Notification Log";
        WarningDate: Date;
        MonthsRemaining: Integer;
    begin
        if not HRSetup.Get() then
            exit;

        if HRSetup."Retirement Warning Months" <= 0 then
            exit;

        HREmployee.Reset();
        HREmployee.SetFilter("Retirement date", '<>%1', 0D);
        HREmployee.SetRange(Status, HREmployee.Status::Active);
        if HREmployee.FindSet() then
            repeat
                WarningDate := HREmployee."Retirement date";
                MonthsRemaining := Round((WarningDate - Today) / 30, 1, '=');

                if (MonthsRemaining > 0) and (MonthsRemaining <= HRSetup."Retirement Warning Months") then begin
                    if not NotificationAlreadySent(HREmployee."No.", HRNotifLog."Notification Type"::Retirement, WarningDate) then begin
                        SendRetirementEmail(HREmployee, MonthsRemaining);
                    end;
                end;
            until HREmployee.Next() = 0;
    end;

    local procedure NotificationAlreadySent(EmployeeNo: Code[20]; NotifType: Option; WarningDate: Date): Boolean
    var
        HRNotifLog: Record "HR Notification Log";
    begin
        HRNotifLog.Reset();
        HRNotifLog.SetRange("Employee No.", EmployeeNo);
        HRNotifLog.SetRange("Notification Type", NotifType);
        HRNotifLog.SetRange("Warning Date", WarningDate);
        HRNotifLog.SetRange(Status, HRNotifLog.Status::Sent);
        exit(not HRNotifLog.IsEmpty);
    end;

    local procedure SendContractExpiryEmail(HREmployee: Record "HR Employees"; DaysRemaining: Integer)
    var
        HRSetup: Record "HR Setup";
        CompInfo: Record "Company Information";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        Subject: Text;
        RecipientList: List of [Text];
        HODEmail: Text[100];
    begin
        if not HRSetup.Get() then
            exit;

        CompInfo.Get();

        Subject := StrSubstNo('Contract Expiry Notification - %1 - %2 Days Remaining', HREmployee."Full Name", DaysRemaining);

        EmailBody := '<html><body style="font-family: Arial, sans-serif;">';
        EmailBody += '<h2 style="color: #d9534f;">Contract Expiry Notification</h2>';
        EmailBody += '<p>This is an automated notification regarding an upcoming contract expiry:</p>';
        EmailBody += '<table style="border-collapse: collapse; width: 100%; margin-top: 20px;">';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Employee Name:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."Full Name" + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Employee No:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."No." + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Position:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee.Position + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Department:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."Responsibility Center" + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Contract End Date:</strong></td><td style="padding: 8px; border: 1px solid #ddd; color: #d9534f;"><strong>' + Format(HREmployee."Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>') + '</strong></td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Days Remaining:</strong></td><td style="padding: 8px; border: 1px solid #ddd; color: #d9534f;"><strong>' + Format(DaysRemaining) + ' days</strong></td></tr>';
        EmailBody += '</table>';
        EmailBody += '<br><p><strong>Action Required:</strong></p>';
        EmailBody += '<ul>';
        EmailBody += '<li>Review contract renewal requirements</li>';
        EmailBody += '<li>Discuss contract extension with the employee if applicable</li>';
        EmailBody += '<li>Prepare exit documentation if contract will not be renewed</li>';
        EmailBody += '<li>Initiate contract renewal process through the HR System</li>';
        EmailBody += '</ul>';
        EmailBody += '<br><p style="color: #666;">Best regards,<br><strong>' + CompInfo.Name + '</strong><br>HR Management System</p>';
        EmailBody += '</body></html>';

        Clear(RecipientList);

        if HRSetup."HR Admin Email" <> '' then
            RecipientList.Add(HRSetup."HR Admin Email");

        if HREmployee."E-Mail" <> '' then
            RecipientList.Add(HREmployee."E-Mail");

        HODEmail := GetHODEmail(HREmployee."Responsibility Center");
        if HODEmail <> '' then
            RecipientList.Add(HODEmail);

        if RecipientList.Count > 0 then begin
            EmailMsg.Create(RecipientList, Subject, EmailBody, true);
            if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
                LogNotification(HREmployee, 0, DaysRemaining, RecipientList, true, '')
            else
                LogNotification(HREmployee, 0, DaysRemaining, RecipientList, false, 'Email send failed');
        end else begin
            LogNotification(HREmployee, 0, DaysRemaining, RecipientList, false, 'No recipient email configured');
        end;
    end;

    local procedure SendRetirementEmail(HREmployee: Record "HR Employees"; MonthsRemaining: Integer)
    var
        HRSetup: Record "HR Setup";
        CompInfo: Record "Company Information";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        Subject: Text;
        RecipientList: List of [Text];
        HODEmail: Text[100];
    begin
        if not HRSetup.Get() then
            exit;

        CompInfo.Get();

        Subject := StrSubstNo('Retirement Notification - %1 - %2 Months Remaining', HREmployee."Full Name", MonthsRemaining);

        EmailBody := '<html><body style="font-family: Arial, sans-serif;">';
        EmailBody += '<h2 style="color: #f0ad4e;">Retirement Notification</h2>';
        EmailBody += '<p>This is an automated notification regarding an upcoming retirement:</p>';
        EmailBody += '<table style="border-collapse: collapse; width: 100%; margin-top: 20px;">';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Employee Name:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."Full Name" + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Employee No:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."No." + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Position:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee.Position + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Department:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + HREmployee."Responsibility Center" + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Date of Birth:</strong></td><td style="padding: 8px; border: 1px solid #ddd;">' + Format(HREmployee."Date Of Birth", 0, '<Day,2>/<Month,2>/<Year4>') + '</td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Retirement Date:</strong></td><td style="padding: 8px; border: 1px solid #ddd; color: #f0ad4e;"><strong>' + Format(HREmployee."Retirement date", 0, '<Day,2>/<Month,2>/<Year4>') + '</strong></td></tr>';
        EmailBody += '<tr><td style="padding: 8px; border: 1px solid #ddd;"><strong>Months Remaining:</strong></td><td style="padding: 8px; border: 1px solid #ddd; color: #f0ad4e;"><strong>' + Format(MonthsRemaining) + ' months</strong></td></tr>';
        EmailBody += '</table>';
        EmailBody += '<br><p><strong>Preparation Required:</strong></p>';
        EmailBody += '<ul>';
        EmailBody += '<li>Begin retirement benefits processing</li>';
        EmailBody += '<li>Plan knowledge transfer sessions</li>';
        EmailBody += '<li>Initiate succession planning</li>';
        EmailBody += '<li>Prepare exit documentation and clearance forms</li>';
        EmailBody += '<li>Schedule retirement counseling session</li>';
        EmailBody += '</ul>';
        EmailBody += '<br><p style="color: #666;">Best regards,<br><strong>' + CompInfo.Name + '</strong><br>HR Management System</p>';
        EmailBody += '</body></html>';

        Clear(RecipientList);

        if HRSetup."HR Admin Email" <> '' then
            RecipientList.Add(HRSetup."HR Admin Email");

        if HREmployee."E-Mail" <> '' then
            RecipientList.Add(HREmployee."E-Mail");

        HODEmail := GetHODEmail(HREmployee."Responsibility Center");
        if HODEmail <> '' then
            RecipientList.Add(HODEmail);

        if RecipientList.Count > 0 then begin
            EmailMsg.Create(RecipientList, Subject, EmailBody, true);
            if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
                LogNotification(HREmployee, 1, MonthsRemaining, RecipientList, true, '')
            else
                LogNotification(HREmployee, 1, MonthsRemaining, RecipientList, false, 'Email send failed');
        end else begin
            LogNotification(HREmployee, 1, MonthsRemaining, RecipientList, false, 'No recipient email configured');
        end;
    end;

    local procedure GetHODEmail(DepartmentCode: Code[20]): Text[100]
    var
        HRHeadOfDept: Record "HR Heads of Departments";
        HREmployee: Record "HR Employees";
    begin
        HRHeadOfDept.Reset();
        HRHeadOfDept.SetRange("Responsibility Center", DepartmentCode);
        if HRHeadOfDept.FindFirst() then begin
            if HREmployee.Get(HRHeadOfDept."Employee No.") then
                exit(HREmployee."E-Mail");
        end;
        exit('');
    end;

    local procedure LogNotification(HREmployee: Record "HR Employees"; NotifType: Option; DaysOrMonths: Integer; RecipientList: List of [Text]; Success: Boolean; ErrorMsg: Text)
    var
        HRNotifLog: Record "HR Notification Log";
        Recipients: Text;
        RecipientEmail: Text;
    begin
        HRNotifLog.Init();
        HRNotifLog."Entry No." := 0;
        HRNotifLog."Employee No." := HREmployee."No.";
        HRNotifLog."Notification Type" := NotifType;
        HRNotifLog."Days/Months Remaining" := DaysOrMonths;
        HRNotifLog."Employee Department" := HREmployee."Responsibility Center";
        HRNotifLog."Employee Position" := HREmployee.Position;
        HRNotifLog."Notification Sent Date" := CurrentDateTime;

        if NotifType = 0 then begin
            HRNotifLog."Warning Date" := HREmployee."Contract End Date";
            HRNotifLog."Contract End Date" := HREmployee."Contract End Date";
        end else begin
            HRNotifLog."Warning Date" := HREmployee."Retirement date";
            HRNotifLog."Retirement Date" := HREmployee."Retirement date";
        end;

        Recipients := '';
        foreach RecipientEmail in RecipientList do begin
            if Recipients <> '' then
                Recipients += '; ';
            Recipients += RecipientEmail;
        end;
        if StrLen(Recipients) > 250 then
            Recipients := CopyStr(Recipients, 1, 250);
        HRNotifLog."Recipient Email" := Recipients;

        if Success then
            HRNotifLog.Status := HRNotifLog.Status::Sent
        else begin
            HRNotifLog.Status := HRNotifLog.Status::Failed;
            if StrLen(ErrorMsg) > 250 then
                ErrorMsg := CopyStr(ErrorMsg, 1, 250);
            HRNotifLog."Error Message" := ErrorMsg;
        end;

        HRNotifLog.Insert(true);
    end;

    procedure ResendFailedNotifications()
    var
        HRNotifLog: Record "HR Notification Log";
        HREmployee: Record "HR Employees";
        ResentCount: Integer;
        SkippedCount: Integer;
    begin
        HRNotifLog.Reset();
        HRNotifLog.SetRange(Status, HRNotifLog.Status::Failed);
        HRNotifLog.SetFilter("Created Date Time", '>%1', CreateDateTime(CalcDate('<-7D>', Today), 0T));

        if HRNotifLog.FindSet() then
            repeat
                if HREmployee.Get(HRNotifLog."Employee No.") then begin
                    if HRNotifLog."Notification Type" = HRNotifLog."Notification Type"::"Contract Expiry" then begin
                        if (HREmployee."Contract End Date" >= Today) then begin
                            SendContractExpiryEmail(HREmployee, HREmployee."Contract End Date" - Today);
                            HRNotifLog.Delete(true);
                            ResentCount += 1;
                        end else
                            SkippedCount += 1;
                    end else begin
                        if (HREmployee."Retirement date" >= Today) then begin
                            SendRetirementEmail(HREmployee, Round((HREmployee."Retirement date" - Today) / 30, 1, '='));
                            HRNotifLog.Delete(true);
                            ResentCount += 1;
                        end else
                            SkippedCount += 1;
                    end;
                end else
                    SkippedCount += 1;
            until HRNotifLog.Next() = 0;

        Message('Resent %1 notifications. Skipped %2 expired or invalid notifications.', ResentCount, SkippedCount);
    end;
}
