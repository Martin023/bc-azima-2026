table 52185459 "Dormancy Log"
{
    Caption = 'Dormancy Log';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Account No"; Code[100])
        {
            Caption = 'Account No';
        }
        field(3; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
        }
        field(4; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
        }
        field(5; "Entered By"; Code[100])
        {
            Caption = 'Entered By';
        }
        field(6; Status; Text[100])
        {
            Caption = 'Status';
        }
        field(7; "Sub Status"; Text[100])
        {
            Caption = 'Sub Status';
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
