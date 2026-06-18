#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185639 "Loan Appraisal Report-Checkoff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Appraisal Report-Checkoff.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(CName; Company.Name)
            {
            }
            column(CAdress; Company.Address)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
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
            column(Installment; Loans.Installments)
            {
            }
            column(LoanRepayment; Loans.Repayment)
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
            column(TotalLoanBal; TotalLoanBal)
            {
            }
            column(CountNo; CountNo)
            {
            }
            column(LoanRecoverd; LoanRecoverd)
            {
            }
            column(MemberDueRetire; MemberDueRetire)
            {
            }
            column(RemPeriod; RemPeriod)
            {
            }
            column(GuarantorMax; GuarantorMax)
            {
            }
            column(SecurityRisk; SecurityRisk)
            {
            }
            column(ReapplicationPeriod; ReapplicationPeriod)
            {
            }
            column(LoanDepositRation; LoanDepositRation)
            {
            }
            column(TotalBasic; TBasic)
            {
            }
            column(TotalEarning; TEarning)
            {
            }
            column(TotalAllowance; TAllowance)
            {
            }
            column(TotalDeductions; TDeductions)
            {
            }
            column(NetSalary; NetSalary)
            {
            }
            column(AdjNet; AdjustedNet)
            {
            }
            column(NetOnSalary; NetOnSalary)
            {
            }
            column(NetOnDeposits; NetOnDeposits)
            {
            }
            column(ExternalRecovered; TotalExteralRec)
            {
            }
            column(TopupRepayments; TopupRepayments)
            {
            }
            column(NewRep; NewRepayment)
            {
            }
            column(Dim1; Dimension1)
            {
            }
            column(Dim2; Dimension2)
            {
            }
            column(Mult; Mult)
            {
            }
            column(DepositMult; Deposit_Multiplier)
            {
            }
            column(SalProcessed; SalProcessed)
            {
            }
            column(SelfGua; Loans."Self Guarantee")
            {
            }
            column(CurrBal; CurrLoanBal)
            {
            }
            column(RelatedBal; RelatedBal)
            {
            }
            column(TakeHome; NetTakeHome)
            {
            }
            column(OffsetTotal; OffsetBalance)
            {
            }
            column(MaxDeposit; ProductFactory."Maximum Deposit Contribution")
            {
            }
            column(MonthlyContr; SavAcc."Monthly Contribution")
            {
            }
            column(DirectorWarning; DirectorWarning)
            {
            }
            column(TwoThird; Twothird)
            {
            }
            column(TopUpComms; TopUpComms)
            {
            }
            column(Discmt; DiscAmt)
            {
            }
            column(TExternalEffects; TExternalEffects)
            {
            }
            column(Inactive; Inactive)
            {
            }
            column(ShareBoost; Loans."Share Boosted Amount")
            {
            }
            column(DiffSec; DifferenceSec)
            {
            }
            column(ExternalCharges; ExternalCharges)
            {
            }
            column(OtherCharges; Loans."Total Charges and Commissions")
            {
            }
            column(SalNotThroughSacco; SalNotThroughSacco)
            {
            }
            column(RepReq; RepBasedOnRequested)
            {
            }
            column(IntReq; IntBasedOnRequested)
            {
            }
            column(AverageInt; AvInterest)
            {
            }
            column(MemberDeposits; MemberDeposits)
            {
            }
            column(MonthsToRetire; MonthsToRetire)
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
                    LoansTopup: Record "Loans Top up";
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
                begin
                    if LoansTopup.Get(AllLoans."Loan No.") then
                        CurrReport.Skip;
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
                column(GuarantBal; GuarLoanBal)
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
                    ProductFactory: Record "Product Factory";
                    CountNo: Integer;
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
                      MESSAGE(FORMAT(DifferenceSec));
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

            trigger OnAfterGetRecord()
            begin
                CountNo := 0;
                DifferenceSec := 0;
                SecurityTotal := 0;
                SecurityRisk := false;
                MemberDueRetire := false;
                MonthsToRetire := 0;
                GuarantorMax := false;
                LoanRecoverd := false;
                LoanDepositRation := false;
                Twothird := false;
                Deposit_Multiplier := 0;
                RelatedBal := 0;
                NetOnDeposits := 0;
                TopupRepayments := 0;
                AdjustedNet := 0;
                NetSalary := 0;
                TotalExteralRec := 0;
                NetOnSalary := 0;
                QualifyingAmount := 0;
                TDeductions := 0;
                TAllowance := 0;
                TBasic := 0;
                CountAll := 0;
                DiscAmt := 0;
                AvInterest := 0;
                NewRepayment := 0;
                CurrLoanBal := 0;
                ChargeExtraComms := false;
                Dimension1 := '';
                Dimension2 := '';
                Mult := 0;
                NetTakeHome := 0;
                TExternalEffects := 0;
                Inactive := false;
                GuarLoanBal := 0;
                GuarantorMax := false;
                RepBasedOnRequested := 0;
                IntBasedOnRequested := 0;


                SalProcessed := false;
                OffsetBalance := 0;
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    AvInterest := ((Loans.Repayment * Loans.Installments) - Loans."Requested Amount") / Loans.Installments
                else
                    AvInterest := Loans."Loan Interest Repayment";

                RepBasedOnRequested := ROUND((Loans."Interest Calculation Method" / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) * Loans."Requested Amount", 1, '>');


                SalProc.Reset;
                SalProc.SetRange("Member No.", Loans."Member No.");
                if SalProc.Find('-') then
                    SalProcessed := true;
                ProductFactory.Get(Loans."Loan Product Type");

                //Qualification on deposits
                MemberDeposits := 0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    MemberDeposits := SavingsAccounts."Balance (LCY)" + Loans."Loans - Deposit Purchase";
                end;

                Mult := ProductFactory."Ordinary Deposits Multiplier";

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    Deposit_Multiplier := MemberDeposits * ProductFactory."Ordinary Deposits Multiplier";
                    NetOnDeposits := Deposit_Multiplier;
                    if NetOnDeposits > ProductFactory."Maximum Loan Amount" then
                        NetOnDeposits := ProductFactory."Maximum Loan Amount";
                end;



                //MESSAGE('Dep %1 Deposits Mult %2 ',Deposit_Multiplier,ProductFactory."Ordinary Share Multiplier");

                //Less balances from related loans
                RelatedProduct.Reset;
                RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
                if RelatedProduct.Find('-') then begin
                    repeat
                        Loan.Reset;
                        Loan.SetRange(Loan."Member No.", Loans."Member No.");
                        Loan.SetRange(Loan.Posted, true);
                        Loan.SetRange(Loan."Loan Product Type", RelatedProduct."Related Product Code");
                        if Loan.Find('-') then begin
                            repeat
                                Loan.CalcFields("Outstanding Balance");
                                RelatedBal := RelatedBal + Loan."Outstanding Balance";
                            until Loan.Next = 0;
                        end;

                        //Topped up loans related product
                        LoansTopup.Reset;
                        LoansTopup.SetRange("Loan No.", "Loan No.");
                        if LoansTopup.Find('-') then begin
                            repeat
                                Loan.Reset;
                                Loan.SetRange("Loan No.", LoansTopup."Loan Top Up");
                                Loan.SetRange("Loan Product Type", RelatedProduct."Related Product Code");
                                if Loan.Find('-') then begin
                                    repeat
                                        CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                                        TopupRepayments := TopupRepayments + Loan.Repayment;
                                        OffsetBalance := OffsetBalance + LoansTopup."Principle Top Up";
                                    until Loan.Next = 0;
                                end;
                            until LoansTopup.Next = 0;
                        end;



                    until RelatedProduct.Next = 0;
                end;




                NetOnDeposits := NetOnDeposits - (RelatedBal + CurrLoanBal - OffsetBalance);

                if Members.Get(Loans."Member No.") then begin
                    Dimension1 := Members."Global Dimension 1 Code";
                    Dimension2 := Members."Global Dimension 2 Code";
                    if Members.Status <> Members.Status::Active then
                        Inactive := true;
                end;

                //contractual shares
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then begin
                    if ProductFactory."Minimum Dep. Contribution %" > 0 then begin
                        if ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01 > ProductFactory."Maximum Deposit Contribution" then
                            NewContr := ProductFactory."Maximum Deposit Contribution"
                        else
                            NewContr := ProductFactory."Minimum Dep. Contribution %" * Loans."Approved Amount" * 0.01;
                    end;
                end;

                //MESSAGE('Curr Contr %1 New Contr %2 Prod fact %3',SavAcc."Monthly Contribution",NewContr,ProductFactory."Minimum Dep. Contribution %");
                //Difference
                if NewContr < ProductFactory."Minimum Deposit Contribution" then
                    NewContr := ProductFactory."Minimum Deposit Contribution";

                // NewContr := NewContr - SavAcc."Monthly Contribution";



                //IF NewContr<0 THEN
                // NewContr:=0;

                //end of contribution


                //Qualification on salary
                AppraisalSal.Reset;
                AppraisalSal.SetRange("Loan No", "Loan No.");
                if AppraisalSal.Find('-') then begin
                    repeat
                        if AppraisalSal.Type = AppraisalSal.Type::Basic then
                            TBasic := TBasic + AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::Earnings then
                                TEarning := AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                    TAllowance := TAllowance + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::Deductions then
                                        TDeductions := TDeductions + AppraisalSal.Amount;
                    until AppraisalSal.Next = 0;
                end;

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


                NetSalary := (TBasic + TEarning + TAllowance - TDeductions);
                //MESSAGE('Net Sal %1 Tallow %2 TotRep %3 Ext %4 NewContr %5',NetSalary,TAllowance,TopupRepayments,TotalExteralRec,NewContr);
                AdjustedNet := (NetSalary - TAllowance) + (TAllowance * 0.3) + TopupRepayments + TotalExteralRec - NewContr;
                NetOnSalary := (AdjustedNet - (1 / 3 * (TBasic + TEarning))) * Loans.Installments;
                NewRepayment := (AdjustedNet - (1 / 3 * (TBasic + TEarning)));
                //MESSAGE('Adjnet %1 Tbasic %2 Tearning %3',AdjustedNet,TBasic,TEarning);



                //MESSAGE('Net On salary %1 Installments %2',NetOnSalary,Loans.Installments);

                if NetOnDeposits >= NetOnSalary then begin
                    if Loans."Requested Amount" > NetOnSalary then begin
                        QualifyingAmount := NetOnSalary;
                        Loans."Recommended Amount" := QualifyingAmount;
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := QualifyingAmount;
                    end;
                end else begin
                    if Loans."Requested Amount" > NetOnDeposits then begin
                        QualifyingAmount := NetOnDeposits;
                        Loans."Recommended Amount" := QualifyingAmount;
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := QualifyingAmount;
                    end;

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
                                if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                    if ChargeExtraComms = true then
                                        Amt := (Loans."Approved Amount" * (PCharges.Percentage + PCharges."Additional Charge %") / 100)
                                    else
                                        Amt := (Loans."Approved Amount" * (PCharges.Percentage / 100));
                                end else
                                    if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
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


                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
                        if PCharges.Find('-') then begin
                            repeat
                                if (PCharges."Use Percentage" = true) then begin
                                    if ChargeExtraComms = true then
                                        ExternalCharges := ExternalCharges + (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                    else
                                        ExternalCharges := ExternalCharges + (OtherCommitments.Amount * (PCharges.Percentage / 100))
                                end else
                                    ExternalCharges := ExternalCharges + OtherCommitments.Amount;
                            //MESSAGE('Running Charge  other comms%1',TotalComputedCharges);
                            until PCharges.Next = 0;

                        end;
                    until OtherCommitments.Next = 0;
                end;


                //Balancing entry if disbursed via Savings
                //IF LoanApps."All Posting through Savings Ac"=TRUE THEN BEGIN

                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                if LoanGua.Find('-') then
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", Loans."Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");

                SecurityTotal := LoanGua."Amount Guaranteed" + Loans."Loans - Deposit Purchase" + SavAcc."Balance (LCY)" - (RelatedBal - OffsetBalance);
                //MESSAGE('Guar %1 Dep %2 Related %3 OffsetBal %4 ',LoanGua."Amount Guaranteed",SavAcc."Balance (LCY)",RelatedBal,OffsetBalance);

                if SecurityTotal < Loans."Approved Amount" then begin
                    SecurityRisk := true;
                    DifferenceSec := Loans."Approved Amount" - SecurityTotal;

                end;

                if QualifyingAmount < SecurityTotal then
                    QualifyingAmount := SecurityTotal;
                Loans."Recommended Amount" := QualifyingAmount;



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

                if Members.Get(Loans."Member No.") then begin
                    if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                        if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                            MemberDueRetire := true;

                        RetirementDate := CALCDATE(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth");
                        TodayDate := TODAY;

                        // if RetirementDate <= TodayDate then
                        //     exit(0); // Already retired

                        MonthsToRetire := ROUND((RetirementDate - TodayDate) / 30, 1);




                        //MESSAGE('Retires %1 Expect Comp%2 Setup %3 DOB %4',MemberDueRetire,Loans."Expected Date of Completion",GeneralSetUp."Max. Member Age",Members."Date of Birth");
                    end;
                end;

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Member No.", Loans."Member No.");
                    Loan.SetRange(Loan."Loan Product Type", Loans."Loan Product Type");
                    Loan.SetRange(Loan.Posted, true);
                    if Loan.Find('-') then begin
                        if Today < CalcDate(Format(ProductFactory."Min. Re-application Period"), Loan."Disbursement Date") then
                            ReapplicationPeriod := true;
                    end;

                end;
                if Loans."Recommended Amount" < 0 then
                    Loans."Recommended Amount" := 0;

                Loans."Approved Amount" := Loans."Recommended Amount";
                Loans."Amount To Disburse" := Loans."Recommended Amount";

                NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
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
                end;
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

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        DCSParameterMatrix: Record "DCS Parameter Matrix";
        ParameterBold: Boolean;
        ParamContribution: Option "Formula Factor","Flat Rate",Range,Ceiling,Multiplier,Divisor,Frequency,"Sum",Difference,"Graduated Range",Exponential,Terminate,Probability,Floor;
        ParamFormula: Text;
        SavingsAccounts: Record "Savings Accounts";
        MemberDeposits: Decimal;
        Loan: Record Loans;
        TotalLoanBal: Decimal;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        CountNo: Integer;
        GuarantorMax: Boolean;
        ProductFactory: Record "Product Factory";
        LoanRecoverd: Boolean;
        GeneralSetUp: Record "General Set-Up";
        Members: Record "Members";
        MemberDueRetire: Boolean;
        SecurityTotal: Decimal;
        SecurityRisk: Boolean;
        LoanDepositRation: Boolean;
        ReapplicationPeriod: Boolean;
        Deposit_Multiplier: Decimal;
        RelatedProduct: Record "Related Product";
        RelatedBal: Decimal;
        NetOnDeposits: Decimal;
        AppraisalSal: Record "Appraisal Salary Details";
        TBasic: Decimal;
        TEarning: Decimal;
        TAllowance: Decimal;
        TDeductions: Decimal;
        LoanTopup: Record "Loans Top up";
        TopupRepayments: Decimal;
        AdjustedNet: Decimal;
        NetSalary: Decimal;
        ExternalEff: Record "Other Commitements Clearance";
        TotalExteralRec: Decimal;
        NetOnSalary: Decimal;
        QualifyingAmount: Decimal;
        AvInterest: Decimal;
        NewContr: Decimal;
        SavAcc: Record "Savings Accounts";
        NewRepayment: Decimal;
        CurrLoanBal: Decimal;
        Dimension1: Code[20];
        Dimension2: Code[20];
        Mult: Decimal;
        NetTakeHome: Decimal;
        LoanProcess: Codeunit "Loans Process";
        SalProc: Record "Salary Lines";
        SalProcessed: Boolean;
        OffsetBalance: Decimal;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        AccountSignatories: Record "Account Signatories";
        DirectorWarning: Boolean;
        MssgDefault: label 'This member has defaulted Loan-:';
        Twothird: Boolean;
        TopUp: Record "Loans Top up";
        PCharges: Record "Loan Product Charges";
        Amt: Decimal;
        TopUpComms: Decimal;
        Loans2: Record Loans;
        DiscAmt: Decimal;
        DifferenceSec: Decimal;
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
        RetirementDate: Date;
        TodayDate: Date;
        MonthsToRetire: Integer;


}
