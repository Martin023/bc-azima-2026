#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186466 pageextension52186466 extends "Total Value Insured per FA" 
{
    layout
    {
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 1106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 1107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1108)".

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

        //Unsupported feature: Code Modification on "ShowMatrix(Action 77).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CLEAR(MatrixForm);
            MatrixForm.Load(
              MATRIX_CaptionSet,MatrixRecords,NoOfColumns,GETFILTER("FA Posting Date Filter"),RoundingFactor);
            MatrixForm.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CLEAR(MatrixForm);
            MatrixForm.Load(MATRIX_CaptionSet,MatrixRecords,NoOfColumns,GETFILTER("FA Posting Date Filter"),RoundingFactor,
              PeriodType,AmountType);
            MatrixForm.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

        moveafter(ShowMatrix;"Next Set")
    }


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1099)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionRange"(Variable 1100)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionRange" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionRange" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetStartFilter(PROCEDURE 1)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).CurrentMatrixRecordOrdinal(Variable 1000)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).RecRef(Variable 1002)".

}
