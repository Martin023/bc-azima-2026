table 52186240 "Delegate Officials"
{
    DataCaptionFields = "Electoral Zone", "Delegate Official Name";
    DrillDownPageID = "Active Delegate Officials";
    LookupPageID = "Active Delegate Officials";

    fields
    {
        field(1; "Electoral Zone"; Code[50])
        {
            Description = 'Lookup to Delegate Electoral Zones';
            Editable = true;
            TableRelation = "Electoral Zones".Code;
            trigger OnValidate()
            var
            begin
                CalcFields("Electoral Zone Name");
            end;
        }
        field(2; "Member Number"; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                CalcFields("Delegate Official Name");
                DelegateOfficials.Reset;
                DelegateOfficials.SetFilter("Electoral Zone", '<>%1', Rec."Electoral Zone");
                DelegateOfficials.SetRange(Retired, false);
                DelegateOfficials.SetRange("Member Number", Rec."Member Number");
                if DelegateOfficials.FindFirst then
                    Error('This delegate is already an official in another %1 electoral zone.', DelegateOfficials."Electoral Zone Name");

                GeneralSetUp.Get();
                if Members.Get("Member Number") then begin
                    if (CalcDate(GeneralSetUp."Min.Delegate Membership Period", Members."Registration Date")) > Today then
                        Error(ErrMemb, GeneralSetUp."Min.Delegate Membership Period");
                    "Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                    "Registered By" := UserId;
                    if GeneralSetUp."Requires Salary Processing" = true then begin
                        Account.Reset;
                        Account.SetRange("Member No.", Members."No.");
                        Account.SetRange("Product Type", '505');
                        if Account.FindFirst then begin
                            AccountNo := Account."No.";
                            EndDateSalo := CalcDate('-' + Format(GeneralSetUp."Salary Period"), Today);
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", AccountNo);
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            SalProc.SetRange(Posted, true);
                            if not SalProc.FindFirst then
                                Error('Member''s salary must be proccessed trhough the sacco');
                        end;

                        SavingsAccount.Reset;
                        SavingsAccount.SetRange("Member No.", "Member Number");
                        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Share Capital");
                        if SavingsAccount.FindFirst then begin
                            SavingsAccount.CalcFields(SavingsAccount."Balance (LCY)");
                            if SavingsAccount."Balance (LCY)" < GeneralSetUp."Min. Delegates Share Capital" then
                                Error('This member does not meet the required Share Capital of %1', GeneralSetUp."Min. Delegates Share Capital");
                        end else
                            Error('This member does not have Share Capital account');

                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", "Member Number");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                        if SavingsAccounts.Find('-') then begin
                            SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                            if SavingsAccounts."Balance (LCY)" < GeneralSetUp."Min. Delegates deposit" then
                                Error('This member donot meet the required deposit contribution of %1', GeneralSetUp."Min. Delegates deposit");
                        end else
                            Error('This member does not have Deposit Contribution account');
                    end;
                end;
            end;
        }
        field(3; "Delegate Official Name"; Text[100])
        {
            CalcFormula = Lookup(Members.Name WHERE("No." = FIELD("Member Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Position; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = filter(Position | "Delegate Member"));

            trigger OnValidate()
            var
                Salutations: Record "Salutation Tittles";
            begin

                Salutations.Get(Position);

                if Salutations.Type = Salutations.Type::Position then begin
                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Rec."Electoral Zone");
                    DelegateOfficials.SetRange(Position, Rec.Position);
                    DelegateOfficials.SetRange(Retired, false);
                    if DelegateOfficials.FindFirst then begin
                        DelegateOfficials.CalcFields("Delegate Official Name");
                        Error('This zone already has %1 as a %2.', DelegateOfficials."Delegate Official Name", DelegateOfficials.Position);
                    end;
                end;
            end;
        }
        field(6; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(7; Retired; Boolean)
        {
            Editable = false;
        }
        field(8; "Retire Date"; Date)
        {
            Editable = false;
        }
        field(10; "Service Period"; Text[30])
        {
            Editable = false;
        }
        field(11; "Retired By"; Code[50])
        {
            Editable = false;
        }
        field(19; "Reason for retirement"; Option)
        {
            OptionCaption = ' ,Death,Transfer,Resignation,Election,Impeachment';
            OptionMembers = " ",Death,Transfer,Resignation,Election,Impeachment;
        }
        field(21; "Electoral Zone Name"; Text[100])
        {
            CalcFormula = Lookup("Electoral Zones"."Electoral Zone Name" WHERE(Code = FIELD("Electoral Zone")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Appointment Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Appointment Date" > Today then
                    Error('Appointment date cannot be later than today');
            end;
        }
        field(23; "Expiry Date"; Date)
        {
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Global Dimension 1 Name"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code Name';
            Editable = false;
        }
        field(26; "ID No."; Code[50])
        {
            CalcFormula = Lookup(Members."Primary Identification" WHERE("No." = FIELD("Member Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Registered By"; Text[50])
        {
            Editable = false;
        }
        field(36; "Retirement Date"; Date)
        {
        }
        field(37; "Board Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Electoral Zone", "Member Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member Number", "Delegate Official Name", Position)
        {
        }
    }

    var
        Members: Record Members;
        // DelegateMembers: Record "Delegate Members Applicationss";
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        GeneralSetUp: Record "General Set-Up";
        ErrMemb: Label 'This member has not met minimum membership period of %1';
        Account: Record "Savings Accounts";
        AccountNo: Code[50];
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        SavingsAccount: Record "Savings Accounts";
        SavingsAccounts: Record "Savings Accounts";
        DelegateOfficials: Record "Delegate Officials";
}

