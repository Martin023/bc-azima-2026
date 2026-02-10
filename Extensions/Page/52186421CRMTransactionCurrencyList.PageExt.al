#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186421 pageextension52186421 extends "CRM TransactionCurrency List" 
{
    Caption = 'Microsoft Dynamics CRM Transaction Currencies';
    layout
    {
        modify(ISOCurrencyCode)
        {
            ApplicationArea = Basic;
        }
        modify(CurrencyName)
        {
            ApplicationArea = Basic;
        }
        modify(Coupled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ISOCurrencyCode(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrencyName(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Coupled(Control 3)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentlyCoupledCRMTransactioncurrency(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
