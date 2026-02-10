#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185703 pageextension52185703 extends "G/L Balance by Dimension"
{
    layout
    {
        modify(LineDimCode)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnDimCode)
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
        modify(BudgetFilter)
        {
            ApplicationArea = Basic;
        }
        modify(BusUnitFilter)
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
        modify(ShowActualBudg)
        {
            ApplicationArea = Basic;
        }
        modify(AmountField)
        {
            ApplicationArea = Basic;
        }
        modify(ClosingEntryFilter)
        {
            ApplicationArea = Basic;
        }
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }
        modify(ShowInAddCurr)
        {
            ApplicationArea = Basic;
        }
        modify(ShowColumnName)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_ColumnSet")
        {
            ApplicationArea = Basic;
        }





    }
    actions
    {
        modify("Reverse Lines and Columns")
        {
            ApplicationArea = Basic;
        }
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 119)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 18)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Lines and Columns"(Action 13)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reverse Lines and Columns"(Action 13)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reverse Lines and Columns"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 119)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 119)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 14)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 18)".

        moveafter(ShowMatrix; "Next Set")
    }

    var
    //ApplicationManagement: Codeunit ApplicationManagement;


    //Unsupported feature: Property Modification (Data type) on "GLAccFilter(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLAccFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLAccFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetFilter(Variable 1024)".

    //var
    //>>>> ORIGINAL VALUE:
    //BudgetFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BudgetFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BusUnitFilter(Variable 1025)".

    //var
    //>>>> ORIGINAL VALUE:
    //BusUnitFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BusUnitFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim1Filter(Variable 1026)".

    //var
    //>>>> ORIGINAL VALUE:
    //GlobalDim1Filter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GlobalDim1Filter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim2Filter(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //GlobalDim2Filter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GlobalDim2Filter : Code;
    //Variable type has not been exported.

    var
        DimCodAmtBuf: Record "Dimension Code Amount Buffer" temporary;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeGLAccFilter(GLAcc,GLAccFilter,LineDimOption,ColumnDimOption);
    GlobalDim1Filter := GLAcc.GETFILTER("Global Dimension 1 Filter");
    GlobalDim2Filter := GLAcc.GETFILTER("Global Dimension 2 Filter");

    #5..23

    MATRIX_NoOfColumns := 32;
    MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..26
    */
    //end;


    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 2)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF DateFilter <> '' THEN BEGIN
      Period.SETFILTER("Period Start",DateFilter);
      IF NOT PeriodFormMgt.FindDate('+',Period,PeriodType) THEN
    #4..16
    InternalDateFilter := GLAcc.GETFILTER("Date Filter");
    IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN
      DateFilter := InternalDateFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    DimCodAmtBuf.DELETEALL;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Continue) (VariableCollection) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 7)".



    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 7)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MATRIX_CurrSetLength := 0;
    CLEAR(MATRIX_ColumnCaptions);
    MATRIX_ColumnSet := '';

    #5..51
      ELSE
        MATRIX_ColumnSet := MATRIX_ColumnCaptions[1] + '..' + MATRIX_ColumnCaptions[MATRIX_CurrSetLength];
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MATRIX_CurrSetLength := 0;
    Continue := TRUE;
    #2..54
    */
    //end;


    //Unsupported feature: Code Modification on "DateFilterOnAfterValidate(PROCEDURE 19006009)".

    //procedure DateFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    IF ColumnDimOption = ColumnDimOption::Period THEN BEGIN
      PeriodInitialized := TRUE;
      MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimCodAmtBuf.DELETEALL;
    #1..5
    */
    //end;


    //Unsupported feature: Code Modification on "GLAccFilterOnAfterValidate(PROCEDURE 19040142)".

    //procedure GLAccFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    IF ColumnDimOption = ColumnDimOption::"G/L Account" THEN
      MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimCodAmtBuf.DELETEALL;
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "GlobalDim2FilterOnAfterValidat(PROCEDURE 19025957)".

    //procedure GlobalDim2FilterOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    IF ColumnDimOption = ColumnDimOption::"Dimension 2" THEN
      MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimCodAmtBuf.DELETEALL;
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "GlobalDim1FilterOnAfterValidat(PROCEDURE 19037628)".

    //procedure GlobalDim1FilterOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    IF ColumnDimOption = ColumnDimOption::"Dimension 1" THEN
      MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimCodAmtBuf.DELETEALL;
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "BudgetFilterOnAfterValidate(PROCEDURE 19069837)".

    //procedure BudgetFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ShowActualBudg <> ShowActualBudg::"Actual Amounts" THEN
      DimCodAmtBuf.DELETEALL;
    CurrPage.UPDATE;
    */
    //end;


    //Unsupported feature: Code Modification on "BusUnitFilterOnAfterValidate(PROCEDURE 19015355)".

    //procedure BusUnitFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    IF ColumnDimOption = ColumnDimOption::"Business Unit" THEN
      MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimCodAmtBuf.DELETEALL;
    #1..3
    */
    //end;

    local procedure LookUpDimFilter(Dim: Code[20]; var Text: Text[250]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        if Dim = '' then
            exit(false);
        DimValList.LookupMode(true);
        DimVal.SetRange("Dimension Code", Dim);
        DimValList.SetTableview(DimVal);
        if DimValList.RunModal = Action::LookupOK then begin
            DimValList.GetRecord(DimVal);
            Text := DimValList.GetSelectionFilter;
            exit(true);
        end;
        exit(false)
    end;
}
