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
        modify("Create Item from Item No.")
        {

            //Unsupported feature: Property Modification (ControlType) on ""Create Item from Item No."(Control 13)".


            //Unsupported feature: Property Modification (Name) on ""Create Item from Item No."(Control 13)".

            Caption = 'Post & Print';

            //Unsupported feature: Property Insertion (GroupType) on ""Create Item from Item No."(Control 13)".

        }
        modify("Copy Vendor Name to Entries")
        {

            //Unsupported feature: Property Modification (Level) on ""Copy Vendor Name to Entries"(Control 17)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Copy Vendor Name to Entries"(Control 17)".


            //Unsupported feature: Property Modification (Name) on ""Copy Vendor Name to Entries"(Control 17)".

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
        modify("Prepmt. Auto Update Frequency")
        {

            //Unsupported feature: Property Modification (ControlType) on ""Prepmt. Auto Update Frequency"(Control 9)".


            //Unsupported feature: Property Modification (Name) on ""Prepmt. Auto Update Frequency"(Control 9)".

            Caption = 'General';

            //Unsupported feature: Property Insertion (GroupType) on ""Prepmt. Auto Update Frequency"(Control 9)".

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

            //Unsupported feature: Property Modification (SourceExpr) on ""Allow Document Deletion Before"(Control 35)".


            //Unsupported feature: Property Modification (Name) on ""Allow Document Deletion Before"(Control 35)".

        }
        modify("Ignore Updated Addresses")
        {

            //Unsupported feature: Property Modification (Level) on ""Ignore Updated Addresses"(Control 11)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ignore Updated Addresses"(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Ignore Updated Addresses"(Control 11)".

        }
        modify("Number Series")
        {
            Caption = 'Numbering';

            //Unsupported feature: Property Modification (Name) on ""Number Series"(Control 1904569201)".

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

            //Unsupported feature: Property Modification (Level) on ""Post with Job Queue"(Control 19)".

            ApplicationArea = Basic;
        }
        modify("Post & Print with Job Queue")
        {

            //Unsupported feature: Property Modification (Level) on ""Post & Print with Job Queue"(Control 15)".

            ApplicationArea = Basic;
        }
        modify("Job Queue Category Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Job Queue Category Code"(Control 5)".

            ApplicationArea = Basic;
        }
        modify("Notify On Success")
        {

            //Unsupported feature: Property Modification (Level) on ""Notify On Success"(Control 3)".

            ApplicationArea = Basic;
        }
        modify("Archive Orders")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Archive Orders"(Control 41)".


            //Unsupported feature: Property Modification (Name) on ""Archive Orders"(Control 41)".

        }
        modify("Archive Blanket Orders")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Archive Blanket Orders"(Control 39)".


            //Unsupported feature: Property Modification (Name) on ""Archive Blanket Orders"(Control 39)".

        }
        modify("Archive Return Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""Archive Return Orders"(Control 37)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Archive Return Orders"(Control 37)".


            //Unsupported feature: Property Modification (Name) on ""Archive Return Orders"(Control 37)".

        }
        modify("Default Accounts")
        {
            Caption = 'Data Exchange';

            //Unsupported feature: Property Modification (Name) on ""Default Accounts"(Control 21)".

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



        addafter("Check Prepmt. when Posting")
        {
            // field("Archive Quotes and Orders";Rec."Archive Quotes and Orders")
            // {
            //     ApplicationArea = Basic;
            // }
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
        // moveafter("Requisition Default Vendor";"Archive Blanket Orders")
        //moveafter("Allow Invoice on PO";"Number Series")
        moveafter("Order Nos."; "Archive Orders")
        //moveafter("Contract No";"Return Order Nos.")
        moveafter("Post with Job Queue"; "Copy Vendor Name to Entries")
        //moveafter("Post & Print";"Post & Print with Job Queue")
        moveafter("Post & Print with Job Queue"; "Ignore Updated Addresses")

    }
    actions
    {
        // modify(ActionContainer33)
        // {
        //     Visible = false;
        // }
        modify("Vendor Posting Groups")
        {
            Visible = false;
        }
        modify("Incoming Documents Setup")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
