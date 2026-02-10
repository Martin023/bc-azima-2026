#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186999 pageextension52186999 extends "Job Resource Manager RC"
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904257908(Control 1904257908)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control19(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control18(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control22(Control 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control22)
        {
            part(Control1903012608; "Copy Profile")
            {
            }
        }
    }
    actions
    {
        modify("Resource &Statistics")
        {
            ApplicationArea = Basic;
        }
        modify("Resource &Utilization")
        {
            ApplicationArea = Basic;
        }
        // modify("Resource - &Price List")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Resource - Cost &Breakdown")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Resources)
        {
            ApplicationArea = Basic;
        }
        modify(ResourcesPeople)
        {

            //Unsupported feature: Property Modification (Name) on "ResourcesPeople(Action 14)".

            ApplicationArea = Basic;
        }
        modify(ResourcesMachines)
        {

            //Unsupported feature: Property Modification (Name) on "ResourcesMachines(Action 15)".

            ApplicationArea = Basic;
        }
        modify("Resource Groups")
        {
            ApplicationArea = Basic;
        }
        modify(ResourceJournals)
        {

            //Unsupported feature: Property Modification (Name) on "ResourceJournals(Action 35)".

            ApplicationArea = Basic;
        }
        modify(RecurringResourceJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringResourceJournals(Action 36)".

            ApplicationArea = Basic;
        }
        modify(Jobs)
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheets")
        {
            ApplicationArea = Basic;
        }
        modify("Manager Time Sheets")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Costs")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Service Zones")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Locations")
        {
            ApplicationArea = Basic;
        }
        modify("Work Types")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust R&esource Costs/Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Resource P&rice Changes")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Pr&ice Chg from Resource")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Pri&ce Chg from Prices")
        {
            ApplicationArea = Basic;
        }
        modify("I&mplement Resource Price Changes")
        {
            ApplicationArea = Basic;
        }
        modify("Create Time Sheets")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Statistics"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Utilization"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource - &Price List"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource - Cost &Breakdown"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Resources(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourcesPeople(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourcesMachines(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Groups"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceJournals(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringResourceJournals(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Jobs(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheets"(Action 1)".

        modify("Page Time Sheet List Open")
        {
            Visible = false;
        }
        modify("Page Time Sheet List Submitted")
        {
            Visible = false;
        }
        modify("Page Time Sheet List Rejected")
        {
            Visible = false;
        }
        modify("Page Time Sheet List Approved")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Manager Time Sheets"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Costs"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Prices"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Service Zones"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Locations"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Types"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust R&esource Costs/Prices"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource P&rice Changes"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Pr&ice Chg from Resource"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Pri&ce Chg from Prices"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""I&mplement Resource Price Changes"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Time Sheets"(Action 12)".

    }
}
