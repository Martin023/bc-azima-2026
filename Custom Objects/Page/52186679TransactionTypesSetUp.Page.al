page 52186679 "Transaction Types SetUp"
{
    PageType = List;
    SourceTable = "Transaction Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    CardPageId = "Transactions Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Mode"; Rec."Default Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires Finger Verification"; Rec."Requires Finger Verification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
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

