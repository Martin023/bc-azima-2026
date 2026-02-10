#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185824 pageextension52185824 extends "Analysis by Dimensions" 
{
    layout
    {
        modify(AnalysisViewCode)
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
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(AccFilter)
        {
            ApplicationArea = Basic;
        }
        modify(BusUnitFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CashFlowFilter)
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
        modify(Dim4Filter)
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
        modify(ShowOppositeSign)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnsSet)
        {
            ApplicationArea = Basic;
        }
        modify(QtyType)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AnalysisViewCode(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDimCode(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnDimCode(Control 9)".


        //Unsupported feature: Code Modification on "DateFilter(Control 36).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            GLAcc.SETFILTER("Date Filter",DateFilter);
            DateFilter := GLAcc.GETFILTER("Date Filter");
            InternalDateFilter := DateFilter;
            IF ColumnDimOption = ColumnDimOption::Period THEN
              CreateCaptionSet(Rec,Step::First,32,PrimaryKeyFirstColInSet,ColumnCaptions,ColumnsSet);
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


        //Unsupported feature: Property Deletion (ToolTipML) on "AccFilter(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashFlowFilter(Control 1013)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetFilter(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim1Filter(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim2Filter(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim3Filter(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dim4Filter(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowActualBudg(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountField(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ClosingEntryFilter(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowInAddCurr(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowOppositeSign(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnsSet(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyType(Control 20)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 19)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 11)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Lines and Columns"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reverse Lines and Columns"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reverse Lines and Columns"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 12)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 11)".

    }

    var
    //Unsupported feature: Property Modification (Data type) on "AccFilter(Variable 1033)".

    //var
        //>>>> ORIGINAL VALUE:
        //AccFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AccFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim1Filter(Variable 1035)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim2Filter(Variable 1036)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim3Filter(Variable 1037)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim3Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim3Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "Dim4Filter(Variable 1038)".

    //var
        //>>>> ORIGINAL VALUE:
        //Dim4Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Dim4Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BusUnitFilter(Variable 1043)".

    //var
        //>>>> ORIGINAL VALUE:
        //BusUnitFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BusUnitFilter : Code;
        //Variable type has not been exported.

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "CreateCaptionSet(PROCEDURE 29)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAnalysisViewCode(PROCEDURE 14)".


    //Unsupported feature: Property Insertion (Length) on "LookUpDimFilter(PROCEDURE 57).Text(Parameter 1001)".

}
