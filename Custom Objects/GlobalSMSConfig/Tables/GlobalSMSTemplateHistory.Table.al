table 52185955 "Global SMS Template History"
{
    Caption = 'Global SMS Template History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(2; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
            TableRelation = "Global SMS Template"."Event Code";
        }

        field(3; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }

        field(4; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
        }

        field(5; Action; Option)
        {
            Caption = 'Action';
            OptionMembers = Created,Modified,Enabled,Disabled,TokenAdded,TokenModified;
            OptionCaption = 'Created,Modified,Enabled,Disabled,Token Added,Token Modified';
            DataClassification = CustomerContent;
        }

        field(6; "Old Value"; Text[500])
        {
            Caption = 'Old Value';
            DataClassification = CustomerContent;
        }

        field(7; "New Value"; Text[500])
        {
            Caption = 'New Value';
            DataClassification = CustomerContent;
        }

        field(8; "Change Reason"; Text[250])
        {
            Caption = 'Change Reason';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(EventCode; "Event Code", "Modified Date")
        {
        }
    }
}
