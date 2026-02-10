page 52186715 "User Tasks"  
{
    PageType = List;
    InsertAllowed = true;
    SourceTable = "User Tasks";
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = Basic,Suite;

                }
                field("Record ID";Rec."Record ID")
                {
                    Editable = false;
                    ApplicationArea = Basic,Suite;
                }
                field(Department;Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Module";Rec."Sub Module")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("User ID";Rec."User ID")
                {
                    Editable = true;
                    ApplicationArea = Basic,Suite;
                }
                
                field("Entry Time";Rec."Entry Time")
                {
                    Editable = false;
                    ApplicationArea = Basic,Suite;
                }
                field("Supervisor ID";Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Last Modified By";Rec."Last Modified By")
                {
                    Editable = false;
                }
                field("Modified At";Rec."Modified At")
                {
                    Editable = false;
                }
            }
        }
    }
}