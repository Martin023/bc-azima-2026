#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185506 "Global Functions"
{
    trigger OnRun()
    begin
    end;

    procedure CreateFile(MemberNo: Code[100]; FileType: Enum "File Types")
    var
        FilesRec: Record "Files Table";
    begin
        FilesRec.Init();
        FilesRec.Validate("File Type", FileType);
        FilesRec.Validate("File/Member No.", MemberNo);
        FilesRec.Insert(true);
    end;

    procedure FormatDate(Realdate: date) dateText: Text;
    var
        Month: Integer;
        FormatedMonth: Text;
        Day: Integer;
        year: Integer;

    begin
        IF RealDate <> 0D THEN BEGIN
            Day := DATE2DMY(RealDate, 1);
            Month := DATE2DMY(RealDate, 2);
            Year := DATE2DMY(RealDate, 3);
        END;

        IF Month = 1 THEN FormatedMonth := 'Jan';
        IF Month = 2 THEN FormatedMonth := 'Feb';
        IF Month = 3 THEN FormatedMonth := 'Mar';
        IF Month = 4 THEN FormatedMonth := 'Apr';
        IF Month = 5 THEN FormatedMonth := 'May';
        IF Month = 6 THEN FormatedMonth := 'June';
        IF Month = 7 THEN FormatedMonth := 'July';
        IF Month = 8 THEN FormatedMonth := 'Aug';
        IF Month = 9 THEN FormatedMonth := 'Sept';
        IF Month = 10 THEN FormatedMonth := 'Oct';
        IF Month = 11 THEN FormatedMonth := 'Nov';
        IF Month = 12 THEN FormatedMonth := 'Dec';

        DateText := FORMAT(Day) + ' ' + FormatedMonth + ' ' + FORMAT(Year);

        IF RealDate = 0D THEN DateText := '';
    end;


    procedure FormatDateFullMonth(Realdate: date) dateText: Text;
    var
        Month: Integer;
        FormatedMonth: Text;
        Day: Integer;
        year: Integer;

    begin
        IF RealDate <> 0D THEN BEGIN
            Day := DATE2DMY(RealDate, 1);
            Month := DATE2DMY(RealDate, 2);
            Year := DATE2DMY(RealDate, 3);
        END;

        IF Month = 1 THEN FormatedMonth := 'January';
        IF Month = 2 THEN FormatedMonth := 'February';
        IF Month = 3 THEN FormatedMonth := 'March';
        IF Month = 4 THEN FormatedMonth := 'April';
        IF Month = 5 THEN FormatedMonth := 'May';
        IF Month = 6 THEN FormatedMonth := 'June';
        IF Month = 7 THEN FormatedMonth := 'July';
        IF Month = 8 THEN FormatedMonth := 'August';
        IF Month = 9 THEN FormatedMonth := 'September';
        IF Month = 10 THEN FormatedMonth := 'October';
        IF Month = 11 THEN FormatedMonth := 'November';
        IF Month = 12 THEN FormatedMonth := 'December';

        DateText := FORMAT(Day) + ' ' + 'of' + ' ' + FormatedMonth + ' ' + FORMAT(Year);

        IF RealDate = 0D THEN DateText := '';
    end;

    procedure DMUDateFormatDate(Realdate: date) dateText: Text;
    var
        Month: Integer;
        FormatedMonth: Text;
        Day: Integer;
        year: Integer;

    begin
        IF RealDate <> 0D THEN BEGIN
            Day := DATE2DMY(RealDate, 1);
            Month := DATE2DMY(RealDate, 2);
            Year := DATE2DMY(RealDate, 3);
        END;

        DateText := FORMAT(Day) + '/' + Format(Month) + '/' + FORMAT(Year);

        IF RealDate = 0D THEN DateText := '';
    end;

    procedure DMUDateFormatDateTime(RealdateTime: DateTime) dateText: Text;
    var
        Month: Integer;
        FormatedMonth: Text;
        Day: Integer;
        year: Integer;

    begin
        if RealdateTime <> 0DT then begin
            Day := DATE2DMY(DT2Date(RealdateTime), 1);
            Month := DATE2DMY(DT2Date(RealdateTime), 2);
            Year := DATE2DMY(DT2Date(RealdateTime), 3);

            DateText := FORMAT(Day) + '/' + Format(Month) + '/' + FORMAT(Year);
        end;

        IF RealdateTime = 0DT THEN DateText := '';
    end;

    procedure DateFormatCRB(RealDate: Date) dateText: Text;
    var
        Month: Text;
        Day: Text;
        year: Text;
    begin
        Day := Format(DATE2DMY(Realdate, 1));
        Month := Format(DATE2DMY(Realdate, 2));
        year := Format(DATE2DMY(Realdate, 3));

        if StrLen(Day) = 1 then Day := '0' + Day;
        if StrLen(Month) = 1 then Month := '0' + Month;
        dateText := year + Month + Day;
    end;

    procedure FormatCRBAmounts(Amount: Decimal): Decimal
    begin
        Amount := Round(Amount, 0.01, '>');
        Amount *= 100;
        exit(Amount);
    end;

    procedure AreUsersPresent(Department: Enum "Responsibility Center Enum"; SubDepartment: Enum "Sub Module"): Boolean
    var
        UserTasks: Record "User Tasks";
        EntryNo: Integer;
        AvailableUsers: Record "Present Users";
        BreakTheLoop: Boolean;
        UserIDValue: code[50];
        // UserTasksIDs: List of [Integer];
        SmallestUserID: Integer;
        HrLeaves: Record "HR Leave Application";
    begin
        AvailableUsers.Reset();
        AvailableUsers.SetRange(Department, Department);
        AvailableUsers.SetRange("Sub Module", SubDepartment);
        AvailableUsers.SetRange("User Active", true);
        if AvailableUsers.FindFirst() then begin
            repeat
                HrLeaves.Reset();
                HrLeaves.SetRange("Applicant User ID", AvailableUsers."User ID");
                HrLeaves.SetFilter("Start Date", '<=%1', Today);
                HrLeaves.SetFilter("Return Date", '>%1', Today);
                if not HrLeaves.FindFirst() then begin
                    exit(true);
                end;
            until AvailableUsers.Next() = 0;
        end else
            exit(false);
    end;

    procedure IsCurrentUserPresent(Department: enum "Responsibility Center Enum"; SubDepartment: Enum "Sub Module"; CurrentUserID: Code[100]): Boolean
    var
        UserTasks: Record "User Tasks";
        EntryNo: Integer;
        AvailableUsers: Record "Present Users";
        BreakTheLoop: Boolean;
        UserIDValue: code[50];
        // UserTasksIDs: List of [Integer];
        SmallestUserID: Integer;
        HrLeaves: Record "HR Leave Application";
    begin
        AvailableUsers.Reset();
        AvailableUsers.SetRange(Department, Department);
        AvailableUsers.SetRange("Sub Module", SubDepartment);
        AvailableUsers.SetRange("User Active", true);
        AvailableUsers.SetRange("User ID", CurrentUserID);
        if AvailableUsers.FindFirst() then begin
            exit(true);
        end else
            exit(false);
    end;


    procedure AssignUserTasks(Department: Enum "Responsibility Center Enum"; SubDepartment: Enum "Sub Module"; RecordID: Code[30]) TaskAssigned: Boolean
    var
        UserTasks: Record "User Tasks";
        EntryNo: Integer;
        AvailableUsers: Record "Present Users";
        BreakTheLoop: Boolean;
        UserIDValue: code[50];
        UserTasksIDs: List of [Integer];
        SmallestUserID: Integer;
        HrLeaves: Record "HR Leave Application";
    begin
        AvailableUsers.Reset();
        AvailableUsers.SetRange(Department, Department);
        AvailableUsers.SetRange("Sub Module", SubDepartment);
        AvailableUsers.SetRange("User Active", true);
        if AvailableUsers.FindFirst() then begin
            repeat
                HrLeaves.Reset();
                HrLeaves.SetRange("Applicant User ID", AvailableUsers."User ID");
                HrLeaves.SetFilter("Start Date", '<=%1', Today);
                HrLeaves.SetFilter("Return Date", '>%1', Today);
                if not HrLeaves.FindFirst() then begin
                    UserIDValue := '';
                    UserTasks.Reset();
                    UserTasks.SetRange("Sub Module", SubDepartment);
                    UserTasks.SetRange("User ID", AvailableUsers."User ID");
                    UserTasks.Ascending(false);
                    if not UserTasks.FindFirst() then begin
                        UserIDValue := AvailableUsers."User ID";
                        InsertUserTasks(Department, SubDepartment, RecordID, UserIDValue);
                        exit(true);
                    end else begin
                        UserTasksIDs.Add(UserTasks."No.");
                    end;
                end;
            until AvailableUsers.Next() = 0;
            SmallestUserID := FindSmallestNumber(UserTasksIDs);
        end;


        UserTasks.Reset();
        UserTasks.SetRange("No.", SmallestUserID);
        if UserTasks.FindFirst() then begin
            InsertUserTasks(Department, SubDepartment, RecordID, UserTasks."User ID");
            TaskAssigned := true;
            exit(TaskAssigned);
        end else
            exit(false);
    end;

    procedure AssignDigitCustodianTask(RecordID: Code[100]; MemberNo: Code[50]; SubModule: Enum "Sub Module")
    var
        LastDigit: Integer;
        CustodianSetup: Record "Digit Custodian Setup";
        UserTasks: Record "User Tasks";
    begin
        UserTasks.Reset();
        UserTasks.SetRange("Record ID", RecordID);
        if UserTasks.Find('-') then UserTasks.DeleteAll();

        Evaluate(LastDigit, CopyStr(MemberNo, StrLen(MemberNo), 1));

        CustodianSetup.Reset();
        CustodianSetup.SetRange("Digit Custodian", LastDigit);
        CustodianSetup.SetRange(Active, true);
        CustodianSetup.SetRange("Sub Module", SubModule);
        if CustodianSetup.FindFirst() then begin
            UserTasks.Init();
            UserTasks."User ID" := CustodianSetup."Responsible Officer Code";
            UserTasks.Department := CustodianSetup.Department;
            // UserTasks."Sub Module" := CustodianSetup."Sub Module";
            UserTasks."Sub Module" := SubModule;
            UserTasks."Entry Time" := CurrentDateTime;
            UserTasks."Record ID" := RecordID;
            UserTasks."Supervisor ID" := CustodianSetup."Supervisor Officer Code";
            UserTasks.Digit := CustodianSetup."Digit Custodian";
            UserTasks.Insert();
        end else
            Error('There is no digit custodian or the digit custodian is not active for digit %1 and sub module - %2', LastDigit, SubModule);
    end;



    procedure ValidateTopup(ApppevedAm: Decimal; loanNu: code[30]; ToppedLn: Code[30])
    var
        Loans: Record Loans;
        RepaymentMade: Decimal;
        Loantopp: Record "Loans Top up";
        Customer: Record Customer;
        RepaymentSchedule: Record "Ideal Repayment Schedule";
        Loantypes: Record "Product Factory";
        EndDate: Date;
        LoanRec: Record Loans;
        LoansProcess: Codeunit "Loans Process";
        NetAmt: Decimal;
    begin
        RepaymentMade := 0;
        Loantopp.Reset();
        Loantopp.SetRange("Loan Top Up", loanNu);
        if Loantopp.FindFirst() then begin
            if Loans.Get(loanNu) then begin
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Outstanding Bills", Loans."Loans Category-SASRA");
                if Customer.Get(Loans."Employer Code") then
                    Loantopp."Loan Type" := Loans."Loan Product Type";
                if (Loans."Recovery Mode" = Loans."Recovery Mode"::Checkoff) and (Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Perfoming)
                  and (Loans."Employer Code" <> '')
                  and (Customer."Loans Cleared" <> Customer."Loans Cleared"::"Full Clearance") then begin
                    Loantopp."Loan No." := ToppedLn;
                    Loantopp."Loan Top Up" := loanNu;
                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                        Loantopp."Principle Top Up" := Loans."Outstanding Balance" - (Loans.Repayment - Round(((Loans."Approved Amount" * Loans.Interest / 12 / 100) + ((Round(Loans."Approved Amount" / Loans.Installments, 1.0, '>')) * Loans.Interest / 12 / 100)) / 2, 1.0, '>'));
                        Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest") - Round(((Loans."Approved Amount" * Loans.Interest / 12 / 100) + ((Round(Loans."Approved Amount" / Loans.Installments, 1.0, '>')) * Loans.Interest / 12 / 100)) / 2, 1.0, '>');
                        //  MESSAGE('%1 and %2',Loans."Outstanding Interest",ROUND(((Loans."Approved Amount"*Loans.Interest/12/100)+((ROUND(Loans."Approved Amount"/Loans.Installments,1.0,'>'))*Loans.Interest/12/100))/2,1.0,'>'));
                    end else begin
                        if (Loans."Outstanding Balance" + Loans."Outstanding Interest") > Loans.Repayment then begin
                            //Loantopp."Principle Top Up" := Loans."Outstanding Balance" - (Loans.Repayment - Round((Loans."Outstanding Balance" * Loans.Interest * 0.01 / 12), 1, '>'));
                            Loantopp."Principle Top Up" := Loans."Outstanding Balance";
                            Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest") - Round((Loans."Outstanding Balance" * Loans.Interest * 0.01 / 12), 1, '>');
                        end else begin
                            Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest") - Round((Loans."Outstanding Balance" * Loans.Interest * 0.01 / 12), 1, '>');
                            Loantopp."Principle Top Up" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                        end;

                    end;
                    Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest");
                    Loantopp."One Month Interest" := (Loans."Outstanding Balance" * Loans.Interest * 0.01 / 12);
                    Loantopp."Monthly Repayment" := Loans.Repayment - Round((Loans."Outstanding Balance" * Loans.Interest * 0.01 / 12), 1, '>');
                    Loantopp."Interest Rate" := Loans.Interest;
                    if Loantopp."Interest Top Up" <= 0 then
                        Loantopp."Interest Top Up" := 0;
                    // if Loantopp."Principle Top Up" <= 0 then
                    //     Loantopp."Principle Top Up" := 0;
                end else begin
                    Loantopp."Principle Top Up" := Loans."Outstanding Balance";
                    Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest");
                    Loantopp."Monthly Repayment" := Loans.Repayment;
                end;
                if CalcDate('CM', Loans."Disbursement Date") = CalcDate('CM', Today) then begin
                    Loantopp."Principle Top Up" := Loans."Outstanding Balance";
                    Loantopp."Interest Top Up" := (Loans."Outstanding Interest" + Loantopp."Daily Interest");
                    Loantopp."Monthly Repayment" := Loans.Repayment;
                end;
                Loantopp."Outstanding Bill" := Loans."Outstanding Bills";
                Loantopp."Outstanding Balance" := Loans."Outstanding Balance";

                Loans.CalcFields("Loan Span");
                Loantopp."Loan Span" := Loans."Loan Span";
                //Check re-application period
                Loantypes.Get(Loantopp."Loan Type");
                if Format(Loantypes."Min. Re-application Period") <> '' then
                    EndDate := CalcDate(Loantypes."Min. Re-application Period", Loans."Repayment Start Date");
                RepaymentSchedule.Reset;
                RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", Loantopp."Loan Top Up");
                RepaymentSchedule.SetRange(RepaymentSchedule."Repayment Date", 0D, EndDate);
                if RepaymentSchedule.Find('-') then begin
                    RepaymentSchedule.CalcSums(RepaymentSchedule."Principal Repayment");
                end;
                //Get the difference if past schedule
                RepaymentMade := Loans."Approved Amount" - Loans."Outstanding Balance";
                if RepaymentMade < RepaymentSchedule."Principal Repayment" then
                    Loantopp."Additional Top Up Commission" := true;
                if Loantopp."Interest Top Up" < 0 then Loantopp."Interest Top Up" := 0;
                Loantopp."Total Top Up" := Loantopp."Principle Top Up" + Loantopp."Interest Top Up";
                Loantopp."Monthly Repayment" := Loans.Repayment;
                Loantopp."Loan Account" := Loans."Loan Account";
            end;
            Loantopp.Modify(true);
        end;
    end;

    procedure ChildHopeGraduation(Members: Record Members)
    var
        Customer: Record Customer;
        Source: Enum "SMS Source";
        SendSMS: Codeunit SendSms;
        msg: Text;
        MemberName: Text;
        PhoneNumber: Text;
    begin
        //Graduate child hope
        if Members."Date of Birth" <> 0D then begin
            if (Today - Members."Date of Birth") / 365 >= 18 then begin
                if Customer.get(Members."Employer Code") then begin
                    if Members."Member Class" <> Customer."Graduation To Class" then begin
                        MemberName := Members."First Name";
                        if MemberName = '' then MemberName := Members."Middle Name";
                        if MemberName = '' then MemberName := Members."Other Names";
                        msg := 'Dear ' + MemberName + ', your member account have suucessfully been upgraded from ' + Members."Member Class" + ' to ' + Customer."Graduation To Class" + '.';

                        PhoneNumber := Members."Phone No.";
                        if PhoneNumber = '' then PhoneNumber := Members."Transactional Mobile Number";

                        Members."Member Class" := Customer."Graduation To Class";
                        Members."Member Class Graduation" := Members."Member Class Graduation"::"Child Hope Graduant";
                        Members."Graduation Date" := CurrentDateTime;
                        SendSMS.SendSms(Source::ACCOUNT_STATUS, PhoneNumber, msg, Members."No.", Members."No.", false, 250, false, 'BC', '', '');
                        Members.Modify();
                    end;
                end;
            end;
        end;
    end;

    procedure NomineeGraduation(Members: Record Members)
    var
        Customer: Record Customer;
        RiskAccount: Record "Savings Accounts";
        BBFAccount: Record "Savings Accounts";
        BosaDepAccount: Record "Savings Accounts";

        RiskBal: Decimal;
        BBFBal: Decimal;
        DepBal: Decimal;

        AccountTrack: Integer;

        Source: Enum "SMS Source";
        SendSMS: Codeunit SendSms;
        msg: Text;
        MemberName: Text;
        PhoneNumber: Text;
    begin
        AccountTrack := 0;
        RiskAccount.Reset();
        RiskAccount.SetRange("Member No.", Members."No.");
        RiskAccount.SetRange("Product Category", RiskAccount."Product Category"::Risk);
        if RiskAccount.FindFirst() then begin
            RiskAccount.CalcFields(Balance);
            RiskBal := RiskAccount.Balance;
            if RiskBal >= RiskAccount."Monthly Contribution" then
                AccountTrack += 1;
        end;

        BBFAccount.Reset();
        BBFAccount.SetRange("Member No.", Members."No.");
        BBFAccount.SetRange("Product Category", BBFAccount."Product Category"::"Benevolent (BBF)");
        if BBFAccount.FindFirst() then begin
            BBFAccount.CalcFields(Balance);
            BBFBal := BBFAccount.Balance;
            if BBFBal >= BBFAccount."Monthly Contribution" then
                AccountTrack += 1;
        end;

        BosaDepAccount.Reset();
        BosaDepAccount.SetRange("Member No.", Members."No.");
        BosaDepAccount.SetRange("Product Category", BosaDepAccount."Product Category"::"BOSA Deposits");
        if BosaDepAccount.FindFirst() then begin
            BosaDepAccount.CalcFields(Balance);
            DepBal := BosaDepAccount.Balance;
            if DepBal >= BosaDepAccount."Monthly Contribution" then
                AccountTrack += 1;
        end;

        if AccountTrack = 3 then begin
            if Customer.Get(Members."Employer Code") then begin
                if Members."Member Class" <> Customer."Graduation To Class" then begin
                    MemberName := Members."First Name";
                    if MemberName = '' then MemberName := Members."Middle Name";
                    if MemberName = '' then MemberName := Members."Other Names";
                    msg := 'Dear ' + MemberName + ', your member account have suucessfully been upgraded from ' + Members."Member Class" + ' to ' + Customer."Graduation To Class" + '.';
                    PhoneNumber := Members."Phone No.";
                    if PhoneNumber = '' then PhoneNumber := Members."Transactional Mobile Number";
                    Members."Member Class" := Customer."Graduation To Class";
                    Members."Member Class Graduation" := Members."Member Class Graduation"::"Nominee Graduant";
                    Members."Graduation Date" := CurrentDateTime;
                    SendSMS.SendSms(Source::ACCOUNT_STATUS, PhoneNumber, msg, Members."No.", Members."No.", false, 250, false, 'BC', '', '');
                    Members.Modify();
                end;
            end;
        end;

    end;

    procedure CheckMemberSubflagTransactionAbility(MemberNo: Code[30]): Boolean;
    var
        Membersrec: Record Members;
    begin

        Membersrec.Reset();
        Membersrec.SetRange("No.", MemberNo);
        Membersrec.SetLoadFields(Subflag);
        if Membersrec.Find('-') then begin
            case Membersrec.Subflag of
                Membersrec.Subflag::Rejoined, Membersrec.Subflag::"First time", Membersrec.Subflag::"Partial withdrawn", Membersrec.Subflag::Defaulter:
                    exit(true);
                else
                    exit(false);
            end;
        end;

        exit(false);
    end;

    procedure HideAccount(No: Code[50]): Boolean
    var
        Loans: Record Loans;
        Members: Record Members;
        Accounts: Record "Savings Accounts";
        UserSetUp: Record "User Setup";
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin
            if UserSetUp."Show Hidden" then exit(false);

            if Members.Get(No) then begin
                if Members."Account Profile" <> Members."Account Profile"::"Normal Member" then begin
                    // Msg := 'To view this account''s details, you need to change the account profile to ' + Format(Members."Account Profile"::"Normal Member");
                    exit(true);
                end;
            end;

            if Loans.Get(No) then begin
                if Members.Get(Loans."Member No.") then begin
                    if Members."Account Profile" <> Members."Account Profile"::"Normal Member" then begin
                        // Msg := 'To view this account''s details, you need to change the account profile to ' + Format(Members."Account Profile"::"Normal Member");
                        exit(true);
                    end;
                end;
            end;

            if Accounts.Get(No) then begin
                if Members.Get(Accounts."Member No.") then begin
                    if Members."Account Profile" <> Members."Account Profile"::"Normal Member" then begin
                        // Msg := 'To view this account''s details, you need to change the account profile to ' + Format(Members."Account Profile"::"Normal Member");
                        exit(true);
                    end;
                end;
            end;
        end else
            Error('You must be set up in the user set up');
    end;

    procedure UpdateInsiders()
    var
        Members: Record Members;
        Officials: Record "Delegate Officials";

        //progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Updating Members ...';
        diaProgress: Dialog;
        intProgress: Integer;
        UpdateBoardMembers: Boolean;
        UpdateStaff: Boolean;
        Customer: Record Customer;
    begin
        if Confirm('Do you want to update delegates and board members?') then begin
            UpdateBoardMembers := true;
        end;
        if Confirm('Do you want to update staff members?') then begin
            UpdateStaff := true;
        end;

        Members.Reset();
        if Members.Find('-') then begin
            intProgressTotal := Members.COUNT;

            intProgressI := 0;
            TimeProgress := TIME;
            NoOfRecsProgress := intProgressTotal DIV 100;
            NoOfProgressed := 0;

            diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            repeat
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                if UpdateBoardMembers then begin
                    Officials.Reset();
                    Officials.SetRange(Retired, false);
                    Officials.SetRange(Status, Officials.Status::Approved);
                    Officials.SetRange("Member Number", Members."No.");
                    if Officials.FindFirst() then begin
                        if Members."Account Category" <> Members."Account Category"::"Board Member" then
                            Members."Account Category" := Members."Account Category"::Delegate;
                    end else begin
                        Members."Account Category" := Members."Account Category"::Member;
                    end;
                end;

                if UpdateStaff then begin
                    if Members."Employer Code" = '00100' then begin
                        Members."Account Category" := Members."Account Category"::"Staff Member";
                    end;
                end;
                Members.Modify();
            until Members.Next() = 0;
            diaProgress.CLOSE;
        end;

    end;

    procedure InsertUserTasks(DepartMent: enum "Responsibility Center Enum"; SubDepartment: Enum "Sub Module"; RecordID: Code[30]; UserIDValue: code[50]) Inserted: Boolean
    var
        UserTasks: Record "User Tasks";
        EntryNo: Integer;
        AvailableUsers: Record "Present Users";
        BreakTheLoop: Boolean;
        // MyArray: List of [Integer];
        SuperVisorID: Code[50];
    begin
        AvailableUsers.Reset();
        AvailableUsers.SetRange("User ID", UserIDValue);
        AvailableUsers.SetRange("Sub Module", SubDepartment);
        if AvailableUsers.FindFirst() then
            SuperVisorID := AvailableUsers."Supervisor ID";

        UserTasks.Reset();
        UserTasks.SetRange("Record ID", RecordID);
        if not UserTasks.FindFirst() then begin
            UserTasks.Init();
            UserTasks."User ID" := UserIDValue;
            UserTasks.Department := Department;
            UserTasks."Sub Module" := SubDepartment;
            UserTasks."Entry Time" := CurrentDateTime;
            UserTasks."Record ID" := RecordID;
            UserTasks."Supervisor ID" := SuperVisorID;
            if UserTasks.Insert() then
                exit(true);
        end;
    end;

    procedure FindSmallestNumber(MyDynamicArray: List of [Integer]): Integer
    var
        SmallestValue: Integer;
        i: Integer;
    begin
        if MyDynamicArray.Count <> 0 then begin
            SmallestValue := MyDynamicArray.get(1);

            if MyDynamicArray.Count > 1 then begin
                for i := 2 to MyDynamicArray.Count do begin
                    if MyDynamicArray.Get(i) < SmallestValue then
                        SmallestValue := MyDynamicArray.Get(i);
                end;
            end;
        end;
        exit(SmallestValue);
    end;

    procedure GetRemainingInstallments(Loans: Record Loans; AsAt: date): Integer
    var
        Schedule: Record "Ideal Repayment Schedule";
        Installments: Integer;
    begin
        Schedule.Reset();
        Schedule.SetFilter("Repayment Date", '>%1', AsAt);
        Schedule.SetRange("Loan No.", Loans."Loan No.");
        Schedule.SetLoadFields("Repayment Date");
        if Schedule.Find('-') then begin
            Installments := Schedule.Count;
            exit(Installments);
        end else begin
            exit(1);
        end;
    end;

    procedure GetFutureInterest(Loans: Record Loans; AsAt: date): Decimal
    var
        Schedule: Record "Ideal Repayment Schedule";
    begin
        Schedule.Reset();
        Schedule.SetFilter("Repayment Date", '>%1', AsAt);
        Schedule.SetRange("Loan No.", Loans."Loan No.");
        if Schedule.Find('-') then begin
            Schedule.CalcSums("Monthly Interest");
            exit(Schedule."Monthly Interest");
        end else begin
            exit(0);
        end;
    end;

    procedure HoursBetweenPeriods(StartDate: Date; StartTime: Time; EndDate: Date; EndTime: Time; Var Duration: Duration; var WokedOnANonWorkingPeriod: Boolean)
    var
        LeaveCalender: Record "HR Leave Calendar";
        CalenderLines: Record "HR Leave Calendar Lines";
        Counter: Integer;
        LoopDate: Date;
        EndWorkingTime: Time;
        WorkingDayMinutes: Integer;
        DaysDecimal: Decimal;
        HoursDecimal: Decimal;
        Milliseconds: Decimal;
    begin
        if StartTime = 0T then StartTime := 080000T;
        if EndTime = 0T then EndTime := 170000T;
        LeaveCalender.Reset();
        LeaveCalender.SetRange("Current Leave Calendar", true);
        if LeaveCalender.FindFirst() then begin
            Milliseconds := 0;

            repeat
                Counter += 1;
                if Counter = 1 then
                    LoopDate := CalcDate('1D', StartDate);
                if Counter > 1 then
                    LoopDate := CalcDate('1D', LoopDate);

                //if the case started and ended on a non working times

                if Counter = 1 then begin
                    if StartDate = EndDate then begin
                        if (CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime)) and
                        (CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", EndDate, EndTime, EndWorkingTime)) then begin
                            Milliseconds += (EndTime - StartTime);
                        end;
                        if (not CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime)) and
                        (CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", EndDate, EndTime, EndWorkingTime)) then begin
                            Milliseconds += (EndTime - 080000T);
                        end;
                        if (CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime)) and
                        (not CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", EndDate, EndTime, EndWorkingTime)) then begin
                            Milliseconds += (EndWorkingTime - 080000T);
                        end;
                    end else begin
                        if CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime) then begin
                            Milliseconds += (EndWorkingTime - StartTime);
                        end;
                    End;
                end else begin
                    if LoopDate < EndDate then begin
                        if CheckIfItsAWorkingDay(LeaveCalender."Calendar Code", CalcDate('-1D', LoopDate), WorkingDayMinutes) then
                            Milliseconds += WorkingDayMinutes * 60000;
                    end;

                    //Check if we are on the last loop
                    if LoopDate = EndDate then begin
                        if CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", EndDate, EndTime, EndWorkingTime) then begin
                            Milliseconds += (EndTime - 080000T);
                        end;
                    end;
                end;

            until LoopDate >= EndDate;

            if Milliseconds = 0 then begin
                if (not CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime)) and
                        (not CheckIfItsAWorkingTime(LeaveCalender."Calendar Code", StartDate, StartTime, EndWorkingTime)) then begin
                    Milliseconds := (CreateDateTime(EndDate, EndTime) - CreateDateTime(StartDate, StartTime));
                    WokedOnANonWorkingPeriod := true;
                end;
            end;

            Duration := Milliseconds;

        end;
    end;

    procedure CheckIfItsAWorkingTime(CalenderCode: Code[50]; TheDate: date; TheTime: Time; var EndWorkingTime: Time): Boolean
    var
        CalenderLines: Record "HR Leave Calendar Lines";
    begin
        CalenderLines.Reset();
        CalenderLines.SetRange(Code, CalenderCode);
        CalenderLines.SetRange(Date, TheDate);
        if CalenderLines.FindFirst() then begin
            if CalenderLines."Non Working" then begin
                if (CalenderLines.Day = 'Saturday') then begin
                    if (TheTime >= 080000T) and (TheTime <= 130000T) then begin
                        EndWorkingTime := 130000T;
                        exit(true);
                    end;
                end
            end else begin
                if (TheTime >= 080000T) and (TheTime <= 170000T) then begin
                    EndWorkingTime := 170000T;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure CheckIfItsAWorkingDay(CalenderCode: Code[50]; TheDate: date; var Minutes: Integer): Boolean
    var
        CalenderLines: Record "HR Leave Calendar Lines";
    begin
        CalenderLines.Reset();
        CalenderLines.SetRange(Code, CalenderCode);
        CalenderLines.SetRange(Date, TheDate);
        if CalenderLines.FindFirst() then begin
            if CalenderLines."Non Working" then begin
                if (CalenderLines.Day = 'Saturday') then begin
                    Minutes := 300;
                    exit(true);
                end;
            end else begin
                Minutes := 540;
                exit(true);
            end;
        end;
    end;

    procedure GetSmallestSalary(AccouNum: Code[20]; IncomeTy: Enum "Salary Income Types"): Decimal
    var
        myInt: Integer;
        //salHeader: Record "Salary Header";
        SalBuffer: Record "Salary Lines";
        SalrBBffer: Record "Salary Lines";
        TotalClearedAmount: Decimal;
        SalaryThroughFosa: Boolean;
        // SavingsAccounts: Record "Savings Accounts";
        EndDate: array[3] of date;
        StartDate: array[3] of Date;
        SmallestSal: Decimal;
        Salary: array[3] of Decimal;
        SalDates: array[3] of Date;
        k: Integer;
        Salo1: Decimal;
        Salo2: Decimal;
        Salo3: Decimal;
        NoOfSalaryTimes: Integer;
    begin
        TotalClearedAmount := 0;
        Salo1 := 0;
        Salo2 := 0;
        Salo3 := 0;
        SalaryThroughFosa := FALSE;
        FOR k := 3 DOWNTO 1 DO BEGIN
            Salary[k] := 0;
            SalDates[k] := 0D;
        END;
        SmallestSal := 0;
        SalrBBffer.Reset();
        SalrBBffer.SetRange(SalrBBffer."Account No.", AccouNum);
        SalrBBffer.SetLoadFields("Salary Header No.");
        SalrBBffer.SetRange(Posted, true);
        if SalrBBffer.FindSet then begin
            // repeat
            //     //if SalrBBffer."Salary Header No." = '' then SalrBBffer."Salary Header No." := 'SAL000000';
            //     // salHeader.Reset();
            //     // salHeader.SetRange(salHeader.No, SalrBBffer."Salary Header No.");
            //     // salHeader.SetRange(salHeader."Income Type", IncomeTy);
            //     // salHeader.SetLoadFields(No);
            //     // if salHeader.FindFirst() then begin
            //     // SavingsAccounts.RESET;
            //     // SavingsAccounts.SETRANGE(SavingsAccounts."No.", AccouNum);
            //     // IF SavingsAccounts.FIND('-') THEN BEGIN
            //     EndDate[3] := CALCDATE('CM', TODAY);
            //     StartDate[3] := CALCDATE('-CM', EndDate[3]);

            //     SalBuffer.RESET;
            //     SalBuffer.SETRANGE(SalBuffer."Account No.", AccouNum);
            //     // SalBuffer.SetRange("Salary Header No.", salHeader.No);
            //     SalBuffer.SetRange(SalBuffer."Income Type", IncomeTy);
            //     SalBuffer.SETFILTER(SalBuffer."Posting Date", '%1..%2', StartDate[3], EndDate[3]);
            //     SalBuffer.SETRANGE(Posted, TRUE);

            //     SalBuffer.SetLoadFields("Salary Header No.");

            //     IF NOT SalBuffer.FIND('-') THEN BEGIN
            //         EndDate[3] := CALCDATE('-1M+CM', TODAY);
            //         StartDate[3] := CALCDATE('-CM', EndDate[3]);
            //     END;


            //     EndDate[2] := CALCDATE('-1M+CM', EndDate[3]);
            //     StartDate[2] := CALCDATE('-CM', EndDate[2]);

            //     EndDate[1] := CALCDATE('-1M+CM', EndDate[2]);
            //     StartDate[1] := CALCDATE('-CM', EndDate[1]);

            //     SalBuffer.RESET;
            //     SalBuffer.SETRANGE(SalBuffer."Account No.", AccouNum);
            //     // SalBuffer.SetRange("Salary Header No.", salHeader.No);
            //     SalBuffer.SetRange(SalBuffer."Income Type", IncomeTy);
            //     SalBuffer.SETFILTER(SalBuffer."Posting Date", '%1..%2', StartDate[3], EndDate[3]);
            //     SalBuffer.SETRANGE(Posted, TRUE);
            //     SalBuffer.SetLoadFields(Amount, "Posting Date");

            //     IF SalBuffer.FindFirst() THEN BEGIN
            //         SalaryThroughFosa := TRUE;
            //         SalBuffer.CALCSUMS(Amount);
            //         Salo1 := SalBuffer.Amount;
            //         SalDates[k] := SalBuffer."Posting Date";
            //     END;

            //     SalBuffer.RESET;
            //     SalBuffer.SETRANGE(SalBuffer."Account No.", AccouNum);
            //     //SalBuffer.SetRange("Salary Header No.", salHeader.No);
            //     SalBuffer.SetRange(SalBuffer."Income Type", IncomeTy);
            //     SalBuffer.SETFILTER(SalBuffer."Posting Date", '%1..%2', StartDate[2], EndDate[2]);
            //     SalBuffer.SETRANGE(Posted, TRUE);
            //     SalBuffer.SetLoadFields(Amount, "Posting Date");

            //     IF SalBuffer.FindFirst() THEN BEGIN
            //         SalaryThroughFosa := TRUE;
            //         SalBuffer.CALCSUMS(Amount);
            //         Salo2 := SalBuffer.Amount;
            //         SalDates[k] := SalBuffer."Posting Date";
            //     END;

            //     SalBuffer.RESET;
            //     SalBuffer.SETRANGE(SalBuffer."Account No.", AccouNum);
            //     //SalBuffer.SetRange("Salary Header No.", salHeader.No);
            //     SalBuffer.SetRange(SalBuffer."Income Type", IncomeTy);
            //     SalBuffer.SETFILTER(SalBuffer."Posting Date", '%1..%2', StartDate[1], EndDate[1]);
            //     SalBuffer.SETRANGE(Posted, TRUE);
            //     SalBuffer.SetLoadFields(Amount, "Posting Date");

            //     IF SalBuffer.FindFirst() THEN BEGIN
            //         SalaryThroughFosa := TRUE;
            //         SalBuffer.CALCSUMS(Amount);
            //         Salo3 := SalBuffer.Amount;
            //         SalDates[k] := SalBuffer."Posting Date";
            //     END;
            // // END;
            // //end;
            // until SalrBBffer.Next() = 0;
            SmallestSal := Salo1;
            IF SmallestSal > Salo2 THEN
                if Salo2 >= 0 then
                    SmallestSal := Salo2;

            IF SmallestSal > Salo3 THEN
                if Salo3 >= 0 then
                    SmallestSal := Salo3;
            exit(SmallestSal);
        end;
    end;

    procedure GetAzimaSMSLoanSalaryAverage(FOSAAccountNo: Code[20]; IncomeTy: Enum "Salary Income Types"): Decimal
    var
        SalBuffer: Record "Salary Lines";
        MonthStart: Date;
        MonthEnd: Date;
        MonthAmount: Decimal;
        TotalSalary: Decimal;
        MonthsWithSalary: Integer;
        MaxMonths: Integer;
        i: Integer;
        LastMonthAmount: Decimal;
        LastMonthIndex: Integer;
    begin
        TotalSalary := 0;
        MonthsWithSalary := 0;
        MaxMonths := 12;
        LastMonthAmount := 0;
        LastMonthIndex := 0;

        for i := 1 to MaxMonths do begin
            MonthStart := DMY2Date(1,
                Date2DMY(CalcDate('<-' + Format(i) + 'M>', Today()), 2),
                Date2DMY(CalcDate('<-' + Format(i) + 'M>', Today()), 3)
            );
            Message('Month %1: Start %2, End %3', i, MonthStart, MonthEnd);

            MonthEnd := CalcDate('<CM>', MonthStart);

            SalBuffer.Reset();
            SalBuffer.SetRange("Account No.", FOSAAccountNo);
            SalBuffer.SetRange("Income Type", IncomeTy);
            SalBuffer.SetRange(Posted, true);
            SalBuffer.SetRange("Posting Date", MonthStart, MonthEnd);
            SalBuffer.SetLoadFields(Amount, "Posting Date");
            SalBuffer.CalcSums(Amount);
            MonthAmount := SalBuffer.Amount;

            Message('Month Amount: %1', MonthAmount);

            if MonthAmount > 0 then begin
                MonthsWithSalary += 1;
                TotalSalary += MonthAmount;

                LastMonthAmount := MonthAmount;
                LastMonthIndex := i;
                Message('Month %1: Start %2, End %3, Amount %4 (Salary Found)', i, MonthStart, MonthEnd, MonthAmount);
            end;
        end;

        // salary in at least 1 month
        if MonthsWithSalary = 0 then
            exit(0);

        Message('Total Salary: %1, Months with Salary: %2, Last Month Amount: %3', TotalSalary, MonthsWithSalary, LastMonthAmount);


        if MonthsWithSalary = MaxMonths then begin
            TotalSalary -= LastMonthAmount;
            MonthsWithSalary -= 1;
            Message('After 12 months rule: Excluding last month amount %1, New Total Salary: %2, New Months with Salary: %3', LastMonthAmount, TotalSalary, MonthsWithSalary);
        end;

        exit(Round(TotalSalary / MonthsWithSalary, 1));
        Message('Average Salary: %1', Round(TotalSalary / MonthsWithSalary, 1));
    end;

    procedure ValidateBusinessLoansOnproductInput(Loans: Record Loans; MemberNo: code[30])
    var
        ProductFactory: Record "Product Factory";
        BusinessDepositsProduct: Record "Product Factory";
        Members: Record Members;
        DepositsBal: Decimal;
        MinimumDepositsBal: Decimal;
        SavingsAccounts: Record "Savings Accounts";
    begin
        ProductFactory.Get(Loans."Loan Product Type");
        Members.Get(MemberNo);

        MinimumDepositsBal := ProductFactory."Minimum Deposit Balance";

        BusinessDepositsProduct.Reset();
        BusinessDepositsProduct.SetRange("Product Category", BusinessDepositsProduct."Product Category"::"Business Deposits");
        if BusinessDepositsProduct.FindFirst() then begin
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetRange("Product Type", BusinessDepositsProduct."Product ID");
            if SavingsAccounts.FindFirst() then begin
                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                DepositsBal := SavingsAccounts."Balance (LCY)";
            end else
                Error('Deposits account not found');
        end else
            Error('Either the deposits account is not found or you don''t have a product by product category Business Deposits');

        if MinimumDepositsBal > DepositsBal then
            Message('Minimum deposits balance should be %1, your balance is %2. Kindly top up %3', MinimumDepositsBal, DepositsBal, MinimumDepositsBal - DepositsBal);
    end;


    procedure HoldMoneyInAccount(RecordNo: Code[50]; MemberNo: Code[30]; AccountNo: Code[30]; Interest: Decimal; Principle: Decimal; Amount: Decimal; HoldType: Enum "Funds Witheld Types")
    var
        HoldMoneyTable: Record "One Month Installment";
    begin
        HoldMoneyTable.Init();
        HoldMoneyTable."Record No." := RecordNo;
        HoldMoneyTable."Member No." := MemberNo;
        HoldMoneyTable."Account No." := AccountNo;
        HoldMoneyTable."Principal Amount" := Principle;
        HoldMoneyTable."Interest Amount" := Interest;
        HoldMoneyTable.Total := Amount;
        HoldMoneyTable."Funds Status" := HoldMoneyTable."Funds Status"::WithHeld;
        HoldMoneyTable."Entry Date" := CurrentDateTime;
        HoldMoneyTable."Created By" := UserId;
        HoldMoneyTable.Type := HoldMoneyTable.Type::"Reverse Guarantor Payment";
        HoldMoneyTable.Insert();
    end;

    procedure HoldSurety(RecordNo: Code[50]; MemberNo: Code[30]; AccountNo: Code[30]; Interest: Decimal; Principle: Decimal; Amount: Decimal; HoldType: Enum "Funds Witheld Types")
    var
        HoldMoneyTable: Record "One Month Installment";
    begin
        HoldMoneyTable.Init();
        HoldMoneyTable."Record No." := RecordNo;
        HoldMoneyTable."Member No." := MemberNo;
        HoldMoneyTable."Account No." := AccountNo;
        HoldMoneyTable."Principal Amount" := Principle;
        HoldMoneyTable."Interest Amount" := Interest;
        HoldMoneyTable.Total := Amount;
        HoldMoneyTable."Funds Status" := HoldMoneyTable."Funds Status"::WithHeld;
        HoldMoneyTable."Entry Date" := CurrentDateTime;
        HoldMoneyTable."Created By" := UserId;
        HoldMoneyTable.Type := HoldMoneyTable.Type::Surety;
        HoldMoneyTable.Insert();
    end;

    procedure GetRunningBalance(EntryNo: Integer; AccountNo: Code[30]): Decimal
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        RunningBalance: Decimal;
    begin
        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Customer No.", AccountNo);
        SavingsLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);

        SavingsLedgerEntry.SetLoadFields(Amount);

        if SavingsLedgerEntry.FindFirst then begin
            SavingsLedgerEntry.CalcSums(Amount);
            RunningBalance := SavingsLedgerEntry.Amount;
            RunningBalance *= -1;
        end;
        exit(RunningBalance);
    end;

    procedure GetLoanRunningBal(EntryNo: Integer; LoanNo: Code[30]) RunBal: Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        PrincipleBal: Decimal;
        InterestBal: Decimal;
    begin
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Loan, CreditLedgerEntry."transaction type"::Repayment);

        CreditLedgerEntry.SetLoadFields(Amount);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            PrincipleBal := CreditLedgerEntry.Amount;
        end;

        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::"Interest Due", CreditLedgerEntry."transaction type"::"Interest Paid");

        CreditLedgerEntry.SetLoadFields(Amount);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            InterestBal := CreditLedgerEntry.Amount;

            if InterestBal < 0 then InterestBal := 0;
        end;

        RunBal := PrincipleBal + InterestBal;
    end;

    procedure FormatUserName(UserID: Code[50]): Code[50]
    begin
        exit(COPYSTR(UserID, STRPOS(UserID, '\') + 1, STRLEN(UserID)));
    end;

    procedure AllocateDriverToVehicleRequest(DriverNo: Code[30]; DriverName: Code[50]; VehicleRequestNo: Code[30]; DriverAllocated: Boolean)

    var
        Drivers: Record "HR Drivers";
        MotorVehicleRequest: Record "Motor Vehicle Request";

    begin
        Drivers.Reset();

    end;

    procedure GetTransactionCharge(Amount: Decimal; TransactionType: Code[50]; TransactionDesc: Text[100]; Var ChargeAmount: Decimal; Var ChargeGLAccount: Code[50]; var ExciseDuty: Decimal; var ExciseDutyGLAccount: Code[50])
    var
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        GenSetup: Record "General Set-Up";
    begin
        GenSetup.Get();
        TransactionCharges.Reset;
        TransactionCharges.SetRange("Transaction Type", TransactionType);
        TransactionCharges.SetRange(Description, TransactionDesc);
        if TransactionCharges.FindFirst() then begin
            if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
            (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin
                ChargeAmount := 0;
                if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                    ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransactionCharges."Charge Amount";
                if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin
                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                    if TariffDetails.FindSet() then begin
                        repeat
                            if (Amount >= TariffDetails."Lower Limit") and (Amount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" = true then begin
                                    ChargeAmount := Amount * TariffDetails.Percentage * 0.01;
                                end else begin
                                    ChargeAmount := TariffDetails."Charge Amount";
                                end;
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;

            end;

            ChargeGLAccount := TransactionCharges."G/L Account";

            if TransactionCharges."Recover Excise Duty" then begin
                ExciseDuty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                ExciseDutyGLAccount := GenSetup."Excise Duty G/L";
            end;

        end;
    end;

    procedure FormatISODate(RealDate: date): Text
    begin
        if RealDate = 0D then begin
            Exit('');
        end;

        Exit(
            Format(DATE2DMY(RealDate, 3)) + '-' +
            Format(DATE2DMY(RealDate, 2)).PadLeft(2, '0') + '-' +
            Format(DATE2DMY(RealDate, 1)).PadLeft(2, '0')
        );
    end;

    procedure FormatCRBDate(RealDate: date): Text
    begin
        if RealDate = 0D then begin
            Exit('');
        end;

        Exit(
            Format(DATE2DMY(RealDate, 3)) +
            Format(DATE2DMY(RealDate, 2)).PadLeft(2, '0') +
            Format(DATE2DMY(RealDate, 1)).PadLeft(2, '0')
        );
    end;

    procedure FormatNCBACheckoffDate(RealDate: date): Text
    begin
        if RealDate = 0D then begin
            Exit('');
        end;

        Exit(
            Format(DATE2DMY(RealDate, 1)).PadLeft(2, '0') +
            Format(DATE2DMY(RealDate, 2)).PadLeft(2, '0') +
            Format(DATE2DMY(RealDate, 3))
        );
    end;

    procedure FormatISODateTime(RealDateTime: DateTime): Text
    var
        TZDuration: Duration;
    begin
        if RealDateTime = 0DT then begin
            Exit('');
        end;

        // TZDuration := 1000 * 60 * 60 * 3; // GMT + 3
        TZDuration := 0; // GMT
        RealDateTime := RealDateTime + TZDuration;

        Exit(
            FormatISODate(DT2Date(RealDateTime)) + ' ' +
            FORMAT(RealDateTime, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>')
        );
    end;

    procedure FormatISOTime(RealTime: Time): Text
    var
        TZDuration: Duration;
    begin
        if RealTime = 0T then begin
            Exit('00:00:00');
        end;

        // TZDuration := 1000 * 60 * 60 * 3; // GMT + 3
        TZDuration := 0; // GMT
        RealTime := RealTime + TZDuration;

        // Exit(
        //     FORMAT(RealTime, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>')
        // );
        Exit(
            StrSubstNo('%1:%2:%3',
                Format(RealTime, 0, '<Hours24>').PadLeft(2, '0'),
                Format(RealTime, 0, '<Minutes>').PadLeft(2, '0'),
                Format(RealTime, 0, '<Seconds>').PadLeft(2, '0')
            )
        );
    end;

    procedure FormatISOATMDateTime(RealDateTime: DateTime): Text
    var
        TZDuration: Duration;
    begin
        if RealDateTime = 0DT then begin
            Exit('');
        end;

        // TZDuration := 1000 * 60 * 60 * 3; // GMT + 3
        TZDuration := 0; // GMT
        RealDateTime := RealDateTime + TZDuration;

        Exit(
            FormatISODate(DT2Date(RealDateTime)) + 'T' +
            FORMAT(RealDateTime, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>')
        );
    end;

    procedure InsertAppraisalSummary("Loan No": code[30])
    var
        DCSParameterMatrix: Record "DCS Parameter Matrix";

        ParameterBold: Boolean;
        CompanyTelephone: Text;
        CompanyNam: Text;
        CommunicationOnline: Text;
        CompanyAddress: Text;
        ParamContribution: Option "Formula Factor","Flat Rate",Range,Ceiling,Multiplier,Divisor,Frequency,"Sum",Difference,"Graduated Range",Exponential,Terminate,Probability,Floor;
        ParamFormula: Text;
        SavingsAccounts: Record "Savings Accounts";
        MemberDeposits: Decimal;
        Loan: Record Loans;
        TotalLoanBal: Decimal;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        CountNo: Integer;
        GuarantorMax: Boolean;
        ProductFactory: Record "Product Factory";
        LoanRecoverd: Boolean;
        GeneralSetUp: Record "General Set-Up";
        Members: Record Members;
        MemberDueRetire: Boolean;
        SecurityTotal: Decimal;
        SecurityRisk: Boolean;
        LoanDepositRation: Boolean;
        ReapplicationPeriod: Boolean;
        Deposit_Multiplier: Decimal;
        RelatedProduct: Record "Related Product";
        RelatedBal: Decimal;
        NetOnDeposits: Decimal;
        AppraisalSal: Record "Appraisal Salary Details";
        TBasic: Decimal;
        TEarning: Decimal;
        TAllowance: Decimal;
        TDeductions: Decimal;
        LoanTopup: Record "Loans Top up";
        TopupRepayments: Decimal;
        AdjustedNet: Decimal;
        NetSalary: Decimal;
        ExternalEff: Record "Other Commitements Clearance";
        TotalExteralRec: Decimal;
        NetOnSalary: Decimal;
        QualifyingAmount: Decimal;
        AvInterest: Decimal;
        NewContr: Decimal;
        SavAcc: Record "Savings Accounts";
        NewRepayment: Decimal;
        CurrLoanBal: Decimal;
        Dimension1: Code[20];
        Dimension2: Code[20];
        Mult: Decimal;
        NetTakeHome: Decimal;
        LoanProcess: Codeunit "Loans Process";
        SalProc: Record "Salary Lines";
        SalProcessed: Boolean;
        OffsetBalance: Decimal;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        AccountSignatories: Record "Account Signatories";
        DirectorWarning: Boolean;
        MssgDefault: label 'This member has defaulted Loan-:';
        Twothird: Boolean;
        TopUp: Record "Loans Top up";
        PCharges: Record "Loan Product Charges";
        Amt: Decimal;
        TopUpComms: Decimal;
        Loans2: Record Loans;
        DiscAmt: Decimal;
        DifferenceSec: Decimal;
        TExternalEffects: Decimal;
        Inactive: Boolean;
        GuarLoanBal: Decimal;
        CountAll: Integer;
        LoanGua: Record "Loan Guarantors and Security";
        OtherComms: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
        ChargeExtraComms: Boolean;
        ExternalCharges: Decimal;
        RemPeriod: Decimal;
        CredLedEntry: Record "Credit Ledger Entry";
        SalNotThroughSacco: Boolean;
        EndDateSalo: Date;
        RepBasedOnRequested: Decimal;
        IntBasedOnRequested: Decimal;
        Cust: Record Customer;
        SelfGuaranteedBal: Decimal;
        TotalLoan: Decimal;
        Denominator: Decimal;
        AthirdDisplay: Text[50];
        AthirdAmt: Decimal;
        emptydateformula: DateFormula;
        ExerciseDuty: Decimal;
        DepPurchaseComm: Decimal;
        DepPurchaseCommExc: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        GenSetup: Record "General Set-Up";
        PossibleBoost: Decimal;
        ExternalCharges2: Decimal;
        GrossAmount: Decimal;
        LoansProductTyp: Text;
        MultP: Integer;
        TotalGuar: Decimal;
        AssetFinanceLoan: Record "Asset Finance Loan";
        AssetFinCharges: Decimal;
        AssetFinComms: Decimal;
        AssetFinCharges2: Decimal;
        AssetFinExerciseDuty: Decimal;
        AssetValue: Decimal;
        TotalAssetValue: Decimal;
        AssetFinComms2: Decimal;
        LoanProcessingAmt: Decimal;
        LoanProcessingAmtEx: Decimal;
        TotalProcessingAmt: Decimal;
        NetTakeAwayHome: Decimal;
        TotalExciseDuty: Decimal;
        NetAfterCharges: Decimal;
        SalaryQualifications: Decimal;
        Loans: Record Loans;
        LoanAppraisals: Record "Loan Appraisal";
    begin
        //Appsails
        DepPurchaseComm := 0;
        CountNo := 0;
        DifferenceSec := 0;
        TotalLoanBal := 0;
        SecurityTotal := 0;
        SecurityRisk := false;
        MemberDueRetire := false;
        GuarantorMax := false;
        LoanRecoverd := false;
        LoanDepositRation := false;
        Twothird := false;
        Deposit_Multiplier := 0;
        RelatedBal := 0;
        NetOnDeposits := 0;
        TopupRepayments := 0;
        AdjustedNet := 0;
        NetSalary := 0;
        TotalExteralRec := 0;
        NetOnSalary := 0;
        QualifyingAmount := 0;
        TDeductions := 0;
        TAllowance := 0;
        TBasic := 0;
        GrossAmount := 0;
        CountAll := 0;
        DiscAmt := 0;
        MultP := 0;
        AvInterest := 0;
        NewRepayment := 0;
        CurrLoanBal := 0;
        ChargeExtraComms := false;
        Dimension1 := '';
        Dimension2 := '';
        Mult := 0;
        NetTakeHome := 0;
        TExternalEffects := 0;
        Inactive := false;
        GuarLoanBal := 0;
        GuarantorMax := false;
        RepBasedOnRequested := 0;
        IntBasedOnRequested := 0;
        SelfGuaranteedBal := 0;
        AthirdDisplay := '';
        AthirdAmt := 0;
        ExerciseDuty := 0;
        DepPurchaseComm := 0;
        DepPurchaseCommExc := 0;
        PossibleBoost := 0;

        NetTakeAwayHome := 0;
        TotalExciseDuty := 0;
        NetAfterCharges := 0;
        Loans.Reset();
        loans.SetRange("Loan No.", "Loan No");
        if loans.FindFirst() then begin

            if Loans."Loans - Deposit Purchase" > 0 then begin
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Boosting");
                if PCharges.Find('-') then begin
                    repeat
                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            DepPurchaseComm := (Loans."Loans - Deposit Purchase" * (PCharges.Percentage / 100))
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                DepPurchaseComm := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                    PCharges.TestField(PCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (Loans."Loans - Deposit Purchase" >= TariffDetails."Lower Limit") and (Loans."Loans - Deposit Purchase" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    DepPurchaseComm := Loans."Loans - Deposit Purchase" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    DepPurchaseComm := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                        if DepPurchaseComm < PCharges.Minimum then
                            DepPurchaseComm := PCharges.Minimum;
                        if DepPurchaseComm > PCharges.Maximum then
                            DepPurchaseComm := PCharges.Maximum;
                        DepPurchaseComm := DepPurchaseComm * -1;
                        if ExcemptCharges = true then
                            DepPurchaseComm := 0;
                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                            DepPurchaseCommExc := DepPurchaseComm * GenSetup."Excise Duty (%)" * 0.01;
                        end;
                    until PCharges.Next = 0;
                end;
            end;
            SalProcessed := false;
            OffsetBalance := 0;
            if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                AvInterest := ((Loans.Repayment * Loans.Installments) - Loans."Approved Amount") / Loans.Installments
            //ELSE IF Loans."Interest Calculation Method"=Loans."Interest Calculation Method"::"Reducing Flat" THEN
            //  AvInterest:=ROUND(((Loans."Requested Amount"*Interest/12/100)+(LPrincipal*Interest/12/100))/2,1.0,'>')
            else
                AvInterest := Loans."Loan Interest Repayment";
            RepBasedOnRequested := ROUND((Loans.Interest / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) * Loans."Requested Amount", 1, '>');
            /*
            IF loans."Interest Calculation Method"=loans."Interest Calculation Method"::"Straight Line" THEN BEGIN
            LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
            LInterest:=ROUND((InterestRate/12/100)*LoanAmount,1,'>');
            Repayment:=LPrincipal+LInterest;
            loans."Loan Principle Repayment":=LPrincipal;
            loans."Loan Interest Repayment":=LInterest;
            END;
            */
            SalProc.Reset;
            SalProc.SetRange("Member No.", Loans."Member No.");
            if SalProc.Find('-') then
                SalProcessed := true;
            ProductFactory.Get(Loans."Loan Product Type");
            Mult := ProductFactory."Ordinary Deposits Multiplier";
            //Qualification on deposits
            MemberDeposits := 0;
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
            SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."product category"::"BOSA Deposits");
            if SavingsAccounts.Find('-') then begin
                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                MemberDeposits := SavingsAccounts."Balance (LCY)";//+Loans."Loans - Deposit Purchase";
            end;
            Loan.Reset;
            Loan.SetRange(Loan."Member No.", Loans."Member No.");
            Loan.SetRange(Loan.Posted, true);
            Loan.SetFilter("Outstanding Balance", '>0');
            Loan.SetRange("Self Guarantee", true);
            if Loan.Find('-') then begin
                repeat
                    Loans.CalcFields("Outstanding Balance");
                    SelfGuaranteedBal := SelfGuaranteedBal + Loans."Outstanding Balance";
                until Loan.Next = 0;
            end;
            //IF ProductFactory.GET(Loans."Loan Product Type") THEN
            //  Deposit_Multiplier:=(MemberDeposits+Loans."Loans - Deposit Purchase")*ProductFactory."Ordinary Deposits Multiplier";
            //  NetOnDeposits:=Deposit_Multiplier;
            //MESSAGE('Dep %1 Deposits Mult %2 ',Deposit_Multiplier,Loans."Loans - Deposit Purchase");
            //Less balances from related loans
            RelatedProduct.Reset;
            RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
            if RelatedProduct.Find('-') then begin
                repeat
                    Loan.CalcFields("Total Loan Balance");
                    Loan.Reset;
                    Loan.SetRange(Loan."Member No.", Loans."Member No.");
                    Loan.SetRange(Loan.Posted, true);
                    Loan.SetRange(Loan."Loan Product Type", RelatedProduct."Related Product Code");
                    Loan.SetFilter("Total Loan Balance", '>0');
                    //Loan.SETFILTER("Outstanding Balance",'>0');
                    if Loan.Find('-') then begin
                        repeat
                            if ProductFactory.Get(Loan."Loan Product Type") then
                                if ProductFactory."Ordinary Deposits Multiplier" >= 4 then
                                    MultP := 4;
                            Loan.CalcFields("Outstanding Balance", "Outstanding Interest");
                            RelatedBal := RelatedBal + Loan."Outstanding Balance" + Loan."Outstanding Interest";
                        until Loan.Next = 0;
                    end;
                    //Topped up loans related product
                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", loans."Loan No.");
                    LoansTopup.SetRange("Loan Type", RelatedProduct."Related Product Code");
                    if LoansTopup.Find('-') then begin
                        repeat
                            /* Loan.RESET;
                             Loan.SETRANGE("Loan No.",LoansTopup."Loan Top Up");
                             Loan.SETRANGE("Loan Product Type",RelatedProduct."Related Product Code");
                             Loan.SETFILTER("Outstanding Balance",'>0');
                             IF Loan.FIND('-') THEN BEGIN
                               REPEAT*/
                            CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                            TopupRepayments := TopupRepayments + Loan.Repayment;
                            OffsetBalance := OffsetBalance + LoansTopup."Outstanding Balance" + LoansTopup."Interest Top Up";
                        /* UNTIL Loan.NEXT=0;
                       END;*/
                        until LoansTopup.Next = 0;
                    end;
                until RelatedProduct.Next = 0;
                //** ERROR('RelatedBal %1',RelatedBal);
                //Added Outside The loOP
            end;
            if MultP >= 4 then begin
                if ProductFactory.Get(Loans."Loan Product Type") then
                    Deposit_Multiplier := (MemberDeposits + Loans."Loans - Deposit Purchase") * MultP;//ProductFactory."Ordinary Deposits Multiplier";
            end else begin
                if ProductFactory.Get(Loans."Loan Product Type") then
                    Deposit_Multiplier := (MemberDeposits + Loans."Loans - Deposit Purchase") * ProductFactory."Ordinary Deposits Multiplier";
            end;
            NetOnDeposits := Deposit_Multiplier;
            RelatedBal := RelatedBal - OffsetBalance;
            if RelatedBal < 0 then
                RelatedBal := 0;
            //MESSAGE('OffsetBalance %1 RelatedBal %2',OffsetBalance,RelatedBal);
            NetOnDeposits := NetOnDeposits - (RelatedBal + SelfGuaranteedBal);
            //NetOnDeposits:=RelatedBal;//-SelfGuaranteedBal;
            if Members.Get(Loans."Member No.") then begin
                Dimension1 := Members."Global Dimension 1 Code";
                Dimension2 := Members."Global Dimension 2 Code";
                if Members.Status <> Members.Status::Active then
                    Inactive := true;
            end;
            //contractual shares
            SavAcc.Reset;
            SavAcc.SetRange("Member No.", Loans."Member No.");
            SavAcc.SetRange("Product Category", SavAcc."product category"::"BOSA Deposits");
            if SavAcc.Find('-') then begin
                if ProductFactory."Minimum Dep. Contribution %" > 0 then begin
                    if ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01 > ProductFactory."Maximum Deposit Contribution" then
                        NewContr := ProductFactory."Maximum Deposit Contribution"
                    else
                        NewContr := ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01;
                end;
            end;
            //MESSAGE('Curr Contr %1 New Contr %2 Prod fact %3',SavAcc."Monthly Contribution",NewContr,ProductFactory."Minimum Dep. Contribution %");
            //Difference
            if NewContr < ProductFactory."Minimum Deposit Contribution" then
                NewContr := ProductFactory."Minimum Deposit Contribution";
            NewContr := NewContr - SavAcc."Monthly Contribution";
            //IF NewContr<0 THEN
            // NewContr:=0;
            //end of contribution
            //Qualification on salary
            AppraisalSal.Reset;
            AppraisalSal.SetRange("Loan No", loans."Loan No.");
            if AppraisalSal.Find('-') then begin
                repeat
                    if AppraisalSal.Type = AppraisalSal.Type::Basic then
                        TBasic := TBasic + AppraisalSal.Amount
                    else
                        if AppraisalSal.Type = AppraisalSal.Type::Earnings then
                            TEarning := AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                TAllowance := TAllowance + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::Deductions then
                                    TDeductions := TDeductions + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::"Gross Pay" then
                                        GrossAmount := GrossAmount + AppraisalSal.Amount;
                until AppraisalSal.Next = 0;
            end;
            AppraisalSal.Reset;
            AppraisalSal.SetRange("Loan No", loans."Loan No.");
            AppraisalSal.SetFilter(Code, '7.1EXTERNAL BANK STO');
            AppraisalSal.SetFilter(Amount, '>0');
            if AppraisalSal.Find('-') then begin
                if (Loans."Recovery Mode" <> Loans."recovery mode"::"Internal STO") and (Loans."Recovery Mode" <> Loans."recovery mode"::"External STO") then
                    Loans."Recovery Mode" := Loans."recovery mode"::"Internal STO";
            end; /*ELSE
				Loans."Recovery Mode":=Loans."Recovery Mode"::Checkoff;*/
                 //Cleared external effects affecting qualification
            ExternalEff.Reset;
            ExternalEff.SetRange("Loan No.", loans."Loan No.");
            ExternalEff.SetRange("Affects 2/3 Rule", true);
            if ExternalEff.Find('-') then begin
                ExternalEff.CalcSums("Monthly Deduction");
                TotalExteralRec := ExternalEff."Monthly Deduction";
            end;
            //Total cleared effects
            ExternalEff.Reset;
            ExternalEff.SetRange("Loan No.", loans."Loan No.");
            if ExternalEff.Find('-') then begin
                ExternalEff.CalcSums(ExternalEff.Amount);
                TExternalEffects := ExternalEff.Amount;
            end;

            NetSalary := (TBasic + TEarning + TAllowance - TDeductions);


            //Get customer/employer
            if Cust.Get(Members."Employer Code") then begin
                if Cust."Loan Qualification" <> Cust."loan qualification"::"Gross Pay" then begin
                    NetOnSalary := (NetSalary - TBasic * 1 / 3);
                    AthirdDisplay := '1/3 of Basic';
                    AthirdAmt := (/*NetSalary-*/TBasic) * 1 / 3
                end else
                    if Cust."Loan Qualification" = Cust."loan qualification"::"Gross Pay" then begin
                        NetOnSalary := (NetSalary - ((TBasic + TEarning + TAllowance) * 1 / 3));
                        AthirdDisplay := '1/3 of Gross';
                        AthirdAmt := (TBasic + TEarning + TAllowance) * 1 / 3;
                    end else
                        if Cust."Loan Qualification" = Cust."loan qualification"::"Standing Order" then begin
                            NetOnSalary := NetSalary;//NetOnDeposits;
                            AthirdDisplay := 'Standing Order';
                            AthirdAmt := NetSalary//NetOnDeposits;
                        end else
                            Error('Employer not found');
            end else begin
                NetOnSalary := (NetSalary - TBasic * 1 / 3);
                AthirdDisplay := '1/3 of Basic';
                AthirdAmt := (/*NetSalary-*/TBasic) * 1 / 3
            end;
            if (Loans."Recovery Mode" = Loans."recovery mode"::"Internal STO") or (Loans."Recovery Mode" = Loans."recovery mode"::"External STO") then //on request from andrew
                NetOnSalary := NetSalary;
            // TotalLoan:=NetOnSalary/(Loans.Interest/12/100) / (1 - POWER((1 + (Loans.Interest/12/100)),- Loans.Installments));
            TotalLoan := NetOnSalary * (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) / (Loans.Interest / 12 / 100);
            NetOnSalary := TotalLoan;

            //zzzz
            // Get the Qualification Based on the prorata
            SalaryQualifications := 0;
            SalaryQualifications := LoanProcess.ComputeProrataQualification(loans."Loan No.", (NetSalary - AthirdAmt));
            NetOnSalary := SalaryQualifications;
            //Take care of wafanisi
            if NetOnDeposits >= NetOnSalary then begin
                if Loans."Requested Amount" > NetOnSalary then begin
                    QualifyingAmount := NetOnSalary;
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');

                end else begin
                    QualifyingAmount := Loans."Requested Amount";
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');

                end;
            end else begin
                if Loans."Requested Amount" > NetOnDeposits then begin
                    QualifyingAmount := NetOnDeposits;
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');

                end else begin
                    QualifyingAmount := Loans."Requested Amount";
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');

                end;
            end;
            //If any has not finished expected reapplication period
            TopUp.Reset;
            TopUp.SetRange("Loan No.", loans."Loan No.");
            if TopUp.Find('-') then begin
                repeat
                    if TopUp."Additional Top Up Commission" = true then
                        ChargeExtraComms := true;
                until TopUp.Next = 0;
            end;
            //Toatl top ups
            TopUp.Reset;
            TopUp.SetRange("Loan No.", loans."Loan No.");
            if TopUp.Find('-') then begin
                TopUpComms := 0;
                repeat
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                    if PCharges.Find('-') then begin
                        repeat
                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                if ChargeExtraComms = true then
                                    Amt := (Loans."Approved Amount" * (PCharges.Percentage + PCharges."Additional Charge %") / 100)
                                else
                                    Amt := (Loans."Approved Amount" * (PCharges.Percentage / 100));
                            end else
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                    if ChargeExtraComms = true then
                                        Amt := ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage + PCharges."Additional Charge %") / 100)
                                    else
                                        Amt := ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage / 100))
                                end else
                                    Amt := PCharges."Charge Amount";
                            if Amt < PCharges.Minimum then
                                Amt := PCharges.Minimum;
                            if Amt > PCharges.Maximum then
                                Amt := PCharges.Maximum;
                            TopUpComms := TopUpComms + Amt;
                            if TopUpComms > 50000000 then
                                TopUpComms := 50000000;
                        until PCharges.Next = 0;
                    end;
                until TopUp.Next = 0;
            end;
            //exteral commitments
            ExternalCharges := 0;
            OtherComms := 0;
            //Clearing external debts
            OtherCommitments.Reset;
            OtherCommitments.SetRange(OtherCommitments."Loan No.", Loans."Loan No.");
            if OtherCommitments.Find('-') then begin
                repeat
                    OtherCommitments.CalcSums(OtherCommitments.Amount);
                    OtherComms := OtherCommitments.Amount;
                    ExternalCharges := 0;
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
                    if PCharges.Find('-') then begin
                        repeat
                            //MESSAGE('Here1 %1',ExternalCharges);
                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then begin
                                if ChargeExtraComms = true then
                                    ExternalCharges := ExternalCharges + (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                else
                                    ExternalCharges := ExternalCharges + (OtherCommitments.Amount * (PCharges.Percentage / 100))
                            end else begin
                                ExternalCharges := ExternalCharges + OtherCommitments.Amount;
                            end;
                            if ExternalCharges > PCharges.Maximum then
                                ExternalCharges := PCharges.Maximum;
                            if ExternalCharges < PCharges.Minimum then
                                ExternalCharges := PCharges.Minimum;
                        //MESSAGE('Running Charge  other comms%1',ExternalCharges);
                        until PCharges.Next = 0;
                        //  GeneralSetUp.GET;
                        //  IF ExternalCharges>GeneralSetUp."Max External Clearance Amount" THEN
                        //  ExternalCharges:=GeneralSetUp."Max External Clearance Amount";
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GeneralSetUp.Get();
                            ExerciseDuty := ExternalCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                        end;
                    end;
                until OtherCommitments.Next = 0;
                ExternalCharges2 := ExternalCharges;
                ExternalCharges := ExternalCharges + ExerciseDuty;
                //MESSAGE('Here %1',ExternalCharges);
            end;
            //Asset Fin commitments
            AssetFinCharges := 0;
            AssetFinComms := 0;
            AssetValue := 0;
            TotalAssetValue := 0;
            AssetFinanceLoan.Reset;
            AssetFinanceLoan.SetRange(AssetFinanceLoan."Loan No.", Loans."Loan No.");
            if AssetFinanceLoan.Find('-') then begin
                repeat
                    AssetFinanceLoan.CalcSums(AssetFinanceLoan.Amount);
                    TotalAssetValue := AssetFinanceLoan.Amount;
                    AssetFinCharges := 0;
                    AssetFinExerciseDuty := 0;
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Asset Finance");
                    if PCharges.Find('-') then begin
                        repeat
                            //MESSAGE('Here1 %1',TotalAssetValue);
                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then begin
                                if ChargeExtraComms = true then
                                    AssetFinComms := AssetFinComms + (AssetFinanceLoan.Amount / (1 + (PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                else
                                    AssetFinComms := AssetFinComms + (AssetFinanceLoan.Amount / (1 + PCharges.Percentage / 100))
                            end else begin
                                AssetFinComms := AssetFinComms + PCharges."Charge Amount";
                            end;
                            AssetFinCharges := AssetFinanceLoan.Amount - AssetFinComms;
                        until PCharges.Next = 0;
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GeneralSetUp.Get();
                            AssetFinExerciseDuty := AssetFinCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                        end;
                    end;
                until AssetFinanceLoan.Next = 0;
                AssetFinComms2 := 0;
                AssetFinCharges2 := AssetFinCharges;
                AssetFinComms2 := AssetFinComms;
                AssetFinCharges := AssetFinExerciseDuty;
            end;
            //
            //Loan Processing Fee Charge
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
            PCharges.SetRange(PCharges."Charge Description", 'Loan Processing  Charge');
            if PCharges.Find('-') then begin
                repeat
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then
                        LoanProcessingAmt := Loans."Approved Amount" * (PCharges.Percentage / 100)
                    else
                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                            LoanProcessingAmt := PCharges."Charge Amount"
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                PCharges.TestField(PCharges."Staggered Charge Code");
                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                LoanProcessingAmt := Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                LoanProcessingAmt := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                    if LoanProcessingAmt < PCharges.Minimum then
                        LoanProcessingAmt := PCharges.Minimum;
                    if LoanProcessingAmt > PCharges.Maximum then
                        LoanProcessingAmt := PCharges.Maximum;
                    //If excise duty involved
                    if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                        GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                        LoanProcessingAmtEx := LoanProcessingAmt * GenSetup."Excise Duty (%)" * 0.01;
                    end;
                until PCharges.Next = 0;
            end;
            //END;
            TotalProcessingAmt := LoanProcessingAmt + LoanProcessingAmtEx;
            //
            //Balancing entry if disbursed via Savings
            //IF LoanApps."All Posting through Savings Ac"=TRUE THEN BEGIN
            //AdjustedNet:=(NetSalary-TAllowance)+(TAllowance*0.3)+TopupRepayments+TotalExteralRec-NewContr;
            AdjustedNet := (NetSalary);//-TAllowance)+(TAllowance*0.3)+TopupRepayments+TotalExteralRec-NewContr;
                                       //MESSAGE('AdjustedNet %1',AdjustedNet);
            NewRepayment := (AdjustedNet - (1 / 3 * (TBasic)));
            // Twothird rule
            if NewRepayment < Loans.Repayment then
                Twothird := true;
            //Total Loans
            Loan.Reset;
            Loan.SetRange(Loan."Member No.", Loans."Member No.");
            Loan.SetRange(Loan.Posted, true);
            if Loan.Find('-') then begin
                repeat
                    Loan.CalcFields(Loan."Outstanding Balance");
                    TotalLoanBal := TotalLoanBal + Loan."Outstanding Balance";
                    if Loan."Recovered Loan" <> '' then
                        LoanRecoverd := true;
                until Loan.Next = 0;
            end;
            //ERROR('TotalLoanBal %1',TotalLoanBal);
            if NetOnDeposits < Loans."Requested Amount" then
                LoanDepositRation := true;
            GeneralSetUp.Get;
            if Members.Get(Loans."Member No.") then begin
                if Members."Date of Birth" = 0D then Members."Date of Birth" := 19900101D;
                // if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                //     if Members."Tax Exempted" = true then begin
                //         if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age - Disabled"), Members."Date of Birth") then
                //             MemberDueRetire := true;
                //     end else begin
                //         if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                //             MemberDueRetire := true;
                //     end;
                //     //MESSAGE('Retires %1 Expect Comp%2 Setup %3 DOB %4',MemberDueRetire,Loans."Expected Date of Completion",GeneralSetUp."Max. Member Age",Members."Date of Birth");
                // end;
            end;
            if ProductFactory.Get(Loans."Loan Product Type") then begin
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", Loans."Member No.");
                Loan.SetRange(Loan."Loan Product Type", Loans."Loan Product Type");
                Loan.SetRange(Loan.Posted, true);
                if Loan.Find('-') then begin
                    if Loan."Disbursement Date" = 0D then Loan."Disbursement Date" := Today;
                    if ProductFactory."Min. Re-application Period" <> emptydateformula then
                        if Today < CalcDate(Format(ProductFactory."Min. Re-application Period"), Loan."Disbursement Date") then
                            ReapplicationPeriod := true;
                end;
            end;
            TotalGuar := 0;
            LoanGua.Reset;
            LoanGua.SetRange("Loan No", Loans."Loan No.");
            //LoanGua.SETRANGE("Self Guarantee",FALSE);
            if LoanGua.Find('-') then
                LoanGua.CalcSums(LoanGua."Amount Guaranteed");
            SavAcc.Reset;
            SavAcc.SetRange(SavAcc."Member No.", Loans."Member No.");
            SavAcc.SetRange(SavAcc."Product Category", SavAcc."product category"::"BOSA Deposits");
            if SavAcc.Find('-') then
                SavAcc.CalcFields(SavAcc."Balance (LCY)");
            SecurityTotal := LoanGua."Amount Guaranteed" + Loans."Loans - Deposit Purchase";//+SavAcc."Balance (LCY)";//-Loans."Approved Amount"{(RelatedBal)};//-OffsetBalance);
            TotalGuar := ROUND(LoanGua."Amount Guaranteed" + Loans."Loans - Deposit Purchase", 100, '<');
            //MESSAGE('Guar %1 Dep %2 Related %3 OffsetBal %4 ',TotalGuar,SavAcc."Balance (LCY)",RelatedBal,OffsetBalance);
            //MESSAGE('SecurityTotal %1',SecurityTotal);
            if SecurityTotal < Loans."Approved Amount" then begin
                SecurityRisk := true;
                DifferenceSec := Loans."Approved Amount" - SecurityTotal;
            end;
            if Loans."Dummy Appraisal" = true then
                TotalGuar := Loans."Requested Amount";
            if QualifyingAmount > TotalGuar then
                QualifyingAmount := TotalGuar;
            Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
            if Loans."Recommended Amount" < 0 then
                Loans."Recommended Amount" := 0;
            if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                //changed on request from andrew
                if (Loans."Recovery Mode" = Loans."recovery mode"::"Internal STO") or (Loans."Recovery Mode" = Loans."recovery mode"::"External STO") then
                    TotalLoan := NetSalary
                else
                    TotalLoan := NetSalary - AthirdAmt;
                // MESSAGE('%1',TotalLoan);
                //NetOnSalary:=ROUND((TotalLoan*Loans.Installments)-(ROUND((Loans.Interest/12/100)*TotalLoan,1,'<')*Loans.Installments),100,'<');
                //   NetOnSalary := ROUND((TotalLoan * Loans.Installments) - ((Loans.Interest / 100) * (TotalLoan * Loans.Installments)), 100, '<');
                NetOnSalary := SalaryQualifications;
                //Take care of wafanisi
                if NetOnDeposits >= NetOnSalary then begin
                    if Loans."Requested Amount" > NetOnSalary then begin
                        QualifyingAmount := NetOnSalary;
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 100, '<');
                        ;
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 100, '<');
                        ;
                    end;
                end else begin
                    if Loans."Requested Amount" > NetOnDeposits then begin
                        QualifyingAmount := NetOnDeposits;
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 100, '<');
                        ;
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 100, '<');
                        ;
                    end;
                end;
                // MESSAGE('%1 , and %2  and %3 AthirdAmt  %4',NetSalary,NetOnSalary,QualifyingAmount,AthirdAmt);
                loans."Loan Principle Repayment" := ROUND(QualifyingAmount / Loans.Installments, 1, '<');
                Loans."Loan Interest Repayment" := ROUND((Loans.Interest / 12 / 100) * QualifyingAmount, 1, '<');
                Loans."Recommended Amount" := ROUND(QualifyingAmount, 1, '<');
            end;
            if Loans."Recommended Amount" > Loans."Requested Amount" then
                Loans."Recommended Amount" := Loans."Requested Amount";
            Loans."Approved Amount" := Loans."Recommended Amount";
            Loans."Amount To Disburse" := Loans."Recommended Amount";
            Loans.Validate(Loans."Approved Amount");
            NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
            //MESSAGE('%1',NetTakeHome);
            //Net take Hone
            NetTakeHome := NetTakeHome - ExerciseDuty;

            Loans."Net Amount" := NetTakeHome;


            ///Amounts to take home ie Net amount
            NetAfterCharges := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);

            TotalExciseDuty := LoanProcess.ComputeExciseDuty(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
            if (NetAfterCharges < 0) then begin
                TotalExciseDuty := 0;
                NetAfterCharges := 0
            end;
            NetTakeAwayHome := NetAfterCharges - TotalExciseDuty;

            Loans."Net Amount" := NetTakeAwayHome;

            //Net take Home
            Loans.Modify;
            //Discuting
            Loans2.Reset;
            Loans2.SetRange(Loans2."Discounted Loan No.", Loans."Loan No.");
            if Loans2.Find('-') then begin
                Loans2.CalcSums(Loans2."Approved Amount");
                DiscAmt := Loans2."Approved Amount";
            end;
            //Insert Warnings---Directors
            DirectorWarning := false;
            if Members.Get(Loans."Member No.") then begin
                AccountSignatories.Reset;
                AccountSignatories.SetRange("ID Number", Members."Primary Identification");
                if AccountSignatories.Find('-') then begin
                    repeat
                        Loan.Reset;
                        Loan.SetFilter("Outstanding Bills", '>0');
                        Loan.SetRange("Member No.", AccountSignatories."Account No");
                        if Loan.Find('-') then begin
                            repeat
                                Loan.CalcFields("Outstanding Bills");
                                if (Loan."Outstanding Bills" - Loan.Repayment) > 0 then
                                    DirectorWarning := true;
                            until Loan.Next = 0;
                        end;
                    until AccountSignatories.Next = 0;
                end;
            end;
            if ProductFactory."Requires Salary Processing" = true then begin
                EndDateSalo := CalcDate('-' + Format(ProductFactory."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                SalProc.Reset;
                SalProc.SetRange("Account No.", Loans."Disbursement Account No");
                SalProc.SetRange("Posting Date", EndDateSalo, Today);
                SalProc.SetRange(Posted, true);
                if SalProc.Find('-') then begin
                    if SalProc.Count < ProductFactory."No. of Salary Times" then
                        SalNotThroughSacco := true;
                end else
                    SalNotThroughSacco := true;
            end;
            //Get Possible boosting Amount
            //(NetOnSalary-NetOnDeposits)/Mult
            /*IF (NetOnSalary>NetOnDeposits) AND (NetOnDeposits<Loans."Requested Amount") THEN
              BEGIN
                //IF
                IF NetOnSalary >Loans."Requested Amount"
                  THEN PossibleBoost:=(NetOnSalary-Loans."Requested Amount")/Mult ELSE
                  PossibleBoost:=(NetOnSalary-Loans."Recommended Amount")/Mult;
                END;*/
            if (NetOnSalary > Loans."Recommended Amount") and (Loans."Recommended Amount" < Loans."Requested Amount") then begin
                if Loans."Recommended Amount" < Loans."Requested Amount"
                  then
                    PossibleBoost := (Loans."Requested Amount" - Loans."Recommended Amount") / Mult;
            end;

            if Mult > 0 then
                PossibleBoost := (Loans."Requested Amount" - Deposit_Multiplier) / Mult;
            if PossibleBoost < 0 then PossibleBoost := 0;
            // if MultP >= 4 then
            //    Mult := 4;
            //On request by andrew
            if (Loans."Recovery Mode" = Loans."recovery mode"::"Internal STO") or (Loans."Recovery Mode" = Loans."recovery mode"::"External STO") then
                AthirdAmt := 0;

            LoanAppraisals.Reset();
            LoanAppraisals.SetRange("Loan No.", Loans."Loan No.");
            if not LoanAppraisals.FindFirst() then begin
                LoanAppraisals.Init();
                LoanAppraisals."Loan No." := "Loan No";
                LoanAppraisals."1/3 of Basic" := AthirdAmt;
                LoanAppraisals."Take Home Amount" := NetTakeAwayHome;
                LoanAppraisals."Member Deposits" := MemberDeposits;
                LoanAppraisals."Existing Loans" := TotalLoanBal;
                LoanAppraisals.Installments := Loans.Installments;
                LoanAppraisals."Basic Income" := TBasic;
                LoanAppraisals.Earnings := TEarning;
                LoanAppraisals.Allowances := TAllowance;
                LoanAppraisals."Gross Pay" := GrossAmount;
                LoanAppraisals.Deductions := TDeductions;
                LoanAppraisals."Net Salary" := NetSalary;
                LoanAppraisals."Amt to Loan" := NetSalary - AthirdAmt;
                LoanAppraisals."External Effects" := TotalExteralRec;
                LoanAppraisals."Cleared Loans Installment" := TopupRepayments;
                LoanAppraisals."Adjusted Net" := AdjustedNet;
                LoanAppraisals."New Repayment" := Loans.Repayment;
                LoanAppraisals."Average Interest" := AvInterest;
                LoanAppraisals."Qualification on Salary" := NetOnSalary;
                LoanAppraisals."Qualification on Deposits" := NetOnDeposits;
                LoanAppraisals."Deposit *5" := Deposit_Multiplier;
                LoanAppraisals."Recommended Amount" := Loans."Recommended Amount";
                LoanAppraisals."Loan Outstanding" := RelatedBal;
                LoanAppraisals."Top Up Loan Amount" := OffsetBalance;
                LoanAppraisals."TopUp Commission" := TopUpComms;
                LoanAppraisals."Maximum Credit" := Deposit_Multiplier - RelatedBal;
                LoanAppraisals."External Effects" := TExternalEffects;
                LoanAppraisals."Existing Loans" := ExternalCharges2;
                LoanAppraisals.Insert(true);
            end else
                if LoanAppraisals.FindFirst() then begin
                    LoanAppraisals."Loan No." := "Loan No";
                    LoanAppraisals."1/3 of Basic" := AthirdAmt;
                    LoanAppraisals."Take Home Amount" := NetTakeAwayHome;
                    LoanAppraisals."Member Deposits" := MemberDeposits;
                    LoanAppraisals."Existing Loans" := TotalLoanBal;
                    LoanAppraisals.Installments := Loans.Installments;
                    LoanAppraisals."Basic Income" := TBasic;
                    LoanAppraisals.Earnings := TEarning;
                    LoanAppraisals.Allowances := TAllowance;
                    LoanAppraisals."Gross Pay" := GrossAmount;
                    LoanAppraisals.Deductions := TDeductions;
                    LoanAppraisals."Net Salary" := NetSalary;
                    LoanAppraisals."Amt to Loan" := NetSalary - AthirdAmt;
                    LoanAppraisals."External Effects" := TotalExteralRec;
                    LoanAppraisals."Cleared Loans Installment" := TopupRepayments;
                    LoanAppraisals."Adjusted Net" := AdjustedNet;
                    LoanAppraisals."New Repayment" := Loans.Repayment;
                    LoanAppraisals."Average Interest" := AvInterest;
                    LoanAppraisals."Qualification on Salary" := NetOnSalary;
                    LoanAppraisals."Qualification on Deposits" := NetOnDeposits;
                    LoanAppraisals."Deposit *5" := Deposit_Multiplier;
                    LoanAppraisals."Recommended Amount" := Loans."Recommended Amount";
                    LoanAppraisals."Loan Outstanding" := RelatedBal;
                    LoanAppraisals."Top Up Loan Amount" := OffsetBalance;
                    LoanAppraisals."TopUp Commission" := TopUpComms;
                    LoanAppraisals."Maximum Credit" := Deposit_Multiplier - RelatedBal;
                    LoanAppraisals."External Effects" := TExternalEffects;
                    LoanAppraisals."Existing Loans" := ExternalCharges2;
                    LoanAppraisals.Modify(true);
                end;
        end;

    end;

    procedure GetSavingsAccountAvailableBalance(Rec: Record "Savings Accounts"; RecCalcFields: Boolean): decimal
    var
        ProductFactory: Record "Product Factory";
        MinBalance: Decimal;
    begin
        Database.SelectLatestVersion();

        MinBalance := 0;
        if ProductFactory.Get(Rec."Product Type") then begin
            MinBalance := ProductFactory."Minimum Balance";
            if ProductFactory."Product Category" = ProductFactory."Product Category"::"Share Capital" then begin
                MinBalance := 0;
            end;
        end;

        if RecCalcFields then begin
            Rec.CalcFields(
                "Balance (LCY)",
                "Authorised Over Draft",
                "Uncleared Cheques",
                "ATM Transactions",
                "Lien Placed",
                "Coop Transactions",
                "One Month Installment"
            );
        end;

        exit(
            (Rec."Balance (LCY)" + Rec."Authorised Over Draft") -
            (Rec."Uncleared Cheques" + Rec."ATM Transactions" + MinBalance + Rec."Lien Placed" + Rec.yed + Rec."Coop Transactions" + Rec."One Month Installment")
        )
    end;

    procedure GetSavingsAccountAvailableGuarantorshipBalance(Rec: Record "Savings Accounts"; RecCalcFields: Boolean): decimal
    var
        ProductFactory: Record "Product Factory";
        MinBalance: Decimal;
        LGSec: Record "Loan Guarantors and Security";
        TotalGuaranteed: Decimal;
        Bal: Decimal;

        GenSetup: Record "General Set-Up";
    begin
        LGSec.Reset;
        LGSec.SetRange("Savings Account No./Member No.", Rec."No.");
        LGSec.SetFilter("Outstanding Balance", '>0');
        if LGSec.FindSet then begin
            repeat begin
                TotalGuaranteed += LGSec."Amount Guaranteed";
            end until LGSec.Next = 0;
        end;


        GenSetup.Get;
        if GenSetup."Maximum Amount to Guarantee" > 0 then begin
            Bal := GenSetup."Maximum Amount to Guarantee" - TotalGuaranteed;
        end else begin
            Bal := GetSavingsAccountAvailableBalance(Rec, RecCalcFields) - TotalGuaranteed;
        end;

        if Bal < 0 then begin
            Bal := 0;
        end;

        exit(Bal);
    end;

    procedure FlagAccounts(MemberNo: Code[30])
    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        Comments: Record Comments;
        ManualFlag: Text;
        Counter: Integer;
        LoanrecoveryHeader: Record "Loan Recovery Header";
        LoanrecoveryHeaderII: Record "Loan Recovery Header II";
        OneMonthInstallment: Record "One Month Installment";
        LoanNumbers: Code[200];
        NumberOfLoans: Integer;
        i: Integer;
        SkyEmail: Codeunit "Sky Send Email";
        UserrSetup: Record "User Setup";
    begin
        if Members.Get(MemberNo) then begin
            if Members.Status = Members.Status::Dormant then begin
                Message('This member is dormant');
            end;
            if Members.Status = Members.Status::Deceased then begin
                Message('This member is deceased');
            end;
            if Members.Status = Members.Status::Closed then begin
                Message('This member account is closed.');
            end;

            i := 0;
            LoanrecoveryHeader.Reset();
            LoanrecoveryHeader.SetRange("Member No.", Members."No.");
            LoanrecoveryHeader.SetRange(Action, LoanrecoveryHeader.Action::Recovered);
            LoanrecoveryHeader.SetRange("Header Reversed", false);
            if LoanrecoveryHeader.Find('-') then begin
                NumberOfLoans := LoanrecoveryHeader.Count;
                repeat
                    i += 1;
                    if i = NumberOfLoans then
                        LoanNumbers += LoanrecoveryHeader."Loan No." + '.  '
                    else
                        LoanNumbers += LoanrecoveryHeader."Loan No." + ', ';
                until LoanrecoveryHeader.Next() = 0;
            end;

            i := 0;
            NumberOfLoans := 0;
            LoanrecoveryHeaderII.Reset();
            LoanrecoveryHeaderII.SetRange("Member No.", Members."No.");
            LoanrecoveryHeaderII.SetRange(Action, LoanrecoveryHeaderII.Action::Recovered);
            LoanrecoveryHeaderII.SetRange("Header Reversed", false);
            if LoanrecoveryHeaderII.Find('-') then begin
                NumberOfLoans := LoanrecoveryHeaderII.Count;
                repeat
                    i += 1;
                    if i = NumberOfLoans then
                        LoanNumbers += LoanrecoveryHeaderII."Loan No." + '.'
                    else
                        LoanNumbers += LoanrecoveryHeaderII."Loan No." + ', ';
                until LoanrecoveryHeaderII.Next() = 0;
            end;

            Loans.Reset();
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetFilter("Outstanding Balance", '>0');
            loans.SetFilter("Loan Product Type", '<>BGL&<>FGL');
            Loans.SetFilter("Loans Category-SASRA", '=%1|=%2|=%3|%4', Loans."Loans Category-SASRA"::Watch, Loans."Loans Category-SASRA"::Substandard, Loans."Loans Category-SASRA"::Doubtful, Loans."Loans Category-SASRA"::Loss);
            if Loans.FindFirst() then
                Message('This member is a defaulter Lno. ' + Loans."Loan No.");

            if LoanNumbers <> '' then begin
                Message('This member has a loan that is not performing : Loan Number: %1', LoanNumbers);
            end;

            if Members.Subflag = Members.Subflag::Deceased then begin
                Message('This member deceased');
            end;

            if Members.Subflag = Members.Subflag::Closed then begin
                Message('This member''s account is closed');
            end;

            if Members.Subflag = Members.Subflag::"Partial withdrawn" then begin
                Message('This member has once partially withdrawn');
            end;

            if Members.Subflag = Members.Subflag::"Pending Withdrawal" then begin
                Message('This member has placed a withdrawal notice');
            end;
            if Members.Subflag = Members.Subflag::Withdrawal then begin
                Message('This is a withdrawn member.');
            end;
            if Members.Subflag = Members.Subflag::"Pending Risk Claim" then begin
                Message('This member is Pending Risk Claim.');
            end;
            if Members.Subflag = Members.Subflag::Defaulter then begin
                Message('This member is a Defaulter.');
            end;

            //The system should allow the setting of reminders on flags that send an email alert on pre-set reminder date          
            // Comments.reset;
            // Comments.SetRange("Header No.", Members."No.");
            // Comments.SetRange("Disable Flag", false);
            // Comments.SetRange(Types, Comments.Types::"Member Flagging");
            // Comments.SetFilter(Comment, '<>%1', '');
            // Comments.SetRange("Reminder Sent", false);
            // Comments.SetFilter("Reminder Date", '<>%1', 0D);
            // if Comments.FindSet() then begin
            //     repeat
            //         if UserrSetup.Get(Comments."Commented By") then begin
            //             SkyEmail.QueueOutgoingEmail(
            //                 Comments."E-mail",
            //                 'Account Flagging Reminder',
            //                 'Dear ' + UserrSetup."Full Name" + ',' + '<br><br>' +
            //                 'This is an automated reminder regarding a flagged member record that requires attention.' + '<br><br>' +
            //                 'Member No: ' + Members."No." + '<br>' +
            //                 'Member Name: ' + Members.Name + '<br>' +
            //                 'Flag Type: ' + format(Comments.Types) + '<br>' +
            //                 'Comment: ' + Comments.Comment + '<br>' +
            //                 'Flagged By: ' + Comments."Commented By" + '<br>' +
            //                 'Date Flagged: ' + Format(Comments.Date) + '<br>' +
            //                 'Reminder Date: ' + Format(Comments."Reminder Date") + '<br>' +
            //                 'Expiry Date: ' + Format(Comments."Expires At") + '<br><br>' +
            //                 'Please review and take the necessary action.' + '<br><br>' +
            //                 'Regards,' + '<br>' +
            //                 'Azima Sacco',
            //                 'HTML',
            //                 'NORMAL',
            //                 'BUSINESS CENTRAL'
            //             );
            //         end;
            //         Comments."Reminder Sent" := true;
            //         Comments.Modify();
            //     until Comments.Next() = 0;
            // end;

            //The system should allow setting of a time-based flag that expires after a set period.
            // Comments.Reset();
            // Comments.SetRange("Header No.", Members."No.");
            // Comments.SetRange("Disable Flag", false);
            // Comments.SetRange(Types, Comments.Types::"Member Flagging");
            // Comments.SetFilter(Comment, '<>%1', '');
            // Comments.SetFilter("Expires At", '<>%1', 0D);
            // Comments.SetFilter("Expires At", '<=%1', Today);
            // if Comments.FindSet() then begin
            //     repeat
            //         // Comments."Disable Flag" := true;
            //         Comments.Modify();
            //     until Comments.Next() = 0;
            // end;

            Counter := 0;
            Comments.Reset();
            Comments.SetRange("Header No.", Members."No.");
            Comments.SetRange("Disable Flag", false);
            Comments.SetRange(Types, Comments.Types::"Member Flagging");
            Comments.SetFilter(Comment, '<>%1', '');
            if Comments.Find('-') then begin
                repeat
                    Counter += 1;
                    ManualFlag += Format(Counter) + '. ' + Comments.Comment + '\';

                    if StrLen(ManualFlag) = 220 then exit;

                until Comments.Next() = 0;
            end;

            OneMonthInstallment.Reset();
            OneMonthInstallment.SetRange("Member No.", MemberNo);
            OneMonthInstallment.SetRange(Type, OneMonthInstallment.Type::Surety);
            OneMonthInstallment.SetRange("Funds Status", OneMonthInstallment."Funds Status"::WithHeld);
            OneMonthInstallment.SetFilter(Total, '>%1', 0);
            if OneMonthInstallment.Find('-') THEN begin
                OneMonthInstallment.CalcSums(Total);
                Message('This Member has Placed Ksh.' + Format(OneMonthInstallment.Total) + ' worth of Surety on their BOSA Deposits.');
            end;

            OneMonthInstallment.Reset();
            OneMonthInstallment.SetRange("Member No.", MemberNo);
            OneMonthInstallment.SetRange(Type, OneMonthInstallment.Type::Lien);
            OneMonthInstallment.SetRange("Funds Status", OneMonthInstallment."Funds Status"::WithHeld);
            OneMonthInstallment.SetFilter(Total, '>%1', 0);
            if OneMonthInstallment.Find('-') THEN begin
                OneMonthInstallment.CalcSums(Total);
                Message('This Member has Placed Ksh.' + Format(OneMonthInstallment.Total) + ' worth of Lien on their Deposits.');
            end;



            if ManualFlag <> '' then
                MESSAGE('WARNING!\This account has been flagged with the following\' + ManualFlag + 'To view more, head to the comments section.');
        end;
    end;

    procedure CommentsManagement(RecordID: Code[30])
    var
        Comments: Record Comments;
    begin
        Comments.Reset();
        Comments.SetRange("Viewd By Somebody Else", false);
        Comments.SetRange("Commented By", UserId);
        Comments.SetRange("Header No.", RecordID);
        if not Comments.Find('-') then
            Error('Please add a comment before performing this action');
    end;

    procedure PopUpCommentsIfCaseHas(RecordID: code[50])
    var
        Comments: Record Comments;
    begin
        Comments.Reset();
        Comments.SetRange("Header No.", RecordID);
        if Comments.Find('-') then
            Page.Run(52186311, Comments);
    end;

    procedure CancelApprovalManually(RecordID: RecordID) Result: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
        IsHandled: Boolean;
    begin
        // ApprovalEntry.Reset();
        // ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        // ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        // ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        // // Initial check before performing an expensive query due to the "Related to Change" flow field.
        // if ApprovalEntry.IsEmpty() then
        //     exit(false);
        // ApprovalEntry.SetRange("Related to Change", false);
        // if ApprovalEntry.FindSet() then
        //     ApprovalEntry.ModifyAll(ApprovalEntry.Status, ApprovalEntry.Status::Canceled);
    end;

    procedure GetMemberData(MemberNo: Code[30]; Var FirstName: Text[50]; Var PhoneNumber: Text[20])
    var
        Members: Record Members;
    begin
        if Members.Get(MemberNo) then begin
            FirstName := Members."First Name";
            if FirstName = '' then
                FirstName := Members."Middle Name";
            if FirstName = '' then
                FirstName := Members."Middle Name";
            if FirstName = '' then
                FirstName := 'Member';

            PhoneNumber := Members."Phone No.";
            if PhoneNumber = '' then
                PhoneNumber := Members."Transactional Mobile Number";
        end;
    end;

    PROCEDURE CheckEmailHasADot(var Email: Text[100]): Text
    var
        EmailAfterAt: Text;
        Characters: Text;
        MemApp: Record "Member Application";
    BEGIN
        EmailAfterAt := CopyStr(Email, StrPos(Email, '@') + 1, StrLen(Email));

        if StrPos(EmailAfterAt, '.') = 1 then Error('E-mail domain part cannot start with a dot');

        if StrPos(EmailAfterAt, '-') = 1 then Error('E-mail domain part cannot start with a -');

        if StrPos(EmailAfterAt, '-') = StrLen(EmailAfterAt) then Error('E-mail domain part cannot end with a -');

        if StrPos(EmailAfterAt, '.') = 0 then Error('E-mail must have a dot after the @');

        if CopyStr(EmailAfterAt, StrPos(EmailAfterAt, '.') + 1, 1) = '.' then Error('Two dots cannot follow each other');

        Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,/<>?-= ''';
        if not MemApp.ValidateShouldNotHaves(EmailAfterAt, Characters) then Error('Domain part must not have special characters');
    END;

    procedure ValidateEmailAddress(EmailAddress: Text): Boolean
    var
        regex: Codeunit Regex;
        regexPattern: Text;
    begin
        regexPattern := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

        exit(
            regex.IsMatch(EmailAddress, regexPattern, 0)
        );
    end;

    procedure ValidateKenyanPhoneNumber(PhoneNumber: Text): Boolean
    var
        regex: Codeunit Regex;
        regexPattern: Text;
    begin
        regexPattern := '^(254)\d{9}$';

        exit(
            regex.IsMatch(PhoneNumber, regexPattern, 0)
        );
    end;

    procedure ValidateKRAPIN(KRAPin: Text): Boolean
    var
        regex: Codeunit Regex;
        regexPattern: Text;
    begin
        regexPattern := '^[A-Z]\d{9}[A-Z]$';

        exit(
            regex.IsMatch(KRAPin, regexPattern, 0)
        );
    end;

    procedure InsertCommentRecord(
        headerNo: Text;
        theComment: Text;
        commentedBy: Text;
        branchCode: Text;
        activityCode: Text;
        responsibilityCenter: Text;
        triggerOnInsert: Boolean
    )
    var
        Comment: Record Comments;
    begin
        if theComment <> '' then begin
            Comment.Init;

            Comment."Header No." := headerNo;
            Comment.Comment := theComment;
            Comment."Commented By" := commentedBy;
            Comment.Date := CurrentDateTime;

            Comment."Global Dimension 1 Code" := branchCode;
            Comment."Global Dimension 2 Code" := activityCode;
            Comment."Responsibility Center" := responsibilityCenter;
            Comment.Types := Comment.Types::Comment;

            Comment.Insert(triggerOnInsert);
        end;
    end;

    procedure CleanGuid() TextWithoutCurlyBrackets: Text;
    var
        guid: Text;
    begin
        guid := CreateGuid;
        TextWithoutCurlyBrackets := CopyStr(guid, 2, StrLen(guid) - 1);
        TextWithoutCurlyBrackets := CopyStr(TextWithoutCurlyBrackets, 1, StrLen(TextWithoutCurlyBrackets) - 1);
        exit(TextWithoutCurlyBrackets);
    end;

    procedure TaxExcemptions(MemberNo: Code[20]): Boolean;
    var
        Certificates: Record "Certificate Management";
        members: Record Members;
        Employer: Record Customer;
        TaxExempt: Boolean;
    begin
        TaxExempt := false;
        if members.Get(MemberNo) then begin
            Certificates.reset;
            Certificates.SetRange("Record ID", members."No.");
            Certificates.SetRange("Document Type", Certificates."Document Type"::"Tax Exemption");
            Certificates.SetFilter("End Date", '>%1', Today);
            Certificates.SetFilter("Start Date", '<=%1', Today);
            if Certificates.Find('-') then begin
                TaxExempt := true;
            end;

        end;
        exit(TaxExempt);

    end;

    procedure GetCRMOriginationLandingDepartment(type: Enum "CRM Originations") Department: Text
    var
        CRMOrigSetup: Record "CRM Originations Setup";
    begin
        Department := '';

        if CRMOrigSetup.Get(type) then begin
            Department := CRMOrigSetup."Landing Department";
        end;
    end;

    procedure GetMemberMajorMinorLoansCount(MemberNo: Text) MemberLoaningDetails: JsonObject;
    var
        LoanGuar: record "Loan Guarantors and Security";
        GuarantorSavingsAccount: Record "Savings Accounts";
        Loan: Record Loans;
        GenSetup: Record "General Set-Up";

        MajorLoansCount: Integer;
        MinorLoansCount: Integer;
        MaxMajorLoansCount: Integer;
        MaxMinorLoansCount: Integer;
    begin
        GuarantorSavingsAccount.Reset;
        GuarantorSavingsAccount.SetRange("Member No.", MemberNo);
        GuarantorSavingsAccount.SetRange("Product Category", GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

        if GuarantorSavingsAccount.FindFirst then begin
            LoanGuar.Reset;
            LoanGuar.SetRange("Savings Account No./Member No.", GuarantorSavingsAccount."No.");
            LoanGuar.SetFilter("Outstanding Balance", '>0');
            LoanGuar.SetRange("Source Unit", LoanGuar."Source Unit"::BOSA);
            LoanGuar.SetRange(Substituted, false);

            if LoanGuar.FindSet then begin
                repeat
                    if Loan.Get(LoanGuar."Loan No") then begin
                        Loan.CalcFields("Loan Span");
                        if Loan."Loan Span" = Loan."Loan Span"::Major then
                            MajorLoansCount += 1;
                        if Loan."Loan Span" = Loan."Loan Span"::Minor then
                            MinorLoansCount += 1;
                    end;
                until LoanGuar.Next = 0;
            end;
        end;

        GenSetUp.Get;
        MaxMajorLoansCount := GenSetup."Max Major Loans To Guarantee";
        MaxMinorLoansCount := GenSetup."Max Minor Loans To Guarantee";

        MemberLoaningDetails.Add('major_loans_count', MajorLoansCount);
        MemberLoaningDetails.Add('minor_loans_count', MinorLoansCount);
        MemberLoaningDetails.Add('max_major_loans_count', MaxMajorLoansCount);
        MemberLoaningDetails.Add('max_minor_loans_count', MaxMinorLoansCount);
    end;

    procedure LogMemberCardPrinting(RecordID: Code[100])
    var
        CardPrinting: Record "Member Card Printing Log";
    begin
        CardPrinting.Init();
        CardPrinting."Printed At" := CurrentDateTime;
        CardPrinting."Printed By" := UserId;
        CardPrinting."Record ID" := RecordID;
        CardPrinting.Insert(true);
    end;

    procedure DisplayLienMessage(MemberNo: Code[20])
    var
        myInt: Integer;
        LienTransactions: Record "Cashier Transactions";
    begin
        LienTransactions.Reset;
        LienTransactions.SetRange("Member No.", MemberNo);
        LienTransactions.SetRange(Posted, true);
        LienTransactions.SetRange(Status, LienTransactions.Status::"Pending Approval");
        if LienTransactions.find('-') then begin
            Message('This member Account %1 : Product: %2 has a lien of: %. Reason : %4.', LienTransactions."Account No",
            LienTransactions."Product Type", LienTransactions.Amount, LienTransactions.Remarks);
        end;

    end;

    procedure GetTransactionCharge(TransactionCode: Code[20]; TotalAmount: Decimal): Decimal
    var
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;

        GenSetup: Record "General Set-Up";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
    begin

        GenSetup.Get();

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionCode);
        if TransactionCharges.Find('-') then begin
            repeat

                ChargeAmount := 0;
                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (TotalAmount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (TotalAmount >= TariffDetails."Lower Limit") and (TotalAmount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := TotalAmount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    TChargeAmount := TChargeAmount + ChargeAmount;

                    /*if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin

                         TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;

                     end;*/
                end;
            until TransactionCharges.Next = 0;
        end;
        exit(TChargeAmount);
    end;

    procedure FormatDateMonth(Month: Integer): Text
    var
        FormatedMonth: Text;
    //Month : Integer;
    begin

        IF Month = 1 THEN FormatedMonth := 'JANUARY';
        IF Month = 2 THEN FormatedMonth := 'FEBRUARY';
        IF Month = 3 THEN FormatedMonth := 'MARCH';
        IF Month = 4 THEN FormatedMonth := 'APRIL';
        IF Month = 5 THEN FormatedMonth := 'MAY';
        IF Month = 6 THEN FormatedMonth := 'JUNE';
        IF Month = 7 THEN FormatedMonth := 'JULY';
        IF Month = 8 THEN FormatedMonth := 'AUGUST';
        IF Month = 9 THEN FormatedMonth := 'SEPTEMBER';
        IF Month = 10 THEN FormatedMonth := 'OCTOBER';
        IF Month = 11 THEN FormatedMonth := 'NOVEMBER';
        IF Month = 12 THEN FormatedMonth := 'DECEMBER';

        exit(FormatedMonth);
    end;

    procedure ConvertDateFormulaToNumber(DateFormulaText: Text): Integer
    var
        Value: Integer;
        Unit: Text;
        Length: Integer;
    begin
        Length := StrLen(DateFormulaText);

        // Handle multi-character units like WD (weekday)
        if Length > 2 then
            Unit := CopyStr(DateFormulaText, Length - 1, 2)
        else
            Unit := CopyStr(DateFormulaText, Length, 1);

        case Unit of
            'D':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 1));
                    exit(Value); // Days
                end;
            'W':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 1));
                    exit(Value); // Weeks
                end;
            'WD':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 2));
                    exit(Value); // Weekdays
                end;
            'M':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 1));
                    exit(Value); // Months
                end;
            'Q':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 1));
                    exit(Value); // Quarters
                end;
            'Y':
                begin
                    Evaluate(Value, CopyStr(DateFormulaText, 1, Length - 1));
                    exit(Value); // Years
                end;
            else
                exit(0); // Unknown or unsupported unit
        end;
    end;

    procedure IsBusinessLoanProduct(ProductID: Code[10]): Boolean;
    var
        TheLoanProduct: Record "Product Factory";
    begin
        TheLoanProduct.Reset;

        TheLoanProduct.SetRange("Product ID", ProductID);
        TheLoanProduct.SetRange("Product Class Type", TheLoanProduct."Product Class Type"::Loan);
        TheLoanProduct.SetRange("Source Unit", TheLoanProduct."Source Unit"::"BUSINESS LOANS");

        exit(TheLoanProduct.FindFirst);
    end;

    procedure CheckMemberHasActiveBusinessDepositsAccount(MemberNo: Code[20]): Boolean;
    var
        theMember: Record members;
        theSavingsAccounts: Record "Savings Accounts";
    begin
        if theMember.Get(MemberNo) then begin
            theSavingsAccounts.Reset;
            theSavingsAccounts.SetRange("Member No.", theMember."No.");
            theSavingsAccounts.SetRange("Product Category", theSavingsAccounts."Product Category"::"Business Deposits");
            theSavingsAccounts.SetRange(Status, theSavingsAccounts.Status::Active);

            exit(theSavingsAccounts.FindFirst);
        end;

        exit(false);
    end;

    procedure CheckMemberHasActiveBosaDepositsAccount(MemberNo: Code[20]): Boolean;
    var
        theMember: Record members;
        theSavingsAccounts: Record "Savings Accounts";
    begin
        if theMember.Get(MemberNo) then begin
            theSavingsAccounts.Reset;
            theSavingsAccounts.SetRange("Member No.", theMember."No.");
            theSavingsAccounts.SetRange("Product Category", theSavingsAccounts."Product Category"::"BOSA Deposits");
            theSavingsAccounts.SetRange(Status, theSavingsAccounts.Status::Active);

            exit(theSavingsAccounts.FindFirst);
        end;

        exit(false);
    end;

    procedure IsKesasaAccount(AccNo: Text): Boolean;
    var
        SavingsAccount: Record "Savings Accounts";
    begin
        SavingsAccount.Reset;

        SavingsAccount.SetRange("No.", AccNo);
        SavingsAccount.SetRange("Product Type", 'KSS');

        exit(SavingsAccount.FindFirst);
    end;

    procedure IsFOSALoanProduct(ProductID: Code[10]): Boolean;
    var
        TheLoanProduct: Record "Product Factory";
    begin
        TheLoanProduct.Reset;

        TheLoanProduct.SetRange("Product ID", ProductID);
        TheLoanProduct.SetRange("Product Class Type", TheLoanProduct."Product Class Type"::Loan);
        TheLoanProduct.SetRange("Source Unit", TheLoanProduct."Source Unit"::FOSA);

        exit(TheLoanProduct.FindFirst);
    end;

    procedure IsBOSALoanProduct(ProductID: Code[10]): Boolean;
    var
        TheLoanProduct: Record "Product Factory";
    begin
        TheLoanProduct.Reset;

        TheLoanProduct.SetRange("Product ID", ProductID);
        TheLoanProduct.SetRange("Product Class Type", TheLoanProduct."Product Class Type"::Loan);
        TheLoanProduct.SetRange("Source Unit", TheLoanProduct."Source Unit"::BOSA);

        exit(TheLoanProduct.FindFirst);
    end;

    procedure GetBranchCodeFromCRMOrigination(theCRMBranchName: Text): Text;
    var
        DimensionValues: Record "Dimension Value";
    begin
        DimensionValues.Reset;
        DimensionValues.SetRange("Dimension Code", 'BRANCH');
        DimensionValues.SetRange(Name, theCRMBranchName);

        if DimensionValues.FindFirst then begin
            exit(DimensionValues.Code)
        end;

        exit('301');
    end;

    procedure RemoveExtraWhiteSpaces(TheStrValue: Text) CleanedText: Text;
    begin
        // exit(DelChr(TheStrValue, '<>', ' ').Trim);
        CleanedText := TheStrValue;
        while STRPOS(CleanedText, '  ') > 0 do begin
            CleanedText := STRSUBSTNO('%1 %2', COPYSTR(CleanedText, 1, STRPOS(CleanedText, '  ') - 1), COPYSTR(CleanedText, STRPOS(CleanedText, '  ') + 2));
        end;
    end;

    procedure GetMainBranchCodeFromCRMOrigination(theCRMBranchName: Text): Text;
    var
        DimensionValues: Record "Dimension Value";
        SatelliteBranchSetup: Record "Satellite Branches Setup";
    begin
        SatelliteBranchSetup.Reset;
        SatelliteBranchSetup.SetRange("Satellite Branch", theCRMBranchName);
        if SatelliteBranchSetup.FindFirst then begin
            exit(SatelliteBranchSetup."Main Branch Code");
        end;

        DimensionValues.Reset;
        DimensionValues.SetRange("Dimension Code", 'BRANCH');
        DimensionValues.SetRange(Name, theCRMBranchName);

        if DimensionValues.FindFirst then begin
            exit(DimensionValues.Code)
        end;

        exit('315');
    end;

    procedure ConvertMillisecondsToCustomDays(Milliseconds: Duration): Text
    var
        CustomMillisecondsInADay: Duration;
        Days: Integer;
        RemMilliseconds: Duration;
    begin
        // Define custom milliseconds for 1 day as per the new scaling
        CustomMillisecondsInADay := 86400000 / 3; // Adjust the scaling to fit 86,400,000 milliseconds to 3 days
        RemMilliseconds := Milliseconds mod CustomMillisecondsInADay;
        Days := (Milliseconds - RemMilliseconds) / CustomMillisecondsInADay;

        if Days >= 1 then begin
            if Days = 1 then begin
                exit(Format(Days) + ' day ' + Format(RemMilliseconds));
            end else begin
                exit(Format(Days) + ' days ' + Format(RemMilliseconds));
            end;
        end else begin
            exit(Format(RemMilliseconds));
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Editss", 'OnBeforeSystemEditsPosting', '', true, true)]
    local procedure "System Editss_OnBeforeSystemEditsPosting"
    (
        TableID: Integer;
        FilterValue: Text;
        FieldID: Integer;
        NewFieldRef: FieldRef
    )
    var
        SavingAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        Loans: Record Loans;
    begin
        if (TableID = 52185700) and (FieldID = 3) then begin
            SavingAccounts.Reset;
            SavingAccounts.SetRange(SavingAccounts."Member No.", FilterValue);
            if SavingAccounts.Find('-') then begin
                repeat
                    SavingAccounts.Validate(SavingAccounts.Name, NewFieldRef.Value);
                    SavingAccounts.Modify;
                until SavingAccounts.Next = 0;
            end;

            CreditAccounts.Reset;
            CreditAccounts.SetRange(CreditAccounts."Member No.", FilterValue);
            if CreditAccounts.Find('-') then begin
                repeat
                    CreditAccounts.Validate(CreditAccounts.Name, NewFieldRef.Value);
                    CreditAccounts.Modify;
                until CreditAccounts.Next = 0;
            end;
            Loans.Reset;
            Loans.SetRange("Member No.", FilterValue);
            if Loans.Find('-') then begin
                repeat
                    Loans."Member Name" := NewFieldRef.Value;
                    Loans.Modify;
                until Loans.Next = 0;
            end;
        end;
    end;

    // procedure ExportCustomerListToExcel()
    // var
    //     ExcelBuffer: Record "Excel Buffer";
    //     TempBlob: Record TempBlob;
    //     OutStream: OutStream;
    //     Customers: Record Customer;
    // begin
    //     // Initialize Excel Buffer
    //     ExcelBuffer.Clear();
    //     ExcelBuffer.AddColumn('Customer No.', false, false, false, '', false, false, true, false, false, true);
    //     ExcelBuffer.AddColumn('Customer Name', false, false, false, '', false, false, true, false, false, true);

    //     // Fetch data
    //     if Customers.FindSet() then
    //     repeat
    //         ExcelBuffer.AddRow();
    //         ExcelBuffer.AddColumnData(Customers."No.", '', false, false, false, false, false, false);
    //         ExcelBuffer.AddColumnData(Customers.Name, '', false, false, false, false, false, false);
    //     until Customers.Next() = 0;

    //     // Generate Excel file
    //     TempBlob.CreateOutStream(OutStream);
    //     ExcelBuffer.GenerateExcel(OutStream);

    //     // Download the file
    //     DownloadFromStream(OutStream, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'CustomerList.xlsx');
    // end;



    procedure UpdateAmountGuaranteed(LoanNo: Code[20]; AppliedAmount: Decimal): Decimal
    var
        Guarantor: Record "Loan Guarantors and Security";
        TotalSpecifiedAmount: Decimal;
        CountUnspecified: Integer;
        RemainingAmount: Decimal;
        PerGuarantorAmount: Decimal;
        maxamountguarantee: Decimal;
        Totalguarantee: Decimal;
        GenSetUp: Record "General Set-Up";
    begin
        // Step 1: Reset tracking variables
        TotalSpecifiedAmount := 0;
        CountUnspecified := 0;

        // Step 2: Loop through guarantors to calculate total specified amount & count unspecified ones
        Guarantor.LockTable(); // Lock table to prevent concurrent modifications
        Guarantor.Reset();
        Guarantor.SetRange("Loan No", LoanNo);

        if Guarantor.FindSet() then begin
            repeat
                if Guarantor."User Specified" then
                    TotalSpecifiedAmount += Guarantor."Amount Guaranteed"
                else
                    CountUnspecified += 1;
            until Guarantor.Next() = 0;
        end;

        // Step 3: Calculate the remaining amount
        RemainingAmount := AppliedAmount - TotalSpecifiedAmount;

        // Step 4: Prevent division by zero before apportioning amount
        if (CountUnspecified > 0) and (RemainingAmount <> 0) then begin
            PerGuarantorAmount := Round(RemainingAmount / CountUnspecified, 0.01);

            Guarantor.Reset();
            Guarantor.SetRange("Loan No", LoanNo);

            if Guarantor.FindSet() then begin
                repeat
                    if NOT Guarantor."User Specified" then begin
                        // Assign amount and update dynamically
                        Guarantor."Amount Guaranteed" := PerGuarantorAmount;
                        //validate if  guarantor exceed maximum allowable
                        GenSetUp.Get;
                        maxamountguarantee := GenSetUp."Maximum Amount to Guarantee";
                        Guarantor.CalcFields("Total Guaranteed");
                        Totalguarantee := Guarantor."Amount Guaranteed" + Guarantor."Total Guaranteed";
                        if Totalguarantee > maxamountguarantee then begin
                            Guarantor."Amount Guaranteed" := Totalguarantee - maxamountguarantee;
                            PerGuarantorAmount := Round(Guarantor."Amount Guaranteed", 0.01);
                            if PerGuarantorAmount > maxamountguarantee then
                                PerGuarantorAmount := 0;

                            Guarantor."Amount Guaranteed" := PerGuarantorAmount;
                            Message('The system has adjusted the guarantee amount for guarantor %1 to Ksh.%2 as they have reached the maximum allowable guarantee of Ksh.%3', Guarantor."Member No", PerGuarantorAmount, maxamountguarantee);
                            Guarantor."User Specified" := true;
                        end;

                        //end of validation

                        Guarantor."Original Amount Guaranteed" := PerGuarantorAmount;
                        Guarantor.Modify(false);

                        // Adjust remaining amount and count to avoid rounding issues
                        RemainingAmount := RemainingAmount - PerGuarantorAmount;
                        CountUnspecified := CountUnspecified - 1;

                        if CountUnspecified > 0 then
                            PerGuarantorAmount := Round(RemainingAmount / CountUnspecified, 0.01);
                    end;
                until Guarantor.Next() = 0;
            end;
        end;
    end;

    procedure GetMonthStartAndEndDate(MMYYYY: Text) Dates: List of [Date];
    var
        MonthTxt: Text[2];
        YearTxt: Text[4];
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        // Extract parts from MMYYYY
        MonthTxt := CopyStr(MMYYYY, 1, 2);
        YearTxt := CopyStr(MMYYYY, 3, 4);

        Evaluate(Month, MonthTxt);
        Evaluate(Year, YearTxt);

        // Start date = 1st of the month
        StartDate := DMY2Date(1, Month, Year);

        // End date = last day of the month
        EndDate := CalcDate('CM', StartDate);

        Dates.AddRange(StartDate, EndDate);

        exit(Dates);
    end;

    procedure CheckHowLongOneHasBeenAMember(MemberNo: Code[20]): Integer
    var
        Members: Record Members;
    begin
        Members.Reset;
        Members.Setrange("No.", MemberNo);
        if Members.FindFirst() then begin
            exit(Today - Members."Registration Date");
        end;
    end;

    procedure GetFOSAAccount(member: record Members): Code[20];
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", member."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    procedure GetDepositAccount(member: record Members): Code[20];
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", member."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    procedure GetShareCptAccount(member: record Members): Code[20];
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", member."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Share Capital");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    //LOCK
    // procedure UpdateAmountGuaranteed(LoanNo: Code[20]; AppliedAmount: Decimal): Decimal
    // var
    //     Guarantor: Record "Loan Guarantors and Security";
    //     TotalSpecifiedAmount: Decimal;
    //     CountUnspecified: Integer;
    //     RemainingAmount: Decimal;
    //     PerGuarantorAmount: Decimal;
    // begin
    //     // Step 1: Reset tracking variables
    //     TotalSpecifiedAmount := 0;
    //     CountUnspecified := 0;

    //     // Step 2: Fetch Guarantors and calculate total specified amount & count unspecified ones
    //     Guarantor.Reset();
    //     Guarantor.SetRange("Loan No", LoanNo);

    //     if Guarantor.FindSet() then begin
    //         repeat
    //             if Guarantor."User Specified" then
    //                 TotalSpecifiedAmount += Guarantor."Amount Guaranteed"
    //             else
    //                 CountUnspecified += 1;
    //         until Guarantor.Next() = 0;
    //     end;

    //     // Step 3: Calculate the remaining amount
    //     RemainingAmount := AppliedAmount - TotalSpecifiedAmount;

    //     // Step 4: Prevent division by zero before apportioning amount
    //     if (CountUnspecified > 0) and (RemainingAmount > 0) then begin
    //         PerGuarantorAmount := Round(RemainingAmount / CountUnspecified, 0.01);

    //         Guarantor.Reset();
    //         Guarantor.SetRange("Loan No", LoanNo);

    //         if Guarantor.FindSet() then begin
    //             repeat
    //                 if NOT Guarantor."User Specified" then begin
    //                     Guarantor."Amount Guaranteed" := PerGuarantorAmount;
    //                     Guarantor.Modify();

    //                     // Update the remaining amount dynamically
    //                     RemainingAmount := RemainingAmount - PerGuarantorAmount;
    //                     CountUnspecified := CountUnspecified - 1;

    //                     // Adjust PerGuarantorAmount if last person to avoid rounding issues
    //                     if CountUnspecified > 0 then
    //                         PerGuarantorAmount := Round(RemainingAmount / CountUnspecified, 0.01);
    //                 end;
    //             until Guarantor.Next() = 0;
    //         end;
    //     end;
    // end;
    procedure getChargesAmt(TransCode: Code[50]; Amount: decimal): Decimal;
    var
        ChargeAmt: Decimal;
        TotalCharge: Decimal;
        ExciseDuty: decimal;
        TransactionCharges: record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        GeneralSetUp: Record "General Set-Up";
        ChargeAmount: Decimal;
        TExciseDuty: Decimal;
    begin
        ChargeAmount := 0;
        TotalCharge := 0;
        ExciseDuty := 0;
        TExciseDuty := 0;
        GeneralSetUp.get();
        GeneralSetUp.TestField("Excise Duty (%)");

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransCode);
        if TransactionCharges.Find('-') then begin
            repeat
                ChargeAmount := 0;
                ExciseDuty := 0;
                if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" then begin
                    if TransactionCharges."Recover Excise Duty" = false then
                        ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                    else begin
                        ChargeAmount := ((Amount * TransactionCharges."Percentage of Amount") * 0.01) + (0.01 * ((Amount * TransactionCharges."Percentage of Amount") * (GeneralSetUp."Excise Duty (%)" * 0.01)));
                    end;
                end
                else begin
                    if TransactionCharges."Recover Excise Duty" = false then
                        ChargeAmount := TransactionCharges."Charge Amount" else begin
                        ChargeAmount := (TransactionCharges."Charge Amount") + (TransactionCharges."Charge Amount" * (GeneralSetUp."Excise Duty (%)" * 0.01));
                        ExciseDuty := (TransactionCharges."Charge Amount" * (GeneralSetUp."Excise Duty (%)" * 0.01));

                    end;
                end;
                if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin
                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                    if TariffDetails.Find('-') then begin
                        repeat
                            if (Amount >= TariffDetails."Lower Limit") and (Amount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" then begin
                                    if TransactionCharges."Recover Excise Duty" = false then
                                        ChargeAmount := Amount * TariffDetails.Percentage * 0.01 else begin
                                        ChargeAmount := ((Amount * TariffDetails.Percentage * 0.01) + ((Amount * TariffDetails.Percentage * 0.01) * (GeneralSetUp."Excise Duty (%)" * 0.01)));
                                        ExciseDuty := ((Amount * TariffDetails.Percentage * 0.01) * (GeneralSetUp."Excise Duty (%)" * 0.01));

                                    end;
                                end else begin
                                    if TransactionCharges."Recover Excise Duty" = false then
                                        ChargeAmount := TariffDetails."Charge Amount" else begin
                                        ChargeAmount := ((TariffDetails."Charge Amount") + ((TariffDetails."Charge Amount") * (GeneralSetUp."Excise Duty (%)" * 0.01)));
                                        ExciseDuty := ((TariffDetails."Charge Amount") * (GeneralSetUp."Excise Duty (%)" * 0.01));
                                    end;
                                end;
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;
                TExciseDuty += ExciseDuty;
                TotalCharge += ChargeAmount;
            until TransactionCharges.Next = 0;
        end;
        exit(TotalCharge + TExciseDuty);
    end;

    procedure GetPaidReadmissionFees(MemberNo: Code[20]; RegistrationFeeAccount: Code[50]; RejoiningDate: Date): Decimal
    var
        Members: Record Members;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        TotalPaid: Decimal;
    begin
        Clear(TotalPaid);
        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.Setrange("Member No.", MemberNo);
        SavingsLedgerEntry.Setrange("Customer No.", RegistrationFeeAccount);
        SavingsLedgerEntry.Setfilter("Posting Date", '%1..%2', RejoiningDate, Today);
        if SavingsLedgerEntry.Find('-') then begin
            SavingsLedgerEntry.Calcsums(Amount);
            TotalPaid := Abs(SavingsLedgerEntry.Amount);
        end;
        exit(TotalPaid);
    end;

    procedure GetRandomBoolean(): Boolean
    begin
        Randomize();
        exit(Random(2) = 1);
    end;
}


