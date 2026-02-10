#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185576 pageextension52185576 extends "Resource Capacity" 
{
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

        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyType(Control 9)".


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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Set"(Action 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Column"(Action 1102601018)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Column"(Action 1102601017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Set"(Action 5)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".


    //Unsupported feature: Code Modification on "UpdateMatrixSubform(PROCEDURE 1102601000)".

    //procedure UpdateMatrixSubform();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.Load(QtyType,MatrixColumnCaptions,MatrixRecords,CurrSetLength);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.Load(PeriodType,QtyType,MatrixColumnCaptions,MatrixRecords,CurrSetLength);
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
