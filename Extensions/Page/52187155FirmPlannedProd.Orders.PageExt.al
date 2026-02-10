#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187155 pageextension52187155 extends "Firm Planned Prod. Orders" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Routing No.")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
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
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {

            //Unsupported feature: Property Modification (Name) on ""Starting Time"(Control 14)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Starting Time"(Control 14)".


            //Unsupported feature: Property Modification (Visible) on ""Starting Time"(Control 14)".

        }
        modify("Starting Date")
        {

            //Unsupported feature: Property Modification (Name) on ""Starting Date"(Control 16)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Starting Date"(Control 16)".

        }
        modify("Ending Time")
        {

            //Unsupported feature: Property Modification (Name) on ""Ending Time"(Control 18)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ending Time"(Control 18)".


            //Unsupported feature: Property Modification (Visible) on ""Ending Time"(Control 18)".

        }
        modify("Ending Date")
        {

            //Unsupported feature: Property Modification (Name) on ""Ending Date"(Control 20)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ending Date"(Control 20)".

        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Finished Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Search Description")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Routing No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 53)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Starting Time"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 14)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Starting Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 16)".


        //Unsupported feature: Property Deletion (Visible) on ""Starting Date"(Control 16)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ending Time"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ending Date"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 20)".


        //Unsupported feature: Property Deletion (Visible) on ""Ending Date"(Control 20)".

        modify("Starting Date-Time")
        {
            Visible = false;
        }
        modify("Ending Date-Time")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finished Date"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 1102601002)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Item Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Capacity Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Value Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Warehouse Entries")
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
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Change &Status")
        {
            ApplicationArea = Basic;
        }
        modify("&Update Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order - Detail Calc.")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order - Precalc. Time")
        {
            ApplicationArea = Basic;
        }
        modify("Production Order - Comp. and Routing")
        {
            ApplicationArea = Basic;
        }
        // modify(ProdOrderJobCard)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ProdOrderJobCard(Action 1903594306)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "ProdOrderJobCard(Action 1903594306)".

        // }
        // modify(ProdOrderMaterialRequisition)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ProdOrderMaterialRequisition(Action 1902917606)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "ProdOrderMaterialRequisition(Action 1902917606)".

        // }
        modify("Production Order List")
        {
            ApplicationArea = Basic;
        }
        // modify(ProdOrderShortageList)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ProdOrderShortageList(Action 1903746906)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "ProdOrderShortageList(Action 1903746906)".

        // }
        modify("Production Order Statistics")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger E&ntries"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Ledger Entries"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Entries"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warehouse Entries"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change &Status"(Action 152)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Update Unit Cost"(Action 151)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order - Detail Calc."(Action 1903759606)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order - Precalc. Time"(Action 1905556906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Order - Comp. and Routing"(Action 1906587906)".

        modify(ProdOrderJobCard)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ProdOrderJobCard(Action 1903594306)".

        modify(ProdOrderMaterialRequisition)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ProdOrderMaterialRequisition(Action 1902917606)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Order List"(Action 1906372006)".

        modify(ProdOrderShortageList)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ProdOrderShortageList(Action 1903746906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Order Statistics"(Action 1901854406)".

        addafter(Dimensions)
        {
            separator(Action31)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
