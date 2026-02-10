#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186996 pageextension52186996 extends "Shop Supervisor Mfg Foundation" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907234908(Control 1907234908)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control27(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control27)
        {
            part(Control1903012608;"Copy Profile")
            {
                Visible = false;
            }
        }
    }
    actions
    {
        modify("Production Order - &Shortage List")
        {
            ApplicationArea = Basic;
        }
        modify("Subcontractor - Dis&patch List")
        {
            ApplicationArea = Basic;
        }
        modify("Production &Order Calculation")
        {
            ApplicationArea = Basic;
        }
        modify("S&tatus")
        {
            ApplicationArea = Basic;
        }
        // modify("&Item Registers - Quantity")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Inventory Valuation &WIP")
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
        modify(ProductionBOM)
        {

            //Unsupported feature: Property Modification (Name) on "ProductionBOM(Action 3)".

            ApplicationArea = Basic;
        }
        modify(ProductionBOMUnderDevelopment)
        {

            //Unsupported feature: Property Modification (Name) on "ProductionBOMUnderDevelopment(Action 15)".

            ApplicationArea = Basic;
        }
        modify(ProductionBOMCertified)
        {

            //Unsupported feature: Property Modification (Name) on "ProductionBOMCertified(Action 63)".

            ApplicationArea = Basic;
        }
        modify("Work Centers")
        {
            ApplicationArea = Basic;
        }
        modify(Routings)
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
        modify("Inventory Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Picks")
        {
            ApplicationArea = Basic;
        }
        modify("Standard Cost Worksheets")
        {
            ApplicationArea = Basic;
        }
        modify(SubcontractingWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "SubcontractingWorksheets(Action 22)".

            ApplicationArea = Basic;
        }
        modify(RequisitionWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "RequisitionWorksheets(Action 20)".

            ApplicationArea = Basic;
        }
        modify(RevaluationJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RevaluationJournals(Action 38)".

            ApplicationArea = Basic;
        }
        modify(ConsumptionJournals)
        {

            //Unsupported feature: Property Modification (Name) on "ConsumptionJournals(Action 46)".

            ApplicationArea = Basic;
        }
        modify(OutputJournals)
        {

            //Unsupported feature: Property Modification (Name) on "OutputJournals(Action 51)".

            ApplicationArea = Basic;
        }
        modify(RecurringConsumptionJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringConsumptionJournals(Action 52)".

            ApplicationArea = Basic;
        }
        modify(RecurringOutputJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringOutputJournals(Action 53)".

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
        modify("Production &Order")
        {
            ApplicationArea = Basic;
        }
        modify("P&urchase Order")
        {
            ApplicationArea = Basic;
        }
        modify("Co&nsumption Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Output &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Requisition &Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Order &Planning")
        {
            ApplicationArea = Basic;
        }
        modify("&Change Production Order Status")
        {
            ApplicationArea = Basic;
        }
        modify("Manu&facturing Setup")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Order - &Shortage List"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Subcontractor - Dis&patch List"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production &Order Calculation"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&tatus"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item Registers - Quantity"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Valuation &WIP"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Simulated Production Orders"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Production Orders"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Firm Planned Production Orders"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Production Orders"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finished Production Orders"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemsProduced(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemsRawMaterials(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stockkeeping Units"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProductionBOM(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProductionBOMUnderDevelopment(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProductionBOMCertified(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Centers"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Routings(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Orders"(Action 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Put-aways"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Picks"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Cost Worksheets"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SubcontractingWorksheets(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequisitionWorksheets(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevaluationJournals(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ConsumptionJournals(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutputJournals(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringConsumptionJournals(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringOutputJournals(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Shifts"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shop Calendars"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Center Groups"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stop Codes"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Codes"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Tasks"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production &Order"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&urchase Order"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&nsumption Journal"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Output &Journal"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requisition &Worksheet"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Planning"(Action 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Change Production Order Status"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Manu&facturing Setup"(Action 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracing"(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 90)".

    }
}
