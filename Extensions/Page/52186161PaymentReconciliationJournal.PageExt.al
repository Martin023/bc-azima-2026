#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186161 pageextension52186161 extends "Payment Reconciliation Journal"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Payment Reconciliation Journal"(Page 1290)".

    layout
    {
        modify("Match Confidence")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Date")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Text")
        {
            ApplicationArea = Basic;
        }
        modify("Statement Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Difference)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Difference(Control 12)".

        }
        modify(StatementToRemAmtDifference)
        {
            ApplicationArea = Basic;
        }
        modify(GetAppliedToDocumentNo)
        {
            ApplicationArea = Basic;
        }
        modify(DescAppliedEntry)
        {
            ApplicationArea = Basic;
        }
        modify(DueDateAppliedEntry)
        {
            ApplicationArea = Basic;
        }
        modify(AccountName)
        {

            //Unsupported feature: Property Modification (Level) on "AccountName(Control 43)".

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
        modify(PostingDateAppliedEntry)
        {
            ApplicationArea = Basic;
        }
        modify("AppliedPmtEntry.""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("Match Details")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Entries")
        {
            ApplicationArea = Basic;
        }
        modify(RemainingAmount)
        {
            ApplicationArea = Basic;
        }
        modify("Additional Transaction Info")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party Address")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party Bank Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party City")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party Name")
        {
            ApplicationArea = Basic;
        }
        // modify(BalanceOnBankAccount)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(TotalTransactionAmount)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(BalanceOnBankAccountAfterPosting)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "BalanceOnBankAccountAfterPosting(Control 24)".

        // }
        // modify(OutstandingTransactions)
        // {

        //     //Unsupported feature: Property Modification (Name) on "OutstandingTransactions(Control 54)".

        //     ApplicationArea = Basic;
        //     ShowCaption = false;
        // }
        // modify(StatementEndingBalance)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Match Confidence"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Date"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Text"(Control 16)".

        modify("Transaction ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Statement Amount"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Difference(Control 12)".


        //Unsupported feature: Property Deletion (Style) on "Difference(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatementToRemAmtDifference(Control 52)".


        //Unsupported feature: Property Deletion (Visible) on "StatementToRemAmtDifference(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetAppliedToDocumentNo(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DescAppliedEntry(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DueDateAppliedEntry(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AccountName(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 4)".


        //Unsupported feature: Code Modification on ""Account No."(Control 13).OnValidate".

        //trigger "(Control 13)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.UPDATE;
        IF Difference <> 0 THEN
          TransferRemainingAmountToAccount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.UPDATE;
        IF Difference > 0 THEN
          TransferRemainingAmountToAccount;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDateAppliedEntry(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AppliedPmtEntry.""Currency Code"""(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Match Details"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Entries"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingAmount(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Transaction Info"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related-Party Address"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related-Party Bank Acc. No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related-Party City"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related-Party Name"(Control 17)".

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
        // modify(BalanceOnBankAccount)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceOnBankAccount(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalTransactionAmount(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceOnBankAccountAfterPosting(Control 24)".


        //Unsupported feature: Property Deletion (StyleExpr) on "BalanceOnBankAccountAfterPosting(Control 24)".

        // modify(OutstandingTransactions)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on "OutstandingTransactions(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutstandingTransactions(Control 54)".


        //Unsupported feature: Property Deletion (SourceExpr) on "OutstandingTransactions(Control 54)".


        //Unsupported feature: Property Deletion (Editable) on "OutstandingTransactions(Control 54)".

        // modify(OutstandingPayments)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "StatementEndingBalance(Control 23)".


        //Unsupported feature: Property Deletion (Editable) on "StatementEndingBalance(Control 23)".

        moveafter("Statement Amount"; Difference)
        moveafter(DueDateAppliedEntry; "Account Type")
        moveafter("Applied Amount"; RemainingAmount)
    }
    actions
    {
        modify(ImportBankTransactions)
        {

            //Unsupported feature: Property Modification (Level) on "ImportBankTransactions(Action 22)".

            ApplicationArea = Basic;
        }
        modify(ApplyAutomatically)
        {

            //Unsupported feature: Property Modification (Level) on "ApplyAutomatically(Action 29)".

            ApplicationArea = Basic;
        }
        modify(Post)
        {

            //Unsupported feature: Property Modification (Level) on "Post(Action 35)".

            Caption = 'Post';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "Post(Action 35)".


            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 35)".

        }
        modify(FinanceChargeMemo)
        {
            ApplicationArea = Basic;
        }
        modify(OpenGenJnl)
        {
            ApplicationArea = Basic;
        }
        modify("Payment Journal")
        {
            ApplicationArea = Basic;
        }
        modify(AddMappingRule)
        {

            //Unsupported feature: Property Modification (Level) on "AddMappingRule(Action 30)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "AddMappingRule(Action 30)".

        }
        modify(ApplyEntries)
        {
            ApplicationArea = Basic;
        }
        modify(Accept)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Accept(Action 36)".

        }
        modify(Reject)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Reject(Action 37)".

        }
        modify(SortForReviewDescending)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SortForReviewDescending(Action 32)".

        }
        modify(SortForReviewAscending)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SortForReviewAscending(Action 34)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(LineDimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account Card")
        {
            ApplicationArea = Basic;
        }
        modify(ShowBankTransactionDetails)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageLink) on "ShowBankTransactionDetails(Action 27)".


            //Unsupported feature: Property Modification (PromotedCategory) on "ShowBankTransactionDetails(Action 27)".

        }
        modify(Process)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "ImportBankTransactions(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnAfterImportBankTransactions(SubscriberInvoked,Rec);
        IF NOT SubscriberInvoked THEN BEGIN
          BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
          BankAccReconciliation.ImportBankStatement;
          IF BankAccReconciliation.FIND THEN;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
        BankAccReconciliation.ImportBankStatement;
        IF BankAccReconciliation.FIND THEN;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportBankTransactions(Action 22)".



        //Unsupported feature: Code Modification on "ApplyAutomatically(Action 29).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AppliedPaymentEntry.SETRANGE("Statement Type","Statement Type");
        AppliedPaymentEntry.SETRANGE("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SETRANGE("Statement No.","Statement No.");
        #4..6
            EXIT;

        BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
        OnAtActionApplyAutomatically(BankAccReconciliation,SubscriberInvoked);
        IF NOT SubscriberInvoked THEN
          CODEUNIT.RUN(CODEUNIT::"Match Bank Pmt. Appl.",BankAccReconciliation);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        CODEUNIT.RUN(CODEUNIT::"Match Bank Pmt. Appl.",BankAccReconciliation);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyAutomatically(Action 29)".

        // modify(ActionGroup58)
        // {
        //     Visible = false;
        // }
        modify(TestReport)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "Post(Action 35).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InvokePost(FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
        CODEUNIT.RUN(CODEUNIT::"Bank Acc. Recon. Post (Yes/No)",BankAccReconciliation);
        RESET;
        CurrPage.CLOSE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 35)".

        modify(PostPaymentsOnly)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "FinanceChargeMemo(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OpenGenJnl(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Journal"(Action 40)".

        modify("Manual Application")
        {
            Visible = false;
        }
        modify(TransferDiffToAccount)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AddMappingRule(Action 30)".



        //Unsupported feature: Code Modification on "ApplyEntries(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DisplayApplication;
        GetAppliedPmtData(AppliedPmtEntry,RemainingAmountAfterPosting,StatementToRemAmtDifference,PmtAppliedToTxt);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DisplayApplication;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyEntries(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Accept(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 37)".

        modify(ShowNonAppliedLines)
        {
            Visible = false;
        }
        modify(ShowAllLines)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SortForReviewDescending(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SortForReviewAscending(Action 34)".


        //Unsupported feature: Property Deletion (ShortCutKey) on "Dimensions(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDimensions(Action 6)".


        //Unsupported feature: Property Deletion (Promoted) on "LineDimensions(Action 6)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "LineDimensions(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Card"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowBankTransactionDetails(Action 27)".

        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
        moveafter(ImportBankTransactions; AddMappingRule)
        moveafter("Payment Journal"; Review)
    }


    //Unsupported feature: Property Modification (TextConstString) on "PmtAppliedToTxt(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //PmtAppliedToTxt : @@@="%1=integer value for number of entries";ENU=The payment has been applied to %1 entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PmtAppliedToTxt : ENU=The payment has been applied to (%1) entries.;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT IsBankAccReconInitialized THEN BEGIN
      BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
      IsBankAccReconInitialized := TRUE;
    END;

    FinanceChargeMemoEnabled := "Account Type" = "Account Type"::Customer;
    BankAccReconciliation.CALCFIELDS("Total Balance on Bank Account","Total Unposted Applied Amount","Total Transaction Amount",
      "Total Applied Amount","Total Outstd Bank Transactions","Total Outstd Payments","Total Applied Amount Payments");

    OutstandingTransactions := BankAccReconciliation."Total Outstd Bank Transactions" -
      (BankAccReconciliation."Total Applied Amount" - BankAccReconciliation."Total Unposted Applied Amount") +
      BankAccReconciliation."Total Applied Amount Payments";
    OutstandingPayments := BankAccReconciliation."Total Outstd Payments" - BankAccReconciliation."Total Applied Amount Payments";

    UpdateBalanceAfterPostingStyleExpr;

    TestIfFiltershaveBeenRemovedWithRefreshAndClose;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    BankAccReconciliation.CALCFIELDS("Total Balance on Bank Account","Total Applied Amount","Total Transaction Amount");
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MatchDetails := PaymentMatchingDetails.MergeMessages(Rec);

    GetAppliedPmtData(AppliedPmtEntry,RemainingAmountAfterPosting,StatementToRemAmtDifference,PmtAppliedToTxt);
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MatchDetails := PaymentMatchingDetails.MergeMessages(Rec);

    GetAppliedPmtEntriesInfo(AppliedPmtEntry,StatementToRemAmtDifference);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateSorting(PROCEDURE 4)".

    //procedure UpdateSorting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankAccReconciliationLine.SETRANGE("Statement Type","Statement Type");
    BankAccReconciliationLine.SETRANGE("Bank Account No.","Bank Account No.");
    BankAccReconciliationLine.SETRANGE("Statement No.","Statement No.");
    #4..8
        BankAccReconciliationLine."Sorting Order" := BankAccReconciliationLine."Match Confidence" * ScoreRange;

        // Update sorting for same match confidence based onother criteria
        GetAppliedPmtData(AppliedPaymentEntry2,RemainingAmountAfterPosting,AmountDifference,PmtAppliedToTxt);

        ScoreRange := ScoreRange / 10;
        IF AmountDifference <> 0 THEN
    #16..25
        BankAccReconciliationLine.MODIFY;
      UNTIL BankAccReconciliationLine.NEXT = 0;

      OnUpdateSorting(BankAccReconciliation,SubscriberInvoked);
      IF NOT SubscriberInvoked THEN
        SETCURRENTKEY("Sorting Order");
      ASCENDING(IsAscending);

      CurrPage.UPDATE(FALSE);
      FINDFIRST;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
        GetAppliedPmtEntriesInfo(AppliedPaymentEntry2,AmountDifference);
    #13..28
      SETCURRENTKEY("Sorting Order");
    #32..36
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: DifferenceStatementAmtToApplEntryAmount) (ParameterCollection) on "GetAppliedPmtEntriesInfo(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: CurrRemAmtAfterPosting) (VariableCollection) on "GetAppliedPmtEntriesInfo(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "OnAtActionApplyAutomatically(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Name) on "OnAtActionApplyAutomatically(PROCEDURE 1)".


    //Unsupported feature: Property Insertion (Local) on "OnAtActionApplyAutomatically(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "OnAtActionApplyAutomatically(PROCEDURE 1)".

    //procedure OnAtActionApplyAutomatically();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AppliedPmtEntry.INIT;
    RemainingAmountAfterPosting := 0;
    DifferenceStatementAmtToApplEntryAmount := 0;

    AppliedPmtEntry.FilterAppliedPmtEntry(Rec);
    AppliedPmtEntry.SETFILTER("Applies-to Entry No.",'<>0');
    IF AppliedPmtEntry.FINDSET THEN BEGIN
      DifferenceStatementAmtToApplEntryAmount := "Statement Amount";
      REPEAT
        CurrRemAmtAfterPosting :=
          AppliedPmtEntry.GetRemAmt -
          AppliedPmtEntry."Applied Pmt. Discount" -
          AppliedPmtEntry.GetAmtAppliedToOtherStmtLines;

        RemainingAmountAfterPosting += CurrRemAmtAfterPosting;
        DifferenceStatementAmtToApplEntryAmount -= CurrRemAmtAfterPosting;
      UNTIL AppliedPmtEntry.NEXT = 0;
    END;

    IF "Applied Entries" > 1 THEN
      AppliedPmtEntry.Description := STRSUBSTNO(PmtAppliedToTxt,"Applied Entries");
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "UpdateSorting(PROCEDURE 4).SubscriberInvoked(Variable 1006)".


    //Unsupported feature: Property Modification (Name) on "OnAtActionApplyAutomatically(PROCEDURE 1).BankAccReconciliation(Parameter 1000)".


    //Unsupported feature: Property Modification (Subtype) on "OnAtActionApplyAutomatically(PROCEDURE 1).BankAccReconciliation(Parameter 1000)".


    //Unsupported feature: Property Insertion (AsVar) on "OnAtActionApplyAutomatically(PROCEDURE 1).BankAccReconciliation(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAtActionApplyAutomatically(PROCEDURE 1).SubscriberInvoked(Parameter 1001)".

}
