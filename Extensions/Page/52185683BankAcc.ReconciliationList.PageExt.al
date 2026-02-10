#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185683 pageextension52185683 extends "Bank Acc. Reconciliation List" 
{
    Caption = 'Bank Acc. Reconciliation List';

    //Unsupported feature: Property Modification (SourceTableView) on ""Bank Acc. Reconciliation List"(Page 388)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Acc. Reconciliation List"(Page 388)".

    layout
    {
        modify(BankAccountNo)
        {
            ApplicationArea = Basic;
        }
        modify(StatementNo)
        {
            ApplicationArea = Basic;
        }
        modify(StatementDate)
        {
            ApplicationArea = Basic;
        }
        modify(BalanceLastStatement)
        {
            ApplicationArea = Basic;
        }
        modify(StatementEndingBalance)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "BankAccountNo(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatementNo(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatementDate(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceLastStatement(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatementEndingBalance(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(StatementEndingBalance)
        {
           
        }
    }
    actions
    {
        modify(Post)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndPrint)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 1102601003)".

    }

    var
        BankAccount: Record "Bank Account";
        BankRec: Record "Bank Acc. Reconciliation";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
