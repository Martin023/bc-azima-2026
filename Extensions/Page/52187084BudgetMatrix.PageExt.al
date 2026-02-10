#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187084 pageextension52187084 extends "Budget Matrix" 
{
    layout
    {

        //Unsupported feature: Property Insertion (Level) on "Control1900000001(Control 1900000001)".

        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(TotalBudgetedAmount)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalBudgetedAmount(Control 24)".

    }
    actions
    {
        modify(GLAccBalanceBudget)
        {

            //Unsupported feature: Property Modification (Name) on "GLAccBalanceBudget(Action 3)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GLAccBalanceBudget(Action 3)".

    }
    var
        ShowColumnName: Boolean;

    var
        MatrixHeader: Text[50];


    //Unsupported feature: Code Modification on "FindRec(PROCEDURE 1130)".

    //procedure FindRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account":
            BEGIN
              GLAcc."No." := DimCodeBuf.Code;
              IF GLAccFilter <> '' THEN
                GLAcc.SETFILTER("No.",GLAccFilter);
              SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
              IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
                GLAcc.SETRANGE("Account Category",GLAccCategoryFilter);
              Found := GLAcc.FIND(Which);
              IF Found THEN
                CopyGLAccToBuf(GLAcc,DimCodeBuf);
        #13..102
            END;
        END;
        EXIT(Found);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        #10..105
        */
    //end;


    //Unsupported feature: Code Modification on "NextRec(PROCEDURE 1137)".

    //procedure NextRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimOption OF
          DimOption::"G/L Account":
            BEGIN
              GLAcc."No." := DimCodeBuf.Code;
              IF GLAccFilter <> '' THEN
                GLAcc.SETFILTER("No.",GLAccFilter);
              SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
              IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
                GLAcc.SETRANGE("Account Category",GLAccCategoryFilter);
              ResultSteps := GLAcc.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopyGLAccToBuf(GLAcc,DimCodeBuf);
        #13..96
            END;
        END;
        EXIT(ResultSteps);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        #10..99
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
        #4..16
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
        #1..19
              DimValList.SETTABLEVIEW(DimVal);
              DimValList.SETRECORD(DimVal);
              DimValList.RUNMODAL;
            END;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "SetCommonFilters(PROCEDURE 1168)".

    //procedure SetCommonFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TheGLAccBudgetBuf DO BEGIN
          RESET;
          SETRANGE("Budget Filter",GLBudgetName.Name);
          IF BusUnitFilter <> '' THEN
            SETFILTER("Business Unit Filter",BusUnitFilter);
          IF GLAccFilter <> '' THEN
            SETFILTER("G/L Account Filter",GLAccFilter);
          IF IncomeBalanceGLAccFilter <> IncomeBalanceGLAccFilter::" " THEN
            SETRANGE("Income/Balance",IncomeBalanceGLAccFilter);
          IF DateFilter <> '' THEN
            SETFILTER("Date Filter",DateFilter);
          IF GlobalDim1Filter <> '' THEN
        #13..21
          IF BudgetDim4Filter <> '' THEN
            SETFILTER("Budget Dimension 4 Filter",BudgetDim4Filter);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        #10..24
        */
    //end;


    //Unsupported feature: Code Modification on "BudgetDrillDown(PROCEDURE 1172)".

    //procedure BudgetDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLBudgetEntry.SETRANGE("Budget Name",GLBudgetName.Name);
        IF GLAccBudgetBuf.GETFILTER("G/L Account Filter") <> '' THEN
          GLAccBudgetBuf.COPYFILTER("G/L Account Filter",GLBudgetEntry."G/L Account No.");
        #4..17
        IF GLAccBudgetBuf.GETFILTER("Date Filter") <> '' THEN
          GLAccBudgetBuf.COPYFILTER("Date Filter",GLBudgetEntry.Date)
        ELSE
          GLBudgetEntry.SETRANGE(Date,0D,DMY2DATE(31,12,9999));
        WITH GLBudgetEntry DO
          IF (GETFILTER("Global Dimension 1 Code") <> '') OR (GETFILTER("Global Dimension 2 Code") <> '') OR
             (GETFILTER("Business Unit Code") <> '')
          THEN
            SETCURRENTKEY("Budget Name","G/L Account No.","Business Unit Code","Global Dimension 1 Code")
          ELSE
            SETCURRENTKEY("Budget Name","G/L Account No.",Date);
        GLBudgetEntries.SetEditable(TRUE);
        GLBudgetEntries.SETTABLEVIEW(GLBudgetEntry);
        GLBudgetEntries.RUN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20
          GLBudgetEntry.SETRANGE(Date,0D,99991231D);
        #22..28
        PAGE.RUN(0,GLBudgetEntry);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1186)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1186)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FOR i := 1 TO 12 DO
          MATRIX_CellData[i] := 0;

        #4..23
        GLBudgetName := _GLBudgetName;
        DateFilter := _DateFilter;
        GLAccFilter := _GLAccFilter;
        IncomeBalanceGLAccFilter := _IncomeBalanceGLAccFilter;
        GLAccCategoryFilter := _GLAccCategoryFilter;
        RoundingFactor := _RoundingFactor;
        PeriodType := _PeriodType;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        InternalDateFilter := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..26
        #29..31
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1189)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(CalcAmount(TRUE),RoundingFactor);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ShowColumnName THEN
          MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Name
        ELSE
          MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Code;
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(CalcAmount(TRUE),RoundingFactor);
        */
    //end;


    //Unsupported feature: Code Modification on "GLAccountBalanceBudget(PROCEDURE 1102601002)".

    //procedure GLAccountBalanceBudget();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF DimCodeToOption(LineDimCode) = 0 THEN
          GLAcc.GET(Code)
        ELSE BEGIN
          IF GLAccFilter <> '' THEN
            GLAcc.SETFILTER("No.",GLAccFilter);
          SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
          IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
            GLAcc.SETRANGE("Account Category",GLAccCategoryFilter);
          GLAcc.FINDFIRST;
          GLAcc.RESET;
        END;
        WITH GLAcc DO BEGIN
          SETRANGE("Budget Filter",GLBudgetName.Name);
          IF DateFilter <> '' THEN
            SETFILTER("Date Filter",DateFilter);
          IF BusUnitFilter <> '' THEN
            SETFILTER("Business Unit Filter",BusUnitFilter);
          IF GLAccFilter <> '' THEN
            SETFILTER("No.",GLAccFilter);
          SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
          IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
            SETRANGE("Account Category",GLAccCategoryFilter);
          IF GlobalDim1Filter <> '' THEN
            SETFILTER("Global Dimension 1 Filter",GlobalDim1Filter);
          IF GlobalDim2Filter <> '' THEN
            SETFILTER("Global Dimension 2 Filter",GlobalDim2Filter);
        END;
        PAGE.RUN(PAGE::"G/L Account Balance/Budget",GLAcc);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        #9..13
        #16..19
        #23..28
        */
    //end;

    //Unsupported feature: Property Modification (Id) on "SetDimFilters(PROCEDURE 1169).DimCodeBuf(Variable 1002)".


    //Unsupported feature: Move on "SetDimFilters(PROCEDURE 1169).DimOption(Variable 1170)".


    //Unsupported feature: Deletion (VariableCollection) on "BudgetDrillDown(PROCEDURE 1172).GLBudgetEntries(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "Load(PROCEDURE 1186)."_IncomeBalanceGLAccFilter"(Parameter 1018)".


    //Unsupported feature: Deletion (ParameterCollection) on "Load(PROCEDURE 1186)."_GLAccCategoryFilter"(Parameter 1019)".


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
