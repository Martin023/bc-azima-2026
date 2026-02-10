page 52186598 "HR Bank Accounts List"
{
    PageType = List;
    SourceTable = "HR Employee Bank Accounts";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank  Code"; Rec."Bank  Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("A/C  Number"; Rec."A/C  Number")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage to Transfer"; Rec."Percentage to Transfer")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Outlook)
            {
            }
            systempart(Control11; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

