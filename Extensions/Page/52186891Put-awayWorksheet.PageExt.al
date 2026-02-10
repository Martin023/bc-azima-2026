#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186891 pageextension52186891 extends "Put-away Worksheet" 
{
    Caption = 'Put-away Worksheet';
    layout
    {
        modify(CurrentWkshName)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentLocationCode)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentSortingMethod)
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("From Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("From Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shelf No.")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Handled")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Handled (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentWkshName(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentLocationCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSortingMethod(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Type"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document No."(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Line No."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Zone Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Bin Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shelf No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Base)"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding (Base)"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle (Base)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Handled"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Handled (Base)"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 67)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Source &Document Line")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Source &Document Line"(Action 21)".

        }
        modify("Whse. Document Line")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Warehouse Entries"(Action 4)".

        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 31)".

        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Bin Contents"(Action 44)".

        }
        modify(GetWarehouseDocuments)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "GetWarehouseDocuments(Action 2)".

        }
        modify("Autofill Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Delete Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify(CreatePutAway)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source &Document Line"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Line"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Whse. Document Line"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Whse. Document Line"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 61)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Lines"(Action 61)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Lines"(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Entries"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetWarehouseDocuments(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Autofill Qty. to Handle"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Qty. to Handle"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreatePutAway(Action 55)".

        addafter(GetWarehouseDocuments)
        {
            separator(Action3)
            {
            }
        }
        addafter("Delete Qty. to Handle")
        {
            separator(Action54)
            {
            }
        }
    }


    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemDescription : 50;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
