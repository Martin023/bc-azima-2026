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
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Reference")
        {
            ApplicationArea = Basic;
        }
        modify("Creditor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Original Amt. (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Amount (LCY)"(Control 47)".

        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amt. (LCY)")
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
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 8)".

        modify("Vendor Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Message to Recipient"(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on ""Message to Recipient"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Reference"(Control 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creditor No."(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amt. (LCY)"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 47)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amt. (LCY)"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Pmt. Disc. Possible"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""On Hold"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 35)".


        //Unsupported feature: Property Deletion (Editable) on "Reversed(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 74)".


        //Unsupported feature: Property Deletion (Editable) on ""Reversed by Entry No."(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 76)".


        //Unsupported feature: Property Deletion (Editable) on ""Reversed Entry No."(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exported to Payment File"(Control 290)".


        //Unsupported feature: Property Deletion (Editable) on ""Exported to Payment File"(Control 290)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(AppliedEntries)
        {

            //Unsupported feature: Property Modification (Name) on "AppliedEntries(Action 72)".

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

            //Unsupported feature: Property Modification (PromotedCategory) on ""Show Document"(Action 13)".


            //Unsupported feature: Property Modification (Name) on ""Show Document"(Action 13)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedEntries(Action 72)".


        //Unsupported feature: Property Deletion (Promoted) on "AppliedEntries(Action 72)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "AppliedEntries(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 55)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 55)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 55)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Detailed &Ledger Entries"(Action 54)".


        //Unsupported feature: Property Deletion (Promoted) on ""Detailed &Ledger Entries"(Action 54)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Detailed &Ledger Entries"(Action 54)".


        //Unsupported feature: Code Modification on "ActionApplyEntries(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VendLedgEntry.COPY(Rec);
            VendEntryApplyPostEntries.ApplyVendEntryFormEntry(VendLedgEntry);
            VendLedgEntry.GET(VendLedgEntry."Entry No.");
            Rec := VendLedgEntry;
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VendLedgEntry.COPY(Rec);
            VendEntryApplyPostEntries.ApplyVendEntryFormEntry(VendLedgEntry);
            Rec := VendLedgEntry;
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ActionApplyEntries(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on "ActionApplyEntries(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ActionApplyEntries(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnapplyEntries(Action 67)".


        //Unsupported feature: Property Deletion (Promoted) on "UnapplyEntries(Action 67)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "UnapplyEntries(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReverseTransaction(Action 69)".


        //Unsupported feature: Property Deletion (Promoted) on "ReverseTransaction(Action 69)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ReverseTransaction(Action 69)".



        //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date",RECORDID);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 13)".

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


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.","Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        HasDocumentAttachment := HasPostedDocAttachment;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.","Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        */
    //end;

    //Unsupported feature: Property Deletion (Permissions).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
