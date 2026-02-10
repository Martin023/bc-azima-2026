#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185440 pageextension52185440 extends "Customer Ledger Entries"
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
        modify("User ID")
        {
            ApplicationArea = Basic;
            Visible = true;
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
            Visible = false;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Original Amt. (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
            Visible = false;

            //Unsupported feature: Property Modification (Visible) on ""Amount (LCY)"(Control 47)".

        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Remaining Amt. (LCY)")
        {
            ApplicationArea = Basic;
            Visible = false;
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
            Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
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
        }
        modify("Message to Recipient")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 8)".

        modify("Customer Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amt. (LCY)"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 47)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = true;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amt. (LCY)"(Control 49)".

        modify("Sales (LCY)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Pmt. Disc. Possible"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""On Hold"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 35)".


        //Unsupported feature: Property Deletion (Editable) on "Reversed(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 71)".


        //Unsupported feature: Property Deletion (Editable) on ""Reversed by Entry No."(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 75)".


        //Unsupported feature: Property Deletion (Editable) on ""Reversed Entry No."(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exported to Payment File"(Control 290)".


        //Unsupported feature: Property Deletion (Editable) on ""Exported to Payment File"(Control 290)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Message to Recipient"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Mandate ID"(Control 291)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1903096107(Control 1903096107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 9)".

        modify(Control38)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Customer No."; "Message to Recipient")

        addafter("Credit Amount (LCY)")
        {

            field(RunningBalance; CalcRunningAccBalance.GetCustAccBalance(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Running Balance';
            }
        }

        // addafter("Global Dimension 2 Code")
        // {
        //     field("User ID";Rec."User ID")
        // }
    }
    actions
    {
        modify("Reminder/Fin. Charge Entries")
        {
            ApplicationArea = Basic;
        }
        modify(AppliedEntries)
        {

            //Unsupported feature: Property Modification (Name) on "AppliedEntries(Action 69)".

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
        modify("Apply Entries")
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

            //Unsupported feature: Property Modification (PromotedCategory) on ""Show Document"(Action 13)".


            //Unsupported feature: Property Modification (Name) on ""Show Document"(Action 13)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder/Fin. Charge Entries"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reminder/Fin. Charge Entries"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reminder/Fin. Charge Entries"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedEntries(Action 69)".


        //Unsupported feature: Property Deletion (Promoted) on "AppliedEntries(Action 69)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "AppliedEntries(Action 69)".

        modify(Customer)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 51)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }



        modify(ShowDocumentAttachment)
        {
            Visible = false;
        }
        addafter("Apply Entries")
        {
            separator(Action63)
            {
            }
        }
        addafter(UnapplyEntries)
        {
            separator(Action65)
            {
            }
        }
    }




    procedure GetCustBalance(var CustLedgerEntry: Record "Cust. Ledger Entry"): Decimal
    var
        RunningBalance: Decimal;
        RunningBalanceLCY: Decimal;
    begin
        CalcCustBalance(CustLedgerEntry, RunningBalance, RunningBalanceLCY);
        exit(RunningBalance);
    end;



    local procedure CalcCustBalance(var CustLedgerEntry: Record "Cust. Ledger Entry"; var RunningBalance: Decimal; var RunningBalanceLCY: Decimal)
    var
        DateTotal: Decimal;
        DateTotalLCY: Decimal;
        CustLedgerEntry2: Record "Detailed Cust. Ledg. Entry";
        DayTotals: Dictionary of [Date, Decimal];
        DayTotalsLCY: Dictionary of [Date, Decimal];
        PrevTableID: Integer;
        PrevAccNo: Code[20];
        EntryValues: Dictionary of [Integer, Decimal];
        EntryValuesLCY: Dictionary of [Integer, Decimal];
        PrevHighestEntryNo: Integer;
    begin
        if (PrevTableID <> 0) and (PrevTableID <> Database::"Cust. Ledger Entry") or
           (PrevAccNo <> '') and (PrevAccNo <> CustLedgerEntry."Customer No.")
        then begin
            Clear(DayTotals);
            Clear(DayTotalsLCY);
            Clear(EntryValues);
            Clear(EntryValuesLCY);
            Clear(PrevHighestEntryNo);
        end;
        PrevTableID := Database::"Cust. Ledger Entry";
        PrevAccNo := CustLedgerEntry."Customer No.";

        if EntryValues.Get(CustLedgerEntry."Entry No.", RunningBalance) and EntryValuesLCY.Get(CustLedgerEntry."Entry No.", RunningBalanceLCY) then
            exit;

        CustLedgerEntry2.Reset();
        CustLedgerEntry2.SetLoadFields("Entry No.", "Customer No.", "Posting Date", Amount, "Amount (LCY)");
        CustLedgerEntry2.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        if not (DayTotals.Get(CustLedgerEntry."Posting Date", DateTotal) and DayTotalsLCY.Get(CustLedgerEntry."Posting Date", DateTotalLCY)) then begin
            CustLedgerEntry2.SetFilter("Posting Date", '<=%1', CustLedgerEntry."Posting Date");
            CustLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
            DateTotal := CustLedgerEntry2.Amount;
            DateTotalLCY := CustLedgerEntry2."Amount (LCY)";
            DayTotals.Add(CustLedgerEntry."Posting Date", DateTotal);
            DayTotalsLCY.Add(CustLedgerEntry."Posting Date", DateTotalLCY);
        end;
        CustLedgerEntry2.SetRange("Posting Date", CustLedgerEntry."Posting Date");
        CustLedgerEntry2.SetFilter("Entry No.", '>%1', CustLedgerEntry."Entry No.");
        CustLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
        RunningBalance := DateTotal - CustLedgerEntry2.Amount;
        RunningBalanceLCY := DateTotalLCY - CustLedgerEntry2."Amount (LCY)";
        EntryValues.Add(CustLedgerEntry."Entry No.", RunningBalance);
        EntryValuesLCY.Add(CustLedgerEntry."Entry No.", RunningBalanceLCY);
        if PrevHighestEntryNo < CustLedgerEntry."Entry No." then
            PrevHighestEntryNo := CustLedgerEntry."Entry No.";
    end;

    var
        CalcRunningAccBalance: Codeunit "Customer Running balalnce";

}
