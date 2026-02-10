page 52185967 "Payment Mode Charges"
{
    PageType = List;
    SourceTable = "Payment Mode Charges";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Mode Type"; Rec."Payment Mode Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Min."; Rec."Amount Min.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Max."; Rec."Amount Max.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Account"; Rec."Posting Account")
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

