table 52185811 "Loan FIle Upload"
{
    Caption = 'Loan FIle Upload';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(2; "Loan File Name"; Text[100])
        {
            Caption = 'Loan File Name';
        }
        field(3; "File"; Blob)
        {
            Caption = 'File';
        }
    }
    keys
    {
        key(PK; "Loan No")
        {
            Clustered = true;
        }
    }
}
