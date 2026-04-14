table 52187153 "Loan FallOff"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Batch No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "National ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Expected Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Principle Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Last Paid Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Variance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Outstanding Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Days In Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Loan Department"; Enum "Source Unit")
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Member Status"; Enum "Member Status")
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Member Sub Status"; Enum "Member Status Sub Flags")
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Product Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Monthly Expected Principle"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Monthly Expected Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Last Paid Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Total Capital AmountPaid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Total Interest Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Future Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "P Plus I Future"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Remaining Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Installments FallOff"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Day Last Paid"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Amount In Arreas SACCO"; Decimal)
        {

        }
        field(36; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {

        }
        field(37; "Total Monthly Expected"; Decimal)
        {

        }
        field(38; "Branch Code"; Code[20])
        {
             
        }

        field(50; "Generate By"; Code[100])
        {

        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Generate By" := UserId;
    end;
}
