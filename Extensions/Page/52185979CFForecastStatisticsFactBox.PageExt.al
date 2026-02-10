#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185979 pageextension52185979 extends "CF Forecast Statistics FactBox" 
{
    layout
    {
        modify(LiquidFunds)
        {
            ApplicationArea = Basic;
        }
        modify(Receivables)
        {
            ApplicationArea = Basic;
        }
        modify(SalesOrders)
        {
            ApplicationArea = Basic;
        }
        modify(ServiceOrders)
        {
            ApplicationArea = Basic;
        }
        modify(SaleofFixedAssets)
        {
            ApplicationArea = Basic;
        }
        modify(ManualRevenues)
        {
            ApplicationArea = Basic;
        }
        modify(Payables)
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseOrders)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetedFixedAssets)
        {
            ApplicationArea = Basic;
        }
        modify(ManualExpenses)
        {
            ApplicationArea = Basic;
        }
        modify(GLBudgets)
        {
            ApplicationArea = Basic;
        }
        modify(Total)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "LiquidFunds(Control 118)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Receivables(Control 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrders(Control 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceOrders(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SaleofFixedAssets(Control 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ManualRevenues(Control 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payables(Control 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseOrders(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetedFixedAssets(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ManualExpenses(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLBudgets(Control 2)".

        modify(Jobs)
        {
            Visible = false;
        }
        modify(Tax)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Total(Control 100)".

    }

    //Unsupported feature: Property Modification (Dimensions) on "Amounts(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //Amounts : 15;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Amounts : 11;
        //Variable type has not been exported.
}
