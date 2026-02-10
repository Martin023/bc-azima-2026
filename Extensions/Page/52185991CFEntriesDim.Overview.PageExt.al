#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185991 pageextension52185991 extends "CF Entries Dim. Overview" 
{
    layout
    {
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 3)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;
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
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 4)".

        moveafter(ShowMatrix;"Next Set")
    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetTempCFForecastEntry(PROCEDURE 1000)".



    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 4)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RecRef.GETTABLE(Dimension);
        RecRef.SETTABLE(Dimension);

        MatrixMgt.GenerateMatrixData(RecRef,Step,ARRAYLEN(MATRIX_CaptionSet),
          1,MATRIX_PKFirstCaptionInCurrSet,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrSetLength);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        MatrixMgt.GenerateMatrixData(RecRef,Step,ARRAYLEN(MATRIX_CaptionSet)
          ,1,MATRIX_PKFirstCaptionInCurrSet,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrSetLength);
        */
    //end;
}
