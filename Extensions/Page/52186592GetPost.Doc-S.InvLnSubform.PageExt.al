#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186592 pageextension52186592 extends "Get Post.Doc - S.InvLn Subform"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
        }
        modify("SalesInvHeader.""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
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
        modify(QtyNotReturned)
        {
            ApplicationArea = Basic;
        }
        // modify(CalcQtyReturned)
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
        modify(UnitPrice)
        {
            ApplicationArea = Basic;
        }
        modify(LineAmount)
        {
            ApplicationArea = Basic;
        }
        modify("SalesInvHeader.""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("SalesInvHeader.""Prices Including VAT""")
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
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SalesInvHeader.""Posting Date"""(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyNotReturned(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcQtyReturned(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevUnitCostLCY(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnitPrice(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineAmount(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SalesInvHeader.""Currency Code"""(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SalesInvHeader.""Prices Including VAT"""(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 74)".


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
    IsHandled := FALSE;
    OnBeforeIsShowRec(Rec,SalesInvLine2,ReturnValue,IsHandled);
    IF IsHandled THEN
      EXIT(ReturnValue);

    WITH SalesInvLine2 DO BEGIN
      QtyNotReturned := 0;
      IF "Document No." <> SalesInvHeader."No." THEN
        SalesInvHeader.GET("Document No.");
      IF SalesInvHeader."Prepayment Invoice" THEN
        EXIT(FALSE);
      IF RevQtyFilter THEN BEGIN
        IF SalesInvHeader."Currency Code" <> ToSalesHeader."Currency Code" THEN
          EXIT(FALSE);
    #15..21
        EXIT(TRUE);
      EXIT(QtyNotReturned > 0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..9
    #12..24
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

    //Unsupported feature: Deletion (VariableCollection) on "IsShowRec(PROCEDURE 3).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "IsShowRec(PROCEDURE 3).ReturnValue(Variable 1002)".

}
