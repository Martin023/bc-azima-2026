table 52186795 "Loan Recovery Lines II"
{
    Caption = 'Loan Recovery Lines';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Recovery Lines II";
    LookupPageId = "Loan Recovery Lines II";

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
            trigger OnValidate()
            begin
                if Members.Get("Member No.") then begin
                    "Member Name" := Members.Name;
                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Member No.", Members."No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.FindFirst() then begin
                        "Account No." := SavingsAccounts."No.";
                    end;
                end;

                if LoanRecoveryHeader.Get("Header No.") then begin
                    LoanRecoveryHeader.TestField("Loan No.");
                    "Attached Loan Number" := LoanRecoveryHeader."Loan No.";
                end;
            end;
        }
        field(6; "Member Name"; Text[100])
        {

        }
        field(7; "Loan No."; Code[30])
        {
            TableRelation = Loans."Loan No." where("Member No." = field("Member No."));
            Caption = 'Guarantor Loan No.';
            trigger OnValidate()
            var
                Loans: Record Loans;
                RecoveryHeader: Record "Loan Recovery Header";
            begin
                if Loans.Get("Loan No.") then begin
                    RecoveryHeader.GetLoanBalances("Loan No.","Opening Interest Balance", "Opening Principle Balance","Opening Loan Balance");
                end;
            end;
        }

        field(8; Reversed; Boolean)
        {

        }
        field(9; "Attached Loan Number"; Code[30])
        {
            Description = 'This is the loan that the guarantor was attached but they are not paying well';
        }
        field(10; "Attached Loan Balance"; Decimal)
        {
            Description = 'This is balance of the loan that the guarantor was attached but they are not paying well';
            DecimalPlaces = 2;

        }
        field(11; "Attached Loan Category"; Enum "Loan Sasra categories")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SASRA Categorization"."Loans Category-SASRA" where("Loan No." = field("Attached Loan Number")));
        }
        field(14; "Original Attached Amount"; Decimal)
        {

        }
        field(12; "Opening Interest Balance"; Decimal)
        {
            Description = 'This is the recoverable interest of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
            trigger OnValidate()
            begin
                "Opening Loan Balance" := "Opening Interest Balance"+"Opening Principle Balance";
            end;
        }
        field(13; "Opening Principle Balance"; Decimal)
        {
            Description = 'This is the recoverable principle of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
            trigger OnValidate()
            begin
                "Opening Loan Balance" := "Opening Interest Balance"+"Opening Principle Balance";
            end;
        }

        field(15; "Opening Loan Balance"; Decimal)
        {

        }
        field(16; "Interest Amount"; Decimal)
        {
            Description = 'This is the recoverable interest of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
        }
        field(17; "Principle Amount"; Decimal)
        {
            Description = 'This is the recoverable principle of the prorated deposits amount and guarantor loan';
            DecimalPlaces = 2;
        }
        
        
    }

    keys
    {
        key(PK; "Header No.", "Account No.", "Recovery Type", "Attached Loan Number")
        {
            Clustered = true;
        }
    }
    var
        Members: Record members;
        SavingsAccounts: Record "Savings Accounts";
        LoanRecoveryHeader: Record "Loan Recovery Header II";
}
