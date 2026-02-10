#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186102 pageextension52186102 extends "Cost Budget per Period" 
{
    layout
    {
        modify(CostCenterFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CostObjectFilter)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetFilter)
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
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CostCenterFilter(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostObjectFilter(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetFilter(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 20)".

    }
    actions
    {
        modify("By Cost &Center")
        {
            ApplicationArea = Basic;
        }
        modify("By Cost &Object")
        {
            ApplicationArea = Basic;
        }
        modify("Budget / Movement")
        {
            ApplicationArea = Basic;
        }
        modify(PreviousSet)
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify(PreviousColumn)
        {
            ApplicationArea = Basic;
        }
        modify(NextColumn)
        {
            ApplicationArea = Basic;
        }
        modify(NextSet)
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }
        modify("Copy Cost Budget to Cost Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Copy G/L Budget to Cost Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Cost Budget to G/L Budget")
        {
            ApplicationArea = Basic;
        }
        modify(ExportToExcel)
        {
            ApplicationArea = Basic;
        }
        modify(ImportFromExcel)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""By Cost &Center"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""By Cost &Object"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget / Movement"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousColumn(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextColumn(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Cost Budget to Cost Budget"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy G/L Budget to Cost Budget"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Cost Budget to G/L Budget"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 22)".


        //Unsupported feature: Code Modification on "ImportFromExcel(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CostBudgetEntry.SETFILTER("Budget Name",BudgetFilter);
            ImportCostBudgetFromExcel.SetGLBudgetName(CostBudgetEntry.GETRANGEMIN("Budget Name"));
            ImportCostBudgetFromExcel.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ImportCostBudgetFromExcel.SetGLBudgetName(BudgetFilter);
            ImportCostBudgetFromExcel.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportFromExcel(Action 21)".

    }


    //Unsupported feature: Property Modification (Data type) on "CostCenterFilter(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //CostCenterFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CostCenterFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "CostObjectFilter(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //CostObjectFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CostObjectFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetFilter(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetFilter : Code;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 1)".

}
