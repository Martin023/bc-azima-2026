#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186199 pageextension52186199 extends "WF Event/Response Combinations" 
{
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixResponseSubpage(Control 2)".

    }
    actions
    {
        modify(PreviousSet)
        {
            ApplicationArea = Basic;
        }
        modify(NextSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousSet(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextSet(Action 6)".

    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_ColumnCaptions_Responses"(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_ColumnCaptions_Responses" : 250;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_ColumnCaptions_Responses" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "SetColumns(PROCEDURE 1)".

    //procedure SetColumns();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ResponseRecRef.OPEN(DATABASE::"Workflow Response");
        MatrixManagement.GenerateMatrixDataExtended(ResponseRecRef,SetWanted,ARRAYLEN(MATRIX_ColumnCaptions_Responses),
          WorkflowResponse.FIELDNO(Description),PKFirstRecInCurrSetResponses,MATRIX_ColumnCaptions_Responses,
          ColumnSetResponses,ColumnSetLengthResponses,MAXSTRLEN(MATRIX_ColumnCaptions_Responses[1]));

        CurrPage.MatrixResponseSubpage.PAGE.SetMatrixColumns(MATRIX_ColumnCaptions_Responses,ColumnSetLengthResponses);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ResponseRecRef.OPEN(DATABASE::"Workflow Response");
        MatrixManagement.GenerateMatrixData(ResponseRecRef,SetWanted,ARRAYLEN(MATRIX_ColumnCaptions_Responses),
          WorkflowResponse.FIELDNO(Description),PKFirstRecInCurrSetResponses,MATRIX_ColumnCaptions_Responses,
          ColumnSetResponses,ColumnSetLengthResponses);
        #5..7
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
