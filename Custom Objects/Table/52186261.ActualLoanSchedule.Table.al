table 52186261 "Actual Loan Schedule"
{
    Caption = 'Actual Loan Schedule';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
        }
        field(2; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
        }
        field(3; "Interest Payments"; Decimal)
        {
            Caption = 'Interest Payments';
        }
        field(4; "Principle Payments"; Decimal)
        {
            Caption = 'Principle Payments';
        }
        field(5; "Total Actual Repayment"; Decimal)
        {
            Caption = 'Total Actual Repayment';
        }
        field(6; "Principle Balance"; Decimal)
        {
            Caption = 'Principle Balance';
        }
        field(7; "P + I Balance"; Decimal)
        {
            Caption = 'P + I Balance';
        }
        field(8; "P + Future Interest"; Decimal)
        {
            Caption = 'P + Future Interest';
        }
        field(9; "Loan Number"; Code[100])
        {

        }
        field(10; "I Balance"; Code[100])
        {

        }
        field(11; "Schedule Position"; Option)
        {
            OptionMembers = Current,Future,Overdue;
        }
        field(12; "Expected Interest"; Decimal)
        {
            
        }
        field(13; "Expected Principle"; Decimal)
        {
            
        }
    }
    keys
    {
        key(PK; "No.","Loan Number")
        {
            Clustered = true;
        }
    }
}
