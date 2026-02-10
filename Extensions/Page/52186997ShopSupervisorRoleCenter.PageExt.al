#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186997 pageextension52186997 extends "Shop Supervisor Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905423708(Control 1905423708)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control3(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control3)
        {
            part(Control1903012608;"Copy Profile")
            {
                Visible = false;
            }
        }
    }
    actions
    {
        modify("Routing &Sheet")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory - &Availability Plan")
        {
            ApplicationArea = Basic;
        }
        modify("Capacity Tas&k List")
        {
            ApplicationArea = Basic;
        }
        modify("Subcontractor - Dis&patch List")
        {
            ApplicationArea = Basic;
        }
        modify("Production Order Ca&lculation")
        {
            ApplicationArea = Basic;
        }
        modify("S&tatus")
        {
            ApplicationArea = Basic;
        }
        modify("Simulated Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Firm Planned Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Released Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Finished Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify(Routings)
        {
            ApplicationArea = Basic;
        }
        modify("Registered Absence")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(ItemsProduced)
        {

            //Unsupported feature: Property Modification (Name) on "ItemsProduced(Action 37)".

            ApplicationArea = Basic;
        }
        modify(ItemsRawMaterials)
        {

            //Unsupported feature: Property Modification (Name) on "ItemsRawMaterials(Action 94)".

            ApplicationArea = Basic;
        }
        modify("Stockkeeping Units")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Work Centers")
        {
            ApplicationArea = Basic;
        }
        modify("Machine Centers")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Picks")
        {
            ApplicationArea = Basic;
        }
        modify(RequisitionWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "RequisitionWorksheets(Action 7)".

            ApplicationArea = Basic;
        }
        modify(SubcontractingWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "SubcontractingWorksheets(Action 8)".

            ApplicationArea = Basic;
        }
        modify(ConsumptionJournals)
        {

            //Unsupported feature: Property Modification (Name) on "ConsumptionJournals(Action 56)".

            ApplicationArea = Basic;
        }
        modify(OutputJournals)
        {

            //Unsupported feature: Property Modification (Name) on "OutputJournals(Action 57)".

            ApplicationArea = Basic;
        }
        modify(CapacityJournals)
        {

            //Unsupported feature: Property Modification (Name) on "CapacityJournals(Action 60)".

            ApplicationArea = Basic;
        }
        modify(RecurringCapacityJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringCapacityJournals(Action 61)".

            ApplicationArea = Basic;
        }
        modify("Work Shifts")
        {
            ApplicationArea = Basic;
        }
        modify("Shop Calendars")
        {
            ApplicationArea = Basic;
        }
        modify("Capacity Constrained Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Work Center Groups")
        {
            ApplicationArea = Basic;
        }
        modify("Stop Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Scrap Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Standard Tasks")
        {
            ApplicationArea = Basic;
        }
        modify("Consumptio&n Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Output &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("&Capacity Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Change &Production Order Status")
        {
            ApplicationArea = Basic;
        }
        modify("Update &Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("&Manufacturing Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracing")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Routing &Sheet"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - &Availability Plan"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Tas&k List"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Subcontractor - Dis&patch List"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Order Ca&lculation"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&tatus"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Simulated Production Orders"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Production Orders"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Firm Planned Production Orders"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Production Orders"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finished Production Orders"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Routings(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Absence"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemsProduced(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemsRawMaterials(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stockkeeping Units"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Orders"(Action 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Centers"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Machine Centers"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Put-aways"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Picks"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequisitionWorksheets(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SubcontractingWorksheets(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ConsumptionJournals(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutputJournals(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CapacityJournals(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringCapacityJournals(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Shifts"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shop Calendars"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Constrained Resources"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Center Groups"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stop Codes"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Codes"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Tasks"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consumptio&n Journal"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Output &Journal"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Capacity Journal"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change &Production Order Status"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update &Unit Cost"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Manufacturing Setup"(Action 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracing"(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 90)".

    }
}
