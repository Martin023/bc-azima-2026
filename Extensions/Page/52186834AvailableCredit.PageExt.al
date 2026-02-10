#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186834 pageextension52186834 extends "Available Credit" 
{
    layout
    {
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
        modify(GetTotalAmountLCYUI)
        {
            ApplicationArea = Basic;
        }
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(CalcAvailableCreditUI)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance (LCY)"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Orders (LCY)"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipped Not Invoiced (LCY)"(Control 9)".

        modify(GetReturnRcdNotInvAmountLCY)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Invoices (LCY)"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Serv. Orders (LCY)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv Shipped Not Invoiced(LCY)"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Serv.Invoices(LCY)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetTotalAmountLCYUI(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Limit (LCY)"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcAvailableCreditUI(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetInvoicedPrepmtAmountLCY(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
}
