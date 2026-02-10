#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185676 pageextension52185676 extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        modify("Transaction Date")
        {
            ApplicationArea = Basic;
        }
        modify("Value Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Check No.")
        {
            ApplicationArea = Basic;
        }
        addafter("Statement Amount")
        {
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Debit Amount';
                ToolTip = 'Debit Amount';
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Amount';
                ToolTip = 'Credit Amount';
            }
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Statement Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Difference)
        {
            ApplicationArea = Basic;
        }
        modify("Applied Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party Name")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Transaction Info")
        {
            ApplicationArea = Basic;
        }
        modify(Control13)
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify(TotalBalance)
        {
            ApplicationArea = Basic;
        }
        modify(TotalDiff)
        {
            ApplicationArea = Basic;
        }



        modify("Applied Amount")
        {
            Visible = false;
        }
        addafter("Document No.")
        {
            field("External Document No"; rec."External Document No")
            {
                ApplicationArea = Basic;
                Caption = 'External Doc./Cheque No';
                ToolTip = 'External Document No';
            }
        }

        //moveafter("Document No.","External Document No");
    }
    // actions
    // {
    //     modify(ShowStatementLineDetails)
    //     {
    //         ApplicationArea = Basic;
    //     }

    // }




}
