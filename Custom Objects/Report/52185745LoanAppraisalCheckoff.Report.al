Report 52185745 "Loan Appraisal Checkoff"
{
    RDLCLayout = './bc-azima-2026/Layout/Loan Appraisal Checkoff.rdl';
    Caption = 'Loan Appraisal Check-off';
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    dataset
    {
        dataitem(Loans; Loans)
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
            column(TotalProcessingAmt; TotalProcessingAmt)
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
            // dataitem("Standing Order Header"; "Standing Order Header")
            // {
            //     DataItemLink = "Member No." = field("Member No.");
            //     DataItemTableView = where(Status = const(Approved));
            //     column(STO_No; "No.")
            //     {

            //     }
            //     column(STO_Source_Account_No_; "Source Account No.")
            //     {

            //     }
            //     column(STO_Amount; Amount)
            //     {

            //     }
            //     // column(STOAmount; STOAmount)
            //     // {

            //     // }

            //     dataitem("Standing Order Lines"; "Standing Order Lines")
            //     {
            //         DataItemLink = "Document No." = field("No.");
            //         //DataItemTableView = where(Status = const(Approved));
            //         column(STOL_Destination_Account_Type; "Destination Account Type")
            //         {

            //         }
            //         column(STOL_Destination_Account_No_; "Destination Account No.")
            //         {

            //         }
            //         column(STOL_Transaction_Type; "Transaction Type")
            //         {

            //         }
            //         column(STOL_Amount; Amount)
            //         {

            //         }
            //     }

            // }
            trigger OnAfterGetRecord()
            begin
                LoanFormFees := 0;
                LoanFormFeesExc := 0;
                LoanProcessingAmt := 0;
                LoanProcessingAmtEx := 0;
                InsuranceFee := 0;
                InsuranceFeeExc := 0;
                OneMonthInterest := 0;
                DepPurchaseComm := 0;
                DepPurchaseCommExc := 0;
                GrossPay := 0;
                OneThirdGross := 0;
                TotalRepay := 0;
                TotalAllowance := 0;
                THouseAllow := 0;
                TotalBasic := 0;
                TDeductions := 0;
                TPension := 0;
                NetSalary := 0;
                TotalGuaranteed := 0;

                ProductFactory.get(Loans."Loan Product Type");
                //Get Charges and commissions
                //1. Form fees - this is applicable to all loan applications
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Form Fees");
                if PCharges.Find('-') then begin
                    repeat

                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then
                            LoanFormFees := Loans."Approved Amount" * (PCharges.Percentage / 100)
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                LoanFormFees := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                    PCharges.TestField(PCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    LoanFormFees := Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    LoanFormFees := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                            LoanFormFeesExc := LoanFormFees * GenSetup."Excise Duty (%)" * 0.01;
                        end;
                    until PCharges.Next = 0;
                end;

                //2. Processing fees - this is applicable to all loan applications
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

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                            LoanProcessingAmtEx := LoanProcessingAmt * GenSetup."Excise Duty (%)" * 0.01;
                        end;
                    until PCharges.Next = 0;
                    TotalProcessingAmt := LoanProcessingAmt + LoanProcessingAmtEx;
                end;

                //3. Insurance fees
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Insurance Fees");
                if PCharges.Find('-') then begin
                    repeat
                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount" = true) then
                            InsuranceFee := Loans."Approved Amount" * (PCharges.Percentage / 100)
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                InsuranceFee := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                    PCharges.TestField(PCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    InsuranceFee := Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    InsuranceFeeExc := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.Get();//TESTFIELD("Excise Duty G/L");
                            InsuranceFeeExc := InsuranceFee * GenSetup."Excise Duty (%)" * 0.01;
                        end;
                    until PCharges.Next = 0;
                end;

                if Loans."Loans - Deposit Purchase" > 0 then begin
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Boosting");
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

                //if Loans."Total TopUp" > 0 then begin

                //Pass loan clearance principle and interest
                TopUpComms := 0;
                TopUp.RESET;
                TopUp.SETRANGE(TopUp."Loan No.", Loans."Loan No.");
                IF TopUp.FIND('-') THEN BEGIN
                    REPEAT
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SETRANGE(PCharges."Charge Type", PCharges."Charge Type"::"Top up");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT
                                ExcemptProductCharges.Reset();
                                ExcemptProductCharges.SetRange("Loan No.", Loans."Loan No.");
                                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                                ExcemptProductCharges.setrange(Excempt, true);
                                if not ExcemptProductCharges.Find('-') then begin
                                    IF (PCharges."Use Percentage" = TRUE) AND (PCharges."Charging Option" = PCharges."Charging Option"::"On Approved Amount") THEN BEGIN
                                        // TopUp.Commision := Loans."Approved Amount" * (PCharges.Percentage / 100);
                                        TopUp.Commision := TopUp."Principle Top Up" * (PCharges.Percentage / 100);
                                    END ELSE
                                        IF (PCharges."Use Percentage" = TRUE) AND (PCharges."Charging Option" = PCharges."Charging Option"::"On Net Amount") THEN BEGIN
                                            TopUp.Commision := TopUp."Outstanding Balance" * (PCharges.Percentage / 100);
                                        END ELSE
                                            TopUp.Commision := PCharges."Charge Amount";
                                    //MESSAGE('Running Charge topup %1',TotalComputedCharges);
                                end;
                                TopUpComms += TopUp.Commision;
                            UNTIL PCharges.NEXT = 0;
                        END;
                        TopUp.Modify;
                    UNTIL TopUp.NEXT = 0;
                end;

                TopUp.Reset;
                TopUp.SetRange("Loan No.", "Loan No.");
                if TopUp.Findset() then begin
                    // TopUp.calcsums(Commision);
                    TopUp.CalcSums("One Month Interest");
                    Topup.CalcSums("Total Top Up");
                    // Topup.CalcSums("Interest Top Up");
                    OneMonthInterest := TopUp."One Month Interest";

                    // PrincipleTopup := TopUp."Principle Top Up";
                    // InterestTopup := TopUp."Interest Top Up";
                    // Totaltopup := PrincipleTopup + InterestTopup;
                    OffsetTotal := TopUp."Total Top Up";
                end;
                //end;


                //get share capital
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."product category"::"Share Capital");
                if SavAcc.Find('-') then begin
                    ShareCapital := SavAcc.GetAvailableBalance(SavAcc."No.");
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

                //Qualification on salary
                AppraisalSal.Reset;
                AppraisalSal.SetRange("Loan No", "Loan No.");
                if AppraisalSal.Find('-') then begin
                    repeat
                        if AppraisalSal.Type = AppraisalSal.Type::Basic then
                            TotalBasic := TotalBasic + AppraisalSal.Amount
                        else
                            if (AppraisalSal.Type = AppraisalSal.Type::Earnings) or (AppraisalSal.Type = AppraisalSal.Type::"Other Allowances") then
                                TrEarni := TrEarni + AppraisalSal.Amount
                            else
                                if (AppraisalSal.Type = AppraisalSal.Type::Deductions) or (AppraisalSal.Type = AppraisalSal.Type::PAYE) or (AppraisalSal.Type = AppraisalSal.Type::NSSF)
                                or (AppraisalSal.Type = AppraisalSal.Type::SHIF) or (AppraisalSal.Type = AppraisalSal.Type::HLEVY) then
                                    TDeductions := TDeductions + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::Pension then
                                        TPension := TPension + AppraisalSal.Amount
                                    else if AppraisalSal.type = AppraisalSal.type::"House Allowance" then
                                        THouseAllow := THouseAllow + AppraisalSal.Amount
                    until AppraisalSal.Next = 0;

                end;
                GrossPay := round(((TotalBasic + TrEarni + THouseAllow)), 0.01);
                NetSalary := round(((TotalBasic + TrEarni + THouseAllow) - TDeductions), 0.01);
                OneThirdGross := round((GrossPay * 0.33), 0.01);
                TwoThirdGross := round((GrossPay * 0.66), 0.01);

                DisposableInc := TwoThirdGross - TDeductions;

                if DisposableInc < 0 then
                    DisposableInc := 0
                else begin
                    IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                        PresentVAF := ((1 - POWER((1 + (Loans.Interest / 1200)), -Loans.Installments)) / (Loans.Interest / 1200));
                    END ELSE BEGIN
                        PresentVAF := (Loans.Installments * 100) / ((Loans.Installments * (Loans.Interest / 12)) + 100);
                    END;
                    NetOnSalary := DisposableInc * PresentVAF;
                end;

                //check to limit the maximum loan amount of the product
                if NetOnSalary > ProductFactory."Maximum Loan Amount" then begin
                    NetOnSalary := ProductFactory."Maximum Loan Amount";
                end;

                //CheckActive
                if Members.Get(Loans."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                    if Members.Status <> Members.Status::Active then
                        Inactive := true;
                end;
                //Cleared external effects affecting qualification
                ExternalEff.Reset;
                ExternalEff.SetRange("Loan No.", "Loan No.");
                ExternalEff.SetRange("Affects 2/3 Rule", true);
                if ExternalEff.Find('-') then begin
                    ExternalEff.CalcSums("Monthly Deduction");
                    TotalExteralRec := ExternalEff."Monthly Deduction";
                end;

                //Qualification on deposits
                //Multiplie changes if its on collateral
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Collateral);
                LoanGua.SetRange(Substituted, false);
                if LoanGua.findfirst() then begin
                    if ProductFactory."Dep. Multiplier On Collateral" <> 0 then
                        Mult := ProductFactory."Dep. Multiplier On Collateral";
                end;

                MemberDeposits := 0;
                Mult := ProductFactory."Ordinary Deposits Multiplier";
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    MemberDeposits := SavingsAccounts."Balance (LCY)";//+Loans."Loans - Deposit Purchase";
                end;
                QualificationOnDeposits := (MemberDeposits + loans."Loans - Deposit Purchase") * Mult;
                DepositMult := QualificationOnDeposits;

                if ProductFactory."Minimum Deposit Balance" <> 0 then begin
                    if (MemberDeposits + loans."Loans - Deposit Purchase") < ProductFactory."Minimum Deposit Balance" then begin
                        Message('Thus Member has not met the minimun deposit of %1', format((MemberDeposits + loans."Loans - Deposit Purchase")));
                        QualificationOnDeposits := 0;
                    end;
                end;

                //Existing Loans
                TotalRepay := 0;
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", Loans."Member No.");
                Loan.SetRange(Loan.Posted, true);
                //Loan.SetRange(Loan."Source Unit", Loan."Source Unit"::BOSA);
                //exclude BGL and FGL
                Loan.SetFilter("Loan Product Type", '<>BGL&<>FGL');
                Loan.SetAutoCalcFields("Total Balance");
                Loan.SetFilter("Total Balance", '>%1', 0);
                if Loan.FindSet() then begin
                    repeat
                        LoanTopup.reset();
                        LoanTopup.SetRange("Loan No.", Loans."Loan No.");
                        LoanTopup.setrange("Loan Top Up", Loan."Loan No.");
                        if LoanTopup.FindFirst() then begin
                            if (LoanTopup."Total Top Up" < Loan."Total Balance") then begin
                                // Message(Format(Loan."Loan No."));
                                // Message(format(LoanTopup."Total Top Up"));
                                // Message(Format(Loan."Total Balance"));
                                TotalRepay += Loan.Repayment;
                                TotalLoanBal += Loan."Total Balance";
                            end;
                        end
                        else begin
                            TotalRepay += Loan.Repayment;
                            TotalLoanBal += Loan."Total Balance";
                        end;
                    until Loan.Next = 0;
                end;


                QualificationOnDeposits -= TotalLoanBal;

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    if QualificationOnDeposits > ProductFactory."Maximum Loan Amount" then
                        QualificationOnDeposits := ProductFactory."Maximum Loan Amount";
                end;

                //get no of guarantors
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                //LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                LoanGua.SetRange(Substituted, false);
                if LoanGua.Findset() then begin
                    NofGuar := LoanGua.Count;
                    Loangua.CalcSums("Amount Guaranteed");
                    TotalGuaranteed := LoanGua."Amount Guaranteed";
                end;

                //Take car 
                if ProductFactory."Type of Discounting" = ProductFactory."Type of Discounting"::"Dividend Discounting" then begin
                    QualifyingAmount := LoanProcess.ComputeDividendsDiscounting(Loans."Member No.", Loans."Loan Product Type", false);
                    NetOnSalary := LoanProcess.ComputeDividendsDiscounting(Loans."Member No.", Loans."Loan Product Type", false);
                end;
                if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Karibu Loan") or (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Commercial Bridging") then
                    NetOnSalary := Loans."Requested Amount";
                if Loans."Requested Amount" > NetOnSalary then begin
                    QualifyingAmount := NetOnSalary;

                    // if ProductFactory."Secured Loan" then begin
                    if QualifyingAmount > QualificationOnDeposits then
                        QualifyingAmount := QualificationOnDeposits;
                    // end;

                    if QualifyingAmount > TotalGuaranteed then
                        QualifyingAmount := TotalGuaranteed;

                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Approved Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Amount To Disburse" := ROUND(QualifyingAmount, 1, '<');
                end else begin
                    QualifyingAmount := Loans."Requested Amount";
                    // if ProductFactory."Secured Loan" then begin
                    // if ProductFactory."Secured Loan" then begin
                    if QualifyingAmount > QualificationOnDeposits then
                        QualifyingAmount := QualificationOnDeposits;
                    // end;

                    if QualifyingAmount > TotalGuaranteed then
                        QualifyingAmount := TotalGuaranteed;
                    // end;
                    Loans."Recommended Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Approved Amount" := ROUND(QualifyingAmount, 1, '<');
                    Loans."Amount To Disburse" := ROUND(QualifyingAmount, 1, '<');
                end;





                //get remaining months to retire
                GeneralSetUp.Get;

                if Members.Get(Loans."Member No.") then begin
                    if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                        if Loans."Expected Date of Completion" > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                            MemberDueRetire := true;

                        RetirementDate := CALCDATE(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth");
                        TodayDate := TODAY;
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

                if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Karibu Loan") or (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::"Commercial Bridging") then begin
                    Loans."Recommended Amount" := Loans."Requested Amount";

                    Loans."Approved Amount" := Loans."Recommended Amount";
                    Loans."Amount To Disburse" := Loans."Recommended Amount";
                end;
                if Loans."Self Guarantee" = true then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                    SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.FindFirst() then begin
                        QualifyingAmount := LoanAppCodeunit.GetmaxSelfGuaranteeAmt(SavingsAccounts."No.", Loans."Loan No.");
                        Message('Self Guarantee Qualifying Amt %1', QualifyingAmount);
                        if Loans."Requested Amount" > QualifyingAmount then begin
                            Loans."Recommended Amount" := QualifyingAmount;
                            Loans."Approved Amount" := QualifyingAmount;
                            Loans."Amount To Disburse" := QualifyingAmount;
                        end
                        else begin
                            Loans."Recommended Amount" := Loans."Requested Amount";
                            Loans."Approved Amount" := Loans."Requested Amount";
                            Loans."Amount To Disburse" := Loans."Requested Amount";
                        end;
                    end;
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

                //recalculate repayment amount
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Loans.Interest;
                LoanAmount := Loans."Approved Amount";
                RepayPeriod := Loans.Installments;
                LBalance := Loans."Approved Amount";

                if (InterestRate <> 0) and (not ProductFactory."Interest Recovered Upfront") then begin

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

                NetTakeHome := LoanProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
                TotalExciseDuty := DepPurchaseCommExc + TopUpCommExc + LoanProcessingAmtEx + LoanFormFeesExc + InsuranceFeeExc;
                //TotalExciseDuty := Round(TotalExciseDuty, 1, '>');

                // NetTakeHome := NetTakeHome - TotalExciseDuty;
                NetTakeHome := NetTakeHome - (DepPurchaseComm + Loans."Loans - Deposit Purchase" + Loans."Share Boosted Amount" + OneMonthInterest + TopUpComms + OffsetTotal);
                if NetTakeHome < 0 then
                    NetTakeHome := 0;
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

                    // if (ProductFactory."Nature of Loan Type" = ProductFactory."Nature of Loan Type"::IPO) and SalNotThroughSacco then begin
                    //     Loans."Recommended Amount" := 0;
                    //     Loans."Approved Amount" := 0;
                    //     Loans."Amount To Disburse" := 0;
                    // end;

                end;
                Loans.modify;
                LoanGua.Reset;
                LoanGua.SetRange("Loan No", Loans."Loan No.");
                if LoanGua.Find('-') then
                    LoanGua.CalcSums(LoanGua."Amount Guaranteed");

                SecurityTotal := LoanGua."Amount Guaranteed";//-OffsetBalance);
                                                             //MESSAGE('Guar %1 Dep %2 Related %3 OffsetBal %4 ',LoanGua."Amount Guaranteed",SavAcc."Balance (LCY)",RelatedBal,OffsetBalance);

                if SecurityTotal < Loans."Approved Amount" then begin
                    SecurityRisk := true;
                    DiffSec := Loans."Approved Amount" - SecurityTotal;
                end;

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
        LoanRec."Qualification on Deposits" := qualificationOnDeposits;
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
