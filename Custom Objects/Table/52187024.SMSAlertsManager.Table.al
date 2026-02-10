table 52187024 "SMS Alerts Manager"
{
    Caption = 'SMS Alerts Manager';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Loan Number"; Code[30])
        {
            Caption = 'Loan Number';
        }
        field(2; "Days In Default"; Integer)
        {
            Caption = 'Days In Default';
        }
        field(3; "Last Alert Date"; Date)
        {
            
        }
        field(4; "Guarantor Alert Date"; Date)
        {

        }
        field(5; "CRB Alert Date"; Date)
        {

        }

        field(6; "Attachment Candidate"; Boolean)
        {

        }

        field(7; "CRB Candidate"; Boolean)
        {
            
        }

        field(8; "CRB Listing Date"; DateTime)
        {

        }
    }
    keys
    {
        key(PK; "Loan Number")
        {
            Clustered = true;
        }
    }
}
