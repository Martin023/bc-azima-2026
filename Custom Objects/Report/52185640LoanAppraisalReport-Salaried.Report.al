#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185640 "Loan Appraisal Report-Salaried"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Appraisal Report-Salaried.rdl';

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
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(Dim1; Dim1)
            {

            }
            column(TrEarni; TrEarni)
            {

            }
            column(SmallSalo; SmallSalo)
            {

            }

            column(CompanyNam; CompanyNam)
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
            column(TotaLFosaIn; TotaLFosaIn)
            { }
            column(MemberDueRetire; MemberDueRetire)

            { }
            column(MonthsToRetire; MonthsToRetire)

            { }
            column(TopUpComms; TopUpComms)

            { }
            column(CountNo; CountNo)
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
            column(NetOnDeposits; NetOnDeposits)
            {

            }

            column(TotalRepay; TotalRepay)
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
            column(ShareCapital; ShareCapital)
            {

            }
            column(QualificationOnDeposits; QualificationOnDeposits)
            {

            }
            column(LoanDepositRation; LoanDepositRation)
            {

            }
            // column(RemPeriod; RemPeriod)
            // {

            // }
            column(TotalSaye; TotalSaye)
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

            column(LoanNo; Loans."Loan No.")
            {
            }


            column(TDeductions; TDeductions
            )
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(TotalProcessingAmt; TotalProcessingAmt)
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
            column(LoanApproveddBy; Loans."Approved By")
            {
            }
            column(LoanAppraiseddBy; Loans."Loan Appraised By")
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
            column(Loan_IN_Repayment; "Loan Interest Repayment")
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
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0));
                column(ReportForNavId_18; 18)
                {
                }
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
                    // NofGuar := CountNo;



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
                column(OffsetTotalz; OffsetTotal)

                { }
                column(TotalEarning; TotalEarning)
                { }
                column(TopUpCommss; TopUpComms)

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

            }
            dataitem("Standing Order Header"; "Standing Order Header")
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where(Status = const(Approved));
                column(STO_No; "No.")
                {

                }
                column(STO_Source_Account_No_; "Source Account No.")
                {

                }
                column(STO_Amount; Amount)
                {

                }
                // column(STOAmount; STOAmount)
                // {

                // }

                dataitem("Standing Order Lines"; "Standing Order Lines")
                {
                    DataItemLink = "Document No." = field("No.");
                    //DataItemTableView = where(Status = const(Approved));
                    column(STOL_Destination_Account_Type; "Destination Account Type")
                    {

                    }
                    column(STOL_Destination_Account_No_; "Destination Account No.")
                    {

                    }
                    column(STOL_Transaction_Type; "Transaction Type")
                    {

                    }
                    column(STOL_Amount; Amount)
                    {

                    }
                }

            }
            trigger OnAfterGetRecord()
            begin
                DepPurchaseComm := 0;
                // CountNo := 0;
                DiffSec := 0;
                SecurityTotal := 0;
                SecurityRisk := false;
                MemberDueRetire := false;
                MonthsToRetire := 0;
                GuarantorMax := false;
                LoanRecoverd := false;
                LoanDepositRation := false;
                Twothird := false;
                DepositMult := 0;
                RelatedBal := 0;
                RelatedRepayments := 0;
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
                TDeductions := 0;
                GrossAmount := 0;
                CountAll := 0;
                TotaLFosaIn := 0;
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
                TopUpCommExc := 0;
                ShareBoostComm := 0;
                ShareComm := 0;
                SharecommExc := 0;
                TotalRepayements := 0;
                STOAmount := 0;
                PossibleBoost := 0;
                //TO DO:GETMONTHS TO RETIRE
                // GenSetup.Get();
                // DOB:=Cust.Get()
                // yrs :=CalcDate(GenSetup."Max. Member Age",DOB)-TODAY;
                //TO DO:GETMONTHS TO RETIRE
                StandingOrderHeader.RESET;
                StandingOrderHeader.SETRANGE("Member No.", Loans."Member No.");
                StandingOrderHeader.SetRange("Income Type", StandingOrderHeader."Income Type"::Salary);
                StandingOrderHeader.SETRANGE(Status, StandingOrderHeader.Status::Approved);
                IF StandingOrderHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        StandingOrderLines.RESET;
                        StandingOrderLines.SETRANGE("Document No.", StandingOrderHeader."No.");
                        IF StandingOrderLines.FINDFIRST THEN BEGIN
                            REPEAT
                                STOAmount += StandingOrderLines.Amount;
                                LoansTopup.Reset;
                                LoansTopup.SetRange("Loan No.", Loans."Loan No.");
                                LoansTopup.SetRange("Loan Top Up", StandingOrderLines."Loan No.");
                                if LoansTopup.Find('-') then begin
                                    if Loans."Recovery Mode" = Loans."Recovery Mode"::Hybrid then begin
                                        STOAmount := STOAmount - StandingOrderLines.Amount;
                                    end;
                                end;
                            UNTIL StandingOrderLines.NEXT = 0;
                        END;
                    UNTIL StandingOrderHeader.NEXT = 0;
                END;
                if Loans."Loans - Deposit Purchase" > 0 then begin
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::Boosting);
                    if PCharges.Find('-') then begin
                        repeat

                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                DepPurchaseComm := (Loans."Loans - Deposit Purchase" * (PCharges.Percentage / 100))
                            // ShareBoostComm := (Loans."Loans - Deposit Purchase" * (PCharges.Percentage / 100))

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


                            // if DepPurchaseComm < PCharges.Minimum then
                            //     DepPurchaseComm := PCharges.Minimum;
                            // if DepPurchaseComm > PCharges.Maximum then
                            //     DepPurchaseComm := PCharges.Maximum;

                            // DepPurchaseComm := DepPurchaseComm * -1;

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


                //get share capital
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."product category"::"Share Capital");
                if SavAcc.Find('-') then begin
                    // SavAcc.CalcFields(SavAcc.Balance);
                    ShareCapital := SavAcc.GetAvailableBalance(SavAcc."No.");
                end;
                //get share capital

                // //Qualification on deposits
                // MemberDeposits := 0;
                // SavingsAccounts.Reset;
                // SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                // SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                // if SavingsAccounts.Find('-') then begin
                //     SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                //     MemberDeposits := SavingsAccounts."Balance (LCY)";//+Loans."Loans - Deposit Purchase";
                // end;
                // QualificationOnDeposits := (MemberDeposits + loans."Loans - Deposit Purchase") * Mult;

                // if ProductFactory.Get(Loans."Loan Product Type") then begin
                //     NetOnDeposits := QualificationOnDeposits;
                //     if NetOnDeposits > ProductFactory."Maximum Loan Amount" then
                //         NetOnDeposits := ProductFactory."Maximum Loan Amount";
                // end;


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
                                TopUp.Reset();
                                TopUp.SetRange("Loan No.", Loans."Loan No.");
                                TopUp.SetRange("Loan Top Up", loan."Loan No.");
                                if not TopUp.Find('-') then begin
                                    TotalRepayements := TotalRepayements + Loan.Repayment;
                                    RelatedRepayments += Loan.Repayment;
                                    RelatedBal := RelatedBal + Loan."Outstanding Balance";
                                end;
                            until Loan.Next = 0;
                        end;
                    until RelatedProduct.Next = 0;
                end;
                //total topup amount
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
                //total topupamount
                RelatedBal := RelatedBal - OffsetTotal;
                if RelatedBal < 0 then
                    RelatedBal := 0;


                // NetOnDeposits := NetOnDeposits - OffsetTotal;

                if Members.Get(Loans."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                    if Members.Status <> Members.Status::Active then
                        Inactive := true;
                end;
                BusinessIncome.Reset;
                BusinessIncome.SetRange("Loan No.", Loans."Loan No.");
                if BusinessIncome.Find('-') then begin
                    BusinessIncome.CalcSums("Average Amount (Internal)");
                    NetOnSalary := BusinessIncome."Average Amount (Internal)";

                end;
                ProductFactory.Get(Loans."Loan Product Type");
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
                if SavAcc.Find('-') then begin
                    SmallSalo := GlobalFunc.GetSmallestSalary(SavAcc."No.", ProductFactory."Salary Income Types");
                end;
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



                //IF NewContr<0 THEN
                // NewContr:=0;

                //end of contribution


                //Qualification on salary
                AppraisalSal.Reset;
                AppraisalSal.SetRange("Loan No", "Loan No.");
                if AppraisalSal.Find('-') then begin
                    repeat
                        if AppraisalSal.Type = AppraisalSal.Type::"Net Income" then
                            TotalBasic := TotalBasic + AppraisalSal.Amount

                        else
                            if AppraisalSal.Type = AppraisalSal.Type::Earnings then
                                TrEarni := TrEarni + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::Deductions then
                                    TDeductions := TDeductions + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::Pension then
                                        TPension := TPension + AppraisalSal.Amount
                    until AppraisalSal.Next = 0;
                end;

                //KKaimor
                // TotaLFosaIn := TotalBasic + TotalSaye + TrEarni + TPension;

                TotaLFosaIn := (TotalBasic + TrEarni + TPension) - TDeductions;//deductions for variables
                if TotaLFosaIn < 0 then
                    TotaLFosaIn := 0;



                //Cleared external effects affecting qualification
                ExternalEff.Reset;
                ExternalEff.SetRange("Loan No.", "Loan No.");
                ExternalEff.SetRange("Affects 2/3 Rule", true);
                if ExternalEff.Find('-') then begin
                    ExternalEff.CalcSums("Monthly Deduction");
                    TotalExteralRec := ExternalEff."Monthly Deduction";
                end;

                // //Total cleared effects
                // ExternalEff.Reset;
                // ExternalEff.SetRange("Loan No.", "Loan No.");
                // if ExternalEff.Find('-') then begin
                //     ExternalEff.CalcSums(ExternalEff.Amount);
                //     TExternalEffects := ExternalEff.Amount;
                // end;
                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    NetSalary := TotaLFosaIn;
                    if NetSalary < 0 then
                        NetSalary := 0;
                end;
                //TotalLoan := NetOnSalary * (1 - Power((1 + (Loans.Interest / 12 / 10)), -Loans.Installments)) / (Loans.Interest / 12 / 100);
                // TotaLFosaIn := TotaLFosaIn - (TotalRepayements + STOAmount);
                //TOTAL Loan Bal-TOPUP
                //Total Loans
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", Loans."Member No.");
                Loan.SetRange(Loan.Posted, true);
                Loan.SetRange(Loan."Source Unit", Loan."Source Unit"::FOSA);
                //exclude BGL and FGL
                Loan.SetFilter("Loan Product Type", '<>BGL&<>FGL');
                Loan.SetFilter("Outstanding Balance", '>%1', 0);
                if Loan.Find('-') then begin
                    repeat
                        if Loan."Loan Product Type" <> 'DAL' then begin
                            Loan.CalcFields(Loan."Outstanding Balance", "Outstanding Interest");
                            TotalLoanBal := TotalLoanBal + Loan."Outstanding Balance" + Loan."Outstanding Interest";
                            TotalRepay := TotalRepay + Loan.Repayment;
                        end;

                    // if Loan."Recovered Loan" <> '' then
                    // LoanRecoverd := true;
                    until Loan.Next = 0;
                    //check if topped up
                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", "Loan No.");
                    LoansTopup.SetRange(LoansTopup."Source Unit", LoansTopup."Source Unit"::FOSA);
                    if LoansTopup.Find('-') then begin
                        repeat
                            if Loan."Loan Product Type" <> 'DAL' then begin
                                CurrLoanBalf := CurrLoanBalf + LoansTopup."Monthly Repayment";
                                // TopupRepayments := TopupRepayments + Loan.Repayment;
                                TopupRepaymentsf := TopupRepaymentsf + LoansTopup."Monthly Repayment";
                                OffsetTotalf := OffsetTotalf + LoansTopup."Total Top Up";
                            end;
                        until LoansTopup.Next = 0;

                    end;
                    //check if topped up
                    TotalLoanBal := TotalLoanBal - OffsetTotalf;

                    TotalRepay := TotalRepay - TopupRepaymentsf;
                end;
                //TOTAL Loan Bak-topup
                //get Net on Deposit
                //Qualification on deposits
                MemberDeposits := 0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    MemberDeposits := SavingsAccounts."Balance (LCY)";//+Loans."Loans - Deposit Purchase";
                end;
                QualificationOnDeposits := (MemberDeposits + loans."Loans - Deposit Purchase") * Mult;

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    NetOnDeposits := QualificationOnDeposits;
                    if ProductFactory."Product ID" <> 'FML' then // Exclude fosa MAKAO from existing loans check - ticket#666 LOAN APPRAISAL ON FOSA OKOA LOAN
                        NetOnDeposits := NetOnDeposits - TotalLoanBal;
                    if NetOnDeposits > ProductFactory."Maximum Loan Amount" then
                        NetOnDeposits := ProductFactory."Maximum Loan Amount";
                end;

                //get Net on Deposit
                GenSetup.Get();
                MinFosaBal := GenSetup."FOSA Minimum";
                //vuka n steppa loan excemption from fosa minimu appraisal
                ProductFactory.Get(Loans."Loan Product Type");
                if ProductFactory."Exempt From Fosa Minimum" = true then begin
                    MinFosaBal := 0;
                end;
                TotaLFosaIn := TotaLFosaIn - (TotalRepay + STOAmount + MinFosaBal);
                // NetOnSalary := TotaLFosaIn * ProductFactory."FosaLoan Multiplier";//wil not need this at t
                //Kenpipe Computation on fosa loan eligibility
                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                    PresentVAF := ((1 - POWER((1 + (Loans.Interest / 1200)), -Loans.Installments)) / (Loans.Interest / 1200));
                END ELSE BEGIN
                    PresentVAF := (Loans.Installments * 100) / ((Loans.Installments * (Loans.Interest / 12)) + 100);
                END;
                NetOnSalary := TotaLFosaIn * PresentVAF;
                //fosa loan eligibilty

                //check

                //check to limit the maximum loan amount of the product
                if NetOnSalary > ProductFactory."Maximum Loan Amount" then begin
                    NetOnSalary := ProductFactory."Maximum Loan Amount";
                end else begin
                    // NetOnSalary := TotaLFosaIn * ProductFactory."FosaLoan Multiplier";
                    NetOnSalary := TotaLFosaIn * PresentVAF;
                end;
                //NetOnSalary := NetOnSalary - 

                //Take car 
                if ProductFactory."Type of Discounting" = ProductFactory."Type of Discounting"::"Dividend Discounting" then begin
                    QualifyingAmount := LoanProcess.ComputeDividendsDiscounting(Loans."Member No.", Loans."Loan Product Type", false);
                    NetOnSalary := LoanProcess.ComputeDividendsDiscounting(Loans."Member No.", Loans."Loan Product Type", false);
                end;
                if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Karibu Loan") or (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Commercial Bridging") then
                    NetOnSalary := Loans."Requested Amount";
                if Loans."Requested Amount" > NetOnSalary then begin
                    QualifyingAmount := NetOnSalary;
                    if QualifyingAmount > NetOnDeposits then
                        QualifyingAmount := NetOnDeposits;
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Approved Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Amount To Disburse" := ROUND(QualifyingAmount, 1, '<');
                end else begin
                    QualifyingAmount := Loans."Requested Amount";
                    if QualifyingAmount > NetOnDeposits then
                        QualifyingAmount := NetOnDeposits;

                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Approved Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Amount To Disburse" := ROUND(QualifyingAmount, 1, '<');
                end;

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

                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                                    TopUpCommExc := TopUpComms * GenSetup."Excise Duty (%)" * 0.01;
                                end;

                            until PCharges.Next = 0;
                        end;


                    until TopUp.Next = 0;
                end;

                //get no of guarantors
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                if LoanGua.Find('-') then
                    NofGuar := LoanGua.Count;



                //get no of guarantors

                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
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
                        // if LoanProcessingAmt < PCharges.Minimum then
                        //     LoanProcessingAmt := PCharges.Minimum;
                        // if LoanProcessingAmt > PCharges.Maximum then
                        //     LoanProcessingAmt := PCharges.Maximum;

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
                // if NewRepayment < Loans.Repayment then  // A third rule not applicable
                //     Twothird := true;

                //Review later if it will be necessary
                //Total Loans
                // Loan.Reset;
                // Loan.SetRange(Loan."Member No.", Loans."Member No.");
                // Loan.SetRange(Loan.Posted, true);
                // Loan.SetRange(Loan."Source Unit", Loan."Source Unit"::FOSA);
                // Loan.SetFilter("Outstanding Balance", '>%1', 0);
                // if Loan.Find('-') then begin
                //     repeat
                //         Loan.CalcFields(Loan."Outstanding Balance");
                //         TotalLoanBal := TotalLoanBal + Loan."Outstanding Balance";
                //     // if Loan."Recovered Loan" <> '' then
                //     // LoanRecoverd := true;
                //     until Loan.Next = 0;
                // end;



                // if NetOnDeposits < Loans."Requested Amount" then
                //     LoanDepositRation := true;

                // GeneralSetUp.Get;

                // if Members.Get(Loans."Member No.") then begin
                //     if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                //         //MESSAGE('Retires %1 Expect Comp%2 Setup %3 DOB %4',MemberDueRetire,Loans."Expected Date of Completion",GeneralSetUp."Max. Member Age",Members."Date of Birth");
                //     end;
                // end;

                //get remaining months to retire
                GeneralSetUp.Get;

                if Members.Get(Loans."Member No.") then begin
                    if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                        if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                            MemberDueRetire := true;

                        RetirementDate := CALCDATE(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth");
                        TodayDate := TODAY;
                        // MonthsToRetire := ROUND((RetirementDate - TodayDate) / 30, 1);
                        MonthsToRetire := (RetirementDate - TodayDate) DIV 30;



                    end;
                end;

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
                if Loans."Recommended Amount" < 0 then begin
                    Loans."Recommended Amount" := 0;
                    Loans."Approved Amount" := 0;
                    Loans."Amount To Disburse" := 0;
                end;

                if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Karibu Loan") or (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Commercial Bridging") or (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::IPO) then begin
                    Loans."Recommended Amount" := Loans."Requested Amount";

                    Loans."Approved Amount" := Loans."Recommended Amount";
                    Loans."Amount To Disburse" := Loans."Recommended Amount";
                end;


                // Loans.Validate(Loans."Approved Amount");
                Loans.Modify();

                // Get upfront INTEREST
                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    if ProductFactory."Interest Recovered Upfront" then begin
                        upfrontrate := ProductFactory."Upfront Interest Rate";
                        if upfrontrate <> 0 then begin
                            UpfrontInterest += Round(((upfrontrate / 100) * Loans."Approved Amount"), 0.01, '>');

                        end;
                    end;
                end;
                //end of get upfroninterest
                //get totaltopup
                // LoansTopup.Reset;
                // LoansTopup.SetRange(LoansTopup."Loan No.", Loans."Loan No.");
                // LoansTopup.SetRange(LoansTopup."Client Code", Loans."Member No.");
                // // LoansTopup.SetRange(LoansTopup."Loan Type", RelatedProduct."Related Product Code");
                // if LoansTopup.FindFirst() then begin
                //     repeat
                //         CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                //         TopupRepayments := TopupRepayments + Loan.Repayment;
                //         OffsetTotal := OffsetTotal + LoansTopup."Outstanding Balance";
                //     until LoansTopup.Next = 0;
                // end;
                // //get total top up`
                //recalculate repayment amount
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Loans.Interest;
                LoanAmount := Loans."Approved Amount";
                RepayPeriod := Loans.Installments;
                LBalance := Loans."Approved Amount";

                if (InterestRate <> 0) and (not ProductFactory."Interest Recovered Upfront") then begin
                    // EmployerProducts.Reset();
                    // EmployerProducts.SetRange("Product ID", Rec."Loan Product Type");
                    // if EmployerProducts.FindFirst() then begin
                    //     Employerate := EmployerProducts.Interest;
                    //     if Employerate = 0 then
                    //         Employerate := InterestRate
                    //     else
                    //         Employerate := Employerate;
                    // End;
                    if Loans."Interest Calculation Method" = "Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Repayment" := Round(TotalMRepay, 1, '>');
                    end;


                    if Loans."Interest Calculation Method" = "Interest Calculation Method"::"Straight Line" then begin
                        TestField(Loans.Interest);
                        TestField(Loans.Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := Round((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := round((LPrincipal + LInterest), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if Loans."Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        TestField(Loans.Interest);
                        TestField(Loans.Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        //LPrincipal:=LoanAmount/RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                        Repayment := round((LInterest + LPrincipal), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Flat" then begin
                        TestField(Interest);
                        TestField(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        //AmortisedInt:=TotalMRepay*Installments-"Approved Amount";
                        LInterest := Round(((LoanAmount * Interest / 12 / 100) + (LPrincipal * Interest / 12 / 100)) / 2, 1, '>');
                        //LInterest:=AmortisedInt/Installments;
                        Repayment := Round((LPrincipal + LInterest), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;


                    end;

                end else begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    Repayment := ROUND(LPrincipal, 1, '>');
                    Loans."Loan Principle Repayment" := LPrincipal;
                    Loans."Loan Interest Repayment" := 0;
                end;
                Loans.Repayment := Round(Loans.Repayment, 1, '>');
                //recalculate repayment amount
                //UPFRONT INTEREST

                // //otherclearence
                //Toatl top ups
                //exteral commitments
                ExternalCharges := 0;
                OtherComms := 0;
                //Clearing external debts
                OtherCommitments.Reset;
                OtherCommitments.SetRange(OtherCommitments."Loan No.", Loans."Loan No.");
                if OtherCommitments.Find('-') then begin
                    repeat
                        OtherCommitments.CalcSums(OtherCommitments.Amount);
                        // OtherComms := OtherCommitments.Amount;
                        TExternalEffects := TExternalEffects + OtherCommitments.Amount;
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
                                if ExternalCharges > PCharges.Maximum then
                                    ExternalCharges := PCharges.Maximum;
                                if ExternalCharges < PCharges.Minimum then
                                    ExternalCharges := PCharges.Minimum;
                            //MESSAGE('Running Charge  other comms%1',ExternalCharges);
                            until PCharges.Next = 0;
                            //  GeneralSetUp.GET;
                            //  IF ExternalCharges>GeneralSetUp."Max External Clearance Amount" THEN
                            //  ExternalCharges:=GeneralSetUp."Max External Clearance Amount";
                            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                GeneralSetUp.Get();
                                ExerciseDuty := ExternalCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                            end;
                        end;
                    until OtherCommitments.Next = 0;
                    ExternalCharges2 := ExternalCharges;
                    ExternalCharges := ExternalCharges + ExerciseDuty;
                    //MESSAGE('Here %1',ExternalCharges);
                end;
                //otherclearence

                if Loans."Recommended Amount" < 0 then begin
                    Loans."Recommended Amount" := 0;
                    Loans."Approved Amount" := 0;
                    Loans."Amount To Disburse" := 0;
                end;

                NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
                // TotalExciseDuty := LoanProcess.ComputeExciseDuty(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
                TotalExciseDuty := DepPurchaseCommExc + TopUpCommExc + LoanProcessingAmtEx;
                TotalExciseDuty := Round(TotalExciseDuty, 1, '>');

                //Net take Home
                // NetTakeHome := NetTakeHome - TotalExciseDuty;
                NetTakeHome := NetTakeHome - (TotalExciseDuty + DepPurchaseComm + Loans."Loans - Deposit Purchase" + Loans."Share Boosted Amount");
                if NetTakeHome > 0 then begin
                    NetTakeHome := NetTakeHome;
                end else begin
                    NetTakeHome := 0;
                end;
                // NetTakeHome := NetTakeHome;
                Loans."Net Amount" := NetTakeHome;
                if Loans.Status = Loans.Status::Open then
                    Loans."Loan Appraised By" := UserId;
                //Net take Home
                Loans.Modify;
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

                    if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::IPO) and SalNotThroughSacco then begin
                        Loans."Recommended Amount" := 0;
                        Loans."Approved Amount" := 0;
                        Loans."Amount To Disburse" := 0;
                    end;

                end;
                Loans.modify;
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                if LoanGua.Find('-') then
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", Loans."Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");

                SecurityTotal := LoanGua."Amount Guaranteed" + SavAcc."Balance (LCY)" - (RelatedBal);//-OffsetBalance);
                                                                                                     //MESSAGE('Guar %1 Dep %2 Related %3 OffsetBal %4 ',LoanGua."Amount Guaranteed",SavAcc."Balance (LCY)",RelatedBal,OffsetBalance);

                if SecurityTotal < Loans."Approved Amount" then begin
                    SecurityRisk := true;
                    DiffSec := Loans."Approved Amount" - SecurityTotal;

                end;


                // if (NetOnSalary > NetOnDeposits) and (NetOnDeposits < Loans."Requested Amount") then begin
                //     //IF
                //     if NetOnSalary > Loans."Requested Amount"
                //       then
                //         PossibleBoost := (NetOnSalary - Loans."Requested Amount") / Mult
                //     else
                //         PossibleBoost := (NetOnSalary - Loans."Recommended Amount") / Mult;
                // end;
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


        // // Insert the new record
        // LoanRec.Init();
        // LoanRec."Loan No." := LoanNo;
        // LoanRec."Member No" := Loans."Member No.";
        // LoanRec."Staff No" := Loans."Staff No";
        // LoanRec."Loan Product Type" := LoansProductTyp;
        // LoanRec."Requested Amount" := Loans."Requested Amount";
        // LoanRec."Approved Amount" := Loans."Approved Amount";
        // LoanRec."Recommended Amount" := Loans."Recommended Amount";
        // LoanRec."Member Deposits" := MemberDeposits;
        // LoanRec."Deposit Boosting" := Loans."Loans - Deposit Purchase";
        // LoanRec."Current Contribution" := MonthlyContr;
        // LoanRec."Qualification on Deposits" := NetOnDeposits;
        // LoanRec.Installments := Loans.Installments;
        // LoanRec."Existing Loans" := TotalLoanBal;
        // LoanRec."Deposit multiplier" := Mult;
        // LoanRec."Qualification on Salary" := NetOnSalary;
        // LoanRec."Qualification on Guarantors" := SecurityTotal;
        // LoanRec."Possible Deposit Boost" := PossibleBoost;
        // LoanRec."No. of Gurantors" := CountNo;
        // LoanRec."Other Clearence" := TExternalEffects;
        // LoanRec."Other Clearence Fee" := ExternalCharges;
        // LoanRec."Other Clearence Duty" := TotalExciseDuty;
        // LoanRec."Total excise Duty" := ExerciseDuty;
        // LoanRec."Basic Income" := TotalBasic;
        // LoanRec.Earnings := TotalEarning;
        // LoanRec.Deductions := TotalDeductions;
        // LoanRec."1/3 of Basic" := AthirdAmt;
        // LoanRec."Net Salary" := NetSalary;
        // LoanRec."Amt to Loan" := NetSalary - AthirdAmt;
        // LoanRec."External Effects" := ExternalRecovered;
        // LoanRec."New Net Salary" := NetSalary - Loans.Repayment;
        // LoanRec."Cleared Loans Installment" := TopupRepayments;
        // LoanRec."Adjusted Net" := AdjNet;
        // LoanRec."New Repayment" := Loans.Repayment;
        // LoanRec."Take Home Amount" := NetTakeHome;
        // LoanRec.Insert();
        // Insert the new record
        LoanRec.Init();
        LoanRec."Loan No." := LoanNo;
        LoanRec."Member No" := Loans."Member No.";
        LoanRec."Member Name" := Loans."Member Name";
        LoanRec."Staff No" := Loans."Staff No";
        LoanRec."Loan Product Type" := LoansProductTyp;
        LoanRec."Loan Product Name" := Loans."Loan Product Type Name";
        LoanRec."Application Date" := Loans."Application Date";
        LoanRec."Requested Amount" := Loans."Requested Amount";
        LoanRec."Approved Amount" := Loans."Approved Amount";
        LoanRec."Recommended Amount" := Loans."Recommended Amount";
        LoanRec."Months to Retire" := MonthsToRetire;
        LoanRec."No. of Gurantors" := NofGuar;
        LoanRec."Employer Code" := Loans."Employer Code";
        // LoanRec."Employer Name" := EmployerName;
        LoanRec."Existing Loans" := TotalLoanBal;
        LoanRec.Installments := Loans.Installments;
        LoanRec."Member Deposits" := MemberDeposits;
        LoanRec."Share Capital" := ShareCapital;
        LoanRec.Dimension := Dim1;
        //End of General

        LoanRec."Deposit Boosting" := Loans."Loans - Deposit Purchase";
        // LoanRec."Current Contribution" := NewContr;
        LoanRec."Deposit Mult" := QualificationOnDeposits;
        LoanRec."Processing Fee" := TotalProcessingAmt;
        LoanRec."Dep Purchase Comm" := DepPurchaseComm;
        LoanRec."Dep Purchase Excise" := DepPurchaseCommExc;
        LoanRec."Share Boost" := Loans."Share Boosted Amount";
        LoanRec."Offset Total" := OffsetTotal;
        LoanRec."Top-up Comm" := TopUpComms;
        LoanRec."Top-Excise" := TopUpCommExc;
        LoanRec."Existing Loans" := TotalLoanBal;
        LoanRec."Deposit multiplier" := Mult;
        LoanRec."Qualification on Guarantors" := SecurityTotal;
        LoanRec."Possible Deposit Boost" := PossibleBoost;
        // LoanRec."No. of Gurantors" := CountNo;
        LoanRec."Other Clearence" := TExternalEffects;
        LoanRec."Other Clearence Fee" := ExternalCharges;
        LoanRec."Other Clearence Duty" := TotalExciseDuty;
        LoanRec."Total excise Duty" := ExerciseDuty;
        //end of deductions

        LoanRec."Basic Income" := TotalBasic;
        LoanRec.Earnings := TrEarni;
        LoanRec.Deductions := TDeductions;
        LoanRec."1/3 of Basic" := AthirdAmt;
        LoanRec."1/3 Display" := AthirdDisplay;
        LoanRec."Net Salary" := NetSalary;
        LoanRec."Amt to Loan" := NetSalary - AthirdAmt;
        LoanRec."Qualification on Deposits" := NetOnDeposits;
        LoanRec."Qualification on Salary" := NetOnSalary;
        LoanRec."STO Amount" := STOAmount;
        LoanRec."Fosa Commitments" := TotalRepay;
        LoanRec."Fosa Minimum" := MinFosaBal;
        LoanRec."Amount to Loan" := TotaLFosaIn;
        LoanRec."Upfront int" := UpfrontInterest;
        LoanRec."TopUp Excise" := TopUpCommExc;
        //end of salar details

        LoanRec."External Effects" := TotalExteralRec;
        LoanRec."New Net Salary" := NetSalary - Loans.Repayment;
        LoanRec.Interest := LInterest;
        LoanRec.Principle := LPrincipal;
        LoanRec."Recommended Amount" := Loans."Recommended Amount";
        LoanRec."Cleared Loans Installment" := TopupRepayments;
        // LoanRec."Adjusted Net" := AdjustedNet;
        LoanRec."New Repayment" := Loans.Repayment;
        LoanRec."Take Home Amount" := NetTakeHome;
        // end of repayment
        LoanRec.Insert();
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        // Message('TExternalEffects %1', TExternalEffects);
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
        DCSParameterMatrix: Record "DCS Parameter Matrix";

        ParameterBold: Boolean;
        CompanyTelephone: Text;
        CompanyAddress: Text;
        Salstartend: Date;
        ParamContribution: Option "Formula Factor","Flat Rate",Range,Ceiling,Multiplier,Divisor,Frequency,"Sum",Difference,"Graduated Range",Exponential,Terminate,Probability,Floor;
        ParamFormula: Text;
        SavingsAccounts: Record "Savings Accounts";
        MemberDeposits, QualificationOnDeposits, ShareCapital : Decimal;
        Loan: Record Loans;
        STOAmount: Decimal;
        TotalLoanBal: Decimal;
        TotalRepay: Decimal;

        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        GlobalFunc: Codeunit "Global Functions";
        SmallSalo: Decimal;
        CountNo: Integer;
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
        RelatedBal, Relatedrepayments : Decimal;
        NetOnDeposits: Decimal;
        AppraisalSal: Record "Appraisal Salary Details";
        TotalBasic: Decimal;
        TDeductions: Decimal;
        StandingOrderLines: Record "Standing Order Lines";
        TotalEarning: Decimal;
        TotalSaye: Decimal;
        CompanyNam: Text[100];

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
        GrossAmount: Decimal;
        LoansProductTyp: Text;
        TotalAllowance: Decimal;
        MultP: Integer;
        BusinessIncome: Record "Business Income";
        LoanProcessingAmt: Decimal;
        LoanProcessingAmtEx: Decimal;
        TotalProcessingAmt: Decimal;
        CommunicationOnline: Text[100];
        TrEarni: Decimal;
        Loanapp: Page "Loan Application Card";
        DOB: Date;
        NofGuar: Integer;
        Yrs: Integer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        ExcemptProductCharges: record "Excempted Product Charges";
}
