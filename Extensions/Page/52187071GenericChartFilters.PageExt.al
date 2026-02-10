#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187071 pageextension52187071 extends "Generic Chart Filters" 
{
    layout
    {
        modify("Filter Field ID")
        {
            ApplicationArea = Basic;
        }
        modify("Filter Field Name")
        {
            ApplicationArea = Basic;
        }
        modify("Filter Value")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Filter Field ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Filter Field Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Filter Value"(Control 5)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetFilters(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetFilters(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTempGenericChart(PROCEDURE 4)".


    //Unsupported feature: Code Modification on "SetTempGenericChart(PROCEDURE 4)".

    //procedure SetTempGenericChart();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempGenericChartSetup := GenericChartSetup2;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempGenericChartSetup := TempGenericChartSetup2;
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "SetTempGenericChart(PROCEDURE 4).GenericChartSetup2(Parameter 1000)".


    //Unsupported feature: Property Insertion (AsVar) on "SetTempGenericChart(PROCEDURE 4).GenericChartSetup2(Parameter 1000)".


    //Unsupported feature: Property Insertion (Temporary) on "SetTempGenericChart(PROCEDURE 4).GenericChartSetup2(Parameter 1000)".

}
