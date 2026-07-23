#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185747 "Loan Appraisal Bus-Special"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Appraisal Business-Special2.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
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
            column(AvrIncomes; AvrIncomes)
            {

            }
            column(AvrExpeneses; AvrExpeneses)
            {

            }
            column(AvrDispossibleIn; AvrDispossibleIn)
            {

            }
            column(DispossibleIn; DispossibleIn)
            {

            }
            column(CompanyNam; Company.Name)
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CPicture; Company.Picture)
            {
            }
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
            column(MemberDueRetire; MemberDueRetire)

            { }
            column(CountNo; CountNo)
            { }
            column(ReapplicationPeriod; ReapplicationPeriod)
            { }
            column(LoanRecoverd; LoanRecoverd)

            {

            }
            column(NetOnDeposits; NetOnDeposits)
            {

            }
            column(GuarLoanBal; GuarLoanBal)
            {

            }
            column(MaxDeposit; MaxDeposit)

            { }
            column(NetOnSalary; NetOnSalary)
            {

            }
            column(GrossAmount; GrossAmount)
            { }
            column(AthirdDisplay; AthirdDisplay)
            { }
            column(SecurityRisk; SecurityRisk)

            {

            }
            column(NetTakeHome; NetTakeHome)
            {

            }

            column(RelatedBal; RelatedBal)
            { }
            column(TotalLoanBal; TotalLoanBal)
            { }
            column(MemberDeposits; MemberDeposits)
            {

            }
            column(LoanDepositRation; LoanDepositRation)
            {

            }
            column(RemPeriod; RemPeriod)
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

            column(CompanyAddress; Company.Address)
            {
            }
            column(DepositMult; DepositMult)
            { }
            column(AverageInt; Loans."Loan Interest Repayment")
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

            column(LoanNo; Loans."Loan No.")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(LoanProduct; Loans."Loan Product Type")
            {
            }
            column(LoanProductName; Loans."Loan Product Type Name")
            {
            }
            column(ApplicationDate; Loans."Application Date")
            {
            }
            column(LoanRequestedAmount; Loans."Requested Amount")
            {
            }
            column(TotalDeductions; TotalDeductions)
            {

            }

            column(Installment; Loans.Installments)
            {
            }
            column(LoanRepayment; Loans.Repayment)
            {
            }
            column(CapturedBy_Loans; Loans."Captured By")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(ApprovalDate_Loans; Loans."Approval Date")
            {
            }
            column(LoanAppraisedBy_Loans; Loans."Loan Appraised By")
            {
            }
            column(TotalExciseDuty; TotalExciseDuty)
            {

            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }

            column(RecommendedAmt; Loans."Recommended Amount")
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }

            column(DepositPurchase; Loans."Loans - Deposit Purchase")
            {
            }

            column(SelfGua; Loans."Self Guarantee")
            {
            }


            column(ShareBoost; Loans."Share Boosted Amount")
            {
            }

            column(OtherCharges; Loans."Total Charges and Commissions")
            {
            }

            dataitem(AllLoans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0));
                column(ReportForNavId_18; 18)
                {
                }
                column(LoansLoanNo; AllLoans."Loan No.")
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
                    CredLedEntry.SetRange("Loan No", Loans."Loan No.");
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
                column(ReportForNavId_14; 14)
                {
                }
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



                    /*DifferenceSec:=0;
                    "Loan Guarantors and Security".CALCSUMS("Loan Guarantors and Security"."Amount Guaranteed");
                    SavAcc.RESET;
                    SavAcc.SETRANGE(SavAcc."Member No.",Loans."Member No.");
                    SavAcc.SETRANGE(SavAcc."Product Category",SavAcc."Product Category"::"BOSA Deposits");
                    IF SavAcc.FIND('-') THEN
                      SavAcc.CALCFIELDS(SavAcc."Balance (LCY)");
                    
                    SecurityTotal:="Loan Guarantors and Security"."Amount Guaranteed"+SavAcc."Balance (LCY)";
                    */
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        if CountNo < ProductFactory."Minimum Guarantors" then
                            GuarantorMax := true;

                    if (Loans."Approved Amount" > ProductFactory."Max Amt on Guarantors") and (CountNo < (ProductFactory."Minimum Guarantors on Max Amt")) then
                        GuarantorMax := true;


                    //MESSAGE('GuaMax %1 Guar %2 Setup Guar %3',GuarantorMax,CountNo,ProductFactory."Minimum Guarantors");
                    //SecurityTotal:=SecurityTotal+"Loan Guarantors and Security"."Amount Guaranteed";
                    /*IF SecurityTotal<Loans."Requested Amount" THEN BEGIN
                      SecurityRisk:=TRUE;
                      DifferenceSec:=Loans."Requested Amount"-SecurityTotal;
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
                DataItemLink = "Loan No." = field("Loan No."), "Client Code" = field("Member No.");
                column(ReportForNavId_97; 97)
                {
                }
                column(LoanNo_LoansTopup; "Loans Top up"."Loan No.")
                {
                }
                column(OffsetTotal; OffsetTotal)

                { }
                column(TotalEarning; TotalEarning)
                { }
                column(TopUpComms; TopUpComms)

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
                column(TExternalEffects; TExternalEffects)
                { }
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
            }

            trigger OnAfterGetRecord()
            begin
                DepPurchaseComm := 0;
                CountNo := 0;
                DiffSec := 0;
                SecurityTotal := 0;
                SecurityRisk := false;
                MemberDueRetire := false;
                GuarantorMax := false;
                LoanRecoverd := false;
                LoanDepositRation := false;
                Twothird := false;
                DepositMult := 0;
                RelatedBal := 0;
                NetOnDeposits := 0;
                TopupRepayments := 0;
                AdjNet := 0;
                NetSalary := 0;
                TotalExteralRec := 0;
                NetOnSalary := 0;
                QualifyingAmount := 0;
                TotalDeductions := 0;
                TotalAllowance := 0;
                TotalBasic := 0;
                GrossAmount := 0;
                CountAll := 0;
                DiscAmt := 0;
                MultP := 0;
                AverageInt := 0;
                NewRepayment := 0;
                CurrLoanBal := 0;
                ChargeExtraComms := false;
                Dim1 := '';
                Dim2 := '';
                Mult := 0;
                NetTakeHome := 0;
                TExternalEffects := 0;
                Inactive := false;
                GuarLoanBal := 0;
                GuarantorMax := false;
                RepBasedOnRequested := 0;
                IntBasedOnRequested := 0;
                SelfGuaranteedBal := 0;
                AthirdDisplay := '';
                AthirdAmt := 0;
                TotalExciseDuty := 0;
                DepPurchaseComm := 0;
                DepPurchaseCommExc := 0;
                PossibleBoost := 0;
                BusiCou := 0;
                AvrDispossibleIn := 0;
                AvrIncomes := 0;
                DispossibleIn := 0;
                AvrExpeneses := 0;

                if Loans."Loans - Deposit Purchase" > 0 then begin
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Boosting");
                    if PCharges.Find('-') then begin
                        repeat

                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                DepPurchaseComm := (Loans."Loans - Deposit Purchase" * (PCharges.Percentage / 100))
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                    DepPurchaseComm := PCharges."Charge Amount"
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                        PCharges.TestField(PCharges."Staggered Charge Code");

                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                        if TariffDetails.Find('-') then begin
                                            repeat
                                                if (Loans."Loans - Deposit Purchase" >= TariffDetails."Lower Limit") and (Loans."Loans - Deposit Purchase" <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        DepPurchaseComm := Loans."Loans - Deposit Purchase" * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        DepPurchaseComm := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;


                            if DepPurchaseComm < PCharges.Minimum then
                                DepPurchaseComm := PCharges.Minimum;
                            if DepPurchaseComm > PCharges.Maximum then
                                DepPurchaseComm := PCharges.Maximum;

                            DepPurchaseComm := DepPurchaseComm * -1;

                            if ExcemptCharges = true then
                                DepPurchaseComm := 0;

                            //If excise duty involved
                            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                                DepPurchaseCommExc := DepPurchaseComm * GenSetup."Excise Duty (%)" * 0.01;
                            end;
                        until PCharges.Next = 0;

                    end;
                end;
                SalProcessed := false;
                OffsetTotal := 0;
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    AverageInt := ((Loans.Repayment * Loans.Installments) - Loans."Requested Amount") / Loans.Installments
                else
                    AverageInt := Loans."Loan Interest Repayment";

                RepBasedOnRequested := ROUND((Loans."Interest Calculation Method" / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) * Loans."Requested Amount", 1, '>');


                SalProc.Reset;
                SalProc.SetRange("Member No.", Loans."Member No.");
                if SalProc.Find('-') then
                    SalProcessed := true;
                ProductFactory.Get(Loans."Loan Product Type");

                Mult := ProductFactory."Ordinary Deposits Multiplier";

                //Qualification on deposits
                MemberDeposits := 0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Type", ProductFactory."Loan Appraisal Account Code");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    MemberDeposits := SavingsAccounts."Balance (LCY)";//+Loans."Loans - Deposit Purchase";
                end;
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", Loans."Member No.");
                Loan.SetRange(Loan.Posted, true);
                Loan.SetFilter("Outstanding Balance", '>0');
                Loan.SetRange("Self Guarantee", true);
                if Loan.Find('-') then begin
                    repeat
                        Loans.CalcFields("Outstanding Balance");
                        SelfGuaranteedBal := SelfGuaranteedBal + Loans."Outstanding Balance";
                    until Loan.Next = 0;
                end;
                //Less balances from related loans
                RelatedProduct.Reset;
                RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
                if RelatedProduct.Find('-') then begin
                    repeat
                        Loan.Reset;
                        Loan.SetRange(Loan."Member No.", Loans."Member No.");
                        Loan.SetRange(Loan.Posted, true);
                        Loan.SetRange(Loan."Loan Product Type", RelatedProduct."Related Product Code");
                        Loan.SetFilter("Outstanding Balance", '>0');
                        if Loan.Find('-') then begin
                            repeat
                                if ProductFactory.Get(Loan."Loan Product Type") then
                                    Loan.CalcFields("Outstanding Balance");
                                RelatedBal := RelatedBal + Loan."Outstanding Balance";
                            until Loan.Next = 0;
                        end;

                    until RelatedProduct.Next = 0;

                    //Added Outside The loOP


                    //Topped up loans related product
                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", "Loan No.");
                    if LoansTopup.Find('-') then begin
                        repeat
                            CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                            TopupRepayments := TopupRepayments + Loan.Repayment;
                            OffsetTotal := OffsetTotal + LoansTopup."Total Top Up";
                        until LoansTopup.Next = 0;
                    end;

                end;
                Otherdeposits := 0;
                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    OtherAppraisals.Reset();
                    OtherAppraisals.SetRange("Product ID", ProductFactory."Product ID");
                    if OtherAppraisals.Find('-') then begin
                        repeat
                            SavingsAccounts.Reset();
                            SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                            SavingsAccounts.SetRange("Product Type", OtherAppraisals."Product code");
                            if SavingsAccounts.Find('-') then begin
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                Otherdeposits := Otherdeposits + SavingsAccounts."Balance (LCY)";
                            end;
                        until OtherAppraisals.Next() = 0;
                    end;
                end;
                if ProductFactory.Get(Loans."Loan Product Type") then
                    DepositMult := (MemberDeposits + Otherdeposits + Loans."Loans - Deposit Purchase") * ProductFactory."Ordinary Deposits Multiplier";
                NetOnDeposits := DepositMult;
                RelatedBal := RelatedBal - OffsetTotal;
                if RelatedBal < 0 then
                    RelatedBal := 0;
                NetOnDeposits := NetOnDeposits - (RelatedBal + SelfGuaranteedBal);
                //NetOnDeposits:=RelatedBal;//-SelfGuaranteedBal;
                if Members.Get(Loans."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                    if Members.Status <> Members.Status::Active then
                        Inactive := true;
                end;

                //Busines
                BusinessIncome.Reset;
                BusinessIncome.SetRange("Loan No.", Loans."Loan No.");
                if BusinessIncome.Find('-') then begin
                    BusiCou := BusinessIncome.Count;
                    BusinessIncome.CalcSums("Total Credits (Internal)", "Total Debits (Internal)");
                    AvrIncomes := BusinessIncome."Total Credits (Internal)";
                    AvrExpeneses := BusinessIncome."Total Debits (Internal)";
                    DispossibleIn := AvrIncomes - AvrExpeneses;
                    AvrDispossibleIn := Round(DispossibleIn / BusiCou);
                end;
                ProductFactory.Get(Loans."Loan Product Type");
                AvrDispossibleIn := Round((ProductFactory."Net Salary Multiplier %" * AvrDispossibleIn) * 0.01);
                NetOnSalary := Round(AvrDispossibleIn / ((Loans.Interest / (12 * 100)) / (1 - POWER((1 + (Loans.Interest / (12 * 100))), -Loans.Installments))));
                //contractual shares
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then begin
                    MonthlyContr := ProductFactory."Maximum Deposit Contribution";
                    if ProductFactory."Minimum Dep. Contribution %" > 0 then begin
                        if ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01 > ProductFactory."Maximum Deposit Contribution" then
                            MaxDeposit := ProductFactory."Maximum Deposit Contribution"
                        else
                            MaxDeposit := ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01;
                    end;
                end;

                //MESSAGE('Curr Contr %1 New Contr %2 Prod fact %3',SavAcc."Monthly Contribution",NewContr,ProductFactory."Minimum Dep. Contribution %");
                //Difference
                if MaxDeposit < ProductFactory."Minimum Deposit Contribution" then
                    MaxDeposit := ProductFactory."Minimum Deposit Contribution";
                MaxDeposit := MaxDeposit - SavAcc."Monthly Contribution";

                //Cleared external effects affecting qualification
                ExternalEff.Reset;
                ExternalEff.SetRange("Loan No.", "Loan No.");
                ExternalEff.SetRange("Affects 2/3 Rule", true);
                if ExternalEff.Find('-') then begin
                    ExternalEff.CalcSums("Monthly Deduction");
                    TotalExteralRec := ExternalEff."Monthly Deduction";
                end;

                //Total cleared effects
                ExternalEff.Reset;
                ExternalEff.SetRange("Loan No.", "Loan No.");
                if ExternalEff.Find('-') then begin
                    ExternalEff.CalcSums(ExternalEff.Amount);
                    TExternalEffects := ExternalEff.Amount;
                end;

                // NetSalary := (TotalBasic + TotalEarning + TotalAllowance - TotalDeductions);
                // TotalLoan := NetOnSalary * (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) / (Loans.Interest / 12 / 100);
                // NetOnSalary := TotalLoan;

                //Take care of wafanisi
                if NetOnDeposits >= NetOnSalary then begin
                    if Loans."Requested Amount" > NetOnSalary then begin
                        QualifyingAmount := NetOnSalary;
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
                    end;
                end else begin
                    if Loans."Requested Amount" > NetOnDeposits then begin
                        QualifyingAmount := NetOnDeposits;
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
                    end;

                end;
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                //LoanGua.SetRange("Member No", Loans."Member No.");
                if LoanGua.Find('-') then begin
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");
                    SecurityTotal := LoanGua."Amount Guaranteed" - (RelatedBal);
                end;
                if Loans."Recommended Amount" > SecurityTotal then
                    Loans."Recommended Amount" := SecurityTotal;

                //If any has not finished expected reapplication period
                TopUp.Reset;
                TopUp.SetRange("Loan No.", "Loan No.");
                if TopUp.Find('-') then begin
                    repeat
                        if TopUp."Additional Top Up Commission" = true then
                            ChargeExtraComms := true;
                    until TopUp.Next = 0;
                end;

                //Toatl top ups
                TopUp.Reset;
                TopUp.SetRange("Loan No.", "Loan No.");
                if TopUp.Find('-') then begin
                    TopUpComms := 0;
                    repeat
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                        if PCharges.Find('-') then begin
                            repeat
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                    if ChargeExtraComms = true then
                                        Amt := (Loans."Approved Amount" * (PCharges.Percentage + PCharges."Additional Charge %") / 100)
                                    else
                                        Amt := (Loans."Approved Amount" * (PCharges.Percentage / 100));
                                end else
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                        if ChargeExtraComms = true then
                                            Amt := ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage + PCharges."Additional Charge %") / 100)
                                        else
                                            Amt := ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage / 100))
                                    end else
                                        Amt := PCharges."Charge Amount";


                                if Amt < PCharges.Minimum then
                                    Amt := PCharges.Minimum;

                                if Amt > PCharges.Maximum then
                                    Amt := PCharges.Maximum;



                                TopUpComms := TopUpComms + Amt;

                            until PCharges.Next = 0;
                        end;


                    until TopUp.Next = 0;
                end;

                //exteral commitments
                ExternalCharges := 0;
                OtherComms := 0;
                //Clearing external debts
                OtherCommitments.Reset;
                OtherCommitments.SetRange(OtherCommitments."Loan No.", Loans."Loan No.");
                if OtherCommitments.Find('-') then begin
                    repeat
                        OtherCommitments.CalcSums(OtherCommitments.Amount);
                        OtherComms := OtherCommitments.Amount;

                        ExternalCharges := 0;
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
                        if PCharges.Find('-') then begin
                            repeat
                                //MESSAGE('Here1 %1',ExternalCharges);
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then begin
                                    if ChargeExtraComms = true then
                                        ExternalCharges := ExternalCharges + (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                    else
                                        ExternalCharges := ExternalCharges + (OtherCommitments.Amount * (PCharges.Percentage / 100))
                                end else begin
                                    ExternalCharges := ExternalCharges + OtherCommitments.Amount;
                                end;
                            //MESSAGE('Running Charge  other comms%1',ExternalCharges);
                            until PCharges.Next = 0;

                            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                GeneralSetUp.Get();
                                TotalExciseDuty := ExternalCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                            end;
                        end;
                    until OtherCommitments.Next = 0;
                    ExternalCharges2 := ExternalCharges;
                    ExternalCharges := ExternalCharges + TotalExciseDuty;

                    //MESSAGE('Here %1',ExternalCharges);
                end;

                //Balancing entry if disbursed via Savings
                //IF LoanApps."All Posting through Savings Ac"=TRUE THEN BEGIN

                //Loan Processing Fee Charge
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                PCharges.SetRange(PCharges."Charge Description", 'Loan Processing  Charge');
                if PCharges.Find('-') then begin
                    repeat

                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then
                            LoanProcessingAmt := Loans."Approved Amount" * (PCharges.Percentage / 100)
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                LoanProcessingAmt := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                    PCharges.TestField(PCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    LoanProcessingAmt := Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    LoanProcessingAmt := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;


                        if LoanProcessingAmt < PCharges.Minimum then
                            LoanProcessingAmt := PCharges.Minimum;
                        if LoanProcessingAmt > PCharges.Maximum then
                            LoanProcessingAmt := PCharges.Maximum;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                            LoanProcessingAmtEx := LoanProcessingAmt * GenSetup."Excise Duty (%)" * 0.01;
                        end;
                    until PCharges.Next = 0;

                end;
                //END;

                TotalProcessingAmt := LoanProcessingAmt + LoanProcessingAmtEx;
                //


                // Twothird rule
                if NewRepayment < Loans.Repayment then
                    Twothird := true;


                //Total Loans
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", Loans."Member No.");
                Loan.SetRange(Loan.Posted, true);
                if Loan.Find('-') then begin
                    repeat
                        Loan.CalcFields(Loan."Outstanding Balance");
                        TotalLoanBal := TotalLoanBal + Loan."Outstanding Balance";
                        if Loan."Recovered Loan" <> '' then
                            LoanRecoverd := true;
                    until Loan.Next = 0;
                end;



                if NetOnDeposits < Loans."Requested Amount" then
                    LoanDepositRation := true;

                GeneralSetUp.Get;
                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Member No.", Loans."Member No.");
                    Loan.SetRange(Loan."Loan Product Type", Loans."Loan Product Type");
                    Loan.SetRange(Loan.Posted, true);
                    if Loan.Find('-') then begin
                        if Loan."Disbursement Date" = 0D then Loan."Disbursement Date" := Today;
                        if ProductFactory."Min. Re-application Period" <> emptydateformula then
                            if Today < CalcDate(Format(ProductFactory."Min. Re-application Period"), Loan."Disbursement Date") then
                                ReapplicationPeriod := true;
                    end;

                end;
                if Loans."Recommended Amount" < 0 then
                    Loans."Recommended Amount" := 0;
                // Loans."Amount To Disburse" := Loans."Recommended Amount";
                NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);


                //MESSAGE('%1',NetTakeHome);

                //Net take Hone
                NetTakeHome := NetTakeHome - TotalExciseDuty;
                Loans."Net Amount" := NetTakeHome;
                //Net take Home

                //Discuting
                Loans2.Reset;
                Loans2.SetRange(Loans2."Discounted Loan No.", Loans."Loan No.");
                if Loans2.Find('-') then begin
                    Loans2.CalcSums(Loans2."Approved Amount");
                    DiscAmt := Loans2."Approved Amount";
                end;



                //Insert Warnings---Directors
                DirectorWarning := false;
                if Members.Get(Loans."Member No.") then begin
                    AccountSignatories.Reset;
                    AccountSignatories.SetRange("ID Number", Members."Primary Identification");
                    if AccountSignatories.Find('-') then begin
                        repeat
                            Loan.Reset;
                            Loan.SetFilter("Outstanding Bills", '>0');
                            Loan.SetRange("Member No.", AccountSignatories."Account No");
                            if Loan.Find('-') then begin
                                repeat
                                    Loan.CalcFields("Outstanding Bills");
                                    if (Loan."Outstanding Bills" - Loan.Repayment) > 0 then
                                        DirectorWarning := true;
                                until Loan.Next = 0;
                            end;
                        until AccountSignatories.Next = 0;
                    end;
                end;


                if ProductFactory."Requires Salary Processing" = true then begin
                    EndDateSalo := CalcDate('-' + Format(ProductFactory."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                    SalProc.Reset;
                    SalProc.SetRange("Account No.", "Disbursement Account No");
                    SalProc.SetRange("Posting Date", EndDateSalo, Today);
                    SalProc.SetRange(Posted, true);
                    if SalProc.Find('-') then begin
                        if SalProc.Count < ProductFactory."No. of Salary Times" then
                            SalNotThroughSacco := true;

                    end else
                        SalNotThroughSacco := true;
                end;
                SecurityTotal := 0;
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                //LoanGua.SetRange("Member No", Loans."Member No.");
                if LoanGua.Find('-') then begin
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");
                    SecurityTotal := LoanGua."Amount Guaranteed" - (RelatedBal);
                end;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", Loans."Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");

                //-OffsetBalance);
                //MESSAGE('Guar %1 Dep %2 Related %3 OffsetBal %4 ',LoanGua."Amount Guaranteed",SavAcc."Balance (LCY)",RelatedBal,OffsetBalance);

                if SecurityTotal < Loans."Approved Amount" then begin
                    SecurityRisk := true;
                    DiffSec := Loans."Approved Amount" - SecurityTotal;

                end;
                Loans."Loan Appraised By" := UserId;
                Loans.Modify;
                CreateLoanAppraisalBackup(Loans."Loan No.");
            end;
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
    procedure CreateLoanAppraisalBackup(LoanNo: Code[20])
    var
        LoanRec: Record "Loan Appraisal";
    begin


        if LoanRec.Get(LoanNo) then begin
            // Check if the loan is already posted
            if Loans.Posted = true then
                exit; // Skip deletion and insertion if loan is posted

            // If not posted, delete the record
            LoanRec.Delete();
        end;


        // Insert the new record
        LoanRec.Init();
        LoanRec."Loan No." := LoanNo;
        LoanRec."Member No" := Loans."Member No.";
        LoanRec."Staff No" := Loans."Staff No";
        LoanRec."Loan Product Type" := LoansProductTyp;
        LoanRec."Requested Amount" := Loans."Requested Amount";
        LoanRec."Approved Amount" := Loans."Approved Amount";
        LoanRec."Recommended Amount" := Loans."Recommended Amount";
        LoanRec."Member Deposits" := MemberDeposits;
        LoanRec."Deposit Boosting" := Loans."Loans - Deposit Purchase";
        LoanRec."Current Contribution" := MonthlyContr;
        LoanRec."Qualification on Deposits" := NetOnDeposits;
        LoanRec.Installments := Loans.Installments;
        LoanRec."Existing Loans" := TotalLoanBal;
        LoanRec."Deposit multiplier" := Mult;
        LoanRec."Qualification on Salary" := NetOnSalary;
        LoanRec."Qualification on Guarantors" := SecurityTotal;
        LoanRec."Possible Deposit Boost" := PossibleBoost;
        LoanRec."No. of Gurantors" := CountNo;
        LoanRec."Other Clearence" := TExternalEffects;
        LoanRec."Other Clearence Fee" := ExternalCharges;
        LoanRec."Other Clearence Duty" := TotalExciseDuty;
        LoanRec."Total excise Duty" := ExerciseDuty;
        LoanRec."Basic Income" := TotalBasic;
        LoanRec.Earnings := TotalEarning;
        LoanRec.Deductions := TotalDeductions;
        // LoanRec."1/3 of Basic" := AthirdAmt;
        LoanRec."Net Salary" := NetSalary;
        LoanRec."Amt to Loan" := NetSalary - AthirdAmt;
        LoanRec."External Effects" := ExternalRecovered;
        LoanRec."New Net Salary" := NetSalary - Loans.Repayment;
        LoanRec."Cleared Loans Installment" := TopupRepayments;
        LoanRec."Adjusted Net" := AdjNet;
        // LoanRec."New Repayment" := Loans.Repayment;
        LoanRec."Take Home Amount" := NetTakeHome;
        LoanRec.Insert();
    end;

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        DCSParameterMatrix: Record "DCS Parameter Matrix";
        BusiCou: Integer;
        ParameterBold: Boolean;
        ParamContribution: Option "Formula Factor","Flat Rate",Range,Ceiling,Multiplier,Divisor,Frequency,"Sum",Difference,"Graduated Range",Exponential,Terminate,Probability,Floor;
        ParamFormula: Text;
        SavingsAccounts: Record "Savings Accounts";
        MemberDeposits: Decimal;
        Loan: Record Loans;
        TotalLoanBal: Decimal;
        Company: Record "Company Information";
        OtherAppraisals: Record "Other Apprails products";
        LoansTopup: Record "Loans Top up";
        CountNo: Integer;
        GuarantorMax: Boolean;
        ProductFactory: Record "Product Factory";
        LoanRecoverd: Boolean;
        GeneralSetUp: Record "General Set-Up";
        Members: Record "Members";
        AvrIncomes: Decimal;
        AvrExpeneses: Decimal;
        MemberDueRetire: Boolean;
        SecurityTotal: Decimal;
        SecurityRisk: Boolean;
        LoanDepositRation: Boolean;
        ReapplicationPeriod: Boolean;
        DepositMult: Decimal;
        RelatedProduct: Record "Related Product";
        RelatedBal: Decimal;
        NetOnDeposits: Decimal;
        AppraisalSal: Record "Appraisal Salary Details";
        TotalBasic: Decimal;
        TotalEarning: Decimal;
        DispossibleIn: Decimal;
        CompanyNam: Text[100];

        TotalDeductions: Decimal;
        LoanTopup: Record "Loans Top up";
        TopupRepayments: Decimal;
        AdjNet: Decimal;
        NetSalary: Decimal;
        ExternalEff: Record "Other Commitements Clearance";
        TotalExteralRec: Decimal;
        NetOnSalary: Decimal;
        AvrDispossibleIn: Decimal;
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
        SalProcessed: Boolean;
        OffsetTotal: Decimal;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        AccountSignatories: Record "Account Signatories";
        DirectorWarning: Boolean;
        MssgDefault: label 'This member has defaulted Loan-:';
        Twothird: Boolean;
        ExternalRecovered: Decimal;
        TopUp: Record "Loans Top up";
        PCharges: Record "Loan Product Charges";
        Amt: Decimal;
        TopUpComms: Decimal;
        Loans2: Record Loans;
        DiscAmt: Decimal;
        DiffSec: Decimal;
        MonthlyContr: Decimal;
        TExternalEffects: Decimal;
        Inactive: Boolean;
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
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        GenSetup: Record "General Set-Up";
        PossibleBoost: Decimal;
        ExternalCharges2: Decimal;
        GrossAmount: Decimal;
        LoansProductTyp: Text;
        TotalAllowance: Decimal;
        Otherdeposits: Decimal;
        MultP: Integer;
        BusinessIncome: Record "Business Income";
        LoanProcessingAmt: Decimal;
        LoanProcessingAmtEx: Decimal;
        TotalProcessingAmt: Decimal;
        CommunicationOnline: Text[100];
}
