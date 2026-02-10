#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186601 pageextension52186601 extends "Item Availability by BOM Level" 
{
    layout
    {
        modify(ItemFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(VariantFilter)
        {
            ApplicationArea = Basic;
        }
        modify(DemandDate)
        {
            ApplicationArea = Basic;
        }
        modify(IsCalculated)
        {
            ApplicationArea = Basic;
        }
        modify(ShowTotalAvailability)
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
        modify(HasWarning)
        {
            ApplicationArea = Basic;
        }
        modify(Bottleneck)
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Parent")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Top Item")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Replenishment System")
        {
            ApplicationArea = Basic;
        }
        modify("Available Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Unused Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Needed by Date")
        {
            ApplicationArea = Basic;
        }
        modify("Able to Make Parent")
        {
            ApplicationArea = Basic;
        }
        modify("Able to Make Top Item")
        {
            ApplicationArea = Basic;
        }
        modify("Gross Requirement")
        {
            ApplicationArea = Basic;
        }
        modify("Scheduled Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Safety Lead Time")
        {
            ApplicationArea = Basic;
        }
        modify("Rolled-up Lead-Time Offset")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VariantFilter(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DemandDate(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IsCalculated(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowTotalAvailability(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "HasWarning(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Bottleneck(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Parent"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Top Item"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Replenishment System"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Available Quantity"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unused Quantity"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Needed by Date"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Able to Make Parent"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Able to Make Top Item"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gross Requirement"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scheduled Receipts"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Safety Lead Time"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rolled-up Lead-Time Offset"(Control 25)".

    }
    actions
    {

        //Unsupported feature: Property Modification (Level) on ""&Item Availability by"(Action 33)".

        modify("Event")
        {

            //Unsupported feature: Property Modification (Level) on "Event(Action 32)".

            ApplicationArea = Basic;
        }
        modify(Period)
        {

            //Unsupported feature: Property Modification (Level) on "Period(Action 31)".

            ApplicationArea = Basic;
        }
        modify(Variant)
        {

            //Unsupported feature: Property Modification (Level) on "Variant(Action 30)".

            ApplicationArea = Basic;
        }
        modify(Location)
        {

            //Unsupported feature: Property Modification (Level) on "Location(Action 29)".

            ApplicationArea = Basic;
        }
        modify("Previous Period")
        {
            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify("Next Period")
        {
            ToolTip = 'Next Period';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Period"(Action 34)".

        }
        modify("Show Warnings")
        {
            ApplicationArea = Basic;
        }
        modify("Item - Able to Make (Timeline)")
        {
            ApplicationArea = Basic;
        }
        modify("&Item")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 29)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Period"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Period"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Warnings"(Action 40)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Show Warnings"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item - Able to Make (Timeline)"(Action 39)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Item - Able to Make (Timeline)"(Action 39)".

        addafter("Event")
        {
            action("BOM Level")
            {
                ApplicationArea = Basic;
                Caption = 'BOM Level';
                Image = BOMLevel;

                trigger OnAction()
                begin
                   // ItemAvail(ItemAvailFormsMgt.ByBOM);
                end;
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "InitItem(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "InitAsmOrder(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "InitProdOrder(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "InitDate(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "GetSelectedDate(PROCEDURE 3)".

}
