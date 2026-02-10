// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185632 "Credit Statement"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Credit Statement.rdl';

//     dataset
//     {
//         dataitem(CreditAccounts; "Agent Applications")
//         {
//             // DataItemTableView = sorting("No.");
//             // RequestFilterFields = "No.";
//             column(ReportForNavId_37; 37)
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
//             // column(No_CreditAccounts; CreditAccounts."No.")
//             // {
//             // }
//             // column(Name_CreditAccounts; CreditAccounts.Name)
//             // {
//             // }
//             // column(MemberNo_CreditAccounts; CreditAccounts."Member No.")
//             // {
//             // }
//             // column(CreditAccountName; CreditAccountName)
//             // {
//             // }
//             // column(IDNumber_CreditAccounts; CreditAccounts."ID No.")
//             // {
//             // }
//             // column(MobilePhoneNo_CreditAccounts; CreditAccounts."Mobile Phone No")
//             // {
//             // }
//             // column(County_CreditAccounts; CreditAccounts.County)
//             // {
//             // }
//             // column(EMail_CreditAccounts; CreditAccounts."E-Mail")
//             // {
//             // }
//             // column(PayrollStaffNo_CreditAccounts; CreditAccounts."Payroll/Staff No.")
//             // {
//             // }
//             column(BalanceBF; BalanceBF)
//             {
//             }
//             dataitem(Loans; Loans)
//             {
//                 // DataItemLink = "Loan Account" = field("No.");
//                 DataItemTableView = sorting("Loan No.");
//                 RequestFilterFields = "Loan No.";
//                 column(ReportForNavId_3; 3)
//                 {
//                 }
//                 column(LoanNo_Loans; Loans."Loan No.")
//                 {
//                 }
//                 column(ApplicationDate_Loans; Loans."Application Date")
//                 {
//                 }
//                 column(MemberNo_Loans; Loans."Member No.")
//                 {
//                 }
//                 column(LoanAccount_Loans; Loans."Loan Account")
//                 {
//                 }
//                 column(MemberName_Loans; Loans."Member Name")
//                 {
//                 }
//                 column(LoanProductType_Loans; Loans."Loan Product Type")
//                 {
//                 }
//                 column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
//                 {
//                 }
//                 column(LoansCategorySASRA; Loans."Loans Category-SASRA")
//                 {
//                 }
//                 column(OutstandingBills_Loans; Loans."Outstanding Bills")
//                 {
//                 }
//                 column(ApprovedAmount_Loans; Loans."Approved Amount")
//                 {
//                 }
//                 dataitem(CreditLedgerEntry; UnknownTable52185733)
//                 {
//                     DataItemLink = "Loan No" = field("Loan No."), "Customer No." = field("Loan Account"), "Posting Date" = field("Date Filter");
//                     DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code") where("Transaction Type" = filter(Loan | Repayment | "Interest Due" | "Interest Paid"));
//                     column(ReportForNavId_32; 32)
//                     {
//                     }
//                     column(MemberNo_CreditLedgerEntry; CreditLedgerEntry."Member No.")
//                     {
//                     }
//                     column(CustomerNo_CreditLedgerEntry; CreditLedgerEntry."Customer No.")
//                     {
//                     }
//                     column(PostingDate_CreditLedgerEntry; CreditLedgerEntry."Posting Date")
//                     {
//                     }
//                     column(DocumentNo_CreditLedgerEntry; CreditLedgerEntry."Document No.")
//                     {
//                     }
//                     column(Prepayment_CreditLedgerEntry; CreditLedgerEntry.Prepayment)
//                     {
//                     }
//                     column(Description_CreditLedgerEntry; CreditLedgerEntry.Description)
//                     {
//                     }
//                     column(DebitAmountLCY_CreditLedgerEntry; CreditLedgerEntry."Debit Amount (LCY)")
//                     {
//                     }
//                     column(CreditAmountLCY_CreditLedgerEntry; CreditLedgerEntry."Credit Amount (LCY)")
//                     {
//                     }
//                     column(SASRAStatus; CreditLedgerEntry."SASRA Loan Status")
//                     {
//                     }
//                     column(AmountLCY_CreditLedgerEntry; CreditLedgerEntry."Amount (LCY)")
//                     {
//                     }
//                     column(LoanNo_CreditLedgerEntry; CreditLedgerEntry."Loan No")
//                     {
//                     }
//                     column(CreditAccountRunBal; CreditAccountRunBal)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         CreditAccountRunBal += CreditLedgerEntry."Amount (LCY)" + BalanceBF;
//                     end;

//                     trigger OnPostDataItem()
//                     begin
//                         CreditAccountRunBal := 0;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         CreditAccountRunBal := 0;
//                         if StartDate = 0D then
// ;
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if StartDate = 0D then StartDate := 20900101D;
//                     if EndDate = 0D then EndDate := Today;

//                     Loans.SetRange(Loans."Date Filter", 0D, CalcDate('-1D', StartDate));
//                     Loans.CalcFields(Loans."Outstanding Interest", Loans."Outstanding Bills", Loans."Outstanding Balance");
//                     BalanceBF := Loans."Outstanding Balance";

//                     Loans.SetRange(Loans."Date Filter", StartDate, EndDate);
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if StartDate = 0D then StartDate := 20900101D;
//                 if EndDate = 0D then EndDate := Today;
//                 CreditAccounts.SetRange(CreditAccounts."Date Filter", 0D, CalcDate('-1D', StartDate));
//                 CreditAccounts.CalcFields(CreditAccounts."Balance (LCY)");
//                 BalanceBF := CreditAccounts."Balance (LCY)";
//                 CreditAccounts.SetRange(CreditAccounts."Date Filter", StartDate, EndDate);

//                 CreditAccountName := CreditAccounts."Product Type" + '-' + CreditAccounts."Product Name";
//             end;

//             trigger OnPreDataItem()
//             begin
//                 CreditAccountName := '';
//                 BalanceBF := 0;
//             end;
//         }
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
//                     }
//                     field("End Date:"; EndDate)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                 }
//             }
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
//         BalanceBF: Decimal;
//         CreditAccountName: Text;
//         CreditAccountRunBal: Decimal;
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         StartDate: Date;
//         EndDate: Date;
// }

