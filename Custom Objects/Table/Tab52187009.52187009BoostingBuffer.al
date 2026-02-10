table 52187009 "52187009 Boosting Buffer"
{
    Caption = '52187009 Boosting Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
        }
        field(4; "Expected Amount"; Decimal)
        {
            Caption = 'Expected Amount';
        }
        field(5; "Boosted Amount"; Decimal)
        {
            Caption = 'Boosted Amount';
        }
        field(6; Commission; Decimal)
        {
            Caption = 'Commission';
        }
        field(7; "Total Current"; Decimal)
        {
            Caption = 'Total Current';
        }
        field(8; "Total Expected"; Decimal)
        {
            Caption = 'Total Expected';
        }
    }
    keys
    {
        key(PK; "Loan No.")
        {
            Clustered = true;
        }
    }
}
