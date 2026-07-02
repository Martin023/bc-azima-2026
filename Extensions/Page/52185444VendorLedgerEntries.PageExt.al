#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185444 pageextension52185444 extends "Vendor Ledger Entries"
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
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
            visible = false;
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
        modify("Purchaser Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
            visible = false;

        }
        modify("Payment Reference")
        {
            ApplicationArea = Basic;
            visible = false;

        }
        modify("Creditor No.")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Original Amt. (LCY)")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
            visible = false;

            //Unsupported feature: Property Modification (Visible) on ""Amount (LCY)"(Control 47)".

        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Remaining Amt. (LCY)")
        {
            ApplicationArea = Basic;
            visible = false;
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
            visible = false;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("User ID")
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
            visible = false;
        }
        modify(Reversed)
        {
            ApplicationArea = Basic;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Exported to Payment File")
        {
            ApplicationArea = Basic;
            visible = false;

        }

        modify("Vendor Name")
        {
            Visible = false;
        }


        modify("Debit Amount")
        {
            Visible = true;
            ApplicationArea = Basic;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = true;
            ApplicationArea = Basic;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = false;
        }
        modify(RunningBalanceLCY)
        {
            //Visible = true;
            Visible = false;
            ApplicationArea = Basic;
        }

        addafter(RunningBalanceLCY)
        {
            field(RunningBalanceLCYAbs; RunningBalanceLCYAbs)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Running Balance (LCY)';
                ToolTip = 'Specifies the running balance in LCY.';
                AutoFormatType = 1;
                AutoFormatExpression = '';
                Visible = true;
            }
        }


        moveafter("Credit Amount"; RunningBalanceLCY)



        modify("Dimension Set ID")
        {
            Visible = false;
        }

    }
    actions
    {
        modify(AppliedEntries)
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Detailed &Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify(ActionApplyEntries)
        {
            ApplicationArea = Basic;
        }
        modify(UnapplyEntries)
        {
            ApplicationArea = Basic;
        }
        modify(ReverseTransaction)
        {
            ApplicationArea = Basic;
            Enabled = false;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(IncomingDocAttachFile)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 37)".

        }
        modify("Show Document")
        {
            Caption = 'Show Posted Document';
            ApplicationArea = Basic;
        }

        modify(SetDimensionFilter)
        {
            Visible = false;
        }


        modify(ShowDocumentAttachment)
        {
            Visible = false;
        }
        modify("Create Payment")
        {
            Visible = false;
        }
        addafter(ActionApplyEntries)
        {
            separator(Action66)
            {
            }
        }
        addafter(UnapplyEntries)
        {
            separator(Action68)
            {
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        RunningBalanceLCYAbs := Abs(CalcRunningVendBalance.GetVendorBalanceLCY(Rec));
    end;

    procedure GetVendorBalanceLCY(var VendorLedgerEntry: Record "Vendor Ledger Entry"): Decimal
    var
        RunningBalanceLCY: Decimal;
    begin
        CalcVendorBalance(rec."Entry No.", RunningBalanceLCY);
        exit(RunningBalanceLCY);
    end;

    procedure CalcVendorBalance(EntryNo: Integer; var RunningBalanceLCY: Decimal)
    var
    begin
        // vendorled
    end;

    var
        CalcRunningVendBalance: Codeunit "Calc. Running Vend. Balance";
        RunningBalanceLCYAbs: Decimal;

}
