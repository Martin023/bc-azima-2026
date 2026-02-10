#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187008 pageextension52187008 extends "Accounting Services RC" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control2(Control 2)".

    }
    actions
    {
        modify("Sales Quote")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""Sales Quote"(Action 5)".


            //Unsupported feature: Property Modification (Image) on ""Sales Quote"(Action 5)".

        }
        modify("Sales Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""Sales Invoice"(Action 4)".


            //Unsupported feature: Property Modification (Image) on ""Sales Invoice"(Action 4)".

        }
        modify(Customers)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on "Customers(Action 15)".

        }
        modify(Items)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on "Items(Action 10)".

        }
        modify("Posted Sales Invoices")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""Posted Sales Invoices"(Action 9)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Quote"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Invoice"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Invoices"(Action 9)".

    }
}
