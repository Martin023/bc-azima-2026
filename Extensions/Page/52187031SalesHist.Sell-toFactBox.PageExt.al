#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187031 pageextension52187031 extends "Sales Hist. Sell-to FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Quotes")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Quotes"(Control 3)".

            Caption = 'Quotes';
            ApplicationArea = Basic;
        }
        modify("No. of Blanket Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Blanket Orders"(Control 5)".

            Caption = 'Blanket Orders';
            ApplicationArea = Basic;
        }
        modify("No. of Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Orders"(Control 7)".

            Caption = 'Orders';
            ApplicationArea = Basic;
        }
        modify("No. of Invoices")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Invoices"(Control 9)".

            Caption = 'Invoices';
            ApplicationArea = Basic;
        }
        modify("No. of Return Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Return Orders"(Control 11)".

            Caption = 'Return Orders';
            ApplicationArea = Basic;
        }
        modify("No. of Credit Memos")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Credit Memos"(Control 13)".

            Caption = 'Credit Memos';
            ApplicationArea = Basic;
        }
        modify("No. of Pstd. Shipments")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Shipments"(Control 15)".

            Caption = 'Pstd. Shipments';
            ApplicationArea = Basic;
        }
        modify("No. of Pstd. Invoices")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Invoices"(Control 17)".

            Caption = 'Pstd. Invoices';
            ApplicationArea = Basic;
        }
        modify("No. of Pstd. Return Receipts")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Return Receipts"(Control 19)".

            Caption = 'Pstd. Return Receipts';
            ApplicationArea = Basic;
        }
        modify("No. of Pstd. Credit Memos")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Credit Memos"(Control 21)".

            Caption = 'Pstd. Credit Memos';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 1)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 1)".

        modify(Control23)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Quotes"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Blanket Orders"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Orders"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Invoices"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Return Orders"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Credit Memos"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Shipments"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Invoices"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Return Receipts"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Credit Memos"(Control 21)".

        modify(Control2)
        {
            Visible = false;
        }
        modify(NoofQuotesTile)
        {
            Visible = false;
        }
        modify(NoofBlanketOrdersTile)
        {
            Visible = false;
        }
        modify(NoofOrdersTile)
        {
            Visible = false;
        }
        modify(NoofInvoicesTile)
        {
            Visible = false;
        }
        modify(NoofReturnOrdersTile)
        {
            Visible = false;
        }
        modify(NoofCreditMemosTile)
        {
            Visible = false;
        }
        modify(NoofPstdShipmentsTile)
        {
            Visible = false;
        }
        modify(NoofPstdInvoicesTile)
        {
            Visible = false;
        }
        modify(NoofPstdReturnReceiptsTile)
        {
            Visible = false;
        }
        modify(NoofPstdCreditMemosTile)
        {
            Visible = false;
        }
    }
}
