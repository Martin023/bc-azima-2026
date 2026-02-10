#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187005 pageextension52187005 extends "Small Business Owner RC" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control78(Control 78)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control69(Control 69)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control66(Control 66)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control70(Control 70)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control68(Control 68)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control2(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control12(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control99(Control 99)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control67(Control 67)".

        addafter(Control78)
        {
            part(Control24;"Copy Profile")
            {
            }
        }
    }
    actions
    {
        // modify("S&tatement")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (RunObject) on ""S&tatement"(Action 60)".

        // }
        modify("Customer - Order Su&mmary")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - T&op 10 List")
        {
            ApplicationArea = Basic;
        }
        // modify("Customer/&Item Sales")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Salesperson - Sales &Statistics")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Price &List")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Inventory - Sales &Back Orders")
        {
            ApplicationArea = Basic;
        }
        // modify("&G/L Trial Balance")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Trial Balance by &Period")
        {
            ApplicationArea = Basic;
        }
        modify("Closing T&rial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Ac&counts Receivable")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Accounts Pa&yable")
        {
            ApplicationArea = Basic;
        }
        modify("Reconcile Cust. and &Vend. Accs")
        {
            ApplicationArea = Basic;
        }
        // modify("VAT Registration No. Chec&k")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT E&xceptions")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("V&AT Statement")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT-VIES Declaration Tax A&uth")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT - VIES Declaration &Disk")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("EC Sal&es List")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Sales Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        // modify("Sales Orders - Microsoft Dynamics 365 for Sales")
        // {
        //     Caption = 'Dynamics CRM Sales Orders';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 43)".

        // }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(CustomersBalance)
        {

            //Unsupported feature: Property Modification (Name) on "CustomersBalance(Action 113)".

            ApplicationArea = Basic;
        }
        modify("Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify(Vendors)
        {
            ApplicationArea = Basic;
        }
        modify(VendorsBalance)
        {

            //Unsupported feature: Property Modification (Name) on "VendorsBalance(Action 103)".

            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(ItemJournals)
        {

            //Unsupported feature: Property Modification (Name) on "ItemJournals(Action 6)".

            ApplicationArea = Basic;
        }
        modify(PhysicalInventoryJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PhysicalInventoryJournals(Action 8)".

            ApplicationArea = Basic;
        }
        modify(RevaluationJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RevaluationJournals(Action 18)".

            ApplicationArea = Basic;
        }
        modify("Resource Journals")
        {
            ApplicationArea = Basic;
        }
        modify("FA Journals")
        {
            ApplicationArea = Basic;
        }
        modify(CashReceiptJournals)
        {

            //Unsupported feature: Property Modification (Name) on "CashReceiptJournals(Action 36)".

            ApplicationArea = Basic;
        }
        modify(PaymentJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PaymentJournals(Action 46)".

            ApplicationArea = Basic;
        }
        modify(GeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "GeneralJournals(Action 35)".

            ApplicationArea = Basic;
        }
        modify(RecurringJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringJournals(Action 47)".

            ApplicationArea = Basic;
        }
        modify("Requisition Worksheets")
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
        modify("Posted Sales Credit Memos")
        {
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
        modify("Issued Reminders")
        {
            ApplicationArea = Basic;
        }
        modify("Issued Fin. Charge Memos")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Statements")
        {
            ApplicationArea = Basic;
        }
        modify("Chart of Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify(Currencies)
        {
            ApplicationArea = Basic;
        }
        modify("Accounting Periods")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account Posting Groups")
        {
            ApplicationArea = Basic;
        }
        modify(Contacts)
        {
            ApplicationArea = Basic;
        }
        modify(Tasks)
        {
            Caption = 'To-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Tasks(Action 157)".

        }
        modify("Assembly BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Standard Sales Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Salespeople/Purchasers")
        {
            ApplicationArea = Basic;
        }
        modify("Customer Invoice Discount")
        {
            ApplicationArea = Basic;
        }
        modify(Purchasing)
        {
            Caption = 'Purchase';

            //Unsupported feature: Property Modification (Name) on "Purchasing(Action 92)".

        }
        modify("Standard Purchase Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Invoice Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Item Discount Groups")
        {
            ApplicationArea = Basic;
        }
        modify(Action126)
        {
            ApplicationArea = Basic;
        }
        modify("Resource Groups")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Price Changes")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Registers")
        {
            ApplicationArea = Basic;
        }
        modify(Employees)
        {
            ApplicationArea = Basic;
        }
        modify(Action17)
        {
            ApplicationArea = Basic;
        }
        modify("User Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Data Templates List")
        {
            ApplicationArea = Basic;
        }
        modify("Base Calendar List")
        {
            ApplicationArea = Basic;
        }
        modify("Post Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Extended Texts")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Credit &Memo")
        {
            ApplicationArea = Basic;
        }
        modify("&Sales Reminder")
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
        modify("Cash Receipt &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Pa&yment Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Price &Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Sales P&rices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("&Bank Account Reconciliation")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Registration")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust E&xchange Rates")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust &Item Costs/Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust &Cost - Item Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Post Inve&ntory Cost to G/L")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. and Post VAT Settlem&ent")
        {
            ApplicationArea = Basic;
        }
        modify("General Le&dger Setup")
        {
            ApplicationArea = Basic;
        }
        modify("S&ales && Receivables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""S&tatement"(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Order Su&mmary"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - T&op 10 List"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer/&Item Sales"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson - Sales &Statistics"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price &List"(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - Sales &Back Orders"(Action 130)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&G/L Trial Balance"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance by &Period"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closing T&rial Balance"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Ac&counts Receivable"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accounts Pa&yable"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reconcile Cust. and &Vend. Accs"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No. Chec&k"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT E&xceptions"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""V&AT Statement"(Action 56)".

        modify("G/L - VAT Reconciliation")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT-VIES Declaration Tax A&uth"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT - VIES Declaration &Disk"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EC Sal&es List"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Quotes"(Action 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustomersBalance(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorsBalance(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemJournals(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PhysicalInventoryJournals(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RevaluationJournals(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Journals"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Journals"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashReceiptJournals(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentJournals(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GeneralJournals(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringJournals(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requisition Worksheets"(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Shipments"(Action 118)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Invoices"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Credit Memos"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Receipts"(Action 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Statements"(Action 152)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chart of Accounts"(Action 154)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Accounts"(Action 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currencies(Action 144)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accounting Periods"(Action 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 150)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Posting Groups"(Action 151)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contacts(Action 156)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Tasks(Action 157)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly BOM"(Action 159)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Credit Memos"(Action 160)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Sales Codes"(Action 161)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespeople/Purchasers"(Action 162)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Invoice Discount"(Action 163)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Purchase Codes"(Action 122)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Invoice Discounts"(Action 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Discount Groups"(Action 124)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action126(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Groups"(Action 131)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Price Changes"(Action 136)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Registers"(Action 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Employees(Action 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action17(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User Setup"(Action 141)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Templates List"(Action 165)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Calendar List"(Action 166)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Codes"(Action 167)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Codes"(Action 168)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Extended Texts"(Action 169)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Order"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Credit &Memo"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Sales Reminder"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Vendor"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Purchase Order"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Receipt &Journal"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Pa&yment Journal"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Price &Worksheet"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales P&rices"(Action 173)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Line Discounts"(Action 174)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Bank Account Reconciliation"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Registration"(Action 170)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust E&xchange Rates"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust &Item Costs/Prices"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust &Cost - Item Entries"(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Inve&ntory Cost to G/L"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. and Post VAT Settlem&ent"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""General Le&dger Setup"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&ales && Receivables Setup"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 42)".

    }
}
