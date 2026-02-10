#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186596 pageextension52186596 extends "Get Post.Doc - P.RcptLn Sbfrm"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Vendor No.")
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
        modify("Qty. Rcd. Not Invoiced")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Vendor No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Rcd. Not Invoiced"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingQty(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcAppliedQty(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevUnitCostLCY(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 82)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 1902759804)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900206204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1901652604)".

    }
    var
        ToPurchHeader: Record "Purchase Header";

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

    //Unsupported feature: Parameter Insertion (Parameter: NewToPurchHeader) (ParameterCollection) on "Initialize(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "Initialize(PROCEDURE 4)".

    //procedure Initialize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RevQtyFilter := NewRevQtyFilter;
    FillExactCostReverse := NewFillExactCostReverse;
    Visible := NewVisible;

    IF Visible THEN BEGIN
      TempPurchRcptLine.RESET;
      TempPurchRcptLine.DELETEALL;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ToPurchHeader := NewToPurchHeader;
    #1..8
    */
    //end;

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
