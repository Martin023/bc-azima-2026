#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186530 pageextension52186530 extends "Transfer Orders" 
{

    //Unsupported feature: Property Modification (Name) on ""Transfer Orders"(Page 5742)".

    Caption = 'Transfer List';
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
        modify(Status)
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
        modify("Shipment Date")
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
        modify("Receipt Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-from Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer-to Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In-Transit Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 21)".

        modify("Direct Transfer")
        {
            Visible = false;
        }

        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 10)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
            /*
            DimMgt.LookupDimValueCodeNoUpdate(1);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 10)".



        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 12)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
            /*
            DimMgt.LookupDimValueCodeNoUpdate(2);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 19)".


        //Unsupported feature: Property Deletion (Visible) on ""Assigned User ID"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 1102601023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 1102601025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Advice"(Control 1102601027)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receipt Date"(Control 1102601029)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601002)".

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

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 150)".

        }
        modify("Re&lease")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Re&lease"(Action 15)".

        }
        modify("Reo&pen")
        {
            ApplicationArea = Basic;
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

        //     //Unsupported feature: Property Modification (Name) on "Post(Action 1102601019)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 1102601019)".


        //     //Unsupported feature: Property Insertion (RunObject) on "Post(Action 1102601019)".

        // }
        // modify(PostAndPrint)
        // {

        //     //Unsupported feature: Property Modification (Name) on "PostAndPrint(Action 1102601020)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "PostAndPrint(Action 1102601020)".


        //     //Unsupported feature: Property Insertion (RunObject) on "PostAndPrint(Action 1102601020)".

        // }
        modify("Inventory - Inbound Transfer")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601002)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601003)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 1102601003)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601006)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1102601006)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 1102601006)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&hipments"(Action 1102601004)".


        //Unsupported feature: Property Deletion (Promoted) on ""S&hipments"(Action 1102601004)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""S&hipments"(Action 1102601004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&ceipts"(Action 1102601005)".


        //Unsupported feature: Property Deletion (Promoted) on ""Re&ceipts"(Action 1102601005)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Re&ceipts"(Action 1102601005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Shi&pments"(Action 1102601007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Whse. Receipts"(Action 1102601008)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In&vt. Put-away/Pick Lines"(Action 1102601009)".

        modify("Transfer Routes")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 150)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&lease"(Action 15)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Re&lease"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reo&pen"(Action 1102601017)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reo&pen"(Action 1102601017)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reo&pen"(Action 1102601017)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Reo&pen"(Action 1102601017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Whse. S&hipment"(Action 1102601013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Whse. Receipt"(Action 1102601012)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Inventor&y Put-away/Pick"(Action 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Bin Content"(Action 1102601015)".

        modify(Post)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 1102601019)".

        modify(PostAndPrint)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 1102601020)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - Inbound Transfer"(Action 1901320106)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Inventory - Inbound Transfer"(Action 1901320106)".

    }

    var
        DimMgt: Codeunit DimensionManagement;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
