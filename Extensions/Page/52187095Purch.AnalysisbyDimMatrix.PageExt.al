#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187095 pageextension52187095 extends "Purch. Analysis by Dim Matrix" 
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalQuantity(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalInvtValue(Control 8)".

    }
    actions
    {
        modify("Export to Excel")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""Export to Excel"(Action 79).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Export to Excel"(Action 79)".

    }

    var
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];

    //Unsupported feature: Parameter Insertion (Parameter: ItemStatisticsBuffer1) (ParameterCollection) on "LoadVariables(PROCEDURE 1)".


    //Unsupported feature: Parameter Insertion (Parameter: LineDimCode1) (ParameterCollection) on "LoadVariables(PROCEDURE 1)".


    //Unsupported feature: Parameter Insertion (Parameter: ColumnDimCode1) (ParameterCollection) on "LoadVariables(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "LoadVariables(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "LoadVariables(PROCEDURE 1)".

    //procedure LoadVariables();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(MatrixColumnCaptions);
        ItemAnalysisView.COPY(ItemAnalysisView1);

        #4..6
        LineDimOption := LineDimOption1;
        ColumnDimOption := ColumnDimOption1;

        PeriodType := PeriodType1;
        ShowOppositeSign := ShowOppositeSign1;

        #13..20

        NoOfRecords := NoOfRecordsLocal;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        LineDimCode := LineDimCode1;
        ColumnDimCode := ColumnDimCode1;

        #10..23
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "LoadFilters(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "GetMatrixDimension(PROCEDURE 6)".


    //Unsupported feature: Property Modification (OptionString) on "LoadVariables(PROCEDURE 1).ValueType1(Parameter 1009)".

}
