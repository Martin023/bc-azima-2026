#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187072 pageextension52187072 extends "Generic Charts" 
{
    layout
    {
        modify(ID)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("BLOB.HASVALUE")
        {
            ApplicationArea = Basic;
        }
        modify("GenericChartMgt.GetDescription(Rec)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ID(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BLOB.HASVALUE"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""GenericChartMgt.GetDescription(Rec)"(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control13(Control 13)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control14(Control 14)".

    }
    actions
    {
        modify("Import Chart")
        {
            ApplicationArea = Basic;
        }
        modify("E&xport Chart")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Chart")
        {
            ApplicationArea = Basic;
        }
        modify("Delete Chart")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Chart"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xport Chart"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Chart"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Chart"(Action 5)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
