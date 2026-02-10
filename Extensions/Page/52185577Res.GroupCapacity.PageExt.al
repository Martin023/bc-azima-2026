#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185577 pageextension52185577 extends "Res. Group Capacity" 
{
    Caption = 'Res. Group Capacity';
    layout
    {
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(QtyType)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyType(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 1102601000)".

    }
    actions
    {
        modify("Previous Set")
        {
            ApplicationArea = Basic;
        }
        modify("Previous Column")
        {
            ApplicationArea = Basic;
        }
        modify("Next Column")
        {
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Set"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Column"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Column"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Set"(Action 11)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
