
report 52186884 HremployeesJobQueues
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(hremp; "HR Employees")
        {
            DataItemTableView = where(status = filter(Active));

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                EmployeeNo := '';
                msg := '';
                subject := '';
                counter := 0;
                LastDay := 0D;

                // For Retirements
                retirement2yr := 0D;
                retirement1yr := 0D;
                TrainingEndDate := 0D;

                //contract expiry
                if hremp."Notice Period" <> noticep then begin
                    EmployeeNo := HrEmp."No.";

                    Clear(RecepientUserIDs);
                    RecepientUserIDs.Add(1, EmployeeNo);
                    counter := 1;

                    HrNoficationEmSMS.reset();
                    HrNoficationEmSMS.setrange(Notification, HrNoficationEmSMS.Notification::Contract);
                    if HrNoficationEmSMS.find('-') then begin
                        repeat
                            counter += 1;
                            RecepientUserIDs.Add(Counter, HrNoficationEmSMS."user id");
                        until HrNoficationEmSMS.next = 0;
                    end;

                    if hremp."Contract End Date" <> 0D then begin
                        noticedate := 0D;
                        noticedate := CalcDate('-' + format(HrEmp."Notice Period"), HrEmp."Contract End Date");
                        if noticedate = Today then begin
                            for i := 1 to Counter do begin
                                userset.Reset();
                                if i = 1 then
                                    userset.SetRange("Employee No.", RecepientUserIDs.Get(i));
                                if i > 1 then
                                    userset.SetRange("User ID", RecepientUserIDs.Get(i));
                                if userset.Find('-') then begin
                                    usermail := userset."E-Mail";
                                    username := userset."Full Name";
                                    msg := 'Your contract is almost expiring';
                                    Subject := 'Contract Expiry';
                                    EmailMsg.Create(usermail, subject, msg, true);
                                    EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                    Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                    

                                end;
                            end;

                        end;
                    end;

                end;
                //contract expiry
                //disciplinary

                // DisciplinaryCases.reset();
                // if DisciplinaryCases.find('-') then begin
                //     if DisciplinaryCases."Action Duration End  Date"<>0D then begin
                //     LastDay := CalcDate('-2w', DisciplinaryCases."Action Duration End  Date");
                //     if LastDay = Today then message('Case Will be closed in two weeks');
                // end;
                // end;

                //Retirement email
                Employee1 := HrEmp."No.";

                // if not RecepientUserIDs1.ContainsKey(Counter1) then
                Clear(RecepientUserIDs1);
                RecepientUserIDs1.Add(1, Employee1);
                counter1 := 1;

                HrNoficationEmSMS.reset();
                HrNoficationEmSMS.setrange(Notification, HrNoficationEmSMS.Notification::Retirement);
                HrNoficationEmSMS.setrange("Send Email", true);
                if HrNoficationEmSMS.find('-') then begin
                    repeat
                        counter1 += 1;
                        RecepientUserIDs1.Add(Counter1, HrNoficationEmSMS."user id");

                    until HrNoficationEmSMS.next = 0;
                end;


                if hremp."Retirement date" <> 0D then begin
                    retirement2yr := CalcDate('-2Y', hremp."Retirement date");
                    retirement1yr := CalcDate('-1Y', hremp."Retirement date");
                    if (retirement1yr = Today) or (retirement2yr = Today) then begin
                        for r := 1 to Counter1 do begin
                            userset.Reset();
                            if r = 1 then
                                userset.SetRange("Employee No.", RecepientUserIDs1.Get(r));
                            if r > 1 then
                                userset.SetRange("User ID", RecepientUserIDs1.Get(r));
                            if userset.Find('-') then begin
                                usermail := userset."E-Mail";
                                username := userset."Full Name";
                                msg := 'You are almost Retiring';
                                Subject := 'Retirement';
                                EmailMsg.Create(usermail, subject, msg, true);
                                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                message('Retirement Notice Sent');

                            end;
                        end;
                    end;
                end;
                //end of retirement

                //Birthday and anniversary
                //if (hremp."Date Of Birth" <> 0D) or (hremp."Wedding Anniversary" <> 0D) then begin
                if (hremp."Date Of Birth" <> 0D) then begin
                    if ((Date2dmy(hremp."Date of Birth", 1)) = (Date2dmy(Today, 1)))
                                   and ((Date2dmy(hremp."Date of Birth", 2)) = (Date2dmy(Today, 2))) THEN begin
                        msg := 'We as Kenpipe Sacco wish you a happy Birthday';
                        Subject := 'Happy birthday';
                        userset.reset();
                        userset.setrange("Employee No.", hremp."No.");
                        if userset.find('-') then begin
                            usermail := userset."E-Mail";
                            username := userset."Full Name";


                            EmailMsg.Create(usermail, subject, msg, true);
                            EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);


                        end;
                    end;
                end;
                if (hremp."Wedding Anniversary" <> 0D) then BEGIN
                    IF ((Date2dmy(hremp."Wedding Anniversary", 1)) = (Date2dmy(Today, 1)))
                    and ((Date2dmy(hremp."Wedding Anniversary", 2)) = (Date2dmy(Today, 2))) THEN begin
                        msg := 'We as Kenpipe DT Sacco wish you a happy Anniversary';
                        Subject := 'Happy Anniversary';

                        userset.reset();
                        userset.setrange("Employee No.", hremp."No.");
                        if userset.find('-') then begin
                            usermail := userset."E-Mail";
                            username := userset."Full Name";


                            EmailMsg.Create(usermail, subject, msg, true);
                            EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);


                        end;
                    end;
                END;


                //end;
                //message('Email Sent');
                //end;


                // //Birthday $ Anniversary end
                // //Training Bonding

                Employee2 := HrEmp."No.";

                // if not RecepientUserIDs1.ContainsKey(Counter1) then
                Clear(RecepientUserIDs2);
                RecepientUserIDs2.Add(1, Employee2);
                counter2 := 1;

                HrNoficationEmSMS.reset();
                HrNoficationEmSMS.setrange(Notification, HrNoficationEmSMS.Notification::"Training Bonding");
                HrNoficationEmSMS.setrange("Send Email", true);
                if HrNoficationEmSMS.find('-') then begin
                    repeat
                        counter2 += 1;
                        RecepientUserIDs2.Add(Counter2, HrNoficationEmSMS."user id");

                    until HrNoficationEmSMS.next = 0;

                end;
                TrainingApplicationHeader.reset();
                TrainingApplicationHeader.setrange("Bonded Training?", true);
                TrainingApplicationHeader.SetRange(Sponsored, true);
                TrainingApplicationHeader.SetRange(TrainingApplicationHeader.Status, TrainingApplicationHeader.status::Approved);
                if TrainingApplicationHeader.find('-') then begin
                    TrainingApplicationLines.Reset();
                    TrainingApplicationLines.SetRange("Application No.", TrainingApplicationHeader."Application No");
                    TrainingApplicationLines.setrange("Employee No.", hremp."No.");
                    TrainingApplicationLines.Setrange(TrainingApplicationLines.Type, TrainingApplicationLines.Type::Employees);
                    if TrainingApplicationLines.find('-') then begin
                        repeat
                            for i := 1 to Counter2 do begin
                                userset.Reset();
                                if i = 1 then
                                    userset.SetRange("Employee No.", RecepientUserIDs2.Get(i));
                                if i > 1 then
                                    userset.SetRange("User ID", RecepientUserIDs2.Get(i));
                                if userset.Find('-') then begin
                                    usermail := userset."E-Mail";
                                    username := userset."Full Name";
                                    TrainingNeeds.get(TrainingApplicationHeader."Course Title");
                                    msg := 'You are bonded to this Training from' + ' ' + format(TrainingNeeds."Bondage Start Date") + 'To' + ' ' + format(TrainingNeeds."Bondage Release Date") + ' ' + 'As per the agreement incase of resignation before the bond period expiry, you will be required to refund the Training Cost';
                                    Subject := 'Bonded Training';
                                    EmailMsg.Create(usermail, subject, msg, true);
                                    EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                    Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                    message('Email Sent ');

                                end;
                            end;

                        until TrainingApplicationLines.Next = 0;
                    end;
                end;
                //Training Bonding end;
                //Training Application expiry start
                TrainingApplicationHeader.reset();
                TrainingApplicationHeader.SetRange(TrainingApplicationHeader.Status, TrainingApplicationHeader.status::Approved);
                if TrainingApplicationHeader.FindSet() then begin
                    repeat
                        TrainingEndDate := TrainingApplicationHeader."End Date";
                        if TrainingEndDate = Today then begin
                            TrainingApplicationLines.Reset();
                            TrainingApplicationLines.SetRange("Application No.", TrainingApplicationHeader."Application No");
                            TrainingApplicationLines.setrange("Employee No.", hremp."No.");
                            TrainingApplicationLines.Setrange(TrainingApplicationLines.Type, TrainingApplicationLines.Type::Employees);
                            if TrainingApplicationLines.find('-') then begin

                                userset.reset();
                                userset.SetRange("Employee No.", TrainingApplicationLines."Employee No.");
                                if userset.find('-') then begin
                                    usermail := userset."E-Mail";
                                    username := userset."Full Name";
                                    msg := 'Kindly Update the Training Evaluation Card for ' + TrainingApplicationHeader."Course Title" + 'attended on' + ' ' + Format(TrainingApplicationHeader."Start Date") + ' ' + 'To' + '' + Format(TrainingApplicationHeader."End Date");
                                end;
                                EmailMsg.Create(usermail, 'Update Training Evaluation', msg, true);
                                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                            end;

                        end;
                    until TrainingApplicationHeader.next = 0;
                    //Training Application End
                end;
            end;
        }
    }



    var
        noticedate: date;
        email: codeunit Email;
        userset: Record "User Setup";
        LastDay: date;
        TrainingApplicationHeader: record "HR Training App Header";
        TrainingApplicationLines: record "HR Training App Lines";
        Filename: Text;
        usermail: Text;
        username: text;
        TrainingNeeds: record "HR Training Needs";
        retirement1yr: date;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <h>';
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentInstream: InStream;
        Application: Record "HR Job Applications";

        AttachmentOutstream: OutStream;
        Temps: Codeunit "Temp Blob";
        msg: text;
        subject: text;
        noticep: DateFormula;
        ftr: Record 472;
        RecepientUserIDs: Dictionary of [Integer, Text];
        EmployeeNo: code[40];
        HrNoficationEmSMS: record "Notification EmSms setup";
        Counter: Integer;
        i: Integer;
        r: integer;
        DisciplinaryCases: record "HR Disciplinary Cases NCA";
        retirement2yr: date;
        Counter1: integer;
        Employee1: code[50];
        RecepientUserIDs1: Dictionary of [Integer, Text];
        employeelist: List of [Dictionary of [Integer, text]];
        Counter2: integer;
        Employee2: code[50];
        RecepientUserIDs2: Dictionary of [Integer, Text];
        TrainingEndDate: date;

}
