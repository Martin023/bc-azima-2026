#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186597 pageextension52186597 extends "Get Post.Doc - P.InvLn Subform"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
        }
        modify("PurchInvHeader.""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify(RemainingQty)
        {
            ApplicationArea = Basic;
        }
        // modify(CalcAppliedQty)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(RevUnitCostLCY)
        {
            ApplicationArea = Basic;
        }
        modify(DirectUnitCost)
        {
            ApplicationArea = Basic;
        }
        modify(LineAmount)
        {
            ApplicationArea = Basic;
        }
        modify("PurchInvHeader.""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("PurchInvHeader.""Prices Including VAT""")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""PurchInvHeader.""Posting Date"""(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingQty(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcAppliedQty(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevUnitCostLCY(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DirectUnitCost(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineAmount(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""PurchInvHeader.""Currency Code"""(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""PurchInvHeader.""Prices Including VAT"""(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 32)".

    }
    actions
    {
        modify("Show Document")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 1903099004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900545404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1901991804)".

    }
    var

        "Document No.HideValue": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoHideValue := FALSE;
    DocumentNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Document No.HideValue" := FALSE;
    DocumentNoOnFormat;
    */
    //end;


    //Unsupported feature: Code Modification on "IsShowRec(PROCEDURE 3)".

    //procedure IsShowRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchInvLine2 DO BEGIN
      RemainingQty := 0;
      IF "Document No." <> PurchInvHeader."No." THEN
        PurchInvHeader.GET("Document No.");
      IF PurchInvHeader."Prepayment Invoice" THEN
        EXIT(FALSE);
      IF RevQtyFilter THEN BEGIN
        IF PurchInvHeader."Currency Code" <> ToPurchHeader."Currency Code" THEN
          EXIT(FALSE);
    #10..18
        EXIT(TRUE);
      EXIT(RemainingQty > 0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #7..21
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "GetSelectedLine(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "DocumentNoOnFormat(PROCEDURE 19001080)".

    //procedure DocumentNoOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT IsFirstDocLine THEN
      DocumentNoHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT IsFirstDocLine THEN
      "Document No.HideValue" := TRUE;
    */
    //end;
}
