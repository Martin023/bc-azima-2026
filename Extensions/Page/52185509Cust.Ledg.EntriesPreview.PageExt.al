#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185509 pageextension52185509 extends "Cust. Ledg. Entries Preview" 
{
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Message to Recipient")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(OriginalAmountFCY)
        {
            ApplicationArea = Basic;
        }
        modify(OriginalAmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify(AmountFCY)
        {
            ApplicationArea = Basic;
        }
        modify(AmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify(RemainingAmountFCY)
        {
            ApplicationArea = Basic;
        }
        modify(RemainingAmountLCY)
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
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
        modify("Pmt. Disc. Tolerance Date")
        {
            ApplicationArea = Basic;
        }
        modify("Original Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Payment Tolerance")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
        }
        modify("Exported to Payment File")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Message to Recipient"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OriginalAmountFCY(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OriginalAmountLCY(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountFCY(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountLCY(Control 47)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingAmountFCY(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingAmountLCY(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Pmt. Disc. Possible"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""On Hold"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exported to Payment File"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 87)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 7)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "CalcAmounts(PROCEDURE 2)".

}
