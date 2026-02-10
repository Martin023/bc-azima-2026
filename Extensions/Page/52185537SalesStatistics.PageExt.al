#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185537 pageextension52185537 extends "Sales Statistics" 
{
    layout
    {
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify(InvDiscountAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmount1)
        {
            ApplicationArea = Basic;
        }
        modify(VATAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmount2)
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY.Amount")
        {
            ApplicationArea = Basic;
        }
        modify(ProfitLCY)
        {
            ApplicationArea = Basic;
        }
        modify(AdjProfitLCY)
        {
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
        modify("TotalSalesLine.Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine.""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine.""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine.""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine.""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify(TotalAdjCostLCY)
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)""")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 129)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InvDiscountAmount(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount1(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VATAmount(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount2(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY.Amount"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitLCY(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjProfitLCY(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitPct(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjProfitPct(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine.Quantity"(Control 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine.""Units per Parcel"""(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine.""Net Weight"""(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine.""Gross Weight"""(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine.""Unit Volume"""(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY.""Unit Cost (LCY)"""(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAdjCostLCY(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)"""(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SubForm(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Credit Limit (LCY)"""(Control 68)".

    }
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: SalesLine)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));
        IF PrevNo = "No." THEN BEGIN
          GetVATSpecification;
          EXIT;
        END;

        PrevNo := "No.";
        FILTERGROUP(2);
        SETRANGE("No.",PrevNo);
        FILTERGROUP(0);

        CalculateTotals;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));
        IF PrevNo = "No." THEN
          EXIT;
        #7..10
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(SalesPost);

        SalesPost.GetSalesLines(Rec,TempSalesLine,0);
        CLEAR(SalesPost);
        SalesPost.SumSalesLinesTemp(
          Rec,TempSalesLine,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY);

        AdjProfitLCY := TotalSalesLineLCY.Amount - TotalAdjCostLCY;
        IF TotalSalesLineLCY.Amount <> 0 THEN
          AdjProfitPct := ROUND(AdjProfitLCY / TotalSalesLineLCY.Amount * 100,0.1);

        IF "Prices Including VAT" THEN BEGIN
          TotalAmount2 := TotalSalesLine.Amount;
          TotalAmount1 := TotalAmount2 + VATAmount;
          TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
          TotalAmount1 := TotalSalesLine.Amount;
          TotalAmount2 := TotalSalesLine."Amount Including VAT";
        END;

        IF Cust.GET("Bill-to Customer No.") THEN
          Cust.CALCFIELDS("Balance (LCY)")
        ELSE
          CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
          CreditLimitLCYExpendedPct := 0
        ELSE
          IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
            CreditLimitLCYExpendedPct := 0
          ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
              CreditLimitLCYExpendedPct := 10000
            ELSE
              CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000,1);

        SalesLine.CalcVATAmountLines(0,Rec,TempSalesLine,TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified,FALSE);
        SetVATSpecification;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;
        AllowInvDisc :=
          NOT (SalesSetup."Calc. Inv. Discount" AND CustInvDiscRecExists("Invoice Disc. Code"));
        AllowVATDifference :=
          SalesSetup."Allow VAT Difference" AND
          NOT ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]);
        OnOpenPageOnBeforeSetEditable(AllowInvDisc,AllowVATDifference);
        CurrPage.EDITABLE := AllowVATDifference OR AllowInvDisc;
        SetVATSpecification;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        CurrPage.EDITABLE :=
          AllowVATDifference OR AllowInvDisc;
        SetVATSpecification;
        */
    //end;
}
