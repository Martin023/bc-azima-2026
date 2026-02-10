#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186053 pageextension52186053 extends "Payment Registration"
{
    Caption = 'Payment Registration';

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Payment Registration"(Page 981)".

    layout
    {
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
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
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Made")
        {
            ApplicationArea = Basic;
        }
        modify("Date Received")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Received")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify("Rem. Amt. after Discount")
        {
            ApplicationArea = Basic;
        }
        modify(PostedBalance)
        {
            ApplicationArea = Basic;
        }
        modify(UnpostedBalance)
        {
            ApplicationArea = Basic;
        }
        modify(TotalBalance)
        {
            ApplicationArea = Basic;
        }
        modify(Warning)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Made"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Received"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Received"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rem. Amt. after Discount"(Control 6)".

        modify(ExternalDocumentNo)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostedBalance(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnpostedBalance(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalBalance(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warning(Control 23)".

    }
    actions
    {
        modify(Navigate)
        {
            ToolTip = 'View and link to all entries that exist for the document number on the selected line.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Navigate(Action 30)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Navigate(Action 30)".

        }
        modify(Details)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Details(Action 28)".

        }
        modify(SearchCustomer)
        {
            ApplicationArea = Basic;
        }
        modify(SearchDocument)
        {
            ApplicationArea = Basic;
        }
        modify(PostPayments)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostPayments(Action 15)".

        }
        modify(PostAsLump)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostAsLump(Action 22)".

        }
        modify(PreviewPayments)
        {
            ApplicationArea = Basic;
        }
        modify(PreviewLump)
        {
            ApplicationArea = Basic;
        }
        modify(OpenGenJnl)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "OpenGenJnl(Action 19)".

        }
        modify(FinanceChargeMemo)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "FinanceChargeMemo(Action 18)".

        }
        modify(Setup)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (PromotedIsBig) on "PostPayments(Action 15)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "PostAsLump(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviewPayments(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on "PreviewPayments(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "PreviewPayments(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviewLump(Action 39)".


        //Unsupported feature: Property Deletion (Promoted) on "PreviewLump(Action 39)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "PreviewLump(Action 39)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "OpenGenJnl(Action 19)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "FinanceChargeMemo(Action 18)".

        //moveafter(ActionContainer37;ActionGroup36)
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
