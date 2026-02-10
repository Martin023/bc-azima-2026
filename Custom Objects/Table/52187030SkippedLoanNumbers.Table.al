table 52187030 "Skipped Loans"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[50])
        {
            Editable = false;
        }
        field(2; "Loan No."; Code[50])
        {
            TableRelation = Loans."Loan No.";
            
        }
        field(3; "Present Header No."; Code[50])
        {
            TableRelation = "SMS Alerts Header";
            Editable = false;
        } 
    }
    keys
    {
        key(Key1; "Header No.", "Loan No.")
        {

        }
    }
}
