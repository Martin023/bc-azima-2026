table 52185964 "Surety Management"
{
    DrillDownPageId = "Surety Management List";
    LookupPageId = "Surety Management Card";
    fields
    {
        field(1; "Surety No"; Code[20])
        {
        }
        field(2; "Refference No"; Code[20])
        {
        }
        field(3; "Refference Details"; Text[200])
        {
        }
        field(4; "Member Nos"; Code[40])
        {
        }
        field(5; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(6; Amount; Decimal)
        {

        }
        field(7; Date; Date)
        {
            trigger OnValidate()
            begin
                if Date > TODAY then
                    Error('You cannot enter a future date');
            end;
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(50005; Status; Enum "Workflow Status Main Flags")
        {
        }
        field(50006; "Type Of Account"; Option)
        {
            OptionMembers = " ",Member,Savings;
        }
        field(50007; "Account No"; Code[20])
        {
            Caption = 'Member No.';

            TableRelation = Members."No.";
            // TableRelation = IF ("Type Of Account" = CONST(Member)) Members."No."
            // ELSE
            // IF ("Type Of Account" = CONST(Savings)) "Savings Accounts"."No." WHERE("Product Category" = filter("BOSA Deposits"));

            trigger OnValidate()
            begin
                Rec.Amount := 0;
                Rec."Outstanding Balance" := 0;

                Memb.Reset;
                if Memb.Get("Account No") then
                    "Member Name" := Memb.Name;

                SavingsAccounts.Reset;
                SavingsAccounts.setrange("Member No.", "Account No");
                SavingsAccounts.Setrange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                //Rec.Amount := SavingsAccounts."Balance (LCY)";
                // Rec.Amount := GlobalFunctions.GetRunningBalance(SavingsAccounts."Balance (LCY)");
                Rec."BOSA Acc No." := SavingsAccounts."No.";
                Rec.Amount := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                Rec."BOSA A/c Status" := FORMAT(SavingsAccounts.Status);

                Loans.Reset;
                Loans.SetRange(Loans."Member No.", "Account No");
                Loans.SetRange(Loans."Source Unit", Loans."Source Unit"::"BOSA");
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                    Rec."Outstanding Balance" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                end;

                "Net Amount" := Rec.Amount - Rec."Outstanding Balance";

                // SavingsAccounts.Reset;
                // SavingsAccounts.SetRange(SavingsAccounts."No.", "Account No");
                // if SavingsAccounts.Find('-') then
                //     "Account Name" := SavingsAccounts.Name;
                // SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                // Amount := SavingsAccounts."Balance (LCY)";
                // "Member Account No" := SavingsAccounts."Member No.";
                // //"Member Name" := SavingsAccounts."Name";


                // Memb.Reset;
                // Memb.SetRange(Memb."No.", "Account No");
                // if Memb.Find('-') then
                //     "Member Name" := Memb.Name;


                // Memb.Reset;
                // Memb.SetRange(Memb."No.", "Account No");
                // if Memb.Find('-') then
                //     "Member Name" := Memb.Name;


            end;
        }
        field(50008; "User ID"; Code[50])
        {
        }
        field(50009; "Court Name"; Text[100])
        {
        }
        field(50010; Court; Text[100])
        {
        }
        field(50011; Type; Text[100])
        {
        }
        field(50012; "Case No"; Code[100])
        {
        }
        // field(50013; "Member No"; Code[20])
        // {
        //     TableRelation = "Credit Accounts"."No.";

        //     trigger OnValidate()
        //     begin
        //         CreditAccount.Reset;
        //         CreditAccount.SetRange(CreditAccount."No.", "Member No");
        //         if CreditAccount.Find('-') then
        //             "Member Name" := CreditAccount.Name;
        //         CreditAccount.CalcFields(CreditAccount."Balance (LCY)");
        //         "Outstanding Balance" := CreditAccount."Balance (LCY)";
        //         if "Outstanding Balance" > 0 then
        //             Error('You cannot be a surety because you have Loan ', "Outstanding Balance");
        //     end;

        // }
        field(50014; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(50015; "Outstanding Balance"; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec."Outstanding Balance" > 0 then
                    Error('You cannot be a surety because you have Loan %1.', "Outstanding Balance");
            end;
        }
        field(50016; Accused; Text[100])
        {
        }
        field(50017; "Member Account No"; Code[20])
        {
        }
        field(50018; "Stopped USER ID"; Code[20])
        {
        }
        field(50019; "Stopped Time"; Time)
        {
        }
        field(50020; "Stopped Date"; Date)
        {
        }
        field(50021; Comment; Text[1000])
        {
        }
        field(50022; "Surety Amount"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (Rec.Amount - Rec."Outstanding Balance") <= Rec."Surety Amount" then
                    Error('Surety amount exceeds Member BOSA Deposits Available Balance!');
                // if Rec."Outstanding Balance" > Rec."Surety Amount" then
                //     Error('You cannot be a surety because you have Loan %1.', "Outstanding Balance");
                begin
                    if Rec."Surety Amount" > Rec.Amount then
                        Error('Surety amount exceeds Member BOSA Deposits!');
                end;
            end;
        }
        field(50023; Posted; Boolean)
        {
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(71; "Created At"; DateTime)
        {
            //CaptionClass = '1,1,3';
            Caption = 'Created At';
        }
        field(72; "Created By"; Code[50])
        {
            // CaptionClass = '1,1,4';
            Caption = 'Created By';
        }
        field(73; "Responsibility Center"; Code[10])
        {
            // CaptionClass = '1,1,5';
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(74; Summary; Text[2048])
        {
            //CaptionClass = '1,1,6';
            Caption = 'Summary';
        }
        field(75; "Name of Case"; Text[200])
        {
            //CaptionClass = '1,1,7';
            Caption = 'Name of Case';
        }
        field(76; "Court Address"; CODE[50])
        {
            //CaptionClass = '1,1,8';
            Caption = 'Court Address';
        }
        field(77; "Court Physical Address"; CODE[50])
        {
            // CaptionClass = '1,1,9';
            Caption = 'Court Address 2';
        }
        field(88; Signatory; Option)
        {
            OptionMembers = " ","C.E.O","Company Secretary";
        }
        field(89; "BOSA Acc No."; Code[20])
        {
            Editable = false;
        }
        field(90; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(91; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(92; "Current Departmrnt"; Code[50])
        {
            Editable = false;
        }
        field(93; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(94; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(96; "BOSA A/c Status"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Surety No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Surety No" = '' then begin
            GenLedgerSetup.Get;
            NoSeriesMgt.InitSeries(GenLedgerSetup."Case Number", xRec."No. Series", 0D, "Surety No", "No. Series");
        end;

        "User ID" := UserId;
        "Created By" := userID;
        "Created At" := CurrentDateTime;
        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            "Current Departmrnt" := UserSetup."Responsibility Centre";
            
        end;
    end;

    var
        SavingsAccounts: Record "Savings Accounts";
        Emp: Record "HR Employees";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vend: Record Vendor;
        Cust: Record Customer;
        Memb: Record Members;
        Witn: Record Witnesses;
        HRCommittees: Record "HR Committees";
        Casetype: Record "Segment/County/Dividend/Signat";
        CreditAccount: Record "Credit Accounts";
        UserSetup: Record "User Setup";
        Loans: Record "Loans";
        GlobalFunctions: Codeunit "Global Functions";
        GlobalFunction: Codeunit "Global Functions";
}

