#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187002 pageextension52187002 extends "Service Technician Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900744308(Control 1900744308)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

    }
    actions
    {
        modify("Service &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Service Items Out of &Warranty")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item &Line Labels")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Item Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify(ServiceOrders)
        {

            //Unsupported feature: Property Modification (Name) on "ServiceOrders(Action 5)".

            ApplicationArea = Basic;
        }
        modify(ServiceOrdersInProcess)
        {

            //Unsupported feature: Property Modification (Name) on "ServiceOrdersInProcess(Action 17)".

            ApplicationArea = Basic;
        }
        modify("Service Item Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(Loaners)
        {
            ApplicationArea = Basic;
        }
        modify("Service Items")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(Action3)
        {
            ApplicationArea = Basic;
        }
        modify("&Loaner")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item &Worksheet")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Order"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Items Out of &Warranty"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item &Line Labels"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Item Worksheet"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceOrders(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceOrdersInProcess(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Lines"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Loaners(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Items"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action3(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Loaner"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item &Worksheet"(Action 10)".

    }
}
