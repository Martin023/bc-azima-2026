#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185677 pageextension52185677 extends "Apply Bank Acc. Ledger Entries"
{

    layout
    {
        modify(LineApplied)
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        moveafter("Debit Amount"; "Credit Amount")
        modify("Debit Amount")
        {
            ApplicationArea = Basic;

            Editable = false;
            Visible = true;
        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;

            Editable = false;
            Visible = true;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Positive)
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Check Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify(Control15)
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify(CheckBalance)
        {
            ApplicationArea = Basic;
        }
        modify(BalanceToReconcile)
        {
            ApplicationArea = Basic;
        }
        modify("Statement Status")
        {
            Visible = false;
        }
        modify("Statement No.")
        {
            Visible = false;
        }
        modify("Statement Line No.")
        {
            Visible = false;
        }

        addafter("Document No.")
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Posting Date")
        {
            field("Value Date"; rec."Value Date")
            {
                ApplicationArea = Basic;
            }
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
            Caption = 'External Doc/Cheque No.';
        }
        moveafter("Document No."; "External Document No.")
        moveafter("External Document No."; "Debit Amount")
        moveafter(Amount; "Remaining Amount")
        addafter("Remaining Amount")
        {
            field(RunningBalance; CalcRunningAccBalance.GetBankAccBalance(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Running Balance';
                ToolTip = 'Specifies the running balance.';
                AutoFormatExpression = Rec."Currency Code";
                AutoFormatType = 1;
            }

            field("User ID"; Rec."User ID")
            {
                ApplicationArea = Basic;
            }
        }
    }


    procedure SetDateFilter(StatementDate: Date)
    begin
        Rec.SetFilter(Rec."Posting Date", '<=%1', StatementDate);
        CurrPage.Update;
    end;

    var
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";

}
