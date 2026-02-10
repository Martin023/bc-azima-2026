#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185635 "Loan Appraisal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Appraisal Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
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
            column(LoanInterest; Loans."Loan Interest Repayment")
            {
            }
            column(RecommendedAmt; Loans."Recommended Amount")
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }

            dataitem("Loan Application Credit Score"; "Loan Application Credit Score")
            {
                DataItemLink = "Customer No." = field("Member No."), "Loan No." = field("Loan No.");
                DataItemTableView = sorting(Priority) order(ascending);
                column(ReportForNavId_8; 8)
                {
                }
                column(ParamneterCode; "Loan Application Credit Score"."Parameter Code")
                {
                }
                column(ParameterName; "Loan Application Credit Score"."Parameter Name")
                {
                }
                column(Score; "Loan Application Credit Score".Score)
                {
                }
                column(CalculatedSuccess; "Loan Application Credit Score"."Calculated Success")
                {
                }
                column(QualifyingAmount; "Loan Application Credit Score"."Qualifying Amount")
                {
                }
                column(RequestedAmount; "Loan Application Credit Score"."Requested Amount")
                {
                }


                trigger OnAfterGetRecord()
                begin
                    /* ParameterBold:=FALSE;
                    IF DCSParameterMatrix.GET(Loans."Loan Product Type","Loan Application Credit Score"."Parameter Code") THEN BEGIN
                    IF DCSParameterMatrix."Parameter Type"=DCSParameterMatrix."Parameter Type"::"End Total" THEN
                      ParameterBold:=TRUE;
                      ParamContribution:=DCSParameterMatrix."Contributes To Score As";
                      ParamFormula:=DCSParameterMatrix.Formula;
                    END;
                    */

                end;
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

                trigger OnAfterGetRecord()
                var
                    GuarantorMax: Boolean;
                    SecurityRisk: Boolean;
                    SecurityTotal: Decimal;
                    CountNo: Integer;
                    ProductFactory: Record "Product Factory";
                begin
                    CountNo := CountNo + 1;
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        if CountNo < ProductFactory."Minimum Guarantors" then
                            GuarantorMax := true;
                    SecurityTotal := SecurityTotal + "Loan Guarantors and Security"."Amount Guaranteed";
                    if SecurityTotal < Loans."Requested Amount" then
                        SecurityRisk := true;
                end;
            }
            dataitem("Loan Required Documents"; "Loan Required Documents")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where("Provided ?" = filter(No));
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
                column(LicenseExpiryDate; "Loan Required Documents"."License Expiry Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CountNo := 0;
                SecurityTotal := 0;
                SecurityRisk := false;
                MemberDueRetire := false;
                GuarantorMax := false;
                LoanRecoverd := false;
                LoanDepositRation := false;
                Deposit_Multiplier := 0;
                RelatedBal := 0;
                NetOnDeposits := 0;
                TopupRepayments := 0;
                AdjustedNet := 0;
                NetSalary := 0;
                TotalExteralRec := 0;
                NetOnSalary := 0;
                QualifyingAmount := 0;
                AvInterest := 0;


                //Qualification on deposits
                MemberDeposits := 0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    MemberDeposits := SavingsAccounts."Balance (LCY)";
                end;

                if ProductFactory.Get(Loans."Loan Product Type") then
                    Deposit_Multiplier := MemberDeposits * ProductFactory."Ordinary Deposits Multiplier";

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
                            Loan.Reset;
                            Loan.SetRange("Loan No.", LoansTopup."Loan Top Up");
                            Loan.SetRange("Loan Product Type", RelatedProduct."Related Product Code");
                            if Loan.Find('-') then begin
                                repeat
                                    TopupRepayments := TopupRepayments + Loan.Repayment;
                                until Loan.Next = 0;
                            end;
                        end;



                    until RelatedProduct.Next = 0;
                end;

                NetOnDeposits := NetOnDeposits - RelatedBal;


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
                                    if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                        TDeductions := TDeductions + AppraisalSal.Amount;
                    until AppraisalSal.Next = 0;
                end;

                //Cleared external effects affecting qualification
                ExternalEff.Reset;
                ExternalEff.SetRange("Loan No.", "Loan No.");
                ExternalEff.SetRange("Affects 2/3 Rule", true);
                if ExternalEff.Find('-') then begin
                    ExternalEff.CalcSums(Amount);
                    TotalExteralRec := ExternalEff.Amount;

                end;


                NetSalary := (TBasic + TEarning + TAllowance - TDeductions);
                AdjustedNet := (NetSalary - TAllowance) + TAllowance * 0.3 + TopupRepayments + TotalExteralRec;
                NetOnSalary := (AdjustedNet - (0.67 * (TBasic + TEarning))) * Loans.Installments;

                if NetOnDeposits >= NetOnSalary then begin
                    if Loans."Requested Amount" > NetOnSalary then begin
                        QualifyingAmount := NetOnSalary;
                        Loans."Recommended Amount" := QualifyingAmount;
                    end else begin
                        QualifyingAmount := Loans."Requested Amount";
                        Loans."Recommended Amount" := QualifyingAmount;
                    end;
                end else begin

                end;
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



                if (MemberDeposits * ProductFactory."Ordinary Deposits Multiplier") - TotalLoanBal < Loans."Requested Amount" then
                    LoanDepositRation := true;



                if Members.Get(Loans."Member No.") then begin
                    if Today > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                        MemberDueRetire := true;
                end;

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Member No.", Loans."Member No.");
                    Loan.SetRange(Loan."Loan Product Type", Loans."Loan Product Type");
                    Loan.SetRange(Loan.Posted, true);
                    if Loan.Find('-') then begin
                        if Today < CalcDate(Format(ProductFactory."Min. Re-application Period"), Loan."Application Date") then
                            ReapplicationPeriod := true;
                    end;

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
}
