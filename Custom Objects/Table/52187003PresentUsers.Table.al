table 52187003 "Present Users"
{
    LookupPageId = "Present Users";
    DrillDownPageId = "Present Users";
    fields
    {
        field(1; "No."; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            
        }
        field(3; Department; Enum "Responsibility Center Enum")
        {

        }
        field(4; "Sub Module"; Enum "Sub Module")
        {

        }
        field(5; "Supervisor ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(6; "User Active"; Boolean)
        {
            Editable = false;
        }
        field(7; "Sealed"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {

        }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "User ID", "Supervisor ID")
        {

        }
    }

    trigger OnDelete()
    begin
        if Sealed then Error('To delete this entry, you need to deactivate the user through system edits, filter %1', "No.");
    end;

    


}