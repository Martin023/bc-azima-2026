#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186618 pageextension52186618 extends "Service Order Statistics" 
{
    layout
    {
        modify("Amount_General")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_General")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[1]")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_General")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_General")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_General")
        {
            ApplicationArea = Basic;
        }
        modify("Original_ProfitLCY_Gen")
        {

            //Unsupported feature: Property Modification (Name) on ""Original_ProfitLCY_Gen"(Control 32)".

            ApplicationArea = Basic;
        }
        modify("Adj_ProfitLCY_Gen")
        {

            //Unsupported feature: Property Modification (Name) on ""Adj_ProfitLCY_Gen"(Control 135)".

            ApplicationArea = Basic;
        }
        modify("Original_ProfitPct_Gen")
        {

            //Unsupported feature: Property Modification (Name) on ""Original_ProfitPct_Gen"(Control 24)".

            ApplicationArea = Basic;
        }
        modify("Adj_ProfitPct_Gen")
        {

            //Unsupported feature: Property Modification (Name) on ""Adj_ProfitPct_Gen"(Control 137)".

            ApplicationArea = Basic;
        }
        modify("TotalServLine[1].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[1].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[1].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[1].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[1].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify(OriginalCostLCY)
        {
            ApplicationArea = Basic;
        }
        modify(AdjustedCostLCY)
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[1] - TotalServLineLCY[1].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("No. of VAT Lines_General")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[2].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Amount_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify(Total)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[2]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[2]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[2]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitPct[2]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLineLCY[2].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[2]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[2] - TotalServLineLCY[2].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity_Consuming")
        {
            ApplicationArea = Basic;
        }
        modify(Text006)
        {
            ApplicationArea = Basic;
        }
        // modify(Control46)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control47)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control48)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control49)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control50)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("ProfitLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[4]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitPct[4]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLineLCY[4].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[4] - TotalServLineLCY[4].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[2].Quantity + TotalServLine[4].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[2].""Line Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[2].""Inv. Discount Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[2]")
        {
            ApplicationArea = Basic;
        }
        modify("VATAmount[2]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount2[2]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLineLCY[2].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[2] + AdjProfitLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[2] + ProfitLCY[4]")
        {
            ApplicationArea = Basic;
        }
        // modify(GetDetailsTotal)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(GetAdjDetailsTotal)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("TotalServLineLCY[2].""Unit Cost (LCY)"" + TotalServLineLCY[4].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[2] + TotalAdjCostLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify(DetailedTotalLCYCost)
        {

            //Unsupported feature: Property Modification (Name) on "DetailedTotalLCYCost(Control 89)".

            ApplicationArea = Basic;
        }
        modify("Amount_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[3]")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLineLCY[3].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[3]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[3].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[3].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[3].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[3].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[3].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("No. of VAT Lines_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[5].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Amount_Items")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_Items")
        {
            ApplicationArea = Basic;
        }
        modify(Total2)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_Items")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_Items")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_Items")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[5]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[5]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitPct[5]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLineLCY[5].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[5]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[5] - TotalServLineLCY[5].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalServLine[6].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Amount_Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_Resources")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[6]")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_Resources")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[6]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[6]")
        {
            ApplicationArea = Basic;
        }
        // modify(Control51)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("TotalServLineLCY[6].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        // modify(Control53)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control55)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("TotalServLine[7].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Amount_Costs")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount_Costs")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[7]")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount_Costs")
        {
            ApplicationArea = Basic;
        }
        modify("Total Incl. VAT_Costs")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)_Costs")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[7]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[7]")
        {
            ApplicationArea = Basic;
        }
        // modify(Control52)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("TotalServLineLCY[7].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        // modify(Control54)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control56)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Cust.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Limit (LCY)_Customer")
        {
            ApplicationArea = Basic;
        }
        modify(CreditLimitLCYExpendedPct)
        {
            ToolTip = 'Expended % of Credit Limit (LCY)';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_General"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount_General"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_General"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original_ProfitLCY_Gen"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adj_ProfitLCY_Gen"(Control 135)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original_ProfitPct_Gen"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adj_ProfitPct_Gen"(Control 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[1].Quantity"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[1].""Units per Parcel"""(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[1].""Net Weight"""(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[1].""Gross Weight"""(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[1].""Unit Volume"""(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OriginalCostLCY(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AdjustedCostLCY(Control 141)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[1] - TotalServLineLCY[1].""Unit Cost (LCY)"""(Control 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of VAT Lines_General"(Control 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[2].Quantity"(Control 166)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount_Invoicing"(Control 156)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_Invoicing"(Control 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Total(Control 150)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount_Invoicing"(Control 147)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Incl. VAT_Invoicing"(Control 144)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_Invoicing"(Control 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[2]"(Control 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[2]"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[2]"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitPct[2]"(Control 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[2].""Unit Cost (LCY)"""(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[2]"(Control 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[2] - TotalServLineLCY[2].""Unit Cost (LCY)"""(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity_Consuming"(Control 165)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[4]"(Control 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[4]"(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[4]"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitPct[4]"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[4].""Unit Cost (LCY)"""(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[4]"(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[4] - TotalServLineLCY[4].""Unit Cost (LCY)"""(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[2].Quantity + TotalServLine[4].Quantity"(Control 168)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[2].""Inv. Discount Amount"""(Control 155)".


        //Unsupported feature: Property Deletion (ShowCaption) on ""VATAmount[2]"(Control 149)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[2].Amount"(Control 143)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[2] + AdjProfitLCY[4]"(Control 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[2] + ProfitLCY[4]"(Control 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetDetailsTotal(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetAdjDetailsTotal(Control 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[2].""Unit Cost (LCY)"" + TotalServLineLCY[4].""Unit Cost (LCY)"""(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[2] + TotalAdjCostLCY[4]"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DetailedTotalLCYCost(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_Shipping"(Control 187)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_Shipping"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[3].""Unit Cost (LCY)"""(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[3]"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[3]"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[3].Quantity"(Control 188)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[3].""Units per Parcel"""(Control 182)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[3].""Net Weight"""(Control 180)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[3].""Gross Weight"""(Control 178)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[3].""Unit Volume"""(Control 172)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of VAT Lines_Shipping"(Control 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[5].Quantity"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount_Items"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_Items"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Total2(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount_Items"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Incl. VAT_Items"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_Items"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[5]"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[5]"(Control 159)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[5]"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitPct[5]"(Control 163)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[5].""Unit Cost (LCY)"""(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[5]"(Control 174)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[5] - TotalServLineLCY[5].""Unit Cost (LCY)"""(Control 173)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[6].Quantity"(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_Resources"(Control 84)".


        //Unsupported feature: Property Deletion (ShowCaption) on ""VAT Amount_Resources"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_Resources"(Control 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[6]"(Control 122)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[6]"(Control 158)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[6]"(Control 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[6].""Unit Cost (LCY)"""(Control 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLine[7].Quantity"(Control 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount_Costs"(Control 125)".


        //Unsupported feature: Property Deletion (ShowCaption) on ""VAT Amount_Costs"(Control 129)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)_Costs"(Control 131)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[7]"(Control 133)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[7]"(Control 157)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[7]"(Control 134)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalServLineLCY[7].""Unit Cost (LCY)"""(Control 132)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Limit (LCY)_Customer"(Control 17)".

    }

    //Unsupported feature: Property Modification (Id) on "VATLinesForm(Variable 1025)".

    //var
        //>>>> ORIGINAL VALUE:
        //VATLinesForm : 1025;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //VATLinesForm : 1102601000;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));

        IF PrevNo = "No." THEN
        #4..28
          ServAmtsMgt.SumServiceLinesTemp(
            Rec,TempServLine,i - 1,TotalServLine[i],TotalServLineLCY[i],
            VATAmount[i],VATAmountText[i],ProfitLCY[i],ProfitPct[i],TotalAdjCostLCY[i]);

          IF i = 3 THEN
            TotalAdjCostLCY[i] := TotalServLineLCY[i]."Unit Cost (LCY)";
        #35..38
            ProfitPct[i] := ROUND(100 * ProfitLCY[i] / TotalServLineLCY[i].Amount,0.1);

          AdjProfitLCY[i] := TotalServLineLCY[i].Amount - TotalAdjCostLCY[i];

          IF TotalServLineLCY[i].Amount <> 0 THEN
            AdjProfitPct[i] := ROUND(100 * AdjProfitLCY[i] / TotalServLineLCY[i].Amount,0.1);

        #46..73
        TempVATAmountLine3.MODIFYALL(Modified,FALSE);

        PrevTab := -1;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31
          ProfitLCY[i] := MakeNegativeZero(ProfitLCY[i]);
        #32..41
          AdjProfitLCY[i] := MakeNegativeZero(AdjProfitLCY[i]);
        #43..76
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateHeaderInfo(PROCEDURE 5)".

    //procedure UpdateHeaderInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TotalServLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1[IndexNo] :=
          TotalServLine[IndexNo]."Line Amount" - TotalServLine[IndexNo]."Inv. Discount Amount";
        #4..26
            UseDate,"Currency Code",TotalServLineLCY[IndexNo].Amount,"Currency Factor");

        ProfitLCY[IndexNo] := TotalServLineLCY[IndexNo].Amount - TotalServLineLCY[IndexNo]."Unit Cost (LCY)";

        IF TotalServLineLCY[IndexNo].Amount = 0 THEN
          ProfitPct[IndexNo] := 0
        ELSE
          ProfitPct[IndexNo] := ROUND(100 * ProfitLCY[IndexNo] / TotalServLineLCY[IndexNo].Amount,0.1);

        AdjProfitLCY[IndexNo] := TotalServLineLCY[IndexNo].Amount - TotalAdjCostLCY[IndexNo];

        IF TotalServLineLCY[IndexNo].Amount = 0 THEN
          AdjProfitPct[IndexNo] := 0
        ELSE
          AdjProfitPct[IndexNo] := ROUND(100 * AdjProfitLCY[IndexNo] / TotalServLineLCY[IndexNo].Amount,0.1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..29
        ProfitLCY[IndexNo] := MakeNegativeZero(ProfitLCY[IndexNo]);
        #31..36
        AdjProfitLCY[IndexNo] := MakeNegativeZero(AdjProfitLCY[IndexNo]);
        #38..41
        */
    //end;

    local procedure UpdateHeaderServLine()
    var
        TempServLine: Record "Service Line" temporary;
    begin
        //Clear(ServAmtsMgt);

        // for i := 1 to 7 do begin
        //   if i in [1,5,6,7] then begin
        //     TempServLine.DeleteAll;
        //     Clear(TempServLine);
        //     ServAmtsMgt.GetServiceLines(Rec,TempServLine,i - 1);

        //     ServAmtsMgt.SumServiceLinesTemp(
        //       Rec,TempServLine,i - 1,TotalServLine[i],TotalServLineLCY[i],
        //       VATAmount[i],VATAmountText[i],ProfitLCY[i],ProfitPct[i],TotalAdjCostLCY[i]);

        //     if TotalServLineLCY[i].Amount = 0 then
        //       ProfitPct[i] := 0
        //     else
        //       ProfitPct[i] := ROUND(100 * ProfitLCY[i] / TotalServLineLCY[i].Amount,0.1);

        //     AdjProfitLCY[i] := TotalServLineLCY[i].Amount - TotalAdjCostLCY[i];
        //     if TotalServLineLCY[i].Amount <> 0 then
        //       AdjProfitPct[i] := ROUND(100 * AdjProfitLCY[i] / TotalServLineLCY[i].Amount,0.1);

        //     if Rec."Prices Including VAT" then begin
        //       TotalAmount2[i] := TotalServLine[i].Amount;
        //       TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
        //       TotalServLine[i]."Line Amount" := TotalAmount1[i] + TotalServLine[i]."Inv. Discount Amount";
        //     end else begin
        //       TotalAmount1[i] := TotalServLine[i].Amount;
        //       TotalAmount2[i] := TotalServLine[i]."Amount Including VAT";
        //     end;
        //   end;
        //end;
    end;

    local procedure MakeNegativeZero(Amount: Decimal): Decimal
    begin
        if Amount < 0 then
          exit(0);
        exit(Amount);
    end;
}
