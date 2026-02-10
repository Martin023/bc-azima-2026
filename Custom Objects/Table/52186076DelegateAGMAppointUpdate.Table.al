table 52186076 "Delegate AGM Appoint Update"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Code"; Code[50])
        {
            Description = 'Lookup to Delegate groups';
            TableRelation = "Delegate Region".Code;
        }
        field(3; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = Members."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                TestField(Code);
                TestField("Job Tittle");

                Members.Reset;
                Members.SetRange("No.", "Delegate MNO.");
                if Members.Find('-') then begin
                    "ID No." := Members."Primary Identification";
                    "Delegate Name" := Members.Name;
                end;
                DelegateMembers.Reset;
                DelegateMembers.SetRange("Delegate MNO.", Rec."Delegate MNO.");
                DelegateMembers.SetRange(Retired, false);
                if DelegateMembers.Find('-') then begin
                    Error(Errgroup, DelegateMembers.Code);


                end;


                if Members.Get("Delegate MNO.") then begin
                    if (CalcDate(GeneralSetUp."Min.Delegate Membership Period", Members."Registration Date")) > Today then
                        Error(ErrMemb, GeneralSetUp."Min.Delegate Membership Period");
                    //chech where salary is passing through'
                    if GeneralSetUp."Requires Salary Processing" = true then begin
                        Account.Reset;
                        Account.SetRange("Member No.", Members."No.");
                        Account.SetRange("Loan Disbursement Account", true);
                        Account.SetCurrentKey(Blocked);
                        if Account.Find('-') then begin
                            AccountNo := Account."No.";
                            EndDateSalo := CalcDate('-' + Format(GeneralSetUp."Salary Period"), Today);
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", AccountNo);
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            SalProc.SetRange(Posted, true);
                            if not SalProc.Find('-') then
                                Error(Text010);
                        end;
                        SavingsAccount.Reset;
                        SavingsAccount.SetRange(SavingsAccount."Member No.", "Delegate MNO.");
                        SavingsAccount.SetRange(SavingsAccount."Product Category", SavingsAccount."Product Category"::"Share Capital");
                        if SavingsAccount.Find('-') then begin
                            SavingsAccount.CalcFields(SavingsAccount."Balance (LCY)");
                            //MESSAGE(FORMAT(SavingsAccount."Balance (LCY)"));
                            if SavingsAccount."Balance (LCY)" < GeneralSetUp."Min. Delegates Share Capital" then
                                Error('This member donot meet the required Share Capital of %1', GeneralSetUp."Min. Delegates Share Capital");
                        end else
                            Error('This member does not have Share Capital account');

                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Delegate MNO.");
                        SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                        if SavingsAccounts.Find('-') then begin
                            SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                            // MESSAGE(FORMAT(SavingsAccounts."Balance (LCY)"));
                            if SavingsAccounts."Balance (LCY)" < GeneralSetUp."Min. Delegates deposit" then
                                Error('This member donot meet the required deposit contribution of %1', GeneralSetUp."Min. Delegates deposit");
                        end else
                            Error('This member does not have Deposit Contribution account');
                    end;
                end;
            end;
        }
        field(4; "Delegate Name"; Text[100])
        {
            Editable = false;
        }
        field(5; Position; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

            trigger OnValidate()
            begin
                DelegateMembers.Reset;
                DelegateMembers.SetRange(Code, Code);
                DelegateMembers.SetRange(Retired, false);
                DelegateMembers.SetRange(Position, Position);
                if DelegateMembers.Find('-') then begin
                    if Position <> '' then
                        Error(ErrPosition, Position);

                end;
            end;
        }
        field(6; "Job Tittle"; Code[50])
        {
            Description = '39004358';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(11; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(13; "Appointment Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Appointment Date" > Today then
                    "Appointment Date" := Today;
            end;
        }
        field(14; "ID No."; Code[20])
        {
        }
        field(15; Type; Option)
        {
            OptionCaption = 'Normal,ADM';
            OptionMembers = Normal,ADM;
        }
        field(16; "Delegate Code"; Code[20])
        {
        }
        field(17; "Region Names"; Text[100])
        {
            CalcFormula = Lookup("Delegate Region"."Delegate Region Description" WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(18; "Update Type"; Option)
        {
            OptionCaption = ' ,Retire,Appoint';
            OptionMembers = " ",Retire,Appoint;
        }
        field(19; "Election Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Delegate MNO.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DelegateMembers: Record "Delegate Members";
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        ErrMemb: Label 'This member has not met minimum membership period of %1';
        Members: Record Members;
        Errgroup: Label 'This member is active in delegate group no %1 ';
        Eno: Integer;
        GeneralSetUp: Record "General Set-Up";
        Account: Record "Savings Accounts";
        AccountNo: Code[20];
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        SavingsAccount: Record "Savings Accounts";
        SavingsAccounts: Record "Savings Accounts";
        Text010: Label 'This member does not receive salary through the sacco';

    [Scope('OnPrem')]
    procedure Tracker(DelegateMemberss: Record "Delegate Members")
    var
        DelegateAppointUpdate: Record "Delegate AGM Appoint Update";
    begin
        DelegateAppointUpdate.Reset;
        DelegateAppointUpdate.SetRange(DelegateAppointUpdate."No.", "No.");
        if DelegateAppointUpdate.Find('-') then begin

            repeat
                Eno := DelegateMemberss.Count;
                Eno += 1;
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", DelegateAppointUpdate."Delegate MNO.");
                DelegateMemberss.SetRange(DelegateMemberss.Code, DelegateAppointUpdate.Code);
                if not DelegateMemberss.Find('-') then begin
                    DelegateMemberss.Init;
                    DelegateMemberss.Code := Code;
                    DelegateMemberss."Entry No" := Eno;
                    DelegateMemberss."Delegate MNO." := "Delegate MNO.";
                    DelegateMemberss."Delegate Name" := "Delegate Name";
                    DelegateMemberss."Job Tittle" := "Job Tittle";
                    DelegateMemberss.Position := Position;
                    DelegateMemberss."Appointment Date" := "Appointment Date";
                    DelegateMemberss."Registered By" := UserId;
                    DelegateMemberss."ID No." := "ID No.";
                    DelegateMemberss.Insert;
                end;
            until DelegateAppointUpdate.Next = 0;
        end;
    end;
}

