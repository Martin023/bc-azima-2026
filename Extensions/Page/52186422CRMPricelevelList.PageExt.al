#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186422 pageextension52186422 extends "CRM Pricelevel List" 
{
    Caption = 'Microsoft Dynamics CRM Price List';
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(StateCode)
        {
            ApplicationArea = Basic;
        }
        modify(StatusCode)
        {
            ApplicationArea = Basic;
        }
        modify(TransactionCurrencyIdName)
        {
            ApplicationArea = Basic;
        }
        modify(ExchangeRate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StateCode(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatusCode(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TransactionCurrencyIdName(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExchangeRate(Control 7)".

        modify(Coupled)
        {
            Visible = false;
        }
    }
}
