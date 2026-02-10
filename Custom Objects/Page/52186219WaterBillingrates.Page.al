page 52186219 "Water Billing rates"
{
    PageType = List;
    SourceTable = "Water Billing rate";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bill Rate tier"; Rec."Bill Rate tier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Tarrif"; Rec."Type of Tarrif")
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

