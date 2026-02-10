table 52186254 "Loans Daily Interest"
{
    Caption = 'Loans Daily Interest';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; "Interest Date"; Date)
        {
            Caption = 'Interest Date';
        }
        field(3; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
        }
        field(4; "Entered By"; Code[50])
        {
            Caption = 'Entered By';
        }
        field(5; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(6; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(7; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(8; "Source Unit"; Code[20])
        {
            Caption = 'Source Unit';
        }
    }
    keys
    {
        key(PK; "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
    }
}
