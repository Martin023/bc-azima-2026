#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185832 pageextension52185832 extends "G/L Entries Dimension Overview" 
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

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 4)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 7)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 4)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 4)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 5)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 7)".

        moveafter(ShowMatrix;"Next Set")
    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecord(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecord : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecord : 1008;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetTempGLEntry(PROCEDURE 1)".

}
