#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186988 pageextension52186988 extends "Acc. Receivables Adm. RC" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902899408(Control 1902899408)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control38(Control 38)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control1902899408)
        {
            // part(Control47; Page 52186055)
            // {
            // }
        }
        addafter(Control1)
        {
            // part(Control1903012608;"Copy Profile")
            // {
            //     Visible = false;
            // }
        }
    }
    actions
    {
        // modify("C&ustomer - List")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Customer - &Balance to Date")
        {
            ApplicationArea = Basic;
        }
        // modify("Aged &Accounts Receivable")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Customer - &Summary Aging Simp.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - Trial Balan&ce")
        {
            ApplicationArea = Basic;
        }
        // modify("Cus&tomer/Item Sales")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Customer &Document Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Invoice Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Sa&les Credit Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Re&minder Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Finance Cha&rge Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(CustomersBalance)
        {

            //Unsupported feature: Property Modification (Name) on "CustomersBalance(Action 2)".

            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify(Reminders)
        {
            ApplicationArea = Basic;
        }
        modify("Finance Charge Memos")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(SalesJournals)
        {

            //Unsupported feature: Property Modification (Name) on "SalesJournals(Action 31)".

            ApplicationArea = Basic;
        }
        modify(CashReceiptJournals)
        {

            //Unsupported feature: Property Modification (Name) on "CashReceiptJournals(Action 32)".

            ApplicationArea = Basic;
        }
        modify(GeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "GeneralJournals(Action 33)".

            ApplicationArea = Basic;
        }
        modify("Direct Debit Collections")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Sales Shipments")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Sales Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Sales Credit Memos")
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
        modify("Issued Reminders")
        {
            ApplicationArea = Basic;
        }
        modify("Issued Fin. Charge Memos")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Registers")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify(PaymentRegistration)
        {

            //Unsupported feature: Property Modification (Level) on "PaymentRegistration(Action 21)".


            //Unsupported feature: Property Modification (Name) on "PaymentRegistration(Action 21)".

            Caption = 'Receipt';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on "PaymentRegistration(Action 21)".


            //Unsupported feature: Property Modification (Image) on "PaymentRegistration(Action 21)".

        }
        modify("Sales &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Sales &Invoice"(Action 104)".

        }
        modify("Sales &Credit Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Fin. Charge Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Reminder")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Receipt &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Combine Shi&pments")
        {
            ApplicationArea = Basic;
        }
        modify("Combine Return S&hipments")
        {
            ApplicationArea = Basic;
        }
        modify("Create Recurring Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales && Recei&vables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer - List"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - &Balance to Date"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged &Accounts Receivable"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - &Summary Aging Simp."(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Trial Balan&ce"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cus&tomer/Item Sales"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer &Document Nos."(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Invoice Nos."(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sa&les Credit Memo Nos."(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&minder Nos."(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Cha&rge Memo Nos."(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustomersBalance(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Invoices"(Action 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Return Orders"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Accounts"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reminders(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memos"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesJournals(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashReceiptJournals(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GeneralJournals(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Collections"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Shipments"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Invoices"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Receipts"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Credit Memos"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Registers"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentRegistration(Action 21)".


        //Unsupported feature: Property Deletion (Promoted) on "PaymentRegistration(Action 21)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "PaymentRegistration(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Order"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Invoice"(Action 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Credit Memo"(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Fin. Charge Memo"(Action 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Reminder"(Action 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Receipt &Journal"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Combine Shi&pments"(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Combine Return S&hipments"(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Recurring Invoices"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales && Recei&vables Setup"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 90)".

        addfirst("&Sales")
        {
            action("Staff Advance")
            {
                ApplicationArea = Basic;
                Caption = 'Staff Advance';
                Image = EmployeeAgreement;
                RunObject = Page 52185949;
            }
            action("Staff Advance Surrender")
            {
                ApplicationArea = Basic;
                Caption = 'Staff Advance Surrender';
                Image = ContractPayment;
                RunObject = Page 52185951;
            }
           
           
            action("Staff Claim")
            {
                ApplicationArea = Basic;
                Caption = 'Staff Claim';
                Image = ReturnReceipt;
                RunObject = Page 52185947;
            }
            action("Store Requisition")
            {
                ApplicationArea = Basic;
                Caption = 'Store Requisition';
                Image = Item;
                RunObject = Page 52185902;
            }
            action("Purchase Requisition")
            {
                ApplicationArea = Basic;
                Caption = 'Purchase Requisition';
                Image = Purchasing;
                RunObject = Page 52185904;
            }
        }
        moveafter("C&ustomer";"&Sales")
    }
}
