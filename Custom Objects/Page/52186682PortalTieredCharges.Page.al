page 52186682 "Portal Tiered Charges"
{
    PageType = ListPart;
    SourceTable = "Portal Tiered Charges";

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
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Vendor Charge"; Rec."External Vendor Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Vendor Charge"; Rec."Mobile Vendor Charge")
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

