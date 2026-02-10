#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187106 pageextension52187106 extends "Analysis by Dimensions Matrix" 
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
        modify(TotalAmount)
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


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount(Control 24)".

    }
    actions
    {
        modify(ExportToExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToExcel(Action 5)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ExportToExcel(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetCommonFilters(AnalysisViewEntry);
            AnalysisViewEntry.FIND('-');
            AnalysisViewToExcel.ExportData(
              AnalysisViewEntry,ShowOppositeSign,
              ShowInAddCurr,AmountField,ShowColumnName,DateFilter,AccountFilter,BudgetFilter,
              Dim1Filter,Dim2Filter,Dim3Filter,Dim4Filter,AmountType,ClosingEntryFilter,ShowActualBudg,BusUnitFilter);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              AnalysisViewEntry,LineDimCode,ColumnDimCode,ShowOppositeSign,
              ShowInAddCurr,AmountField,PeriodType,ShowColumnName,DateFilter,AccountFilter,BudgetFilter,
              Dim1Filter,Dim2Filter,Dim3Filter,Dim4Filter,AmountType,ClosingEntryFilter,ShowActualBudg,BusUnitFilter);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 5)".

    }


    //Unsupported feature: Property Modification (Data type) on "AccountFilter(Variable 1114)".

    //var
        //>>>> ORIGINAL VALUE:
        //AccountFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AccountFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim1Filter(Variable 1116)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim2Filter(Variable 1117)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim3Filter(Variable 1118)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim3Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim3Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim4Filter(Variable 1119)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim4Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim4Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BusUnitFilter(Variable 1124)".

    //var
        //>>>> ORIGINAL VALUE:
        //BusUnitFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BusUnitFilter : Code;
        //Variable type has not been exported.

    var
        GLAcc: Record "G/L Account";

    var
        InternalDateFilter: Text[1024];

    var
        MatrixHeader: Text[50];

    var
        PeriodInitialized: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Amount := MatrixMgt.RoundValue(CalcAmount(FALSE),RoundingFactor);

        MATRIX_CurrentColumnOrdinal := 0;
        IF MATRIX_PrimKeyFirstCol <> '' THEN
          MatrixRecord.SETPOSITION(MATRIX_PrimKeyFirstCol);
        IF MATRIX_OnFindRecord('=><') THEN BEGIN
          MATRIX_CurrentColumnOrdinal := 1;

        #9..17

        SetVisible;
        FormatLine;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        MatrixRecord.SETPOSITION(MATRIX_PrimKeyFirstCol);
        #6..20
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);

        ValidateAnalysisViewCode;

        InitRec(Rec,LineDimOption);
        InitRec(MatrixRecord,ColumnDimOption);

        IF (LineDimCode = '') AND (ColumnDimCode = '') THEN BEGIN
          IF GLAccountSource THEN
            LineDimCode := GLAcc.TABLECAPTION
        #11..17
        SetVisible;
        IF LineDimOption = LineDimOption::Period THEN
          Code := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        #8..20
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: GLAcc) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: BusUnit) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: CFAccount) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: CashFlowForecast) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: Period) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: DimVal) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: PeriodFormMgt) (VariableCollection) on "FindRec(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: Found) (VariableCollection) on "FindRec(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "FindRec(PROCEDURE 4)".

    //procedure FindRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account",
          DimOption::"Cash Flow Account",
          DimOption::"Business Unit",
          DimOption::"Cash Flow Forecast",
          DimOption::"Dimension 1",
          DimOption::"Dimension 2",
          DimOption::"Dimension 3",
          DimOption::"Dimension 4":
            EXIT(DimCodeBuf.FIND(Which));
          DimOption::Period:
            // Make specifial length of Which parameter in order to find PeriodFormmgt.FindDate procedure
            EXIT(FindPeriod(DimCodeBuf,COPYSTR(Which,1,3)));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account":
            BEGIN
              GLAcc."No." := DimCodeBuf.Code;
              FilterGLAcc(GLAcc);
              Found := GLAcc.FIND(Which);
              IF Found THEN
                CopyGLAccToBuf(GLAcc,DimCodeBuf);
            END;
          DimOption::"Cash Flow Account":
            BEGIN
              CFAccount."No." := DimCodeBuf.Code;
              FilterCFAcc(CFAccount);
              IF AccountFilter <> '' THEN
                CFAccount.SETFILTER("No.",AccountFilter);
              Found := CFAccount.FIND(Which);
              IF Found THEN
                CopyCFAccToBuf(CFAccount,DimCodeBuf);
            END;
          DimOption::Period:
            BEGIN
              IF NOT PeriodInitialized THEN
                DateFilter := '';
              PeriodInitialized := TRUE;
              EVALUATE(Period."Period Start",DimCodeBuf.Code);
              IF DateFilter <> '' THEN
                Period.SETFILTER("Period Start",DateFilter)
              ELSE
                IF NOT PeriodInitialized AND (InternalDateFilter <> '') THEN
                  Period.SETFILTER("Period Start",InternalDateFilter);
              Found := PeriodFormMgt.FindDate(Which,Period,PeriodType);
              IF Found THEN
                CopyPeriodToBuf(Period,DimCodeBuf);
            END;
          DimOption::"Business Unit":
            BEGIN
              BusUnit.Code := DimCodeBuf.Code;
              FilterBusUnit(BusUnit,BusUnitFilter);
              Found := BusUnit.FIND(Which);
              IF Found THEN
                CopyBusUnitToBuf(BusUnit,DimCodeBuf);
            END;
          DimOption::"Cash Flow Forecast":
            BEGIN
              CashFlowForecast."No." := DimCodeBuf.Code;
              FilterCashFlowForecast(CashFlowForecast,CashFlowFilter);
              Found := CashFlowForecast.FIND(Which);
              IF Found THEN
                CopyCashFlowToBuf(CashFlowForecast,DimCodeBuf);
            END;
          DimOption::"Dimension 1":
            BEGIN
              FilterDimValue(DimVal,Dim1Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 1 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              Found := DimVal.FIND(Which);
              IF Found THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 2":
            BEGIN
              FilterDimValue(DimVal,Dim2Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 2 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              Found := DimVal.FIND(Which);
              IF Found THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 3":
            BEGIN
              FilterDimValue(DimVal,Dim3Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 3 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              Found := DimVal.FIND(Which);
              IF Found THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 4":
            BEGIN
              FilterDimValue(DimVal,Dim4Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 4 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              Found := DimVal.FIND(Which);
              IF Found THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
        END;
        EXIT(Found);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: GLAcc) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: BusUnit) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: CFAccount) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: CashFlowForecast) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: Period) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: DimVal) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: PeriodFormMgt) (VariableCollection) on "NextRec(PROCEDURE 1138)".


    //Unsupported feature: Variable Insertion (Variable: ResultSteps) (VariableCollection) on "NextRec(PROCEDURE 1138)".



    //Unsupported feature: Code Modification on "NextRec(PROCEDURE 1138)".

    //procedure NextRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account",
          DimOption::"Cash Flow Account",
          DimOption::"Business Unit",
          DimOption::"Cash Flow Forecast",
          DimOption::"Dimension 1",
          DimOption::"Dimension 2",
          DimOption::"Dimension 3",
          DimOption::"Dimension 4":
            EXIT(DimCodeBuf.NEXT(Steps));
          DimOption::Period:
            EXIT(NextPeriod(DimCodeBuf,Steps));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account":
            BEGIN
              GLAcc."No." := DimCodeBuf.Code;
              FilterGLAcc(GLAcc);
              ResultSteps := GLAcc.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyGLAccToBuf(GLAcc,DimCodeBuf);
            END;
          DimOption::"Cash Flow Account":
            BEGIN
              CFAccount."No." := DimCodeBuf.Code;
              FilterCFAcc(CFAccount);
              ResultSteps := CFAccount.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyCFAccToBuf(CFAccount,DimCodeBuf);
            END;
          DimOption::Period:
            BEGIN
              IF DateFilter <> '' THEN
                Period.SETFILTER("Period Start",DateFilter);
              EVALUATE(Period."Period Start",DimCodeBuf.Code);
              ResultSteps := PeriodFormMgt.NextDate(Steps,Period,PeriodType);
              IF ResultSteps <> 0 THEN
                CopyPeriodToBuf(Period,DimCodeBuf);
            END;
          DimOption::"Business Unit":
            BEGIN
              BusUnit.Code := DimCodeBuf.Code;
              FilterBusUnit(BusUnit,BusUnitFilter);
              ResultSteps := BusUnit.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyBusUnitToBuf(BusUnit,DimCodeBuf);
            END;
          DimOption::"Cash Flow Forecast":
            BEGIN
              CashFlowForecast."No." := DimCodeBuf.Code;
              FilterCashFlowForecast(CashFlowForecast,CashFlowFilter);
              ResultSteps := CashFlowForecast.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyCashFlowToBuf(CashFlowForecast,DimCodeBuf);
            END;
          DimOption::"Dimension 1":
            BEGIN
              FilterDimValue(DimVal,Dim1Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 1 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              ResultSteps := DimVal.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 2":
            BEGIN
              FilterDimValue(DimVal,Dim2Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 2 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              ResultSteps := DimVal.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 3":
            BEGIN
              FilterDimValue(DimVal,Dim3Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 3 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              ResultSteps := DimVal.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
          DimOption::"Dimension 4":
            BEGIN
              FilterDimValue(DimVal,Dim4Filter);
              DimVal."Dimension Code" := AnalysisView."Dimension 4 Code";
              DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
              DimVal.Code := DimCodeBuf.Code;
              ResultSteps := DimVal.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyDimValueToBuf(DimVal,DimCodeBuf);
            END;
        END;
        EXIT(ResultSteps);
        */
    //end;


    //Unsupported feature: Code Modification on "CopyGLAccToBuf(PROCEDURE 1145)".

    //procedure CopyGLAccToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := TheGLAcc."No.";
          Name := TheGLAcc.Name;
          Totaling := TheGLAcc.Totaling;
          Indentation := TheGLAcc.Indentation;
          "Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
          INSERT;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyCFAccToBuf(PROCEDURE 1372)".

    //procedure CopyCFAccToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := TheCFAcc."No.";
          Name := TheCFAcc.Name;
          Totaling := TheCFAcc.Totaling;
          Indentation := TheCFAcc.Indentation;
          "Show in Bold" := TheCFAcc."Account Type" <> TheCFAcc."Account Type"::Entry;
          INSERT;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyPeriodToBuf(PROCEDURE 1146)".

    //procedure CopyPeriodToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := FORMAT(ThePeriod."Period Start");
        #4..11
              "Period End" := Period2.GETRANGEMAX("Period End");
          END;
          Name := ThePeriod."Period Name";
          IF INSERT THEN;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyBusUnitToBuf(PROCEDURE 1148)".

    //procedure CopyBusUnitToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := TheBusUnit.Code;
          Name := TheBusUnit.Name;
          INSERT;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyCashFlowToBuf(PROCEDURE 1375)".

    //procedure CopyCashFlowToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := TheCashFlowForecast."No.";
          Name := TheCashFlowForecast.Description;
          INSERT;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyDimValueToBuf(PROCEDURE 1149)".

    //procedure CopyDimValueToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheDimCodeBuf DO BEGIN
          INIT;
          Code := TheDimVal.Code;
          Name := TheDimVal.Name;
          Totaling := TheDimVal.Totaling;
          Indentation := TheDimVal.Indentation;
          "Show in Bold" :=
            TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
          INSERT;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DimValList) (VariableCollection) on "LookUpCode(PROCEDURE 1160)".



    //Unsupported feature: Code Modification on "LookUpCode(PROCEDURE 1160)".

    //procedure LookUpCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account":
            BEGIN
        #4..25
            BEGIN
              DimVal.SETRANGE("Dimension Code",DimCode);
              DimVal.GET(DimCode,Code);

              PAGE.RUNMODAL(PAGE::"Dimension Value List",DimVal);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..28
              DimValList.SETTABLEVIEW(DimVal);
              DimValList.SETRECORD(DimVal);
              DimValList.RUNMODAL;
            END;
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: MATRIX_CurrentColumnOrdinal) (VariableCollection) on ""MATRIX_UpdateMatrixRecord"(PROCEDURE 1193)".



    //Unsupported feature: Code Modification on ""MATRIX_UpdateMatrixRecord"(PROCEDURE 1193)".

    //procedure "MATRIX_UpdateMatrixRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_ColumnOrdinal := MATRIX_NewColumnOrdinal;
        MatrixRecord.SETPOSITION(MATRIX_PrimKeyFirstCol);
        MATRIX_OnFindRecord('=');
        IF MATRIX_ColumnOrdinal <> 1 THEN
          MATRIX_OnNextRecord(MATRIX_ColumnOrdinal - 1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        MATRIX_CurrentColumnOrdinal := 1;
        IF MATRIX_ColumnOrdinal <> 1 THEN
          MATRIX_OnNextRecord(MATRIX_ColumnOrdinal - 1);
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1197)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MatrixAmount := MatrixMgt.RoundValue(CalcAmount(TRUE),RoundingFactor);

        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixAmount;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ShowColumnName THEN
          MatrixHeader := MatrixRecord.Name
        ELSE
          MatrixHeader := MatrixRecord.Code;
        #1..3
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 3)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        LineDimOption := LineDimOptionLocal;
        ColumnDimOption := ColumnDimOptionLocal;
        LineDimCode := LineDimCodeLocal;
        ColumnDimCode := ColumnDimCodeLocal;
        PeriodType := NewPeriodType;
        DateFilter := NewDateFilter;
        AccountFilter := NewAccountFilter;
        BusUnitFilter := NewBusUnitFilter;
        BudgetFilter := NewBudgetFilter;
        CashFlowFilter := NewCashFlowFilter;
        Dim1Filter := NewDim1Filter;
        Dim2Filter := NewDim2Filter;
        Dim3Filter := NewDim3Filter;
        Dim4Filter := NewDim4Filter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        PeriodInitialized := TRUE;
        #7..14
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load2(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: CodeMatrixFilter) (VariableCollection) on "FilterCFAcc(PROCEDURE 10)".


    //Unsupported feature: Variable Insertion (Variable: NameMatrixFilter) (VariableCollection) on "FilterCFAcc(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Name) on "InitDimValue(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "InitDimValue(PROCEDURE 10)".

    //procedure InitDimValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF DimensionCode <> '' THEN BEGIN
          DimensionValue.SETRANGE("Dimension Code",DimensionCode);
          IF DimensionFilter <> '' THEN
            DimensionValue.SETFILTER(Code,DimensionFilter);
          IF DimensionValue.FINDSET THEN
            REPEAT
              CopyDimValueToBuf(DimensionValue,DimensionCodeBuffer);
            UNTIL DimensionValue.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetDimOptionFilters(CodeMatrixFilter,NameMatrixFilter,AccountFilter);
        IF CodeMatrixFilter <> '' THEN
          CFAccount.SETFILTER("No.",CodeMatrixFilter);
        IF NameMatrixFilter <> '' THEN
          CFAccount.SETFILTER(Name,NameMatrixFilter);
        */
    //end;

    //Unsupported feature: Property Modification (Data type) on "GetDimValueTotaling(PROCEDURE 6).ReturnValue".


    //Unsupported feature: Property Insertion (Length) on "GetDimValueTotaling(PROCEDURE 6).ReturnValue".


    local procedure FilterGLAcc(var GLAcc: Record "G/L Account")
    var
        CodeMatrixFilter: Text;
        NameMatrixFilter: Text;
    begin
        // GetDimOptionFilters(CodeMatrixFilter,NameMatrixFilter,AccountFilter);
        if CodeMatrixFilter <> '' then
          GLAcc.SetFilter("No.",CodeMatrixFilter);
        if NameMatrixFilter <> '' then
          GLAcc.SetFilter(Name,NameMatrixFilter);
    end;

    local procedure FilterBusUnit(var BusUnit: Record "Business Unit";InitCodeFilter: Code[250])
    var
        CodeMatrixFilter: Text;
        NameMatrixFilter: Text;
    begin
        GetDimOptionFilters(CodeMatrixFilter,NameMatrixFilter,InitCodeFilter);
        if CodeMatrixFilter <> '' then
          BusUnit.SetFilter(Code,CodeMatrixFilter);
        if NameMatrixFilter <> '' then
          BusUnit.SetFilter(Name,NameMatrixFilter);
    end;

    local procedure FilterCashFlowForecast(var CashFlowForecast: Record "Cash Flow Forecast";InitCodeFilter: Code[250])
    var
        CodeMatrixFilter: Text;
        NameMatrixFilter: Text;
    begin
        GetDimOptionFilters(CodeMatrixFilter,NameMatrixFilter,InitCodeFilter);
        if CodeMatrixFilter <> '' then
          CashFlowForecast.SetFilter("No.",CodeMatrixFilter);
        if NameMatrixFilter <> '' then
          CashFlowForecast.SetFilter("Search Name",NameMatrixFilter);
    end;

    local procedure FilterDimValue(var DimVal: Record "Dimension Value";InitCodeFilter: Code[250])
    var
        CodeMatrixFilter: Text;
        NameMatrixFilter: Text;
    begin
        GetDimOptionFilters(CodeMatrixFilter,NameMatrixFilter,InitCodeFilter);
        if CodeMatrixFilter <> '' then
          DimVal.SetFilter(Code,CodeMatrixFilter);
        if NameMatrixFilter <> '' then
          DimVal.SetFilter(Name,NameMatrixFilter);
    end;

    local procedure GetDimOptionFilters(var CodeMatrixFilter: Text;var NameMatrixFilter: Text;AccMatrixFilter: Text)
    begin
        CodeMatrixFilter := Rec.GetFilter(Rec.Code);
        if CodeMatrixFilter = '' then
          CodeMatrixFilter := AccMatrixFilter;
        NameMatrixFilter := Rec.GetFilter(Rec.Name);
    end;

    //Unsupported feature: Property Insertion (Length) on "SetCommonFilters(PROCEDURE 1168).DateFilter2(Variable 1169)".


    //Unsupported feature: Property Modification (Id) on "SetDimFilters(PROCEDURE 1170).DimCodeBuf(Variable 1002)".


    //Unsupported feature: Move on "SetDimFilters(PROCEDURE 1170).DimOption(Variable 1171)".


    //Unsupported feature: Property Modification (Id) on "SetDimBudgetFilters(PROCEDURE 1174).DimCodeBuf(Variable 1002)".


    //Unsupported feature: Move on "SetDimBudgetFilters(PROCEDURE 1174).DimOption(Variable 1175)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewDateFilter(Parameter 1003)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewAccountFilter(Parameter 1004)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewAccountFilter(Parameter 1004)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewBusUnitFilter(Parameter 1001)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewBusUnitFilter(Parameter 1001)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewBudgetFilter(Parameter 1005)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewBudgetFilter(Parameter 1005)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewDim1Filter(Parameter 1006)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewDim1Filter(Parameter 1006)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewDim2Filter(Parameter 1007)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewDim2Filter(Parameter 1007)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewDim3Filter(Parameter 1016)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewDim3Filter(Parameter 1016)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewDim4Filter(Parameter 1017)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewDim4Filter(Parameter 1017)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 3).NewCashFlowFilter(Parameter 1111)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 3).NewCashFlowFilter(Parameter 1111)".


    //Unsupported feature: Property Modification (Name) on "InitDimValue(PROCEDURE 10).DimensionCodeBuffer(Parameter 1000)".


    //Unsupported feature: Property Modification (Subtype) on "InitDimValue(PROCEDURE 10).DimensionCodeBuffer(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "InitDimValue(PROCEDURE 10).DimensionCode(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "InitDimValue(PROCEDURE 10).DimensionFilter(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "InitDimValue(PROCEDURE 10).DimensionValue(Variable 1001)".


    //Unsupported feature: Property Modification (Data type) on "GetDimValueTotaling(PROCEDURE 6).DimValueFilter(Parameter 1002)".


    //Unsupported feature: Property Insertion (Length) on "GetDimValueTotaling(PROCEDURE 6).DimValueFilter(Parameter 1002)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (ModifyAllowed).


    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
