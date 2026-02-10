#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186119 pageextension52186119 extends "Direct Debit Collect. Entries" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer Name")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Date")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction ID")
        {
            ApplicationArea = Basic;
        }
        modify("Mandate ID")
        {
            ApplicationArea = Basic;
        }
        modify("Sequence Type")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Mandate Type of Payment")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Description")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Rem. Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry Open")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Document No."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Amount"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction ID"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mandate ID"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sequence Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mandate Type of Payment"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Description"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Posting Date"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Currency Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Amount"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Rem. Amount"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry Open"(Control 26)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control28(Control 28)".

    }
    actions
    {
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Close)
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Close(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 25)".

        modify(ResetTransferDate)
        {
            Visible = false;
        }
    }
}
