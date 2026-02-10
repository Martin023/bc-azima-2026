page 52185632 "prPayroll Type"
{
    PageType = List;
    SourceTable = "prPayroll Type";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll Name"; Rec."Payroll Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Length"; Rec."Period Length")
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

