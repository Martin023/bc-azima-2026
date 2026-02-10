#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186990 pageextension52186990 extends "Sales Manager Role Center"
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control11(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control6(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control31(Control 31)".

        modify("My User Tasks")
        {
            Visible = false;
        }
        // modify(Control41)
        // {
        //     Visible = false;
        // }
        addfirst(Control1900724808)
        {
            part(Control21; "Copy Profile")
            {
            }
        }
    }
    actions
    {
        modify("Customer - &Order Summary")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - &Top 10 List")
        {
            ApplicationArea = Basic;
        }
        // modify("S&ales Statistics")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Salesperson - Sales &Statistics")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Salesperson - &Commission")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Campaign - &Details")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Analysis Reports")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Analysis by Dimensions")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Budgets")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Quotes")
        {
            ApplicationArea = Basic;
        }
        modify(SalesOrders)
        {

            //Unsupported feature: Property Modification (Name) on "SalesOrders(Action 15)".

            ApplicationArea = Basic;
        }
        modify(SalesOrdersOpen)
        {

            //Unsupported feature: Property Modification (Name) on "SalesOrdersOpen(Action 7)".

            ApplicationArea = Basic;
        }
        // modify("Sales Orders - Microsoft Dynamics 365 for Sales")
        // {
        //     Caption = 'Dynamics CRM Sales Orders';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 36)".

        // }
        modify(SalesInvoices)
        {

            //Unsupported feature: Property Modification (Name) on "SalesInvoices(Action 35)".

            ApplicationArea = Basic;
        }
        modify(SalesInvoicesOpen)
        {

            //Unsupported feature: Property Modification (Name) on "SalesInvoicesOpen(Action 16)".

            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(Contacts)
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(Campaigns)
        {
            ApplicationArea = Basic;
        }
        modify(Segments)
        {
            ApplicationArea = Basic;
        }
        modify(Tasks)
        {
            Caption = 'To-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Tasks(Action 29)".

        }
        modify(Teams)
        {
            ApplicationArea = Basic;
        }
        modify("Salespeople/Purchasers")
        {
            ApplicationArea = Basic;
        }
        modify("Cust. Invoice Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Vend. Invoice Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Item Disc. Groups")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Price &Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Line &Discounts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - &Order Summary"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - &Top 10 List"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&ales Statistics"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson - Sales &Statistics"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson - &Commission"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign - &Details"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Analysis Reports"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Analysis by Dimensions"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Budgets"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Quotes"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrders(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrdersOpen(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesInvoices(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesInvoicesOpen(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contacts(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Campaigns(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Segments(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Tasks(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Teams(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespeople/Purchasers"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust. Invoice Discounts"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vend. Invoice Discounts"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Disc. Groups"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Price &Worksheet"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Prices"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Line &Discounts"(Action 10)".

    }
}
