table 52187027 "ATM Card Table"
{
    Caption = 'ATM Card Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ATM No."; Code[50])
        {
            Caption = 'ATM No.';
            Editable = false;
        }
        field(2; "Account No."; Code[50])
        {
            Caption = 'Account No.';
            Editable = false;
        }
        field(3; "Card Type"; Code[10])
        {
            TableRelation = "ATM Card Types".Code;
            Editable = false;
        }
        field(4; "Date Linked"; Date)
        {
            Caption = 'Date Linked';
            Editable = false;
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
        }
    }
    keys
    {
    }

}
