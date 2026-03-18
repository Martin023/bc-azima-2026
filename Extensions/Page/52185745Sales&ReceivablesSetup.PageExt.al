#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185745 pageextension52185745 extends "Sales & Receivables Setup"
{
    layout
    {
        modify("Discount Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Warnings")
        {
            ApplicationArea = Basic;
        }
        modify("Stockout Warning")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment on Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Return Receipt on Credit Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Rounding")
        {
            ApplicationArea = Basic;
        }
       
        modify("Ext. Doc. No. Mandatory")
        {
            ApplicationArea = Basic;
        }
        modify("Appln. between Currencies")
        {
            ApplicationArea = Basic;
        }
        modify("Logo Position on Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Default Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Default Quantity to Ship")
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
        modify("Copy Comments Order to Shpt.")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Cmts Ret.Ord. to Ret.Rcpt")
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
        modify("VAT Bus. Posting Gr. (Price)")
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

            //Unsupported feature: Property Modification (ControlType) on ""Prepmt. Auto Update Frequency"(Control 13)".


            //Unsupported feature: Property Modification (Name) on ""Prepmt. Auto Update Frequency"(Control 13)".

            Caption = 'Post & Print';

            //Unsupported feature: Property Insertion (GroupType) on ""Prepmt. Auto Update Frequency"(Control 13)".

        }
        modify("Ignore Updated Addresses")
        {

            //Unsupported feature: Property Modification (Level) on ""Ignore Updated Addresses"(Control 11)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ignore Updated Addresses"(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Ignore Updated Addresses"(Control 11)".

        }
       
        modify("Quote Validity Calculation")
        {

            //Unsupported feature: Property Modification (Level) on ""Quote Validity Calculation"(Control 17)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Quote Validity Calculation"(Control 17)".


            //Unsupported feature: Property Modification (Name) on ""Quote Validity Calculation"(Control 17)".

        }
        modify("Customer Group Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Number Series")
        {
            Caption = 'Numbering';

            //Unsupported feature: Property Modification (Name) on ""Number Series"(Control 1904569201)".

        }
        modify("Customer Nos.")
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
        modify("Posted Shipment Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Receipt Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Reminder Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Issued Reminder Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Fin. Chrg. Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Issued Fin. Chrg. M. Nos.")
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
        modify("Direct Debit Mandate Nos.")
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

            //Unsupported feature: Property Modification (Level) on ""Notify On Success"(Control 4)".

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
        modify("Archive Blanket Orders")
        {
            Visible = false;
        }
        modify("Archive Orders")
        {
            Visible = false;
        }
        modify("Archive Return Orders")
        {
            Visible = false;
        }
        // modify("Dynamics 365 for Sales")
        // {
        //     Visible = false;
        // }
        modify("Write-in Product Type")
        {
            Visible = false;
        }
        modify("Write-in Product No.")
        {
            Visible = false;
        }
        modify("Freight G/L Acc. No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Check Prepmt. when Posting")
        {
            // field("Archive Quotes and Orders";Rec."Archive Quotes and Orders")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            // field("Salary Agreement Nos";"Salary Agreement Nos")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter("Customer Nos.")
        {
            field("Tenant Nos"; Rec."Tenant Nos")
            {

            }

        }
        moveafter("Invoice Rounding"; "Ext. Doc. No. Mandatory")
        moveafter("Check Prepmt. when Posting"; Dimensions)
        //moveafter(Post; "Post with Job Queue")
        moveafter("Post with Job Queue"; "Quote Validity Calculation")
        //moveafter("Post & Print"; "Post & Print with Job Queue")
    }
    actions
    {
        // modify(ActionContainer47)
        // {
        //     Visible = false;
        // }
        modify("Customer Posting Groups")
        {
            Visible = false;
        }
        modify("Customer Price Groups")
        {
            Visible = false;
        }
        modify("Customer Disc. Groups")
        {
            Visible = false;
        }
        modify(Payment)
        {
            Visible = false;
        }
        modify("Payment Registration Setup")
        {
            Visible = false;
        }
        modify("Payment Methods")
        {
            Visible = false;
        }
        modify("Payment Terms")
        {
            Visible = false;
        }
        modify("Finance Charge Terms")
        {
            Visible = false;
        }
        modify("Reminder Terms")
        {
            Visible = false;
        }
        modify("Rounding Methods")
        {
            Visible = false;
        }
    }


}
