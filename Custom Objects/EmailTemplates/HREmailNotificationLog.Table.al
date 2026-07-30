table 52185857 "HR Email Notification Log"
{
    Caption = 'HR Email Notification Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
        }
        field(3; "Recipient Role"; Option)
        {
            Caption = 'Recipient Role';
            OptionCaption = 'Applicant,Reliever,Supervisor,HOD,CEO,Custom';
            OptionMembers = Applicant,Reliever,Supervisor,HOD,CEO,Custom;
        }
        field(4; "Sent To"; Text[100])
        {
            Caption = 'Sent To';
        }
        field(5; "Source Document No."; Code[50])
        {
            Caption = 'Source Document No.';
        }
        field(6; "Sent Date"; Date)
        {
            Caption = 'Sent Date';
        }
        field(7; "Sent Time"; Time)
        {
            Caption = 'Sent Time';
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Sent,Failed';
            OptionMembers = Sent,Failed;
        }
        field(9; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
        }
        field(10; "Subject Sent"; Text[250])
        {
            Caption = 'Subject Sent';
        }
        field(11; "Sent By"; Code[100])
        {
            Caption = 'Sent By';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Event Code", "Sent Date")
        {
        }
        key(Key3; "Source Document No.", "Sent Date")
        {
        }
    }
}
