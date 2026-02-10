#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185655 "Business Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Business Evaluation.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }
            // column(CName; Company.Name)
            // {
            // }
            // column(CAdress; Company.Address)
            // {
            // }
            // column(CPicture; Company.Picture)
            // {
            // }
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
            // column(MemberDeposits; MemberDeposits)
            // {
            // }
            // column(TotalLoanBal; TotalLoanBal)
            // {
            // }
            // column(CountNo; CountNo)
            // {
            // }
            // column(LoanRecoverd; LoanRecoverd)
            // {
            // }
            // column(MemberDueRetire; MemberDueRetire)
            // {
            // }
            // column(GuarantorMax; GuarantorMax)
            // {
            // }
            // column(SecurityRisk; SecurityRisk)
            // {
            // }
            // column(ReapplicationPeriod; ReapplicationPeriod)
            // {
            // }
            // column(LoanDepositRation; LoanDepositRation)
            // {
            // }
            // column(TotalBasic; TBasic)
            // {
            // }
            // column(TotalEarning; TEarning)
            // {
            // }
            // column(TotalAllowance; TAllowance)
            // {
            // }
            // column(TotalDeductions; TDeductions)
            // {
            // }
            // column(NetSalary; NetSalary)
            // {
            // }
            // column(AdjNet; AdjustedNet)
            // {
            // }
            // column(NetAverageIncome; NetAverageIncome)
            // {
            // }
            // column(QualifyingIncome; QualifyingBusiness)
            // {
            // }
            // column(NetOnDeposits; NetOnDeposits)
            // {
            // }
            // column(ExternalRecovered; TotalExteralRec)
            // {
            // }
            // column(TopupRepayments; TopupRepayments)
            // {
            // }
            // column(Dim1; Dimension1)
            // {
            // }
            // column(Dim2; Dimension2)
            // {
            // }
            // column(Equity; Equity)
            // {
            // }
            // column(QuickRatio; QuickRatio)
            // {
            // }
            // column(Currentratio; Currentratio)
            // {
            // }
            // column(StockTurnover; StockTurnover)
            // {
            // }
            // column(Debtratio; Debtratio)
            // {
            // }
            // column(LoanToCurrentasset; LoanToCurrentasset)
            // {
            // }
            // column(InstallmentToNetHousehold; InstallmentToNetHousehold)
            // {
            // }
            // column(CashSales; "Cash Sales")
            // {
            // }
            // column(CostofSales; "Cost of Sales")
            // {
            // }
            // column(Creditsales; "Credit sales")
            // {
            // }
            // column(HouseholdIncome; "Household Income")
            // {
            // }
            // column(BusinessExpenses; "Business Expenses")
            // {
            // }
            // column(HouseloldExpenses; "Houselold Expenses")
            // {
            // }
            // column(CurrentAssets; "Current Assets")
            // {
            // }
            // column(FixedAssets; "Fixed Assets")
            // {
            // }
            // column(ShortTermLiabilities; "Short Term Liabilities")
            // {
            // }
            // column(LongTermLiabilities; "Long Term Liabilities")
            // {
            // }
            // column(CurrentAssetsStock; "Current Assets(Stock)")
            // {
            // }
            // column(DirectorWarning; DirectorWarning)
            // {
            // }
            // column(mult; Mult)
            // {
            // }
            // column(Deposit_Multiplier; Deposit_Multiplier)
            // {
            // }
            // column(RelatedBal; RelatedBal)
            // {
            // }
            // column(OffsetBalance; OffsetBalance)
            // {
            // }
            // column(AvInterest; AvInterest)
            // {
            // }
            dataitem("Business Loan Appraisal"; "Business Loan Appraisal")
            {
                column(ReportForNavId_62; 62)
                {
                }
                column(Code_BusinessLoanAppraisal; "Business Loan Appraisal".Code)
                {
                }
                column(ClassCode; "Business Loan Appraisal"."Financial Classification Code")
                {
                }
                column(BusDesc; "Business Loan Appraisal".Description)
                {
                }
                column(BusAmt; "Business Loan Appraisal"."Amount (LCY)")
                {
                }
                column(LoanWithSACCO; "Business Loan Appraisal"."Loan With Sacco")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Business Loan Appraisal"."Amount (LCY)" = 0) and ("Business Loan Appraisal"."Loan With Sacco" = 0) then
                        CurrReport.Skip;
                end;
            }
            dataitem(AllLoans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                //DataItemTableView = where(Posted = const(Yes), "Outstanding Balance" = filter(> 0));
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
                begin
                    // if LoansTopup.Get(AllLoans."Loan No.") then
                    //     CurrReport.Skip;
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
                begin
                    // CountNo := CountNo + 1;
                    // if ProductFactory.Get(Loans."Loan Product Type") then
                    //     if CountNo < ProductFactory."Minimum Guarantors" then
                    //         GuarantorMax := true;
                    // SecurityTotal := SecurityTotal + "Loan Guarantors and Security"."Amount Guaranteed";
                    // if SecurityTotal < Loans."Requested Amount" then
                    //     SecurityRisk := true;
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


                if Members.Get(Loans."Member No.") then begin
                    Dimension1 := Members."Global Dimension 1 Code";
                    Dimension2 := Members."Global Dimension 2 Code";
                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    AvInterest := ((Loans.Repayment * Loans.Installments) - Loans."Requested Amount") / Loans.Installments
                else
                    AvInterest := Loans."Loan Interest Repayment";


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
                Mult := ProductFactory."Ordinary Deposits Multiplier";
                NetOnDeposits := Deposit_Multiplier;

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



                //Business income

                //New approach
                FinancialRatios.Reset;
                FinancialRatios.SetRange("Loan No.", Loans."Loan No.");
                if FinancialRatios.Find('-') then begin
                    repeat
                        if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Business Expenses" then
                            "Business Expenses" := "Business Expenses" + FinancialRatios."Amount (LCY)"
                        else
                            if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Cash Sales" then
                                "Cash Sales" := "Cash Sales" + FinancialRatios."Amount (LCY)"
                            else
                                if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Cost of Sales" then
                                    "Cost of Sales" := "Cost of Sales" + FinancialRatios."Amount (LCY)"
                                else
                                    if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Credit sales" then
                                        "Credit sales" := "Credit sales" + FinancialRatios."Amount (LCY)"
                                    else
                                        if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Current Assets" then
                                            "Current Assets" := "Current Assets" + FinancialRatios."Amount (LCY)"
                                        else
                                            if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Current Assets(Stock)" then
                                                "Current Assets(Stock)" := "Current Assets(Stock)" + FinancialRatios."Amount (LCY)"
                                            else
                                                if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Fixed Assets" then
                                                    "Fixed Assets" := "Fixed Assets" + FinancialRatios."Amount (LCY)"
                                                else
                                                    if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Household Income" then
                                                        "Household Income" := "Household Income" + FinancialRatios."Amount (LCY)"
                                                    else
                                                        if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Short Term Liabilities" then
                                                            "Short Term Liabilities" := "Short Term Liabilities" + FinancialRatios."Amount (LCY)"
                                                        else
                                                            if FinancialRatios."Financial Classification Code" = FinancialRatios."financial classification code"::"Long Term Liabilities" then begin
                                                                "Long Term Liabilities" := "Long Term Liabilities" + FinancialRatios."Amount (LCY)" + FinancialRatios."Loan With Sacco";
                                                            end;
                    until FinancialRatios.Next = 0;
                end;



                //Add running loans


                //

                //Create ratios
                Equity := ("Current Assets" + "Fixed Assets") - ("Short Term Liabilities" + "Long Term Liabilities");

                Busincome := (("Cash Sales" + "Credit sales") - "Cost of Sales") - "Business Expenses";
                if "Short Term Liabilities" > 0 then
                    QuickRatio := ("Current Assets" - "Current Assets(Stock)") / "Short Term Liabilities";

                //MESSAGE('SL %1 CA %2 CSTOCK %3',"Short Term Liabilities","Current Assets","Current Assets(Stock)");

                if "Short Term Liabilities" > 0 then
                    Currentratio := "Current Assets" / "Short Term Liabilities";

                if "Current Assets(Stock)" > 0 then
                    StockTurnover := "Cost of Sales" / "Current Assets(Stock)";

                if Equity <> 0 then
                    Debtratio := ("Short Term Liabilities" + "Long Term Liabilities") / Equity;

                if "Current Assets" > 0 then
                    LoanToCurrentasset := Loans."Requested Amount" / "Current Assets";


                if ("Household Income" + Busincome) > 0 then
                    InstallmentToNetHousehold := Loans.Repayment / ("Household Income" + Busincome);


                if NetOnDeposits >= QualifyingBusiness then begin
                    if Loans."Requested Amount" > QualifyingBusiness then begin
                        QualifyingAmount := QualifyingBusiness;
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

                /*
                //Qualification on salary
                AppraisalSal.RESET;
                AppraisalSal.SETRANGE("Loan No","Loan No.");
                IF AppraisalSal.FIND('-') THEN BEGIN
                  REPEAT
                   IF AppraisalSal.Type=AppraisalSal.Type::Basic THEN
                     TBasic:=TBasic+AppraisalSal.Amount
                   ELSE IF AppraisalSal.Type=AppraisalSal.Type::Earnings THEN
                     TEarning:=AppraisalSal.Amount
                   ELSE IF AppraisalSal.Type=AppraisalSal.Type::"Other Allowances" THEN
                     TAllowance:=TAllowance+AppraisalSal.Amount
                   ELSE IF AppraisalSal.Type=AppraisalSal.Type::"Other Allowances" THEN
                     TDeductions:=TDeductions+AppraisalSal.Amount;
                   UNTIL AppraisalSal.NEXT=0;
                END;
                
                
                //Cleared external effects affecting qualification
                ExternalEff.RESET;
                ExternalEff.SETRANGE("Loan No.","Loan No.");
                ExternalEff.SETRANGE("Affects 2/3 Rule",TRUE);
                IF ExternalEff.FIND('-') THEN BEGIN
                  ExternalEff.CALCSUMS(Amount);
                  TotalExteralRec:=ExternalEff.Amount;
                
                END;
                */

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
                    if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                        if Today > CalcDate(Format(GeneralSetUp."Max. Member Age"), Members."Date of Birth") then
                            MemberDueRetire := true;
                    end;
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

                //Insert Warnings---Directors
                DirectorWarning := true;
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
                                    if Loan."Outstanding Bills" > 0 then
                                        DirectorWarning := false;
                                until Loan.Next = 0;
                            end;
                        until AccountSignatories.Next = 0;
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
        BusinessIncome: Record "Business Income";
        NoofSalaryErr: label 'The expected number of salary times have not been factored';
        NetAverageIncome: Decimal;
        QualifyingBusiness: Decimal;
        NewContr: Decimal;
        SavAcc: Record "Savings Accounts";
        Dimension1: Code[20];
        Dimension2: Code[20];
        AccountSignatories: Record "Account Signatories";
        DirectorWarning: Boolean;
        Currentratio: Decimal;
        StockTurnover: Decimal;
        Debtratio: Decimal;
        LoanToCurrentasset: Decimal;
        InstallmentToNetHousehold: Decimal;
        FinancialRatios: Record "Business Loan Appraisal";
        "Cash Sales": Decimal;
        "Cost of Sales": Decimal;
        "Credit sales": Decimal;
        "Household Income": Decimal;
        "Business Expenses": Decimal;
        "Houselold Expenses": Decimal;
        "Current Assets": Decimal;
        "Fixed Assets": Decimal;
        "Short Term Liabilities": Decimal;
        "Long Term Liabilities": Decimal;
        "Current Assets(Stock)": Decimal;
        Equity: Decimal;
        QuickRatio: Decimal;
        Busincome: Decimal;
        CurrLoanBal: Decimal;
        OffsetBalance: Decimal;
        Inactive: Boolean;
        AvInterest: Decimal;
        Mult: Decimal;
}
