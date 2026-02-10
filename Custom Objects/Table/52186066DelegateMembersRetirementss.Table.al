table 52186066 "Delegate Members Retirementss"
{
    DrillDownPageID = "Delegate Retire Memberss";
    LookupPageID = "Delegate Retire Memberss";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Lookup to Delegate groups';
            Editable = false;
        }
        field(2; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = Members."No.";

            trigger OnValidate()
            begin

                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", "Delegate MNO.");
                DelegateMemberss.SetFilter(Type, '<>%1', DelegateMemberss.Type::ADM);
                DelegateMemberss.SetRange(Retired, false);

                if DelegateMemberss.Find('-') then begin
                    Error('This member is already a member of %1', DelegateMemberss.Code);
                end;
                Validate(Position);
                if Members.Get("Delegate MNO.") then begin
                    "Delegate Name" := Members.Name;
                end;

                TestField("Job Tittle");
                TestField(Position);

                GeneralSetUp.Get();
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", "Delegate MNO.");
                DelegateMemberss.SetFilter(Type, '<>%1', DelegateMemberss.Type::ADM);
                DelegateMemberss.SetRange(Retired, false);
                if DelegateMemberss.Find('-') then begin
                    Error('This member is already a member of %1', DelegateMemberss.Code);
                end;
                Validate(Position);
                if Members.Get("Delegate MNO.") then begin
                    if Members.Status <> Members.Status::Active then
                        Error(Err0000);

                    if (CalcDate(GeneralSetUp."Min.Delegate Membership Period", Members."Registration Date")) > Today then
                        Error(ErrMemb, GeneralSetUp."Min.Delegate Membership Period");
                    //check where salary is passing through'
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
                    end;

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange(SavingsAccount."Member No.", "Delegate MNO.");
                    SavingsAccount.SetRange(SavingsAccount."Product Category", SavingsAccount."Product Category"::"Share Capital");
                    if SavingsAccount.Find('-') then begin

                        SavingsAccount.CalcFields(SavingsAccount."Balance (LCY)");
                        // MESSAGE(FORMAT(SavingsAccount."Balance (LCY)"));
                        if SavingsAccount."Balance (LCY)" < GeneralSetUp."Min. Delegates Share Capital" then
                            Error('This member does not meet the required Share Capital of %1', GeneralSetUp."Min. Delegates Share Capital");
                    end else
                        Error('This member does not have Share Capital account');

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Delegate MNO.");
                    SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin
                        SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                        // MESSAGE(FORMAT(SavingsAccounts."Balance (LCY)"));
                        if SavingsAccounts."Balance (LCY)" < GeneralSetUp."Min. Delegates deposit" then
                            Error('This member does not meet the required deposit contribution of %1', GeneralSetUp."Min. Delegates deposit");
                    end else
                        Error('This member does not have Deposit Contribution account');
                end;


                DelegateGroupsApplicationss.Reset;
                DelegateGroupsApplicationss.SetRange(DelegateGroupsApplicationss.Code, Code);
                if DelegateGroupsApplicationss.Find('-') then begin
                    // IF DelegateGroupsApplicationss."Global Dimension 2 Code"<>Members."Global Dimension 2 Code" THEN
                    //  ERROR('Member No.: %1 belong to Branch: %2 and therefore cannot represent  Branch: %3',Members."No.",Members."Global Dimension 2 Code",DelegateGroupsApplicationss."Global Dimension 2 Code");
                end;
                //"Global Dimension 2 Code":=Members."Global Dimension 2 Code";
                //VALIDATE("Global Dimension 2 Code");
                "Delegate Name" := Members.Name;
                //"ID No.":=Members."Primary Identification";
                //"Appointment Date":=TODAY;
                //END;
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", "Delegate MNO.");
                DelegateMemberss.SetRange(DelegateMemberss.Code, Rec.Code);
                if not DelegateMemberss.Find('-') then begin
                    Appoint := true;
                end;
            end;
        }
        field(3; "Delegate Name"; Text[100])
        {
        }
        field(4; Position; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

            trigger OnValidate()
            begin
                DelegateMembers.Reset;
                DelegateMembers.SetRange(DelegateMembers.Code, Code);
                DelegateMembers.SetRange(DelegateMembers.Retired, false);
                DelegateMembers.SetRange(DelegateMembers.Position, Position);
                if DelegateMembers.Find('-') then begin
                    if Position <> '' then
                        Error(ErrPosition, Position);
                end;
            end;
        }
        field(5; "Job Tittle"; Code[50])
        {
            Description = '39004358';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
        }
        field(6; Retired; Boolean)
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(8; "Service Period"; Text[30])
        {
        }
        field(9; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Appointment Date"; Date)
        {
        }
        field(11; Reinstate; Boolean)
        {
        }
        field(12; "Retirement Date"; Date)
        {
        }
        field(13; "Reinstatement Date"; Date)
        {
        }
        field(14; "Tranfer To"; Code[10])
        {
            TableRelation = "Delegate Region";

            trigger OnValidate()
            begin
                DelegateRegion.Reset;
                DelegateRegion.SetRange(Code, "Tranfer To");
                if DelegateRegion.Find('-') then begin

                    "Transfer to Name" := DelegateRegion."Delegate Region Description";

                end;
            end;
        }
        field(15; "Tranfer Date"; Date)
        {
        }
        field(16; "Transfer to Position"; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

            trigger OnValidate()
            begin
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss.Code, "Tranfer To");
                DelegateMemberss.SetRange(DelegateMemberss.Retired, false);
                DelegateMemberss.SetRange(DelegateMemberss.Position, "Transfer to Position");
                if DelegateMemberss.Find('-') then begin
                    //IF "Transfer to Position"<>'' THEN
                    Error(ErrPosition, "Transfer to Position");
                end;
            end;
        }
        field(17; "Transfer to Name"; Text[50])
        {
        }
        field(18; Transfer; Boolean)
        {
        }
        field(19; Appoint; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code", "Delegate MNO.", "Entry No", "Appointment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        Members: Record Members;
        DelegateMembers: Record "Delegate Members Retirementss";
        GeneralSetUp: Record "General Set-Up";
        DelegateMemberss: Record "Delegate Members";
        DelegateGroupsApplicationss: Record "Delegate Region Applicationss";
        DimensionValue: Record "Dimension Value";
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        Account: Record "Savings Accounts";
        AccountNo: Code[20];
        SavingsAccounts: Record "Savings Accounts";
        SavingsAccount: Record "Savings Accounts";
        ErrMemb: Label 'This member has not met minimum membership period of %1';
        Text010: Label 'This member does not receive salary through the sacco';
        Err0000: Label 'Member status must be Active';
        DelegateRegion: Record "Delegate Region";
}

