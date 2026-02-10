#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187058 pageextension52187058 extends "Service Line FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("STRSUBSTNO('%1',ServInfoPaneMgt.CalcAvailability(Rec))")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (DecimalPlaces) on ""STRSUBSTNO('%1',ServInfoPaneMgt.CalcAvailability(Rec))"(Control 3)".

        }
        modify("STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSubstitutions(Rec))")
        {
            ApplicationArea = Basic;
        }
        modify("STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSalesPrices(Rec))")
        {
            ApplicationArea = Basic;
        }
        modify("STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSalesLineDisc(Rec))")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('%1',ServInfoPaneMgt.CalcAvailability(Rec))"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSubstitutions(Rec))"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSalesPrices(Rec))"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('%1',ServInfoPaneMgt.CalcNoOfSalesLineDisc(Rec))"(Control 11)".

    }
}
