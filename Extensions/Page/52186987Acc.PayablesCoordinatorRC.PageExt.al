#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186987 pageextension52186987 extends "Acc. Payables Coordinator RC" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900601808(Control 1900601808)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control10(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control12(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control12)
        {
            // part(Control1903012608;"Copy Profile")
            // {
            //     Visible = false;
            // }
        }
    }
    actions
    {
        modify("&Vendor - List")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor - &Balance to date")
        {
            ApplicationArea = Basic;
        }
        // modify("Vendor - &Summary Aging")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Aged &Accounts Payable")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Vendor - &Purchase List")
        {
            ApplicationArea = Basic;
        }
        modify("Pa&yments on Hold")
        {
            ApplicationArea = Basic;
        }
        // modify("P&urchase Statistics")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Vendor &Document Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Invoice Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Credit Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify(Vendors)
        {
            ApplicationArea = Basic;
        }
        modify(VendorsBalance)
        {

            //Unsupported feature: Property Modification (Name) on "VendorsBalance(Action 5)".

            ApplicationArea = Basic;
        }
        modify("Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseJournals(Action 22)".

            ApplicationArea = Basic;
        }
        modify(PaymentJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PaymentJournals(Action 23)".

            ApplicationArea = Basic;
        }
        modify(GeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "GeneralJournals(Action 24)".

            ApplicationArea = Basic;
        }
        modify("Posted Purchase Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Shipments")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Registers")
        {
            ApplicationArea = Basic;
        }
        modify("&Vendor")
        {
            ApplicationArea = Basic;
        }
        modify("&Purchase Order")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Purchase &Invoice"(Action 4)".

        }
        modify("Purchase Credit &Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Payment &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("P&urchase Journal")
        {
            ApplicationArea = Basic;
        }
        modify(VendorPayments)
        {

            //Unsupported feature: Property Modification (Name) on "VendorPayments(Action 14)".

            Caption = 'Payment Voucher';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on "VendorPayments(Action 14)".


            //Unsupported feature: Property Modification (Image) on "VendorPayments(Action 14)".

        }
        modify("Purchases && Payables &Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Vendor - List"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor - &Balance to date"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor - &Summary Aging"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged &Accounts Payable"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor - &Purchase List"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pa&yments on Hold"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&urchase Statistics"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor &Document Nos."(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Invoice Nos."(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Credit Memo Nos."(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorsBalance(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Invoices"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Return Orders"(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Credit Memos"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Accounts"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseJournals(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentJournals(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GeneralJournals(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Receipts"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Shipments"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Registers"(Action 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Vendor"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Purchase Order"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Invoice"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Credit &Memo"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment &Journal"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&urchase Journal"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorPayments(Action 14)".


        //Unsupported feature: Property Deletion (RunPageView) on "VendorPayments(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "VendorPayments(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchases && Payables &Setup"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 41)".

        addafter(VendorPayments)
        {
            action("Petty Cash Voucher")
            {
                ApplicationArea = Basic;
                Caption = 'Petty Cash Voucher';
                Image = CashFlow;
                //RunObject = Page 52185923;
            }
        }
        moveafter("Purchase Credit &Memo";VendorPayments)
    }
}
