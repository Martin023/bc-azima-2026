#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186989 pageextension52186989 extends "Bookkeeper Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901197008(Control 1901197008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control17(Control 17)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control18(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control18)
        {
          
        }
    }
    actions
    {
        // modify("A&ccount Schedule")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("&G/L Trial Balance")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Bank &Detail Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("T&rial Balance/Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Trial Balance by &Period")
        {
            ApplicationArea = Basic;
        }
        // modify("Closing Tria&l Balance")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("&Fiscal Year Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Balance C&omp. . Prev. Year")
        {
            ApplicationArea = Basic;
        }
        // modify("&Aged Accounts Receivable")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Aged Accou&nts Payable")
        {
            ApplicationArea = Basic;
        }
        modify("Reconcile Customer and &Vendor Accounts")
        {
            Caption = 'Reconcile Cust. and &Vend. Accs';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Reconcile Customer and &Vendor Accounts"(Action 52)".

        }
        // modify("VAT Reg&istration No. Check")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT E&xceptions")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT State&ment")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT - VI&ES Declaration Tax Auth")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT - VIES Declaration Dis&k")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("EC &Sales List")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Chart of Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(CustomersBalance)
        {

            //Unsupported feature: Property Modification (Name) on "CustomersBalance(Action 20)".

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
        modify(VendorsPaymentonHold)
        {

            //Unsupported feature: Property Modification (Name) on "VendorsPaymentonHold(Action 83)".

            ApplicationArea = Basic;
        }
        modify("VAT Statements")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify(CashReceiptJournals)
        {

            //Unsupported feature: Property Modification (Name) on "CashReceiptJournals(Action 95)".

            ApplicationArea = Basic;
        }
        modify(PaymentJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PaymentJournals(Action 96)".

            ApplicationArea = Basic;
        }
        modify(GeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "GeneralJournals(Action 97)".

            ApplicationArea = Basic;
        }
        modify(RecurringGeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "RecurringGeneralJournals(Action 98)".

            ApplicationArea = Basic;
        }
        // modify("Intrastat Journals")
        // {
        //     ApplicationArea = Basic;
        // }
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
        modify("Posted Purchase Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Shipments")
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
        modify("Issued Fi. Charge Memos")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Registers")
        {
            ApplicationArea = Basic;
        }
        modify("Requests Sent for Approval")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""Requests Sent for Approval"(Action 24)".

        }
        modify(RequestsToApprove)
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
        modify("Number Series")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Sales &Invoice"(Action 8)".

        }
        modify("Sales Credit &Memo")
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
        modify("&Vendor")
        {
            ApplicationArea = Basic;
        }
        modify("&Purchase Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""&Purchase Invoice"(Action 556)".

        }
        modify("Cash Re&ceipt Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Payment &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Registration")
        {
            ApplicationArea = Basic;
        }
        // modify("B&ank Account Reconciliations")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Adjust E&xchange Rates")
        {
            ApplicationArea = Basic;
        }
        modify("Post Inventor&y Cost to G/L")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. and Pos&t VAT Settlement")
        {
            ApplicationArea = Basic;
        }
        modify("Sa&les && Receivables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""A&ccount Schedule"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&G/L Trial Balance"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank &Detail Trial Balance"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&rial Balance/Budget"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance by &Period"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closing Tria&l Balance"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fiscal Year Balance"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance C&omp. . Prev. Year"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Aged Accounts Receivable"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accou&nts Payable"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reconcile Customer and &Vendor Accounts"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Reg&istration No. Check"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT E&xceptions"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT State&ment"(Action 56)".

        modify("G/L - VAT Reconciliation")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT - VI&ES Declaration Tax Auth"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT - VIES Declaration Dis&k"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EC &Sales List"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chart of Accounts"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Accounts"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustomersBalance(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorsBalance(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorsPaymentonHold(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Statements"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Invoices"(Action 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Invoices"(Action 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashReceiptJournals(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentJournals(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GeneralJournals(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecurringGeneralJournals(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Intrastat Journals"(Action 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Shipments"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Invoices"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Receipts"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Credit Memos"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Receipts"(Action 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Shipments"(Action 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Fi. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Registers"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requests Sent for Approval"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequestsToApprove(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currencies(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accounting Periods"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Number Series"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Invoice"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Credit &Memo"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Fin. Charge Memo"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Reminder"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Vendor"(Action 555)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Purchase Invoice"(Action 556)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Re&ceipt Journal"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment &Journal"(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Registration"(Action 19)".

        modify("Payment Reconciliation Journals")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""B&ank Account Reconciliations"(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust E&xchange Rates"(Action 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Inventor&y Cost to G/L"(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. and Pos&t VAT Settlement"(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sa&les && Receivables Setup"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 90)".

    }
}
