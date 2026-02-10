// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52187093 "Tenant Revenue Collection"
// {

//     DefaultLayout = RDLC;
//     ApplicationArea = Basic, suite;
//     UsageCategory = ReportsAndAnalysis;
//     Caption = 'Tenant Revenue Collection';
//     RDLCLayout = './bc-kenpipe-2024/Layout/Tenant Revenue Collection.rdl';

//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             RequestFilterFields = "No.";
//             DataItemTableView = where("Account Type" = const(Tenant));

//             column(CompanyInformation_Name; CompanyInformation.Name)
//             {
//             }
//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CommunicationOnline; CommunicationOnline)
//             {
//             }
//             column(No_; "No.")
//             {
//             }
//             column(Name; Name)
//             {

//             }
//             column(EndDate; EndDate)
//             {

//             }
//             column(StartDate; StartDate)
//             {

//             }

//             dataitem("Sales Invoice Header"; "Sales Invoice Header")
//             {
//                 DataItemLink = "Bill-to Customer No." = field("No.");
//                 column(Amount; Amount)
//                 {
//                 }
//             }
//             dataitem("Receipts Header"; "Receipts Header")
//             {
//                 DataItemLink = "Customer No." = field("No.");
//                 DataItemTableView = where(Posted = filter(true));
//                 column(PostingDate_SavingsLedgerEntry; "Posting Date")
//                 {
//                 }
//                 column(DocumentNo_SavingsLedgerEntry; "Document No.")
//                 {
//                 }
//                 column(Description_SavingsLedgerEntry; Description)
//                 {
//                 }
//                 column(Document_Date; "Document Date")
//                 {
//                 }
//                 column(DebitAmountLCY_SavingsLedgerEntry; "Debit Amount (LCY)")
//                 {
//                 }
//                 column(CreditAmountLCY_SavingsLedgerEntry; "Credit Amount (LCY)")
//                 {
//                 }
//                 column(AmountLCY_SavingsLedgerEntry; "Amount (LCY)")
//                 {
//                 }
//                 column(LineBalance; LineBalance) { }
//                 column(SOpeningBal; SOpeningBal) { }

//                 trigger OnPreDataItem()
//                 begin
//                     LSavingsLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
//                 end;

//                 trigger OnAfterGetRecord()
//                 begin

//                     SavingsLedgerEntry.Reset();
//                     SavingsLedgerEntry.SetRange("Customer No.", SavingsAccounts."No.");
//                     SavingsLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
//                     if SavingsLedgerEntry.FindFirst() then begin
//                         repeat
//                             LineBalance := LineBalance + (SavingsLedgerEntry."Credit Amount" - SavingsLedgerEntry."Debit Amount")
//                                                     until SavingsLedgerEntry.Next() = 0;
//                         SOpeningBal := LineBalance;
//                     end;

//                     LineBalance := LineBalance + (LSavingsLedgerEntry."Credit Amount" - LSavingsLedgerEntry."Debit Amount");
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 AcctBal := 0;
//                 LineBalance := 0;
//                 SOpeningBal := 0;
//                 SavingsAccounts.calcfields("Balance (LCY)");
//                 AcctBal := SavingsAccounts."Balance (LCY)";
//             end;

//         }
//         dataitem(CreditAccounts; Loans)
//         {
//             DataItemLink = "Member No." = field("No.");
//             DataItemTableView = where(Posted = filter(true));

//             column(CreditAccNo; CreditAccounts."Loan No.") { }
//             column(CreditAccountName; CreditAccounts."Loan Product Type Name") { }
//             column(LoanOutstandingBal; LoanOutstandingBal) { }

//             dataitem(CreditLedgerEntry; "Credit Ledger Entry")
//             {
//                 DataItemLink = "Loan No" = field("Loan No.");
//                 DataItemTableView = where("Posting Date" = filter(<> 0D));
//                 column(CreditAmountLCY; "Amount (LCY)")
//                 {
//                 }
//                 column(CreditAmountcreditledger; "Credit Amount (LCY)")
//                 {
//                 }
//                 column(CreditDocumentNo; "Document No.")
//                 {
//                 }
//                 column(CreditPostingDate; "Posting Date")
//                 {
//                 }
//                 column(Credit_Document_Date; "Document Date")
//                 {
//                 }
//                 column(CreditDebitAmountLCY; "Debit Amount (LCY)")
//                 {
//                 }
//                 column(Transaction_Type; "Transaction Type") { }
//                 column(CreditTotals; CreditTotals) { }
//                 column(PrevOutstanding; PrevOutstanding) { }
//                 column(Loan_No; "Loan No") { }

//                 trigger OnAfterGetRecord()
//                 begin
//                     NCreditLedgerEntry.Reset();
//                     NCreditLedgerEntry.SetRange("Loan No", CreditAccounts."Loan No.");
//                     NCreditLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
//                     if NCreditLedgerEntry.FindFirst() then begin
//                         repeat
//                             CreditTotals := CreditTotals + (NCreditLedgerEntry."Debit Amount (LCY)" - NCreditLedgerEntry."Credit Amount (LCY)")
//                                                    until NCreditLedgerEntry.Next() = 0;
//                         PrevOutstanding := CreditTotals;
//                     end;

//                     CreditTotals := CreditTotals + (CreditLedgerEntry."Debit Amount (LCY)" - CreditLedgerEntry."Credit Amount (LCY)");
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     CreditLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 LoanOutstandingBal := 0;
//                 PrevOutstanding := 0;
//                 CreditTotals := 0;
//                 CreditAccounts.CalcFields("Outstanding Interest", "Outstanding Balance");
//                 LoanOutstandingBal := CreditAccounts."Outstanding Balance" + CreditAccounts."Outstanding Interest";

//                 // TotalLoanPaid
//             end;

//             trigger OnPreDataItem()
//             begin
//                 //CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
//                 // CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
//                 // CreditAccounts.SetFilter("Outstanding Interest", '>%1', 0, '|');
//             end;
//         }


//             trigger OnAfterGetRecord()
//     begin
//         AllSavingsAmount := 0;
//         AllCreditsAmount := 0;
//         AllLoanBalances := 0;
//         AllInterests := 0;
//         DepoContrib := 0;
//         ShareContrib := 0;
//         ChrismassContrib := 0;
//         // Savings
//         SavingsAccounts.Reset();
//         SavingsAccounts.setrange(SavingsAccounts."Member No.", Members."No.");
//         //SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3', "Product Category"::Dividend, "Product Category"::"Registration Fee", "Product Category"::"Insurance Contribution");

//         if SavingsAccounts.FindFirst() then begin
//             repeat
//                 SavingsAccounts.calcfields("Balance (LCY)");
//                 if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then
//                     DepoContrib := SavingsAccounts."Balance (LCY)" else
//                     if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Share Capital" then
//                         ShareContrib := SavingsAccounts."Balance (LCY)" else
//                         if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account" then
//                             ChrismassContrib := SavingsAccounts."Balance (LCY)";
//             //Message('%1', SavingsAccounts."Balance (LCY)");                   
//             // repeat
//             //     SavingsAccounts.CalcFields("Balance (LCY)");
//             //     AllSavingsAmount := AllSavingsAmount + SavingsAccounts."Balance (LCY)";
//             until SavingsAccounts.Next() = 0;
//             //Message('%1', AllSavingsAmount);
//         end else
//             AllSavingsAmount := 0;
//         // credits principal outstanding balances
//         CreditAccounts.Reset();
//         CreditAccounts.SetRange(CreditAccounts."Member No.", Members."No.");
//         if CreditAccounts.FindFirst() then begin
//             repeat
//                 CreditAccounts.CalcFields("Outstanding Balance");
//                 AllCreditsAmount := AllCreditsAmount + CreditAccounts."Outstanding Balance";
//             until CreditAccounts.Next() = 0;
//         end else
//             AllCreditsAmount := 0;
//         // Interests 
//         CreditAccounts.Reset();
//         CreditAccounts.SetRange(CreditAccounts."Member No.", Members."No.");
//         if CreditAccounts.FindFirst() then begin
//             repeat
//                 CreditAccounts.CalcFields("Outstanding Interest");
//                 AllInterests := AllInterests + CreditAccounts."Outstanding Interest";
//             until CreditAccounts.Next() = 0;
//         end
//         else
//             AllInterests := 0;
//         AllLoanBalances := AllInterests + AllCreditsAmount;
//     end;

// }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group("Date Filter")
//                 {
//                     field("Start Date:"; StartDate)
//                     {
//                         ApplicationArea = Basic;
//                         ShowMandatory = True;
//                     }
//                     field("End Date:"; EndDate)
//                     {
//                         ApplicationArea = Basic;
//                         ShowMandatory = true;
//                     }
//                 }
//             }
//         }


//     }


//     labels
//     {
//     }

//     trigger OnPreReport()

//     begin
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + ' | Website: ' + CompanyInformation."Home Page";

//         if (StartDate = 0D) or (EndDate = 0D) then begin
//             StartDate := 19900101D;
//             EndDate := Today;
//         end;


//         // Initialize all variables 

//         LineBalance := 0;

//     end;

//     trigger OnPostReport()
//     begin

//     end;

//     var
//         BalanceBF: Decimal;
//         BalanceBFL: Decimal;
//         SavingsAccountName: Text;
//         SavingsAccountRunBal: Decimal;
//         CreditAccountRunBal: Decimal;
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         StartDate: Date;
//         EndDate: Date;
//         CumBalanceL: Decimal;
//         LineBalance: Decimal;
//         OutstandinBalances: Decimal;
//         SavingsTotal: Decimal;
//         CreditTotals: Decimal;
//         AllSavingsAmount: Decimal;
//         SavingsLedgerEntry: record "Savings Ledger Entry";
//         AmountLCY_SavingsLedgerEntry: Decimal;
//         CreditAmountLCY_SavingsLedgerEntry: Decimal;
//         DebitAmountLCY_SavingsLedgerEntry: Decimal;
//         Description_SavingsLedgerEntry: Text;
//         DocumentNo_SavingsLedgerEntry: Text;
//         PostingDate_SavingsLedgerEntry: Date;
//         NCreditLedgerEntry: Record "Credit Ledger Entry";
//         SOpeningBal: Decimal;
//         PrevOutstanding: Decimal;
//         AllCreditsAmount: Decimal;
//         AllInterests: Decimal;
//         AllLoanBalances: Decimal;
//         DepoContrib: Decimal;
//         ShareContrib: Decimal;
//         ChrismassContrib: Decimal;
//         LoanOutstandingBal: Decimal;
//         AcctBal: Decimal;
//     //TotalLoanPaid:deci

// }
