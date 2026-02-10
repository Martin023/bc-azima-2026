#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186162 pageextension52186162 extends "Payment Application" 
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Payment Application"(Page 1292)".

    layout
    {
        modify(PaymentStatus)
        {
            ApplicationArea = Basic;
        }
        modify(TransactionDate)
        {
            ApplicationArea = Basic;
        }
        modify(TransactionAmount)
        {
            ApplicationArea = Basic;
        }
        modify(BankAccReconLineDescription)
        {
            ApplicationArea = Basic;
        }
        modify(AppliedAmount)
        {
            ApplicationArea = Basic;
        }
        modify(Applied)
        {
            ApplicationArea = Basic;
        }
        modify(RemainingAmountAfterPosting)
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
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
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amt. Incl. Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
        }
        modify(AccountName)
        {

            //Unsupported feature: Property Modification (Level) on "AccountName(Control 40)".

            Caption = 'Account Name:';
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Match Confidence")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(TotalAppliedAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalRemainingAmount)
        {
            Caption = 'Remaining Amount to Apply';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentStatus(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TransactionDate(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TransactionAmount(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BankAccReconLineDescription(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedAmount(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Applied(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingAmountAfterPosting(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amt. Incl. Discount"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AccountName(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Match Confidence"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAppliedAmount(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalRemainingAmount(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control2(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".

        moveafter("Remaining Pmt. Disc. Possible";"Account Type")
    }
    actions
    {
        // modify(ActionContainer43)
        // {

        //     //Unsupported feature: Property Modification (ActionType) on "ActionContainer43(Action 43)".


        //     //Unsupported feature: Property Modification (Name) on "ActionContainer43(Action 43)".


        //     //Unsupported feature: Property Insertion (Level) on "ActionContainer43(Action 43)".

        //     Caption = 'Details';
        // }
        // modify(Details)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Details(Action 38)".


        //     //Unsupported feature: Property Modification (ActionType) on "Details(Action 38)".

        //     Caption = 'Bank Transaction Details';

        //     //Unsupported feature: Property Modification (Name) on "Details(Action 38)".


        //     //Unsupported feature: Property Insertion (Promoted) on "Details(Action 38)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Details(Action 38)".


            //Unsupported feature: Property Insertion (Image) on "Details(Action 38)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "Details(Action 38)".

        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Modification (ActionType) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Modification (Name) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Insertion (ActionContainerType) on "ShowBankTransactionDetails(Action 42)".

        modify(Accept)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Accept(Action 9)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Accept(Action 9)".

        }
        modify(Reject)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Reject(Action 8)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Reject(Action 8)".

        }
        modify(AllOpenEntries)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "AllOpenEntries(Action 35)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "AllOpenEntries(Action 35)".

        }
        modify(RelatedPartyOpenEntries)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "RelatedPartyOpenEntries(Action 37)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "RelatedPartyOpenEntries(Action 37)".

        }
        modify(AppliedEntries)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "AppliedEntries(Action 36)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "AppliedEntries(Action 36)".

        }

        //Unsupported feature: Property Deletion (ActionContainerType) on "ActionContainer43(Action 43)".


        //Unsupported feature: Code Insertion on "ShowBankTransactionDetails(Action 38)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //var
            //DataExchField: Record "Data Exch. Field";
        //begin
            /*
            DataExchField.SETRANGE("Data Exch. No.",BankAccReconLine."Posting Exch. Entry No.");
            DataExchField.SETRANGE("Line No.",BankAccReconLine."Posting Exch. Line No.");
            PAGE.RUN(PAGE::"Bank Statement Line Details",DataExchField);
            */
        //end;
        modify(ShowBankTransactionDetails)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Level) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Deletion (CaptionML) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ShowBankTransactionDetails(Action 42)".


        //Unsupported feature: Property Deletion (Image) on "ShowBankTransactionDetails(Action 42)".



        //Unsupported feature: Code Modification on "Accept(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF BankAccReconLine.Difference * BankAccReconLine."Applied Amount" > 0 THEN
              IF BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::"Bank Account" THEN
                ERROR(ExcessiveAmountErr,BankAccReconLine.Difference);

            BankAccReconLine.AcceptApplication;
            CurrPage.CLOSE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF BankAccReconLine.Difference > 0 THEN
              IF NOT CONFIRM(STRSUBSTNO(CreditTheAccountQst,BankAccReconLine.GetAppliedToName,BankAccReconLine.Difference)) THEN
                EXIT;
            #4..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Accept(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 8)".



        //Unsupported feature: Code Modification on "AllOpenEntries(Action 35).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SETRANGE(Applied);
            SETRANGE("Account Type");
            SETRANGE("Account No.");
            SETRANGE(Type,Type::"Bank Account Ledger Entry",Type::"Check Ledger Entry");

            IF FINDFIRST THEN;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3

            IF FINDFIRST THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AllOpenEntries(Action 35)".



        //Unsupported feature: Code Modification on "RelatedPartyOpenEntries(Action 37).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SETRANGE(Applied);

            BankAccReconLine.GET(
            #4..7
              SETRANGE("Account No.",BankAccReconLine."Account No.");
              SETRANGE("Account Type",BankAccReconLine."Account Type");
            END;
            SETRANGE(Type,Type::"Bank Account Ledger Entry",Type::"Check Ledger Entry");

            IF FINDFIRST THEN;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10

            IF FINDFIRST THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "RelatedPartyOpenEntries(Action 37)".



        //Unsupported feature: Code Modification on "AppliedEntries(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SETRANGE(Applied,TRUE);
            SETRANGE("Account Type");
            SETRANGE("Account No.");
            SETRANGE(Type,Type::"Bank Account Ledger Entry",Type::"Check Ledger Entry");

            IF FINDFIRST THEN;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3

            IF FINDFIRST THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedEntries(Action 36)".

        modify(AllOpenBankTransactions)
        {
            Visible = false;
        }
        modify(AllOpenPayments)
        {
            Visible = false;
        }
       // moveafter(;ActionContainer7)
        moveafter(AppliedEntries;ShowBankTransactionDetails)
    }

    var
        CreditTheAccountQst: label 'Remaining Amount to Apply is %2.\\Do you want to create a new payment application line that will debit or credit %1 with the remaining amount when you post the payment?', Comment='%1 is the account name, %2 is the amount that is not applied (there is filed on the page named Remaining Amount To Apply)';

    //Unsupported feature: Property Deletion (Attributes) on "SetBankAccReconcLine(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetBankAccReconcLine(PROCEDURE 3)".

    //procedure SetBankAccReconcLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        BankAccReconLine := NewBankAccReconLine;
        TransferFromBankAccReconLine(NewBankAccReconLine);

        OnSetBankAccReconcLine(BankAccReconLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        BankAccReconLine := NewBankAccReconLine;
        TransferFromBankAccReconLine(NewBankAccReconLine);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateAfterChangingApplication(PROCEDURE 13)".

    //procedure UpdateAfterChangingApplication();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        BankAccReconLine.SetManualApplication;
        UpdateToSystemMatchConfidence;
        UpdateTotals;
        MatchBankPayments.UpdateType(BankAccReconLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "UpdateAfterChangingApplication(PROCEDURE 13).MatchBankPayments(Variable 1000)".

}

