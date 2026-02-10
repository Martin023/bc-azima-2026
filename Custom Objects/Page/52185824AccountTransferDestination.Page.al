page 52185824 "Account Transfer Destination"
{
    PageType = ListPart;
    SourceTable = "Account Transfer Destination";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                FreezeColumn = "Destination Account Name";
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Type';
                }
                field("Destination Loan No."; Rec."Destination Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan No.';
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("External Document No."; Rec."External Document No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'External Document No.';
                // }
                // field("Fixed Deposit Contract"; Rec."Fixed Deposit Contract")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Fixed Deposit Contract';
                // }
                field("Destination Account Balance"; Rec."Destination Account Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Balance';
                }

                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Account Name';
                }
                field("Destination Transaction Type"; Rec."Destination Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Type';
                }
                // field("Destination Loan No."; Rec."Destination Loan No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Loan No.';
                // }
                field("Destination Amount"; Rec."Destination Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Destination Amount';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1000000002)
            {
                action("Import Bulk Refunds")
                {
                    Image = ImportExcel;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;
                    ////RunObject = XMLport XMLport39005557;

                    trigger OnAction()
                    begin
                        /////ghhghghghg
                    end;
                }
                action("Print Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print';
                    //RunObject = Report Report39006045;
                }
            }
        }
    }

    var
        SavAcc: Record "Savings Accounts";
        CredAcc: Record "Credit Accounts";
    // SavAccPage: Page "Savings Account List";
}

