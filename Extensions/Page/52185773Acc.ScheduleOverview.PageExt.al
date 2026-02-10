#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185773 pageextension52185773 extends "Acc. Schedule Overview" 
{
    layout
    {
        modify(CurrentSchedName)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentColumnName)
        {
            ApplicationArea = Basic;
        }
        modify(UseAmtsInAddCurr)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(DateFilter)
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
        modify(Dim4Filter)
        {
            ApplicationArea = Basic;
        }
        modify(CostCenterFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CostObjectFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CashFlowFilter)
        {
            ApplicationArea = Basic;
        }
        modify("G/LBudgetFilter")
        {
            ApplicationArea = Basic;
        }
        modify(CostBudgetFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Row No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues1)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues2)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues3)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues4)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues5)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues6)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues7)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues8)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues9)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues10)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues11)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValues12)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "CurrentSchedName(Control 10).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Result := AccSchedManagement.LookupName(CurrentSchedName,Text);
            CurrentSchedName := Text;
            CurrentSchedNameOnAfterValidate;
            EXIT(Result);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(AccSchedManagement.LookupName(CurrentSchedName,Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSchedName(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on "CurrentSchedName(Control 10)".



        //Unsupported feature: Code Modification on "CurrentColumnName(Control 12).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Result := AccSchedManagement.LookupColumnName(CurrentColumnName,Text);
            CurrentColumnName := Text;
            CurrentColumnNameOnAfterValidate;
            EXIT(Result);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EXIT(AccSchedManagement.LookupColumnName(CurrentColumnName,Text));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentColumnName(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UseAmtsInAddCurr(Control 44)".


        //Unsupported feature: Property Deletion (Visible) on "UseAmtsInAddCurr(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on "PeriodType(Control 42)".



        //Unsupported feature: Code Insertion (VariableCollection) on "DateFilter(Control 7).OnValidate".

        //trigger (Variable: ApplicationManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "DateFilter(Control 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            SETFILTER("Date Filter",DateFilter);
            DateFilter := GETFILTER("Date Filter");
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            #2..4
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 7)".


        //Unsupported feature: Property Deletion (Importance) on "DateFilter(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim1Filter(Control 37)".


        //Unsupported feature: Property Deletion (Importance) on "Dim1Filter(Control 37)".


        //Unsupported feature: Property Deletion (Visible) on "Dim1Filter(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim2Filter(Control 36)".


        //Unsupported feature: Property Deletion (Importance) on "Dim2Filter(Control 36)".


        //Unsupported feature: Property Deletion (Visible) on "Dim2Filter(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim3Filter(Control 39)".


        //Unsupported feature: Property Deletion (Importance) on "Dim3Filter(Control 39)".


        //Unsupported feature: Property Deletion (Visible) on "Dim3Filter(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim4Filter(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on "Dim4Filter(Control 38)".


        //Unsupported feature: Property Deletion (Visible) on "Dim4Filter(Control 38)".



        //Unsupported feature: Code Modification on "CostCenterFilter(Control 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CostCenterFilter = '' THEN
              SETRANGE("Cost Center Filter")
            ELSE
              SETFILTER("Cost Center Filter",CostCenterFilter);

            OnAfterValidateCostCenterFilter(Rec,CostCenterFilter,Dim1Filter);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CostCenterFilter(Control 3)".


        //Unsupported feature: Property Deletion (Importance) on "CostCenterFilter(Control 3)".



        //Unsupported feature: Code Modification on "CostObjectFilter(Control 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CostObjectFilter = '' THEN
              SETRANGE("Cost Object Filter")
            ELSE
              SETFILTER("Cost Object Filter",CostObjectFilter);

            OnAfterValidateCostObjectFilter(Rec,CostObjectFilter,Dim2Filter);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CostObjectFilter(Control 4)".


        //Unsupported feature: Property Deletion (Importance) on "CostObjectFilter(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashFlowFilter(Control 5)".


        //Unsupported feature: Property Deletion (Importance) on "CashFlowFilter(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/LBudgetFilter"(Control 6)".


        //Unsupported feature: Property Deletion (Importance) on ""G/LBudgetFilter"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostBudgetFilter(Control 9)".


        //Unsupported feature: Property Deletion (Importance) on "CostBudgetFilter(Control 9)".


        //Unsupported feature: Property Deletion (IndentationColumnName) on "Control48(Control 48)".


        //Unsupported feature: Property Deletion (IndentationControls) on "Control48(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Row No."(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 51)".


        //Unsupported feature: Property Deletion (Style) on "Description(Control 51)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Description(Control 51)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues2(Control 59)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues3(Control 61)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues4(Control 63)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues5(Control 65)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues6(Control 81)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues7(Control 79)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues8(Control 77)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues9(Control 75)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues10(Control 73)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues11(Control 71)".


        //Unsupported feature: Property Deletion (Visible) on "ColumnValues12(Control 69)".

        moveafter(DateFilter;Control48)
    }
    actions
    {
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify(PreviousColumn)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PreviousColumn(Action 2)".

        }
        modify(NextPeriod)
        {
            ToolTip = 'Next Period';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "NextPeriod(Action 27)".

        }
        modify(PreviousPeriod)
        {
            ToolTip = 'Previous Period';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PreviousPeriod(Action 26)".

        }
        modify(NextColumn)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "NextColumn(Action 1)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "NextColumn(Action 1)".

        }
        modify(Recalculate)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 40)".


        //Unsupported feature: Property Deletion (Promoted) on "Print(Action 40)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Print(Action 40)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Print(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousColumn(Action 2)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PreviousColumn(Action 2)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "NextPeriod(Action 27)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "PreviousPeriod(Action 26)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PreviousPeriod(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextColumn(Action 1)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "NextColumn(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (Promoted) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (Image) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Recalculate(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create New Document"(Action 292)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Existing Document"(Action 13)".

    }

    var
       

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        UseAmtsInAddCurr := FALSE;
        GLSetup.GET;
        UseAmtsInAddCurrVisible := GLSetup."Additional Reporting Currency" <> '';
        IF NewCurrentSchedName <> '' THEN
          CurrentSchedName := NewCurrentSchedName;
        IF CurrentSchedName = '' THEN
        #7..38
        SETRANGE("G/L Budget Filter");
        UpdateDimFilterControls;
        DateFilter := GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GLSetup.GET;
        #4..41
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAccSchedName(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPeriodType(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetDimFilters(PROCEDURE 2)".

    //procedure SetDimFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE DimNo OF
          1:
            IF DimValueFilter = '' THEN
              SETRANGE("Dimension 1 Filter")
            ELSE BEGIN
              DimensionManagement.ResolveDimValueFilter(DimValueFilter,AnalysisView."Dimension 1 Code");
              SETFILTER("Dimension 1 Filter",DimValueFilter);
            END;
          2:
            IF DimValueFilter = '' THEN
              SETRANGE("Dimension 2 Filter")
            ELSE BEGIN
              DimensionManagement.ResolveDimValueFilter(DimValueFilter,AnalysisView."Dimension 2 Code");
              SETFILTER("Dimension 2 Filter",DimValueFilter);
            END;
          3:
            IF DimValueFilter = '' THEN
              SETRANGE("Dimension 3 Filter")
            ELSE BEGIN
              DimensionManagement.ResolveDimValueFilter(DimValueFilter,AnalysisView."Dimension 3 Code");
              SETFILTER("Dimension 3 Filter",DimValueFilter);
            END;
          4:
            IF DimValueFilter = '' THEN
              SETRANGE("Dimension 4 Filter")
            ELSE BEGIN
              DimensionManagement.ResolveDimValueFilter(DimValueFilter,AnalysisView."Dimension 4 Code");
              SETFILTER("Dimension 4 Filter",DimValueFilter);
            END;
        END;

        OnAfterSetDimFilters(Rec,DimNo,DimValueFilter,CostCenterFilter,CostObjectFilter);
        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
              GetDimValueTotaling(DimValueFilter,AnalysisView."Dimension 1 Code");
        #7..12
              GetDimValueTotaling(DimValueFilter,AnalysisView."Dimension 2 Code");
        #14..19
              GetDimValueTotaling(DimValueFilter,AnalysisView."Dimension 3 Code");
        #21..26
              GetDimValueTotaling(DimValueFilter,AnalysisView."Dimension 4 Code");
        #28..30
        CurrPage.UPDATE;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateColumnCaptions(PROCEDURE 19)".

    //procedure UpdateColumnCaptions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ColumnCaptions);
        IF TempColumnLayout.FINDSET THEN
          REPEAT
        #4..7
        // Set unused columns to blank to prevent RTC to display control ID as caption
        FOR i := ColumnNo - ColumnOffset + 1 TO ARRAYLEN(ColumnCaptions) DO
          ColumnCaptions[i] := ' ';
        NoOfColumns := ColumnNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        */
    //end;


    //Unsupported feature: Code Modification on "CurrentSchedNameOnAfterValidate(PROCEDURE 19053875)".

    //procedure CurrentSchedNameOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.SAVERECORD;
        AccSchedManagement.SetName(CurrentSchedName,Rec);
        IF AccSchedName.GET(CurrentSchedName) THEN BEGIN
          IF (AccSchedName."Default Column Layout" <> '') AND
             (CurrentColumnName <> AccSchedName."Default Column Layout")
          THEN BEGIN
            CurrentColumnName := AccSchedName."Default Column Layout";
            CurrentColumnNameOnAfterValidate;
          END ELSE
            AccSchedManagement.CheckAnalysisView(CurrentSchedName,CurrentColumnName,TRUE);
        END ELSE
          AccSchedManagement.CheckAnalysisView(CurrentSchedName,CurrentColumnName,TRUE);

        IF AccSchedName."Analysis View Name" <> AnalysisView.Code THEN BEGIN
          PrevAnalysisView := AnalysisView;
        #16..31
        UpdateDimFilterControls;

        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.SAVERECORD;
        AccSchedManagement.SetName(CurrentSchedName,Rec);
        IF AccSchedName.GET(CurrentSchedName) THEN
        #4..7
            AccSchedManagement.CopyColumnsToTemp(CurrentColumnName,TempColumnLayout);
            AccSchedManagement.SetColumnName(CurrentColumnName,TempColumnLayout);
          END;
        AccSchedManagement.CheckAnalysisView(CurrentSchedName,CurrentColumnName,TRUE);
        #13..34
        */
    //end;


    //Unsupported feature: Code Modification on "CurrentColumnNameOnAfterValidate(PROCEDURE 19064415)".

    //procedure CurrentColumnNameOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        AccSchedManagement.CopyColumnsToTemp(CurrentColumnName,TempColumnLayout);
        AccSchedManagement.SetColumnName(CurrentColumnName,TempColumnLayout);
        AccSchedManagement.CheckAnalysisView(CurrentSchedName,CurrentColumnName,TRUE);
        ColumnOffset := 0;
        UpdateColumnCaptions;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        UpdateColumnCaptions;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "FormatStr(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "RoundNone(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "GetStyle(PROCEDURE 7)".

    //procedure GetStyle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        AccSchedManagement.CalcFieldError(ErrorType,RowLineNo,ColumnLineNo);
        IF ErrorType > ErrorType::None THEN
          ColumnStyle := 'Unfavorable'
        ELSE
          IF Bold THEN
            ColumnStyle := 'Strong'
          ELSE
            ColumnStyle := 'Standard';

        CASE ColumnNo OF
          1:
        #12..32
          12:
            ColumnStyle12 := ColumnStyle;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
          ColumnStyle := 'Standard';
        #9..35
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DimensionValue) (VariableCollection) on "GetDimValueTotaling(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "OnAfterValidateCostCenterFilter(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Name) on "OnAfterValidateCostCenterFilter(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "OnAfterValidateCostCenterFilter(PROCEDURE 3)".

    //procedure OnAfterValidateCostCenterFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF DimensionCode <> '' THEN BEGIN
          DimensionValue.SETRANGE("Dimension Code",DimensionCode);
          DimensionValue.SETFILTER(Code,DimValueFilter);
          IF DimensionValue.FINDFIRST THEN
            IF DimensionValue.Totaling <> '' THEN
              DimValueFilter := DimensionValue.Totaling;
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Length) on "SetDimFilters(PROCEDURE 2).DimValueFilter(Parameter 1001)".


    //Unsupported feature: Property Deletion (AsVar) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).AccScheduleLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).AccScheduleLine(Parameter 1000)".


    //Unsupported feature: Property Deletion (Subtype) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).AccScheduleLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).AccScheduleLine(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).AccScheduleLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).CostCenterFilter(Parameter 1001)".


    //Unsupported feature: Property Modification (Name) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).Dim1Filter(Parameter 1002)".


    //Unsupported feature: Property Insertion (Length) on "OnAfterValidateCostCenterFilter(PROCEDURE 3).Dim1Filter(Parameter 1002)".


    //Unsupported feature: Move on "OnAfterValidateCostCenterFilter(PROCEDURE 3).Dim1Filter(Parameter 1002)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (ModifyAllowed).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).


    //Unsupported feature: Property Deletion (ShowFilter).

}
