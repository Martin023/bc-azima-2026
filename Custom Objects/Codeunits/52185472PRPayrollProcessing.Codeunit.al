#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185472 "PR Payroll Processing"
{

    trigger OnRun()
    begin
    end;

    var
        Text020: label 'Because of circular references, the program cannot calculate a formula.';
        Text012: label 'You have entered an illegal value or a nonexistent row number.';
        Text013: label 'You have entered an illegal value or a nonexistent column number.';
        Text017: label 'The error occurred when the program tried to calculate:\';
        Text018: label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        VitalSetup: Record "PR Vital Setup Info";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefNHIF: Decimal;
        curReliefNHIFAmt: Decimal;
        curNhif_Base_Amount: Decimal;
        curNetRnd_Effect: Decimal;
        curTotCompanyDed: Decimal;
        curNetPay: Decimal;
        prUnusedRelief: Record "prUnused Relief";
        curTotalDeductions: Decimal;

        CurNhif: Decimal;
        CurShifBaseAmount: decimal;
        HousingLevyBaseAmount: decimal;
        ShifAmount: decimal;
        HousingLevyAmount: Decimal;

        curReliefMorgage: Decimal;
        CurAffordableHousingMax: Decimal;
        AffordableHRelief: Decimal;
        curMaximumRelief: Decimal;
        currMinRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic;
        curDisabledLimit: Decimal;
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        curReliefPension: Decimal;
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        NSSFEmpyee2: Code[20];
        HREmployee: Record "HR Employees";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
        PostingGroup: Record "prEmployee Posting Group";
        ShifAccount: code[50];
        ShifReliefAmount: Decimal;
        AccSchedMgt: Codeunit AccSchedManagement;
        HREmp2: Record "HR Employees";
        PRTransCode: Record "PR Transaction Codes";
        HREmployes: Record "HR Employees";
        Cust2: Record Customer;
        curTransSubledger: Option " ",Customer,Vendor;
        curTransSubledgerAccount: Code[20];
        PRSalCard: Record "PR Salary Card";
        HRBankSummary: Record "HR Bank Summary";
        PRSalCard_2: Record "PR Salary Card";
        EmployeeInterestRate: Decimal;
        curMorgageRelief: Decimal;
        PRTransCode_2: Record "PR Transaction Codes";
        PREmpTrans_2: Record "PR Employee Transactions";
        BenifitAmount: Decimal;
        HREmpBankAC: Record "HR Employee Bank Accounts";
        MembCust: Record Members;
        Loans: Record Loans;
        DisabledTaxRelief: Decimal;
        shifRelief: decimal;
        ShifPercentage: decimal;
        NewNSSFRate: Decimal;
        HousingLevyRate: Decimal;
        Allowables: Decimal;
        TotalAllowables: Decimal;
        OtherSavingDeduction: Decimal;
        TotalOtherSavingDeductions: Decimal;


    procedure fnInitialize()
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        athirdofGS: decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "PR Period Transactions";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "PR Employee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
        SpecialTransType: Enum "Special Transactions";
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "prUnused Relief";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        AffordableRelief: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        AffordableHS: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;

        prEmployerDeductions: Record "prEmployer Deductions";
        JournalPostingType: Enum "Gen. Journal Account Type";
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        "`": Integer;
        NewNSSFRate: Decimal;
        HousingLevyRate: Decimal;
        Allowables: Decimal;
        TotalAllowables: Decimal;
        AllAllowables: Decimal;
        TotalOtherSavingDeductions: Decimal;
        OtherSavingsDeductions: Decimal;

    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        begin
            curReliefPersonal := VitalSetup."Tax Relief";
            DisabledTaxRelief := VitalSetup."Tax Relief";
            curReliefInsurance := VitalSetup."Insurance Relief";

            curReliefMorgage := VitalSetup."Mortgage Relief"; //Same as HOSP
            curMaximumRelief := VitalSetup."Max Relief";
            AffordableHRelief := VitalSetup."AffordableH Relief%";
            CurAffordableHousingMax := VitalSetup."Affordable Housing Relief";
            curNssfEmployee := VitalSetup."NSSF Employee";
            curNssf_Employer_Factor := VitalSetup."NSSF Employer Factor";
            intNHIF_BasedOn := VitalSetup."NHIF Based on";
            curMaxPensionContrib := VitalSetup."Max Pension Contribution";
            curRateTaxExPension := VitalSetup."Tax On Excess Pension";
            curOOIMaxMonthlyContrb := VitalSetup."OOI Deduction";
            curOOIDecemberDedc := VitalSetup."OOI December";
            curLoanMarketRate := VitalSetup."Loan Market Rate";
            curLoanCorpRate := VitalSetup."Loan Corporate Rate";
            currMinRelief := VitalSetup."Minimum Relief Amount";
            // MESSAGE(FORMAT(currMinRelief));
            curDisabledLimit := VitalSetup."Disbled Tax Limit";
            curReliefNHIF := VitalSetup."NHIF Relief";
            shifRelief := VitalSetup."SHIF Relief%";
            ShifPercentage := VitalSetup."SHIF Percentage%";
            NewNSSFRate := VitalSetup."New NSSF Rate %";
            HousingLevyRate := VitalSetup."Housing Levy";

        end;
    end;


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; blnInsuranceCertificate: Boolean; PaysNewNSSF: Boolean)
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        NonLevied: decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        athirdofGS: decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "PR Period Transactions";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "PR Employee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        SpecialTransType: Enum "Special Transactions";
        AffordableHS: Decimal;
        AffordableRelief: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "prEmployer Deductions";
        salCard: Record "PR Salary Card";
        curBPAYBal: Decimal;
        curPensionReliefAmount: Decimal;
        curIncludeinNet: Decimal;
        JournalPostAs: Option ,Debit,Credit;
        JournalPostingType: Enum "Gen. Journal Account Type";//Option " ","G/L Account",Customer,Vendor,Savings,Credit;
        JournalAc: Code[20];
        Customer: Record Customer;
        curIncludeGross: Decimal;
        IsCashbenefit: Decimal;
        curNssf_Base_Amount: Decimal;
        PRPeriodTrans: Record "PR Period Transactions";
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        Ploan: Record Loans;
        OtherNonDeductibles: Decimal;
        OtherNonDeductible: Decimal;
        Allowables: Decimal;
        TotalAllowables: Decimal;
        AllAllowables: Decimal;
        OtherSavingsDeductions: Decimal;
        TotalOtherSavingDeductions: Decimal;

    begin

        dtOpenPeriod := fnGetOpenPeriod();

        //Initialize
        fnInitialize;
        //Get Payroll Posting Accountss
        fnGetJournalDet(strEmpCode);


        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2dmy(SelectedPeriod, 2);
        intYear := Date2dmy(SelectedPeriod, 3);

        //Delete all Records from the prPeriod Transactions for Reprocessing
        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", dtOpenPeriod);
        if prPeriodTransactions.Find('-') then
            prPeriodTransactions.DeleteAll;

        //Delete all Records from prEmployer Deductions
        prEmployerDeductions.Reset;
        prEmployerDeductions.SetRange(prEmployerDeductions."Employee Code", strEmpCode);
        prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", dtOpenPeriod);
        if prEmployerDeductions.Find('-') then
            prEmployerDeductions.DeleteAll;

        //Delete all records from HRBankSummary
        HRBankSummary.Reset;
        HRBankSummary.SetRange(HRBankSummary."Payroll Period", dtOpenPeriod);
        HRBankSummary.SetRange(HRBankSummary."Staff No.", strEmpCode);
        if HRBankSummary.Find('-') then HRBankSummary.DeleteAll;



        //IF curBasicPay >0 THEN

        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
            CountDaysofMonth := fnDaysInMonth(dtDOE);
            DaysWorked := fnDaysWorked(dtDOE, false);
            curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth);
            curTransAmount := ROUND(curBasicPay, 0.01, '<')//DERRICKBASIC
        end;

        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
        if dtTermination <> 0D then begin
            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                CountDaysofMonth := fnDaysInMonth(dtTermination);
                DaysWorked := fnDaysWorked(dtTermination, true);
                curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
            end;
        end;
        //basic pay balance
        curBPAYBal := 0;
        salCard.Reset;
        salCard.SetRange(salCard."Employee Code", strEmpCode);
        //salCard.CALCFIELDS(salCard."Cumm BasicPay");
        if salCard.Find('-') then begin
            curBPAYBal := curBasicPay;
        end;


        curTransAmount := curBasicPay;
        strTransDescription := 'Basic Pay';
        //TGroup := 'BASIC SALARY';
        TGROUP := 'EARNINGS';
        TGroupOrder := 1;
        TSubGroupOrder := 1;
        fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
                           TSubGroupOrder, strTransDescription, curTransAmount, 0,
                           intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                           salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", ''
                           , Coopparameters::none);
        curTransAmount := ROUND(curBasicPay, 0.01, '<'); //DERRICKBASIC
        //Message('Basic Pay: %1', curTransAmount);
        //END OF BASIC PAY

        //Salary Arrears
        prSalaryArrears.Reset;
        prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
        prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
        prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
        if prSalaryArrears.Find('-') then begin
            repeat
                curSalaryArrears := prSalaryArrears."Salary Arrears";
                curPayeArrears := prSalaryArrears."PAYE Arrears";

                //Insert [Salary Arrears] into period trans [ARREARS]
                curTransAmount := curSalaryArrears;
                strTransDescription := 'Salary Arrears';
                TGroup := 'ARREARS';
                // TGroupOrder := 1;
                // TSubGroupOrder := 2;
                TGroupOrder := 1;
                TSubGroupOrder := 1;
                fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                  salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                //Insert [PAYE Arrears] into period trans [PYAR] chacha
                curTransAmount := curPayeArrears;
                strTransDescription := 'P.A.Y.E Arrears';
                // TGroup := 'STATUTORIES';
                // TGroupOrder := 7;
                // TSubGroupOrder := 4;
                TGroup := 'DEDUCTIONS';
                TGroupOrder := 3;
                TSubGroupOrder := 3;
                fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                   strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept
                   , salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none)

            until prSalaryArrears.Next = 0;
        end;

        //..............................................levied..........................................

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
        if prEmployeeTransactions.Find('-') then begin
            curTotAllowances := 0;
            NonLevied := 0;
            repeat

                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                prTransactionCodes.SetRange(prTransactionCodes."Is HLEVY", false);
                if prTransactionCodes.Find('-') then begin
                    NonLevied := NonLevied + prEmployeeTransactions.Amount;
                end;
            until prEmployeeTransactions.next = 0;
        end;

        //..............................................levied.............................................

        //Get Earnings
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.Find('-') then begin
            curTotAllowances := 0;
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                if prTransactionCodes.Find('-') then begin

                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';
                    curIncludeinNet := 0;

                    if prTransactionCodes."Is Formula" then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                        if prEmployeeTransactions."No of Units" = 0 then begin
                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.01, '<'); //Get the calculated amount
                                                                                                   //error('%1',curTransAmount);
                        end else
                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.01, '<') * prEmployeeTransactions."No of Units";
                    end else begin
                        curTransAmount := prEmployeeTransactions."Original Amount";
                        //end;
                    end;


                    if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
                        curTransBalance := 0;
                    if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
                        curTransBalance := prEmployeeTransactions.Balance + curTransAmount;

                    if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                    if prEmployeeTransactions."Loan Number" <> ' ' then
                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                            curTransBalance := prEmployeeTransactions.Balance - (curTransAmount) + prEmployeeTransactions."Interest Due";

                    if prTransactionCodes."Include in Net" = true then begin
                        curIncludeinNet := curTransAmount;
                    end;


                    //Prorate Allowances Here
                    //Get the Basic Salary (prorate basc pay if needed) //DOE in same month

                    if prTransactionCodes.Prorated = false then begin
                        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                            CountDaysofMonth := fnDaysInMonth(dtDOE);
                            DaysWorked := fnDaysWorked(dtDOE, false);
                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                        end else
                            curTransAmount := prEmployeeTransactions.Amount;
                    end;

                    //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                    if prTransactionCodes.Prorated = false then begin
                        if dtTermination <> 0D then begin
                            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtTermination);
                                DaysWorked := fnDaysWorked(dtTermination, true);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;
                        end else
                            curTransAmount := prEmployeeTransactions.Amount;
                    end;
                    // Prorate Allowances Here

                    //Add Non Taxable Here
                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
                    prTransactionCodes."special transactions"::None) then
                        curNonTaxable := curNonTaxable + curTransAmount;

                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                    prTransactionCodes."special transactions"::None) then
                        curTransAmount := 0;

                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                    curTransAmount := curTransAmount;
                    curTransBalance := curTransBalance;
                    strTransDescription := prTransactionCodes."Transaction Name";
                    //jnlcode:=prTransactionCodes."GL Account";
                    //TGroup := 'ALLOWANCE';
                    // TGroupOrder := 3;
                    // TSubGroupOrder := 0;
                    //MESSAGE(FORMAT(JournalAc));
                    TGROUP := 'EARNINGS';
                    TGroupOrder := 1;
                    TSubGroupOrder := 1;


                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';
                    if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                        //FOR CUSTOMER
                        //***********************************

                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                            //HrEmployee.GET(strEmpCode);
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", strEmpCode);
                            if Customer.Find('-') then begin
                                JournalAc := strEmpCode;
                                JournalPostingType := Journalpostingtype::Customer;
                            end;
                        end;

                        //FOR MEMBERS
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Member then begin
                            HREmployee.Get(strEmpCode);
                            MembCust.Reset;
                            MembCust.SetRange(MembCust."Payroll/Staff No.", strEmpCode);
                            //MembCust.SETRANGE(MembCust."Employer Code",'00');
                            if MembCust.Find('-') then begin
                                JournalAc := MembCust."No.";
                                JournalPostingType := Journalpostingtype::Customer;
                            end;

                        end;

                        //Savings
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Savings then begin
                            HREmployee.Get(strEmpCode);
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", strEmpCode);
                            SavingsAccounts.SetRange("Product Category", prTransactionCodes."Product Category");
                            if SavingsAccounts.Find('-') then begin
                                Customer.reset;
                                customer.SetRange("No.", SavingsAccounts."Employer Code");
                                customer.SetRange("Internal Staff Employer", true);
                                if Customer.Find('-') then begin
                                    JournalAc := SavingsAccounts."No.";
                                    JournalPostingType := Journalpostingtype::Savings;
                                end;
                            end;
                        end;

                        //Credit
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Credit then begin
                            HREmployee.Get(strEmpCode);
                            /*CreditAccounts.RESET;
                            CreditAccounts.SETRANGE(CreditAccounts."Payroll/Staff No.",strEmpCode);
                            CreditAccounts.SETRANGE("Product Type",prTransactionCodes."Transaction Code");
                            IF CreditAccounts.FIND('+') THEN
                              BEGIN
                                JournalAc:=CreditAccounts."No.";
                                JournalPostingType:=JournalPostingType::Credit;
                                END;*/

                            Loans.Reset;
                            Loans.SetRange(Loans."Staff No", strEmpCode);
                            Loans.SetRange(Loans."Loan Product Type", prTransactionCodes."Loan Product Type");
                            if Loans.Find('-') then begin
                                JournalAc := Loans."Loan Account";
                                JournalPostingType := Journalpostingtype::Credit;
                            end;

                        end;

                        //FOR VENDOR
                        //***********************************
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Vendor then begin
                            HREmployes.Reset;
                            HREmployes.SetRange(HREmployes."No.", strEmpCode);
                            if HREmployes.Find('-') then begin
                                JournalAc := prEmployeeTransactions."Subledger Account";
                                JournalPostingType := Journalpostingtype::Vendor;
                            end;
                        end;

                    end else begin
                        //JournalAc:=jnlcode;
                        JournalPostingType := Journalpostingtype::"G/L Account";
                        JournalAc := prTransactionCodes."GL Account";

                    end;

                    //End posting Details

                    fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                    strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                    prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAc, Journalpostas::Debit, JournalPostingType, '',
                    prTransactionCodes."coop parameters");

                end;
            until prEmployeeTransactions.Next = 0;
        end;

        //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
        curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears + curIncludeGross);
        curTransAmount := ROUND(curGrossPay, 0.01, '>'); //curGrossPay;

        strTransDescription := 'Gross Pay';
        //TGroup := 'GROSS PAY';
        TGroupOrder := 1;
        TSubGroupOrder := 7;
        fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
         intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);


        strTransDescription := 'Taxable Earnings';
        TGroup := 'Tax Calculations';
        TGroupOrder := 6;
        TSubGroupOrder := 1;
        fnUpdatePeriodTrans(strEmpCode, 'TBLEAR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
         intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);


        //************************************************************************************************************************************
        //NEW NSSF CODE HERE
        //Get the N.S.S.F amount for the month GBT
        curNssf_Base_Amount := 0;
        if intNSSF_BasedOn = Intnssf_basedon::Gross then //>NSSF calculation can be based on:
            curNssf_Base_Amount := curGrossPay;
        if intNSSF_BasedOn = Intnssf_basedon::Basic then
            curNssf_Base_Amount := curBasicPay;

        //Get the NSSF amount
        if blnPaysNssf then BEGIN
            // IF NOT PaysNewNSSF THEN BEGIN
            curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
            curTransAmount := curNSSF;
            strTransDescription := 'N.S.S.F';
            // TGroup := 'STATUTORIES';
            // TGroupOrder := 7;
            // TSubGroupOrder := 1;
            TGroup := 'DEDUCTIONS';
            TGroupOrder := 3;
            TSubGroupOrder := 3;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);
            // END
            // else
            //     if PaysNewNSSF = True then begin
            //         CurNssf := (NewNSSFRate * curNssf_Base_Amount) / 100;
            //         curTransAmount := curNSSF;
            //         strTransDescription := 'N.S.S.F';
            //         // TGroup := 'STATUTORIES';
            //         // TGroupOrder := 7;
            //         // TSubGroupOrder := 1;
            //         TGroup := 'DEDUCTIONS';
            //         TGroupOrder := 3;
            //         TSubGroupOrder := 3;
            //         fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            //         strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            //         Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);
            //     end;
        END;

        // //Update Employer deductions
        // if blnPaysNssf then
        //     curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
        // curTransAmount := curNSSF;
        // fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
        //  'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
        //   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
        //Update Employer deductions
        if blnPaysNssf then begin
            IF NOT PaysNewNSSF THEN BEGIN
                curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
                curTransAmount := curNSSF;
                fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
                 'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
            end
            else
                if PaysNewNSSF = True then begin
                    CurNssf := (NewNSSFRate * curNssf_Base_Amount) / 100;
                    //CurNssf := (VitalSetup."New NSSF Rate %" * curNssf_Base_Amount) / 100;
                    curTransAmount := curNSSF;
                    fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
                     'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
                end;
        end;


        //************************************************************************************************************************************

        //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
        curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
        //curTransAmount := curDefinedContrib;
        // //error('%1',curTransAmount);
        // strTransDescription := 'Defined Contributions';
        // TGroup := 'TAX CALCULATIONS';
        // TGroupOrder := 6;
        // TSubGroupOrder := 1;
        // fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
        //  strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        //  '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none); ----------------------------------------------------------------REMOVED April 2025

        //Get the Gross taxable amount
        //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
        curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;
        //>If GrossTaxable = 0 Then TheDefinedToPost = 0
        if curGrossTaxable = 0 then curDefinedContrib := 0;
        athirdofGS := ROUND(2 / 3 * curBasicPay, 0.01, '>');

        //Added for auto relief calculation
        if (curGrossPay - curNSSF) <= currMinRelief then begin
            blnGetsPAYERelief := false;
        end else begin
            blnGetsPAYERelief := true;

        end;

        // //Specialtranstype := prTransactionCodes."Special Transactions";
        curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
        Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
        // if curPensionStaff > 0 then begin
        //     curTransAmount := curPensionStaff;
        //     if (curTransAmount + curDefinedContrib) > (curMaxPensionContrib) then
        //         //curTransAmount := ROUND((curMaxPensionContrib - curDefinedContrib), 0.01, '>')//here
        //         curTransAmount := ROUND((curMaxPensionContrib - curDefinedContrib), 0.01, '<')
        //     else
        //         curTransAmount := ROUND(curPensionStaff, 0.01, '>');
        //     strTransDescription := 'Pension Contribution';
        //     TGroup := 'TAX CALCULATIONS';
        //     TGroupOrder := 6;
        //     TSubGroupOrder := 2;
        //     fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        //     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        //     '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none)
        // end;
        //----------------------------------------------------------------------------------------------------------Removed 2025
        //Other Deductibles
        OtherNonDeductible := 0;
        OtherNonDeductibles := 0;
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.Find('-') then begin
            repeat
                //OtherNonDeductible := 0;
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                prTransactionCodes.SetRange(Deductible, true);
                if prTransactionCodes.Find('-') then begin
                    OtherNonDeductible := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';
                    if prTransactionCodes."Not Pension" = false then begin
                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            OtherNonDeductible := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                        end else begin
                            OtherNonDeductible := prEmployeeTransactions.Amount;
                        end;
                    end;

                    if prTransactionCodes."Not Pension" = true then begin
                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPurelevyFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            OtherNonDeductible := Round(fnFormulaResult(strExtractedFrml), 0.01, '='); //Get the calculated amount
                        end else begin
                            OtherNonDeductible := Round(prEmployeeTransactions.Amount, 0.01, '=');
                        end;
                    end;


                    OtherNonDeductible := ROUND(OtherNonDeductible, 0.01, '>');
                    strTransDescription := prEmployeeTransactions."Transaction Name";
                    // TGroup := 'TAX CALCULATIONS';
                    // TGroupOrder := 6;
                    // TSubGroupOrder := 2;
                    /*

                    TGroupOrder := 2;
                    TSubGroupOrder := 0;

                    fnUpdatePeriodTrans(strEmpCode, 'ND' + prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    OtherNonDeductible, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
                    */
                    //Removed So that They do not appear twice on the payslip

                    //for deductions
                    // OtherNonDeductible := ROUND(OtherNonDeductible, 0.01, '>');
                    // strTransDescription := prEmployeeTransactions."Transaction Name";
                    // TGroup := 'DEDUCTIONS';
                    // TGroupOrder := 6;
                    // TSubGroupOrder := 2;
                    // fnUpdatePeriodTrans(strEmpCode, 'D-' + prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    // OtherNonDeductible, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    // '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                    OtherNonDeductibles += OtherNonDeductible;
                    //Message(Format(OtherNonDeductibles));
                end;


            until prEmployeeTransactions.Next = 0;
        end;
        //Other Deductibles

        //if he PAYS paye only*******************I  chacha
        if blnPaysPaye and blnGetsPAYERelief then begin
            //Get Insurance Relief
            curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]

            //********************************************************************************************************************************************************
            //Added DW - for employees who have brought the Insurance certificate, they are entitled to Insurance relief, Otherwise NO
            //Place a check mark on the Salary Card to YES
            if (curInsuranceReliefAmount > 0) and (blnInsuranceCertificate) then begin
                curTransAmount := ROUND(curInsuranceReliefAmount, 1, '<');
                if curTransAmount > curMaximumRelief then
                    curTransAmount := curMaximumRelief;
                strTransDescription := 'Insurance Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 8;
                fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            end;
            //********************************************************************************************************************************************************
            //Get Pension Relief
            curPensionReliefAmount := 0;
            curPensionReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::Pension, false); //Insurance is 3 on [Special Transaction]
            if curPensionReliefAmount > 0 then begin
                curTransAmount := curPensionReliefAmount;
                strTransDescription := 'Insurance Pension Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 8;
                fnUpdatePeriodTrans(strEmpCode, 'IPR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

            end;

            //>OOI
            curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
            if curOOI > 0 then begin
                if curOOI <= curOOIMaxMonthlyContrb then
                    curTransAmount := curOOI
                else
                    curTransAmount := curOOIMaxMonthlyContrb;

                strTransDescription := 'Owner Occupier Interest';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 3;
                fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            end;

            //HOSP
            curHOSP := 0;
            curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
            if curHOSP > 0 then begin
                if curHOSP <= curReliefMorgage then
                    curTransAmount := curHOSP
                else
                    curTransAmount := curReliefMorgage;

                strTransDescription := 'Home Ownership Savings Plan';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 4;
                fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            end;

            //Mortage Relief
            curMorgageRelief := 0;
            curMorgageRelief := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Mortgage Relief", false);
            if curMorgageRelief > 0 then begin
                curTransAmount := ROUND(curMorgageRelief, 1, '>');
                strTransDescription := 'Mortgage Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'MORG-RL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none)

            end;

            //Enter NonTaxable Amount   chacha Other Non-Taxable Benefits
            if curNonTaxable > 0 then begin
                strTransDescription := 'Other Non-Taxable Benefits';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            end;
            /////...........................chacha

        end;

        //................................................ chacha add pension...............................................................

        //>Company pension, Excess pension, Tax on excess pension
        curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
        TRUE);
        IF curPensionCompany > 0 THEN BEGIN
            curTransAmount := curPensionCompany;
            strTransDescription := 'Pension (Company)';

            curExcessPension := curPensionCompany - curMaxPensionContrib;
            IF curExcessPension > 0 THEN BEGIN
                curTransAmount := curExcessPension;
                strTransDescription := 'Excess Pension';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 5;
                fnUpdatePeriodTrans(strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

            END;
        END;

        //................................................ chacha add pension...............................................................



        //Added Dann for KEPHIS
        BenifitAmount := 0;

        PRTransCode_2.Reset;
        PRTransCode_2.SetRange(PRTransCode_2."Transaction Type", PRTransCode_2."transaction type"::Income);
        if PRTransCode_2.Find('-') then begin
            PREmpTrans_2.Reset;
            PREmpTrans_2.SetRange(PREmpTrans_2."Transaction Code", PRTransCode_2."Transaction Code");
            PREmpTrans_2.SetRange(PREmpTrans_2."Employee Code", strEmpCode);
            PREmpTrans_2.SetRange(PREmpTrans_2."Payroll Period", SelectedPeriod);
            if PREmpTrans_2.Find('-') then begin
                if PRTransCode_2.Taxable then BenifitAmount := PREmpTrans_2.Amount;
            end;
        end;
        //Insert in to PR Period Trans
        strTransDescription := PRTransCode_2."Transaction Name";
        curTransAmount := PREmpTrans_2.Amount;
        TGroup := 'TAX CALCULATIONS';
        TGroupOrder := 6;
        TSubGroupOrder := 1;
        // fnUpdatePeriodTrans(strEmpCode, PRTransCode_2."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
        //  strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        //  '', Journalpostas::Credit, Journalpostingtype::" ", '', Coopparameters::none);

        //Initialize
        curTransAmount := 0;
        curTransBalance := 0;
        strTransDescription := '';
        //Added Dann for KEPHIS

        //Add HOSP and MORTGAGE KIM{}
        // HREmp2.Reset;
        // if HREmp2.Get(strEmpCode) then begin
        //     if HREmp2.Disabled = HREmp2.Disabled::No then begin
        //         if curPensionStaff > (curMaxPensionContrib) then begin
        //             curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + (curMaxPensionContrib - curDefinedContrib) + curOOI + curHOSP + curNonTaxable
        //                              + curPensionReliefAmount + curMorgageRelief) + BenifitAmount //includes subtracting mortgage relief to get taxable pay
        //         end else
        //             curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable
        //                            + curPensionReliefAmount + curMorgageRelief) + BenifitAmount;//includes subtracting mortgage relief to get taxable pay

        //     end else begin
        //         if HREmp2.Disabled = HREmp2.Disabled::Yes then begin
        //             if curPensionStaff > (curMaxPensionContrib) then begin
        //                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + (curMaxPensionContrib - curDefinedContrib + curDisabledLimit) + curOOI + curHOSP + curNonTaxable
        //                                  + curPensionReliefAmount + curMorgageRelief) + BenifitAmount //includes subtracting mortgage relief to get taxable pay
        //             end else
        //                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable
        //                                + curPensionReliefAmount + curMorgageRelief + curDisabledLimit) + BenifitAmount;//includes subtracting mortgage relief to get taxable pay


        //         end;
        //     end;
        // end;

        //Other Deductibles SHIF & AHL

        HREmp2.Reset;
        if HREmp2.Get(strEmpCode) then begin
            if HREmp2.Disabled = HREmp2.Disabled::No then begin
                if curPensionStaff > (curMaxPensionContrib) then begin
                    curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + (curMaxPensionContrib - curDefinedContrib) + curOOI + curHOSP + OtherNonDeductibles + curNonTaxable
                                     + curPensionReliefAmount + curMorgageRelief) + BenifitAmount //includes subtracting mortgage relief to get taxable pay
                end else
                    curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + OtherNonDeductibles + curNonTaxable
                                   + curPensionReliefAmount + curMorgageRelief) + BenifitAmount;//includes subtracting mortgage relief to get taxable pay
                                                                                                //CurTaxablePay := CurGrossTaxable - (CurDefinedContrib + OtherNonDeductibles);

            end else begin
                if HREmp2.Disabled = HREmp2.Disabled::Yes then begin
                    if curPensionStaff > (curMaxPensionContrib) then begin
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + (curMaxPensionContrib - curDefinedContrib + curDisabledLimit) + curOOI + curHOSP + OtherNonDeductibles + curNonTaxable
                                         + curPensionReliefAmount + curMorgageRelief) + BenifitAmount //includes subtracting mortgage relief to get taxable pay
                    end else
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + OtherNonDeductibles + curNonTaxable
                                       + curPensionReliefAmount + curMorgageRelief + curDisabledLimit) + BenifitAmount;//includes subtracting mortgage relief to get taxable pay


                end;
            end;
        end;

        //End

        if curTaxablePay < 0 then
            curTaxablePay := 0;
        curTaxablePay := ROUND(curTaxablePay, 1, '<');
        curTransAmount := curTaxablePay;
        strTransDescription := 'Taxable Pay';
        TGroup := 'TAX CALCULATIONS';
        TGroupOrder := 6;
        TSubGroupOrder := 3;
        fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
         '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);


        //Get the Tax charged for the month
        //Added for auto relief calculation
        if (curGrossPay - curNSSF) <= currMinRelief then begin
            blnPaysPaye := false;
        end else begin
            blnPaysPaye := true;
        end;



        if blnPaysPaye then begin
            //Added:: Dann.... Special tax for disabled employee
            HREmp2.Reset;
            if HREmp2.Get(strEmpCode) then begin
                if (HREmp2.Disabled = HREmp2.Disabled::Yes) and (curGrossPay > curDisabledLimit) then begin
                    if curTaxablePay > 0 then begin
                        curTaxCharged := fnGetEmployeePaye(curTaxablePay);
                        curTransAmount := ROUND(curTaxCharged, 1, '>');
                        DisabledTaxRelief := DisabledTaxRelief + curUnusedRelief; //*****Get curUnusedRelief
                        if curTransAmount > DisabledTaxRelief then begin
                            curTransAmount := (curTaxCharged)
                        end else
                            curTransAmount := 0;
                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 4;
                        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                        '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
                    end;
                    if (curTransAmount > DisabledTaxRelief) and (curGrossPay > curDisabledLimit) then begin
                        curTransAmount := DisabledTaxRelief;
                        strTransDescription := 'Personal Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 5;
                        fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                         '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
                    end;
                end;

                if HREmp2.Disabled = HREmp2.Disabled::No then begin
                    curTaxCharged := fnGetEmployeePaye(curTaxablePay);
                    curTransAmount := ROUND(curTaxCharged, 0.01, '>');
                    strTransDescription := 'Tax Charged';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 7;
                    fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                    if (curTransAmount > curReliefPersonal) then begin
                        curTransAmount := DisabledTaxRelief;
                        strTransDescription := 'Personal Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 9;
                        fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                         '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
                    end;
                end;
            end;
        end;


        //Get the N.H.I.F amount for the month GBT
        curNhif_Base_Amount := 0;
        curNHIF := 0;

        if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
            curNhif_Base_Amount := curGrossPay;
        if intNHIF_BasedOn = Intnhif_basedon::Basic then
            curNhif_Base_Amount := curBasicPay;
        if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
            curNhif_Base_Amount := curTaxablePay;

        if blnPaysNhif then begin

            curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
            curTransAmount := curNHIF;
            strTransDescription := 'N.H.I.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 2;
            fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
             NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
        end;

        //NHIF ReliefcurReliefNHIF
        curReliefNHIFAmt := 0;
        PRSalCard_2.Reset();
        PRSalCard_2.SetRange("Employee Code", strEmpCode);
        if PRSalCard_2.FindFirst() then begin

            if PRSalCard_2."Pays NHIF" = false then
                curTransAmount := 0;
            curReliefNHIFAmt := curTransAmount * curReliefNHIF / 100;
            curTransAmount := curReliefNHIFAmt;
            strTransDescription := 'NHIF Relief';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 9;
            fnUpdatePeriodTrans(strEmpCode, 'NHIFR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
             '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            //NHIF Relief
        end;
        //..SHIF
        CurShifBaseAmount := 0;
        ShifAmount := 0;


        if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
            CurShifBaseAmount := curGrossPay;
        if intNHIF_BasedOn = Intnhif_basedon::Basic then
            CurShifBaseAmount := curBasicPay;
        if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
            CurShifBaseAmount := curTaxablePay;

        ShifAmount := (CurShifBaseAmount * (ShifPercentage / 100));
        ShifAmount := Round(ShifAmount, 0.01, '<');
        //curTransAmount := ShifAmount;

        // strTransDescription := 'S.H.I.F';
        // TGroup := 'STATUTORIES';
        // TGroupOrder := 7;
        // TSubGroupOrder := 1; //Kenpipe ///Removed for Payslip's sake

        // // TGroup := 'DEDUCTIONS';
        // // TGroupOrder := 8;
        // // TSubGroupOrder := 1; //Previously As MNS

        // fnUpdatePeriodTrans(strEmpCode, 'SHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        //  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        //  ShifAccount, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

        //End of SHIF

        //..SHIF RELIEF
        ShifReliefAmount := 0;
        ShifReliefAmount := Round(ShifAmount * (shifRelief / 100), 0.01, '<');
        curTransAmount := ShifReliefAmount;
        strTransDescription := 'SHIF Relief';
        TGroup := 'TAX CALCULATIONS';
        TGroupOrder := 6;
        TSubGroupOrder := 9;
        fnUpdatePeriodTrans(strEmpCode, 'SHIFR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
         '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

        //END OF SHIF RELIEF


        //Housing Levy As a Satutory
        HousingLevyAmount := 0;

        HousingLevyBaseAmount := curGrossPay;

        //Message('HousingLevyBaseAmount', HousingLevyBaseAmount);
        HousingLevyAmount := Round((HousingLevyBaseAmount * (HousingLevyRate / 100)), 0.01, '<');
        //HousingLevyAmount := Round(HousingLevyAmount, 0.01, '<');
        curTransAmount := HousingLevyAmount;
        strTransDescription := 'A.H.L';
        TGroup := 'STATUTORIES';
        TGroupOrder := 7;
        TSubGroupOrder := 1; //Kenpipe

        // TGroup := 'DEDUCTIONS';
        // TGroupOrder := 8;
        // TSubGroupOrder := 1; //Previously As MNS

        // fnUpdatePeriodTrans(strEmpCode, 'A.H.L', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        //  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        //  ShifAccount, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);


        //End of Housing Levy As a Satutory

        HREmp2.Reset;
        if HREmp2.Get(strEmpCode) then begin
            if (HREmp2.Disabled = HREmp2.Disabled::Yes) and (curGrossPay > curDisabledLimit) then begin
                curReliefPersonal := DisabledTaxRelief;
            end;
        end;
        //Get the Net PAYE amount to post for the month  chacha
        if (curReliefPersonal + curInsuranceReliefAmount + curReliefNHIFAmt + AffordableRelief + ShifReliefAmount) > curMaximumRelief then begin
            curPAYE := Round(curTaxCharged - (curReliefPersonal + curReliefNHIFAmt + AffordableRelief + ShifReliefAmount), 0.01, '>');
            //curPAYE := curTaxCharged - curMaximumRelief;
        end else begin
            //******************************************************************************************************************************************
            //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
            //Place a check mark on the Salary Card to YES
            if (blnInsuranceCertificate) then begin
                // curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curMorgageRelief);
                curPAYE := Round(curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curReliefNHIFAmt + AffordableRelief + ShifReliefAmount), 0.01, '>');//mortgage relief subtracted to for taxable pay
            end else begin
                //curPAYE := curTaxCharged - (curReliefPersonal + curMorgageRelief);
                curPAYE := Round(curTaxCharged - (curReliefPersonal + curReliefNHIFAmt + AffordableRelief + ShifReliefAmount), 0.01, '>');//mortgage relief subtracted to for taxable pay
            end;
            //******************************************************************************************************************************************
        end;


        //Added for auto PAYE calculation
        if (curGrossPay - curNSSF) <= currMinRelief then begin
            blnPaysPaye := false;
        end else begin
            blnPaysPaye := true;
        end;
        //curNetPay := ROUND(curNetPay, 1, '<');

        if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
        curTransAmount := ROUND(curPAYE, 0.01, '>');
        if curPAYE < 0 then curTransAmount := 0;
        strTransDescription := 'P.A.Y.E';
        // TGroup := 'STATUTORIES';
        // TGroupOrder := 7;
        // TSubGroupOrder := 3;
        TGroup := 'DEDUCTIONS';
        TGroupOrder := 3;
        TSubGroupOrder := 3;
        fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
         TaxAccount, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

        TGroup := 'Tax Calculations';
        TGroupOrder := 6;
        TSubGroupOrder := 10;

        fnUpdatePeriodTrans(strEmpCode, 'NDPAYE', TGroup, TgroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        TaxAccount, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);

        //Store the unused relief for the current month
        //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
        if curPAYE < 0 then begin
            prUnusedRelief.Reset;
            prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
            prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
            prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
            if prUnusedRelief.FindSet() then
                prUnusedRelief.DeleteAll();

            prUnusedRelief.Reset;
            begin
                prUnusedRelief.Init;
                prUnusedRelief."Employee Code" := strEmpCode;
                prUnusedRelief."Unused Relief" := curPAYE;
                prUnusedRelief."Period Month" := intMonth;
                prUnusedRelief."Period Year" := intYear;
                prUnusedRelief.Insert;
            end;
        end;

        if curPAYE < 0 then
            curPAYE := 0;


        curTotalDeductions := 0;


        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                if prTransactionCodes.Find('-') then begin
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';



                    if prTransactionCodes."Not Pension" = false then begin
                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;
                    end;

                    if prTransactionCodes."Not Pension" = true then begin
                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPurelevyFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := Round(fnFormulaResult(strExtractedFrml), 0.01, '='); //Get the calculated amount
                        end else begin
                            curTransAmount := Round(prEmployeeTransactions.Amount, 0.01, '=');
                        end;
                    end;



                    //**************************If "deduct Premium" is not ticked and the type is insurance*****
                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Life Insurance")
                      and (prTransactionCodes."Deduct Premium" = false) then begin
                        curTransAmount := 0;
                    end;

                    //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Mortgage)
                     and (prTransactionCodes."Deduct Mortgage" = false) then begin
                        curTransAmount := 0;
                    end;


                    //**************************If "deduct Premium" is not ticked and the type is mortgage- Chacha*****
                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Pension)
                     and (prTransactionCodes.Welfare = false) then begin
                        curTransAmount := 0;
                    end;

                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';
                    if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin

                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                            //HrEmployee.GET(strEmpCode);
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", strEmpCode);
                            if Customer.Find('-') then begin
                                JournalAc := strEmpCode;
                                JournalPostingType := Journalpostingtype::Customer;
                            end;
                        end;

                        //FOR VENDOR
                        //***********************************
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Vendor then begin
                            HREmployes.Reset;
                            HREmployes.SetRange(HREmployes."No.", strEmpCode);
                            if HREmployes.Find('-') then begin
                                JournalAc := prEmployeeTransactions."Subledger Account";
                                JournalPostingType := Journalpostingtype::Vendor;
                            end;
                        end;

                        //Savings
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Savings then begin
                            if not prTransactionCodes."Posting to Other Savings" then begin
                                HREmployee.Get(strEmpCode);
                                Customer.reset;
                                customer.SetRange("Internal Staff Employer", true);
                                if Customer.Find('-') then begin

                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", strEmpCode);
                                    SavingsAccounts.SetRange("Employer Code", Customer."No.");
                                    SavingsAccounts.SetRange("Product Category", prTransactionCodes."Product Category");
                                    if SavingsAccounts.Find('-') then begin
                                        JournalAc := SavingsAccounts."No.";
                                        JournalPostingType := Journalpostingtype::Savings;
                                    end else begin
                                        error('Saving Account Not Found');
                                    end;
                                end;
                            end
                            else if prTransactionCodes."Posting to Other Savings" then begin
                                JournalAc := prEmployeeTransactions."Savings Account No.";
                                JournalPostingType := Journalpostingtype::Savings;
                            end;
                        end;

                        //Credit
                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Credit then begin

                            HREmployee.Get(strEmpCode);
                            Loans.Reset;
                            Loans.SetRange("Staff No", strEmpCode);
                            Loans.SetRange("Loan Product Type", prTransactionCodes."Loan Product Type");
                            Loans.SetRange("Loan No.", prEmployeeTransactions."Loan Number");
                            if Loans.Find('-') then begin
                                JournalAc := Loans."Loan Account";
                                JournalPostingType := Journalpostingtype::Credit;
                            end;
                        end;

                    end else begin

                        JournalAc := prTransactionCodes."GL Account";
                        JournalPostingType := Journalpostingtype::"G/L Account";
                    end;

                    //End posting Details

                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Staff Loan (Interest Varies)") and
                       (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                        curTransAmount := 0;
                        curLoanInt := 0;

                        if not prEmployeeTransactions."Exempt from Interest" then
                            prEmployeeTransactions.TestField(prEmployeeTransactions."Loan Interest Rate");

                        if Ploan.Get(prEmployeeTransactions."Loan Number") then
                            Ploan.CalcFields("Outstanding Interest", "Outstanding Balance");
                        if Ploan."Outstanding Balance" > prEmployeeTransactions.Amount then begin
                            if prEmployeeTransactions.Amount >= Ploan."Outstanding Interest" then
                                curLoanInt := Ploan."Outstanding Interest" else
                                if prEmployeeTransactions.Amount <= Ploan."Outstanding Interest" then
                                    curLoanInt := prEmployeeTransactions.Amount

                        end else
                            if Ploan."Outstanding Interest" <= prEmployeeTransactions.Amount then
                                curLoanInt := Ploan."Outstanding Interest" else
                                if Ploan."Outstanding Interest" >= prEmployeeTransactions.Amount then
                                    curLoanInt := prEmployeeTransactions.Amount;

                        if curLoanInt < 0 then
                            curLoanInt := 0 else
                            curLoanInt := curLoanInt;
                        //Post the Interest
                        if (curLoanInt <> 0) then begin
                            curTransAmount := curLoanInt;
                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransBalance := 0;
                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                            TGroup := 'DEDUCTIONS';
                            // TGroupOrder := 8;
                            // TSubGroupOrder := 1;
                            TGroupOrder := 2;
                            TSubGroupOrder := 1;

                            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                              JournalAc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                              Coopparameters::"loan Interest")
                        end;
                        //Get the Principal Amt
                        if Ploan.Get(prEmployeeTransactions."Loan Number") then //Variated
                            if Ploan."Loan Product Type" <> '133' then begin
                                curTransAmount := prEmployeeTransactions.Amount - curLoanInt;

                            end;
                    end;

                    case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                        prTransactionCodes."balance type"::None:
                            curTransBalance := 0;
                        prTransactionCodes."balance type"::Increasing:
                            begin
                                //Added Dann
                                if prTransactionCodes."Special Transactions" <> prTransactionCodes."special transactions"::"Defined Contribution"
                                then begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                end;
                                //Added Dann
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            end;
                        prTransactionCodes."balance type"::Reducing:
                            begin
                                //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                    curTransAmount := prEmployeeTransactions.Balance;
                                    curTransBalance := 0;
                                end else begin
                                    //Added Dann
                                    if not prEmployeeTransactions.Variated then begin //PMN
                                        if prEmployeeTransactions."Loan Number" = '' then
                                            curTransAmount := prEmployeeTransactions.Amount else
                                            curTransAmount := curTransAmount;
                                    end else
                                        curTransAmount := curTransAmount;
                                    //Added Dann

                                    curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                end;
                                if prEmployeeTransactions."Loan Number" <> ' ' then
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                                        curTransBalance := prEmployeeTransactions.Balance - (curTransAmount) + prEmployeeTransactions."Interest Due";

                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end
                    end;

                    curTotalDeductions := ROUND(curTotalDeductions + curTransAmount, 0.01, '<'); //Sum-up all the deductions
                    curTransAmount := ROUND(curTransAmount, 0.01, '<');
                    curTransBalance := curTransBalance;
                    strTransDescription := prTransactionCodes."Transaction Name";

                    //MESSAGE('%1 and %2',prTransactionCodes."Transaction Code",curTransAmount);
                    TGroup := 'DEDUCTIONS';
                    // TGroupOrder := 8;
                    // TSubGroupOrder := 0;

                    TGroupOrder := 2;
                    TSubGroupOrder := 0;

                    fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                     strTransDescription, curTransAmount, curTransBalance, intMonth,
                     intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                     JournalAc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                     prTransactionCodes."coop parameters");


                    // Affordable Housing Relief..................................ReliefTest
                    if prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Affordable Housing" then begin

                        AffordableRelief := ((AffordableHRelief / 100) * prEmployeeTransactions.Amount);
                        if AffordableRelief > CurAffordableHousingMax then AffordableRelief := CurAffordableHousingMax;

                        if AffordableRelief > 0 then begin

                            curTransAmount := AffordableRelief;

                            strTransDescription := 'Affordable housing Relief';
                            TGroup := 'TAX CALCULATIONS';
                            TGroupOrder := 6;
                            TSubGroupOrder := 4;
                            fnUpdatePeriodTrans(strEmpCode, 'AFHR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                            '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                        end;
                    end;

                    // Affordable Housing Relief..................................

                    //Fringe Benefits and Low interest Benefits
                    if prTransactionCodes."Fringe Benefit" = true then begin
                        if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
                            fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                             * prEmployeeTransactions.Balance;
                        end;
                    end else begin
                        fnCalcFringeBenefit := 0;
                    end;
                    if fnCalcFringeBenefit > 0 then begin
                        fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                         'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                    end;
                    //End Fringe Benefits

                    //Create Employer Deduction
                    if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                        if prTransactionCodes."Is Formula for employer" <> '' then begin
                            if prTransactionCodes."Not Pension" = false then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                            end;
                            if prTransactionCodes."Not Pension" = true then begin
                                strExtractedFrml := fnPurelevyFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                curTransAmount := Round(fnFormulaResult(strExtractedFrml), 0.01, '>'); //Get the calculated amount
                            end;
                        end else begin
                            curTransAmount := prEmployeeTransactions."Employer Amount";
                        end;
                        if curTransAmount > 0 then begin
                            fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                             'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);


                        end;

                    end;
                end;

            until prEmployeeTransactions.Next = 0;

            //END GET TOTAL DEDUCTIONS
        end;



        curTotalDeductions += ROUND(curNSSF + curNHIF /*+ ShifAmount + */+ curPAYE + curPayeArrears, 0.01, '>');
        IF curTotalDeductions > (athirdofGS + curTotAllowances) then
            Error('This Employee:' + '' + Format(strEmpCode) + '' + 'current deduction exceeds the two third rule');

        //GET TOTAL DEDUCTIONS
        curTransBalance := 0;
        strTransCode := 'TOT-DED';
        strTransDescription := 'TOTAL DEDUCTION';
        TGroup := 'DEDUCTIONS';
        // TGroupOrder := 8;
        // TSubGroupOrder := 9;

        TGroupOrder := 3;
        TSubGroupOrder := 3;
        fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,//chacha
          strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
          '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);





        //Net Pay: calculate the Net pay for the month in the following manner:
        //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
        //...Tot Deductions also include (SumLoan + SumInterest)

        //curNetPay :=curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions);//-curIncludeinNet;******HK
        curNetPay := curGrossPay - curTotalDeductions;


        //curNetPay:=curNetPay+curIncludeinNet;
        //>Nett = Nett - curExcessPension
        //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
        // curNetPay := curNetPay; //- curExcessPension

        //>Nett = Nett - cSumEmployerDeductions
        //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
        //curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

        curNetRnd_Effect := curNetPay - ROUND(curNetPay);
        curNetPay := ROUND(curNetPay, 0.01, '>'); //Check here//DERRICKNETPAY
        curTransAmount := curNetPay;
        strTransDescription := 'Net Pay';
        TGroup := 'NET PAY';
        TGroupOrder := 9;
        TSubGroupOrder := 0;

        IF curNetPay < 0 THEN ERROR('Net Pay for Employee No. %1 is %2', strEmpCode, curNetPay);//chacha

        fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        PayablesAcc, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
        //PayablesAcc,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);

        //  //*************************************************************************************************************
        //  //Added: DW. To Update PR Staff Bank Transactions with Net Pay Amounts that are transfered to Individual Banks

        //  fnUpdateStaffBankTrans(strEmpCode, 'NPAY',strTransDescription,curTransAmount,
        //                        intMonth, intYear,SelectedPeriod,Dept);


        //  //*************************************************************************************************************

        Allowables := 0;
        TotalAllowables := 0;
        AllAllowables := 0;
        curTransAmount := 0;

        //Allowables
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.Find('-') then begin
            repeat
                PrTransactionCodes.Reset;
                PrTransactionCodes.SetRange(PrTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                PrTransactionCodes.SetRange(PrTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                pRTransactionCodes.Setrange(PrTransactionCodes.Allowable, True);
                if pRTransactionCodes.find('-') then begin
                    repeat
                        Allowables := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';
                        if prTransactionCodes."Not Pension" = false then begin
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                Allowables := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                            end else begin
                                Allowables := prEmployeeTransactions.Amount;
                            end;
                        end;

                        if prTransactionCodes."Not Pension" = true then begin
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := fnPurelevyFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                Allowables := Round(fnFormulaResult(strExtractedFrml), 0.01, '='); //Get the calculated amount
                            end else begin
                                Allowables := Round(prEmployeeTransactions.Amount, 0.01, '=');
                            end;
                        end;
                        AllAllowables += Allowables;
                    until PrTransactionCodes.Next = 0;
                end
            until prEmployeeTransactions.Next = 0;
        end;

        TotalAllowables := curDefinedContrib + curPensionStaff + AllAllowables; //curPensionStaff
        curTransAmount := TotalAllowables;
        strTransDescription := 'Allowables';
        TGroup := 'Tax Calculations';
        TGroupOrder := 6;
        TSubGroupOrder := 2;

        fnUpdatePeriodTrans(strEmpCode, 'ALLOWABLES', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        '', Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

        //Message('Allowables', curTransAmount);

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 1, '<');
    end;


    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
        SysDate.SetFilter(SysDate."Period No.", '1..7');
        if SysDate.Find('-') then
            DaysInMonth := SysDate.Count;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[50]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Enum "Gen. Journal Account Type"; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
    var
        PRPeriodTransactions: Record "PR Period Transactions";
        HRBankAccounts: Record "HR Employee Bank Accounts";
        curNetPay_2: Decimal;
    begin
        //******************************************************************************************************************************************
        /* Added Dann. for Multiple bank A/Cs                                                                                                       */
        //******************************************************************************************************************************************
        if TCode = 'NPAY' then begin
            HRBankAccounts.Reset;
            HRBankAccounts.SetRange(HRBankAccounts."Employee Code", EmpCode);
            if HRBankAccounts.Find('-') then begin
                repeat

                    HRBankAccounts.TestField(HRBankAccounts."Bank  Code");
                    HRBankAccounts.TestField(HRBankAccounts."Branch Code");
                    HRBankAccounts.TestField(HRBankAccounts."A/C  Number");
                    HRBankAccounts.TestField(HRBankAccounts."Percentage to Transfer");

                    HRBankSummary.Reset;
                    HRBankSummary.Init;

                    HRBankSummary."Line No." := GetLastEntryNo;
                    HRBankSummary."Bank Code" := HRBankAccounts."Bank  Code";
                    HRBankSummary."Branch Code" := HRBankAccounts."Branch Code";
                    HRBankSummary."Payroll Period" := dtOpenPeriod;
                    HRBankSummary.Amount := ROUND((curAmount * HRBankAccounts."Percentage to Transfer" / 100), 0.1, '=');
                    HRBankSummary."Transaction Code" := 'NPAY';
                    HRBankSummary."Staff No." := EmpCode;
                    HRBankSummary."Bank Name" := UpperCase(HRBankAccounts."Bank Name");
                    HRBankSummary."Branch Name" := UpperCase(HRBankAccounts."Branch Name");

                    HRBankSummary."% NPAY" := HRBankAccounts."Percentage to Transfer";
                    if HRBankSummary.Amount > 0 then HRBankSummary.Insert;

                until HRBankAccounts.Next = 0;
            end else begin
                //ERROR('No Bank A/C has been specified for [Employee No %1]',EmpCode);
            end;
        end;
        //******************************************************************************************************************************************
        //******************************************************************************************************************************************


        if curAmount = 0 then exit;
        begin
            PRPeriodTransactions.Init;
            PRPeriodTransactions."Employee Code" := EmpCode;
            PRPeriodTransactions."Transaction Code" := TCode;
            PRPeriodTransactions."Group Text" := TGroup;
            PRPeriodTransactions."Transaction Name" := Description;
            PRPeriodTransactions.Amount := curAmount;
            PRPeriodTransactions.Balance := curBalance;
            PRPeriodTransactions."Original Amount" := PRPeriodTransactions.Balance;
            PRPeriodTransactions."Group Order" := GroupOrder;
            PRPeriodTransactions."Sub Group Order" := SubGroupOrder;
            //PRPeriodTransactions.Membership := mMembership;
            PRPeriodTransactions."Reference No" := ReferenceNo;
            PRPeriodTransactions."Period Month" := Month;
            PRPeriodTransactions."Period Year" := Year;
            PRPeriodTransactions."Payroll Period" := dtOpenPeriod;
            PRPeriodTransactions."Department Code" := Department;
            PRPeriodTransactions."Journal Account Type" := JournalACType;
            PRPeriodTransactions."Post As" := PostAs;
            PRPeriodTransactions."Journal Account Code" := JournalAC;
            PRPeriodTransactions."Loan Number" := LoanNo;
            PRPeriodTransactions."coop parameters" := CoopParam;
            // Insert() Scheme Code and Contract Type for each Trans Being Updated
            HREmp2.Reset;
            if HREmp2.Get(EmpCode) then begin
                PRPeriodTransactions."Global Dimension 1 Code" := HREmp2."Global Dimension 1 Code";
                PRPeriodTransactions."Contract Type" := HREmp2."Contract Type";

            end;
            //Insert Transaction Type (Either "Income or Deduction") for each Trans Being Updated
            PRTransCode.Reset;
            PRTransCode.SetRange(PRTransCode."Transaction Code", TCode);
            if PRTransCode.Find('-') then begin
                PRPeriodTransactions."Transaction Type" := PRTransCode."Transaction Type";
                if PRTransCode."Is HLEVY" = true then
                    PRPeriodTransactions."Not Levied" := true;
            end;

            PRPeriodTransactions.Insert;
            //Update the prEmployee Transactions  with the Amount
            fnUpdateEmployeeTrans(PRPeriodTransactions."Employee Code", PRPeriodTransactions."Transaction Code", PRPeriodTransactions.Amount, PRPeriodTransactions."Period Month", PRPeriodTransactions."Period Year", PRPeriodTransactions."Payroll Period");
        end;

    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Enum "Special Transactions"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "PR Employee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
        MortgageInterest: Decimal;
        MortgageRelief: Decimal;
    begin
        SpecialTransAmount := 0;
        MortgageInterest := 0;


        prTransactionCodes.Reset;
        //if intSpecTransID = intSpecTransID::"Affordable Housing" then
        //prTransactionCodes."Special Transactions" := prTransactionCodes."Special Transactions"::"Affordable Housing";
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        prTransactionCodes.SetRange(prTransactionCodes."Not Pension", false);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := '';
                                if prTransactionCodes."Not Pension" = false then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                    SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml));
                                end else
                                    if prTransactionCodes."Not Pension" = true then begin
                                        strExtractedFrml := fnPurelevyFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                        SpecialTransAmount := Round(SpecialTransAmount + (fnFormulaResult(strExtractedFrml)), 0.01, '<');
                                    end;
                                //Get the calculated amount for the Special Transaction
                            end else
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        Intspectransid::"Home Ownership Savings Plan":
                            begin
                                SpecialTransAmount := SpecialTransAmount + ((AffordableHRelief / 100) * prEmployeeTransactions.Amount);
                                if SpecialTransAmount > CurAffordableHousingMax then SpecialTransAmount := CurAffordableHousingMax;
                            end;

                        Intspectransid::"Affordable Housing":
                            begin
                                SpecialTransAmount := SpecialTransAmount + ((AffordableHRelief / 100) * prEmployeeTransactions.Amount);
                                if SpecialTransAmount > CurAffordableHousingMax then SpecialTransAmount := CurAffordableHousingMax;
                            end;
                        Intspectransid::Pension:
                            begin
                                SpecialTransAmount := SpecialTransAmount + ((curReliefPension / 100) * prEmployeeTransactions.Amount);
                                if SpecialTransAmount > curMaxPensionContrib then SpecialTransAmount := curMaxPensionContrib
                            end;

                        Intspectransid::Mortgage:
                            begin
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                if SpecialTransAmount > curReliefMorgage then begin
                                    SpecialTransAmount := curReliefMorgage
                                end;
                            end;

                        //Dann
                        Intspectransid::"Mortgage Relief":
                            begin
                                //Intrest = 6%/12 * Curr Balance
                                // MortgageInterest:=(0.05/12) * prEmployeeTransactions.Balance;
                                MortgageInterest := (prEmployeeTransactions."Loan Interest Rate" / 12) * prEmployeeTransactions."Interest Due";

                                if MortgageInterest < curReliefMorgage then begin
                                    MortgageRelief := MortgageInterest;//0.3 * MortgageInterest
                                end;

                                if MortgageInterest > curReliefMorgage then begin
                                    MortgageRelief := curReliefMorgage;//0.3 * curReliefMorgage;
                                end;

                                SpecialTransAmount := MortgageRelief;
                            end;
                    //Dann

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
        PayeFinal: Decimal;
    begin
        KeepCount := 0;

        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxablePay < prPAYE."PAYE Tier" then exit;
            repeat
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                if curTaxablePay = 0 then exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxablePay := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PayeFinal := Round((curTempAmount * (prPAYE.Rate / 100)), 0.01, '>');

                PAYE := PAYE + PayeFinal; //chacha
                curTaxablePay := curTaxablePay - curTempAmount;

            until prPAYE.Next = 0;
        end;
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record prNHIF;
    begin
        prNHIF.Reset;
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            if prNHIF.banded = false then begin
                repeat
                    if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                        NHIF := prNHIF.Amount;
                until prNHIF.Next = 0;
            end else
                NHIF := (curBaseAmount * prNHIF."NHIF Employee") * 0.01;
        end;
    end;


    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
        prTransactionCodes: record "PR Transaction Codes";
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;



    procedure fnPurelevyFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
        prTransactionCodes: record "PR Transaction Codes";
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmoun n
                TransCodeAmount := fnGetNotLeviedTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "PR Employee Transactions";
        prPeriodTransactions: Record "PR Period Transactions";
    begin
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
        if prEmployeeTransactions.FindFirst then
            TransAmount := prEmployeeTransactions.Amount;

        if TransAmount = 0 then begin
            prPeriodTransactions.Reset;
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
            if prPeriodTransactions.FindFirst then
                TransAmount := prPeriodTransactions.Amount;
        end;
    end;


    procedure fnGetNotLeviedTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "PR Employee Transactions";
        prPeriodTransactions: Record "PR Period Transactions";
        prTransactionCodes: record "PR Transaction Codes";
        NonLevied: decimal;
    begin
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.FindFirst then
            TransAmount := prEmployeeTransactions.Amount;

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false); //Added DW to not process Stopped Transactions
        if prEmployeeTransactions.Find('-') then begin
            NonLevied := 0;
            repeat

                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                prTransactionCodes.SetRange(prTransactionCodes."Is HLEVY", true);
                if prTransactionCodes.Find('-') then begin
                    NonLevied := NonLevied + prEmployeeTransactions.Amount;
                end;
            until prEmployeeTransactions.next = 0;
        end;

        if TransAmount = 0 then begin
            prPeriodTransactions.Reset;
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
            //prPeriodTransactions.SetRange(prPeriodTransactions."Not Levied", true);
            if prPeriodTransactions.FindFirst then
                TransAmount := Round(prPeriodTransactions.Amount - NonLevied, 0.01, '>');
        end;
    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin


        Results := Round(AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr), 0.01, '>');


    end;


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "PR Employee Transactions";
        prPeriodTransactions: Record "PR Period Transactions";
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "PR Transaction Codes";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "PR Employee Transactions";
        prPayrollPeriods: Record "PR Payroll Periods";
        prNewPayrollPeriods: Record "PR Payroll Periods";
        CreateTrans: Boolean;
    begin
        //MESSAGE('Also include function to reset No. of days worked');
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Stopped, false);
        if prEmployeeTransactions.Find('-') then begin
            repeat
                if not prEmployeeTransactions."Stop for Next Period" then begin
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");

                    if prTransactionCodes.Find('-') then begin
                        begin
                            case prTransactionCodes."Balance Type" of
                                prTransactionCodes."balance type"::None:
                                    begin

                                        curTransAmount := prEmployeeTransactions.Amount;
                                        curTransBalance := 0;
                                    end;
                                prTransactionCodes."balance type"::Increasing:
                                    begin
                                        curTransAmount := prEmployeeTransactions.Amount;
                                        curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                        //****
                                        //Added DW to Include Subledger and Subledger Account for the next period
                                        if prEmployeeTransactions.Subledger <> prEmployeeTransactions.Subledger::" " then begin
                                            curTransSubledger := prEmployeeTransactions.Subledger;
                                            curTransSubledgerAccount := prEmployeeTransactions."Subledger Account";
                                        end;
                                        //****

                                    end;
                                prTransactionCodes."balance type"::Reducing:
                                    begin
                                        curTransAmount := prEmployeeTransactions.Amount;
                                        if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                            curTransAmount := prEmployeeTransactions.Balance;
                                            curTransBalance := 0;
                                        end else begin
                                            curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                        end;
                                        if curTransBalance < 0 then begin
                                            curTransAmount := 0;
                                            curTransBalance := 0;
                                        end;
                                    end;
                            end;
                        end;
                    end;

                    //For those transactions with Start and End Date Specified
                    if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
                        if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                        end;
                    end;
                    //End Transactions with Start and End Date

                    if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                       (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                     begin
                        if (curTransAmount <> 0) then  //Update the employee transaction table
                         begin
                            if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
                             (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
                                if not prEmployeeTransactions.Variated then begin
                                    prEmployeeTransactions.Balance := curTransBalance;
                                    prEmployeeTransactions.Modify;
                                end;


                            //Clear(prEmployeeTrans);
                            prEmployeeTrans.Init;
                            prEmployeeTrans."Employee Code" := prEmployeeTransactions."Employee Code";
                            prEmployeeTrans."Transaction Code" := prEmployeeTransactions."Transaction Code";
                            prEmployeeTrans."Transaction Name" := prEmployeeTransactions."Transaction Name";

                            //IF NOT prEmployeeTrans.Variated THEN BEGIN  //variated pMN
                            prEmployeeTrans.Amount := curTransAmount;
                            // END;

                            prEmployeeTrans.Balance := curTransBalance;
                            prEmployeeTrans."Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
                            prEmployeeTrans."Original Amount" := prEmployeeTransactions."Original Amount";
                            //prEmployeeTrans.Membership := prEmployeeTransactions.Membership;
                            //prEmployeeTrans."Reference No" := prEmployeeTransactions."Reference No";
                            prEmployeeTrans."Period Month" := intNewMonth;
                            prEmployeeTrans."Period Year" := intNewYear;
                            prEmployeeTrans."Payroll Period" := dtNewPeriod;
                            prEmployeeTrans."Loan Interest Rate" := prEmployeeTransactions."Loan Interest Rate";
                            prEmployeeTrans."Loan Number" := prEmployeeTransactions."Loan Number";
                            prEmployeeTrans.Variated := prEmployeeTransactions.Variated;

                            //Added DW to Insert Subledger and Subledger Account for the next period
                            if curTransSubledger <> Curtranssubledger::" " then begin
                                prEmployeeTrans.Subledger := curTransSubledger;
                                prEmployeeTrans."Subledger Account" := curTransSubledgerAccount;

                            end;
                            prEmployeeTrans.Insert;
                            // prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", prEmployeeTransactions."Transaction Code");
                            // prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", dtNewPeriod);
                            // prEmployeeTrans.SetRange(prEmployeeTrans."Period Year", intNewYear);
                            // prEmployeeTrans.SetRange(prEmployeeTrans."Period Month", intNewMonth);
                            // if prEmployeeTrans.Find('-') then
                            //     //prEmployeeTrans.DeleteAll;

                            // Clear(prEmployeeTrans);
                        end;
                    end;
                end;
            until prEmployeeTransactions.Next = 0;
        end;

        //Update the Period as Closed
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods."Closed By" := UserId;
            prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        prNewPayrollPeriods.Init;
        prNewPayrollPeriods."Period Month" := intMonth + 1;
        prNewPayrollPeriods."Period Year" := intNewYear;
        prNewPayrollPeriods."Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + '' + Format(intNewYear);
        prNewPayrollPeriods."Date Opened" := dtNewPeriod;
        prNewPayrollPeriods."Opened By" := UserId;
        prNewPayrollPeriods.Closed := false;
        prNewPayrollPeriods.Insert;

        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);


        /*
        //Reset no. of days worked for casuals
        PRSalCard.RESET;
        PRSalCard.SETRANGE(PRSalCard."Employee Contract Type",'CASUALS');
        IF PRSalCard.FIND('-') THEN
        BEGIN
            REPEAT
                PRSalCard."No. of Days Worked":=0;
                PRSalCard.MODIFY;
            UNTIL PRSalCard.NEXT = 0;
        END;
        */

    end;


    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "PR Period Transactions";
        prEmployeeTransactions: Record "PR Employee Transactions";
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then begin
            repeat
            begin/////confirm

                prEmployeeTransactions.Init;
                prEmployeeTransactions."Employee Code" := prPeriodTransactions."Employee Code";
                prEmployeeTransactions."Transaction Code" := 'NEGP';
                prEmployeeTransactions."Transaction Name" := 'Negative Pay';
                prEmployeeTransactions.Amount := prPeriodTransactions.Amount;
                prEmployeeTransactions.Balance := 0;
                prEmployeeTransactions."Original Amount" := 0;
                prEmployeeTransactions."Period Month" := intNewMonth;
                prEmployeeTransactions."Period Year" := intNewYear;
                prEmployeeTransactions."Payroll Period" := dtNewPeriod;
                prEmployeeTransactions.Insert;
            end;
            until prPeriodTransactions.Next = 0;
        end;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date)
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        p9SHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record "PR Period Transactions";
        prEmployee: Record "HR Employees";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        p9SHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
        //prEmployee.SETFILTER(prEmployee."Employee Contract Type",'<>%1','CASUALS'); //Remove
        if prEmployee.Find('-') then begin
            repeat

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                p9SHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                if prPeriodTransactions.Find('-') then begin
                    repeat
                    begin
                        case prPeriodTransactions."Group Order" of
                            1: //Basic pay & Arrears
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9BasicPay := prPeriodTransactions.Amount; //Basic Pay
                                    if prPeriodTransactions."Sub Group Order" = 2 then P9BasicPay := P9BasicPay + prPeriodTransactions.Amount; //Basic Pay Arrears
                                end;
                            3:  //Allowances
                                begin
                                    P9Allowances := P9Allowances + prPeriodTransactions.Amount
                                end;
                            4: //Gross Pay
                                begin
                                    P9GrossPay := prPeriodTransactions.Amount
                                end;
                            6: //Taxation
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9DefinedContribution := prPeriodTransactions.Amount; //Defined Contribution
                                    if prPeriodTransactions."Sub Group Order" = 9 then P9TaxRelief := prPeriodTransactions.Amount; //Tax Relief
                                    if prPeriodTransactions."Sub Group Order" = 8 then P9InsuranceRelief := prPeriodTransactions.Amount; //Insurance Relief
                                    if prPeriodTransactions."Sub Group Order" = 6 then P9TaxablePay := prPeriodTransactions.Amount; //Taxable Pay
                                    if prPeriodTransactions."Sub Group Order" = 7 then P9TaxCharged := prPeriodTransactions.Amount; //Tax Charged
                                end;
                            7: //Statutories
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9NSSF := prPeriodTransactions.Amount; //Nssf
                                    if prPeriodTransactions."Sub Group Order" = 2 then p9SHIF := prPeriodTransactions.Amount; //Nhif
                                    if prPeriodTransactions."Sub Group Order" = 3 then P9Paye := prPeriodTransactions.Amount; //paye
                                    if prPeriodTransactions."Sub Group Order" = 4 then P9Paye := P9Paye + prPeriodTransactions.Amount; //Paye Arrears
                                end;
                            8://Deductions
                                begin
                                    P9Deductions := P9Deductions + prPeriodTransactions.Amount;
                                end;
                            9: //NetPay
                                begin
                                    P9NetPay := prPeriodTransactions.Amount;
                                end;
                        end;
                    end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details
                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        p9SHIF, P9Deductions, P9NetPay, dtCurPeriod);

            until prEmployee.Next = 0;
        end;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9SHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date)
    var
        prEmployeeP9Info: Record "PR Employee P9 Info";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        begin
            prEmployeeP9Info.Init;
            prEmployeeP9Info."Employee Code" := P9EmployeeCode;
            prEmployeeP9Info."Basic Pay" := P9BasicPay;
            prEmployeeP9Info.Allowances := P9Allowances;
            prEmployeeP9Info.Benefits := P9Benefits;
            prEmployeeP9Info."Value Of Quarters" := P9ValueOfQuarters;
            prEmployeeP9Info."Defined Contribution" := P9DefinedContribution;
            prEmployeeP9Info."Owner Occupier Interest" := P9OwnerOccupierInterest;
            prEmployeeP9Info."Gross Pay" := P9GrossPay;
            prEmployeeP9Info."Taxable Pay" := P9TaxablePay;
            prEmployeeP9Info."Tax Charged" := P9TaxCharged;
            prEmployeeP9Info."Insurance Relief" := P9InsuranceRelief;
            prEmployeeP9Info."Tax Relief" := P9TaxRelief;
            prEmployeeP9Info.PAYE := P9Paye;
            prEmployeeP9Info.NSSF := P9NSSF;
            prEmployeeP9Info.SHIF := P9SHIF;
            prEmployeeP9Info.Deductions := P9Deductions;
            prEmployeeP9Info."Net Pay" := P9NetPay;
            prEmployeeP9Info."Period Month" := intMonth;
            prEmployeeP9Info."Period Year" := intYear;
            prEmployeeP9Info."Payroll Period" := dtCurrPeriod;
            prEmployeeP9Info.Insert;
        end;
    end;


    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        SysDate.SetFilter(SysDate."Period No.", '1..7');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;


    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record "PR Employee P9 Info";
        P9BasicPay: Decimal;
        P9taxablePay: Decimal;
        P9PAYE: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPAYE: Decimal;
        PAYEVariance: Decimal;
        PAYEArrears: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
    begin
        FirstMonth := true;
        if EndDate > StartDate then begin
            while StartDate < EndDate do begin
                //fnGetEmpP9Info
                startmonth := Date2dmy(StartDate, 2);
                startYear := Date2dmy(StartDate, 3);

                "prEmployee P9 Info".Reset;
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
                if "prEmployee P9 Info".Find('-') then begin
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    if P9BasicPay > 0 then   //Staff payment history is available
                     begin
                        if FirstMonth then begin                 //This is the first month in the arrears loop
                            if Date2dmy(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
                             begin
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                if (Date2dmy(dtDOE, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(StartDate, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, false);
                                    ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                if dtTermination <> 0D then begin
                                    if (Date2dmy(dtTermination, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(StartDate, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                                        DaysWorked := fnDaysWorked(dtTermination, true);
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                    end;
                                end;

                                SalaryArrears := (CBasic - ProratedBasic)
                            end
                            else begin
                                SalaryArrears := (CBasic - P9BasicPay);
                            end;
                        end;
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        if SupposedTaxablePay > P9taxablePay then begin
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        end;
                        FirstMonth := false;               //reset the FirstMonth Boolean to False
                    end;
                end;
                StartDate := CalcDate('+1M', StartDate);
            end;
            if SalaryArrears <> 0 then begin
                PeriodYear := Date2dmy(dtOpenPeriod, 3);
                PeriodMonth := Date2dmy(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            end

        end
        else
            Error('The start date must be earlier than the end date');
    end;


    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        FirstMonth: Boolean;
        ProratedBasic: Decimal;
        SalaryVariance: Decimal;
        PayeVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPaye: Decimal;
        CurrentBasic: Decimal;
        StartDate: Date;
        "prSalary Arrears": Record "prSalary Arrears";
    begin
        "prSalary Arrears".Reset;
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code");
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Modify;
        end
    end;


    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);

        curLoanInt := 0;
        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;

        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := ROUND(curLoanInt, 1);
    end;


    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "prEmployer Deductions";
    begin

        if curAmount = 0 then exit;
        begin

            prEmployerDeductions.Init;
            prEmployerDeductions."Employee Code" := EmpCode;
            prEmployerDeductions."Transaction Code" := TCode;
            prEmployerDeductions.Amount := curAmount;
            prEmployerDeductions."Period Month" := Month;
            prEmployerDeductions."Period Year" := Year;
            prEmployerDeductions."Payroll Period" := dtOpenPeriod;
            //***********************************************************
            HREmp2.Reset;
            HREmp2.SetRange(HREmp2."No.", EmpCode);
            if HREmp2.Find('-') then begin
                HREmp2."Global Dimension 1 Code" := HREmp2."Global Dimension 1 Code";
                HREmp2."Contract Type" := HREmp2."Contract Type";
            end;
            //****************************************************************
            prEmployerDeductions.Insert;
        end;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
        curTransAmount := ROUND(curTransAmount, 0.01, '>');
    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
        prEmployeeTrans: Record "PR Employee Transactions";
    begin
        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", EmpCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", PayrollPeriod);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Month", Month);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Year", Year);
        if prEmployeeTrans.Find('-') then begin
            if not prEmployeeTrans.Variated then begin
                if prEmployeeTrans."Loan Number" = '' then begin
                    prEmployeeTrans.Amount := Amount;
                    prEmployeeTrans.Modify;
                end;
            end;
        end;
    end;


    procedure fnGetOpenPeriod() dtOpenPeriod: Date
    var
        "prPayroll Periods": Record "PR Payroll Periods";
        intMonth: Integer;
        intYear: Integer;
    begin
        "prPayroll Periods".Reset;
        "prPayroll Periods".SetRange("prPayroll Periods".Closed, false);

        if "prPayroll Periods".Find('-') then begin
            dtOpenPeriod := "prPayroll Periods"."Date Opened";
            intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
            intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
        end
        else begin
            Error('There is no open payroll period');
        end
    end;


    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "PR Salary Card";
        HREmp: Record "HR Employees";
    begin
        //Get Payroll Posting Accounts
        //IF SalaryCard.GET(strEmpCode) THEN BEGIN
        if HREmp.Get(strEmpCode) then begin
            if PostingGroup.Get(HREmp."Posting Group") then begin
                //Comment This for the Time Being
                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                PostingGroup.TestField("Net Salary Payable");
                PostingGroup.TestField("SSF Employer Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("SHIF Account");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Tier 1 Payable Account";
                NSSFEmpyee2 := PostingGroup."SSF Tier 2 Payable Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
                ShifAccount := PostingGroup."SHIF Account";
            end
            else
                Error('Employee No:%1 does not have a posting group', HREmp."No.")
        end;
        //End Get Payroll Posting Accounts
    end;


    procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "prNSSF Tiers";
    begin

        prNSSF.Reset;
        prNSSF.SetCurrentkey(prNSSF.Tier);
        if prNSSF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                    NSSF := prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";

                if curBaseAmount < 108000 then begin
                    NSSF := prNSSF."Tier 1 Employer Contribution" + (0.06 * (curBaseAmount - prNSSF."Lower Limit"));
                    Exit(NSSF);
                end;
            until prNSSF.Next = 0;
        end;
    end;


    procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "prNSSF Tiers";
    begin
        prNSSF.Reset;
        prNSSF.SetCurrentkey(prNSSF.Tier);
        if prNSSF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                    NSSF := prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";

                if curBaseAmount < 108000 then begin
                    NSSF := prNSSF."Tier 1 Employer Contribution" + (0.06 * (curBaseAmount - prNSSF."Lower Limit"));
                    Exit(NSSF);
                end;

            until prNSSF.Next = 0;
        end;
    end;

    local procedure GetLastEntryNo() LastLineNum: Integer
    var
        HRBankSummary_2: Record "HR Bank Summary";
    begin
        HRBankSummary_2.Reset;
        if HRBankSummary_2.Find('+') then begin
            LastLineNum := HRBankSummary_2."Line No." + 1;
        end else begin
            LastLineNum := 1000;
        end;
    end;

    procedure Overtime(Overtime: record "Overtime Claim Header")
    var
        PrTransactionCodes: record "PR Transaction Codes";
        PrEmployeeTransactions: record "PR Employee Transactions";
        dtOpenPeriod: date;
    begin
        PrEmployeeTransactions.reset;
        PrEmployeeTransactions.SetRange("Transaction Code", Overtime."Transaction Code");
        if PrEmployeeTransactions.find then PrEmployeeTransactions.DeleteAll();
        dtOpenPeriod := fnGetOpenPeriod();
        Overtime.CalcFields(Amount);
        PrEmployeeTransactions.Init();
        PrEmployeeTransactions."Employee Code" := Overtime."Staff No.";
        PrEmployeeTransactions."Payroll Period" := dtOpenPeriod;
        PrEmployeeTransactions."Transaction Code" := Overtime."Transaction Code";
        PrEmployeeTransactions.Validate("Transaction Code");
        PrEmployeeTransactions.Amount := Overtime.Amount;
        PrEmployeeTransactions.Insert;
    end;

    procedure Allowances(Allowances: record "Salary Grade Lines"; emplyCode: code[30]; PayriollP: Date)
    var
        PrTransactionCodes: record "PR Transaction Codes";
        PrEmployeeTransactions: record "PR Employee Transactions";
        dtOpenPeriod: date;
        SalGrad: Record "Salary Grade Lines";
        intMonth: Integer;
        intYear: Integer;
        NonLevied: decimal;
    begin
        dtOpenPeriod := fnGetOpenPeriod();
        intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
        intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR


        //if PrEmployeeTransactions.Frequency = PrEmployeeTransactions.Frequency::Varied then begin
        PrEmployeeTransactions.Amount := 0;
        PrEmployeeTransactions.Init();
        PrEmployeeTransactions."Employee Code" := emplyCode;
        PrEmployeeTransactions."Payroll Period" := dtOpenPeriod;
        PrEmployeeTransactions."Period Month" := intMonth;
        PrEmployeeTransactions."Salary Grade" := Allowances."Salary Grade";
        PrEmployeeTransactions."Period Year" := intYear;
        PrEmployeeTransactions."Transaction Code" := Allowances."Transaction Code";
        PrEmployeeTransactions.Validate("Transaction Code");
        PrEmployeeTransactions.Amount := Allowances.Amount;
        PrEmployeeTransactions."Original Amount" := Allowances.Amount;
        PrEmployeeTransactions.Insert;
        //end;
    end;


    procedure FixedAllowances(Allowances: record "Salary Grade Lines"; emplyCode: code[30]; PayriollP: Date)
    var
        PrTransactionCodes: record "PR Transaction Codes";
        PrEmployeeTransactions: record "PR Employee Transactions";
        dtOpenPeriod: date;
        SalGrad: Record "Salary Grade Lines";
        intMonth: Integer;
        intYear: Integer;
        NonLevied: decimal;
    begin
        dtOpenPeriod := fnGetOpenPeriod();
        intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
        intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR


        if PrEmployeeTransactions.Frequency = PrEmployeeTransactions.Frequency::Fixed then begin
            PrEmployeeTransactions.Amount := 0;
            PrEmployeeTransactions.Init();
            PrEmployeeTransactions."Employee Code" := emplyCode;
            PrEmployeeTransactions."Payroll Period" := dtOpenPeriod;
            PrEmployeeTransactions."Period Month" := intMonth;
            PrEmployeeTransactions."Salary Grade" := Allowances."Salary Grade";
            PrEmployeeTransactions."Period Year" := intYear;
            PrEmployeeTransactions.Frequency := PrEmployeeTransactions.Frequency::Fixed;
            PrEmployeeTransactions."Transaction Code" := Allowances."Transaction Code";
            PrEmployeeTransactions.Validate("Transaction Code");
            PrEmployeeTransactions.Amount := Allowances.Amount;
            PrEmployeeTransactions."Original Amount" := Allowances.Amount;
            PrEmployeeTransactions.Insert;
        end
    end;
    //end;

}
