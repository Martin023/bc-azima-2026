page 52185707 EDMS
{
    PageType = List;
    SourceTable = EDMS;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Key"; Rec.Key)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("url path"; Rec."url path")
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
            systempart(Control8; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

