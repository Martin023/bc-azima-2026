table 52186257 "Contract Templates Lines"
{
    Caption = 'Contract Templates Lines';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Template No."; Code[50])
        {
            Caption = 'Template No.';
        }
        field(2; Body; Text[2048])
        {
            Caption = 'Body';
        }
        field(3; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Clause"; Text[100])
        {
            Caption = 'Clause';
        }
    }
    keys
    {
        key(PK; "No.", "Template No.")
        {
            Clustered = true;
        }
    }
}
