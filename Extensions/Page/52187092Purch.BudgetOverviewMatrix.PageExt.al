#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187092 pageextension52187092 extends "Purch. Budget Overview Matrix" 
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
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
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


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 24)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1004;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1117;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "SourceNoFilter(Variable 1088)".

    //var
        //>>>> ORIGINAL VALUE:
        //SourceNoFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SourceNoFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemFilter(Variable 1089)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim1Filter(Variable 1095)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "GlobalDim2Filter(Variable 1096)".

    //var
        //>>>> ORIGINAL VALUE:
        //GlobalDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GlobalDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim1Filter(Variable 1097)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim1Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim1Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim2Filter(Variable 1098)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim2Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim2Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetDim3Filter(Variable 1099)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetDim3Filter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetDim3Filter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentAnalysisArea := CurrentAnalysisArea::Purchase;
        ItemBudgetManagement.BudgetNameSelection(
          CurrentAnalysisArea,CurrentBudgetName,ItemBudgetName,ItemStatisticsBuffer,
          BudgetDim1Filter,BudgetDim2Filter,BudgetDim3Filter);

        GLSetup.GET;
        SourceTypeFilter := SourceTypeFilter::Vendor;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #2..7
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1132)".


    //Unsupported feature: Property Deletion (Attributes) on "SetFilters(PROCEDURE 1102601000)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_DateFilter"(Parameter 1102601001)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_ItemFilter"(Parameter 1102601000)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_ItemFilter"(Parameter 1102601000)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_SourceNoFilter"(Parameter 1102601007)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_SourceNoFilter"(Parameter 1102601007)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_GlobalDim1Filter"(Parameter 1102601002)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_GlobalDim1Filter"(Parameter 1102601002)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_GlobalDim2Filter"(Parameter 1102601003)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_GlobalDim2Filter"(Parameter 1102601003)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim1Filter"(Parameter 1102601004)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim1Filter"(Parameter 1102601004)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim2Filter"(Parameter 1102601005)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim2Filter"(Parameter 1102601005)".


    //Unsupported feature: Property Modification (Data type) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim3Filter"(Parameter 1102601006)".


    //Unsupported feature: Property Insertion (Length) on "SetFilters(PROCEDURE 1102601000)."_BudgetDim3Filter"(Parameter 1102601006)".


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
