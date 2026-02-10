page 52186402 "Business Incomes"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Business Income";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("First Day of Current Month"; Rec."First Day of Current Month")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Month Narration."; Rec."Month Narration.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Credits (Internal)"; Rec."Total Credits (Internal)")
                {
                    Caption = 'Average Income';
                    ApplicationArea = Basic, Suite;
                }
                field("Total Debits (Internal)"; Rec."Total Debits (Internal)")
                {
                    Caption = 'Average Expenses.';
                    ApplicationArea = Basic, Suite;
                }
                // field("Average Amount (Internal)"; Rec."Average Amount (Internal)")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Average Amount (External)"; Rec."Average Amount (External)")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }

    actions
    {
    }
}

