#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186723 pageextension52186723 extends "Contract Trendscape" 
{
    layout
    {
        modify(ContractNo)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ToolTip = 'Day';
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ContractNo(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 13)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "TrendLines(Control 3)".


        //Unsupported feature: Property Deletion (PartType) on "TrendLines(Control 3)".

    }

    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
        /*
        ContractNo := "Contract No.";
        UpdateSubform;
        */
    //end;
}
