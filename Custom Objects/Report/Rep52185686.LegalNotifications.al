report 52185686 "Legal Notifications"
{
    ApplicationArea = All;
    Caption = 'Legal Notifications';
    UsageCategory = ReportsandAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(LegalUpcomingMatters; "Legal Upcoming Matters")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                LegalDeadlineDate: date;
                AppealsDeadlineDate: date;
                msg: Text;
                EmailManager: Codeunit "Email Message";
                Email: Codeunit Email;
                UserSetup: Record "User Setup";

            begin
                if (LegalUpcomingMatters."Shceduled Date" = 0D) then begin
                    CurrReport.Skip();
                end;
                LegalDeadlineDate := CalcDate('-5D', LegalUpcomingMatters."Shceduled Date");

                if LegalDeadlineDate = Today then begin
                    NotificationSetup.RESET;
                    NotificationSetup.SetRange(Notification, NotificationSetup.Notification::Legal);
                    NotificationSetup.SetRange("Send Email", true);
                    if NotificationSetup.Find('-') then begin

                        repeat
                            UserSetup.Reset();
                            UserSetup.SetRange("User ID", NotificationSetup."user id");
                            if UserSetup.FindFirst() then begin
                                //msg := 'tested and verifeid';
                                msg := 'Dear Legal Department,\' + NewLine + 'We would like to bring to your attention an important update regarding ongoing litigation related to ' +
                                 LegalUpcomingMatters."Case Number" + ' and Case Reference Number ' + LegalUpcomingMatters."Record ID" + '.' +
                                'The action required is ' + LegalUpcomingMatters.Matter + '.' + 'The deadline for the same is '
                                + FORMAT(LegalUpcomingMatters."Shceduled Date") + '.\' + 'Please take necessary action\. Thank you.';
                                // Message(msg);
                                EmailManager.Create(UserSetup."E-Mail", 'Litigation Upcoming Matters', msg, true);
                                Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                            end;
                        until NotificationSetup.NEXT = 0;
                        Message('Email Sent Successfully');
                    end;
                end;
            end;
            // Appeals.RESET;
            // Appeals.SETRANGE("No.", LegalUpcomingMatters."Record ID");
            // Appeals.SetRange(Status, Legal.Status::Approved);
            // if Appeals.Find('-') then begin
            //    repeat
            // if (LegalUpcomingMatters."Shceduled Date" = 0D) then begin
            //     //Message('Please Enter Respective Scheduled Dates.');
            //     CurrReport.Skip();
            // end;
            // AppealsDeadlineDate := CalcDate('-5D', LegalUpcomingMatters."Shceduled Date");
            // if AppealsDeadlineDate = Today then begin
            //     UserSetup.GET(UserSetup."User ID");
            //     msg := 'Dear Legal Department, ' + 'We would like to bring to your attention an important update regarding ongoing litigation related to ' + Appeals."Case Number" + '.' + 'The action required is ' + LegalUpcomingMatters.Matter + '.' + 'The deadline for the same is ' + FORMAT(LegalUpcomingMatters."Shceduled Date") + '.' + 'Please take necessary action.' + 'Thank you.';
            //     EmailManager.Create(UserSetup."E-Mail", 'Appeals Upcoming Maatters', msg, true);
            //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
            // end;
            // until Appeals.NEXT = 0;
            // end;
            // end;
        }
        dataitem(Perfection_File_Action; "Perfection File Action")
        {
            trigger OnAfterGetRecord()
            Var
                msg: Text;
                EmailManager: Codeunit "Email Message";
                Email: Codeunit Email;
                UserSetup: Record "User Setup";

            begin
                if (Perfection_File_Action."End Date" = 0D) then begin
                    CurrReport.Skip();
                end;
                if ("TAT Sent" = true) then begin
                    CurrReport.Skip();
                end
                else
                    if ("TAT Sent" = false) then begin
                        NotificationSetup.RESET;
                        NotificationSetup.SetRange(Notification, NotificationSetup.Notification::Legal);
                        NotificationSetup.SetRange("Send Email", true);
                        if NotificationSetup.Find('-') then begin
                            repeat
                                UserSetup.Reset();
                                UserSetup.SetRange("User ID", NotificationSetup."user id");
                                if UserSetup.FindFirst() then begin
                                    msg := 'Dear Legal Department, \' + 'As of' + ' ' + Format(Perfection_File_Action."End Date") + ', ' + 'the TAT for the Security Perfection No.' + ' ' + Perfection_File_Action."Perfection No." + ' ' +
                                'is' + ' ' + FORMAT(Perfection_File_Action."Action On File") + ' ' + 'after' + ' ' + Perfection_File_Action.TAT + '.' + 'It Is important that we meet our TAT commitment to ensure the successful and timely completion of this' + ' '
                                + Perfection_File_Action."Perfection No." + '.';
                                    //Message(msg);
                                    EmailManager.Create(UserSetup."E-Mail", 'Perfection File Action TAT', msg, true);
                                    Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                                end;
                                Perfection_File_Action."TAT Sent" := true;
                                Perfection_File_Action.MODIFY;
                            until NotificationSetup.NEXT = 0;
                        end;
                    end;
            end;
        }


        dataitem(Contract_Expectations; "Contract Expectations")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DueDate: date;
                usermail: Text;
                username: text;
                EmailManager: Codeunit "Email Message";
                Email: Codeunit Email;
                UserSetup: Record "User Setup";

            begin
                //ContractExpections.RESET;
                //ContractExpections.SETRANGE("Contract No", Contracts."Contract No");
                //ContractExpections.SETRANGE("Staff User ID", UserSetup."User ID");
                if ContractExpections."Due Date" <> 0D then
                    //if ContractExpections.Find('-') then begin
                    //repeat
                DueDate := CalcDate('-5D', ContractExpections."Due Date");
                Message('Due date is ' + FORMAT(DueDate) + ' and today is ' + FORMAT(Today));
                if DueDate <= Today then begin

                    UserSetup.GET(UserId);
                    //UserSetup.SetRange("User ID", ContractExpections."Staff User ID");
                    //if UserSetup.FindFirst() then begin
                    //Usermail := UserSetup."E-Mail";
                    msg := 'Dear' + ' ' + ContractExpections."Person Responsible" + ',' + 'I hope this finds you well. We have an important matter that requires your immediate attention and action. We kindly request your prompt execution of Contract Number' + ContractExpections."Contract No" + '.' + 'The action required is ' + ContractExpections.Description + '.' + 'The deadline for the same is ' + FORMAT(ContractExpections."Due Date") + '.' + 'Please take necessary action.' + 'Thank you.';
                    //EmailManager.Create(UserSetup."E-Mail", 'Contract Execution', msg, true);
                    EmailManager.Create(UserSetup."E-Mail", 'Contract Execution', msg, true);
                    Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                    Message('Email Sent Successfully');
                end;
            end;
            //Until ContractExpections.NEXT = 0;
            //end;
            //end;
        }
        dataitem(Contracts; Contracts)
        {
            trigger OnAfterGetRecord()
            begin
                if Contracts.Terminated = true then
                    CurrReport.Skip()
                else
                    if Contracts.Expired = true then
                        CurrReport.Skip()
                    else
                        if Contracts."End Date" = 0D then
                            CurrReport.Skip()
                        else if Contracts."End Date" = Today then
                            Contracts."Contract Status" := Contracts."Contract Status"::Expired;
                Contracts.Expired := true;
                Contracts.MODIFY;
            end;
        }
        dataitem(SecuritiesRegister; "Securities Register")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                ExpiryNotificationDate: Date;
                Loans: Record Loans;
                Members: Record Members;
                SendSMS: Codeunit SendSms;
                msg: Text;
                Source: enum "SMS Source";

            begin
                if SecuritiesRegister."Collateral Hold Types" = SecuritiesRegister."Collateral Hold Types"::"Lease Hold" then begin
                    Loans.RESET;
                    Loans.SetRange("Loan No.", SecuritiesRegister."Loan No.");
                    Loans.SetRange(Posted, true);
                    Loans.SetFilter("Outstanding Balance", '>0');
                    IF Loans.Find('-') then begin
                        repeat
                            ExpiryNotificationDate := CalcDate('-2W', SecuritiesRegister."Lease/Ownership Exp. Date");
                            Members.RESET;
                            Members.SETRANGE("No.", Loans."Member No.");
                            if Members.FindFirst() then begin
                                if ExpiryNotificationDate = TODAY THEN begin
                                    if Members."Phone No." <> '' then begin
                                        msg := 'Dear' + ' ' + Members."Name" + ',' + 'this is to remind you that the lease/ownership of the property with Loan No.' + ' ' + Loans."Loan No." + ' ' + 'is due to expire on' + ' ' + FORMAT(SecuritiesRegister."Lease/Ownership Exp. Date") + '.' + 'Please take necessary action to renew the lease/ownership.' + 'Thank you.';
                                        SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', SecuritiesRegister."No.", 'CBS', Today);
                                    end
                                    else
                                        msg := 'Dear' + ' ' + Members."Name" + ',' + 'this is to remind you that the lease/ownership of the property with Loan No.' + ' ' + Loans."Loan No." + ' ' + 'is due to expire on' + ' ' + FORMAT(SecuritiesRegister."Lease/Ownership Exp. Date") + '.' + 'Please take necessary action to renew the lease/ownership.' + 'Thank you.';
                                    SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', SecuritiesRegister."No.", 'CBS', Today);

                                end;
                            end;
                        until Loans.Next = 0;
                    end
                end
                else
                    exit;
            end;

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    procedure NewLine() NewLine: Text
    var
        nL: Char;
    begin

        nL := 13;
        NewLine := Format(nL, 0, '<CHAR>');
    end;

    var
        Legal: Record Legal;
        Appeals: Record "Appeals Table";
        UserSetup: Record "User Setup";
        Office: Record Unit;
        SmtpSet: Record "Email Account";
        // EmailManager: Codeunit "Email Message";
        // Email: Codeunit Email;
        msg: Text;
        ContractExpections: Record "Contract Expectation Details";
        //Contracts: Record "Contracts";
        NotificationSetup: Record "Notification EmSms setup";
}
