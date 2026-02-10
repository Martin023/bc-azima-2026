page 52186646 "Dependancies Applications List"
{
    CardPageID = "Dependancies Applications Card";
    // DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dependancies Applications";
    SourceTableView = WHERE(Status = FILTER(Open));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Application"; Rec."Source Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer";Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID";Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No.";Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        //Rec.SetFilter("Responsible Officer",UserId);
    end;
}

