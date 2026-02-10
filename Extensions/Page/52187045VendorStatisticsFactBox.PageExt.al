#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187045 pageextension52187045 extends "Vendor Statistics FactBox" 
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
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Invoices (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify("Balance Due (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(GetInvoicedPrepmtAmountLCY)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 13)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance (LCY)"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Orders (LCY)"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amt. Rcd. Not Invoiced (LCY)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Invoices (LCY)"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmountLCY(Control 9)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Balance Due (LCY)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetInvoicedPrepmtAmountLCY(Control 1)".

        modify("Payments (LCY)")
        {
            Visible = false;
        }
        modify("Refunds (LCY)")
        {
            Visible = false;
        }
        modify(LastPaymentDate)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FILTERGROUP(4);
        SETAUTOCALCFIELDS("Balance (LCY)","Outstanding Orders (LCY)","Amt. Rcd. Not Invoiced (LCY)","Outstanding Invoices (LCY)");
        TotalAmountLCY := "Balance (LCY)" + "Outstanding Orders (LCY)" + "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SETAUTOCALCFIELDS("Balance (LCY)","Outstanding Orders (LCY)","Amt. Rcd. Not Invoiced (LCY)","Outstanding Invoices (LCY)");
        TotalAmountLCY := "Balance (LCY)" + "Outstanding Orders (LCY)" + "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)";
        */
    //end;
}
