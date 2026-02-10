#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185698 pageextension52185698 extends "Purchase Order Statistics" 
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
        modify("Total_General")
        {
            ApplicationArea = Basic;
        }
        modify("VATAmount[1]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalInclVAT_General")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLineLCY[1].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity_General")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfVATLines_General")
        {
            Caption = 'No. of VAT Lines';
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[2].""Line Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("InvDiscountAmount_Invoicing")
        {

            //Unsupported feature: Property Modification (Name) on ""InvDiscountAmount_Invoicing"(Control 57)".

            ApplicationArea = Basic;
        }
        modify("Total_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("VATAmount_Invoicing")
        {

            //Unsupported feature: Property Modification (Name) on ""VATAmount_Invoicing"(Control 47)".

            ApplicationArea = Basic;
        }
        modify("TotalInclVAT_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLineLCY[2].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity_Invoicing")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[2].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[2].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[2].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[2].""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfVATLines_Invoicing")
        {
            Caption = 'No. of VAT Lines';
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Line Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Inv. Discount Amount""")
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
        modify("TotalInclVAT_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLineLCY[3].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity_Shipping")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[3].""Unit Volume""")
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
        modify("TotalPurchLine[1].""Prepmt. Amt. Inv.""")
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtInvPct)
        {
            ToolTip = 'Invoiced % of Prepayment Amt.';
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Prepmt Amt Deducted""")
        {
            ApplicationArea = Basic;
        }
        modify(PrepmtDeductedPct)
        {
            ToolTip = 'Deducted % of Prepayment Amt. to Deduct';
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine[1].""Prepmt Amt to Deduct""")
        {
            ApplicationArea = Basic;
        }
        modify("TempVATAmountLine4.COUNT")
        {
            ApplicationArea = Basic;
        }
        modify("Vend.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "LineAmountGeneral(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""InvDiscountAmount_General"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total_General"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VATAmount[1]"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalInclVAT_General"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLineLCY[1].Amount"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity_General"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[1].""Units per Parcel"""(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[1].""Net Weight"""(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[1].""Gross Weight"""(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[1].""Unit Volume"""(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfVATLines_General"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[2].""Line Amount"""(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""InvDiscountAmount_Invoicing"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total_Invoicing"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VATAmount_Invoicing"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalInclVAT_Invoicing"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLineLCY[2].Amount"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity_Invoicing"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[2].""Units per Parcel"""(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[2].""Net Weight"""(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[2].""Gross Weight"""(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[2].""Unit Volume"""(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfVATLines_Invoicing"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Line Amount"""(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Inv. Discount Amount"""(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalAmount1[3]"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VATAmount[3]"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalInclVAT_Shipping"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLineLCY[3].Amount"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity_Shipping"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Units per Parcel"""(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Net Weight"""(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Gross Weight"""(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine[3].""Unit Volume"""(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TempVATAmountLine3.COUNT"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PrepmtVATAmount(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PrepmtTotalAmount2(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TempVATAmountLine4.COUNT"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vend.""Balance (LCY)"""(Control 131)".

    }

    //Unsupported feature: Property Modification (TextConstString) on "UpdateInvDiscountQst(Variable 1022)".

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
        PurchSetup.GET;
        AllowInvDisc :=
          NOT (PurchSetup."Calc. Inv. Discount" AND VendInvDiscRecExists("Invoice Disc. Code"));
        AllowVATDifference :=
          PurchSetup."Allow VAT Difference" AND
          NOT ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]);
        OnOpenPageOnBeforeSetEditable(AllowInvDisc,AllowVATDifference);
        VATLinesFormIsEditable := AllowVATDifference OR AllowInvDisc;
        CurrPage.EDITABLE := VATLinesFormIsEditable;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
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
        ReleasePurchaseDocument.CalcAndUpdateVATOnLines(Rec,PurchLine);
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetVATSpecification(PrevTab);
        IF TempVATAmountLine1.GetAnyLineModified OR TempVATAmountLine2.GetAnyLineModified THEN
          UpdateVATOnPurchLines;
        EXIT(TRUE);
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
        #10..78
        "Invoice Discount Value" := TotalPurchLine[1]."Inv. Discount Amount";
        MODIFY;
        UpdateVATOnPurchLines;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
          IF NOT CONFIRM(UpdateInvDiscountQst,FALSE) THEN
        #7..81
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "UpdateVATOnPurchLines(PROCEDURE 1)".


    //Unsupported feature: Property Insertion (Local) on "UpdateVATOnPurchLines(PROCEDURE 1)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateInvDiscAmount(PROCEDURE 3).ConfirmManagement(Variable 1006)".

}
