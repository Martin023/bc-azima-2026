#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186095 pageextension52186095 extends "Cost Type Balance" 
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

        //Unsupported feature: Property Deletion (ToolTipML) on "CostCenterFilter(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostObjectFilter(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "MatrixForm(Control 20)".

    }
    actions
    {
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

        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousColumn(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextColumn(Action 10)".

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

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 1)".


    //Unsupported feature: Property Insertion (OptionString) on "SetColumns(PROCEDURE 1).SetWanted(Parameter 1000)".


    //Unsupported feature: Property Insertion (OptionString) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 3)."MATRIX_SetWanted"(Parameter 1000)".

}
