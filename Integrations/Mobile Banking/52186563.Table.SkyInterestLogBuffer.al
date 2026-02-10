table 52186563 "Sky Interest Log Buffer"
{
    Caption = 'Sky Interest Log Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Credit Ledger Entry No."; Integer)
        {
            Caption = 'Credit Ledger Entry No.';
        }
        field(3; "Is Processed?"; Boolean)
        {
            Caption = 'Is Processed?';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
