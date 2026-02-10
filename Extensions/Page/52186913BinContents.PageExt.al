#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186913 pageextension52186913 extends "Bin Contents" 
{
    layout
    {
        modify(LocationCode)
        {
            ApplicationArea = Basic;
        }
        modify(ZoneCode)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
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
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify(Default)
        {
            ApplicationArea = Basic;
        }
        modify(Dedicated)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Class Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Ranking")
        {
            ApplicationArea = Basic;
        }
        modify("Block Movement")
        {
            ApplicationArea = Basic;
        }
        modify("Min. Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Qty.")
        {
            ApplicationArea = Basic;
        }
        modify(CalcQtyUOM)
        {
            ApplicationArea = Basic;
        }
        modify("Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Pick Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("ATO Components Pick Qty (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Negative Adjmt. Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Put-away Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Positive Adjmt. Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify(CalcQtyAvailToTakeUOM)
        {
            ApplicationArea = Basic;
        }
        modify("Fixed")
        {
            ApplicationArea = Basic;
        }
        modify("Cross-Dock Bin")
        {
            ApplicationArea = Basic;
        }
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }
        modify(CalcQtyonAdjmtBin)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "LocationCode(Control 20).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Location.RESET;
            Location.SETRANGE("Bin Mandatory",TRUE);
            IF LocationCode <> '' THEN
              Location.Code := LocationCode;
            IF PAGE.RUNMODAL(PAGE::"Locations with Warehouse List",Location) = ACTION::LookupOK THEN BEGIN
              Location.TESTFIELD("Bin Mandatory",TRUE);
              LocationCode := Location.Code;
              DefFilter;
            END;
            CurrPage.UPDATE(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            IF PAGE.RUNMODAL(7347,Location) = ACTION::LookupOK THEN BEGIN
            #6..10
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "LocationCode(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ZoneCode(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Default(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dedicated(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Class Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Type Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Ranking"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Block Movement"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Min. Qty."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Qty."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcQtyUOM(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity (Base)"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pick Quantity (Base)"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ATO Components Pick Qty (Base)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Negative Adjmt. Qty. (Base)"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-away Quantity (Base)"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Positive Adjmt. Qty. (Base)"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcQtyAvailToTakeUOM(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Fixed(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Dock Bin"(Control 56)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 54)".



        //Unsupported feature: Code Modification on "CalcQtyonAdjmtBin(Control 52).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            LocationGet("Location Code");
            WhseEntry.SETCURRENTKEY(
              "Item No.","Bin Code","Location Code","Variant Code","Unit of Measure Code");
            WhseEntry.SETRANGE("Item No.","Item No.");
            WhseEntry.SETRANGE("Bin Code",AdjmtLocation."Adjustment Bin Code");
            WhseEntry.SETRANGE("Location Code","Location Code");
            WhseEntry.SETRANGE("Variant Code","Variant Code");
            WhseEntry.SETRANGE("Unit of Measure Code","Unit of Measure Code");

            PAGE.RUNMODAL(PAGE::"Warehouse Entries",WhseEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
            WhseEntries.SETTABLEVIEW(WhseEntry);
            WhseEntries.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CalcQtyonAdjmtBin(Control 52)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control2(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Warehouse Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Entries"(Action 57)".

    }

    var
        WhseEntries: Page "Warehouse Entries";


    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemDescription : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemDescription := '';
        GetWhseLocation(LocationCode,ZoneCode);
        DefFilter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemDescription := '';
        GetWhseLocation(LocationCode,ZoneCode);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
