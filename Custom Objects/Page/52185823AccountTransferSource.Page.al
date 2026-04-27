page 52185823 "Account Transfer Source"
{
    PageType = ListPart;
    SourceTable = "Account Transfer Source";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                FreezeColumn = "Source Account Name";
                ShowCaption = false;
                // field("No."; Rec."No.")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic, Suite;
                // }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    Caption = 'Account Type';
                    ApplicationArea = Basic, Suite;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    Caption = 'Account No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;                    
                }
                // field("External Document No."; Rec."External Document No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    Caption = 'Account Name';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    Caption = 'Transaction Type';
                    ApplicationArea = Basic, Suite;
                }
                field("Source Loan No."; Rec."Source Loan No.")
                {
                    Caption = 'Loan No.';
                    ApplicationArea = Basic, Suite;
                }
                // field("Fixed Deposit Contract"; Rec."Fixed Deposit Contract")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Fixed Deposit Contract';
                // }
                field("Description"; Rec."Source Description")
                {
                    Caption = 'Description';
                    ApplicationArea = Basic, Suite;
                }
                field("Source Amount"; Rec."Source Amount")
                {
                    Caption = 'Source Amount';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

