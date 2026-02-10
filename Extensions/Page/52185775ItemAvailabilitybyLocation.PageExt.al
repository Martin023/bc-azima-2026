#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185775 pageextension52185775 extends "Item Availability by Location" 
{
    layout
    {
        modify(ItemPeriodLength)
        {
            ToolTip = 'Day';
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }
        modify(DateFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "ItemAvailLocLines(Control 1)".

    }
    actions
    {
        modify("Event")
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
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify(PreviousPeriod)
        {

            //Unsupported feature: Property Modification (Name) on "PreviousPeriod(Action 27)".

            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify(NextPeriod)
        {

            //Unsupported feature: Property Modification (Name) on "NextPeriod(Action 26)".

            ToolTip = 'Next Period';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 4)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "PreviousPeriod(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PreviousPeriod(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "NextPeriod(Action 26)".

        addafter(Variant)
        {
            action(Location)
            {
                ApplicationArea = Basic;
                Caption = 'Location';
                Image = Warehouse;
                RunObject = Page "Item Availability by Location";
                RunPageLink = "No."=field("No."),
                              "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"),
                              "Location Filter"=field("Location Filter"),
                              "Drop Shipment Filter"=field("Drop Shipment Filter"),
                              "Variant Filter"=field("Variant Filter");
            }
        }
    }


    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 2)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Date Filter") <> '' THEN BEGIN
          Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
          IF NOT PeriodFormMgt.FindDate('+',Calendar,ItemPeriodLength) THEN
        #4..10
            SETRANGE("Date Filter",GETRANGEMIN("Date Filter"));
        END ELSE
          SETRANGE("Date Filter",0D,Calendar."Period End");
        DateFilter := GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetLastLocation(PROCEDURE 3)".

}
