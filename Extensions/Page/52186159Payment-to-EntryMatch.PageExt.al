#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186159 pageextension52186159 extends "Payment-to-Entry Match" 
{
    layout
    {
        modify(MatchConfidence)
        {
            ApplicationArea = Basic;
        }
        modify(RelatedPatryMatchedOverview)
        {
            ApplicationArea = Basic;
        }
        modify(DocExtDocNoMatchedOverview)
        {
            ApplicationArea = Basic;
        }
        modify(AmountMatchText)
        {
            ApplicationArea = Basic;
        }
        modify("BankAccReconciliationLine.GetAppliedEntryAccountName(""Applies-to Entry No."")")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""BankAccReconciliationLine.GetAppliedEntryAccountName(""Applies-to Entry No."")"(Control 3)".


            //Unsupported feature: Property Modification (Name) on ""BankAccReconciliationLine.GetAppliedEntryAccountName(""Applies-to Entry No."")"(Control 3)".

        }
        modify(NoOfLedgerEntriesWithinAmount)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfLedgerEntriesOutsideAmount)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "MatchConfidence(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RelatedPatryMatchedOverview(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocExtDocNoMatchedOverview(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountMatchText(Control 5)".


        //Unsupported feature: Code Modification on ""BankAccReconciliationLine.GetAppliedEntryAccountName(""Applies-to Entry No."")"(Control 3).OnDrillDown".

        //trigger GetAppliedEntryAccountName(""Applies-to Entry No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            BankAccReconciliationLine.AppliedEntryAccountDrillDown("Applies-to Entry No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            BankAccReconciliationLine.AppliedToDrillDown;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""BankAccReconciliationLine.GetAppliedEntryAccountName(""Applies-to Entry No."")"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfLedgerEntriesWithinAmount(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfLedgerEntriesOutsideAmount(Control 8)".

    }

    var
        OneAmountInclToleranceMatchedTxt: label 'Yes - Single';
        MultipleAmountInclToleranceMatchedTxt: label 'Yes - Multiple';
        NoMatchOnAmountInclToleranceTxt: label 'No';


    //Unsupported feature: Code Modification on "FetchData(PROCEDURE 1)".

    //procedure FetchData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FILTERGROUP(4);
        EVALUATE(AppliesToEntryNo,GETFILTER("Applies-to Entry No."));
        RecRef.GETTABLE(Rec);
        #4..25
              MatchBankPayments.MatchSingleLineVendor(
                BankPmtApplRule,BankAccReconciliationLine,AppliesToEntryNo,
                NoOfLedgerEntriesWithinAmountTolerance,NoOfLedgerEntriesOutsideAmountTolerance);
            "Account Type"::"Bank Account":
              MatchBankPayments.MatchSingleLineBankAccountLedgerEntry(
                BankPmtApplRule,BankAccReconciliationLine,AppliesToEntryNo,
                NoOfLedgerEntriesWithinAmountTolerance,NoOfLedgerEntriesOutsideAmountTolerance);
            ELSE
              ERROR(AccTypeErr);
          END;
        #36..44
        BankAccReconciliationLine."Match Confidence" := TypeHelper.GetOptionNo(
            GETFILTER("Match Confidence"),MatchConfidenceFieldRef.OPTIONCAPTION);

        AmountMatchText := FORMAT(BankPmtApplRule."Amount Incl. Tolerance Matched");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..28
        #33..47
        SetAmountInclToleranceMatched(BankPmtApplRule);
        */
    //end;

    local procedure SetAmountInclToleranceMatched(BankPmtApplRule: Record "Bank Pmt. Appl. Rule")
    begin
        // case BankPmtApplRule."Amount Incl. Tolerance Matched" of
        //   BankPmtApplRule."amount incl. tolerance matched"::"One Match":
        //     AmountMatchText := OneAmountInclToleranceMatchedTxt;
        //   BankPmtApplRule."amount incl. tolerance matched"::"Multiple Matches":
        //     AmountMatchText := MultipleAmountInclToleranceMatchedTxt;
        //   BankPmtApplRule."amount incl. tolerance matched"::"No Matches":
        //     AmountMatchText := NoMatchOnAmountInclToleranceTxt;
        // end;
    end;
}
