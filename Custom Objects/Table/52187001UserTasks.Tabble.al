table 52187001 "User Tasks"
{
    fields{
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "User ID"; code[50])
        { 
            Editable = true;
            //TableRelation = "Present Users"."User ID" where("Supervisor ID" = field("Supervisor ID"));
            TableRelation = "Present Users"."No.";

            trigger OnValidate()
            var
                PresentUsers: Record "Present Users";
            begin
                
                if UserId <> "Supervisor ID" then Error('Only the supervisor %1 can make this change',"Supervisor ID");

                if PresentUsers.Get("User ID") then
                "User ID" := PresentUsers."User ID";

                Rec."Last Modified By" := "User ID";
                Rec."Modified At" := CurrentDateTime;
            end;
        }
        field(3; "Entry Time"; DateTime)
        {
            Editable = false;
        }

        field(4; Department; enum "Responsibility Center Enum")
        {
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        
        field(5; "Sub Module"; enum "Sub Module")
        {
            Editable= false;
        }

        field(6; "Record ID"; Code[30])
        {
            Editable = false;
        }

        field(7; "Last Modified By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Modified At"; DateTime)
        {
            Editable = false;
        }
        field(9; "Supervisor ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(10; Digit; Integer)
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "No.","Record ID")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID","Supervisor ID")
        {

        }
    }

}