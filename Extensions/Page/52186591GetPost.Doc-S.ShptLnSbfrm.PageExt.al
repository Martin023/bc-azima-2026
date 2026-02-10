#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186591 pageextension52186591 extends "Get Post.Doc - S.ShptLn Sbfrm"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
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
        modify("Qty. Shipped Not Invoiced")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Shipped Not Invoiced"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyNotReturned(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcQtyReturned(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevUnitCostLCY(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 32)".

    }
    actions
    {
        modify(ShowDocument)
        {

            //Unsupported feature: Property Modification (Name) on "ShowDocument(Action 1902759804)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(ItemTrackingLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingLines(Action 1901652604)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDocument(Action 1902759804)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900206204)".


        //Unsupported feature: Code Modification on "ItemTrackingLines(Action 1901652604).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemTrackingLines;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostedShipmentItemTrackingLns;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 1901652604)".

    }

    var
        ToSalesHeader: Record "Sales Header";

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
    OnBeforeIsShowRec(Rec,SalesShptLine2,ReturnValue,IsHandled);
    IF IsHandled THEN
      EXIT(ReturnValue);

    WITH SalesShptLine2 DO BEGIN
      QtyNotReturned := 0;
      IF RevQtyFilter AND (Type = Type::" ") THEN
    #9..13
        EXIT(TRUE);
      EXIT(QtyNotReturned > 0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..16
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: NewToSalesHeader) (ParameterCollection) on "Initialize(PROCEDURE 4)".


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
      TempSalesShptLine.RESET;
      TempSalesShptLine.DELETEALL;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ToSalesHeader := NewToSalesHeader;
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

    //Unsupported feature: Variable Insertion (Variable: SalesShptHeader) (VariableCollection) on "ShowDocument(PROCEDURE 7)".


    //Unsupported feature: Property Deletion (Attributes) on "OnBeforeIsShowRec(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeIsShowRec(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "OnBeforeIsShowRec(PROCEDURE 7)".

    //procedure OnBeforeIsShowRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT SalesShptHeader.GET("Document No.") THEN
      EXIT;
    PAGE.RUN(PAGE::"Posted Sales Shipment",SalesShptHeader);
    */
    //end;

    local procedure PostedShipmentItemTrackingLns()
    begin
        GetSelectedLine(Rec);
        Rec.ShowItemTrackingLines;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "IsShowRec(PROCEDURE 3).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "IsShowRec(PROCEDURE 3).ReturnValue(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeIsShowRec(PROCEDURE 7).SalesShipmentLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeIsShowRec(PROCEDURE 7).SalesShipmentLine2(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeIsShowRec(PROCEDURE 7).ReturnValue(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeIsShowRec(PROCEDURE 7).IsHandled(Parameter 1003)".

}
