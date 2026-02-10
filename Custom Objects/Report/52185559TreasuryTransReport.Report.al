// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185559 "Treasury Deposits Withdrawals"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Treasury Deposits Withdrawals Report.rdl';
//     UsageCategory = ReportsAndAnalysis;

//     dataset
//     {
//         dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
//         {
//             RequestFilterFields = "Posting Date", "Bank Account No.";
//             column(Bank_Account_No_; "Bank Account No.")
//             {

//             }
//             column(Posting_Date; "Posting Date")
//             {

//             }
//             column(Document_No_; "Document No.")
//             {

//             }
//             column(Description; Description)
//             {

//             }
//             column(Debit_Amount; "Debit Amount")
//             {

//             }
//             column(Credit_Amount; "Credit Amount")
//             {

//             }
//             column(RunningBalance; CalcRunningAccBalance.GetBankAccBalance("Bank Account Ledger Entry"))
//             {
//             }
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
//             column(AccountName; AccountName)
//             {

//             }
//             column(AccountNo; AccountNo)
//             {

//             }
//             column(TransType; TransType)
//             {

//             }

//             trigger OnAfterGetRecord()
//             begin
//                 CashierTrans.Reset();
//                 CashierTrans.SetRange(No, "Bank Account Ledger Entry"."Document No.");
//                 if CashierTrans.FindFirst() then begin
//                     AccountNo := CashierTrans."Account No";
//                     AccountName := CashierTrans."Account Name";
//                     TransType := CashierTrans.Type;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 // "Bank Account Ledger Entry".SetFilter("Posting Date", '%1', "Bank Account Ledger Entry"."Posting Date");
//                 // "Bank Account Ledger Entry".SetFilter("Date Filter", DateFilter);
//             end;

//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//         }

//         actions
//         {
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
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
//         BankAcc: Record "Bank Account";
//         CashierTrans: Record "Cashier Transactions";
//         AccountNo: Code[100];
//         AccountName: Text[100];
//         TransType: Enum "Fosa Transaction Types";

// }
