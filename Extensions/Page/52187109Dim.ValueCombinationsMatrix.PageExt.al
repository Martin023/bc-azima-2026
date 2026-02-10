#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187109 pageextension52187109 extends "Dim. Value Combinations Matrix" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Field1)
        {
            ApplicationArea = Basic;
        }
        modify(Field2)
        {
            ApplicationArea = Basic;
        }
        modify(Field3)
        {
            ApplicationArea = Basic;
        }
        modify(Field4)
        {
            ApplicationArea = Basic;
        }
        modify(Field5)
        {
            ApplicationArea = Basic;
        }
        modify(Field6)
        {
            ApplicationArea = Basic;
        }
        modify(Field7)
        {
            ApplicationArea = Basic;
        }
        modify(Field8)
        {
            ApplicationArea = Basic;
        }
        modify(Field9)
        {
            ApplicationArea = Basic;
        }
        modify(Field10)
        {
            ApplicationArea = Basic;
        }
        modify(Field11)
        {
            ApplicationArea = Basic;
        }
        modify(Field12)
        {
            ApplicationArea = Basic;
        }
        modify(Field13)
        {
            ApplicationArea = Basic;
        }
        modify(Field14)
        {
            ApplicationArea = Basic;
        }
        modify(Field15)
        {
            ApplicationArea = Basic;
        }
        modify(Field16)
        {
            ApplicationArea = Basic;
        }
        modify(Field17)
        {
            ApplicationArea = Basic;
        }
        modify(Field18)
        {
            ApplicationArea = Basic;
        }
        modify(Field19)
        {
            ApplicationArea = Basic;
        }
        modify(Field20)
        {
            ApplicationArea = Basic;
        }
        modify(Field21)
        {
            ApplicationArea = Basic;
        }
        modify(Field22)
        {
            ApplicationArea = Basic;
        }
        modify(Field23)
        {
            ApplicationArea = Basic;
        }
        modify(Field24)
        {
            ApplicationArea = Basic;
        }
        modify(Field25)
        {
            ApplicationArea = Basic;
        }
        modify(Field26)
        {
            ApplicationArea = Basic;
        }
        modify(Field27)
        {
            ApplicationArea = Basic;
        }
        modify(Field28)
        {
            ApplicationArea = Basic;
        }
        modify(Field29)
        {
            ApplicationArea = Basic;
        }
        modify(Field30)
        {
            ApplicationArea = Basic;
        }
        modify(Field31)
        {
            ApplicationArea = Basic;
        }
        modify(Field32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 8)".

    }
    var
        MatrixRecord: Record "Dimension Value";

    var
        MatrixHeader: Text[250];
        ShowColumnName: Boolean;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetColumnVisibility;
        FILTERGROUP(2);
        SETRANGE("Dimension Code",Row);
        FILTERGROUP(0);
        IF SelectedDimValueCode <> '' THEN
          SETRANGE(Code,SelectedDimValueCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: _ShowColumnName) (ParameterCollection) on "Load(PROCEDURE 1093)".


    //Unsupported feature: Parameter Insertion (Parameter: _Column) (ParameterCollection) on "Load(PROCEDURE 1093)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1093)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1093)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        COPYARRAY(MATRIX_ColumnCaption,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumn;
        Row := _Row;

        SetColumnVisibility;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        COPYARRAY(MATRIX_ColumnCaption,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        ShowColumnName := _ShowColumnName;
        MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumn;
        Row := _Row;
        */
    //end;


    //Unsupported feature: Code Modification on "MatrixOnAssistEdit(PROCEDURE 1)".

    //procedure MatrixOnAssistEdit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Dimension Code" > MatrixRecords[ColumnID]."Dimension Code" THEN BEGIN
          Dim1Code := MatrixRecords[ColumnID]."Dimension Code";
          Dim1ValueCode := MatrixRecords[ColumnID].Code;
        #4..18
        NewDimLimVal := STRMENU(Text000,DimLimVal);
        IF DimLimVal <> NewDimLimVal THEN BEGIN
          CombRestriction := NewDimLimVal - 1;
          ChangeCombRestriction(Dim1Code,Dim1ValueCode,Dim2Code,Dim2ValueCode);
        END ;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..21
          ChangeCombRestriction(ColumnID,Dim1Code,Dim1ValueCode,Dim2Code,Dim2ValueCode);
        END ;
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1095)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowCombRestriction(ColumnID);
        IF CombRestriction = CombRestriction::" " THEN
          MATRIX_CellData[ColumnID] := ''
        ELSE
          MATRIX_CellData[ColumnID] := SELECTSTR(CombRestriction + 1,Text000);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ShowColumnName THEN
          MatrixHeader := MatrixRecord.Name
        ELSE
          MatrixHeader := MatrixRecord.Code;
        #1..5
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ColumnID) (ParameterCollection) on "ChangeCombRestriction(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (Attributes) on "SetColumnVisibility(PROCEDURE 3)".

}
