

namespace Microsoft.Finance.RoleCenters;

using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Deposit;
using BCAZIMA.BCAZIMA;
using Microsoft.Bank.DirectDebit;
using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.Reports;
using Microsoft.Bank.Statement;
using Microsoft.CashFlow.Account;
using Microsoft.CashFlow.Forecast;
using Microsoft.CashFlow.Reports;
using Microsoft.CashFlow.Setup;
using Microsoft.CostAccounting.Account;
using Microsoft.CostAccounting.Allocation;
using Microsoft.CostAccounting.Budget;
using Microsoft.CostAccounting.Ledger;
using Microsoft.CostAccounting.Reports;
using KenpipeBC.KenpipeBC;
using Microsoft.EServices.EDocument;
using Mwanga.Mwanga;
using Microsoft.Finance.Analysis;
using Microsoft.Finance.GeneralLedger.Setup;
using ALProject.ALProject;
using Microsoft.Finance.Consolidation;
using Microsoft.Finance.Currency;
using Microsoft.Finance.Deferral;
using MNSProjectMwanga.MNSProjectMwanga;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.FinancialReports;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Budget;
using AzimaBC.AzimaBC;
using Microsoft.Finance.GeneralLedger.Journal;
using azima.azima;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Reports;
using Microsoft.Finance.VAT.Registration;
using MNS.MNS;
using Microsoft.Finance.VAT.Reporting;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Insurance;
using Microsoft.FixedAssets.Setup;
using MNSProject.MNSProject;
using Microsoft.FixedAssets.Journal;
using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Inventory.Requisition;
using Microsoft.CRM.Team;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Period;
using Microsoft.Foundation.Task;
using Microsoft.HumanResources.Employee;
using Microsoft.Integration.Entity;
using Microsoft.Intercompany;
using Microsoft.Intercompany.Dimension;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Intercompany.Partner;
using kenpipe.kenpipe;
using Microsoft.Inventory.Costing;
#if not CLEAN22
using Microsoft.Inventory.Intrastat;
#endif
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Reports;
using Microsoft.Purchases.Vendor;
using Microsoft.RoleCenters;
using Microsoft.Sales.Analysis;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.FinanceCharge;
using Microsoft.Sales.History;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.Reports;
using Microsoft.Foundation.Navigate;
using System.Automation;
using System.Email;
using System.Environment;
using System.Integration.PowerBI;
using System.Threading;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Reports;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.StandardCost;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Counting.Recording;
using Microsoft.Inventory.Journal;
using KenpipeCBS.KenpipeCBS;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Reports;
using Microsoft.Inventory.Transfer;
using Microsoft.Service.Document;
using Microsoft.Foundation.UOM;
using System.Visualization;

page 52186778 "Finance Role Center"
{
    Caption = 'Accountant', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            // part(Control1902304208; "Accountant Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part(Control1902304209; "All Users Activities")
            {
                ApplicationArea = Basic, Suite;
            }

            // part("Intercompany Activities"; "Intercompany Activities")
            // {
            //     ApplicationArea = Intercompany;
            // }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            // part(Control123; "Team Member Activities")
            // {
            //     ApplicationArea = Suite;
            // }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {

            //             group("G/L Reports")
            //             {
            //                 Caption = 'G/L Reports';
            //                 action("&G/L Trial Balance")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = '&G/L Trial Balance';
            //                     Image = "Report";
            //                     RunObject = Report "Trial Balance";
            //                     ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            //                 }
            //                 action("&Bank Detail Trial Balance")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = '&Bank Detail Trial Balance';
            //                     Image = "Report";
            //                     RunObject = Report "Bank Acc. - Detail Trial Bal.";
            //                     ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
            //                 }
            //                 action("&Account Schedule")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = '&Account Schedule';
            //                     Image = "Report";
            //                     RunObject = Report "Account Schedule";
            //                     ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
            //                 }
            //                 action("Bu&dget")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Bu&dget';
            //                     Image = "Report";
            //                     RunObject = Report Budget;
            //                     ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            //                 }
            //                 action("Trial Bala&nce/Budget")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Trial Bala&nce/Budget';
            //                     Image = "Report";
            //                     RunObject = Report "Trial Balance/Budget";
            //                     ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
            //                 }
            //                 action("Trial Balance by &Period")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Trial Balance by &Period';
            //                     Image = "Report";
            //                     RunObject = Report "Trial Balance by Period";
            //                     ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
            //                 }
            //                 action("&Fiscal Year Balance")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = '&Fiscal Year Balance';
            //                     Image = "Report";
            //                     RunObject = Report "Fiscal Year Balance";
            //                     ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
            //                 }
            //                 action("Balance Comp. - Prev. Y&ear")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Balance Comp. - Prev. Y&ear';
            //                     Image = "Report";
            //                     RunObject = Report "Balance Comp. - Prev. Year";
            //                     ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
            //                 }
            //                 action("&Closing Trial Balance")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = '&Closing Trial Balance';
            //                     Image = "Report";
            //                     RunObject = Report "Closing Trial Balance";
            //                     ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
            //                 }
            //                 action("Dimensions - Total")
            //                 {
            //                     ApplicationArea = Dimensions;
            //                     Caption = 'Dimensions - Total';
            //                     Image = "Report";
            //                     RunObject = Report "Dimensions - Total";
            //                     ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
            //                 }
            //             }
            //             group("Cash Flow")
            //             {
            //                 Caption = 'Cash Flow';
            //                 action("Cash Flow Date List")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Cash Flow Date List';
            //                     Image = "Report";
            //                     RunObject = Report "Cash Flow Date List";
            //                     ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
            //                 }
            //             }
            //             group("Customers and Vendors")
            //             {
            //                 Caption = 'Customers and Vendors';
            //                 action("Aged Accounts &Receivable")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Aged Accounts &Receivable';
            //                     Image = "Report";
            //                     RunObject = Report "Aged Accounts Receivable";
            //                     ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
            //                 }
            //                 action("Aged Accounts Pa&yable")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Aged Accounts Pa&yable';
            //                     Image = "Report";
            //                     RunObject = Report "Aged Accounts Payable";
            //                     ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
            //                 }
            //                 action("Reconcile Cus&t. and Vend. Accs")
            //                 {
            //                     ApplicationArea = Basic, Suite;
            //                     Caption = 'Reconcile Cus&t. and Vend. Accs';
            //                     Image = "Report";
            //                     RunObject = Report "Reconcile Cust. and Vend. Accs";
            //                     ToolTip = 'View if a certain general ledger account reconciles the balance on a certain date for the corresponding posting group. The report shows the accounts that are included in the reconciliation with the general ledger balance and the customer or the vendor ledger balance for each account and shows any differences between the general ledger balance and the customer or vendor ledger balance.';
            //                 }
            //             }
            //             group("VAT Reports")
            //             {
            //                 Caption = 'VAT Reports';
            //                 action("&VAT Registration No. Check")
            //                 {
            //                     ApplicationArea = VAT;
            //                     Caption = '&VAT Registration No. Check';
            //                     Image = "Report";
            //                     RunObject = Report "VAT Registration No. Check";
            //                     ToolTip = 'Use an EU VAT number validation service to validated the VAT number of a business partner.';
            //                 }
            //                 action("VAT E&xceptions")
            //                 {
            //                     ApplicationArea = VAT;
            //                     Caption = 'VAT E&xceptions';
            //                     Image = "Report";
            //                     RunObject = Report "VAT Exceptions";
            //                     ToolTip = 'View the VAT entries that were posted and placed in a general ledger register in connection with a VAT difference. The report is used to document adjustments made to VAT amounts that were calculated for use in internal or external auditing.';
            //                 }
            //                 action("VAT &Statement")
            //                 {
            //                     ApplicationArea = VAT;
            //                     Caption = 'VAT &Statement';
            //                     Image = "Report";
            //                     RunObject = Report "VAT Statement";
            //                     ToolTip = 'View a statement of posted VAT and calculate the duty liable to the customs authorities for the selected period.';
            //                 }
            //                 action("VAT - VIES Declaration Tax Aut&h")
            //                 {
            //                     ApplicationArea = BasicEU;
            //                     Caption = 'VAT - VIES Declaration Tax Aut&h';
            //                     Image = "Report";
            //                     RunObject = Report "VAT- VIES Declaration Tax Auth";
            //                     ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            //                 }
            //                 action("VAT - VIES Declaration Dis&k")
            //                 {
            //                     ApplicationArea = BasicEU;
            //                     Caption = 'VAT - VIES Declaration Dis&k';
            //                     Image = "Report";
            //                     RunObject = Report "VAT- VIES Declaration Disk";
            //                     ToolTip = 'Report your sales to other EU countries or regions to the customs and tax authorities. If the information must be printed out on a printer, you can use the VAT- VIES Declaration Tax Auth report. The information is shown in the same format as in the declaration list from the customs and tax authorities.';
            //                 }
            //                 action("EC Sales &List")
            //                 {
            //                     ApplicationArea = BasicEU;
            //                     Caption = 'EC Sales &List';
            //                     Image = "Report";
            //                     RunObject = Report "EC Sales List";
            //                     ToolTip = 'Calculate VAT amounts from sales, and submit the amounts to a tax authority.';
            //                 }
            //             }
            // #if not CLEAN22
            //             group(Action60)
            //             {
            //                 Caption = 'Intrastat';
            //                 ObsoleteState = Pending;
            //                 ObsoleteTag = '22.0';
            //                 ObsoleteReason = 'Intrastat related functionalities are moved to Intrastat extensions.';
            //                 // action("&Intrastat - Checklist")
            //                 // {
            //                 //     ApplicationArea = BasicEU;
            //                 //     Caption = '&Intrastat - Checklist';
            //                 //     Image = "Report";
            //                 //     RunObject = Report "Intrastat - Checklist";
            //                 //     ToolTip = 'View a checklist that you can use to find possible errors before printing and also as documentation for what is printed. You can use the report to check the Intrastat journal before you use the Intrastat - Make Disk Tax Auth batch job.';
            //                 //     ObsoleteState = Pending;
            //                 //     ObsoleteTag = '22.0';
            //                 //     ObsoleteReason = 'Intrastat related functionalities are moved to Intrastat extensions.';
            //                 // }
            //                 // action("Intrastat - For&m")
            //                 // {
            //                 //     ApplicationArea = BasicEU;
            //                 //     Caption = 'Intrastat - For&m';
            //                 //     Image = "Report";
            //                 //     RunObject = Report "Intrastat - Form";
            //                 //     ToolTip = 'View all the information that must be transferred to the printed Intrastat form.';
            //                 //     ObsoleteState = Pending;
            //                 //     ObsoleteTag = '22.0';
            //                 //     ObsoleteReason = 'Intrastat related functionalities are moved to Intrastat extensions.';
            //                 // }
            //             }
            // #endif
            //             group("Cost Accounting")
            //             {
            //                 Caption = 'Cost Accounting';
            //                 action("Cost Accounting P/L Statement")
            //                 {
            //                     ApplicationArea = CostAccounting;
            //                     Caption = 'Cost Accounting P/L Statement';
            //                     Image = "Report";
            //                     RunObject = Report "Cost Acctg. Statement";
            //                     ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
            //                 }
            //                 action("CA P/L Statement per Period")
            //                 {
            //                     ApplicationArea = CostAccounting;
            //                     Caption = 'CA P/L Statement per Period';
            //                     Image = "Report";
            //                     RunObject = Report "Cost Acctg. Stmt. per Period";
            //                     ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
            //                 }
            //                 action("CA P/L Statement with Budget")
            //                 {
            //                     ApplicationArea = CostAccounting;
            //                     Caption = 'CA P/L Statement with Budget';
            //                     Image = "Report";
            //                     RunObject = Report "Cost Acctg. Statement/Budget";
            //                     ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
            //                 }
            //                 action("Cost Accounting Analysis")
            //                 {
            //                     ApplicationArea = CostAccounting;
            //                     Caption = 'Cost Accounting Analysis';
            //                     Image = "Report";
            //                     RunObject = Report "Cost Acctg. Analysis";
            //                     ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
            //                 }
            //             }

        }
        area(embedding)
        {

            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(VendorsBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            // action("Purchase Orders")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Purchase Orders';
            //     RunObject = Page "Purchase Order List";
            //     ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            // }

            // action(CustomersBalance)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Balance';
            //     Image = Balance;
            //     RunObject = Page "Customer List";
            //     RunPageView = where("Balance (LCY)" = filter(<> 0));
            //     ToolTip = 'View a summary of the bank account balance in different periods.';
            // }
            // action("Incoming Documents")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Incoming Documents';
            //     Image = Documents;
            //     RunObject = Page "Incoming Documents";
            //     ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
            // }
            // // action("Purchase Invoices")
            // // {
            // //     ApplicationArea = Basic, Suite;
            // //     Caption = 'Purchase Invoices';
            // //     Image = Invoice;
            // //     RunObject = Page "Purchase Invoices";
            // //     ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            // // }
            // action("EC Sales List")
            // {
            //     ApplicationArea = VAT;
            //     Caption = 'EC Sales List';
            //     RunObject = Page "EC Sales List Reports";
            //     ToolTip = 'Calculate VAT amounts from sales, and submit the amounts to a tax authority.';
            // }
            // action("VAT Returns")
            // {
            //     ApplicationArea = VAT;
            //     Caption = 'VAT Returns';
            //     RunObject = Page "VAT Report List";
            //     ToolTip = 'Prepare the VAT Return report so you can submit VAT amounts to a tax authority.';
            // }

            // action("VAT Statements")
            // {
            //     ApplicationArea = VAT;
            //     Caption = 'VAT Statements';
            //     Image = VATStatement;
            //     RunObject = Page "VAT Statement Names";
            //     ToolTip = 'View a statement of posted VAT amounts, calculate your VAT settlement amount for a certain period, such as a quarter, and prepare to send the settlement to the tax authorities.';
            // }

        }
        area(sections)
        {
            group("Member Personal Accounts")
            {
                group("Member")
                {
                    Caption = 'Member';
                    action("Member Single List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Single';
                        RunObject = Page "Member Single List";
                    }
                    action("Member Detailed List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Detailed Balances';
                        RunObject = Page "Detailed Member Balance List";
                    }

                    action("Savings Account Register")
                    {
                        ApplicationArea = All;
                        Caption = 'Savings Account Register(ALL)';
                        RunObject = page "Savings Accounts";
                    }
                    action("Member Group List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Groups';
                        RunObject = Page "Member Group List";
                    }

                }
                group("Loan Processing")
                {

                    Caption = 'Loans Processing';

                    action("Loan Appraisal List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Appraisal List';
                        RunObject = page "Appraisal Loans List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }
                    action("Loan Approved List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Approved List';
                        RunObject = page "Approved Loans List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }
                    action("Loan Posted List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Posted List(Running)';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Total Balance" = filter(> 0));
                    }
                    action("Cleared Loan List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Cleared Loan List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Total Balance" = filter(0));
                    }
                    action("Overpaid Loan List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Overpaid Loan List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Total Balance" = filter(< 0));
                    }
                    action("All Posted Loans List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'All Posted Loans List';
                        RunObject = page "Loan Posted List";
                        //RunPageView = where("Total Balance" = filter(< 0));
                    }
                    action("Loan Ageing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Ageing Report";
                    }

                }
                // group("Guarantor Substitution")
                // {
                //     action("Loan Guarantors List")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Guarantors Lists';
                //         RunObject = page "Guarantors List";

                //     }
                //     action("Open Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Guarantor Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Open);//, "Sent Back to CRM" = const(false); Show all but provided a filter
                //     }
                //     action("Pending Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Pending Guarantor Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Pending), "Sent Back to CRM" = const(false);
                //     }
                //     action("Approved Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Approved Guarantor Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Approved), Posted = const(false), "Sent Back to CRM" = const(false);
                //     }
                //     action("Posted Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Posted Guarantor Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Posted), Posted = const(true), "Sent Back to CRM" = const(false);
                //     }
                //     action("Deffred Guantor Substitution")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Deffered Guarantor Substitution';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Deffered), "Sent Back to CRM" = const(false);
                //     }
                //     action("Rejected Guarantor Substitution")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Rejected Guarantor Substitution';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Rejected), "Sent Back to CRM" = const(false);
                //     }
                //     // action("Guarantor Substitution Sent Send Back to CRM")
                //     // {
                //     //     ApplicationArea = all;
                //     //     Caption = 'Guarantor Substitution Sent Send Back to CRM';
                //     //     RunObject = page "Guarantor Subsitution List";
                //     //     RunPageLink = "Sent Back to CRM" = const(true);
                //     // }
                // }

                group("Account Activation")
                {
                    group("BOSA Account Activation")
                    {
                        Caption = 'BOSA Account Activation';
                        action("Open Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("Account Activaion Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'BOSA Account Activation Pending Approval';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Pending));
                        }
                        action("Rejected Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Approved Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Approved));
                        }
                        action("Posted Account Activation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted BOSA Account Activation';
                            RunObject = Page "Posted BOSA Account Activation";
                        }
                    }
                    group("FOSA Account Activation")
                    {
                        Caption = 'FOSA Account Activation';
                        action("Open FOSA Account Activation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open FOSA Account Activation';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("FOSA Account Activation Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'FOSA Account Activation Pending Approval';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Pending));
                        }
                        action("Rejected FOSA Account Activation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected FOSA Account Activation';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Approved FOSA Account Activation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved FOSA Account Activation';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Approved));
                        }
                        action("Activated FOSA Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Activated FOSA Accounts';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Activated));
                        }
                    }
                    group(ActivationReports)
                    {
                        action("FOSA Account Activation Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'FOSA Account Activation Report';
                            RunObject = report "FOSA Account Activation";
                        }
                       
                    }
                }

                group("Member closure Notices")
                {
                    Caption = 'Member Closure Notices';

                    action("Open Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Open closure Notice';
                        RunObject = page "Open Withdrawal Notice";
                        RunPageView = where(Status = const(open), "Sent Back to CRM" = const(false));
                    }
                    action("Pending Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Pending closure Notice';
                        RunObject = page "Pending Withdrawal Notice";
                        RunPageView = where(Status = const(Pending), "Sent Back to CRM" = const(false));
                    }
                    action("Approved Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Approved Closure Notice';
                        RunObject = page "Approved Withdrawal Notice";
                    }
                    action("Matured Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Matured Closure Notice';
                        RunObject = page "Matured withdrwal Notices";

                    }
                    action("Processed/Matured Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Processed Closure Notice';
                        RunObject = page "Processed WithDrawal Notices";
                    }
                    action("Rejected Withdrawal Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Rejected Closure Notice';
                        RunObject = page "Rejected Withdrawal Notice";
                    }
                    action("Cancelled/Archived Notices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancelled/Archived Withdrawal List';
                        RunObject = Page "Cancelled/Archived withdrawal";
                    }
                    // action("Notices Sent Back To CRM")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Notices Sent Back To CRM';
                    //     RunObject = Page "Open withdrawal Notice";
                    //     RunPageView = where(Status = const(open), "Sent Back to CRM" = const(true));
                    // }
                    action("Withdrawal Notice List All")
                    {
                        ApplicationArea = all;
                        RunObject = page "Member Withdrawal Notices ALL";
                        //Run
                    }
                    //}
                }
                group("Member CLosure")
                {

                    Caption = 'Member Closure';
                    action("Open Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Open Closure List';
                        RunObject = page "Open Closure List";
                    }
                    action("Pending Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Pending Closure List';
                        RunObject = page "Pending Closure List";

                    }
                    // action("Member closure List (Shared)")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Shared Closure List';
                    //     RunObject = page "Member closure List (Shared)";
                    //     RunPageView = where(Status = const(open));
                    // }
                    action("Approved Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Approved Closure List';
                        RunObject = page "Approved Closure List";
                    }
                    action("Posted Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Posted Closure List';
                        RunObject = page "Posted Membership Closure List";
                    }
                    action("Cancelled Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Cancelled Closure List';
                        RunObject = page "Open Closure List";
                        RunPageView = where(Status = const(Cancelled), Posted = const(false));
                    }
                    action("Rejected Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Rejected Closure List';
                        RunObject = page "Rejected Closure List";
                    }
                    action("Member Closure List All")
                    {
                        ApplicationArea = all;
                        RunObject = page "Member Closure List All";
                    }
                    group("Member Closure Reports")
                    {
                        action("Membership Closure Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Report "Membership Closure Summary";
                        }
                        action("Withdrawal Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Withdrawal Summary";
                        }
                        action("Withdrawal Reasons")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Withdrawal Reasons";
                        }
                        action("Closure Listing")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Closure Listing";
                        }
                    }
                }
                // group("Deceased Member Closure")
                // {
                //     action("Open Deceased Closure List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Deceased Closure List';
                //         RunObject = page "Open Deceased Closure List";
                //     }
                // }
                // group("Product Variations")
                // {
                //     group("Loans Variations")
                //     {
                //         action("Open Variations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Open Loans Variations List';
                //             RunObject = Page "Variations List";
                //             RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false), "Variation Type" = filter(Loan);
                //         }
                //         // action("Pending Variations List")
                //         // {
                //         //     ApplicationArea = Basic, Suite;
                //         //     Caption = 'Pending Loans Variations List';
                //         //     RunObject = Page "Variations List";
                //         //     RunPageLink = Status = filter("Pending Approval"), "Variation Type" = filter(Loan);
                //         // }
                //         action("Approved Variations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Loans Variations List';
                //             RunObject = Page "Variations List";
                //             RunPageLink = Status = filter(Approved), posted = const(false), "Sent Back to CRM" = const(false), "Variation Type" = filter(Loan);
                //         }
                //         action("Posted Variations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Posted Variations List';
                //             RunObject = Page "Variations List";
                //             RunPageLink = Status = filter(Approved), posted = const(true), "Sent Back to CRM" = const(false), "Variation Type" = filter(Loan);
                //         }
                //         // action("Variations Send Back To CRM")
                //         // {
                //         //     ApplicationArea = Basic, Suite;
                //         //     Caption = 'Variations Send Back To CRM';
                //         //     RunObject = Page "Variations List";
                //         //     RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(true), "Variation Type" = filter(Loan), posted = const(false);
                //         // }
                //     }
                //     group("Savings Variations")
                //     {
                //         action("Open  Savings Variations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Open Savings Variations List';
                //             RunObject = Page "Savings Variations List";
                //             RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false), "Variation Type" = filter(savings);
                //         }
                //         // action("Savings PendVariations List")
                //         // {
                //         //     ApplicationArea = Basic, Suite;
                //         //     Caption = 'Pending Savings Variations List';
                //         //     RunObject = Page "Savings Variations List";
                //         //     RunPageLink = Status = filter("Pending Approval"), "Variation Type" = filter(savings);
                //         // }
                //         action("Savings  AppVariations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Savings Variations List';
                //             RunObject = Page "Savings Variations List";
                //             RunPageLink = Status = filter(Approved), "Sent Back to CRM" = CONST(false), posted = const(false), "Variation Type" = filter(savings);
                //         }
                //         action("Posted sav Variations List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Posted  Savings Variations List';
                //             RunObject = Page "Savings Variations List";
                //             RunPageLink = Status = filter(Approved), "Sent Back to CRM" = CONST(false), posted = const(true), "Variation Type" = filter(savings);
                //         }
                //         // action("Sav' Variations Send Back To CRM")
                //         // {
                //         //     ApplicationArea = Basic, Suite;
                //         //     Caption = ' Savings Variations Send Back To CRM';
                //         //     RunObject = Page "Savings Variations List";
                //         //     RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(true), "Variation Type" = filter(savings);
                //         // }
                //     }

                // }


                // group("Checkoff Advise Process")
                // {
                //     action("Checkoff Advise")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Checkoff Advice';
                //         RunObject = Page "Checkoff Advice Header List";
                //     }
                //     action("Posted Checkoff Advise")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Posted Checkoff Advice';
                //         RunObject = Page "+Checkoff Advice Header List";
                //     }
                //     action("Checkoff Advice Lines")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Checkoff Advice Lines(ALL)';
                //         RunObject = Page "Checkoff Advice";
                //     }


                // }


                // group("Case Forwarding")
                // {
                //     group("Employer Change Case Forwarding")
                //     {
                //         action("Employer Change Unforwarded Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "MKey Sent Cases";
                //             RunPageView = where("Originating Status" = const(New));
                //         }
                //         action("Employer Change forwarded Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "MKey Sent Cases";
                //             RunPageView = where("Originating Status" = const(Sent));

                //         }
                //         action("Employer Change Actioned Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "MKey Sent Cases";
                //             RunPageView = where("Originating Status" = const("Sent & Actioned"));

                //         }
                //     }

                //     group("DMU Case Forwarding;")
                //     {
                //         Visible = false;

                //         action("Unforwarded Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "Unforwarded Cases";
                //         }
                //         action("Forwarded Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "Forwarded Cases";
                //         }
                //         action("Received Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "Received Cases";
                //         }
                //         action("Actioned Cases")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "Actioned Cases";
                //         }

                //     }
                // }
                group("Refunds& account Transfer")
                {
                    group("Bulk Refunds")
                    {
                        action("Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(open));
                        }
                        action("Bulk Account RefundsP")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(pending));
                        }
                        action("Bulk Account RefundsA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(Approved));
                        }
                        action("Posted Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(true));
                        }
                        action("Rejected Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), status = const(Rejected));
                        }

                    }
                    group("Single Refunds")
                    {
                        action("Account Trasfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Transfer List(Single Member)';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("Pending Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Account Transfer List';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                        action("Approved Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Account Transfer List';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Approved));
                        }
                        action("Rejected Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Account Transfer';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Posted Account Transfer")
                        {
                            ApplicationArea = Suite, FixedAssets;
                            Caption = 'Posted Account Transfer';
                            RunObject = page "Posted Account Transfer List";
                            RunPageView = where(Posted = filter(true));
                        }
                    }

                }
                // group("Loan Clearance")
                // {
                //     action("Open Loan Clearance List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Open Loan Clearance List';
                //         RunObject = Page "Loan Clearance List";
                //         RunPageView = where(Posted = const(false), Status = const(open));
                //     }
                //     action("Pending Loan Clerance List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Pending Loan Clerance List';
                //         RunObject = Page "Loan Clearance List";
                //         RunPageView = where(Posted = const(false), Status = const(pending));
                //     }
                //     action("Approved Loan Clerance List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approved Loan Clerance List';
                //         RunObject = Page "Loan Clearance List";
                //         RunPageView = where(Posted = const(false), Status = const(Approved));
                //     }
                //     action("Posted Loan Clerance List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Posted Loan Clearance List';
                //         RunObject = Page "Loan Clearance List";
                //         RunPageView = where(Posted = const(true));
                //     }


                // }

                group("Share Capital Transfer")
                {
                    action("Share Capital Transfer List")
                    {
                        ApplicationArea = all;
                        Caption = 'Open Transfer Shares List';
                        RunObject = page "Share Capital Transfer List";
                        RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false);
                    }
                    action("Pending ShareCapital List")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Transfer Share List';
                        RunObject = page "pending ShareCapital List";
                        RunPageLink = Status = filter(Pending);
                    }
                    action("Approved Share Capital")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Transfer Share List';
                        RunObject = page "Posted Share Capital List";
                        RunPageLink = Status = filter(Approved), Transfered = const(false);
                    }
                    action("Transfered share Capital")
                    {
                        ApplicationArea = all;
                        Caption = 'Transfered Shares List';
                        RunObject = page "Posted Share Capital List";
                        RunPageLink = Transfered = const(true);
                    }
                    // action("Share Capital Send Back To CRM")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Share Capital Send Back To CRM';
                    //     RunObject = page "Share Capital Transfer List";
                    //     RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(true);
                    // }
                    action("Rejected Share Capital Transfer List")
                    {
                        ApplicationArea = all;
                        Caption = 'Rejected Transfer Shares List';
                        RunObject = page "Share Capital Transfer List";
                        RunPageLink = Status = filter(Rejected), "Sent Back to CRM" = const(false), Transfered = const(false);
                    }
                    // action("Transfered Share Capital Certificate")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Transferred Share Capital Certificate';
                    //     RunObject = report "Transferred Share Capital Cert";
                    // }
                }
                group("Share Capital Cert")
                {
                    Caption = 'Share Certificate';

                    action("Share Capital Certificate Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Share Capital Certificate';
                        //RunObject = Report "Share Capital Certificate";
                        RunObject = Report "Finance Share Certificate";
                    }
                    action("Trans. Share Capital Certificate")
                    {
                        ApplicationArea = all;
                        Caption = 'Transferred Share Capital Certificate';
                        RunObject = report "Transferred Share Capital Cert";
                    }
                    action("Share Capital Register")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Share Capital Register';
                        RunObject = page "Savings Accounts";
                        RunPageView = WHERE("Product Category" = filter("Share Capital" | "Transfered Share Capital"));
                    }
                }
                // group("BBF & Risk Claims")
                // {
                //     Caption = 'Deceased Member Notice';
                //     // group("Risk Claims")
                //     // {
                //     action("Risk Claim List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Deceased Member Notice';
                //         RunObject = Page "Risk Claim List";

                //     }
                //     action("Approved Risk Claim List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approved Deceased Member Notice';
                //         RunObject = Page "Approved Risk Claim List";
                //     }
                //     // action("Partially Posted Risk Claim List")
                //     // {
                //     //     ApplicationArea = Basic, Suite;
                //     //     Caption = 'Partially Posted Risk Claim List';
                //     //     RunObject = Page "Partially Posted Risk Claim";
                //     // }
                //     action("Posted Risk Claim List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Posted Deceased Member Notice';
                //         RunObject = Page "Posted Risk Claim List";
                //     }
                //     action("Cancelled/Archived Risk Claim List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Cancelled/Archived Member Notice List';
                //         RunObject = Page "Cancelled/Archived Risk Claim";
                //     }
                //     action("Risk Claim Report")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Deceased Member Notice Report';
                //         RunObject = Report "Risk Claims Report";
                //     }
                //     // }
                // }
                //     group("Insurance Claims")
                //     {
                //         action("Insurance Claim List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Open Insurance Claim List';
                //             RunObject = Page "Insurance Claim List";
                //             RunPageView = where(Status = const(Open));
                //         }
                //         action("Pending Insurance Claim List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Pending Insurance Claim List';
                //             RunObject = Page "Insurance Claim List";
                //             RunPageView = where(Status = const(Pending));
                //         }
                //         action("Approved Insurance Claim List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Insurance Claim List';
                //             RunObject = Page "Insurance Claim List";
                //             RunPageView = where(Status = const(Approved));
                //         }
                //         action("Rejected Insurance Claim List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Rejected Insurance Claim List';
                //             RunObject = Page "Insurance Claim List";
                //             RunPageView = where(Status = const(Rejected));
                //         }
                //         action("BBF - Insurance Claim Report")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'BBF - Insurance Claim Report';
                //             RunObject = Report "BBF - Insurance Claim Report";
                //         }
                //     }
                //     group("Nominee Form Request")
                //     {
                //         action("Nominee Request Form")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Open Nominee Form Request';
                //             RunObject = Page "Nominee Request Form List";
                //             RunPageView = where(Status = CONST(Open));
                //         }
                //         action("Form Request Pending Approval")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Form Request Pending Approval';
                //             RunObject = Page "Nominee Request Form List";
                //             RunPageView = where(Status = CONST(Pending));
                //         }
                //         action("Rejected Nominee Request Form")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Rejected Nominee Form Request';
                //             RunObject = Page "Nominee Request Form List";
                //             RunPageView = where(Status = CONST(Pending));
                //         }
                //         action("Approved Nominee Request Form")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Nominee Form Request';
                //             RunObject = Page "Nominee Request Form List";
                //             RunPageView = where(Status = CONST(Approved));
                //         }
                //     }

                // }
                group("Fees Management")
                {
                    Caption = 'Fees Management';
                    action("Registration Fee Recovery")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Registration Fee Recovery';
                        RunObject = Report "Registration Fee Recovery";
                    }
                    action("Share Capital Fee Recovery")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Share Capital Fee Recovery';
                        RunObject = Report "Share Capital Recovery";
                    }
                    action("Members with Expected Reg Fee")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members with Expected Reg Fee';
                        RunObject = Report "Members with Expected Reg Fee";
                    }
                    action("Recovered Registration Fees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recovered Registration Fees';
                        RunObject = Report "Recovered Registration Fees";
                    }
                }
                group("Files")
                {
                    action("File Details List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Details List';
                        RunObject = page "Files List";
                    }
                    action("Member Form List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Member Form List';
                        RunObject = page "Member Form List";
                        RunPageView = where(Filed = filter(false));
                    }
                    action("Filed Member Form List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Filed member Form List';
                        RunObject = page "Member Form List";
                        RunPageView = where(Filed = filter(true));
                    }

                    action("File Volumes List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Volumes List';
                        RunObject = page "File Volumes List";
                    }
                    action("File Locations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Locations';
                        RunObject = page "File Locations List";
                    }
                    action("Batch Number List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Batch No List';
                        RunObject = page "Batch No List";
                    }
                }

                group("File Tracking")
                {
                    action("Open File Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open File Tracker List';
                        RunObject = page "File Tracker List";
                        RunPageView = where("File Request Status" = filter(Open));
                    }
                    action("File Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Requests';
                        RunObject = page "File Tracker List";
                        RunPageView = where("File Request Status" = filter(Requested));
                    }
                    action("Issued Files")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Issued Files';
                        RunObject = page "File Tracker List";
                        RunPageView = where("File Request Status" = filter(Issued));
                    }
                    action("Received Files")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Received Files';
                        RunObject = page "File Tracker List";
                        RunPageView = where("File Request Status" = filter(Received));
                    }
                    // action("Forwarded Files")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Forwarded Files';
                    //     RunObject = page "File Tracker List";
                    //     RunPageView = where("File Request Status" = filter(Forwarded));
                    // }
                    action("Closed File Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed File Request';
                        RunObject = page "File Tracker List";
                        RunPageView = where("File Request Status" = filter(Closed));
                    }
                    // action("Overdue File Requests")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Overdue File Requests';
                    //     RunObject = page "File Tracker List";
                    //     RunPageView = where(Overdue = const(true));
                    // }
                    action("File List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archived File Tracker List';
                        RunObject = page "File Tracker List";
                        RunPageView = where(Status = filter(archived));
                    }
                }

            }
            group("Payments & Receipts")
            {
                Caption = 'Payments/Receipts';
                group("Payments ")
                {
                    group("Delegates Management")
                    {
                        Caption = 'Delegates Management';
                        group(Registry)
                        {
                            group("Electoral Zones")
                            {
                                Caption = 'Electoral Zones Registration';
                                action("Application List")
                                {
                                    Caption = 'Electoral Zones Application List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Electoral Application List";

                                }
                                action("Approved List")
                                {
                                    Caption = 'Approved Electoral Zones List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Approved Electoral List";
                                }
                                action("Rejected List")
                                {
                                    Caption = 'Rejected Electoral Zones List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Electoral Rejected List";

                                }

                            }
                            group("Delegates Officials")
                            {
                                Caption = 'Officials Registrations';
                                action("Officials Application List")
                                {
                                    Caption = 'Officials Application List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Delegate Official Applications";

                                }
                                action("Officials Approved List")
                                {
                                    Caption = 'Active Delegate Officials';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Active Delegate Officials";
                                }
                                action("Retired Delegates Officials")
                                {
                                    Caption = 'Rejected Electoral Zones List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Retired Delegate Officials";

                                }
                            }
                        }
                        group("Meetings and Payments")
                        {

                            Caption = 'Meetings & Payments';
                            group(Meetings)
                            {
                                Caption = 'Delegate Meetings';
                                action("Open Delegates Meetings")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Delegate Meeting Header";
                                }
                                action("Approved Delegates Meetings")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Approved Delegate Meetings";
                                }
                                action("Paid Delegates Meetings")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Posted Delegate Meetings";
                                }

                            }
                            group("Delegate Payments")
                            {
                                Caption = 'Delegate Payments';
                                action("Delegates Payments List")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Delegates Payment List";
                                }
                                action("Approved Payments List")
                                {
                                    Caption = 'Approved Delegates Payments List';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Approved Delegates Payments";
                                }
                                action("Posted Payments List")
                                {
                                    Caption = 'Posted Delegate Payments';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Posted Delegates Payments";
                                }
                                action("Deleg. Payment Withholding Tax")
                                {
                                    Caption = 'Delegate Payment Withholding Tax';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "Deleg. Payment Withholding Tax";
                                }
                            }
                        }
                        action("Delegate Tariffs")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Delegate Tariffs";
                        }
                    }
                    // group("Board Members")
                    // {
                    //     group("Board Payroll")
                    //     {
                    //         // action("Board Payment Voucher")
                    //         // {
                    //         //     ApplicationArea = Basic, Suite;
                    //         //     Caption = 'Payment Voucher Board List';
                    //         //     RunObject = page "Payment Voucher Board List";
                    //         //     //RunPageLink = Status = filter(Pending);
                    //         // }
                    //         action("prBoard employee list")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Open Board Payroll';
                    //             RunObject = page "prBoard employee list";
                    //             RunPageLink = Status = filter(Open);
                    //         }
                    //         action("Pending Board Payroll")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Pending Board Payroll';
                    //             RunObject = page "prBoard employee list";
                    //             RunPageLink = Status = filter(Pending);
                    //         }
                    //         action("Approved Board Payroll")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Approved Board Payroll';
                    //             RunObject = page "prBoard employee list";
                    //             RunPageLink = Status = filter(Approved), Posted = const(false);
                    //         }
                    //         action("Posted Board Payroll")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Posted Board Payroll';
                    //             RunObject = page "prBoard employee list";
                    //             RunPageLink = Status = filter(Approved), Posted = const(true);
                    //         }

                    //         // action("Board Payment Withholding Tax")
                    //         // {
                    //         //     ApplicationArea = Basic, Suite;
                    //         //     Caption = 'Board Payment Withholding Tax';
                    //         //     RunObject = page "Board Payment Withholding Tax";
                    //         // }

                    //     }

                    // }

                    group("Payment Vouchers")
                    {
                        action("Open Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Payment Voucher';
                            RunObject = page "Payment Vouchers List";
                            RunPageLink = Status = CONST(Pending);

                        }
                        action("Pending Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Payment Voucher';
                            RunObject = page "Payment Vouchers List";
                            RunPageLink = Status = CONST("Pending Approval");

                        }
                        action("Approved Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Payment Voucher';
                            RunObject = page "Payment Vouchers List";
                            RunPageLink = Status = CONST(Approved);

                        }
                        action("Rejected Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Payment Voucher';
                            RunObject = page "Payment Vouchers List";
                            RunPageLink = Status = CONST(Cancelled);
                        }
                        action("Payments Posted Payment Voucher")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Payment Voucher';
                            RunObject = Page "Posted Payment Vouchers List";
                            ToolTip = 'Open the list of posted payment vouchers.';
                        }
                    }
                    group("Fosa Payment Voucher")
                    {
                        action("Open FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open FOSA Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = CONST(Open), Posted = const(false);
                        }
                        action("Pending FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Pending Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = filter("Pending Approval" | Pending), Posted = const(false);
                        }
                        action("Approved FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Approved Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = CONST("Approved"), Posted = const(false);
                        }
                        action("Posted FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Posted Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Posted = const(true);
                        }

                    }

                    group("Staff claims")
                    {
                        action("Staff Claim")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Staff Claims List';
                            RunObject = page "Staff Claims List";
                            RunPageView = where(status = CONST(Pending), Posted = const(false));//
                        }
                        action("Pending Staff Claim")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Staff Claim List';
                            RunObject = page "Staff Claims List";
                            RunPageView = where(status = CONST("Pending Approval"), Posted = const(false));//
                        }

                        action(ApprovedStaffClaims)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Staff Claims List';
                            RunObject = page "Staff Claims List";
                            RunPageView = where(status = CONST(Approved), Posted = const(false));//
                        }
                        action(PostedStaffClaims)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Staff Claims List';
                            RunObject = page "Posted Staff Claims List";
                        }
                        action(CancelledStaffClaims)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Staff Claims List';
                            RunObject = page "Cancelled Staff Claims List";
                        }
                    }
                    group(PettyCash)
                    {
                        action("Petty Cash")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Petty Cash';
                            RunObject = page "Petty Cash Vouchers List";
                            runpageview = where(status = CONST(Pending), posted = const(false));
                        }
                        action("Approved Petty Cash")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Petty Cash';
                            RunObject = page "Petty Cash Vouchers List";
                            runpageview = where(status = CONST(Approved), posted = const(false));
                        }

                        action("PostedPettyCash")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Petty Cash';
                            RunObject = Page "Posted Petty Cash Vouchers";
                            ToolTip = 'Open the list of posted Petty Cash.';
                        }
                        action("Cancelled Petty Cash")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Petty Cash';
                            RunObject = page "Cancelled Petty Cash Vouchers";
                        }
                    }


                    group(StaffImprest)
                    {
                        Caption = 'Imprest';
                        action("Imprest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Imprest Application List';
                            RunObject = page "Imprest List";
                            RunPageView = where(status = CONST(Pending), Posted = const(false));//
                        }
                        action("Pending Imprest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Approval Imprest List';
                            RunObject = page "Imprest List";
                            RunPageView = where(status = CONST("Pending Approval"), Posted = const(false));//
                        }
                        action("Approved Imprest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Imprest List';
                            RunObject = page "Imprest List";
                            RunPageView = where(status = CONST(Approved), Posted = const(false));//
                        }
                        action("Cancelled Imprest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Imprest List';
                            RunObject = page "Imprest List";
                            RunPageView = where(status = CONST(Cancelled), Posted = const(false));//
                        }
                        action("Posted Imprest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Imprest List';
                            RunObject = page "Imprest List";
                            RunPageView = where(Posted = CONST(true));//
                        }
                        action("Overdue Imprest Notifications")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Overdue Imprest Notifications (SMS)';
                            RunObject = report "Overdue Imprest Notification";
                        }
                        action("Imprest Surrender List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Imprest Surrender';
                            RunObject = page "Imprest Surrender List";
                            RunPageView = where(Posted = CONST(false));//
                        }
                        action("Posted Imprest Surrender List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Imprest Surrender';
                            RunObject = page "Imprest Surrender List";
                            RunPageView = where(Posted = CONST(true));//
                        }

                    }


                    // group(Checkoff)
                    // {
                    //     action("Checkoff Advice List")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Checkoff Advice List';
                    //         RunObject = page "Checkoff Advice List";
                    //     }

                    // }
                    // action("Purchase Invoice")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Purchase Invoice';
                    //     RunObject = page "Purchase Invoices";
                    // }
                    // action("Sales &Credit Memos")
                    // {
                    //     AccessByPermission = TableData "Sales Header" = IMD;
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sales &Credit Memo';
                    //     RunObject = Page "Sales Credit Memo";
                    //     RunPageMode = Create;
                    //     ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
                    // }
                    // action("P&urchase Credit Memos")
                    // {
                    //     AccessByPermission = TableData "Purchase Header" = IMD;
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'P&urchase Credit Memo';
                    //     RunObject = Page "Purchase Credit Memos";
                    //     RunPageMode = Create;
                    //     ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
                    // }
                    // action("Journal Entries")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Journal Entries';
                    //     RunObject = page "G/L Registers";
                    // }

                }
                group(Receipt)
                {
                    Caption = 'Receipts';

                    action("Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts';
                        RunObject = page "Receipts List";
                    }
                    action("Pending Approval Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Approval Receipts';
                        Image = Approval;
                        RunObject = page "Receipts List";
                        RunPageView = WHERE(Status = CONST("Pending Approval"));
                    }
                    action("Approved Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Receipts';
                        Image = Approve;
                        RunObject = page "Receipts List";
                        RunPageView = WHERE(Status = CONST(Approved));
                    }
                    // action("Post Dated Receipts")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Post Dated Receipts';
                    //     Image = Calendar;
                    //     RunObject = page "Receipts List";
                    //     RunPageView = WHERE(Status = CONST("Post Dated"));
                    // }
                    // action("Partial Receipts")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Partial Receipts';
                    //     Image = Split;
                    //     RunObject = page "Receipts List";
                    //     RunPageView = WHERE(Status = CONST(Partial));
                    // }
                    action("Cancelled Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancelled Receipts';
                        Image = Cancel;
                        RunObject = page "Receipts List";
                        RunPageView = WHERE(Status = CONST(Cancelled));
                    }
                    action("Posted Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Receipts';
                        Image = PostedOrder;
                        RunObject = page "Posted Receipt List";
                    }
                }
                // group("Per-Diem Receipt")
                // {
                //     Caption = 'Per-Diem/Claim Payments';
                //     action("Per-Diem Receipts")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Per-Diem/Claims Payments';
                //         RunObject = page "Per-Diem Receipts list";
                //         RunPageView = where(Posted = const(false));

                //     }
                //     action(" Posted Receipt List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Posted Per-Diem/Claim Payments';
                //         RunObject = page "Per-Diem Receipts list";
                //         RunPageView = where(Posted = const(true));
                //     }

                // }

                group(Interbanktfr)
                {
                    Caption = 'InterBank Transfers';
                    action("Open Interbank Transfer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open InterBank Transfer';
                        RunObject = page "InterBank Transfers List";
                        RunPageView = WHERE(Status = Const("pending"));
                    }

                    action("Pending Interbank Transfer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending InterBank Transfer';
                        RunObject = page "InterBank Transfers List";
                        RunPageView = WHERE(Status = Const("pending approval"));
                    }

                    action("Approved Interbank Transfers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved InterBank Transfer';
                        RunObject = page "InterBank Transfers List";
                        RunPageView = WHERE(Status = Const("approved"), Posted = const(false));
                    }
                    action("Posted Interbank Transfers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted InterBank Transfer';
                        RunObject = page "Posted Bank & Cash Transfers";
                        //RunPageView = WHERE(Status = Const("posted"));
                    }

                    action("Cancelled Interbank Transfers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected InterBank Transfer';
                        RunObject = page "InterBank Transfers List";
                        RunPageView = WHERE(Status = Const("cancelled"));
                    }
                }
                group(Salaries)
                {
                    Caption = 'Salaries';
                    action("Salary Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Salary Lists';
                        RunObject = page "Salary Lists";
                        RunPageView = where(Status = filter(Open), Posted = const(false));
                    }
                    action("Pending Salary Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Salary Lists';
                        RunObject = page "Salary Lists";
                        RunPageView = where(Status = filter(Pending), Posted = const(false));
                    }
                    action("Approved Salary Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Salary Lists';
                        RunObject = page "Salary Lists";
                        RunPageView = where(Status = filter(Approved), Posted = const(false));
                    }
                    action("Posted Salary Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Salary Lists';
                        RunObject = page "Posted Salary List";
                        //RunPageView = where("Income Type" = filter(Salary | pension));

                    }
                    action("Rejected Salary Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Salary Lists';
                        RunObject = page "Salary Lists";
                        //RunPageView = where(Status = filter(Rejected), Posted = const(false), "Income Type" = filter(Salary | pension));
                    }
                    // action("Posted Salary Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Posted Salary Report';
                    //     RunObject = report "Slary List Report";
                    // }
                }
                group("FixedDepositContract")
                {
                    Caption = 'Fixed/Call Deposit Contracts';

                    action("Saving Account Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Saving Account Application';
                        RunObject = page "Savings Account Application";
                    }
                    action("Fixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = CONST(" ");
                    }
                    action("ActiveFixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Running Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = CONST(Active);
                    }
                    action("CTFixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed/Terminated Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = filter(Matured | Closed | "Not Matured" | Terminated);
                    }
                }
                group(RTGS)
                {
                    Caption = 'EFT/RTGS';
                    action("RTGS Transfer List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RTGS Transfer List';
                        RunObject = page "RTGS Transfer List";
                    }
                    action("Posted EFT Transfer List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted RTGS Transfer List';
                        RunObject = page "Posted EFT Transfer List";
                    }
                    action("RTGS Reports")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RTGS Report';
                        RunObject = report "RTGS Report";
                    }
                }

                group("Interest")
                {
                    Caption = 'Account Interest Management';
                    action("Account Interest List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Interest List';
                        RunObject = page "Account Interest List";
                    }
                    action("Posted Account Interest List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Account Interest List';
                        RunObject = page "Posted Account Interest List";
                    }
                    action("End Year Interest List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Year Interest List';
                        RunObject = page "End Year Interest List";
                    }

                    action("Posted End Year Interest List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted End Year Interest List';
                        RunObject = page "Posted End Year Interest List";
                    }
                }
                group("Withheld Taxes On PV")
                {
                    Caption = 'Withheld Taxes On PV';
                    action("Withheld Taxes On PV List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Withheld Taxes On PV List';
                        RunObject = page "Witheld Tax Obligations On PV";
                    }
                    action("Witheld Tax Obligations On PV")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Witheld Tax Obligations On PV Report';
                        RunObject = report "Witheld Tax Obligations On PV";
                    }
                }
                group(WithholdingTaxesOnDelPV)
                {
                    Caption = 'Delegate Withholding Taxes';
                    action("Delegate Payment Withholding Tax")
                    {
                        Caption = 'Delegate Payment Withholding Tax';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Deleg. Payment Withholding Tax";
                    }
                }

            }

            group(Action172)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                group(Journals)
                {
                    Caption = 'Journals';
                    // Image = Journals;
                    ToolTip = 'Post financial transactions.';
                    action(GeneralJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journals';
                        Image = Journal;
                        RunObject = Page "General Journal Batches";
                        RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("<Action3>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring General Journals';
                        RunObject = Page "General Journal Batches";
                        RunPageView = where("Template Type" = const(General),
                                        Recurring = const(true));
                        ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                    }
                    // action(PurchaseJournals)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Purchase Journals';
                    //     RunObject = Page "General Journal Batches";
                    //     RunPageView = where("Template Type" = const(Purchases),
                    //                     Recurring = const(false));
                    //     ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                    // }
                    // action(SalesJournals)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sales Journals';
                    //     RunObject = Page "General Journal Batches";
                    //     RunPageView = where("Template Type" = const(Sales),
                    //                     Recurring = const(false));
                    //     ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                    // }
                    // action(ICGeneralJournals)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'IC General Journals';
                    //     RunObject = Page "General Journal Batches";
                    //     RunPageView = where("Template Type" = const(Intercompany),
                    //                         Recurring = const(false));
                    //     ToolTip = 'Post intercompany transactions. IC general journal lines must contain either an IC partner account or a customer or vendor account that has been assigned an intercompany partner code.';
                    // }
                    action(PostedGeneralJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted General Journals';
                        RunObject = Page "Posted General Journal";
                        ToolTip = 'Open the list of posted general journal lines.';
                    }
                    action("Journals Import")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport JOURNAL;
                    }

                }
                action(Action170)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action(GLRegidters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View the details of transactions that are posted to general ledger accounts. You can view the details by opening the G/L register for a specific account or for all accounts. The G/L register shows the opening balance, transactions, and closing balance for each period, such as a month or a fiscal year, based on the selection criteria that you choose when you open the register.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                group(SystemReversals)
                {
                    Caption = 'System Reversal';
                    action(OSystemReversal)
                    {
                        Caption = 'Open System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Open), Reversed = const(false));
                    }
                    action(PSystemReversal)
                    {
                        Caption = 'Pending System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Pending), Reversed = const(false));
                    }
                    action(ASystemReversal)
                    {
                        Caption = 'Approved System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Approved), Reversed = const(false));
                    }

                    action(PostedSystemReversal)
                    {
                        Caption = 'Posted System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Reversed System Reversal List";
                    }
                    action(RejectedSysReversal)
                    {
                        Caption = 'Rejected System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Rejected), Reversed = const(false));
                    }
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }

                action("Analysis Views")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Financial Reporting';
                    RunObject = Page "Financial Reports";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Financial reports analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Financial reports provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                // action(Deferrals)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Deferrals';
                //     RunObject = Page "Deferral Template List";
                //     ToolTip = 'Distribute revenues or expenses to the relevant accounting periods instead of the date of posting the transaction. Set up a deferral template for the resource, item, or G/L account that the revenue or expense will be posted for. When you post the related sales or purchase document, the revenue or expense is deferred to the involved accounting periods, according to a deferral schedule that is governed by settings in the deferral template and the posting date.';
                // }

                // action("Posted General Journal")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Posted General Journals';
                //     RunObject = Page "Posted General Journal";
                //     ToolTip = 'Open the list of posted general journal lines.';
                // }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }

                // group(Action84)
                // {
                //     Caption = 'Cost Accounting';
                //     ToolTip = 'Allocate actual and budgeted costs of operations, departments, products, and projects to analyze the profitability of your company.';
                //     action("Cost Types")
                //     {
                //         ApplicationArea = CostAccounting;
                //         Caption = 'Cost Types';
                //         RunObject = Page "Chart of Cost Types";
                //         ToolTip = 'View the chart of cost types with a structure and functionality that resembles the general ledger chart of accounts. You can transfer the general ledger income statement accounts or create your own chart of cost types.';
                //     }
                //     action("Cost Centers")
                //     {
                //         ApplicationArea = CostAccounting;
                //         Caption = 'Cost Centers';
                //         RunObject = Page "Chart of Cost Centers";
                //         ToolTip = 'Manage cost centers, which are departments and profit centers that are responsible for costs and income. Often, there are more cost centers set up in cost accounting than in any dimension that is set up in the general ledger. In the general ledger, usually only the first level cost centers for direct costs and the initial costs are used. In cost accounting, additional cost centers are created for additional allocation levels.';
                //     }
                //     action("Cost Objects")
                //     {
                //         ApplicationArea = CostAccounting;
                //         Caption = 'Cost Objects';
                //         RunObject = Page "Chart of Cost Objects";
                //         ToolTip = 'Set up cost objects, which are products, product groups, or services of a company. These are the finished goods of a company that carry the costs. You can link cost centers to departments and cost objects to projects in your company.';
                //     }
                //     action("Cost Allocations")
                //     {
                //         ApplicationArea = CostAccounting;
                //         Caption = 'Cost Allocations';
                //         RunObject = Page "Cost Allocation Sources";
                //         ToolTip = 'Manage allocation rules to allocate costs and revenues between cost types, cost centers, and cost objects. Each allocation consists of an allocation source and one or more allocation targets. For example, all costs for the cost type Electricity and Heating are an allocation source. You want to allocate the costs to the cost centers Workshop, Production, and Sales, which are three allocation targets.';
                //     }
                //     action("Cost Budgets")
                //     {
                //         ApplicationArea = CostAccounting;
                //         Caption = 'Cost Budgets';
                //         RunObject = Page "Cost Budget Names";
                //         ToolTip = 'Set up cost accounting budgets that are created based on cost types just as a budget for the general ledger is created based on general ledger accounts. A cost budget is created for a certain period of time, for example, a fiscal year. You can create as many cost budgets as needed. You can create a new cost budget manually, or by importing a cost budget, or by copying an existing cost budget as the budget base.';
                //     }
                // }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action(CloseIncomeStatement)
                {
                    Caption = 'Close Income Statement';
                    Image = "Invoicing-Save";
                    RunObject = report "Close Income Statement";
                }
                group("Monthly Billing")
                {
                    caption = 'Loan Monthly Interest';
                    action("Interest Due Periods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Interest Due Periods';
                        RunObject = page "Interest Due Periods";
                    }
                    group("Billing List")
                    {
                        action("Open Billing List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Billing List';
                            RunObject = page "Interest Header List";
                            RunPageLink = Status = filter(Open);
                        }
                        action("Pending Billing List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Billing List';
                            RunObject = page "Interest Header List";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Approved Billing List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Billing List';
                            RunObject = page "Interest Header List";
                            RunPageLink = Status = filter(Approved);
                        }
                        action("Posted Billing List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Billing List';
                            RunObject = page "Interest Header List";
                            RunPageLink = Status = filter(Approved), Posted = const(true);
                        }
                    }
                    // action("Dailly Bills Buffer List")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Dailly Bills Buffer List';
                    //     RunObject = page "Dailly Interest Buffer";
                    // }
                }
                group(Dividends)
                {
                    action("Dividend Simulation")
                    {
                        ApplicationArea = all;
                        Caption = 'Dividend Simulation';
                        RunObject = page "Dividend Simulation Header";
                    }
                    group("Dividend Provisions")
                    {
                        action("Dividends Provision List")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividends Provision List';
                            RunObject = page "Dividends Provision List";
                            RunPageView = where(Posted = const(false));

                        }
                        action("Posted Dividends Provision List")
                        {
                            ApplicationArea = all;
                            Caption = 'Posted Dividends Provision List';
                            RunObject = page "Dividends Provision List";
                            RunPageView = where(Posted = const(true));

                        }

                    }

                    group("Dividend Processing")
                    {

                        // action("Run Dividends")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Dividends Generation';
                        //     RunObject = report "Dividend Generation";
                        // }
                        action("Dividend Progression ")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividend Header List';
                            RunObject = page "Dividend Header List";
                        }
                        // action("Dividend Posting Buffer")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Generate Dividend Posting Buffer';
                        //     RunObject = report "Dividend Posting Buffer";
                        // }
                        // action("Dividend Posting Buffer ")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Dividend Posting Buffer';
                        //     RunObject = page "Dividend Posting Buffer";
                        // }
                        group("Dividend Reports")
                        {
                            action("Dividends Register")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Register';
                                RunObject = report "Dividend Register";
                            }
                            action("Dividends Slip")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Slip';
                                RunObject = report "Dividend Slip B64";
                            }
                            action("Dividends Statement")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Summary';
                                RunObject = report "Dividend Register Summary";
                            }
                            action("DividendsRegister")
                            {
                                ApplicationArea = all;
                                Caption = 'Detailed Dividend Register';
                                RunObject = report "Dividend Register Filtered";
                            }
                            action("Dividend Capitalization")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Capitalization';
                                RunObject = report "Dividends Capitalization";
                            }
                            action("Tax Exemption Report")
                            {
                                ApplicationArea = all;

                                RunObject = report "Tax Exemption Report";

                            }
                            action("Flagged Dividend Report")
                            {
                                ApplicationArea = all;

                                RunObject = report FlaggedDividendRegister;

                            }


                        }
                    }
                }
                group("Budgeting & Transfers")
                {
                    Caption = 'Budgeting & Transfers';

                    action(BudgetNames)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Budgets';
                        RunObject = Page "G/L Budget Names";
                        ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                    }
                    action(VoteTransfers)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vote Transfers';
                        RunObject = Page "Vote Transfer List.";
                        ToolTip = 'Transfer budgeted amounts between different budget entries.';
                    }
                    action(PostedVoteTransfers)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Vote Transfers';
                        RunObject = Page "Posted Vote Transfer List";
                        ToolTip = 'View the list of posted vote transfers.';
                    }
                    // action("Budget Committments")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Budget Committments';
                    //     RunObject = Page "Budget Committments";
                    //     ToolTip = 'View Budget Committments for a specific accounting period.';
                    // }
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }

            }

            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"),
                                        Recurring = const(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments),
                                        Recurring = const(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action164)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                // action("Direct Debit Collections")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Direct Debit Collections';
                //     RunObject = Page "Direct Debit Collections";
                //     ToolTip = 'Instruct your bank to withdraw payment amounts from your customer''s bank account and transfer them to your company''s account. A direct debit collection holds information about the customer''s bank account, the affected sales invoices, and the customer''s agreement, the so-called direct-debit mandate. From the resulting direct-debit collection entry, you can then export an XML file that you send or upload to your bank for processing.';
                // }
                // action("Payment Recon. Journals")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Payment Recon. Journals';
                //     Image = ApplyEntries;
                //     RunObject = Page "Pmt. Reconciliation Journals";
                //     ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                // }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Bank Reconcilliation Ageing Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Transactions Aging report';
                    Image = Aging;
                    RunObject = report "Bank Transactions Aging report";
                    ToolTip = 'Bank Transactions Aging report';

                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from customer cards or sales documents to define when the customer must pay, such as within 14 days.';
                }
                action(Deposit)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Deposit';
                    Image = DepositSlip;
                    //RunObject = Codeunit "Open Deposits Page";
                    RunObject = page "Bank Deposit List";
                    ToolTip = 'Create a new deposit. ';
                    // trigger OnAction()
                    // begin
                    //     "Open Deposits Page".Run;
                    // end;
                }

                // action("Cash Flow Forecasts")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Cash Flow Forecasts';
                //     RunObject = Page "Cash Flow Forecast List";
                //     ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                // }
                // action("Chart of Cash Flow Accounts")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Chart of Cash Flow Accounts';
                //     RunObject = Page "Chart of Cash Flow Accounts";
                //     ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                // }
                // action("Cash Flow Manual Revenues")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Cash Flow Manual Revenues';
                //     RunObject = Page "Cash Flow Manual Revenues";
                //     ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                // }
                // action("Cash Flow Manual Expenses")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Cash Flow Manual Expenses';
                //     RunObject = Page "Cash Flow Manual Expenses";
                //     ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                // }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }

            group(BankingMgt)
            {
                // group("Banking Management")
                group("Accounts")
                {
                    Caption = 'Accounts';
                    // action("Saving Account Application")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Saving Account Application';
                    //     RunObject = page "Savings Account Application";
                    // }

                    action("Savings Accounts Register List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts Register List';
                        RunObject = page "Savings Accounts";
                    }
                    // action("Member Listing Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Member Listing - List';
                    //     RunObject = page "Member Listing Report";
                    // }

                    action("Account Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Closure List';
                        RunObject = page "Banking Closure List";
                    }
                    action("Account Activation List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Activation List';
                        RunObject = page "Account Activation List";
                    }
                    action("Account Changes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Account Change Logs';
                        RunObject = report "FOSA Account Change Logs";
                    }
                    action(MemberList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member List';
                        RunObject = page "Member List";
                    }
                    action("Member Detailed Bal. List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Detailed Balances';
                        RunObject = Page "Detailed Member Balance List";
                    }
                    action(BankAccounts)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Accounts List';
                        RunObject = page "Bank Account List";
                    }
                }


                group("Banking Operations")
                {
                    Caption = 'Banking Operations';
                    group("Cashier")
                    {
                        Caption = 'Cashier And Treasury Transactions';
                        group(Cashiers)
                        {
                            action("Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Cashier Transactions';
                                RunObject = page "Cashier Transactions List";
                                RunPageView = where(Status = filter(Open), posted = filter(false));
                            }
                            action("Pending Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Cashier Transactions';
                                RunObject = page "Cashier Transactions List";
                                RunPageView = where(Status = filter("Pending Approval"), posted = filter(false));
                            }
                            action("Approved Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Cashier Transactions';
                                RunObject = page "Cashier Transactions List";
                                RunPageView = where(Status = filter(Approved), posted = filter(false));
                            }
                            action("Rejected Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Rejected Cashier Transactions';
                                RunObject = page "Cashier Transactions List";
                                RunPageView = where(Status = filter(Rejected), posted = filter(false));
                            }
                            action("Posted Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Cashier Transactions';
                                RunObject = page "Posted Cashier Transactions";
                            }
                            group(CashierReports)
                            {
                                Caption = 'Cashier Reports';

                                action("Cashier Daily Report")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Tellers Journal';
                                    RunObject = report "Tellers Journal";
                                }
                                action("Cashier Cheque Deposits")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Cashier Cheque Deposits Report';
                                    RunObject = report "Cashier Cheque Deposits";
                                }
                                // action()
                                action("Bankers Cheque Register")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Bankers Cheque Register Report';
                                    RunObject = report "Sacco Cheque Register";
                                }
                                action("End of Day Reconciliation")
                                {
                                    ApplicationArea = Basic;
                                    Image = PrintReport;
                                    Caption = 'End of Day Reconciliation Report';
                                    RunObject = codeunit "Run EOD Reconciliation Report";
                                }
                                action("Counter Summary Report")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Counter Summary Report';
                                    RunObject = report "Counter Summary Report";
                                }
                                action("Petty Cash Expenses Report")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Petty Cash Expenses Report';
                                    RunObject = report "Petty Cash Expenses Report";
                                }
                            }
                        }
                        group(BOSAReceipt)
                        {
                            Caption = 'Receipts';
                            action("BOSA Receipt List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Receipts';
                                RunObject = page "Receipts List";
                            }
                            action(" Posted Receipt List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = ' Posted Receipts';
                                RunObject = page "Posted Receipt List";
                            }

                        }
                        group("LienTransactions")
                        {
                            Caption = 'Lien Transactions.';
                            action("Lien Transactions List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Lien Transactions List';
                                RunObject = page "Lien Transactions List";
                                RunPageView = where(Posted = const(false), "Type" = Const(Lien));
                            }
                            action("Posted Lien Transactions List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Posted Lien Transactions List';
                                RunObject = page "Lien Transactions List";
                                RunPageView = where(Posted = const(true), "Type" = Const(Lien));
                            }
                        }
                        group(TreasuryCashierTransaction)
                        {
                            Caption = 'Treasury & Cashier Transactions';

                            action("Open Treasury & Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), status = const(open), Issued = const(no));
                            }
                            action("Pending Treasury & Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), status = const(pending), Issued = const(no));
                            }
                            action("Archived Treasury & Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Archived Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), status = const(Archived), Issued = const(no));
                            }
                            action("Approved Treasury & Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), status = const(Approved), Issued = const(no));
                            }
                            action("Issued Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Issued Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), issued = const(yes));
                            }

                            action("Treasury Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(true));
                            }
                            action("Rejected Treasury & Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Rejected Treasury & Cashier Transactions';
                                RunObject = page "Treasury Cashier List";
                                RunPageView = where(Posted = const(false), status = const(Rejected));
                            }
                            action("Treasury  Cashier Transactions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Treasury Report';
                                RunObject = report "Treasury Report";
                            }

                        }
                        // action(DailyTrans)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Daily FOSA Transaction Report';
                        //     RunObject = report "Daily Transactions Report";
                        // }
                    }
                    group("Transfers")
                    {
                        Caption = 'Transfers';
                        group(Account)
                        {
                            Caption = 'Account Transfer';
                            action("ACT Trasfer")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Account Transfer';
                                RunObject = page "Account Transfer List";
                            }
                            action("P. Account Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Posted Account Transfer';
                                RunObject = page "Posted Account Transfer List";
                            }
                        }
                        group(Interbank)
                        {
                            Caption = 'InterBank Transfers';
                            action("Interbank Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Pending InterBank Transfer';
                                RunObject = page "InterBank Transfers List";
                                RunPageView = where(Posted = const(false), status = filter(Pending));
                            }

                            action("Approved Interbank Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Approved InterBank Transfer';
                                RunObject = page "InterBank Transfers List";
                                RunPageView = where(Posted = const(false), status = filter(Approved));
                            }
                            action("Cancelled Interbank Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Cancelled InterBank Transfer';
                                RunObject = page "InterBank Transfers List";
                                RunPageView = where(Posted = const(false), status = filter(Cancelled));
                            }
                            action("Posted Interbank Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Posted InterBank Transfer';
                                RunObject = page "Posted Bank & Cash Transfers";
                            }
                            action("Rejected Interbank Transfer")
                            {
                                ApplicationArea = Suite, FixedAssets;
                                Caption = 'Rejected InterBank Transfer';
                                RunObject = page "InterBank Transfers List";
                                RunPageView = where(Posted = const(false), status = filter(Rejected));
                            }

                        }
                    }
                    group(Payments)
                    {
                        Caption = 'Payments';
                        group("Petty Cash List")
                        {
                            Caption = 'Petty Cash';
                            action(PettyCashL)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Petty Cash List';
                                RunObject = page "Petty Cash Vouchers List";
                            }
                            action(PPettyCash)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Petty Cash List';
                                RunObject = page "Posted Petty Cash Vouchers";
                            }
                        }

                    }


                    group("Standing Orders")
                    {
                        group(Processing)
                        {
                            action("Open Standing Order List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Standing Order List";
                                RunPageView = where(Status = const(Open));
                            }
                            action("Pending Standing Order List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Standing Order List";
                                RunPageView = where(Status = const(Pending));
                            }

                        }
                        group("Active STOs")
                        {
                            action("Approved Standing Order List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Standing Order List";
                                RunPageView = where(Status = const(Approved));
                            }
                            action("Standing Order Register List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Standing Order Register List';
                                RunObject = page "Standing Order Register List";
                            }
                        }
                        group(Achives)
                        {
                            action("Rejected Standing Order List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Standing Order List";
                                RunPageView = where(Status = const(Rejected));
                            }
                            action("Stopped Standing Order List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Standing Order List";
                                RunPageView = where(Status = const(Stopped));
                            }
                        }
                        action("Standing Order")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Report';
                            RunObject = report "Standing Order";
                        }


                    }

                    group("Cheque Management")
                    {
                        Caption = 'Cheque Management';
                        group("Bankers Cheque Applications")
                        {
                            action("Open Bankers Cheque Application")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Bankers Cheque Applications';
                                RunObject = page "Bankers Application List";
                                RunPageView = where(Status = const(Open), "Cheque Register Generated" = const(false));
                            }
                            action("Pending Bankers Cheque Application")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Bankers Cheque Applications';
                                RunObject = page "Bankers Application List";
                                RunPageView = where(Status = const("Pending Approval"), "Cheque Register Generated" = const(false));
                            }
                            action("Approved Bankers Cheque Application")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Bankers Cheque Applications';
                                RunObject = page "Bankers Application List";
                                RunPageView = where(Status = const("Approved"), "Cheque Register Generated" = const(false));
                            }
                            action("Registered Bankers Cheque Application")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Registered Bankers Cheque Applications';
                                RunObject = page "Bankers Application List";
                                RunPageView = where(Status = const("Approved"), "Cheque Register Generated" = const(true));
                            }

                        }
                        // action("Treasury Cheque Application")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Treasury Control Cheque Application';
                        //     RunObject = page "Treasury Application List";
                        // }
                        // action("Treasury Cheque Inventory")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Treasury Control Cheque Inventory';
                        //     RunObject = page "Treasury Cheque Inventory";
                        // }
                        action("Cheque Clearance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Clearance';
                            RunObject = page "Cheque Clearance";
                            RunPageView = where("Cheque Status" = filter(Pending));
                        }
                        action("Cleared Cheques")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cleared Cheques';
                            RunObject = page "Cheque Clearance";
                            RunPageView = where("Cheque Status" = filter(Cleared));
                        }
                        action("Cancelled Cheques")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Cheques';
                            RunObject = page "Cheque Clearance";
                            RunPageView = where("Cheque Status" = filter(Stopped | Bounced));
                        }
                        // action("Cheque Book Application")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Cheque Book Application';
                        //     RunObject = page "Cheque Book Application List";
                        // }
                        action("Cheque Types")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Types';
                            RunObject = page "Cheque Types";
                        }
                        // action("Cheque Receipts")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Cheque Receipts';
                        //     RunObject = page "Cheque Receipts List";
                        // }

                    }
                    group("ATM Management")
                    {
                        Caption = 'ATM Management';

                        group("ATM Applications")
                        {
                            action("ATM Applications List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'ATM Applications List';
                                RunObject = page "ATM Application List";
                            }
                            action("Approved ATM Applications List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved ATM Applications List';
                                RunObject = page "Approved ATM Application List";
                            }

                            // action("ATM Inventory List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'ATM Inventory List';
                            //     RunObject = page "ATM Inventory List";
                            // }
                            // action("Dispatch ATM List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Dispatch ATM List';
                            //     RunObject = page "Dispatch ATM Lists";
                            // }
                            action("Uncollected Cards From Bank")
                            {
                                ApplicationArea = Basic, Suite;
                                Visible = false;
                                Caption = 'Uncollected Cards From Bank';
                                RunPageLink = "Received From Bank" = CONST(false);
                                RunObject = page "Approved ATM Application List";
                            }
                            action("Collected Cards From Bank")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Collected Cards From Bank';
                                RunPageLink = "Received From Bank" = CONST(true);
                                RunObject = page "Approved ATM Application List";
                            }
                            action("Rejected ATM Applications List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Rejected ATM Applications List';
                                RunObject = page "ATM Application List";
                                RunPageLink = "Status" = CONST(Rejected);
                            }

                        }
                        action("ATM Return List")
                        {
                            Visible = false;
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Return List';
                            RunObject = page "ATM Returned List";
                        }
                        group("Atm Linking")
                        {
                            action("ATM Linking Application List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'ATM Linking Application List';
                                RunObject = page "ATM Linking Application List";
                            }
                            action("Approved ATM Linking Charge List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved ATM Linking Charge and Collection List';
                                //RunPageLink = "ATM Charges Applied" = const(false);
                                RunPageLink = "Collected" = const(false);

                                RunObject = page "Approved ATM Linking List";
                            }
                            // action("Approved ATM Linking Collection List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Approved ATM Linking Collection List';
                            //     RunPageLink = "Collected" = const(false), "ATM Charges Applied" = const(true);
                            //     RunObject = page "Approved ATM Linking List";
                            // }
                            action("Approved ATM Linking List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved ATM Linking List';
                                RunPageLink = "Collected" = const(true), "ATM Charges Applied" = const(true), "ATM Linked" = const(false), "ATM Delinked" = const(false);
                                RunObject = page "Approved ATM Linking List";
                            }
                            action("Linked ATM List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Linked ATM List';
                                RunPageLink = "Collected" = const(true), "ATM Charges Applied" = const(true), "ATM Linked" = const(true);
                                RunObject = page "Approved ATM Linking List";
                            }
                            action("Delinked ATM List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Delinked ATM List';
                                RunPageLink = "ATM Delinked" = const(true);
                                RunObject = page "Approved ATM Linking List";
                            }
                            // action("Bulk ATM Linking List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Bulk ATM Linking List';
                            //     RunObject = page "ATM Bulk Linking List";
                            // }
                        }
                        group(ATMRepin)
                        {
                            Caption = 'ATM Repin';
                            Visible = true;
                            action("ATM Repin Application List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'ATM Repin Application List';
                                RunObject = page "ATM Repin Application List";
                            }
                            action("ATM Repin Processed List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'ATM Repin Procssed List';
                                RunObject = page "ATM Repin Procssed List";
                            }
                        }

                        group(MobileBank)
                        {
                            Caption = 'M-Banking PIN Resets';
                            Visible = true;
                            action("Mobile Banking List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Mobile Banking PIN Reset Application List';
                                RunObject = page "Mobile Banking App List";
                            }
                            action("Mobile Processed List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Mobile Banking PIN Reset Processed List';
                                RunObject = page "Mobile Banking Procssed List";
                            }
                        }
                        // action("ATM Card List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'ATM Card List';
                        //     RunObject = page "ATM Card List";
                        // }
                        action("ATM Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Transactions';
                            RunObject = page "Sky ATM Transactions Buffer";
                        }
                        // action("ATM Applicant List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'ATM Applicant List';
                        //     RunObject = page "Member List";
                        //     RunPageView = where("Request for ATM" = const(true));
                        // }

                        // action("Mobile Banking Applicant List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Mobile Banking Applicant List';
                        //     RunObject = page "Member List";
                        //     RunPageView = where("Request Mobile Banking" = const(true));
                        // }

                    }


                    group(SystemEdits)
                    {
                        Caption = 'System Edits';
                        action(SystemEdit)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'System Edits';
                            RunObject = page "System Edits List";
                        }

                    }

                    group("Reversal")
                    {
                        Caption = 'Reversals';

                        action(AutoReversal)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Auto Reversal';
                            RunObject = page "System Reversal List";
                        }
                        action(PostedAutoReversal)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Auto Reversal';
                            RunObject = page "Posted Reversal List";
                        }
                    }

                    group(GLRegister)
                    {
                        Caption = 'General Journal And Register';
                        group(GLRegisters)
                        {
                            Caption = 'General Journal And Register';
                            action(Register)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'G/L Register';
                                RunObject = page "G/L Registers";
                            }
                            action(GeneralJournal)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'General Journal';
                                RunObject = page "General Journal";
                            }
                        }
                        group(BankDeposits)
                        {
                            Caption = 'Bank Deposits';
                            action("Bank Deposits")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Bank Deposit List';
                                RunObject = page "Bank Deposit List";
                            }
                            // action("Posted Bank Deposits")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Posted Bank Deposit list';
                            //     RunObject = codeunit posted
                            // }
                        }

                    }

                }
                group("Banking Reports")
                {
                    Caption = 'Reports and Analysis';
                    group("Account Reports")
                    {
                        Caption = 'Account Management';
                        action("Accounts Application Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Accounts Application Register';
                            RunObject = report "Accounts Application Register";
                        }
                        action("Savings Accounts Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Savings Accounts Register';
                            RunObject = report "Savings Accounts Register";
                        }
                        action("FOSA Savings Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'FOSA Savings Register';
                            RunObject = report "FOSA Savings Register";
                        }
                        action("Savings Account Types")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Savings Accounts Types Report';
                            RunObject = report "Savings Account Types Report";
                        }
                        // action("Posted Salary Reports")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Posted Salary Report';
                        //     RunObject = query "Salary Lines";
                        // }
                        action("Account Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'FOSA Loan Register';
                            RunObject = report "FOSA Loan Register";
                        }
                        action("Salary Accounts List Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salaries received though FOSA';
                            RunObject = report "Salary Accounts List Report";
                        }
                        // action("Salary Through FOSA Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Salary Through FOSA Report';
                        //     RunObject = report "Salary Through FOSA Report";
                        // }
                        action("Salary Not Thru FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salary Not Thru FOSA';
                            RunObject = report "Salary Not Through FOSA";
                        }

                        // action("Savings Contribution Variance")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Savings Contribution Variance';
                        //     //RunObject = report "Savings Contribution Variance";
                        // }
                        action("Generate Dormant Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Generate Dormant Accounts';
                            RunObject = report "Generate Dormant Accounts";
                        }

                    }
                    group("Cashier Reports")
                    {
                        Caption = 'Cashier Reports';
                        action("Cashier Transactions Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cashier Transactions';
                            RunObject = report "Cashier Transactions";
                        }


                        action("Daily Transactions Cashiers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Daily Transactions Cashiers Report';
                            RunObject = report "Daily Transaction Report";
                        }
                        action("Bankers Cheque Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bankers Cheque Report';
                            RunObject = report "Bankers Cheque Report";
                        }
                        action("Treasury Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Treasury Report';
                            RunObject = report "Treasury Report";
                        }
                        action("AML Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Anti-Money Laundering Report';
                            RunObject = report "Anti-Money Laundering Report";
                        }
                        action("All Tellers Cash Report")
                        {
                            ApplicationArea = Basic;
                            Caption = 'All Tellers Cash Report';
                            Image = PrintReport;
                            // Promoted = true;
                            // PromotedCategory = "Report";
                            ToolTip = 'View the consolidated cash summary for all tellers.';
                            RunObject = report "All Tellers Cash Report";

                            // trigger OnAction()
                            // begin
                            //     // RUNS THE REPORT, 'true' OPENS THE REQUEST PAGE FOR THE DATE FILTER
                            //     Report.Run(Report::"All Tellers Cash Report", true, false);
                            // end;
                        }
                        action("Petty Cash Expense Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Petty Cash Expense Report';
                            RunObject = report "Petty Cash Expenses Report";
                        }
                        action("End of Day Reconciliation reports")
                        {
                            ApplicationArea = Basic;
                            Image = PrintReport;
                            Caption = 'End of Day Reconciliation Report';
                            RunObject = codeunit "Run EOD Reconciliation Report";
                        }
                    }



                    group("ATM Reports")
                    {
                        Caption = 'ATM Reports';
                        action("ATM Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Activation Report';
                            RunObject = report "ATM Activation Report";
                        }
                        // action("ATM card no's account balances")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'ATM card nos account balances';
                        //     // RunObject = report "ATM card no's account balances";
                        // }
                        action("ATM Upload Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Upload Report';
                            RunObject = report "ATM Upload Report";
                        }
                    }
                    group("Standing Order Reports")
                    {
                        Caption = 'Standing Order Reports';

                        action("Standing Orders Register")
                        {
                            ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                            Caption = 'Standing Orders Register';
                            RunObject = report "Standing Orders Register";
                        }
                        action("Standing Order Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Report';
                            RunObject = report "Standing Order";
                        }
                        // action("Standing Order Register")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Standing Order Register';
                        //     RunObject = report "Standing Order Register";
                        // }
                    }

                }

                group("Banking Setup")
                {
                    Caption = 'Banking Setups';
                    group("Transaction Setup")
                    {
                        Caption = 'Transactions Setup';
                        action("Transaction Type list")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Transaction Types List';
                            RunObject = page "Transaction Types List";
                        }
                        action("Tiered Charges")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tiered Charges';
                            RunObject = page "Tiered Charges List";
                        }
                        action("Denominition Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Denominition Setup';
                            RunObject = page "Denomination Setup";
                        }
                        action("ATM Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Card Types Setup';
                            RunObject = page "ATM Card Types";
                        }
                        // action(ProductSetup)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Product Setup';
                        //     RunObject = page "Product Factory List";
                        // }

                    }

                    group("Banking Setups")
                    {
                        Caption = 'Banking Setups.';
                        action("Banking No Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Banking No Setup';
                            RunObject = page "Banking No Setup";
                        }
                        action("Banking User Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Banking User Setup';
                            RunObject = page "Banking User Setup";
                        }
                        action("Cash Office User Template")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Office User Template';
                            RunObject = page "Cash Office User Template";
                        }
                    }
                }

            }
            group(Channels)
            {
                caption = 'Channels';
                group("Mobile Banking")
                {
                    Caption = 'Mobile Banking';
                    group("Posted Transactions")
                    {
                        Caption = 'Posted Transactions';

                        action(AllWithdrawals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'All Withdrawals';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(true),
                                    "Transaction Type" = Filter(
                                        "Mpesa Withdrawal" |
                                        "Utility Payment" |
                                        Airtime |
                                        "Bank Transfer" | "Till Payment" | "Gaming Utility Payment"
                                    ),
                                "Change Type" = filter(Post | Reverse)
                                );
                        }
                        action(PostedWithdrawals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Withdrawal Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(true),
                                    "Transaction Type" = Filter(
                                        "Mpesa Withdrawal" |
                                        "Utility Payment" |
                                        Airtime |
                                        "Bank Transfer" | "Till Payment" | "Gaming Utility Payment"
                                    ),
                                    "Change Type" = const(Post)
                                );
                        }
                        action(ReversedWithdrawals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Reversed Withdrawal Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(true),
                                    "Transaction Type" = Filter(
                                        "Mpesa Withdrawal" |
                                        "Utility Payment" |
                                        Airtime |
                                        "Bank Transfer" | "Till Payment" | "Gaming Utility Payment"
                                    ),
                                    "Change Type" = const(Reverse)
                                );
                        }
                        action(PostedDeposits)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Deposit Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(true),
                                    "Transaction Type" = Filter(
                                        "Mpesa Deposit" |
                                        "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                    ),
                                    "Change Type" = const(Post)
                                );
                        }
                        action(ReversedDeposits)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Reversed Deposit Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(true),
                                    "Transaction Type" = Filter(
                                        "Mpesa Deposit" |
                                        "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                    ),
                                    "Change Type" = const(Reverse)
                                );
                        }
                    }

                    group("Unposted Transactions")
                    {
                        Caption = 'Unposted Transactions';
                        action(UnpostedWithdrawals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Withdrawal Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(false),
                                    "Transaction Type" = Filter(
                                        "Mpesa Withdrawal" |
                                        "Utility Payment" |
                                        Airtime |
                                        "Bank Transfer"
                                    )
                                );
                        }
                        action(UnpostedDeposits)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Deposit Transactions';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                    "Posted" = const(false),
                                    "Transaction Type" = Filter(
                                        "Mpesa Deposit" |
                                        "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                    )
                                );
                        }
                        group("Tasks")
                        {
                            Caption = 'Tasks';

                            action(DepositNeedsChange)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Deposit Needs Change';
                                RunObject = Page "Sky M-Banking Trans. Buffer";
                                RunPageView = where(
                                    "Needs Change" = const(true)
                                );
                            }
                        }
                    }

                    group("Reversal Transactions")
                    {
                        Caption = 'Reversal Transactions';
                        action(PostedReversals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted Reversals';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                "Transaction Status" = const(REVERSE_CONFIRMED),
                                Posted = const(true)
                            );
                        }
                        action(UnpostedReversals)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Unposted Reversals';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                "Transaction Status" = const(REVERSE_CONFIRMED),
                                Posted = const(false)
                            );
                        }
                    }

                    group("MobileLoans")
                    {
                        Caption = 'Mobile Loans';
                        action("Posted Mobile Loans")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted Mobile Loans';
                            RunObject = Page "Sky Mobile Loans";
                            RunPageView = where(
                                    Posted = const(true)
                                );
                        }
                        action("Unposted Mobile Loans")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Unposted Mobile Loans';
                            RunObject = Page "Sky Mobile Loans";
                            RunPageView = where(
                                Posted = const(false)
                            );
                        }
                        action("Mobile Loans - Loan Book")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted Mobile Loan Book';
                            RunObject = Page "Loans List";
                            RunPageView = where(
                                Posted = const(true), "Mobile Loan" = filter(true)
                            );
                        }

                    }
                    group("Members Portal Loans")
                    {
                        action("Portal Loans")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Applied Portal Loans';
                            RunObject = Page "Loans List";
                            RunPageView = where(
                                Posted = const(false), "Source Aplication" = filter("Member Portal")
                            );
                        }
                        action("Posted Portal Loans")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted Portal Loans';
                            RunObject = Page "Loans List";
                            RunPageView = where(
                                Posted = const(true), "Source Aplication" = filter("Member Portal")
                            );
                        }
                    }

                }
                group(SMS)
                {
                    Caption = 'SMS';
                    action(SMSMessages)
                    {
                        ApplicationArea = Basic;
                        Caption = 'SMS Messages';
                        RunObject = Page "Sky SMS Messages";
                    }
                }
                group(Setups)
                {
                    Caption = 'Setups';
                    action(MobileTransactionTypes)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Mobile Transaction Types';
                        RunObject = Page "Mobile Transaction types List";
                    }
                    action(ATMTransactionTypes)
                    {
                        ApplicationArea = Basic;
                        Caption = 'ATM Transaction Types';
                        RunObject = Page "ATM Charge List";
                    }
                    action(TransactionLimits)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transaction Limits';
                        RunObject = Page "E-Channels Transaction Setup";
                    }
                    action("Gaming Paybills Setup")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Gaming Paybills Setup';
                        RunObject = Page "Gaming Paybills Setup";
                    }
                }
            }

            group("5. Purchase Invoicing1")
            {
                Caption = 'Purchase Invoicing';
                Visible = true;
                action("Open Purchase Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Open Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    RunPageView = WHERE(Status = CONST("Open"));
                }
                action("Pending Purchase Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    RunPageView = WHERE(Status = CONST("Pending Approval"));
                }
                action("Approved Purchase Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    RunPageView = WHERE(Status = CONST("Released"));
                }

                action("Posted Purchase Invoicess1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    //RunObject = page "Purchase Invoices";
                    RunObject = page "Posted Purchase Invoices";
                }

                action("All Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Purchase Invoices';
                    Image = Invoice;
                    RunObject = page "Purchase Invoices";
                }
            }
            group(Procurement)
            {
                // group("Planning")
                // {
                //     Caption = 'Planning';
                //     group("Procurememnt Order Planning")
                //     {
                //         Caption = 'Order Planning';
                //         action("Order Planning")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Order Planning';
                //             RunObject = page "G/L Budget Names";
                //         }
                //     }
                //     group("Planning Administration")
                //     {
                //         Caption = 'Administration';
                //         action("Req. Worksheet")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Req. Worksheet';
                //             RunObject = page "Req. Worksheet";
                //         }
                //         action("Recurring Req. Worksheet")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Recurring Req. Worksheet';
                //             RunObject = page "Recurring Req. Worksheet";
                //         }
                //         action("Purchase Order List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Purchase Order List';
                //             RunObject = page "Purchase Order List";
                //         }
                //         action("Service Orders")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Service Orders';
                //             RunObject = page "Service Orders";
                //         }
                //         action("Transfer Orders")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Transfer Orders';
                //             RunObject = page "Transfer Orders";
                //         }
                //     }
                // }

                group("Order Processing")
                {
                    group("Order Processing2")
                    {
                        Caption = 'Order Processing';

                        group("1. Purchase Requisitions")
                        {
                            Caption = 'Purchase Requisitions';

                            action("Open Purchase Requisitions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Purchase Requisitions';
                                RunObject = Page "Purchase Requisitions";
                                RunPageView = WHERE(Status = Const(Open));
                            }

                            action("Pending Purchase Requisitions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Purchase Requisitions';
                                RunObject = Page "Purchase Requisitions";
                                RunPageView = WHERE(Status = CONST("Pending Approval"));
                            }

                            action("Approved Purchase Requisitions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Purchase Requisitions';
                                RunObject = Page "Purchase Requisitions";
                                RunPageView = WHERE(Status = CONST("Released"));
                            }

                            /* action("Posted Purchase Requisitions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted';
                                RunObject = Page "Purchase Requisitions";
                                RunPageView = WHERE(Status = CONST(Posted));
                            } */
                        }


                        group("Purchase Quotes")
                        {
                            Caption = 'Purchase Quotes';
                            action("Open Purchase Quotes")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Purchase Quotes';
                                RunObject = page "Purchase Quotes";
                                RunPageView = WHERE(Status = Const(Open));
                            }
                            action("Pending Purchase Quotes")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Purchase Quotes';
                                RunObject = page "Purchase Quotes";
                                RunPageView = WHERE(Status = Const("Pending Approval"));
                            }
                            action("Approved Purchase Quotes")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Purchase Quotes';
                                RunObject = page "Purchase Quotes";
                                RunPageView = WHERE(Status = Const("Released"));

                            }
                            /*                     action("Posted Purchase Quotes")
                                                {
                                                    ApplicationArea = Basic, Suite;
                                                    Caption = 'Posted';
                                                    RunObject = page "Purchase Quotes";
                                                } */
                        }

                        group("Local Purchase Orders")
                        {
                            Caption = 'Local Purchase Orders';
                            action("Open LPOs")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Local Purchase Orders';
                                RunObject = page "Purchase Order List";
                                RunPageView = WHERE(Status = Const("Open"));

                            }
                            action("Pending LPOs")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Local Purchase Orders';
                                RunObject = page "Purchase Order List";
                                RunPageView = WHERE(Status = Const("Pending Approval"));

                            }
                            action("Approved LPOs")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Local Purchase Orders';
                                RunObject = page "Purchase Order List";
                                RunPageView = WHERE(Status = Const("Released"));
                            }

                            // action("Posted LPOs")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Posted';
                            //     RunObject = page "Purchase Order List";
                            // }

                            // Cancelled Purchase Orders
                            // action("Cancelled LPOs")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Cancelled Local Purchase Orders';
                            //     RunObject = page "Purchase Order List";
                            //     RunPageView = WHERE(Status = FILTER(Cancelled | Rejected));
                            // }
                        }

                        group("5. Payments")
                        {
                            Caption = 'Payments';
                            ///Visible = false;
                            action("Open Purchase Invoices")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Purchase Invoices';
                                RunObject = page "Purchase Invoices";
                                RunPageView = WHERE(Status = CONST("Open"));
                            }
                            action("Pending Purchase Invoices")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Purchase Invoices';
                                RunObject = page "Purchase Invoices";
                                RunPageView = WHERE(Status = CONST("Pending Approval"));
                            }
                            action("Approved Purchase Invoices")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Purchase Invoices';
                                RunObject = page "Purchase Invoices";
                                RunPageView = WHERE(Status = CONST("Released"));
                            }
                            action("Posted Purchase Invoicess")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Purchase Invoices';
                                //RunObject = page "Purchase Invoices";
                                RunObject = page "Posted Purchase Invoices";
                            }

                            action("Purchase Credit Memos")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase Credit Memos';
                                RunObject = page "Purchase Credit Memos";
                            }
                        }
                        group("Procurement & Logistics")
                        {
                            Caption = 'Related Procurement Activities';
                            action("Disposal Requisition")
                            {
                                visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Disposal Requisition';
                                RunObject = page "Disposal Requisition List";
                            }

                            action("Sales Quotes")
                            {
                                visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Sales Quotes';
                                RunObject = page "Sales Quotes";
                            }

                            action("Sales Invoice List")
                            {
                                Visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Sales Invoice List';
                                RunObject = page "Sales Invoice List";
                            }

                            // action("Goods Received Note")
                            // {
                            //     visible = false;
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Goods Received Note';
                            //     RunObject = page "GRN List";
                            // }

                            /* action("Transfer Orders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Transfer Orders';
                                RunObject = page "Transfer Orders";
                            } */
                        }

                        group("Order Processing Documents")
                        {
                            Caption = 'Documents';
                            action("Purchase - Quote")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase - Quote';
                                RunObject = report "Purchase - Quote";
                            }
                            action("Order")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Order';
                                RunObject = report "Order";
                            }
                            action("Blanket Purchase Order")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Blanket Purchase Order';
                                RunObject = report "Blanket Purchase Order";
                            }
                            action("Purchase - Invoice")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase - Invoice';
                                RunObject = report "Purchase - Invoice";
                            }
                            action("Purchase - Credit Memo")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase - Credit Memo';
                                RunObject = report "Purchase - Credit Memo";
                            }
                            action("Purchase - Receipt")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase - Receipt';
                                RunObject = report "Purchase - Receipt";
                            }
                            action("Purchase - Return Shipment")
                            {
                                Visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase - Return Shipment';
                                RunObject = report "Purchase - Return Shipment";
                            }
                            action("Return Order Confirmation")
                            {
                                Visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Return Order Confirmation';
                                RunObject = report "Return Order Confirmation";
                            }
                            action("Vendor-Payment Receipt")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor - Payment Receipt';
                                RunObject = report "Vendor - Payment Receipt";
                            }
                            action("Purchase Document - Test")
                            {
                                visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase Document - Test';
                                RunObject = report "Purchase Document - Test";
                            }
                            action("Item Tracking Appendix")
                            {
                                visible = false;
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Tracking Appendix';
                                RunObject = report "Item Tracking Appendix";
                            }
                        }

                        /* group("8. Administration")
                        {
                            Caption = 'Administration';
                            action("Subcontracting Worksheet")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Subcontracting Worksheet';
                                RunObject = page "Subcontracting Worksheet";
                            }
                        } */
                    }
                    group("Procurememnt Order Planning")
                    {
                        Caption = 'Lists';
                        // action("Order Planning")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Order Planning';
                        //     RunObject = page "Order Planning";
                        // }
                        // action(Budgets)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'G/L Budgets';
                        //     RunObject = page "G/L Budget Names";
                        // }
                        action(Vendors)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Active Vendors';
                            RunObject = page "Vendor List";
                            RunPageView = where(Archived = const(false));
                        }
                        action(AVendors)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Archived Vendors';
                            RunObject = page "Vendor List";
                            RunPageView = where(Archived = const(true));
                        }
                        action(Item)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Items';
                            RunObject = page "Item List";
                        }
                        action("Stock Keeping")
                        {
                            ApplicationArea = Basic, Suite;

                            RunObject = page "StockKeeping List";
                        }
                    }

                    group("Inventory and Costing List")
                    {
                        group("Store Keeping")
                        {
                            Caption = 'Store Keeping';

                            action("Store Requisition")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Store Requisition';
                                RunObject = Page "Store Requisitions List";
                            }

                            action("Cancelled Store Req List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Cancelled Store Req List';
                                RunObject = Page "Cancelled Store Req List";
                            }

                            action("Posted Store Req List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Store Req List';
                                RunObject = Page "Posted Store Requisitions List";
                            }
                            action("Store Requisition Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Store Requisition Report';
                                RunObject = Report "Store Requisition";
                            }
                        }

                        action("Stockkeeping Unit List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Stockkeeping Unit List';
                            RunObject = page "Stockkeeping Unit List";
                            Visible = false;
                        }
                    }
                    // group("Inventory and Costing")
                    // {
                    //     Caption = 'Inventory & Costing';
                    //     group("Inventory and Costing List")
                    //     {
                    //         // action("Nonstock Item List")
                    //         // {
                    //         //     ApplicationArea = Basic, Suite;
                    //         //     Caption = 'Nonstock Item List';
                    //         //     RunObject = page "Nonstock Item List";
                    //         // }
                    //         action("Stockkeeping Unit List")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Stockkeeping Unit List';
                    //             RunObject = page "Stockkeeping Unit List";
                    //         }
                    //     }
                    //     group("Procurement Tasks")
                    //     {
                    //         Caption = 'Procurement Journals';
                    //         action("Item Journal")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Item Journal';
                    //             RunObject = page "Item Journal";
                    //         }

                    //         action("Phys. Inventory Journal")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Phys. Inventory Journal';
                    //             RunObject = page "Phys. Inventory Journal";
                    //         }
                    //         action("Revaluation Journal")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Revaluation Journal';
                    //             RunObject = page "Revaluation Journal";
                    //         }
                    //         action("Item Reclass. Journal")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Item Reclass. Journal';
                    //             RunObject = page "Item Reclass. Journal";
                    //         }
                    //         action("Recurring Item Jnl.")
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Recurring Item Jnl.';
                    //             RunObject = page "Recurring Item Jnl.";
                    //         }
                    //     }
                    //     // group("Costing")
                    //     // {
                    //     //     Caption = 'Costing';
                    //     //     action("Standard Cost Worksheet")
                    //     //     {
                    //     //         ApplicationArea = Basic, Suite;
                    //     //         Caption = 'Standard Cost Worksheet';
                    //     //         RunObject = page "Standard Cost Worksheet";
                    //     //     }
                    //     // }

                    // }
                    group("Reports and Analysis")
                    {
                        Caption = 'Reports and Analysis';
                        group("Planning Reports")
                        {
                            Caption = 'Planning';

                            // action("Purchase Invoice Report")
                            // {
                            //     ApplicationArea = all;
                            //     Caption = 'Purchase Invoice Report';
                            //     RunObject = report "Purchase Invoice Report";

                            // }
                            action("Purchase Order Report")
                            {
                                ApplicationArea = all;
                                Caption = 'Purchase Order Report';
                                RunObject = report "Purchase Order";

                            }
                            action("Purchase Reservation Avail.")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase Reservation Avail.';
                                RunObject = report "Purchase Reservation Avail.";
                            }
                            action("Purchase Statistics")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase Statistics';
                                RunObject = report "Purchase Statistics";
                            }
                            action("Vendor Item Catalog")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor Item Catalog';
                                RunObject = report "Vendor Item Catalog";
                            }
                            action("Vendor - Balance to Date")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor - Balance to Date';
                                RunObject = report "Vendor - Balance to Date";
                            }
                            action("Vendor - Detail Trial Balance")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor - Detail Trial Balance';
                                RunObject = report "Vendor - Detail Trial Balance";
                            }
                            // action("Vendor - List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Vendor - List';
                            //     RunObject = report "Vendor - List";
                            // }
                            action("Vendor - Purchase List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor - Purchase List';
                                RunObject = report "Vendor - Purchase List";
                            }
                            // action("Vendor - Summary Aging")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Vendor - Summary Aging';
                            //     RunObject = report "Vendor - Summary Aging";
                            // }
                            // action("Vendor - Top 10 List")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Vendor - Top 10 List';
                            //     RunObject = report "Vendor - Top 10 List";
                            // }
                            action("Vendor - Trial Balance")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor - Trial Balance';
                                RunObject = report "Vendor - Trial Balance";
                            }
                            action("Vendor/Item Purchases")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor/Item Purchases';
                                RunObject = report "Vendor/Item Purchases";
                            }
                            action("Inventory Cost and Price List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory Cost and Price List';
                                RunObject = report "Inventory Cost and Price List";
                            }
                            action("Inventory Purchase Orders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory Purchase Orders';
                                RunObject = report "Inventory Purchase Orders";
                            }
                            // action("Inventory - Availability Plan")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Inventory - Availability Plan';
                            //     RunObject = report "Inventory - Availability Plan";
                            // }
                            action("Inventory - Cost Variance")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - Cost Variance';
                                RunObject = report "Inventory - Cost Variance";
                            }
                            action("Inventory - Inbound Transfer")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - Inbound Transfer';
                                RunObject = report "Inventory - Inbound Transfer";
                            }
                            action("Inventory - List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - List';
                                RunObject = report "Inventory - List";
                            }
                            action("Inventory - Vendor Purchases")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - Vendor Purchases';
                                RunObject = report "Inventory - Vendor Purchases";
                            }
                            action("Item Substitutions")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Substitutions';
                                RunObject = report "Item Substitutions";
                            }
                            action("Item/Vendor Catalog")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item/Vendor Catalog';
                                RunObject = report "Item/Vendor Catalog";
                            }
                            // action("Nonstock Item Sales")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Nonstock Item Sales';
                            //     RunObject = report "Nonstock Item Sales";
                            // }
                            action("Prod. Order - Mat. Requisition")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Prod. Order - Mat. Requisition';
                                RunObject = report "Prod. Order - Mat. Requisition";
                            }
                            action("Prod. Order - Shortage List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Prod. Order - Shortage List';
                                RunObject = report "Prod. Order - Shortage List";
                            }
                        }

                        group("Order Processing Reports")
                        {
                            Caption = 'Order Processing';
                            action("Vendor/Items Purchases")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Vendor/Item Purchases';
                                RunObject = report "Vendor/Item Purchases";
                            }
                            action("Inventory Availability")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory Availability';
                                RunObject = report "Inventory Availability";
                            }
                            action("Inventory Cost and Prices List")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory Cost and Price List';
                                RunObject = report "Inventory Cost and Price List";
                            }
                            action("Inventory Posting - Test")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory Posting - Test';
                                RunObject = report "Inventory Posting - Test";
                            }
                            action("Inventory Purchases Orders")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory Purchase Orders';
                                RunObject = report "Inventory Purchase Orders";
                            }
                            action("Inventory-List")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory - List';
                                RunObject = report "Inventory - List";
                            }
                            action("Inventory - Reorders")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory - Reorders';
                                RunObject = report "Inventory - Reorders";
                            }
                            action("Inventory - Transaction Detail")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory - Transaction Detail';
                                RunObject = report "Inventory - Transaction Detail";
                            }
                            action("Inventory - Vendors Purchases")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Inventory - Vendor Purchases';
                                RunObject = report "Inventory - Vendor Purchases";
                            }
                            action("Item Charges - Specification")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Item Charges - Specification';
                                RunObject = report "Item Charges - Specification";
                            }
                            action("Items Substitutions")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Item Substitutions';
                                RunObject = report "Item Substitutions";
                            }
                            action("Item/Vendors Catalog")
                            {
                                ApplicationArea = Suite, Basic;
                                Caption = 'Item/Vendor Catalog';
                                RunObject = report "Item/Vendor Catalog";
                            }
                        }
                        group("Inventory and Costing Reports")
                        {
                            Caption = 'Inventrory and Costing';
                            action("Adjust Cost - Item Entries")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Adjust Cost - Item Entries';
                                RunObject = report "Adjust Cost - Item Entries";
                            }
                            action("Adjust Item Costs/Prices")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Adjust Item Costs/Prices';
                                RunObject = report "Adjust Item Costs/Prices";
                            }
                            action("RInventory Availability")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory Availability';
                                RunObject = report "Inventory Availability";
                            }
                            action("RInventory - Cost Variance")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - Cost Variance';
                                RunObject = report "Inventory - Cost Variance";
                            }
                            action("RInventory - Inbound Transfer")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - Inbound Transfer';
                                RunObject = report "Inventory - Inbound Transfer";
                            }
                            action("RInventory - List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Inventory - List';
                                RunObject = report "Inventory - List";
                            }
                            action("Invt. Valuation - Cost Spec.")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Invt. Valuation - Cost Spec.';
                                RunObject = report "Invt. Valuation - Cost Spec.";
                            }
                            // action("Item Age Composition - Qty.")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Item Age Composition - Qty.';
                            //     RunObject = report "Item Age Composition - Qty.";
                            // }
                            action("Item Age Composition - Value")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Age Composition - Value';
                                RunObject = report "Item Age Composition - Value";
                            }
                            action("Item Expiration - Quantity")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Expiration - Quantity';
                                RunObject = report "Item Expiration - Quantity";
                            }
                            action("RItem Charges - Specification")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Charges - Specification';
                                RunObject = report "Item Charges - Specification";
                            }
                            action("Item Register - Quantity")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Register - Quantity';
                                RunObject = report "Item Register - Quantity";
                            }
                            action("Item Register - Value")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Item Register - Value';
                                RunObject = report "Item Register - Value";
                            }
                        }

                    }
                    group("Procurement Setup")
                    {
                        Caption = 'Setup';
                        // group("Planning Setup")
                        // {
                        //     Caption = 'Planning';
                        //     action("Salespeople/Purchasers")
                        //     {
                        //         ApplicationArea = Basic, Suite;
                        //         Caption = 'Salespeople/Purchasers';
                        //         RunObject = page "Salespersons/Purchasers";
                        //     }
                        //     action("Req. Worksheet Templates")
                        //     {
                        //         ApplicationArea = Basic, Suite;
                        //         Caption = 'Req. Worksheet Templates List';
                        //         RunObject = page "Req. Worksheet Template List";
                        //     }
                        // }
                        action("Units of Measure")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Units of Measure';
                            RunObject = page "Units of Measure";
                        }
                        group("Order Processing Setup")
                        {
                            Caption = 'Order Processing';
                            action("Standard Purchase Codes")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Standard Purchase Codes';
                                RunObject = page "Standard Purchase Codes";
                            }
                            action("Purchasing Codes")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchasing Codes';
                                RunObject = page "Purchasing Codes";
                            }
                            action("Shipment Methods")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Shipment Methods';
                                RunObject = page "Shipment Methods";
                            }
                            action("Return Reasons")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Return Reasons';
                                RunObject = page "Return Reasons";
                            }
                            // action("Report Selection - Purchase ")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Report Selection - Purchase ';
                            //     //RunObject = page "Report Selection - Purchase ";
                            // }
                        }
                        // group("Inventory and Costing Setup")
                        // {
                        //     Caption = 'Inventrory and Costing';

                        // action("Manufacturers")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Manufacturers';
                        //     RunObject = page "Manufacturers";
                        // }
                        // action("Product Groups")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Product Groups';
                        //     RunObject = page "Product Groups";
                        // }
                        // action("Nonstock Item Setup")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Nonstock Item Setup';
                        //     //RunObject = page "Nonstock Item Setup";
                        // }
                        // }
                    }
                }
            }


            group(Action16)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                action(Action17)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Assets),
                                        Recurring = const(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                // action("Fixed Assets Journals")
                // {
                //     ApplicationArea = FixedAssets;
                //     Caption = 'Fixed Assets Journals';
                //     RunObject = Page "FA Journal Batches";
                //     RunPageView = where(Recurring = const(false));
                //     ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                // }
                action("Calculate Depreciation")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation Custom';
                    RunObject = report "Calculate Depreciation Custom";

                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action("Fixed Asset Transfer List")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Transfer List';
                    RunObject = Page "Asset Transfer List";
                    ToolTip = 'This module facilitates Transfer of FA location and responsible employee';
                }
                action("Transferred Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Transferred Fixed Assets';
                    RunObject = Page "Asset Transfer List Effected";
                    ToolTip = 'View the list of fixed assets that have been transferred.';
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = where(Recurring = const(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }


            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Payment Voucher")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payment Voucher';
                    RunObject = Page "Posted Payment Vouchers List";
                    ToolTip = 'Open the list of posted payment vouchers.';
                }
                action("Posted Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Receipts';
                    RunObject = Page "Posted Receipt List";
                    ToolTip = 'Open the list of posted Receipts.';
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Posted Petty Cash Vouchers";
                    ToolTip = 'Open the list of posted Petty Cash.';
                }
                action("Posted Staff Claims")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Staff Claims';
                    RunObject = Page "Posted Staff Claims List";
                    ToolTip = 'Open the list of posted Staff Claims.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'Open the list of issued reminders.';
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'Open the list of issued finance charge memos.';
                }
                action("G/L Registers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View auditing details for all general ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Posted Bank Deposits")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Bank Deposits';
                    Image = PostedDeposit;
                    RunObject = codeunit "Open P. Bank Deposits L. Page";
                    ToolTip = 'View the posted deposit header, deposit header lines, deposit comments, and deposit dimensions.';
                }
                action("Cost Accounting Registers")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                    ToolTip = 'View auditing details for all cost accounting entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Cost Accounting Budget Registers")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
                    ToolTip = 'View auditing details for all cost accounting budget entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
            }
            group("Payroll Processing")
            {
                group("Payroll")
                {
                    Caption = 'Payroll processing';
                    action(PRsalaryListAll)
                    {
                        Caption = 'PR Salary List (All)';
                        RunObject = Page "PR Salary List (ALL)";
                        ApplicationArea = Basic, Suite;
                    }
                    // action(PRsalaryListCasual)
                    // {
                    //     Caption = 'PR Salary List Casual';
                    //     RunObject = Page "PrSalary List Casual";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Hr Employees - Active")
                    {
                        Caption = 'Hr Employees - Active';
                        RunObject = Page "HR Employee List - Active";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Board Pay Card")
                    // {
                    //     Caption = 'Board Pay Card';
                    //     RunObject = Page "prBoard employee list";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("PR Bank Summary")
                    {
                        Caption = 'PR Bank Summary';
                        RunObject = Page "PR Bank Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    group("Payroll Transactions")
                    {
                        Caption = 'Reports and Analysis';
                        action("PR Period Transactions")
                        {
                            RunObject = Page "prPeriodTransaction List";
                            ApplicationArea = Basic, Suite;
                        }
                        action("PR Employer Transactions")
                        {
                            RunObject = Page "prEmployer Deductions";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Employee P9 Info")
                        {
                            Caption = 'Employee p9 Info';
                            RunObject = page "Employee P9 Info";
                            ApplicationArea = Basic, Suite;
                        }
                        action(p9)
                        {
                            Caption = 'P9';
                            RunObject = report P9;
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    // group("PR Reports and Analysis")
                    // {
                    //     Caption = 'Reports and Analysis';
                    // action("PR NHIF")
                    // {
                    //     Caption = 'PR NHIF report';
                    //     RunObject = report "pr NHIF";
                    //     ApplicationArea = Basic, Suite;
                    // }


                    // action(P10)
                    // {
                    //     Caption = 'P10';
                    //     RunObject = report P10;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action(P10A)
                    // {
                    //     Caption = 'P10A';
                    //     RunObject = report P10A;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR Payroll Summary")
                    // {
                    //     Caption = 'PR Payroll Summary';
                    //     //RunObject = report "PR Payroll Summary";
                    //     RunObject = report "Payroll Summary";

                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Payroll Summary")
                    // {
                    //     Caption = 'PR Payroll Summary';
                    //     RunObject = report "PR Payroll Summary";
                    //     //RunObject = report "Payroll Summary";

                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR Other PR Customers (Listing)")
                    // {
                    //     Caption = 'PR Other PR Customers (Listing)';
                    //     RunObject = report "PR Other PR Customers (Listin)";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR BankSummary")
                    // {
                    //     Caption = 'PR Bank summary';
                    //     RunObject = report "PR Bank Summary";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR Email Individual payslip")
                    // {
                    //     Caption = 'PR E-Mail Individual Payslip';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = report "PR E-Mail Individual Payslip";
                    //     Visible = false;
                    // }
                    // action("PR NSSF NEW")
                    // {
                    //     Caption = 'PRE NSSF';
                    //     RunObject = report "PR NSSF NEW";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // }
                }
                group(PayrollSetup)
                {
                    Caption = 'Payroll Setup';
                    action("prPayroll Period")
                    {
                        Caption = 'Payroll Periods';
                        RunObject = page "PR Payroll Periods";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Employee Posting Groups")
                    {
                        Caption = 'Employee Posting Groups';
                        RunObject = page "prEmployee Posting Group";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Transaction Codes")
                    {
                        Caption = 'Transaction Codes';
                        RunObject = page "PR Transaction Codes List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Rates & Ceilings")
                    {
                        Caption = 'Rates and Ceilings';
                        RunObject = page "PR Rates & Ceilings";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("PR Bank Accounts")
                    // {
                    //     Caption = 'Bank Accounts';
                    //     RunObject = page "PR Bank Accounts";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR Bank Branches")
                    // {
                    //     Caption = 'Bank Branches';
                    //     RunObject = page "PR Bank Branches";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("prP.A.Y.E Setup")
                    {
                        Caption = 'prP.A.Y.E Setup';
                        RunObject = page "prP.A.Y.E Setup";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Salary Grades List")
                    {
                        Caption = 'Salary Grades List';
                        RunObject = page "Salary Grades List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prNSSF List")
                    {
                        Caption = 'prNSSF List';
                        RunObject = page "prNSSF List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prNHIF SetUp")
                    {
                        Caption = 'prNHIF SetUp';
                        RunObject = page "prNHIF SetUp";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("prBoard Earning")
                    // {
                    //     Caption = 'prBoard Earning';
                    //     RunObject = page "prBoard Earning";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PrCasual Payroll Setup")
                    // {
                    //     Caption = 'PrCasual Payroll Setup';
                    //     RunObject = page "PrCasual Payroll Setup";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("PR Employee Allowances List")
                    {
                        Caption = 'PR Employee Allowances List';
                        RunObject = page "PR Employee Allowances List";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Status Change Permssion.")
                    // {
                    //     Caption = 'Status Change Permssion.';
                    //     RunObject = page "Status Change Permssion.";
                    //     ApplicationArea = Basic, Suite;
                    // }

                }
                group(PeriodicActivities)
                {
                    Caption = 'Payroll Posting & journals';

                    action("Salary List")
                    {

                        RunObject = page "Salary Lists";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Transfer Net Pay To Fosa")
                    {
                        Caption = 'Transfer Net Pay To Fosa';
                        RunObject = report "Transfer Net Pay To Fosa";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Transfer To Journal Bills")
                    {
                        Caption = 'PR Transfer To Journal Bills';
                        RunObject = report "PR Transfer To Journal Bills";
                        ApplicationArea = Basic, Suite;
                    }
                    action("General Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Journal';
                        Image = Journal;
                        RunObject = page "General Journal";
                        RunPageView = where("Journal Template Name" = Const('GENERAL'), "Journal Batch Name" = Const('SALARIES'));

                    }

                }
                group("PR Reports")
                {
                    Caption = 'Reports';
                    action("Master Payroll Report")
                    {
                        RunObject = Report "Master Payroll Report";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Master Payroll Report';
                    }
                    // action("Pr Variance Report")
                    // {
                    //     Caption = 'PR Monthly Variance';
                    //     RunObject = report "Pr Variance Report";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Payroll Variance Report")
                    // {
                    //     Caption = 'Payroll Monthly Variance Report (BPAY & NPAY & GPAY)';
                    //     RunObject = report "Payroll Variance Report";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    action("prPaye Report")
                    {
                        Caption = 'PAYE Schedule';
                        RunObject = report "prPaye Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR NSSF")
                    {
                        Caption = 'PR NSSF Tier I Report';
                        RunObject = report prNSSF;
                        ApplicationArea = Basic, Suite;
                    }
                    action("NSSF Tier II")
                    {
                        Caption = 'NSSF Tier II Report';
                        RunObject = report "NSSF Tier II";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Deductions With Employer Contr")
                    {
                        RunObject = Report "Deductions With Employer Contr";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deductions With Employer Contributions';
                    }
                    action("prDeductions Report")
                    {
                        Caption = 'Deductions Report';
                        RunObject = report "prDeductions Report";
                        ApplicationArea = Basic, Suite;
                    }

                    action("prAllowances Report")
                    {
                        Caption = 'prAllowances Report';
                        RunObject = report "prAllowances Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action(prGrossNetPay)
                    {
                        Caption = 'Gross & NetPay Report';
                        ApplicationArea = Basic, Suite;
                        RunObject = report prGrossNetPay;
                    }
                    // action("prGrossNetPay FxedTC")
                    // {
                    //     Caption = 'prGrossNetPay FxedTC';
                    //     RunObject = report "prGrossNetPay FxedTC";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("prPayrollSummary-List")
                    // {
                    //     Caption = 'prPayrollSummary-List';
                    //     RunObject = report "prPayrollSummary-List";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Staff Member Balances")
                    // {
                    //     Caption = 'Staff Member Balances';
                    //     RunObject = report "Staff Member Balances";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Pension Summary")
                    // {
                    //     Caption = 'Pension Summary';
                    //     RunObject = report "Pension Summary";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("prBank Payments")
                    // {
                    //     Caption = 'prBank Payments';
                    //     RunObject = report "prBank Payments";
                    //     ApplicationArea = Basic, Suite;
                    //     visible = false;
                    // }
                    action("PrAllowances Summary")
                    {
                        Caption = 'PrAllowances Summary';
                        RunObject = report "PrAllowances Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action(" PrDeductions Summary")
                    {
                        Caption = 'PrDeductions Summary';
                        RunObject = report "PrDeductions Summary";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Helb Report")
                    {
                        Caption = 'Helb Report';
                        RunObject = report "Helb Report";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("PR iTax Report")
                    // {
                    //     Caption = 'PR iTax Report';
                    //     RunObject = report "PR iTax Report";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("PR Company Totals")
                    {
                        Caption = 'PR Company Summary';
                        RunObject = report "PR Company Totals";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Fringe Benefit")
                    // {

                    //     RunObject = report "Fringe Benefit";
                    //     ApplicationArea = Basic, Suite;
                    // }


                    // action("prP9A-test  new")
                    // {
                    //     Caption = 'prP9A-test  new';
                    //     RunObject = report "prP9A-test  new";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("PR Company FixedTC Totals")
                    // {
                    //     Caption = 'PR Company FixedTC Totals';
                    //     //RunObject = report "PR Company FixedTC Totals";
                    //     ApplicationArea = Basic, Suite;
                    //     visible = False;
                    // }
                    // action("Detailed Payroll Transactions")
                    // {
                    //     Caption = 'Detailed Payroll Transactions';
                    //     RunObject = report "Detailed Payroll Transactions";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Staff Allowance  P9")
                    // {
                    //     Caption = 'Staff Allowance  P9';
                    //     // RunObject = report "Staff Allowance  P9";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Overtime Hours Worked1")
                    // {
                    //     Caption = 'Overtime Hours Worked1';
                    //     RunObject = report "Overtime Hours Worked1";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // group("PR Admin")
                    // {
                    //     Caption = 'Administration';
                    //     action("Update Mismatched HR Loans")
                    //     {
                    //         Caption = 'Update Mismatched HR Loans';
                    //         RunObject = report "Update Mismatched HR Loans";
                    //         ApplicationArea = Basic, Suite;
                    //     }
                    // }
                    // }
                }
                group(TaxReturns)
                {
                    Caption = 'Tax Returns';
                    group("Repo and analysis")
                    {
                        Caption = 'Reports And analysis';

                        action("P 9")
                        {
                            Caption = 'P9';
                            RunObject = report P9;
                            ApplicationArea = Basic, Suite;
                        }

                    }
                }
            }
            Group("Reports ")
            {
                group(Members)
                {
                    // action("EX member Creditors")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'EX member Creditors';
                    //     RunObject = report "EX member Creditors";
                    // }
                    // action("Deposit Arrears Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Deposit Arrears Report';
                    //     RunObject = report "Deposits Arreas Report";
                    // }
                    action("Checkoff Receipt Report ")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Checkoff Receipts Report';
                        RunObject = report "Posted Checkoff Receipts";
                    }
                    // action("Checkoff Report ")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Checkoff Receipt Report Report';
                    //     RunObject = report "Posted Receipt Checkoff";
                    // }


                    // action("Member Listing Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Member Listing - List';
                    //     RunObject = page "Member Listing Report";

                    // }

                    action("Savings Accounts List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts List';
                        RunObject = Report "Savings Accounts Register";
                    }
                    // action("Over Recoveries Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Over Recoveries Report';
                    //     RunObject = Report "Over Recoveries Report";
                    // }
                    // action("Amounts Received - Deposits")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Amounts Received - Deposits';
                    //     RunObject = Report "Amounts Received - Deposit A/c";
                    // }
                    // action("Amount Received Summary - Deposits")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Amount Received Summary - Deposits';
                    //     RunObject = Report "Amounts Received Summary - Dep";
                    // }
                    // action("Withdrawal Notices")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Withdrawal Notices';
                    //     RunObject = report "Withdrawal Notices";
                    //     Visible = false;
                    // }
                    // action("pending Member Withdawal Notice")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Pending Member Withdrawal Notice';
                    //     RunObject = report "Pending Withdrawal Notices";
                    //     Visible = false;
                    // }
                    // group("Deposit Listing")
                    // {
                    //     action("Proces Deposit Listing")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = report "Deposit Listing Report";
                    //     }
                    //     action("View Deposit Listing")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "Deposit Listing List";
                    //     }
                    //     action("Deposit Listing Errors")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "Bulk Processing Errors List";
                    //         RunPageView = where(Process = filter("Deposit Listing"));
                    //     }
                    // }
                    action("Dormant Deposit Listing Report ")
                    {
                        ApplicationArea = all;
                        Caption = 'Dormant Deposit Listing Report';
                        RunObject = report "Dormant Deposit Listing Report";
                    }
                    action("Deposit Monthly Receipt Report ")
                    {
                        ApplicationArea = all;
                        Caption = 'Monthly Savings Receipts Report';
                        RunObject = report "Monthly Receipt ";
                    }
                    action("Member Share Capital Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Share Capital Report';
                        RunObject = report "Share Capital Register";
                    }
                    action("Summary Unallocated A/C")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Unallocated Fund Report';
                        RunObject = report "Summary Unlocated A/C";
                    }
                    action("Loan Monthly Receipt Report ")
                    {
                        ApplicationArea = all;
                        Caption = ' Loans Monthly Receipt Report';
                        RunObject = report " Loan Monthly Receipt ";
                    }
                    action("Over/Under Recovery Loans Rep")
                    {
                        ApplicationArea = all;
                        Caption = 'Over/Under Recovery Loans Report';
                        RunObject = report "Over/Under Recovery Loans Rep";
                    }
                    // action("BOSA Arreas Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Employer Shares and Loans Report';
                    //     RunObject = report "Employer Shares and Loans";
                    // }
                    // action("Combined BOSA Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Combined BOSA Report';
                    //     RunObject = report "BOSA Combined Report";
                    // }
                    // // action("Global Variance Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Monthly Global Deposit Variance Report';
                    //     RunObject = report "Global Variance Report";
                    // }
                    // action("Loan Arreas Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Loan Arreas Report';
                    //     //RunObject = report "Loan Arrears Report";
                    //     RunObject = report "Loan Arrears Report - Finance";
                    // }
                    // action("Duplicate Deductions Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Duplicate Deduction Report';
                    //     RunObject = report "Duplicate Deduction Report";
                    // }
                    // action(Shares_BBF_Risk_Analysis)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Shares, BBF & Risk Analysis';
                    //     RunObject = report "Shares, BBF & Risk Analysis";
                    // }
                    group("Shares Transfer Report")
                    {
                        action("Share Capital Transfer Report ")
                        {
                            ApplicationArea = all;
                            Caption = 'Share Capital Transfer Report';
                            RunObject = report "Share Capital Transfer";
                        }
                        action("Share Capital Transfer Fee Report ")
                        {
                            ApplicationArea = all;
                            Caption = 'Share Capital Transfer Fee Report';
                            RunObject = report "Share Capital fee";
                        }
                        // action("Transferred Share Capital Certificate")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Transferred Share Capital Certificate';
                        //     RunObject = report "Transferred Share Capital Cert";
                        // }
                    }
                    group("Variations ")
                    {
                        action("Loan Variation")
                        {
                            ApplicationArea = all;
                            Caption = 'Loan Variation Report';
                            RunObject = report "Loan Variation Report";
                        }
                        action("Share Variation")
                        {
                            ApplicationArea = all;
                            Caption = 'Share Variation Report';
                            RunObject = report "Share Variation";
                        }
                    }
                    group("Dividends ")
                    {
                        action("Dividend Slip")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividend Slip Report';
                            RunObject = report "Dividend Slip B64";
                        }
                    }
                    // group("BBF/RISK Report")
                    // {
                    //     action("BBF/Risk/entrance fees/Depo")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'BBF/RISK/ENTRANCE/DEPOSIT Summary';
                    //         RunObject = report "BBF/Risk/entrance fees/Depo";
                    //     }
                    //     action("BBF/RISK Report ")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'BBF/RISK UnPaid Report';
                    //         RunObject = report "Sinkfund not paid";
                    //     }
                    //     action("Deceased Member Report ")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Deceased Member Report';
                    //         RunObject = report "Sink Fund Notice Report";
                    //     }
                    //     // action("BBFSummary Report ")
                    //     // {
                    //     //     ApplicationArea = all;
                    //     //     Caption = 'BBF/RISK/ENTRANCE/DEPOSIT Falloff Summary';
                    //     //     RunObject = report "BBF_Risk_entr fees_Dep Falloff";
                    //     // }
                    //     action("BBF/RISK/ENTRANCE/DEPOSIT Falloff")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'BBF/RISK/ENTRANCE/DEPOSIT Falloff';
                    //         RunObject = report "BBF_Risk_entr fees_Dep Falloff";
                    //     }
                    //     action("Unrecov. Reg Fee/BBF/Risk/Shar")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Unrecoveres Reg Fee/BBF/Risk/Share';
                    //         RunObject = report "Unrecov. Reg Fee/BBF/Risk/Shar";
                    //     }
                    //     action("DepositRiskBBF Falloff")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Deposit Risk BBF Falloff';
                    //         RunObject = report "BOSA Accounts Fall-Off Report";
                    //     }
                    //     action("Over/Under Recoveries Loans Report")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Over/Under Recoveries Loans Report';
                    //         RunObject = report "Over/Under Recovery Loans Rep";
                    //     }
                    // }
                    action("Bulk Account Refunds Report")
                    {
                        ApplicationArea = All;
                        RunObject = report "Bulk Account Refunds Report";
                    }
                    // action("Accounts Fall Off")
                    // {
                    //     ApplicationArea = All;
                    //     RunObject = report "Accounts FallOff Report";
                    //     Visible = false;
                    // }
                    // 
                    action("Staff Daily Transactions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Staff Daily Transactions";
                    }
                    // action("Prorata Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = report "Prorata Report";
                    // }
                    // action("Deposit Fall Off Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'BOSA Savings Fall Off';
                    //     RunObject = report "Deposit Fall Off";
                    // }


                }

                group("Loans")
                {
                    Caption = 'Loans';
                    // action("Loans Collection Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Collection Report';
                    //     RunObject = report "Loan Collection Report";

                    // }
                    action("Amounts Received - Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Amounts Received - Loans';
                        RunObject = report "Amounts Received - Loans";
                    }
                    // action("Amounts Receiv Summary - Loans")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Amounts Receiv Summary - Loans';
                    //     RunObject = report "Amounts Receiv Summary - Loans";
                    // }
                    action("Posted Loans Checkoff")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Loans Checkoff Report';
                        RunObject = report "Posted Loans Checkoff";
                    }

                    // action("Loans Interest Register")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Posted Loans Register';
                    //     RunObject = report "Loan Interest  Register";
                    //     Visible = false;
                    // }
                    // group("Loan Listing")
                    // {

                    //     action("Loan Listing Report List")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "Loan Listing Report List";
                    //     }

                    //     action("Loan Listing Errors")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "Bulk Processing Errors List";
                    //         RunPageView = where(Process = filter("Loan Listing"));
                    //     }
                    // }
                    action("Loan Register ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Register Report';
                        RunObject = report "Loan Register";

                    }
                    action("Unit Loan Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'LUnit Lan Summary';
                        RunObject = report "Unit Loan Summary Register";

                    }
                    action("Product Loan Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Loan Summary';
                        RunObject = report "Product Loan Summary Register";

                    }
                    action("Restructured Loans Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Restructured loans Report';
                        RunObject = report "Restructured Loans report";
                    }
                    action("Loans Cleared Early")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cleared Loans Report';
                        RunObject = report "Loans Cleared Early";
                    }
                    action("Commercial Loans Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Commercial Loan buyoffs";
                        Caption = 'Commercial Buyoffs Report';
                    }
                    action("Posted Loans Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Loans Report';
                        RunObject = report "Posted Loans Report";
                    }
                    action("Reversed Loans")
                    {
                        ApplicationArea = all;
                        Caption = 'Reversed Loans Report';
                        RunObject = report "Reversed Loans Report";
                    }
                    action("Loans Underway Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Loans Underway Report';
                        RunObject = report "Loans Underway Report";
                    }


                    action("Loan Ageing")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Defaulter Ageing';
                        RunObject = report "Loan Ageing Report";
                    }


                    action("Loan Variance Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Variance Report";
                    }

                    action("Recovery Loans")
                    {
                        ApplicationArea = all;
                        Caption = 'Recovery Loans Report';
                        RunObject = report "Recovery Fresh Loans";
                    }
                    action("Recovery Fresh Loans Summary")
                    {
                        ApplicationArea = all;
                        Caption = 'Recovery Fresh Loans Summary';
                        RunObject = report "Recovery Fresh Loans Summary";
                    }
                    action("Loan Recovery Per Month")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loans Recovery Per Month";
                    }

                    action("Loan Approved Schedule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Approved Schedule';
                        RunObject = report "Loan Approved Schedule";

                    }

                    action("Loan Guarantors Reports")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Guarantors Report';
                        RunObject = report "Loan Guarators Reports";

                    }
                    action("Loan Guaranteed")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Guaranteed';
                        RunObject = report "Loan Guaranteed";
                    }
                    action("Loan Repayment Dues")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Dues';
                        RunObject = report "Loan Repayment Dues";

                    }
                    // action("Loan Bills")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loan Bills';
                    //     RunObject = report "Loan Bills";
                    //     Visible = false;
                    // }
                    action("SASRA Loan Categorization")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'SASRA Loan Categorization';
                        RunObject = report "SASRA Loan Categorization";
                    }

                    action("Loan Provisioning Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Provisioning Summary';
                        // RunObject = report "Loans Provisioning Summary";
                        RunObject = report "Risk Provisioning";
                    }
                    action("Loan Product Summaries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Product Summaries';
                        RunObject = report "Loan Product Summaries";
                    }
                    action("Savings & Loans Listings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings & Loans Listings';
                        RunObject = report "Savings & Loans Listings";

                    }


                    // action("Loans Datasheet Employer")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Datasheet Employer';
                    //     RunObject = report "Loans Datasheet Employer";

                    // }
                    // action("Savings Datasheet Employer")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Savings Datasheet Employer';
                    //     RunObject = report "Savings Datasheet Employer";

                    // }
                    action("Loan Registered By Category")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Registered By Category';
                        RunObject = report "Premier Loan Report";

                    }
                    action("Loans issued Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Issued Summary';
                        RunObject = report "Loan Issued Summary";

                    }

                    action("Position on Borrowers in Sacco")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Position on Borrowers in Sacco';
                        RunObject = report "Position on Borrowers in Sacco";

                    }
                    action("Loan Reschedule report")
                    {
                        ApplicationArea = all;
                        Caption = 'Resheduled Loans Report';
                        RunObject = report "Rescheduled Loans report";

                    }

                    action("Total Lianbilities Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Total Liabilities Report';
                        RunObject = report "Total Liabilities report";
                    }
                    action("Member Deposits")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Deposits Report';
                        RunObject = report "Member Deposits Report";

                    }
                    action("JV Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'JV Report';
                        RunObject = report "JV Report";
                        Visible = false;

                    }
                    action("Delegate Loans Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Delegate Loans Register';
                        RunObject = report "Delegate Loans Register";

                    }
                    action("Delegate Loans Register New")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Delegate Loans Register New';
                        RunObject = report "Delegates Loan Register New";
                        Visible = false;

                    }
                    action("Loan Repayment Dues Summaries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Dues Summaries';
                        RunObject = report "Loan Repayment Dues Summaries";

                    }
                    action("Loans Recovery Per Month")
                    {
                        ApplicationArea = all;
                        Caption = 'Loans Recovery per Month';
                        RunObject = report "Loans Recovery Per Month";
                    }

                    action("Montlhy Bill Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Montlhy Bill Summary';
                        RunObject = report "Monthly Bill Summary";
                        Visible = false;

                    }
                    action("Member Loan Statement")
                    {
                        ApplicationArea = all;
                        Caption = 'Member loan Statement';
                        RunObject = report "Member Loan Statement II";
                    }

                    action("Loans Movement Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Movement Report';
                        RunObject = report "Loans Movement Report";

                    }

                    action("Tenor Loan Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenor Loan Register';
                        RunObject = report "Tenor Loan Register";

                    }
                    action("Asset Finance Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Asset Finance Loans';
                        RunObject = report "Asset Finance Loans";

                    }

                    action("Batch Loan Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Batch Loan Register';
                        RunObject = report "Batch Loan Register";

                    }

                    action("Loan Movement Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Movement Summary';
                        RunObject = report "Loan Movement Summary";

                    }
                    action("Loan Movement Report II")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Movement Report II';
                        RunObject = report "Loans Movement Report II";
                        Visible = false;
                    }
                    action("Direct Debit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Debit Report';
                        RunObject = report "Direct Debit Report";
                        Visible = false;

                    }

                    action("Generate CRB Data")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate CRB Data';
                        RunObject = report "Generate CRB Data";
                        Visible = false;
                    }
                    action("Loan  Recovery Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Recovery Report';
                        RunObject = report "Loan Attachment";
                    }
                    // action("Past Due Accounts")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = report "Past Due Accounts";
                    // }

                    // action("DMU Case Forwarded")
                    // {
                    //     ApplicationArea = All;
                    //     RunObject = report "DMU Case Forwarded";
                    // }
                    action("Loan Variation Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Variation Report";
                    }
                    action("Savings Variation Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Share Variation";
                    }
                    action("Loan Attachment Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Attachment";
                    }
                    action("NPL Per Product")
                    {
                        ApplicationArea = all;
                        RunObject = report "NPL Per Product";
                    }

                }
                group(Financials)
                {
                    group("Bank Reconciliation")
                    {
                        action("Bank Reconciliations")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Reconciliation';
                            RunObject = page "Bank Acc. Reconciliation List";
                        }
                        action("Unreconcilled Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Unreconcilled Transactions';
                            RunObject = report "Unreconcilled Transactions";
                        }
                        action("Bank Transactions Ageing")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Transactions Ageing Report';
                            RunObject = report "Bank Transactions Aging report";
                        }
                        action("Bank Reconciliation Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Reconciliation Report';
                            RunObject = report "Bank Reconcilliation report";
                        }
                        action(BankDetailedTrialBalance)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Detailed Trial Balance';
                            RunObject = report "Custom Bank Detail Trial Bal.";
                        }
                        action(Bank_Trial_Balance)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Detailed Trial Balance Summary';
                            RunObject = report "Bank Acc. - Detail Trial Bal.";
                        }
                    }
                    group("Employer Account Management")
                    {
                        action("Employer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employer Account Management';
                            RunObject = page "Customer List";
                            RunPageView = where("Account Type" = const(Employer));
                        }

                        action("Customer Summary Aging")
                        {
                            ApplicationArea = All;
                            RunObject = report "Customer Summary Aging Report";
                        }
                        action("Comparison Employer Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employer Revenue Collection Report';
                            RunObject = report "Revenue Collection Report";
                        }
                        action("EmployerStatement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Customer Statement';
                            RunObject = report "Employer Statement";
                        }
                        action("Employer Allocation Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employer Allocation Report';
                            RunObject = report "Employer Allocation Report";
                        }

                        action("Employer Email Status")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employer Listing Report';
                            RunObject = report "Employer Email Status";
                        }
                    }
                    // group("Chart of Accounts ")
                    // {
                    //     action("Chart of Accounts")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'General Ledger';
                    //         RunObject = page "Chart of Accounts";
                    //     }
                    // }
                    group("Fixed Asset ")
                    {
                        action("Fixed Asset")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Asset';
                            RunObject = page "Fixed Asset List";
                        }

                    }
                    group(Sasra)
                    {
                        action("Sasra Deposit Return")
                        {
                            ApplicationArea = all;
                            Caption = 'Sasra Deposit Return';
                            RunObject = report "SASRA Deposit Return";
                        }
                        action("Insider Lending Sasra")
                        {
                            ApplicationArea = all;
                            RunObject = report "Insider Lending Report";
                        }
                        action("Sectoral Lending")
                        {
                            ApplicationArea = all;
                            RunObject = report "Sectoral Lending";
                        }
                        action("Sasra Summary Ration")
                        {
                            ApplicationArea = all;
                            Caption = 'Sasra Summary Ratio';
                            RunObject = report "Sectoral Classification";
                        }
                        action("Loans Defaulter Aging - SASRA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Defaulter Aging - SASRA';
                            RunObject = report "Loans Defaulter Aging - SASRA";
                        }
                        action("Customer Summary Aging Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Customer Summary Aging Report';
                            RunObject = report "Customer Summary Aging Report";
                        }
                        action("Risk Provisioning")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Risk Provisioning";
                        }
                    }
                    group("G/L Budget")
                    {
                        action("G/L Budget Names")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Budget';
                            RunObject = page "G/L Budget Names";
                        }
                    }

                    group("AML Auditing")
                    {
                        action("Anti-Money Laundering Report")
                        {
                            ApplicationArea = all;
                            Caption = 'AML Report Transactions';
                            RunObject = report "AML Report Transactions";
                        }
                    }
                }
                group("Payment/ Receipts")
                {
                    Caption = 'Payments/Receipts';
                    action("Loan Checkoff Advice")
                    {
                        ApplicationArea = all;
                        Caption = 'Checkoff Advice';
                        RunObject = report "Checkoff Advice - Loans";
                    }
                    action(" Checkoff Advice Variance")
                    {
                        ApplicationArea = all;
                        Caption = 'Checkoff Advice Variance';
                        RunObject = report "Checkoff Advice Variance";
                    }

                    group("Payment Voucher")
                    {
                        action("Payment Voucher List Report")
                        {
                            ApplicationArea = all;
                            Caption = 'Payment Voucher';
                            RunObject = report "Payment Voucher";
                        }
                        action("Staff Claim Report")
                        {
                            ApplicationArea = all;
                            Caption = 'Staff Claim ';
                            RunObject = report "Staff Claims Voucher";

                        }
                        action("Petty Cash Report")
                        {
                            ApplicationArea = all;
                            Caption = 'Petty Cash  ';
                            RunObject = report "Petty Cash";

                        }

                        action("Claimed Branch Report")
                        {
                            ApplicationArea = all;
                            Caption = 'Claimed Branch Allocation Report';
                            RunObject = report "Claimed Branch Allocation";
                        }
                        action("UNClaimed Branch Report")
                        {
                            ApplicationArea = all;
                            Caption = 'UnClaimed Branch Allocation Report';
                            RunObject = report "UnClaimed Branch Allocation";
                        }

                        action("Uncleared Cheque Report")
                        {
                            ApplicationArea = all;

                            RunObject = report "ClearedUncleared Cheques";


                        }
                        action("Cheque Allocation Report")
                        {
                            ApplicationArea = all;

                            RunObject = report "ReceiptLIne Report";

                        }





                        action("cleared Cheque Report")
                        {
                            ApplicationArea = all;

                            RunObject = report ClearedCheques;

                        }




                    }
                }
                group(Delegate)
                {
                    action("Delegate Claim Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Delegate Claim Report';
                        RunObject = report "Delegate Claims II";
                    }
                    action("Unpaid Delegate Claims")
                    {
                        ApplicationArea = all;
                        Caption = 'Unpaid Delegate Claims';
                        RunObject = report "Unpaid Delegate Claims";
                    }
                    // action("Delegate Posting Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Delegate Posting Report';
                    //     RunObject = report "Delegates Payments Reports";
                    // }
                    action("Delegate Slip")
                    {
                        ApplicationArea = all;
                        Caption = 'Delegate Slip Report';
                        RunObject = report "Delegate PaySlip";
                    }
                }
                group(Imprest)
                {
                    action("Staff Imprests Report")
                    {
                        // General report for handling multiple scenarios of imprests ie posted, status, etc
                        ApplicationArea = all;
                        Caption = 'Staff Imprests Requests Report';
                        RunObject = report "Staff Imprests Report";
                    }
                    action("Imprest Aging Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Imprest Aging Report';
                        RunObject = report "Unsurrendered Imprest Aging";
                    }
                    action("Imprest Surrender")
                    {
                        // General report for surrendered imprests
                        ApplicationArea = all;
                        Caption = 'Imprest Surrender Report';
                        RunObject = report "Imprest Surrender Report";
                    }

                    action("Surrendered Imprests Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Surrendered Imprests Report';
                        RunObject = report "Surrendered Imprests Report";//uncomment
                    }
                    action("Un-Surrendered Imprests")
                    {
                        ApplicationArea = all;
                        Caption = 'Un-Surrendered Imprests';
                        RunObject = report "Un-Surrendered Imprests";
                    }
                    action(UnsurrenderedImprestsAging)
                    {
                        ApplicationArea = all;
                        caption = 'Un-surrendered Imprests Aging';
                        RunObject = report "Unsurrendered Imprest Aging";
                    }
                    action(StaffClaims)
                    {
                        ApplicationArea = all;
                        Caption = 'Staff Claims';
                        RunObject = report "Staff Claims Report";
                    }

                }
                group("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    action("Fixed Asset Register")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Asset Register';
                        RunObject = report "Fixed Asset Register";
                        //ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("Fixed Assets By Category")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets By Category';
                        RunObject = report "Fixed Assets By Category";
                        ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("Fixed Assets register additions audit trail")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Register Audit Trail';
                        RunObject = report "FA reg addition audit trail";
                        ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("Assets Marked For Disposal")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Assets Marked For Disposal';
                        RunObject = report "Assets Marked For Disposal";
                        ToolTip = 'View the list of fixed assets that are marked for disposal.';
                    }

                    action("Adjusted Fixed assets")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Adjusted Fixed Assets';
                        RunObject = report "Adjusted Fixed Assets";
                        ToolTip = 'View the list of fixed assets that are Adjusted Fixed Assets';
                    }
                    // action("Deprceation audit trail")
                    // {
                    //     ApplicationArea = FixedAssets;
                    //     Caption = 'Disposal audit trail';
                    //     RunObject = report "Depreciation FA audit trail";
                    //     ToolTip = 'View the list of Disposal FA audit trail .';
                    // }
                    action("Disposal Audit Trail")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Disposal Audit Trail';
                        RunObject = report "Disposal FA audit trail";
                        ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("Disposed Fixed Assets")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Disposed Fixed Assets';
                        RunObject = report "Disposed Fixed Assets";
                        ToolTip = 'View the list of fixed assets that are Dispoded';
                    }
                    // action("Transfered Fixed Assets")
                    // {
                    //     ApplicationArea = FixedAssets;
                    //     Caption = 'Transfered Fixed Assets';
                    //     RunObject = report "Transfered Fixed Assets";
                    //     ToolTip = 'View the list of fixed assets that are Transfered';
                    // }
                    action("Fixed Asset Transfer Report")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Asset Transfer Report';
                        RunObject = report "Fixed Asset Transfer Report";
                        ToolTip = 'View the list of fixed assets that are Transfered';
                    }
                    action("FA Period Depreciation Report")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Period Depreciation Report';
                        RunObject = report "FA Period Depreciation Report";
                        ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("52186871FA Analysis")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Asset Analysis';
                        RunObject = page "52186871FA Analysis";
                        ToolTip = 'Analyze the list of fixed assets.';
                    }
                    action("FA Forecast Depreciation")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Forecast Depreciation';
                        RunObject = report "FA Forecast Depreciation";
                    }

                    action("Fully depreciated Assets")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fully depreciated Assets';
                        RunObject = report "Fully depreciated Assets";
                        ToolTip = 'View the list of fixed assets that are currently in use.';
                    }
                    action("Insurance Valuation Report")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Valuation Report';
                        RunObject = report "Insurance Valuation Report";

                    }
                    action("Insurance Contracts")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Contracts';
                        RunObject = Report "Insurance Contracts";
                    }
                    action("Fixed Asset Movement Schedule")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Asset Movement Schedule';
                        RunObject = report "Fixed Asset Movement Schedule";

                    }
                    // action("Movement Schedule")
                    // {
                    //     ApplicationArea = FixedAssets;
                    //     Caption = 'Movement Schedule';
                    //     RunObject = report "MovementScheduleII";
                    // }
                    action("FA Depreciation History")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Depreciation History';
                        RunObject = report "FA Depreciation History";
                    }
                    action("Leased Assets & Obligations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Leased Assets & Obligations';
                        RunObject = report "Leased Assets & Obligations";
                    }
                    action("Right To Use Assets")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Right To Use Assets';
                        RunObject = report "Right To Use Assets";
                    }
                    action("Reccurring FA Journals Report")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'ROU Report';
                        RunObject = report "Reccurring FA Journals Report";
                    }
                }
                group("G/L Reports.")
                {
                    Caption = 'G/L Reports';
                    action("&G/L Trial Balance.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&G/L Trial Balance';
                        Image = "Report";
                        RunObject = Report "Trial Balance Custom";
                        ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                    }
                    action("&Bank Detail Trial Balance.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Bank Detail Trial Balance';
                        Image = "Report";
                        RunObject = Report "Bank Acc. - Detail Trial Bal.";
                        ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                    }
                    action("&Account Schedule.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Account Schedule';
                        Image = "Report";
                        RunObject = Report "Account Schedule";
                        ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                    }
                    action("Bu&dget.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bu&dget';
                        Image = "Report";
                        RunObject = Report Budget;
                        ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                    }
                    action("Trial Bala&nce/Budget.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Bala&nce/Budget';
                        Image = "Report";
                        RunObject = Report "Trial Balance/Budget";
                        ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                    }
                    action("Trial Balance by &Period.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance by &Period';
                        Image = "Report";
                        RunObject = Report "Trial Balance by Period";
                        ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                    }
                    action("&Fiscal Year Balance.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Fiscal Year Balance';
                        Image = "Report";
                        RunObject = Report "Fiscal Year Balance";
                        ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                    }
                    action("Balance Comp. - Prev. Y&ear.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Comp. - Prev. Y&ear';
                        Image = "Report";
                        RunObject = Report "Balance Comp. - Prev. Year";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                    }
                    action("&Closing Trial Balance.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Closing Trial Balance';
                        Image = "Report";
                        RunObject = Report "Closing Trial Balance";
                        ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                    }
                    action("Dimensions - Total.")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions - Total';
                        Image = "Report";
                        RunObject = Report "Dimensions - Total";
                        ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                    }
                }
                action("Control Summary Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Control Summary Report';
                    Image = "Report";
                    RunObject = Report "Control Summary Report";

                }
            }
            group(EmployeeSelfService)
            {
                Caption = 'Employee Self Service';
                // action("Employee Fixed Asset Transfer List")
                // {
                //     ApplicationArea = FixedAssets;
                //     Caption = 'Fixed Assets Transfer List';
                //     RunObject = Page "Asset Transfer List";
                //     ToolTip = 'This module facilitates Transfer of FA location and responsible employee';
                // }
                // action("Employee Transferred Fixed Assets")
                // {
                //     ApplicationArea = FixedAssets;
                //     Caption = 'Transferred Fixed Assets';
                //     RunObject = Page "Asset Transfer List Effected";
                //     ToolTip = 'View the list of fixed assets that have been transferred.';
                // }
                // action(StaffWelfare)
                // {
                //     Caption = 'Staff Welfare Claim';
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Staff Welfare List";
                // }
                action(LeaveApplication1)
                {
                    Caption = 'Employee Leave Application';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Leave Applications List1";

                }
                action("Training Need Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Need Request';
                    RunObject = page "HR Training Need Request List";
                }
                // HIDDEN: OLD 360 APPRAISAL - USE "MY ASSIGNED TARGETS" INSTEAD
                // action("Appraisal")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'My Appraisals';
                //     RunObject = page "HR 360 Appraisals List - TS1";
                // }
                action("My Individual Appraisals ESS")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Individual Appraisals';
                    RunObject = page "My Individual Appraisals List";
                    ToolTip = 'View and manage my performance appraisals';
                }
                action("My Team Appraisals ESS")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Team Appraisals (Supervisor)';
                    RunObject = page "Supervisor Appraisals List";
                    ToolTip = 'View and review appraisals for employees I supervise';
                }
                action("My Assigned Targets ESS")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Assigned Targets';
                    RunObject = page "My Assigned Targets";
                    ToolTip = 'View targets assigned to me by my HOD';
                }
                action("My Department Targets (HOD)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Department Targets (HOD)';
                    RunObject = page "HRHOD Department Targets";
                    ToolTip = 'Set and manage targets for my department (HOD only)';
                }
                action("My CEO Goal Assignments ESS")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My CEO Goal Assignments';
                    RunObject = page "My CEO Goal Assignments";
                    ToolTip = 'View and acknowledge CEO goals assigned to me as HOD';
                }
                // action("Overtime Claim List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Overtime';
                //     RunObject = page "Overtime Claim List";
                // }

                action("System Rights Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System Rights Requisition';
                    RunObject = page "Permission Requisition Card";
                }

                // action("Loan Application")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Apply Staff Loan';
                //     RunObject = page "Self Loan Application List";
                // }
                // action(ImprestsList)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Imprest Application List';
                //     RunObject = page "Imprest List";
                //     //RunObject = page "Imprest Application List S/S."; //TODO
                //     RunPageView = where(Status = filter(pending));
                // }
                action("Store Requisition1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Store Requisition';
                    RunObject = Page "Store Requisitions List";


                }
                action("Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Payslip';
                    RunObject = report "Self Service Slip";
                }
                // group("Employee Requests")
                // {

                // group("File Requests.")
                // {
                //     action("Request File")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Request File';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(open));
                //     }
                //     action("File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Files Requested';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(requested));
                //     }
                //     action("Closed File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Closed Files Requests.';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(closed));
                //     }
                //     action("File List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'File Tracker List';
                //         RunObject = page "File Tracker List";
                //         RunPageView = where(Status = filter(<> archived));
                //     }
                // }
                // group("Conf & Meeting Room Booking")
                // {
                //     Caption = 'Conf & Meeting Room Aplications';
                //     action("Conference Hall & Meeting Rooms")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Open Bookings';
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         RunPageLink = Status = CONST(Open);
                //     }
                //     action("Pending Conf & Meeting Room Booking")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Pending Bookings';
                //         //RunObject = page "Pending Conf & Meeting - List";
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         RunPageLink = Status = CONST(Pending);
                //     }
                //     action("Approved Conf & Meeting Room Booking")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Approved Booking';
                //         //RunObject = page "Approved Conf & Meeting - List";
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         RunPageLink = Status = CONST(Approved);
                //     }
                //     action("Invoicing for Hire of Halls")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Invoicing for Hire of Halls';
                //         //RunObject = page "Approved Conf & Meeting - List";
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         //RunPageLink = Status = CONST(Approved);
                //         RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                //     }
                //     action("Rejected Conf & Meeting Room Booking")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Declined Bookings';
                //         //RunObject = page "Rejected Conf & Meeting - List";
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         RunPageLink = Status = CONST(Rejected);
                //     }
                //     action("Closed Conf & Meeting Room Booking")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Closed Bookings';
                //         //RunObject = page "Closed Conf & Meeting - List";
                //         RunObject = page "MNS Conf & Meetings Appl List";
                //         RunPageLink = "Status of the Booking" = CONST(Closed);
                //     }
                // }
                // Group("Motor Vehicle Requests")
                // {
                //     Caption = 'Motor Vehicle Requests';
                //     action("Vehicle Request Application")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Open Vehicle Requests';
                //         RunObject = page "Motor Vehicle Request List";
                //         RunPageLink = Status = CONST(Open);
                //     }
                //     action("Pending Vehicle Requests")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Pending Vehicle Requests';
                //         RunObject = page "Motor Vehicle Request List";
                //         RunPageLink = Status = CONST(Pending);
                //     }
                //     action("Approved Vehicle Requests")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Approved Vehicle Requests';
                //         //RunObject = page "Approved Vehicle Req - List";
                //         RunObject = page "Motor Vehicle Request List";
                //         RunpageLink = Status = CONST(Approved);
                //     }
                //     action("Deffered Vehicle Requests")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Deffered Vehicle Requests';
                //         RunObject = page "Deffered Vehicle Req - List";
                //     }
                //     action("Reject Vehicle Requests")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Rejected Vehicle Requests';
                //         //RunObject = page "Rejected Vehicle Req - List";
                //         RunObject = page "Motor Vehicle Request List";
                //         RunPageLink = Status = CONST(Rejected);
                //     }
                //     action("Closed Vehicle Request")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Closed Vehicle Request';
                //         //RunObject = page "Closed Vehicle Req - List";
                //         RunObject = page "Motor Vehicle Request List";
                //         RunPageLink = Status = CONST(Closed);
                //     }
                //     action("Reallocated Requests")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Reallocated Requests';
                //         RunObject = page "Motor Vehicle Request List";
                //         RunPageLink = Reallocated = CONST(TRUE);
                //     }
                // }
                // group("Key Requests")
                // {
                //     action("Open Keys Request")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Office Keys Request';
                //         RunObject = page "Key Request List";
                //         RunPageLink = Status = CONST(Open);
                //     }
                //     action("Pending Keys Request")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Pending Requests';
                //         RunObject = page "Key Request List";
                //         RunPageLink = Status = CONST(Pending);
                //     }
                //     action("Approved Keys Request")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Approved Requests';
                //         RunObject = page "Key Request List";
                //         RunPageLink = Status = CONST(Approved);
                //     }
                //     action("Rejected Keys Request")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Rejected Key Request';
                //         RunObject = page "Key Request List";
                //         RunPageLink = Status = CONST(Rejected);
                //     }
                //     action("Closed Keys Request")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Closed Key Requests';
                //         RunObject = page "Key Request List";
                //         RunPageLink = "Key Status" = CONST(Received);
                //     }
                // }
                // Group("Parking Allocation")
                // {
                //     action("Parking Space List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Open Parking Application';
                //         RunObject = page "Parking Space List";
                //         RunPageLink = Status = CONST(Open);
                //     }
                //     action("Pending Parking Space Application")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Pending Parking Allocation';
                //         //RunObject = page "Approved Parking - List";
                //         RunObject = page "Parking Space List";
                //         RunPageLink = Status = CONST(Pending);
                //     }
                //     action("Approved Parking Space Application")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Approved Parking Allocation';
                //         //RunObject = page "Approved Parking - List";
                //         RunObject = page "Parking Space List";
                //         RunPageLink = Status = CONST(Approved);
                //     }
                //     action("Rejected Parking Space Application")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Rejected Parking Allocation';
                //         //RunObject = page "Rejected Parking Space - List";
                //         RunObject = page "Parking Space List";
                //         RunPageLink = Status = CONST(Rejected);
                //     }
                // }
                //}

            }
            group(Setup)
            {
                action("Budgetary Control Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budgetary Control Setup';
                    RunObject = page "Budgetary Control Setup";
                }
                action("Fixed Asset Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixed Asset Setup';
                    RunObject = page "Fixed Asset Setup";
                }
                action("Dividend SetUp")
                {
                    ApplicationArea = all;
                    Caption = 'Dividend Setup';
                    RunObject = page "Dividend Setup";
                }
                group("Delegates Setups")
                {
                    action("Delegates Tarrifs")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Delegate Tariffs";
                    }
                    action("Meeting Types List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Meeting Types List";
                    }

                }
                group("BBF Setups")
                {
                    // action("BBF Entitlement")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'BBF Entitlement List';
                    //     RunObject = Page "BBF Entitlement List";
                    // }
                    action("Relationship Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Relationship Types';
                        RunObject = Page "Relationship Types";
                    }
                }
                action("Loan Categorization")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Categorization codes';
                    RunObject = Page "Loan Categorization";
                }
                action("Digit Custodian Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Digit Custodian Setup";
                }
                action("Products Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Product Factory List";
                }
                action("Transaction Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Types List';
                    RunObject = page "Transaction Types List";
                }
                group("Fixed Deposit Types Setup")
                {
                    action("Fixed Deposit Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Fixed Deposit Type List";
                    }
                }
            }

        }

        area(creation)
        {
            action("Members Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members Portal';
                RunObject = codeunit "Members Portal Link";
            }
            action("Customer Management Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Management Portal';
                RunObject = codeunit "Customer Management Portal Url";
            }
            action("Bulk SMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bulk SMS List';
                RunObject = page "Bulk SMS Header List";
            }
            // action("NCBA Pension List")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'NCBA Pension List';
            //     RunObject = page "NCBA Pension List";
            // }

        }
        area(processing)
        {

            group(Reports)
            {
                Caption = 'Reports';
                // group("Financial Statements")
                // {
                //Caption = 'Financial Statements';
                //Image = ReferenceData;
                action("Balance Sheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                    RunObject = Report "Balance Sheet";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                }
                action("Income Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                    RunObject = Report "Income Statement";
                    ToolTip = 'View a report that shows your company''s income and expenses.';
                }
                action("Statement of Cash Flows")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement of Cash Flows';
                    Image = "Report";
                    RunObject = Report "Statement of Cashflows";
                    ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                }
                action("Statement of Retained Earnings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement of Retained Earnings';
                    Image = "Report";
                    RunObject = Report "Retained Earnings Statement";
                    ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                }

            }



        }
    }
}



profile "Finance Role Centers"
{
    Caption = 'Finance Role Center';
    RoleCenter = "Finance Role Center";
    ProfileDescription = 'Finance Role Center';
}
