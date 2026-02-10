#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185794 pageextension52185794 extends "Item Avail. by Location Lines" 
{

    //Unsupported feature: Property Insertion (SourceTableView) on ""Item Avail. by Location Lines"(Page 515)".

    layout
    {
        modify(LocationCode)
        {

            //Unsupported feature: Property Modification (Name) on "LocationCode(Control 5)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "LocationCode(Control 5)".

        }
        modify(Name)
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
        modify("Item.Inventory")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Item.Inventory"(Control 4)".

        }
        modify(ProjAvailableBalance)
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
        modify("Item.""Qty. on Asm. Component""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.""Qty. on Assembly Order""")
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

        //Unsupported feature: Property Deletion (CaptionML) on "LocationCode(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationCode(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GrossRequirement(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ScheduledRcpt(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PlannedOrderRcpt(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.Inventory"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProjAvailableBalance(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Purch. Order"""(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Sales Order"""(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Service Order"""(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Job Order"""(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Trans. Ord. Shipment (Qty.)"""(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Asm. Component"""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. on Assembly Order"""(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Qty. in Transit"""(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Trans. Ord. Receipt (Qty.)"""(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExpectedInventory(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyAvailable(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Scheduled Receipt (Qty.)"""(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Scheduled Need (Qty.)"""(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PlannedOrderReleases(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item.""Net Change"""(Control 36)".

        moveafter(PlannedOrderRcpt;ProjAvailableBalance)
    }

    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PeriodStart := 0D;
        PeriodEnd := DMY2DATE(31,12,1999);

        GetLocationsIncludingUnspecifiedLocation(FALSE,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PeriodStart := 0D;
        PeriodEnd := 20991231D;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetItemFilter(PROCEDURE 6)".

    //procedure SetItemFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF AmountType = AmountType::"Net Change" THEN
          Item.SETRANGE("Date Filter",PeriodStart,PeriodEnd)
        ELSE
          Item.SETRANGE("Date Filter",0D,PeriodEnd);
        LocationCode := Code;
        Item.SETRANGE("Location Filter",Code);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        Item.SETRANGE("Location Filter",Code);
        */
    //end;

    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
