#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186427 pageextension52186427 extends "CRM Statistics FactBox" 
{
    Caption = 'Dynamics CRM Statistics';
    layout
    {
        modify(Opportunities)
        {
            ApplicationArea = Basic;
        }
        modify(Quotes)
        {
            ApplicationArea = Basic;
        }
        modify(Cases)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Opportunities(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quotes(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Cases(Control 4)".

    }
}
