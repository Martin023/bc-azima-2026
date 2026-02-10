#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186827 pageextension52186827 extends "Invt. Analysis by Dimensions" 
{
    layout
    {
        modify(CurrentItemAnalysisViewCode)
        {
            ApplicationArea = Basic;
        }
        modify(LineDimCode)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnDimCode)
        {
            ApplicationArea = Basic;
        }
        modify(ValueType)
        {
            ApplicationArea = Basic;
        }
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ItemFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetFilter)
        {
            ApplicationArea = Basic;
        }
        modify(Dim1Filter)
        {
            ApplicationArea = Basic;
        }
        modify(Dim2Filter)
        {
            ApplicationArea = Basic;
        }
        modify(Dim3Filter)
        {
            ApplicationArea = Basic;
        }
        modify(ShowActualBudget)
        {
            ApplicationArea = Basic;
        }
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }
        modify(ShowColumnName)
        {
            ApplicationArea = Basic;
        }
        modify(ShowOppositeSign)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentItemAnalysisViewCode(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDimCode(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnDimCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ValueType(Control 47)".


        //Unsupported feature: Code Insertion (VariableCollection) on "DateFilter(Control 36).OnValidate".

        //trigger (Variable: ApplicationManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "DateFilter(Control 36).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            ItemStatisticsBuffer.SETFILTER("Date Filter",DateFilter);
            DateFilter := ItemStatisticsBuffer.GETFILTER("Date Filter");
            InternalDateFilter := DateFilter;

            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            #2..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetFilter(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim1Filter(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim2Filter(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim3Filter(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowActualBudget(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowOppositeSign(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 1138)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1140)".

    }
    actions
    {
        modify(ReverseLinesAndColumns)
        {
            ApplicationArea = Basic;
        }
        modify(ExportToExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToExcel(Action 56)".

            ApplicationArea = Basic;
        }
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

        //Unsupported feature: Property Deletion (ToolTipML) on "ReverseLinesAndColumns(Action 59)".



        //Unsupported feature: Code Modification on "ExportToExcel(Action 56).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ItemAnalysisViewToExcel.SetCommonFilters(
              CurrentAnalysisArea,CurrentItemAnalysisViewCode,
              ItemAnalysisViewEntry,DateFilter,ItemFilter,Dim1Filter,Dim2Filter,Dim3Filter,LocationFilter);
            ItemAnalysisViewEntry.FINDFIRST;
            ItemAnalysisViewToExcel.ExportData(
              ItemAnalysisViewEntry,ShowColumnName,DateFilter,ItemFilter,BudgetFilter,
              Dim1Filter,Dim2Filter,Dim3Filter,ShowActualBudget,LocationFilter,ShowOppositeSign);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            ItemAnalysisViewEntry.FIND('-');
            ItemAnalysisViewToExcel.ExportData(
              ItemAnalysisViewEntry,LineDimCode,ColumnDimCode,ValueType,
              PeriodType,ShowColumnName,DateFilter,ItemFilter,BudgetFilter,
              Dim1Filter,Dim2Filter,Dim3Filter,ShowActualBudget,LocationFilter,ShowOppositeSign);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 19)".

        moveafter(ShowMatrix;"Next Set")
    }

    var
        //ApplicationManagement: Codeunit ApplicationManagement;


    //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1024)".

    //var
        //>>>> ORIGINAL VALUE:
        //GLSetup : 1024;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GLSetup : 1025;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAnalysisView(Variable 1023)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemAnalysisView : 1023;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemAnalysisView : 1011;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemStatisticsBuffer(Variable 1011)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemStatisticsBuffer : 1011;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemStatisticsBuffer : 1002;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAnalysisMgt(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemAnalysisMgt : 1002;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemAnalysisMgt : 1038;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1131)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    var
        MATRIX_PrimKeyFirstCaptionInCu: Text[1024];


    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1145)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MATRIX_MatrixRecords);
        FirstColumn := '';
        LastColumn := '';
        MATRIX_CurrentNoOfColumns := ARRAYLEN(MATRIX_CaptionSet);

        CASE ColumnDimCode OF
          Text100: // Period
            BEGIN
              MatrixMgt.GeneratePeriodMatrixData(MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),ShowColumnName,
                PeriodType,DateFilter,MATRIX_PrimKeyFirstCaption,
                MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns,MATRIX_PeriodRecords);
              FOR i := 1 TO ARRAYLEN(MATRIX_CaptionSet) DO BEGIN
                MATRIX_MatrixRecords[i]."Period Start" := MATRIX_PeriodRecords[i]."Period Start";
        #15..23
              RecRef.GETTABLE(Location);
              RecRef.SETTABLE(Location);
              MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),1,
                MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted::Same,ARRAYLEN(MATRIX_CaptionSet),2,
                  MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          Item.TABLECAPTION:
            BEGIN
        #36..38
              RecRef.SETTABLE(Item);

              MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),1,
                MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted::Same,ARRAYLEN(MATRIX_CaptionSet),3,
                  MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          Customer.TABLECAPTION:
            BEGIN
              CLEAR(MATRIX_CaptionSet);
              RecRef.GETTABLE(Customer);
              RecRef.SETTABLE(Customer);
              MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),1,
                MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted::Same,ARRAYLEN(MATRIX_CaptionSet),2,
                  MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          Vendor.TABLECAPTION:
            BEGIN
              CLEAR(MATRIX_CaptionSet);
              RecRef.GETTABLE(Vendor);
              RecRef.SETTABLE(Vendor);
              MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),1,
                MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(RecRef,MATRIX_SetWanted::Same,ARRAYLEN(MATRIX_CaptionSet),2,
                  MATRIX_PrimKeyFirstCaption,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          ItemAnalysisView."Dimension 1 Code":
            MatrixMgt.GenerateDimColumnCaption(
              ItemAnalysisView."Dimension 1 Code",
              Dim1Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaption,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          ItemAnalysisView."Dimension 2 Code":
            MatrixMgt.GenerateDimColumnCaption(
              ItemAnalysisView."Dimension 2 Code",
              Dim2Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaption,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          ItemAnalysisView."Dimension 3 Code":
            MatrixMgt.GenerateDimColumnCaption(
              ItemAnalysisView."Dimension 3 Code",
              Dim3Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaption,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
          Text100:  {Period}
            BEGIN
              MatrixMgt.GeneratePeriodMatrixData(MATRIX_SetWanted,ARRAYLEN(MATRIX_CaptionSet),ShowColumnName,
                PeriodType,DateFilter,MATRIX_PrimKeyFirstCaptionInCu,
        #12..26
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #28..31
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #33..41
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #43..46
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #48..54
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #56..59
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #61..67
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #69..72
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
        #74..77
              Dim1Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
        #79..82
              Dim2Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
        #84..87
              Dim3Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Item) (VariableCollection) on "FindPeriod(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: Calendar) (VariableCollection) on "FindPeriod(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 2)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PeriodFormMgt.FindPeriodOnMatrixPage(
          DateFilter,InternalDateFilter,SearchText,PeriodType,
          (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF DateFilter <> '' THEN BEGIN
          Calendar.SETFILTER("Period Start",DateFilter);
          IF NOT PeriodFormMgt.FindDate('+',Calendar,PeriodType) THEN
            PeriodFormMgt.FindDate('+',Calendar,PeriodType::Day);
          Calendar.SETRANGE("Period Start");
        END;
        PeriodFormMgt.FindDate(SearchText,Calendar,PeriodType);
        Item.SETRANGE("Date Filter",Calendar."Period Start",Calendar."Period End");
        IF Item.GETRANGEMIN("Date Filter") = Item.GETRANGEMAX("Date Filter") THEN
          Item.SETRANGE("Date Filter",Item.GETRANGEMIN("Date Filter"));
        InternalDateFilter := Item.GETFILTER("Date Filter");
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN
          DateFilter := InternalDateFilter;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentAnalysisViewCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1145).MatrixMgt(Variable 1001)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1145).MatrixMgt(Variable 1001)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1145).i(Variable 1007)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1145).RecRef(Variable 1005)".


    //Unsupported feature: Property Modification (Length) on "FindPeriod(PROCEDURE 2).SearchText(Parameter 1000)".

}
