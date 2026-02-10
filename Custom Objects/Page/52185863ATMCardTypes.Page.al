page 52185863 "ATM Card Types"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "ATM Card Types";
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Charge Code"; Rec."Application Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Replacement Charge Code"; Rec."Replacement Charge Code")
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

