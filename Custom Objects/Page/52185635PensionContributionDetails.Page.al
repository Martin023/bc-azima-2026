page 52185635 "Pension Contribution Details"
{
    PageType = List;
    SourceTable = "prPension Details";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Inception Date"; Rec."Inception Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pension Number"; Rec."Pension Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Code"; Rec."Transaction Code")
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

