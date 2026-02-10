#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186163 pageextension52186163 extends "Pmt. Reconciliation Journals"
{
    layout
    {
        modify("Statement No.")
        {
            ApplicationArea = Basic;
        }
        modify("Total Transaction Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Total Difference")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Total Difference"(Control 8)".


            //Unsupported feature: Property Modification (Name) on ""Total Difference"(Control 8)".

        }
        // modify("Bank Account No.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Statement No."(Control 7)".


        //Unsupported feature: Property Deletion (Editable) on ""Statement No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Transaction Amount"(Control 5)".


        //Unsupported feature: Property Deletion (Editable) on ""Total Transaction Amount"(Control 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Total Difference"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Difference"(Control 8)".


        //Unsupported feature: Property Deletion (BlankZero) on ""Total Difference"(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on ""Total Difference"(Control 8)".


        //Unsupported feature: Property Deletion (Style) on ""Total Difference"(Control 8)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Total Difference"(Control 8)".

        modify("Copy VAT Setup to Jnl. Line")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Statement No.")
        {
            // field("Bank Account No."; Rec."Bank Account No.")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        modify(Process)
        {
            Caption = 'New';

            //Unsupported feature: Property Modification (Name) on "Process(Action 11)".

        }
        modify(ImportBankTransactionsToNew)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "ImportBankTransactionsToNew(Action 13)".

        }
        modify(NewJournal)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "NewJournal(Action 3)".

        }
        modify("Bank Account Card")
        {

            //Unsupported feature: Property Modification (Level) on ""Bank Account Card"(Action 10)".

            Caption = 'List of Bank Accounts';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""Bank Account Card"(Action 10)".


            //Unsupported feature: Property Modification (Image) on ""Bank Account Card"(Action 10)".


            //Unsupported feature: Property Modification (Name) on ""Bank Account Card"(Action 10)".

        }
        modify("List of Bank Accounts")
        {

            //Unsupported feature: Property Modification (Level) on ""List of Bank Accounts"(Action 6)".

            Caption = 'Bank Account Card';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""List of Bank Accounts"(Action 6)".


            //Unsupported feature: Property Modification (Image) on ""List of Bank Accounts"(Action 6)".


            //Unsupported feature: Property Modification (Name) on ""List of Bank Accounts"(Action 6)".


            //Unsupported feature: Property Insertion (RunPageLink) on ""List of Bank Accounts"(Action 6)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportBankTransactionsToNew(Action 13)".

        // modify(EditJournal)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "NewJournal(Action 3)".

        modify(Bank)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Card"(Action 10)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""Bank Account Card"(Action 10)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bank Account Card"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Bank Account Card"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bank Account Card"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""List of Bank Accounts"(Action 6)".


        //Unsupported feature: Property Deletion (Promoted) on ""List of Bank Accounts"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""List of Bank Accounts"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""List of Bank Accounts"(Action 6)".

        addafter("List of Bank Accounts")
        {
            // action(EditJournal)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Edit Journal';
            //     Image = OpenWorksheet;
            //     ShortCutKey = 'Return';

            //     trigger OnAction()
            //     var
            //         BankAccReconciliation: Record "Bank Acc. Reconciliation";
            //     begin
            //         if not BankAccReconciliation.Get(Rec."Statement Type", Rec."Bank Account No.", Rec."Statement No.") then
            //             exit;

            //         Rec.OpenWorksheet(Rec);
            //     end;
            // }
        }
        // moveafter(ActionContainer1900000004;"List of Bank Accounts")
        // moveafter("Bank Account Card";"Bank Account Card")
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
