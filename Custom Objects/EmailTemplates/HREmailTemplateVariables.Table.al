table 52185902 "HR Email Template Variables"
{
    Caption = 'HR Email Template Variables';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            TableRelation = "HR Email Template"."Event Code";
            NotBlank = true;
        }
        field(2; Placeholder; Code[10])
        {
            Caption = 'Placeholder';
            NotBlank = true;
        }
        field(3; "Variable Name"; Text[100])
        {
            Caption = 'Variable Name';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Event Code", Placeholder)
        {
            Clustered = true;
        }
    }
}
