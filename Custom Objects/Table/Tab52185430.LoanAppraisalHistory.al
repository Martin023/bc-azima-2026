table 52185430 "Loan Appraisal History"
{
    Caption = 'Loan Appraisal History';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(2; "Appraisal form"; Blob)
        {
            Caption = 'Appraisal form';
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
