#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185864 "Loan Appraisal Haramb-Shamba"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Appraisal Haramb-Shamba.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            column(TitleLeaseProvideS; Loans."Title Lease Provide SL")
            {
            }
            column(NationalIdS; Loans."Sale Agreement")
            {
            }
            column(KRAPINS; Loans."20% Payment Slip")
            {
            }
            column(PropertyCostValue; Loans."Property Cost Value")
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
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }

            column(DepositPurchase; Loans."Loans - Deposit Purchase")
            {
            }

            // }
            // column(Mult; Mult)
            // {
            // }
            // column(DepositMult; Loans.Deposit_Multiplier)
            // {
            // }
            // column(SalProcessed; SalProcessed)
            // {
            // }
            column(SelfGua; Loans."Self Guarantee")
            {
            }
            // column(CurrBal; CurrLoanBal)
            // {
            // }
            // column(RelatedBal; RelatedBal)
            // {
            // }
            // column(TakeHome; NetTakeHome)
            // {
            // }
            // column(OffsetTotal; OffsetBalance)
            // {
            // }
            // column(MaxDeposit; ProductFactory."Maximum Deposit Contribution")
            // {
            // }
            // column(MonthlyContr; SavAcc."Monthly Contribution")
            // {
            // }
            // column(DirectorWarning; DirectorWarning)
            // {
            // }
            // column(TwoThird; Twothird)
            // {
            // }
            // column(TopUpComms; TopUpComms)
            // {
            // }
            // column(Discmt; DiscAmt)
            // {
            // }
            // column(TExternalEffects; TExternalEffects)
            // {
            // }
            // column(Inactive; Inactive)
            // {
            // }
            // column(ShareBoost; Loans."Share Boosted Amount")
            // {
            // }
            // column(DiffSec; DifferenceSec)
            // {
            // }
            // column(ExternalCharges; ExternalCharges)
            // {
            // }
            column(OtherCharges; Loans."Total Charges and Commissions")
            {
            }
            // column(AthirdDisplay; AthirdDisplay)
            // {
            // }
            // column(AthirdAmt; AthirdAmt)
            // {
            // }
            // column(SalNotThroughSacco; SalNotThroughSacco)
            // {
            // }
            // column(PossibleBoost; PossibleBoost)
            // {
            // }
            // column(GrossAmount; GrossAmount)
            // {
            // }
            // column(AssetValue; AssetValue)
            // {
            // }
            // column(AssetFinCharges; AssetFinCharges2)
            // {
            // }
            // column(AssetFinComms; AssetFinComms2)
            // {
            // }
            // column(AssetFinExerciseDuty; AssetFinExerciseDuty)
            // {
            // }
            // column(TotalAssetValue; TotalAssetValue)
            // {
            // }
            column(CostValue; Loans."Cost Value of House")
            {
            }
            column(ExpiryDate; Loans."Retirement/Expiry Date")
            {
            }
            // column(PaysliProvided; Payslipprovided)
            // {
            // }
            // column(PolicyProtectionProvided; PolicyProtectionProvided)
            // {
            // }
            // column(DomesticCoverProvided; DomesticCoverProvided)
            // {
            // }
            // column(EmployerLetterprovided; EmployerLetterprovided)
            // {
            // }
            // column(BankStatementProvided; BankStatementProvided)
            // {
            // }
            // column(NationalIDProvided; NationalIDProvided)
            // {
            // }
            // column(KRAProvided; KRAProvided)
            // {
            // }
            // column(VendorLetterProvided; VendorLetterProvided)
            // {
            // }
            // column(Member_ID; Loans."ID No.")
            // {
            // }
            // column(DrawdownScheduleProvided; DrawdownScheduleProvided)
            // {
            // }
            // column(InjuryInsuranceProvided; InjuryInsuranceProvided)
            // {
            // }
            column(Insurance_Amount; Loans."Mortgage Insurance Amount")
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
                // column(RemPeriod; RemPeriod)
                // {
                // }
                column(Repayment; AllLoans.Repayment)
                {
                }
                // column(LoansProductTyp; LoansProductTyp)
                // {
                // }

                trigger OnAfterGetRecord()
                var
                    CredLedEntry: Record "Credit Ledger Entry";
                    remPeriod: Decimal;
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
                    LoansProductTyp: Text[100];
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
                // column(GuarantBal; GuarLoanBal)
                // {
                // }
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
                    LoanProcess: Codeunit "Loans Process";
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
            dataitem("Loans Top up"; "Loans Top up")
            {
                DataItemLink = "Loan No." = field("Loan No."), "Client Code" = field("Member No.");
                column(ReportForNavId_97; 97)
                {
                }
                column(LoanNo_LoansTopup; "Loans Top up"."Loan No.")
                {
                }
                column(LoanTopUp_LoansTopup; "Loans Top up"."Loan Top Up")
                {
                }
                column(ClientCode_LoansTopup; "Loans Top up"."Client Code")
                {
                }
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
                column(Payee_OtherCommitementsClearance; "Other Commitements Clearance".Payee)
                {
                }
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
            dataitem(Partial; "Partial Disbursement Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where(Amount = filter(> 0));
                column(ReportForNavId_144; 144)
                {
                }
                column(LoanNo_Partial; Partial."Loan No.")
                {
                }
                column(ScheduledDisbursementDate_Partial; Partial."Scheduled Disbursement Date")
                {
                }
                column(Amount_Partial; Partial.Amount)
                {
                }
                column(Posted_Partial; Partial.Posted)
                {
                }
                column(EntryNo_Partial; Partial."Entry No")
                {
                }
                column(DisbursementDestination_Partial; Partial."Disbursement Destination")
                {
                }
                column(SuggestedforDisbursement_Partial; Partial."Suggested for Disbursement")
                {
                }
                column(DatePosted_Partial; Partial."Date Posted")
                {
                }
                column(TimePosted_Partial; Partial."Time Posted")
                {
                }
                column(PostedBy_Partial; Partial."Posted By")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                LoanProcess: Codeunit "Loans Process";
            begin
                DepPurchaseComm := 0;
                CountNo := 0;
                DifferenceSec := 0;
                SecurityTotal := 0;
                SecurityRisk := false;
                MemberDueRetire := false;
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
                GrossAmount := 0;
                CountAll := 0;
                DiscAmt := 0;
                MultP := 0;
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
                SelfGuaranteedBal := 0;
                AthirdDisplay := '';
                AthirdAmt := 0;
                ExerciseDuty := 0;
                DepPurchaseComm := 0;
                DepPurchaseCommExc := 0;
                PossibleBoost := 0;
                if Loans."Loans - Deposit Purchase" > 0 then begin
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::Boosting);
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
                OffsetBalance := 0;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    AvInterest := ((Loans.Repayment * Loans.Installments) - Loans."Approved Amount") / Loans.Installments
                //ELSE IF Loans."Interest Calculation Method"=Loans."Interest Calculation Method"::"Reducing Flat" THEN
                //  AvInterest:=ROUND(((Loans."Requested Amount"*Interest/12/100)+(LPrincipal*Interest/12/100))/2,1.0,'>')
                else
                    AvInterest := Loans."Loan Interest Repayment";

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
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
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
                        Loan.CalcFields("Total Loan Balance");
                        Loan.Reset;
                        Loan.SetRange(Loan."Member No.", Loans."Member No.");
                        Loan.SetRange(Loan.Posted, true);
                        Loan.SetRange(Loan."Loan Product Type", RelatedProduct."Related Product Code");
                        Loan.SetFilter("Total Loan Balance", '>0');
                        //Loan.SETFILTER("Outstanding Balance",'>0');
                        if Loan.Find('-') then begin
                            repeat
                                if ProductFactory.Get(Loan."Loan Product Type") then
                                    if ProductFactory."Ordinary Deposits Multiplier" >= 4 then
                                        MultP := 4;
                                Loan.CalcFields("Outstanding Balance", "Outstanding Interest");
                                RelatedBal := RelatedBal + Loan."Outstanding Balance" + Loan."Outstanding Interest";
                            until Loan.Next = 0;
                        end;

                    until RelatedProduct.Next = 0;

                    //Added Outside The loOP


                    //Topped up loans related product
                    LoansTopup.Reset;
                    LoansTopup.SetRange(LoansTopup."Loan No.", "Loan No.");
                    if LoansTopup.Find('-') then begin
                        repeat
                            /* Loan.RESET;
                             Loan.SETRANGE("Loan No.",LoansTopup."Loan Top Up");
                             Loan.SETRANGE("Loan Product Type",RelatedProduct."Related Product Code");
                             Loan.SETFILTER("Outstanding Balance",'>0');
                             IF Loan.FIND('-') THEN BEGIN
                               REPEAT*/
                            CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                            TopupRepayments := TopupRepayments + Loan.Repayment;
                            OffsetBalance := OffsetBalance + LoansTopup."Outstanding Balance" + LoansTopup."Interest Top Up";
                        /* UNTIL Loan.NEXT=0;
                       END;*/
                        until LoansTopup.Next = 0;
                    end;
                    //    MESSAGE('Top %1',OffsetBalance);
                end;

                if MultP >= 4 then begin
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        Deposit_Multiplier := (MemberDeposits + Loans."Loans - Deposit Purchase") * MultP;//ProductFactory."Ordinary Deposits Multiplier";
                end else begin
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        Deposit_Multiplier := (MemberDeposits + Loans."Loans - Deposit Purchase") * ProductFactory."Ordinary Deposits Multiplier";

                end;

                NetOnDeposits := Deposit_Multiplier;

                RelatedBal := RelatedBal - OffsetBalance;
                if RelatedBal < 0 then
                    RelatedBal := 0;



                NetOnDeposits := NetOnDeposits - (RelatedBal + SelfGuaranteedBal);
                //NetOnDeposits:=RelatedBal;//-SelfGuaranteedBal;

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

                NewContr := NewContr - SavAcc."Monthly Contribution";



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
                                        TDeductions := TDeductions + AppraisalSal.Amount
                                    else
                                        if AppraisalSal.Type = AppraisalSal.Type::"Gross Pay" then
                                            GrossAmount := GrossAmount + AppraisalSal.Amount;

                    until AppraisalSal.Next = 0;
                end;
                AppraisalSal.Reset;
                AppraisalSal.SetRange("Loan No", "Loan No.");
                AppraisalSal.SetFilter(Code, '7.1EXTERNAL BANK STO');
                AppraisalSal.SetFilter(Amount, '>0');
                if AppraisalSal.Find('-') then begin
                    Loans."Recovery Mode" := Loans."recovery mode"::"Internal STO";
                end else
                    Loans."Recovery Mode" := Loans."recovery mode"::Checkoff;

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

                //Get customer/employer
                if Cust.Get(Members."Employer Code") then begin
                    if Cust."Loan Qualification" = Cust."loan qualification"::"Basic Pay" then begin
                        NetOnSalary := (NetSalary - TBasic * 1 / 3);
                        AthirdDisplay := '1/3 Third of Basic';
                        AthirdAmt := (/*NetSalary-*/TBasic) * 1 / 3
                    end else
                        if Cust."Loan Qualification" = Cust."loan qualification"::"Gross Pay" then begin
                            NetOnSalary := (NetSalary - ((TBasic + TEarning + TAllowance) * 1 / 3));
                            AthirdDisplay := '1/3 Third of Gross';
                            AthirdAmt := (TBasic + TEarning + TAllowance) * 1 / 3;
                        end else
                            if Cust."Loan Qualification" = Cust."loan qualification"::"Standing Order" then begin
                                NetOnSalary := NetSalary;//NetOnDeposits;
                                AthirdDisplay := 'Standing Order';
                                AthirdAmt := NetSalary//NetOnDeposits;
                            end else
                                Error('Employer not found');
                end else begin
                    NetOnSalary := (NetSalary - TBasic * 1 / 3);
                    AthirdDisplay := '1/3 Third of Basic';
                    AthirdAmt := (/*NetSalary-*/TBasic) * 1 / 3
                end;



                if Loans."Recovery Mode" = Loans."recovery mode"::"Internal STO" then
                    NetOnSalary := NetSalary;
                // TotalLoan:=NetOnSalary/(Loans.Interest/12/100) / (1 - POWER((1 + (Loans.Interest/12/100)),- Loans.Installments));

                TotalLoan := NetOnSalary * (1 - Power((1 + (Loans.Interest / 12 / 100)), -Loans.Installments)) / (Loans.Interest / 12 / 100);
                NetOnSalary := TotalLoan;


                //Amount Not greater than qualifying on salary
                if Loans."Requested Amount" > NetOnSalary then begin
                    QualifyingAmount := NetOnSalary;
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1000, '<');
                    ;
                end
                else begin
                    QualifyingAmount := Loans."Requested Amount";
                    Loans."Recommended Amount" := Loans."Requested Amount";
                end;
                //Take care of wafanisi
                /*IF NetOnDeposits>=NetOnSalary THEN BEGIN
                  IF Loans."Requested Amount">NetOnSalary THEN BEGIN
                    QualifyingAmount:=NetOnSalary;
                    Loans."Recommended Amount":=ROUND(QualifyingAmount,1000,'<');;
                  END ELSE BEGIN
                    QualifyingAmount:=Loans."Requested Amount";
                    Loans."Recommended Amount":=ROUND(QualifyingAmount,1000,'<');;
                  END;
                END ELSE BEGIN
                  IF Loans."Requested Amount">NetOnDeposits THEN BEGIN
                    QualifyingAmount:=NetOnDeposits;
                    Loans."Recommended Amount":=ROUND(QualifyingAmount,1000,'<');;
                  END ELSE BEGIN
                    QualifyingAmount:=Loans."Requested Amount";
                    Loans."Recommended Amount":=ROUND(QualifyingAmount,1000,'<');;
                  END;
                
                END;*/



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
                                ExerciseDuty := ExternalCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                            end;
                        end;
                    until OtherCommitments.Next = 0;
                    ExternalCharges2 := ExternalCharges;
                    ExternalCharges := ExternalCharges + ExerciseDuty;

                    //MESSAGE('Here %1',ExternalCharges);
                end;

                //Asset Fin commitments
                AssetFinCharges := 0;
                AssetFinComms := 0;
                AssetValue := 0;
                TotalAssetValue := 0;
                AssetFinanceLoan.Reset;
                AssetFinanceLoan.SetRange(AssetFinanceLoan."Loan No.", Loans."Loan No.");
                if AssetFinanceLoan.Find('-') then begin
                    repeat
                        AssetFinanceLoan.CalcSums(AssetFinanceLoan.Amount);
                        TotalAssetValue := AssetFinanceLoan.Amount;

                        AssetFinCharges := 0;
                        AssetFinExerciseDuty := 0;
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Asset Finance");
                        if PCharges.Find('-') then begin
                            repeat
                                //MESSAGE('Here1 %1',TotalAssetValue);

                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then begin
                                    if ChargeExtraComms = true then
                                        AssetFinComms := AssetFinComms + (AssetFinanceLoan.Amount / (1 + (PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                    else
                                        AssetFinComms := AssetFinComms + (AssetFinanceLoan.Amount / (1 + PCharges.Percentage / 100))
                                end else begin
                                    AssetFinComms := AssetFinComms + PCharges."Charge Amount";
                                end;
                                AssetFinCharges := AssetFinanceLoan.Amount - AssetFinComms;
                            until PCharges.Next = 0;

                            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                GeneralSetUp.Get();
                                AssetFinExerciseDuty := AssetFinCharges * GeneralSetUp."Excise Duty (%)" * 0.01;
                            end;

                        end;
                    until AssetFinanceLoan.Next = 0;
                    AssetFinComms2 := 0;
                    AssetFinCharges2 := AssetFinCharges;
                    AssetFinComms2 := AssetFinComms;
                    AssetFinCharges := AssetFinExerciseDuty;
                end;

                AdjustedNet := (NetSalary);
                NewRepayment := (AdjustedNet - (1 / 3 * (TBasic)));
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



                /*IF NetOnDeposits<Loans."Requested Amount" THEN
                  LoanDepositRation:=TRUE;*/

                GeneralSetUp.Get;

                if Members.Get(Loans."Member No.") then begin
                    if Loans."Dummy Appraisal" = true then if Members."Date of Birth" = 0D then Members."Date of Birth" := 20900101D;
                    if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                        // if Members."Tax Exempted" = true then begin
                        //     if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age - Disabled"), Members."Date of Birth") then
                        //         MemberDueRetire := true;
                        // end else begin
                        //     if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                        //         MemberDueRetire := true;
                        // end;

                        //MESSAGE('Retires %1 Expect Comp%2 Setup %3 DOB %4',MemberDueRetire,Loans."Expected Date of Completion",GeneralSetUp."Max. Member Age",Members."Date of Birth");
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
                TotalGuar := 0;
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                //LoanGua.SETRANGE("Self Guarantee",FALSE);
                if LoanGua.Find('-') then
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");

                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", Loans."Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");

                /*SecurityTotal:=LoanGua."Amount Guaranteed"+Loans."Loans - Deposit Purchase";//+SavAcc."Balance (LCY)";//-Loans."Approved Amount"{(RelatedBal)};//-OffsetBalance);
                TotalGuar:=ROUND(LoanGua."Amount Guaranteed"+Loans."Loans - Deposit Purchase",100,'<');
                
                IF QualifyingAmount>TotalGuar THEN
                    QualifyingAmount:=TotalGuar;
                    Loans."Recommended Amount":=ROUND(QualifyingAmount,1000,'<');*/
                TotalPartial := 0;
                PDisbursement.Reset;
                PDisbursement.SetRange("Loan No.", Loans."Loan No.");
                if PDisbursement.FindFirst then begin
                    PDisbursement.CalcSums(Amount);
                    TotalPartial := PDisbursement.Amount;
                end;

                if Loans."Recommended Amount" < 0 then
                    Loans."Recommended Amount" := 0;


                Loans."Approved Amount" := Loans."Recommended Amount";
                Loans.Validate(Loans."Approved Amount");
                Loans."Amount To Disburse" := Loans."Approved Amount" - TotalPartial;
                NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);


                NetTakeHome := NetTakeHome - ExerciseDuty;
                Loans."Net Amount" := NetTakeHome;

                Loans.Modify;

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


                //Get Possible boosting Amount
                //(NetOnSalary-NetOnDeposits)/Mult
                /*IF (NetOnSalary>NetOnDeposits) AND (NetOnDeposits<Loans."Requested Amount") THEN
                  BEGIN
                    //IF
                    IF NetOnSalary >Loans."Requested Amount"
                      THEN PossibleBoost:=(NetOnSalary-Loans."Requested Amount")/Mult ELSE
                      PossibleBoost:=(NetOnSalary-Loans."Recommended Amount")/Mult;
                    END;*/

                if MultP >= 4 then
                    Mult := 4;

                if Loans."Recovery Mode" = Loans."recovery mode"::"Internal STO" then
                    AthirdAmt := 0;

                if Loans."Three Months Payslip" = true then
                    Payslipprovided := 'Yes'
                else
                    Payslipprovided := 'No';
                if Loans."Mortgage Protection Policy" = true then
                    PolicyProtectionProvided := 'Yes'
                else
                    PolicyProtectionProvided := 'No';
                if Loans."Domestic Insurance Cover" = true then
                    DomesticCoverProvided := 'Yes'
                else
                    DomesticCoverProvided := 'No';
                if Loans."Employer Introduction Letter" = true then
                    EmployerLetterprovided := 'Yes'
                else
                    EmployerLetterprovided := 'No';
                if Loans."Six Months Bank Statement" = true then
                    BankStatementProvided := 'Yes'
                else
                    BankStatementProvided := 'No';
                if Loans."National ID" = true then
                    NationalIDProvided := 'Yes'
                else
                    NationalIDProvided := 'No';
                if Loans."KRA PIN Copy" = true then
                    KRAProvided := 'Yes'
                else
                    KRAProvided := 'No';
                if Loans."Vendor Letter/Sale Agreement" = true then
                    VendorLetterProvided := 'Yes'
                else
                    VendorLetterProvided := 'No';
                if Loans."Drawdown Schedule" = true then
                    DrawdownScheduleProvided := 'Yes'
                else
                    DrawdownScheduleProvided := 'No';
                if Loans."Injury Benefit Insurance" = true then
                    InjuryInsuranceProvided := 'Yes'
                else
                    InjuryInsuranceProvided := 'No';

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
        Cust: Record Customer;
        SelfGuaranteedBal: Decimal;
        TotalLoan: Decimal;
        Denominator: Decimal;
        AthirdDisplay: Text[50];
        AthirdAmt: Decimal;
        emptydateformula: DateFormula;
        ExerciseDuty: Decimal;
        DepPurchaseComm: Decimal;
        DepPurchaseCommExc: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        GenSetup: Record "General Set-Up";
        PossibleBoost: Decimal;
        ExternalCharges2: Decimal;
        GrossAmount: Decimal;
        LoansProductTyp: Text;
        MultP: Integer;
        TotalGuar: Decimal;
        AssetFinanceLoan: Record "Asset Finance Loan";
        AssetFinCharges: Decimal;
        AssetFinComms: Decimal;
        AssetFinCharges2: Decimal;
        AssetFinExerciseDuty: Decimal;
        AssetValue: Decimal;
        TotalAssetValue: Decimal;
        AssetFinComms2: Decimal;
        Payslipprovided: Text;
        PolicyProtectionProvided: Text;
        DomesticCoverProvided: Text;
        EmployerLetterprovided: Text;
        BankStatementProvided: Text;
        NationalIDProvided: Text;
        KRAProvided: Text;
        VendorLetterProvided: Text;
        DrawdownScheduleProvided: Text;
        InjuryInsuranceProvided: Text;
        PDisbursement: Record "Partial Disbursement Schedule";
        TotalPartial: Decimal;
}
