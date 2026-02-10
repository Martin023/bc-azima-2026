#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185428 pageextension52185428 extends "Customer Price Groups" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Allow Line Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Price Includes VAT")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Line Disc."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Includes VAT"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Gr. (Price)"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(SalesPrices)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SalesPrices(Action 18)".

        modify(ActionGroupCRM)
        {
            Visible = false;
        }
        modify(CRMGoToPricelevel)
        {
            Visible = false;
        }
        modify(CRMSynchronizeNow)
        {
            Visible = false;
        }
        modify(Coupling)
        {
            Visible = false;
        }
        modify(ManageCRMCoupling)
        {
            Visible = false;
        }
        modify(DeleteCRMCoupling)
        {
            Visible = false;
        }
        modify(ShowLog)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
