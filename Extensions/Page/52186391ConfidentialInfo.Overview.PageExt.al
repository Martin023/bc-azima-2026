#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186391 pageextension52186391 extends "Confidential Info. Overview" 
{
    layout
    {
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 2)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

        moveafter(ShowMatrix;"Next Set")
    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1066)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionRange"(Variable 1067)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionRange" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionRange" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1096).MatrixMgt(Variable 1003)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1096).CurrentMatrixRecordOrdinal(Variable 1001)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1096).RecRef(Variable 1002)".

}
