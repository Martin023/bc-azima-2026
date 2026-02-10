#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186561 pageextension52186561 extends "Source Document Filter Card"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Source No. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Item No. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Show Filter Request")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Return Orders")
        {
            ApplicationArea = Basic;
            Enabled = "Sales Return OrdersEnable";
        }
        modify("Purchase Orders")
        {
            ApplicationArea = Basic;
            Enabled = "Purchase OrdersEnable";
        }
        modify("Inbound Transfers")
        {
            ApplicationArea = Basic;
            Enabled = "Inbound TransfersEnable";
        }
        modify("Shipping Agent Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Service Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Do Not Fill Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
            Enabled = "Sales OrdersEnable";
        }
        modify("Service Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Return Orders")
        {
            ApplicationArea = Basic;
            Enabled = "Purchase Return OrdersEnable";
        }
        modify("Outbound Transfers")
        {
            ApplicationArea = Basic;
            Enabled = "Outbound TransfersEnable";
        }
        modify(Partial)
        {
            ApplicationArea = Basic;
        }
        modify(Complete)
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("In-Transit Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Code Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No. Filter")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No. Filter"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No. Filter"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code Filter"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Filter"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code Filter"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Filter Request"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Return Orders"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Transfers"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code Filter"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Filter"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Do Not Fill Qty. to Handle"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Return Orders"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Transfers"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Partial(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Complete(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No. Filter"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No. Filter"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In-Transit Code Filter"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Code Filter"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Code Filter"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No. Filter"(Control 7)".

    }
    actions
    {
        modify(Run)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Run(Action 17)".

    }
    var

        "Sales OrdersEnable": Boolean;

        "Purchase Return OrdersEnable": Boolean;

        "Outbound TransfersEnable": Boolean;

        "Purchase OrdersEnable": Boolean;

        "Sales Return OrdersEnable": Boolean;

        "Inbound TransfersEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShippingAgentServiceFilterEnab := TRUE;
    ShippingAgentCodeFilterEnable := TRUE;
    InboundTransfersEnable := TRUE;
    SalesReturnOrdersEnable := TRUE;
    PurchaseOrdersEnable := TRUE;
    OutboundTransfersEnable := TRUE;
    PurchaseReturnOrdersEnable := TRUE;
    SalesOrdersEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShippingAgentServiceFilterEnab := TRUE;
    ShippingAgentCodeFilterEnable := TRUE;
    "Inbound TransfersEnable" := TRUE;
    "Sales Return OrdersEnable" := TRUE;
    "Purchase OrdersEnable" := TRUE;
    "Outbound TransfersEnable" := TRUE;
    "Purchase Return OrdersEnable" := TRUE;
    "Sales OrdersEnable" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetOneCreatedShptHeader(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetOneCreatedReceiptHeader(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "EnableControls(PROCEDURE 2)".

    //procedure EnableControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE Type OF
      Type::Inbound:
        BEGIN
          SalesOrdersEnable := FALSE;
          PurchaseReturnOrdersEnable := FALSE;
          OutboundTransfersEnable := FALSE;
        END;
      Type::Outbound:
        BEGIN
          PurchaseOrdersEnable := FALSE;
          SalesReturnOrdersEnable := FALSE;
          InboundTransfersEnable := FALSE;
        END;
    END;
    IF "Sales Orders" OR "Inbound Transfers" OR "Outbound Transfers" THEN BEGIN
    #16..18
      ShippingAgentCodeFilterEnable := FALSE;
      ShippingAgentServiceFilterEnab := FALSE;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
          "Sales OrdersEnable" := FALSE;
          "Purchase Return OrdersEnable" := FALSE;
          "Outbound TransfersEnable" := FALSE;
    #7..9
          "Purchase OrdersEnable" := FALSE;
          "Sales Return OrdersEnable" := FALSE;
          "Inbound TransfersEnable" := FALSE;
    #13..21
    */
    //end;
}
