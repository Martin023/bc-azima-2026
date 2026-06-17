codeunit 52187325 "Bulk Processing"
{

    procedure LoanListingProcessing(Loans: Record Loans; BatchNo: Code[100]; AsAt: date)
    var
        LoanListing: Record "Loan Listing Report List";
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
        TotalBalance: Decimal;
        AmountInArreas: Decimal;
        ExpectedDateOfCompletion: Date;
        Installmets: Integer;
        RepaymentStartDate: Date;
        FOSABalance: Decimal;
        BusinessDeposits: Decimal;
        LastInterestRepayment: Decimal;
        LastPrincipleRepayment: Decimal;
        ProrataAmt: Decimal;
        MemberDeposits: Decimal;
        AmuntOn: Decimal;
        AmountOff: Decimal;
        TypeOfSecurity: text;
        Securities: list of [Text];
        Security: Text;
        FutureInterest: Decimal;
        Paidprorata: Decimal;
        MemberAge: Integer;

        ProcessLoan: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;
        RepaymentSchedule: Record "Ideal Repayment Schedule";

    begin
        ProcessLoan := true;
        Saverity := Saverity::" ";
        Clear(OutstandingInterest);
        Clear(OutstandingBalance);
        Clear(TotalBalance);
        Clear(AmountInArreas);
        Clear(ExpectedDateOfCompletion);
        Clear(Installmets);
        Clear(FOSABalance);
        Clear(BusinessDeposits);
        Clear(ProrataAmt);
        Clear(MemberDeposits);
        Clear(AmuntOn);
        Clear(AmountOff);
        Clear(TypeOfSecurity);
        Clear(Security);
        Clear(FutureInterest);
        Clear(Paidprorata);



        if ProcessLoan then
            if not ProductFactory.Get(Loans."Loan Product Type") then begin
                ProcessLoan := false;
                ErrorText := 'Product ' + Loans."Loan Product Type" + ' does not exist';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Error);
            end;

        Installmets := Loans.Installments;
        if ProcessLoan then
            if (Installmets = 0) or (Installmets > 300) then begin
                Installmets := ProductFactory."Prefferential Default installm";

                if Installmets = 0 then begin
                    ErrorText := 'This loan''s installments is 0';
                    RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Error);
                    ProcessLoan := false;
                end else begin
                    ErrorText := 'This loan''s installments is 0, but we have managed to process it using the installments in the products setup';
                    RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Warning);
                end;
            end;

        if ProcessLoan then
            if Loans."Disbursement Date" = 0D then begin
                Loans."Disbursement Date" := Loans."Application Date";
                if Loans."Disbursement Date" = 0D then begin
                    ErrorText := 'This loan''s does nto have disbursement date';
                    RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Error);
                    ProcessLoan := false;
                end else begin
                    ErrorText := 'This loan''s does nto have disbursement date, we have resorted to use the application date';
                    RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Warning);
                end;
            end;

        if ProcessLoan then
            if Loans."Disbursement Date" > AsAt then begin
                ProcessLoan := false;
                ErrorText := 'Loan was applied at a later date than ' + Format(AsAt);
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Warning);
            end;

        if ProcessLoan then
            if not Members.Get(Loans."Member No.") then begin
                ErrorText := 'Member No. ' + Loans."Member No." + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Listing", Saverity::Error);
                ProcessLoan := false;
            end;

        FutureInterest := ActualSchedule.GenerateFutureInterest(Loans);

        if ProcessLoan then begin
            Loans.SetFilter("Date Filter", '..%1', AsAt);
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Amount In Arreas SACCO", "Days In Arrears", "Loans Category-SASRA", "Last Repayment Date");


            SavingLedger.Reset();
            SavingLedger.SetRange("Member No.", Loans."Member No.");
            SavingLedger.SetLoadFields("Credit Amount (LCY)");
            SavingLedger.SetRange(Reversed, false);
            SavingLedger.SetFilter("Posting Date", '..%1', AsAt);
            if SavingLedger.FindFirst() then begin
                Paidprorata := SavingLedger."Credit Amount (LCY)";
            end;

            OutstandingInterest := Loans."Outstanding Interest";
            OutstandingBalance := Loans."Outstanding Balance";
            TotalBalance := OutstandingInterest + OutstandingBalance;
            AmountInArreas := Loans."Amount In Arreas SACCO";

            RepaymentStartDate := CalcDate('1M + CM', Loans."Disbursement Date");

            ExpectedDateOfCompletion := CalcDate(Format(Installmets) + 'M + CM', RepaymentStartDate);

            SavingAcc.Reset();
            SavingAcc.SetRange("Member No.", Loans."Member No.");
            SavingAcc.SetFilter("Product Category", '=%1|=%2|=%3', SavingAcc."Product Category"::"FOSA Account", SavingAcc."Product Category"::"Business Deposits", SavingAcc."Product Category"::"BOSA Deposits");
            SavingAcc.SetLoadFields(SavingAcc.Balance, "Product Category");
            SavingLedger.SetFilter("Date Filter", '..%1', AsAt);
            if SavingAcc.Find('-') then begin
                repeat
                    SavingAcc.CalcFields(Balance);

                    if SavingAcc."Product Category" = SavingAcc."Product Category"::"FOSA Account" then begin
                        FOSABalance := SavingAcc.Balance;
                    end;
                    if SavingAcc."Product Category" = SavingAcc."Product Category"::"Business Deposits" then begin
                        BusinessDeposits := SavingAcc.Balance;
                    end;

                    if SavingAcc."Product Category" = SavingAcc."Product Category"::"BOSA Deposits" then begin
                        ProrataAmt := CustomCuesCodeunit.Prorata(SavingAcc."Member No.", SavingAcc."Product Type");
                        MemberDeposits := SavingAcc.Balance;
                    end;

                until SavingAcc.Next() = 0;
            end;

            Creditledger.Reset();
            Creditledger.SetRange("Loan No", Loans."Loan No.");
            Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::Repayment);
            Creditledger.SetLoadFields(Amount);
            Creditledger.SetRange(Reversed, false);
            Creditledger.SetFilter("Posting Date", '..%1', AsAt);
            if Creditledger.FindLast() then begin
                LastPrincipleRepayment := Creditledger.Amount;
            end;

            Creditledger.Reset();
            Creditledger.SetRange("Loan No", Loans."Loan No.");
            Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
            Creditledger.SetLoadFields(Amount);
            Creditledger.SetRange(Reversed, false);
            Creditledger.SetFilter("Posting Date", '..%1', AsAt);
            if Creditledger.FindLast() then begin
                LastInterestRepayment := Creditledger.Amount;
            end;

            Checkofline.Reset();
            Checkofline.SetRange("Loan No.", Loans."Loan No.");
            Checkofline.SetRange(Type, Checkofline.Type::Credit);
            Checkofline.SetLoadFields("Amount Off", "Amount On");
            Checkofline.SetFilter("Advice Date", '..%1', AsAt);
            if Checkofline.FindLast() then begin
                AmuntOn := Checkofline."Amount On";
                AmountOff := Checkofline."Amount Off";
            end;

            if Securities.Count > 0 then
                Securities.RemoveRange(1, Securities.Count);
            LoanGuarantorsandSecurity.Reset;
            LoanGuarantorsandSecurity.SetRange("Member No", Loans."Member No.");
            LoanGuarantorsandSecurity.SetRange("Loan No", Loans."Loan No.");
            if LoanGuarantorsandSecurity.Find('-') then begin
                repeat
                    if not Securities.Contains(Format(LoanGuarantorsandSecurity."Guarantor Type")) then
                        Securities.Add(Format(LoanGuarantorsandSecurity."Guarantor Type"));
                until LoanGuarantorsandSecurity.Next() = 0;
            end;

            foreach Security in Securities do begin
                TypeOfSecurity += Security + ' ,';
            end;

            if Members."Date of Birth" <> 0D then
                MemberAge := Round((Today - Members."Date of Birth") / 365, 1, '<');


            Clear(LoanListing);
            LoanListing.Init();
            LoanListing."Loan No" := Loans."Loan No.";
            LoanListing."Paid Prorata" := Paidprorata;
            LoanListing."Loan Status" := 'Active';
            LoanListing."Batch No" := BatchNo;
            if TotalBalance <= 0 then
                LoanListing."Loan Status" := 'Closed';
            LoanListing."Amount In Arrears" := AmountInArreas;
            LoanListing."Outstanding Installments" := GlobalFunctions.GetRemainingInstallments(Loans, AsAt);

            LoansTopup.Reset;
            LoansTopup.SetRange("Loan No.", Loans."Loan No.");
            LoansTopup.SetLoadFields("Total Top Up", "Interest Top Up", "Principle Top Up");
            if LoansTopup.Find('-') then begin
                LoansTopup.CalcSums("Total Top Up", "Interest Top Up", "Principle Top Up");
                LoanListing."Principle Toppped" := LoansTopup."Principle Top Up";
                LoanListing."Interest Topped" := LoansTopup."Interest Top Up";
            end;

            LoanListing."Disbursement Date" := Loans."Disbursement Date";
            LoanListing.Repayment := Loans.Repayment; //Recheck
            LoanListing."Relation Officer" := Loans."Relation Officer";
            if LoanListing."Relation Officer" = '' then
                LoanListing."Relation Officer" := Loans."Relationship Manager";
            LoanListing."CRM Application No" := Loans."CRM Application No.";
            LoanListing."Repayment Start Date" := RepaymentStartDate;
            LoanListing."Expected Date Of Completion" := ExpectedDateOfCompletion;
            LoanListing."FOSA Balance" := FOSABalance;
            LoanListing."Loan Principle Repayment" := Loans."Loan Principle Repayment";
            LoanListing."Loan Interest Repayment" := Loans."Loan Interest Repayment";
            LoanListing."Last Interest Repayment" := -1 * LastInterestRepayment;
            LoanListing."Last Principle Repayment" := -1 * LastPrincipleRepayment;
            LoanListing."Approval Date" := Loans."Approval Date";
            LoanListing."Application Date" := Loans."Application Date";
            LoanListing."Last Payment Date" := Loans."Last Repayment Date";
            LoanListing."SASRA Caategorization" := Loans."Loans Category-SASRA";
            LoanListing."Loan Product Type" := Loans."Loan Product Type";
            LoanListing."Loan Product Type Name" := Loans."Loan Product Type Name";
            LoanListing."Member No" := Loans."Member No.";
            LoanListing."Member Name" := Loans."Member Name";
            LoanListing.Intallments := Installmets;
            LoanListing."Requested Amount" := Loans."Requested Amount";
            if LoanListing."Requested Amount" = 0 then
                LoanListing."Requested Amount" := Loans."Approved Amount";
            if LoanListing."Requested Amount" = 0 then
                LoanListing."Requested Amount" := Loans."Amount To Disburse";

            LoanListing."Approved Amount" := Loans."Approved Amount";
            if LoanListing."Approved Amount" = 0 then
                LoanListing."Requested Amount" := Loans."Amount To Disburse";
            if LoanListing."Approved Amount" = 0 then
                LoanListing."Requested Amount" := Loans."Requested Amount";

            LoanListing."Outstanding Balance" := OutstandingBalance;
            LoanListing."Outstanding Interest" := OutstandingInterest;
            LoanListing."Principle Arrears" := AmountInArreas - OutstandingInterest;
            if LoanListing."Principle Arrears" <= 0 then
                LoanListing."Principle Arrears" := 0;
            LoanListing."Share Boosted Amount" := Loans."Share Boosted Amount";
            LoanListing."Employer Code" := Loans."Employer Code";
            if Employer.Get(Loans."Employer Code") then
                LoanListing."Employer Name" := Employer.Name;
            LoanListing."Staff No" := Loans."Staff No";
            LoanListing."Loan Appraised By" := Loans."Loan Appraised By";
            LoanListing."Posted By" := Loans."Posted By";
            LoanListing."Member Age" := MemberAge;
            LoanListing."Prorata Amount" := ProrataAmt;
            LoanListing."Main Sector Code" := Loans."Main Sector";
            LoanListing."Main Sector Name" := Loans."Main Sector Description";
            LoanListing."Sub Sector1 Code" := Loans."Sub Sector Level1";
            LoanListing."Sub Sector1 Name" := Loans."Sub Sector Level1 Description";
            LoanListing."Sub Sector2 Code" := Loans."Sub Sector Level2";
            LoanListing."Sub Sector2 Name" := Loans."Sub Sector Level2 Description";
            LoanListing."Member Deposits" := MemberDeposits;
            LoanListing."Business Loan Deposits" := BusinessDeposits;
            LoanListing."Source Unit" := Loans."Source Unit";
            LoanListing."Days In Arrears" := Loans."Days In Arrears";
            LoanListing."Amount On" := AmuntOn;
            LoanListing."Amount Off" := AmountOff;
            LoanListing."Activity Code" := Loans."Global Dimension 2 Code";
            LoanListing."Branch Code" := Loans."Global Dimension 1 Code";
            LoanListing."Type Of Security" := TypeOfSecurity;
            LoanListing."Future Interest" := FutureInterest; //Pending
            LoanListing."Position Of Lonee" := Format(Members."Account Category");
            LoanListing."Entry Date" := Today;
            LoanListing."Entry Time" := Time;

            LoanListing."Loan Interest Rate" := Loans.Interest;
            LoanListing."ID Number" := Members."Primary Identification";
            LoanListing."Total Loan Balance" := LoanListing."Outstanding Balance" + LoanListing."Outstanding Interest";
            LoanListing."Principle Plus Future Interest" := LoanListing."Outstanding Balance" + FutureInterest;
            LoanListing."Loan Amortization Type" := Loans."Interest Calculation Method";
            LoanListing."Loan Frequency" := 'Monthly';
            LoanListing."Interest Arrears" := OutstandingInterest;
            if Loans."Days In Arrears" > 0 then
                LoanListing."Months In Arrears" := Round(Loans."Days In Arrears" / 30, 1, '<');
            LoanListing."Total Expected Interest" := FutureInterest;
            LoanListing."Total Expected Principle" := LoanListing."Outstanding Balance";
            LoanListing."Member Status" := Members.Status;
            LoanListing."Member Sub-Status" := Members.Subflag;
            LoanListing.Insert(true);
        end;
    end;

    // procedure GenerateLoanFallOff(Loans: Record Loans)
    // var
    //     LoansProcess: Codeunit "Loans Process";

    //     ProcessLoan: Boolean;
    //     ErrorText: Text;
    //     Process: Enum "Bulk Errors Process";
    //     Saverity: Option " ",Warning,Error;
    // begin
    //     ProcessLoan := true;
    //     Saverity := Saverity::" ";

    //     if ProcessLoan then
    //         if not Members.Get(Loans."Member No.") then begin
    //             ErrorText := 'Member No. ' + Loans."Member No." + ' is not found';
    //             RegisterError(Loans."Loan No.", '', Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
    //             ProcessLoan := false;
    //         end;

    //     if ProcessLoan then
    //         if not ProductFactory.Get(Loans."Loan Product Type") then begin
    //             ErrorText := 'Product type. ' + Loans."Loan Product Type" + ' is not found';
    //             RegisterError(Loans."Loan No.", '', Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
    //             ProcessLoan := false;
    //         end;

    //     //Disbursement check
    //     if ProcessLoan then
    //         if Loans."Disbursement Date" = 0D then begin
    //             ErrorText := 'Product type. ' + Loans."Loan Product Type" + ' is not found';
    //             RegisterError(Loans."Loan No.", '', Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
    //             ProcessLoan := false;
    //         end;

    //     if not Customer.Get(Members."Employer Code") then begin
    //         ErrorText := 'Employer code. ' + Members."Employer Code" + ' is not found';
    //         RegisterError(Loans."Loan No.", '', Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Warning);
    //     end;

    //     if ProcessLoan then begin
    //         Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Last Repayment Date");
    //         if Loans."Outstanding Balance" + Loans."Outstanding Interest" <= 0 then
    //             ProcessLoan := false;
    //     end;

    //     if ProcessLoan then
    //         if Loans."Approved Amount" <= 0 then begin
    //             ErrorText := 'Approve amount is 0';
    //             RegisterError(Loans."Loan No.", '', Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
    //             ProcessLoan := false;
    //         end;

    //     if ProcessLoan then
    //         LoansProcess.CalculateFallOffMonths(Loans, Today);
    // end;

    procedure GenerateLoanFallOffOutPut(Loans: Record Loans; BatchNo: Code[100]; AsAt: Date)
    var
        //Fields
        ExpectedPrinciple: Decimal;
        ExpectedInterest: Decimal;
        LastPaidDate: Date;
        LastPaidAmount: Decimal;
        TotalCapitalAmountPaid: Decimal;
        TotalInterestAmountPaid: Decimal;
        RemainingInstallments: Integer;
        DaysLastPaid: Integer;


        StartDate: Date;
        EndDate: Date;
        LastTransactionNo: Integer;
        ProcessLoan: Boolean;
        ErrorText: Text;
        Saverity: Option " ",Warning,Error;
        InsertCase: Boolean;

        //Tables
        LoanFallOff: Record "Loan FallOff";
        Process: Enum "Bulk Errors Process";
        IdealSchedule: Record "Ideal Repayment Schedule";

    begin
        ProcessLoan := true;
        InsertCase := true;
        Saverity := Saverity::" ";

        StartDate := CalcDate('-CM', AsAt);
        EndDate := CalcDate('CM', AsAt);

        Creditledger.Reset();
        Creditledger.SetRange("Loan No", Loans."Loan No.");
        Creditledger.SetFilter("Transaction Type", '=%1|=%2', Creditledger."Transaction Type"::"Interest Paid", Creditledger."Transaction Type"::Repayment);
        Creditledger.SetRange("Posting Date", StartDate, AsAt);
        Creditledger.SetRange(Reversed, false);
        if Creditledger.FindFirst() then
            ProcessLoan := false;


        //Fields
        Clear(ExpectedPrinciple);
        Clear(ExpectedInterest);
        Clear(LastPaidDate);
        Clear(LastPaidAmount);
        Clear(TotalCapitalAmountPaid);
        Clear(TotalInterestAmountPaid);
        Clear(RemainingInstallments);
        Clear(DaysLastPaid);

        Clear(LastTransactionNo);

        if ProcessLoan then
            if not Members.Get(Loans."Member No.") then begin
                ErrorText := 'Member No. ' + Loans."Member No." + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
                ProcessLoan := false;
            end;

        if ProcessLoan then
            if not ProductFactory.Get(Loans."Loan Product Type") then begin
                ErrorText := 'Product type. ' + Loans."Loan Product Type" + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
                ProcessLoan := false;
            end;

        //Disbursement check
        if ProcessLoan then
            if Loans."Disbursement Date" = 0D then begin
                ErrorText := 'Product type. ' + Loans."Loan Product Type" + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
                ProcessLoan := false;
            end;

        if not Customer.Get(Members."Employer Code") then begin
            ErrorText := 'Employer code. ' + Members."Employer Code" + ' is not found';
            RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Warning);
        end;

        if ProcessLoan then begin
            Loans.SetFilter("Date Filter", '..' + Format(EndDate));
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Last Repayment Date");
            if Loans."Outstanding Balance" + Loans."Outstanding Interest" <= 0 then
                ProcessLoan := false;
        end;

        if ProcessLoan then
            if Loans."Approved Amount" <= 0 then begin
                ErrorText := 'Approve amount is 0';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Error);
                ProcessLoan := false;
            end else
                TotalCapitalAmountPaid := Loans."Approved Amount" - Loans."Outstanding Balance";

        if ProcessLoan then begin
            //Expected Principle and Interest
            IdealSchedule.Reset();
            IdealSchedule.SetFilter("Repayment Date", '>=%1', StartDate);
            IdealSchedule.SetRange("Loan No.", Loans."Loan No.");
            if IdealSchedule.FindFirst() then begin
                ExpectedPrinciple := IdealSchedule."Principal Repayment";
                ExpectedInterest := IdealSchedule."Monthly Interest";
            end else begin
                ExpectedPrinciple := Loans."Outstanding Balance";
                ExpectedInterest := Loans."Outstanding Interest";
            end;

            LastPaidDate := Loans."Last Repayment Date";

            Creditledger.Reset();
            Creditledger.SetRange("Loan No", Loans."Loan No.");
            Creditledger.SetFilter("Transaction Type", '=%1|=%2', Creditledger."Transaction Type"::"Interest Paid", Creditledger."Transaction Type"::Repayment);
            Creditledger.SetRange("Posting Date", 19000101D, AsAt);
            Creditledger.SetRange(Reversed, false);
            if Creditledger.FindLast() then begin
                LastTransactionNo := Creditledger."Transaction No.";
            end;

            if LastTransactionNo <> 0 then begin
                Creditledger.Reset();
                Creditledger.SetRange("Loan No", Loans."Loan No.");
                Creditledger.SetFilter("Transaction Type", '=%1|=%2', Creditledger."Transaction Type"::"Interest Paid", Creditledger."Transaction Type"::Repayment);
                Creditledger.SetRange(Reversed, false);
                Creditledger.SetRange("Transaction No.", LastTransactionNo);
                if Creditledger.FindLast() then begin
                    Creditledger.CalcSums("Credit Amount");
                    LastPaidAmount += Creditledger."Credit Amount";
                end;
            end;

            TotalCapitalAmountPaid := Loans."Approved Amount" - Loans."Outstanding Balance";

            Clear(Loans."Date Filter");
            Loans.SetFilter("Date Filter", '..' + Format(Today));
            Loans.CalcFields("Interest Paid");
            TotalInterestAmountPaid := Abs(Loans."Interest Paid");

            RemainingInstallments := GlobalFunctions.GetRemainingInstallments(Loans, AsAt);

            if Loans."Last Repayment Date" <> 0D then
                DaysLastPaid := Today - Loans."Last Repayment Date";


            LoanFallOff.Init();
            LoanFallOff."Batch No" := BatchNo;
            LoanFallOff."Member No" := Loans."Member No.";
            LoanFallOff."Payroll Number" := Members."Payroll/Staff No.";
            LoanFallOff."Member Name" := Members.Name;
            LoanFallOff."Employer Code" := Members."Employer Code";
            LoanFallOff."Employer Name" := Customer.Name;
            LoanFallOff."National ID" := Members."Primary Identification";
            LoanFallOff."Loan No" := Loans."Loan No.";
            LoanFallOff."Product ID" := ProductFactory."Product ID";
            LoanFallOff."Product Description" := ProductFactory."Product Description";
            LoanFallOff."Disbursed Amount" := Loans."Approved Amount";
            LoanFallOff."Disbursement Date" := Loans."Disbursement Date";
            LoanFallOff."Monthly Expected Principle" := ExpectedPrinciple;
            LoanFallOff."Monthly Expected Interest" := ExpectedInterest;
            LoanFallOff."Total Monthly Expected" := ExpectedPrinciple + ExpectedInterest;
            LoanFallOff."Last Paid Date" := LastPaidDate;
            LoanFallOff."Last Paid Amount" := LastPaidAmount;
            LoanFallOff."Principle Balance" := Loans."Outstanding Balance";
            LoanFallOff."Total Outstanding Interest" := Loans."Outstanding Interest";
            LoanFallOff."Total Outstanding Loan Balance" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
            LoanFallOff."Loan Department" := Loans."Source Unit";
            LoanFallOff."Member Status" := Members.Status;
            LoanFallOff."Member Sub Status" := Members.Subflag;
            LoanFallOff."Total Capital AmountPaid" := TotalCapitalAmountPaid;
            LoanFallOff."Total Interest Amount Paid" := TotalInterestAmountPaid;
            LoanFallOff."Remaining Installments" := RemainingInstallments;
            LoanFallOff."Expiry Date" := Loans."Expected Date of Completion";
            LoanFallOff."Day Last Paid" := DaysLastPaid;
            LoanFallOff."Branch Code" := Members."Branch Code";
            LoanFallOff.Insert(true);
            Clear(LoanFallOff);
        end;
    end;


    procedure GenerateDepositListing(Savings: Record "Savings Accounts"; AsAt: Date; BatchNo: Code[100])
    var
        ProcessAccount: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;

        DepositListing: Record "Deposit Listing";

        BalanceAsAtToday: Decimal;
        Balance: Decimal;
    begin
        ProcessAccount := true;

        ErrorText := '';
        Saverity := Saverity::" ";
        Clear(BalanceAsAtToday);

        if ProcessAccount then
            if not Members.Get(Savings."Member No.") then begin
                ErrorText := 'Member No. ' + Savings."Member No." + ' is not found';
                RegisterError(Savings."No.", BatchNo, Savings."Member No.", ErrorText, Process::"Deposit Listing", Saverity::Error);
                ProcessAccount := false;
            end;

        if not Customer.Get(Members."Employer Code") then begin
            ErrorText := 'Employer code. ' + Members."Employer Code" + ' is not found';
            RegisterError(Savings."No.", BatchNo, Savings."Member No.", ErrorText, Process::"Loan Fall Off", Saverity::Warning);
        end;

        if ProcessAccount then begin
            // Calculate Balance As At the specified date
            Savings.SetRange("Date Filter", 0D, AsAt); // Filter up to the AsAt date
            Savings.CalcFields("Balance (LCY)");
            Balance := Savings."Balance (LCY)";

            // Clear Date Filter before setting a new filter
            Clear(Savings."Date Filter");

            // Calculate Balance As At Today
            Savings.SetRange("Date Filter", 0D, Today); // Filter up to today
            Savings.CalcFields("Balance (LCY)");
            BalanceAsAtToday := Savings."Balance (LCY)";

            // Insert data into Deposit Listing
            DepositListing.Init();
            DepositListing."Batch No" := BatchNo;
            DepositListing."Account No" := Savings."No.";
            DepositListing.Name := Savings.Name;
            DepositListing."Member No." := Savings."Member No.";
            DepositListing."Product Category" := Savings."Product Category";
            DepositListing."Balance (LCY)" := Balance; // Use the calculated Balance As At
            DepositListing."Last Transacted Amount" := Savings."Last Transacted Amount";
            DepositListing."Monthly Contribution" := Savings."Monthly Contribution";
            DepositListing."Source Unit" := Savings."Source Unit";
            DepositListing.Status := Savings.Status;
            DepositListing."Member Status" := Members.Status;
            DepositListing."Member Sub Status" := Members.Subflag;
            DepositListing."Employer Code" := Members."Employer Code";
            DepositListing."Employer Name" := Customer.Name;
            DepositListing."Date Of Birth" := Members."Date of Birth";
            DepositListing."Payroll/Staff No." := Members."Payroll/Staff No.";
            DepositListing."Product Code" := Savings."Product Type";
            DepositListing."Product Name" := Savings."Product Name";
            DepositListing."Balance As At" := Balance; // Use the calculated Balance As At
            DepositListing."Current Balance" := BalanceAsAtToday; // Use the calculated Balance As At Today
            DepositListing."As At Date" := AsAt;
            DepositListing."Last Transaction Date" := Savings."Last Transaction Date";
            DepositListing."ID Number" := Members."Primary Identification";
            DepositListing.Insert(true);
        end;
    end;


    procedure GenerateCRBMonthly(Loans: Record Loans; BatchNo: Code[100])
    var
        ProcessLoan: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;



        //Columns
        Surname: Text;//Mandatory
        Forename1: Text;//Mandatory
        Forename2: Text;
        Forename3: Text;
        TradingAs: Text;
        DateofBirth: Text;//Mandatory
        ClientNo: Code[50];
        AccountNo: Code[50];//Mandatory
        OldAccountNo: Text;
        Gender: Text;//Mandatory
        Nationality: Text;//Mandatory
        MaritalStatus: Text;
        PrimaryIdentificationDocumentType: Code[50];//Mandatory
        PrimaryIdentificationDocumentNumber: Code[50];//Mandatory
        SecondaryIdentificationDocumentType: Code[50];
        SecondaryIdentificationDocumentNumber: Code[50];
        OtherIdentificationDocumentType: Code[50];
        OtherIdentificationDocumentNumber: Code[50];
        PassportCountryCode: Code[50];
        MobileTelephoneNumber: Text;
        HomeTelephoneNumber: Text;
        WorkTelephoneNumber: Text;
        PostalAdress1: Text;
        PostalAdress2: Text;
        PostalLocationTown: Text;
        PostalLocationCountry: Text;
        PostCode: Code[50];
        PhysicalAdress1: Code[100];
        PhysicalAdress2: Code[100];
        PlotNumber: Text;
        LocationTown: Text;
        LocationCoutry: Text;
        TypeOfResidency: Text;
        PinNumber: Text;
        ConsumerEmail: Text;
        EmployerName: Text;
        OccupationalIndustryType: Text;//Mandatory
        EmploymentDate: Text;
        EmploymentType: Text;
        IncomeAmount: Decimal;//Mandatory
        LendersRegisteredName: Text;//Mandatory
        LendersTradingName: Text;//Mandatory
        LendersBrachName: Code[50];//Mandatory
        LendersBrachCode: Code[50];//Mandatory
        AccountJointSingleIndicator: Text;//Mandatory
        AccountProductType: Text;//Mandatory
        DateAccountOpened: Text;//Mandatory
        InstallmentDueDate: Text;//Mandatory
        OriginalAmount: Decimal;//Mandatory
        CurrencyOfFacility: Code[10];//Mandatory
        CurrentBalInKes: Decimal;//Mandatory
        CurrentBal: Decimal;//Mandatory
        OverdueBalance: Decimal;//Mandatory
        OverdueDate: Text;
        NumberOfDaysInArrears: Integer;//Mandatory
        NumberOfInstallmentsInArrears: Integer;//Mandatory
        PrudentialRiskClassification: Text;//Mandatory
        AccountStatus: Text;//Mandatory
        AccountStatusDate: Text;//Mandatory
        AccountClossureReason: Text;
        RepaymentPeriod: Integer;//Mandatory
        DefferedPaymentDate: Text;
        DefferedPaymentAmount: Decimal;
        PaymentFrequency: Text;//Mandatory
        DisbursementDate: Text;//Mandatory
        NextInstallmentAmount: Decimal;//Mandatory
        DateOfLatestPayment: Text;
        LastPaymentAmount: Decimal;
        TypeOfSecurity: Text;//Mandatory
        GroupID: Text;

        OverDueDateDate: Date;

        //Other Variables


        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        LastTransactionNo: Integer;
        DaysInArreas: Integer;
        NextExpectedRepaymentDate: Date;
        OriginalAmntDec: Decimal;
        CRBMonthly: Record "CRB Monthly Manual";
    begin
        ProcessLoan := true;
        Saverity := Saverity::" ";

        Clear(OutInt);
        Clear(OutBal);
        Clear(TotalBal);
        Clear(LastTransactionNo);

        //Columns
        Clear(Surname);
        Clear(Forename1);
        Clear(Forename2);
        Clear(Forename3);
        Clear(TradingAs);
        Clear(DateofBirth);
        Clear(ClientNo);
        Clear(AccountNo);
        Clear(OldAccountNo);
        Clear(Gender);
        Clear(Nationality);
        Clear(MaritalStatus);
        Clear(PrimaryIdentificationDocumentType);
        Clear(PrimaryIdentificationDocumentNumber);
        Clear(SecondaryIdentificationDocumentType);
        Clear(SecondaryIdentificationDocumentNumber);
        Clear(OtherIdentificationDocumentType);
        Clear(OtherIdentificationDocumentNumber);
        Clear(PassportCountryCode);
        Clear(MobileTelephoneNumber);
        Clear(HomeTelephoneNumber);
        Clear(WorkTelephoneNumber);
        Clear(PostalAdress1);
        Clear(PostalAdress2);
        Clear(PostalLocationTown);
        Clear(PostalLocationCountry);
        Clear(PostCode);
        Clear(PhysicalAdress1);
        Clear(PhysicalAdress2);
        Clear(PlotNumber);
        Clear(LocationTown);
        Clear(LocationCoutry);
        Clear(TypeOfResidency);
        Clear(PinNumber);
        Clear(ConsumerEmail);
        Clear(EmployerName);
        Clear(OccupationalIndustryType);
        Clear(EmploymentDate);
        Clear(EmploymentType);
        Clear(IncomeAmount);
        Clear(LendersRegisteredName);
        Clear(LendersTradingName);
        Clear(LendersBrachName);
        Clear(LendersBrachCode);
        Clear(AccountJointSingleIndicator);
        Clear(AccountProductType);
        Clear(DateAccountOpened);
        Clear(InstallmentDueDate);
        Clear(OriginalAmount);
        Clear(CurrencyOfFacility);
        Clear(CurrentBalInKes);
        Clear(CurrentBal);
        Clear(OverdueBalance);
        Clear(OverdueDate);
        Clear(NumberOfDaysInArrears);
        Clear(NumberOfInstallmentsInArrears);
        Clear(PrudentialRiskClassification);
        Clear(AccountStatus);
        Clear(AccountStatusDate);
        Clear(AccountClossureReason);
        Clear(RepaymentPeriod);
        Clear(DefferedPaymentDate);
        Clear(DefferedPaymentAmount);
        Clear(PaymentFrequency);
        Clear(DisbursementDate);
        Clear(NextInstallmentAmount);
        Clear(DateOfLatestPayment);
        Clear(LastPaymentAmount);
        Clear(TypeOfSecurity);
        Clear(GroupID);

        if ProcessLoan then
            if not Members.Get(Loans."Member No.") then begin
                ErrorText := 'Member No. ' + Loans."Member No." + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"CRB Monthly", Saverity::Error);
                ProcessLoan := false;
            end;

        if Members."Date of Birth" = 0D then begin
            ErrorText := 'Member does not have date of birth';
            RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"CRB Monthly", Saverity::Warning);
        end else begin
            DateofBirth := GlobalFunctions.DateFormatCRB(Members."Date of Birth");
        end;

        if Loans."Disbursement Date" = 0D then begin
            ErrorText := 'Disbursement date does not have a value';
            RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"CRB Monthly", Saverity::Error);
            ProcessLoan := false;
        end;

        OriginalAmntDec := Loans."Approved Amount";
        if OriginalAmntDec = 0 then
            OriginalAmntDec := Loans."Requested Amount";

        if OriginalAmntDec = 0 then begin
            ErrorText := 'Approved amount and requested amount is 0';
            RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"CRB Monthly", Saverity::Error);
            ProcessLoan := false;
        end;

        if ProcessLoan then begin
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Last Repayment Date", "Days In Arrears", "Amount In Arreas SACCO");
        end;

        TotalBal := Loans."Outstanding Balance" + Loans."Outstanding Interest";

        //FROM MEMBERS TABLE
        if ProcessLoan then begin
            Surname := Members."Other Names";
            IF Surname = '' then Surname := Members."Middle Name";
            IF Surname = '' then Surname := Members."First Name";
            ForeName1 := Members."First Name";
            ForeName2 := Members."Middle Name";
            //ForeName3 := Members."Other Names";

            ClientNo := Members."No.";
            LocationTown := 'NAIROBI';
            if Customer.Get(Members."Employer Code") then
                EmployerName := Customer.Name;

            if Members.Gender = Members.Gender::Male then
                Gender := 'M';
            if Members.Gender = Members.Gender::Female then
                Gender := 'F';

            PrimaryIdentificationDocumentNumber := Members."Primary Identification";

            Creditledger.Reset();
            Creditledger.SetRange("Loan No", Loans."Loan No.");
            Creditledger.SetFilter("Transaction Type", '=%1|=%2', Creditledger."Transaction Type"::"Interest Paid", Creditledger."Transaction Type"::Repayment);
            Creditledger.SetRange(Reversed, false);
            if Creditledger.FindLast() then begin
                LastTransactionNo := Creditledger."Transaction No.";
            end;

            if LastTransactionNo <> 0 then begin
                Creditledger.Reset();
                Creditledger.SetRange("Loan No", Loans."Loan No.");
                Creditledger.SetFilter("Transaction Type", '=%1|=%2', Creditledger."Transaction Type"::"Interest Paid", Creditledger."Transaction Type"::Repayment);
                Creditledger.SetRange(Reversed, false);
                Creditledger.SetRange("Transaction No.", LastTransactionNo);
                if Creditledger.Find('-') then begin
                    Creditledger.CalcSums("Credit Amount");
                    LastPaymentAmount += Creditledger."Credit Amount";
                end;
            end;

            if LastPaymentAmount > 0 then
                LastPaymentAmount := GlobalFunctions.FormatCRBAmounts(LastPaymentAmount);

            if Loans."Last Repayment Date" <> 0D then
                DateOfLatestPayment := GlobalFunctions.DateFormatCRB(Loans."Last Repayment Date");

            //FROM LOANS TABLE
            Loans.CalcFields("Days In Arrears", "Last Repayment Date");
            AccountNo := Loans."Loan No.";

            DateAccountOpened := GlobalFunctions.DateFormatCRB(Loans."Disbursement Date");

            if Loans."Days In Arrears" > 0 then begin
                NumberOfDaysInArrears := Loans."Days In Arrears";

                OverdueBalance := GlobalFunctions.FormatCRBAmounts(Loans."Amount In Arreas SACCO");

                OverDueDateDate := CalcDate('-' + Format(NumberOfDaysInArrears, 0, '<Integer>') + 'D', Today);

                if OverDueDateDate < Loans."Disbursement Date" then begin
                    OverDueDateDate := CalcDate('1M+CM', Loans."Disbursement Date");
                    NumberOfDaysInArrears := Today - OverDueDateDate;
                end;

                OverdueDate := GlobalFunctions.DateFormatCRB(OverdueDateDate);
                InstallmentDueDate := OverdueDate;

                NextExpectedRepaymentDate := CalcDate('-' + Format(NumberOfDaysInArrears, 0, '<Integer>') + 'D', Today);

                if NextExpectedRepaymentDate < Loans."Disbursement Date" then begin
                    NextExpectedRepaymentDate := CalcDate('1M+CM', Loans."Disbursement Date");
                    InstallmentDueDate := GlobalFunctions.DateFormatCRB(NextExpectedRepaymentDate);
                    OverdueDate := GlobalFunctions.DateFormatCRB(NextExpectedRepaymentDate);
                end;

            end else begin
                InstallmentDueDate := GlobalFunctions.DateFormatCRB(CalcDate('CM', Today));
            end;



            OriginalAmount := GlobalFunctions.FormatCRBAmounts(OriginalAmntDec);

            CurrentBalInKes := GlobalFunctions.FormatCRBAmounts(TotalBal);

            CurrentBal := CurrentBalInKes;

            if NumberOfDaysInArrears > 90 then
                if Loans."Approved Amount" <= 1000 then
                    NumberOfDaysInArrears := 90;

            NumberOfInstallmentsInArrears := Round(NumberOfDaysInArrears / 30, 1, '>');

            if NumberOfDaysInArrears < 0 then begin
                NumberOfDaysInArrears := 0;
                OverdueDate := '';
                OverdueBalance := 0;
                NumberOfInstallmentsInArrears := 0;
                InstallmentDueDate := GlobalFunctions.DateFormatCRB(CalcDate('CM', Today));
                InstallmentDueDate := '';
            end;

            if (NumberOfDaysInArrears >= 0) and (NumberOfDaysInArrears <= 30) then
                PrudentialRiskClassification := 'A';
            if (NumberOfDaysInArrears > 30) and (NumberOfDaysInArrears <= 90) then
                PrudentialRiskClassification := 'B';
            if (NumberOfDaysInArrears > 90) and (NumberOfDaysInArrears <= 180) then
                PrudentialRiskClassification := 'C';
            if (NumberOfDaysInArrears > 180) and (NumberOfDaysInArrears <= 360) then
                PrudentialRiskClassification := 'D';
            if NumberOfDaysInArrears > 360 then
                PrudentialRiskClassification := 'E';

            AccountStatus := 'F';
            if loans."Loan Rescheduled" then
                AccountStatus := 'G';
            if Members.Status = Members.Status::Deceased then
                AccountStatus := 'L';

            AccountStatusDate := GlobalFunctions.DateFormatCRB(Today);
            RepaymentPeriod := Loans.Installments;

            DisbursementDate := GlobalFunctions.DateFormatCRB(Loans."Disbursement Date");

            NextInstallmentAmount := GlobalFunctions.FormatCRBAmounts(Loans.Repayment);
            TypeOfSecurity := 'U'; //To be confirmed

            Nationality := 'KE';

            if Members."Primary Identification" <> '' then begin
                if Members."Primary Identification Type" = Members."Primary Identification Type"::"ID Number" then begin
                    PrimaryIdentificationDocumentType := '001';
                    PrimaryIdentificationDocumentNumber := Members."Primary Identification";

                    if StrLen(PrimaryIdentificationDocumentNumber) = 4 then
                        PrimaryIdentificationDocumentNumber := '0' + PrimaryIdentificationDocumentNumber;
                    if StrLen(PrimaryIdentificationDocumentNumber) = 3 then
                        PrimaryIdentificationDocumentNumber := '00' + PrimaryIdentificationDocumentNumber;
                    if StrLen(PrimaryIdentificationDocumentNumber) = 2 then
                        PrimaryIdentificationDocumentNumber := '000' + PrimaryIdentificationDocumentNumber;
                end;
                if Members."Primary Identification Type" = Members."Primary Identification Type"::"Passport No" then begin
                    PrimaryIdentificationDocumentType := '002';
                    PrimaryIdentificationDocumentNumber := Members."Primary Identification";
                end;
            end;

            if PrimaryIdentificationDocumentNumber = '' then begin
                if Members."Secondary Identification" <> '' then begin
                    if Members."Secondary Identification Type" = Members."Secondary Identification Type"::"ID Number" then begin
                        PrimaryIdentificationDocumentType := '001';
                        PrimaryIdentificationDocumentNumber := Members."Secondary Identification";

                        if StrLen(PrimaryIdentificationDocumentNumber) = 4 then
                            PrimaryIdentificationDocumentNumber := '0' + PrimaryIdentificationDocumentNumber;
                        if StrLen(PrimaryIdentificationDocumentNumber) = 3 then
                            PrimaryIdentificationDocumentNumber := '00' + PrimaryIdentificationDocumentNumber;
                        if StrLen(PrimaryIdentificationDocumentNumber) = 2 then
                            PrimaryIdentificationDocumentNumber := '000' + PrimaryIdentificationDocumentNumber;
                    end;
                    if Members."Secondary Identification Type" = Members."Secondary Identification Type"::"Passport No" then begin
                        PrimaryIdentificationDocumentType := '002';
                        PrimaryIdentificationDocumentNumber := Members."Primary Identification";
                    end;
                end;
            end;

            LocationCoutry := 'KE';
            OccupationalIndustryType := '011';
            IncomeAmount := 12000000;
            LendersRegisteredName := 'KENPIE SACCO LTD';
            LendersTradingName := 'KENPIE SACCO LTD';
            LendersBrachName := 'KENPIE SACCO LTD';
            LendersBrachCode := 'N084001';

            if CopyStr(Loans."Loan Product Type", 1, 1) = 'D' then
                AccountJointSingleIndicator := 'J'
            else
                AccountJointSingleIndicator := 'S';

            if ProductFactory.Get(Loans."Loan Product Type") then
                AccountProductType := ProductFactory."CRB Product Type";
            if AccountProductType = '' then
                AccountProductType := 'H';

            CurrencyOfFacility := 'KES';
            PaymentFrequency := 'M';

            CRBMonthly.Init();
            CRBMonthly."Sur Name" := Surname;
            CRBMonthly."Forename 1" := Forename1;
            CRBMonthly."Forename 2" := Forename2;
            CRBMonthly."Forename 3" := Forename3;
            CRBMonthly."Trading As" := TradingAs;
            CRBMonthly."Date of Birth" := DateofBirth;
            CRBMonthly."Client No" := ClientNo;
            CRBMonthly."Account No" := AccountNo;
            CRBMonthly."Old Account No" := OldAccountNo;
            CRBMonthly.Gender := Gender;
            CRBMonthly.Nationality := Nationality;
            CRBMonthly."Marital Status" := MaritalStatus;
            CRBMonthly."Primary ID Document Type" := PrimaryIdentificationDocumentType;
            CRBMonthly."Primary ID Document Number" := PrimaryIdentificationDocumentNumber;
            CRBMonthly."Passport Country Code" := PassportCountryCode;
            CRBMonthly."Mobile Telephone Number" := MobileTelephoneNumber;
            CRBMonthly."Home Telephone Number" := HomeTelephoneNumber;
            CRBMonthly."Work Telephone Number" := WorkTelephoneNumber;
            CRBMonthly."Postal Adress 1" := PostalAdress1;
            CRBMonthly."Postal Adress 2" := PostalAdress2;
            CRBMonthly."Postal Location Town" := PostalLocationTown;
            CRBMonthly."Postal Location Country" := PostalLocationCountry;
            CRBMonthly."Post Code" := PostCode;
            CRBMonthly."Physical Adress 1" := PhysicalAdress1;
            CRBMonthly."Physical Adress 2" := PhysicalAdress2;
            CRBMonthly."Plot Number" := PlotNumber;
            CRBMonthly."Location Town" := LocationTown;
            CRBMonthly."Location Coutry" := LocationCoutry;
            CRBMonthly."Type Of Residency" := TypeOfResidency;
            CRBMonthly."P.I.N Number" := PinNumber;
            CRBMonthly."Consumer Email" := ConsumerEmail;
            CRBMonthly."Employer Name" := EmployerName;
            CRBMonthly."Occupational Industry Type" := OccupationalIndustryType;
            CRBMonthly."Employment Date" := EmploymentDate;
            CRBMonthly."Employment Type" := EmploymentType;
            CRBMonthly."Income Amount" := Format(IncomeAmount, 0, '<Integer>');
            CRBMonthly."Lenders Registered Name" := LendersRegisteredName;
            CRBMonthly."Lenders Trading Name" := LendersTradingName;
            CRBMonthly."Lenders Brach Name" := LendersBrachName;
            CRBMonthly."Lenders Brach Code" := LendersBrachCode;
            CRBMonthly."Account Joint Single Indicator" := AccountJointSingleIndicator;
            CRBMonthly."Account Product Type" := AccountProductType;
            CRBMonthly."Date Account Opened" := DateAccountOpened;
            CRBMonthly."Installment Due Date" := InstallmentDueDate;
            CRBMonthly."Original Amount" := Format(OriginalAmount, 0, '<Integer>');
            CRBMonthly."Currency Of Facility" := CurrencyOfFacility;
            CRBMonthly."Current Bal In Kes" := Format(CurrentBalInKes, 0, '<Integer>');
            CRBMonthly."Current Bal" := Format(CurrentBal, 0, '<Integer>');
            CRBMonthly."Overdue Balance" := Format(OverdueBalance, 0, '<Integer>');
            CRBMonthly."Overdue Date" := OverdueDate;
            CRBMonthly."Number Of Days In Arrears" := NumberOfDaysInArrears;
            CRBMonthly."No Of Installments In Arrears" := NumberOfInstallmentsInArrears;
            CRBMonthly."Prudential Risk Classification" := PrudentialRiskClassification;
            CRBMonthly."Account Status" := AccountStatus;
            CRBMonthly."Account Status Date" := AccountStatusDate;
            CRBMonthly."Account Clossure Reason" := AccountClossureReason;
            CRBMonthly."Repayment Period" := RepaymentPeriod;
            CRBMonthly."Deffered Payment Date" := DefferedPaymentDate;
            CRBMonthly."Deffered Payment Amount" := Format(DefferedPaymentAmount, 0, '<Integer>');
            CRBMonthly."Payment Frequency" := PaymentFrequency;
            CRBMonthly."Disbursement Date" := DisbursementDate;
            CRBMonthly."Next Installment Amount" := Format(NextInstallmentAmount, 0, '<Integer>');
            CRBMonthly."Date Of Latest Payment" := DateOfLatestPayment;
            CRBMonthly."Last Payment Amount" := Format(LastPaymentAmount, 0, '<Integer>');
            CRBMonthly."Type Of Security" := TypeOfSecurity;
            CRBMonthly."Group ID" := GroupID;
            CRBMonthly.Insert(true);
        end;
    end;


    procedure GenerateCRBDaily(Loans: Record Loans; BatchNo: Code[100])
    var
        ProcessLoan: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;


        //Colums
        SnapShotDate: Text;
        ClientType: Code[50];
        Surname: Text;
        ForeName1: Text;
        ForeName2: Text;
        ForeName3: Text;
        CompanyName: Text;
        PrimaryIdentificationType: Text;
        PrimaryIdentification: Code[50];//Mandatory
        AccountNo: Code[50];//Mandatory
        CurrencyOfFacility: Code[50];
        OriginalAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentDate: Text;
        CurrentBal: Decimal;
        InstallmentsInArrears: Integer;
        DaysInArrears: Integer;
        AccountStatus: Code[50];

        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        ProductFactory: Record "Product Factory";
        RepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        TotalLoanBal: Decimal;
        AmountInArrears: Decimal;
        ExpectedDateOfPayment: Text;
        AmountPaid: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        CRBDaily: Record "CRB Daily Manual";
    begin
        ProcessLoan := true;
        Saverity := Saverity::" ";

        Clear(TotalBal);
        Clear(SnapShotDate);
        Clear(ClientType);
        Clear(Surname);
        Clear(ForeName1);
        Clear(ForeName2);
        Clear(ForeName3);
        Clear(CompanyName);
        Clear(PrimaryIdentificationType);
        Clear(PrimaryIdentification);
        Clear(AccountNo);
        Clear(CurrencyOfFacility);
        Clear(OriginalAmount);
        Clear(PaymentAmount);
        Clear(PaymentDate);
        Clear(CurrentBal);
        Clear(InstallmentsInArrears);
        Clear(DaysInArrears);
        Clear(AccountStatus);

        if ProcessLoan then
            if not Members.Get(Loans."Member No.") then begin
                ErrorText := 'Member No. ' + Loans."Member No." + ' is not found';
                RegisterError(Loans."Loan No.", BatchNo, Loans."Member No.", ErrorText, Process::"CRB Monthly", Saverity::Error);
                ProcessLoan := false;
            end;

        if ProcessLoan then begin
            CreditLedgerEntry.Reset();
            CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
            CreditLedgerEntry.SetRange("Posting Date", Today);
            CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
            CreditLedgerEntry.SetRange(Reversed, false);
            CreditLedgerEntry.SetLoadFields(Amount);
            if not CreditLedgerEntry.FindFirst() then
                ProcessLoan := false;
        end;

        TotalBal := 0;

        if ProcessLoan then begin
            Loans.CalcFields("Days In Arrears", "Outstanding Balance", "Outstanding Interest");

            TotalBal := Loans."Outstanding Balance" + Loans."Outstanding Interest";

            Surname := Members."Other Names";
            IF Surname = '' then Surname := Members."Middle Name";
            IF Surname = '' then Surname := Members."First Name";
            ForeName1 := Members."First Name";
            ForeName2 := Members."Middle Name";
            ForeName3 := Members."Other Names";

            InstallmentsInArrears := Round(Loans."Days In Arrears" / 30, 1, '=');
            if TotalBal <= 0 then
                InstallmentsInArrears := 0;

            if Loans."Expected Date of Completion" <> 0D then
                ExpectedDateOfPayment := GlobalFunctions.FormatDate(Loans."Expected Date of Completion");

            AccountStatus := 'H';
            if TotalBal > 0 then
                AccountStatus := 'F';

            SnapShotDate := GlobalFunctions.DateFormatCRB(Today);
            ClientType := 'A';

            if Members."Primary Identification" <> '' then begin
                if Members."Primary Identification Type" = Members."Primary Identification Type"::"ID Number" then begin
                    PrimaryIdentificationType := '001';
                    PrimaryIdentification := Members."Primary Identification";

                    if StrLen(PrimaryIdentification) = 4 then
                        PrimaryIdentification := '0' + PrimaryIdentification;
                    if StrLen(PrimaryIdentification) = 3 then
                        PrimaryIdentification := '00' + PrimaryIdentification;
                    if StrLen(PrimaryIdentification) = 2 then
                        PrimaryIdentification := '000' + PrimaryIdentification;
                end;
                if Members."Primary Identification Type" = Members."Primary Identification Type"::"Passport No" then begin
                    PrimaryIdentificationType := '002';
                    PrimaryIdentification := Members."Primary Identification";
                end;
            end;

            if PrimaryIdentification = '' then begin
                if Members."Secondary Identification" <> '' then begin
                    if Members."Secondary Identification Type" = Members."Secondary Identification Type"::"ID Number" then begin
                        PrimaryIdentificationType := '001';
                        PrimaryIdentification := Members."Secondary Identification";

                        if StrLen(PrimaryIdentification) = 4 then
                            PrimaryIdentification := '0' + PrimaryIdentification;
                        if StrLen(PrimaryIdentification) = 3 then
                            PrimaryIdentification := '00' + PrimaryIdentification;
                        if StrLen(PrimaryIdentification) = 2 then
                            PrimaryIdentification := '000' + PrimaryIdentification;
                    end;
                    if Members."Secondary Identification Type" = Members."Secondary Identification Type"::"Passport No" then begin
                        PrimaryIdentificationType := '002';
                        PrimaryIdentification := Members."Primary Identification";
                    end;
                end;
            end;

            AccountNo := Loans."Loan No.";
            CurrencyOfFacility := 'KES';

            OriginalAmount := GlobalFunctions.FormatCRBAmounts(Loans."Approved Amount");

            CreditLedgerEntry.Reset();
            CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
            CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
            CreditLedgerEntry.SetRange("Posting Date", Today);
            CreditLedgerEntry.SetRange(Reversed, false);
            CreditLedgerEntry.SetLoadFields("Posting Date", "Credit Amount");
            if CreditLedgerEntry.Find('-') then begin
                PaymentDate := GlobalFunctions.DateFormatCRB(CreditLedgerEntry."Posting Date");
                CreditLedgerEntry.CalcSums("Credit Amount");
                PaymentAmount := GlobalFunctions.FormatCRBAmounts(CreditLedgerEntry."Credit Amount");
            end;

            CurrentBal := GlobalFunctions.FormatCRBAmounts(TotalBal);

            DaysInArrears := Loans."Days In Arrears";
            if DaysInArrears < 0 then
                DaysInArrears := 0;

            InstallmentsInArrears := Round(DaysInArrears / 30, 1, '>');

            // Assign the variables to the table fields
            CRBDaily.Init();
            CRBDaily."Batch No" := BatchNo;
            CRBDaily."Snap Shot Date" := SnapShotDate;
            CRBDaily."Client Type" := ClientType;
            CRBDaily."Sur Name" := Surname;
            CRBDaily."Fore Name 1" := ForeName1;
            CRBDaily."Fore Name 2" := ForeName2;
            CRBDaily."Fore Name 3" := ForeName3;
            CRBDaily."Company Name" := CompanyName;
            CRBDaily."Primary Identification Type" := PrimaryIdentificationType;
            CRBDaily."Primary Identification" := PrimaryIdentification;
            CRBDaily."Account No" := AccountNo;
            CRBDaily."Currency Of Facility" := CurrencyOfFacility;
            CRBDaily."Original Amount" := Format(OriginalAmount, 0, '<Integer>');
            CRBDaily."Payment Amount" := Format(PaymentAmount, 0, '<Integer>');
            CRBDaily."Payment Date" := PaymentDate;
            CRBDaily."Current Bal" := Format(CurrentBal, 0, '<Integer>');
            CRBDaily."Installments In Arrears" := InstallmentsInArrears;
            CRBDaily."Days In Arrears" := DaysInArrears;
            CRBDaily."Account Status" := AccountStatus;
            CRBDaily.Insert(true);
        end;
    end;

    procedure MemberListing(Members: Record Members; BatchNo: Code[20])
    var
        ProcessMember: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;

        MemberListing: Record "Member Listing";
        MemberFactBox: Record "Member FactBox";
        SavingsAccount: Record "Savings Accounts";


        //Fields
        RiskAccountNo: Code[20];
        FOSAAccountNo: Code[20];
        FOSAAccountStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        BOSAAccountNo: Code[20];
        BOSAAccountStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        BBFAccountNo: Code[20];
        BBFAccountStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        ShareCapitalAccountNo: Code[20];
        ShareCapitalAcStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        TransferredShareCapNo: Code[20];
        TransferredShareCapStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        Prorata: Decimal;
        MemberAge: Integer;

        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        Clear(RiskAccountNo);
        Clear(FOSAAccountNo);
        Clear(FOSAAccountStatus);
        Clear(BOSAAccountNo);
        Clear(BOSAAccountStatus);
        Clear(BBFAccountNo);
        Clear(BBFAccountStatus);
        Clear(ShareCapitalAccountNo);
        Clear(ShareCapitalAcStatus);
        Clear(TransferredShareCapNo);
        Clear(TransferredShareCapStatus);
        Clear(Prorata);

        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetRange("Member No.", Members."No.");
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2|=%3|=%4', CreditLedgerEntry."Transaction Type"::"Interest Due", CreditLedgerEntry."Transaction Type"::"Interest Paid",
        CreditLedgerEntry."Transaction Type"::Loan, CreditLedgerEntry."Transaction Type"::Repayment);
        if CreditLedgerEntry.Find('-') then begin
            CreditLedgerEntry.CalcSums(Amount);
            MemberFactBox."Total Loans" := CreditLedgerEntry.Amount;
        end;

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Members."No.");
        if SavingsAccount.Find('-') then begin
            repeat
                SavingsAccount.CalcFields("Balance (LCY)");
                //if SavingsAccount."Product Type" = '002' then begin
                if savingsaccount."Product Category" = savingsaccount."Product Category"::"FOSA Account" then begin
                    FOSAAccountNo := SavingsAccount."No.";
                    FOSAAccountStatus := SavingsAccount.Status;
                    MemberFactBox."FOSA Savings" := SavingsAccount."Balance (LCY)";
                end;
                //if SavingsAccount."Product Type" = '1' then begin
                if savingsaccount."Product Category" = savingsaccount."Product Category"::"BOSA Deposits" then begin
                    BOSAAccountNo := SavingsAccount."No.";
                    BOSAAccountStatus := SavingsAccount.Status;
                    MemberFactBox."BOSA Deposit" := SavingsAccount."Balance (LCY)";
                    MemberFactBox."Bosa Monthly Contribution" := SavingsAccount."Monthly Contribution";
                end;
                // if SavingsAccount."Product Type" = '4' then begin
                //     BBFAccountNo := SavingsAccount."No.";
                //     BBFAccountStatus := SavingsAccount.Status;
                //     MemberFactBox.BBF := SavingsAccount."Balance (LCY)";
                //     MemberFactBox."BBF Contribution" := SavingsAccount."Monthly Contribution";
                // end;
                //if SavingsAccount."Product Type" = '2' then begin
                if savingsaccount."Product Category" = savingsaccount."Product Category"::"Share Capital" then begin
                    ShareCapitalAccountNo := SavingsAccount."No.";
                    ShareCapitalAcStatus := SavingsAccount.Status;
                    MemberFactBox."Share Capital" := SavingsAccount."Balance (LCY)";

                end;
                // if SavingsAccount."Product Type" = '3' then begin
                //     TransferredShareCapNo := SavingsAccount."No.";
                //     TransferredShareCapStatus := SavingsAccount.Status;
                //     MemberFactBox."Transferred Share Capital" := SavingsAccount."Balance (LCY)";
                // end;
                //if SavingsAccount."Product Type" = '0' then begin
                if savingsaccount."Product Category" = savingsaccount."Product Category"::"Entrance Fee" then begin
                    MemberFactBox."Entrance Fee" := SavingsAccount."Balance (LCY)";
                end;
                // if SavingsAccount."Product Type" = '5' then begin
                //     MemberFactBox.Risk := SavingsAccount."Balance (LCY)";
                //     MemberFactBox."Risk Contribution" := SavingsAccount."Monthly Contribution";
                // end;
                //if SavingsAccount."Product Type" = '6' then begin
                // if savingsaccount."Product Category" = savingsaccount."Product Category"::"Unallocated Fund" then begin
                //     MemberFactBox."Unallocated Funds" := SavingsAccount."Balance (LCY)";
                // end;
            // if SavingsAccount."Product Type" = '011' then begin
            //     MemberFactBox."Business Deposits" := SavingsAccount."Balance (LCY)";
            // end;
            until SavingsAccount.Next() = 0;
        end;

        if Members."Date of Birth" <> 0D then
            MemberAge := Round((Today - Members."Date of Birth") / 360, 1, '<')
        else begin
            ErrorText := 'Member No. ' + Members."No." + ' does not have date of birth';
            RegisterError(Members."No.", BatchNo, Members."No.", ErrorText, Process::"Member Listing", Saverity::Warning);
        end;

        MemberListing.Init();
        Members.CalcFields("Employer Name");
        MemberListing."Member No" := Members."No.";//Done
        MemberListing.Name := Members.Name;//Done
        MemberListing.Gender := Members.Gender;//Done
        MemberListing."Phone No." := Members."Phone No.";//Done
        MemberListing."P.I.N Number" := Members."P.I.N Number";//Done
        MemberListing."Payroll/Staff No." := Members."Payroll/Staff No.";//Done
        MemberListing."Readmission Date" := Members."Rejoinig Date";//Done//Done
        MemberListing.Status := Members.Status;//Done
        MemberListing."Primary Identification Type" := Members."Primary Identification Type";//Done
        MemberListing."Primary Identification" := Members."Primary Identification";//Done
        MemberListing.Subflag := Members.Subflag;//Done
        MemberListing."Registration Date" := Members."Registration Date";//Done
        MemberListing."Employer Code" := Members."Employer Code";//Done
        MemberListing."Employer Name" := Members."Employer Name";//Done
        MemberListing."Current Address" := Members."Current Address";//Done
        MemberListing."Date of Birth" := Members."Date of Birth";//Done
        MemberListing."E-Mail" := Members."E-Mail";//Done
        MemberListing."Recruited By" := Members."Recruited By";//Done
        MemberListing."Recruited By Name" := Members."Recruited By Name";//Done
        MemberListing."Start Date" := 0D;
        MemberListing."End Date" := 0D;
        MemberListing."Recruited by Type" := Members."Recruited by Type";//Done
        MemberListing."Member Class" := Members."Member Class";//Done
        MemberListing.Salutation := Members.Salutation;//Done
        MemberListing."Marital Status" := Members."Marital Status";//Done
        MemberListing."Date Approved" := Members."Date Approved";//Done
        MemberListing."Branch Name" := Members."Branch Name";//Done
        MemberListing."Member Age" := MemberAge;//Done
        MemberListing."Delegates Zone" := Members."Delegates Zone";//Done
        MemberListing."Risk Balance" := MemberFactBox.Risk;//Done
        MemberListing."Risk Monthly Contribution" := MemberFactBox."Risk Contribution";//Done
        MemberListing."Registration Fee" := MemberFactBox."Entrance Fee";//Done
        MemberListing."FOSA Account No" := FOSAAccountNo;//Done
        MemberListing."FOSA Account Status" := FOSAAccountStatus;//Done   
        MemberListing."FOSA Balance" := MemberFactBox."FOSA Savings";//Done
        MemberListing."Business Deposits" := MemberFactBox."Business Deposits";//Done
        MemberListing."BOSA Deposit Account No" := BOSAAccountNo;//Done
        MemberListing."BOSA Deposit Balance" := MemberFactBox."BOSA Deposit";//Done
        MemberListing."BOSA Deposit Account Status" := BOSAAccountStatus;//Done
        MemberListing."BOSA Deposits Monthly Contr." := MemberFactBox."Bosa Monthly Contribution";
        MemberListing."BBF Account No" := BBFAccountNo;//Done
        MemberListing."BBF Balance" := MemberFactBox.BBF;//Done
        MemberListing."BBF Monthly Contribution" := MemberFactBox."BBF Contribution";//Done
        MemberListing."BBF Account Status" := BBFAccountStatus;//Done
        MemberListing."Transfer Share Capital" := MemberFactBox."Transferred Share Capital";//Done
        MemberListing."Share Capital Account No" := ShareCapitalAccountNo;//Done
        MemberListing."Share Capital Ac Status" := ShareCapitalAcStatus;//Done
        MemberListing."Share Capital Balance" := MemberFactBox."Share Capital";//Done
        MemberListing."Trasferred Share Cap No" := TransferredShareCapNo;//Done
        MemberListing."Trasferred Share Cap Bal" := MemberFactBox."Transferred Share Capital";//Done
        // MemberListing."Trasferred Share Cap Status" := TransferredShareCapStatus;//Done
        MemberListing.Prorata := CustomCuesCodeunit.Prorata(Members."No.", '1');//Done
        MemberListing.County := Members.County;//Done
        MemberListing."Transactional Mobile Number" := Members."Transactional Mobile Number";//Done
        MemberListing.LoanBal := MemberFactBox."Total Loans";//Done
        MemberListing."Contribution Effective Date" := Members."Contribution Start Date";//Done
        if MemberListing."Contribution Effective Date" = 0D then
            MemberListing."Contribution Effective Date" := Members."Contribution Effective Date";//Done
        MemberListing."Global Dimension 1 Code" := Members."Global Dimension 1 Code";//Done
        MemberListing."Global Dimension 2 Code" := Members."Global Dimension 2 Code";//Done
        MemberListing."Work Station" := Members."Work Station";
        MemberListing.Insert(true);
    end;

    procedure BBFNomineeListing(NextOfKin: Record "Next of KIN"; BatchNo: Code[50])
    var
        ProcessNOK: Boolean;
        ErrorText: Text;
        Process: Enum "Bulk Errors Process";
        Saverity: Option " ",Warning,Error;

        BBFNomineeList: Record "BBF/Nominee Register";
        SavingAccounts: Record "Savings Accounts";

        MemberDeposits: Decimal;
        MemberName: Text;
    begin

        SavingAccounts.RESET;
        SavingAccounts.SetRange("Member No.", NextOfKin."Record ID");
        SavingAccounts.Setrange(SavingAccounts."Product Category", SavingAccounts."Product Category"::"BOSA Deposits");
        if SavingAccounts.FindFirst() then begin
            SavingAccounts.CalcFields("Balance (LCY)");
            MemberDeposits := SavingAccounts."Balance (LCY)";
            MemberName := SavingAccounts.Name;
        end;

        BBFNomineeList.Init();
        BBFNomineeList."Member No" := NextOfKin."Record ID";
        BBFNomineeList."Member Name" := MemberName;
        BBFNomineeList."Member Deposits" := MemberDeposits;
        BBFNomineeList."Nominee Name" := NextOfKin.Name;
        BBFNomineeList."Identification Type" := NextOfKin."Identification Type";
        BBFNomineeList."Identification Number" := NextOfKin.Identification;
        BBFNomineeList.Relationship := NextOfKin.Relationship;
        BBFNomineeList.Allocation := NextOfKin.Allocation;
        BBFNomineeList."Date Captured" := NextOfKin."Date Captured";
        BBFNomineeList.Deceased := NextOfKin.Deceased;
        BBFNomineeList.Insert(true);
    end;

    procedure GeerateLoanAgeing(Loans: Record Loans)
    var
        LoanAgeing: Record "Loan Ageing Table";
    begin
        // Loans.CalcFields("Outstanding Interest", "Outstanding Balance", "Interest Paid", "Principle Paid");

        // LoanRecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

        // if Members.Get(Loans."Member No.") then begin
        //     EmployerCode := Members."Employer Code";
        //     EmployerName := Members."Employer Name";
        //     if EmployerName = '' then begin
        //         if Customer.Get(EmployerCode) then begin
        //             EmployerName := Customer.Name;
        //         end;
        //     end;
        //     MemberStatus := Format(Members.Status);
        //     SubFlag := Format(Members.Subflag);
        // end;

        // DisbursementDate := GlobalFunctions.FormatDate(Loans."Disbursement Date");

        // i := 0;
        // RepaymentSchedule.Reset();
        // RepaymentSchedule.SetCurrentKey("Loan No.");
        // RepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
        // if RepaymentSchedule.Findset then begin
        //     repeat
        //         i += 1;
        //         if i = 1 then begin
        //             "Loan Principle Repayment" := RepaymentSchedule."Principal Repayment";
        //             "Loan Interest Repayment" := RepaymentSchedule."Monthly Interest";
        //             FirstInstallmentDate := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
        //         end;

        //         if (RepaymentSchedule."Repayment Date" >= Today) then begin
        //             //Count priciple from current date
        //             if LoanPrincipleRepayment <= 0 then
        //                 LoanPrincipleRepayment := RepaymentSchedule."Principal Repayment";
        //             //Count interest from next period
        //             if (RepaymentSchedule."Repayment Date" > Today) and (LoanInterestRepayment <= 0) then
        //                 LoanInterestRepayment := RepaymentSchedule."Monthly Interest";

        //             //Monthly repayment is for the current period
        //             if MonthlyRepayment <= 0 then
        //                 MonthlyRepayment := RepaymentSchedule."Monthly Interest" + RepaymentSchedule."Principal Repayment";

        //             ExpectedBalance += RepaymentSchedule."Principal Repayment";
        //             OutstandingInstallments += 1;

        //             if RepaymentSchedule."Repayment Date" > Today then
        //                 TotalExpectedInterest += RepaymentSchedule."Monthly Interest";

        //             TotalExpectedPrinciple += RepaymentSchedule."Principal Repayment";

        //             if NextExpectedDateOfPayment = '' then
        //                 NextExpectedDateOfPayment := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
        //         end;
        //         if i = Loans.Installments then
        //             LoanExpiryDate := GlobalFunctions.FormatDate(RepaymentSchedule."Repayment Date");
        //     until RepaymentSchedule.Next() = 0;
        // end;

        // if NextExpectedDateOfPayment = '' then
        //     NextExpectedDateOfPayment := GlobalFunctions.FormatDate(Today);

        // TotalExpectedInterest += Loans."Outstanding Interest";
        // TotalExpectedPrinciple := ExpectedBalance;
        // TotalPrinciplePaid := Loans."Approved Amount" - OutBal;

        // // CreditLedgerEntry.Reset();
        // // CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
        // // CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
        // // CreditLedgerEntry.SetRange(Reversed, false);
        // // if CreditLedgerEntry.Find('-') then begin
        // //     CreditLedgerEntry.CalcSums("Credit Amount");
        // TotalInterestPaid := Loans."Interest Paid";
        // // end;

        // CreditLedgerEntry.Reset();
        // CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
        // CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
        // CreditLedgerEntry.SetRange(Reversed, false);
        // CreditLedgerEntry.SetLoadFields("Transaction No.", "Posting Date", "Credit Amount");
        // if CreditLedgerEntry.FindLast() then begin
        //     TransactionNumber := CreditLedgerEntry."Transaction No.";
        //     LastPaymentDate := GlobalFunctions.FormatDate(CreditLedgerEntry."Posting Date");
        //     LastAmountPaid := (CreditLedgerEntry."Credit Amount");
        // end;

        // if ExpectedBalance > 0 then
        //     TotalPrincipleArrears := OutBal - ExpectedBalance;
        // if TotalPrincipleArrears <= 0 then TotalPrincipleArrears := 0;

        // TotalInterestArrears := Loans."Outstanding Interest";

        // TotalArrears := TotalPrincipleArrears + TotalInterestArrears;

        // MonthsInArrears := Round("Days In Arrears" / 30, 1, '<');

        // LoansTopUp.Reset();
        // LoansTopUp.SetRange("Loan No.", Loans."Loan No.");
        // LoansTopUp.SetLoadFields("Total Top Up");
        // if LoansTopUp.Find('-') then begin
        //     LoansTopUp.CalcSums("Total Top Up");
        //     LoanAmountBridged := LoansTopUp."Total Top Up";
        // end;

        // SavingsLedgerEntry.SetRange("Customer No.", Loans."Disbursement Account No");
        // SavingsLedgerEntry.SetRange("Document No.", Loans."Loan No.");
        // SavingsLedgerEntry.SetLoadFields(Amount);
        // SavingsLedgerEntry.CalcSums(Amount);
        // NetTakeHome := (SavingsLedgerEntry.Amount) * -1;

        // SavingsAccounts.SetFilter("Product Category", '%1|%2|%3',
        // SavingsAccounts."Product Category"::"BOSA Deposits",
        // SavingsAccounts."Product Category"::"FOSA Account",
        // SavingsAccounts."Product Category"::"Business Deposits");
        // SavingsAccounts.SetRange("Member No.", Loans."Member No.");
        // SavingsAccounts.SetLoadFields("No.", "Product Category");
        // if SavingsAccounts.Find('-') then begin
        //     repeat
        //         if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
        //             BOSADeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
        //         end;
        //         if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account" then begin
        //             SavingsAccounts.CalcFields("Lien Placed");
        //             AmountInLien := SavingsAccounts."Lien Placed";
        //             FOSADeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
        //         end;
        //         if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Business Deposits" then begin
        //             BusinessLoansDeposits := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
        //         end;
        //     until SavingsAccounts.Next() = 0;
        // end;

        // BranchDomicile := Loans."Global Dimension 1 Code";
        // RepaymentRate := 'Monthly';

        // if Securities.Count > 0 then
        //     Securities.RemoveRange(1, Securities.Count);

        // TotalAmountGuaranteed := 0;
        // LoanGuarantorsandSecurity.Reset;
        // LoanGuarantorsandSecurity.SetRange("Member No", Loans."Member No.");
        // LoanGuarantorsandSecurity.SetLoadFields("Amount Guaranteed", "Guarantor Type", "Collateral Value", "Collateral Reg. No.");
        // if LoanGuarantorsandSecurity.FindSet() then begin
        //     repeat
        //         TotalAmountGuaranteed += LoanGuarantorsandSecurity."Amount Guaranteed";
        //         if not Securities.Contains(Format(LoanGuarantorsandSecurity."Guarantor Type")) then
        //             Securities.Add(Format(LoanGuarantorsandSecurity."Guarantor Type"));

        //         if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::Collateral then begin
        //             CollateralValue += LoanGuarantorsandSecurity."Collateral Value";
        //             CollateralRefNumber := LoanGuarantorsandSecurity."Collateral Reg. No.";
        //         end;
        //     until LoanGuarantorsandSecurity.Next() = 0;
        // end;

        // NetExposure := Loans."Approved Amount" - TotalAmountGuaranteed;
        // if NetExposure <= 0 then NetExposure := 0;

        // foreach Security in Securities do begin
        //     SecurityType += Security + ' ,';
        // end;

        // LoanPurpose := Format(Loans."Sub Sector Level2 Description");

        // P_Plus_I_FutureInterest := "Outstanding Balance" + TotalExpectedInterest;


        // LoanAgeing.Init();
        // LoanAgeing
        // LoanAgeing.Insert(true);
    end;

    procedure RegisterError(RecordID: Code[100]; BatchNo: code[100]; MemberNo: Code[100]; ErrorText: Text; Process: Enum "Bulk Errors Process"; Severity: Option " ",Warning,Error)
    var
        BulkErrors: Record "Bulk Processing Errors";
    begin
        BulkErrors.Init();
        BulkErrors."Record ID" := RecordID;
        BulkErrors."Member No" := MemberNo;
        BulkErrors.Error := ErrorText;
        BulkErrors.Process := Process;
        BulkErrors.Severity := Severity;
        BulkErrors."Batch No" := BatchNo;
        BulkErrors.Insert(true);
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        LoansTopup: Record "Loans Top up";
        ProductFactory: Record "Product Factory";
        SavingAcc: Record "Savings Accounts";
        Creditledger: Record "Credit Ledger Entry";
        Employer: Record Customer;
        Members: Record Members;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        Checkofline: Record "Checkoff Advice Line";
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        SavingLedger: Record "Savings Ledger Entry";
        Customer: Record Customer;
        ActualSchedule: Codeunit ActualLoanSchedule;

}