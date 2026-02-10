#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187033 pageextension52187033 extends "Customer Statistics FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Balance (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Orders (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Invoices (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Serv. Orders (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Serv Shipped Not Invoiced(LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Serv.Invoices(LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Total (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Balance Due (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Sales (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(GetInvoicedPrepmtAmountLCY)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 19)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance (LCY)"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Orders (LCY)"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipped Not Invoiced (LCY)"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Invoices (LCY)"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Serv. Orders (LCY)"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv Shipped Not Invoiced(LCY)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Serv.Invoices(LCY)"(Control 3)".

        modify(Payments)
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        modify("Refunds (LCY)")
        {
            Visible = false;
        }
        modify(LastPaymentReceiptDate)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Total (LCY)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Limit (LCY)"(Control 11)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Balance Due (LCY)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales (LCY)"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetInvoicedPrepmtAmountLCY(Control 8)".

    }
}
