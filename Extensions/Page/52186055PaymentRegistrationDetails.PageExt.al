#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186055 pageextension52186055 extends "Payment Registration Details"
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Rem. Amt. after Discount")
        {
            ApplicationArea = Basic;
        }
        // modify(Control16)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rem. Amt. after Discount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control16(Control 16)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Control16(Control 16)".

    }
    actions
    {
        modify(FinanceChargeMemo)
        {
            ApplicationArea = Basic;
        }
        modify(Navigate)
        {
            ToolTip = 'View and link to all entries that exist for the document number on the selected line.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (PromotedCategory) on "FinanceChargeMemo(Action 24)".

    }
}
