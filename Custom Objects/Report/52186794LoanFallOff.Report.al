#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52186794 "Loan FallOff Report"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Loan FallOff Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Loan Product Type", "Disbursement Date", "Loans Category-SASRA", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source Unit", Installments;
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
            column(MemberNo; MemberNo)
            {

            }
            column(PayrollNumber; PayrollNumber)
            {

            }
            column(AmountInArrears; AmountInArrears)
            {

            }
            column(MemberName; MemberName)
            {

            }
            column(EmployerCode; EmployerCode)
            {

            }
            column(NationalID; NationalID)
            {

            }
            column(OrdinaryAccNo; OrdinaryAccNo) { }
            column(OrdinaryAccBal; OrdinaryAccBal) { }
            column(BOSABal; BOSABal) { }
            column(Loan_No_; "Loan No.")
            {

            }
            column(ProductID; ProductID)
            {

            }
            column(DisbursedAmount; DisbursedAmount)
            {

            }
            column(ExpectedAmount; ExpectedAmount)
            {

            }
            column(PrincipleBalance; PrincipleBalance)
            {

            }
            column(TotalOutstandingInterest; TotalOutstandingInterest)
            {

            }
            column(LastPaidDate; LastPaidDate)
            {

            }
            column(Variance; Variance)
            {

            }
            column(TotalOutstandingLoanBalance; TotalOutstandingLoanBalance)
            {

            }
            column(DaysInArrears; DaysInArrears)
            {

            }
            column(LoanDepartment; LoanDepartment)
            {

            }
            column(MemberStatus; MemberStatus)
            {

            }
            column(MemberSubStatus; MemberSubStatus)
            {

            }
            column(ProductDescription; ProductDescription)
            {

            }
            column(DisbursementDate; DisbursementDate)
            {

            }
            column(EmployerName; EmployerName)
            {

            }
            column(MonthlyExpectedPrinciple; MonthlyExpectedPrinciple)
            {

            }
            column(ScheduleBalance; ScheduleBalance)
            {

            }
            column(MonthlyExpectedInterest; MonthlyExpectedInterest)
            {

            }
            column(LastPaidAmount; LastPaidAmount)
            {

            }
            column(TotalCapitalAmountPaid; TotalCapitalAmountPaid)
            {

            }
            column(TotalInterestAmountPaid; TotalInterestAmountPaid)
            {

            }
            column(FutureOutstandingInterest; FutureOutstandingInterest)
            {

            }
            column(TotalLoanPlusFutureInterest; TotalLoanPlusFutureInterest)
            {

            }
            column(RemainingInstallments; RemainingInstallments)
            {

            }
            column(InstallmentsFallOff; InstallmentsFallOff)
            {

            }
            column(ExpiryDate; ExpiryDate)
            {

            }
            column(DaysLastPaid; DaysLastPaid)
            {

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
                ProductID := '';
                ProductDescription := '';
                DisbursementDate := '';
                DisbursedAmount := 0;
                MemberNo := '';
                MemberStatus := '';
                MemberName := '';
                NationalID := '';
                EmployerCode := '';
                PayrollNumber := '';
                OrdinaryAccBal := 0;
                OrdinaryAccNo := '';
                BOSABal := 0;
                MonthlyExpectedPrinciple := 0;
                ScheduleBalance := 0;
                MonthlyExpectedInterest := 0;
                ExpectedAmount := 0;
                LastPaidAmount := 0;
                Variance := 0;
                TotalCapitalAmountPaid := 0;
                TotalInterestAmountPaid := 0;
                TotalOutstandingInterest := 0;
                PrincipleBalance := 0;
                TotalOutstandingLoanBalance := 0;
                FutureOutstandingInterest := 0;
                TotalLoanPlusFutureInterest := 0;
                RemainingInstallments := 0;
                LastPaidDate := '';
                DaysInArrears := 0;
                LoanDepartment := '';
                DaysLastPaid := 0;
                EmployerName := '';
                InstallmentsFallOff := 0;
                ExpiryDate := '';

                Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

                ProductID := Loans."Loan Product Type";
                ProductDescription := Loans."Loan Product Type Name";
                DisbursementDate := GlobalFunctions.DMUDateFormatDate(Loans."Disbursement Date");
                DisbursedAmount := Loans."Approved Amount";
                MemberNo := Loans."Member No.";

                if Members.Get(Loans."Member No.") then begin
                    Members.CalcFields("FOSA Savings", "BOSA Deposit");
                    MemberStatus := Format(Members.Status);
                    MemberSubStatus := Format(Members.Subflag);
                    MemberName := Members.Name;
                    NationalID := Members."Primary Identification";
                    EmployerCode := Members."Employer Code";
                    PayrollNumber := Members."Payroll/Staff No.";
                    BOSABal := Members."BOSA Deposit";
                end;

                SavingsTable.Reset();
                SavingsTable.Setrange("Product Category", SavingsTable."Product Category"::"FOSA Account");
                SavingsTable.SetRange("Member No.", Loans."Member No.");
                if SavingsTable.Find('-') then begin
                    SavingsTable.CalcFields("Balance (LCY)");
                    if SavingsTable."Product Category" = SavingsTable."Product Category" then begin
                        OrdinaryAccNo := SavingsTable."No.";
                        OrdinaryAccBal := SavingsTable."Balance (LCY)";
                    end;
                end;
                // Schedule.Reset();
                // Schedule.SetRange("Loan No.", Loans."Loan No.");
                // Schedule.SetFilter("Repayment Date", '>=%1', AsAt);
                // if Schedule.Find('-') then begin
                //     MonthlyExpectedPrinciple := Schedule."Principal Repayment";
                //     MonthlyExpectedInterest := Schedule."Monthly Interest";
                //     ScheduleBalance := Schedule."Principal Repayment";
                // end else begin
                //     MonthlyExpectedPrinciple := Loans.Repayment;
                //     MonthlyExpectedInterest := 0;
                // end;

                //ScheduleBalance
                Schedule.Reset();
                Schedule.SetRange("Loan No.", Loans."Loan No.");
                Schedule.SetFilter("Repayment Date", '>=%1', AsAt);
                if Schedule.Find('-') then begin
                    repeat
                        ScheduleBalance += Abs(Schedule."Principal Repayment");
                    until Schedule.NEXT = 0;
                end else begin
                    if Loans."Expected Date of Completion" <> 0D then
                        DaysAfterSchedule := AsAt - Loans."Expected Date of Completion";
                end;
                //end of schedule balance


                ExpectedAmount := Loans.Repayment;

                if Customer.get(EmployerCode) then begin
                    CutoffDay := Customer."Checkoff Cuttoff Day";
                    EmployerName := Customer.Name;
                end;

                if CutoffDay = 0 then
                    CutoffDay := GeneralSetUp."Checkoff Cuttoff Day";

                if CutoffDay = 0 then
                    CutoffDay := 15;

                EndDate := AsAt;

                if Date2DMY(AsAt, 1) > CutoffDay then
                    StartDate := CalcDate('-CM', AsAt);

                if Date2DMY(AsAt, 1) <= CutoffDay then
                    StartDate := CalcDate('-1M-CM', AsAt);

                // LedgerEntry.Reset();
                // LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                // LedgerEntry.SetRange("Loan No", Loans."Loan No.");
                // LedgerEntry.SetFilter("Transaction Type", '%1|%2', LedgerEntry."Transaction Type"::Repayment, LedgerEntry."Transaction Type"::"Interest Paid");
                // LedgerEntry.SetRange(Reversed, false);
                // if LedgerEntry.Find('-') then begin
                //     LedgerEntry.CalcSums("Credit Amount");
                //     LastPaidAmount := LedgerEntry."Credit Amount";

                // end;

                LedgerEntry.Reset();
                LedgerEntry.SetRange("Loan No", Loans."Loan No.");
                LedgerEntry.SetRange("Transaction Type", LedgerEntry."Transaction Type"::"Interest Paid");
                LedgerEntry.SetRange(Reversed, false);
                if LedgerEntry.FindLast() then begin
                    LedgerEntry.CalcSums("Credit Amount");
                    LastPaidAmount := LedgerEntry."Credit Amount";
                end;
                LedgerEntry.Reset();
                LedgerEntry.SetRange("Loan No", Loans."Loan No.");
                LedgerEntry.SetRange("Transaction Type", LedgerEntry."Transaction Type"::Repayment);
                LedgerEntry.SetRange(Reversed, false);
                if LedgerEntry.FindLast() then begin
                    LedgerEntry.CalcSums("Credit Amount");
                    LastPaidAmount += LedgerEntry."Credit Amount";
                end;
                Loans.CalcFields(Loans."Outstanding Balance");
                TotalCapitalAmountPaid := Loans."Approved Amount" - Loans."Outstanding Balance";

                LedgerEntry.Reset();
                LedgerEntry.SetRange("Loan No", Loans."Loan No.");
                LedgerEntry.SetFilter("Transaction Type", '%1|%2', LedgerEntry."Transaction Type"::Repayment, LedgerEntry."Transaction Type"::"Interest Paid");
                LedgerEntry.SetRange(Reversed, false);
                if LedgerEntry.Find('-') then begin
                    repeat
                        if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::"Interest Paid" then begin
                            TotalInterestAmountPaid += LedgerEntry."Credit Amount";
                        end;
                        LastPostingDate := LedgerEntry."Posting Date";
                        LastPaidDate := GlobalFunctions.DMUDateFormatDate(LedgerEntry."Posting Date");
                    until LedgerEntry.Next() = 0;
                end;

                RecoveryHeader.GetLoanBalances(Loans."Loan No.", TotalOutstandingInterest, PrincipleBalance, TotalOutstandingLoanBalance);

                FutureOutstandingInterest := GlobalFunctions.GetFutureInterest(Loans, AsAt);

                TotalLoanPlusFutureInterest := TotalOutstandingLoanBalance + FutureOutstandingInterest;

                Variance := LastPaidAmount - ExpectedAmount;

                RemainingInstallments := GlobalFunctions.GetRemainingInstallments(Loans, AsAt);

                Loans.CalcFields("Days In Arrears", "Installments FallOff");
                DaysInArrears := ROUND(Loans."Days In Arrears", 1, '=');
                AmountInArrears := TotalOutstandingLoanBalance - ScheduleBalance;
                if AmountInArrears <= 0 then
                    AmountInArrears := 0;

                InstallmentsFallOff := Round(Loans."Installments FallOff", 1, '=');

                if LastPostingDate <> 0D then
                    DaysLastPaid := Round((AsAt - LastPostingDate));

                LoanDepartment := Format(Loans."Source Unit");

                ExpiryDate := GlobalFunctions.DMUDateFormatDate(Loans."Expected Date of Completion");
            end;

            trigger OnPreDataItem()
            begin
                GeneralSetUp.Get();
                if AsAt = 0D then AsAt := Today;
                intProgressTotal := Loans.Count;

                Loans.SetRange("Date Filter", AsAt);

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
                field(AsAt; AsAt)
                {

                }

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
        //Columns
        ProductID: Code[50];
        ProductDescription: Text;
        DisbursementDate: Text;
        DisbursedAmount: Decimal;
        MemberNo: Code[50];
        MemberStatus: Text;
        MemberSubStatus: Text;
        MemberName: Text;
        NationalID: Code[50];
        EmployerCode: Code[50];
        PayrollNumber: Code[50];
        MonthlyExpectedPrinciple, ScheduleBalance : Decimal;
        MonthlyExpectedInterest: Decimal;
        ExpectedAmount: Decimal;
        LastPaidAmount: Decimal;
        Variance: Decimal;
        TotalCapitalAmountPaid: Decimal;
        TotalInterestAmountPaid: Decimal;
        TotalOutstandingInterest: Decimal;
        PrincipleBalance: Decimal;
        TotalOutstandingLoanBalance: Decimal;
        FutureOutstandingInterest: Decimal;
        TotalLoanPlusFutureInterest: Decimal;
        RemainingInstallments: Decimal;
        AmountInArrears: Decimal;
        LastPaidDate: Text;
        DaysInArrears, DaysAfterSchedule : Integer;
        LoanDepartment: Code[30];
        DaysLastPaid: Integer;
        EmployerName: Text;
        InstallmentsFallOff: Integer;
        ExpiryDate: Text;


        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        LoanProcess: Codeunit "Loans Process";
        FallOff: Integer;
        SASRACategory: Record "SASRA Categorization";
        Schedule: Record "Ideal Repayment Schedule";
        LedgerEntry: Record "Credit Ledger Entry";
        GeneralSetUp: Record "General Set-Up";
        Customer: Record Customer;
        CutoffDay: Integer;
        StartDate: Date;
        EndDate: Date;
        RecoveryHeader: Record "Loan Recovery Header";
        LoansProcess: Codeunit "Loans Process";
        LastPostingDate: Date;

        //Request Page
        ProcessAndDisplay: Boolean;
        DisplayOnly: Boolean;
        AsAt: Date;

        //Progress Bar
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
        OrdinaryAccNo: Code[20];
        OrdinaryAccBal: Decimal;
        BOSABal: Decimal;
        SavingsTable: Record "Savings Accounts";
}
