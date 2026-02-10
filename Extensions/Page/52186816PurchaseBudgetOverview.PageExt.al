#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186816 pageextension52186816 extends "Purchase Budget Overview" 
{
    layout
    {
        modify(CurrentBudgetName)
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
        modify(SalesCodeFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(ItemFilter)
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
        modify(GlobalDim1Filter)
        {
            ApplicationArea = Basic;
        }
        modify(GlobalDim2Filter)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentBudgetName(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDimCode(Control 5)".


        //Unsupported feature: Code Insertion (VariableCollection) on "ColumnDimCode(Control 7).OnValidate".

        //trigger (Variable: MATRIX_SetWanted)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "ColumnDimCode(Control 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF (UPPERCASE(LineDimCode) = UPPERCASE(ColumnDimCode)) AND (LineDimCode <> '') THEN BEGIN
              LineDimCode := '';
              ItemBudgetManagement.ValidateLineDimCode(
            #4..7
              ItemBudgetName,ColumnDimCode,ColumnDimOption,LineDimOption,
              InternalDateFilter,DateFilter,ItemStatisticsBuffer,PeriodInitialized);

            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
            ColumnDimCodeOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::First);
            ColumnDimCodeOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnDimCode(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ValueType(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 26)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MATRIX(Control 17)".



        //Unsupported feature: Code Insertion (VariableCollection) on "DateFilter(Control 33).OnValidate".

        //trigger (Variable: ApplicationManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "DateFilter(Control 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            ItemStatisticsBuffer.SETFILTER("Date Filter",DateFilter);
            DateFilter := ItemStatisticsBuffer.GETFILTER("Date Filter");
            InternalDateFilter := DateFilter;
            DateFilterOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            #2..5
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCodeFilterCtrl(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim1Filter(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim2Filter(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetDim3Filter(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GlobalDim1Filter(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GlobalDim2Filter(Control 49)".

    }
    actions
    {
        modify("Reverse Lines and Columns")
        {
            ApplicationArea = Basic;
        }
        modify("Delete Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Create New Document")
        {
            ApplicationArea = Basic;
        }
        modify("Update Existing Document")
        {
            ApplicationArea = Basic;
        }
        modify("Import from Excel")
        {
            ApplicationArea = Basic;
        }
        modify("Next Period")
        {
            ApplicationArea = Basic;
        }
        modify("Previous Period")
        {
            ApplicationArea = Basic;
        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Previous Column")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Next Column")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Lines and Columns"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Budget"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create New Document"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Existing Document"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import from Excel"(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Period"(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Period"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Period"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Period"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 23)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Column"(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Column"(Action 11)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 24)".

    }

    var
        MATRIX_SetWanted: Option First,Previous,Same,Next;

    var
       // ApplicationManagement: Codeunit ApplicationManagement;


    //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1026)".

    //var
        //>>>> ORIGINAL VALUE:
        //GLSetup : 1026;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GLSetup : 1035;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemBudgetName(Variable 1010)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemBudgetName : 1010;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemBudgetName : 1006;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemStatisticsBuffer(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemStatisticsBuffer : 1006;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemStatisticsBuffer : 1010;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (OptionString) on "CurrentAnalysisArea(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentAnalysisArea : Sale,Purchase,Inventory;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentAnalysisArea : Sales,Purchase,Inventory;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "SourceNoFilter(Variable 1016)".

    //var
        //>>>> ORIGINAL VALUE:
        //SourceNoFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SourceNoFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemFilter(Variable 1019)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim1Filter(Variable 1024)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim2Filter(Variable 1023)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim1Filter(Variable 1009)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim2Filter(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim3Filter(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim3Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim3Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MATRIX_MatrixRecords);
        FirstColumn := '';
        #4..41
              RecRef.GETTABLE(Item);
              RecRef.SETTABLE(Item);
              IF ItemFilter <> '' THEN BEGIN
                FieldRef := RecRef.FIELD(Item.FIELDNO("No."));
                FieldRef.SETFILTER(ItemFilter);
              END;
              MatrixMgt.GenerateMatrixData(
        #49..75
              RecRef.GETTABLE(Vendor);
              RecRef.SETTABLE(Vendor);
              IF SourceNoFilter <> '' THEN BEGIN
                FieldRef := RecRef.FIELD(Vendor.FIELDNO("No."));
                FieldRef.SETFILTER(SourceNoFilter);
              END;
              MatrixMgt.GenerateMatrixData(
        #83..114
              BudgetDim3Filter,MATRIX_SetWanted,MATRIX_PrimKeyFirstCaptionInCu,FirstColumn,LastColumn,
              MATRIX_CaptionSet,MATRIX_MatrixRecords,MATRIX_CurrentNoOfColumns,ShowColumnName,MATRIX_CaptionRange);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..44
                FieldRef := RecRef.FIELDINDEX(1);
        #46..78
                FieldRef := RecRef.FIELDINDEX(1);
        #80..117
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

    //Unsupported feature: Property Deletion (Attributes) on "SetNewBudgetName(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).Item(Variable 1008)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).Customer(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).Vendor(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).Location(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152)."MATRIX_PeriodRecords"(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).RecRef(Variable 1009)".


    //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).FieldRef(Variable 1006)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).MatrixMgt(Variable 1002)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152)."MATRIX_PeriodRecords"(Variable 1001)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).i(Variable 1004)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).Location(Variable 1003)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1152).RecRef(Variable 1009)".


    //Unsupported feature: Property Modification (Length) on "FindPeriod(PROCEDURE 2).SearchText(Parameter 1000)".


    //Unsupported feature: Property Deletion (SaveValues).

}
