page 52185640 "prEmployer Deductions"
{
    Editable = false;
    PageType = List;
    SourceTable = "prEmployer Deductions";
    ModifyAllowed = false;
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
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll Code"; Rec."Payroll Code")
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

