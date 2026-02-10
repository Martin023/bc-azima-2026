page 52186042 "Destination Rate List"
{
    CardPageID = "Destination Rates Card";
    PageType = List;
    SourceTable = "Destination Rate Entry";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Job Group"; Rec."Employee Job Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advance Code"; Rec."Advance Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Daily Rate (Amount)"; Rec."Daily Rate (Amount)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Name"; Rec."Destination Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control14; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

