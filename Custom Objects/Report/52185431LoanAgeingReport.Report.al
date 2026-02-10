#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185431 "Loan Ageing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Ageing Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Application Date", "Disbursement Date", "Loan Product Type";

            DataItemTableView = where(Posted = const(true));
            column(CompanyInformation_Name; CompanyInformation.Name)
            {

            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Loan_No_; "Loan No.")
            {
                //1 Complete
            }
            column(Loan_Product_Type; "Loan Product Type")
            {
                //2 Complete
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
                //3 Complete
            }
            column(EmployerCode; EmployerCode)
            {
                //4 Complete
            }
            column(EmployerName; EmployerName)
            {
                //5 Complete
            }
            column(Member_No_; "Member No.")
            {
                //6 Complete
            }
            column(Member_Name; "Member Name")
            {
                //7 Complete
            }
            column(MemberStatus; MemberStatus)
            {
                //8 Complete
            }
            column(SubFlag; SubFlag)
            {
                //9 Complete
            }
            column(Interest; Loans.Interest)
            {
                //10 Complete
            }
            column(Requested_Amount; "Requested Amount")
            {
                //11 Complete
            }
            column(Disbursed_Amount; "Approved Amount")
            {
                //12 Complete
            }
            column(DisbursementDate; DisbursementDate)
            {
                //13 Complete
            }
            column(Loan_Amortization_Type; "Interest Calculation Method")
            {
                //14 Complete
            }
            column(Repayment_Frequency; "Repayment Frequency")
            {
                //15 Complete
            }
            column(Installments; Installments)
            {
                //16 Complete
            }
            column(LoanPrincipleRepayment; LoanPrincipleRepayment)
            {
                //17 Complete
            }
            column(LoanInterestRepayment; LoanInterestRepayment)
            {
                //18 Complete
            }
            column(MonthlyRepayment; MonthlyRepayment)
            {
                //19  Complete
            }
            column(FirstInstallmentDate; FirstInstallmentDate)
            {
                //20 Complete
            }
            column(NextExpectedDateOfPayment; NextExpectedDateOfPayment)
            {
                //21 Complete
            }
            column(LastPaymentDate; LastPaymentDate)
            {
                //22 Complete
            }
            column(LastAmountPaid; LastAmountPaid)
            {
                //23 Complete
            }
            column(OutstandingInstallments; OutstandingInstallments)
            {
                //24 Complete
            }
            column(LoanExpiryDate; LoanExpiryDate)
            {
                //25 Complete
            }
            column(SuspendedInterest; SuspendedInterest)
            {
                //26 Blank Move to the last column
            }
            column(TotalExpectedInterest; TotalExpectedInterest)
            {
                //27 Complete
            }
            column(TotalInterestPaid; TotalInterestPaid)
            {
                //28 Complete
            }
            column(TotalExpectedPrinciple; TotalExpectedPrinciple)
            {
                //29 Complete
            }
            column(TotalPrinciplePaid; TotalPrinciplePaid)
            {
                //30 Complete
            }
            column(TotalPrincipleArrears; TotalPrincipleArrears)
            {
                //31 Complete
            }
            column(TotalInterestArrears; TotalInterestArrears)
            {
                //32 Complete
            }

            column(TotalArrears; TotalArrears)
            {
                //33 Complete
            }
            column(Days_In_Arrears; "Days In Arrears")
            {
                //34 Complete
            }
            column(MonthsInArrears; MonthsInArrears)
            {
                //35 Complete
            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {
                //36 Complete
            }
            column(OutBal; ("Outstanding Balance"))
            {
                //37 Complete
            }
            column(Outstanding_Interest; "Outstanding Interest")
            {
                //38 Complete
            }

            column(DailyInterest; ("Daily Interest"))
            {
                // Complete
            }
            column(TotalBal; ("Outstanding Balance" + "Outstanding Interest"))
            {
                //39 Complete
            }
            column(P_Plus_I_FutureInterest; P_Plus_I_FutureInterest)
            {
                //40 p - Actual Principle Bal + Outstanding Interest + Future Interest Complete
            }
            column(LoanAmountBridged; LoanAmountBridged)
            {
                //41  Complete Loan Paid using this loan
            }
            column(NetTakeHome; NetTakeHome)
            {
                //42 Complete
            }
            column(FOSADeposits; FOSADeposits)
            {
                //43 Complete
            }
            column(BOSADeposits; BOSADeposits)
            {
                //44 Complete
            }
            column(BusinessLoansDeposits; BusinessLoansDeposits)
            {
                //45 Complete
            }
            column(SecurityType; SecurityType)
            {
                //46 Complete
            }
            column(CollateralRefNumber; CollateralRefNumber)
            {
                //47 Complete
            }
            column(AmountInLien; AmountInLien)
            {
                //48 Complete - FOSA
            }
            column(CollateralValue; CollateralValue)
            {
                //49 Complete
            }
            column(NetExposure; NetExposure)
            {
                //50 Complete - Amount guaranteed against loan
            }
            column(Rescheduled; Rescheduled)
            {
                //51  Complete
            }
            column(LoanPurpose; LoanPurpose)
            {
                //52 Complete
            }
            column(BranchDomicile; BranchDomicile)
            {
                //53 Complete
            }
            column(Position; Position)
            {
                //54 Delegate ....
            }
            column(LoanDep; ("Source Unit"))
            {
                //55 Source Unit
            }

            trigger OnAfterGetRecord()
            begin
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;
                EmployerCode := '';
                EmployerName := '';
                MemberStatus := '';
                SubFlag := '';
                DisbursementDate := '';
                LoanPrincipleRepayment := 0;
                LoanInterestRepayment := 0;
                MonthlyRepayment := 0;
                RepaymentRate := '';
                FirstInstallmentDate := '';
                NextExpectedDateOfPayment := '';
                LastPaymentDate := '';
                LastAmountPaid := 0;
                OutstandingInstallments := 0;
                LoanExpiryDate := '';
                SuspendedInterest := 0;
                TotalExpectedInterest := 0;
                TotalInterestPaid := 0;
                TotalExpectedPrinciple := 0;
                TotalPrinciplePaid := 0;
                TotalPrincipleArrears := 0;
                TotalInterestArrears := 0;
                TotalArrears := 0;
                MonthsInArrears := 0;
                OutBal := 0;
                OutInt := 0;
                DailyInterest := 0;
                TotalBal := 0;
                P_Plus_I_FutureInterest := 0;
                LoanAmountBridged := 0;
                NetTakeHome := 0;
                FOSADeposits := 0;
                BOSADeposits := 0;
                BusinessLoansDeposits := 0;
                SecurityType := '';
                CollateralRefNumber := '';
                AmountInLien := 0;
                CollateralValue := 0;
                NetExposure := 0;
                Rescheduled := false;
                LoanPurpose := '';
                BranchDomicile := '';
                Position := '';
                LoanDep := '';
                ExpectedBalance := 0;

                Loans.CalcFields("Outstanding Interest", "Outstanding Balance", "Interest Paid", "Principle Paid", "Daily Interest");

                OutInt := Loans."Outstanding Interest" + Loans."Daily Interest";
                OutBal := Loans."Outstanding Balance";

                // LoanRecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                if Members.Get(Loans."Member No.") then begin
                    EmployerCode := Members."Employer Code";
                    EmployerName := Members."Employer Name";
                    if EmployerName = '' then begin
                        if Customer.Get(EmployerCode) then begin
                            EmployerName := Customer.Name;
                        end;
                    end;
                    MemberStatus := Format(Members.Status);
                    SubFlag := Format(Members.Subflag);
                end;

                DisbursementDate := GlobalFunctions.FormatDate(Loans."Disbursement Date");

                i := 0;
                RepaymentSchedule.Reset();
                RepaymentSchedule.SetCurrentKey("Loan No.");
                RepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                if RepaymentSchedule.Findset then begin
                    repeat
                        i += 1;
                        if i = 1 then begin
                            "Loan Principle Repayment" := RepaymentSchedule."Principal Repayment";
                            "Loan Interest Repayment" := RepaymentSchedule."Monthly Interest";
                            FirstInstallmentDate := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
                        end;

                        if (RepaymentSchedule."Repayment Date" >= Today) then begin
                            //Count priciple from current date
                            if LoanPrincipleRepayment <= 0 then
                                LoanPrincipleRepayment := RepaymentSchedule."Principal Repayment";
                            //Count interest from next period
                            if (RepaymentSchedule."Repayment Date" > Today) and (LoanInterestRepayment <= 0) then
                                LoanInterestRepayment := RepaymentSchedule."Monthly Interest";

                            //Monthly repayment is for the current period
                            if MonthlyRepayment <= 0 then
                                MonthlyRepayment := RepaymentSchedule."Monthly Interest" + RepaymentSchedule."Principal Repayment";

                            ExpectedBalance += RepaymentSchedule."Principal Repayment";
                            OutstandingInstallments += 1;

                            if RepaymentSchedule."Repayment Date" > Today then
                                TotalExpectedInterest += RepaymentSchedule."Monthly Interest";

                            TotalExpectedPrinciple += RepaymentSchedule."Principal Repayment";

                            if NextExpectedDateOfPayment = '' then
                                NextExpectedDateOfPayment := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
                        end;
                        if i = Loans.Installments then
                            LoanExpiryDate := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
                    until RepaymentSchedule.Next() = 0;
                end;

                if NextExpectedDateOfPayment = '' then
                    NextExpectedDateOfPayment := GlobalFunctions.FormatDate(Today);

                TotalExpectedInterest += Loans."Outstanding Interest";
                TotalExpectedPrinciple := ExpectedBalance;
                TotalPrinciplePaid := Loans."Approved Amount" - OutBal;

                // CreditLedgerEntry.Reset();
                // CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                // CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
                // CreditLedgerEntry.SetRange(Reversed, false);
                // if CreditLedgerEntry.Find('-') then begin
                //     CreditLedgerEntry.CalcSums("Credit Amount");
                TotalInterestPaid := Loans."Interest Paid";
                // end;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
                CreditLedgerEntry.SetRange(Reversed, false);
                CreditLedgerEntry.SetLoadFields("Transaction No.", "Posting Date", "Credit Amount");
                if CreditLedgerEntry.FindLast() then begin
                    TransactionNumber := CreditLedgerEntry."Transaction No.";
                    LastPaymentDate := GlobalFunctions.FormatDate(CreditLedgerEntry."Posting Date");
                    LastAmountPaid := (CreditLedgerEntry."Credit Amount");
                end;

                if ExpectedBalance > 0 then
                    TotalPrincipleArrears := OutBal - ExpectedBalance;
                if TotalPrincipleArrears <= 0 then TotalPrincipleArrears := 0;

                TotalInterestArrears := Loans."Outstanding Interest";

                TotalArrears := TotalPrincipleArrears + TotalInterestArrears;

                MonthsInArrears := Round("Days In Arrears" / 30, 1, '<');

                LoansTopUp.Reset();
                LoansTopUp.SetRange("Loan No.", Loans."Loan No.");
                LoansTopUp.SetLoadFields("Total Top Up");
                if LoansTopUp.Find('-') then begin
                    LoansTopUp.CalcSums("Total Top Up");
                    LoanAmountBridged := LoansTopUp."Total Top Up";
                end;

                SavingsLedgerEntry.SetRange("Customer No.", Loans."Disbursement Account No");
                SavingsLedgerEntry.SetRange("Document No.", Loans."Loan No.");
                SavingsLedgerEntry.SetLoadFields(Amount);
                SavingsLedgerEntry.CalcSums(Amount);
                NetTakeHome := (SavingsLedgerEntry.Amount) * -1;

                SavingsAccounts.SetFilter("Product Category", '%1|%2|%3',
                SavingsAccounts."Product Category"::"BOSA Deposits",
                SavingsAccounts."Product Category"::"FOSA Account",
                SavingsAccounts."Product Category"::"Business Deposits");
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetLoadFields("No.", "Product Category");
                if SavingsAccounts.Find('-') then begin
                    repeat
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                            BOSADeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        end;
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account" then begin
                            SavingsAccounts.CalcFields("Lien Placed");
                            AmountInLien := SavingsAccounts."Lien Placed";
                            FOSADeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        end;
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Business Deposits" then begin
                            BusinessLoansDeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        end;
                    until SavingsAccounts.Next() = 0;
                end;

                BranchDomicile := Loans."Global Dimension 1 Code";
                RepaymentRate := 'Monthly';

                if Securities.Count > 0 then
                    Securities.RemoveRange(1, Securities.Count);

                TotalAmountGuaranteed := 0;
                LoanGuarantorsandSecurity.Reset;
                LoanGuarantorsandSecurity.SetRange("Member No", Loans."Member No.");
                LoanGuarantorsandSecurity.SetLoadFields("Amount Guaranteed", "Guarantor Type", "Collateral Value", "Collateral Reg. No.");
                if LoanGuarantorsandSecurity.FindSet() then begin
                    repeat
                        TotalAmountGuaranteed += LoanGuarantorsandSecurity."Amount Guaranteed";
                        if not Securities.Contains(Format(LoanGuarantorsandSecurity."Guarantor Type")) then
                            Securities.Add(Format(LoanGuarantorsandSecurity."Guarantor Type"));

                        if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::Collateral then begin
                            CollateralValue += LoanGuarantorsandSecurity."Collateral Value";
                            CollateralRefNumber := LoanGuarantorsandSecurity."Collateral Reg. No.";
                        end;
                    until LoanGuarantorsandSecurity.Next() = 0;
                end;

                NetExposure := Loans."Approved Amount" - TotalAmountGuaranteed;
                if NetExposure <= 0 then NetExposure := 0;

                foreach Security in Securities do begin
                    SecurityType += Security + ' ,';
                end;

                LoanPurpose := Format(Loans."Sub Sector Level2 Description");

                P_Plus_I_FutureInterest := "Outstanding Balance" + TotalExpectedInterest;

            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := Loans.Count;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN('Processing ... ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.Close();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
            }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        //Colums
        EmployerCode: Code[50];
        EmployerName: Text;
        MemberStatus: Text;
        SubFlag: Text;
        DisbursementDate: Text;
        LoanPrincipleRepayment: Decimal;
        LoanInterestRepayment: Decimal;
        MonthlyRepayment: Decimal;
        RepaymentRate: Text;
        FirstInstallmentDate: Text;
        NextExpectedDateOfPayment: Text;
        LastPaymentDate: Text;
        LastAmountPaid: Decimal;
        OutstandingInstallments: Integer;
        LoanExpiryDate: Text;
        SuspendedInterest: Decimal;
        TotalExpectedInterest: Decimal;
        TotalInterestPaid: Decimal;
        TotalExpectedPrinciple: Decimal;
        TotalPrinciplePaid: Decimal;
        TotalPrincipleArrears: Decimal;
        TotalInterestArrears: Decimal;
        TotalArrears: Decimal;
        MonthsInArrears: Integer;
        OutBal: Decimal;
        OutInt: Decimal;
        DailyInterest: Decimal;
        TotalBal: Decimal;
        P_Plus_I_FutureInterest: Decimal;
        LoanAmountBridged: Decimal;
        NetTakeHome: Decimal;
        FOSADeposits: Decimal;
        BOSADeposits: Decimal;
        BusinessLoansDeposits: Decimal;
        SecurityType: Text;
        CollateralRefNumber: Text;
        AmountInLien: Decimal;
        CollateralValue: Decimal;
        NetExposure: Decimal;
        Rescheduled: Boolean;
        LoanPurpose: Text;
        BranchDomicile: Code[100];
        Position: Text;
        LoanDep: Code[50];


        //Request Page

        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";

        ProductFactory: Record "Product Factory";
        RepaymentSchedule: Record "Ideal Repayment Schedule";
        LoansTopUp: Record "Loans Top up";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        Customer: Record Customer;
        i: Integer;
        ExpectedBalance: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        Securities: list of [Text];
        Security: Text;
        TotalAmountGuaranteed: Decimal;
        TransactionNumber: Integer;

        //Progress Bar
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

}
