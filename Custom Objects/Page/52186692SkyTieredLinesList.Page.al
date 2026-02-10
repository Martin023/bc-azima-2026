page 52186692 "Sky Tiered Lines List"
{
    PageType = ListPart;
    SourceTable = "Sky Mobile Tiered Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage (Sacco)"; Rec."Use Percentage (Sacco)")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage (Sacco)"; Rec."Percentage (Sacco)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage (Vendor)"; Rec."Use Percentage (Vendor)")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage (Vendor)"; Rec."Percentage (Vendor)")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Charge"; Rec."Sacco Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Charge"; Rec."Vendor Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Band Active"; Rec."Band Active")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

