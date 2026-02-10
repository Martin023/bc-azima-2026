#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186790 pageextension52186790 extends "Posted Return Receipts" 
{
    Caption = 'Posted Return Receipts';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer Name")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
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
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 61)".

        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Post Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Country/Region Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Country/Region Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 1102601003)".

        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 1102601005)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 22)".

        modify("Update Document")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        HasFilters := GETFILTERS <> '';
        SetSecurityFilterOnRespCenter;
        IF HasFilters THEN
          IF FINDFIRST THEN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).

}
