page 52186035 "Contract Cycle Activities"
{
    PageType = List;
    SourceTable = "Contract Cycle Stage";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Cycle Code"; Rec."Sales Cycle Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Completed %"; Rec."Completed %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Quote Required"; Rec."Quote Required")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Skip"; Rec."Allow Skip")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Estimated Value (LCY)"; Rec."Estimated Value (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Calcd. Current Value (LCY)"; Rec."Calcd. Current Value (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Average No. of Days"; Rec."Average No. of Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Formula"; Rec."Date Formula")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Line Type"; Rec."Contract Line Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Expected"; Rec."Payment Expected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("%age of Payment"; Rec."%age of Payment")
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

