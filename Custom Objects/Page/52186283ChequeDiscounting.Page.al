page 52186283 "Cheque Discounting"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Cashier Transactions";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Discounting Amount"; Rec."Discounting Amount")
                {
                    Caption = 'Discounting Amount';
                }
                field("Discounted Amount"; Rec."Discounted Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Cheque Discounting")
            {
                ApplicationArea = Basic, Suite;
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin
                    SaccoT.ChequeDiscounting(Rec);
                end;
            }
        }
    }

    var
        DiscountingAmount: Decimal;
}

