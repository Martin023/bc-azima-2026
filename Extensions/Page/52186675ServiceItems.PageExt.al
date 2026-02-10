#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186675 pageextension52186675 extends "Service Items" 
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
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Starting Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Starting Date (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Labor)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Parts)"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Parts)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Labor)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Labor)"(Control 47)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Service Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Warranty Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("&Trendscape")
        {
            ApplicationArea = Basic;
        }
        modify("L&og")
        {
            ApplicationArea = Basic;
        }
        modify("Com&ponents")
        {
            ApplicationArea = Basic;
        }
        modify(ServiceItemGroup)
        {

            //Unsupported feature: Property Modification (Name) on "ServiceItemGroup(Action 44)".

            ApplicationArea = Basic;
        }
        modify(ServiceItem)
        {

            //Unsupported feature: Property Modification (Name) on "ServiceItem(Action 45)".

            ApplicationArea = Basic;
        }
        modify(Item)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ledger E&ntries"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warranty Ledger Entries"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Trendscape"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""L&og"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Com&ponents"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceItemGroup(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceItem(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Item(Action 46)".

        addafter("Co&mments")
        {
            separator(Action18)
            {
            }
        }
        addafter("L&og")
        {
            separator(Action36)
            {
            }
        }
    }
}
