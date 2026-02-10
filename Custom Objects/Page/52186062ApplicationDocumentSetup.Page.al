page 52186062 "Application Document Setup"
{
    CardPageID = "Application Doc. Setup Card";
    Editable = false;
    PageType = List;
    SourceTable = "Application Document Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control8; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control9; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

