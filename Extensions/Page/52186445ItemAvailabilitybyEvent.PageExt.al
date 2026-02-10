#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186445 pageextension52186445 extends "Item Availability by Event"
{
    layout
    {
        modify(ItemNo)
        {
            ApplicationArea = Basic;
        }
        modify(VariantFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(LastUpdateTime)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on "LastUpdateTime(Control 13)".

        }
        modify(ForecastName)
        {
            ApplicationArea = Basic;
        }
        modify(IncludePlanningSuggestions)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeBlanketOrders)
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Period Start")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Source)
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gross Requirement")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Requirement")
        {
            ApplicationArea = Basic;
        }
        modify("Scheduled Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Projected Inventory")
        {
            ApplicationArea = Basic;
        }
        modify(Forecast)
        {
            ApplicationArea = Basic;
        }
        modify("Forecasted Projected Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Forecast")
        {
            ApplicationArea = Basic;
        }
        modify("Action Message")
        {
            ApplicationArea = Basic;
        }
        modify("Action Message Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Suggested Projected Inventory")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNo(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VariantFilter(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastUpdateTime(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ForecastName(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludePlanningSuggestions(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeBlanketOrders(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Source(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gross Requirement"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Requirement"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scheduled Receipt"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Receipt"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity (Base)"(Control 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Projected Inventory"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Projected Inventory"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Forecast(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Forecasted Projected Inventory"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Forecast"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Action Message"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Action Message Qty."(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Suggested Projected Inventory"(Control 47)".

    }
    actions
    {
        modify(Recalculate)
        {
            ApplicationArea = Basic;
        }
        modify("Show Document")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Recalculate(Action 6)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Recalculate(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Show Document"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 25)".

        addfirst("&Item Availability by")
        {
            action("Event")
            {
                ApplicationArea = Basic;
                Caption = 'Event';
                Image = "Event";

                trigger OnAction()
                begin
                    //ItemAvailFormsMgt.ShowItemAvailFromItem(Item,ItemAvailFormsMgt.ByEvent);
                end;
            }
        }
    }


    //Unsupported feature: Property Modification (Data type) on "LocationFilter(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //LocationFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LocationFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "VariantFilter(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //VariantFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VariantFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "Initialize(PROCEDURE 1)".

    //procedure Initialize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.SETRANGE("Drop Shipment Filter",FALSE);
    CalcInventoryPageData.Initialize(Item,ForecastName,IncludeBlanketOrders,0D,IncludePlanningSuggestions);
    LastUpdateTime := CURRENTDATETIME;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CalcInventoryPageData.Initialize(Item,ForecastName,IncludeBlanketOrders,0D,IncludePlanningSuggestions);
    LastUpdateTime := CURRENTDATETIME;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetForecastName(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetIncludePlan(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "GetSelectedDate(PROCEDURE 13)".

}
