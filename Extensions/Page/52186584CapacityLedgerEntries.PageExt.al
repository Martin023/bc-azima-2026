#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186584 pageextension52186584 extends "Capacity Ledger Entries" 
{
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Type")
        {
            ApplicationArea = Basic;
        }
        modify("Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Routing No.")
        {
            ApplicationArea = Basic;
        }
        modify("Routing Reference No.")
        {
            ApplicationArea = Basic;
        }
        modify("Work Center No.")
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
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Operation No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Work Shift Code")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Time")
        {
            ApplicationArea = Basic;
        }
        modify("Concurrent Capacity")
        {
            ApplicationArea = Basic;
        }
        modify("Setup Time")
        {
            ApplicationArea = Basic;
        }
        modify("Run Time")
        {
            ApplicationArea = Basic;
        }
        modify("Stop Time")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Output Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Scrap Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Overhead Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Cost (ACY)")
        {
            ApplicationArea = Basic;
        }
        modify("Overhead Cost (ACY)")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Stop Code")
        {
            ApplicationArea = Basic;
        }
        modify("Scrap Code")
        {
            ApplicationArea = Basic;
        }
        modify("Completely Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Routing No."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Routing Reference No."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Center No."(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Operation No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Shift Code"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Concurrent Capacity"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Setup Time"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run Time"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stop Time"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Output Quantity"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Quantity"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Cost"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Overhead Cost"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Cost (ACY)"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Overhead Cost (ACY)"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stop Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Code"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Completely Invoiced"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 56)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Value Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 42)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Value Entries"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 8)".

    }

    //Unsupported feature: Property Modification (Id) on "GetCaption(PROCEDURE 3).WorkCenter(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "GetCaption(PROCEDURE 3).ProdOrder(Variable 1004)".


    //Unsupported feature: Property Insertion (Length) on "GetCaption(PROCEDURE 3).SourceFilter(Variable 1001)".


    //Unsupported feature: Move on "GetCaption(PROCEDURE 3).SourceTableName(Variable 1002)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).

}
