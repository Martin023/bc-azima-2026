#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185534 pageextension52185534 extends "Item Availability by Periods" 
{
    layout
    {
        modify(PeriodType)
        {
            ToolTip = 'Day';
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "ItemAvailLines(Control 5)".

    }
    actions
    {
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".

        addafter("Event")
        {
            action(Period)
            {
                ApplicationArea = Basic;
                Caption = 'Period';
                Image = Period;
                RunObject = Page "Item Availability by Periods";
                RunPageLink = "No."=field("No."),
                              "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"),
                              "Location Filter"=field("Location Filter"),
                              "Drop Shipment Filter"=field("Drop Shipment Filter"),
                              "Variant Filter"=field("Variant Filter");
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetLastDate(PROCEDURE 2)".

}
