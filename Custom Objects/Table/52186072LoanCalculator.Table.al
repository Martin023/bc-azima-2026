table 52186072 "Loan Calculator"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
            trigger OnValidate()
            begin
                if "Loan No." <> xRec."Loan No." then begin
                    MembNoSeries.Get;
                    if "Source Unit" = "Source Unit"::FOSA then
                        NoSeriesMgt.TestManual(MembNoSeries."FOSA Loan Nos.") else
                        if "Source Unit" = "Source Unit"::"HR LOANS" then
                            NoSeriesMgt.TestManual(MembNoSeries."HR Loan Nos.") else
                            if "Source Unit" = "Source Unit"::"BUSINESS LOANS" then
                                NoSeriesMgt.TestManual(MembNoSeries."Business Loan Nos.") else
                                NoSeriesMgt.TestManual(MembNoSeries."Loan Nos.");
                    "No. Series" := '';
                    //Check dimensions and responsibility centre
                    "Application Date" := Today;
                    Advice := true;
                    "All Posting through Savings Ac" := true;

                    "Disbursement Date" := Today;// (CalcDate('CM', Today));
                    "disbursement time" := time;
                    "Captured By" := UpperCase(UserId);

                    if UserSetup.Get(UpperCase(UserId)) then begin
                        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                        "Responsibility Centre" := UserSetup."Responsibility Centre";
                    end;
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin

                if "Application Date" > Today then
                    Error('Application date can not be in the future.');
            end;
        }
        field(3; "Loan Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan),
                                                                  Status = CONST(Active));
            // "Source Unit" = field("Source Unit")

            trigger OnValidate()
            var
                Apprasail: Record "Appraisal Salary Details";
                loansGu: Record "Loan Guarantors and Security";
                RetirementDate: date;
                adj: Integer;
                HrEmployees: Record "HR Employees";
                Yearsofservice: Integer;
                ProductFa: Record "Product Factory";
                LoansS: Record Loans;
                Morg: Boolean;
                DateComplition: Date;
                NoofMonths: Decimal;
                Nofdays: Integer;
                MemberAge: Integer;
                LoansProcessing: codeunit "Loans process";
            begin


                NoofMonths := 0;
                "Loan Group" := "Loan Group"::Normal;
                ClearMortgageDate;
                Yearsofservice := 0;
                ProductFa.Get(rec."Loan Product Type");

                ProdFac.Get("Loan Product Type");
                "Loan Group" := ProdFac."Loan Group";

                if "Loan Group" = "Loan Group"::"Group Loan" then begin
                    InsertLoanGuarantorsForBusinessLoans();
                    rec."Share Boosted Amount" := 0;
                end;
                Otherdeposits := 0;
                if ProductFactory.Get(rec."Loan Product Type") then begin
                    OtherAppraisals.Reset();
                    OtherAppraisals.SetRange(OtherAppraisals."Product ID", ProductFactory."Product ID");
                    if OtherAppraisals.Find('-') then begin
                        repeat
                            SavingsAccounts.Reset();
                            SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                            SavingsAccounts.SetRange("Product Type", OtherAppraisals."Product code");
                            if SavingsAccounts.Find('-') then begin
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                Otherdeposits := Otherdeposits + SavingsAccounts."Balance (LCY)";
                            end;
                        until OtherAppraisals.Next() = 0;
                    end;
                end;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Product Type", ProductFa."Loan Appraisal Account Code");
                if SavAcc.find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    //Check Minimum savings per product
                    "Member Deposits" := SavAcc."Balance (LCY)" + Otherdeposits;
                end;
                Rec."Source Unit" := ProductFa."Source Unit";
                if rec."Source Unit" = Rec."Source Unit"::"HR LOANS" then begin
                    HrEmployees.Reset();
                    HrEmployees.SetRange("Member No.", Rec."Member No.");
                    if HrEmployees.FindFirst() then begin
                        Yearsofservice := Today - HrEmployees."Date Of Join";
                        if Yearsofservice < 2 then
                            if ProductFa."Mortgage Loan" = true then
                                Error('A member must have serviced for atleast 2 years before applying for this product');
                    end;
                end;
                "Loan Account" := '';
                "Cost Value of House" := 0;
                "Max. Loan Amount" := 0;
                "Recommended Amount" := 0;
                //"Requested Amount":=0;
                "Approved Amount" := 0;
                "Amount To Disburse" := 0;
                //"Retirement/Expiry Date" := 0D;

                if ProdFac.Get("Loan Product Type") then begin
                    Rec."Appraisal Parameter Type" := ProdFac."Appraisal Parameter Type";

                    TestField("Member No.");
                    //Get age of the client
                    // ProdFacDisb.reset;
                    // ProdFacDisb.SetRange(ProdFacDisb."Product ID", ProdFac."Loan Disbt Account Code");
                    // if ProdFacDisb.Find('-') then begin

                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    if ProdFac."Loan Disbt Account Code" <> '' then
                        SavAcc.SetRange("Product Type", ProdFac."Loan Disbt Account Code")
                    else
                        // SavAcc.SetRange("Product Type", '191');
                          SavAcc.SetRange(SavAcc."Loan Disbursement Account", true);
                    if SavAcc.Find('-') then
                        "Disbursement Account No" := SavAcc."No."
                    else
                        error('Loan disbursement account product was not found. kindly create product %1', ProdFac."Loan Disbt Account Code");
                    // end;
                    // if (CalcDate('-CM+15D', Today)) > Today then
                    //    "Disbursement Date" := (CalcDate('-CM+15D', Today)) else
                    "Disbursement Date" := Today;//(CalcDate('CM', Today));

                    if Mem.Get("Member No.") then begin
                        if ProdFac.Category = ProdFac.Category::"Business Dep Loan" then begin
                            if not Mem."Has Joined Business Loans" then
                                Error('This product is only meant for members who have joined business loans class');
                        end;
                        //if from another sacco
                        if Mem."From Another Sacco" = false then begin
                            IF ProdFac.GET("Loan Product Type") THEN BEGIN
                                Mem.TESTFIELD("Registration Date");
                                IF Mem."Registration Date" > CALCDATE(ProdFac."Minimum Application Period", TODAY) THEN BEGIN
                                    // IF "Override Loan Qualification" = FALSE THEN
                                    ERROR('Registration date of this member must be before %1', CALCDATE(ProdFac."Minimum Application Period", TODAY));
                                END;
                                //check registration date-Faith's  Logic
                                if CalcDate(ProdFac."Minimum Application Period", Mem."Registration Date") > Today THEN begin
                                    ERROR('The member has been registered for less than six months and is therefore not eligible to apply for a loan.');
                                end;

                                // //check registration date
                                //Check Gender
                                IF ProdFac.Gender <> ProdFac.Gender::" " THEN BEGIN
                                    IF Mem.Gender <> ProdFac.Gender THEN
                                        ERROR('Member is %1 yet this loan applies only to %2', Mem.Gender, ProdFac.Gender);
                                END;
                            END;
                            if Mem."Account Type" = Mem."Account Type"::"Single Member Account" then begin
                                if "Dummy Appraisal" = true then begin
                                    if Mem."Date of Birth" = 0D then Mem."Date of Birth" := 19900101D;
                                end;
                                ClientAge := HRDates.DetermineAge(Mem."Date of Birth", Today);

                                ClientAgePart := CopyStr(ClientAge, 1, 2);


                                ClientAgePart := CopyStr(ClientAge, 1, 2);

                                Evaluate(ClientAgeValue, ClientAgePart);

                                ProdMinAgeText := DelChr(Format(ProdFac."Min. Customer Age"), '=', 'Y|M');

                                Evaluate(ProdMinAge, ProdMinAgeText);
                            end;
                            if "Dummy Appraisal" = false then begin
                                if ProdMinAge > ClientAgeValue then
                                    Error(Text005, ProdFac."Min. Customer Age");
                            end else
                                Message(Text010);
                        end;


                        if "Dummy Appraisal" = true then begin
                            if ProdMinAge > ClientAgeValue then
                                Message(Text005, ProdFac."Min. Customer Age");
                        end;
                    end;

                    if "Dummy Appraisal" = false then begin
                        //confirm if loan exist of same type
                        LoanApp.Reset;
                        LoanApp.SetRange("Member No.", "Member No.");
                        LoanApp.SetRange(Posted, true);
                        if ProdFac."Nature of Loan Type" <> ProdFac."Nature of Loan Type"::"Karibu Loan" then
                            LoanApp.SetRange("Loan Product Type", "Loan Product Type");
                        LoanApp.SetRange("Dummy Appraisal", false);
                        LoanApp.SetFilter("Outstanding Balance", '>0');
                        if LoanApp.Find('-') then begin
                            repeat
                                if ProdFac.Get("Loan Product Type") then begin
                                    if ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::"Karibu Loan" then begin
                                        Error('Member does not qualify. Has an existing Loan %1. ', LoanApp."Loan No.")
                                    end;
                                    if ProdFac."Allow Multiple Running Loans" = false then
                                        Message('Member already has an existing Loan %1 of same product which needs bridging', LoanApp."Loan No.")
                                    else
                                        Message('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");
                                end;
                            until LoanApp.Next = 0;
                        end;
                    end;

                    //Get if salary based loan and the frequency in that period
                    if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
                        if ProdFac."Requires Salary Processing" = true then begin
                            EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", "Disbursement Account No");
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            SalProc.SetRange(Posted, true);
                            if SalProc.Find('-') then begin
                                if SalProc.Count < ProdFac."No. of Salary Times" then begin
                                    if "Dummy Appraisal" = false then
                                        Error(Text009) else
                                        Message(Text009)
                                end;

                                if ProdFac."Requires Salary Processing" = true then begin
                                    EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                                    SalProc.Reset;
                                    SalProc.SetRange("Account No.", "Disbursement Account No");
                                    SalProc.SetRange("Posting Date", EndDateSalo, Today);
                                    SalProc.SetRange(Posted, true);
                                    if SalProc.Find('-') then begin
                                        if SalProc.Count < ProdFac."No. of Salary Times" then begin
                                            if "Dummy Appraisal" = false then
                                                Error(Text009) else
                                                Message(Text009);
                                        end;
                                    end;

                                end;
                            end;
                        end;
                    end;
                    if Credit.Get(ProdFac."Account No. Prefix" + "Member No." + ProdFac."Account No. Suffix") then
                        "Loan Account" := ProdFac."Account No. Prefix" + "Member No." + ProdFac."Account No. Suffix";
                end else begin
                    Message('This member does not  have a loan account. Kindly use create function before you proceed');
                    "Loan Account" := '';
                end;
                "Loan Product Type Name" := ProdFac."Product Description";
                "Grace Period" := ProdFac."Grace Period - Interest";
                Interest := ProdFac."Interest Rate (Min.)";
                "Global Dimension 2 Code" := ProdFac."Global Dimension 2 Code";
                "Grace Period" := ProdFac."Grace Period - Interest";
                "Interest Calculation Method" := ProdFac."Interest Calculation Method";
                "Loan Span" := ProdFac."Loan Span";
                Installments := ProdFac."Ordinary Default Intallments";
                "Disbursement Priority" := ProdFac."Disbursement Priority";
                "Recovery Priority" := ProdFac."Recovery Priority";
                "Compute Interest Due on Postin" := ProdFac."Compute Interest Due on Postin";
                "Repayment Frequency" := ProdFac."Repayment Frequency";
                "Recovery Mode" := ProdFac."Repay Mode";
                "Appraisal Parameter Type" := ProdFac."Appraisal Parameter Type";
                "Source Unit" := ProdFac."Source Unit";
                ProdFac.Get("Loan Product Type");
                if ProdFac."Mortgage Loan" = false then
                    if "Loan No." <> UserId then begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                        LoanApp.SetRange("Dummy Appraisal", false);
                        LoanApp.SetRange(LoanApp.Posted, false);
                        if LoanApp.Find('-') then begin
                            repeat
                                if LoanApp.Status <> LoanApp.Status::Rejected then begin
                                    if ProdFac.Get("Loan Product Type") then begin
                                        if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Loan Discounting" then begin
                                            if LoanApp."Loan No." <> UserId then begin
                                                if LoanApp."Loan No." <> "Loan No." then begin
                                                    if "Dummy Appraisal" = false then
                                                        Message('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.")
                                                    else
                                                        Message('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.");

                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            until LoanApp.Next = 0;
                        end;
                    end;
                //Clear requirements
                LoanReq.Reset;
                LoanReq.SetRange(LoanReq."Loan No.", "Loan No.");
                if LoanReq.Find('-') then begin
                    LoanReq.DeleteAll;
                end;
                //Update required documents
                LoanReqDocs.Reset;
                LoanReqDocs.SetRange(LoanReqDocs."Loan No.", "Loan No.");
                if LoanReqDocs.Find('-') then begin
                    LoanReqDocs.DeleteAll;
                end;

                ApplDocs.Reset;
                ApplDocs.SetRange(ApplDocs."Product ID", "Loan Product Type");
                if ApplDocs.Find('-') then begin
                    repeat
                        LoanReqDocs.Init;
                        LoanReqDocs."Loan No." := "Loan No.";
                        LoanReqDocs.Description := ApplDocs.Description;
                        LoanReqDocs."Document No." := ApplDocs."Document No.";
                        LoanReqDocs."Document Type" := ApplDocs."Document Type";
                        LoanReqDocs."Entry No." := LoanReqDocs."Entry No." + 100;
                        LoanReqDocs."Product ID" := "Loan Product Type";
                        LoanReqDocs."Product Name" := "Loan Product Type Name";
                        LoanReqDocs.Insert;
                    until ApplDocs.Next = 0;
                end;

                // //Fixed DepositType
                // if ProdFac."Repay Mode" = ProdFac."Repay Mode"::"Fixed Deposit" then begin
                //     SavingsAccounts.Reset;
                //     SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                //     SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Fixed Deposit");
                //     SavingsAccounts.SetRange(SavingsAccounts."Fixed Deposit Status", SavingsAccounts."Fixed Deposit Status"::Active);
                //     if not SavingsAccounts.Find('-') then begin
                //         if "Dummy Appraisal" = false then
                //             Error(Text006, ProdFac."Ordinary Default Intallments") else
                //             Message(Text006, ProdFac."Ordinary Default Intallments")
                //     end;
                // end;
                if (ProdFac."Repay Mode" = ProdFac."Repay Mode"::Dividend) then begin
                    DivloanBal := 0;

                    LNRec.RESET;
                    LNRec.SETRANGE(LNRec."Member No.", "Member No.");
                    LNRec.SETRANGE(LNRec."recovery Mode", LNRec."Recovery Mode"::Dividend);
                    LNRec.SETFILTER(LNRec."Outstanding Balance", '>0');
                    IF LNRec.FIND('-') THEN BEGIN
                        REPEAT
                            LNRec.CALCFIELDS(LNRec."Outstanding Balance", "Outstanding Interest");
                            DivloanBal += (LNRec."Outstanding Balance" + LNRec."Outstanding Interest");
                        UNTIL LNRec.NEXT = 0;
                    END;

                    DivSetup.GET;
                    DividendProgression.RESET;
                    DividendProgression.SETRANGE("Member No", "Member No.");
                    DividendProgression.SETRANGE("End Date", DivSetup."Start Date", DivSetup."End Date");
                    IF DividendProgression.FIND('-') THEN BEGIN
                        DividendProgression.CALCSUMS("Gross Dividends", "Net Dividends");
                        "Requested Amount" := (ProdFac."Discounting %" / 100 * DividendProgression."Net Dividends") - DivloanBal;

                        "Recommended Amount" := "Requested Amount";
                        VALIDATE("Requested Amount");
                    END;
                end;

                //Revalidate installments
                // if "Approved Amount" > 0 then
                //     Validate(Installments);
                Validate("Disbursement Date");
                //get retirement age for the member
                ProdFac.Get("Loan Product Type");
                if ProdFac."Mortgage Loan" = true then begin
                    "Mortgage Loan" := true;
                    Mem.Get("Member No.");
                    Validate("Retirement/Expiry Date");
                end else
                    "Mortgage Loan" := false;
                if Mem.Get(Rec."Member No.") then begin
                    if Mem."Employer Code" <> '' then begin
                        EmployerProducts.reset;
                        EmployerProducts.setrange("Employer Code", Mem."Employer Code");
                        EmployerProducts.SetRange("Product ID", Rec."Loan Product Type");
                        if EmployerProducts.Find('-') then begin
                            Rec.Installments := EmployerProducts.Installments;
                            if Installments = 0 then
                                Rec.Installments := ProdFac."Ordinary Default Intallments";
                            Rec.Interest := EmployerProducts.Interest;
                            if Interest = 0 then
                                Rec.Interest := ProdFac."Interest Rate (Min.)";
                            Rec."Max. Loan Amount" := EmployerProducts."Max Amount";
                            Rec."Recovery Mode" := EmployerProducts."Recovery Mode";
                            Rec."Grace Period" := EmployerProducts."Grace Period";
                        end;
                        TargetEmployers.reset;
                        TargetEmployers.SetRange("Product ID", Rec."Loan Product Type");
                        if TargetEmployers.Find('-') then begin
                            TargetEmployersII.reset;
                            TargetEmployersII.SetRange("Product ID", Rec."Loan Product Type");
                            TargetEmployersII.setrange("Employer Code", Mem."Employer Code");
                            if not TargetEmployersII.Find('-') then
                                error('This Product is not available for this employer.');
                        end;
                    end;
                end;
                // if ProdFac.Category = ProdFac.Category::"Business Dep Loan" then begin
                //     GlobalFunctions.ValidateBusinessLoansOnproductInput(Rec, Rec."Member No.");
                // end;
                //Check if an employee has a mortgage Loan to be eligible for mortgage refinancing
                Morg := false;
                DateComplition := 0D;
                ProdFac.Get(Rec."Loan Product Type");
                if rec."Source Unit" = Rec."Source Unit"::"HR LOANS" then begin
                    if ProdFac."Loan Refinancing" = true then begin
                        loanss.Reset();
                        loanss.SetRange("Member No.", Rec."Member No.");
                        LoansS.SetRange(Posted, true);
                        loanss.SetFilter(LoansS."Outstanding Balance", '>%1', 0);
                        if LoansS.FindFirst() then begin
                            repeat
                                if ProductFa.Get(LoansS."Loan Product Type") then
                                    if ProductFa."Mortgage Loan" = true then begin
                                        DateComplition := LoansS."Expected Date of Completion";
                                        Morg := true;
                                    end;
                            until loanss.Next() = 0;
                        end;
                        if Morg = false then
                            Error('You can only refinance a mortgage loan');
                        if Morg = true then begin
                            Nofdays := today - DateComplition;
                            NoofMonths := Round((Nofdays / 30), 1, '>');
                            rec.Installments := NoofMonths;
                            rec."Expected Date of Completion" := DateComplition;
                        end;
                    end;
                end;
                // get retirement age FB Version
                GenSetup.Get;
                Mem.Get("Member No.");
                if Mem."Any Physical Disability" = true then begin
                    "Retirement/Expiry Date" := CalcDate(GenSetup."Max. Member Age - Disabled", Mem."Date of Birth");

                    Validate("Retirement/Expiry Date");
                end else begin
                    "Retirement/Expiry Date" := CalcDate(GenSetup."Max. Member Age", Mem."Date of Birth");
                    Validate("Retirement/Expiry Date");
                end;

                if ProdFac."Pension Loan" = false then begin
                    // IF Installments > ("Retirement/Expiry Date" - TODAY) / 30 THEN
                    RetirementDate := CalcDate(GenSetup."Max. Member Age", Mem."Date of Birth");
                    // Calculate member's age in years
                    MemberAge := Date2DMY(Today, 3) - Date2DMY(Mem."Date of Birth", 3);
                    // Calculate max member age from DateFormula (assumed in years)
                    MaxMemberAge := 0;
                    Evaluate(MaxMemberAge, DelChr(Format(GenSetup."Max. Member Age"), '=', 'Y|M|D'));
                    // Subtract member's age from max member age
                    RetirementDue := MaxMemberAge - MemberAge;
                    RetirementInstallments := RetirementDue * 12; // Convert years to months if needed
                    IF Installments > RetirementInstallments then begin
                        Installments := RetirementInstallments;
                        if Installments <= 0 then
                            Message('Member already retired. Loan cannot be processed.')
                        else
                            Message('The loan repayment period exceeds the member’s maximum retirement age.The installment duration is adjusted to %1 months.', Installments);
                    end;
                end;
            end;
        }
        field(4; "Member No."; Code[20])
        {
            //TableRelation = Members."No.";
            TableRelation =
            IF ("Group Account No." = filter(<> '')) Members."No." WHERE("Group Account No." = field("Group Account No."))
            ELSE
            Members."No.";
            trigger OnValidate()
            var
                // Apprasail: record "Loan Appraisal Comments";
                loansGu: Record "Loan Guarantors and Security";
                memebrrec: Record Members;
                RetirementDate: Date;
                adj: Integer;
                LoanSS: Record Loans;
                LoanCount: Integer;
                Membersrec: Record Members;
                HrEmployees: Record "HR Employees";
                Yearsofservice: Integer;
                Otherdeposits: Decimal;
                OtherAppraisals: Record "Other Apprails products";
                ProductFactory: Record "Product Factory";
                ShareBoostAmount: Decimal;
                GeneralSetUp: Record "General Set-Up";
                TodayDate: Date;
                Comments: record Comments;
            begin
                GlobalFunctions.FlagAccounts(Rec."Member No.");
                // LoansProcess.LoanBulkClearence(Rec."Member No.");
                GlobalFunctions.DisplayLienMessage(Rec."Member No.");
                LoanSS.reset;
                LoanSS.setrange(LoanSS."Member No.", Rec."Member No.");
                LoanSS.SetFilter(Status, '%1|%2', LoanSS.Status::Open, LoanSS.Status::Pending);
                LoanSS.SetRange(LoanSS."Source Unit", Rec."Source Unit");
                LoanSS.SetRange(LoanSS."Sent Back to CRM", false);
                LoanSS.SetRange(LoanSS."Sent Back to M-Smart", false);
                if LoanSS.FindFirst() then begin
                    LoanCount := LoanSS.Count;
                    if LoanCount >= 1 then
                        if LoanSS."Loan No." <> Rec."Loan No." then
                            Error('Member has an existing loan application %1 in progress', LoanSS."Loan No.");
                end;

                Membersrec.Reset();
                Membersrec.SetRange("No.", rec."Member No.");
                if Membersrec.Find('-') then begin
                    if (Membersrec.Subflag <> Membersrec.Subflag::Rejoined) and (Membersrec.Subflag <> Membersrec.Subflag::"First time") and (Membersrec.Subflag <> Membersrec.Subflag::"Partial withdrawn") and (Membersrec.Subflag <> Membersrec.Subflag::Defaulter) then
                        Error('The member with status  %1 is not allowed to apply for loan', Membersrec.Subflag);
                    if Membersrec.Subflag = Membersrec.Subflag::Defaulter then
                        Message('The Member is a defaulter!');
                end;
                memebrrec.Reset();
                memebrrec.SetRange(memebrrec."No.", Rec."Member No.");
                if memebrrec.FindFirst() then begin
                    if memebrrec."Account Type" = memebrrec."Account Type"::"Single Member Account" then begin
                        if memebrrec."Date of Birth" = 0D then
                            Error('Member date of birth not captured');
                        Rec."Member Age" := (ROUND((TODAY - memebrrec."Date of Birth") / 365.2364, 1, '<'));
                        Rec."ID No." := memebrrec."Primary Identification";
                    end;
                    "Member Class" := memebrrec."Member Class";
                    //Rec."Employer Code" := memebrrec."Employer Code";
                    if "Member Class" = '' then message('Kindly note that the Member Class is not indicated on the member')
                end;
                // Apprasail.Reset();
                // Apprasail.SetRange(Apprasail."Loan No.", Rec."Loan No.");
                // if Apprasail.FindFirst() then begin
                //     Apprasail.DeleteAll();
                // end;

                if ProdFac.Get("Loan Product Type") then begin
                    Otherdeposits := 0;
                    OtherAppraisals.Reset();
                    OtherAppraisals.SetRange(OtherAppraisals."Product ID", ProdFac."Product ID");
                    if OtherAppraisals.Find('-') then begin
                        repeat
                            SavingsAccounts.Reset();
                            SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                            SavingsAccounts.SetRange("Product Type", OtherAppraisals."Product code");
                            if SavingsAccounts.Find('-') then begin
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                Otherdeposits += SavingsAccounts."Balance (LCY)";
                            end;
                        until OtherAppraisals.Next() = 0;
                    end;

                end;
                loansGu.Reset();
                loansGu.SetRange(loansGu."Loan No", Rec."Loan No.");
                if loansGu.FindFirst() then begin
                    loansGu.DeleteAll();
                end;
                // To accomodate portal loans

                // if "Source Aplication" = "Source Aplication"::BC then begin
                // if "Source Unit" = Rec."Source Unit"::BOSA then begin
                UserSetup.get(USERID);
                if UserSetup."Member No." = '' then
                    // Skip error for Api 
                    if GlobalFunctions.SkipApiMsg() = false then begin
                        Error('Member number for %1 must have a value in the user setup', UserId);
                    end;
                IF (UserSetup."Member No." = "Member No.") and (UserSetup."Member No." <> '') then
                    Error('You cannot capture your own loan application.');
                // end;
                // end;

                "Loans - Deposit Purchase" := 0;
                "Share Boosted Amount" := 0;
                //ClearDataLoans;
                "Cost Value of House" := 0;
                "Retirement/Expiry Date" := 0D;
                // if "Picked Mobile Loan" = false then
                //     "Loan Product Type" := '';
                if ProdFac.Get("Loan Product Type") then
                    "Disbursement Account No" := '';
                "Loan Account" := '';
                GenSetup.Get;
                if "Loan Product Type" <> '' then begin
                    ProdFac.Get("Loan Product Type");
                    //if ProdFac."Mortgage Loan" = true then begin
                    Mem.Get("Member No.");
                    // if Mem."Employer Code" <> '99' then
                    GenSetup.testfield("Max. Member Age");
                    "Retirement/Expiry Date" := CalcDate(GenSetup."Max. Member Age", Mem."Date of Birth");

                end;

                //Check loan recovered from guarantor
                LoanRec.Reset;
                LoanRec.SetRange("Member No.", "Member No.");
                LoanRec.SetRange(Action, LoanRec.Action::Recovered);
                if LoanRec.Find('-') then begin
                    LoanRec.Reset;
                    LoanRec.SetRange("Member No.", "Member No.");
                    LoanRec.SetRange(Action, LoanRec.Action::Reversed);
                    LoanRec.SetRange("Recovery Type", LoanRec."Recovery Type"::Reversal);
                    if not LoanRec.Find('-') then begin
                        if "Override Loan Qualification" = false then
                            // Error(Text012, LoanRec."Loan No.") else
                            Message(Text012, LoanRec."Loan No.");
                    end;
                end;

                //Check if there is a loan never paid or is in arrears
                // LoanApp.Reset;
                // LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                // LoanApp.SetRange(LoanApp.Posted, true);
                // LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
                // if LoanApp.Find('-') then begin
                //     repeat
                //         CreditLedger.Reset;
                //         CreditLedger.SetRange(CreditLedger."Member No.", "Member No.");
                //         CreditLedger.SetRange(CreditLedger."Transaction Type", CreditLedger."Transaction Type"::Repayment);
                //         CreditLedger.SetRange(CreditLedger."Loan No", LoanApp."Loan No.");
                //         if not CreditLedger.Find('-') then
                //             // Message(Text003, LoanApp."Loan No.");//they dont want this pop up

                //         LoanApp.CalcFields(LoanApp."Outstanding Bills");

                //     // if LoanApp."Outstanding Bills" > 0 then//????revisit
                //     // if loanapp."Amount In Arreas SACCO" > 0 then
                //     //     Message(Text004, LoanApp."Loan No.");//they dont want this pop up
                //     until LoanApp.Next = 0;
                // end;

                if Mem.Get("Member No.") then begin
                    if "Dummy Appraisal" = false then begin
                        if memebrrec."Account Type" = memebrrec."Account Type"::"Single Member Account" then begin
                            Mem.TestField("Date of Birth");
                            Mem.TestField("Primary Identification");
                            // Mem.TestField("Phone No.");
                        end;
                    end else begin
                        if Mem."Date of Birth" = 0D then Message('Member date of birth not captured');
                        if Mem."Primary Identification" = '' then Message('Member has no Id number captured');
                        if Mem."Phone No." = '' then Message('Member has no phone number captured');
                    end;
                    if (Mem.Status <> Mem.Status::Active) and (Mem.Status <> Mem.Status::New) and (Mem.Status <> mem.Status::Dormant) then begin
                        //IF CONFIRM('This member is not active. Do you wish to continue with application ?',TRUE)=FALSE THEN
                        if "Dummy Appraisal" = false then Error("InactiveErr:") else Message("InactiveErr:");
                    end;
                    // "Staff No" := Mem."Payroll/Staff No.";
                    if "Staff No" <> '' then begin
                        HrEmployees.Reset();
                        HrEmployees.SetRange(HrEmployees."No.", Rec."Staff No");
                        HrEmployees.SetRange(Status, HrEmployees.Status::Active);
                        if HrEmployees.Find('-') then begin
                            "Date of join" := HrEmployees."Date Of Join";
                            "Date of retirement" := HrEmployees."Retirement date";
                            "Residential Address" := HrEmployees."Residential Address";
                        end;
                    end;
                    "Member Name" := Mem.Name;
                    "KRA PIN" := Mem."P.I.N Number";
                    "ID No." := Mem."Primary Identification";
                    "Application Date" := Today;
                    //"Employer Code" := Mem."Employer Code";
                    "Residential Address" := Mem."Home Address";
                    // "Global Dimension 1 Code":=Mem."Global Dimension 1 Code";
                    //"Global Dimension 2 Code":=Mem."Global Dimension 2 Code";

                    Comments.reset;
                    COmments.SetRange(Comments."Header No.", "Member No.");
                    Comments.setrange(Types, Comments.types::"Member Flagging");
                    Comments.setrange("Disable Flag", false);
                    if Comments.Find('-') then
                        Message(Comments."Comment");
                end else begin
                    if "Dummy Appraisal" = false then Error('Member does not exist') else Message('Member does not exist');
                end;
                if ("Member No." <> '') and ("Member No." <> xRec."Member No.") then begin
                    "Loan Account" := '';
                    "Disbursement Account No" := '';
                end;

                if ProdFac."Loan Disbt Account Code" <> '' then begin
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    SavAcc.SetRange("Product Type", ProdFac."Loan Disbt Account Code");
                    if SavAcc.Find('-') then
                        rec."Disbursement Account No" := SavAcc."No."
                    else
                        error('Loan disbursement account product was not found. kindly create product %1', ProdFac."Loan Disbt Account Code");
                end
                else begin
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    SavAcc.SetRange(SavAcc."Loan Disbursement Account", true);
                    // SavAcc.SetRange("Product Type", '191');
                    // SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"FOSA Account");
                    if SavAcc.Find('-') then
                        "Disbursement Account No" := SavAcc."No."
                    else begin
                        if "Dummy Appraisal" = false then
                            Error('Member No.' + SavAcc."Member No." + ' does not have an FOSA savings account') else
                            Message('Member No.' + SavAcc."Member No." + ' does not have an FOSA savings account');
                    end;
                end;

                ShareCapAcc.RESET;
                ShareCapAcc.SETRANGE(ShareCapAcc."Member No.", "Member No.");
                ShareCapAcc.SETRANGE(ShareCapAcc."Product Category", ShareCapAcc."Product Category"::"Share Capital");
                //reason for comment out:the data dont display share capital  category on saving account
                //ShareCapAcc.SETRANGE(ShareCapAcc."Product Type", '4');
                IF ShareCapAcc.FIND('-') THEN BEGIN
                    if SavProducts.Get(ShareCapAcc."Product Type") then begin
                        ShareCapAcc.CALCFIELDS(ShareCapAcc."Balance (LCY)");
                        IF ShareCapAcc."Balance (LCY)" < SavProducts."Minimum Contribution" THEN begin
                            if not ("Mobile Loan") and ("Loan Group" <> "Loan Group"::"Group Loan") then begin
                                MESSAGE('Member no. %1 has share capital of %2 and minimum required share capital is %3 This will be boosted on the loan.', LoanApp."Member No.", ShareCapAcc."Balance (LCY)", SavProducts."Minimum Contribution");
                                "Share Boosted Amount" := SavProducts."Minimum Contribution" - ShareCapAcc."Balance (LCY)";
                            end;
                        end;
                    end;
                END ELSE
                    MESSAGE('Member does not have share capital account.');
                //check share capital
                // if ProdFac.get(Rec."Loan Product Type") then begin
                //     ProdFacDisb.reset;
                //     ProdFacDisb.SetRange(ProdFacDisb."Product ID", ProdFac."Loan Disbt Account Code");
                //     if ProdFacDisb.Find('-') then begin
                // SavAcc.Reset;
                // SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                // //SavAcc.SetRange(SavAcc."Loan Disbursement Account", true);
                // SavAcc.SetRange("Product Type", '191');
                // if SavAcc.Find('-') then
                //     "Disbursement Account No" := SavAcc."No.";
                //     end;
                // end;

                //Update member transactions
                //DCSUpdate.UpdateMemberData("Member No.");
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    //Check Minimum savings per product
                    "Member Deposits" := SavAcc."Balance (LCY)";
                    Otherdeposits := Otherdeposits + SavAcc."Balance (LCY)";
                    if Otherdeposits < ProdFac."Minimum Deposit Balance" then begin
                        if "Dummy Appraisal" then
                            Message(Text011, Otherdeposits, ProdFac."Minimum Deposit Balance")
                        else
                            Error(Text011, Otherdeposits, ProdFac."Minimum Deposit Balance");
                    end;
                    if "Source Unit" = rec."Source Unit"::BOSA then begin
                        if SavAcc."Balance (LCY)" < ProdFac."Minimum Deposit Balance" then
                            Error(Text011, SavAcc."Balance (LCY)", ProdFac."Minimum Deposit Balance");
                    end;
                    GenSetup.TestField("Boosting Maturity");
                end;
                LoanHistory.Reset;
                LoanHistory.SetRange(LoanHistory."Loan Application No.", "Loan No.");
                if LoanHistory.Find('-') then begin
                    LoanHistory.DeleteAll;
                end;

                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                LoanApp.SetRange(Posted, true);
                if LoanApp.Find('-') then begin
                    repeat
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Bills", LoanApp."Outstanding Interest");
                        LoanHistory.Init;
                        LoanHistory."Loan Application No." := "Loan No.";
                        LoanHistory."Loan No." := LoanApp."Loan No.";
                        LoanHistory."Loan Expiry Date" := LoanApp."Expected Date of Completion";
                        LoanHistory."Loan Issued Date" := LoanApp."Disbursement Date";
                        LoanHistory."Outanding Bill" := LoanApp."Outstanding Bills";
                        LoanHistory."Outstanding Balance" := LoanApp."Outstanding Balance";
                        LoanHistory."Outstanding Interest" := LoanApp."Outstanding Interest";
                        LoanHistory."Loan Status" := LoanApp."Loans Category-SASRA";
                        LoanHistory."Loan Product Type" := LoanApp."Loan Product Type";
                        LoanHistory.Insert;
                    until LoanApp.Next = 0;
                end;
                ImageData.Reset;
                ImageData.SetRange(ImageData."Member No", "Member No.");
                if ImageData.Find('-') then begin
                    ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
                    if not ImageData.Picture.HasValue then begin
                        if "Dummy Appraisal" = false then
                            Message('Kindly capture the member photo before proceeding') else
                            Message('Kindly capture the member photo before proceeding')
                    end;
                    if not ImageData.Signature.HasValue then begin
                        if "Dummy Appraisal" = false then
                            Message('Kindly Signature sample of the member before proceeding') else
                            Message('Kindly Signature sample of the member before proceeding');
                    end;

                end else begin
                    if "Dummy Appraisal" = false then
                        Message('Kindly capture the member photo & Signature before proceeding') else
                        Message('Kindly capture the member photo & Signature before proceeding');

                end;


                "Application Date" := Today;
                Advice := true;
                "All Posting through Savings Ac" := true;
                "Captured By" := UpperCase(UserId);
                //Avoid multiple loan applications pending
                if "Loan No." <> UserId then begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                    LoanApp.SetRange(LoanApp.Posted, false);
                    if LoanApp.Find('-') then begin
                        repeat
                            if LoanApp.Status <> LoanApp.Status::Rejected then begin
                                if ProdFac.Get("Loan Product Type") then begin
                                    if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Loan Discounting" then begin
                                        if LoanApp."Loan No." <> UserId then begin
                                            if LoanApp."Loan No." <> "Loan No." then begin
                                                if "Dummy Appraisal" = false then
                                                    Message('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.") else
                                                    Message('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.");

                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                end;

                userSetup.get(USERID);
                if userSetup."Member No." = Rec."Member No." then begin
                    Error('You cannot capture your own loan application.');
                end;
            end;
        }
        field(5; "Requested Amount"; Decimal)
        {

            // Editable = false;

            trigger OnValidate()
            var
                DivDiscRem: decimal;
            begin
                //checkfoboosting


                //endofboosting
                //check if its morgateg loan
                if rec."Max. Loan Amount" <> 0 then
                    if rec."Requested Amount" > Rec."Max. Loan Amount" then
                        Error('You cannot exceed the maximum loan Amount');
                if ProdFac.Get("Loan Product Type") then begin
                    if ProdFac."Mortgage Loan" = true then begin
                        if "Cost Value of House" <= 0 then Error('Kindly Specify Cost Value of the house being Purchased');
                        TestField("Retirement/Expiry Date");
                        if "Requested Amount" > ("Cost Value of House" * (90 / 100)) then Error('Amount Applied cannot exceed 90% cost value of the house being Purchase ')
                    end;
                end;

                if "Loan Account" = '' then
                    rec."Loan Account" := LoanProcess.CreateLoanAccount("Member No.", "Loan Product Type");

                //ERROR('This member does not have a loan account. Please create before you proceed');
                if "Disbursement Account No" = '' then begin
                    if "Dummy Appraisal" = false then
                        Error('This member does not have a disbursement account. Please create before you proceed') else
                        Message('This member does not have a disbursement account. Please create before you proceed');
                end;



                "Approved Amount" := "Requested Amount";
                "Amount To Disburse" := "Requested Amount";
                "Recommended Amount" := 0;
                // if "Source Unit" <> rec."Source Unit"::BOSA then begin
                //     "Approved Amount" := Rec."Requested Amount";

                //     Validate("Approved Amount");
                // end;

                Validate("Approved Amount");
                "Application Date" := Today;

                // if ProdFac.Get("Loan Product Type") then begin
                //     DepositMultiplier := Rec."Member Deposits" * ProdFac."Ordinary Deposits Multiplier";
                //     PossibleDeposits := Rec."Requested Amount" - DepositMultiplier;
                //     if DepositMultiplier > 0 then begin
                //         Rec."Loans - Deposit Purchase" := PossibleDeposits;
                //         // Rec.Modify();
                //     end;

                // end;

                //Check maximum and minimum loan amounts

                if ProdFac.Get("Loan Product Type") then begin
                    // IF "Picked Mobile Loan"=FALSE THEN BEGIN
                    if (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::" ")
                    or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::"Karibu Loan") then begin
                        if ("Requested Amount" > ProdFac."Maximum Loan Amount") or ("Requested Amount" < ProdFac."Minimum Loan Amount") then begin
                            if "Dummy Appraisal" = false then Error(LoanAmountErr, ProdFac."Minimum Loan Amount", ProdFac."Maximum Loan Amount") else Message(LoanAmountErr, ProdFac."Minimum Loan Amount", ProdFac."Maximum Loan Amount");
                        end;
                        // END;
                    end;
                end;



                // if ProdFac."No. Of Months for Appr. Saving" > 0 then begin
                //     BusinessIncome.Reset;
                //     BusinessIncome.SetRange(BusinessIncome."Loan No.", "Loan No.");
                //     if BusinessIncome.Find('-') then
                //         BusinessIncome.DeleteAll;



                //     LastMonthDate := CalcDate('<-1M>', Today);

                //     for i := 1 to ProdFac."No. Of Months for Appr. Saving" do begin
                //         LowerDateLimit := CalcDate('<-CM>', LastMonthDate);
                //         UpperDateLimit := CalcDate('<CM>', LastMonthDate);

                //         SavLedger.SetCurrentKey(SavLedger."Customer No.", SavLedger."Posting Date");
                //         SavLedger.SetRange(SavLedger."Customer No.", "Disbursement Account No");
                //         SavLedger.SetFilter("Document No.", '<>*BC0');
                //         SavLedger.SetRange(SavLedger."Posting Date", LowerDateLimit, UpperDateLimit);
                //         SavLedger.CalcSums(SavLedger."Amount (LCY)");
                //         SavLedger.CalcSums(SavLedger."Debit Amount (LCY)");
                //         SavLedger.CalcSums(SavLedger."Credit Amount (LCY)");
                //         //MESSAGE('%1',SavLedger.Amount);
                //         BusinessIncome.Init;
                //         BusinessIncome."Loan No." := "Loan No.";
                //         BusinessIncome."Average Amount (Internal)" := SavLedger."Credit Amount (LCY)" * (ProdFac."Net Salary Multiplier %" / 100);//-SavLedger."Debit Amount (LCY)";//SavLedger.Amount*-1;
                //         BusinessIncome."First Day of Current Month" := LowerDateLimit;
                //         BusinessIncome."Entry No." := BusinessIncome."Entry No." + 1;
                //         BusinessIncome."Total Credits (Internal)" := SavLedger."Credit Amount (LCY)";
                //         BusinessIncome."Total Debits (Internal)" := 0;//SavLedger."Debit Amount (LCY)";
                //         BusinessIncome.Insert;
                //         LastMonthDate := CalcDate('<-1M>', UpperDateLimit);
                //     end;
                // end;

                // //Fixed DepositType
                // if ProdFac."Repay Mode" = ProdFac."Repay Mode"::"Fixed Deposit" then begin
                //     SavingsAccounts.Reset;
                //     SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                //     SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Fixed Deposit");
                //     SavingsAccounts.SetRange(SavingsAccounts."Fixed Deposit Status", SavingsAccounts."Fixed Deposit Status"::Active);
                //     if SavingsAccounts.Find('-') then begin
                //         // REPEAT
                //         if "Requested Amount" > SavingsAccounts."Fixed Deposit Amount" then begin
                //             if "Dummy Appraisal" = false then Error(Err008) else Message(Err008);
                //         end;
                //         //  UNTIL SavingsAccounts.NEXT=0;
                //     end;
                // end;

                //Div Discounting
                IF ProdFac.GET("Loan Product Type") THEN BEGIN
                    IF ProdFac."Type of Discounting" = ProdFac."Type of Discounting"::"Dividend Discounting" THEN BEGIN


                        DivDiscRem := LoansProcess.ComputeDividendsDiscounting(Rec."Member No.", ProdFac."Product ID", false);
                        if "Requested Amount" > 0 then begin
                            IF "Requested Amount" > DivDiscRem THEN begin
                                "Requested Amount" := DivDiscRem;
                                MESSAGE('You cannot apply more than the recommended amount of %1 .', DivDiscRem);
                            end;
                        end;


                        "Recommended Amount" := "Requested Amount";
                        "Approved Amount" := "Requested Amount";
                        Rec.Validate("Approved Amount");
                    end;
                end;
            end;
        }
        field(6; "Approved Amount"; Decimal)
        {
            trigger OnValidate()
            var
                Employerate: Decimal;
                GlobalFu: Codeunit "Global Functions";
                LoanSrec: Record Loans;
                CreditLedger: Record "Credit Ledger Entry";
                DivDiscRem: DECIMAL;
            begin
                // //IF ProdFac.GET("Loan Product Type") THEN BEGI
                // if rec."Approved Amount" <> xRec."Approved Amount" then
                //     Rec."Loan Appraised By" := '';
                if rec."Approved Amount" <= 0 then begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetRange(LoanApp."Source Unit", LoanApp."Source Unit"::BOSA);
                    LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
                    if LoanApp.Find('-') then begin
                        LoanApp.CalcFields("Total Loan Balance");
                        if LoanApp."Total Loan Balance" > 0 then begin
                            LoansTopup.Reset;
                            LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                            LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                            if LoansTopup.Find('-') then begin
                                LoansTopup.delete;
                                exit;
                            end;
                        end;
                    end;
                end;

                ProdFac.Reset;
                ProdFac.SetRange("Product ID", Rec."Loan Product Type");
                if ProdFac.FindFirst then begin
                    //  IF "Picked Mobile Loan"=FALSE THEN BEGIN
                    if "Mobile Loan" <> true then begin
                        if (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::" ") or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::"Karibu Loan") then begin
                            if ("Requested Amount" > ProdFac."Maximum Loan Amount") or ("Requested Amount" < ProdFac."Minimum Loan Amount") then begin
                                if "Dummy Appraisal" = false then Error(LoanAmountErr, ProdFac."Minimum Loan Amount", ProdFac."Maximum Loan Amount") else Message(LoanAmountErr, ProdFac."Minimum Loan Amount", ProdFac."Maximum Loan Amount");
                                //  END;
                            end;
                        end;
                    end;
                end;
                IF ProdFac.GET("Loan Product Type") THEN BEGIN
                    IF ProdFac."Type of Discounting" = ProdFac."Type of Discounting"::"Dividend Discounting" THEN BEGIN
                        DivDiscRem := 0;

                        DivDiscRem := LoansProcess.ComputeDividendsDiscounting(Rec."Member No.", ProdFac."Product ID", false);
                        if "Approved Amount" > 0 then begin
                            IF "Approved Amount" > DivDiscRem THEN
                                ERROR('You cannot apply more than the recommended amount of %1 .', DivDiscRem);

                        end;
                    end;
                    if ("Approved Amount" > 0) and ("Recommended Amount" <> 0) then begin
                        IF "Approved Amount" > "Recommended Amount" THEN
                            ERROR('You cannot apply more than the recommended amount');
                    end;
                end;
                if Rec.Installments <= 0 then
                    Error(InstallmentsErr);

                if "Approved Amount" > "Requested Amount" then
                    Error(ApprovedAmtErr);

                if ("Approved Amount" > "Recommended Amount") and ("Recommended Amount" <> 0) then
                    ERROR('You cannot apply more than the recommended amount of %1 .', DivDiscRem);

                "Amount To Disburse" := "Approved Amount";


                //
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";

                if (InterestRate <> 0) and (not ProdFac."Interest Recovered Upfront") then begin
                    EmployerProducts.Reset();
                    EmployerProducts.SetRange("Product ID", Rec."Loan Product Type");
                    if EmployerProducts.FindFirst() then begin
                        Employerate := EmployerProducts.Interest;
                        if Employerate = 0 then
                            Employerate := InterestRate
                        else
                            Employerate := Employerate;
                    End;
                    if "Interest Calculation Method" = "Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Repayment" := Round(TotalMRepay, 1, '>');
                    end;


                    if "Interest Calculation Method" = "Interest Calculation Method"::"Straight Line" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := Round((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := round((LPrincipal + LInterest), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
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
                end;
                //Boosting
                // GenSetup.Get();
                // GenSetup.TestField("Boosting Maturity");
                // IF "Requested Amount" <> 0 THEN BEGIN
                //     "Share Boosted Amount" := 0;
                //     GenSetup.GET();
                //     IF ProdFac.GET("Loan Product Type") THEN BEGIN

                //         ProdFac.Get("Loan Product Type");
                //         Otherdeposits := 0;
                //         OtherAppraisals.Reset();
                //         OtherAppraisals.SetRange(OtherAppraisals."Product ID", ProdFac."Product ID");
                //         if OtherAppraisals.Find('-') then begin
                //             repeat
                //                 SavingsAccounts.Reset();
                //                 SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                //                 SavingsAccounts.SetRange("Product Type", OtherAppraisals."Product code");
                //                 if SavingsAccounts.Find('-') then begin
                //                     SavingsAccounts.CalcFields("Balance (LCY)");
                //                     Otherdeposits := Otherdeposits + SavingsAccounts."Balance (LCY)";
                //                 end;
                //             until OtherAppraisals.Next() = 0;
                //         end;
                //         SavAcc.RESET;
                //         SavAcc.SETRANGE(SavAcc."Member No.", "Member No.");
                //         SavAcc.SETRANGE("Product Type", ProdFac."Loan Appraisal Account Code");
                //         IF SavAcc.FIND('-') THEN BEGIN
                //             SavAcc.CALCFIELDS(SavAcc."Balance (LCY)");
                //             //Check Minimum savings per product
                //             IF SavAcc."Balance (LCY)" < 0 THEN SavAcc."Balance (LCY)" := 0;
                //             IF (SavAcc."Balance (LCY)" + Otherdeposits) < ProdFac."Minimum Deposit Balance" THEN
                //                 //ERROR(Text011,SavAcc."Balance (LCY)",ProdFac."Minimum Deposit Balance");
                //                 IF NOT CONFIRM('The ' + SavAcc."Member No." + ' has lower deposits of ' + FORMAT(SavAcc."Balance (LCY)" + Otherdeposits) + ' less than expected of deposits of  ' + FORMAT(ProdFac."Minimum Deposit Balance")) THEN EXIT;

                //             IF "Approved Amount" > (SavAcc."Balance (LCY)" + Otherdeposits) THEN BEGIN
                //                 IF ProdFac."Repay Mode" = ProdFac."Repay Mode"::Checkoff THEN BEGIN
                //                     SavLedger.RESET;
                //                     SavLedger.SETRANGE(SavLedger."Customer No.", SavAcc."No.");
                //                     SavLedger.SETFILTER(Amount, '<%1', 0);
                //                     SavLedger.SETFILTER("Document No.", '<>OPENBAL');
                //                     SavLedger.SetFilter("Posting Date", '%1..%2', CALCDATE('-' + FORMAT(GenSetup."Boosting Maturity"), "Application Date"), "Application Date");
                //                     IF SavLedger.FIND('-') THEN BEGIN
                //                         REPEAT
                //                             //MESSAGE('Amount %1 Boost Mat %2 Boost %3 Post date %4',SavLedger.Amount,GenSetup."Boosting Maturity",GenSetup."Boosting Shares %",SavLedger."Posting Date");
                //                             //IF SavLedger."Posting Date" >= CALCDATE('-' + FORMAT(GenSetup."Boosting Maturity"), "Application Date") THEN BEGIN
                //                             IF SavLedger.Amount * -1 > SavAcc."Monthly Contribution" THEN BEGIN
                //                                 "Share Boosted Amount" := "Share Boosted Amount" + (SavLedger.Amount * -1);
                //                                 NoOfDays := "Application Date" - SavLedger."Posting Date";
                //                                 NoOfMonths := ROUND(NoOfDays / 30, 1, '>');
                //                                 IF NoOfMonths = 0 THEN
                //                                     ShareBoostComm := ShareBoostComm + (ABS(SavLedger.Amount) * 0.03)
                //                                 ELSE
                //                                     IF NoOfMonths = 1 THEN
                //                                         ShareBoostComm := ShareBoostComm + (ABS(SavLedger.Amount) * 0.03)
                //                                     ELSE
                //                                         IF NoOfMonths = 2 THEN
                //                                             ShareBoostComm := ShareBoostComm + (ABS(SavLedger.Amount) * 0.02)
                //                                         ELSE
                //                                             ShareBoostComm := ShareBoostComm + (ABS(SavLedger.Amount) * 0.01);
                //                             END;
                //                         // END;
                //                         UNTIL SavLedger.NEXT = 0;
                //                     ENd;
                //                     if "Share Boosted Amount" > 0 then
                //                         Message('Deposit Lumpsum');
                //                     BCommBuffer.RESET;
                //                     BCommBuffer.SETRANGE(BCommBuffer."Loan No.", rec."Loan No.");
                //                     if BCommBuffer.FindFirst() then
                //                         BCommBuffer.DELETEALL;

                //                     BStartDate := CALCDATE('-' + FORMAT(GenSetup."Boosting Maturity") + '-CM', "Application Date");

                //                     BPeriod[3] := "Application Date";
                //                     BPeriod[2] := CALCDATE('-1M+CM', "Application Date");
                //                     BPeriod[1] := CALCDATE('-2M+CM', "Application Date");
                //                     BRate[3] := 3;
                //                     BRate[2] := 2;
                //                     BRate[1] := 1;

                //                     DepBefore := 0;
                //                     DepAcc.RESET;
                //                     DepAcc.SETRANGE("No.", SavAcc."No.");
                //                     DepAcc.SETFILTER("Date Filter", '..%1', CALCDATE('-1M+CM', BPeriod[1]));
                //                     IF DepAcc.FINDFIRST THEN BEGIN
                //                         DepAcc.CALCFIELDS("Balance (LCY)");
                //                         DepBefore := DepAcc."Balance (LCY)";
                //                         CurrDep := DepBefore;
                //                         ExpDep := DepBefore;
                //                     END;
                //                     FOR InitLoop := 1 TO 3 DO BEGIN

                //                         SavLedger.RESET;
                //                         SavLedger.SETRANGE(SavLedger."Customer No.", SavAcc."No.");
                //                         SavLedger.SETFILTER("Document No.", '<>OPENBAL');
                //                         SavLedger.SETRANGE("Posting Date", CALCDATE('-CM', BPeriod[InitLoop]), BPeriod[InitLoop]);
                //                         IF SavLedger.FIND('-') THEN BEGIN
                //                             SavLedger.CALCSUMS("Amount (LCY)");
                //                             MDep := SavLedger."Amount (LCY)" * -1;
                //                             IF MDep < 0 THEN
                //                                 MDep := 0;
                //                             BCommBuffer.Reset();
                //                             BCommBuffer.SetRange("Loan No.", Rec."Loan No.");
                //                             if BCommBuffer.FindFirst() then begin
                //                                 BCommBuffer.Delete();
                //                             end;
                //                             BCommBuffer.INIT;
                //                             BCommBuffer."Loan No." := "Loan No.";
                //                             BCommBuffer.Date := BPeriod[InitLoop];
                //                             BCommBuffer."Deposit Amount" := MDep;
                //                             BCommBuffer."Expected Amount" := SavAcc."Monthly Contribution";
                //                             BCommBuffer."Boosted Amount" := BCommBuffer."Deposit Amount" - BCommBuffer."Expected Amount";

                //                             IF BCommBuffer."Boosted Amount" < 0 THEN
                //                                 BCommBuffer."Boosted Amount" := 0;

                //                             BCommBuffer.Commission := ROUND(BCommBuffer."Boosted Amount" * BRate[InitLoop] / 100);

                //                             ExpDep += BCommBuffer."Expected Amount";
                //                             CurrDep += BCommBuffer."Deposit Amount";

                //                             BCommBuffer."Total Expected" := ExpDep;
                //                             BCommBuffer."Total Current" := CurrDep;

                //                             IF BCommBuffer."Boosted Amount" > 0 THEN
                //                                 DepBefore += BCommBuffer."Expected Amount"
                //                             ELSE
                //                                 DepBefore += BCommBuffer."Deposit Amount";

                //                             BCommBuffer.INSERT;

                //                         END;

                //                     END;


                //                     BCommBuffer.RESET;
                //                     BCommBuffer.SETRANGE("Loan No.", "Loan No.");
                //                     IF BCommBuffer.FINDFIRST THEN BEGIN
                //                         BCommBuffer.CALCSUMS(Commission);
                //                         ShareBoostComm := BCommBuffer.Commission;
                //                     END;

                //                     IF DepBefore * ProdFac."Ordinary Deposits Multiplier" > "Approved Amount" THEN
                //                         ShareBoostComm := 0;
                //                 END;
                //             END;
                //         end;

                //     end;
                // end;
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                LoanApp.SetRange(LoanApp."Source Unit", LoanApp."Source Unit"::BOSA);
                LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields("Total Loan Balance", "Outstanding Balance", "Outstanding Interest");
                    if LoanApp."Total Loan Balance" > 0 then begin
                        LoansTopup.Reset;
                        LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                        LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                        if LoansTopup.Find('-') then begin
                            GlobalFu.ValidateTopup(Rec."Approved Amount", LoansTopup."Loan Top Up", LoansTopup."Loan No.");
                            if LoanSrec.Get(rec."Loan No.") then begin
                                NetAmt := LoansProcess.ComputeCharges(rec."Approved Amount", LoanSrec."Loan Product Type", LoanSrec."Loan No.", 0);
                                //MESSAGE(FORMAT(NetAmt));
                                if (LoanApp."Outstanding Balance" + LoanApp."Outstanding Interest") > Rec."Approved Amount" then
                                    Error('The Approved Amount is not sufficient to offset existing loan Balance of the same product');
                                if NetAmt <= 0 then
                                    Error('The Approved Amount is not sufficient to offset existing loan Balance of the same product');
                            end;
                        end;
                    end;

                end;

            end;
        }
        field(7; Interest; Decimal)
        {

            trigger OnValidate()
            var
                AdjustedAppDate: Date;
                AdjustedDate: Date;
                Month: integer;
                Year: integer;
            begin
                TestField("Loan Product Type");
                if ProdFac.Get("Loan Product Type") then begin
                    if ProdFac."Mortgage Loan" = false then
                        if (Interest < ProdFac."Interest Rate (Min.)") or (Interest > ProdFac."Interest Rate (Max.)") then
                            Error(InterestErrorTxt);
                end;

                // if "Approved Amount" > 0 then
                //     Validate("Approved Amount");


                //compute expected end date based on application date
                if ProdFac.Get("Loan Product Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        "Repayment Start Date" := CalcDate(ProdFac."Grace Period - Principle", "Application Date");
                        //"Repayment Start Date" := CalcDate('CM', "Repayment Start Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end else begin
                        if rec."Member Class" = 'CLASSA' then
                            "Repayment Start Date" := CalcDate('45D', "Application Date")
                        else
                            "Repayment Start Date" := CalcDate('1M', "Application Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end;
                end;


                GenSetup.Get;
                ProdFac.Get("Loan Product Type");
                if ProdFac."Mortgage Loan" = true then begin
                    if Installments <= 120 then
                        Interest := ProdFac."Interest Rate (Min.)" + GenSetup."KMRC Rate"
                    else
                        Interest := ProdFac."Interest Rate (Max.)" + GenSetup."KMRC Rate"
                end;
            end;
        }
        field(8; "Member Name"; Text[50])
        {
        }
        field(800; "Member Status"; Enum "Member Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = Field("Member No.")));
        }
        field(801; "Sub Status"; Enum "Member Status Sub Flags")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Subflag where("No." = Field("Member No.")));
        }
        field(9; "Approval Date"; Date)
        {
        }
        field(10; Installments; Integer)
        {

            trigger OnValidate()
            var
                adj: Integer;
                RetirementDate: Date;
            begin
                //  Rec."Requested Amount" := 0;
                Rec."Approved Amount" := 0;
                Rec."Amount To Disburse" := 0;
                rec."Loan Principle Repayment" := 0;
                rec."Loan Interest Repayment" := 0;
                rec.Repayment := 0;
                //Control
                if ProdFac.Get("Loan Product Type") then begin
                    if ProdFac."Mortgage Loan" = true then begin
                        if "Member No." = '' then Error('Kindly Select Member applying for this loan');
                        GenSetup.Get();
                        if Mem.Get("Member No.") then begin
                            RetirementDate := CalcDate(Format(GenSetup."Max. Member Age"), Mem."Date of Birth");

                            if Mem."Account Type" = Mem."Account Type"::"Single Member Account" then begin
                                /*ClientAge:=HRDates.DetermineAge("Retirement/Expiry Date",TODAY);
                                ClientAgePart:=COPYSTR(ClientAge,1,2);
                                ClientAgePart:=COPYSTR(ClientAge,1,2);
                                EVALUATE(ClientAgeValue,ClientAgePart);*/
                                RetirementDate := "Retirement/Expiry Date";
                                adj := Round((((RetirementDate - "Repayment Start Date") / 365) * 12), 1, '<');
                                if Installments > adj then
                                    Installments := adj
                                else
                                    Installments := Installments;
                            end;
                        end;
                        Validate("Loan Product Type");

                        Validate(Interest);
                    end;
                end;

                if ProdFac.Get("Loan Product Type") then begin
                    if Installments > ProdFac."Ordinary Default Intallments" then
                        Error(Text006, ProdFac."Ordinary Default Intallments");
                end;

            end;
        }
        field(11; "Disbursement Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            var
                AdjustedAppDate: Date;
                Month: integer;
                Year: integer;
                AdjustedDate: Date;
            begin
                "disbursement time" := time;
                if ProdFac.Get("Loan Product Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        // Apply grace period
                        "Repayment Start Date" := CalcDate(ProdFac."Grace Period - Principle", "Disbursement Date");

                        // Apply repayment start date logic based on loan application date
                        // if Date2DMY("Repayment Start Date", 1) <= 15 then
                        //     "Repayment Start Date" := CalcDate('CM', "Repayment Start Date") // End of current month
                        // else
                        //     "Repayment Start Date" := CalcDate('CM+1M', "Repayment Start Date"); // End of following month

                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");

                    end else begin
                        if rec."Member Class" = 'CLASSA' then
                            "Repayment Start Date" := CalcDate('45D', "Disbursement Date")
                        // No grace period, apply repayment start date logic
                        // if Date2DMY("Disbursement Date", 1) <= 15 then
                        //     "Repayment Start Date" := CalcDate('CM', "Disbursement Date") // End of current month
                        else
                            "Repayment Start Date" := CalcDate('1M', "Disbursement Date"); // End of following month

                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end;
                end;
            end;
        }
        field(1022; "disbursement time"; time)
        {

        }
        field(12; "Mode of Disbursement"; Option)
        {
            OptionCaption = 'Full Disbursement,Partial Disbursement';
            OptionMembers = "Full Disbursement","Partial Disbursement";

            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "Mode of Disbursement"::"Partial Disbursement" then begin
                    if "Amount To Disburse" >= "Approved Amount" then
                        Error(DisbErr);
                end else begin
                    if "Approved Amount" <> "Amount To Disburse" then
                        Error(Text002);

                    PartialDisb.Reset;
                    PartialDisb.SetRange(Posted, false);
                    PartialDisb.SetRange(PartialDisb."Loan No.", "Loan No.");
                    if PartialDisb.Find('-') then
                        PartialDisb.DeleteAll;
                end;
            end;
        }
        field(13; "Grace Period"; DateFormula)
        {
            trigger OnValidate()
            begin
                GenSetup.get();
                if Format((GenSetup."Max. Loan Grace Period")) <> '' then begin
                    if CalcDate(Rec."Grace Period", Today) > CalcDate(GenSetup."Max. Loan Grace Period", Today) then
                        Error('Maximum allowable grace period exceeded, the maximum is %1 .', GenSetup."Max. Loan Grace Period");
                end;
                Rec.validate(Installments);
            end;
        }
        field(14; "Installment Period"; DateFormula)
        {
        }
        field(15; Repayment; Decimal)
        {

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec.Repayment);
                // if ("Recovery Mode" = "Recovery Mode"::Checkoff) or ("Loan Product Type" = '133') then
                //     CheckoffAdvice.LoanCheckoffAdvice(LoanRec, Repayment, xRec.Repayment);
            end;
        }
        field(16; "Loan Product Type Name"; Text[50])
        {
            Editable = false;
        }
        field(17; Posted; Boolean)
        {
            // trigger OnValidate()
            // var
            //     LoanGuarSec: Record "Loan Guarantors and Security";
            // begin
            //     if Rec.Posted then
            //         LoanProcess.GenerateSchedule(Rec, True);

            //     // if "Source Unit" = Rec."Source Unit"::FOSA then begin
            //     //     LoanGuarSec.Reset();
            //     //     LoanGuarSec.SetRange("Loan No",Rec."Loan No.");
            //     //     if LoanGuarSec.find

            //     // end;
            // end;
        }
        field(18; "Amount To Disburse"; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            var
                VarVariant: Variant;
                // CustomApprovals: Codeunit "Custom Approvals Codeunit";
                CompInfo: Record "Company Information";
            begin

                if ("Amount To Disburse" <> "Approved Amount") then begin
                    "Mode of Disbursement" := "Mode of Disbursement"::"Partial Disbursement";
                    Modify;
                end else begin
                    if ("Amount To Disburse" = "Approved Amount") then begin
                        rec."Mode of Disbursement" := "Mode of Disbursement"::"Full Disbursement";
                        rec.Modify;
                    end;
                end;

                Rec.Validate("Mode of Disbursement");

            end;
        }
        field(19; "Fully Disbursed"; Boolean)
        {
        }
        field(20; "New Interest Rate"; Decimal)
        {
        }
        field(21; "New No. of Installment"; Integer)
        {
        }
        field(22; "New Grace Period"; DateFormula)
        {
        }
        field(23; "New Installment Period"; DateFormula)
        {
        }
        field(24; "Loan Balance at Rescheduling"; Decimal)
        {
        }
        field(25; "Loan Rescheduled"; Boolean)
        {
        }
        field(26; "Date Rescheduled"; Date)
        {
        }
        field(27; "Reschedule by"; Code[50])
        {
        }
        field(28; "Interest Calculation Method"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat,Zero Interest';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat","Zero Interest";
        }
        field(29; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(30; "Max. Installments"; Integer)
        {
        }

        field(31; "Max. Loan Amount"; Decimal)
        {
        }
        field(32; "Loan Cycle"; Integer)
        {
        }
        field(33; "Total Disbursed"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry"."Amount (LCY)" WHERE("Loan No" = FIELD("Loan No."), "Transaction Type" = const("Loan"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(34; "Repayment Start Date"; Date)
        {
        }
        field(35; "Disbursement Account No"; Code[20])
        {
            Editable = false;
        }
        field(36; "Staff No"; Code[20])
        {
            trigger OnValidate()
            begin
                if rec."Employer Code" <> '' then begin
                    Mem.Reset();
                    mem.SetRange("Employer Code", rec."Employer Code");
                    Mem.SetRange("Payroll/Staff No.", rec."Staff No");
                    if Mem.FindFirst() then
                        rec.Validate("Member No.", Mem."No.")
                    else
                        Message('Member of employer code %1 with Staff no.%2 was not found!', rec."Employer Code", rec."Staff No");
                end;
            end;
        }
        field(37; Source; Option)
        {
            OptionCaption = 'CREDIT,BANKING,MICRO';
            OptionMembers = CREDIT,BANKING,MICRO;
        }
        field(38; Remarks; Text[50])
        {
        }
        field(39; Advice; Boolean)
        {
        }
        field(40; Defaulted; Boolean)
        {
        }
        field(41; "Captured By"; Code[100])
        {
        }
        field(42; "Last Advice Date"; Date)
        {
        }
        field(43; "Advice Type"; Option)
        {
            OptionCaption = ' ,Fresh Loan,Adjustment,Reintroduction,Stoppage';
            OptionMembers = " ","Fresh Loan",Adjustment,Reintroduction,Stoppage;
        }
        field(44; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("SASRA Categorization"."Loans Category-SASRA" WHERE("Loan No." = FIELD("Loan No.")));
        }
        field(45; "Currency Code"; Code[20])
        {
        }
        field(46; "Currency Filter"; Code[10])
        {
        }
        field(47; "Appln. between Currencies"; Option)
        {
            OptionCaption = 'None,EMU,All';
            OptionMembers = "None",EMU,All;
        }
        field(48; "Expected Date of Completion"; Date)
        {
        }
        field(49; "Recovery Mode"; Enum "Loan Recovery Mode")
        {
        }
        field(50; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Bi-Annual,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,"Bi-Annual",Yearly;
        }
        field(51; Status; enum "Workflow Status Main Flags")
        {
            // OptionCaption = 'Open,Pending Approval,Approved,Rejected,Deffered,Archived,Posted';
            // OptionMembers = Open,Pending,Approved,Rejected,Deffered,Archived,Posted;
            trigger OnValidate()
            var
                LoanGua: record "Loan Guarantors and Security";
                SendM: Boolean;
                Members: record Members;
                CompInfo: Record "Company Information";
                MemberGuarantor: record Members;
                Source: enum "SMS Source";
            begin
                GlobalFunctions.DisplayLienMessage("Member No.");
                CheckExceptions;
                //SendSMSApproval()
                if (rec.Status = rec.Status::Approved) or (rec.Status = rec.Status::Rejected) then begin
                    GlobalFunctions.CommentsManagement(Rec."Loan No.");

                    userSetup.get(USERID);
                    if userSetup."Member No." = Rec."Member No." then begin
                        Error('You cannot Approve or Reject your own loan application.');
                    end;
                end;
                if (rec.Status = rec.Status::Approved) then begin
                    //Send guarantor sms
                    LoanGua.Reset;
                    LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                    LoanGua.SetRange("SMS Sent", false);
                    if LoanGua.FindFirst then begin
                        //Message('Some Messages have not been sent to the guarantors');
                        SendM := true;
                    end;
                    if SendM = true then begin
                        if Confirm('Do you wish to Send Guarantor SMS?', false) then begin
                            if Loan.Get(Rec."Loan No.") then begin
                                LoanGua.Reset;
                                LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                                LoanGua.SetRange("SMS Sent", false);
                                if LoanGua.Find('-') then begin
                                    repeat
                                        // MESSAGE(FORMAT(LoanGua."Member No"));
                                        if Members.Get(LoanGua."Member No") then begin
                                            if Members."Phone No." <> '' then begin
                                                if Loan.Posted = true then
                                                    exit;
                                                CompInfo.Get;
                                                MemberGuarantor.Get(LoanGua."Member Guaranteed");

                                                msg := 'Dear ' + MemberGuarantor."First Name" + ', You have guaranteed MNo: '
                                                + LoanGua."Member Guaranteed" + '-' + MemberGuarantor.Name + ' ' + Loan."Loan Product Type Name" + ' of KES ' +
                                                Format(Loan."Approved Amount") + '. If in dispute call' + ' ' + CompInfo."Phone No.";

                                                SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');

                                                LoanGua."SMS Sent" := true;
                                                LoanGua.Modify;
                                            end;
                                        end;
                                    until LoanGua.Next = 0;

                                    //END;
                                end;
                                // if Members.Get(Loan."Member No.") then begin
                                //     if Loan."SMS Sent" = false then begin

                                //         msg := 'You loan application of ' + ' ' + Loan."Loan Product Type Name" + ' of ' + ' Kes' + Format(Loan."Approved Amount") + ' ' + 'is being processed';

                                //         SendSMS.SendSms(Source::MBANKING, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                //     end;
                                // end;
                            end;
                        end;
                    end;
                end;
            end;

        }
        field(52; "Loan Rejection Reason"; Code[100])
        {
            TableRelation = "Exceptions/ Rejection Reason"."Exceptions/ Rejection Reason";

            trigger OnValidate()
            var
                AppraisaComme: record "Loan Appraisal Comments";
                CompanyIn: Record "Company Information";
                LoanGua: Record "Loan Guarantors and Security";
            begin
                if (Status = Rec.Status::Rejected) or (Status = Rec.Status::Deffered) then
                    Error('You cannot Reject a document in status %1', Rec.Status);
                if not Confirm('Do you Want to Reject this Loan?') then exit;
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if not AppraisaComme.FindFirst() then
                    Error('Appraisal Comments Must have a value');

                if UserSetup.Get(UpperCase(UserId)) then begin
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Responsibility Centre" := UserSetup."Responsibility Centre";
                end;
                CellNo := '';
                CompanyIn.get();
                CellNo := CompanyIn."Phone No.";
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if AppraisaComme.FindFirst() then begin
                    repeat
                        AppraisaComme.Commented := true;
                        AppraisaComme.Modify();
                    until AppraisaComme.Next() = 0;
                end;
                RejectionReason.Reset;
                RejectionReason.SetRange("Exceptions/ Rejection Reason", "Loan Rejection Reason");
                if RejectionReason.Find('-') then begin
                    if "Loan Rejection Reason" <> '' then begin
                        if Confirm('Do you want to send SMS notification to the member?', false) = true then begin
                            if Mem.Get("Member No.") then begin

                                msg := 'Your Loan application of' + ' ' + "Loan Product Type Name" + ' ' + Format("Approved Amount") + ' ' + 'has been rejected' + ': ' + RejectionReason."Exceptions/ Rejection Reason"
                                 + ' Call ' + CellNo;

                                SendSMS.SendSms(SMSSource::LOAN_APPLICATION, Mem."Phone No.", msg, Format("Disbursement Account No"), '', true, 0, false, 'CBS', "Disbursement Account No", 'CBS');
                            end;
                        end;
                        Status := Status::Rejected;
                    end;
                end;
                LoanGua.Reset();
                LoanGua.SetRange("Loan No", Rec."Loan No.");
                if LoanGua.Find('-') then begin
                    LoanGua.DeleteAll();
                end;

                "Rejected By" := UserId;
                Rec.Modify(true);
            end;
        }
        field(53; "Recommended Amount"; Decimal)
        {
        }
        field(54; "Responsibility Center"; Code[20])
        {
            Editable = false;
        }
        field(55; "Loan Account"; Code[20])
        {
            Editable = true;
        }
        field(56; "Loan Span"; Option)
        {
            OptionCaption = ' ,Minor,Major';
            OptionMembers = " ","Minor","Major";

            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Loan Span" where("Product ID" = field("Loan Product Type")));
            Editable = false;
        }
        field(57; "No. Series"; Code[20])
        {
        }
        field(58; "Outstanding Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Loan | Repayment),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
        }
        field(59; "Outstanding Interest"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            Editable = false;
        }
        field(60; "Outstanding Bills"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Bills),
                                                                  "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "All Posting through Savings Ac"; Boolean)
        {
        }
        field(62; "Loan Principle Repayment"; Decimal)
        {
        }
        field(63; "Loan Interest Repayment"; Decimal)
        {
        }
        field(64; "Employer Code"; Code[100])
        {
            TableRelation = Customer WHERE("Account Type" = CONST("Employer Code"));

            trigger OnValidate()
            begin
                "Staff No" := '';
            end;
        }
        field(65; "Compute Interest Due on Postin"; Option)
        {
            OptionCaption = ' ,Full Interest,Pro-rata,Full Period Interest';
            OptionMembers = " ","Full Interest","Pro-rata","Full Period Interest";
        }
        field(66; "Discounted Loan No."; Code[50])
        {
        }
        field(67; "Discounted Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //IF xRec."Discounted Amount">0 THEN
                //  ERROR("DiscErr:" ,xRec."Discounted Amount");

                GenSetup.Get;
                TotalDisc := 0;
                NetAmt := 0;
                ProdFac.Reset;
                ProdFac.SetRange(ProdFac."Type of Discounting", ProdFac."Type of Discounting"::"Loan Discounting");
                if ProdFac.Find('-') then begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", ProdFac."Product ID");
                    LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        repeat
                            LoanApp.CalcFields("Outstanding Balance");
                            TotalDisc := TotalDisc + LoanApp."Outstanding Balance";
                        until LoanApp.Next = 0;
                    end;
                end;

                if GenSetup."Maximum Discounting %" <= 0 then
                    Error(Text016);
                NetAmt := LoansProcess.ComputeCharges("Approved Amount", "Loan Product Type", "Loan No.", 0);
                //MESSAGE('Appr %1 Dis Amt %2 NetAmt %3 Total Disc %4',"Approved Amount","Discounted Amount",NetAmt,TotalDisc);
                if TotalDisc + "Discounted Amount" > NetAmt * GenSetup."Maximum Discounting %" * 0.01 then
                    Error(Text008, GenSetup."Maximum Discounting %");
            end;
        }
        field(68; "Share Boosted Amount"; Decimal)
        {
            // Editable = false;
            trigger OnValidate()
            begin
                // Validate("Member No.");
            end;

        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(71; "Disbursement Destination"; Option)
        {
            OptionCaption = 'FOSA Account,Other Channels';
            OptionMembers = "FOSA Account","Other Channels";

            trigger OnLookup()
            begin
                if "Disbursement Destination" = "Disbursement Destination"::"Other Channels" then
                    "All Posting through Savings Ac" := false;
            end;
        }
        field(72; "Already Suggested"; Boolean)
        {
        }
        field(73; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
        }
        field(74; "Recovered Loan"; Code[20])
        {
            Description = 'To link loan recovered from Guarantors';
        }
        field(75; "Batch No."; Code[20])
        {
            TableRelation = "Loan Disbursement Header"."No." WHERE(Status = FILTER(Open), Posted = CONST(false));
            // TableRelation = "Loan Disbursement Header"."No." WHERE(Status = FILTER(Open),
            //                                                         Posted = CONST(false)
            //                                                         "Loan Product Type" = FIELD("Loan Product Type"));

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(Text017);

                // if Batches.Get("Batch No.") then begin
                //     if Batches.Status <> Batches.Status::Open then begin
                //         if xRec."Batch No." <> "Batch No." then
                //             Error(Err005);
                //     end;
                // end;
                "Disbursement Date" := Today;
            end;
        }
        field(76; "Self Guarantee"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Self Guarantee" = true then begin
                    LoanGuara.Reset;
                    LoanGuara.SetRange(LoanGuara."Loan No", "Loan No.");
                    if LoanGuara.Find('-') then begin
                        LoanGuara.DeleteAll;
                    end;
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                    if SavAcc.Find('-') then begin
                        GenSetup.Get;
                        GenSetup.testfield("Withdrawal Fee");
                        MaxSelfGuar := 0;
                        MaxSelfGuar := LoanAppCodeunit.GetmaxSelfGuaranteeAmt(SavAcc."No.", Rec."Loan No.");
                        Message('The maximum self guarantee amount is %1', MaxSelfGuar);
                        if "Requested Amount" > MaxSelfGuar then
                            Error(Text015 + ' of %1. Kindly apply for a lower amount.', MaxSelfGuar, "Requested Amount", "Member Deposits");
                        //"Recommended Amount":=SavAcc."Balance (LCY)"*GenSetup."Self Guarantee %"*0.01;
                        //"Approved Amount":=SavAcc."Balance (LCY)"*GenSetup."Self Guarantee %"*0.01;
                        LoanGuara.Init;
                        LoanGuara."Self Guarantee" := true;
                        LoanGuara."Loan No" := "Loan No.";
                        LoanGuara."Member No" := "Member No.";
                        LoanGuara."Savings Account No./Member No." := SavAcc."No.";
                        LoanGuara.Validate(LoanGuara."Savings Account No./Member No.");
                        LoanGuara.Validate(LoanGuara."Member No");
                        LoanGuara."Deposits/Shares" := SavAcc.GetAvailableBalance(SavAcc."No.");
                        LoanGuara."Available Shares" := MaxSelfGuar;
                        if MaxSelfGuar > rec."Requested Amount" then
                            LoanGuara."Amount Guaranteed" := rec."Requested Amount"
                        else
                            LoanGuara."Amount Guaranteed" := MaxSelfGuar;
                        LoanGuara.Insert(true);
                    end
                    else
                        Error('The member does not have a BOSA savings account to be used as self guarantee!');
                end;
            end;
        }
        field(77; "Appraisal Fee"; Decimal)
        {
        }
        field(78; "Recovery Priority"; Integer)
        {
        }
        field(79; "Member Deposits"; Decimal)
        {
            Editable = false;
        }
        field(80; "Cost Value of House"; Decimal)
        {

            trigger OnValidate()
            begin
                "Amount To Disburse" := 0;
                //"Requested Amount" := 0;
                "Approved Amount" := 0;
            end;
        }
        field(81; "Retirement/Expiry Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Retirement/Expiry Date" <> 0D then begin
                    if "Retirement/Expiry Date" < Today then
                        // Error('This date cannot be less than today');
                        Message('This member is already retired');
                    "Months to Retire" := round(("Retirement/Expiry Date" - Today) / 30, 1);
                end;


                Validate(Installments);
            end;
        }
        field(82; "Three Months Payslip"; Boolean)
        {
        }
        field(83; "Mortgage Protection Policy"; Boolean)
        {
        }
        field(84; "Mortgage Protection Policy No"; Code[10])
        {
        }
        field(85; "Domestic Insurance Cover"; Boolean)
        {
        }
        field(86; "Domestic Insurance Cover No"; Code[10])
        {
        }
        field(87; "Employer Introduction Letter"; Boolean)
        {
        }
        field(88; "Six Months Bank Statement"; Boolean)
        {
        }
        field(89; "National ID"; Boolean)
        {
        }
        field(90; "KRA PIN Copy"; Boolean)
        {
        }
        field(91; "KRA PIN"; Code[20])
        {
        }
        field(92; "Vendor Letter/Sale Agreement"; Boolean)
        {
        }
        field(93; "ID No."; Code[20])
        {

            trigger OnValidate()
            begin
                TestField("Member No.");
                "ID No." := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');

                //check if ID is same of the member
                Mem.Reset;
                Mem.SetRange("No.", "Member No.");
                if Mem.Find('-') then
                    if Mem."Primary Identification" <> "ID No." then Error('ID No does not match record for member %1', "Member No.");
            end;
        }
        field(94; "Mortgage Loan"; Boolean)
        {
        }
        field(95; "Title/Lease Provided"; Boolean)
        {
        }
        field(96; "Title/Lease No"; Code[50])
        {
        }
        field(97; "Injury Benefit Insurance"; Boolean)
        {
        }
        field(98; "Drawdown Schedule"; Boolean)
        {
        }
        field(99; "Hold Installment(s)"; Boolean)
        {
        }
        field(1112; "Held Funds Comments"; text[30])
        {

        }
        field(1111; "Number Of Installment(s)"; Integer)
        {
            trigger OnValidate()
            begin
                TestField("Hold Installment(s)", true);
                TestField(Installments);
                if "Number Of Installment(s)" > Installments then
                    Error('Number of installments to hold cannot be grater than the applied installments');
            end;
        }
        field(100; "Mortgage Insurance Amount"; Decimal)
        {
        }
        field(101; "Title Lease Provide SL"; Boolean)
        {
        }
        field(102; "Lease No SL"; Code[20])
        {
        }
        field(103; "Sale Agreement"; Boolean)
        {
        }
        field(104; "ID No.SL"; Code[10])
        {
        }
        field(105; "20% Payment Slip"; Boolean)
        {
        }
        field(106; "KRA PIN No.SL"; Code[12])
        {
        }
        field(107; "Property Cost Value"; Decimal)
        {
        }
        field(108; "Land Valuation Done"; Boolean)
        {
        }
        field(109; "Title Deed"; Boolean)
        {
        }
        field(110; "Source Unit"; Enum "Source Unit")
        {
            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(111; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("Loan No.")));
        }
        field(1110; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("Loan No.")));
        }
        field(112; "Recovery Level"; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4";
        }
        field(113; "Recovery Creteria"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Recovery Creteria" where("Product ID" = field("Loan Product Type")));
            OptionMembers = " ","Guarantors and Shares","Guarantors Only","Shares Only";
            Editable = false;
        }
        field(114; "Recovery Product"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Recovery Product" where("Product ID" = field("Loan Product Type")));
            Editable = false;
        }
        field(10025; "Loan Group"; Option)
        {
            Caption = 'Loan Group';
            OptionMembers = Normal,"Group Loan";
            OptionCaption = 'Normal,Group Loan';
            FieldClass = Normal;
            Editable = true;

        }

        field(50000; "Disbursement Priority"; Integer)
        {
        }
        field(50004; "Relationship Manager"; Code[10])
        {
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active));
        }
        field(50005; "Appraisal Parameter Type"; Option)
        {
            OptionMembers = "Check Off",Salary,"Corporate or Business","Staff Loans","Hybrid";
            OptionCaption = 'Check Off,Salary,Corporate or Business,Staff Loans';
            Editable = false;
        }
        field(50006; "Employer Loan No."; Code[20])
        {
        }
        field(50007; "Client Bank Code"; Code[10])
        {
            TableRelation = "Bank Code Structure";

            trigger OnValidate()
            begin
                "Client Bank Name" := '';
                "Client Account No" := '';

                if BankCodeStructure.Get("Client Bank Code") then begin
                    "Client Bank Name" := BankCodeStructure.Name;
                end;
            end;
        }
        field(50008; "Client Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(50009; "Client Account No"; Code[20])
        {
        }
        field(50010; "External STO  Amount"; Decimal)
        {
            CalcFormula = Sum("Appraisal Salary Details".Amount WHERE("Client Code" = FIELD("Member No."),
                                                                       Type = FILTER("Other Allowances"),
                                                                       Code = FILTER('7.1EXTERNAL BANK STO'),
                                                                       "Loan No" = FIELD("Loan No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "External STO Effective Date"; Option)
        {
            OptionCaption = ' ,03rd,05th,10th,15th,20th,25th,28th';
            OptionMembers = " ","03rd","05th","10th","15th","20th","25th","28th";
        }
        field(50012; "Member Class"; Code[10])
        {
            // CalcFormula = Lookup(Members."Member Class" WHERE("No." = FIELD("Member No.")));
            // FieldClass = FlowField;
            TableRelation = "Member Classes";
        }
        field(50050; "Mobile Loan"; Boolean)
        {
        }
        field(50052; "Tpay Approved"; Boolean)
        {
        }
        field(50051; "Last Mobile Loan Rem. Date"; Date)
        {
        }
        field(50055; "Mobile Loan Reminder"; Option)
        {
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(50056; "Last Repayment Date"; Date)
        {
            CalcFormula = Max("Credit Ledger Entry"."Posting Date" WHERE("Loan No" = FIELD("Loan No."),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Transaction Type" = FILTER(Repayment | "Interest Paid"),
                                                                          Reversed = FILTER(false),
                                                                          Amount = FILTER(< 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Recovered Product Type"; Code[20])
        {
            Description = 'To link loan type recovered to Guarantors';
        }
        field(50058; "Fosa Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Disbursement Account No"),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50059; "Next Penalty Date"; Date)
        {
        }
        field(50060; Reversed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry".Reversed where("Loan No" = field("Loan No."), "Transaction Type" = filter(loan | " ")));
            Editable = false;
        }
        field(39004241; "Bank Transfer Mode"; Code[20])
        {
            TableRelation = "Bank Transfer Modes";
        }
        field(39004242; "Sales Agent"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(39004243; "Loan Linking No."; Code[20])
        {
        }
        field(39004244; "Sent Online"; Boolean)
        {
        }
        field(39004245; "CRB Rating"; Integer)
        {
        }
        field(39004246; "Purpose of Loan"; Code[200])
        {
            TableRelation = "Loan Purpose".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                ProductSet: Record "Product Factory";
            begin
                if rec."Source Unit" = Rec."Source Unit"::"HR LOANS" then begin
                    if ProductSet.get(rec."Loan Product Type") then begin
                        if ProductSet."Loan Purpose" <> '' then
                            if rec."Purpose of Loan" <> ProductSet."Loan Purpose" then
                                Error('kindly select the correct loan Purpose which is %1', ProductSet."Puporse Description");
                    end;
                end;
            end;
        }
        field(39004247; "Loan Appraised By"; Code[50])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if UserSetup.Get(UpperCase("Loan Appraised By")) then begin
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Responsibility Centre" := UserSetup."Responsibility Centre";
                end;

            end;
        }
        field(39004248; "Loan Recovery No."; Code[20])
        {
        }
        field(39004249; "SMS Sent"; Boolean)
        {
        }
        field(39004250; "Available Credit Limit"; Decimal)
        {
        }
        field(39004251; "Loan Appl.form No."; Code[50])
        {
            Editable = false;
        }
        field(39004252; "CRM Application No."; Code[50])
        {
            Editable = false;
            // TableRelation = "CRM Application"."No." WHERE("Application Type" = CONST("Loan Application"),
            //                                                Created = CONST(false),
            //                                                Case360_Docs = CONST(1),
            //                                                "Approval Status" = FILTER(Open | Deffered));

            // trigger OnValidate()
            // begin
            //     LoansApp.Reset;
            //     LoansApp.SetRange(LoansApp."CRM Application No.", "CRM Application No.");
            //     //LoansApp.SETRANGE(LoansApp.Posted,FALSE);
            //     if LoansApp.Find('-') then begin
            //         if "CRM Application No." <> '' then
            //             Error(Err002, LoansApp."Loan No.");
            //     end;

            //     CRMLoanApplication.Reset;
            //     CRMLoanApplication.SetRange(CRMLoanApplication."No.", "CRM Application No.");
            //     if CRMLoanApplication.Find('-') then begin
            //         "Loan Appl.form No." := CRMLoanApplication."Application Form No.";
            //         "CRM Captured by" := CRMLoanApplication."Captured By";
            //         //"CRM Date":=CRMLoanApplication.Date;
            //         "CRM Captured Time" := CRMLoanApplication.Date;
            //         "Member No." := CRMLoanApplication."Member No.";
            //         "Requested Amount" := CRMLoanApplication."Requested Amount";
            //         "Loan Product Type" := CRMLoanApplication."Product Factory";
            //         Validate("Member No.");
            //         Validate("Loan Product Type");
            //     end;
            // end;
        }
        field(39004253; "CRM Captured by"; Code[100])
        {
            Editable = false;
        }
        field(39004254; "CRM Date"; Date)
        {
            Editable = false;
        }
        field(39004255; "CRM Created"; Boolean)
        {
            Editable = false;
        }

        field(39004256; "Comment for Exemptions"; Text[250])
        {
        }
        field(39004257; "Total Charges and Commissions"; Decimal)
        {
        }
        field(39004258; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39004259; "Loans - Deposit Purchase"; Decimal)
        {
            Caption = 'Loans - Deposit Purchase';

            trigger OnValidate()
            begin
                IF ProdFac.Get("Loan Product Type") THEN begin
                    if ProdFac."Maximum Deposit Boost %" > 0 then begin
                        if "Loans - Deposit Purchase" >= "Member Deposits" * ProdFac."Maximum Deposit Boost %" then Error(Txt001, "Loans - Deposit Purchase", "Member Deposits", ProdFac."Maximum Deposit Boost %");
                    end;
                END;
            end;
        }
        field(39004260; "Application Time"; Time)
        {
        }
        field(39004261; "Member Segment"; Text[50])
        {
        }
        field(39004262; "Relation Officer"; Code[50])
        {
            Editable = true;
            NotBlank = true;
            Caption = 'Relation Officer';
            TableRelation = IF ("BDE Type" = FILTER(BDE)) "Marketing Teams Header"."Payroll No."
            ELSE
            "HR Employees"."No.";
        }
        field(39004263; "Loan BDE Paid"; Boolean)
        {
        }
        field(39004264; "BDE Type"; Option)
        {
            Caption = 'Relation Officer Type';
            OptionCaption = 'Sales Representative,Others';
            OptionMembers = BDE,Others;
        }
        field(39004265; "Dummy Appraisal"; Boolean)
        {
        }
        field(39004266; "Net Amount"; Decimal)
        {
        }
        field(39004267; "Picked Mobile Loan"; Boolean)
        {
            Editable = false;
        }
        field(39004268; "Repayment Method Alert"; Boolean)
        {
            Editable = false;
        }
        field(39004269; "Repayment Alert"; Boolean)
        {
            Editable = false;
        }
        field(39004270; "Non Performance Alert"; Boolean)
        {
        }
        field(39004271; "Penalty Charge"; Boolean)
        {
        }
        field(39004272; "Employer Balance"; Decimal)
        {
        }
        field(39004274; "Penalty Frequency"; Integer)
        {
        }
        field(39004275; "Total Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Loan | Repayment | "Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(39004276; "Total TopUp"; Decimal)
        {
            CalcFormula = Sum("Loans Top up"."Principle Top Up" WHERE("Loan No." = FIELD("Loan No."),
                                                                       "Client Code" = FIELD("Member No.")));
            FieldClass = FlowField;
        }
        field(39004277; "Demand Letter Status"; Option)
        {
            OptionCaption = ' ,Notice 1,Notice 2,Notice 3';
            OptionMembers = " ","Notice 1","Notice 2","Notice 3";
        }
        field(39004278; "Demand Letter Date"; Date)
        {
        }
        field(39004279; "Total Loan Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER("Interest Due" | "Interest Paid" | Loan | Repayment),
                                                                  "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(39004280; "Last Pay Date"; Date)
        {
            CalcFormula = Max("Credit Ledger Entry"."Posting Date" WHERE("Loan No" = FIELD("Loan No."),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Transaction Type" = filter(Loan | Repayment | "Interest Paid"),
                                                                          Reversed = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004281; "Mark For Listing"; Boolean)
        {
        }
        field(39004282; "Loan Amount"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Loan),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(39004283; "Interest Paid"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER("Interest Paid"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(39004284; "Principle Paid"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Repayment),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        // field(39004285; "Approved By"; Code[50])
        // {
        //     Editable = false;
        // }
        field(39004285; "Approved By"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Approval Entry"."Approver ID"
        WHERE("Document No." = FIELD("Loan No."),
              Status = CONST(Approved)));
            Editable = false;
        }
        field(39004286; "Main Sector"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level1" := '';
                "Sub Sector Level1 Description" := '';
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                if SectoralClassification.Get(rec."Main Sector") then
                    "Main Sector Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004287; "Main Sector Description"; Text[100])
        {

            Editable = false;
        }
        field(39004288; "Sub Sector Level1"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 1"), "Parent Sector" = field("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                SectoralClassification.Reset();
                if SectoralClassification.Get(rec."Sub Sector Level1") then
                    "Sub Sector Level1 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004289; "Sub Sector Level1 Description"; Text[100])
        {
            Editable = false;
        }
        field(39004290; "Sub Sector Level2"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 2"), "Parent Sector" = field("Sub Sector Level1"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if SectoralClassification.Get(rec."Sub Sector Level2") then
                    "Sub Sector Level2 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004291; "Sub Sector Level2 Description"; Text[100])
        {
            Editable = false;
        }
        field(39004292; "Posted By"; Code[50])
        {
        }
        field(39004293; "Details Verified By"; Code[50])
        {
        }
        field(39004294; "Loan Defferal Reason"; Code[100])
        {
            TableRelation = "Exceptions/ Rejection Reason"."Exceptions/ Rejection Reason";


            trigger OnValidate()
            var
                AppraisaComme: Record "Loan Appraisal Comments";
                CompanyIn: record "Company Information";
            begin
                if (Status = Rec.Status::Rejected) or (Status = Rec.Status::Deffered) then
                    Error('You cannot deffer a document in status %1', Rec.Status);
                if not Confirm('Do you Want to deffer this Loan?') then exit;
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if not AppraisaComme.FindFirst() then
                    Error('Appraisal Comments Must have a value');
                if UserSetup.Get(UpperCase(UserId)) then begin
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Responsibility Centre" := UserSetup."Responsibility Centre";
                end;
                CellNo := '';

                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    CellNo := DimensionValue."Phone No.";
                end;
                if CellNo = '' then begin
                    CompanyIn.get();
                    CellNo := CompanyIn."Phone No.";
                end;
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if AppraisaComme.FindFirst() then begin
                    repeat
                        AppraisaComme.Commented := true;
                        AppraisaComme.Modify();
                    until AppraisaComme.Next() = 0;
                end;

                RejectionReason.Reset;
                RejectionReason.SetRange("Exceptions/ Rejection Reason", "Loan Defferal Reason");
                if RejectionReason.Find('-') then begin
                    if "Loan Defferal Reason" <> '' then begin
                        if Confirm('Do you want to send SMS notification to the member?', false) = true then begin
                            if Mem.Get("Member No.") then begin

                                msg := 'Your Loan application of' + ' ' + "Loan Product Type Name" + ' ' + Format("Approved Amount") + ' ' + 'has been Deffered' + ': ' + RejectionReason."Exceptions/ Rejection Reason"
                                 + 'for more information, call ' + CellNo;

                                SendSMS.SendSms(SMSSource::LOAN_APPLICATION, Mem."Phone No.", msg, Format("Disbursement Account No"), '', true, 0, false, 'CBS', "Disbursement Account No", 'CBS');
                            end;
                        end;
                        Status := Status::Deffered;
                        Rec."Rejected By" := UserId;
                        Rec.Modify();
                    end;
                end;
            end;
        }
        field(39004295; "SAD No."; Code[50])
        {
        }
        field(39004296; "Loan Transferred"; boolean)
        {
        }
        field(39004297; "Moratorium Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(127; "Variated Amount"; Decimal)
        {
            MinValue = 100;
            //Editable = False;
            trigger
            OnValidate()
            begin
                Message('Kindly note For Armotized loans we are varying Repayment and Reducing Principal');
                if (rec."Interest Calculation Method" = rec."Interest Calculation Method"::Amortised) then begin
                    if rec."Variated Amount" < rec.Repayment then
                        Error('The variated repayment cannot be less than Repayment.');
                end
                else begin
                    if Rec."Variated Amount" < rec."Loan Principle Repayment" then Error('The variated repayment cannot be less than Loan Principle Repayment.');
                    if rec."Variated Amount" <> 0 then rec."Variated By" := UserId;
                end;
            end;
        }
        field(128; "Moratorium Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(129; "Moratorium End date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(130; "CRM Notes"; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(601; "CRM Created By"; Code[100])
        {
            Editable = false;
        }

        field(602; "CRM Originating Branch"; Code[50])
        {
            Editable = false;
        }
        field(603; "Days In Arrears"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("SASRA Categorization"."Days In Arreas" WHERE("Loan No." = FIELD("Loan No.")));
        }
        field(604; "Installments FallOff"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("SASRA Categorization"."Installments In Arrears" WHERE("Loan No." = FIELD("Loan No.")));
        }
        field(605; "Rejected By"; Text[100])
        {
            Caption = 'Rejected/Deferred By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(606; "Override Loan Qualification"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                AppraisaComme: record "Loan Appraisal Comments";
            begin
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if not AppraisaComme.FindFirst() then
                    Error('Appraisal Comments Must have a value');
            end;
        }
        field(607; "Commercial Buyoff"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec.TestField(Rec."Member No.");
                Rec.TestField(Rec."Approved Amount");
                if rec."Commercial Buyoff" = false then
                    rec."Commercial Approval" := '';
            end;
        }
        field(608; "Recover ShareCapital"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(609; "Prorata Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(610; "Member Age"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(611; "Current User"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(612; "Mwalimu Smart Callback URL"; text[1000])
        {

        }
        field(613; "WorkTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(614; "Loan Exceptions"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                AppraisaComme: record "Loan Appraisal Comments";
            begin
                AppraisaComme.Reset();
                AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                AppraisaComme.SetRange(Commented, false);
                if not AppraisaComme.FindFirst() then
                    Error('Appraisal Comments Must have a value');

            end;
        }
        field(615; "Commercial Approval"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(616; "Commercial sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(617; "Source Aplication"; Option)
        {
            OptionMembers = "BC",CRM,"Mwalimu Smart","Member Portal","Mbanking - APP","Mbanking - USSD";
            Editable = false;
            ValuesAllowed = "BC", "Member Portal", "Mbanking - APP", "Mbanking - USSD";
        }
        field(618; "Daily Interest"; Decimal)
        {
            FieldClass = flowfield;
            CalcFormula = SUM("Loans Interest Buffer"."Interest Amount" where("Loan No." = FIELD("Loan No."), Posted = const(false), "Interest Date" = FIELD("Date Filter")));
        }
        field(619; "Last Interest Run Date"; Date)
        {
            FieldClass = flowfield;
            editable = false;
            CalcFormula = max("Loans Interest Buffer"."Interest Date" where("Loan No." = FIELD("Loan No.")));
        }

        field(159; "CRM No. Series"; Code[10])
        {

        }
        field(160; "Sent Back to CRM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1600; "Sent Back to M-Smart"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(161; "Scheduled Principal"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Ideal Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan No."), "Repayment Date" = field("Date Filter")));
        }
        field(162; "Scheduled Interest"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Ideal Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan No."), "Repayment Date" = field("Date Filter")));
        }
        field(163; "Amount In Arreas SACCO"; Decimal)
        {
            Caption = 'Amount In Arreas(P+I)';
            FieldClass = FlowField;
            Editable = false;
            //Enabled = false;
            CalcFormula = Lookup("SASRA Categorization"."Amount In Arears SACCO" WHERE("Loan No." = FIELD("Loan No.")));
        }
        field(196; "Amount In Arreas SASRA"; Decimal)
        {
            Caption = 'Amount In Arreas(P)';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("SASRA Categorization"."Amount In Arears SACCO" WHERE("Loan No." = FIELD("Loan No.")));

        }
        field(168; "Repayment Bal."; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(164; "Date of join"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(165; "Date of retirement"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retirement Date';
        }
        field(166; "Date of manufacture"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ProdFac.Get(Rec."Loan Product Type") then begin
                    if ProdFac."Is a Car Loan" = true then begin
                        if (Date2DMY(Today, 3) - Date2DMY(Rec."Date of manufacture", 3)) > ProdFac."Max Second-Hand Period" then
                            Error('Date of manufacture cannot be more  than %1', ProdFac."Max Second-Hand Period");
                    end
                end;

            end;
        }
        field(167; "Digit Order"; Integer)
        {
            FieldClass = FlowField;
            Description = 'Introduced to assist in running bulk jobs in batches';
            Editable = false;
            CalcFormula = lookup(Customer."Digit Order" where("No." = field("Employer Code")));
        }

        field(169; "Principle With Guarantors"; Decimal)
        {
            Editable = false;
        }
        field(170; "Interest With Guarantors"; Decimal)
        {
            Editable = false;
        }
        field(171; "Attachmnet Reversed"; Boolean)
        {
            Editable = false;
        }

        field(180; "Member Primary Identifier Type"; Enum "Identification Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification Type" where("No." = Field("Member No.")));
        }
        field(181; "Member Primary Identifier"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = Field("Member No.")));
        }

        field(182; "TAT Period"; Duration)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                //"TAT Period" := calcdate("Application Date"-"Approval Date");
            end;

        }

        field(183; "CRM Priority"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Urgent","High","Normal";
        }
        field(185; "Document Excalated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Document Escalated';
        }
        field(186; "Actively Attached"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Recovery Header" where("Loan No." = field("Loan No."), "Header Reversed" = const(false), Action = const(Recovered)));
        }
        field(187; "Actively Attached II"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Recovery Header II" where("Loan No." = field("Loan No."), "Header Reversed" = const(false), Action = const(Recovered)));
        }
        field(188; "Out. Bal. On Attachment"; Decimal)
        {
            Editable = false;
        }
        field(189; "Out. Int. On Attachment"; Decimal)
        {
            Editable = false;
        }
        field(190; "Mortgage Exipry date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec."Mortgage Exipry date" <= Today then
                    error('Mortgage expiry date cannot be less  or equal to today');

            end;
        }
        field(191; "Residential Address"; code[100])
        {

        }

        field(192; "Mwalimu Smart Document"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "M-Smart Documents"."No." where(Status = const(Open), "Member No." = Field("Member No."));
            // ObsoleteState = Removed;
            // ObsoleteReason = 'Field is no longer required.';

            trigger OnLookup()
            var
                MSMDocRec: Record "M-Smart Documents";
            begin
                Rec.TestField("Member No.");

                MSMDocRec.Reset;
                MSMDocRec.SetRange(Status, MSMDocRec.Status::Open);
                MSMDocRec.SetRange("Member No.", Rec."Member No.");
                MSMDocRec.SetFilter("Document Type", '%1|%2', MSMDocRec."Document Type"::"LOAN APPLICATION FORM", MSMDocRec."Document Type"::"KARIBU LOAN APPLICATION FORM");

                // if Page.RunModal(Page::"M-Smart Documents List", MSMDocRec) = Action::LookupOK then begin
                //     "Mwalimu Smart Document" := MSMDocRec."No.";
                // end;
            end;
        }
        field(193; "Approval Time"; Time)
        {

        }


        field(194; "Account Profile"; Option)
        {
            OptionMembers = "Normal Member","High Profile","Politically Exposed";
            Fieldclass = flowfield;
            CalcFormula = lookup(Members."Account Profile" where("No." = field("Member No.")));
        }
        field(195; "Repayment Advised"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Checkoff Advice Line"."Amount On" where("Loan No." = field("Loan No.")));
            editable = false;

        }
        field(199; "Loanee Message"; text[100])
        {

        }
        field(200; "Application Date Time"; DateTime)
        {

        }
        field(201; "Salary Amount"; Decimal)
        {
            //Editable = false;

            trigger OnValidate()
            begin
                if "Recovery Mode" = "Recovery Mode"::Hybrid then begin
                    if "Salary Amount" = 0 then begin
                        error('Please enter salary amount!')
                    end;
                    "Checkoff Amount" := Repayment - "Salary Amount";
                    if "Checkoff Amount" < 0 then
                        "Checkoff Amount" := 0;
                    Rec.Modify();
                end;
            end;
        }
        field(203; "Checkoff Amount"; Decimal)
        {
            Editable = false;
        }
        field(204; "Installments In Arrears"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("SASRA Categorization"."Installments In Arrears" WHERE("Loan No." = FIELD("Loan No.")));
        }
        field(205; "Repayment Mode Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(206; "Variated By"; Code[100])
        {
            Editable = False;
        }
        field(207; "BOSA Deposits"; Decimal)
        {
            Caption = 'Current BOSA Deposits';
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Posting Date" = FIELD("Date Filter"), "Product Type" = const('1'), "Member No." = field("Member No.")));
            //Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(210; "Months to Retire"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(211; "Group Account No."; Code[30])
        {
            TableRelation = Members."No." where("Account Type" = filter("Group Account"));
        }

    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "CRM Application No.", "Disbursement Date")
        {
        }
        // Secondary keys for non-primary fields

        key(IdxMemberNo; "Member No.")
        {
            Clustered = false;
        }

        key(IdxLoanProductType; "Loan Product Type")
        {
            Clustered = false;
        }

        key(IdxPosted; Posted)
        {
            Clustered = false;
        }

        key(IdxApplicationDate; "Application Date")
        {
            Clustered = false;
        }

        key(IdxSource; Source)
        {
            Clustered = false;
        }

        key(IdxRecoveryMode; "Recovery Mode")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxLoanProductTypePosted; "Loan Product Type", Posted)
        {
            Clustered = false;
        }

        key(IdxMemberNoApplicationDate; "Member No.", "Application Date")
        {
            Clustered = false;
        }

        key(IdxSourceRecoveryMode; Source, "Recovery Mode")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan No.", "Loan Product Type", "Loan Product Type Name", "Outstanding Balance", "Outstanding Interest", "Days In Arrears", "Loans Category-SASRA", "Member Name")
        {

        }
    }

    trigger OnDelete()
    begin
        //if Status = Status::Approved then
        Error('A loan cannot be deleted.');
    end;

    trigger OnInsert()
    var
        SubDepartments: Enum "Sub Module";
        LoanApps: record Loans;
        theSMS: Text;
        theMember: record members;
        DepartMent: Enum "Responsibility Center Enum";

    begin

        if (Rec."Source Aplication" = Rec."Source Aplication"::CRM) or (Rec."Source Aplication" = Rec."Source Aplication"::"Mwalimu Smart") then begin
            LoanApps.Reset;

            LoanApps.SetRange("Member No.", Rec."Member No.");
            LoanApps.SetRange("Source Unit", rec."Source Unit");
            LoanApps.SetFilter(Status, '=%1|%2', Status::Open, Status::Pending);
            LoanApps.SetRange(Posted, false);

            if LoanApps.FindFirst then begin
                Error('This member already has an ongoing loan application of number %1 at status %2', LoanApps."Loan No.", LoanApps.Status);
            end;
        end;

        // -------------------------------------------------------------------------------------------------------------------------------

        if "Mobile Loan" then begin
            if ProdFac.Get("Loan Product Type") then begin
                if ProdFac."Loan Nos" <> '' then begin

                    if "Loan No." = '' then begin
                        MembNoSeries.Get;
                        "Loan No." := NoSeriesMgt.GetNextNo(ProdFac."Loan Nos");
                        // NoSeriesMgt.InitSeries(ProdFac."Loan Nos", xRec."No. Series", 0D, "Loan No.", "No. Series");
                    end;
                end
                else begin

                    if "Loan No." = '' then begin
                        MembNoSeries.Get;

                        if "Source Unit" = "Source Unit"::FOSA then begin
                            MembNoSeries.TestField(MembNoSeries."FOSA Loan Nos.");
                            "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."FOSA Loan Nos.");
                            // NoSeriesMgt.InitSeries(MembNoSeries."FOSA Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                        end else
                            if "Source Unit" = "Source Unit"::"BUSINESS LOANS" then begin
                                MembNoSeries.TestField(MembNoSeries."Business Loan Nos.");
                                "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."Business Loan Nos.");
                                // NoSeriesMgt.InitSeries(MembNoSeries."Business Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                            end else
                                if "Source Unit" = "Source Unit"::"HR LOANS" then begin
                                    MembNoSeries.TestField(MembNoSeries."HR Loan Nos.");
                                    "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."HR Loan Nos.");
                                    // NoSeriesMgt.InitSeries(MembNoSeries."HR Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                                end else begin
                                    MembNoSeries.TestField(MembNoSeries."Loan Nos.");
                                    "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."Loan Nos.");
                                    // NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                                end;

                    end;
                end;
            end;
        end
        else begin

            if "Loan No." = '' then begin
                MembNoSeries.Get;
                //MembNoSeries.TestField(MembNoSeries."Loan Nos.");
                //NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                if "Source Unit" = "Source Unit"::FOSA then begin
                    MembNoSeries.TestField(MembNoSeries."FOSA Loan Nos.");
                    "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."FOSA Loan Nos.");
                    // NoSeriesMgt.InitSeries(MembNoSeries."FOSA Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                end else
                    if "Source Unit" = "Source Unit"::"BUSINESS LOANS" then begin
                        MembNoSeries.TestField(MembNoSeries."Business Loan Nos.");
                        "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."Business Loan Nos.");
                        // NoSeriesMgt.InitSeries(MembNoSeries."Business Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                    end else
                        if "Source Unit" = "Source Unit"::"HR LOANS" then begin
                            MembNoSeries.TestField(MembNoSeries."HR Loan Nos.");
                            "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."HR Loan Nos.");
                            // NoSeriesMgt.InitSeries(MembNoSeries."HR Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                        end else begin
                            MembNoSeries.TestField(MembNoSeries."Loan Nos.");
                            "Loan No." := NoSeriesMgt.GetNextNo(MembNoSeries."Loan Nos.");
                            // NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
                        end;


                //This code is affecting disbursement date
                // if (CalcDate('-CM+15D', Today)) > Today then
                //     "Disbursement Date" := (CalcDate('-CM+15D', Today))
                // else
                //     "Disbursement Date" := (CalcDate('CM', Today));


            end;


            if UserSetup.Get(UpperCase(UserId)) then begin
                "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                "Responsibility Centre" := UserSetup."Responsibility Centre";
            end;
        end;
        IF REC."Source Unit" = rec."Source Unit"::FOSA then
            GlobalFunctions.AssignUserTasks(DepartMent::FOSA, SubDepartments::"Loan Application", Rec."Loan No.");
        IF REC."Source Unit" = rec."Source Unit"::BOSA then
            GlobalFunctions.AssignUserTasks(DepartMent::BOSA, SubDepartments::"Loan Application", Rec."Loan No.");
        // IF REC."Source Unit" = rec."Source Unit"::"BUSINESS LOANS" then
        //     GlobalFunctions.AssignUserTasks(DepartMent::BLOANS, SubDepartments::"Loan Application", Rec."Loan No.");
        IF REC."Source Unit" = rec."Source Unit"::FOSA then
            GlobalFunctions.AssignUserTasks(DepartMent::FOSA, SubDepartments::"Loan Application", Rec."Loan No.");

        "Application Date" := Today;
        "Application Time" := time;
        "Application Date Time" := CurrentDateTime;
        Advice := true;
        "All Posting through Savings Ac" := true;

        if "Captured By" = '' then begin
            "Captured By" := UpperCase(UserId);
        end;

        // CRM API
        // if "CRM Application No." <> '' then begin
        //     CRMIntegration.CRMLoanApplicationUpdate(
        //     "CRM Application No.",
        //     "Loan No.",
        //     '0',
        //     '',
        //     Format(Status),
        //     ''
        // );
        // end;


        // SMS to applicant
        theSMS := 'Dear applicant, your loan application request has been received successfully and is being processed. REF ' + "Loan No.";

        theMember.Reset;
        theMember.SetRange("No.", "Member No.");

        if theMember.findfirst then begin
            // if theSMS <> '' then begin
            //     SkySMS.SendSms(
            //                     SMSSource::CRM,
            //                     theMember."Phone No.",
            //                     theSMS,
            //                     CreateGuid(),
            //                     '',
            //                     false,
            //                     0,
            //                     false,
            //                     'CBS',
            //                     "Loan No.",
            //                     'CBS'
            //                 );

            //     // EMAIL
            //     SkySendEmail.QueueOutgoingEmail(
            //         theMember."E-Mail",
            //         'Loan Application',
            //         theSMS,
            //         'TEXT',
            //         'LOAN APPLICATION',
            //         'CRM'
            //     );
            // end;
        end;

    end;

    trigger OnModify()
    var
        thisApp: Record "Loans";
        theSMS: Text;
        theMember: record members;
        Comments: Record Comments;
        MSmartCorrections: Record "M-Smart Loan Corrections";
        theMSmartDocument: Record "M-Smart Documents";
        theSkyLoanApplication: Record "Sky Channels Loan Applications";
        LoanGuar: Record "Loan Guarantors and Security";
        ProductType: Text;
        Members: Record Members;
        AppAmount: Decimal;
        CompInfo: Record "Company Information";
        SMSSOURCE: enum "SMS Source";
    begin


        if "Loan No." = UserId then
            "Dummy Appraisal" := true;

        // CRM API Updates
        thisApp.Reset();
        thisApp.SetRange("Loan No.", "Loan No.");
        thisApp.SetRange(Posted, false);

        if thisApp.FindFirst() then begin

            if thisApp.Status <> Status then begin

                if Status = Status::Approved then begin
                    "Approved By" := UserId;
                    "Approval Date" := Today;
                    "Approval Time" := Time;
                end;

                theMember.Reset;
                theMember.SetRange("No.", "Member No.");

                if theMember.findfirst then begin
                    if theSMS <> '' then begin
                        SkySMS.SendSms(
                            SMSSource::CRM,
                            theMember."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            "Loan No.",
                            'CBS'
                        );

                        // EMAIL 
                        SkySendEmail.QueueOutgoingEmail(
                            theMember."E-Mail",
                            'Loan Application',
                            theSMS,
                            'TEXT',
                            'LOAN APPLICATION',
                            'CRM'
                        );
                    end;
                end;

                // if "Mwalimu Smart Callback URL" <> '' then begin
                //     MSmartFunctions.LoanStatusChange(Rec, MSmartCorrections, true);
                // end;

                // Mwalimu Smart Document
                // theMSmartDocument.SetRange("No.", Rec."Mwalimu Smart Document");

                if theMSmartDocument.FindFirst then begin
                    case Rec.Status of
                        Rec.Status::Pending:
                            begin
                                theMSmartDocument.Status := theMSmartDocument.Status::Pending;
                                theMSmartDocument.Modify(true);
                            end;
                        Rec.Status::Approved:
                            begin
                                theMSmartDocument.Status := theMSmartDocument.Status::Approved;
                                theMSmartDocument.Modify(true);
                            end;
                        Rec.Status::Rejected:
                            begin
                                theMSmartDocument.Status := theMSmartDocument.Status::Rejected;
                                theMSmartDocument.Modify(true);
                            end;
                        Rec.Status::Open:
                            begin
                                theMSmartDocument.Status := theMSmartDocument.Status::Open;
                                theMSmartDocument.Modify(true);
                            end;
                    end;
                end;
                // Sky Channels
                theSkyLoanApplication.Reset;
                theSkyLoanApplication.SetRange("Application No.", Rec."Loan No.");

                if theSkyLoanApplication.FindFirst then begin
                    case Rec.Status of
                        Rec.Status::Open:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Open;
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Pending:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::"Pending Approval";
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Approved:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Approved;
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Deffered:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Deferred;
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Archived:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Archived;
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Posted:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Posted;
                                theSkyLoanApplication.Modify(true);
                            end;
                        Rec.Status::Rejected:
                            begin
                                theSkyLoanApplication.Status := theSkyLoanApplication.Status::Rejected;
                                theSkyLoanApplication.Modify(true);
                            end;
                    end;
                end;
            end;
        end;
    end;

    trigger OnRename()
    begin
        if Status = Status::Approved then
            Error('A loan cannot be renamed once it has been approved');
    end;



    var
        SkySMS: CodeUnit SendSms;
        DivSetup: record "Dividend SetUp";
        DividendProgression: Record "Dividend Progression";
        DivloanBal: decimal;
        LNRec: record Loans;
        SkySendEmail: Codeunit "Sky Send Email";
        MSmartFunctions: Codeunit "Mwalimu Smart Functions";
        BankCodeStructure: Record "Bank Code Structure";
        BStartDate: Date;
        BRate: array[10] of Decimal;
        BPeriod: array[10] of Date;
        DepBefore: decimal;
        CurrDep: decimal;
        ExpDep: decimal;
        InitLoop: integer;
        MDep: decimal;
        DepAcc: Record "Savings Accounts";
        EmployerProducts: Record "52187008 Employer Product Attr";
        RejectionReason: Record "Exceptions/ Rejection Reason";
        MembNoSeries: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        TargetEmployers: Record "Target Employers";
        TargetEmployersII: Record "Target Employers";
        ProdFac: Record "Product Factory";
        ProdFacDisb: Record "Product Factory";
        SavAcc: Record "Savings Accounts";
        LoanApp: Record Loans;
        Mem: Record Members;
        Credit: Record "Credit Accounts";
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        DCSUpdate: Codeunit "DCS Management";
        CheckoffAdvice: Codeunit "Periodic Activities";
        "DiscErr:": Label 'Loan is already discounted by %1';
        ShareBoostComm: Decimal;
        "Shares Boosted": Boolean;
        DimMgt: Codeunit DimensionManagement;
        "InactiveErr:": Label 'This member account is not active';
        LoanAmountErr: Label 'Amount applied for this product is not within allowed margins Min %1 Max %2';
        InstallmentsErr: Label 'Number of installments must be greater than Zero.';
        DateErr: Label 'The date is invalid. It should not be in the past';
        DisbErr: Label 'The amount to disburse cannot be greater than or equal to approved amount';
        ApprovedAmtErr: Label 'The approved amount cannot be greater than requested amount';
        AmountToDisb: Label 'Amount to disburse cannot be greater than approved amount';
        Text002: Label 'Amount to disburse must be equal to amount approved';
        CreditLedger: Record "Credit Ledger Entry";
        Text003: Label 'This member has a loan which has not be repaid %1';
        Text004: Label 'This member has a loan in arrears %1';
        ClientAge: Text;
        HRDates: Codeunit "HR Dates 2";
        Text005: Label 'This Member age is less than the limit of %1';
        ClientAgeValue: Integer;
        ClientAgePart: Text;
        ProdMinAgeText: Text;
        ProdMinAge: Integer;
        UserSetup: Record "User Setup";
        SavLedger: Record "Savings Ledger Entry";
        GenSetup: Record "General Set-Up";
        NoOfDays: Integer;
        NoOfMonths: Decimal;
        Text006: Label 'You cannot exceed the maximum installments for this product. Max. installments = %1';
        InstalmentPeriods: DateFormula;
        IntstallMentPeriodText: Text;
        RetirementInstallments: Integer;
        MemberAge: Integer;
        MaxMemberAge: Integer;
        RetirementDue: Integer;
        ProdReq: Record "Product Checklist";
        LoanReq: Record "Loan Mandatory Requirements";
        i: Integer;
        PeriodStartDate: array[6] of Date;
        StartDate: Date;
        BusinessIncome: Record "Business Income";
        BusDateFilter: Text;
        LowerDateLimit: Date;
        UpperDateLimit: Date;
        LastMonthDate: Date;
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        SavingsAccounts: Record "Savings Accounts";
        Text007: Label 'You cannot apply this product without an active Fixed Deposit';
        Err008: Label 'You cannot apply more than Amount Fixed';
        LoanHistory: Record "Loan History";
        LoanGuara: Record "Loan Guarantors and Security";
        ErrGua: Label 'You cannot self guarantee where you have guaranteed running loans';
        TotalDisc: Decimal;
        Text008: Label 'You cannot discount above %1 Percent of the approved amount';
        SalProc: Record "Salary Lines";
        EndDateSalo: Date;
        Text009: Label 'Salary Must be through the SACCO to get this loan';
        Text010: Label 'This member is from another sacco excempted from minimum membership limit';
        Text011: Label 'This member has lower deposits of %1 than expected of deposits of %2 ';
        InterestErrorTxt: Label 'Interest Rate is not within allowed range.';
        LoansProcess: Codeunit "Loans Process";
        NetAmt: Decimal;
        Text012: Label 'The applicant is a defaulter - Loan No. %1';
        LoanRec: Record "Loan Recovery Header";
        Text013: Label 'The member has a loan recocered from guarantors refference %1';
        CheckOffLines: Record "Checkoff Buffer";
        Text014: Label 'The member must be remmitting checkoff to the organization to qualify';
        Loan: Record Loans;
        Text015: Label 'The requested amount %2 is more than available deposit balance %3 for self guarantee';
        MaxSelfGuar: Decimal;
        Text016: Label 'Maximum discounting percentage allowable must be defined';
        Text017: Label 'The loan must be approved before assigning a batch';
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        LoansApp: Record Loans;
        CRMLoanApplication: Record "CRM Application";
        Err002: Label 'CRM application is already in use by Loan No. %1';
        AmortisedInt: Decimal;
        LoanProcess: Codeunit "Loans Process";
        ImageData: Record "Image Data";
        Batches: Record "Loan Disbursement Header";
        Err005: Label 'You cannot change batch no, the batch has alreay been approved';
        DimensionValue: Record "Dimension Value";
        CellNo: Code[20];
        LoansTopup: Record "Loans Top up";
        OffsetBalance: Decimal;
        SectoralClassification: Record "Sectoral Classification";
        PartialDisb: Record "Partial Disbursement Schedule";
        Txt001: Label 'Deposit Boosted Amount:%1  is greater than %1 of  member deposit %2.';
        BatchEditable: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        ShareCapAcc: Record "Savings Accounts";
        SavProducts: Record "Product Factory";

        SMSSource: Enum "SMS Source";

        msg: Text;
        CRMIntegration: Codeunit "CRM Integration";
        ProductFactory: Record "Product Factory";
        Otherdeposits: Decimal;
        OtherAppraisals: Record "Other Apprails products";
        LoanAppCodeunit: Codeunit "Loan Appraisal Codeunit";



    procedure ClearDataLoans()
    var
        AppraisalSalDetails: Record "Appraisal Salary Details";
        LoanGua: Record "Loan Guarantors and Security";
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        BusinessIncome: Record "Business Income";
        LoansTopup: Record "Loans Top up";
        ExternalComm: Record "Other Commitements Clearance";
    begin
        AppraisalSalDetails.Reset;
        AppraisalSalDetails.SetRange("Loan No", Rec."Loan No.");
        if AppraisalSalDetails.Find('-') then begin
            AppraisalSalDetails.DeleteAll;
        end;

        ExternalComm.Reset;
        ExternalComm.SetRange("Loan No.", Rec."Loan No.");
        if ExternalComm.Find('-') then
            ExternalComm.DeleteAll;

        LoansTopup.Reset;
        LoansTopup.SetRange("Loan No.", Rec."Loan No.");
        if LoansTopup.Find('-') then
            LoansTopup.DeleteAll;

        if "Picked Mobile Loan" = false then begin
            LoanGua.Reset;
            LoanGua.SetRange("Loan No", Rec."Loan No.");
            if LoanGua.Find('-') then
                LoanGua.DeleteAll;
        end;
    end;

    local procedure ClearMortgageDate()
    begin
        "Three Months Payslip" := false;
        "Mortgage Protection Policy" := false;
        "Mortgage Protection Policy No" := '';
        "Domestic Insurance Cover" := false;
        "Domestic Insurance Cover No" := '';
        "Employer Introduction Letter" := false;
        "Six Months Bank Statement" := false;
        "National ID" := false;
        "ID No." := '';
        "KRA PIN" := '';
        "KRA PIN Copy" := false;
        "Vendor Letter/Sale Agreement" := false;
        "Mortgage Insurance Amount" := 0;
        "Title/Lease Provided" := false;
        "Injury Benefit Insurance" := false;
        "Drawdown Schedule" := false;
        "Title/Lease No" := '';
    end;

    local procedure InsertLoanGuarantorsForBusinessLoans()
    var
        Guarantors: Record "Loan Guarantors and Security";
        Members: Record Members;
        ProductFactory: Record "Product Factory";
        GroupMembers: Record Members;
        BusinesDepositsAcc: Record "Savings Accounts";
    begin
        Guarantors.Reset();
        Guarantors.SetRange(Guarantors."Loan No", Rec."Loan No.");
        if Guarantors.FindFirst() then begin
            Guarantors.DeleteAll();
        end;

        if (Rec."Member No." <> '') and (Rec."Loan Product Type" <> '') then begin
            ProductFactory.Get("Loan Product Type");
            if Members.Get("Member No.") then begin
                //if (Members."Has Joined Business Loans") and (ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS") and (Members."Group Account No." <> '') then begin
                GroupMembers.Reset;
                GroupMembers.SetAutoCalcFields("Group Account No.");
                GroupMembers.SetRange("Group Account No.", rec."Group Account No.");
                Groupmembers.setfilter(Groupmembers.Subflag, '%1|%2|%3', Groupmembers.Subflag::Rejoined, Groupmembers.Subflag::"First time", Groupmembers.Subflag::"Partial withdrawn");
                // GroupMembers.SetRange("Has Joined Business Loans", true);
                // GroupMembers.SetFilter("No.", '<>%1', Members."No.");
                if GroupMembers.findset() then begin
                    repeat
                        BusinesDepositsAcc.Reset;
                        BusinesDepositsAcc.SetRange("Member No.", GroupMembers."No.");
                        BusinesDepositsAcc.SetRange("Product Category", BusinesDepositsAcc."Product Category"::"Chama Investment Account");
                        BusinesDepositsAcc.SetAutoCalcFields(BusinesDepositsAcc."Balance (LCY)");
                        BusinesDepositsAcc.setfilter("Balance (LCY)", '>0');
                        if BusinesDepositsAcc.FindFirst() then begin
                            Guarantors.Reset;
                            Guarantors.SetRange("Loan No", Rec."Loan No.");
                            Guarantors.SetRange("Savings Account No./Member No.", BusinesDepositsAcc."No.");
                            if not Guarantors.FindFirst() then begin
                                Guarantors.Init;
                                Guarantors."Loan No" := "Loan No.";
                                Guarantors.Name := GroupMembers.Name;
                                Guarantors."Loan Groups" := rec."Loan Group"::"Group Loan";
                                Guarantors."Staff/Payroll No." := GroupMembers."Payroll/Staff No.";
                                Guarantors."Phone No." := GroupMembers."Phone No.";
                                Guarantors."ID No." := GroupMembers."Primary Identification";
                                Guarantors."Amount Guaranteed" := 0;
                                Guarantors."Savings Account No./Member No." := BusinesDepositsAcc."No.";
                                Guarantors."Guarantor Type" := Guarantors."Guarantor Type"::Guarantor;
                                Guarantors.Insert;

                            end;
                        end;
                    until GroupMembers.Next() = 0;
                end;

                Guarantors.reset();
                Guarantors.SetRange("Loan No", rec."Loan No.");
                if Guarantors.findset() then begin
                    repeat
                        Guarantors.validate("Savings Account No./Member No.");
                    until Guarantors.next = 0;
                end;
                //end;
            end;
        end;
    end;

    procedure CheckExceptions()
    var
        Counter: Integer;
        Exceptions: record "Exceptions/ Rejection Reason";
        ExceptReason: text;
        ManualFlag: text;
        ExcemptProductCharges: record "Excempted Product Charges";
    begin
        if Rec."Loan Exceptions" = true then begin
            Exceptions.reset;
            Exceptions.setrange(Code, "Loan No.");
            Exceptions.setfilter("Exceptions/ Rejection Reason", '<>%1', '');
            if Exceptions.Find('-') then begin
                repeat
                    Counter += 1;
                    ManualFlag += Format(Counter) + '. ' + Exceptions."Exceptions/ Rejection Reason" + '\';


                until Exceptions.next = 0;
            end else
                ManualFlag := 'This is an exceptional Loan';

            if StrLen(ManualFlag) > 250 then ManualFlag := copystr(ManualFlag, 1, 250);
            message(ManualFlag);
        end;
        Counter := 0;
        ManualFlag := '';
        ExcemptProductCharges.Reset();
        ExcemptProductCharges.SetRange("Loan No.", "Loan No.");
        ExcemptProductCharges.setrange(Excempt, true);
        if ExcemptProductCharges.Find('-') then begin
            repeat
                Counter += 1;
                ManualFlag += Format(Counter) + '. ' + Exceptions."Exceptions/ Rejection Reason" + '\';
            until ExcemptProductCharges.next = 0;

            if StrLen(ManualFlag) > 250 then ManualFlag := copystr(ManualFlag, 1, 250);
            message(ManualFlag);
        end;

    end;



}

