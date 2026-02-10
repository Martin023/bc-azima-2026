#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185533 pageextension52185533 extends "Vendor Purchases" 
{
    layout
    {
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

        //Unsupported feature: Property Deletion (ApplicationArea) on "VendPurchLines(Control 3)".

    }
}
