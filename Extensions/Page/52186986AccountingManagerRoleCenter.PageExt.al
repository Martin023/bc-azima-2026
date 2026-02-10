#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186986 pageextension52186986 extends "Accounting Manager Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control99(Control 99)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902304208(Control 1902304208)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control103(Control 103)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control106(Control 106)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control100(Control 100)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control108(Control 108)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control108)
        {
            // part(Control1903012608;"Copy Profile")
            // {
            // }
        }
    }
    actions
    {
        modify("&G/L Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("&Bank Detail Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("&Account Schedule")
        {
            ApplicationArea = Basic;
        }
        // modify("Bu&dget")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Trial Bala&nce/Budget")
        {
            ApplicationArea = Basic;
        }
        // modify("Trial Balance by &Period")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("&Fiscal Year Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Balance Comp. - Prev. Y&ear")
        {
            ApplicationArea = Basic;
        }
        modify("&Closing Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Date List")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Accounts &Receivable")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Accounts Pa&yable")
        {
            ApplicationArea = Basic;
        }
        // modify("Reconcile Cus&t. and Vend. Accs")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("&VAT Registration No. Check")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("VAT E&xceptions")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("VAT &Statement")
        {
            ApplicationArea = Basic;
        }
        modify("VAT - VIES Declaration Tax Aut&h")
        {
            ApplicationArea = Basic;
        }
        modify("VAT - VIES Declaration Dis&k")
        {
            ApplicationArea = Basic;
        }
        modify("EC Sales &List")
        {
            ApplicationArea = Basic;
        }
        // modify("&Intrastat - Checklist")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Intrastat - For&m")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Cost Accounting P/L Statement")
        {
            ApplicationArea = Basic;
        }
        modify("CA P/L Statement per Period")
        {
            ApplicationArea = Basic;
        }
        modify("CA P/L Statement with Budget")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Accounting Analysis")
        {
            ApplicationArea = Basic;
        }
        modify("Chart of Accounts")
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
        modify(Budgets)
        {
            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Statements")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify(CustomersBalance)
        {

            //Unsupported feature: Property Modification (Name) on "CustomersBalance(Action 13)".

            ApplicationArea = Basic;
        }
        modify("Sales Orders")
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
        modify("Incoming Documents")
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseJournals(Action 117)".

            ApplicationArea = Basic;
        }
        modify(SalesJournals)
        {

            //Unsupported feature: Property Modification (Name) on "SalesJournals(Action 118)".

            ApplicationArea = Basic;
        }
        modify(CashReceiptJournals)
        {

            //Unsupported feature: Property Modification (Name) on "CashReceiptJournals(Action 113)".

            ApplicationArea = Basic;
        }
        modify(PaymentJournals)
        {

            //Unsupported feature: Property Modification (Name) on "PaymentJournals(Action 114)".

            ApplicationArea = Basic;
        }
        modify(ICGeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "ICGeneralJournals(Action 1102601000)".

            ApplicationArea = Basic;
        }
        modify(GeneralJournals)
        {

            //Unsupported feature: Property Modification (Name) on "GeneralJournals(Action 1102601001)".

            ApplicationArea = Basic;
        }
        // modify("Intrastat Journals")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Action17)
        {
            ApplicationArea = Basic;
        }
        modify(Insurance)
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Assets G/L Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Assets Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Assets Reclass. Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance Journals")
        {
            ApplicationArea = Basic;
        }
        modify("<Action3>")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Fixed Asset Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Forecasts")
        {
            ApplicationArea = Basic;
        }
        modify("Chart of Cash Flow Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Manual Revenues")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Manual Expenses")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Types")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Centers")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Objects")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Allocations")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Budgets")
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
        modify("Cost Accounting Registers")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Accounting Budget Registers")
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
        modify("Analysis Views")
        {
            ApplicationArea = Basic;
        }
        modify("Account Schedules")
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
        modify("Sales &Credit Memo")
        {
            ApplicationArea = Basic;
        }
        modify("P&urchase Credit Memo")
        {
            ApplicationArea = Basic;
        }
        modify("Cas&h Receipt Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Pa&yment Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Analysis &Views")
        {
            ApplicationArea = Basic;
        }
        // modify("Analysis by &Dimensions")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Calculate Deprec&iation")
        {
            ApplicationArea = Basic;
        }
        modify("Import Co&nsolidation from Database")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account R&econciliation")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust E&xchange Rates")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost Inventory Cost to G/L")
        {
            ApplicationArea = Basic;
        }
        modify("C&reate Reminders")
        {
            ApplicationArea = Basic;
        }
        modify("Create Finance Charge &Memos")
        {
            ApplicationArea = Basic;
        }
        // modify("Intrastat &Journal")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Calc. and Pos&t VAT Settlement")
        {
            ApplicationArea = Basic;
        }
        modify("General &Ledger Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Sales && Receivables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Purchases && Payables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Fixed Asset Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Accounting Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&G/L Trial Balance"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Bank Detail Trial Balance"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Account Schedule"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bu&dget"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Bala&nce/Budget"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance by &Period"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fiscal Year Balance"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance Comp. - Prev. Y&ear"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Closing Trial Balance"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Date List"(Action 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accounts &Receivable"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accounts Pa&yable"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reconcile Cus&t. and Vend. Accs"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&VAT Registration No. Check"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT E&xceptions"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT &Statement"(Action 56)".

        modify("G/L - VAT Reconciliation")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT - VIES Declaration Tax Aut&h"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT - VIES Declaration Dis&k"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EC Sales &List"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Intrastat - Checklist"(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Intrastat - For&m"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting P/L Statement"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CA P/L Statement per Period"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CA P/L Statement with Budget"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Analysis"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chart of Accounts"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorsBalance(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Orders"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Budgets(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Accounts"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Statements"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustomersBalance(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reminders(Action 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memos"(Action 1102601004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Incoming Documents"(Action 119)".

        modify("EC Sales List")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseJournals(Action 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesJournals(Action 118)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CashReceiptJournals(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentJournals(Action 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ICGeneralJournals(Action 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GeneralJournals(Action 1102601001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Intrastat Journals"(Action 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action17(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Insurance(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed Assets G/L Journals"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed Assets Journals"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed Assets Reclass. Journals"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance Journals"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Fixed Asset Journals"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Forecasts"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chart of Cash Flow Accounts"(Action 142)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Manual Revenues"(Action 174)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Manual Expenses"(Action 177)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Types"(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Centers"(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Objects"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Allocations"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Budgets"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Invoices"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Credit Memos"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Registers"(Action 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Registers"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Budget Registers"(Action 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currencies(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accounting Periods"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Number Series"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis Views"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Schedules"(Action 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Posting Groups"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Credit Memo"(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&urchase Credit Memo"(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cas&h Receipt Journal"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pa&yment Journal"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis &Views"(Action 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis by &Dimensions"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate Deprec&iation"(Action 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Co&nsolidation from Database"(Action 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account R&econciliation"(Action 70)".

        modify("Payment Reconciliation Journals")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust E&xchange Rates"(Action 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost Inventory Cost to G/L"(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&reate Reminders"(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Finance Charge &Memos"(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Intrastat &Journal"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. and Pos&t VAT Settlement"(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""General &Ledger Setup"(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Sales && Receivables Setup"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Purchases && Payables Setup"(Action 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fixed Asset Setup"(Action 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Setup"(Action 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Setup"(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 90)".

    }
}
