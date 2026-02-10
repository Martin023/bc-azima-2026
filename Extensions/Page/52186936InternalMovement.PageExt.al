#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186936 pageextension52186936 extends "Internal Movement" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("To Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Assignment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Assignment Time")
        {
            ApplicationArea = Basic;
        }
        modify("Sorting Method")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Bin Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assignment Date"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assignment Time"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sorting Method"(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "InternalMovementLines(Control 97)".


        //Unsupported feature: Property Deletion (PartType) on "InternalMovementLines(Control 97)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control5(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(List)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Get Bin Content")
        {
            ApplicationArea = Basic;
        }
        modify("Create Inventory Movement")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Bin Content"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Inventory Movement"(Action 39)".

        addafter("Get Bin Content")
        {
            separator(Action34)
            {
            }
        }
    }
}
