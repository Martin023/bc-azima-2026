#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186499 pageextension52186499 extends "FA Posting Types Overview" 
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


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1108)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 1111)".

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
            MatrixForm.Load(
              MATRIX_CaptionSet,MatrixRecords,NoOfColumns,GETFILTER("FA Posting Date Filter"),
              RoundingFactor,PeriodType,AmountType);
            MatrixForm.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 77)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 1109)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 1111)".

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

    //Unsupported feature: Property Deletion (Attributes) on "SetStartFilter(PROCEDURE 1)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).CurrentMatrixRecordOrdinal(Variable 1000)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).RecRef(Variable 1002)".

}
