#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

Table 52185648 "Control Summary Buffer"
{
    TableType = Temporary;
    
    fields
    {
        field(1; "Account Type"; Option)
        {
            OptionMembers = "G/L Account","Savings","Loan","Bank Account";
        }
        field(2; "Account No."; Code[50]) { }
        field(3; "Account Name"; Text[100]) { }
        field(4; "Short Code"; Code[50]) { }
        field(5; "Records"; Integer) { }
        field(6; "Opening Balance"; Decimal) { }
        field(7; "Debit Amt"; Decimal) { }
        field(8; "Credit Amt"; Decimal) { }
        field(9; "Closing Balance"; Decimal) { }
    }

    keys
    {
        key(Key1; "Account Type", "Account No.")
        {
            Clustered = true;
        }
    }
}