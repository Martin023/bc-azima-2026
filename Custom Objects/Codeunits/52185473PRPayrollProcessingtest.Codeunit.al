// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185473 "PR Payroll Processing test"
// {
//     // ++Note
//     // Tax on Excess Pension Not Clear /Not indicated anywhere
//     // Low Interest Benefits
//     // VOQ


//     trigger OnRun()
//     begin
//     end;

//     var
//         Text020: label 'Because of circular references, the program cannot calculate a formula.';
//         Text012: label 'You have entered an illegal value or a nonexistent row number.';
//         Text013: label 'You have entered an illegal value or a nonexistent column number.';
//         Text017: label 'The error occurred when the program tried to calculate:\';
//         Text018: label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
//         Text019: label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
//         Text023: label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
//         VitalSetup: Record "PR Vital Setup Info";
//         curReliefPersonal: Decimal;
//         curReliefInsurance: Decimal;
//         curReliefMorgage: Decimal;
//         curMaximumRelief: Decimal;
//         currMinRelief: Decimal;
//         curNssfEmployee: Decimal;
//         curNssf_Employer_Factor: Decimal;
//         intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
//         intNSSF_BasedOn: Option Gross,Basic;
//         curDisabledLimit: Decimal;
//         curMaxPensionContrib: Decimal;
//         curRateTaxExPension: Decimal;
//         curOOIMaxMonthlyContrb: Decimal;
//         curOOIDecemberDedc: Decimal;
//         curLoanMarketRate: Decimal;
//         curLoanCorpRate: Decimal;
//         curReliefPension: Decimal;
//         TaxAccount: Code[20];
//         salariesAcc: Code[20];
//         PayablesAcc: Code[20];
//         NSSFEMPyer: Code[20];
//         PensionEMPyer: Code[20];
//         NSSFEMPyee: Code[20];
//         NHIFEMPyer: Code[20];
//         NHIFEMPyee: Code[20];
//         HREmployee: Record "HR Employees";
//         CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
//         PostingGroup: Record "prEmployee Posting Group";
//         AccSchedMgt: Codeunit AccSchedManagement;
//         HREmp2: Record "HR Employees";
//         PRTransCode: Record "PR Transaction Codes";
//         HREmployes: Record "HR Employees";
//         Cust2: Record Customer;
//         curTransSubledger: Option " ",Customer,Vendor;
//         curTransSubledgerAccount: Code[20];
//         PRSalCard: Record "PR Salary Card";
//         HRBankSummary: Record "HR Bank Summary";
//         PRSalCard_2: Record "PR Salary Card";
//         EmployeeInterestRate: Decimal;
//         curMorgageRelief: Decimal;
//         PRTransCode_2: Record "PR Transaction Codes";
//         PREmpTrans_2: Record "PR Employee Transactions";
//         BenifitAmount: Decimal;
//         HREmpBankAC: Record "HR Employee Bank Accounts";
//         MembCust: Record Members;


//     procedure fnInitialize()
//     var
//         strTableName: Text[50];
//         curTransAmount: Decimal;
//         curTransBalance: Decimal;
//         strTransDescription: Text[50];
//         TGroup: Text[30];
//         TGroupOrder: Integer;
//         TSubGroupOrder: Integer;
//         curSalaryArrears: Decimal;
//         curPayeArrears: Decimal;
//         curGrossPay: Decimal;
//         curTotAllowances: Decimal;
//         curExcessPension: Decimal;
//         curNSSF: Decimal;
//         curDefinedContrib: Decimal;
//         curPensionStaff: Decimal;
//         curNonTaxable: Decimal;
//         curGrossTaxable: Decimal;
//         curBenefits: Decimal;
//         curValueOfQuarters: Decimal;
//         curUnusedRelief: Decimal;
//         curInsuranceReliefAmount: Decimal;
//         curMorgageReliefAmount: Decimal;
//         curTaxablePay: Decimal;
//         curTaxCharged: Decimal;
//         curPAYE: Decimal;
//         prPeriodTransactions: Record "PR Period Transactions";
//         intYear: Integer;
//         intMonth: Integer;
//         LeapYear: Boolean;
//         CountDaysofMonth: Integer;
//         DaysWorked: Integer;
//         prSalaryArrears: Record "prSalary Arrears";
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         prTransactionCodes: Record "PR Transaction Codes";
//         strExtractedFrml: Text[250];
//         SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
//         TransactionType: Option Income,Deduction;
//         curPensionCompany: Decimal;
//         curTaxOnExcessPension: Decimal;
//         prUnusedRelief: Record "prUnused Relief";
//         curNhif_Base_Amount: Decimal;
//         curNHIF: Decimal;
//         curTotalDeductions: Decimal;
//         curNetRnd_Effect: Decimal;
//         curNetPay: Decimal;
//         curTotCompanyDed: Decimal;
//         curOOI: Decimal;
//         curHOSP: Decimal;
//         curLoanInt: Decimal;
//         strTransCode: Text[250];
//         fnCalcFringeBenefit: Decimal;
//         prEmployerDeductions: Record "prEmployer Deductions";
//         JournalPostingType: Option " ","G/L Account",Customer,Vendor;
//         JournalAcc: Code[20];
//         Customer: Record Customer;
//         JournalPostAs: Option " ",Debit,Credit;
//         "`": Integer;
//     begin
//         //Initialize Global Setup Items
//         VitalSetup.FindFirst;
//         begin
//             // curReliefPersonal := "Tax Relief";
//             // curReliefInsurance := "Insurance Relief";
//             // curReliefMorgage := "Mortgage Relief"; //Same as HOSP
//             // curMaximumRelief := "Max Relief";
//             // curNssfEmployee := "NSSF Employee";
//             // curNssf_Employer_Factor := "NSSF Employer Factor";
//             // intNHIF_BasedOn := "NHIF Based on";
//             // curMaxPensionContrib := "Max Pension Contribution";
//             // curRateTaxExPension := "Tax On Excess Pension";
//             // curOOIMaxMonthlyContrb := "OOI Deduction";
//             // curOOIDecemberDedc := "OOI December";
//             // curLoanMarketRate := "Loan Market Rate";
//             // curLoanCorpRate := "Loan Corporate Rate";
//             // currMinRelief := "Minimum Relief Amount";
//             // curDisabledLimit := "Disbled Tax Limit";
//         end;
//     end;


//     procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; blnInsuranceCertificate: Boolean)
//     var
//         strTableName: Text[50];
//         curTransAmount: Decimal;
//         curTransBalance: Decimal;
//         strTransDescription: Text[50];
//         TGroup: Text[30];
//         TGroupOrder: Integer;
//         TSubGroupOrder: Integer;
//         curSalaryArrears: Decimal;
//         curPayeArrears: Decimal;
//         curGrossPay: Decimal;
//         curTotAllowances: Decimal;
//         curExcessPension: Decimal;
//         curNSSF: Decimal;
//         curDefinedContrib: Decimal;
//         curPensionStaff: Decimal;
//         curNonTaxable: Decimal;
//         curGrossTaxable: Decimal;
//         curBenefits: Decimal;
//         curValueOfQuarters: Decimal;
//         curUnusedRelief: Decimal;
//         curInsuranceReliefAmount: Decimal;
//         curMorgageReliefAmount: Decimal;
//         curTaxablePay: Decimal;
//         curTaxCharged: Decimal;
//         curPAYE: Decimal;
//         prPeriodTransactions: Record "PR Period Transactions";
//         intYear: Integer;
//         intMonth: Integer;
//         LeapYear: Boolean;
//         CountDaysofMonth: Integer;
//         DaysWorked: Integer;
//         prSalaryArrears: Record "prSalary Arrears";
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         prTransactionCodes: Record "PR Transaction Codes";
//         strExtractedFrml: Text[250];
//         SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Mortgage,Pension,"Mortgage Relief";
//         TransactionType: Option Income,Deduction;
//         curPensionCompany: Decimal;
//         curTaxOnExcessPension: Decimal;
//         prUnusedRelief: Record "prUnused Relief";
//         curNhif_Base_Amount: Decimal;
//         curNHIF: Decimal;
//         curTotalDeductions: Decimal;
//         curNetRnd_Effect: Decimal;
//         curNetPay: Decimal;
//         curTotCompanyDed: Decimal;
//         curOOI: Decimal;
//         curHOSP: Decimal;
//         curLoanInt: Decimal;
//         strTransCode: Text[250];
//         fnCalcFringeBenefit: Decimal;
//         prEmployerDeductions: Record "prEmployer Deductions";
//         salCard: Record "PR Salary Card";
//         curBPAYBal: Decimal;
//         curPensionReliefAmount: Decimal;
//         curIncludeinNet: Decimal;
//         JournalPostAs: Option ,Debit,Credit;
//         JournalPostingType: Option " ","G/L Account",Customer,Vendor,Savings,Credit;
//         JournalAc: Code[20];
//         Customer: Record Customer;
//         curIncludeGross: Decimal;
//         IsCashbenefit: Decimal;
//         curNssf_Base_Amount: Decimal;
//         PRPeriodTrans: Record "PR Period Transactions";
//         SavingsAccounts: Record "Savings Accounts";
//         CreditAccounts: Record "Credit Accounts";
//     begin

//         dtOpenPeriod := fnGetOpenPeriod();

//         //Initialize
//         fnInitialize;

//         //Get Payroll Posting Accountss
//         fnGetJournalDet(strEmpCode);


//         //check if the period selected=current period. If not, do NOT run this function
//         if SelectedPeriod <> dtOpenPeriod then exit;
//         intMonth := Date2dmy(SelectedPeriod, 2);
//         intYear := Date2dmy(SelectedPeriod, 3);

//         //Delete all Records from the prPeriod Transactions for Reprocessing
//         prPeriodTransactions.Reset;
//         prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
//         prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", dtOpenPeriod);
//         if prPeriodTransactions.Find('-') then
//             prPeriodTransactions.DeleteAll;

//         //Delete all Records from prEmployer Deductions
//         prEmployerDeductions.Reset;
//         prEmployerDeductions.SetRange(prEmployerDeductions."Employee Code", strEmpCode);
//         prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", dtOpenPeriod);
//         if prEmployerDeductions.Find('-') then
//             prEmployerDeductions.DeleteAll;

//         //Delete all records from HRBankSummary
//         HRBankSummary.Reset;
//         HRBankSummary.SetRange(HRBankSummary."Payroll Period", dtOpenPeriod);
//         HRBankSummary.SetRange(HRBankSummary."Staff No.", strEmpCode);
//         if HRBankSummary.Find('-') then HRBankSummary.DeleteAll;



//         //IF curBasicPay >0 THEN
//         begin
//             //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
//             if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
//                 CountDaysofMonth := fnDaysInMonth(dtDOE);
//                 DaysWorked := fnDaysWorked(dtDOE, false);
//                 curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth);
//                 curTransAmount := ROUND(curBasicPay, 0.01, '<')//DERRICKBASIC
//             end;

//             //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//             if dtTermination <> 0D then begin
//                 if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
//                     CountDaysofMonth := fnDaysInMonth(dtTermination);
//                     DaysWorked := fnDaysWorked(dtTermination, true);
//                     curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
//                 end;
//             end;
//             //basic pay balance
//             curBPAYBal := 0;
//             salCard.Reset;
//             salCard.SetRange(salCard."Employee Code", strEmpCode);
//             //salCard.CALCFIELDS(salCard."Cumm BasicPay");
//             if salCard.Find('-') then begin
//                 curBPAYBal := curBasicPay;
//             end;


//             curTransAmount := curBasicPay;
//             strTransDescription := 'Basic Pay';
//             TGroup := 'BASIC SALARY';
//             TGroupOrder := 1;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
//                                TSubGroupOrder, strTransDescription, curTransAmount, curBPAYBal,
//                                intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
//                                salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", ''
//                                , Coopparameters::none);
//             curTransAmount := ROUND(curBasicPay, 0.01, '<'); //DERRICKBASIC


//             //Salary Arrears
//             prSalaryArrears.Reset;
//             prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
//             prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
//             prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
//             if prSalaryArrears.Find('-') then begin
//                 repeat
//                     curSalaryArrears := prSalaryArrears."Salary Arrears";
//                     curPayeArrears := prSalaryArrears."PAYE Arrears";

//                     //Insert [Salary Arrears] into period trans [ARREARS]
//                     curTransAmount := curSalaryArrears;
//                     strTransDescription := 'Salary Arrears';
//                     TGroup := 'ARREARS';
//                     TGroupOrder := 1;
//                     TSubGroupOrder := 2;
//                     fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                       strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
//                       salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

//                     //Insert [PAYE Arrears] into period trans [PYAR]
//                     curTransAmount := curPayeArrears;
//                     strTransDescription := 'P.A.Y.E Arrears';
//                     TGroup := 'STATUTORIES';
//                     TGroupOrder := 7;
//                     TSubGroupOrder := 4;
//                     fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
//                        strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept
//                        , salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none)

//                 until prSalaryArrears.Next = 0;
//             end;

//             //Get Earnings
//             prEmployeeTransactions.Reset;
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
//             if prEmployeeTransactions.Find('-') then begin
//                 curTotAllowances := 0;
//                 repeat
//                     prTransactionCodes.Reset;
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
//                     if prTransactionCodes.Find('-') then begin

//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                         strTransDescription := '';
//                         strExtractedFrml := '';
//                         curIncludeinNet := 0;
//                         if prTransactionCodes."Is Formula" then begin
//                             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                             curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '<'); //Get the calculated amount
//                                                                                                 //error('%1',curTransAmount);

//                         end else begin
//                             curTransAmount := prEmployeeTransactions.Amount;
//                         end;

//                         if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
//                             curTransBalance := 0;
//                         if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
//                             curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
//                         if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
//                             curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
//                         if prTransactionCodes."Include in Net" = true then begin
//                             curIncludeinNet := curTransAmount;
//                         end;


//                         //Prorate Allowances Here
//                         //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
//                         if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
//                             CountDaysofMonth := fnDaysInMonth(dtDOE);
//                             DaysWorked := fnDaysWorked(dtDOE, false);
//                             curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//                         end;

//                         //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//                         if dtTermination <> 0D then begin
//                             if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
//                                 CountDaysofMonth := fnDaysInMonth(dtTermination);
//                                 DaysWorked := fnDaysWorked(dtTermination, true);
//                                 curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//                             end;
//                         end;
//                         // Prorate Allowances Here

//                         //Add Non Taxable Here
//                         if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
//                         prTransactionCodes."special transactions"::None) then
//                             curNonTaxable := curNonTaxable + curTransAmount;

//                         //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
//                         if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
//                         prTransactionCodes."special transactions"::None) then
//                             curTransAmount := 0;

//                         curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
//                         curTransAmount := curTransAmount;
//                         curTransBalance := curTransBalance;
//                         strTransDescription := prTransactionCodes."Transaction Name";
//                         //jnlcode:=prTransactionCodes."GL Account";
//                         TGroup := 'ALLOWANCE';
//                         TGroupOrder := 3;
//                         TSubGroupOrder := 0;
//                         //MESSAGE(FORMAT(JournalAc));


//                         //Get the posting Details
//                         JournalPostingType := Journalpostingtype::" ";
//                         JournalAc := '';
//                         if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
//                             //FOR CUSTOMER
//                             //***********************************

//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
//                                 //HrEmployee.GET(strEmpCode);
//                                 Customer.Reset;
//                                 Customer.SetRange(Customer."No.", strEmpCode);
//                                 if Customer.Find('-') then begin
//                                     JournalAc := strEmpCode;
//                                     JournalPostingType := Journalpostingtype::Customer;
//                                 end;
//                             end;

//                             //FOR MEMBERS
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Member then begin
//                                 HREmployee.Get(strEmpCode);
//                                 MembCust.Reset;
//                                 MembCust.SetRange(MembCust."Payroll/Staff No.", strEmpCode);
//                                 //MembCust.SETRANGE(MembCust."Employer Code",'00');
//                                 if MembCust.Find('-') then begin
//                                     JournalAc := MembCust."No.";
//                                     JournalPostingType := Journalpostingtype::Customer;
//                                 end;

//                             end;

//                             //Savings
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Savings then begin
//                                 HREmployee.Get(strEmpCode);
//                                 SavingsAccounts.Reset;
//                                 SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", strEmpCode);
//                                 SavingsAccounts.SetRange("Product Category", prTransactionCodes."Product Category");
//                                 if SavingsAccounts.Find('-') then begin
//                                     JournalAc := SavingsAccounts."No.";
//                                     JournalPostingType := Journalpostingtype::Savings;
//                                 end;

//                             end;

//                             //Credit
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Credit then begin
//                                 HREmployee.Get(strEmpCode);
//                                 CreditAccounts.Reset;
//                                 CreditAccounts.SetRange(CreditAccounts."Payroll/Staff No.", strEmpCode);
//                                 CreditAccounts.SetRange("Product Type", prTransactionCodes."Transaction Code");
//                                 if CreditAccounts.Find('-') then begin
//                                     JournalAc := CreditAccounts."No.";
//                                     JournalPostingType := Journalpostingtype::Credit;
//                                 end;

//                             end;

//                             //FOR VENDOR
//                             //***********************************
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Vendor then begin
//                                 HREmployes.Reset;
//                                 HREmployes.SetRange(HREmployes."No.", strEmpCode);
//                                 if HREmployes.Find('-') then begin
//                                     JournalAc := prEmployeeTransactions."Subledger Account";
//                                     JournalPostingType := Journalpostingtype::Vendor;
//                                 end;
//                             end;

//                         end else begin
//                             //JournalAc:=jnlcode;
//                             JournalPostingType := Journalpostingtype::"G/L Account";
//                             JournalAc := prTransactionCodes."GL Account";

//                         end;



//                         //End posting Details

//                         fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                         strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
//                         prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAc, Journalpostas::Debit, JournalPostingType, '',
//                         prTransactionCodes."coop parameters");



//                     end;
//                 until prEmployeeTransactions.Next = 0;
//             end;

//             //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
//             curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears + curIncludeGross);
//             curTransAmount := ROUND(curGrossPay, 0.01, '>'); //curGrossPay;

//             strTransDescription := 'Gross Pay';
//             TGroup := 'GROSS PAY';
//             TGroupOrder := 4;
//             TSubGroupOrder := 0;
//             fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
//              intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::Debit, Journalpostingtype::" ", '', Coopparameters::none);

//             //************************************************************************************************************************************
//             /*
//                       //Get the NSSF amount
//                       IF blnPaysNssf THEN
//                         curNSSF := curNssfEmployee;
//                       curTransAmount := curNSSF;
//                       strTransDescription := 'N.S.S.F';
//                       TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 1;
//                       fnUpdatePeriodTrans (strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
//                       strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
//                       NSSFEMPyee,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::NSSF);
//             */


//             //************************************************************************************************************************************
//             //NEW NSSF CODE HERE
//             //Get the N.S.S.F amount for the month GBT
//             curNssf_Base_Amount := 0;
//             if intNSSF_BasedOn = Intnssf_basedon::Gross then //>NSSF calculation can be based on:
//                 curNssf_Base_Amount := curGrossPay;
//             if intNSSF_BasedOn = Intnssf_basedon::Basic then
//                 curNssf_Base_Amount := curBasicPay;

//             //Get the NSSF amount
//             if blnPaysNssf then
//                 curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
//             curTransAmount := curNSSF;
//             strTransDescription := 'N.S.S.F';
//             TGroup := 'STATUTORIES';
//             TGroupOrder := 7;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
//             strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
//             Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);

//             //Update Employer deductions
//             if blnPaysNssf then
//                 curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
//             curTransAmount := curNSSF;
//             fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
//              'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
//               prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);


//             //************************************************************************************************************************************



//             //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
//             curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
//             curTransAmount := curDefinedContrib;
//             //error('%1',curTransAmount);
//             strTransDescription := 'Defined Contributions';
//             TGroup := 'TAX CALCULATIONS';
//             TGroupOrder := 6;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
//              strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//              '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);

//             //Get the Gross taxable amount
//             //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
//             curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

//             //>If GrossTaxable = 0 Then TheDefinedToPost = 0
//             if curGrossTaxable = 0 then curDefinedContrib := 0;

//             //Personal Relief
//             // if get relief is ticked  - DENNO ADDED


//             //Added for auto relief calculation
//             if (curGrossPay - curNSSF) <= currMinRelief then begin
//                 blnGetsPAYERelief := false;
//             end else begin
//                 blnGetsPAYERelief := true;
//                 //If employee is marked on salary card as not entitle to personal relief
//                 PRSalCard_2.Reset;
//                 if PRSalCard_2.Get(strEmpCode) then begin
//                     if PRSalCard_2."Disable Personal Relief?" then blnGetsPAYERelief := false;
//                 end;

//             end;

//             if blnGetsPAYERelief then begin
//                 curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
//                 curTransAmount := curReliefPersonal;
//                 strTransDescription := 'Personal Relief';
//                 TGroup := 'TAX CALCULATIONS';
//                 TGroupOrder := 6;
//                 TSubGroupOrder := 9;
//                 fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                  '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//             end
//             else
//                 curReliefPersonal := 0;

//             //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//             //>Pension Contribution [self] relief
//             curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//             Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
//             if curPensionStaff > 0 then begin
//                 if curPensionStaff > curMaxPensionContrib then
//                     curTransAmount := ROUND(curMaxPensionContrib, 1, '<')
//                 else
//                     curTransAmount := ROUND(curPensionStaff, 1, '<');
//                 strTransDescription := 'Pension Contribution';
//                 TGroup := 'TAX CALCULATIONS';
//                 TGroupOrder := 6;
//                 TSubGroupOrder := 2;
//                 fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                 '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none)
//             end;

//             //if he PAYS paye only*******************I
//             if blnPaysPaye and blnGetsPAYERelief then begin
//                 //Get Insurance Relief
//                 curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]

//                 //********************************************************************************************************************************************************
//                 //Added DW - for employees who have brought the Insurance certificate, they are entitled to Insurance relief, Otherwise NO
//                 //Place a check mark on the Salary Card to YES
//                 if (curInsuranceReliefAmount > 0) and (blnInsuranceCertificate) then begin
//                     curTransAmount := ROUND(curInsuranceReliefAmount, 1, '<');
//                     strTransDescription := 'Insurance Relief';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 8;
//                     fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//                 end;
//                 //********************************************************************************************************************************************************
//                 //Get Pension Relief
//                 curPensionReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 Specialtranstype::Pension, false); //Insurance is 3 on [Special Transaction]
//                 if curPensionReliefAmount > 0 then begin
//                     curTransAmount := curPensionReliefAmount;
//                     strTransDescription := 'Insurance Pension Relief';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 8;
//                     fnUpdatePeriodTrans(strEmpCode, 'IPR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);

//                 end;

//                 //>OOI
//                 curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
//                 if curOOI > 0 then begin
//                     if curOOI <= curOOIMaxMonthlyContrb then
//                         curTransAmount := curOOI
//                     else
//                         curTransAmount := curOOIMaxMonthlyContrb;

//                     strTransDescription := 'Owner Occupier Interest';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 3;
//                     fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//                 end;

//                 //HOSP
//                 curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
//                 if curHOSP > 0 then begin
//                     if curHOSP <= curReliefMorgage then
//                         curTransAmount := curHOSP
//                     else
//                         curTransAmount := curReliefMorgage;

//                     strTransDescription := 'Home Ownership Savings Plan';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 4;
//                     fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//                 end;

//                 //Dann
//                 //Mortage Relief
//                 curMorgageRelief := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 Specialtranstype::"Mortgage Relief", false);
//                 if curMorgageRelief > 0 then begin
//                     curTransAmount := ROUND(curMorgageRelief, 1, '>');
//                     strTransDescription := 'Mortgage Relief';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 9;
//                     fnUpdatePeriodTrans(strEmpCode, 'MORG-RL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none)

//                 end;



//                 //Enter NonTaxable Amount
//                 if curNonTaxable > 0 then begin
//                     strTransDescription := 'Other Non-Taxable Benefits';
//                     TGroup := 'TAX CALCULATIONS';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 5;
//                     fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//                 end;

//             end;

//             //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//             /*
//             //>Company pension, Excess pension, Tax on excess pension
//             curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
//             TRUE); //Self contrib Pension is 1 on [Special Transaction]
//             IF curPensionCompany > 0 THEN BEGIN
//                 curTransAmount := curPensionCompany;
//                 strTransDescription := 'Pension (Company)';
//                 //Update the Employer deductions table

//                 curExcessPension:= curPensionCompany - curMaxPensionContrib;
//                 IF curExcessPension > 0 THEN BEGIN
//                     curTransAmount := curExcessPension;
//                     strTransDescription := 'Excess Pension';
//                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
//                     fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
//                      intMonth,intYear,'','',SelectedPeriod,Dept,costc);

//                     curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
//                     curTransAmount := curTaxOnExcessPension;
//                     strTransDescription := 'Tax on ExPension';
//                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
//                     fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
//                      intMonth,intYear,'','',SelectedPeriod,Dept,);
//                 END;
//             END;
//              */

//             //Get the Taxable amount for calculation of PAYE
//             //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)

//             //Added Dann for KEPHIS
//             BenifitAmount := 0;

//             PRTransCode_2.Reset;
//             // PRTransCode_2.SetRange(PRTransCode_2."Transaction Type", PRTransCode_2."transaction type"::"2");
//             if PRTransCode_2.Find('-') then begin
//                 PREmpTrans_2.Reset;
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Transaction Code", PRTransCode_2."Transaction Code");
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Employee Code", strEmpCode);
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Payroll Period", SelectedPeriod);
//                 if PREmpTrans_2.Find('-') then begin
//                     if PRTransCode_2.Taxable then BenifitAmount := PREmpTrans_2.Amount;
//                 end;
//             end;
//             //Insert in to PR Period Trans
//             strTransDescription := PRTransCode_2."Transaction Name";
//             curTransAmount := PREmpTrans_2.Amount;
//             TGroup := 'TAX CALCULATIONS';
//             TGroupOrder := 6;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, PRTransCode_2."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//              strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//              '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);

//             //Initialize
//             curTransAmount := 0;
//             curTransBalance := 0;
//             strTransDescription := '';
//             //Added Dann for KEPHIS

//             //Add HOSP and MORTGAGE KIM{}
//             if curPensionStaff > curMaxPensionContrib then
//                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable
//                                  + curPensionReliefAmount) + BenifitAmount
//             else
//                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable
//                                + curPensionReliefAmount) + BenifitAmount;
//             curTaxablePay := ROUND(curTaxablePay, 1, '<');
//             curTransAmount := curTaxablePay;
//             strTransDescription := 'Taxable Pay';
//             TGroup := 'TAX CALCULATIONS';
//             TGroupOrder := 6;
//             TSubGroupOrder := 6;
//             fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//              curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//              '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);


//             //Get the Tax charged for the month
//             //Added for auto relief calculation
//             if (curGrossPay - curNSSF) <= currMinRelief then begin
//                 blnPaysPaye := false;
//             end else begin
//                 blnPaysPaye := true;
//             end;













//             if blnPaysPaye then begin
//                 //Added:: Dann.... Special tax for disabled employee
//                 HREmp2.Reset;
//                 if HREmp2.Get(strEmpCode) then begin
//                     if HREmp2.Disabled = HREmp2.Disabled::Yes then begin

//                         // blnPaysPaye:=FALSE;
//                         if curTaxablePay >= curDisabledLimit then
//                       //END ELSE
//                       begin
//                             curTaxCharged := fnGetEmployeePaye(curTaxablePay - curDisabledLimit);
//                             curTransAmount := ROUND(curTaxCharged, 1, '>');
//                             strTransDescription := 'Tax Charged';
//                             TGroup := 'TAX CALCULATIONS';
//                             TGroupOrder := 6;
//                             TSubGroupOrder := 7;
//                             fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                             '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);
//                         end
//                     end;
//                 end;
//             end;

//             //Get the Net PAYE amount to post for the month
//             if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then begin
//                 curPAYE := curTaxCharged - curMaximumRelief;
//             end else begin
//                 //******************************************************************************************************************************************
//                 //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
//                 //Place a check mark on the Salary Card to YES
//                 if (blnInsuranceCertificate) then begin
//                     curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curMorgageRelief);
//                 end else begin
//                     curPAYE := curTaxCharged - (curReliefPersonal + curMorgageRelief);
//                 end;
//                 //******************************************************************************************************************************************
//             end;




//             //Added for auto PAYE calculation
//             if (curGrossPay - curNSSF) <= currMinRelief then begin
//                 blnPaysPaye := false;
//             end else begin
//                 blnPaysPaye := true;
//             end;


//             if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
//             curTransAmount := ROUND(curPAYE, 1, '>');
//             if curPAYE < 0 then curTransAmount := 0;
//             strTransDescription := 'P.A.Y.E';
//             TGroup := 'STATUTORIES';
//             TGroupOrder := 7;
//             TSubGroupOrder := 3;
//             fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//              curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//              TaxAccount, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

//             //Store the unused relief for the current month
//             //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
//             if curPAYE < 0 then begin
//                 prUnusedRelief.Reset;
//                 prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
//                 prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
//                 prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
//                 if prUnusedRelief.Find('-') then
//                     prUnusedRelief.Delete;

//                 prUnusedRelief.Reset;
//                 begin
//                     // prUnusedRelief.Init;
//                     // "Employee Code" := strEmpCode;
//                     // "Unused Relief" := curPAYE;
//                     // "Period Month" := intMonth;
//                     // "Period Year" := intYear;
//                     // prUnusedRelief.Insert;
//                 end;
//             end;

//             //Deductions: get all deductions for the month
//             //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
//             //>Balance = (Openning Bal + Deduction)...//Increasing balance
//             //>Balance = (Openning Bal - Deduction)...//Reducing balance
//             //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance

//             //Get the N.H.I.F amount for the month GBT
//             curNhif_Base_Amount := 0;

//             if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
//                 curNhif_Base_Amount := curGrossPay;
//             if intNHIF_BasedOn = Intnhif_basedon::Basic then
//                 curNhif_Base_Amount := curBasicPay;
//             if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
//                 curNhif_Base_Amount := curTaxablePay;

//             if blnPaysNhif then begin
//                 curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
//                 curTransAmount := curNHIF;
//                 strTransDescription := 'N.H.I.F';
//                 TGroup := 'STATUTORIES';
//                 TGroupOrder := 7;
//                 TSubGroupOrder := 2;
//                 fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                  NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
//             end;

//             prEmployeeTransactions.Reset;
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
//             if prEmployeeTransactions.Find('-') then begin
//                 curTotalDeductions := 0;
//                 repeat
//                     prTransactionCodes.Reset;
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
//                     if prTransactionCodes.Find('-') then begin
//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                         strTransDescription := '';
//                         strExtractedFrml := '';

//                         if prTransactionCodes."Is Formula" then begin
//                             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                             curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

//                         end else begin
//                             curTransAmount := prEmployeeTransactions.Amount;
//                         end;

//                         //**************************If "deduct Premium" is not ticked and the type is insurance- Derrick*****
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Life Insurance")
//                           and (prTransactionCodes."Deduct Premium" = false) then begin
//                             curTransAmount := 0;
//                         end;

//                         //**************************If "deduct Premium" is not ticked and the type is mortgage- Derrick*****
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Mortgage)
//                          and (prTransactionCodes."Deduct Mortgage" = false) then begin
//                             curTransAmount := 0;
//                         end;


//                         //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Pension)
//                          and (prTransactionCodes.Welfare = false) then begin
//                             curTransAmount := 0;
//                         end;

//                         //Get the posting Details
//                         JournalPostingType := Journalpostingtype::" ";
//                         JournalAc := '';
//                         if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
//                             //IF prTransactionCodes.Subledger=prTransactionCodes.Subledger::Customer THEN BEGIN
//                             ////Customer.RESET;
//                             // HrEmployee.GET(strEmpCode);
//                             //   {
//                             //Customer

//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
//                                 //HrEmployee.GET(strEmpCode);
//                                 Customer.Reset;
//                                 Customer.SetRange(Customer."No.", strEmpCode);
//                                 if Customer.Find('-') then begin
//                                     JournalAc := strEmpCode;
//                                     JournalPostingType := Journalpostingtype::Customer;
//                                 end;
//                             end;

//                             //FOR VENDOR
//                             //***********************************
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Vendor then begin
//                                 HREmployes.Reset;
//                                 HREmployes.SetRange(HREmployes."No.", strEmpCode);
//                                 if HREmployes.Find('-') then begin
//                                     JournalAc := prEmployeeTransactions."Subledger Account";
//                                     JournalPostingType := Journalpostingtype::Vendor;
//                                 end;
//                             end;

//                             //Savings
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Savings then begin
//                                 // MESSAGE('%1 and %2',JournalPostingType,JournalAc);
//                                 HREmployee.Get(strEmpCode);
//                                 SavingsAccounts.Reset;
//                                 SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", strEmpCode);
//                                 SavingsAccounts.SetRange("Product Category", prTransactionCodes."Product Category");
//                                 if SavingsAccounts.Find('-') then begin
//                                     JournalAc := SavingsAccounts."No.";
//                                     JournalPostingType := Journalpostingtype::Savings;
//                                 end;


//                             end;

//                             //Credit
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Credit then begin

//                                 HREmployee.Get(strEmpCode);
//                                 CreditAccounts.Reset;
//                                 CreditAccounts.SetRange(CreditAccounts."Payroll/Staff No.", strEmpCode);
//                                 CreditAccounts.SetRange("Product Type", prTransactionCodes."Loan Product Type");
//                                 if CreditAccounts.Find('-') then begin
//                                     JournalAc := CreditAccounts."No.";
//                                     JournalPostingType := Journalpostingtype::Credit;
//                                 end;
//                                 //MESSAGE('%1 and %2',JournalPostingType,JournalAc);

//                             end;

//                         end else begin

//                             JournalAc := prTransactionCodes."GL Account";
//                             JournalPostingType := Journalpostingtype::"G/L Account";
//                         end;

//                         //End posting Details


//                         //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Staff Loan (Interest Varies)") and
//                            (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
//                             curTransAmount := 0;
//                             curLoanInt := 0;

//                             if not prEmployeeTransactions."Exempt from Interest" then prEmployeeTransactions.TestField(prEmployeeTransactions."Loan Interest Rate");

//                             curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
//                             prEmployeeTransactions."Loan Interest Rate", prTransactionCodes."Repayment Method",
//                                prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod);

//                             //MESSAGE(FORMAT(curTransAmount));
//                             //Post the Interest//DERRICK LOAN
//                             //hosea uncommented
//                             if (curLoanInt <> 0) then begin
//                                 curTransAmount := curLoanInt;
//                                 curTotalDeductions := (curTotalDeductions + curTransAmount); //Sum-up all the deductions
//                                 curTransBalance := 0;
//                                 strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
//                                 strTransDescription := prEmployeeTransactions."Transaction Name" + ' Interest';
//                                 TGroup := 'DEDUCTIONS';
//                                 TGroupOrder := 8;
//                                 TSubGroupOrder := 1;


//                                 fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
//                                   strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
//                                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                                   JournalAc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
//                                   Coopparameters::"loan Interest")
//                             end;

//                             //Get the Principal Amt
//                             curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
//                             //Modify PREmployeeTransaction Table
//                             prEmployeeTransactions.Amount := curTransAmount;
//                             prEmployeeTransactions.Modify;
//                             //hosea uncommented
//                         end;
//                         //Loan Calculation Amortized

//                         case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
//                             prTransactionCodes."balance type"::None:
//                                 curTransBalance := 0;
//                             prTransactionCodes."balance type"::Increasing:
//                                 begin
//                                     //Added Dann
//                                     if prTransactionCodes."Special Transactions" <> prTransactionCodes."special transactions"::"Defined Contribution"
//                                     then begin
//                                         curTransAmount := prEmployeeTransactions.Amount;
//                                     end;
//                                     //Added Dann
//                                     curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
//                                 end;
//                             prTransactionCodes."balance type"::Reducing:
//                                 begin
//                                     //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
//                                     if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
//                                         curTransAmount := prEmployeeTransactions.Balance;
//                                         curTransBalance := 0;
//                                     end else begin
//                                         //Added Dann
//                                         curTransAmount := prEmployeeTransactions.Amount;
//                                         //Added Dann

//                                         curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
//                                     end;
//                                     if curTransBalance < 0 then begin
//                                         curTransAmount := 0;
//                                         curTransBalance := 0;
//                                     end;
//                                 end
//                         end;

//                         curTotalDeductions := ROUND(curTotalDeductions + curTransAmount, 1, '<'); //Sum-up all the deductions
//                         curTransAmount := ROUND(curTransAmount, 1, '<');
//                         curTransBalance := curTransBalance;
//                         strTransDescription := prTransactionCodes."Transaction Name";

//                         //MESSAGE('%1 and %2',prTransactionCodes."Transaction Code",curTransAmount);
//                         TGroup := 'DEDUCTIONS';
//                         TGroupOrder := 8;
//                         TSubGroupOrder := 0;
//                         fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                          strTransDescription, curTransAmount, curTransBalance, intMonth,
//                          intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                          JournalAc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
//                          prTransactionCodes."coop parameters");

//                         //Fringe Benefits and Low interest Benefits
//                         if prTransactionCodes."Fringe Benefit" = true then begin
//                             if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
//                                 fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
//                                  * prEmployeeTransactions.Balance;
//                             end;
//                         end else begin
//                             fnCalcFringeBenefit := 0;
//                         end;
//                         if fnCalcFringeBenefit > 0 then begin
//                             fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
//                              'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
//                               prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

//                         end;
//                         //End Fringe Benefits

//                         //Create Employer Deduction
//                         if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
//                             if prTransactionCodes."Is Formula for employer" <> '' then begin
//                                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
//                                 curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
//                             end else begin
//                                 curTransAmount := prEmployeeTransactions."Employer Amount";
//                             end;
//                             if curTransAmount > 0 then
//                                 fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
//                                  'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
//                                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);

//                             //Added Dann
//                             //Update Balance on PR Period Transaction Table with Pension Contributed from Employer
//                             PRPeriodTrans.Reset;
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", strEmpCode);
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", prEmployeeTransactions."Transaction Code");
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", SelectedPeriod);
//                             if PRPeriodTrans.Find('-') then begin
//                                 if PRPeriodTrans.Balance <> 0 then PRPeriodTrans.Balance += curTransAmount;
//                                 PRPeriodTrans.Modify;
//                             end;
//                             //Added Dann

//                         end;
//                     end;

//                 until prEmployeeTransactions.Next = 0;
//                 curTotalDeductions := ROUND(curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions, 1, '>');
//                 //GET TOTAL DEDUCTIONS
//                 curTransBalance := 0;
//                 strTransCode := 'TOT-DED';
//                 strTransDescription := 'TOTAL DEDUCTION';
//                 TGroup := 'DEDUCTIONS';
//                 TGroupOrder := 8;
//                 TSubGroupOrder := 9;
//                 fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
//                   strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
//                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                   '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);

//                 //END GET TOTAL DEDUCTIONS
//             end;





//             //Net Pay: calculate the Net pay for the month in the following manner:
//             //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
//             //...Tot Deductions also include (SumLoan + SumInterest)
//             //curNetPay :=curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions);//-curIncludeinNet;
//             curNetPay := curGrossPay - curTotalDeductions;
//             //curNetPay:=curNetPay+curIncludeinNet;
//             //>Nett = Nett - curExcessPension
//             //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
//             curNetPay := curNetPay; //- curExcessPension

//             //>Nett = Nett - cSumEmployerDeductions
//             //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
//             curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

//             curNetRnd_Effect := curNetPay - ROUND(curNetPay);
//             curNetPay := ROUND(curNetPay, 1, '<'); //Check here//DERRICKNETPAY
//             curTransAmount := curNetPay;
//             strTransDescription := 'Net Pay';
//             TGroup := 'NET PAY';
//             TGroupOrder := 9;
//             TSubGroupOrder := 0;

//             //IF curNetPay < 0 THEN ERROR('Net Pay for Employee No. %1 is %2',strEmpCode, curNetPay);

//             fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//             PayablesAcc, Journalpostas::Credit, Journalpostingtype::Customer, '', Coopparameters::none);////"G/L Account"

//             //  //*************************************************************************************************************
//             //  //Added: DW. To Update PR Staff Bank Transactions with Net Pay Amounts that are transfered to Individual Banks

//             //  fnUpdateStaffBankTrans(strEmpCode, 'NPAY',strTransDescription,curTransAmount,
//             //                        intMonth, intYear,SelectedPeriod,Dept);


//             //  //*************************************************************************************************************
//         end;

//     end;


//     procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
//     begin
//         ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 1, '<');
//     end;


//     procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
//     var
//         Day: Integer;
//         SysDate: Record Date;
//         Expr1: Text[30];
//         FirstDay: Date;
//         LastDate: Date;
//         TodayDate: Date;
//     begin
//         TodayDate := dtDate;

//         Day := Date2dmy(TodayDate, 1);
//         Expr1 := Format(-Day) + 'D+1D';
//         FirstDay := CalcDate(Expr1, TodayDate);
//         LastDate := CalcDate('1M-1D', FirstDay);

//         SysDate.Reset;
//         SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
//         SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
//         SysDate.SetFilter(SysDate."Period No.", '1..7');
//         if SysDate.Find('-') then
//             DaysInMonth := SysDate.Count;
//     end;


//     procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[50]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
//     var
//         PRPeriodTransactions: Record "PR Period Transactions";
//         HRBankAccounts: Record "HR Employee Bank Accounts";
//         curNetPay_2: Decimal;
//     begin
//         //******************************************************************************************************************************************
//         /* Added Dann. for Multiple bank A/Cs                                                                                                       */
//         //******************************************************************************************************************************************
//         if TCode = 'NPAY' then begin
//             HRBankAccounts.Reset;
//             HRBankAccounts.SetRange(HRBankAccounts."Employee Code", EmpCode);
//             if HRBankAccounts.Find('-') then begin
//                 repeat

//                     HRBankAccounts.TestField(HRBankAccounts."Bank  Code");
//                     HRBankAccounts.TestField(HRBankAccounts."Branch Code");
//                     HRBankAccounts.TestField(HRBankAccounts."A/C  Number");
//                     HRBankAccounts.TestField(HRBankAccounts."Percentage to Transfer");

//                     HRBankSummary.Reset;
//                     HRBankSummary.Init;

//                     HRBankSummary."Line No." := GetLastEntryNo;
//                     HRBankSummary."Bank Code" := HRBankAccounts."Bank  Code";
//                     HRBankSummary."Branch Code" := HRBankAccounts."Branch Code";
//                     HRBankSummary."Payroll Period" := dtOpenPeriod;
//                     HRBankSummary.Amount := ROUND((curAmount * HRBankAccounts."Percentage to Transfer" / 100), 0.1, '=');
//                     HRBankSummary."Transaction Code" := 'NPAY';
//                     HRBankSummary."Staff No." := EmpCode;
//                     HRBankSummary."Bank Name" := UpperCase(HRBankAccounts."Bank Name");
//                     HRBankSummary."Branch Name" := UpperCase(HRBankAccounts."Branch Name");

//                     HRBankSummary."% NPAY" := HRBankAccounts."Percentage to Transfer";
//                     if HRBankSummary.Amount > 0 then HRBankSummary.Insert;

//                 until HRBankAccounts.Next = 0;
//             end else begin
//                 //ERROR('No Bank A/C has been specified for [Employee No %1]',EmpCode);
//             end;
//         end;
//         //******************************************************************************************************************************************
//         //******************************************************************************************************************************************


//         if curAmount = 0 then exit;
//         begin
//             // PRPeriodTransactions.Init;
//             // "Employee Code" := EmpCode;
//             // "Transaction Code" := TCode;
//             // "Group Text" := TGroup;
//             // "Transaction Name" := Description;
//             // Amount := curAmount;
//             // Balance := curBalance;
//             // "Original Amount" := Balance;
//             // "Group Order" := GroupOrder;
//             // "Sub Group Order" := SubGroupOrder;
//             // Membership := mMembership;
//             // "Reference No" := ReferenceNo;
//             // "Period Month" := Month;
//             // "Period Year" := Year;
//             // "Payroll Period" := dtOpenPeriod;
//             // "Department Code" := Department;
//             // "Journal Account Type" := JournalACType;
//             // "Post As" := PostAs;
//             // "Journal Account Code" := JournalAC;
//             // "Loan Number" := LoanNo;
//             // "coop parameters" := CoopParam;
//             // //DW
//             // //Insert Scheme Code and Contract Type for each Trans Being Updated
//             // HREmp2.Reset;
//             // if HREmp2.Get(EmpCode) then begin
//             //     "Global Dimension 1 Code" := HREmp2."Global Dimension 1 Code";
//             //     "Contract Type" := HREmp2."Contract Type";

//             // end;
//             //Insert Transaction Type (Either "Income or Deduction") for each Trans Being Updated
//             // PRTransCode.Reset;
//             // PRTransCode.SetRange(PRTransCode."Transaction Code", TCode);
//             // if PRTransCode.Find('-') then begin
//             //     "Transaction Type" := PRTransCode."Transaction Type";
//             // end;

//             // PRPeriodTransactions.Insert;
//             // //Update the prEmployee Transactions  with the Amount
//             // fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
//         end;

//     end;


//     procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Mortgage,Pension,"Mortgage Relief"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
//     var
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         prTransactionCodes: Record "PR Transaction Codes";
//         strExtractedFrml: Text[250];
//         MortgageInterest: Decimal;
//         MortgageRelief: Decimal;
//     begin
//         SpecialTransAmount := 0;
//         prTransactionCodes.Reset;
//         prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
//         if prTransactionCodes.Find('-') then begin
//             repeat
//                 prEmployeeTransactions.Reset;
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
//                 if prEmployeeTransactions.Find('-') then begin

//                     //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
//                     //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
//                     case intSpecTransID of
//                         Intspectransid::"Defined Contribution":
//                             if prTransactionCodes."Is Formula" then begin
//                                 strExtractedFrml := '';
//                                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                                 SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount for the Special Transaction
//                             end else
//                                 SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

//                         Intspectransid::"Life Insurance":
//                             SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);
//                         Intspectransid::"Owner Occupier Interest":
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


//                         Intspectransid::"Home Ownership Savings Plan":
//                             begin
//                                 SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;
//                                 //Modified Dann
//                                 if SpecialTransAmount > 4000 then SpecialTransAmount := 4000;
//                             end;
//                         Intspectransid::Pension:
//                             begin
//                                 SpecialTransAmount := SpecialTransAmount + ((curReliefPension / 100) * prEmployeeTransactions.Amount);
//                                 if SpecialTransAmount > curMaxPensionContrib then SpecialTransAmount := curMaxPensionContrib
//                             end;


//                         Intspectransid::Mortgage:
//                             begin
//                                 SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

//                                 if SpecialTransAmount > curReliefMorgage then begin
//                                     SpecialTransAmount := curReliefMorgage
//                                 end;
//                             end;

//                         //Dann
//                         Intspectransid::"Mortgage Relief":
//                             begin
//                                 //Intrest = 6%/12 * Curr Balance
//                                 MortgageInterest := (0.05 / 12) * prEmployeeTransactions.Balance;

//                                 if MortgageInterest < curReliefMorgage then begin
//                                     MortgageRelief := MortgageInterest;//0.3 * MortgageInterest
//                                 end;

//                                 if MortgageInterest > curReliefMorgage then begin
//                                     MortgageRelief := curReliefMorgage;//0.3 * curReliefMorgage;
//                                 end;

//                                 SpecialTransAmount := MortgageRelief;
//                             end;
//                     //Dann

//                     end;
//                 end;
//             until prTransactionCodes.Next = 0;
//         end;
//     end;


//     procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
//     var
//         prPAYE: Record prPAYE;
//         curTempAmount: Decimal;
//         KeepCount: Integer;
//     begin
//         KeepCount := 0;
//         prPAYE.Reset;
//         if prPAYE.FindFirst then begin
//             if curTaxablePay < prPAYE."PAYE Tier" then exit;
//             repeat
//                 KeepCount += 1;
//                 curTempAmount := curTaxablePay;
//                 if curTaxablePay = 0 then exit;
//                 if KeepCount = prPAYE.Count then   //this is the last record or loop
//                     curTaxablePay := curTempAmount
//                 else
//                     if curTempAmount >= prPAYE."PAYE Tier" then
//                         curTempAmount := prPAYE."PAYE Tier"
//                     else
//                         curTempAmount := curTempAmount;

//                 PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
//                 curTaxablePay := curTaxablePay - curTempAmount;

//             until prPAYE.Next = 0;
//         end;
//     end;


//     procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
//     var
//         prNHIF: Record prNHIF;
//     begin
//         prNHIF.Reset;
//         prNHIF.SetCurrentkey(prNHIF."Tier Code");
//         if prNHIF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
//                     NHIF := prNHIF.Amount;
//             until prNHIF.Next = 0;
//         end;
//     end;


//     procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
//     var
//         Where: Text[30];
//         Which: Text[30];
//         i: Integer;
//         TransCode: Code[20];
//         Char: Text[1];
//         FirstBracket: Integer;
//         StartCopy: Boolean;
//         FinalFormula: Text[250];
//         TransCodeAmount: Decimal;
//         AccSchedLine: Record "Acc. Schedule Line";
//         ColumnLayout: Record "Column Layout";
//         CalcAddCurr: Boolean;
//         AccSchedMgt: Codeunit AccSchedManagement;
//     begin
//         TransCode := '';
//         for i := 1 to StrLen(strFormula) do begin
//             Char := CopyStr(strFormula, i, 1);
//             if Char = '[' then StartCopy := true;

//             if StartCopy then TransCode := TransCode + Char;
//             //Copy Characters as long as is not within []
//             if not StartCopy then
//                 FinalFormula := FinalFormula + Char;
//             if Char = ']' then begin
//                 StartCopy := false;
//                 //Get Transcode
//                 Where := '=';
//                 Which := '[]';
//                 TransCode := DelChr(TransCode, Where, Which);
//                 //Get TransCodeAmount
//                 TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
//                 //Reset Transcode
//                 TransCode := '';
//                 //Get Final Formula
//                 FinalFormula := FinalFormula + Format(TransCodeAmount);
//                 //End Get Transcode
//             end;
//         end;
//         Formula := FinalFormula;
//     end;


//     procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
//     var
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         prPeriodTransactions: Record "PR Period Transactions";
//     begin
//         prEmployeeTransactions.Reset;
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
//         if prEmployeeTransactions.FindFirst then
//             TransAmount := prEmployeeTransactions.Amount;

//         if TransAmount = 0 then begin
//             prPeriodTransactions.Reset;
//             prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//             if prPeriodTransactions.FindFirst then
//                 TransAmount := prPeriodTransactions.Amount;
//         end;
//     end;


//     procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
//     var
//         AccSchedLine: Record "Acc. Schedule Line";
//         ColumnLayout: Record "Column Layout";
//         CalcAddCurr: Boolean;
//         AccSchedMgt: Codeunit AccSchedManagement;
//     begin
//         // Results := AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
//     end;


//     procedure fnClosePayrollPeriod(dtOpenPeriod: Date) Closed: Boolean
//     var
//         dtNewPeriod: Date;
//         intNewMonth: Integer;
//         intNewYear: Integer;
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         prPeriodTransactions: Record "PR Period Transactions";
//         intMonth: Integer;
//         intYear: Integer;
//         prTransactionCodes: Record "PR Transaction Codes";
//         curTransAmount: Decimal;
//         curTransBalance: Decimal;
//         prEmployeeTrans: Record "PR Employee Transactions";
//         prPayrollPeriods: Record "PR Payroll Periods";
//         prNewPayrollPeriods: Record "PR Payroll Periods";
//         CreateTrans: Boolean;
//     begin
//         //MESSAGE('Also include function to reset No. of days worked');
//         dtNewPeriod := CalcDate('1M', dtOpenPeriod);
//         intNewMonth := Date2dmy(dtNewPeriod, 2);
//         intNewYear := Date2dmy(dtNewPeriod, 3);

//         intMonth := Date2dmy(dtOpenPeriod, 2);
//         intYear := Date2dmy(dtOpenPeriod, 3);

//         prEmployeeTransactions.Reset;
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
//         if prEmployeeTransactions.Find('-') then begin
//             repeat
//                 prTransactionCodes.Reset;
//                 prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                 if prTransactionCodes.Find('-') then begin
//                     begin
//                         case prTransactionCodes."Balance Type" of
//                             prTransactionCodes."balance type"::None:
//                                 begin
//                                     curTransAmount := prEmployeeTransactions.Amount;
//                                     curTransBalance := 0;
//                                 end;
//                             prTransactionCodes."balance type"::Increasing:
//                                 begin
//                                     curTransAmount := prEmployeeTransactions.Amount;
//                                     curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
//                                     //****
//                                     //Added DW to Include Subledger and Subledger Account for the next period
//                                     if prEmployeeTransactions.Subledger <> prEmployeeTransactions.Subledger::" " then begin
//                                         curTransSubledger := prEmployeeTransactions.Subledger;
//                                         curTransSubledgerAccount := prEmployeeTransactions."Subledger Account";
//                                     end;
//                                     //****

//                                 end;
//                             prTransactionCodes."balance type"::Reducing:
//                                 begin
//                                     curTransAmount := prEmployeeTransactions.Amount;
//                                     if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
//                                         curTransAmount := prEmployeeTransactions.Balance;
//                                         curTransBalance := 0;
//                                     end else begin
//                                         curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
//                                     end;
//                                     if curTransBalance < 0 then begin
//                                         curTransAmount := 0;
//                                         curTransBalance := 0;
//                                     end;
//                                 end;
//                         end;
//                     end;
//                 end;

//                 //For those transactions with Start and End Date Specified
//                 if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
//                     if prEmployeeTransactions."End Date" < dtNewPeriod then begin
//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                     end;
//                 end;
//                 //End Transactions with Start and End Date

//                 if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
//                    (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
//                  begin
//                     if (curTransAmount <> 0) then  //Update the employee transaction table
//                      begin
//                         if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
//                          (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
//                             prEmployeeTransactions.Balance := curTransBalance;
//                         prEmployeeTransactions.Modify;


//                         //Insert record for the next period
//                         begin
//                             // prEmployeeTrans.Init;
//                             // "Employee Code" := prEmployeeTransactions."Employee Code";
//                             // "Transaction Code" := prEmployeeTransactions."Transaction Code";
//                             // "Transaction Name" := prEmployeeTransactions."Transaction Name";
//                             // Amount := curTransAmount;
//                             // Balance := curTransBalance;
//                             // "Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
//                             // "Original Amount" := prEmployeeTransactions."Original Amount";
//                             // Membership := prEmployeeTransactions.Membership;
//                             // "Reference No" := prEmployeeTransactions."Reference No";
//                             // "Period Month" := intNewMonth;
//                             // "Period Year" := intNewYear;
//                             // "Payroll Period" := dtNewPeriod;
//                             // //****
//                             // //Added DW to Insert Subledger and Subledger Account for the next period
//                             // if curTransSubledger <> Curtranssubledger::" " then begin
//                             //     Subledger := curTransSubledger;
//                             //     "Subledger Account" := curTransSubledgerAccount;

//                             // end;
//                             // //****

//                             // prEmployeeTrans.Insert;
//                         end;
//                     end;
//                 end
//             until prEmployeeTransactions.Next = 0;
//         end;

//         //Update the Period as Closed
//         prPayrollPeriods.Reset;
//         prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
//         prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
//         prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
//         if prPayrollPeriods.Find('-') then begin
//             prPayrollPeriods.Closed := true;
//             prPayrollPeriods."Date Closed" := Today;
//             prPayrollPeriods."Closed By" := UserId;
//             prPayrollPeriods.Modify;
//         end;

//         //Enter a New Period
//         begin
//             // prNewPayrollPeriods.Init;
//             // "Period Month" := intNewMonth;
//             // "Period Year" := intNewYear;
//             // "Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + '' + Format(intNewYear);
//             // "Date Opened" := dtNewPeriod;
//             // "Opened By" := UserId;
//             // Closed := false;
//             // prNewPayrollPeriods.Insert;
//         end;

//         //Effect the transactions for the P9
//         fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod);

//         //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
//         fnGetNegativePay(intMonth, intYear, dtOpenPeriod);


//         /*
//         //Reset no. of days worked for casuals
//         PRSalCard.RESET;
//         PRSalCard.SETRANGE(PRSalCard."Employee Contract Type",'CASUALS');
//         IF PRSalCard.FIND('-') THEN
//         BEGIN
//             REPEAT
//                 PRSalCard."No. of Days Worked":=0;
//                 PRSalCard.MODIFY;
//             UNTIL PRSalCard.NEXT = 0;
//         END;
//         */

//     end;


//     procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
//     var
//         prPeriodTransactions: Record "PR Period Transactions";
//         prEmployeeTransactions: Record "PR Employee Transactions";
//         intNewMonth: Integer;
//         intNewYear: Integer;
//         dtNewPeriod: Date;
//     begin
//         dtNewPeriod := CalcDate('1M', dtOpenPeriod);
//         intNewMonth := Date2dmy(dtNewPeriod, 2);
//         intNewYear := Date2dmy(dtNewPeriod, 3);

//         prPeriodTransactions.Reset;
//         prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//         prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//         prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
//         prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

//         if prPeriodTransactions.Find('-') then begin
//             repeat
//             begin
//                 // prEmployeeTransactions.Init;
//                 // "Employee Code" := prPeriodTransactions."Employee Code";
//                 // "Transaction Code" := 'NEGP';
//                 // "Transaction Name" := 'Negative Pay';
//                 // Amount := prPeriodTransactions.Amount;
//                 // Balance := 0;
//                 // "Original Amount" := 0;
//                 // "Period Month" := intNewMonth;
//                 // "Period Year" := intNewYear;
//                 // "Payroll Period" := dtNewPeriod;
//                 // prEmployeeTransactions.Insert;
//             end;
//             until prPeriodTransactions.Next = 0;
//         end;
//     end;


//     procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date)
//     var
//         P9EmployeeCode: Code[20];
//         P9BasicPay: Decimal;
//         P9Allowances: Decimal;
//         P9Benefits: Decimal;
//         P9ValueOfQuarters: Decimal;
//         P9DefinedContribution: Decimal;
//         P9OwnerOccupierInterest: Decimal;
//         P9GrossPay: Decimal;
//         P9TaxablePay: Decimal;
//         P9TaxCharged: Decimal;
//         P9InsuranceRelief: Decimal;
//         P9TaxRelief: Decimal;
//         P9Paye: Decimal;
//         P9NSSF: Decimal;
//         P9NHIF: Decimal;
//         P9Deductions: Decimal;
//         P9NetPay: Decimal;
//         prPeriodTransactions: Record "PR Period Transactions";
//         prEmployee: Record "HR Employees";
//     begin
//         P9BasicPay := 0;
//         P9Allowances := 0;
//         P9Benefits := 0;
//         P9ValueOfQuarters := 0;
//         P9DefinedContribution := 0;
//         P9OwnerOccupierInterest := 0;
//         P9GrossPay := 0;
//         P9TaxablePay := 0;
//         P9TaxCharged := 0;
//         P9InsuranceRelief := 0;
//         P9TaxRelief := 0;
//         P9Paye := 0;
//         P9NSSF := 0;
//         P9NHIF := 0;
//         P9Deductions := 0;
//         P9NetPay := 0;

//         prEmployee.Reset;
//         prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
//         //prEmployee.SETFILTER(prEmployee."Employee Contract Type",'<>%1','CASUALS'); //Remove
//         if prEmployee.Find('-') then begin
//             repeat

//                 P9BasicPay := 0;
//                 P9Allowances := 0;
//                 P9Benefits := 0;
//                 P9ValueOfQuarters := 0;
//                 P9DefinedContribution := 0;
//                 P9OwnerOccupierInterest := 0;
//                 P9GrossPay := 0;
//                 P9TaxablePay := 0;
//                 P9TaxCharged := 0;
//                 P9InsuranceRelief := 0;
//                 P9TaxRelief := 0;
//                 P9Paye := 0;
//                 P9NSSF := 0;
//                 P9NHIF := 0;
//                 P9Deductions := 0;
//                 P9NetPay := 0;

//                 prPeriodTransactions.Reset;
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//                 if prPeriodTransactions.Find('-') then begin
//                     repeat
//                     begin
//                         case prPeriodTransactions."Group Order" of
//                             1: //Basic pay & Arrears
//                                 begin
//                                     // if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
//                                     // if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
//                                 end;
//                             3:  //Allowances
//                                 begin
//                                     // P9Allowances := P9Allowances + Amount
//                                 end;
//                             4: //Gross Pay
//                                 begin
//                                     // P9GrossPay := Amount
//                                 end;
//                             6: //Taxation
//                                 begin
//                                     // if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
//                                     // if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
//                                     // if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
//                                     // if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
//                                     // if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
//                                 end;
//                             7: //Statutories
//                                 begin
//                                     // if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
//                                     // if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
//                                     // if "Sub Group Order" = 3 then P9Paye := Amount; //paye
//                                     // if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
//                                 end;
//                             8://Deductions
//                                 begin
//                                     // P9Deductions := P9Deductions + Amount;
//                                 end;
//                             9: //NetPay
//                                 begin
//                                     // P9NetPay := Amount;
//                                 end;
//                         end;
//                     end;
//                     until prPeriodTransactions.Next = 0;
//                 end;
//                 //Update the P9 Details
//                 if P9NetPay <> 0 then
//                     fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
//                         P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
//                         P9NHIF, P9Deductions, P9NetPay, dtCurPeriod);

//             until prEmployee.Next = 0;
//         end;
//     end;


//     procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date)
//     var
//         prEmployeeP9Info: Record "PR Employee P9 Info";
//         intYear: Integer;
//         intMonth: Integer;
//     begin
//         intMonth := Date2dmy(dtCurrPeriod, 2);
//         intYear := Date2dmy(dtCurrPeriod, 3);

//         prEmployeeP9Info.Reset;
//         begin
//             // prEmployeeP9Info.Init;
//             // "Employee Code" := P9EmployeeCode;
//             // "Basic Pay" := P9BasicPay;
//             // Allowances := P9Allowances;
//             // Benefits := P9Benefits;
//             // "Value Of Quarters" := P9ValueOfQuarters;
//             // "Defined Contribution" := P9DefinedContribution;
//             // "Owner Occupier Interest" := P9OwnerOccupierInterest;
//             // "Gross Pay" := P9GrossPay;
//             // "Taxable Pay" := P9TaxablePay;
//             // "Tax Charged" := P9TaxCharged;
//             // "Insurance Relief" := P9InsuranceRelief;
//             // "Tax Relief" := P9TaxRelief;
//             // PAYE := P9Paye;
//             // NSSF := P9NSSF;
//             // NHIF := P9NHIF;
//             // Deductions := P9Deductions;
//             // "Net Pay" := P9NetPay;
//             // "Period Month" := intMonth;
//             // "Period Year" := intYear;
//             // "Payroll Period" := dtCurrPeriod;
//             // prEmployeeP9Info.Insert;
//         end;
//     end;


//     procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
//     var
//         Day: Integer;
//         SysDate: Record Date;
//         Expr1: Text[30];
//         FirstDay: Date;
//         LastDate: Date;
//         TodayDate: Date;
//     begin
//         TodayDate := dtDate;

//         Day := Date2dmy(TodayDate, 1);
//         Expr1 := Format(-Day) + 'D+1D';
//         FirstDay := CalcDate(Expr1, TodayDate);
//         LastDate := CalcDate('1M-1D', FirstDay);

//         SysDate.Reset;
//         SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
//         if not IsTermination then
//             SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
//         else
//             SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
//         SysDate.SetFilter(SysDate."Period No.", '1..7');
//         if SysDate.Find('-') then
//             DaysWorked := SysDate.Count;
//     end;


//     procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
//     var
//         FirstMonth: Boolean;
//         startmonth: Integer;
//         startYear: Integer;
//         "prEmployee P9 Info": Record "PR Employee P9 Info";
//         P9BasicPay: Decimal;
//         P9taxablePay: Decimal;
//         P9PAYE: Decimal;
//         ProratedBasic: Decimal;
//         SalaryArrears: Decimal;
//         SalaryVariance: Decimal;
//         SupposedTaxablePay: Decimal;
//         SupposedTaxCharged: Decimal;
//         SupposedPAYE: Decimal;
//         PAYEVariance: Decimal;
//         PAYEArrears: Decimal;
//         PeriodMonth: Integer;
//         PeriodYear: Integer;
//         CountDaysofMonth: Integer;
//         DaysWorked: Integer;
//     begin
//         FirstMonth := true;
//         if EndDate > StartDate then begin
//             while StartDate < EndDate do begin
//                 //fnGetEmpP9Info
//                 startmonth := Date2dmy(StartDate, 2);
//                 startYear := Date2dmy(StartDate, 3);

//                 "prEmployee P9 Info".Reset;
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
//                 if "prEmployee P9 Info".Find('-') then begin
//                     P9BasicPay := "prEmployee P9 Info"."Basic Pay";
//                     P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
//                     P9PAYE := "prEmployee P9 Info".PAYE;

//                     if P9BasicPay > 0 then   //Staff payment history is available
//                      begin
//                         if FirstMonth then begin                 //This is the first month in the arrears loop
//                             if Date2dmy(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
//                              begin
//                                 //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
//                                 //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
//                                 if (Date2dmy(dtDOE, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(StartDate, 3)) then begin
//                                     CountDaysofMonth := fnDaysInMonth(dtDOE);
//                                     DaysWorked := fnDaysWorked(dtDOE, false);
//                                     ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
//                                 end;

//                                 //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//                                 if dtTermination <> 0D then begin
//                                     if (Date2dmy(dtTermination, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(StartDate, 3)) then begin
//                                         CountDaysofMonth := fnDaysInMonth(dtTermination);
//                                         DaysWorked := fnDaysWorked(dtTermination, true);
//                                         ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
//                                     end;
//                                 end;

//                                 SalaryArrears := (CBasic - ProratedBasic)
//                             end
//                             else begin
//                                 SalaryArrears := (CBasic - P9BasicPay);
//                             end;
//                         end;
//                         SalaryVariance := SalaryVariance + SalaryArrears;
//                         SupposedTaxablePay := P9taxablePay + SalaryArrears;

//                         //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
//                         if SupposedTaxablePay > P9taxablePay then begin
//                             SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
//                             SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
//                             PAYEVariance := SupposedPAYE - P9PAYE;
//                             PAYEArrears := PAYEArrears + PAYEVariance;
//                         end;
//                         FirstMonth := false;               //reset the FirstMonth Boolean to False
//                     end;
//                 end;
//                 StartDate := CalcDate('+1M', StartDate);
//             end;
//             if SalaryArrears <> 0 then begin
//                 PeriodYear := Date2dmy(dtOpenPeriod, 3);
//                 PeriodMonth := Date2dmy(dtOpenPeriod, 2);
//                 fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
//                 dtOpenPeriod);
//             end

//         end
//         else
//             Error('The start date must be earlier than the end date');
//     end;


//     procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
//     var
//         FirstMonth: Boolean;
//         ProratedBasic: Decimal;
//         SalaryVariance: Decimal;
//         PayeVariance: Decimal;
//         SupposedTaxablePay: Decimal;
//         SupposedTaxCharged: Decimal;
//         SupposedPaye: Decimal;
//         CurrentBasic: Decimal;
//         StartDate: Date;
//         "prSalary Arrears": Record "prSalary Arrears";
//     begin
//         "prSalary Arrears".Reset;
//         "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code");
//         "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
//         "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
//         "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
//         if "prSalary Arrears".Find('-') = false then begin
//             "prSalary Arrears"."Employee Code" := EmployeeCode;
//             "prSalary Arrears"."Transaction Code" := TransCode;
//             "prSalary Arrears"."Start Date" := OrigStartDate;
//             "prSalary Arrears"."End Date" := EndDate;
//             "prSalary Arrears"."Salary Arrears" := SalaryArrears;
//             "prSalary Arrears"."PAYE Arrears" := PayeArrears;
//             "prSalary Arrears"."Period Month" := intMonth;
//             "prSalary Arrears"."Period Year" := intYear;
//             "prSalary Arrears"."Payroll Period" := payperiod;
//             "prSalary Arrears".Modify;
//         end
//     end;


//     procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date) LnInterest: Decimal
//     var
//         curLoanInt: Decimal;
//         intMonth: Integer;
//         intYear: Integer;
//     begin
//         intMonth := Date2dmy(CurrPeriod, 2);
//         intYear := Date2dmy(CurrPeriod, 3);

//         curLoanInt := 0;
//         if InterestRate > 0 then begin
//             if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
//                 curLoanInt := (InterestRate / 1200) * LoanAmount;

//             if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

//                  curLoanInt := (InterestRate / 1200) * Balance;

//             if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
//                 curLoanInt := (InterestRate / 1200) * Balance;

//         end else
//             curLoanInt := 0;

//         //Return the Amount
//         LnInterest := ROUND(curLoanInt, 1);
//     end;


//     procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
//     var
//         prEmployerDeductions: Record "prEmployer Deductions";
//     begin

//         if curAmount = 0 then exit;
//         begin
//             // prEmployerDeductions.Init;
//             // "Employee Code" := EmpCode;
//             // "Transaction Code" := TCode;
//             // Amount := curAmount;
//             // "Period Month" := Month;
//             // "Period Year" := Year;
//             // "Payroll Period" := dtOpenPeriod;
//             //***********************************************************
//             HREmp2.Reset;
//             HREmp2.SetRange(HREmp2."No.", EmpCode);
//             if HREmp2.Find('-') then begin
//                 //"Global Dimension 1 Code":=HREmp2."Global Dimension 1 Code";
//                 //"Contract Type":=HREmp2."Contract Type";
//             end;
//             //****************************************************************
//             prEmployerDeductions.Insert;
//         end;
//     end;


//     procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
//     var
//         pureformula: Text[50];
//     begin
//         pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
//         curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
//         curTransAmount := ROUND(curTransAmount, 0.01, '>');
//     end;


//     procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
//     var
//         prEmployeeTrans: Record "PR Employee Transactions";
//     begin
//         prEmployeeTrans.Reset;
//         prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", EmpCode);
//         prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
//         prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", PayrollPeriod);
//         prEmployeeTrans.SetRange(prEmployeeTrans."Period Month", Month);
//         prEmployeeTrans.SetRange(prEmployeeTrans."Period Year", Year);
//         if prEmployeeTrans.Find('-') then begin
//             prEmployeeTrans.Amount := Amount;
//             prEmployeeTrans.Modify;
//         end;
//     end;


//     procedure fnGetOpenPeriod() dtOpenPeriod: Date
//     var
//         "prPayroll Periods": Record "PR Payroll Periods";
//         intMonth: Integer;
//         intYear: Integer;
//     begin
//         "prPayroll Periods".Reset;
//         "prPayroll Periods".SetRange("prPayroll Periods".Closed, false);

//         if "prPayroll Periods".Find('-') then begin
//             dtOpenPeriod := "prPayroll Periods"."Date Opened";
//             intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
//             intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
//         end
//         else begin
//             Error('There is no open payroll period');
//         end
//     end;


//     procedure fnGetJournalDet(strEmpCode: Code[20])
//     var
//         SalaryCard: Record "PR Salary Card";
//         HREmp: Record "HR Employees";
//     begin
//         //Get Payroll Posting Accounts
//         //IF SalaryCard.GET(strEmpCode) THEN BEGIN
//         if HREmp.Get(strEmpCode) then begin
//             if PostingGroup.Get(HREmp."Posting Group") then begin
//                 //Comment This for the Time Being
//                 PostingGroup.TestField("Salary Account");
//                 PostingGroup.TestField("Income Tax Account");
//                 PostingGroup.TestField("Net Salary Payable");
//                 PostingGroup.TestField("SSF Employer Account");
//                 PostingGroup.TestField("Pension Employer Acc");

//                 TaxAccount := PostingGroup."Income Tax Account";
//                 salariesAcc := PostingGroup."Salary Account";
//                 PayablesAcc := PostingGroup."Net Salary Payable";
//                 NSSFEMPyer := PostingGroup."SSF Employer Account";
//                 NSSFEMPyee := PostingGroup."SSF Employee Account";
//                 NHIFEMPyee := PostingGroup."NHIF Employee Account";
//                 PensionEMPyer := PostingGroup."Pension Employer Acc";
//             end;
//         end;
//         //End Get Payroll Posting Accounts
//     end;


//     procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
//     var
//         prNSSF: Record "prNSSF Tiers";
//     begin

//         prNSSF.Reset;
//         prNSSF.SetCurrentkey(prNSSF.Tier);
//         if prNSSF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
//                     NSSF := prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
//             until prNSSF.Next = 0;
//         end;
//     end;


//     procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
//     var
//         prNSSF: Record "prNSSF Tiers";
//     begin

//         prNSSF.Reset;
//         prNSSF.SetCurrentkey(prNSSF.Tier);
//         if prNSSF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
//                     NSSF := prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";
//             until prNSSF.Next = 0;
//         end;
//     end;

//     local procedure GetLastEntryNo() LastLineNum: Integer
//     var
//         HRBankSummary_2: Record "HR Bank Summary";
//     begin
//         HRBankSummary_2.Reset;
//         if HRBankSummary_2.Find('+') then begin
//             LastLineNum := HRBankSummary_2."Line No." + 1;
//         end else begin
//             LastLineNum := 1000;
//         end;
//     end;
// }
