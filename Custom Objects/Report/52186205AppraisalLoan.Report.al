Report 52186205
"Appraisal Loan Report"
{
    RDLCLayout = './bc-azima-2026/Layout/Appraisal Loan.rdl';
    Caption = 'Loan Appraised';
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {

        dataitem("Loan Appraisal"; "Loan Appraisal")
        {
            RequestFilterFields = "Loan No.";
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyNam; CompanyNam)
            {

            }
            column(CPicture; Company.Picture)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }

            column(LoanFormFees; LoanFormFees)
            {
            }
            column(LoanFormFeesExc; LoanFormFeesExc)
            {
            }
            column(InsuranceFee; InsuranceFee)
            {
            }
            column(InsuranceFeeExc; InsuranceFeeExc)
            {
            }
            //
            column(OneMonthInterest; OneMonthInterest)
            {
            }

            column(OnethirdGross; OnethirdGross)
            {
            }
            column(TwoThirdGross; TwoThirdGross)
            {

            }
            column(TotalGuaranteed; TotalGuaranteed)
            {
            }
            column(GuarantorMax; GuarantorMax)
            {
            }
            column(SecurityTotal; SecurityTotal)
            {
            }

            column(Dim1; Dim1)
            {

            }
            column(TrEarni; TrEarni)
            {

            }
            column(THouseAllow; THouseAllow)
            {

            }
            column(DisposableInc; DisposableInc)
            {

            }
            column(GrossPay; GrossPay)
            { }


            column(Dim2; Dim2)
            {

            }
            column(AdjNet; AdjNet)

            { }
            column(SalNotThroughSacco; SalNotThroughSacco)
            { }
            column(TwoThird; TwoThird)

            { }
            column(Mult; Mult)

            { }
            column(TotaLFosaIn; TotaLFosaIn)
            { }
            column(MemberDueRetire; MemberDueRetire)

            { }
            column(MonthsToRetire; MonthsToRetire)

            { }
            column(TopUpComms; TopUpComms)

            { }

            column(NofGuar; NofGuar)
            { }

            column(OffsetTotal; OffsetTotal)

            { }
            column(ReapplicationPeriod; ReapplicationPeriod)
            { }
            column(LoanRecoverd; LoanRecoverd)

            {

            }

            column(TotalRepay; TotalRepay)
            {

            }
            column(TotalLoanBal; TotalLoanBal)
            {

            }

            column(MinFosaBal; MinFosaBal)
            {

            }
            column(GuarLoanBal; GuarLoanBal)//DepPurchaseCommExc
            {

            }
            column(DepPurchaseCommExc; DepPurchaseCommExc)
            {

            }
            column(TopUpCommExc; TopUpCommExc)
            {

            }
            column(MaxDeposit; MaxDeposit)

            { }
            column(NetOnSalary; NetOnSalary)
            {

            }
            column(TExternalEffects; TExternalEffects)
            { }

            column(AthirdDisplay; AthirdDisplay)
            { }
            column(SecurityRisk; SecurityRisk)

            {

            }
            column(NetTakeHome; NetTakeHome)
            {

            }
            column(MemberDeposits; MemberDeposits)
            {

            }
            column(ShareCapital; ShareCapital)
            {

            }
            column(QualificationOnDeposits; QualificationOnDeposits)
            {

            }
            column(LoanDepositRation; LoanDepositRation)
            {

            }
            column(TopupRepayments; TopupRepayments)
            {

            }
            column(AthirdAmt; AthirdAmt)
            { }


            column(NetSalary; NetSalary)
            {

            }
            column(ExternalRecovered; ExternalRecovered)
            { }
            column(DiffSec; DiffSec)

            {

            }
            column(CName; Company.Name)
            {
            }
            column(CompanyAddress; Company.Address)
            {
            }
            column(DepositMult; DepositMult)
            { }
            column(AverageInt; AverageInt)
            { }
            column(Inactive; Inactive)
            {

            }
            column(TotalAllowance; TotalAllowance)
            {

            }
            column(DirectorWarning; DirectorWarning)
            {

            }
            column(TotalBasic; TotalBasic)
            { }

            column(LoanNo; "Loan Appraisal"."Loan No.")
            {
            }

            column(TDeductions; TDeductions
            )
            {
            }
            column(MemberNo; "Loan Appraisal"."Member No")
            {
            }
            column(MemberName; "Loan Appraisal"."Member Name")
            {
            }

            column(LoanProduct; "Loan Appraisal"."Loan Product Type")
            {
            }
            column(LoanProductName; "Loan Appraisal"."Loan Product Name")
            {
            }
            column(ApplicationDate; "Loan Appraisal"."Application Date")
            {
            }
            column(LoanRequestedAmount; "Loan Appraisal"."Requested Amount")
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }

            column(Installment; "Loan Appraisal".Installments)
            {
            }
            column(LoanRepayment; "Loan Appraisal".Repayment)
            {
            }
            // column(CapturedBy_Loans; "Loan Appraisal"."Captured By")
            // {
            // }
            column(ApplicationDate_Loans; "Loan Appraisal"."Application Date")
            {
            }
            // column(ApprovalDate_Loans; "Loan Appraisal"."Approval Date")
            // {
            // }
            column(LoanApproveddBy; "Loan Appraisal"."Loan Approved By")
            {
            }
            column(LoanAppraiseddBy; "Loan Appraisal"."Loan Appraised By")
            {
            }
            column(TotalExciseDuty; TotalExciseDuty)
            {

            }
            column(ShareCommExc; ShareCommExc)
            {
            }
            column(ShareComm; ShareComm)
            {
            }
            column(UpfrontInterest; UpfrontInterest)
            {
            }

            column(RecommendedAmt; "Loan Appraisal"."Recommended Amount")
            {
            }
            column(StaffNo; "Loan Appraisal"."Staff No")
            {
            }

            column(DepositPurchase; "Loan Appraisal"."Deposit Boosting")
            {
            }

            // column(SelfGua; "Loan Appraisal"."Self Guarantee")
            // {
            // }


            column(ShareBoost; "Loan Appraisal"."Share Boost")
            {
            }

            // column(OtherCharges; "Loan Appraisal".)
            // {
            // }
            column(Loan_IN_Repayment; "Loan Appraisal"."Loan Interest Repayement")
            {

            }
            column(DepPurchaseComm; DepPurchaseComm)
            {

            }
            column(ShareBoostComm; ShareBoostComm)
            {

            }
            column(Loan_Pr_Repayment; "Loan Principle Repayment")
            {

            }
            column(STOAmount; STOAmount)
            {

            }

            dataitem(AllLoans; Loans)
            {
                DataItemLink = "Member No." = field("Member No");
                DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0));

                column(LoansLoanNo; AllLoans."Loan No.")
                {
                }

                column(RemPeriod; RemPeriod)
                {

                }
                column(LoansProductType; AllLoans."Loan Product Type")
                {
                }
                column(LoansProductName; AllLoans."Loan Product Type Name")
                {
                }
                column(ApprovedAmount; AllLoans."Approved Amount")
                {
                }
                column(PrincipalRepayment; AllLoans."Loan Principle Repayment")
                {
                }
                column(OutstandingInterest; AllLoans."Outstanding Interest")
                {
                }
                column(Allloanrepayment; AllLoans.Repayment)
                {
                }
                column(OutStandingBalance; AllLoans."Outstanding Balance")
                {
                }
                column(Defaulted; AllLoans.Defaulted)
                {
                }

                column(Repayment; AllLoans.Repayment)
                {
                }


                trigger OnAfterGetRecord()
                var
                    CredLedEntry: Record "Credit Ledger Entry";
                    RemPeriod: Decimal;


                begin

                    CredLedEntry.Reset;
                    CredLedEntry.SetRange("Loan No", "Loan Appraisal"."Loan No.");
                    CredLedEntry.SetFilter("Transaction Type", '%1|%2', CredLedEntry."transaction type"::"Interest Paid", CredLedEntry."transaction type"::Repayment);
                    if CredLedEntry.Find('-') then begin
                        CredLedEntry.CalcSums(Amount);
                        RemPeriod := ROUND((((AllLoans.Repayment * AllLoans.Installments) - CredLedEntry.Amount) / AllLoans.Repayment), 0.0, '>');
                    end else
                        RemPeriod := AllLoans.Installments;
                end;

                trigger OnPreDataItem()
                var
                    LoansTopup: Record "Loans Top up";
                    LoansProductTyp: Text[30];
                begin
                    if LoansTopup.Get(AllLoans."Loan No.") then
                        CurrReport.Skip;
                    LoansProductTyp := '';
                    LoansProductTyp := AllLoans."Loan Product Type" + ' : ' + AllLoans."Loan Product Type Name";
                end;
            }
            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No.");

                column(AccountNo; "Loan Guarantors and Security"."Savings Account No./Member No.")
                {
                }
                column(GuarantorName; "Loan Guarantors and Security".Name)
                {
                }
                column(PayrollNo; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                }
                column(LoanBalance; "Loan Guarantors and Security"."Loan Balance")
                {
                }
                column(Deposits; "Loan Guarantors and Security"."Deposits/Shares")
                {
                }
                column(NoOfLoanGuranteed; "Loan Guarantors and Security"."No Of Loans Guaranteed")
                {
                }
                column(GuarantorType; "Loan Guarantors and Security"."Guarantor Type")
                {
                }

                column(AmtGuaranteed; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(CollateralValue; "Loan Guarantors and Security"."Collateral Value")
                {
                }

                trigger OnAfterGetRecord()
                var
                    LoanGua: Record "Loan Guarantors and Security";
                    LoanApp: Record Loans;
                    CountNo: Integer;
                    ProductFactory: Record "Product Factory";
                    GuarantorMax: Boolean;
                    GuarLoanBal: Decimal;
                    CountAll: Integer;
                begin

                    LoanGua.Reset;
                    LoanGua.SetRange("Loan No", "Loan No");
                    LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                    if LoanGua.Find('-') then
                        CountNo := LoanGua.Count;
                    // NofGuar := CountNo;



                    /*DifferenceSec:=0;
                    "Loan Guarantors and Security".CALCSUMS("Loan Guarantors and Security"."Amount Guaranteed");
                    SavAcc.RESET;
                    SavAcc.SETRANGE(SavAcc."Member No.","Loan Appraisal"."Member No.");
                    SavAcc.SETRANGE(SavAcc."Product Category",SavAcc."Product Category"::"BOSA Deposits");
                    IF SavAcc.FIND('-') THEN
                      SavAcc.CALCFIELDS(SavAcc."Balance (LCY)");
                    
                    SecurityTotal:="Loan Guarantors and Security"."Amount Guaranteed"+SavAcc."Balance (LCY)";
                    */
                    if ProductFactory.Get("Loan Appraisal"."Loan Product Type") then
                        if CountNo < ProductFactory."Minimum Guarantors" then
                            GuarantorMax := true;

                    if ("Loan Appraisal"."Approved Amount" > ProductFactory."Max Amt on Guarantors") and (CountNo < (ProductFactory."Minimum Guarantors on Max Amt")) then
                        GuarantorMax := true;


                    //MESSAGE('GuaMax %1 Guar %2 Setup Guar %3',GuarantorMax,CountNo,ProductFactory."Minimum Guarantors");
                    //SecurityTotal:=SecurityTotal+"Loan Guarantors and Security"."Amount Guaranteed";
                    /*IF SecurityTotal<"Loan Appraisal"."Requested Amount" THEN BEGIN
                      SecurityRisk:=TRUE;
                      DifferenceSec:="Loan Appraisal"."Requested Amount"-SecurityTotal;
                      MESSAGE(FORMAT(DiffSec));
                    END;*/
                    GuarLoanBal := 0;

                    LoanApp.Reset;
                    LoanApp.SetRange("Member No.", "Member No");
                    LoanApp.SetFilter("Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        repeat
                            LoanApp.CalcFields("Outstanding Balance");
                            GuarLoanBal := GuarLoanBal + LoanApp."Outstanding Balance";
                        until LoanApp.Next = 0;
                    end;
                    CountAll := CountAll + 1;

                end;
            }
            dataitem("Loan Required Documents"; "Loan Required Documents")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(ReportForNavId_36; 36)
                {
                }
                column(DocumentType; "Loan Required Documents"."Document Type")
                {
                }
                column(DocumentNo; "Loan Required Documents"."Document No.")
                {
                }
                column(Description; "Loan Required Documents".Description)
                {
                }
                column(SingleMultiple; "Loan Required Documents"."Single Party/Multiple")
                {
                }
                column(Provided; "Loan Required Documents"."Provided ?")
                {
                }
                column(LicenseExpiryDate; "Loan Required Documents"."License Expiry Date")
                {
                }
            }
            dataitem("Loans Top up"; "Loans Top up")
            {
                DataItemLink = "Loan No." = field("Loan No."), "Client Code" = field("Member No");
                column(LoanNo_LoansTopup; "Loans Top up"."Loan No.")
                {
                }
                column(OffsetTotalz; OffsetTotal)

                { }
                column(TotalEarning; TotalEarning)
                { }

                column(LoanTopUp_LoansTopup; "Loans Top up"."Loan Top Up")
                {
                }
                column(ClientCode_LoansTopup; "Loans Top up"."Client Code")
                {
                }
                column(ExerciseDuty; ExerciseDuty)
                { }
                column(LoanType_LoansTopup; "Loans Top up"."Loan Type")
                {
                }
                column(PrincipleTopUp_LoansTopup; "Loans Top up"."Principle Top Up")
                {
                }
                column(InterestTopUp_LoansTopup; "Loans Top up"."Interest Top Up")
                {
                }
                column(TotalTopUp_LoansTopup; "Loans Top up"."Total Top Up")
                {
                }
                column(MonthlyRepayment_LoansTopup; "Loans Top up"."Monthly Repayment")
                {
                }
                column(MonthlyContr; MonthlyContr)

                {

                }
                column(InterestPaid_LoansTopup; "Loans Top up"."Interest Paid")
                {
                }
                column(OutstandingBalance_LoansTopup; "Loans Top up"."Outstanding Balance")
                {
                }
                column(IDNO_LoansTopup; "Loans Top up"."ID. NO")
                {
                }
                column(Commision; Commision)
                {
                }
                column(OneMonthIn; "One Month Interest")
                {
                }
            }
            dataitem("Other Commitements Clearance"; "Other Commitements Clearance")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(ReportForNavId_109; 109)
                {
                }
                column(Description_OtherCommitementsClearance; "Other Commitements Clearance".Description)
                {
                }
                column(ExternalCharges2; ExternalCharges2)
                { }
                column(Payee_OtherCommitementsClearance; "Other Commitements Clearance".Payee)
                {
                }
                // column(TExternalEffects; TExternalEffects)
                // { }
                column(Amount_OtherCommitementsClearance; "Other Commitements Clearance".Amount)
                {
                }
                column(BatchNo_OtherCommitementsClearance; "Other Commitements Clearance"."Batch No.")
                {
                }
                column(VendorNo_OtherCommitementsClearance; "Other Commitements Clearance"."Vendor No.")
                {
                }
                column(VendorName_OtherCommitementsClearance; "Other Commitements Clearance"."Vendor Name")
                {
                }
                column(Destination_Loan_No_; "Destination Loan No.")
                {
                }

            }


        }



    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }


    trigger OnPostReport()
    var
        myInt: Integer;
    begin
    end;

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var

        //Company Information
        Company: Record "Company Information";
        CompanyTelephone: Text;
        CompanyAddress: Text;
        CompanyNam: Text[100];
        CommunicationOnline: Text[100];

        //Deductions
        TotalProcessingAmt: Decimal;
        LoanFormFees: Decimal;
        LoanFormFeesExc: Decimal;

        LoanProcessingAmt: Decimal;
        LoanProcessingAmtEx: Decimal;

        InsuranceFee: Decimal;
        InsuranceFeeExc: Decimal;

        OneMonthInterest: Decimal;

        GrossPay: Decimal;
        OnethirdGross: Decimal;
        //
        SavingsAccounts: Record "Savings Accounts";
        MemberDeposits, QualificationOnDeposits, ShareCapital : Decimal;
        Loan: Record Loans;
        STOAmount: Decimal;
        TotalLoanBal: Decimal;
        TotalRepay: Decimal;
        GlobalFunc: Codeunit "Global Functions";
        DisposableInc: Decimal;
        StandingOrderHeader: Record "Standing Order Header";
        GuarantorMax: Boolean;
        ProductFactory: Record "Product Factory";
        LoanRecoverd: Boolean;
        GeneralSetUp: Record "General Set-Up";
        TotaLFosaIn: Decimal;
        Members: Record "Members";
        MemberDueRetire: Boolean;
        MonthsToRetire: Integer;
        PresentVAF: Decimal;
        RetirementDate: Date;
        TodayDate: Date;
        SecurityTotal: Decimal;
        SecurityRisk: Boolean;
        LoanDepositRation: Boolean;
        ReapplicationPeriod: Boolean;
        DepositMult: Decimal;
        RelatedProduct: Record "Related Product";
        TotalGuaranteed: Decimal;
        AppraisalSal: Record "Appraisal Salary Details";
        TotalBasic: Decimal;
        TDeductions: Decimal;
        StandingOrderLines: Record "Standing Order Lines";
        TotalEarning: Decimal;
        TotalDeductions: Decimal;
        LoanTopup: Record "Loans Top up";
        TopupRepayments: Decimal;
        AdjNet: Decimal;
        NetSalary: Decimal;
        ExternalEff: Record "Other Commitements Clearance";
        TotalExteralRec: Decimal;
        NetOnSalary: Decimal;
        ExerciseDuty: Decimal;
        QualifyingAmount: Decimal;
        AverageInt: Decimal;
        MaxDeposit: Decimal;
        SavAcc: Record "Savings Accounts";
        NewRepayment: Decimal;
        CurrLoanBal: Decimal;
        Dim1: Code[20];
        Dim2: Code[20];
        Mult: Decimal;
        NetTakeHome: Decimal;
        LoanProcess: Codeunit "Loans Process";
        SalProc: Record "Salary Lines";
        TotalRepayements: Decimal;
        MinFosaBal: Decimal;
        SalProcessed: Boolean;
        OffsetTotal: Decimal;

        CurrLoanBalf, TopupRepaymentsf, OffsetTotalf : Decimal;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        AccountSignatories: Record "Account Signatories";
        DirectorWarning: Boolean;
        MssgDefault: label 'This member has defaulted Loan-:';
        Twothird: Boolean;
        ExternalRecovered: Decimal;
        TopUp: Record "Loans Top up";
        PCharges: Record "Loan Product Charges";
        Standingorder: Record "Standing Order Header";
        Amt: Decimal;
        TopUpComms: Decimal;
        Loans2: Record Loans;
        DiscAmt: Decimal;
        DiffSec: Decimal;
        MonthlyContr: Decimal;
        TExternalEffects: Decimal;
        Inactive: Boolean;
        TPension: Decimal;
        GuarLoanBal: Decimal;
        CountAll: Integer;
        LoanGua: Record "Loan Guarantors and Security";
        OtherComms: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
        ChargeExtraComms: Boolean;
        ExternalCharges: Decimal;
        RemPeriod: Decimal;
        CredLedEntry: Record "Credit Ledger Entry";
        SalNotThroughSacco: Boolean;
        EndDateSalo: Date;
        RepBasedOnRequested: Decimal;
        IntBasedOnRequested: Decimal;
        Cust: Record Customer;
        SelfGuaranteedBal: Decimal;
        TotalLoan: Decimal;
        Denominator: Decimal;
        AthirdDisplay: Text[50];
        AthirdAmt: Decimal;
        emptydateformula: DateFormula;
        TotalExciseDuty: Decimal;
        DepPurchaseComm: Decimal;
        DepPurchaseCommExc: Decimal;
        TopUpCommExc: Decimal;
        ShareBoostComm: Decimal;
        ShareComm: Decimal;
        upfrontrate: Decimal;
        UpfrontInterest: Decimal;

        SharecommExc: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        GenSetup: Record "General Set-Up";
        PossibleBoost: Decimal;
        ExternalCharges2: Decimal;
        LoansProductTyp: Text;
        TotalAllowance: Decimal;
        MultP: Integer;
        BusinessIncome: Record "Business Income";
        THouseAllow: Decimal;
        TrEarni: Decimal;
        NofGuar: Integer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        ExcemptProductCharges: record "Excempted Product Charges";
        TwoThirdGross: Decimal;
        LoanAppCodeunit: Codeunit "Loan Appraisal Codeunit";

}
