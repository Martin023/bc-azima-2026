#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187087 pageextension52187087 extends "Invt. Analys by Dim. Matrix" 
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
        modify(TotalQuantity)
        {
            ApplicationArea = Basic;
        }
        modify(TotalInvtValue)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalQuantity(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalInvtValue(Control 24)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1112;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1115)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Variable Insertion (Variable: ApplicationManagement) (VariableCollection) on "Load(PROCEDURE 1125)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1125)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1125)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        COPYARRAY(MATRIX_CaptionSet,MatrixColumns1,1);
        FOR i := 1 TO ARRAYLEN(MatrixRecords) DO
          MatrixRecords[i].COPY(MatrixRecords1[i]);
        #4..7
        ValueType := _ValueType;
        ItemAnalysisView := _ItemAnalysisView;
        CurrentItemAnalysisViewCode := _CurrentItemAnalysisViewCode;
        TextManagement.MakeDateFilter(_DateFilter);
        ItemStatisticsBuffer.SETFILTER("Date Filter",_DateFilter);
        DateFilter := ItemStatisticsBuffer.GETFILTER("Date Filter");
        ItemFilter := _ItemFilter;
        #15..18
        Dim3Filter := _Dim3Filter;
        InternalDateFilter := DateFilter;
        ShowOppositeSign := ShowOppSign;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        IF ApplicationManagement.MakeDateFilter(_DateFilter) = 0 THEN;
        #12..21
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnDrillDown"(PROCEDURE 1126)".

    //procedure "MATRIX_OnDrillDown"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemAnalysisMgt.DrillDown(
          CurrentAnalysisArea,ItemStatisticsBuffer,CurrentItemAnalysisViewCode,
          ItemFilter,LocationFilter,DateFilter,
          Dim1Filter,Dim2Filter,Dim3Filter,BudgetFilter,
          LineDimOption,Rec,
          ColumnDimOption,MatrixRecords[MATRIX_ColumnOrdinal],
          TRUE,ValueType,ShowActualBudget);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        {
        MATRIX_ColumnTempRec := MatrixRecords[MATRIX_ColumnOrdinal];
        DrillDown(FALSE,ValueType);
        }

        #1..7
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1128)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        AnalysisValue := CalcAmt(ValueType,TRUE);
        MATRIX_CellData[MATRIX_ColumnOrdinal] := AnalysisValue;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        {
        IF ShowColumnName THEN
          MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Name
        ELSE
          MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Code;
        }
        #1..3
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "Load(PROCEDURE 1125).TextManagement(Variable 1021)".

}
