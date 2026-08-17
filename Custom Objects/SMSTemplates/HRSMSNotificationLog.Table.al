table 52185921 "HR SMS Notification Log"
{
    Caption = 'HR SMS Notification Log';
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
        field(4; "Sent To"; Text[20])
        {
            Caption = 'Phone No.';
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
            OptionCaption = 'Sent,Failed,Retry Succeeded,Retry Failed,Resent';
            OptionMembers = Sent,Failed,"Retry Succeeded","Retry Failed",Resent;
        }
        field(9; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
        }
        field(10; "Message Sent"; Text[320])
        {
            Caption = 'Message Sent';
        }
        field(11; "Sent By"; Code[100])
        {
            Caption = 'Sent By';
        }
        field(12; "Token Values"; Text[2048])
        {
            Caption = 'Token Values';
            // STORED AT SEND TIME — USED BY RETRY AND RESEND TO RE-RESOLVE THE BODY
        }
        field(13; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
        }
        field(14; "Last Retry DateTime"; DateTime)
        {
            Caption = 'Last Retry';
        }
        field(15; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
            // LINKS RETRY/RESEND ENTRIES BACK TO THE ORIGINATING ENTRY. 0 ON ORIGINALS.
        }
        field(16; "Is Retry"; Boolean)
        {
            Caption = 'Is Retry';
        }
        field(17; "Is Resend"; Boolean)
        {
            Caption = 'Is Resend';
        }
        field(18; "Is CC"; Boolean)
        {
            Caption = 'Is CC';
            DataClassification = CustomerContent;
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
        key(Key4; "Parent Entry No.")
        {
        }
    }
}
