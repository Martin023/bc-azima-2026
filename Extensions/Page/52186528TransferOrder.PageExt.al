#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186528 pageextension52186528 extends "Transfer Order"
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
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Shipment Date"(Control 32)".

        }
        modify("Outbound Whse. Handling Time")
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

            //Unsupported feature: Property Insertion (Importance) on ""Shipping Agent Code"(Control 72)".

        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Time")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Advice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""Shipping Advice"(Control 70)".

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
        // modify(Control24)
        // {

        //     //Unsupported feature: Property Modification (ControlType) on "Control24(Control 24)".


        //     //Unsupported feature: Property Modification (Name) on "Control24(Control 24)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on "Control24(Control 24)".

        //     //ApplicationArea = Basic;
        // }
        modify("Transfer-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Inbound Whse. Handling Time")
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


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Code"(Control 14)".


        //Unsupported feature: Property Deletion (Editable) on ""Transfer-from Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Code"(Control 34)".


        //Unsupported feature: Property Deletion (Editable) on ""Transfer-to Code"(Control 34)".

        modify("Direct Transfer")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""In-Transit Code"(Control 8)".


        //Unsupported feature: Property Deletion (Enabled) on ""In-Transit Code"(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on ""In-Transit Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 1 Code"(Control 10)".


        //Unsupported feature: Property Deletion (Editable) on ""Shortcut Dimension 1 Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 2 Code"(Control 12)".


        //Unsupported feature: Property Deletion (Editable) on ""Shortcut Dimension 2 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 106)".


        //Unsupported feature: Property Deletion (Importance) on ""Assigned User ID"(Control 106)".


        //Unsupported feature: Property Deletion (Editable) on ""Assigned User ID"(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "TransferLines(Control 55)".


        //Unsupported feature: Property Deletion (PartType) on "TransferLines(Control 55)".


        //Unsupported feature: Property Deletion (UpdatePropagation) on "TransferLines(Control 55)".

        modify(Shipment)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Whse. Handling Time"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 74)".


        //Unsupported feature: Property Deletion (Importance) on ""Shipping Agent Service Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Time"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Advice"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receipt Date"(Control 52)".


        //Unsupported feature: Property Deletion (Editable) on ""Transfer-from"(Control 1904655901)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Name"(Control 16)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Name 2"(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-from Address"(Control 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-from Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from City"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from City"(Control 26)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from City"(Control 26)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-from City"(Control 26)".

        modify(Control17)
        {
            Visible = false;
        }
        modify("Transfer-from County")
        {
            Visible = false;
        }
        modify("Transfer-from Post Code")
        {
            Visible = false;
        }
        modify("Trsf.-from Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-from Contact"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Contact"(Control 49)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-from Contact"(Control 49)".


        //Unsupported feature: Property Deletion (Editable) on ""Transfer-to"(Control 1901454601)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Name"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Name"(Control 36)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Name 2"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Name 2"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Name 2"(Control 38)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to City"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to City"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to City"(Control 46)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Transfer-to City"(Control 46)".


        //Unsupported feature: Property Deletion (Visible) on "Control24(Control 24)".


        //Unsupported feature: Property Deletion (GroupType) on "Control24(Control 24)".

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

        //Unsupported feature: Property Deletion (CaptionML) on ""Transfer-to Contact"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Contact"(Control 51)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer-to Contact"(Control 51)".

        modify(Control19)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Whse. Handling Time"(Control 91)".


        //Unsupported feature: Property Deletion (Editable) on ""Foreign Trade"(Control 1907468901)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry/Exit Point"(Control 83)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Transfer-to Address 2")
        {
            // field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        moveafter(TransferLines; "Transfer-from")
        moveafter("Transfer-from Address 2"; Control24)
        moveafter("Transfer-from Post Code"; "Transfer-from City")
        moveafter("Shipping Advice"; "Transfer-to")
        moveafter("Transfer-to City"; "Transfer-to Contact")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 27)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("S&hipments")
        {
            ApplicationArea = Basic;
        }
        modify("Re&ceipts")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Shi&pments")
        {
            ApplicationArea = Basic;
        }
        modify("&Whse. Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 69)".

        }
        modify("Re&lease")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Re&lease"(Action 59)".

        }
        modify("Reo&pen")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Reo&pen"(Action 48)".

        }
        modify("Create Whse. S&hipment")
        {
            ApplicationArea = Basic;
        }
        modify("Create &Whse. Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            ApplicationArea = Basic;
        }
        modify("Get Bin Content")
        {
            ApplicationArea = Basic;
        }
        // modify(Post)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Post(Action 66)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 66)".


        //     //Unsupported feature: Property Insertion (RunObject) on "Post(Action 66)".

        // }
        // modify(PostAndPrint)
        // {

            //Unsupported feature: Property Modification (Name) on "PostAndPrint(Action 67)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "PostAndPrint(Action 67)".


        //     //Unsupported feature: Property Insertion (RunObject) on "PostAndPrint(Action 67)".

        // }
        modify("Inventory - Inbound Transfer")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 27)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 65)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 65)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 65)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&hipments"(Action 81)".


        //Unsupported feature: Property Deletion (Promoted) on ""S&hipments"(Action 81)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""S&hipments"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&ceipts"(Action 82)".


        //Unsupported feature: Property Deletion (Promoted) on ""Re&ceipts"(Action 82)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Re&ceipts"(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Shi&pments"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Whse. Receipts"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In&vt. Put-away/Pick Lines"(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&lease"(Action 59)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Re&lease"(Action 59)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Re&lease"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reo&pen"(Action 48)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Reo&pen"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Whse. S&hipment"(Action 5778)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Whse. Receipt"(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Inventor&y Put-away/Pick"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Bin Content"(Action 95)".

        modify(GetReceiptLines)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 66)".

        modify(PostAndPrint)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - Inbound Transfer"(Action 1901320106)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Inventory - Inbound Transfer"(Action 1901320106)".

    }


    //Unsupported feature: Code Modification on "ShipmentDateOnAfterValidate(PROCEDURE 19068710)".

    //procedure ShipmentDateOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "ShippingAgentServiceCodeOnAfte(PROCEDURE 19046563)".

    //procedure ShippingAgentServiceCodeOnAfte();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "ShippingAgentCodeOnAfterValida(PROCEDURE 19008956)".

    //procedure ShippingAgentCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "ShippingTimeOnAfterValidate(PROCEDURE 19029567)".

    //procedure ShippingTimeOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "OutboundWhseHandlingTimeOnAfte(PROCEDURE 19078070)".

    //procedure OutboundWhseHandlingTimeOnAfte();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "ReceiptDateOnAfterValidate(PROCEDURE 19074743)".

    //procedure ReceiptDateOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "InboundWhseHandlingTimeOnAfter(PROCEDURE 19076948)".

    //procedure InboundWhseHandlingTimeOnAfter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
