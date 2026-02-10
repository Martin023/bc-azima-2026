#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185697 pageextension52185697 extends "Sales Order Statistics" 
{
    layout
    {
        modify(LineAmountGeneral)
        {
            ApplicationArea = Basic;
        }
        modify("InvDiscountAmount_General")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[1]")
        {
            ApplicationArea = Basic;
        }
        modify(VATAmount)
        {

            //Unsupported feature: Property Modification (Name) on "VATAmount(Control 16)".

            ApplicationArea = Basic;
        }
        modify("TotalAmount2[1]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[1].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitLCY[1]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitLCY[1]")
        {
            ApplicationArea = Basic;
        }
        modify("ProfitPct[1]")
        {
            ApplicationArea = Basic;
        }
        modify("AdjProfitPct[1]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[1]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfVATLines_General")
        {
            Caption = 'No. of VAT Lines';
            ApplicationArea = Basic;
        }
        modify("AmountInclVAT_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("InvDiscountAmount_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("TotalInclVAT_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("VATAmount_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("TotalExclVAT_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[2].Amount")
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
        modify("TotalSalesLine[2].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[2].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[2].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[2].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[2].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[2]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfVATLines_Invoicing")
        {
            Caption = 'No. of VAT Lines';
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Line Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Inv. Discount Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount1[3]")
        {
            ApplicationArea = Basic;
        }
        modify("VATAmount[3]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalAmount2[3]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[3].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLineLCY[3].""Unit Cost (LCY)""")
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
        modify("TotalSalesLine[3].Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[3].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("TempVATAmountLine3.COUNT")
        {
            Caption = 'No. of VAT Lines';
            ApplicationArea = Basic;
        }
        modify(PrepmtTotalAmount)
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtVATAmount)
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtTotalAmount2)
        {
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Prepmt. Amt. Inv.""")
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtInvPct)
        {
            ToolTip = 'Invoiced % of Prepayment Amt.';
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Prepmt Amt Deducted""")
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtDeductedPct)
        {
            ToolTip = 'Deducted % of Prepayment Amt. to Deduct';
            ApplicationArea = Basic;
        }
        modify("TotalSalesLine[1].""Prepmt Amt to Deduct""")
        {
            ApplicationArea = Basic;
        }
        modify("TempVATAmountLine4.COUNT")
        {
            Caption = 'No. of VAT Lines';
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""InvDiscountAmount_General"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VATAmount(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[1].Amount"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[1]"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitLCY[1]"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[1]"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""AdjProfitLCY[1]"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[1]"(Control 24)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitPct[1]"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitPct[1]"(Control 52)".


        //Unsupported feature: Property Deletion (Importance) on ""AdjProfitPct[1]"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[1].Quantity"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[1].Quantity"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[1].""Units per Parcel"""(Control 8)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[1].""Units per Parcel"""(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[1].""Net Weight"""(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[1].""Net Weight"""(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[1].""Gross Weight"""(Control 11)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[1].""Gross Weight"""(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[1].""Unit Volume"""(Control 2)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[1].""Unit Volume"""(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[1].""Unit Cost (LCY)"""(Control 37)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLineLCY[1].""Unit Cost (LCY)"""(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[1]"(Control 35)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalAdjCostLCY[1]"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)"""(Control 120)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)"""(Control 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfVATLines_General"(Control 119)".


        //Unsupported feature: Property Deletion (Importance) on ""NoOfVATLines_General"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""InvDiscountAmount_Invoicing"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[2].Amount"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[2]"(Control 67)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitLCY[2]"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitLCY[2]"(Control 75)".


        //Unsupported feature: Property Deletion (Importance) on ""AdjProfitLCY[2]"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[2]"(Control 66)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitPct[2]"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AdjProfitPct[2]"(Control 79)".


        //Unsupported feature: Property Deletion (Importance) on ""AdjProfitPct[2]"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[2].Quantity"(Control 65)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[2].Quantity"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[2].""Units per Parcel"""(Control 62)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[2].""Units per Parcel"""(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[2].""Net Weight"""(Control 64)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[2].""Net Weight"""(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[2].""Gross Weight"""(Control 63)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[2].""Gross Weight"""(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[2].""Unit Volume"""(Control 61)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[2].""Unit Volume"""(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[2].""Unit Cost (LCY)"""(Control 68)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLineLCY[2].""Unit Cost (LCY)"""(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[2]"(Control 17)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalAdjCostLCY[2]"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)"""(Control 122)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)"""(Control 122)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfVATLines_Invoicing"(Control 125)".


        //Unsupported feature: Property Deletion (Importance) on ""NoOfVATLines_Invoicing"(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].""Inv. Discount Amount"""(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[3].Amount"(Control 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLineLCY[3].""Unit Cost (LCY)"""(Control 102)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLineLCY[3].""Unit Cost (LCY)"""(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitLCY[3]"(Control 101)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitLCY[3]"(Control 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ProfitPct[3]"(Control 100)".


        //Unsupported feature: Property Deletion (Importance) on ""ProfitPct[3]"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].Quantity"(Control 99)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[3].Quantity"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].""Units per Parcel"""(Control 94)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[3].""Units per Parcel"""(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].""Net Weight"""(Control 98)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[3].""Net Weight"""(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].""Gross Weight"""(Control 97)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[3].""Gross Weight"""(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalSalesLine[3].""Unit Volume"""(Control 93)".


        //Unsupported feature: Property Deletion (Importance) on ""TotalSalesLine[3].""Unit Volume"""(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TempVATAmountLine3.COUNT"(Control 127)".


        //Unsupported feature: Property Deletion (Importance) on ""TempVATAmountLine3.COUNT"(Control 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PrepmtVATAmount(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TempVATAmountLine4.COUNT"(Control 130)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Credit Limit (LCY)"""(Control 28)".

    }

    //Unsupported feature: Property Modification (Id) on "VATLinesForm(Variable 1032)".

    //var
        //>>>> ORIGINAL VALUE:
        //VATLinesForm : 1032;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //VATLinesForm : 1044;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "UpdateInvDiscountQst(Variable 1056)".

    //var
        //>>>> ORIGINAL VALUE:
        //UpdateInvDiscountQst : ENU=One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //UpdateInvDiscountQst : ENU=There are one or more invoiced lines.\Do you want to update the invoice discount?;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;
        AllowInvDisc := NOT (SalesSetup."Calc. Inv. Discount" AND CustInvDiscRecExists("Invoice Disc. Code"));
        AllowVATDifference :=
          SalesSetup."Allow VAT Difference" AND
          NOT ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]);
        OnOpenPageOnBeforeSetEditable(AllowInvDisc,AllowVATDifference);
        VATLinesFormIsEditable := AllowVATDifference OR AllowInvDisc;
        CurrPage.EDITABLE := VATLinesFormIsEditable;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        VATLinesFormIsEditable := AllowVATDifference OR AllowInvDisc;
        CurrPage.EDITABLE := VATLinesFormIsEditable;
        */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetVATSpecification(PrevTab);
        ReleaseSalesDocument.CalcAndUpdateVATOnLines(Rec,SalesLine);
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetVATSpecification(PrevTab);
        IF TempVATAmountLine1.GetAnyLineModified OR TempVATAmountLine2.GetAnyLineModified THEN
          UpdateVATOnSalesLines;
        EXIT(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "RefreshOnAfterGetRecord(PROCEDURE 10)".

    //procedure RefreshOnAfterGetRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));

        IF PrevNo = "No." THEN
        #4..82
        TempVATAmountLine4.MODIFYALL(Modified,FALSE);

        PrevTab := -1;

        UpdateHeaderInfo(2,TempVATAmountLine2);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..85
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateInvDiscAmount(PROCEDURE 3)".

    //procedure UpdateInvDiscAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckAllowInvDisc;
        IF NOT (ModifiedIndexNo IN [1,2]) THEN
          EXIT;

        IF InvoicedLineExists THEN
          IF NOT ConfirmManagement.ConfirmProcess(UpdateInvDiscountQst,TRUE) THEN
            ERROR('');

        IF ModifiedIndexNo = 1 THEN
        #10..79
        MODIFY;

        UpdateVATOnSalesLines;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
          IF NOT CONFIRM(UpdateInvDiscountQst,FALSE) THEN
        #7..82
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "UpdateInvDiscAmount(PROCEDURE 3).ConfirmManagement(Variable 1006)".

}
