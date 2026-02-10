page 52185698 "Agent Tarriff Details"
{
    PageType = List;
    SourceTable = "Agent Tariff Details";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Comm"; Rec."Agent Comm")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Comm"; Rec."Vendor Comm")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco Comm"; Rec."Sacco Comm")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
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

