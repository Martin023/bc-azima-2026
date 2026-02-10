table 52187033 "General SMS Lines"
{
    Caption = 'General SMS Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }

        field(4; SMS; Text[1000])
        {
            Caption = 'SMS';
        }
        field(5; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(6; "Sent At"; DateTime)
        {
            Caption = 'Sent At';
        }

        field(8; "Phone Number"; Text[13])
        {

        }

        field(21; "Time Sent"; DateTime)
        {

        }
        field(22; "Sent By"; Code[50])
        {

        }

    }
    keys
    {
        // key(PK; "Entry No")
        // {
        //     Clustered = true;
        // }
        key(Key1; "Header No", SMS, "Phone Number")
        {

        }

    }
}
