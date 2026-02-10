#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185813 pageextension52185813 extends "Dimension Combinations" 
{
    layout
    {
        modify(ShowColumnName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 1102601000)".

    }
    actions
    {
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Previous Column")
        {
            ToolTip = 'Previous';
            ApplicationArea = Basic;
        }
        modify("Next Column")
        {
            ToolTip = 'Next';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Column"(Action 103)".

        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 101)".

        }

        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 100)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Column"(Action 102)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Column"(Action 103)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 101)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixMgm(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixMgm : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixMgm : 1005;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1101)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_ColumnSet"(Variable 1102)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_ColumnSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_ColumnSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1106)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SelectedDimensionCombination."Dimension 2 Code" <> '' THEN
          MatrixRecord.SETRANGE(Code,SelectedDimensionCombination."Dimension 2 Code");
        RecRef.GETTABLE(MatrixRecord);

        IF RecRef.ISEMPTY THEN
          ERROR(NoDimensionsErr);

        IF ShowColumnName THEN
          MATRIX_CaptionFieldNo := 2
        #10..19
          MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
          CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
        UNTIL (CurrentMatrixRecordOrdinal = ARRAYLEN(MatrixRecords)) OR (MatrixRecord.NEXT <> 1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RecRef.GETTABLE(MatrixRecord);
        #7..22
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateMatrixSubform(PROCEDURE 1102601000)".

    //procedure UpdateMatrixSubform();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.SetSelectedDimCode(SelectedDimensionCombination."Dimension 1 Code");
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet,MatrixRecords,ShowColumnName);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet,MatrixRecords,ShowColumnName);
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
