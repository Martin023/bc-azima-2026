#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186563 pageextension52186563 extends "Source Documents"
{
    layout
    {
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Expected Receipt Date"(Control 18)".

        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shipment Date"(Control 22)".

        }
        modify("Put-away / Pick No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source Document")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Destination Type")
        {
            ApplicationArea = Basic;
        }
        modify("Destination No.")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Advice")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-away / Pick No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Advice"(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 25)".

    }
    var

        "Expected Receipt DateVisible": Boolean;

        "Shipment DateVisible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShipmentDateVisible := TRUE;
    ExpectedReceiptDateVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Shipment DateVisible" := TRUE;
    "Expected Receipt DateVisible" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetResult(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "UpdateVisible(PROCEDURE 2)".

    //procedure UpdateVisible();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpectedReceiptDateVisible := Type = Type::Inbound;
    ShipmentDateVisible := Type = Type::Outbound;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Expected Receipt DateVisible" := Type = Type::Inbound;
    "Shipment DateVisible" := Type = Type::Outbound;
    */
    //end;
}
