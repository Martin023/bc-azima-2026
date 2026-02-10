#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186485 pageextension52186485 extends "Insurance Statistics" 
{
    layout
    {
        modify("Annual Premium")
        {
            ApplicationArea = Basic;
        }
        modify("Policy Coverage")
        {
            ApplicationArea = Basic;
        }
        modify("Total Value Insured")
        {
            ApplicationArea = Basic;
        }
        modify("""Policy Coverage"" - ""Total Value Insured""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Annual Premium"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Policy Coverage"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Value Insured"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Policy Coverage" - "Total Value Insured"(Control 8)".

    }
}
