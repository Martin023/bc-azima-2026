#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185692 pageextension52185692 extends "Sales Invoice Statistics" 
{
    layout
    {
        modify("CustAmount + InvDiscAmount")
        {
            ApplicationArea = Basic;
        }
        modify(InvDiscAmount)
        {
            ApplicationArea = Basic;
        }
        modify(CustAmount)
        {
            ApplicationArea = Basic;
        }
        modify(VATAmount)
        {
            ApplicationArea = Basic;
        }
        modify(AmountInclVAT)
        {
            ApplicationArea = Basic;
        }
        modify(AmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify(ProfitLCY)
        {
            ApplicationArea = Basic;
        }
        modify(AdjustedProfitLCY)
        {

            //Unsupported feature: Property Modification (Name) on "AdjustedProfitLCY(Control 43)".

            ApplicationArea = Basic;
        }
        modify(ProfitPct)
        {
            ApplicationArea = Basic;
        }
        modify(AdjProfitPct)
        {
            ApplicationArea = Basic;
        }
        modify(LineQty)
        {
            ApplicationArea = Basic;
        }
        modify(TotalParcels)
        {
            ApplicationArea = Basic;
        }
        modify(TotalNetWeight)
        {
            ApplicationArea = Basic;
        }
        modify(TotalGrossWeight)
        {
            ApplicationArea = Basic;
        }
        modify(TotalVolume)
        {
            ApplicationArea = Basic;
        }
        modify(CostLCY)
        {
            ApplicationArea = Basic;
        }
        modify(AdjustedCostLCY)
        {

            //Unsupported feature: Property Modification (Name) on "AdjustedCostLCY(Control 35)".

            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY - CostLCY")
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Credit Limit (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify(CreditLimitLCYExpendedPct)
        {
            ToolTip = 'Expended % of Credit Limit (LCY)';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""CustAmount + InvDiscAmount"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InvDiscAmount(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustAmount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VATAmount(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountInclVAT(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountLCY(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitLCY(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjustedProfitLCY(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitPct(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjProfitPct(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineQty(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalParcels(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalNetWeight(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalGrossWeight(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalVolume(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostLCY(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjustedCostLCY(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY - CostLCY"(Control 39)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Subform(Control 18)".


        //Unsupported feature: Property Deletion (PartType) on "Subform(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Credit Limit (LCY)"""(Control 21)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEARALL;

        IF "Currency Code" = '' THEN
        #4..25
                VATPercentage := SalesInvLine."VAT %"
              ELSE
                VATPercentage := -1;
            TotalAdjCostLCY :=
              TotalAdjCostLCY + CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvLine) +
              CostCalcMgt.CalcSalesInvLineNonInvtblCostAmt(SalesInvLine);
          UNTIL SalesInvLine.NEXT = 0;
        VATAmount := AmountInclVAT - CustAmount;
        InvDiscAmount := ROUND(InvDiscAmount,currency."Amount Rounding Precision");
        #35..78
        SalesInvLine.CalcVATAmountLines(Rec,TempVATAmountLine);
        CurrPage.Subform.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        CurrPage.Subform.PAGE.InitGlobals("Currency Code",FALSE,FALSE,FALSE,FALSE,"VAT Base Discount %");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..28
            TotalAdjCostLCY := TotalAdjCostLCY + CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvLine);
        #32..81
        */
    //end;
}
