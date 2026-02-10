#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186535 pageextension52186535 extends "Transfer Routes" 
{
    layout
    {
        // modify(Show)
        // {
        //     ApplicationArea = Basic;
        // }
        modify(ShowTransferToName)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }
        modify(Show)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowTransferToName(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1103)".

        modify(MatrixForm)
        {
            Visible = false;
        }
        addafter(Options)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
            }
        }
    }
    actions
    {
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

        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 1104)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 1106)".

        addfirst(Processing)
        {
            action(ShowMatrix)
            {
                ApplicationArea = Basic;
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MatrixForm: Page "Transfer Routes Matrix";
                begin
                    Clear(MatrixForm);
                    //MatrixForm.Load(MATRIX_CaptionSet,MatrixRecords,MATRIX_CurrentNoOfColumns,Show);
                    MatrixForm.RunModal;
                end;
            }
        }
       // moveafter(ActionContainer1900000004;"Next Set")
    }


    //Unsupported feature: Property Modification (Id) on ""MATRIX_MatrixRecord"(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_MatrixRecord" : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_MatrixRecord" : 1005;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1006;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1094)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;
        #4..20
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
          UNTIL (CurrentMatrixRecordOrdinal > MATRIX_CurrentNoOfColumns) OR (MATRIX_MatrixRecord.NEXT <> 1);
        END;

        UpdateMatrixSubform;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..23
        */
    //end;

    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).CurrentMatrixRecordOrdinal(Variable 1000)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).RecRef(Variable 1002)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
