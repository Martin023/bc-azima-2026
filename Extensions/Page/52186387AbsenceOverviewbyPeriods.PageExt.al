#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186387 pageextension52186387 extends "Absence Overview by Periods" 
{
    layout
    {
        modify("Cause Of Absence Filter")
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(QtyType)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cause Of Absence Filter"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyType(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnSet(Control 8)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 77)".

        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 10)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 77)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 10)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".

}
