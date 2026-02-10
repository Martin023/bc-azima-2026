page 52185907 "Procurement Type"
{
    PageType = List;
    SourceTable = "Procurement Limit Code";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Procurement Code"; Rec."Procurement Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Amount Type"; Rec."Procurement Amount Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max Amount"; Rec."Max Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Amount"; Rec."Fixed Amount")
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

