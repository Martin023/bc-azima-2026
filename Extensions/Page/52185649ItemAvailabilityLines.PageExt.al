#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185649 pageextension52185649 extends "Item Availability Lines" 
{
    layout
    {
        modify("Period Start")
        {
            ApplicationArea = Basic;
        }
        modify("Period Name")
        {
            ApplicationArea = Basic;
        }
        modify(GrossRequirement)
        {
            ApplicationArea = Basic;
        }
        modify(ScheduledRcpt)
        {
            ApplicationArea = Basic;
        }
        modify(PlannedOrderRcpt)
        {
            ApplicationArea = Basic;
        }
        modify(ProjAvailableBalance)
        {
            ApplicationArea = Basic;
        }
        modify("Item.Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Purch. Order""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Sales Order""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Service Order""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Job Order""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Trans. Ord. Shipment (Qty.)""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. in Transit""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Trans. Ord. Receipt (Qty.)""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Asm. Component""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Assembly Order""")
        {
            ApplicationArea = Basic;
        }
        modify(ExpectedInventory)
        {
            ApplicationArea = Basic;
        }
        modify(QtyAvailable)
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Scheduled Receipt (Qty.)""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Scheduled Need (Qty.)""")
        {
            ApplicationArea = Basic;
        }
        modify(PlannedOrderReleases)
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Net Change""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GrossRequirement(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ScheduledRcpt(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PlannedOrderRcpt(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProjAvailableBalance(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.Inventory"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Purch. Order"""(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Sales Order"""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Service Order"""(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Job Order"""(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Trans. Ord. Shipment (Qty.)"""(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. in Transit"""(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Trans. Ord. Receipt (Qty.)"""(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Asm. Component"""(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Assembly Order"""(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExpectedInventory(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyAvailable(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Scheduled Receipt (Qty.)"""(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Scheduled Need (Qty.)"""(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PlannedOrderReleases(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Net Change"""(Control 38)".

    }
    var
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ItemPeriodLength));
        */
    //end;


    //Unsupported feature: Code Modification on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ItemPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Item.COPY(NewItem);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);

        OnAfterSet(Item,PeriodType,AmountType);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Item.COPY(NewItem);
        ItemPeriodLength := NewItemPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "SetItemFilter(PROCEDURE 4)".

    //procedure SetItemFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF AmountType = AmountType::"Net Change" THEN
          Item.SETRANGE("Date Filter","Period Start","Period End")
        ELSE
          Item.SETRANGE("Date Filter",0D,"Period End");
        OnAfterSetItemFilter(Item,"Period Start","Period End");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (ModifyAllowed).


    //Unsupported feature: Property Deletion (ShowFilter).

}
