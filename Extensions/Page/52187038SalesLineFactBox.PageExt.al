#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187038 pageextension52187038 extends "Sales Line FactBox" 
{
    layout
    {
        modify(ItemNo)
        {
            ApplicationArea = Basic;
        }
        modify("Required Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Item Availability")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (DecimalPlaces) on ""Item Availability"(Control 3)".

        }
        modify("Available Inventory")
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
        modify("Gross Requirements")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Requirements")
        {
            ApplicationArea = Basic;
        }
        modify(UnitofMeasureCode)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify(Substitutions)
        {
            ApplicationArea = Basic;
        }
        modify(SalesPrices)
        {
            ApplicationArea = Basic;
        }
        modify(SalesLineDiscounts)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNo(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Required Quantity"(Control 13)".

        modify(Attachments)
        {
            Visible = false;
        }
        modify("Attached Doc Count")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Availability"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Available Inventory"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scheduled Receipt"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Receipt"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gross Requirements"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Requirements"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnitofMeasureCode(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 14)".


        //Unsupported feature: Code Modification on "Substitutions(Control 5).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SAVERECORD;
            ShowItemSub;
            CurrPage.UPDATE(TRUE);
            IF (Reserve = Reserve::Always) AND ("No." <> xRec."No.") THEN BEGIN
              AutoReserve;
              CurrPage.UPDATE(FALSE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemSub;
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Substitutions(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesPrices(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesLineDiscounts(Control 11)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Reserved Quantity","Attached Doc Count");
        SalesInfoPaneMgt.ResetItemNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CALCFIELDS("Reserved Quantity");
        */
    //end;
}
