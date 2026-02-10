#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185502 "prShift PayrollProcessing"
{
    // ++Note
    // Tax on Excess Pension Not Clear /Not indicated anywhere
    // Low Interest Benefits
    // VOQ


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
        curReliefMorgage: Decimal;
        curReliefChild: Decimal;
        curReliefDependant: Decimal;
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curNHFPerc: Decimal;
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "prEmployee Posting Group";
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        PensionEMPyee: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "HR Employees";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
        PayrollType: Code[20];
        curReliefGrossPerc: Decimal;
        MonthlyReliefAmount: Decimal;
        EmployerAmount: Decimal;
        EmployerBalance: Decimal;
        VitalSetupS: Record "HR Employees";
        TotalTaxable: Decimal;
        Trans: Record "PR Transaction Codes";
        Employee: Record "HR Employees";
        EmpTrans: Record "PR Employee Transactions";
        curTaxDeductions: Decimal;
        RemainingDays: Integer;
        TDate: Date;
        i: Integer;
        ArrearsDays: Integer;
        MonthDays: Integer;
        PayTillCutOff: Boolean;
        NoOfUnits: Decimal;
        ProrateAbsence: Boolean;
        SalCard: Record "PR Salary Card";
        DayAbsent: Decimal;
        currAnnualPay: Decimal;
        statTaxPay: Decimal;
        DontProrateBPAY: Boolean;
        ExcludeNonTaxRelief: Boolean;
        ProrateAbsBP: Boolean;
        ProrateAbsMonthDays: Boolean;
        ExcludeMonthlyRelief: Boolean;
        curNssfEmployeeFormula: Code[20];
        SelectedPayrollPeriod: Date;
        PeriodTransAmountFCY: Decimal;
        PeriodTransCurrrency: Code[10];
        PeriodTransAmountLCY: Decimal;
        DOM: Integer;
        AngolaPayroll: Boolean;
        SSFBasedOn: Option " ",Basic,Gross,Taxable;
        NewSSFEmployee: Decimal;
        NewSSFEmployer: Decimal;
        OldSSFEmployee: Decimal;
        OldSSFEmployer: Decimal;
        PFEmployee: Decimal;
        PFEmployer: Decimal;
        PFIsAfterTax: Boolean;
        MaxSSF: Decimal;
        ExcessSSF: Decimal;
        "HR-Employee": Record "HR Employees";
        Amount13th: Decimal;
        Perc: Decimal;
        PayrollPeriodR: Record "PR Payroll Periods";
        PeriodTrans: Record "PR Period Transactions";
        BonusPAYE: Decimal;
        BonusNetPay: Decimal;
        PayEmploymenTax: Boolean;
        EmploymentTaxPercent: Decimal;
        EmploymentTax: Decimal;
        PretaxDeductions: Decimal;
        MaxSSFEmployee: Decimal;
        MaxSSFEmployer: Decimal;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        begin
            // curReliefPersonal := "Tax Relief";
            // curReliefInsurance := "Insurance Relief";
            // curReliefMorgage := "Mortgage Relief"; //Same as HOSP
            // curMaximumRelief := "Max Relief";
            // //curReliefChild := "Child Relief";
            // //curReliefDependant:= "Dependants Relief";
            // curNssfEmployee := "NSSF Employee";
            // curNssf_Employer_Factor := "NSSF Employer Factor";
            // intNHIF_BasedOn := "NHIF Based on";
            // // curNHFPerc:= "NHF - % of Basic Pay";
            // curMaxPensionContrib := "Max Pension Contribution";
            // curRateTaxExPension := "Tax On Excess Pension";
            // curOOIMaxMonthlyContrb := "OOI Deduction";
            // curOOIDecemberDedc := "OOI December";
            // curLoanMarketRate := "Loan Market Rate";
            // curLoanCorpRate := "Loan Corporate Rate";
            // curReliefGrossPerc := VitalSetup."Tax Relief % of Gross Income";
            // ProrateAbsence := VitalSetup."Prorate Absence";
            //  DontProrateBPAY := VitalSetup."Don't Prorate Basic Pay";
            // ProrateAbsBP := VitalSetup."Prorate Absence Basic Pay";
            // ProrateAbsMonthDays := VitalSetup."Prol. Absence on days in month";
            // ExcludeNonTaxRelief := VitalSetup."Exclude NonTax from Relief";
            // ExcludeMonthlyRelief := VitalSetup."Exclude Monthly Relief";
            //AngolaPayroll := VitalSetup."Angola Payroll";
            /*
            SSFBasedOn := VitalSetup."SSF Based on";
            NewSSFEmployee := VitalSetup."New SSF Employee %";
            NewSSFEmployer := VitalSetup."New SSF Employer %";
            OldSSFEmployee := VitalSetup."Old SSF Employee %";
            OldSSFEmployer := VitalSetup."Old SSF Employer %";
            MaxSSF := VitalSetup."Max. SSF Contribution";
            MaxSSFEmployee := VitalSetup."NSSF Employee";
            MaxSSFEmployer := VitalSetup."NSSF Employer Factor";
            PFEmployee := VitalSetup."PF Employee %";
            PFEmployer := VitalSetup."PF Employer %";
            PFIsAfterTax := VitalSetup."PF is After Tax";
            PayEmploymenTax := VitalSetup."Pay Employment Tax";
            EmploymentTaxPercent := VitalSetup."Employment Tax %";
            */
        end;

    end;


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysSSf: Boolean; blnPaysPF: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20])
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
        DaysWorked: Decimal;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "PR Employee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "prUnused Relief";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "prEmployer Deductions";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        Text021: label 'This application is not licensed on this server. Contact your systems administrator.';
        blnDoesPaysPayeOnBasic: Boolean;
        fullBasicPay: Decimal;
        prLatenessSummary: Record prLatenessLedger;
        PrOtherSetups: Record PrOtherSetups;
        checkmorethan5days: Decimal;
        curSSF: Decimal;
        curSSFEmployer: Decimal;
        curPF: Decimal;
        curPFEmployer: Decimal;
    begin
        /*
        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);
        SelectedPayrollPeriod := SelectedPeriod;
        
        prPeriodTransactions.RESET;
        prPeriodTransactions.SETRANGE("Employee Code",strEmpCode);
        prPeriodTransactions.SETRANGE("Payroll Period",SelectedPeriod);
        prPeriodTransactions.DELETEALL;
        
        
        //PKK
        //PayrollType
        PayrollType:=PayrollCode;
        
        //check if the period selected=current period. If not, do NOT run this function
        IF SelectedPeriod <> dtOpenPeriod THEN EXIT;
        intMonth:=DATE2DMY(SelectedPeriod,2);intYear:=DATE2DMY(SelectedPeriod,3);
        
        
        //ADDED TO CATER FOR THE 13TH MONTH SALARY
        PayrollPeriodR.RESET;
        PayrollPeriodR.SETRANGE(PayrollPeriodR."Date Opened",SelectedPeriod);
        IF PayrollPeriodR.FIND('-') THEN BEGIN
        IF PayrollPeriodR."Period Month" <> 13 THEN BEGIN
        
        
              DOM := fnDaysInMonth(SelectedPeriod);
        
              //PKK
              DayAbsent:=0;
        
        
              //insert the lateness ledger
              prLatenessSummary.RESET;
              prLatenessSummary.SETRANGE(prLatenessSummary."Employee Code",strEmpCode);
              prLatenessSummary.SETRANGE(prLatenessSummary."Payroll Period",SelectedPeriod);
              IF prLatenessSummary.FINDSET THEN
              BEGIN
                PrOtherSetups.RESET;
                PrOtherSetups.SETRANGE(PrOtherSetups."Transaction Code",prLatenessSummary."Transaction Code");
                PrOtherSetups.SETRANGE(PrOtherSetups.Range,prLatenessSummary."No. Of Days");
                PrOtherSetups.FINDSET;
        
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETRANGE("Employee Code",strEmpCode);
                prEmployeeTransactions.SETRANGE("Transaction Code",prLatenessSummary."Transaction Code");
                prEmployeeTransactions.SETRANGE("Payroll Period",SelectedPeriod);
                prEmployeeTransactions.DELETEALL;
        
                prEmployeeTransactions.INIT;
                prEmployeeTransactions."Employee Code" := strEmpCode;
                prEmployeeTransactions.VALIDATE("Transaction Code",prLatenessSummary."Transaction Code");
                Trans.GET(prLatenessSummary."Transaction Code");
                prEmployeeTransactions."Transaction Name" := Trans."Transaction Name";
                prEmployeeTransactions."Period Month" := intMonth;
                prEmployeeTransactions."Period Year" := intYear;
                prEmployeeTransactions.VALIDATE("Payroll Period",SelectedPeriod);
                IF PrOtherSetups.Amount <> 0 THEN
                  prEmployeeTransactions.Amount := PrOtherSetups.Amount
                ELSE
                 BEGIN
                  IF PrOtherSetups."Period Type" = PrOtherSetups."Period Type"::Day THEN
                    prEmployeeTransactions."No of Units":= PrOtherSetups.Period
                  ELSE
                    prEmployeeTransactions."No of Units":= PrOtherSetups.Period * DATE2DMY(CALCDATE('CM',DMY2DATE(1,intMonth,intYear)),1);
                 END;
                SalCard.GET(strEmpCode);
               // prEmployeeTransactions.Currency := SalCard.Currency;
                prEmployeeTransactions.INSERT(TRUE);
              END;
        
              IF ProrateAbsence = TRUE THEN BEGIN
              Trans.RESET;
              //Trans.SETRANGE(Trans."Excl. from Basic Pay",TRUE);  //have all that affect basic pay
              IF Trans.FINDSET THEN
              REPEAT
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",Trans."Transaction Code"); //have all that affect basic pay
                //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",'ABS'); //have all with No. of units
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Payroll Period",SelectedPeriod);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                prEmployeeTransactions.SETFILTER(prEmployeeTransactions."No of Units",'>%1',0);
                 IF prEmployeeTransactions.FIND('-') THEN BEGIN
                  DayAbsent += prEmployeeTransactions."No of Units";
                 END;
              UNTIL Trans.NEXT = 0;
              END;
        
              //added for currency conversion ghana
              SalCard.GET(strEmpCode);
             // blnDoesPaysPayeOnBasic := SalCard."Does Not Pay PAYE On Basic";
              IF SalCard.Currency <> '' THEN
              BEGIN
                curBasicPay := fnCurrencyConv(SalCard.Currency,SelectedPeriod,curBasicPay,TRUE);
              END;
        
              fullBasicPay := curBasicPay;
        
              //Commented to allow processing for Board Members who only get allowances and no Basic Pay
              //IF curBasicPay >0 THEN BEGIN
        
              //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
              IF (DATE2DMY(dtDOE,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtDOE,3)=DATE2DMY(dtOpenPeriod,3))THEN BEGIN
        
                  CountDaysofMonth:=fnDaysInMonth(dtDOE);
                  DaysWorked:=fnDaysWorked(dtDOE,FALSE);
                  //PKK
                  i:=0;
                  RemainingDays:=0;
                  ArrearsDays:=0;
                  //PKK
                  IF DontProrateBPAY = FALSE THEN //PKK
                  curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,DaysWorked,CountDaysofMonth);
              END;
        
              //PKK Prorate Absence
              IF (ProrateAbsence = TRUE) AND (ProrateAbsBP = TRUE) THEN BEGIN
              IF (DayAbsent > 0) AND (curBasicPay > 0) THEN BEGIN
              CountDaysofMonth:=fnDaysInMonth(SelectedPeriod);
              DaysWorked:=fnDaysWorked(SelectedPeriod,FALSE);
        
              IF ProrateAbsMonthDays = TRUE THEN
              curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,CountDaysofMonth-DayAbsent,CountDaysofMonth)
              ELSE
              curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,22-DayAbsent,22);
        
              END;
              END;
              //PKK Prorate Absence
        
        
              //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
              IF dtTermination<>0D THEN BEGIN
              IF (DATE2DMY(dtTermination,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(dtOpenPeriod,3))THEN BEGIN
              CountDaysofMonth:=fnDaysInMonth(dtTermination);
              DaysWorked:=fnDaysWorked(dtTermination,TRUE);    //error('%1, %2, %3',countdaysofmonth,dttermination,daysworked);
              DaysWorked := CountDaysofMonth - DaysWorked;
              curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,DaysWorked,CountDaysofMonth)
              END;
              END;
        
              //added to ensure absentism and lateness are reflected in the reports**Anthony
              IF fullBasicPay <> curBasicPay THEN
               BEGIN
                //error('%1 for %2 for %3',strEmpCode,fullBasicPay,curbasicpay);
                curTransAmount := fullBasicPay;
                strTransDescription := 'Basic Pay';
                TGroup := 'BASIC SALARY'; TGroupOrder := 1; TSubGroupOrder := 0;
                NoOfUnits:=0;
                fnUpdatePeriodTrans(strEmpCode, 'BPAYFULL', TGroup, TGroupOrder,
                TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,
                salariesAcc,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                curTransAmount := fullBasicPay - curBasicPay;
                //divide the transaction amount into the different components
                  Trans.RESET;
                  Trans.SETRANGE(Trans."Excl. from Basic Pay",TRUE);
                  IF Trans.FINDSET THEN
                  REPEAT
                    prEmployeeTransactions.RESET;
                    prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
                    prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
                    prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",Trans."Transaction Code"); //have all that affect basic pay
                    prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Payroll Period",SelectedPeriod);
                    prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                    prEmployeeTransactions.SETFILTER(prEmployeeTransactions."No of Units",'>%1',0);
                     IF prEmployeeTransactions.FIND('-') THEN BEGIN
                          strTransDescription := prEmployeeTransactions."Transaction Name";
                          TGroup := 'BASIC SALARY'; TGroupOrder := 1; TSubGroupOrder := 1;
                          NoOfUnits:=0;
                          fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder,
                          TSubGroupOrder, strTransDescription, curTransAmount*(prEmployeeTransactions."No of Units"/DayAbsent), 0, intMonth, intYear,Membership,'BPAY',SelectedPeriod,Dept,
                          salariesAcc,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);
                     END;
                  UNTIL Trans.NEXT = 0;
               END;
        
               curTransAmount := curBasicPay;
               strTransDescription := 'Basic Pay';
               TGroup := 'BASIC SALARY'; TGroupOrder := 1; TSubGroupOrder := 2;
               NoOfUnits:=0;
               fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
               TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,
               salariesAcc,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                //Added for Countries which pay Employment Tax
                IF PayEmploymenTax THEN BEGIN
                EmploymentTax := 0;
                EmploymentTax := EmploymentTaxPercent/100 * curBasicPay;
        
                //Make Employer Deductions entries
                IF EmploymentTax > 0 THEN
                fnUpdateEmployerDeductions(strEmpCode, 'EMPTAX','EMP', TGroupOrder, TSubGroupOrder,'', EmploymentTax, 0, intMonth, intYear,
                prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod);
        
                END;
        
        
              IF blnDoesPaysPayeOnBasic = TRUE THEN
              curNonTaxable := curNonTaxable + curBasicPay; //**changes to exclude BPAY from PAYE
        
               //Salary Arrears
               prSalaryArrears.RESET;
               prSalaryArrears.SETRANGE(prSalaryArrears."Employee Code",strEmpCode);
               prSalaryArrears.SETRANGE(prSalaryArrears."Period Month",intMonth);
               prSalaryArrears.SETRANGE(prSalaryArrears."Period Year",intYear);
               IF prSalaryArrears.FIND('-') THEN BEGIN
               REPEAT
                    curSalaryArrears := prSalaryArrears."Salary Arrears";
                    curPayeArrears := prSalaryArrears."PAYE Arrears";
        
                    //Insert [Salary Arrears] into period trans [ARREARS]
                    curTransAmount := curSalaryArrears;
                    strTransDescription := 'Salary Arrears';
                    TGroup := 'ARREARS'; TGroupOrder := 1; TSubGroupOrder := 3;
                    NoOfUnits:=0;
                    fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,salariesAcc,
                      JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                    //Insert [PAYE Arrears] into period trans [PYAR]
                    curTransAmount:= curPayeArrears;
                    strTransDescription := 'P.A.Y.E Arrears';
                    TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 4;
                    NoOfUnits:=0;
                    fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,
                       TaxAccount,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none)
        
               UNTIL prSalaryArrears.NEXT=0;
               END;
        
               //Get Earnings
               currAnnualPay:=0;
        
              fnUpdateEmployeeTransCurrency(strEmpCode,SelectedPeriod); //**changes** all transaction to lcy so to ease related calculations
        
               prEmployeeTransactions.RESET;
               prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
               prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
               prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
               prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
               prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
               IF prEmployeeTransactions.FIND('-') THEN BEGIN
                  curTotAllowances:= 0;
                 IsCashBenefit:=0;
                 REPEAT
                   prTransactionCodes.RESET;
                   prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
                   prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Income);
                   prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions",prTransactionCodes."Special Transactions"::Ignore);
                   IF prTransactionCodes.FIND('-') THEN BEGIN
                     curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';
        
                     IF prTransactionCodes."Is Formula" THEN BEGIN
                         strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                         curTransAmount := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                     END ELSE BEGIN
                         curTransAmount := prEmployeeTransactions."Amount LCY";
                     END;
        
                    IF prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::None THEN //[0=None, 1=Increasing, 2=Reducing]
                              curTransBalance := 0;
                    IF prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::Increasing THEN
                              curTransBalance := prEmployeeTransactions.Balance+ curTransAmount;
                    IF prTransactionCodes."Balance Type"= prTransactionCodes."Balance Type"::Reducing THEN
                              curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
        
        
                       //Prorate Allowances Here
                        IF prTransactionCodes."Excl. from Proration" = FALSE THEN
                          IF (DATE2DMY(dtDOE,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtDOE,3)=DATE2DMY(dtOpenPeriod,3))THEN BEGIN
                             CountDaysofMonth:=fnDaysInMonth(dtDOE);
                             DaysWorked:=fnDaysWorked(dtDOE,FALSE);
                             curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                          END
                        ELSE
                          curTransAmount := curTransAmount;
        
                        //PKK Added
              //       IF prTransactionCodes."Excl. from Proration" = TRUE THEN
              //          curTransAmount := 0;
                        //PKK Added
        
                        //PKK Prorate absence
                        IF ProrateAbsence = TRUE THEN BEGIN
                        IF prTransactionCodes."Prorate Absence" = TRUE THEN BEGIN
                        IF curTransAmount > 0 THEN BEGIN
                        IF DayAbsent > 0 THEN BEGIN
                        CountDaysofMonth:=fnDaysInMonth(SelectedPeriod);
                        DaysWorked:=fnDaysWorked(SelectedPeriod,FALSE);
        
                        IF ProrateAbsMonthDays = TRUE THEN
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,CountDaysofMonth-DayAbsent,
                                          CountDaysofMonth)
                        ELSE
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,22-DayAbsent,22);
        
                        END;
                        END;
                        END;
                        END;
        
                        //PKK Prorate absence
        
                       //{What if someone leaves within the same month they are employed}
                       IF prTransactionCodes."Excl. from Proration" = FALSE THEN BEGIN
                        IF dtTermination<>0D THEN BEGIN
                         IF (DATE2DMY(dtTermination,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(dtOpenPeriod,3))THEN
                         BEGIN
                           CountDaysofMonth:=fnDaysInMonth(dtTermination);
                           DaysWorked:=fnDaysWorked(dtTermination,TRUE);
                           DaysWorked := CountDaysofMonth - DaysWorked;
                           curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                         END;
                        END;
                       END;
                      // Prorate Allowances Here
        
        
                       //Add Non Taxable Here
                       IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" =
                       prTransactionCodes."Special Transactions"::Ignore) THEN
                           curNonTaxable:=curNonTaxable+curTransAmount;
        
                       //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                       IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" <>
                       prTransactionCodes."Special Transactions"::Ignore) THEN
                          curTransAmount:=0;
        
                       //PKK - Annual Trans
                       IF prTransactionCodes."Annual Pay" = TRUE THEN
                       currAnnualPay:=currAnnualPay+curTransAmount;
        
                       curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                       curTransAmount := curTransAmount;
                       curTransBalance := curTransBalance;
                       strTransDescription := prTransactionCodes."Transaction Name";
                       TGroup := 'ALLOWANCE'; TGroupOrder := 3; TSubGroupOrder := 0;
        
                       //Get the posting Details
                       JournalPostingType:=JournalPostingType::" ";JournalAcc:='';
                       IF prTransactionCodes.Subledger<>prTransactionCodes.Subledger::" " THEN BEGIN
                          IF prTransactionCodes.Subledger=prTransactionCodes.Subledger::Customer THEN BEGIN
                              HrEmployee.GET(strEmpCode);
                              Customer.RESET;
                              //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                              Customer.SETRANGE(Customer."No.",HrEmployee."No.");
                              IF Customer.FIND('-') THEN BEGIN
                                 JournalAcc:=Customer."No.";
                                 JournalPostingType:=JournalPostingType::Customer;
                              END;
                          END;
                       END ELSE BEGIN
                          JournalAcc:=prTransactionCodes."GL Account";
                          JournalPostingType:=JournalPostingType::"G/L Account";
                       END;
        
                        //Get is Cash Benefits
                        IF prTransactionCodes."Is Cash" THEN
                             IsCashBenefit:=IsCashBenefit+curTransAmount;
                       //End posting Details
                       NoOfUnits:=prEmployeeTransactions."No of Units";
                       fnUpdatePeriodTrans(strEmpCode,prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,prEmployeeTransactions.Membership,
                       prEmployeeTransactions."Reference No",SelectedPeriod,Dept,JournalAcc,JournalPostAs::Debit,JournalPostingType,'',
                       prTransactionCodes."coop parameters");
                   END;
                 UNTIL prEmployeeTransactions.NEXT=0;
               END;
        
               //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
               curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
        
               curTransAmount := curGrossPay;
               strTransDescription := 'Gross Pay';
               TGroup := 'GROSS PAY'; TGroupOrder := 4; TSubGroupOrder := 0;
               fnUpdatePeriodTrans (strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
                intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
        
        
               //PKK - NG Relief
               {
               //Annual Relief
               IF (((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)) >
                  (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
               MonthlyReliefAmount:=((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)
               ELSE
               MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12));
        
               //Monthly Relief
               MonthlyReliefAmount:=MonthlyReliefAmount/12;
               }
               //Annual Relief
               IF ExcludeNonTaxRelief = TRUE THEN BEGIN
               IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                  ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)) >
                  (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
               MonthlyReliefAmount:=((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01)
                                    +  ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)
               ELSE
               MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*
                                    ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay)));
        
               END ELSE BEGIN
               IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                  ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)) >
                  (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
               MonthlyReliefAmount:=((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.01)
                                    +  ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)
               ELSE
               MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*((((curGrossPay-currAnnualPay)*12)+currAnnualPay)));
               END;
        
              IF ExcludeMonthlyRelief = TRUE THEN
              MonthlyReliefAmount := 0;
        
               //Monthly Relief
               //MonthlyReliefAmount:=MonthlyReliefAmount/12;
        
        
              //PKK NG
              curTaxDeductions:=0;
        
              Trans.RESET;
              //Trans.SETRANGE(Trans.Pension,TRUE);
              Trans.SETRANGE(Trans."Add to Relief",TRUE);
              IF Trans.FIND('-') THEN BEGIN
              REPEAT
              EmpTrans.RESET;
              EmpTrans.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
              EmpTrans.SETRANGE("Employee Code",strEmpCode);
              EmpTrans.SETRANGE(EmpTrans."Transaction Code",Trans."Transaction Code");
              EmpTrans.SETRANGE("Period Month",intMonth);
              EmpTrans.SETRANGE("Period Year",intYear);
              EmpTrans.SETRANGE(Suspended,FALSE);
              IF EmpTrans.FIND('-') THEN BEGIN
              REPEAT
              curTaxDeductions:=curTaxDeductions+EmpTrans."Amount LCY";
        
              UNTIL EmpTrans.NEXT =0
              END;
              UNTIL Trans.NEXT = 0;
              END;
        
              //PKK
              //MonthlyReliefAmount:=MonthlyReliefAmount+curTaxDeductions;
              MonthlyReliefAmount:=MonthlyReliefAmount+(curTaxDeductions*12);
              //PKK
        
               //PKKGet the N.H.F amount for the month
               curNHIF:=0;
               curNhif_Base_Amount :=0;
        
               IF intNHIF_BasedOn =intNHIF_BasedOn::Gross THEN //>NHIF calculation can be based on:
                       curNhif_Base_Amount := curGrossPay;
               IF intNHIF_BasedOn = intNHIF_BasedOn::Basic THEN
                      curNhif_Base_Amount := curBasicPay;
               IF intNHIF_BasedOn =intNHIF_BasedOn::"Taxable Pay" THEN
                      curNhif_Base_Amount := curTaxablePay;
        
              {
               IF blnPaysNhif THEN BEGIN
                curNHIF:=curNhif_Base_Amount*curNHFPerc*0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                strTransDescription := 'N.H.F';
                TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 2;
                fnUpdatePeriodTrans (strEmpCode, 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
                 NHIFEMPyee,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
               END;
              }
              //PKK
              //MonthlyReliefAmount:=MonthlyReliefAmount+curNHIF;
              MonthlyReliefAmount:=MonthlyReliefAmount+(curNHIF*12);
        
        
              IF (curReliefChild+curReliefDependant) > 0 THEN
              MonthlyReliefAmount:=MonthlyReliefAmount+ ((curReliefChild+curReliefDependant));///12 //PKK-NG
        
        
               //PKK
        
              //PKK NG
        
        
        
               curReliefPersonal:=0;
               //PKK - NG Relief
        
              {
               //Get the NSSF amount
               IF blnPaysNssf THEN
                 curNSSF := curNssfEmployee;
              }
        
               curTransAmount := curNSSF;
               strTransDescription := 'N.S.S.F';
               TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 1;
               fnUpdatePeriodTrans (strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
               strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,NSSFEMPyee,
               JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::NSSF);
        
        
               //Ghana SSF
                ExcessSSF:=0;
        
               IF blnPaysSSf THEN BEGIN
                curSSF:=0;
                curSSFEmployer:=0;
        
                HrEmployee.RESET;
                IF HrEmployee.GET(strEmpCode) THEN BEGIN
        
                  IF (HrEmployee."Direct/Indirect" = HrEmployee."Direct/Indirect"::Indirect) THEN BEGIN
                    curSSF := NewSSFEmployee/100 * curBasicPay;
                    curSSFEmployer := NewSSFEmployer/100 * curBasicPay;
                  END
                  ELSE IF (HrEmployee."Direct/Indirect" = HrEmployee."Direct/Indirect"::"2") THEN BEGIN
                    curSSF := OldSSFEmployee/100 * curBasicPay;
                    curSSFEmployer := OldSSFEmployer/100 * curBasicPay;
                  END;
                END;
        
                //Check for Maximum SSNIT contribution (Zambia)
                IF MaxSSFEmployee <> 0 THEN BEGIN
                  IF curSSF > MaxSSFEmployee THEN curSSF := MaxSSFEmployee;
                END;
                IF MaxSSFEmployer <> 0 THEN BEGIN
                  IF curSSFEmployer > MaxSSFEmployer THEN curSSFEmployer := MaxSSFEmployer;
                END;
        
        
                //Check for Maximum PAYE SSNIT contribution (Zambia)
                IF (MaxSSF <> 0) THEN BEGIN
        
                    IF (curSSF > MaxSSF) THEN BEGIN
                      //Get Excess SSF and insert it as a deduction
                      ExcessSSF:=0;
                      ExcessSSF := curSSF - MaxSSF;
                      strTransDescription := 'Excess NAPSA';
                      TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 0;
                      fnUpdatePeriodTrans (strEmpCode, 'ExcSSF', TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, ExcessSSF, 0, intMonth, intYear,'','',SelectedPeriod,Dept,NSSFEMPyee,
                      JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                      //Then make SSF to be the MaxSSF
                      curSSF := MaxSSF;
                    END;
        
                END;
        
                curTransAmount := curSSF;
                strTransDescription := 'Social Security';
                TGroup := 'STATUTORIES'; TGroupOrder := 5; TSubGroupOrder := 0;
                fnUpdatePeriodTrans (strEmpCode, 'SSF', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,NSSFEMPyee,
                JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::NSSF);
        
                //Make Employer Deductions entries
                IF curSSFEmployer > 0 THEN
                fnUpdateEmployerDeductions(strEmpCode, 'SSF','EMP', TGroupOrder, TSubGroupOrder,'', curSSFEmployer, 0, intMonth, intYear,
                prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod);
        
               END;
        
        
               //Ghana PF
               IF blnPaysPF THEN BEGIN
                curPF:=0;
                curPFEmployer:=0;
        
                    curPF := PFEmployee/100 * curBasicPay;
                    curPFEmployer := PFEmployer/100 * curBasicPay;
        
                curTransAmount := curPF;
                strTransDescription := 'Provident Fund';
        
                //Provident Fund can either be PreTax or AfterTax
                IF PFIsAfterTax THEN BEGIN
                TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 0;
                END ELSE BEGIN
                TGroup := 'STATUTORIES'; TGroupOrder := 5; TSubGroupOrder := 0;
                END;
        
                fnUpdatePeriodTrans (strEmpCode, 'PF', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,PensionEMPyee,
                JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::Pension);
        
                //Make Employer Deductions entries
                IF curPFEmployer > 0 THEN
                fnUpdateEmployerDeductions(strEmpCode, 'PF','EMP', TGroupOrder, TSubGroupOrder,'', curPFEmployer, 0, intMonth, intYear,
                prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod);
        
               END;
        
        
        
        
              //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
               curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
               curTransAmount := curDefinedContrib;
               strTransDescription := 'Defined Contributions';
               TGroup := 'TAX CALCULATIONS'; TGroupOrder:= 6; TSubGroupOrder:= 1;
               NoOfUnits:=0;
               fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",
                JournalPostingType::" ",'',CoopParameters::none);
        
        
               //Get the Gross taxable amount
               //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
               curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;
        
               //>If GrossTaxable = 0 Then TheDefinedToPost = 0
               IF curGrossTaxable = 0 THEN curDefinedContrib := 0;
        
               //Personal Relief
              // if get relief is ticked  - DENNO ADDED
              IF blnGetsPAYERelief THEN
              BEGIN
               curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
               curTransAmount := curReliefPersonal;
               strTransDescription := 'Personal Relief';
               TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 9;
               fnUpdatePeriodTrans (strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                CoopParameters::none);
              END
              ELSE
               curReliefPersonal := 0;
        
              //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
               //>Pension Contribution [self] relief
               curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
               SpecialTransType::"Defined Contribution",FALSE) ;//Self contrib Pension is 1 on [Special Transaction]
               IF curPensionStaff > 0 THEN BEGIN
                   IF curPensionStaff > curMaxPensionContrib THEN
                       curTransAmount :=curMaxPensionContrib
                   ELSE
                       curTransAmount :=curPensionStaff;
                   strTransDescription := 'Pension Relief';
                   TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 2;
                   fnUpdatePeriodTrans (strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                   curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                   CoopParameters::none)
               END;
        
              //if he PAYS paye only*******************I
              IF blnPaysPaye AND blnGetsPAYERelief THEN
              BEGIN
                //Get Insurance Relief
                curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Life Insurance",FALSE); //Insurance is 3 on [Special Transaction]
                IF curInsuranceReliefAmount > 0 THEN BEGIN
                    curTransAmount := curInsuranceReliefAmount;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 8;
                    fnUpdatePeriodTrans (strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                    CoopParameters::none);
                END;
        
               //>OOI
                curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Owner Occupier Interest",FALSE); //Morgage is LAST on [Special Transaction]
                IF curOOI > 0 THEN BEGIN
                  IF curOOI<=curOOIMaxMonthlyContrb THEN
                    curTransAmount := curOOI
                  ELSE
                    curTransAmount:=curOOIMaxMonthlyContrb;
        
                    strTransDescription := 'Owner Occupier Interest';
                    TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 3;
                    fnUpdatePeriodTrans (strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                    CoopParameters::none);
                END;
        
              //HOSP
                curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Home Ownership Savings Plan",FALSE); //Home Ownership Savings Plan
                IF curHOSP > 0 THEN BEGIN
                  IF curHOSP<=curReliefMorgage THEN
                    curTransAmount := curHOSP
                  ELSE
                    curTransAmount:=curReliefMorgage;
        
                    strTransDescription := 'Home Ownership Savings Plan';
                    TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 4;
                    fnUpdatePeriodTrans (strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                    CoopParameters::none);
                END;
        
              //Enter NonTaxable Amount
              IF curNonTaxable>0 THEN BEGIN
                    strTransDescription := 'Other Non-Taxable Benefits';
                    TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                    fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curNonTaxable, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                    CoopParameters::none);
              END;
        
              END;
        
              //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              {
               //>Company pension, Excess pension, Tax on excess pension
               curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
               TRUE); //Self contrib Pension is 1 on [Special Transaction]
               IF curPensionCompany > 0 THEN BEGIN
                   curTransAmount := curPensionCompany;
                   strTransDescription := 'Pension (Company)';
                   //Update the Employer deductions table
        
                   curExcessPension:= curPensionCompany - curMaxPensionContrib;
                   IF curExcessPension > 0 THEN BEGIN
                       curTransAmount := curExcessPension;
                       strTransDescription := 'Excess Pension';
                       TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
                       fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                        intMonth,intYear,'','',SelectedPeriod);
        
                       curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
                       curTransAmount := curTaxOnExcessPension;
                       strTransDescription := 'Tax on ExPension';
                       TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                       fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                        intMonth,intYear,'','',SelectedPeriod);
                   END;
               END;
               }
        
               //Get the Taxable amount for calculation of PAYE
               //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)
        
        
        
                  //Added For Pretax Deductions
                  PretaxDeductions:=0;
        
                  Trans.RESET;
                  Trans.SETRANGE(Trans."Transaction Type",Trans."Transaction Type"::Deduction);
                  Trans.SETRANGE(Trans."Pre-Tax Deduction",TRUE);
                  IF Trans.FIND('-') THEN BEGIN
                  REPEAT
                  EmpTrans.RESET;
                  EmpTrans.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
                  EmpTrans.SETRANGE("Employee Code",strEmpCode);
                  EmpTrans.SETRANGE(EmpTrans."Transaction Code",Trans."Transaction Code");
                  EmpTrans.SETRANGE("Period Month",intMonth);
                  EmpTrans.SETRANGE("Period Year",intYear);
                  EmpTrans.SETRANGE(Suspended,FALSE);
                  IF EmpTrans.FIND('-') THEN BEGIN
                  REPEAT
                  PretaxDeductions:=PretaxDeductions+EmpTrans."Amount LCY";
        
                  UNTIL EmpTrans.NEXT =0
                  END;
                  UNTIL Trans.NEXT = 0;
                  END;
        
        
        
        
                //Add HOSP and MORTGAGE KIM{}
               IF (curPensionStaff+curDefinedContrib) > curMaxPensionContrib THEN
                   curTaxablePay:= curGrossTaxable - (curSalaryArrears + curSSF + curPF + curMaxPensionContrib+curOOI+curHOSP+curNonTaxable+curTaxDeductions+PretaxDeductions)
               ELSE
                   curTaxablePay:= curGrossTaxable - (curSalaryArrears + curSSF + curPF +curPensionStaff+curOOI+curHOSP+curNonTaxable+curTaxDeductions+PretaxDeductions);
        
               //Readd PF if it is AfterTax
               IF PFIsAfterTax THEN curTaxablePay := curTaxablePay + curPF;
        
               //curTransAmount := (curTaxablePay - MonthlyReliefAmount/12); //curTaxablePay; **changes
               curTransAmount:= curTaxablePay;
               strTransDescription := 'Taxable Pay';
               TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 6;
               fnUpdatePeriodTrans (strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                CoopParameters::none);
        
               //Get the Tax charged for the month
               IF NOT AngolaPayroll THEN
               curTaxCharged := fnGetEmployeePaye(curTaxablePay,strEmpCode)
               ELSE
               curTaxCharged := fnGetEmployeePayeAngola(curTaxablePay,strEmpCode);
        
        
              {
               //PKK-NG ADDED
               IF (curGrossPay*0.01) > curTaxCharged THEN
               curTaxCharged:=(curGrossPay*0.01);
               //PKK-NG ADDED
              }
        
               curTransAmount := curTaxCharged;
               strTransDescription := 'Tax Charged';
               TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 7;
               fnUpdatePeriodTrans (strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
               curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
               CoopParameters::none);
        
        
               //Get the Net PAYE amount to post for the month
               IF (curReliefPersonal + curInsuranceReliefAmount)>curMaximumRelief THEN
                 curPAYE := curTaxCharged - curMaximumRelief
               ELSE
               curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);
        
               IF NOT blnPaysPaye THEN curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
               curTransAmount := curPAYE;
               IF curPAYE<0 THEN curTransAmount := 0;
               strTransDescription := 'P.A.Y.E';
               TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 3;
               fnUpdatePeriodTrans (strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,TaxAccount,JournalPostAs::Credit,
                JournalPostingType::"G/L Account",'',CoopParameters::none);
        
               //Store the unused relief for the current month
               //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
               IF curPAYE < 0 THEN BEGIN
               prUnusedRelief.RESET;
               prUnusedRelief.SETRANGE(prUnusedRelief."Employee Code",strEmpCode);
               prUnusedRelief.SETRANGE(prUnusedRelief."Period Month",intMonth);
               prUnusedRelief.SETRANGE(prUnusedRelief."Period Year",intYear);
               IF prUnusedRelief.FIND('-') THEN
                  prUnusedRelief.DELETE;
        
               prUnusedRelief.RESET;
               WITH prUnusedRelief DO BEGIN
                   INIT;
                   "Employee Code" := strEmpCode;
                   "Unused Relief" := curPAYE;
                   "Period Month" := intMonth;
                   "Period Year" := intYear;
                   INSERT;
        
                   curPAYE:=0;
               END;
              END;
        
               //Deductions: get all deductions for the month
               //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
               //>Balance = (Openning Bal + Deduction)...//Increasing balance
               //>Balance = (Openning Bal - Deduction)...//Reducing balance
               //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance
        
        
               //Get the N.H.F amount for the month GBT //PKK
               {
               curNhif_Base_Amount :=0;
        
               IF intNHIF_BasedOn =intNHIF_BasedOn::Gross THEN //>NHIF calculation can be based on:
                       curNhif_Base_Amount := curGrossPay;
               IF intNHIF_BasedOn = intNHIF_BasedOn::Basic THEN
                      curNhif_Base_Amount := curBasicPay;
               IF intNHIF_BasedOn =intNHIF_BasedOn::"Taxable Pay" THEN
                      curNhif_Base_Amount := curTaxablePay;
        
        
               IF blnPaysNhif THEN BEGIN
                curNHIF:=curNhif_Base_Amount*curNHFPerc*0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                strTransDescription := 'N.H.F';
                TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 2;
                fnUpdatePeriodTrans (strEmpCode, 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
                 NHIFEMPyee,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
               END;
               }
               //PKK
        
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                IF prEmployeeTransactions.FIND('-') THEN BEGIN
                  curTotalDeductions:= 0;
                  REPEAT
                    EmployerAmount:=0; //PKK
                    EmployerBalance:=0; //PKK
        
                    prTransactionCodes.RESET;
                    prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Deduction);
                    IF prTransactionCodes.FIND('-') THEN BEGIN
                      curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';
        
                      IF prTransactionCodes."Is Formula" THEN BEGIN
                          strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                          curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
        
                      END ELSE BEGIN
                          curTransAmount := prEmployeeTransactions."Amount LCY";
                      END;
        
                       //Prorate Deductions Here
                       //If Employee date of join is after period start
                        IF prTransactionCodes."Excl. from Proration" = FALSE THEN
                          IF (DATE2DMY(dtDOE,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtDOE,3)=DATE2DMY(dtOpenPeriod,3))THEN BEGIN
                             CountDaysofMonth:=fnDaysInMonth(dtDOE);
                             DaysWorked:=fnDaysWorked(dtDOE,FALSE);
                             curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                          END
                        ELSE
                          curTransAmount := curTransAmount;
        
        
                        //Prorate absence
                        IF ProrateAbsence = TRUE THEN BEGIN
                        IF prTransactionCodes."Prorate Absence" = TRUE THEN BEGIN
                        IF curTransAmount > 0 THEN BEGIN
                        IF DayAbsent > 0 THEN BEGIN
                        CountDaysofMonth:=fnDaysInMonth(SelectedPeriod);
                        DaysWorked:=fnDaysWorked(SelectedPeriod,FALSE);
        
                        IF ProrateAbsMonthDays = TRUE THEN
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,CountDaysofMonth-DayAbsent,
                                          CountDaysofMonth)
                        ELSE
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,22-DayAbsent,22);
        
                        END;
                        END;
                        END;
                        END;
        
                       //If employee leaves before end of period
                       IF prTransactionCodes."Excl. from Proration" = FALSE THEN BEGIN
                        IF dtTermination<>0D THEN BEGIN
                         IF (DATE2DMY(dtTermination,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(dtOpenPeriod,3))THEN
                         BEGIN
                           CountDaysofMonth:=fnDaysInMonth(dtTermination);
                           DaysWorked:=fnDaysWorked(dtTermination,TRUE);
                           DaysWorked := CountDaysofMonth - DaysWorked;
                           curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                         END;
                        END;
                       END;
                      // End of Prorate Deductions
        
        
                     //PKK EMPLOYER TRANSACTION
                     EmployerAmount:=0;
                     EmployerBalance:=0;
        
                      IF (prTransactionCodes."Employer Deduction") OR (prTransactionCodes."Include Employer Deduction") THEN BEGIN
                      IF prTransactionCodes."Is Formula for employer"<>'' THEN BEGIN
                          strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear,prTransactionCodes."Is Formula for employer");
                          EmployerAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
        
        
                          prEmployeeTransactions."Employer Amount":=EmployerAmount;
                          prEmployeeTransactions.MODIFY;
        
                          EmployerBalance:=prEmployeeTransactions."Employer Balance"+EmployerAmount;
        
                      END ELSE BEGIN
                          EmployerAmount := prEmployeeTransactions."Employer Amount";
        
                          prEmployeeTransactions."Employer Amount":=EmployerAmount;
                          prEmployeeTransactions.MODIFY;
        
                          EmployerBalance:=prEmployeeTransactions."Employer Balance"+EmployerAmount;
        
                      END;
                      END;
        
                     //PKK EMPLOYER TRANSACTION
        
                     //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                     IF (prTransactionCodes."Special Transactions"=prTransactionCodes."Special Transactions"::"Life Insurance")
                       AND (prTransactionCodes."Deduct Premium"=FALSE) THEN
                      BEGIN
                       curTransAmount:=0;
                      END;
        
                     //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                     IF(prTransactionCodes."Special Transactions"=prTransactionCodes."Special Transactions"::Morgage)
                      AND (prTransactionCodes."Deduct Mortgage"=FALSE) THEN
                      BEGIN
                       curTransAmount:=0;
                      END;
        
        
        
        
                  //Get the posting Details
                       JournalPostingType:=JournalPostingType::" ";JournalAcc:='';
                       IF prTransactionCodes.Subledger<>prTransactionCodes.Subledger::" " THEN BEGIN
                          IF prTransactionCodes.Subledger=prTransactionCodes.Subledger::Customer THEN BEGIN
                              Customer.RESET;
                              HrEmployee.GET(strEmpCode);
                              Customer.RESET;
                              //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                                //Customer.SETRANGE(Customer."Employer Code",'KPSS');
        
                              //IF prTransactionCodes.CustomerPostingGroup <>'' THEN
                              //Customer.SETRANGE(Customer."Customer Posting Group",prTransactionCodes.CustomerPostingGroup);
        
                              //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                              Customer.SETRANGE(Customer."No.",HrEmployee."No.");
                              IF Customer.FIND('-') THEN BEGIN
                                 JournalAcc:=Customer."No.";
                                 JournalPostingType:=JournalPostingType::Customer;
                              END;
                          END;
                       END ELSE BEGIN
                          JournalAcc:=prTransactionCodes."GL Account";
                          JournalPostingType:=JournalPostingType::"G/L Account";
                       END;
        
                      //End posting Details
        
        
                      //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                      IF (prTransactionCodes."Special Transactions"=prTransactionCodes."Special Transactions"::"Staff Loan") AND
                         (prTransactionCodes."Repayment Method" = prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN
                         curTransAmount:=0; curLoanInt:=0;
                         curLoanInt:=fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
                         prTransactionCodes."Interest Rate",prTransactionCodes."Repayment Method",
                            prEmployeeTransactions."Original Amount",prEmployeeTransactions.Balance,SelectedPeriod,FALSE);
                         //Post the Interest
                         IF (curLoanInt<>0) THEN BEGIN
                                curTransAmount := curLoanInt;
                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                curTransBalance:=0;
                                strTransCode := prEmployeeTransactions."Transaction Code"+'-INT';
                                strTransDescription := prEmployeeTransactions."Transaction Name"+ 'Interest';
                                TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 1;
                                NoOfUnits:=prEmployeeTransactions."No of Units";
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                                  JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                                  CoopParameters::"loan Interest")
                          END;
                         //Get the Principal Amt
                         curTransAmount:=prEmployeeTransactions."Amortized Loan Total Repay Amt"-curLoanInt;
                          //Modify PREmployeeTransaction Table
                           prEmployeeTransactions."Amount LCY" := curTransAmount;
                           prEmployeeTransactions.MODIFY;
        
                      END;
                      //Loan Calculation Amortized
        
                      CASE prTransactionCodes."Balance Type" OF //[0=None, 1=Increasing, 2=Reducing]
                          prTransactionCodes."Balance Type"::None:
                               curTransBalance := 0;
                          prTransactionCodes."Balance Type"::Increasing:
                              curTransBalance := prEmployeeTransactions.Balance+ curTransAmount;
                         prTransactionCodes."Balance Type"::Reducing:
                         BEGIN
                              //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                              IF prEmployeeTransactions.Balance < prEmployeeTransactions."Amount LCY" THEN BEGIN
                                   curTransAmount := prEmployeeTransactions.Balance;
                                   curTransBalance := 0;
                               END ELSE BEGIN
                                   curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                               END;
                               IF curTransBalance < 0 THEN BEGIN
                                   curTransAmount := 0;
                                   curTransBalance := 0;
                               END;
                         END
                    END;
        
                      curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                      curTransAmount := curTransAmount;
                      curTransBalance := curTransBalance;
                      strTransDescription := prTransactionCodes."Transaction Name";
        
                      //Added to distinguish between pretax and after tax deductions
                      IF prTransactionCodes."Pre-Tax Deduction" THEN BEGIN
                      TGroup := 'DEDUCTIONS'; TGroupOrder := 5; TSubGroupOrder := 0;
                      END ELSE BEGIN
                      TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 0;
                      END;
        
                      IF prTransactionCodes."coop parameters" = prTransactionCodes."coop parameters"::Pension THEN TGroup := 'STATUTORIES';
        
                      fnUpdatePeriodTrans (strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription,curTransAmount, curTransBalance, intMonth,
                       intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                       JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                       prTransactionCodes."coop parameters");
        
              //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                      IF (prTransactionCodes."Special Transactions"=prTransactionCodes."Special Transactions"::"Staff Loan") AND
                         (prTransactionCodes."Repayment Method" <> prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN
        
                           curLoanInt:=fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
                          prTransactionCodes."Interest Rate",
                           prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                           prEmployeeTransactions.Balance,SelectedPeriod,prTransactionCodes.Welfare);
                            IF curLoanInt > 0 THEN BEGIN
                                curTransAmount := curLoanInt;
                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                curTransBalance:=0;
                                strTransCode := prEmployeeTransactions."Transaction Code"+'-INT';
                                strTransDescription := prEmployeeTransactions."Transaction Name"+ 'Interest';
                                TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 1;
                                NoOfUnits:=prEmployeeTransactions."No of Units";
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                                  JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                                  CoopParameters::"loan Interest")
                           END;
                     END;
                     //End Loan transaction calculation
                     //Fringe Benefits and Low interest Benefits
                            IF prTransactionCodes."Fringe Benefit" = TRUE THEN BEGIN
                                IF prTransactionCodes."Interest Rate" < curLoanMarketRate THEN BEGIN
                                    fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                                     * prEmployeeTransactions.Balance;
                                END;
                            END ELSE BEGIN
                                fnCalcFringeBenefit := 0;
                            END;
                            IF  fnCalcFringeBenefit>0 THEN BEGIN
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code"+'-FRG',
                                 'EMP', TGroupOrder, TSubGroupOrder,'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod)
        
                            END;
                     //End Fringe Benefits
        
                    //Create Employer Deduction
                    EmployerAmount:=0;
                    EmployerBalance:=0;
                    IF (prTransactionCodes."Employer Deduction") OR (prTransactionCodes."Include Employer Deduction") THEN BEGIN
                      IF prTransactionCodes."Is Formula for employer"<>'' THEN BEGIN
                          strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear,prTransactionCodes."Is Formula for employer");
                          curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
        
                      END ELSE BEGIN
                          curTransAmount := prEmployeeTransactions."Employer Amount";
        
                      END;
                            IF  curTransAmount>0 THEN
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                                 'EMP', TGroupOrder, TSubGroupOrder,'', curTransAmount, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod)
        
                    END;
                    //Employer deductions
        
                    END;
        
                UNTIL prEmployeeTransactions.NEXT=0;
                   //GET TOTAL DEDUCTIONS
                                //PKK ADD NHF to TOTAL DEDUCTIONS
                                //curTotalDeductions:=curTotalDeductions+curNHIF;
        
                                curTransBalance:=0;
                                strTransCode := 'TOT-DED';
                                strTransDescription := 'TOTAL DEDUCTION';
                                TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 9;
                                NoOfUnits:=prEmployeeTransactions."No of Units";
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                                  '',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
        
                    EmployerAmount:=0; //PKK
                    EmployerBalance:=0; //PKK
        
                   //END GET TOTAL DEDUCTIONS
               END;
        
                //Net Pay: calculate the Net pay for the month in the following manner:
                //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
                //...Tot Deductions also include (SumLoan + SumInterest)
                curNetPay := curGrossPay - (curSSF + curPF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit + ExcessSSF);
        
                //>Nett = Nett - curExcessPension
                //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
                curNetPay := curNetPay; //- curExcessPension
        
                //>Nett = Nett - cSumEmployerDeductions
                //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
                curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****
        
                curNetRnd_Effect := curNetPay - ROUND(curNetPay);
                curTransAmount := curNetPay;
                strTransDescription := 'Net Pay';
                TGroup := 'NET PAY'; TGroupOrder := 9; TSubGroupOrder := 0;
                NoOfUnits:=0;
                fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
                PayablesAcc,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                //Rounding Effect: if the Net pay is rounded, take the rounding effect &
                //save it as an earning for the staff for the next month
                    //>Insert the Netpay rounding effect into the tblRoundingEffect table
        
        
                //Negative pay: if the NetPay<0 then log the entry
                    //>Display an on screen report
                    //>Through a pop-up to the user
                    //>Send an email to the user or manager
              END;
        
        //ADDED TO CATER FOR THE 13TH MONTH SALARY
        END ELSE BEGIN
        
            "HR-Employee".RESET;
            IF "HR-Employee".GET(strEmpCode) THEN BEGIN
              "HR-Employee".TESTFIELD("HR-Employee"."Date Of Join");
        
              PayrollPeriodR.RESET;
              PayrollPeriodR.SETRANGE(PayrollPeriodR."Date Opened",SelectedPeriod);
              IF PayrollPeriodR.FIND('-') THEN BEGIN
              Amount13th := 0;
              BonusPAYE := 0;
              BonusNetPay := 0;
        
                  VitalSetup.GET;
                  Perc := VitalSetup."13th Month %";
        
                  IF VitalSetup."Calculate 13th Month On" = VitalSetup."Calculate 13th Month On"::"0" THEN BEGIN
                    IF DATE2DMY("HR-Employee"."Date Of Join",3) = DATE2DMY(PayrollPeriodR."Date Opened",3) THEN
                    Amount13th:=("HR-Employee"."Basic Pay 2"*Perc*0.01)*(((12-DATE2DMY("HR-Employee"."Date Of Join",2)+1))/12)
                    ELSE
                    Amount13th:="HR-Employee"."Basic Pay 2"*Perc*0.01;
                  END ELSE
        
                  IF VitalSetup."Calculate 13th Month On" = VitalSetup."Calculate 13th Month On"::"1" THEN BEGIN
                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE("Employee Code","HR-Employee"."No.");
                    PeriodTrans.SETRANGE("Transaction Code",'GPAY');
                    PeriodTrans.FINDLAST;
                    IF DATE2DMY("HR-Employee"."Date Of Join",3) = DATE2DMY(PayrollPeriodR."Date Opened",3) THEN
                     Amount13th:=(PeriodTrans.Amount*Perc*0.01)*(((12-DATE2DMY("HR-Employee"."Date Of Join",2)+1))/12)
                    ELSE
                     Amount13th:=PeriodTrans.Amount*Perc*0.01;
                  END ELSE
        
                  IF VitalSetup."Calculate 13th Month On" = VitalSetup."Calculate 13th Month On"::"2" THEN BEGIN
                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE("Employee Code","HR-Employee"."No.");
                    PeriodTrans.SETRANGE("Transaction Code",'NPAY');
                    PeriodTrans.FINDLAST;
                    IF DATE2DMY("HR-Employee"."Date Of Join",3) = DATE2DMY(PayrollPeriodR."Date Opened",3) THEN
                     Amount13th:=(PeriodTrans.Amount*Perc*0.01)*(((12-DATE2DMY("HR-Employee"."Date Of Join",2)+1))/12)
                    ELSE
                     Amount13th:=PeriodTrans.Amount*Perc*0.01;
                  END;
        
                 //Entries for Bonus Pay
                 strTransDescription := 'Bonus Pay';
                 TGroup := 'BASIC SALARY'; TGroupOrder := 1; TSubGroupOrder := 2;
                 NoOfUnits:=0;
                 fnUpdatePeriodTrans(strEmpCode, 'BONPAY', TGroup, TGroupOrder,
                 TSubGroupOrder, strTransDescription, Amount13th, 0, PayrollPeriodR."Period Month", intYear,Membership,ReferenceNo,SelectedPeriod,Dept,
                 salariesAcc,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                 //Entries for Bonus PAYE
                 BonusPAYE := 0.05 * Amount13th;
                 strTransDescription := 'P.A.Y.E';
                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 3;
                 fnUpdatePeriodTrans (strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                  BonusPAYE, 0, PayrollPeriodR."Period Month", intYear,'','',SelectedPeriod,Dept,TaxAccount,JournalPostAs::Credit,
                  JournalPostingType::"G/L Account",'',CoopParameters::none);
        
                //Entries for Bonus Net Pay
                  BonusNetPay := Amount13th - BonusPAYE;
                  strTransDescription := 'Net Pay';
                  TGroup := 'NET PAY'; TGroupOrder := 9; TSubGroupOrder := 0;
                  NoOfUnits:=0;
                  fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                  BonusNetPay, 0, PayrollPeriodR."Period Month", intYear,'','',SelectedPeriod,Dept,
                  PayablesAcc,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
        
        
        
              END;
        
            END;
        
        
        
        
        
        
        
        END;
        //END;
        */

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Decimal; DaysInMonth: Integer) ProratedAmt: Decimal
    begin

        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary);
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
        /*
        VitalSetup.GET();
        
        TodayDate:=dtDate;
        {
         Day:=DATE2DMY(TodayDate,1);
         Expr1:=FORMAT(-Day)+'D+1D';
         FirstDay:=CALCDATE(Expr1,TodayDate);
         LastDate:=CALCDATE('1M-1D',FirstDay);
        
         SysDate.RESET;
         SysDate.SETRANGE(SysDate."Period Type",SysDate."Period Type"::Date);
         SysDate.SETRANGE(SysDate."Period Start",FirstDay,LastDate);
         SysDate.SETFILTER(SysDate."Period No.",'1..5');
         IF SysDate.FIND('-') THEN
            DaysInMonth:=SysDate.COUNT;
        }
        
        //W days in month
        MonthDays:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY(TodayDate,2),DATE2DMY(TodayDate,3))))-
                    DMY2DATE(1,DATE2DMY(TodayDate,2),DATE2DMY(TodayDate,3));
        
        TDate:=DMY2DATE(1,DATE2DMY(TodayDate,2),DATE2DMY(TodayDate,3));
        
        i:=0;
        REPEAT
        i :=i + 1;
        
        IF VitalSetup."Prol. Based on days in month" = TRUE THEN BEGIN
        DaysInMonth:=DaysInMonth+1;
        END ELSE BEGIN
        IF (DATE2DWY(TDate,1) <> 6) AND (DATE2DWY(TDate,1) <> 7)  THEN
        DaysInMonth:=DaysInMonth+1;
        END;
        
        TDate:=CALCDATE('1D',TDate);
        
        UNTIL i = MonthDays+1;
        //W days in month
        */

    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[10]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
    var
        prPeriodTransactions: Record "PR Period Transactions";
        prSalCard: Record "HR Employees";
    begin
        /*
        IF curAmount = 0 THEN EXIT;
        WITH prPeriodTransactions DO BEGIN
            INIT;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
             fnUpdatePeriodTransCurrency(EmpCode,TCode,Month,Year,dtOpenPeriod,curAmount);
             Amount := ROUND(curAmount,0.01,'=');
             Currency:= PeriodTransCurrrency;
             AmountFCY:= PeriodTransAmountFCY;
             Balance := curBalance;
             "Emp Amount":= EmployerAmount;
             "Emp Balance":= EmployerBalance;
            "Original Amount" := Balance;
            "Group Order" := GroupOrder;
            "Sub Group Order" := SubGroupOrder;
             Membership := mMembership;
             "Reference No" := ReferenceNo;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            "Department Code":=Department;
            "Journal Account Type":=JournalACType;
            "Post As":=PostAs;
            "Journal Account Code":=JournalAC;
             "Loan Number":=LoanNo;
             "coop parameters":=CoopParam;
             "No. Of Units":=NoOfUnits;
             "Payroll Code":=PayrollType;
             prPeriodTransactions."Payslip Order":=0;
             //Paymode
             IF prSalCard.GET(EmpCode) THEN BEGIN
             "Payment Mode":=prSalCard."Payment Mode";
             "Location/Division":=prSalCard."Location/Division Code";
             Department:=prSalCard."Department Code";
             "Cost Centre":=prSalCard."Cost Code";
             "Salary Grade":=prSalCard."Salary Grade";
             "Salary Notch":=prSalCard."Salary Notch/Step";
             END;
             IF Trans.GET(TCode) THEN BEGIN
             IF Trans."Non-Transactional" = FALSE THEN BEGIN
             IF Trans.Frequency = Trans.Frequency::Varied THEN
             prPeriodTransactions."Payslip Order":=2
             END;
             END;
            INSERT;
           //Update the prEmployee Transactions  with the Amount
           fnUpdateEmployeeTrans("Employee Code","Transaction Code",Amount,"Period Month","Period Year","Payroll Period","Reference No");
        END;
        */

    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "PR Employee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
    begin
        /*
        SpecialTransAmount:=0;
        prTransactionCodes.RESET;
        prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions",intSpecTransID);
        IF prTransactionCodes.FIND('-') THEN BEGIN
        REPEAT
           prEmployeeTransactions.RESET;
           prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
           prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
           prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",prTransactionCodes."Transaction Code");
           prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
           prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
           prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
           IF prEmployeeTransactions.FIND('-') THEN BEGIN
        
            //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
            //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
              CASE intSpecTransID OF
                intSpecTransID::"Defined Contribution":
                  IF prTransactionCodes."Is Formula" THEN BEGIN
                      strExtractedFrml := '';
                      strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                      SpecialTransAmount := SpecialTransAmount+(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                  END ELSE
                      SpecialTransAmount := SpecialTransAmount+prEmployeeTransactions."Amount LCY";
        
                intSpecTransID::"Life Insurance":
                    SpecialTransAmount :=SpecialTransAmount+( (curReliefInsurance / 100) * prEmployeeTransactions."Amount LCY");
        
        //
                intSpecTransID::"Owner Occupier Interest":
                      SpecialTransAmount := SpecialTransAmount+prEmployeeTransactions."Amount LCY";
        
        
                intSpecTransID::"Home Ownership Savings Plan":
                      SpecialTransAmount := SpecialTransAmount+prEmployeeTransactions."Amount LCY";
        
                intSpecTransID::Morgage:
                  BEGIN
                    SpecialTransAmount :=SpecialTransAmount+ curReliefMorgage;
        
                    IF SpecialTransAmount > curReliefMorgage THEN
                     BEGIN
                      SpecialTransAmount:=curReliefMorgage
                     END;
        
                  END;
        
              END;
           END;
         UNTIL prTransactionCodes.NEXT=0;
        END;
        */

    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal; curEmployee: Code[20]) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
        Employees: Record "HR Employees";
        Posting: Record "prEmployee Posting Group";
    begin
        /*//PKK - Convert to annual
        //statTaxPay:=curTaxablePay;
        //curTaxablePay:=((curTaxablePay-currAnnualPay)*12)+currAnnualPay;
        //PKK - Convert to annual
        
        
        KeepCount:=0;
        prPAYE.RESET;
        IF prPAYE.FINDFIRST THEN BEGIN
        
        IF curTaxablePay < prPAYE."PAYE Tier" THEN BEGIN //PKK EXIT;
        IF KeepCount = 0 THEN BEGIN
        PAYE := PAYE + (curTaxablePay * (prPAYE.Rate / 100));
        END;
        //PKK
        //PAYE := PAYE/12;
        //Min PAYE
        //Min PAYE
        EXIT;
        END;
        REPEAT
         KeepCount+=1;
         curTempAmount:= curTaxablePay;
         IF curTaxablePay = 0 THEN EXIT;
               IF KeepCount = prPAYE.COUNT THEN   //this is the last record or loop
                  curTaxablePay := curTempAmount
                ELSE
                   IF curTempAmount >= prPAYE."PAYE Tier" THEN
                    curTempAmount := prPAYE."PAYE Tier"
                   ELSE
                     curTempAmount := curTempAmount;
        
        PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
        curTaxablePay := curTaxablePay - curTempAmount;
        
        UNTIL prPAYE.NEXT=0;
        END;
        
        //PKK
        //PAYE := PAYE/12;
        //curTaxablePay:=statTaxPay;
        //PKK
        */

        //Added to cater for the different tax groups
        //Get the employee's posting group
        Employees.Reset;
        if Employees.Get(curEmployee) then begin
            Employees.TestField(Employees."Posting Group");

            //Get the tax group for that posting group
            Posting.Reset;
            Posting.Get(Employees."Posting Group");

            KeepCount := 0;
            prPAYE.Reset;
            prPAYE.SetRange(prPAYE."Tax Code", Posting."Tax Code"); //Added
            if prPAYE.FindFirst then begin
                //IF curTaxablePay < prPAYE."PAYE Tier" THEN EXIT;  //Commented
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

                    PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                    curTaxablePay := curTaxablePay - curTempAmount;

                until prPAYE.Next = 0;
            end;

        end;

    end;


    procedure fnGetEmployeePayeAngola(curTaxablePay: Decimal; curEmployee: Code[20]) PAYEAngola: Decimal
    var
        prPAYEAngola: Record "prPAYE Angola";
        curTempAmount: Decimal;
        KeepCount: Integer;
        Employees: Record "HR Employees";
        Posting: Record "prEmployee Posting Group";
    begin
        //Added to cater for the different tax groups
        //Get the employee's posting group
        Employees.Reset;
        if Employees.Get(curEmployee) then begin
            Employees.TestField(Employees."Posting Group");

            //Get the tax group for that posting group
            Posting.Reset;
            Posting.Get(Employees."Posting Group");


            prPAYEAngola.Reset;
            prPAYEAngola.SetRange(prPAYEAngola."Tax Code", Posting."Tax Code"); //Added
            if prPAYEAngola.FindFirst then begin
                repeat
                    if (curTaxablePay >= prPAYEAngola."Min. Amount") and (curTaxablePay <= prPAYEAngola."Max. Amount") then begin
                        PAYEAngola := ((curTaxablePay - prPAYEAngola."Excess Amount") * (prPAYEAngola.Rate / 100)) + prPAYEAngola."Fixed Amount";
                    end;
                until prPAYEAngola.Next = 0;
            end;

        end;
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record prNHIF;
    begin
        prNHIF.Reset;
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                    NHIF := prNHIF.Amount;
            until prNHIF.Next = 0;
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
                //Get TransCodeAmount
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


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "PR Employee Transactions";
        prPeriodTransactions: Record "PR Period Transactions";
        prSalaryCard: Record "PR Salary Card";
    begin
        /*
        IF COPYSTR(strTransCode,1,1) = '#' THEN BEGIN  //PKK
        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",DELCHR(strTransCode,'=','#'));
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
        IF prEmployeeTransactions.FINDFIRST THEN BEGIN
          TransAmount:=prEmployeeTransactions."No of Units";
          //PKKIF prEmployeeTransactions."No of Units"<>0 THEN
          //PKK   TransAmount:=prEmployeeTransactions."No of Units";
        END;
        
        END ELSE BEGIN
        
        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",strTransCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
        IF prEmployeeTransactions.FINDSET THEN BEGIN
        // IF prEmployeeTransactions.Currency = '' THEN
          TransAmount:=prEmployeeTransactions."Amount LCY";
        // ELSE
        //    TransAmount:=fnCurrencyConv(prEmployeeTransactions.Currency,SelectedPayrollPeriod,prEmployeeTransactions.Amount,TRUE)
          //PKKIF prEmployeeTransactions."No of Units"<>0 THEN
          //PKK   TransAmount:=prEmployeeTransactions."No of Units";
        END;
        
        IF TransAmount=0 THEN BEGIN
        prPeriodTransactions.RESET;
        prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code",strEmpCode);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Transaction Code",strTransCode);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Month",intMonth);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Year",intYear);
          IF prPeriodTransactions.FINDFIRST THEN BEGIN
            TransAmount:=prPeriodTransactions.Amount;
        
                //Added to cater for changes in BPAY that have not hit PrPeriod Transactions
                IF prPeriodTransactions."Transaction Code"='BPAY' THEN BEGIN
                prSalaryCard.RESET;
                prSalaryCard.SETRANGE(prSalaryCard."Employee Code",strEmpCode);
                IF prSalaryCard.FINDFIRST THEN
                TransAmount:=prSalaryCard."Basic Pay";
                END;
          END;
        END;
        
        END;
        
        
        //Added for new employees who have not had any entry into PrPeriod Transactions
        IF TransAmount=0 THEN BEGIN
           IF strTransCode='BPAY' THEN BEGIN
        
            prSalaryCard.RESET;
            prSalaryCard.SETRANGE(prSalaryCard."Employee Code",strEmpCode);
            IF prSalaryCard.FINDFIRST THEN
            TransAmount:=prSalaryCard."Basic Pay";
        
          END;
        END;
        
        
        IF strTransCode = 'DOM' THEN // so as to use days of month
        TransAmount := DOM;
        
        //MESSAGE('%1 for %2 and %3 and %4 or %5 vs %6',strTransCode,TransAmount,prEmployeeTransactions.Currency,prEmployeeTransactions.Amount,prPeriodTransactions.Amount);
        */

    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        // Results :=
        //  AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]; BiWeek: Integer) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewBiWeeK: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "HR Leave Reliver";
        prPeriodTransactions: Record "PR Period Transactions";
        intBiWeek: Integer;
        intYear: Integer;
        prTransactionCodes: Record "PR Transaction Codes";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "HR Leave Reliver";
        prPayrollPeriods: Record "prNSSF Tiers";
        prNewPayrollPeriods: Record "prNSSF Tiers";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information";
        prAssignEmployeeLoan: Record prAssignEmployeeLoan;
        Periods: Record "prNSSF Tiers";
        Periods2: Record "prNSSF Tiers";
    begin
        /*
        ControlInfo.GET();
        
        {
        //Added to cater for the 13th Month
        Periods.RESET;
        Periods.SETRANGE(Periods."Date Opened",dtOpenPeriod);
        IF Periods.FIND('-') THEN BEGIN
         IF Periods."Period Month" = 13 THEN BEGIN
          Periods.Closed := TRUE;
          Periods."Date Closed" := TODAY;
          Periods.MODIFY;
        
          //Get the month before the 13th Month to be the one to close
          Periods2.RESET;
          Periods2.SETRANGE(Periods2."Is before 13th Month",TRUE);
          IF Periods2.FIND('+') THEN
           dtOpenPeriod := Periods2."Date Opened";
         END;
        END;
        }
        
        intBiWeek := BiWeek;
        intYear := DATE2DMY(dtOpenPeriod,3);
        
        
        dtNewPeriod := CALCDATE('2W', dtOpenPeriod);
        intNewBiWeeK := BiWeek + 1;
        intNewYear := DATE2DMY(dtNewPeriod,3);
        
        
        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Pay Period",intBiWeek);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
        //Multiple Payroll
        IF ControlInfo."Multiple Payroll" THEN
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Payroll Code",PayrollCode);
        IF prEmployeeTransactions.FIND('-') THEN BEGIN
          REPEAT
           prTransactionCodes.RESET;
           prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
           IF prTransactionCodes.FIND('-') THEN BEGIN
            WITH prTransactionCodes DO BEGIN
              CASE prTransactionCodes."Balance Type" OF
                prTransactionCodes."Balance Type"::None:
                 BEGIN
                  curTransAmount:= prEmployeeTransactions."Amount LCY";
                  curTransBalance:= 0;
                 END;
                prTransactionCodes."Balance Type"::Increasing:
                 BEGIN
                   curTransAmount := prEmployeeTransactions."Amount LCY";
                   curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions."Amount LCY";
                 END;
                prTransactionCodes."Balance Type"::Reducing:
                 BEGIN
                   curTransAmount := prEmployeeTransactions."Amount LCY";
                   IF prEmployeeTransactions.Balance < prEmployeeTransactions."Amount LCY" THEN BEGIN
                       curTransAmount := prEmployeeTransactions.Balance;
                       curTransBalance := 0;
                   END ELSE BEGIN
                       curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions."Amount LCY";
                   END;
                   IF curTransBalance < 0 THEN
                    BEGIN
                       curTransAmount:=0;
                       curTransBalance:=0;
                    END;
                  END;
              END;
            END;
           END;
        
            //For those transactions with Start and End Date Specified
               IF (prEmployeeTransactions."Start Date"<>0D) AND (prEmployeeTransactions."End Date"<>0D) THEN BEGIN
                   IF prEmployeeTransactions."End Date"<dtNewPeriod THEN BEGIN
                       curTransAmount:=0;
                       curTransBalance:=0;
                   END;
               END;
            //End Transactions with Start and End Date
        
          IF (prTransactionCodes.Frequency=prTransactionCodes.Frequency::Fixed) AND
             (prEmployeeTransactions."Stop for Next Period"=FALSE) THEN //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
           BEGIN
            IF (curTransAmount <> 0) THEN  //Update the employee transaction table
             BEGIN
             IF ((prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::Reducing) AND (curTransBalance <> 0)) OR
              (prTransactionCodes."Balance Type"<>prTransactionCodes."Balance Type"::Reducing) THEN
              prEmployeeTransactions.Balance:=curTransBalance;
              prEmployeeTransactions.MODIFY;
        
        
           //Insert record for the next period
            WITH prEmployeeTrans DO BEGIN
              INIT;
              "Employee Code":= prEmployeeTransactions."Employee Code";
              "Transaction Code":= prEmployeeTransactions."Transaction Code";
              "Transaction Name":= prEmployeeTransactions."Transaction Name";
               Amount:= curTransAmount;
               Balance:= curTransBalance;
               "Amortized Loan Total Repay Amt":=prEmployeeTransactions. "Amortized Loan Total Repay Amt";
              "Original Amount":= prEmployeeTransactions."Original Amount";
               Membership:= prEmployeeTransactions.Membership;
              "Reference No":= prEmployeeTransactions."Reference No";
              "Loan Number":=prEmployeeTransactions."Loan Number";
              "Pay Period":= intNewBiWeeK;
              "Period Year":= intNewYear;
              "Payroll Period":= dtNewPeriod;
              "Payroll Code" :=PayrollCode;
              Currency := prEmployeeTransactions.Currency;
               INSERT;
             END;
          END;
          END
          UNTIL prEmployeeTransactions.NEXT=0;
        END;
        
        //Added for loan card to push loans for next period into employee transactions **changes**
        prAssignEmployeeLoan.RESET;
        prAssignEmployeeLoan.SETRANGE(prAssignEmployeeLoan."Payroll Period",dtNewPeriod);
        prAssignEmployeeLoan.SETRANGE(prAssignEmployeeLoan.Status,prAssignEmployeeLoan.Status::Posted);
        IF prAssignEmployeeLoan.FINDSET THEN
        REPEAT
          fnInsertTrans(prAssignEmployeeLoan);
        UNTIL prAssignEmployeeLoan.NEXT=0;
        
        
        //Update the Period as Closed
        prPayrollPeriods.RESET;
        prPayrollPeriods.SETRANGE(prPayrollPeriods.Tier,intBiWeek);
        prPayrollPeriods.SETRANGE(prPayrollPeriods.Earnings,intYear);
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Tier 1 Employer Contribution",FALSE);
        IF ControlInfo."Multiple Payroll" THEN
            prPayrollPeriods.SETRANGE(prPayrollPeriods."Tier 2 earnings",PayrollCode);
        
        IF prPayrollPeriods.FIND('-') THEN BEGIN
           prPayrollPeriods."Tier 1 Employer Contribution":=TRUE;
           prPayrollPeriods."Tier 1 Employee Deduction":=TODAY;
           prPayrollPeriods.MODIFY;
        END;
        
        //Enter a New Period
        WITH prNewPayrollPeriods DO BEGIN
          INIT;
            Tier := intNewBiWeeK;
            Earnings := intNewYear;
            "Pensionable Earnings" := FORMAT('Period '+FORMAT(intNewBiWeeK)+' '+FORMAT(intNewYear));
            "Tier 1 earnings" := dtNewPeriod;
            "Period End" := CALCDATE('2W - 1D', dtNewPeriod);
             "Tier 1 Employer Contribution" := FALSE;
             "Tier 2 earnings":=PayrollCode;
            INSERT;
        END;
        
        //Effect the transactions for the P9
        fnP9PeriodClosure (intBiWeek, intYear, dtOpenPeriod,PayrollCode);
        
        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intBiWeek, intYear,dtOpenPeriod);
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
            begin
                // prEmployeeTransactions.Init;
                // "Employee Code" := prPeriodTransactions."Employee Code";
                // "Transaction Code" := 'NEGP';
                // "Transaction Name" := 'Negative Pay';
                // Amount := prPeriodTransactions.Amount;
                // Balance := 0;
                // "Original Amount" := 0;
                // "Period Month" := intNewMonth;
                // "Period Year" := intNewYear;
                // "Payroll Period" := dtNewPeriod;
                // prEmployeeTransactions.Insert;
            end;
            until prPeriodTransactions.Next = 0;
        end;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
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
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
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
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then begin
                    repeat
                    begin
                        case prPeriodTransactions."Group Order" of
                            1: //Basic pay & Arrears
                                begin
                                    // if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
                                    // if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
                                end;
                            3:  //Allowances
                                begin
                                    // P9Allowances := P9Allowances + Amount
                                end;
                            4: //Gross Pay
                                begin
                                    // P9GrossPay := Amount
                                end;
                            6: //Taxation
                                begin
                                    // if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
                                    // if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
                                    // if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
                                    // if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
                                    // if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
                                end;
                            7: //Statutories
                                begin
                                    // if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
                                    // if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
                                    // if "Sub Group Order" = 3 then P9Paye := Amount; //paye
                                    // if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
                                end;
                            8://Deductions
                                begin
                                    // P9Deductions := P9Deductions + Amount;
                                end;
                            9: //NetPay
                                begin
                                    // P9NetPay := Amount;
                                end;
                        end;
                    end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details
                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            until prEmployee.Next = 0;
        end;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "PR Employee P9 Info";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        begin
            // prEmployeeP9Info.Init;
            // "Employee Code" := P9EmployeeCode;
            // "Basic Pay" := P9BasicPay;
            // Allowances := P9Allowances;
            // Benefits := P9Benefits;
            // "Value Of Quarters" := P9ValueOfQuarters;
            // "Defined Contribution" := P9DefinedContribution;
            // "Owner Occupier Interest" := P9OwnerOccupierInterest;
            // "Gross Pay" := P9GrossPay;
            // "Taxable Pay" := P9TaxablePay;
            // "Tax Charged" := P9TaxCharged;
            // "Insurance Relief" := P9InsuranceRelief;
            // "Tax Relief" := P9TaxRelief;
            // PAYE := P9Paye;
            // NSSF := P9NSSF;
            // NHIF := P9NHIF;
            // Deductions := P9Deductions;
            // "Net Pay" := P9NetPay;
            // "Period Month" := intMonth;
            // "Period Year" := intYear;
            // "Payroll Period" := dtCurrPeriod;
            // "Payroll Code" := prPayrollCode;
            // prEmployeeP9Info.Insert;
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
        /*
        TodayDate:=dtDate;
        PayTillCutOff:=FALSE;
        
        IF VitalSetup.GET() THEN BEGIN
        PayTillCutOff:=VitalSetup."Pay upto Cut Off Date";
        IF PayTillCutOff = TRUE THEN BEGIN
        VitalSetup.TESTFIELD(VitalSetup."Payroll Cut Off Day");
        END;
        END;
        
        RemainingDays:=0;
        IF PayTillCutOff = TRUE THEN BEGIN //PKK - AGROSACK
        RemainingDays:=(DMY2DATE(VitalSetup."Payroll Cut Off Day",DATE2DMY(TodayDate,2),DATE2DMY(TodayDate,3)) - TodayDate);
        
        END ELSE BEGIN
        RemainingDays:=(CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY(TodayDate,2),DATE2DMY(TodayDate,3))))
                                        -TodayDate);
        END;
        
        
        TDate:=TodayDate;
        
        i:=0;
        REPEAT
        i :=i + 1;
        
        IF VitalSetup."Prol. Based on days in month" = TRUE THEN BEGIN
        DaysWorked:=DaysWorked+1;
        END ELSE BEGIN
        IF (DATE2DWY(TDate,1) <> 6) AND (DATE2DWY(TDate,1) <> 7)  THEN
        DaysWorked:=DaysWorked+1;
        END;
        
        TDate:=CALCDATE('1D',TDate);
        
        UNTIL i = RemainingDays+1;
        */

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
        fnInitialize;

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
                                    if DontProrateBPAY = false then
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //PKK - Prorate Absence

                                //PKK - Prorate Absence

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
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay, EmpCode);
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
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears".Init;
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Insert;
        end
    end;


    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
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
            // prEmployerDeductions.Init;
            // "Employee Code" := EmpCode;
            // "Transaction Code" := TCode;
            // Amount := curAmount;
            // "Period Month" := Month;
            // "Period Year" := Year;
            // "Payroll Period" := dtOpenPeriod;
            // prEmployerDeductions.Insert;
        end;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date; ReffNo: Code[20])
    var
        prEmployeeTrans: Record "PR Employee Transactions";
    begin
        /*
        prEmployeeTrans.RESET;
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Employee Code",EmpCode);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Reference No",ReffNo);
        IF prEmployeeTrans.FIND('-') THEN BEGIN
          IF prEmployeeTrans.Currency = '' THEN
           prEmployeeTrans."Amount LCY" :=Amount
          ELSE
            prEmployeeTrans."Amount LCY" := fnCurrencyConv(prEmployeeTrans.Currency,PayrollPeriod,Amount,FALSE);
        
          prEmployeeTrans.MODIFY;
        END;
        */
        if Employee.Get(EmpCode) then begin
            if (Date2dmy(Employee."Date Of Join", 2) = Month) and (Date2dmy(Employee."Date Of Join", 3) = Year) then begin
                if Trans.Get(TransCode) then begin
                    if Trans."Is Formula" = false then
                        exit;

                end;
            end;
        end;

        if ProrateAbsence = true then begin
            if DayAbsent > 0 then begin
                if Trans.Get(TransCode) then begin
                    if Trans."Is Formula" = false then
                        exit;

                end;
            end;
        end;

    end;


    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "HR Employees";
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then begin
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being

                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                PostingGroup.TestField("Net Salary Payable");
                //PostingGroup.TESTFIELD("SSF Employer Account");
                PostingGroup.TestField("Pension Employer Acc");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
                PensionEMPyee := PostingGroup."Pension Employee Acc"
            end;
        end;
        //End Get Payroll Posting Accounts
    end;


    procedure fnInsertTrans(prAssignLoan: Record prAssignEmployeeLoan)
    var
        prEmployeeTrans: Record "PR Employee Transactions";
    begin

        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", prAssignLoan."Employee Code");
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", prAssignLoan."Transaction Code");
        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", prAssignLoan."Payroll Period");
        if not prEmployeeTrans.FindFirst then begin
            prEmployeeTrans.Init;
            prEmployeeTrans.TransferFields(prAssignLoan);
            prEmployeeTrans."End Date" := 0D;
            prEmployeeTrans.Insert;
        end
    end;


    procedure fnCurrencyConv(Currency: Code[10]; CurrencyPeriod: Date; AmountToConvert: Decimal; LCYToFCY: Boolean): Decimal
    var
        CurrExchRate: Record "Currency Exchange Rate";
        "Currency Factor": Decimal;
    begin
        "Currency Factor" := CurrExchRate.ExchangeRate(CalcDate('CM', CurrencyPeriod), Currency);
        if LCYToFCY = true then
            exit(ROUND(CurrExchRate.ExchangeAmtFCYToLCY(CalcDate('CM', CurrencyPeriod), Currency, AmountToConvert, "Currency Factor")))
        else
            exit(ROUND(CurrExchRate.ExchangeAmtLCYToFCY(CalcDate('CM', CurrencyPeriod), Currency, AmountToConvert, "Currency Factor")));
    end;


    procedure fnUpdateEmployeeTransCurrency(EmployeeCode: Code[10]; PayrollPeriod: Date)
    var
        EmployeeTransactions: Record "PR Employee Transactions";
    begin
        /*
        EmployeeTransactions.RESET;
        EmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
        EmployeeTransactions.SETRANGE(EmployeeTransactions."Employee Code",EmployeeCode);
        EmployeeTransactions.SETRANGE("Payroll Period",PayrollPeriod);
        //EmployeeTransactions.SETRANGE("Reference No",ReffNo);
        EmployeeTransactions.SETRANGE(EmployeeTransactions.Suspended,FALSE);
        IF EmployeeTransactions.FIND('-') THEN
        REPEAT
          IF EmployeeTransactions.Currency = '' THEN
           EmployeeTransactions."Amount LCY" := EmployeeTransactions.Amount
          ELSE
           EmployeeTransactions."Amount LCY" := fnCurrencyConv(EmployeeTransactions.Currency,PayrollPeriod,EmployeeTransactions.Amount,TRUE);
        
          EmployeeTransactions.MODIFY;
        
        UNTIL EmployeeTransactions.NEXT = 0;
        */

    end;


    procedure fnUpdatePeriodTransCurrency(EmployeeCode: Code[10]; TransactionCode: Code[20]; PayrollMonth: Integer; PayrollYear: Integer; PayrollPeriod: Date; Amount: Decimal)
    var
        EmployeeTransactions: Record "PR Employee Transactions";
    begin
        /*
        PeriodTransAmountLCY := 0;
        PeriodTransCurrrency := '';
        PeriodTransAmountFCY := 0;
        
        EmployeeTransactions.RESET;
        EmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
        EmployeeTransactions.SETRANGE(EmployeeTransactions."Employee Code",EmployeeCode);
        EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Code",TransactionCode);
        EmployeeTransactions.SETRANGE(EmployeeTransactions."Payroll Period",PayrollPeriod);
        IF EmployeeTransactions.FIND('-') THEN
        BEGIN
          IF EmployeeTransactions.Currency <> '' THEN
            BEGIN
              PeriodTransAmountLCY := Amount;//fnCurrencyConv(EmployeeTransactions.Currency,PayrollPeriod,Amount,TRUE);
              PeriodTransCurrrency := EmployeeTransactions.Currency;
              PeriodTransAmountFCY := fnCurrencyConv(EmployeeTransactions.Currency,PayrollPeriod,Amount,FALSE);
            END
          ELSE
           BEGIN
              PeriodTransAmountLCY := Amount;
              PeriodTransCurrrency := EmployeeTransactions.Currency;
              PeriodTransAmountFCY := Amount;
           END
        END //system transactions like bpay,gpay,npay
          ELSE
           BEGIN
              SalCard.GET(EmployeeCode);
              IF SalCard.Currency <> '' THEN
               BEGIN
                PeriodTransAmountLCY := Amount;//fnCurrencyConv(SalCard.Currency,PayrollPeriod,Amount,TRUE);
                PeriodTransCurrrency := SalCard.Currency;
                PeriodTransAmountFCY := fnCurrencyConv(SalCard.Currency,PayrollPeriod,Amount,FALSE)
               END
              ELSE
               BEGIN
                PeriodTransAmountLCY := Amount;
                PeriodTransCurrrency := SalCard.Currency;
                PeriodTransAmountFCY := Amount;
               END
           END;
        {
        IF (TransactionCode = 'BPAY') OR (TransactionCode = 'BPAYFULL') THEN
        BEGIN
          SalCard.GET(EmployeeCode);
          IF SalCard.Currency <> '' THEN
           BEGIN
            PeriodTransAmountLCY := fnCurrencyConv(SalCard.Currency,PayrollPeriod,Amount,TRUE);
            PeriodTransCurrrency := SalCard.Currency;
            PeriodTransAmountFCY := Amount;//fnCurrencyConv(SalCard.Currency,PayrollPeriod,Amount,FALSE);
           END
        END
        }
        */

    end;
}
