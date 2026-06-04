page 52185736 "Dividend Posting Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Dividend Posting Buffer";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type Name"; Rec."Product Type Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    // actions
    // {
    //     area(creation)
    //     {
    //         // action("Dividend Process")
    //         // {
    //         //     Caption = 'Generate Dividends';
    //         //     ApplicationArea = Basic, Suite;
    //         //     Image = Add;
    //         //     Promoted = true;
    //         //     PromotedCategory = Process;
    //         //     RunObject = report "Dividend Generation";
    //         // }

            
    //     }
    // }
}

