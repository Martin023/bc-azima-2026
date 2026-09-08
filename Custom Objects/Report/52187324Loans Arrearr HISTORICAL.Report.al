report 52187324 "Loans Arrears HISTORICAL"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './bc-azima-2026/Layout/Loans Arrearr HISTORICAL.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Employer Code", "Application Date";
            column(LoanNo; "Loan No.") { }
            column(Member_No_; "Member No.") { }
            column(MemberName; "Member Name") { }
            column(EmployerCode; "Employer Code") { }
            column(DisbursementDate; "Disbursement Date") { }
            column(ApplicationDate; "Application Date") { }
            column(LoanProductType; "Loan Product Type") { }
            column(LoanProductTypeName; "Loan Product Type Name") { }
            column(outstandingPrinciple; "Outstanding Balance") { }
            column(outstandingInterest; "Outstanding Interest") { }
            column(OutstandingBalance; "Total Balance") { }
            column(Repayment; "Repayment") { }
            column(Interest; "Interest") { }
            column(GracePeriod; "Grace Period") { }
            column(DaysInArrears; DaysInarrears) { }
            column(AmountInArrearsSASRA; AmountInArrearsSASRA) { }
            column(InstallInArrears; InstallInArrears) { }
            column(Loans_Category_SASRA; "Loans Category-SASRA") { }
            column(Approved_Amount; "Approved Amount") { }

            trigger OnAfterGetRecord()
            var
            begin
                AmountInArrearsSASRA := 0;
                InstallInArrears := 0;
                DaysInArrears := 0;
                ActualInterestBal := 0;
                ActualPrincipleBal := 0;
                ActualTotalBal := 0;
                IdealInterestBal := 0;
                IdealPrincipleBal := 0;
                IdealTotalBal := 0;
                MonthlyInterest := 0;
                MonthlyPrinciple := 0;
                MonthlyRepayment := 0;
                GraceDays := 0;
                DaysAfterSchedule := 0;
                CurrMonthInt := 0;

                Loans.CalcFields("Total Balance", "Outstanding Interest", "Outstanding Balance");
                Schedule.Reset();
                Schedule.SetRange("Loan No.", Loans."Loan No.");
                if not Schedule.FindFirst() then
                    LoanProcess.GenerateSchedule(Loans, true);
                // Loans with grace period - to change from 137
                if (Loans."Recovery Mode" <> Loans."Recovery Mode"::Dividend) then begin
                    ActualInterestBal := Loans."Outstanding Interest";
                    ActualPrincipleBal := Loans."Outstanding Balance";
                    ActualTotalBal := ActualInterestBal + ActualPrincipleBal;

                    LnReshedule.Reset();
                    LnReshedule.SetRange("Loan No.", Loans."Loan No.");
                    if LnReshedule.FindFirst() then begin
                        MonthlyInterest := LnReshedule."Monthly Interest";
                        MonthlyPrinciple := LnReshedule."Principal Repayment";
                        MonthlyRepayment := MonthlyInterest + MonthlyPrinciple;
                    end;

                    LnReshedule.Reset();
                    LnReshedule.SetRange("Loan No.", Loans."Loan No.");
                    LnReshedule.SetFilter("Repayment Date", '>=%1', AsAt);
                    if LnReshedule.Find('-') then begin
                        IdealInterestBal := Abs(LnReshedule."Monthly Interest");
                        repeat
                            IdealPrincipleBal += Abs(LnReshedule."Principal Repayment");
                        until LnReshedule.NEXT = 0;
                    end else begin
                        if Loans."Expected Date of Completion" <> 0D then
                            DaysAfterSchedule := AsAt - Loans."Expected Date of Completion";
                    end;

                    IdealTotalBal := IdealPrincipleBal;

                    DaysInArrears := DaysAfterSchedule;
                    InstallInArrears := round(DaysAfterSchedule / 30, 0.01, '=');

                    CurrMonthInt := 0;
                    CreditLedger.reset;
                    CreditLedger.setrange("Loan No", Loans."Loan No.");
                    CreditLedger.setfilter("Posting Date", '%1..%2', CalcDate('-CM', AsAt), calcdate('<CM>', AsAt));
                    CreditLedger.setrange("Transaction Type", CreditLedger."Transaction Type"::"Interest Due");
                    if CreditLedger.FindSet() then begin
                        CreditLedger.CalcSums("Amount (LCY)");
                        CurrMonthInt := CreditLedger."Amount (LCY)";
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                        AmountInArrearsSASRA := ActualPrincipleBal - IdealPrincipleBal;
                        if MonthlyPrinciple <> 0 then begin
                            DaysInArrears += Round((AmountInArrearsSASRA / MonthlyPrinciple) * 30, 1, '>');
                            InstallInArrears += Round((AmountInArrearsSASRA / MonthlyPrinciple), 0.01, '=');
                        end;

                        // DaysInArrears += Round((round((AmountInArrearsSASRA / MonthlyPrinciple), 1, '<')) * 30, 1, '<');
                    end else begin
                        AmountInArrearsSASRA := ActualTotalBal - IdealTotalBal - CurrMonthInt;
                        //if MonthlyRepayment <> 0 then
                        //DaysInArrears += Round((AmountInArrearsSASRA / MonthlyRepayment) * 30, 1, '<'); Cyprian, commented to catch the divide by zero
                        if MonthlyRepayment = 0 then MonthlyRepayment := MonthlyPrinciple;
                        if MonthlyRepayment > 0 then begin
                            DaysInArrears += Round(((AmountInArrearsSASRA / MonthlyRepayment) * 30), 1, '>');
                            InstallInArrears += Round((AmountInArrearsSASRA / MonthlyRepayment), 0.01, '=');
                        end;

                    end;
                    DaysInArrears := round(DaysInArrears, 1, '>');
                    if AmountInArrearsSASRA <= 0 then AmountInArrearsSASRA := 0;

                    if DaysInArrears <= 0 then begin
                        DaysInArrears := 0;
                    end else begin
                        // DaysInArrears -= GraceDays;
                        if DaysInArrears <= 0 then
                            DaysInArrears := 0;
                    end;
                    if InstallInArrears <= 0 then
                        InstallInArrears := 0;

                end else begin
                    if Loans."Disbursement Date" = 0D then Loans."Disbursement Date" := (CalcDate('-12M', AsAt));
                    if Loans."Disbursement Date" <> 0D then begin
                        if (CalcDate('12M', Loans."Disbursement Date")) < AsAt then begin
                            DaysInArrears := AsAt - Loans."Disbursement Date";
                            // One off loans not recovered in the year;
                            InstallInArrears := 12.1;
                        end;
                    end;

                end;

                if Loans."Repayment Start Date" <> 0D then
                    if Loans."Repayment Start Date" > AsAt then begin
                        DaysInArrears := 0;
                        AmountInArrearsSASRA := 0;
                        InstallInArrears := 0;
                    end;

                if (Loans."Outstanding Balance" + Loans."Outstanding Interest" <= 0) then begin
                    DaysInArrears := 0;
                    AmountInArrearsSASRA := 0;
                    InstallInArrears := 0;
                end;


                // Guarantor loans to always be in loss - FINANCE Kenneth.
                if (Loans."Loan Product Type" = '075') or (Loans."Loan Product Type" = 'BGL') then begin
                    DaysInArrears := AsAt - Loans."Disbursement Date";
                    // One off loans not recovered in the year;
                    InstallInArrears := 12.1;
                end;

                // DaysInArrears := LoansProcess.CalculateLoanArrears(Loans, AmountInArrearsSACCO, AmountInArrearsSASRA, AsAt);



                Loans."Loans Category-SASRA" := LoanProcess.LoanCategoryStage(DaysInArrears);
                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Perfoming then begin
                    // DaysInArrears := 0;
                    // AmountInArrearsSACCO := 0;
                    // AmountInArrearsSASRA := 0;
                    InstallInArrears := 0;
                end;
                AmountInArrearsSASRA := round(AmountInArrearsSASRA, 0.01, '=');
            end;

            trigger OnPostDataItem()
            var
            begin
            end;

            trigger OnPreDataItem()
            begin
                Loans.setfilter("Disbursement Date", '..%1,', AsAt);
                Loans.setfilter("Date Filter", '..%1', AsAt);
                Loans.SetFilter("Total Balance", '>0');
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
                field(AsAt; AsAt)
                {
                }

            }
        }
    }
    trigger OnPreReport()
    begin
        if AsAt = 0D then
            AsAt := Today;
    end;



    var
        LoanProcess: Codeunit "Loans Process";
        RunLoan: Boolean;
        AsAt: Date;
        AmountInArrearsSASRA: Decimal;
        DaysInArrears: Decimal;
        LnReshedule: Record "Ideal Repayment Schedule";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        GraceDays: Integer;

        ActualPrincipleBal: Decimal;
        ActualInterestBal: Decimal;
        ActualTotalBal: Decimal;

        IdealPrincipleBal: Decimal;
        IdealInterestBal: Decimal;
        IdealTotalBal: Decimal;

        MonthlyPrinciple: Decimal;
        MonthlyInterest: Decimal;
        MonthlyRepayment: Decimal;

        DaysAfterSchedule: Integer;
        Schedule: Record "Ideal Repayment Schedule";
        InstallInArrears: Decimal;
        CreditLedger: record "Credit Ledger Entry";
        CurrMonthInt: Decimal;
}