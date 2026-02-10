page 52185619 "prStaff Dimensions"
{
    PageType = List;
    SourceTable = "prStaff Dimensions";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Dimension 0"; Rec."Dimension 0")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 1"; Rec."Dimension 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 3"; Rec."Dimension 3")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 4"; Rec."Dimension 4")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 5"; Rec."Dimension 5")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
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

