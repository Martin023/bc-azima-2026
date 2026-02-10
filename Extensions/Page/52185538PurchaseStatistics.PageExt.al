#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185538 pageextension52185538 extends "Purchase Statistics" 
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
        modify("TotalPurchLineLCY.Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine.""Units per Parcel""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine.""Net Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine.""Gross Weight""")
        {
            ApplicationArea = Basic;
        }
        modify("TotalPurchLine.""Unit Volume""")
        {
            ApplicationArea = Basic;
        }
        modify("Vend.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InvDiscountAmount(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount1(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VATAmount(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount2(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLineLCY.Amount"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine.""Units per Parcel"""(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine.""Net Weight"""(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine.""Gross Weight"""(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalPurchLine.""Unit Volume"""(Control 71)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SubForm(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vend.""Balance (LCY)"""(Control 67)".

    }
    var
        PurchLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: PurchLine)()
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
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);
        CLEAR(PurchPost);

        PurchPost.GetPurchLines(Rec,TempPurchLine,0);
        CLEAR(PurchPost);
        PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText);

        IF "Prices Including VAT" THEN BEGIN
          TotalAmount2 := TotalPurchLine.Amount;
          TotalAmount1 := TotalAmount2 + VATAmount;
          TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
          TotalAmount1 := TotalPurchLine.Amount;
          TotalAmount2 := TotalPurchLine."Amount Including VAT";
        END;

        IF Vend.GET("Pay-to Vendor No.") THEN
          Vend.CALCFIELDS("Balance (LCY)")
        ELSE
          CLEAR(Vend);

        PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified,FALSE);
        SetVATSpecification;
        */
    //end;


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
        CurrPage.EDITABLE := AllowVATDifference OR AllowInvDisc;
        SetVATSpecification;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        CurrPage.EDITABLE := AllowVATDifference OR AllowInvDisc;
        SetVATSpecification;
        */
    //end;
}
