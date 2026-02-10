// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185907 "Member Statement-6MONTHS MAIL"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Member Statement-6MONTHS MAIL.rdl';

//     dataset
//     {
//         dataitem(Members; UnknownTable52185700)
//         {
//             RequestFilterFields = "No.", "Date Filter";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(CompanyInformation_Name; CompanyInformation.Name)
//             {
//             }
//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyAddress; CompanyInformation."Address 2")
//             {
//             }
//             column(CompanyTelephone; CompanyInformation."Phone No.")
//             {
//             }
//             column(CommunicationOnline; CompanyInformation."Home Page")
//             {
//             }
//             column(CompanyInformationEMail; CompanyInformation."E-Mail")
//             {
//             }
//             column(No_Members; Members."No.")
//             {
//             }
//             column(Name_Members; Members.Name)
//             {
//             }
//             column(IDNumber_Members; Members."Primary Identification")
//             {
//             }
//             column(MobilePhoneNo_Members; Members."Phone No.")
//             {
//             }
//             column(County_Members; Members.County)
//             {
//             }
//             column(EMail_Members; Members."E-Mail")
//             {
//             }
//             column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
//             {
//             }
//             column(HomeAddress_Members; Members."Home Address")
//             {
//             }
//             column(EmployerCode_Members; Members."Employer Code")
//             {
//             }
//             column(ShowSavings; ShowSavings)
//             {
//             }
//             column(ShowLoans; ShowLoans)
//             {
//             }
//             column(ShowAll; ShowAll)
//             {
//             }
//             column(ObjEmpName; ObjEmpName)
//             {
//             }
//             column(TotalLoanBal; TotalLoanBal)
//             {
//             }
//             column(TotalDep; TotalDep)
//             {
//             }
//             dataitem(SharesCapitalAccount; "Savings Accounts")
//             {
//                 DataItemLink = "Member No." = field("No.");
//                 DataItemTableView = sorting("No.") where("Product Category" = const("Share Capital"));
//                 column(ReportForNavId_97; 97)
//                 {
//                 }
//                 column(No_SharesCapitalAccount; SharesCapitalAccount."No.")
//                 {
//                 }
//                 column(Name_SharesCapitalAccount; SharesCapitalAccount.Name)
//                 {
//                 }
//                 column(MemberNo_SharesCapitalAccount; SharesCapitalAccount."Member No.")
//                 {
//                 }
//                 column(ProductCategory_SharesCapitalAccount; SharesCapitalAccount."Product Category")
//                 {
//                 }
//                 column(ShareCapBalanceBF; ShareCapBalanceBF)
//                 {
//                 }
//                 column(SharesAccountName; SharesAccountName)
//                 {
//                 }
//                 dataitem(SavingsLedgerSharesCapital; UnknownTable52185732)
//                 {
//                     DataItemLink = "Customer No." = field("No.");
//                     DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code.") where(Reversed = const(No));
//                     column(ReportForNavId_102; 102)
//                     {
//                     }
//                     column(AmountLCY_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Amount (LCY)")
//                     {
//                     }
//                     column(Amount_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital.Amount)
//                     {
//                     }
//                     column(CustomerNo_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Customer No.")
//                     {
//                     }
//                     column(PostingDate_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Posting Date")
//                     {
//                     }
//                     column(DocumentType_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Document Type")
//                     {
//                     }
//                     column(DocumentNo_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Document No.")
//                     {
//                     }
//                     column(Description_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital.Description)
//                     {
//                     }
//                     column(ShareCapContribution; ShareCapContribution)
//                     {
//                     }
//                     column(OpenBalSharesCap; OpenBalSharesCap)
//                     {
//                     }
//                     column(ShareCapAccountRunBal; ShareCapAccountRunBal)
//                     {
//                     }
//                     column(ClosingBalSharesCap; ClosingBalSharesCap)
//                     {
//                     }
//                     column(RunningBalSharesCap; RunningBalSharesCap)
//                     {
//                     }
//                     column(CreditAmount_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Credit Amount")
//                     {
//                     }
//                     column(DebitAmount_SavingsLedgerSharesCapital; SavingsLedgerSharesCapital."Debit Amount")
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         ShareCapContribution := SavingsLedgerSharesCapital."Amount (LCY)" * -1;
//                         ShareCapAccountRunBal += ShareCapContribution;
//                         ClosingBalSharesCap := ShareCapAccountRunBal;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         OpenBalSharesCap := ShareCapBalanceBF;
//                         ShareCapAccountRunBal := ShareCapBalanceBF;

//                         //SavingsLedgerSharesCapital.SETRANGE("Posting Date",StartDate,EndDate);
//                         //SavingsLedgerSharesCapital.SETRANGE("Posting Date",StatementDate,StartDate);
//                     end;
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     SharesCapitalAccount.SetRange("Date Filter", 0D, CalcDate('-1D', 20160101D));
//                     SharesCapitalAccount.CalcFields("Balance (LCY)");
//                     ShareCapBalanceBF := "Balance (LCY)";

//                     SharesAccountName := "Product Type" + '-' + "Product Name";
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     ShareCapBalanceBF := 0;
//                     SharesAccountName := '';
//                 end;
//             }
//             dataitem(SavingsAccounts; "Savings Accounts")
//             {
//                 DataItemLink = "Member No." = field("No.");
//                 DataItemTableView = sorting("No.") where("Product Category" = const("Deposit Contribution"));
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(No_SavingsAccounts; SavingsAccounts."No.")
//                 {
//                 }
//                 column(Name_SavingsAccounts; SavingsAccounts.Name)
//                 {
//                 }
//                 column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
//                 {
//                 }
//                 column(SavingsAccountName; SavingsAccountName)
//                 {
//                 }
//                 column(BalanceBF; BalanceBF)
//                 {
//                 }
//                 column(ProductCategory_SavingsAccounts; SavingsAccounts."Product Category")
//                 {
//                 }
//                 column(OpenBalSavingsBF; OpenBalSavingsBF)
//                 {
//                 }
//                 dataitem(SavingsLedgerEntry; UnknownTable52185732)
//                 {
//                     DataItemLink = "Customer No." = field("No.");
//                     DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code.") where(Reversed = const(No));
//                     column(ReportForNavId_3; 3)
//                     {
//                     }
//                     column(MemberNo_SavingsLedgerEntry; SavingsLedgerEntry."Member No.")
//                     {
//                     }
//                     column(CustomerNo_SavingsLedgerEntry; SavingsLedgerEntry."Customer No.")
//                     {
//                     }
//                     column(PostingDate_SavingsLedgerEntry; SavingsLedgerEntry."Posting Date")
//                     {
//                     }
//                     column(DocumentNo_SavingsLedgerEntry; SavingsLedgerEntry."Document No.")
//                     {
//                     }
//                     column(Description_SavingsLedgerEntry; SavingsLedgerEntry.Description)
//                     {
//                     }
//                     column(DebitAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Debit Amount (LCY)")
//                     {
//                     }
//                     column(CreditAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Credit Amount (LCY)")
//                     {
//                     }
//                     column(AmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Amount (LCY)")
//                     {
//                     }
//                     column(Contribution; Contribution)
//                     {
//                     }
//                     column(SavingsAccountRunBal; SavingsAccountRunBal)
//                     {
//                     }
//                     column(CreditIntAmt; CreditIntAmt)
//                     {
//                     }
//                     column(OpenBalSavings; OpenBalSavings)
//                     {
//                     }
//                     column(ClosingBalSavings; ClosingBalSavings)
//                     {
//                     }
//                     column(RunningBalSavings; RunningBalSavings)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         Contribution := SavingsLedgerEntry."Amount (LCY)" * -1;
//                         SavingsAccountRunBal += Contribution;
//                         ClosingBalSavings := SavingsAccountRunBal;
//                     end;

//                     trigger OnPostDataItem()
//                     begin

//                         CreditAccountName := '';
//                         BalanceBF := 0;
//                     end;

//                     trigger OnPreDataItem()
//                     begin

//                         OpenBalSavings := BalanceBF;
//                         SavingsAccountRunBal := BalanceBF;

//                         //SavingsLedgerEntry.SETRANGE("Posting Date",StartDate,EndDate);
//                         SavingsLedgerEntry.SetRange("Posting Date", StatementDate, StartDate);
//                     end;
//                 }

//                 trigger OnAfterGetRecord()
//                 begin

//                     SavingsAccounts.SetFilter(SavingsAccounts."Date Filter", '..%1', CalcDate('-1D', StatementDate));
//                     SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
//                     BalanceBF := SavingsAccounts."Balance (LCY)";

//                     SavingsAccountName := SavingsAccounts."Product Type" + '-' + SavingsAccounts."Product Name";
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SavingsAccountName := '';
//                     BalanceBF := 0;
//                 end;
//             }
//             dataitem(Loans; Loans)
//             {
//                 DataItemLink = "Member No." = field("No.");
//                 DataItemTableView = where("Total Loan Balance" = filter(> 0));
//                 column(ReportForNavId_49; 49)
//                 {
//                 }
//                 column(ExpectedDateofCompletion_Loans; Format(CompletionDate))
//                 {
//                 }
//                 column(LoanNo_Loans; Loans."Loan No.")
//                 {
//                 }
//                 column(ApplicationDate_Loans; Loans."Application Date")
//                 {
//                 }
//                 column(LoanProductType_Loans; Loans."Loan Product Type")
//                 {
//                 }
//                 column(MemberNo_Loans; Loans."Member No.")
//                 {
//                 }
//                 column(RequestedAmount_Loans; Loans."Requested Amount")
//                 {
//                 }
//                 column(ApprovedAmount_Loans; Loans."Approved Amount")
//                 {
//                 }
//                 column(Interest_Loans; Loans.Interest)
//                 {
//                 }
//                 column(MemberName_Loans; Loans."Member Name")
//                 {
//                 }
//                 column(ApprovalDate_Loans; Loans."Approval Date")
//                 {
//                 }
//                 column(Installments_Loans; Loans.Installments)
//                 {
//                 }
//                 column(DisbursementDate_Loans; Format(Loans."Disbursement Date"))
//                 {
//                 }
//                 column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
//                 {
//                 }
//                 column(GracePeriod_Loans; Loans."Grace Period")
//                 {
//                 }
//                 column(InstallmentPeriod_Loans; Loans."Installment Period")
//                 {
//                 }
//                 column(Repayment_Loans; Loans.Repayment)
//                 {
//                 }
//                 column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
//                 {
//                 }
//                 column(OutstandingInterest_Loans; Loans."Outstanding Interest")
//                 {
//                 }
//                 column(OpeningBalPrinc; OpeningBalPrinc)
//                 {
//                 }
//                 column(OpeningBalInt; OpeningBalInt)
//                 {
//                 }
//                 column(OpenBalLoans; OpenBalLoans)
//                 {
//                 }
//                 dataitem(CreditLedgers; UnknownTable52185733)
//                 {
//                     DataItemLink = "Posting Date" = field("Date Filter"), "Loan No" = field("Loan No.");
//                     DataItemTableView = sorting("Posting Date", "Document No.", "Customer No.") order(ascending) where("Transaction Type" = filter(Loan | Repayment | "Interest Due" | "Interest Paid"), Reversed = const(No));
//                     column(ReportForNavId_66; 66)
//                     {
//                     }
//                     column(CustomerNo_CreditLedgers; CreditLedgers."Customer No.")
//                     {
//                     }
//                     column(PostingDate_CreditLedgers; CreditLedgers."Posting Date")
//                     {
//                     }
//                     column(DocumentType_CreditLedgers; CreditLedgers."Document Type")
//                     {
//                     }
//                     column(DocumentNo_CreditLedgers; CreditLedgers."Document No.")
//                     {
//                     }
//                     column(Description_CreditLedgers; CreditLedgers.Description)
//                     {
//                     }
//                     column(CurrencyCode_CreditLedgers; CreditLedgers."Currency Code")
//                     {
//                     }
//                     column(Amount_CreditLedgers; CreditLedgers.Amount)
//                     {
//                     }
//                     column(DebitAmount_CreditLedgers; CreditLedgers."Debit Amount")
//                     {
//                     }
//                     column(CreditAmount_CreditLedgers; CreditLedgers."Credit Amount")
//                     {
//                     }
//                     column(DebitAmountLCY_CreditLedgers; CreditLedgers."Debit Amount (LCY)")
//                     {
//                     }
//                     column(CreditAmountLCY_CreditLedgers; CreditLedgers."Credit Amount (LCY)")
//                     {
//                     }
//                     column(LoanNo_CreditLedgers; CreditLedgers."Loan No")
//                     {
//                     }
//                     column(TransactionType_CreditLedgers; CreditLedgers."Transaction Type")
//                     {
//                     }
//                     column(CreditAccountRunBal; CreditAccountRunBal)
//                     {
//                     }
//                     column(OpeningBal; OpeningBal)
//                     {
//                     }
//                     column(IntDue; Loan_Int)
//                     {
//                     }
//                     column(IntPaid; IntPaid)
//                     {
//                     }
//                     column(PrinciplePaid; PrinciplePaid)
//                     {
//                     }
//                     column(LoanAmount; LoanAmount)
//                     {
//                     }
//                     column(ClosingBal; ClosingBal)
//                     {
//                     }
//                     column(InterestR; InterestR)
//                     {
//                     }
//                     column(RunningBal; RunningBal)
//                     {
//                     }
//                     column(TotRepayment; TotRepayment)
//                     {
//                     }
//                     column(TotOpenningBal; TotOpenningBal)
//                     {
//                     }
//                     column(OutPrincipal; OutPrincipal)
//                     {
//                     }
//                     column(OutInt; OutInt)
//                     {
//                     }
//                     column(Dues; Dues)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         //MESSAGE('Doc No %1 Principle %2 Interest Paid %3 Inerest Due %4',CreditLedgers."Document No.",PrinciplePaid,IntPaid,IntDue);



//                         LedgerEntries.Reset;
//                         LedgerEntries.SetCurrentkey("Document No.", "Transaction Type", "Posting Date", "Loan No");
//                         //LedgerEntries.SETRANGE("Document No.",DocmrntNo);
//                         LedgerEntries.SetFilter("Transaction Type", '%1|%2', CreditLedgers."transaction type"::"Interest Due", CreditLedgers."transaction type"::Loan);
//                         LedgerEntries.SetRange("Posting Date", CreditLedgers."Posting Date");
//                         LedgerEntries.SetRange("Loan No", CreditLedgers."Loan No");
//                         if LedgerEntries.Find('-') then begin
//                             LedgerEntries.CalcSums("Amount (LCY)");
//                             Dues += LedgerEntries."Amount (LCY)";
//                         end;
//                         if (PrevDate = CreditLedgers."Posting Date") and (DocNo = CreditLedgers."Document No.") then
//                             CurrReport.Skip;

//                         IntDue := 0;
//                         OutInt := 0;
//                         PrinciplePaid := 0;
//                         OutPrincipal := 0;
//                         TotRepayment := 0;
//                         IntPaid := 0;
//                         Loan_Int := 0;
//                         LoanAmount := 0;
//                         DocmrntNo := CreditLedgers."Document No.";



//                         LedgerEntries.Reset;
//                         LedgerEntries.SetCurrentkey("Document No.", "Transaction Type", "Posting Date", "Loan No");
//                         LedgerEntries.SetRange("Document No.", DocmrntNo);
//                         LedgerEntries.SetRange("Transaction Type", CreditLedgers."transaction type"::"Interest Paid");
//                         LedgerEntries.SetRange("Posting Date", CreditLedgers."Posting Date");
//                         LedgerEntries.SetRange("Loan No", CreditLedgers."Loan No");
//                         if LedgerEntries.Find('-') then begin
//                             LedgerEntries.CalcSums("Amount (LCY)");
//                             IntPaid := LedgerEntries."Amount (LCY)";
//                         end;

//                         LedgerEntries.Reset;
//                         LedgerEntries.SetCurrentkey("Document No.", "Transaction Type", "Posting Date", "Loan No");
//                         LedgerEntries.SetRange("Document No.", DocmrntNo);
//                         LedgerEntries.SetRange("Transaction Type", CreditLedgers."transaction type"::"Interest Due");
//                         LedgerEntries.SetRange("Posting Date", CreditLedgers."Posting Date");
//                         LedgerEntries.SetRange("Loan No", CreditLedgers."Loan No");
//                         if LedgerEntries.Find('-') then begin
//                             LedgerEntries.CalcSums("Amount (LCY)");
//                             IntDue := LedgerEntries."Amount (LCY)";
//                         end;

//                         LedgerEntries.Reset;
//                         LedgerEntries.SetCurrentkey("Document No.", "Transaction Type", "Posting Date", "Loan No");
//                         LedgerEntries.SetRange("Document No.", DocmrntNo);
//                         LedgerEntries.SetRange("Transaction Type", CreditLedgers."transaction type"::Repayment);
//                         LedgerEntries.SetRange("Posting Date", CreditLedgers."Posting Date");
//                         LedgerEntries.SetRange("Loan No", CreditLedgers."Loan No");
//                         if LedgerEntries.Find('-') then begin
//                             LedgerEntries.CalcSums("Amount (LCY)");
//                             PrinciplePaid := LedgerEntries."Amount (LCY)";
//                         end;

//                         LedgerEntries.Reset;
//                         LedgerEntries.SetCurrentkey("Document No.", "Transaction Type", "Posting Date", "Loan No");
//                         LedgerEntries.SetRange("Document No.", DocmrntNo);
//                         LedgerEntries.SetRange("Transaction Type", CreditLedgers."transaction type"::Loan);
//                         LedgerEntries.SetRange("Posting Date", CreditLedgers."Posting Date");
//                         LedgerEntries.SetRange("Loan No", CreditLedgers."Loan No");
//                         if LedgerEntries.Find('-') then begin
//                             LedgerEntries.CalcSums("Amount (LCY)");
//                             LoanAmount := LedgerEntries."Amount (LCY)";
//                         end;



//                         PrinciplePaid *= -1;
//                         IntPaid *= -1;
//                         Loan_Int := LoanAmount + IntDue;
//                         OutPrincipal := LoanAmount - PrinciplePaid;
//                         OutInt := IntDue - IntPaid;


//                         TotRepayment := PrinciplePaid + IntPaid;

//                         RunningBal += Loan_Int - TotRepayment;
//                         //RunningBal:=RunningBal+TotRepayment;
//                         ClosingBal := RunningBal;

//                         if LoanAmount > 0 then
//                             Desc := 'Loan Amount'
//                         else
//                             if PrinciplePaid > 0 then
//                                 Desc := 'Loan Repayment'
//                             else
//                                 if IntPaid > 0 then
//                                     Desc := 'Interest Paid'
//                                 else
//                                     if IntDue > 0 then
//                                         Desc := 'Interest Due';




//                         PrevDate := CreditLedgers."Posting Date";
//                         DocNo := CreditLedgers."Document No.";
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         ClosingBal := 0;
//                         OpeningBal := OpenBalLoans;
//                         CreditAccountRunBal := 0;
//                         CreditIntAmt := 0;
//                         TotRepayment := 0;
//                         TotOpenningBal := 0;
//                         CreditAccountRunBal := 0;


//                         RunningBal := OpenBalLoans;
//                         //CreditLedgers.SETRANGE("Posting Date",StartDate,EndDate);
//                         CreditLedgers.SetRange("Posting Date", StatementDate, StartDate);
//                         PrevDate := 0D;
//                     end;
//                 }
//                 dataitem(CreditLedgerInt; UnknownTable52185733)
//                 {
//                     DataItemLink = "Loan No" = field("Loan No."), "Posting Date" = field("Date Filter");
//                     DataItemTableView = sorting("Posting Date", "Document No.", "Customer No.") order(ascending) where("Transaction Type" = filter("Interest Due" | "Interest Paid"), Reversed = const(No));
//                     column(ReportForNavId_21; 21)
//                     {
//                     }
//                     column(TransactionType_CreditLedgerInt; CreditLedgerInt."Transaction Type")
//                     {
//                     }
//                     column(LoanNo_CreditLedgerInt; CreditLedgerInt."Loan No")
//                     {
//                     }
//                     column(DebitAmount_CreditLedgerInt; CreditLedgerInt."Debit Amount")
//                     {
//                     }
//                     column(CreditAmount_CreditLedgerInt; CreditLedgerInt."Credit Amount")
//                     {
//                     }
//                     column(DebitAmountLCY_CreditLedgerInt; CreditLedgerInt."Debit Amount (LCY)")
//                     {
//                     }
//                     column(CreditAmountLCY_CreditLedgerInt; CreditLedgerInt."Credit Amount (LCY)")
//                     {
//                     }
//                     column(CustomerNo_CreditLedgerInt; CreditLedgerInt."Customer No.")
//                     {
//                     }
//                     column(PostingDate_CreditLedgerInt; CreditLedgerInt."Posting Date")
//                     {
//                     }
//                     column(DocumentType_CreditLedgerInt; CreditLedgerInt."Document Type")
//                     {
//                     }
//                     column(DocumentNo_CreditLedgerInt; CreditLedgerInt."Document No.")
//                     {
//                     }
//                     column(Description_CreditLedgerInt; CreditLedgerInt.Description)
//                     {
//                     }
//                     column(CurrencyCode_CreditLedgerInt; CreditLedgerInt."Currency Code")
//                     {
//                     }
//                     column(Amount_CreditLedgerInt; CreditLedgerInt.Amount)
//                     {
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     /*
//                     AppMght.MakeDateFilter(DateFilter);

//                     StartDateLnTx:=FORMAT(StartDateLn);
//                     EndDateLnTx:=FORMAT(EndDateLn);
//                     DateFilterTx:=StartDateLnTx+'..'+EndDateLnTx;
//                     StartDateLn:=CALCDATE('-CY',TODAY);
//                     EndDateLn:=CALCDATE('CY',TODAY);
//                     DatFilter:=CALCDATE('-CY',TODAY);
//                     StartDate:=0D;

//                     StartDate:=20170101D;
//                     EVALUATE(FromDate,FORMAT(StartDate));
//                     EVALUATE(ToDate,FORMAT(TODAY));
//                     DateFilter:=FromDate+'..'+ToDate;

//                     MinRange := CALCDATE('-1D',20170101D);
//                     PLoans.RESET;
//                     PLoans.SETRANGE("Date Filter",0D,MinRange);
//                     PLoans.SETRANGE("Loan No.",Loans."Loan No.");
//                     PLoans.SETRANGE("Member No.",Members."No.");
//                     IF PLoans.FIND('-') THEN BEGIN

//                       PLoans.CALCFIELDS("Outstanding Balance");
//                       OpenBalLoans:=PLoans."Outstanding Balance";

//                     END;
//                     */


//                     CompletionDate := Loans."Expected Date of Completion";
//                     if Loans."Disbursement Date" <> 0D then
//                         CompletionDate := CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date");

//                     OpenBalLoans := 0;
//                     OpeningBalInt := 0;
//                     OpeningBalPrinc := 0;
//                     PLoans.Reset;
//                     //PLoans.SETRANGE("Date Filter",0D,CALCDATE('-1D',StatementDate));
//                     PLoans.SetFilter("Date Filter", '..%1', CalcDate('-1D', StatementDate));
//                     PLoans.SetRange("Loan No.", Loans."Loan No.");
//                     if PLoans.Find('-') then begin
//                         repeat
//                             PLoans.CalcFields("Total Loan Balance", "Outstanding Balance", "Outstanding Interest");
//                             OpeningBalInt := PLoans."Outstanding Interest";
//                             OpeningBalPrinc := PLoans."Outstanding Balance";
//                             OpenBalLoans := PLoans."Total Loan Balance";
//                         until PLoans.Next = 0;
//                     end;

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     RunningBal := 0;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 GeneralSetUp.Get();

//                 if StartDate = 0D then StartDate := 20900101D;
//                 if EndDate = 0D then EndDate := Today;
//                 if Cust.Get("Employer Code") then
//                     ObjEmpName := Cust.Name;
//                 StartDate := GeneralSetUp."Statement Limit Period";
//                 StatementDate := CalcDate('-180D', StartDate);
//                 if StartDate = 0D then StatementDate := Today;
//                 Acc.Reset;
//                 Acc.SetRange("Member No.", "No.");
//                 Acc.SetRange("Date Filter", StartDate, StatementDate);
//                 Acc.SetRange("Product Category", Acc."Product Category"::"BOSA Deposits");
//                 if Acc.FindFirst then begin
//                     Acc.CalcFields("Balance (LCY)");
//                     TotalDep := Acc."Balance (LCY)";
//                 end;

//                 PLoans.Reset;
//                 PLoans.SetRange("Member No.", "No.");
//                 PLoans.SetRange("Date Filter", StartDate, StatementDate);
//                 PLoans.SetFilter("Total Loan Balance", '>0');
//                 if PLoans.FindFirst then begin
//                     repeat
//                         PLoans.CalcFields("Total Loan Balance");
//                         TotalLoanBal += PLoans."Total Loan Balance";
//                     until PLoans.Next = 0;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin

//                 DFilter := '';
//                 if Members.GetFilter("Date Filter") <> '' then
//                     DFilter := Members.GetFilter("Date Filter");

//                 if DFilter <> '' then begin
//                     if CopyStr(DFilter, 1, 2) = '..' then begin
//                         StartDate := 20900101D;
//                         EndDate := Members.GetRangemax("Date Filter");
//                     end
//                     else begin
//                         StartDate := Members.GetRangeMin("Date Filter");
//                         EndDate := Members.GetRangemax("Date Filter");
//                     end;
//                 end
//                 else begin
//                     if StartDate = 0D then
//                         StartDate := 20900101D;

//                     if EndDate = 0D then
//                         EndDate := Today;
//                 end;
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
//                     field(ShowAll; ShowAll)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Show All';

//                         trigger OnValidate()
//                         begin
//                             case ShowAll of
//                                 true:
//                                     begin
//                                         ShowLoans := true;
//                                         ShowSavings := true;
//                                     end;
//                                 false:
//                                     begin
//                                         ShowLoans := false;
//                                         ShowSavings := false;
//                                     end;
//                             end;
//                         end;
//                     }
//                     field(ShowSavings; ShowSavings)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Show Savings';

//                         trigger OnValidate()
//                         begin
//                             case ShowSavings of
//                                 true:
//                                     begin
//                                         ShowAll := false;

//                                     end;
//                                 false:
//                                     begin
//                                         ShowAll := false;
//                                     end;
//                             end;
//                         end;
//                     }
//                     field(ShowLoans; ShowLoans)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Show Loans';

//                         trigger OnValidate()
//                         begin
//                             case ShowLoans of
//                                 true:
//                                     begin
//                                         ShowAll := false;

//                                     end;
//                                 false:
//                                     begin
//                                         ShowAll := false;
//                                     end;
//                             end;
//                         end;
//                     }
//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'StartDate';
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
//         AppMght: Codeunit ApplicationManagement;
//         BalanceBF: Decimal;
//         SavingsAccountName: Text;
//         SavingsAccountRunBal: Decimal;
//         CreditAccountName: Text;
//         CreditAccountRunBal: Decimal;
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         DateFilter: Text;
//         FromDate: Text;
//         ToDate: Text;
//         StartDate: Date;
//         EndDate: Date;
//         CreditIntAmt: Decimal;
//         ShowSavings: Boolean;
//         ShowLoans: Boolean;
//         ShowAll: Boolean;
//         PLoans: Record Loans;
//         MinRange: Date;
//         OpenBalLoans: Decimal;
//         OpeningBal: Decimal;
//         ClosingBal: Decimal;
//         InterestR: Decimal;
//         InterestDue: Decimal;
//         InterestArrears: Decimal;
//         LedgerEntries: Record "Credit Ledger Entry";
//         RunningBal: Decimal;
//         TotRepayment: Decimal;
//         TotOpenningBal: Decimal;
//         Acc: Record "Savings Accounts";
//         OpenBalSavings: Decimal;
//         RunningBalSavings: Decimal;
//         ClosingBalSavings: Decimal;
//         OpenBalSavingsBF: Decimal;
//         Cust: Record Customer;
//         ObjEmpName: Text;
//         StartDateLn: Date;
//         EndDateLn: Date;
//         StartDateLnTx: Text;
//         EndDateLnTx: Text;
//         DateFilterTx: Text;
//         DatFilter: Date;
//         ProductCat: Integer;
//         AccL: Record "Savings Accounts";
//         OpenBalSharesCap: Decimal;
//         ClosingBalSharesCap: Decimal;
//         RunningBalSharesCap: Decimal;
//         ShareCapBalanceBF: Decimal;
//         OpenBalShareCapBF: Decimal;
//         ShareCapAccountRunBal: Decimal;
//         SharesAccountName: Text;
//         DFilter: Text;
//         Contribution: Decimal;
//         ShareCapContribution: Decimal;
//         TotalDep: Decimal;
//         TotalLoanBal: Decimal;
//         IntDue: Decimal;
//         IntPaid: Decimal;
//         PrinciplePaid: Decimal;
//         LoanAmount: Decimal;
//         Loan_Int: Decimal;
//         Desc: Text;
//         PrevDate: Date;
//         CompletionDate: Date;
//         DocmrntNo: Code[20];
//         DocNo: Code[20];
//         Dues: Decimal;
//         OutPrincipal: Decimal;
//         OutInt: Decimal;
//         OpeningBalInt: Decimal;
//         OpeningBalPrinc: Decimal;
//         StatementDate: Date;
//         GeneralSetUp: Record "General Set-Up";
// }
