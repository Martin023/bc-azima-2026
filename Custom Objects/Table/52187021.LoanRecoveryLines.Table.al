table 52187021 "Loan Recovery Lines"
{
    Caption = 'Loan Recovery Lines';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Recovery Lines";
    LookupPageId = "Loan Recovery Lines";
    
    

    fields
    {
        field(1; "Header No."; Code[30])
        {
            Caption = 'Header No.';
        }
        field(2; "Account No."; Code[30])
        {
            Caption = 'Account No.';
            TableRelation = "Savings Accounts"."No.";
            trigger OnValidate()
            var
                SavingsAccount: Record "Savings Accounts";
            begin
                if SavingsAccount.Get("Account No.") then begin
                    "Member No." := SavingsAccount."Member No.";
                    "Member Name" := SavingsAccount.Name;
                end;
            end;
        }
        field(3; "Recovery Type"; Option)
        {
            Caption = 'Recovery Type';
            OptionMembers = "Guarantor Attachment","Deposits Recovery","Attached Loan Recovery";
        }
        field(4; "Recovery Amount"; Decimal)
        {
            Caption = 'Recovery Amount';
            DecimalPlaces = 2;
        }

        field(5; "Member No."; Code[30])
        {
            TableRelation = Members."No.";
        }
        field(6; "Member Name"; Text[100])
        {

        }
        field(7; "Loan No."; Code[30])
        {
            Caption = 'Guarantor Loan No.';
        }

        field(8; Reversed; Boolean)
        {

        }
        field(9; "Attached Loan Number"; Code[30])
        {
            Editable = false;
            Description = 'This is the loan that the guarantor was attached but they are not paying well';
        }
        field(10; "Attached Loan Balance"; Decimal)
        {
            Editable = false;
            Description = 'This is balance of the loan that the guarantor was attached but they are not paying well';
            DecimalPlaces = 2;

        }
        field(11; "Attached Loan Category"; Enum "Loan Sasra categories")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SASRA Categorization"."Loans Category-SASRA" where("Loan No." = field("Attached Loan Number")));
        }

        field(12; "Interest Amount"; Decimal)
        {
            Editable = false;
            Description = 'This is the recoverable interest of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
        }
        field(13; "Principle Amount"; Decimal)
        {
            Editable = false;
            Description = 'This is the recoverable principle of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
        }
        
    }

    keys
    {
        key(PK; "Header No.", "Account No.","Recovery Type","Attached Loan Number")
        {
            Clustered = true;
        }
    }
}
