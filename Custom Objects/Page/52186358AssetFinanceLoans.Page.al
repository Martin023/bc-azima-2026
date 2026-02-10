page 52186358 "Asset Finance Loans"
{
    PageType = List;
    SourceTable = "Asset Finance Loan";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Affects 2/3 Rule"; Rec."Affects 2/3 Rule")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Deduction"; Rec."Monthly Deduction")
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

