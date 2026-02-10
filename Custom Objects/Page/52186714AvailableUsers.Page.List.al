page 52186714 "Present Users"  
{
    PageType = List;
    Editable = true;
    InsertAllowed = true;
    SourceTable = "Present Users";
    DeleteAllowed = false;
    UsageCategory = Lists;
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
                field(Department;Rec.Department)
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Module";Rec."Sub Module")
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                }
                field("User ID";Rec."User ID")
                {
                    Editable = true;
                    ApplicationArea = Basic,Suite;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {

                }
                field("User Active";Rec."User Active")
                {
                    Editable = false;
                    
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Activate)
            {
                PromotedCategory = Process;
                Promoted = true;
                Image = ActivateDiscounts;
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to activate this entry, note this action can oly be reversed by system edits') then exit;
                    Rec."User Active" := true;
                    Rec.Sealed := true;
                    Rec.Modify();
                    Message('Activated successfully');
                end;

            }

            action(Modify)
            {
                ApplicationArea = All;
            }

            action(Delete)
            {
                ApplicationArea = All;
            }
        }
    }

}