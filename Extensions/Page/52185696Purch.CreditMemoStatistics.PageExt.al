#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185696 pageextension52185696 extends "Purch. Credit Memo Statistics" 
{
    layout
    {
        modify("VendAmount + InvDiscAmount")
        {
            ApplicationArea = Basic;
        }
        modify(InvDiscAmount)
        {
            ApplicationArea = Basic;
        }
        modify(VendAmount)
        {
            ApplicationArea = Basic;
        }
        modify(VATAmount)
        {
            ApplicationArea = Basic;
        }
        modify(AmountInclVAT)
        {
            ApplicationArea = Basic;
        }
        modify(AmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify(LineQty)
        {
            ApplicationArea = Basic;
        }
        modify(TotalParcels)
        {
            ApplicationArea = Basic;
        }
        modify(TotalNetWeight)
        {
            ApplicationArea = Basic;
        }
        modify(TotalGrossWeight)
        {
            ApplicationArea = Basic;
        }
        modify(TotalVolume)
        {
            ApplicationArea = Basic;
        }
        modify("Vend.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VendAmount + InvDiscAmount"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InvDiscAmount(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendAmount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VATAmount(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountInclVAT(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountLCY(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineQty(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalParcels(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalNetWeight(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalGrossWeight(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalVolume(Control 17)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SubForm(Control 18)".


        //Unsupported feature: Property Deletion (PartType) on "SubForm(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vend.""Balance (LCY)"""(Control 21)".

    }
}
