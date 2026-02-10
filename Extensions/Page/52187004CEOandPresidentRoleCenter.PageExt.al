#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187004 pageextension52187004 extends "CEO and President Role Center"
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control24(Control 24)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control27(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control28(Control 28)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control29(Control 29)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control25(Control 25)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control1907692008)
        {
            part(Control26; "Copy Profile")
            {
            }
        }
    }
    actions
    {
        modify("Recei&vables-Payables")
        {
            ApplicationArea = Basic;
        }
        modify("&Trial Balance/Budget")
        {
            ApplicationArea = Basic;
        }
        modify("&Closing Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("&Fiscal Year Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - &Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - T&op 10 List")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - S&ales List")
        {
            ApplicationArea = Basic;
        }
        // modify("Sales &Statistics")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Vendor - &Purchase List")
        {
            ApplicationArea = Basic;
        }
        modify("Account Schedules")
        {
            ApplicationArea = Basic;
        }
        modify("Analysis by Dimensions")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Analysis Report")
        {
            ApplicationArea = Basic;
        }
        modify(Budgets)
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
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Invoices")
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(Contacts)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Recei&vables-Payables"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Trial Balance/Budget"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Closing Trial Balance"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fiscal Year Balance"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - &Balance"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - T&op 10 List"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - S&ales List"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Statistics"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor - &Purchase List"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Schedules"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis by Dimensions"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Analysis Report"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Budgets(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Budgets"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Quotes"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Invoices"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contacts(Action 23)".

    }
}
