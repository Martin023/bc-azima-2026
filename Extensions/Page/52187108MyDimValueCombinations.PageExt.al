#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187108 pageextension52187108 extends "MyDim Value Combinations" 
{
    layout
    {
        modify(ShowColumnName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 13)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 1102601000)".

    }
    actions
    {
        modify(PreviousSet)
        {

            //Unsupported feature: Property Modification (Name) on "PreviousSet(Action 1102601002)".

            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify(PreviousColumn)
        {

            //Unsupported feature: Property Modification (Name) on "PreviousColumn(Action 1102601003)".

            ToolTip = 'Previous';
            ApplicationArea = Basic;
        }
        modify(NextColumn)
        {

            //Unsupported feature: Property Modification (Name) on "NextColumn(Action 1102601004)".

            ToolTip = 'Next';
            ApplicationArea = Basic;
        }
        modify(NextSet)
        {

            //Unsupported feature: Property Modification (Name) on "NextSet(Action 1102601001)".

            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }
    }

    //Unsupported feature: Property Modification (Id) on "MatrixMgm(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixMgm : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixMgm : 1004;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1100)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    var
        Column: Code[20];

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Row := _Row;
        ShowColumnName := _ShowColumnName;
        MatrixRecord.SETRANGE("Dimension Code",_Column);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Row := _Row;
        Column := _Column;
        ShowColumnName := _ShowColumnName;
        MatrixRecord.SETRANGE("Dimension Code",_Column);
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1106)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF DimensionValueCombination."Dimension 2 Code" <> '' THEN
          MatrixRecord.SETRANGE(Code,DimensionValueCombination."Dimension 2 Value Code");
        RecRef.GETTABLE(MatrixRecord);
        IF ShowColumnName THEN
          MATRIX_CaptionFieldNo := 3
        #6..9
          MATRIX_CaptionSet,MATRIX_ColumnSet,MATRIX_CurrSetLength);
        CLEAR(MatrixRecords);
        MatrixRecord.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
        REPEAT
          CurrentMatrixRecordOrdinal += 1;
          MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
        UNTIL (CurrentMatrixRecordOrdinal = ARRAYLEN(MatrixRecords)) OR (MatrixRecord.NEXT <> 1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..12
        CurrentMatrixRecordOrdinal := 1;
        REPEAT
          MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
          CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
        UNTIL (CurrentMatrixRecordOrdinal = ARRAYLEN(MatrixRecords)) OR (MatrixRecord.NEXT <> 1);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateMatrixSubform(PROCEDURE 1102601000)".

    //procedure UpdateMatrixSubform();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.SetSelectedDimValue(DimensionValueCombination."Dimension 1 Value Code");
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet,MatrixRecords,Row,MATRIX_CurrSetLength);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet,MatrixRecords,ShowColumnName,Row,Column,MATRIX_CurrSetLength);
        CurrPage.UPDATE(FALSE);
        */
    //end;
}
