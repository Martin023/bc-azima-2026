table 52186131 "Temp Loans"
{
    DrillDownPageID = "Loans List";
    LookupPageID = "Loans List";

    fields
    {
        field(1; "Loan No."; Code[50])
        {

            trigger OnValidate()
            begin
                if "Loan No." <> xRec."Loan No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Loan Nos.");
                    "No. Series" := '';

                    //Check dimensions and responsibility centre


                    "Application Date" := Today;
                    Advice := true;
                    "All Posting through Savings Ac" := true;
                    if (CalcDate('-CM+15D', Today)) > Today then
                        "Disbursement Date" := (CalcDate('-CM+15D', Today)) else
                        "Disbursement Date" := (CalcDate('CM', Today));

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

            trigger OnValidate()
            begin
                "Loan Account" := '';
                if ProdFac.Get("Loan Product Type") then begin

                    TestField("Member No.");
                    //Get age of the client

                    if Mem.Get("Member No.") then begin
                        //if from another sacco
                        // if Mem.Type <> Mem.Type::"From Other Sacco" then begin
                        //     if Mem."Group Account" = false then begin


                        //         ClientAge := HRDates.DetermineAge(Mem."Date of Birth", Today);

                        //         ClientAgePart := CopyStr(ClientAge, 1, 2);


                        //         ClientAgePart := CopyStr(ClientAge, 1, 2);

                        //         Evaluate(ClientAgeValue, ClientAgePart);

                        //         ProdMinAgeText := DelChr(Format(ProdFac."Min. Customer Age"), '=', 'Y|M');

                        //         Evaluate(ProdMinAge, ProdMinAgeText);
                        //     end;

                        //     if ProdMinAge > ClientAgeValue then
                        //         Error(Text005, ProdFac."Min. Customer Age");
                        // end else
                        //     Message(Text010);

                    end;

                    if "Dummy Appraisal" = false then begin
                        //confirm if loan exist of same type
                        LoanApp.Reset;
                        LoanApp.SetRange("Member No.", "Member No.");
                        LoanApp.SetRange(Posted, true);
                        LoanApp.SetRange("Loan Product Type", "Loan Product Type");
                        LoanApp.SetRange("Dummy Appraisal", false);
                        LoanApp.SetFilter("Outstanding Balance", '>0');
                        if LoanApp.Find('-') then begin
                            repeat
                                if ProdFac.Get("Loan Product Type") then begin
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
                        EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                        SalProc.Reset;
                        SalProc.SetRange("Account No.", "Disbursement Account No");
                        SalProc.SetRange("Posting Date", EndDateSalo, Today);
                        SalProc.SetRange(Posted, true);
                        if SalProc.Find('-') then begin
                            if SalProc.Count < ProdFac."No. of Salary Times" then
                                Error(Text009);

                            //END ELSE
                            //ERROR(Text009);//gg
                        end;
                    end;
                    /*//Ambiquity 170116
                    IF ProdFac."Repay Mode"=ProdFac."Repay Mode"::Checkoff THEN BEGIN
                      CheckOffLines.RESET;
                      CheckOffLines.SETRANGE("Member No.","Member No.");
                      IF NOT CheckOffLines.FIND('-') THEN
                        ERROR(Text014);
                    END;
                    */
                    if Credit.Get(ProdFac."Account No. Prefix" + "Member No." + ProdFac."Account No. Suffix") then
                        "Loan Account" := ProdFac."Account No. Prefix" + "Member No." + ProdFac."Account No. Suffix";
                end else begin
                    Message('This member does not  have a loan account. Kindly use create function before you proceed');
                    "Loan Account" := '';
                end;
                "Loan Product Type Name" := ProdFac."Product Description";
                "Grace Period" := ProdFac."Grace Period - Interest";
                Interest := ProdFac."Interest Rate (Min.)";
                "Grace Period" := ProdFac."Grace Period - Interest";
                "Interest Calculation Method" := ProdFac."Interest Calculation Method";
                "Loan Span" := ProdFac."Loan Span";
                Installments := ProdFac."Ordinary Default Intallments";
                "Compute Interest Due on Postin" := ProdFac."Compute Interest Due on Postin";
                "Repayment Frequency" := ProdFac."Repayment Frequency";
                "Recovery Mode" := ProdFac."Repay Mode";
                "Appraisal Parameter Type" := ProdFac."Appraisal Parameter Type";



                //Avoid multiple loan applications pending
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
                                            if LoanApp."Loan No." <> "Loan No." then
                                                Error('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.");
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

                //Fixed DepositType
                if ProdFac."Repay Mode" = ProdFac."Repay Mode"::"Fixed Deposit" then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                    SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Fixed Deposit");
                    SavingsAccounts.SetRange(SavingsAccounts."Fixed Deposit Status", SavingsAccounts."Fixed Deposit Status"::Active);
                    if not SavingsAccounts.Find('-') then begin
                        Error(Text006);
                    end;
                end;

                //Revalidate installments
                if "Approved Amount" > 0 then
                    Validate(Installments);

                Validate("Disbursement Date");

            end;
        }
        field(4; "Member No."; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                if ProdFac.Get("Loan Product Type") then
                    "Disbursement Account No" := '';
                "Loan Account" := '';
                GenSetup.Get;



                //Check loan recovered from guarantor
                LoanRec.Reset;
                LoanRec.SetRange("Member No.", "Member No.");
                LoanRec.SetFilter(Action, '<>%1', LoanRec.Action::" ");
                if LoanRec.Find('-') then begin
                    if LoanRec."Recovery Type" <> LoanRec."Recovery Type"::Reversal then
                        Error(Text012, LoanRec."No.")
                end;

                //Check if there is a loan never paid or is in arrears
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                LoanApp.SetRange(LoanApp.Posted, true);
                LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
                if LoanApp.Find('-') then begin
                    repeat

                        //Check status - sasra
                        /*LoanApp.CALCFIELDS("Loans Category-SASRA");
                        IF LoanApp."Loans Category-SASRA">GenSetup."Allowed Loan Categories" THEN
                          ERROR(Text012,LoanApp."Loan No.");*/

                        CreditLedger.Reset;
                        CreditLedger.SetRange(CreditLedger."Member No.", "Member No.");
                        CreditLedger.SetRange(CreditLedger."Transaction Type", CreditLedger."Transaction Type"::Repayment);
                        CreditLedger.SetRange(CreditLedger."Loan No", LoanApp."Loan No.");
                        if not CreditLedger.Find('-') then
                            Message(Text003, LoanApp."Loan No.");

                        LoanApp.CalcFields(LoanApp."Outstanding Bills");

                        if LoanApp."Outstanding Bills" > 0 then
                            Message(Text004, LoanApp."Loan No.");
                    until LoanApp.Next = 0;
                end;

                if Mem.Get("Member No.") then begin

                    if Mem.Status <> Mem.Status::Active then
                        if Confirm('This member is not active. Do you wish to continue with application ?', true) = false then
                            Error("InactiveErr:");
                    "Staff No" := Mem."Payroll/Staff No.";
                    "Member Name" := Mem.Name;
                    "Application Date" := Today;
                    "Employer Code" := Mem."Employer Code";
                    // "Global Dimension 1 Code":=Mem."Global Dimension 1 Code";
                    //"Global Dimension 2 Code":=Mem."Global Dimension 2 Code";
                end else
                    Error('Member does not exist');
                if ("Member No." <> '') and ("Member No." <> xRec."Member No.") then begin
                    "Loan Account" := '';
                    "Disbursement Account No" := '';
                end;

                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Loan Disbursement Account", true);
                if SavAcc.Find('-') then
                    "Disbursement Account No" := SavAcc."No."
                else
                    Error('This member does not have a savings account');



                //Update member transactions
                //DCSUpdate.UpdateMemberData("Member No.");
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    //Check Minimum savings per product
                    "Member Deposits" := SavAcc."Balance (LCY)";
                    if SavAcc."Balance (LCY)" < ProdFac."Minimum Deposit Balance" then
                        Error(Text011, SavAcc."Balance (LCY)", ProdFac."Minimum Deposit Balance");

                    SavLedger.Reset;
                    SavLedger.SetRange(SavLedger."Customer No.", SavAcc."No.");
                    if SavLedger.Find('-') then begin
                        repeat
                            // MESSAGE('Amount %1 Boost Mat %2 Boost %3 Post date %4',SavLedger.Amount,GenSetup."Boosting Maturity",GenSetup."Boosting Shares %",SavLedger."Posting Date");
                            if SavLedger."Posting Date" > CalcDate('-' + Format(GenSetup."Boosting Maturity"), "Application Date") then begin
                                if SavLedger.Amount * -1 > SavAcc."Monthly Contribution" * GenSetup."Boosting Shares %" * 0.01 then begin
                                    "Share Boosted Amount" := "Share Boosted Amount" + SavLedger.Amount;
                                    NoOfDays := "Application Date" - SavLedger."Posting Date";
                                    NoOfMonths := Round(NoOfDays / 30, 1, '>');



                                    if NoOfMonths = 0 then
                                        ShareBoostComm := ShareBoostComm + (Abs(SavLedger.Amount) * 0.03)
                                    else
                                        if NoOfMonths = 1 then
                                            ShareBoostComm := ShareBoostComm + (Abs(SavLedger.Amount) * 0.03)
                                        else
                                            if NoOfMonths = 2 then
                                                ShareBoostComm := ShareBoostComm + (Abs(SavLedger.Amount) * 0.02)
                                            else
                                                ShareBoostComm := ShareBoostComm + (Abs(SavLedger.Amount) * 0.01);
                                    //MESSAGE('Amount %1 pdate %2 Months %3 ShareBoost %4',SavLedger.Amount,SavLedger."Posting Date",NoOfMonths,ShareBoostComm );
                                end;
                            end;
                        until SavLedger.Next = 0;
                    end;

                end;
                "Share Boosted Amount" := ShareBoostComm;
                //MESSAGE('Result %1',"Share Boosted Amount");

                //Update information on personal savings
                //Historical information
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
                //For Data Migration

                //Check if member has picture and Signature
                ImageData.Reset;
                ImageData.SetRange(ImageData."Member No", "Member No.");
                if ImageData.Find('-') then begin
                    ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
                    if not ImageData.Picture.HasValue then
                        Error('Kindly capture the member photo before proceeding');
                    if not ImageData.Signature.HasValue then
                        Error('Kindly Signature sample of the member before proceeding');
                end else begin
                    Error('Kindly capture the member photo & Signature before proceeding');
                end;


                "Application Date" := Today;
                Advice := true;
                "All Posting through Savings Ac" := true;
                if (CalcDate('-CM+15D', Today)) > Today then
                    "Disbursement Date" := (CalcDate('-CM+15D', Today)) else
                    "Disbursement Date" := (CalcDate('CM', Today));

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
                                            if LoanApp."Loan No." <> "Loan No." then
                                                Error('Member already has an existing %1 application: %2 - %3', LoanApp."Loan Product Type Name", "Loan Account", LoanApp."Loan No.");
                                        end;
                                    end;
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                end;

            end;
        }
        field(5; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Loan Account" = '' then
                    "Loan Account" := LoanProcess.CreateLoanAccount("Member No.", "Loan Product Type");

                //ERROR('This member does not have a loan account. Please create before you proceed');
                if "Disbursement Account No" = '' then
                    Error('This member does not have a disbursement account. Please create before you proceed');



                "Approved Amount" := "Requested Amount";
                "Amount To Disburse" := "Requested Amount";
                Validate("Approved Amount");
                "Application Date" := Today;

                //Check maximum and minimum loan amounts

                if ProdFac.Get("Loan Product Type") then begin
                    if (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::" ") then begin
                        if ("Requested Amount" > ProdFac."Maximum Loan Amount") or ("Requested Amount" < ProdFac."Minimum Loan Amount") then
                            Error(LoanAmountErr, ProdFac."Product ID");
                    end;
                end;

                if ProdFac."No. Of Months for Appr. Saving" > 0 then begin
                    BusinessIncome.Reset;
                    BusinessIncome.SetRange(BusinessIncome."Loan No.", "Loan No.");
                    if BusinessIncome.Find('-') then
                        BusinessIncome.DeleteAll;



                    LastMonthDate := CalcDate('<-1M>', Today);

                    for i := 1 to ProdFac."No. Of Months for Appr. Saving" do begin
                        LowerDateLimit := CalcDate('<-CM>', LastMonthDate);
                        UpperDateLimit := CalcDate('<CM>', LastMonthDate);

                        SavLedger.SetCurrentKey(SavLedger."Customer No.", SavLedger."Posting Date");
                        SavLedger.SetRange(SavLedger."Customer No.", "Disbursement Account No");
                        SavLedger.SetFilter("Document No.", '<>*BC0');
                        SavLedger.SetRange(SavLedger."Posting Date", LowerDateLimit, UpperDateLimit);
                        SavLedger.CalcSums(SavLedger."Amount (LCY)");
                        SavLedger.CalcSums(SavLedger."Debit Amount (LCY)");
                        SavLedger.CalcSums(SavLedger."Credit Amount (LCY)");
                        //MESSAGE('%1',SavLedger.Amount);
                        BusinessIncome.Init;
                        BusinessIncome."Loan No." := "Loan No.";
                        BusinessIncome."Average Amount (Internal)" := SavLedger."Credit Amount (LCY)" * (ProdFac."Net Salary Multiplier %" / 100);//-SavLedger."Debit Amount (LCY)";//SavLedger.Amount*-1;
                        BusinessIncome."First Day of Current Month" := LowerDateLimit;
                        BusinessIncome."Entry No." := BusinessIncome."Entry No." + 1;
                        BusinessIncome."Total Credits (Internal)" := SavLedger."Credit Amount (LCY)";
                        BusinessIncome."Total Debits (Internal)" := 0;//SavLedger."Debit Amount (LCY)";
                        BusinessIncome.Insert;
                        LastMonthDate := CalcDate('<-1M>', UpperDateLimit);
                    end;
                end;

                //Fixed DepositType
                if ProdFac."Repay Mode" = ProdFac."Repay Mode"::"Fixed Deposit" then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                    SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Fixed Deposit");
                    SavingsAccounts.SetRange(SavingsAccounts."Fixed Deposit Status", SavingsAccounts."Fixed Deposit Status"::Active);
                    if SavingsAccounts.Find('-') then begin
                        // REPEAT
                        if "Requested Amount" > SavingsAccounts."Fixed Deposit Amount" then
                            Error(Err008);
                        //  UNTIL SavingsAccounts.NEXT=0;
                    end;
                end;
            end;
        }
        field(6; "Approved Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if ProdFac.Get("Loan Product Type") then begin
                    if (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::" ") then begin
                        if ("Requested Amount" > ProdFac."Maximum Loan Amount") or ("Requested Amount" < ProdFac."Minimum Loan Amount") then
                            Error(LoanAmountErr, ProdFac."Product ID");
                    end;
                end;

                if Installments <= 0 then
                    Error(InstallmentsErr);

                if "Approved Amount" > "Requested Amount" then
                    Error(ApprovedAmtErr);

                "Amount To Disburse" := "Approved Amount";

                //
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";

                if InterestRate <> 0 then begin
                    if "Interest Calculation Method" = "Interest Calculation Method"::Amortised then begin
                        //TESTFIELD(Interest);
                        //TESTFIELD(Installments);

                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Loan Principle Repayment" := TotalMRepay;
                        //"Qualifying Repayment" :=TotalMRepay;

                    end;


                    if "Interest Calculation Method" = "Interest Calculation Method"::"Straight Line" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := Round((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                        Repayment := LPrincipal;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Flat" then begin
                        TestField(Interest);
                        TestField(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        //AmortisedInt:=TotalMRepay*Installments-"Approved Amount";
                        LInterest := Round(((LoanAmount * Interest / 12 / 100) + (LPrincipal * Interest / 12 / 100)) / 2, 1.0, '>');
                        //LInterest:=AmortisedInt/Installments;
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                    end;
                end else begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    Repayment := LPrincipal;
                end;
            end;
        }
        field(7; Interest; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Loan Product Type");
                if ProdFac.Get("Loan Product Type") then begin
                    if (Interest < ProdFac."Interest Rate (Min.)") or (Interest > ProdFac."Interest Rate (Max.)") then
                        Error(InterestErrorTxt);
                end;

                if "Approved Amount" > 0 then
                    Validate("Approved Amount");


                //compute expected end date based on application date
                if ProdFac.Get("Loan Product Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        "Repayment Start Date" := CalcDate(ProdFac."Grace Period - Principle", "Application Date");
                        "Repayment Start Date" := CalcDate('CM', "Repayment Start Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end else begin
                        "Repayment Start Date" := CalcDate('CM', "Application Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end;
                end;
            end;
        }
        field(8; "Member Name"; Text[50])
        {
        }
        field(9; "Approval Date"; Date)
        {
        }
        field(10; Installments; Integer)
        {

            trigger OnValidate()
            begin
                //Control
                if ProdFac.Get("Loan Product Type") then begin
                    if Installments > ProdFac."Ordinary Default Intallments" then
                        Error(Text006);
                end;

                if "Approved Amount" > 0 then
                    Validate("Approved Amount");
            end;
        }
        field(11; "Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin

                //IF "Disbursement Date"<TODAY THEN
                // ERROR(DateErr);

                if ProdFac.Get("Loan Product Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        "Repayment Start Date" := CalcDate(ProdFac."Grace Period - Principle", "Disbursement Date");
                        "Repayment Start Date" := CalcDate('CM', "Repayment Start Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end else begin
                        "Repayment Start Date" := CalcDate('CM', "Disbursement Date");
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Repayment Start Date");
                    end;
                end;
            end;
        }
        field(12; "Mode of Disbursement"; Option)
        {
            OptionCaption = 'Full Disbursement,Partial Disbursement';
            OptionMembers = "Full Disbursement","Partial Disbursement";

            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "Mode of Disbursement"::"Partial Disbursement" then begin
                    if "Approved Amount" >= "Amount To Disburse" then
                        Error(DisbErr);
                end else begin
                    if "Approved Amount" <> "Amount To Disburse" then
                        Error(Text002);
                end;
            end;
        }
        field(13; "Grace Period"; DateFormula)
        {
        }
        field(14; "Installment Period"; DateFormula)
        {
        }
        field(15; Repayment; Decimal)
        {

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec.Repayment);
            end;
        }
        field(16; "Loan Product Type Name"; Text[50])
        {
            Editable = false;
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; "Amount To Disburse"; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            var
                MngExemptionsDocApprvls: Codeunit "Mngt. Routine Processes";
                VarVariant: Variant;
                // CustomApprovals: Codeunit "Custom Approvals Codeunit";
                CompInfo: Record "Company Information";
                DocExemptionsApprvls: Record "Document Exemptions Auth.";
            begin
                /*
                IF "Amount To Disburse" > "Recommended Amount" THEN BEGIN
                TESTFIELD("Comment for Exemptions");
                MngExemptionsDocApprvls.PerformExemptionsOnLoanApplic(Rec);
                AvailableCreditLimit();
                PassDocumentNo();
                EXIT;
                END;*/

                if ("Amount To Disburse" <> "Approved Amount") then begin
                    "Mode of Disbursement" := "Mode of Disbursement"::"Partial Disbursement";
                    Modify;
                end;

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
            CalcFormula = Sum("Credit Ledger Entry"."Amount (LCY)" WHERE("Loan No" = FIELD("Loan No.")));
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
        field(41; "Captured By"; Code[50])
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
            CalcFormula = Lookup("SASRA Categorization"."Loans Category-SASRA" WHERE("Loan No." = FIELD("Loan No.")));
            FieldClass = FlowField;
            //OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            //OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
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
            // OptionCaption = ' ,Checkoff,Salary,Dividend,Fixed Deposit,Internal STO, External STO,D Allowance';
            // OptionMembers = " ",Checkoff,Salary,Dividend,"Fixed Deposit","Internal STO"," External STO","D Allowance";
        }
        field(50; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Bi-Annual,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,"Bi-Annual",Yearly;
        }
        field(51; Status; Option)
        {
            OptionCaption = 'Application,Appraisal,Approved,Rejected,Deffered';
            OptionMembers = Open,Pending,Approved,Rejected,Deffered;
        }
        field(52; "Loan Rejection Reason"; Code[100])
        {
            TableRelation = "Exceptions/ Rejection Reason"."Exceptions/ Rejection Reason";

            trigger OnValidate()
            var
                msg: Text;
                SendSMS: Codeunit SendSms;
                Source: Enum "SMS Source";
            begin
                RejectionReason.Reset;
                RejectionReason.SetRange("Exceptions/ Rejection Reason", "Loan Rejection Reason");
                if RejectionReason.Find('-') then begin
                    if "Loan Rejection Reason" <> '' then begin
                        if Confirm('Do you want to send SMS notification to the member?', false) = true then begin
                            if Mem.Get("Member No.") then begin
                                msg := 'Your Loan application of' + ' ' + "Loan Product Type Name" + ' ' + Format("Approved Amount") + ' ' + 'has been rejected' + ': ' + RejectionReason."Exceptions/ Rejection Reason";

                                SendSMS.SendSms(Source::LOAN_APPLICATION, Mem."Phone No.", msg, Format(Rec."Loan No."), '', true, 0, false, 'CBS', Rec."Loan No.", 'CBS');
                            end;
                        end;
                        Status := Status::Rejected;
                    end;
                end;
            end;
        }
        field(53; "Recommended Amount"; Decimal)
        {
        }
        field(54; "Responsibility Center"; Code[20])
        {
        }
        field(55; "Loan Account"; Code[20])
        {
            Editable = true;
        }
        field(56; "Loan Span"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term';
            OptionMembers = " ","Short Term","Long Term";
        }
        field(57; "No. Series"; Code[20])
        {
        }
        field(58; "Outstanding Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Loan | Repayment),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Document No." = FIELD("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(59; "Outstanding Interest"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
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
        field(64; "Employer Code"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(65; "Compute Interest Due on Postin"; Option)
        {
            OptionCaption = ' ,Full Interest,Pro-rata';
            OptionMembers = " ","Full Interest","Pro-rata";
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
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
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
            TableRelation = "Loan Disbursement Header"."No." WHERE(Status = FILTER(Open),
                                                                    Posted = CONST(false),
                                                                    "Loan Product Type" = FIELD("Loan Product Type"));

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(Text017);

                if Batches.Get("Batch No.") then begin
                    if Batches.Status <> Batches.Status::Open then begin
                        if xRec."Batch No." <> "Batch No." then
                            Error(Err005);
                    end;
                end;
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
                end;

                //Check own balance
                SelfGuaBal := 0;
                Loan.Reset;
                Loan.SetRange(Loan."Member No.", "Member No.");
                Loan.SetRange(Loan."Self Guarantee", true);
                Loan.SetRange("Loan Span", Loan."Loan Span"::"Major");
                Loan.SetFilter(Loan."Outstanding Balance", '>0');
                if Loan.Find('-') then begin
                    Loan.CalcFields("Outstanding Balance");
                    SelfGuaBal := SelfGuaBal + Loan."Outstanding Balance";
                end;

                //Balance guaranteed loans
                BalGuara := 0;
                LoanGuara.Reset;
                LoanGuara.SetRange("Member No", "Member No.");
                LoanGuara.SetFilter("Outstanding Balance", '>0');
                if LoanGuara.Find('-') then begin
                    LoanGuara.CalcFields("Outstanding Balance");
                    BalGuara := BalGuara + LoanGuara."Amount Guaranteed";
                end;

                BalGuara := 0;
                SelfGuaBal := 0;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    GenSetup.Get;
                    MaxSelfGuar := 0;
                    MaxSelfGuar := (SavAcc."Balance (LCY)" * GenSetup."Self Guarantee %" * 0.01) - (BalGuara + SelfGuaBal);
                    if "Requested Amount" > (SavAcc."Balance (LCY)" * GenSetup."Self Guarantee %" * 0.01) - (BalGuara + SelfGuaBal) then
                        Error(Text015);
                    //"Recommended Amount":=SavAcc."Balance (LCY)"*GenSetup."Self Guarantee %"*0.01;
                    //"Approved Amount":=SavAcc."Balance (LCY)"*GenSetup."Self Guarantee %"*0.01;
                    LoanGuara.Init;
                    LoanGuara."Self Guarantee" := true;
                    LoanGuara."Loan No" := "Loan No.";
                    LoanGuara."Member No" := "Member No.";
                    LoanGuara."Savings Account No./Member No." := SavAcc."No.";
                    LoanGuara.Validate(LoanGuara."Savings Account No./Member No.");
                    LoanGuara.Validate(LoanGuara."Member No");
                    LoanGuara."Amount Guaranteed" := (SavAcc."Balance (LCY)" * GenSetup."Self Guarantee %" * 0.01) - (BalGuara + SelfGuaBal);
                    LoanGuara.Insert(true);
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
        field(50004; "Relationship Manager"; Code[10])
        {
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active));
        }
        field(50005; "Appraisal Parameter Type"; Option)
        {
            OptionMembers = "Check Off",Salary,"Corporate or Business";
        }
        field(50006; "Employer Loan No."; Code[20])
        {
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
        field(39004246; "Purpose of Loan"; Code[20])
        {
            TableRelation = "Loan Purpose".Code;
        }
        field(39004247; "Loan Appraised By"; Code[50])
        {
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
            TableRelation = "CRM Application"."No." WHERE("Application Type" = CONST("Loan Application"),
                                                           Created = CONST(false),
                                                           Case360_Docs = CONST(1),
                                                           "Approval Status" = FILTER(Open | Deffered));

            trigger OnValidate()
            begin
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."CRM Application No.", "CRM Application No.");
                //LoansApp.SETRANGE(LoansApp.Posted,FALSE);
                if LoansApp.Find('-') then begin
                    if "CRM Application No." <> '' then
                        Error(Err002, LoansApp."Loan No.");
                end;

                CRMLoanApplication.Reset;
                CRMLoanApplication.SetRange(CRMLoanApplication."No.", "CRM Application No.");
                if CRMLoanApplication.Find('-') then begin
                    "Loan Appl.form No." := CRMLoanApplication."Application Form No.";
                    "CRM Captured by" := CRMLoanApplication."Captured By";
                    //"CRM Date":=CRMLoanApplication.Date;
                    // "CRM Captured Time" := CRMLoanApplication.Date;
                    "Member No." := CRMLoanApplication."Member No.";
                    "Requested Amount" := CRMLoanApplication."Requested Amount";
                    "Loan Product Type" := CRMLoanApplication."Product Factory";
                    Validate("Member No.");
                    Validate("Loan Product Type");
                end;
            end;
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
            Caption = '<Share Boosting- Purchase>';
        }
        // field(39004260; "CRM Captured Time"; DateTime)
        // {
        // }
        field(39004261; "Member Segment"; Text[50])
        {
        }
        field(39004262; "Relation Officer"; Code[50])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = IF ("BDE Type" = FILTER(BDE)) "HR Employees"."No."
            ELSE
            "Salesperson/Purchaser".Code;
        }
        field(39004263; "Loan BDE Paid"; Boolean)
        {
        }
        field(39004264; "BDE Type"; Option)
        {
            OptionCaption = 'BDE,Others';
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
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "CRM Application No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Status = Status::Approved then
            Error('A loan cannot be deleted once it has been approved');
    end;

    trigger OnInsert()
    begin

        if "Loan No." = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Loan Nos.");
            NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");

            "Application Date" := Today;
            Advice := true;
            "All Posting through Savings Ac" := true;
            /*
            IF (CALCDATE('-CM+15D',TODAY))> TODAY THEN
           "Disbursement Date":=(CALCDATE('-CM+15D',TODAY)) ELSE
              "Disbursement Date":=(CALCDATE('CM',TODAY));
           */
            "Disbursement Date" := Today;
            "Captured By" := UpperCase(UserId);
        end;


        if UserSetup.Get(UpperCase(UserId)) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";

        end;

    end;

    trigger OnModify()
    begin
        /*
        IF ("Discounted Amount"=xRec."Discounted Amount") AND ("Employer Loan No."=xRec."Employer Loan No.")AND ("Batch No."=xRec."Batch No.")THEN BEGIN
        IF Posted THEN BEGIN
           ERROR('A loan cannot be modified once it has been posted');
        END;
        
        IF "Employer Loan No."=xRec."Employer Loan No." THEN BEGIN
        IF (Status=Status::Approved) OR (Status=Status::Pending) THEN
          ERROR('Loan is not open for modification');
         END;
        END;  //
        */
        if "Loan No." = UserId then
            "Dummy Appraisal" := true;

    end;

    trigger OnRename()
    begin
        if Status = Status::Approved then
            Error('A loan cannot be renamed once it has been approved');
    end;

    var
        RejectionReason: Record "Exceptions/ Rejection Reason";
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProdFac: Record "Product Factory";
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
        LoanAmountErr: Label 'The loan applied is not within allowed margins %1';
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
        Text006: Label 'You cannot exceed the maximum installments';
        InstalmentPeriods: DateFormula;
        IntstallMentPeriodText: Text;
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
        BalGuara: Decimal;
        SelfGuaBal: Decimal;
        Text015: Label 'The requested amount is more than availabe deposit balance for self guarantee';
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

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Loans, "Loan No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    local procedure AvailableCreditLimit()
    begin
        "Amount To Disburse" := xRec."Amount To Disburse";
    end;

    local procedure PassDocumentNo()
    var
        DocExemptionsApprvls: Record "Document Exemptions Auth.";
    begin
        /*
        DocExemptionsApprvls.RESET;
        DocExemptionsApprvls.SETRANGE("Document No.","Loan No.");
        IF DocExemptionsApprvls.FIND('-') THEN
          DocExemptionsApprvls.VALIDATE("Document No.");
          */

    end;
}

