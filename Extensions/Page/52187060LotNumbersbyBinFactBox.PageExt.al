#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187060 pageextension52187060 extends "Lot Numbers by Bin FactBox" 
{

    //Unsupported feature: Property Modification (SourceTable) on ""Lot Numbers by Bin FactBox"(Page 9126)".

    layout
    {
        modify("Item No.")
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
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Base)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Base)"(Control 6)".

    }

    //Unsupported feature: Code Modification on "FillTempTable(PROCEDURE 5)".

    //procedure FillTempTable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        LotNosByBinCode.SETRANGE(Item_No,GETRANGEMIN("Item No."));
        LotNosByBinCode.SETRANGE(Variant_Code,GETRANGEMIN("Variant Code"));
        LotNosByBinCode.SETRANGE(Location_Code,GETRANGEMIN("Location Code"));
        LotNosByBinCode.SETFILTER(Lot_No,'<>%1','');
        LotNosByBinCode.OPEN;

        DELETEALL;
        #8..13
          "Bin Code" := LotNosByBinCode.Bin_Code;
          "Location Code" := LotNosByBinCode.Location_Code;
          "Lot No." := LotNosByBinCode.Lot_No;
          IF FIND THEN BEGIN
            "Qty. (Base)" += LotNosByBinCode.Sum_Qty_Base;
            MODIFY;
          END ELSE BEGIN
            "Qty. (Base)" := LotNosByBinCode.Sum_Qty_Base;
            INSERT;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        #5..16
          "Qty. (Base)" := LotNosByBinCode.Sum_Qty_Base;
          INSERT;
        END;
        */
    //end;
}
