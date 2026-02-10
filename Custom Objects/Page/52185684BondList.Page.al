page 52185684 "Bond List"
{
    CardPageID = "Bond Card";
    Editable = false;
    PageType = List;
    SourceTable = Bond;
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bond No."; Rec."Bond No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Type"; Rec."Bond Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

