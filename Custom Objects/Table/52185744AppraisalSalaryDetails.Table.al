table 52185744 "Appraisal Salary Details"
{
    DrillDownPageID = "Appraisal Salary Details";
    LookupPageID = "Appraisal Salary Details";

    fields
    {
        field(1; "Client Code"; Code[20])
        {
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Salary Set-up";

            trigger OnValidate()
            var
                AppraisalSet: Record "Appraisal Salary Set-up";
            begin
                AppraisalSet.Reset();
                AppraisalSet.SetRange(Code, Rec.Code);
                if AppraisalSet.FindFirst() then begin
                    Rec.Type := AppraisalSet.Type;
                end;
            end;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Type; enum "Salary Type")
        {
            // OptionCaption = ' ,Earnings,Deductions,Basic,Other Allowances ,Gross Pay,Fosa Income,Pension,House Allowance,Taxable Pay,Relief';
            // OptionMembers = " ",Earnings,Deductions,Basic,"Other Allowances","Gross Pay","Net Income",Pension,"House Allowance","Taxable Pay",Relief;
            trigger OnValidate()
            var
                myInt: Integer;
                SalLines: Record "Salary Lines";
                Savingsacc: Record "Savings Accounts";
                LoansRec: Record Loans;
                GlobalFun: Codeunit "Global Functions";
                SlaryIn: Enum "Salary Income Types";
            begin
                Rec.Amount := 0;
                // LoansRec.Reset();
                // LoansRec.SetRange("Loan No.", Rec."Loan No");
                // LoansRec.SetFilter("Source Unit", '<>%1', LoansRec."Source Unit"::BOSA);
                // if LoansRec.FindFirst() then begin
                //     Savingsacc.Reset();
                //     Savingsacc.SetRange("Member No.", Rec."Client Code");
                //     Savingsacc.SetRange("Product Category", Savingsacc."Product Category"::"FOSA Account");
                //     if Savingsacc.FindFirst() then begin
                // if Rec.Type = Rec.Type::"Net Income" then begin
                //     rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::Salary);
                // end;
                // if Rec.Type = Rec.Type::"SAYE Income" then begin
                //     Rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::SAYE);
                // end;
                // if Rec.Type = Rec.Type::Pension then begin
                //     Rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::Pension);
                // end;
                // end;
                // end
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            Var
                LoanApp: Record Loans;
            begin
                Rec."Modified By" := '';
                if Type = Type::"Net Income" then begin
                    "Modified By" := UserId;
                    Rec.Modify();
                end;
                // if Type = Type::"SAYE Income" then begin
                //     "Modified By" := UserId;
                //     Rec.Modify();
                // end;
                if Amount < 0 then Error('Amount cannot be less than zero');


                //to initialize the STO Amount if inserted and Display a message
                // if (Code = '7.1EXTERNAL BANK STO') and (Amount > 0) then begin
                //     ApprDetails.Reset;
                //     ApprDetails.SetRange("Loan No", "Loan No");
                //     ApprDetails.SetRange(Type, ApprDetails.Type::Basic);
                //     ApprDetails.SetFilter(Amount, '>0');
                //     if ApprDetails.FindFirst then begin
                //         Rec.Amount := 0;
                //         Rec.Modify;
                //         Message('Standing Order Amount not allowed when there is Basic Salary');
                //     end;
                // end;
                //end of initializing STO Amount

                if (Type = Type::"Gross Pay") then
                    Error(Text002);

                // if Rec."Loan No" <> '' then begin
                //     if LoanApp.Get(Rec."Loan No") then begin
                //         if (LoanApp."Source Unit" = LoanApp."Source Unit"::BOSA) then begin
                //             fnProcessSalaryDetails(rec."Loan No", rec."Client Code");
                //             // ApprD.CalculateNetPay();
                //         end;
                //     end;
                // end;
                // if Type = Type::Basic then begin

                //     ApprDetails.Reset;
                //     ApprDetails.SetRange(Type, Type::"Gross Pay");
                //     ApprDetails.SetRange("Loan No", "Loan No");
                //     if ApprDetails.Find('-') then begin
                //         ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                //         ApprDetails.Modify;
                //     end;
                // end else

                //     if Type = Type::Earnings then begin
                //         ApprDetails.Reset;
                //         ApprDetails.SetRange(Type, Type::"Gross Pay");
                //         ApprDetails.SetRange("Loan No", "Loan No");
                //         if ApprDetails.Find('-') then begin
                //             ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                //             ApprDetails.Modify;
                //         end;
                //     end else
                //         if Type = Type::"Other Allowances" then begin
                //             ApprDetails.Reset;
                //             ApprDetails.SetRange(Type, Type::"Gross Pay");
                //             ApprDetails.SetRange("Loan No", "Loan No");
                //             if ApprDetails.Find('-') then begin
                //                 ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                //                 ApprDetails.Modify;
                //             end;
                //         end else
                //             if Type = Type::Pension then begin
                //                 ApprDetails.Reset;
                //                 ApprDetails.SetRange(Type, Type::"Gross Pay");
                //                 ApprDetails.SetRange("Loan No", "Loan No");
                //                 if ApprDetails.Find('-') then begin
                //                     ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                //                     ApprDetails.Modify;
                //                 end;
                //             end;

                //initialize the STO Amount if there is a value in Basicbulk
                // if (Type = Type::Basic) and (Amount > 0) then begin
                //     ApprDetails.Reset;
                //     ApprDetails.SetRange("Loan No", "Loan No");
                //     ApprDetails.SetRange(Code, '7.1EXTERNAL BANK STO');
                //     if ApprDetails.FindFirst then begin
                //         STOVal := ApprDetails.Amount;
                //         ApprDetails.Amount := 0;
                //         ApprDetails.Modify;

                //         //IF Type=Type::"Other Allowances" THEN BEGIN
                //         ApprDetails.Reset;
                //         ApprDetails.SetRange(Type, Type::"Gross Pay");
                //         ApprDetails.SetRange("Loan No", "Loan No");
                //         if ApprDetails.Find('-') then begin
                //             ApprDetails.Amount := ApprDetails.Amount - STOVal;
                //             ApprDetails.Modify;
                //         end;
                //         //END;

                //     end;
                // end;
                //End of initialize STO Amount if There is Basic Amount


            end;
        }
        field(6; "Loan No"; Code[50])
        {
            TableRelation = Loans;

            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No") then
                    "Client Code" := LoanApp."Member No.";
            end;
        }
        field(7; Verified; Boolean)
        {
            Editable = false;
        }
        field(8; "Modified By"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Rate; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec.Hours > 0 then begin
                    if rec.Rate > 0 then
                        Rec.Amount := round(Rec.Rate * Rec.Hours, 0.01);
                end;
                rec.Validate(amount);

            end;
        }
        field(10; Hours; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec.Hours > 0 then begin
                    if rec.Rate > 0 then
                        Rec.Amount := round(Rec.Rate * Rec.Hours, 0.01);
                end;
                rec.Validate(amount);
            end;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Client Code", "Code", Type, Description)
        {
            Clustered = true;
        }
        // key(Key2; "Code", "Client Code", Type,Description)
        // {
        //     SumIndexFields = Amount;
        // }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        Text001: Label 'Loan is already %1 thus cannot modify';
    begin
        if LoanApp.Get("Loan No") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    procedure fnProcessSalaryDetails(LoanNo: code[20]; Mno: code[20])
    var
        curBasicPay: Decimal;
        ApprDetails: Record "Appraisal Salary Details";
        AppraisalSet: Record "Appraisal Salary Set-up";
        curTransAmount: Decimal;
        prPayrollProcessing: Codeunit "PR Payroll Processing";
        curNSSF: Decimal;
        ShifAmount: Decimal;
        Savingsacc: Record "Savings Accounts";
        DepositContr: Decimal;
        HousingLevyAmount: Decimal;
        curPayeAmount: Decimal;
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
        dtOpenPeriod: date;
        Members: Record "Members";
        intMonth: Integer;
        intYear: Integer;
        TaxablePay: Decimal;
        Relief: Decimal;
        Loanrec: Record Loans;
        TotalOutstanding: Decimal;
        PensionRelief: Decimal;
        curPensionAmount: Decimal;
        CurGrossPay: Decimal;
        OtherAllowances: Decimal;
        TotalDeductions: Decimal;
        OtherDeductions: Decimal;
    begin
        curBasicPay := 0;
        curTransAmount := 0;
        curNSSF := 0;
        ShifAmount := 0;
        HousingLevyAmount := 0;
        curPayeAmount := 0;
        TaxablePay := 0;
        Relief := 0;
        curPensionAmount := 0;
        CurGrossPay := 0;
        OtherAllowances := 0;
        TotalDeductions := 0;
        TotalOutstanding := 0;
        PensionRelief := 0;
        OtherDeductions := 0;
        // dtOpenPeriod := prPayrollProcessing.fnGetOpenPeriod();
        // intMonth := Date2dmy(dtOpenPeriod, 2);
        // intYear := Date2dmy(dtOpenPeriod, 3);

        // STEP 1: Get Basic Pay from details
        // if Rec.Type = Rec.Type::Basic then
        //     curBasicPay := Rec.Amount
        // else begin
        //     // Fetch Basic from existing salary detail lines
        //     ApprDetails.Reset();
        //     ApprDetails.SetRange("Loan No", LoanNo);
        //     ApprDetails.SetRange("Client Code", Mno);
        //     ApprDetails.SetRange(Type, ApprDetails.Type::Basic);
        //     if ApprDetails.FindFirst() then
        //         curBasicPay := ApprDetails.Amount;
        // end;

        // if Rec.Type = Rec.Type::Pension then
        //     curPensionAmount := Rec.Amount
        // else begin
        //     ApprDetails.Reset();
        //     ApprDetails.SetRange("Loan No", Rec."Loan No");
        //     ApprDetails.SetRange("Client Code", Rec."Client Code");
        //     ApprDetails.SetRange(Type, ApprDetails.Type::Pension);
        //     if ApprDetails.FindFirst() then
        //         curPensionAmount := ApprDetails.Amount;
        // end;

        // if Rec.Type = Rec.Type::"Gross Pay" then
        //     CurGrossPay := Rec.Amount
        // else begin
        //     ApprDetails.Reset();
        //     ApprDetails.SetRange("Loan No", Rec."Loan No");
        //     ApprDetails.SetRange("Client Code", Rec."Client Code");
        //     ApprDetails.SetRange(Type, ApprDetails.Type::"Gross Pay");
        //     if ApprDetails.FindFirst() then
        //         CurGrossPay := ApprDetails.Amount;
        // end;
        ApprDetails.Reset();
        ApprDetails.SetRange("Loan No", LoanNo);
        ApprDetails.SetRange("Client Code", Mno);
        ApprDetails.setfilter(Type, '%1|%2|%3|%4|%5', ApprDetails.Type::Basic, ApprDetails.Type::Pension, ApprDetails.Type::"Other Allowances", ApprDetails.Type::"House Allowance", ApprDetails.Type::Deductions);
        if ApprDetails.FindFirst() then begin
            repeat
                case
                    ApprDetails.Type of
                    ApprDetails.Type::Basic:
                        curBasicPay += ApprDetails.Amount;

                    ApprDetails.Type::Pension:
                        curPensionAmount += ApprDetails.Amount;
                    ApprDetails.Type::"Other Allowances", ApprDetails.Type::"House Allowance":
                        OtherAllowances += ApprDetails.Amount;
                    ApprDetails.Type::Deductions:
                        OtherDeductions += ApprDetails.Amount;
                end;
            until ApprDetails.Next() = 0;
        end;

        CurGrossPay := curBasicPay + OtherAllowances;
        // curBasicPay := ApprDetails.Amount;
        curTransAmount := ROUND(curBasicPay, 0.01, '<');
        if curTransAmount > 0 then begin
            curNSSF := prPayrollProcessing.fnGetEmployerNSSF(curTransAmount);
            //Message('NSSF: %1', curNSSF);
            ShifAmount := ROUND((curTransAmount * (2.75 / 100)), 0.01, '<');

            HousingLevyAmount := ROUND((curTransAmount * (1.5 / 100)), 0.01, '<');
            Relief := 2400;
            TaxablePay := (curTransAmount + OtherAllowances) - curNSSF - ShifAmount - HousingLevyAmount - curPensionAmount;
            if TaxablePay < 0 then
                TaxablePay := 0;
            curPayeAmount := prPayrollProcessing.fnGetEmployeePaye(TaxablePay);
            curPayeAmount := curPayeAmount - Relief;
            if curPayeAmount < 0 then
                curPayeAmount := 0;
            curPayeAmount := ROUND(curPayeAmount, 0.01, '>');

            TotalDeductions := curPayeAmount + ShifAmount + curNSSF + curPensionAmount + HousingLevyAmount + OtherDeductions;
        end;

        // STEP 3: Update using Appraisal Setup
        ApprDetails.Reset();
        ApprDetails.SetRange("Loan No", LoanNo);
        ApprDetails.SetRange("Client Code", Mno);
        if ApprDetails.FindSet() then begin
            repeat
                // Link to setup using Code (BEST key)
                // AppraisalSet.Reset();
                // AppraisalSet.SetRange(Code, ApprDetails.Code);

                // if AppraisalSet.FindFirst() then begin

                case ApprDetails.Type of
                    ApprDetails.Type::"Gross Pay":
                        ApprDetails.Amount := CurGrossPay;

                    ApprDetails.Type::NSSF:
                        ApprDetails.Amount := curNSSF;

                    ApprDetails.Type::SHIF:
                        ApprDetails.Amount := ShifAmount;

                    // 'SHARES':
                    //     ApprDetails.Amount := DepositContr;

                    ApprDetails.Type::PAYE:
                        ApprDetails.Amount := curPayeAmount;

                    ApprDetails.Type::HLEVY:
                        ApprDetails.Amount := HousingLevyAmount;

                    ApprDetails.Type::"Taxable Pay":
                        ApprDetails.Amount := TaxablePay;

                    ApprDetails.Type::Relief:
                        ApprDetails.Amount := Relief;

                    ApprDetails.Type::Loans:
                        ApprDetails.Amount := TotalOutstanding;
                    ApprDetails.Type::"Total Deduction":
                        begin
                            ApprDetails.Amount := TotalDeductions;
                        end;

                    ApprDetails.Type::"Net Income":
                        begin
                            ApprDetails.Amount := CurGrossPay - TotalDeductions;
                        end;
                end;
                ApprDetails.Modify();
            // end;
            until ApprDetails.Next() = 0;
        end;
    end;

    local procedure CalculateNetPay()
    var
        GrossPay: Decimal;
        TotalDeductions: Decimal;
        NetPayRec: Record "Appraisal Salary Details";
    begin
        GrossPay := 0;
        TotalDeductions := 0;

        // Get Gross Pay
        ApprDetails.Reset;
        ApprDetails.SetRange("Loan No", "Loan No");
        ApprDetails.SetRange("Client Code", "Client Code");
        ApprDetails.SetRange(Type, Type::"Gross Pay");
        if ApprDetails.FindFirst then
            GrossPay := ApprDetails.Amount;

        // Calculate Total Deductions from database
        ApprDetails.Reset;
        ApprDetails.SetRange("Loan No", "Loan No");
        ApprDetails.SetRange("Client Code", "Client Code");
        ApprDetails.SetRange(Type, Type::Deductions);
        ApprDetails.SetFilter(Code, '<>%1', Rec.Code);
        if ApprDetails.FindSet then
            repeat
                TotalDeductions += ApprDetails.Amount;
            until ApprDetails.Next = 0;

        // Include current record if it's a deduction being modified
        if Rec.Type = Rec.Type::Deductions then
            TotalDeductions += Rec.Amount;

        // Update or Create Net Income record
        ApprDetails.Reset;
        ApprDetails.SetRange("Loan No", "Loan No");
        ApprDetails.SetRange("Client Code", "Client Code");
        ApprDetails.SetRange(Type, Type::"Net Income");
        if ApprDetails.FindFirst then begin
            ApprDetails.Amount := GrossPay - TotalDeductions;
            ApprDetails.Modify(true);  // Added 'true' to trigger OnModify
        end else begin
            // Create new Net Income record if it doesn't exist
            ApprDetails.Init;
            ApprDetails."Loan No" := Rec."Loan No";
            ApprDetails."Client Code" := Rec."Client Code";
            ApprDetails.Type := Type::"Net Income";
            ApprDetails.Code := 'NET PAY';
            ApprDetails.Amount := GrossPay - TotalDeductions;
            ApprDetails.Insert;
        end;
    end;


    var
        "SalarySet-up": Record "Appraisal Salary Set-up";
        LoanApp: Record Loans;
        Text002: Label 'Do not capture anything here';
        ApprDetails: Record "Appraisal Salary Details";
        STOVal: Decimal;
        VitalSetup: Record "PR Vital Setup Info";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefNHIF: Decimal;
        curReliefNHIFAmt: Decimal;
        curDisabledLimit: Decimal;
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        curReliefPension: Decimal;
        curReliefMorgage: Decimal;
        CurAffordableHousingMax: Decimal;
        AffordableHRelief: Decimal;
        curMaximumRelief: Decimal;
        currMinRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        DisabledTaxRelief: Decimal;
        shifRelief: decimal;
        ShifPercentage: decimal;
        HousingLevyRate: Decimal;

}


