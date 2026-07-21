namespace AZIMA.AZIMA;

using Microsoft.Purchases.Document;

pageextension 52185455 "Purchase Quotes Subform Ext" extends "Purchase Quote Subform"
{
    layout
    {
        modify("Line Amount")
        {
            ApplicationArea = Basic;
            visible = true;
            Caption = 'Line Amount Incl. VAT';
        }

        modify("Tax Group Code")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Tax Liable")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Line Discount %")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Qty. to Assign")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Qty. Assigned")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Location Code")
        {
            ApplicationArea = Basic;
            showmandatory = true;
        }

        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
            showmandatory = true;
            caption = 'Direct Unit Cost Incl. VAT';
        }

        modify("Quantity")
        {
            ApplicationArea = Basic;
            showmandatory = true;
        }

        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("AmountBeforeDiscount")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Invoice Disc. Pct.")
        {
            ApplicationArea = Basic;
            visible = false;
        }
    }
}
