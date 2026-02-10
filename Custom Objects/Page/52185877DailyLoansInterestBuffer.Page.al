page 52185877 "Daily Loans Interest Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Daily Loans Interest Buffer";
    ApplicationArea = Basic, Suite;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product type"; Rec."Loan Product type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ProductName; ProductName)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
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
        area(creation)
        {
            group(Action19)
            {
                action("Generate Daily Interest")
                {
                    ApplicationArea = Basic, Suite;
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    // trigger OnAction()
                    // begin
                    //     PeriodicActivities.GenerateDailyInterest(Rec);
                    // end;
                }
                separator(Action17)
                {
                }
                action("Generate Daily Interest 2")
                {
                    ApplicationArea = Basic, Suite;
                    //RunObject = Report "Compute Daily Interest";
                }
            }
        }
    }

    var
        PeriodicActivities: Codeunit "Periodic Activities";
        ProductName: Text;
        ProducFac: Record "Product Factory";

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if ProducFac.Get(Rec."Loan Product type") then begin
            ProductName := ProducFac."Product Description";
        end;
    end;
}

