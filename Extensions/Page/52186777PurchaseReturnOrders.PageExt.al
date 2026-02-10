#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186777 pageextension52186777 extends "Purchase Return Orders" 
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Quantity"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Show Document")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 33)".

        // modify(ActionContainer3)
        // {
        //     Visible = false;
        // }
        // modify("Delete Invoiced Orders")
        // {
        //     Visible = false;
        // }
    }
}
