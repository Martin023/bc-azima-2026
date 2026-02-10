table 52187020 "Loan Reapotionment Lines"
{
    Caption = 'Loan Reapotionment Lines';
    DataClassification = ToBeClassified;
    LookupPageId = "Loan Reappotionment Lines";
    DrillDownPageId = "Loan Reappotionment Lines";
    
    fields
    {
        field(1; "Header No."; Code[30])
        {
            Caption = 'Header No.';
        }
        field(2; "Guarantor Loan No."; Code[30])
        {
            Caption = 'Guarantor Loan No.';
        }
        field(3; "Defaulter Loan No."; Code[30])
        {
            Caption = 'Defaulter Loan No.';
        }
        field(4; "Guarantor Member No."; Code[30])
        {
            Caption = 'Guarantor Member No.';
        }
        field(5; "Guarantor Name"; Text[100])
        {
            Caption = 'Guarantor Name';
        }
        field(6; "Appotionment Amount"; Decimal)
        {
            Caption = 'Appotionment Amount';
        }
        field(7; Reversed; Boolean)
        {
            
        }
        field(8; "BOSA Account No."; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";

        }
        field(9; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(10; "Money To FOSA"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 2;
        }
        field(20; "Interest Portion"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 2;
        }
        field(21; "Principle Portion"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 2;
        }
        field(22; "Innitial Attachment Amount"; Decimal)
        {
            Editable = false;
        }

        }
    keys
    {
        key(PK; "Header No.","Guarantor Loan No.")
        {
            Clustered = true;
        }
    }
}
