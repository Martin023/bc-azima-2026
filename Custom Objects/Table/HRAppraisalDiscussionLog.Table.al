table 52185504 "HR Appraisal Discussion Log"
{
    Caption = 'HR Appraisal Discussion Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[50])
        {
            TableRelation = "HR Individual Targets Header"."Appraisal No";
        }
        field(3; "Discussion Date"; Date)
        {
        }
        field(4; "Discussion Time"; Time)
        {
        }
        field(5; "Discussion Point"; Text[250])
        {
        }
        field(6; "Point Category"; Option)
        {
            OptionMembers = " ",Target,Rating,Performance,Other;
            OptionCaption = ' ,Target,Rating,Performance,Other';
        }
        field(7; "Raised By"; Option)
        {
            OptionMembers = Appraisee,Appraiser;
            OptionCaption = 'Appraisee,Appraiser';
        }
        field(8; "Raised By User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(9; "Response"; Text[250])
        {
        }
        field(10; "Response By"; Option)
        {
            OptionMembers = " ",Appraisee,Appraiser;
            OptionCaption = ' ,Appraisee,Appraiser';
        }
        field(11; "Response By User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(12; "Response Date"; Date)
        {
        }
        field(13; Resolved; Boolean)
        {
        }
        field(14; "Resolution Notes"; Text[250])
        {
        }
        field(15; "Target Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No")
        {
            Clustered = true;
        }
        key(Key2; "Appraisal No", Resolved)
        {
        }
    }

    fieldgroups
    {
    }
}