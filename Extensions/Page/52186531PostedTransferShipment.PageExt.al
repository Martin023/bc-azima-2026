#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186531 pageextension52186531 extends "Posted Transfer Shipment" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Code")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("In-Transit Code")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
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
        modify("Shipment Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Shipment Date"(Control 27)".

        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = Basic;
        }
        modify("Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Name")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Name 2")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Address")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from City")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-from Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Name 2")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Address")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to City")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Type")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Specification")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Method")
        {
            ApplicationArea = Basic;
        }
        modify("Area")
        {
            ApplicationArea = Basic;
        }
        modify("Entry/Exit Point")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Code"(Control 6)".

        modify("Direct Transfer")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""In-Transit Code"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Order No."(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Order Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 1 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 14)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 2 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "TransferShipmentLines(Control 49)".


        //Unsupported feature: Property Deletion (PartType) on "TransferShipmentLines(Control 49)".

        modify(Shipment)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receipt Date"(Control 29)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Name"(Control 16)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from City"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from City"(Control 26)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from City"(Control 26)".

        modify(Control13)
        {
            Visible = false;
        }
        modify("Transfer-from County")
        {
            Visible = false;
        }
        // modify("Transfer-from Post Code")
        // {
        //     Visible = false;
        // }
        modify("Trsf.-from Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Contact"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Contact"(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Contact"(Control 44)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Name 2"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Name 2"(Control 34)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Name 2"(Control 34)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Address"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Address"(Control 36)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Address"(Control 36)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Address 2"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Address 2"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Address 2"(Control 38)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to City"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to City"(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to City"(Control 42)".

        modify(Control21)
        {
            Visible = false;
        }
        modify("Transfer-to County")
        {
            Visible = false;
        }
        // modify("Transfer-to Post Code")
        // {
        //     Visible = false;
        // }
        modify("Trsf.-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry/Exit Point"(Control 78)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Transfer-from Address 2")
        {
            // field("Transfer-from Post Code";Rec."Transfer-from Post Code")
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;
            // }
        }
        addafter("Transfer-to Address 2")
        {
            // field("Transfer-to Post Code";Rec."Transfer-to Post Code")
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;
            // }
        }
        moveafter(TransferShipmentLines;"Transfer-from")
        moveafter("Shipping Agent Service Code";"Transfer-to")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 56)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 56)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Statistics(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 58)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 58)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 58)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Dimensions(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 51)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""&Print"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 52)".

    }

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
