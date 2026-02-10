#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185496 pageextension52185496 extends Budget 
{
    layout
    {
        modify(BudgetName)
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
        modify(PeriodType)
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
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(GLAccFilter)
        {
            ApplicationArea = Basic;
        }
        modify(GlobalDim1Filter)
        {
            ApplicationArea = Basic;
        }
        modify(GlobalDim2Filter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetDim1Filter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetDim2Filter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetDim3Filter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetDim4Filter)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetName(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDimCode(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnDimCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 1102601000)".


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
            ValidateDateFilter(DateFilter);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            GLAccBudgetBuf.SETFILTER("Date Filter",DateFilter);
            DateFilter := GLAccBudgetBuf.GETFILTER("Date Filter");
            InternalDateFilter := DateFilter;
            DateFilterOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLAccFilter(Control 38)".

        modify(GLAccCategory)
        {
            Visible = false;
        }
        modify(IncomeBalGLAccFilter)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "GlobalDim1Filter(Control 49).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLSetup."Global Dimension 1 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLSetup."Global Dimension 1 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GlobalDim1Filter(Control 49)".



        //Unsupported feature: Code Modification on "GlobalDim2Filter(Control 48).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLSetup."Global Dimension 2 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLSetup."Global Dimension 2 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GlobalDim2Filter(Control 48)".



        //Unsupported feature: Code Modification on "BudgetDim1Filter(Control 34).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLBudgetName."Budget Dimension 1 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 1 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim1Filter(Control 34)".



        //Unsupported feature: Code Modification on "BudgetDim2Filter(Control 30).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLBudgetName."Budget Dimension 2 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 2 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim2Filter(Control 30)".



        //Unsupported feature: Code Modification on "BudgetDim3Filter(Control 46).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLBudgetName."Budget Dimension 3 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 3 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim3Filter(Control 46)".



        //Unsupported feature: Code Modification on "BudgetDim4Filter(Control 35).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EXIT(DimensionValue.LookUpDimFilter(GLBudgetName."Budget Dimension 4 Code",Text));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 4 Code",Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim4Filter(Control 35)".

    }
    actions
    {
        modify(GLBalanceBudget)
        {

            //Unsupported feature: Property Modification (Name) on "GLBalanceBudget(Action 1102601011)".

            Caption = 'G/L Balance/B&udget';
            ApplicationArea = Basic;
        }
        // modify("Copy Budget")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on ""Copy Budget"(Action 1102601002)".

        // }
        modify("Delete Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Export to Excel")
        {
            ApplicationArea = Basic;
        }
        modify("Import from Excel")
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Lines and Columns")
        {
            ApplicationArea = Basic;
        }
        modify("Next Period")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Next Period"(Action 22)".

        }
        modify("Previous Period")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Previous Period"(Action 21)".

        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Previous Set"(Action 12)".

        }
        modify("Previous Column")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Previous Column"(Action 50)".

        }
        modify("Next Column")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Next Column"(Action 52)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Column"(Action 52)".

        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Next Set"(Action 111)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 111)".

        }


        //Unsupported feature: Code Modification on "GLBalanceBudget(Action 1102601011).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GLAccount.SETFILTER("Budget Filter",BudgetName);
            IF BusUnitFilter <> '' THEN
              GLAccount.SETFILTER("Business Unit Filter",BusUnitFilter);
            IF GLAccFilter <> '' THEN
              GLAccount.SETFILTER("No.",GLAccFilter);
            IF DateFilter <> '' THEN
              GLAccount.SETFILTER("Date Filter",DateFilter);
            CASE IncomeBalanceGLAccFilter OF
              IncomeBalanceGLAccFilter::"Balance Sheet":
                GLAccount.SETRANGE("Income/Balance",GLAccount."Income/Balance"::"Balance Sheet");
              IncomeBalanceGLAccFilter::"Income Statement":
                GLAccount.SETRANGE("Income/Balance",GLAccount."Income/Balance"::"Income Statement");
            END;
            IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
              GLAccount.SETRANGE("Account Category",GLAccCategoryFilter);
            IF GlobalDim1Filter <> '' THEN
              GLAccount.SETFILTER("Global Dimension 1 Filter",GlobalDim1Filter);
            IF GlobalDim2Filter <> '' THEN
              GLAccount.SETFILTER("Global Dimension 2 Filter",GlobalDim2Filter);
            PAGE.RUN(PAGE::"G/L Balance/Budget",GLAccount);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GLAccount.SETFILTER("Budget Filter",BudgetName);
            PAGE.RUN(PAGE::"G/L Balance/Budget",GLAccount);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GLBalanceBudget(Action 1102601011)".


        //Unsupported feature: Property Deletion (Promoted) on "GLBalanceBudget(Action 1102601011)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "GLBalanceBudget(Action 1102601011)".

        modify("Copy Budget")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Budget"(Action 1102601002)".


        //Unsupported feature: Property Deletion (Promoted) on ""Copy Budget"(Action 1102601002)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Copy Budget"(Action 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Budget"(Action 1102601003)".


        //Unsupported feature: Property Deletion (Promoted) on ""Delete Budget"(Action 1102601003)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Delete Budget"(Action 1102601003)".



        //Unsupported feature: Code Modification on ""Export to Excel"(Action 1102601005).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GLBudgetEntry.SETFILTER("Budget Name",BudgetName);
            GLBudgetEntry.SETFILTER("Business Unit Code",BusUnitFilter);
            GLBudgetEntry.SETFILTER("G/L Account No.",GLAccFilter);
            #4..6
            GLBudgetEntry.SETFILTER("Budget Dimension 2 Code",BudgetDim2Filter);
            GLBudgetEntry.SETFILTER("Budget Dimension 3 Code",BudgetDim3Filter);
            GLBudgetEntry.SETFILTER("Budget Dimension 4 Code",BudgetDim4Filter);
            REPORT.RUN(REPORT::"Export Budget to Excel",TRUE,FALSE,GLBudgetEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            EVALUATE(PeriodLength,'<0D>');
            ExportBudgetToExcel.SetParameters(0D,0,PeriodLength,RoundingFactor);
            ExportBudgetToExcel.SETTABLEVIEW(GLBudgetEntry);
            ExportBudgetToExcel.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Export to Excel"(Action 1102601005)".


        //Unsupported feature: Property Deletion (Promoted) on ""Export to Excel"(Action 1102601005)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Export to Excel"(Action 1102601005)".



        //Unsupported feature: Code Modification on ""Import from Excel"(Action 1102601006).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ImportBudgetfromExcel.SetParameters(BudgetName,0);
            ImportBudgetfromExcel.RUNMODAL;
            UpdateMatrixSubform;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ImportBudgetfromExcel.SetParameters(BudgetName,0);
            ImportBudgetfromExcel.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Import from Excel"(Action 1102601006)".


        //Unsupported feature: Property Deletion (Promoted) on ""Import from Excel"(Action 1102601006)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Import from Excel"(Action 1102601006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Lines and Columns"(Action 1102601008)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reverse Lines and Columns"(Action 1102601008)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reverse Lines and Columns"(Action 1102601008)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Reverse Lines and Columns"(Action 1102601008)".

        modify(ReportGroup)
        {
            Visible = false;
        }
        modify(ReportTrialBalance)
        {
            Visible = false;
        }
        modify(ReportBudget)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Period"(Action 22)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Period"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Period"(Action 21)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Previous Period"(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Period"(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Column"(Action 50)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Column"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Column"(Action 52)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Column"(Action 52)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 111)".

    }

    var


    var



    //Unsupported feature: Property Modification (Data type) on "BusUnitFilter(Variable 1027)".

    //var
        //>>>> ORIGINAL VALUE:
        //BusUnitFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BusUnitFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GLAccFilter(Variable 1028)".

    //var
        //>>>> ORIGINAL VALUE:
        //GLAccFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GLAccFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim1Filter(Variable 1029)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim2Filter(Variable 1030)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim1Filter(Variable 1031)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim2Filter(Variable 1032)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim3Filter(Variable 1033)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim3Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim3Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim4Filter(Variable 1034)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim4Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim4Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
          GlobalDim1Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
        #4..11
          (GLSetup."Global Dimension 2 Code" <> '') AND
          (GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") = '');

        IF GLAccBudgetBuf.GETFILTER("G/L Account Filter") <> '' THEN
          GLAccFilter := GLAccBudgetBuf.GETFILTER("G/L Account Filter");

        ValidateBudgetName;

        IF LineDimCode = '' THEN
        #21..31
          ValidateColumnDimCode;
        END;

        PeriodType := PeriodType::Month;
        IncomeBalanceGLAccFilter := IncomeBalanceGLAccFilter::"Income Statement";
        IF DateFilter = '' THEN
          ValidateDateFilter(FORMAT(CALCDATE('<-CY>',TODAY)) + '..' + FORMAT(CALCDATE('<CY>',TODAY)));

        FindPeriod('');
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);

        UpdateMatrixSubform;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14
        #18..34
        #40..43
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: CurrentMatrixRecordOrdinal) (VariableCollection) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1206)".



    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1206)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MATRIX_MatrixRecords);
        FirstColumn := '';
        LastColumn := '';
        MATRIX_CurrentNoOfColumns := 12;

        IF ColumnDimCode = '' THEN
          EXIT;

        CASE ColumnDimCode OF
          Text001:  // Period
            BEGIN
              MatrixMgt.GeneratePeriodMatrixData(
                MATRIX_SetWanted,MATRIX_CurrentNoOfColumns,ShowColumnName,
                PeriodType,DateFilter,MATRIX_PrimKeyFirstCaptionInCu,
                MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns,MATRIX_PeriodRecords);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO BEGIN
                MATRIX_MatrixRecords[i]."Period Start" := MATRIX_PeriodRecords[i]."Period Start";
                MATRIX_MatrixRecords[i]."Period End" := MATRIX_PeriodRecords[i]."Period End";
              END;
              FirstColumn := FORMAT(MATRIX_PeriodRecords[1]."Period Start");
              LastColumn := FORMAT(MATRIX_PeriodRecords[MATRIX_CurrentNoOfColumns]."Period End");
              PeriodTypeEnable := TRUE;
            END;
          GLAccount.TABLECAPTION:
            BEGIN
              CLEAR(MATRIX_CaptionSet);
              RecRef.GETTABLE(GLAccount);
              RecRef.SETTABLE(GLAccount);
              IF GLAccFilter <> '' THEN BEGIN
                FieldRef := RecRef.FIELD(GLAccount.FIELDNO("No."));
                FieldRef.SETFILTER(GLAccFilter);
              END;
              IF IncomeBalanceGLAccFilter <> IncomeBalanceGLAccFilter::" " THEN BEGIN
                IncomeBalFieldRef := RecRef.FIELDINDEX(GLAccount.FIELDNO("Income/Balance"));
                CASE IncomeBalanceGLAccFilter OF
                  IncomeBalanceGLAccFilter::"Balance Sheet":
                    IncomeBalFieldRef.SETRANGE(GLAccount."Income/Balance"::"Balance Sheet");
                  IncomeBalanceGLAccFilter::"Income Statement":
                    IncomeBalFieldRef.SETRANGE(GLAccount."Income/Balance"::"Income Statement");
                END;
              END;
              IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN BEGIN
                GLAccCategoryFieldRef := RecRef.FIELDINDEX(GLAccount.FIELDNO("Account Category"));
                GLAccCategoryFieldRef.SETRANGE(GLAccCategoryFilter);
              END;
              MatrixMgt.GenerateMatrixData(
                RecRef,MATRIX_SetWanted,12,1,
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := COPYSTR(MATRIX_CaptionSet[i],1,MAXSTRLEN(MATRIX_MatrixRecords[i].Code));
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(
                  RecRef,MATRIX_SetWanted::Same,12,GLAccount.FIELDNO(Name),
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          BusUnit.TABLECAPTION:
            BEGIN
              CLEAR(MATRIX_CaptionSet);
              RecRef.GETTABLE(BusUnit);
              RecRef.SETTABLE(BusUnit);
              IF BusUnitFilter <> '' THEN BEGIN
                FieldRef := RecRef.FIELDINDEX(1);
                FieldRef.SETFILTER(BusUnitFilter);
              END;
              MatrixMgt.GenerateMatrixData(
                RecRef,MATRIX_SetWanted,12,1,
                MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
              FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                MATRIX_MatrixRecords[i].Code := COPYSTR(MATRIX_CaptionSet[i],1,MAXSTRLEN(MATRIX_MatrixRecords[i].Code));
              IF ShowColumnName THEN
                MatrixMgt.GenerateMatrixData(
                  RecRef,MATRIX_SetWanted::Same,12,BusUnit.FIELDNO(Name),
                  MATRIX_PrimKeyFirstCaptionInCu,MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrentNoOfColumns);
            END;
          // Apply dimension filter
          GLSetup."Global Dimension 1 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLSetup."Global Dimension 1 Code",
              GlobalDim1Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          GLSetup."Global Dimension 2 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLSetup."Global Dimension 2 Code",
              GlobalDim2Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          GLBudgetName."Budget Dimension 1 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLBudgetName."Budget Dimension 1 Code",
              BudgetDim1Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          GLBudgetName."Budget Dimension 2 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLBudgetName."Budget Dimension 2 Code",
              BudgetDim2Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          GLBudgetName."Budget Dimension 3 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLBudgetName."Budget Dimension 3 Code",
              BudgetDim3Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
          GLBudgetName."Budget Dimension 4 Code":
            MatrixMgt.GenerateDimColumnCaption(
              GLBudgetName."Budget Dimension 4 Code",
              BudgetDim4Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CLEAR(MATRIX_CaptionSet);
        CurrentMatrixRecordOrdinal := 1;
        #2..30
                FieldRef := RecRef.FIELDINDEX(1);
                FieldRef.SETFILTER(GLAccFilter);
        #46..69
                MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
        #71..107
        */
    //end;


    //Unsupported feature: Code Modification on "DeleteBudget(PROCEDURE 10)".

    //procedure DeleteBudget();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ConfirmManagement.ConfirmProcess(Text003,TRUE) THEN
          WITH GLBudgetEntry DO BEGIN
            SETRANGE("Budget Name",BudgetName);
            IF BusUnitFilter <> '' THEN
        #5..24
            SETCURRENTKEY("Budget Name");
            DELETEALL(TRUE);
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF CONFIRM(Text003) THEN
        #2..27
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetBudgetName(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "SetGLAccountFilter(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "UpdateMatrixSubform(PROCEDURE 1102601003)".

    //procedure UpdateMatrixSubform();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.MatrixForm.PAGE.Load(
          MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,LineDimCode,
          LineDimOption,ColumnDimOption,GlobalDim1Filter,GlobalDim2Filter,BudgetDim1Filter,
          BudgetDim2Filter,BudgetDim3Filter,BudgetDim4Filter,GLBudgetName,DateFilter,
          GLAccFilter,IncomeBalanceGLAccFilter,GLAccCategoryFilter,RoundingFactor,PeriodType);

        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
          GLAccFilter,RoundingFactor,PeriodType);

        CurrPage.UPDATE;
        */
    //end;

    local procedure LookUpDimFilter(Dim: Code[20];var Text: Text[250]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        if Dim = '' then
          exit(false);
        DimValList.LookupMode(true);
        DimVal.SetRange("Dimension Code",Dim);
        DimValList.SetTableview(DimVal);
        if DimValList.RunModal = Action::LookupOK then begin
          DimValList.GetRecord(DimVal);
          Text := DimValList.GetSelectionFilter;
        end;
        exit(true);
    end;

    //Unsupported feature: Deletion (VariableCollection) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1206).IncomeBalFieldRef(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1206).GLAccCategoryFieldRef(Variable 1009)".


    //Unsupported feature: Deletion (VariableCollection) on "DeleteBudget(PROCEDURE 10).ConfirmManagement(Variable 1002)".


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
