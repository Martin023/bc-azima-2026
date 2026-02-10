#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186103 pageextension52186103 extends "Cost Budget by Cost Center" 
{
    layout
    {
        modify(RoundingFactor)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetFilter(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 17)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 18)".

    }
    actions
    {
        modify("By &Period")
        {
            ApplicationArea = Basic;
        }
        modify("By Cost &Object")
        {
            ApplicationArea = Basic;
        }
        modify("&Budget / Movement")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""By &Period"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""By Cost &Object"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Budget / Movement"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousColumn(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextColumn(Action 10)".

    }

    //Unsupported feature: Property Modification (OptionString) on "PeriodType(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //PeriodType : Day,Week,Month,Quarter,Year,"Accounting Period";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PeriodType : Day,Week,Month,Quarter,Year,Period;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "BudgetFilter(Variable 1014)".

    //var
        //>>>> ORIGINAL VALUE:
        //BudgetFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BudgetFilter : Code;
        //Variable type has not been exported.
}
