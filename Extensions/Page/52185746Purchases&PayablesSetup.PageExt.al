#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185746 pageextension52185746 extends "Purchases & Payables Setup"
{
    layout
    {
        modify("Discount Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Receipt on Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Return Shipment on Credit Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Rounding")
        {
            ApplicationArea = Basic;
        }

        modify("Copy Vendor Name to Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Ext. Doc. No. Mandatory")
        {
            ApplicationArea = Basic;
        }
        modify("Allow VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. Inv. Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            ApplicationArea = Basic;
        }
        modify("Appln. between Currencies")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Comments Blanket to Order")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Comments Order to Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Comments Order to Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Cmts Ret.Ord. to Ret.Shpt")
        {
            ApplicationArea = Basic;
        }
        modify("Exact Cost Reversing Mandatory")
        {
            ApplicationArea = Basic;
        }
        modify("Check Prepmt. when Posting")
        {
            ApplicationArea = Basic;
        }
       
        modify("Default Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Default Qty. to Receive")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Document Deletion Before")
        {
            ApplicationArea = Basic;

        }
        modify("Ignore Updated Addresses")
        {

            ApplicationArea = Basic;

        }
        modify("Number Series")
        {
            Caption = 'Numbering';
        }
        modify("Vendor Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Quote Nos.")
        {
            ApplicationArea = Basic;
        }

        modify("Blanket Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Return Order Nos.")
        {
            ApplicationArea = Basic;
        }

        modify("Invoice Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Invoice Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Credit Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Receipt Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Shpt. Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Prepmt. Inv. Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Prepmt. Cr. Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Post with Job Queue")
        {
            ApplicationArea = Basic;
        }
        modify("Post & Print with Job Queue")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Category Code")
        {
            ApplicationArea = Basic;
        }
        modify("Notify On Success")
        {
            ApplicationArea = Basic;
        }
        modify("Archive Orders")
        {
            ApplicationArea = Basic;

        }
        modify("Archive Blanket Orders")
        {
            ApplicationArea = Basic;

        }
        modify("Archive Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Acc. for Non-Item Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Acc. for Non-Item Lines")
        {
            ApplicationArea = Basic;
        }



        modify(Archiving)
        {
            Visible = false;
        }
        modify("Archive Quotes")
        {
            Visible = false;
        }

        addafter("Document Default Line Type")
        {
            field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Stores Requisition No"; Rec."Stores Requisition No")
            {
                ApplicationArea = Basic;
            }
            field("Requisition No"; Rec."Requisition No")
            {
                ApplicationArea = Basic;
            }
            field("Quotation Request No"; Rec."Quotation Request No")
            {
                ApplicationArea = Basic;
            }
        }
        addfirst("Background Posting")
        {
            group(Post)
            {
                Caption = 'Post';
            }
        }
        moveafter("Invoice Rounding"; "Ext. Doc. No. Mandatory")
        moveafter("Check Prepmt. when Posting"; "Default Posting Date")
        moveafter("Order Nos."; "Archive Orders")
        moveafter("Post with Job Queue"; "Copy Vendor Name to Entries")
        moveafter("Post & Print with Job Queue"; "Ignore Updated Addresses")

    }
}
