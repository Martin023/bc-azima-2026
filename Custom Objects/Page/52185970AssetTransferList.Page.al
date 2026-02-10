page 52185970 "Asset Transfer List"
{
    CardPageID = "Asset Transfer";
    
    PageType = List;
    SourceTable = "Asset Transfer";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Asset to Transfer"; Rec."Asset to Transfer")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("From Location"; Rec."From Location")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("From Responsible Employee"; Rec."From Responsible Employee")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("To Location"; Rec."To Location")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("To Responsible Employee"; Rec."To Responsible Employee")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Transferred; Rec.Transferred)
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

