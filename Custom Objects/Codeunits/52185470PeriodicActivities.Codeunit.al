#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185470 "Periodic Activities"
{

    trigger OnRun()
    var
        DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer";
    begin
        GenerateDailyInterest(DailyLoansInterestBuffer);
    end;

    var
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: enum "Transaction Types";
        JournalPosting: Codeunit "Journal Posting";
        AccNo: Code[20];
        BalAccNo: Code[20];
        Amt: Decimal;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        iEntryNo: Integer;
        Genrating: label 'Validating advice';
        intProgressTotal: Integer;
        SendSMS: Codeunit SendSms;
        LoanNo: Code[10];
        LoanRecoveryHeader2: Record "Loan Recovery Header";
        SavAmount: Decimal;
        AccountNo: Code[50];
        UserSetup: Record "User Setup";
        Members: Record Members;
        LoanRecoveryHeaderRecovered: Record "Loan Recovery Header";
        TotalLoan: Decimal;
        JournlPosted: Codeunit "Journal Post Successful";
        RegistrationProcess: Codeunit "Registration Process";
        SaccoTrans: Codeunit "Sacco Transactions";


    procedure CreateItDuePeriods(IntPeriod: Record "Interest Due Period")
    var
        AccountingPeriod: Record "Interest Due Period";
        InvtSetup: Record "Inventory Setup";
        NoOfPeriods: Integer;
        PeriodLength: DateFormula;
        FiscalYearStartDate: Date;
        FiscalYearStartDate2: Date;
        FirstPeriodStartDate: Date;
        LastPeriodStartDate: Date;
        FirstPeriodLocked: Boolean;
        i: Integer;
        Text000: label 'The new Interest period begins before an existing interest period, so the new year will be closed automatically.\\';
        Text001: label 'Do you want to create and close the interest period?';
        Text002: label 'Once you create the new interest period you cannot change its starting date.\\';
        Text003: label 'Do you want to create the interest period?';
        Text004: label 'It is only possible to create new interest period before or after the existing ones.';
    begin
        // with IntPeriod do
        begin
            AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
            AccountingPeriod.TestField("Interest Due Date");

            if AccountingPeriod.Find('-') then begin
                FirstPeriodStartDate := AccountingPeriod."Interest Due Date";
                FirstPeriodLocked := AccountingPeriod."Date Locked";
                if (FiscalYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
                    if not
                       Confirm(
                         Text000 +
                         Text001)
                    then
                        exit;
                if AccountingPeriod.Find('+') then
                    LastPeriodStartDate := AccountingPeriod."Interest Due Date";
            end else
                if not
                   Confirm(
                     Text002 +
                     Text003)
                then
                    exit;

            FiscalYearStartDate2 := FiscalYearStartDate;

            for i := 1 to NoOfPeriods + 1 do begin
                if (FiscalYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
                    exit;

                if (FirstPeriodStartDate <> 0D) then
                    if (FiscalYearStartDate >= FirstPeriodStartDate) and (FiscalYearStartDate < LastPeriodStartDate) then
                        Error(Text004);

                AccountingPeriod.Init;
                AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
                AccountingPeriod."Interest Calcuation Date" := FiscalYearStartDate;
                AccountingPeriod.Validate("Interest Due Date");
                if (i = 1) or (i = NoOfPeriods + 1) then begin
                    AccountingPeriod."New Fiscal Year" := true;
                    InvtSetup.Get;
                    AccountingPeriod."Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
                    AccountingPeriod."Average Cost Period" := InvtSetup."Average Cost Period";
                end;
                if (FirstPeriodStartDate = 0D) and (i = 1) then
                    AccountingPeriod."Date Locked" := true;
                if (AccountingPeriod."Interest Due Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
                    AccountingPeriod.Closed := true;
                end;
                if not AccountingPeriod.Find('=') then
                    AccountingPeriod.Insert;
                FiscalYearStartDate := CalcDate(PeriodLength, FiscalYearStartDate);

            end;
            AccountingPeriod.Get(FiscalYearStartDate2);
            // AccountingPeriod.UpdateAvgItems(0);
        end;
    end;

    procedure GenerateInvestmentInterest(InvInterest: Record "Investment Interest Header");
    var
        ExistingInvInterest: Record "Investment Interest Header";
        IntEarned: Decimal;
        NoOfDays: Integer;
        Inv: Record "Investment Header";
        InvLine: Record "Investment Lines";
        InvIntLine: Record "Investment Interest Lines";
        InvSetup: Record "Investment Type";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        EntryNo: Integer;
        GlobalFunc: codeunit "Global Functions";
    begin
        // Check Already generated Int
        ExistingInvInterest.Reset;
        ExistingInvInterest.Setfilter("No.", '<>%1', InvInterest."No.");
        ExistingInvInterest.setfilter("Posting Date", '%1..%2', Calcdate('<-CM>', InvInterest."Posting Date"), Calcdate('<CM>', InvInterest."Posting Date"));
        if ExistingInvInterest.Find('-') then begin
            repeat
                if ExistingInvInterest.Posted then
                    Error('Interest has already been generated and posted for the month of %1 for Year: %2 .', GlobalFunc.FormatDate(InvInterest."Posting Date"), Date2DMY(InvInterest."Posting Date", 3));
            until ExistingInvInterest.Next() = 0;
            Error('Interest has already an existing interest header for this period Kindly use Investment interest no %1', ExistingInvInterest."No.");
        end;

        Inv.Reset;
        Inv.SetRange(Inv.Posted, true);
        Inv.SetRange(Inv.Status, Inv.Status::Fulfilled);
        //Inv.Setfilter(Inv."Maturity Date", '>%1',Today );
        Inv.SetFilter("Maturity Date", '>%1', InvInterest."Posting Date"); // Added - for testing purposes now
        if Inv.Find('-') then begin
            repeat
                InvSetup.get(Inv."Investment Type Code");
                If InvSetup."Deposit Type" <> InvSetup."Deposit Type"::Shares then begin
                    // Cust.Reset();
                    // Cust.get(Inv.Institution);
                    EntryNo := 1;

                    InvLine.Reset();
                    InvLine.SetRange("Investment No", Inv."Investment No");
                    if InvLine.Find('-') then
                        repeat
                            //--------------------for testing purposes
                            // if calcdate('CM', Inv."Investment Date") = calcdate('CM', today) then
                            //     NoOfDays := (calcdate('CM', today) - Inv."Investment Date") + 1
                            // else
                            //     NoOfDays := calcdate('CM', today) - calcdate('-CM', today) + 1;

                            //--------------------for testing purposes
                            if calcdate('CM', Inv."Investment Date") = calcdate('CM', InvInterest."Posting Date") then
                                NoOfDays := (calcdate('CM', InvInterest."Posting Date") - Inv."Investment Date") + 1
                            else
                                NoOfDays := calcdate('CM', InvInterest."Posting Date") - calcdate('-CM', InvInterest."Posting Date") + 1;

                            IntEarned := (InvLine."Face Value") * (Inv."Interest Rate" / 100) * ((NoOfDays)) / 365;

                            InvLine.Modify();

                            InvIntLine.Reset();
                            InvIntLine.SetRange(InvIntLine."Investment Header No", InvInterest."No.");
                            if InvIntLine.FindLast() then
                                EntryNo := InvIntLine.No + 1;
                            InvIntLine.Init;
                            InvIntLine."Interest Date" := InvInterest."Posting Date";

                            // for testing purposes
                            //InvIntLine."Interest Date" := Today;

                            InvIntLine."Investment Type" := Inv."Deposit Type";
                            InvIntLine.No := EntryNo;
                            InvIntLine."Investment Header No" := InvInterest."No.";
                            InvIntLine."Account No" := Inv.Institution;
                            InvIntLine."Investment No" := Inv."Investment No";
                            InvIntLine."Date Placed" := Inv."Investment Date";
                            InvIntLine."Maturity Date" := Inv."Maturity Date";
                            InvIntLine."Invested Amount" := InvLine."Face Value";
                            InvIntLine."Accrued Interest Amount" := IntEarned;
                            InvIntLine."Accrued Interest G/L Acc" := Inv."Accrued Interest G/L Acc";
                            InvIntLine."Interest Income G/L Acc" := Inv."Interest Income G/L Acc";
                            InvIntLine."Account Name" := Inv."Institution Name";
                            InvIntLine."Shortcut Dimension 1 Code" := GLSetup."Shortcut Dimension 1 Code";
                            InvIntLine.Insert();

                        until InvIntLine.Next() = 0;
                end;
            until Inv.Next = 0;
        end;
    end;

    procedure PostInvestmentInterest(InvInterest: Record "Investment Interest Header");
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0004: label 'The transaction has already been posted.';
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        InvestInterestLine: Record "Investment Interest Lines";
        Jtemp: Code[10];
        JBatch: Code[10];
        LineNo: Integer;
        ErrNotApproved: Label 'This document has not been approved';
    begin

        if not Confirm('Do you want to post the journal lines?') = true then exit;

        begin


            if InvInterest.Posted = true then
                Error(Text0004);
            if InvInterest.Status <> InvInterest.Status::Approved then
                Error(ErrNotApproved);

            if Temp.Get(UserId) then begin
                JTemp := Temp."Investment Interest Template";
                JBatch := Temp."Investment Interest Batch";
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemp);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then
                GenJournalLine.DeleteAll;

            InvestInterestLine.Reset;
            InvestInterestLine.SetRange(InvestInterestLine."Investment Header No", InvInterest."No.");
            if InvestInterestLine.Find('-') then begin
                repeat
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemp;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := InvestInterestLine."Accrued Interest G/L Acc";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := InvInterest."Document No.";
                    GenJournalLine."Posting Date" := InvInterest."Posting Date";
                    GenJournalLine.Description := InvInterest.Description;
                    GenJournalLine.Amount := InvestInterestLine."Accrued Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := InvestInterestLine."Interest Income G/L Acc";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := InvestInterestLine."Shortcut Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code" := InvestInterestLine."Shortcut Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;





                    InvestInterestLine.Posted := true;
                    InvestInterestLine.Modify();
                    Commit();
                until InvestInterestLine.Next = 0;
            end;


            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemp);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;

            InvInterest.Posted := true;
            InvInterest."Posted By" := UserId;
            InvInterest."Posting Date" := Today;
            InvInterest.Modify;

            Message('Posted Successfully');


        end;
    end;

    procedure PostFOSAPV(FPVHeader: Record "Fosa Payments Header");
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0004: label 'The transaction has already been posted.';
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        FPVLines: Record "FOSA Payment Line";
        Jtemp: Code[10];
        JBatch: Code[10];
        LineNo: Integer;
        ErrNotApproved: Label 'This document has not been approved';
        TarriffCodes: Record "Tariff Code s";
        Post: Boolean;
        CheckBudget: Codeunit "Budgetary Control";
        BankLedger: Record "Bank Account Ledger Entry";
        SavAcc: record "Savings Accounts";
        SendSMS: codeunit sendsms;
        Member: record Members;
        Msg: text[1000];
        GenSetup: record "General Set-Up";
        TransactionCharges: record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        ChargeAmount: decimal;
    begin
        if not Confirm('Do you want to post the journal lines?') = true then exit;
        begin
            BankLedger.Reset();
            BankLedger.SetRange("Document No.", FPVHeader."No.");
            if not BankLedger.Find('-') then begin
                if FPVHeader.Posted = true then
                    Error(Text0004);
                if FPVHeader.Status <> FPVHeader.Status::Approved then
                    Error(ErrNotApproved);
                FPVHeader.TestField("Payment Release Date");

                if Temp.Get(UserId) then begin
                    JTemp := Temp."Investment Interest Template";
                    JBatch := Temp."Investment Interest Batch";
                end;
                if Jtemp = '' then
                    Error('Ensure the Investment interest Template is set up in Banking User Setup');
                if JBatch = '' then
                    Error('Ensure the Investment interest Batch is set up in Banking User Setup');
                CheckBudget.CheckFundsAvailability1(FPVHeader);

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemp);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;

                FPVHeader.CalcFields("Total Net Amount", "Total Payment Amount", "Total Payment Amount LCY");

                // Insert Header : Debit Transaction
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JTemp;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := FPVHeader."Account Type";
                GenJournalLine."Account No." := FPVHeader."Account No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FPVHeader."No.";
                GenJournalLine."Posting Date" := FPVHeader."Payment Release Date";
                GenJournalLine.Description := FPVHeader."Payment Narration";
                GenJournalLine.Amount := FPVHeader."Total Payment Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '';
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := FPVLines."Branch Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := FPVLines."Shortcut Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                FPVLines.Reset;
                FPVLines.SetRange(FPVLines.No, FPVHeader."No.");
                if FPVLines.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemp;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := FPVLines."Account Type";
                        GenJournalLine."Account No." := FPVLines."Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := FPVHeader."No.";
                        GenJournalLine."Posting Date" := FPVHeader."Payment Release Date";
                        GenJournalLine.Description := FPVHeader."Payment Narration";
                        GenJournalLine.Amount := -FPVLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := '';
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := FPVLines."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := FPVLines."Shortcut Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        // Commit();
                        // Withholding Tax from FOSA Acc.
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code, FPVLines."Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                            TarriffCodes.TestField(TarriffCodes."Account No.");
                            TarriffCodes.TestField(TarriffCodes."Account Type", TarriffCodes."Account Type"::"G/L Account");

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemp;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
                            GenJournalLine."Source Code" := 'PAYMENTJNL';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Posting Date" := FPVHeader."Payment Release Date";
                            GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
                            GenJournalLine."Document No." := FPVLines.No;
                            GenJournalLine."External Document No." := FPVHeader."Cheque No.";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                            GenJournalLine."Account No." := FPVLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Currency Code" := FPVHeader."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            //CurrFactor
                            GenJournalLine."Currency Factor" := FPVHeader."Currency Factor";
                            GenJournalLine.Validate("Currency Factor");

                            GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
                            GenJournalLine.Validate(GenJournalLine."Gen. Posting Type");
                            GenJournalLine."Gen. Bus. Posting Group" := '';
                            GenJournalLine.Validate(GenJournalLine."Gen. Bus. Posting Group");
                            GenJournalLine."Gen. Prod. Posting Group" := '';
                            GenJournalLine.Validate(GenJournalLine."Gen. Prod. Posting Group");
                            GenJournalLine."VAT Bus. Posting Group" := '';
                            GenJournalLine.Validate(GenJournalLine."VAT Bus. Posting Group");
                            GenJournalLine."VAT Prod. Posting Group" := '';
                            GenJournalLine.Validate(GenJournalLine."VAT Prod. Posting Group");
                            GenJournalLine.Amount := FPVLines."Withholding Tax Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := TarriffCodes."Account Type";
                            GenJournalLine."Bal. Account No." := TarriffCodes."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine.Description := CopyStr(TarriffCodes.Description + ' ' + Format(GenJournalLine."Account No.") + ' :: for ' + FPVLines."Account Name", 1, 50);
                            GenJournalLine."Shortcut Dimension 1 Code" := FPVHeader."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := FPVHeader."Shortcut Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Dimension Set ID" := FPVLines."Dimension Set ID";

                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            Commit();
                        end;
                        // SMS Charges
                        GenSetup.Get();
                        if Gensetup."Disable Salary SMS" = false then begin
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", FPVHeader."SMS Charge");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    LineNo := LineNo + 10000;
                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (FPVLines.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (FPVLines.Amount >= TariffDetails."Lower Limit") and (FPVLines.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := FPVLines.Amount * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemp;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := CopyStr(FPVLines.No, 1, 20);
                                    // GenJournalLine."Document No." := CopyStr(FPVLines."Document No.", 1, 20);

                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := FPVLines."Account No.";
                                    //GenJournalLine."External Document No.":="ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := FPVHeader."Payment Release Date";
                                    ;
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := FPVLines."Branch Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := FPVLines."Shortcut Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert(false);

                                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise Duty
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemp;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := CopyStr(FPVLines.No, 1, 20);

                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FPVLines."Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := FPVHeader."Payment Release Date";
                                        ;
                                        GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := FPVLines."Branch Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FPVLines."Shortcut Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert(false);
                                    end;
                                until TransactionCharges.Next = 0;
                            end;
                        end;
                    until FPVLines.Next() = 0;
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemp);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post New", GenJournalLine);
            end;


            FPVLines.Reset;
            FPVLines.SetRange(FPVLines.No, FPVHeader."No.");
            if FPVLines.Find('-') then begin
                repeat
                    FPVLines.Posted := true;
                    FPVLines.Modify();
                until FPVLines.Next() = 0;
                FPVHeader.Posted := true;
                FPVHeader."Posted By" := UserId;
                FPVHeader."Date Posted" := Today;
                FPVHeader.Modify;
                Message('FOSA PV Posted Successfully');
            end;
            //send Messages

            FPVLines.Reset;
            FPVLines.SetRange(FPVLines.No, FPVHeader."No.");
            if FPVLines.Find('-') then begin
                repeat
                    SavAcc.reset;
                    SavAcc.setrange("No.", FPVLines."Account No.");
                    if SavAcc.findfirst then begin
                        if Members.get(SavAcc."Member No.") then begin
                            Msg := 'Dear ' + Members."First Name" + ', KES ' + format(FPVLines.Amount) + 'has been credited to your account. AZIMA SACCO';
                            SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Members."Phone No.", msg, Format(Members."No."), '', true, 0, false, 'CBS', Members."No.", 'CBS');
                        end;
                    end;
                until FPVLines.Next() = 0;
            end;
        end;
    end;

    procedure PostEntries(InterestBufferBillAndAccrue: Record "Interest Header")
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        members: Record Members;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Product Factory";
        MoratoriumLoan: Record "Moratorium Loan";
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Dim1: Code[20];
        Dim2: Code[20];
        JBatch: Code[10];
        Descri: Text[100];
        Jtemplate: Code[10];
        CustLedger: Record "Interest Due Period";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        LoansInterest: Record "Loans Interest";
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in Banking User Template';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the Banking User Template';
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        RunPosting: Boolean;
        LoansRec: Record Loans;
        LoanPr: Codeunit "Loans Process";
        GenSetup: Record "General Set-Up";
        LoansLedger: record "Credit Ledger Entry";
    begin
        // with InterestBufferBillAndAccrue do
        begin
            if InterestBufferBillAndAccrue.Posted = true then
                Error(AlreadyPostedErr);

            Temp.Get(UserId);

            Jtemplate := Temp."Bills Template";
            JBatch := Temp."Bills Batch";

            if Jtemplate = '' then begin
                Error(NoTemplateErr);
            end;
            if JBatch = '' then begin
                Error(NoBatchErr)
            end;
            GenSetup.Get();
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            LoansInterest.Reset;
            LoansInterest.SetRange(LoansInterest.No, InterestBufferBillAndAccrue."No.");
            LoansInterest.SetRange(Posted, false);
            LoansInterest.SetFilter("Interest Amount", '>%1', 0);
            if LoansInterest.FindSet() then begin
                repeat
                    if LoanType.Get(LoansInterest."Loan Product type") then begin
                        if LoansInterest."Interest Amount" <> 0 then begin
                            if LoansRec.get(LoansInterest."Loan No.") then begin
                                // Check for already posted entries
                                LoansLedger.reset();
                                LoansLedger.setrange("Loan No", LoansRec."Loan No.");
                                LoansLedger.setrange("Document No.", LoansInterest.No);
                                LoansLedger.setrange("Transaction Type", LoansLedger."Transaction Type"::"Interest Due");
                                LoansLedger.SetRange(Reversed, false);
                                if not LoansLedger.findfirst() then begin
                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::Credit;
                                    AccNo := LoansInterest."Account No";
                                    Amt := LoansInterest."Interest Amount";
                                    BalAccNo := LoanType."Loan Interest Account [G/L]";// '';
                                    Descri := InterestBufferBillAndAccrue."Document No.";
                                    TransType := Transtype::"Interest Due";
                                    BalAccType := BalAccType::"G/L Account";
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, LoansInterest.No, CopyStr((Descri + '-'), 1, 50), Amt, AccNo, Today, BalAccType,
                                    BalAccNo, LoansInterest."Loan No.", Dim1, Dim2, TransType, LoansInterest."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    JournalPosting.CompletePosting(Jtemplate, JBatch);

                                    // DailyLoansInterestBuffer.Reset();
                                    // DailyLoansInterestBuffer.SetRange("Loan No.", LoansInterest."Loan No.");
                                    // DailyLoansInterestBuffer.SetRange(Posted, false);
                                    // DailyLoansInterestBuffer.SetRange("Interest Date", CALCDATE('-CM', InterestBufferBillAndAccrue."End Date"), InterestBufferBillAndAccrue."End Date");
                                    // DailyLoansInterestBuffer.ModifyAll(Posted, true);
                                    // DailyLoansInterestBuffer.ModifyAll(Transferred, true);


                                    LoansInterest.Transferred := true;
                                    LoansInterest.Posted := true;
                                    LoansInterest.Modify;
                                end
                                else begin
                                    LoansInterest.Transferred := true;
                                    LoansInterest.Posted := true;
                                    LoansInterest.Modify;
                                end;
                            end;
                        end;
                    end;
                until LoansInterest.Next = 0;
            end;
            InterestBufferBillAndAccrue.Posted := true;
            InterestBufferBillAndAccrue."Posted By" := UserId;
            InterestBufferBillAndAccrue."Posting Date" := Today;
            InterestBufferBillAndAccrue.Modify;
            Message(GeneratesuccMSG);
        end;

    end;

    procedure GenerateDailyInterest(LoansInt: Record "Loans Interest"; var HeaderNo: Code[30]; Empl: Code[30]);
    var
        myInt: Integer;
        LoanRecc: Record Loans;
        LoansInterest: Record "Loans Interest";
        BufferInterest: Record "Loans Interest Buffer";
        MemberRe: Record Members;
        productFac: Record "Product Factory";

    begin
        if MemberRe.Get(LoansInt."Member No") then
            if MemberRe.Status <> MemberRe.Status::Deceased then begin
                LoansInt.Reset();
                LoansInt.SetRange(Posted, false);
                LoansInt.SetRange(LoansInt."Emp code", Empl);
                if LoansInt.FindFirst() then begin
                    LoanRecc.Reset();
                    LoanRecc.SetRange("Loan No.", LoansInt."Loan No.");
                    LoanRecc.SetFilter("loan account", '<>%1', '');
                    LoanRecc.SetFilter("Daily Interest", '>%1', 0);
                    LoanRecc.SetFilter(LoanRecc."Loans Category-SASRA", '<>%1', LoanRecc."Loans Category-SASRA"::Substandard);
                    if LoanRecc.FindFirst() then begin
                        LoanRecc.CalcFields(LoanRecc."Outstanding Balance", LoanRecc."Outstanding Interest");
                        if LoanRecc."Outstanding Balance" > LoanRecc."Outstanding Interest" then begin
                            if productFac.Get(LoanRecc."Loan Product Type") then
                                if (productFac."Interest Recovered Upfront" = false) and (productFac."Product Class Type" = productFac."Product Class Type"::Loan) then begin
                                    // BufferInterest.Reset();
                                    // BufferInterest.SetRange(Posted, false);
                                    // BufferInterest.SetRange("Loan No.", LoanRecc."Loan No.");
                                    // if BufferInterest.FindFirst() then begin
                                    //     repeat
                                    LoansInterest.Init();
                                    LoansInterest.No := HeaderNo;
                                    LoansInterest."Entry No" := LoansInterest."Entry No" + 1;
                                    LoansInterest."Loan No." := LoansInterest."Loan No.";
                                    LoansInterest.TestField(LoansInterest."Loan No.");
                                    LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                                    LoansInterest."Account No" := LoanRecc."Loan Account";
                                    LoansInterest.Posted := false;
                                    LoansInterest."Interest Date" := LoansInterest."Interest Date";
                                    LoansInterest.Description := LoansInterest.Description;
                                    LoansInterest."Interest Amount" := LoansInterest."Interest Amount" + LoansInterest."Interest Amount";
                                    LoansInterest."Shortcut Dimension 1 Code" := LoansInterest."Shortcut Dimension 1 Code";
                                    LoansInterest."Shortcut Dimension 2 Code" := LoansInterest."Shortcut Dimension 2 Code";
                                    LoansInterest."Monthly Repayment" := LoansInterest."Repayment Bill" + LoansInterest."Interest Bill";
                                    LoansInterest."Outstanding Balance" := LoansInterest."Outstanding Balance" + LoansInterest."Outstanding Balance";
                                    LoansInterest."Outstanding Interest" := LoansInterest."Outstanding Interest" + LoansInterest."Outstanding Interest";
                                    LoansInterest."Outstanding Bill" := LoansInterest."Outstanding Bill" + LoansInterest."Outstanding Bill";
                                    LoansInterest.Insert();
                                    // until BufferInterest.Next() = 0;
                                    // end;
                                end;
                        end;
                    end;
                end;
            end;
    end;


    procedure GenerateMonthlyInterestandBills(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        LoanType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        Members: Record Members;
        Memb: Record Members;
        diaProgress: Dialog;
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        GeneratingDividends: label 'Generating Interest :';
        Counter1: Integer;
        Counter2: Integer;
        ToDateS: Text;
        DateFilter: Text;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        InterestDuePeriod: Record "Interest Due Period";
        MonthDays: Integer;
        GeneralSetUp: Record "General Set-Up";
        Dim1: Code[50];
        Dim2: Code[50];
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);

            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            // TESTFIELD("Start Date");
            InterestBuffer.TestField("End Date");
            InterestDuePeriod.Get(InterestBuffer."Interest Due Date");
            IntCharged := 0;
            Principle := 0;
            intProgressI := 0;
            MonthDays := 0;
            Counter1 := 0;
            //Sum Up Daily Entries
            diaProgress.Open(GeneratingDividends + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            Evaluate(ToDateS, Format(InterestBuffer."End Date"));
            DateFilter := '..' + ToDateS;
            MonthDays := ((CalcDate('CM', InterestDuePeriod."Interest Due Date")) - InterestDuePeriod."Interest Due Date") + 1;



            Loans.Reset;
            Loans.SetRange(Loans.Posted, true);
            Loans.SetFilter(Loans."Date Filter", DateFilter);
            Loans.SetRange("Disbursement Date", 19000101D, InterestBuffer."End Date");
            Loans.SetFilter("Outstanding Balance", '>0');
            if Loans.Find('-') then begin
                Counter2 := Loans.Count;
                repeat
                    Dim1 := Loans."Global Dimension 1 Code";
                    Dim2 := Loans."Global Dimension 2 Code";

                    if Dim2 = '' then begin
                        UserSetup.Reset;
                        UserSetup.SetRange("User ID", Loans."Posted By");
                        if UserSetup.FindFirst then begin
                            Dim1 := UserSetup."Global Dimension 1 Code";
                            Dim2 := UserSetup."Global Dimension 2 Code";
                        end;
                    end;

                    if Dim2 = '' then begin
                        Dim1 := InterestBuffer."Shortcut Dimension 1 Code";
                        Dim2 := InterestBuffer."Shortcut Dimension 1 Code";
                    end;


                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills", "Loans Category-SASRA");
                    if (Loans."Outstanding Balance" + Loans."Outstanding Interest") > 0 then begin
                        if Loans."Loan Account" <> '' then begin
                            //Check status - sasra
                            GeneralSetUp.Get();
                            Loans.CalcFields("Loans Category-SASRA");
                            // if Loans."Loans Category-SASRA" < GeneralSetUp."Allowed Loan Cat Billing"
                            if Loans."Loans Category-SASRA".AsInteger() <= GeneralSetUp."Allowed Loan Cat Billing".AsInteger() then begin
                                Counter1 += 1;
                                diaProgress.Update(1, ROUND((Counter1 / Counter2), 1, '>') * 100);
                                LoanType.Get(Loans."Loan Product Type");
                                //Calculate Interest
                                //MBUSO

                                Members.Reset;
                                Members.SetRange("No.", Loans."Member No.");
                                Members.SetFilter(Status, '<>%1', Members.Status::Deceased);
                                if Members.Find('-') then begin
                                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then
                                        IntCharged := Loans."Approved Amount" * ((Loans.Interest) / 1200)
                                    else
                                        IntCharged := Loans."Outstanding Balance" * ((Loans.Interest) / 1200);

                                    if (LoansInterest.No = "Document No.") and (LoansInterest."Loan No." = Loans."Loan No.") then LoansInterest.Delete;
                                    if Memb.Get(Loans."Member No.") then begin
                                        if Memb.Status = Memb.Status::Deceased then
                                            IntCharged := 0;
                                    end;

                                    LoanType.Get(Loans."Loan Product Type");

                                    if LoanType."No Interest Bills" = true then
                                        IntCharged := 0;
                                    LoansInterest.Init;
                                    LoansInterest.No := InterestBuffer."No.";
                                    LoansInterest."Loan No." := Loans."Loan No.";
                                    LoansInterest.TestField(LoansInterest."Loan No.");
                                    LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                                    LoansInterest."Account No" := Loans."Loan Account";
                                    LoansInterest.TestField(LoansInterest."Account No");
                                    LoansInterest."Interest Date" := InterestBuffer."Posting Date";//TODAY;
                                    LoansInterest."Issued Date" := Loans."Disbursement Date";
                                    //Grace Period Interest
                                    if Format(LoanType."Grace Period - Interest") <> '' then begin
                                        if CalcDate(LoanType."Grace Period - Interest", Loans."Disbursement Date") <= Today then
                                            LoansInterest."Interest Bill" := IntCharged else
                                            LoansInterest."Interest Bill" := 0;
                                    end else begin
                                        LoansInterest."Interest Bill" := IntCharged;
                                    end;

                                    if Loans."Outstanding Balance" > (Loans.Repayment - IntCharged) then
                                        Principle := (Loans.Repayment - IntCharged)
                                    else
                                        Principle := Loans."Outstanding Balance";

                                    if (Principle + Loans."Outstanding Bills") > Loans."Outstanding Balance" then
                                        Principle := Loans."Outstanding Balance" - Loans."Outstanding Bills";
                                    LoansInterest."Repayment Amount" := Principle;

                                    if Format(LoanType."Grace Period - Principle") <> '' then begin
                                        if CalcDate(LoanType."Grace Period - Principle", Loans."Disbursement Date") <= Today then
                                            LoansInterest."Repayment Bill" := (Principle) else
                                            LoansInterest."Repayment Bill" := 0;
                                    end else begin
                                        LoansInterest."Repayment Bill" := Principle;
                                    end;

                                    if LoansInterest."Repayment Bill" < 0 then
                                        LoansInterest."Repayment Bill" := 0;

                                    if Loans.Installments <> 0 then
                                        LoansInterest."Appraisal Amount" := Loans."Appraisal Fee" / Loans.Installments;
                                    LoansInterest.Description := InterestBuffer.Description;
                                    LoansInterest."Interest Amount" := IntCharged;
                                    LoansInterest."Shortcut Dimension 1 Code" := Dim1;
                                    LoansInterest."Shortcut Dimension 2 Code" := Dim2;
                                    LoansInterest."Monthly Repayment" := LoansInterest."Repayment Bill" + LoansInterest."Interest Bill";
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Bills", Loans."Outstanding Interest");
                                    LoansInterest."Outstanding Balance" := Loans."Outstanding Balance";
                                    LoansInterest."Outstanding Interest" := Loans."Outstanding Interest";
                                    LoansInterest."Outstanding Bill" := Loans."Outstanding Bills";
                                    LoansInterest."Loan Product type" := Loans."Loan Product Type";
                                    if LoanType.Get(Loans."Loan Product Type") then begin
                                        LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                                        LoansInterest."Bill Account" := LoanType."Billed Account";
                                        if LoanType."No Interest Bills" = true then
                                            LoansInterest."Interest Bill" := 0;
                                        if LoanType."No Principle Bills" = true then
                                            LoansInterest."Repayment Bill" := 0;
                                        LoansInterest."Monthly Repayment" := LoansInterest."Repayment Bill" + LoansInterest."Interest Bill";
                                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming) or (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch) then
                                            LoansInterest."Bal. Account No." := LoanType."Loan Interest Account [G/L]"
                                        else begin
                                            LoansInterest."Bal. Account No." := LoanType."Suspend Interest Account [G/L]";
                                            //Insert Entries to buffer
                                            iEntryNo := iEntryNo + 1;
                                            SuspendedInterestAccounts.Reset;
                                            if SuspendedInterestAccounts.FindLast then begin
                                                SuspendedInterestAccounts.Init;
                                                SuspendedInterestAccounts."Entry No." := SuspendedInterestAccounts."Entry No." + iEntryNo;
                                                SuspendedInterestAccounts."Loan No." := Loans."Loan No.";
                                                SuspendedInterestAccounts."Loan Product type" := LoanType."Product ID";
                                                SuspendedInterestAccounts."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                                                SuspendedInterestAccounts."Interest Amount" := IntCharged;
                                                SuspendedInterestAccounts."Interest Date" := InterestBuffer."Posting Date";
                                                SuspendedInterestAccounts."Issued Date" := Loans."Disbursement Date";
                                                if LoansInterest."Repayment Bill" < 0 then
                                                    LoansInterest."Repayment Bill" := 0;
                                                if (LoanType."No Principle Bills" = true) and (LoanType."No Interest Bills" = false) then begin
                                                    LoansInterest."Repayment Bill" := 0;
                                                end;
                                                SuspendedInterestAccounts.Insert(true);
                                            end;
                                        end;
                                    end;

                                    LoansInterest.TestField(LoansInterest."Bal. Account No.");
                                    if CustMember.Get(Loans."Loan Account") then begin
                                        //LoansInterest."Shortcut Dimension 1 Code":=CustMember."Global Dimension 1 Code";
                                        //LoansInterest."Shortcut Dimension 2 Code":=CustMember."Global Dimension 2 Code";
                                        LoansInterest.Status := CustMember.Status;
                                        LoansInterest.Blocked := CustMember.Blocked;
                                    end;
                                    if (LoansInterest."Monthly Repayment" <> 0) and ((LoansInterest."Repayment Bill" + LoansInterest."Interest Bill" + LoansInterest."Appraisal Amount") <> 0) then
                                        LoansInterest.Insert;


                                end;
                            end;
                        end;
                    end;
                until Loans.Next = 0;
            end;
        end;
    end;

    procedure GenerateMonthlyInterest(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        LoanType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;

            //Sum Up Daily Entries
            Loans.Reset;
            Loans.SetRange(Loans.Posted, true);
            if Loans.Find('-') then begin
                repeat
                    DailyLoansInterest.Reset;
                    DailyLoansInterest.SetCurrentkey(DailyLoansInterest."Loan No.", DailyLoansInterest.Transferred);
                    DailyLoansInterest.SetRange(DailyLoansInterest.Transferred, false);
                    DailyLoansInterest.SetRange(DailyLoansInterest."Loan No.", Loans."Loan No.");
                    //DailyLoansInterest.CALCSUMS("Interest Amount");

                    if DailyLoansInterest.Find('-') then begin
                        IntCharged := 0;
                        repeat
                            IntCharged += DailyLoansInterest."Interest Amount";
                        until DailyLoansInterest.Next = 0;
                    end;
                    //MESSAGE('Interest %1, Princ %2',IntCharged,Principle);
                    if (LoansInterest.No = "Document No.") and (LoansInterest."Loan No." = Loans."Loan No.")
                             then
                        LoansInterest.Delete;
                    LoansInterest.Init;
                    LoansInterest.No := "Document No.";
                    LoansInterest."Loan No." := Loans."Loan No.";
                    LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                    LoansInterest."Account No" := Loans."Loan Account";
                    LoansInterest."Interest Date" := Today;
                    LoansInterest."Issued Date" := Loans."Disbursement Date";
                    LoansInterest."Repayment Amount" := Loans.Repayment;
                    LoansInterest."Repayment Bill" := Loans.Repayment;
                    LoansInterest."Interest Bill" := IntCharged;
                    LoansInterest."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                    LoansInterest."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
                    LoansInterest.Description := InterestBuffer.Description;
                    LoansInterest."Interest Amount" := IntCharged;
                    LoansInterest."Monthly Repayment" := LoansInterest."Repayment Amount" + LoansInterest."Interest Amount";
                    LoansInterest."Loan Product type" := Loans."Loan Product Type";
                    if LoanType.Get(Loans."Loan Product Type") then begin
                        LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                        LoansInterest."Bill Account" := LoanType."Billed Account";
                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming) or (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch) then
                            LoansInterest."Bal. Account No." := LoanType."Loan Interest Account [G/L]" else
                            LoansInterest."Bal. Account No." := LoanType."Suspend Interest Account [G/L]";
                    end;
                    if CustMember.Get(Loans."Loan Account") then begin
                        //LoansInterest."Shortcut Dimension 1 Code":=CustMember."Global Dimension 1 Code";
                        //LoansInterest."Shortcut Dimension 2 Code":=CustMember."Global Dimension 2 Code";
                        LoansInterest.Status := CustMember.Status;
                        LoansInterest.Blocked := CustMember.Blocked;
                    end;
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Bills", Loans."Outstanding Interest");
                    LoansInterest."Outstanding Balance" := Loans."Outstanding Balance";
                    LoansInterest."Outstanding Interest" := Loans."Outstanding Interest";
                    if LoansInterest."Monthly Repayment" <> 0 then
                        LoansInterest.Insert;
                    //DailyLoansInterest.MODIFYALL(DailyLoansInterest.Transferred,FALSE);
                    DailyLoansInterest.ModifyAll(DailyLoansInterest."Interest Matured", true);
                until Loans.Next = 0;
            end;

        end;
    end;


    procedure GenerateMonthlyBills(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        LoanType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        Memb: Record Members;
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;
            //Compute Bills
            Loans.Reset;
            Loans.SetRange(Loans.Posted, true);
            if Loans.Find('-') then begin
                repeat
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Bills", Loans."Outstanding Interest");
                    if Loans."Outstanding Bills" < Loans."Outstanding Balance" then begin
                        LoansInterest.Init;
                        LoansInterest.No := "Document No.";
                        LoansInterest."Loan No." := Loans."Loan No.";
                        LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                        LoansInterest."Account No" := Loans."Loan Account";
                        LoansInterest."Interest Date" := Today;
                        LoansInterest."Issued Date" := Loans."Disbursement Date";
                        LoansInterest."Repayment Amount" := Loans.Repayment;
                        LoansInterest."Repayment Bill" := Loans.Repayment;
                        LoansInterest."Interest Bill" := IntCharged;
                        LoansInterest.Description := InterestBuffer.Description;
                        LoansInterest."Interest Amount" := IntCharged;
                        LoansInterest."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                        LoansInterest."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
                        LoansInterest."Monthly Repayment" := Loans.Repayment;
                        LoansInterest."Loan Product type" := Loans."Loan Product Type";
                        if LoanType.Get(Loans."Loan Product Type") then begin
                            LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                            LoansInterest."Bill Account" := LoanType."Billed Account";
                            if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming) or (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch) then
                                LoansInterest."Bal. Account No." := LoanType."Loan Interest Account [G/L]" else
                                LoansInterest."Bal. Account No." := LoanType."Suspend Interest Account [G/L]";
                        end;
                        if CustMember.Get(Loans."Loan Account") then begin
                            LoansInterest.Status := CustMember.Status;
                            LoansInterest.Blocked := CustMember.Blocked;
                        end;
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Bills", Loans."Outstanding Interest");
                        LoansInterest."Outstanding Balance" := Loans."Outstanding Balance";
                        LoansInterest."Outstanding Interest" := Loans."Outstanding Interest";
                        if LoansInterest."Monthly Repayment" <> 0 then
                            LoansInterest.Insert;
                        //DailyLoansInterest.MODIFYALL(DailyLoansInterest.Transferred,FALSE);
                        DailyLoansInterest.ModifyAll(DailyLoansInterest."Interest Matured", true);
                    end;
                until Loans.Next = 0;
            end;
        end;
    end;


    procedure GenerateDailyInterest(DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer")
    var
        Loans: Record Loans;
        LoanType: Record "Product Factory";
        DailyLoansBuffer: Record "Daily Loans Interest Buffer";
        DateDiff: Integer;
        MontDays: Integer;
    begin
        // with DailyLoansInterestBuffer do
        begin
            //Initiate Variables
            DateDiff := 0;
            Loans.SetRange(Loans.Posted, true);
            Loans.SetRange(Loans."Compute Interest Due on Postin", Loans."compute interest due on postin"::"Pro-rata");
            if Loans.Find('-') then begin
                LoanType.Get(Loans."Loan Product Type");
                repeat
                    DateDiff := 1;//TODAY-Loans."Application Date" ELSE
                                  //DateDiff:=TODAY-Loans."Disbursement Date";
                    MontDays := (CalcDate('CM', Today)) - (CalcDate('-CM', Today));
                    DailyLoansBuffer.Init;
                    DailyLoansBuffer."Loan No." := Loans."Loan No.";
                    DailyLoansBuffer."Interest Date" := Today;//CALCDATE('-1d',TODAY);
                    DailyLoansBuffer."Account No" := Loans."Loan Account";
                    DailyLoansBuffer."Account Type" := DailyLoansBuffer."account type"::Credit;
                    DailyLoansBuffer."Loan Product type" := Loans."Loan Product Type";
                    DailyLoansBuffer."User ID" := UserId;
                    //Compute Interest
                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                        if Format(LoanType."Grace Period - Interest") <> '' then
                            //BEGIN
                            if CalcDate(LoanType."Grace Period - Interest", Loans."Disbursement Date") >= Today then
                                DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                            else
                                DailyLoansBuffer."Interest Amount" := 0;
                    end else begin
                        if Format(LoanType."Grace Period - Interest") <> '' then begin
                            if CalcDate(LoanType."Grace Period - Interest", Loans."Disbursement Date") >= Today then
                                DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                            else
                                DailyLoansBuffer."Interest Amount" := 0;
                        end else begin
                            DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                        end;
                    end;
                    //end of interest computations
                    if Format(LoanType."Grace Period - Principle") <> '' then begin
                        if CalcDate(LoanType."Grace Period - Principle", Loans."Disbursement Date") >= Today then
                            DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays) else
                            DailyLoansBuffer."Repayment Amount" := 0;
                    end else begin
                        DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays)
                    end;
                    DailyLoansBuffer."Monthly Repayment" := DailyLoansBuffer."Repayment Amount" + DailyLoansBuffer."Interest Amount";
                    if DailyLoansBuffer."Monthly Repayment" <> 0 then
                        DailyLoansBuffer.Insert;
                until Loans.Next = 0;
            end;
        end;
        //END;
        //END;
    end;



    procedure MonthlyCheckoffAdviceLn(CheckoffAdviceHeader: Record "Checkoff Advice Header")
    var
        Loans: Record Loans;
        Employer: Record Customer;
        CheckoffAdvice: Record "Checkoff Advice Line";
        iEntryNo: Integer;
        ChAdvice: Record "Checkoff Advice Line";
        Employer2: Record Customer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        Employer3: Record Customer;
        MemberClass: Record "Member Classes";
        // PaymentMethods: Record "Payment Methods";
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffAdvice2: Record "Checkoff Advice Line";
        MoratoriumLoan: Record "Moratorium Loan";
        LoopCount: Integer;
        CountNo: Integer;
        CountNo1: Integer;
        STOPlaced: record "Standing Order Header";
        STOLines: record "Standing Order Lines";
        TotalSTO: decimal;

    begin
        Mdays := (CheckoffAdviceHeader."End Date" - CheckoffAdviceHeader."Start Date") + 1;
        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;

        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice.Period, CheckoffAdviceHeader.Period);
        ChAdvice.SetRange(ChAdvice.Type, ChAdvice.Type::Credit);
        ChAdvice.setfilter("Advice Header No.", '<>%1', '');
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;
        if CheckoffAdviceHeader."Employer Code" = '' then begin

            Employer2.Reset;
            Employer2.SetRange(Employer2."Advice Method", Employer2."advice method"::Everything);
            if Employer2.Find('-') then begin
                repeat
                    Loans.Reset;
                    loans.CalcFields("Total Balance");
                    Loans.SetFilter("Total Balance", '>0');
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetFilter("Date Filter", '..' + Format(CheckoffAdviceHeader."Loan Interest Cut OFF Date"));
                    Loans.SetFilter("Disbursement Date", '..' + Format(CheckoffAdviceHeader."Loan Issue Cut OFF Date"));
                    //Loans.setfilter("Recovery Mode", '%1|%2', Loans."recovery mode"::Checkoff, Loans."recovery mode"::Hybrid);
                    Loans.setrange(Loans."Source Unit", Loans."Source Unit"::BOSA);
                    Loans.SetRange("Employer Code", Employer2."No.");
                    if Loans.findset then begin
                        repeat
                            TotalSTO := 0;
                            if Memb.Get(Loans."Member No.") then begin
                                if Memb.status <> Memb.Status::Deceased then begin
                                    //if Memb."Employer Code" = CheckoffAdviceHeader."Employer Code" then begin
                                    Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest", "Total Balance");
                                    if Employer.Get(Memb."Employer Code") then begin
                                        if Employer."Advice Method" = Employer."advice method"::Everything then begin
                                            iEntryNo := 0;
                                            CheckoffAdvice.Reset;
                                            if CheckoffAdvice.Find('+') then
                                                iEntryNo := CheckoffAdvice."Entry No" + 1;

                                            CheckoffAdvice.Init;
                                            CheckoffAdvice."Entry No" := iEntryNo;
                                            CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                            CheckoffAdvice."Account No." := Loans."Loan Account";
                                            CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                            CheckoffAdvice.Validate("Product Type");
                                            CheckoffAdvice."Loan No." := Loans."Loan No.";
                                            if Memb.Get(Loans."Member No.") then
                                                CheckoffAdvice."ID No." := Memb."Primary Identification";
                                            CheckoffAdvice."Member No." := Loans."Member No.";
                                            CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                            CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                            CheckoffAdvice.Names := Loans."Member Name";

                                            //Different Mode of Payment***************
                                            // PaymentMethods.Reset;
                                            // PaymentMethods.SetRange(PaymentMethods."Loan No.", Loans."Loan No.");
                                            // PaymentMethods.SetRange(PaymentMethods."Member No.", Loans."Member No.");
                                            // PaymentMethods.SetRange(PaymentMethods."Payment Method", PaymentMethods."payment method"::Checkoff);
                                            // if PaymentMethods.Find('-') then begin
                                            //     CheckoffAdvice."Amount On" := PaymentMethods.Amount;
                                            // end else

                                            // STOPlaced.Reset();
                                            // STOPlaced.setrange(Status, STOPlaced.Status::Approved);
                                            // STOPlaced.setrange("Member No.", Loans."Member No.");
                                            // if STOPlaced.findfirst then begin
                                            //     repeat
                                            //         STOLines.reset;
                                            //         STOLines.setrange("Document No.", STOPlaced."No.");
                                            //         STOLines.SetRange("Loan No.", Loans."Loan No.");
                                            //         if STOLines.findfirst then begin
                                            //             TotalSTO += STOLines.Amount;
                                            //         end;
                                            //     until STOPlaced.next = 0;
                                            // end;


                                            // if Loans."Recovery Mode" = Loans."Recovery Mode"::Hybrid then
                                            //     CheckoffAdvice."Amount On" := loans.Repayment - Loans."Salary Amount"
                                            // else

                                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                                if Loans."Variated Amount" <> 0 then
                                                    Loans."Loan Principle Repayment" := Loans."Variated Amount";
                                                CheckoffAdvice."Amount On" := loans."Loan Principle Repayment";
                                                //+ Loans."Outstanding Interest" - TotalSTO;
                                                CheckoffAdvice."Total Loan Repayment" := loans."Loan Principle Repayment" + Loans."Outstanding Interest";
                                            end
                                            else begin
                                                if Loans."Variated Amount" <> 0 then
                                                    Loans.Repayment := Loans."Variated Amount";
                                                CheckoffAdvice."Amount On" := loans.Repayment;
                                                // - TotalSTO;
                                                CheckoffAdvice."Total Loan Repayment" := loans.Repayment;
                                            end;

                                            // if Loans.Repayment <> (Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment") then
                                            //     CheckoffAdvice."Amount On" := Loans.Repayment - TotalSTO;

                                            if loans."Total Balance" < CheckoffAdvice."Amount On"
                                            then
                                                CheckoffAdvice."Amount On" := Loans."Total Balance";

                                            CheckoffAdvice."Loan Principle Repayment" := Loans."Loan Principle Repayment";
                                            CheckoffAdvice."Loan Interest Repayment" := Loans."Loan Interest Repayment";
                                            CheckoffAdvice."Amount On" := Round(CheckoffAdvice."Amount On", 1, '>');
                                            CheckoffAdvice."Balance On" := Loans."Outstanding Balance";
                                            CheckoffAdvice."Advice Date" := Today;
                                            if Loans."Outstanding Interest" > InterestAmount then
                                                CheckoffAdvice.Interest := Loans."Outstanding Interest"
                                            else
                                                CheckoffAdvice.Interest := InterestAmount;

                                            CheckoffAdvice."Payroll No" := Loans."Staff No";
                                            //Update Staff numbers
                                            if Memb.Get(Loans."Member No.") then
                                                if Memb."Payroll/Staff No." <> Loans."Staff No" then begin
                                                    CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                    Loans."Staff No" := Memb."Payroll/Staff No.";
                                                    Loans.Modify();
                                                end;

                                            CheckoffAdvice."Standing Order amount" := TotalSTO;
                                            CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
                                            if CheckoffAdvice."Amount On" > 0 then
                                                CheckoffAdvice.Insert;
                                        end;
                                    end;
                                end;
                            end;
                        // end;
                        until Loans.Next = 0;
                    end;
                until Employer2.next = 0;
            end;

        end else begin

            //++++++++++++++++++++++++++++++++++++Advice Everything+++++++++with Employer Code
            Employer.Reset;
            Employer.SetRange(Employer."No.", CheckoffAdviceHeader."Employer Code");
            //Employer.SetRange(Employer."Advice Method", Employer."advice method"::Everything);
            if Employer.Find('-') then begin
                Loans.Reset;
                loans.CalcFields("Total Balance");
                Loans.SetFilter("Total Balance", '>0');
                Loans.SetRange(Loans.Posted, true);
                Loans.SetFilter("Date Filter", '..' + Format(CheckoffAdviceHeader."Loan Interest Cut OFF Date"));
                Loans.SetFilter("Disbursement Date", '..' + Format(CheckoffAdviceHeader."Loan Issue Cut OFF Date"));
                Loans.SetRange(Loans."Employer Code", CheckoffAdviceHeader."Employer Code");
                //Loans.setfilter("Recovery Mode", '%1|%2', Loans."recovery mode"::Checkoff, Loans."recovery mode"::Hybrid);
                Loans.setrange(Loans."Source Unit", Loans."Source Unit"::BOSA);

                repeat
                    TotalSTO := 0;
                    if Memb.Get(Loans."Member No.") then
                        if Memb."Employer Code" = CheckoffAdviceHeader."Employer Code" then begin
                            Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest", "Total Balance");
                            InterestAmount := ROUND(((Loans."Outstanding Balance" * (Loans.Interest * Mdays) / 36500)), 1, '>');
                            if InterestAmount < 0 then
                                InterestAmount := 0;
                            if Employer.Get(Memb."Employer Code") then begin
                                if Employer."Advice Method" = Employer."advice method"::Everything then begin
                                    iEntryNo := 0;
                                    CheckoffAdvice.Reset;
                                    if CheckoffAdvice.Find('+') then
                                        iEntryNo := CheckoffAdvice."Entry No" + 1;

                                    CheckoffAdvice.Init;
                                    CheckoffAdvice."Entry No" := iEntryNo;
                                    CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                    CheckoffAdvice."Account No." := Loans."Loan Account";
                                    CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                    CheckoffAdvice.Validate("Product Type");
                                    CheckoffAdvice."Loan No." := Loans."Loan No.";
                                    if Memb.Get(Loans."Member No.") then
                                        CheckoffAdvice."ID No." := Memb."Primary Identification";
                                    CheckoffAdvice."Member No." := Loans."Member No.";
                                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                    CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                    CheckoffAdvice.Names := Loans."Member Name";

                                    //Different Mode of Payment***************
                                    // PaymentMethods.Reset;
                                    // PaymentMethods.SetRange(PaymentMethods."Loan No.", Loans."Loan No.");
                                    // PaymentMethods.SetRange(PaymentMethods."Member No.", Loans."Member No.");
                                    // PaymentMethods.SetRange(PaymentMethods."Payment Method", PaymentMethods."payment method"::Checkoff);
                                    // if PaymentMethods.Find('-') then begin
                                    //     CheckoffAdvice."Amount On" := PaymentMethods.Amount;
                                    // end else

                                    // STOPlaced.Reset();
                                    // STOPlaced.setrange(Status, STOPlaced.Status::Approved);
                                    // STOPlaced.setrange("Member No.", Loans."Member No.");
                                    // if STOPlaced.findfirst then begin
                                    //     repeat
                                    //         STOLines.reset;
                                    //         STOLines.setrange("Document No.", STOPlaced."No.");
                                    //         STOLines.SetRange("Loan No.", Loans."Loan No.");
                                    //         if STOLines.findfirst then begin
                                    //             TotalSTO += STOLines.Amount;
                                    //         end;
                                    //     until STOPlaced.next = 0;
                                    // end;


                                    // if Loans."Recovery Mode" = Loans."Recovery Mode"::Hybrid then
                                    //     CheckoffAdvice."Amount On" := loans.Repayment - Loans."Salary Amount"
                                    // else
                                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                        if Loans."Variated Amount" <> 0 then
                                            Loans."Loan Principle Repayment" := Loans."Variated Amount";
                                        CheckoffAdvice."Amount On" := loans."Loan Principle Repayment";
                                        //+ Loans."Outstanding Interest" - TotalSTO;
                                        CheckoffAdvice."Total Loan Repayment" := loans."Loan Principle Repayment" + Loans."Outstanding Interest";
                                    end
                                    else begin
                                        if Loans."Variated Amount" <> 0 then
                                            Loans.Repayment := Loans."Variated Amount";
                                        CheckoffAdvice."Amount On" := loans.Repayment;
                                        // - TotalSTO;
                                        CheckoffAdvice."Total Loan Repayment" := loans.Repayment;
                                    end;

                                    CheckoffAdvice."Loan Principle Repayment" := Loans."Loan Principle Repayment";
                                    CheckoffAdvice."Loan Interest Repayment" := Loans."Loan Interest Repayment";
                                    CheckoffAdvice."Amount On" := Round(CheckoffAdvice."Amount On", 1, '>');
                                    CheckoffAdvice."Balance On" := Loans."Outstanding Balance";
                                    CheckoffAdvice."Advice Date" := Today;
                                    if Loans."Outstanding Interest" > InterestAmount then
                                        CheckoffAdvice.Interest := Loans."Outstanding Interest"
                                    else
                                        CheckoffAdvice.Interest := InterestAmount;
                                    // if Loans.HasMoratorium(CheckoffAdviceHeader."End Date") then
                                    //     CheckoffAdvice."Amount On" := 0;
                                    CheckoffAdvice."Amount On" := Round(checkoffAdvice."Amount On", 1, '>');
                                    // CheckoffAdvice.Interest:=Loans."Loan Interest Repayment";
                                    CheckoffAdvice."Payroll No" := Loans."Staff No";
                                    if Memb.Get(Loans."Member No.") then
                                        if Memb."Payroll/Staff No." <> Loans."Staff No" then begin
                                            CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                            Loans."Staff No" := Memb."Payroll/Staff No.";
                                            Loans.Modify();
                                        end;

                                    CheckoffAdvice."Standing Order amount" := TotalSTO;
                                    CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
                                    if CheckoffAdvice."Amount On" > 0 then
                                        CheckoffAdvice.Insert;
                                end;
                            end;
                        end;
                until Loans.Next = 0;
            end;
        end;

    end;
    //++++++++++++++++++++Advice Changes with Employer CODE======

    procedure MonthlyCheckoffAdviceSav(CheckoffAdviceHeader: Record "Checkoff Advice Header")
    var
        Loans: Record Loans;
        Employer: Record Customer;
        CheckoffAdvice: Record "Checkoff Advice Line";
        iEntryNo: Integer;
        ChAdvice: Record "Checkoff Advice Line";
        Employer2: Record Customer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        Employer3: Record Customer;
        MemberClass: Record "Member Classes";
        // PaymentMethods: Record "Payment Methods";
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffAdvice2: Record "Checkoff Advice Line";
        MoratoriumLoan: Record "Moratorium Loan";
        LoopCount: Integer;
        CountNo: Integer;
        CountNo1: Integer;
        STOPlaced: record "Standing Order Header";
        STOLines: record "Standing Order Lines";
        TotalSTO: decimal;

    begin
        Mdays := (CheckoffAdviceHeader."End Date" - CheckoffAdviceHeader."Start Date") + 1;
        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;
        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice.Period, CheckoffAdviceHeader.Period);
        ChAdvice.setfilter("Advice Header No.", '<>%1', '');
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;

        if CheckoffAdviceHeader."Employer Code" = '' then begin
            //Advice Deposits Everything
            Employer2.Reset;
            Employer2.SetRange(Employer2."Advice Method", Employer2."advice method"::Everything);
            if Employer2.Find('-') then begin
                repeat
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Employer Code", Employer2."No.");
                    if SavingsAccounts.Find('-') then begin
                        repeat
                            //Deposit Contr
                            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        if MemberClass."Default BOSA Deposit" > SavingsAccounts."Monthly Contribution" then
                                            CheckoffAdvice."Amount On" := MemberClass."Default BOSA Deposit"
                                        else
                                            CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                    end;
                                end;
                                //**CheckoffAdvice."Amount On":=SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Amount On" <> 0 then
                                    CheckoffAdvice.Insert;
                            end;
                            //Share Cap
                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Share Capital" then begin
                                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        if MemberClass."Share Capital" > SavingsAccounts."Balance (LCY)" then
                                            CheckoffAdvice."Amount On" := MemberClass."Default BOSA Deposit"
                                    end;
                                end;
                                //**CheckoffAdvice."Amount On":=SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Amount On" <> 0 then
                                    CheckoffAdvice.Insert;
                            end;
                            //Reg Fee
                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Entrance Fee" then begin
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");

                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        CheckoffAdvice."Amount On" := MemberClass."Entrance Fee";
                                    end;
                                end;
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Amount On" <> 0 then
                                    CheckoffAdvice.Insert;
                            end;
                        until SavingsAccounts.Next = 0;
                    end;
                until Employer2.Next = 0;
            end;
        end;
    end;

    procedure MonthlyCheckoffAdviceSavAPI(CheckoffAdviceHeader: Record "Checkoff Advice Header")
    var
        Loans: Record Loans;
        Employer: Record Customer;
        CheckoffAdvice: Record "Checkoff Advice Line";
        iEntryNo: Integer;
        ChAdvice: Record "Checkoff Advice Line";
        Employer2: Record Customer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        Employer3: Record Customer;
        MemberClass: Record "Member Classes";
        // PaymentMethods: Record "Payment Methods";
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffAdvice2: Record "Checkoff Advice Line";
        MoratoriumLoan: Record "Moratorium Loan";
        LoopCount: Integer;
        CountNo: Integer;
        CountNo1: Integer;
        STOPlaced: record "Standing Order Header";
        STOLines: record "Standing Order Lines";
        TotalSTO: decimal;

    begin
        Mdays := (CheckoffAdviceHeader."End Date" - CheckoffAdviceHeader."Start Date") + 1;
        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;
        ChAdvice.Reset;
        ChAdvice.SetRange(ChAdvice.Period, CheckoffAdviceHeader.Period);
        ChAdvice.setfilter("Advice Header No.", '<>%1', '');
        if ChAdvice.Find('-') then begin
            ChAdvice.DeleteAll;
        end;

        if CheckoffAdviceHeader."Employer Code" <> '' then begin
            //Advice Deposits Everything
            Employer2.Reset;
            Employer2.SetRange("No.", CheckoffAdviceHeader."Employer Code");
            //Employer2.SetRange(Employer2."Advice Method", Employer2."advice method"::Everything);
            if Employer2.Find('-') then begin
                repeat
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Employer Code", Employer2."No.");
                    if SavingsAccounts.Find('-') then begin
                        repeat
                            //Deposit Contr
                            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        if MemberClass."Default BOSA Deposit" > SavingsAccounts."Monthly Contribution" then
                                            CheckoffAdvice."Amount On" := MemberClass."Default BOSA Deposit"
                                        else
                                            CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                    end;
                                end;
                                //**CheckoffAdvice."Amount On":=SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Payroll No" = '' then begin
                                    if Memb.Get(SavingsAccounts."Member No.") then
                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                end;
                                if (CheckoffAdvice."Amount On" <> 0) and (CheckoffAdvice."Payroll No" <> '') then
                                    CheckoffAdvice.Insert;
                            end;
                            //Share Cap
                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Share Capital" then begin
                                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        if MemberClass."Share Capital" > SavingsAccounts."Balance (LCY)" then
                                            CheckoffAdvice."Amount On" := MemberClass."Default BOSA Deposit"
                                    end;
                                end;
                                //**CheckoffAdvice."Amount On":=SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Payroll No" = '' then begin
                                    if Memb.Get(SavingsAccounts."Member No.") then
                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                end;
                                if (CheckoffAdvice."Amount On" <> 0) and (CheckoffAdvice."Payroll No" <> '') then
                                    CheckoffAdvice.Insert;
                            end;
                            //Reg Fee
                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Entrance Fee" then begin
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");

                                if Memb.Get(SavingsAccounts."Member No.") then begin
                                    MemberClass.Reset;
                                    MemberClass.SetRange(MemberClass."No.", Memb."Member Class");
                                    if MemberClass.Find('-') then begin
                                        CheckoffAdvice."Amount On" := MemberClass."Entrance Fee";
                                    end;
                                end;
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                if SavingsAccounts."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";

                                SavingsAccounts.CalcFields("Balance (LCY)");
                                if Abs(SavingsAccounts."Balance (LCY)") < CheckoffAdvice."Amount On" then begin
                                    CheckoffAdvice."Amount On" := CheckoffAdvice."Amount On" - Abs(SavingsAccounts."Balance (LCY)");
                                end else begin
                                    CheckoffAdvice."Amount On" := 0;
                                end;

                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := Employer2."No.";
                                CheckoffAdvice.Names := SavingsAccounts.Name;
                                CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
                                if CheckoffAdvice."Payroll No" = '' then begin
                                    if Memb.Get(SavingsAccounts."Member No.") then
                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                end;
                                if (CheckoffAdvice."Amount On" <> 0) and (CheckoffAdvice."Payroll No" <> '') and (Memb.Status = Memb.Status::New) then
                                    CheckoffAdvice.Insert;
                            end;
                        until SavingsAccounts.Next = 0;
                    end;
                until Employer2.Next = 0;
            end;
        end;
    end;


    procedure CheckoffValidate(CheckoffBuffer: Record "Checkoff Buffer")
    var
        Buffer: Record "Checkoff Buffer";
        Loans: Record Loans;
        SAccount: Record "Savings Accounts";
        LAccount: Record "Credit Accounts";
        Memb: Record Members;
        PFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        Txt0000: label 'Enter either the Id No,Payroll No or Member No before validating';
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
        Txt0001: label 'This buffer contains %1 record(s) not validated';
        ProductIDCode: Code[10];
        Members: Record Members;
        MemberNo: Code[20];
    begin
        //Buffer.COUNT;

        //Creating Progress Bar------------------------------------
        intProgressTotal := Buffer.Count;
        diaProgress.Open(Genrating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
        intProgressI := 0;
        TimeProgress := Time;
        NoOfRecsProgress := intProgressTotal DIV 100;
        NoOfProgressed := 0;

        //Creating Progress Bar-------------------------------------

        MemberNo := '';
        Buffer.Reset;
        Buffer.SetRange(Buffer."Checkoff No", CheckoffBuffer."Checkoff No");
        //Buffer.SETRANGE(No,'19');
        if Buffer.Find('-') then begin
            repeat
                //Progress-------------------------------
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := Time;
                end;
                //Progress------------------------------


                // IF (Buffer.Payroll='') AND (Buffer."Member No."='') AND (Buffer."ID No."='') THEN
                if (Buffer."Upload No." = '') and (Buffer."Upload Response" <> 0) then
                    Error(Txt0000);

                ///Filling the Details
                if Buffer."Upload Response" = 2 then begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", Buffer."Upload No.");
                    //Memb.SETRANGE(Status,Memb.Status::Active);
                    if Memb.Find('-') then begin
                        Buffer.Name := Memb.Name;
                        Buffer.Payroll := Memb."Payroll/Staff No.";
                        Buffer."Employer Code" := Memb."Employer Code";
                        Buffer."ID No." := Memb."Primary Identification";
                        Buffer."Member No." := Memb."No.";
                        Buffer."Record Found" := true;
                        MemberNo := Memb."No.";
                    end else
                        Buffer."Record Found" := false;
                end else
                    if Buffer."Upload Response" = 1 then begin
                        Buffer.TestField("Employer Code");
                        Memb.Reset;
                        Memb.SetRange(Memb."Payroll/Staff No.", Buffer."Upload No.");
                        Memb.SetRange("Employer Code", Buffer."Employer Code");
                        //Memb.SETRANGE(Status,Memb.Status::Active);
                        if Memb.Find('-') then begin
                            Buffer.Name := Memb.Name;
                            Buffer."Member No." := Memb."No.";
                            Buffer."Employer Code" := Memb."Employer Code";
                            Buffer.Payroll := Memb."Payroll/Staff No.";
                            Buffer."ID No." := Memb."Primary Identification";
                            Buffer."Record Found" := true;
                            Buffer."Loan No" := '';
                            MemberNo := Memb."No.";
                            //Buffer.MODIFY;
                        end else
                            Buffer."Record Found" := false;
                    end else
                        if Buffer."Upload Response" = 3 then begin
                            Memb.Reset;
                            Memb.SetRange(Memb."Primary Identification", Buffer."Upload No.");
                            //Memb.SETRANGE(Status,Memb.Status::Active);
                            if Memb.Find('-') then begin
                                Buffer.Name := Memb.Name;
                                Buffer."Member No." := Memb."No.";
                                Buffer."Employer Code" := Memb."Employer Code";
                                Buffer.Payroll := Memb."Payroll/Staff No.";
                                Buffer."ID No." := Memb."Primary Identification";
                                Buffer."Record Found" := true;
                                MemberNo := Memb."No.";
                                //Buffer.MODIFY;
                            end else
                                Buffer."Record Found" := false;
                        end;

                //Buffer.MODIFY;
                //-------Start Product Search;
                if Buffer."Search Code" <> '' then begin
                    PFactory.Reset;
                    PFactory.SetRange(PFactory."Search Code", Buffer."Search Code");
                    if PFactory.Find('-') then begin
                        if PFactory."Product Class Type" = PFactory."product class type"::Loan then begin
                            Loans.Reset;
                            Loans.SetFilter(Loans."Outstanding Balance", '>0');
                            Loans.SetRange(Loans."Member No.", MemberNo);// Buffer."Member No.");
                            Loans.SetRange("Dummy Appraisal", false);
                            Loans.SetFilter("Member No.", '<>%1', '');
                            Loans.SetRange(Loans."Loan Product Type", PFactory."Product ID");
                            if Loans.Find('-') then begin
                                repeat
                                    Buffer."Loan No" := Loans."Loan No.";
                                    Buffer."Member No." := Loans."Member No.";
                                    Buffer.Payroll := Loans."Staff No";
                                    Buffer."ID No." := Loans."ID No.";
                                    Buffer.Modify;
                                until Loans.Next = 0;
                            end;
                        end;

                        if PFactory."Product Class Type" = PFactory."product class type"::Savings then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberNo);// Buffer."Member No.");
                            if SavingsAccounts.Find('-') then begin
                                Buffer."Savings Account" := true;
                                Buffer."Account No" := SavingsAccounts."No.";
                                Buffer."Member No." := SavingsAccounts."Member No.";
                            end;
                        end;
                    end;
                end else begin
                    //------------------------------------------+++++
                    //++++++++++++++++++Type
                    // ProductIDCode:='';
                    PFactory.Reset;
                    PFactory.SetRange("Product Class Type", PFactory."product class type"::Savings);
                    if PFactory.Find('-') then begin
                        repeat
                            if Buffer.Type = Buffer.Type::sShare then begin
                                if PFactory."Product Category" = PFactory."Product Category"::"BOSA Deposits" then begin
                                    ProductIDCode := PFactory."Product ID";
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberNo);//, Buffer."Member No.");
                                    if SavingsAccounts.Find('-') then begin
                                        Buffer."Savings Account" := true;
                                        Buffer."Account No" := SavingsAccounts."No.";
                                    end;
                                end;
                                if Members.Get(Buffer."Member No.") then begin
                                    if (Members.Status = Members.Status::Closed) or (Members.Status = Members.Status::Closed) then begin
                                        SavingsAccounts.Reset;
                                        SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberNo);//, Buffer."Member No.");
                                        if SavingsAccounts.Find('-') then begin
                                            Buffer."Savings Account" := true;
                                            Buffer."Account No" := SavingsAccounts."No.";
                                        end;
                                    end;
                                end;
                            end;
                            if Buffer.Type = Buffer.Type::wCont then begin
                                if PFactory."Product Category" = PFactory."Product Category"::"Benevolent (BBF)" then begin
                                    ProductIDCode := PFactory."Product ID";

                                    ProductIDCode := PFactory."Product ID";
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Buffer."Member No.");
                                    if SavingsAccounts.Find('-') then begin
                                        Buffer."Savings Account" := true;
                                        Buffer."Account No" := SavingsAccounts."No.";
                                    end;
                                end;
                                if Members.Get(Buffer."Member No.") then begin
                                    if (Members.Status = Members.Status::Closed) or (Members.Status = Members.Status::Closed) then begin
                                        SavingsAccounts.Reset;
                                        SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", Buffer."Member No.");
                                        if SavingsAccounts.Find('-') then begin
                                            Buffer."Savings Account" := true;
                                            Buffer."Account No" := SavingsAccounts."No.";
                                        end;
                                    end;
                                end;
                            end;
                            if Buffer.Type = Buffer.Type::sJoining then begin
                                if PFactory."Product Category" = PFactory."product category"::"Entrance Fee" then begin
                                    ProductIDCode := PFactory."Product ID";
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Buffer."Member No.");
                                    if SavingsAccounts.Find('-') then begin
                                        Buffer."Savings Account" := true;
                                        Buffer."Account No" := SavingsAccounts."No.";
                                    end;
                                end;
                            end;

                            if Buffer.Type = Buffer.Type::wLoan then begin
                                if PFactory."Product Category" = PFactory."product category"::"Share Capital" then begin
                                    ProductIDCode := PFactory."Product ID";
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Buffer."Member No.");
                                    if SavingsAccounts.Find('-') then begin
                                        Buffer."Savings Account" := true;
                                        Buffer."Account No" := SavingsAccounts."No.";
                                    end;
                                end;
                            end;
                        until PFactory.Next = 0;
                    end;
                END;
                //END;
                ///-----End Product Search
                if Buffer."Savings Account" = false then begin
                    if Loans.Get(Buffer."Loan No") then begin
                        Buffer."Account No" := Loans."Loan Account";
                        Buffer."Credit Account" := true;
                    end else begin
                        Loans.Reset;
                        Loans.SetRange("Employer Loan No.", Buffer."Loan No");
                        Loans.SetRange("Dummy Appraisal", false);
                        Loans.SetRange("Member No.", Buffer."Member No.");
                        Loans.SetFilter("Outstanding Balance", '>%1', 0);
                        Loans.SetFilter("Member No.", '<>%1', '');
                        if Loans.Find('-') then begin
                            Buffer."Loan No" := Loans."Loan No.";
                            Buffer."Account No" := Loans."Loan Account";
                            Buffer."Credit Account" := true;
                        end else begin
                            if Buffer."Savings Account" = false then
                                Buffer."Record Found" := false
                            else
                                Buffer."Record Found" := true;
                        end;
                    end;
                end;
                if Members.Get(Buffer."Member No.") then begin
                    // if Members.Status = Members.Status::New then begin
                    //     Members.Status := Members.Status::Active;
                    //     Members.Modify;
                    // end;
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Members."No.");
                    SavingsAccounts.SetRange(Status, SavingsAccounts.Status::New);
                    if SavingsAccounts.Find('-') then begin
                        repeat
                            SavingsAccounts.Status := SavingsAccounts.Status::Active;
                            SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
                            SavingsAccounts.Modify;
                        until SavingsAccounts.Next = 0;
                    end;


                end;
                Buffer.Modify;
            until Buffer.Next = 0;
        end;


        diaProgress.Close;
        Buffer.Reset;
        Buffer.SetRange("Record Found", false);
        if Buffer.Find('-') then
            if Buffer.Count > 0 then
                Message(Txt0001, Buffer.Count);
    end;

    //New Validation
    procedure NewCheckoffValidate(CheckoffHeader: Record "Checkoff Header")
    var
        Buffer: Record "Checkoff Buffer";
        Loans: Record Loans;
        SAccount: Record "Savings Accounts";
        LAccount: Record "Credit Accounts";
        Memb: Record Members;
        PFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        Txt0000: label 'Enter either the Id No,Payroll No or Member No before validating';
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
        Txt0001: label 'This buffer contains %1 record(s) not validated';
        ProductIDCode: Code[10];
        Members: Record Members;
        MembersII: Record Members;
        MemberNo: Code[20];
    begin
        //Buffer.COUNT;

        //Creating Progress Bar------------------------------------
        Buffer.SetRange(Buffer."Checkoff No", CheckoffHeader."No.");
        intProgressTotal := Buffer.Count;
        diaProgress.Open(Genrating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
        intProgressI := 0;
        TimeProgress := Time;
        NoOfRecsProgress := intProgressTotal DIV 100;
        NoOfProgressed := 0;

        //Creating Progress Bar-------------------------------------

        MemberNo := '';
        Buffer.Reset;
        Buffer.SetRange(Buffer."Checkoff No", CheckoffHeader."No.");
        if Buffer.FindSet() then begin
            repeat
                Buffer."Loan No" := '';
                MemberNo := Buffer."Member No.";
                Buffer."Member No." := '';
                Buffer."Account No" := '';
                Buffer.Payroll := '';
                Buffer."ID No." := '';
                Buffer.Name := '';
                Buffer."Credit Account" := false;
                Buffer."Savings Account" := false;
                Buffer."Record Found" := false;
                //Progress-------------------------------
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := Time;
                end;
                //Progress------------------------------
                if (Buffer."Upload No." = '') and (Buffer."Upload Response" <> 0) then
                    Error(Txt0000);

                ///Filling the Details
                // MemberNo := '';
                if Buffer."Upload Response" = 3 then begin
                    Buffer.TestField("Employer Code");
                    Memb.Reset;
                    Memb.SetRange(Memb."Payroll/Staff No.", Buffer."Upload No.");
                    Memb.SetRange("Employer Code", Buffer."Employer Code");
                    if Memb.Find('-') then begin
                        MemberNo := Memb."No.";
                    end;
                end else
                    if Buffer."Upload Response" = 2 then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", Buffer."Upload No.");
                        if Memb.Find('-') then begin
                            MemberNo := Memb."No.";
                        end;
                    end else
                        if Buffer."Upload Response" = 4 then begin
                            Memb.Reset;
                            Memb.SetRange(Memb."Primary Identification", Buffer."Upload No.");
                            if Memb.Find('-') then begin
                                MemberNo := Memb."No.";
                            end;
                        end;
                if MemberNo <> '' then begin
                    Buffer."Other Comments" := 'Member No. Not found.';
                    // if Buffer."Product Code" <> '' then begin
                    if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Loans then begin
                        // PFactory.Reset;
                        // if Buffer."Product Code" <> '' then begin
                        //     PFactory.SetRange(PFactory."Product ID", Buffer."Product Code");
                        // if Buffer."Product Code" <> '' then
                        //     PFactory.SetRange("Product ID", Buffer."Product Code");
                        // if PFactory.Find('-') then begin
                        // if PFactory."Product Class Type" = PFactory."product class type"::Loan then begin
                        if MemberNo <> '' then begin
                            Loans.Reset;
                            Loans.SetRange(Loans."Member No.", MemberNo);
                            loans.CalcFields("Total Loan Balance");
                            Loans.SetFilter(Loans."Total Loan Balance", '>0');
                            // Buffer."Member No.");
                            Loans.SetRange(Loans."Loan Product Type", Buffer."Product Code");
                            if Loans.FindFirst() then begin
                                // repeat
                                Buffer."Loan No" := Loans."Loan No.";
                                Buffer."Member No." := Loans."Member No.";
                                Buffer."Account No" := Loans."Loan Account";
                                Buffer.Payroll := Loans."Staff No";
                                Buffer."ID No." := Loans."ID No.";
                                Buffer."Credit Account" := true;
                                Buffer."Savings Account" := false;
                                Buffer."Record Found" := true;
                                Buffer.Name := Loans."Member Name";
                                Buffer."Other Comments" := '';
                                // until Loans.Next = 0;
                            end else begin
                                //Loan Not found
                                Buffer."Member No." := MemberNo;
                                Buffer."Credit Account" := false;
                                Buffer."Other Comments" := 'There is no outstanding loan for the menber';
                                Buffer."Savings Account" := true;
                            end;
                        end else
                            Buffer."Other Comments" := 'Member No. not found';
                        // end;
                        // end;
                        // end else begin
                        if Members.get(MemberNo) then begin
                            Buffer."Loan No" := '';
                            Buffer."Member No." := MemberNo;
                            Buffer."Account No" := '';
                            Buffer.Payroll := Members."Payroll/Staff No.";
                            Buffer."ID No." := Members."Primary Identification";
                            Buffer."Credit Account" := true;
                            Buffer."Savings Account" := false;
                            Buffer."Record Found" := true;
                            Buffer.Name := Members.name;
                        end
                        else begin
                            Buffer."Other Comments" := 'Member No. not found';
                        end;
                        // end;
                    end else
                        if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Savings then begin
                            if Buffer."Product Code" <> '' then begin
                                PFactory.Reset;
                                PFactory.SetRange(PFactory."Product ID", Buffer."Product Code");
                                PFactory.SetRange("Product Class Type", PFactory."Product Class Type"::Savings);
                                // if Buffer."Product Code" <> '' then
                                //     PFactory.SetRange("Product ID", Buffer."Product Code");
                                if PFactory.Find('-') then begin

                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", PFactory."Product ID");
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberNo);// Buffer."Member No.");
                                    if SavingsAccounts.FindSet() then begin
                                        if Buffer."Product Code" = PFactory."Product ID" then begin
                                            Buffer."Loan No" := '';
                                            Buffer."Member No." := MemberNo;
                                            Buffer."Account No" := SavingsAccounts."No.";
                                            // if (SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::Risk) then
                                            //     Buffer.Status := SavingsAccounts.Status::Active
                                            // else
                                            //     if (SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)") then
                                            //         Buffer.Status := SavingsAccounts.Status::Active
                                            //     else
                                            Buffer.Status := SavingsAccounts.Status;
                                            Buffer.Payroll := SavingsAccounts."Payroll/Staff No.";
                                            Buffer.Name := SavingsAccounts.Name;
                                            Buffer."ID No." := SavingsAccounts."ID No.";
                                            Buffer."Credit Account" := false;
                                            Buffer."Savings Account" := true;
                                            Buffer."Record Found" := true;
                                            Buffer."Other Comments" := '';
                                        end Else begin
                                            Buffer."Other Comments" := 'Product Code Mismatch.';
                                        end;

                                    end else
                                        Buffer."Other Comments" := 'Account not found.';
                                end else
                                    Buffer."Other Comments" := 'Product Not found.';
                            end
                            else begin
                                Buffer."Other Comments" := 'Product Code not entered.';
                            end;
                        end else
                            if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Lumpsum then begin
                                MembersII.Reset;
                                MembersII.SetRange("No.", MemberNo);// Buffer."Member No.");
                                if MembersII.Find('-') then begin
                                    Buffer."Loan No" := '';
                                    Buffer."Member No." := MemberNo;
                                    Buffer."Account No" := MembersII."No.";
                                    Buffer.Payroll := MembersII."Payroll/Staff No.";
                                    Buffer.Name := MembersII.Name;
                                    Buffer."ID No." := MembersII."Primary Identification";
                                    Buffer."Credit Account" := false;
                                    Buffer."Savings Account" := false;
                                    Buffer."Record Found" := true;
                                    // Buffer.Status := MembersII.Status;
                                end else
                                    Buffer."Other Comments" := 'Member No. Not found.';
                            end;
                    // end ELSE begin// No search code for lumpsum
                    if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Lumpsum then begin
                        MembersII.Reset;
                        MembersII.SetRange("No.", MemberNo);// Buffer."Member No.");
                        if MembersII.Find('-') then begin
                            Buffer."Loan No" := '';
                            Buffer."Member No." := MemberNo;
                            Buffer."Account No" := MembersII."No.";
                            Buffer.Payroll := MembersII."Payroll/Staff No.";
                            Buffer.Name := MembersII.Name;
                            Buffer."ID No." := MembersII."Primary Identification";
                            Buffer."Credit Account" := false;
                            Buffer."Savings Account" := false;
                            Buffer."Record Found" := true;
                            // Buffer.Status := MembersII.Status;
                        end else
                            Buffer."Other Comments" := 'Member No. Not found.';
                        // end;
                    end;

                end
                else
                    Buffer."Other Comments" := 'Member was not found/Wrong Employer code';
                Buffer.Modify;
            until Buffer.Next = 0;
        end;


        diaProgress.Close;
        Buffer.Reset;
        Buffer.SetRange("Record Found", false);
        Buffer.SetRange("Checkoff No", CheckoffHeader."No.");
        if Buffer.Find('-') then
            if Buffer.Count > 0 then
                Message(Txt0001, Buffer.Count);
    end;
    //New Validation
    procedure GenerateCheckoff(checkoffHeader: Record "Checkoff Header")
    var
        CheckoffLines: Record "Checkoff Lines";
        CheckoffBuffer: Record "Checkoff Buffer";
        Members: Record Members;
        CheckoffBuffer2: Record "Checkoff Buffer";
        EntryNo: Integer;
        CheckoffLines2: Record "Checkoff Lines";
        Err0001: label 'There are records that have not been Validated';
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        remAmt: decimal;
        TransType: enum "Transaction Types";
        UnallocatedAccount: code[100];
        Pfact: Record "Product Factory";
        MemberRegistration: codeunit "Registration Process";
        STOLines: record "Standing Order Lines";
        STOPlaced: record "Standing Order Header";
        TotalSTO: Decimal;
    begin

        //Delete Entries
        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", checkoffHeader."No.");
        CheckoffLines.DeleteAll;
        //delete Entries

        if checkoffHeader.Source <> checkoffHeader.Source::"Amali NCBA" then begin
            CheckoffBuffer.Reset;
            CheckoffBuffer.SetRange("Checkoff No", checkoffHeader."No.");
            CheckoffBuffer.SetRange("Member No.", '');
            if CheckoffBuffer.FindFirst then
                Error(Err0001);
        end;

        CheckoffBuffer.Reset;
        CheckoffBuffer.SetRange(CheckoffBuffer."Checkoff No", checkoffHeader."No.");
        if CheckoffBuffer.FindSet() then begin
            //ProgressWindow.OPEN('Processing check off for Entry No: #1#######');
            repeat
                // CheckoffBuffer.TESTFIELD(CheckoffBuffer."Search Code");
                // CheckoffBuffer.TESTFIELD(CheckoffBuffer."Employer Code");
                // CheckoffBuffer.TESTFIELD(CheckoffBuffer."Member No.");
                Members.Reset;
                Members.SetRange(Members."No.", CheckoffBuffer."Member No.");
                if Members.Find('-') then begin
                    CheckoffBuffer2.Reset;
                    CheckoffBuffer2.SetRange(CheckoffBuffer2."Checkoff No", CheckoffBuffer."Checkoff No");
                    CheckoffBuffer2.SetRange(CheckoffBuffer2.No, CheckoffBuffer.No);
                    CheckoffBuffer2.SetRange(CheckoffBuffer2."Member No.", Members."No.");
                    if CheckoffBuffer2.FindSet() then begin

                        if checkoffHeader."CheckOff Type" <> checkoffHeader."CheckOff Type"::Loans then begin
                            // REPEAT
                            CheckoffLines.Reset;
                            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffBuffer2."Checkoff No");
                            CheckoffLines.SetRange(CheckoffLines."Member No.", CheckoffBuffer2."Member No.");
                            CheckoffLines.SetRange(CheckoffLines.Multiple, false);
                            if CheckoffLines.Find('-') then begin

                                CheckoffLines.Amount := CheckoffLines.Amount + CheckoffBuffer2.Amount + CheckoffBuffer2.Interest;
                                CheckoffLines.Modify;
                            end else begin
                                EntryNo := 1;
                                CheckoffLines2.Reset;
                                CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer2."Checkoff No");
                                if CheckoffLines2.Find('+') then
                                    EntryNo := CheckoffLines2."Entry No" + 1;

                                CheckoffLines.Init;
                                CheckoffLines."Entry No" := EntryNo;
                                CheckoffLines.Amount := CheckoffBuffer2.Amount + CheckoffBuffer2.Interest;
                                CheckoffLines."Account No." := CheckoffBuffer2."Account No";
                                //IF CheckoffBuffer2."Account No"<>'' THEN
                                CheckoffLines.Multiple := true;
                                CheckoffLines."Loan No." := CheckoffBuffer2."Loan No";
                                if CheckoffBuffer2."Loan No" <> '' then begin
                                    CheckoffLines."Clears Loan" := AmountClearsLoanIfPosted(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount);
                                    if CheckoffLines."Clears Loan" then
                                        CheckoffLines."Refundable Amount" := ABS(GetLoanBalanceAfterPosting(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount));
                                end;
                                CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                CheckoffLines."ID Number" := CheckoffBuffer2."ID No.";
                                CheckoffLines."Member No." := CheckoffBuffer2."Member No.";
                                CheckoffLines."Savings Account" := CheckoffBuffer2."Savings Account";
                                CheckoffLines."Credit Account" := CheckoffBuffer2."Credit Account";
                                CheckoffLines."Checkoff Header" := CheckoffBuffer2."Checkoff No";
                                CheckoffLines.Type := CheckoffBuffer.Type;
                                CheckoffLines.Name := CheckoffBuffer2.Name;
                                CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                CheckoffLines."Employer Code" := CheckoffBuffer2."Employer Code";
                                CheckoffLines.Remarks := CheckoffBuffer2.Remarks;
                                CheckoffLines."Product Code" := CheckoffBuffer2."Search Code";
                                CheckoffLines.Insert;
                            end;
                        end
                        else begin
                            // REPEAT
                            CheckoffLines.Reset;
                            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffBuffer2."Checkoff No");
                            CheckoffLines.SetRange(CheckoffLines."Member No.", CheckoffBuffer2."Member No.");
                            CheckoffLines.SetRange(CheckoffLines.Multiple, false);
                            if CheckoffLines.Find('-') then begin
                                // CheckoffLines.Amount := CheckoffLines.Amount + CheckoffBuffer2.Amount + CheckoffBuffer2.Interest;
                                CheckoffLines.DeleteAll();
                            end;
                            //end else begin
                            //
                            remAmt := CheckoffBuffer.Amount;
                            //
                            if remAmt > 0 then begin
                                loans.reset;
                                loans.setrange("Member No.", CheckoffBuffer2."Member No.");
                                //loans.setfilter("Recovery Mode", '%1|%2', loans."Recovery Mode"::Checkoff, loans."Recovery Mode"::Hybrid);
                                // Loans.Setrange("Source Unit", Loans."Source Unit"::BOSA);
                                Loans.setrange("Loan Product Type", CheckoffBuffer2."Product Code");
                                Loans.SetCurrentKey("Disbursement Date");
                                Loans.SetAscending("Disbursement Date", true);
                                loans.SetFilter("Disbursement Date", '<=%1', checkoffHeader."Loan Cutoff Date");
                                Loans.CalcFields("Total Loan Balance");
                                //loans.SetRange(pa);
                                // Loans.SetRange(Posted, false);
                                Loans.SetFilter("Total Loan Balance", '>0');
                                if Loans.FindFirst() then begin
                                    repeat
                                        if remAmt > 0 then begin
                                            // loans.CalcFields("Total Balance", "Outstanding Balance", "Outstanding Interest");
                                            //if loans."Outstanding Interest" > 0 then begin
                                            EntryNo := 1;
                                            CheckoffLines2.Reset;
                                            CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer2."Checkoff No");
                                            if CheckoffLines2.Find('+') then
                                                EntryNo := CheckoffLines2."Entry No" + 1;

                                            CheckoffLines.Init;
                                            CheckoffLines."Entry No" := EntryNo;
                                            if loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                                Loans.calcfields("Outstanding Interest");
                                                CheckoffLines.Amount := Loans."Loan Principle Repayment" + Loans."Outstanding Interest";
                                            end
                                            else
                                                CheckoffLines.Amount := Loans.Repayment;

                                            // TotalSTO := 0;
                                            // STOPlaced.Reset();
                                            // STOPlaced.setrange(Status, STOPlaced.Status::Approved);
                                            // STOPlaced.setrange("Member No.", Loans."Member No.");
                                            // if STOPlaced.findfirst then begin
                                            //     repeat
                                            //         STOLines.reset;
                                            //         STOLines.setrange("Document No.", STOPlaced."No.");
                                            //         STOLines.SetRange("Loan No.", Loans."Loan No.");
                                            //         if STOLines.findfirst then begin
                                            //             TotalSTO += STOLines.Amount;
                                            //         end;
                                            //     until STOPlaced.next = 0;
                                            // end;

                                            // CheckoffLines.Amount := CheckoffLines.Amount - TotalSTO;
                                            if CheckoffLines.Amount < 0 then begin
                                                CheckoffLines.Amount := 0;
                                            end;

                                            if CheckoffLines.Amount > remAmt then begin
                                                CheckoffLines."Loan Underpayment amount" := CheckoffLines.Amount - remAmt;
                                                CheckoffLines.Amount := remAmt;
                                                remAmt := 0;
                                            end
                                            else
                                                remAmt -= CheckoffLines.Amount;
                                            // CheckoffLines.Amount := CheckoffBuffer2.Amount + CheckoffBuffer2.Interest;
                                            CheckoffLines."Account No." := Loans."Loan Account";
                                            //IF CheckoffBuffer2."Account No"<>'' THEN
                                            CheckoffLines.Multiple := true;
                                            CheckoffLines."Loan No." := Loans."Loan No.";
                                            CheckoffLines."Payroll No." := Loans."Staff No";
                                            CheckoffLines."ID Number" := Loans."ID No.";
                                            CheckoffLines."Member No." := Loans."Member No.";
                                            CheckoffLines."Savings Account" := false;
                                            CheckoffLines."Credit Account" := true;
                                            CheckoffLines."Checkoff Header" := checkoffHeader."No.";
                                            CheckoffLines.Type := checkoffHeader.Type;
                                            CheckoffLines.Name := Loans."Member Name";
                                            //CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                            CheckoffLines."Employer Code" := CheckoffBuffer2."Employer Code";
                                            CheckoffLines.Remarks := CheckoffBuffer2.Remarks;
                                            CheckoffLines."Product Code" := Loans."Loan Product Type";
                                            // CheckoffLines."Transaction Type" := TransType::"Interest Paid";
                                            CheckoffLines.Insert;

                                        end;
                                    until Loans.Next() = 0;
                                end;
                                // Get loan Arrears
                                // loans.reset;
                                // loans.setrange("Member No.", CheckoffBuffer2."Member No.");
                                // loans.setfilter("Recovery Mode", '%1|%2', loans."Recovery Mode"::Checkoff, loans."Recovery Mode"::Hybrid);
                                // Loans.SetCurrentKey("Disbursement Date");
                                // Loans.SetAscending("Disbursement Date", true);
                                // loans.SetAutoCalcFields("Total Loan Balance", "Amount In Arreas SACCO");
                                // //loans.SetRange(pa);
                                // // Loans.SetRange(Posted, false);
                                // Loans.SetFilter("Total Loan Balance", '>0');
                                // loans.setfilter("Amount In Arreas SACCO", '>0');
                                // if Loans.FindFirst() then begin
                                //     repeat
                                //         if remAmt > 0 then begin
                                //             EntryNo := 1;
                                //             CheckoffLines2.Reset;
                                //             CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer2."Checkoff No");
                                //             if CheckoffLines2.Find('+') then
                                //                 EntryNo := CheckoffLines2."Entry No" + 1;

                                //             CheckoffLines.Init;
                                //             CheckoffLines."Entry No" := EntryNo;
                                //             if remAmt > Loans."Amount In Arreas SACCO" then begin
                                //                 CheckoffLines.Amount := Loans."Amount In Arreas SACCO";
                                //                 remAmt := remAmt - Loans."Amount In Arreas SACCO";
                                //             end
                                //             else begin
                                //                 CheckoffLines.Amount := remAmt;
                                //                 remAmt := 0;
                                //             end;

                                //             // CheckoffLines.Amount := CheckoffBuffer2.Amount + CheckoffBuffer2.Interest;
                                //             CheckoffLines."Account No." := Loans."Loan Account";
                                //             //IF CheckoffBuffer2."Account No"<>'' THEN
                                //             CheckoffLines.Multiple := true;
                                //             CheckoffLines."Loan No." := Loans."Loan No.";
                                //             CheckoffLines."Payroll No." := Loans."Staff No";
                                //             CheckoffLines."ID Number" := Loans."ID No.";
                                //             CheckoffLines."Member No." := Loans."Member No.";
                                //             CheckoffLines."Savings Account" := false;
                                //             CheckoffLines."Credit Account" := true;
                                //             CheckoffLines."Checkoff Header" := checkoffHeader."No.";
                                //             CheckoffLines.Type := checkoffHeader.Type;
                                //             CheckoffLines.Name := Loans."Member Name";
                                //             //CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                //             CheckoffLines."Employer Code" := CheckoffBuffer2."Employer Code";
                                //             CheckoffLines.Remarks := CheckoffBuffer2.Remarks;
                                //             CheckoffLines."Product Code" := Loans."Loan Product Type";
                                //             // CheckoffLines."Transaction Type" := TransType::"Interest Paid";
                                //             CheckoffLines.Insert;

                                //         end;
                                //     until Loans.Next() = 0;
                                // end;

                                if remAmt > 0 then begin
                                    // if remAmt > 500 then begin
                                    UnallocatedAccount := '';
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Members."No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"BOSA Deposits");
                                    if SavingsAccounts.Find('-') then begin
                                        UnallocatedAccount := SavingsAccounts."No.";
                                    end else begin
                                        Pfact.reset;
                                        Pfact.SetRange("Product Category", Pfact."Product Category"::"BOSA Deposits");
                                        Pfact.SetRange(status, Pfact.status::Active);
                                        if Pfact.find('-') then begin

                                            UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", Members."Global Dimension 1 Code", Members."No.");
                                            MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, Members."No.", Pfact."Product ID");
                                        end;
                                    end;
                                    // Unallocatd Fund
                                    EntryNo := 1;
                                    CheckoffLines2.Reset;
                                    CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer2."Checkoff No");
                                    if CheckoffLines2.Find('+') then
                                        EntryNo := CheckoffLines2."Entry No" + 1;

                                    CheckoffLines.Init;
                                    CheckoffLines."Entry No" := EntryNo;
                                    CheckoffLines.Amount := remAmt;
                                    CheckoffLines."Account No." := SavingsAccounts."No.";
                                    //IF CheckoffBuffer2."Account No"<>'' THEN
                                    CheckoffLines.Multiple := true;
                                    CheckoffLines."Loan No." := '';
                                    // if CheckoffBuffer2."Loan No" <> '' then begin
                                    //     CheckoffLines."Clears Loan" := AmountClearsLoanIfPosted(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount);
                                    //     if CheckoffLines."Clears Loan" then
                                    //         CheckoffLines."Refundable Amount" := ABS(GetLoanBalanceAfterPosting(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount));
                                    // end;
                                    CheckoffLines."Payroll No." := SavingsAccounts."Payroll/Staff No.";
                                    CheckoffLines."ID Number" := SavingsAccounts."ID No.";
                                    CheckoffLines."Member No." := SavingsAccounts."Member No.";
                                    CheckoffLines."Savings Account" := true;
                                    CheckoffLines."Credit Account" := false;
                                    CheckoffLines."Checkoff Header" := checkoffHeader."No.";
                                    CheckoffLines.Type := checkoffHeader.Type;
                                    CheckoffLines.Name := SavingsAccounts.Name;
                                    // CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                    CheckoffLines."Employer Code" := SavingsAccounts."Employer Code";
                                    CheckoffLines.Remarks := 'Excess checkoff from ' + checkoffHeader."No." + ' to deposits.';
                                    CheckoffLines."Product Code" := SavingsAccounts."Product Type";
                                    CheckoffLines.Insert;
                                    // end
                                    // else begin
                                    //     UnallocatedAccount := '';
                                    //     SavingsAccounts.Reset;
                                    //     SavingsAccounts.SetRange(SavingsAccounts."Member No.", Members."No.");
                                    //     SavingsAccounts.SetRange("Product Type", '191');
                                    //     if SavingsAccounts.Find('-') then begin
                                    //         UnallocatedAccount := SavingsAccounts."No.";
                                    //     end else begin
                                    //         Pfact.reset;
                                    //         Pfact.SetRange("Product ID", '191');
                                    //         Pfact.SetRange(status, Pfact.status::Active);
                                    //         if Pfact.find('-') then begin

                                    //             UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", Members."Global Dimension 1 Code", Members."No.");
                                    //             MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, Members."No.", Pfact."Product ID");
                                    //         end;
                                    //     end;
                                    //     // FOSA Acc below 100
                                    //     EntryNo := 1;
                                    //     CheckoffLines2.Reset;
                                    //     CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer2."Checkoff No");
                                    //     if CheckoffLines2.Find('+') then
                                    //         EntryNo := CheckoffLines2."Entry No" + 1;

                                    //     CheckoffLines.Init;
                                    //     CheckoffLines."Entry No" := EntryNo;
                                    //     CheckoffLines.Amount := remAmt;
                                    //     CheckoffLines."Account No." := SavingsAccounts."No.";
                                    //     //IF CheckoffBuffer2."Account No"<>'' THEN
                                    //     CheckoffLines.Multiple := true;
                                    //     CheckoffLines."Loan No." := '';
                                    //     // if CheckoffBuffer2."Loan No" <> '' then begin
                                    //     //     CheckoffLines."Clears Loan" := AmountClearsLoanIfPosted(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount);
                                    //     //     if CheckoffLines."Clears Loan" then
                                    //     //         CheckoffLines."Refundable Amount" := ABS(GetLoanBalanceAfterPosting(CheckoffBuffer2."Loan No", CheckoffBuffer2.Amount));
                                    //     // end;
                                    //     CheckoffLines."Payroll No." := SavingsAccounts."Payroll/Staff No.";
                                    //     CheckoffLines."ID Number" := SavingsAccounts."ID No.";
                                    //     CheckoffLines."Member No." := SavingsAccounts."Member No.";
                                    //     CheckoffLines."Savings Account" := true;
                                    //     CheckoffLines."Credit Account" := false;
                                    //     CheckoffLines."Checkoff Header" := checkoffHeader."No.";
                                    //     CheckoffLines.Type := checkoffHeader.Type;
                                    //     CheckoffLines.Name := SavingsAccounts.Name;
                                    //     // CheckoffLines."Payroll No." := CheckoffBuffer2.Payroll;
                                    //     CheckoffLines."Employer Code" := SavingsAccounts."Employer Code";
                                    //     CheckoffLines.Remarks := 'Ordinary excess checkoff refund from ' + checkoffHeader."No.";
                                    //     CheckoffLines."Product Code" := SavingsAccounts."Product Type";
                                    //     CheckoffLines.Insert;
                                    // end;
                                end;

                            end;
                            //end;
                        end;
                    end;
                end;
            //     end else begin
            //     EntryNo := 1;
            //     CheckoffLines2.Reset;
            //     CheckoffLines2.SetRange(CheckoffLines2."Checkoff Header", CheckoffBuffer."Checkoff No");
            //     if CheckoffLines2.Find('+') then
            //         EntryNo := CheckoffLines2."Entry No" + 1;

            //     CheckoffLines.Init;
            //     CheckoffLines."Entry No" := EntryNo;
            //     CheckoffLines.Amount := CheckoffBuffer.Amount + CheckoffBuffer.Interest;
            //     CheckoffLines."Account No." := CheckoffBuffer."Account No";
            //     //IF CheckoffBuffer."Account No"<>'' THEN
            //     CheckoffLines.Multiple := true;
            //     CheckoffLines."Loan No." := CheckoffBuffer."Loan No";
            //     if CheckoffBuffer."Loan No" <> '' then
            //         CheckoffLines."Clears Loan" :=
            //         AmountClearsLoanIfPosted(CheckoffBuffer."Loan No", CheckoffBuffer.Amount);
            //     CheckoffLines."Payroll No." := CheckoffBuffer."Upload No.";//CheckoffBuffer.Payroll;
            //     CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
            //     CheckoffLines."Member No." := CheckoffBuffer."Member No.";
            //     CheckoffLines."Savings Account" := CheckoffBuffer."Savings Account";
            //     CheckoffLines."Credit Account" := CheckoffBuffer."Credit Account";
            //     CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
            //     CheckoffLines.Name := CheckoffBuffer.Name;
            //     CheckoffLines.Type := CheckoffBuffer.Type;
            //     //CheckoffLines."Payroll No.":=CheckoffBuffer.Payroll;
            //     CheckoffLines.Remarks := CheckoffBuffer.Remarks;
            //     CheckoffLines."Product Code" := CheckoffBuffer."Search Code";
            //     CheckoffLines.Insert;
            // end;

            //Employer Balance Update
            // if Loans.Get(CheckoffBuffer."Loan No") then begin
            //     if CheckoffBuffer.Type = CheckoffBuffer.Type::sLoan then
            //         Loans."Employer Balance" := CheckoffBuffer.Balance;
            //     Loans.Modify;
            // end;

            // if SavingsAccounts.Get(CheckoffBuffer."Account No") then begin
            //     SavingsAccounts."Employer Balance" := CheckoffBuffer.Balance;
            //     SavingsAccounts."Monthly Contribution" := CheckoffBuffer.Amount;
            //     SavingsAccounts.Modify;
            // end;

            until CheckoffBuffer.Next = 0;
        end;
    end;

    procedure GetLoanBalanceAfterPosting(LoanNo: Code[20];
            AmountToPost: Decimal) LoanBalanceAfterPosting: Decimal
    var
        Loan: Record Loans;
        TotalLoanAmount: Decimal;
    begin
        LoanBalanceAfterPosting := 0;
        TotalLoanAmount := 0;
        Loan.Get(LoanNo);
        Loan.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
        if (Loan."Outstanding Interest" + Loan."Daily Interest") > 0 then
            TotalLoanAmount := Loan."Outstanding Interest" + loan."Daily Interest";
        if Loan."Outstanding Balance" > 0 then
            TotalLoanAmount := Loan."Outstanding Balance";
        LoanBalanceAfterPosting := TotalLoanAmount - AmountToPost;
    end;

    procedure AmountClearsLoanIfPosted(LoanNo: Code[20]; AmountToPost: Decimal) AmtClearsLoanIfPosted: Boolean
    begin
        AmtClearsLoanIfPosted := (GetLoanBalanceAfterPosting(LoanNo, AmountToPost) <= 0);
    end;
    //POST CHECKOFF NEW
    procedure NewPostCheckoff(CheckoffHeader: Record "Checkoff Header"; BulkPosting: Boolean)
    var
        Loans: Record Loans;
        CheckoffLines: Record "Checkoff Lines";
        RunBal: Decimal;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Txt0000: label 'Loan Repayment';
        CreditAccounts: Record "Credit Accounts";
        Txt0001: label 'Interest Paid';
        TransDescription: Text;
        TransDescriptions: Text;
        Amortised: Decimal;
        Recovery: Decimal;
        Interest: Decimal;
        Txt0002: label 'Deposit Contribution';
        SavingsAccounts: Record "Savings Accounts";
        DepositCont: Decimal;
        Txt0003: label 'Excess Amount';
        LoanAmount: Decimal;
        Txt0004: label 'Checkoff schedule and amount is not equal';
        Txt0005: label 'Batch Posted successfully';
        Txt0006: label 'Principle Recovery';
        LoansBill: Record Loans;
        Txt0007: label 'Loan Repayment -Bills';
        ProductF: Record "Product Factory";
        ShareCap: Decimal;
        PrdFac: Record "Product Factory";
        Txt0008: label 'Share Capital';
        ProgressWindow: Dialog;
        Dim1: Code[20];
        Dim2: Code[20];
        Members: Record Members;
        MembersII: Record Members;
        MemberClass: Record "Member Classes";
        UserSetup: Record "User Setup";
        Txt0009: label 'Vendor:-';
        SavingsAcc: Code[20];
        Text010: label '<Month Text>';
        Text011: label 'Contribution';
        TextIntDue: Label ' Interest Due';
        SavingsAccountsBlock: Record "Savings Accounts";
        CreditAccountsBlock: Record "Credit Accounts";
        DepositAccount: Record "Savings Accounts";
        UnallocatedAccount: code[20];
        MemberRegistration: codeunit "Registration Process";
        Pfact: Record "Product Factory";
        DepositAccountPost: Code[20];
        DepositAccountPostRec: Record "Savings Accounts";
        UnpostedInterestAccrued: Decimal;
        DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
        RecoveredAmount: Decimal;
    begin

        CheckoffHeader.CalcFields(CheckoffHeader."Scheduled Amount", Amount);
        if ROUND(CheckoffHeader."Scheduled Amount", 0.01, '=') <> ROUND(CheckoffHeader.Amount, 0.01, '=') then
            Error(Txt0004);
        RunBal := 0;
        TransDescription := CheckoffHeader.Description;
        CheckoffHeader.CalcFields("Scheduled Amount");
        Temp.Get(UserId);

        Temp.TestField(Temp."Check Off Template");
        Temp.TestField(Temp."Check Off Batch");

        Jtemplate := Temp."Check Off Template";
        JBatch := Temp."Check Off Batch";

        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        //MESSAGE('%1',JBatch);
        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
        if BulkPosting = false then
            CheckoffLines.SetRange(CheckoffLines.Posted, false);
        if CheckoffLines.FindSet() then begin
            //Progress Window
            ProgressWindow.OPEN('Processing check off for Entry No: #1#######');
            repeat
                UnallocatedAccount := '';
                DepositAccountPost := '';
                //Blocked Account
                SavingsAccountsBlock.Reset;
                SavingsAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                SavingsAccountsBlock.SetRange(Blocked, SavingsAccountsBlock.Blocked::All);
                SavingsAccountsBlock.SetFilter(SavingsAccountsBlock."Product Category", '<>1', SavingsAccountsBlock."Product Category"::"BOSA Deposits");
                if SavingsAccountsBlock.FindSet() then begin
                    repeat
                        SavingsAccountsBlock.Blocked := SavingsAccountsBlock.Blocked::" ";
                        SavingsAccountsBlock.Modify;
                    until SavingsAccountsBlock.Next = 0;
                end;

                CreditAccountsBlock.Reset;
                CreditAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                CreditAccountsBlock.SetRange(Blocked, CreditAccountsBlock.Blocked::All);
                if CreditAccountsBlock.Find('-') then begin
                    repeat
                        CreditAccountsBlock.Blocked := CreditAccountsBlock.Blocked::" ";
                        CreditAccountsBlock.Modify;
                    until CreditAccountsBlock.Next = 0;
                end;

                if DepositAccount.Get(CheckoffLines."Account No.") then begin
                    DepositAccountPost := DepositAccount."No.";
                    if DepositAccount."Product Category" = DepositAccount."Product Category"::"BOSA Deposits" then begin
                        if (DepositAccount.Status = DepositAccount.Status::Closed) or (DepositAccount.Status = DepositAccount.Status::Deceased)
                        then begin
                            //Post to unallocated funds
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                            if SavingsAccounts.Find('-') then begin
                                UnallocatedAccount := SavingsAccounts."No.";
                            end else begin
                                Pfact.reset;
                                Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                Pfact.SetRange(status, Pfact.status::Active);
                                if Pfact.find('-') then begin
                                    MembersII.Get(CheckoffLines."Member No.");
                                    UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                    MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                end;
                            end;
                            DepositAccountPost := UnallocatedAccount;
                        end;
                    end;
                    // if Members.Get(CheckoffLines."Member No.") then begin
                    //     if (Members.Status = Members.Status::Dormant) or (Members.Status = Members.Status::New) then begin
                    //         Members.Status := Members.Status::Active;
                    //         Members.Modify;
                    //     end;
                    // end;
                end;


                ProgressWindow.UPDATE(1, CheckoffLines."Entry No");
                CheckoffLines.TESTFIELD(CheckoffLines."Member No.");
                RunBal := CheckoffLines.Amount;
                //Get Dimensions
                if Members.Get(CheckoffLines."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                end else begin
                    if UserSetup.Get(UserId) then begin
                        Dim1 := UserSetup."Global Dimension 1 Code";
                        Dim2 := UserSetup."Global Dimension 2 Code";
                    end;
                end;

                LoanAmount := CheckoffLines.Amount;
                TransDescription := CheckoffLines.Remarks;
                if TransDescription = '' then TransDescription := CheckoffHeader.Description;
                TransDescriptions := TransDescription;

                //If not Bulk Upload 
                if CheckoffHeader."CheckOff Type" <> CheckoffHeader."CheckOff Type"::Lumpsum then begin
                    //Savings Account
                    if CheckoffLines."Savings Account" = true then begin
                        if CheckoffLines."Account No." = '' then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                            if SavingsAccounts.Find('-') then begin
                                UnallocatedAccount := SavingsAccounts."No.";
                            end else begin
                                Pfact.reset;
                                Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                Pfact.SetRange(status, Pfact.status::Active);
                                if Pfact.find('-') then begin
                                    MembersII.Get(CheckoffLines."Member No.");
                                    UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                    MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                end;
                            end;
                            DepositAccountPost := UnallocatedAccount;
                            CheckoffLines."Account No." := DepositAccountPost;
                            TransDescriptions := CopyStr(('Err.  ATS' + CheckoffLines."Product Code" + ' ' + TransDescription), 1, 50);
                        end;
                        AcctType := Accttype::Savings;
                        TransType := Transtype::" ";
                        LineNo := LineNo + 10000;
                        if CheckoffLines."Account No." <> '' then begin
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                              TransDescriptions, CheckoffLines.Amount * -1, DepositAccountPost/*CheckoffLines."Account No."*/, CheckoffHeader."Posting Date", BalAccType,
                              BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LoanAmount := 0;
                        end;
                    end;


                    //Credit Account
                    if CheckoffLines."Credit Account" = true then begin
                        LoanAmount := CheckoffLines.Amount;

                        Loans.Reset;
                        Loans.SetCurrentkey(Loans."Recovery Priority");
                        //Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                        Loans.SetRange(Loans."Member No.", CheckoffLines."Member No.");
                        Loans.SetRange(Loans."Loan No.", CheckoffLines."Loan No.");
                        Loans.SetAutoCalcFields("Daily Interest", "Outstanding Interest", "Outstanding Balance");
                        if Loans.Find('-') then begin
                            if BulkPosting = true then
                                //Loans."Outstanding Interest" := Loans."Outstanding Interest" - ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::"interest Paid");

                                //if AmountClearsLoanIfPosted(Loans."Loan No.", (LoanAmount + (ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment)))) then begin
                                // if Loans."Daily Interest" > 0 then begin
                                //     UnpostedInterestAccrued := Loans."Daily Interest";
                                //     If Loans."Outstanding Interest" < 0 then
                                //         Loans."Outstanding Interest" := 0;
                                //     //LoansProcess.CapitalizeDailyInterest(loans."Loan No.");
                                //     /*
                                //                                         // Accrue Interest;
                                //                                         Pfact.Get(Loans."Loan Product Type");
                                //                                         Pfact.TestField("Loan Interest Account [G/L]");
                                //                                         AcctType := Accttype::Credit;
                                //                                         TransType := Transtype::"Interest Due";
                                //                                         LineNo := LineNo + 10000;
                                //                                         AccNo := Loans."Loan Account";
                                //                                         BalAccType := BalAccType::"G/L Account";
                                //                                         BalAccNo := Pfact."Loan Interest Account [G/L]";
                                //                                         Amt := UnpostedInterestAccrued;

                                //                                         JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                //                                         'Daily Interest Capitalized', Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                //                                         BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                //                                         Loans."Outstanding Interest" += UnpostedInterestAccrued;

                                //                                         LoansProcess.ClearDailyInterest(Loans."Loan No.");
                                //     */
                                //     LoansProcess.AdviceLoan(Loans."Loan No.", true, CheckoffHeader."Document No.");
                                // end;
                                //end;

                                if Loans."Outstanding Interest" > 0 then begin
                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::"Interest Paid";
                                    LineNo := LineNo + 10000;
                                    AccNo := loans."Loan Account";
                                    BalAccNo := '';
                                    Amt := 0;
                                    if LoanAmount > Loans."Outstanding Interest" then
                                        Amt := Loans."Outstanding Interest" * -1
                                    else
                                        Amt := LoanAmount * -1;
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                   TransDescription, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := LoanAmount - Abs(Amt);
                                end;
                            if LoanAmount > 0 then begin
                                AcctType := Accttype::Credit;
                                TransType := Transtype::Repayment;
                                LineNo := LineNo + 10000;
                                BalAccNo := '';
                                AccNo := loans."Loan Account";
                                Amt := 0;
                                RecoveredAmount := 0;
                                if BulkPosting = true then begin
                                    RecoveredAmount := ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment);
                                    Loans."Outstanding Balance" := Loans."Outstanding Balance" - RecoveredAmount;
                                end;
                                if LoanAmount > (Loans."Outstanding Balance") then
                                    Amt := ROUND(Loans."Outstanding Balance") * -1
                                else
                                    Amt := ROUND(LoanAmount) * -1;
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                TransDescription, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                LoanAmount := LoanAmount - Abs(Amt);
                                BalAccNo := '';
                                //Excess to unallocated Funds
                                if LoanAmount > 0 then begin
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                                    if SavingsAccounts.Find('-') then begin
                                        UnallocatedAccount := SavingsAccounts."No.";
                                    end else begin
                                        Pfact.reset;
                                        Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                        Pfact.SetRange(status, Pfact.status::Active);
                                        if Pfact.find('-') then begin
                                            MembersII.Get(CheckoffLines."Member No.");
                                            UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                            MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                        end;
                                    end;
                                    AcctType := Accttype::Savings;
                                    LineNo := LineNo + 10000;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                     Txt0003 + ' ' + Loans."Loan No.", LoanAmount * -1, UnallocatedAccount, CheckoffHeader."Posting Date", BalAccType,
                                     BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := 0;
                                end;
                            end;
                        end;
                    end;
                    //Bulk Postings
                end else if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Lumpsum then begin
                    Pfact.reset;
                    Pfact.SetRange("Product Class Type", Pfact."Product Class Type"::Loan);
                    Pfact.SetCurrentKey("Recovery Priority");
                    // Pfact.SetRange(status, Pfact.status::Active);
                    if Pfact.FindSet() then begin
                        repeat
                            Loans.RESET;
                            loans.setrange("Loan Product Type", Pfact."Product ID");
                            Loans.SETCURRENTKEY(Loans."Recovery Priority");
                            Loans.SETFILTER(Loans."Outstanding Balance", '>0');
                            Loans.SETRANGE(Loans."Member No.", CheckoffLines."Member No.");
                            Loans.SETRANGE(Loans."Recovery Mode", Loans."Recovery Mode"::Checkoff);
                            IF Loans.FindSet() THEN BEGIN
                                REPEAT
                                    //Capitalize Interest
                                    LoansProcess.CapitalizeDailyInterest(loans."Loan No.");
                                    //***Repayment Methods other than Reducing Flat 
                                    IF Loans."Interest Calculation Method" <> Loans."Interest Calculation Method"::"Reducing Flat" THEN BEGIN
                                        IF RunBal > 0 THEN BEGIN
                                            Loans.CALCFIELDS(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Daily Interest");
                                            RecoveredAmount := 0;
                                            if BulkPosting = true then begin
                                                RecoveredAmount := ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment);
                                                Loans."Outstanding Balance" := Loans."Outstanding Balance" - RecoveredAmount;
                                                Loans."Outstanding Interest" := Loans."Outstanding Interest" - ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::"interest Paid");
                                            end;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN
                                                Amortised := Loans.Repayment - ROUND(((Loans."Outstanding Balance" * (Loans.Interest) / 1200)), 0.01, '>')
                                            ELSE
                                                Recovery := Loans.Repayment;

                                            IF (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 THEN
                                                Interest := (Loans."Outstanding Interest" + Loans."Daily Interest")
                                            ELSE
                                                Interest := 0;
                                            //Interest *****************

                                            AcctType := AcctType::Credit;
                                            AccNo := Loans."Loan Account";
                                            TransType := TransType::"Interest Paid";
                                            BalAccType := BalAccType::"G/L Account";
                                            BalAccNo := '';
                                            Amt := 0;
                                            LineNo := LineNo + 10000;
                                            IF Interest > 0 THEN BEGIN
                                                IF RunBal > Interest THEN BEGIN
                                                    IF Interest > (Loans."Outstanding Interest" + Loans."Daily Interest") THEN
                                                        Amt := ROUND((Loans."Outstanding Interest" + Loans."Daily Interest"), 0.01, '=') * -1
                                                    ELSE
                                                        Amt := ROUND(Interest, 0.01, '=') * -1;
                                                END ELSE
                                                    Amt := RunBal * -1;
                                            END;
                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            RunBal := RunBal - ABS(Amt);

                                            //Repayment**************
                                            Amt := 0;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                                                IF Amortised > 0 THEN BEGIN
                                                    IF RunBal > Amortised THEN BEGIN
                                                        IF Amortised > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Amortised, 0.01, '=') * -1;
                                                    END ELSE
                                                        Amt := RunBal * -1;
                                                END;
                                            END ELSE BEGIN
                                                IF Recovery > 0 THEN BEGIN
                                                    IF RunBal > Recovery THEN BEGIN
                                                        IF Recovery > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Recovery, 0.01, '=') * -1;
                                                    END ELSE
                                                        Amt := RunBal * -1;
                                                END;

                                            END;

                                            AcctType := AcctType::Credit;
                                            TransType := TransType::Repayment;
                                            BalAccNo := '';
                                            LineNo := LineNo + 10000;

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                               '', Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);
                                        END;////*******************************End of other Repayment methods other than Reducing Flat
                                    END ELSE BEGIN
                                        IF RunBal > 0 THEN BEGIN
                                            Loans.CALCFIELDS(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Daily Interest");
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" THEN
                                                Amortised := (Loans."Approved Amount" / Loans.Installments) ////////-Loans."Outstanding Balance"*Loans.Interest/1200
                                            ELSE
                                                Recovery := (Loans."Approved Amount" / Loans.Installments);//Loans.Repayment;

                                            IF (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 THEN
                                                Interest := (Loans.Repayment) - (Loans."Approved Amount" / Loans.Installments)
                                            ELSE
                                                Interest := 0;
                                            //Loans."Outstanding Balance"*Loans.Interest/1200;

                                            //Interest *****************

                                            AcctType := AcctType::Credit;
                                            AccNo := Loans."Loan Account";
                                            TransType := TransType::"Interest Paid";
                                            BalAccType := BalAccType::"G/L Account";
                                            BalAccNo := '';
                                            Amt := 0;
                                            LineNo := LineNo + 10000;
                                            IF Interest > 0 THEN BEGIN
                                                IF RunBal > Interest THEN BEGIN
                                                    IF Interest > (Loans."Outstanding Interest" + Loans."Daily Interest") THEN
                                                        Amt := ROUND((Loans."Outstanding Interest" + Loans."Daily Interest"), 0.01, '=') * -1
                                                    ELSE
                                                        Amt := ROUND(Interest, 0.01, '=') * -1;
                                                END;
                                            END;
                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            RunBal := RunBal - ABS(Amt);

                                            //Repayment**************
                                            Amt := 0;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                                                IF Amortised > 0 THEN BEGIN
                                                    IF RunBal > Amortised THEN BEGIN
                                                        IF Amortised > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Amortised, 0.01, '=') * -1;
                                                    END;
                                                END;
                                            END ELSE BEGIN
                                                IF Recovery > 0 THEN BEGIN
                                                    IF RunBal > Recovery THEN BEGIN
                                                        IF Recovery > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Recovery, 0.01, '=') * -1;
                                                    END;
                                                END;
                                            END;
                                            AcctType := AcctType::Credit;
                                            TransType := TransType::Repayment;
                                            LineNo := LineNo + 10000;
                                            BalAccNo := '';

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                '', Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);

                                        END;
                                    END;
                                UNTIL Loans.NEXT = 0;

                            END;
                        until Pfact.next = 0;
                    end;
                    //Savings Priority
                    IF RunBal > 0 THEN BEGIN
                        Pfact.reset;
                        Pfact.SetRange("Product Class Type", Pfact."Product Class Type"::Savings);
                        Pfact.SetCurrentKey("Recovery Priority");
                        // Pfact.SetRange(status, Pfact.status::Active);
                        if Pfact.FindSet() then begin
                            repeat
                                SavingsAccounts.RESET;
                                SavingsAccounts.SetRange("Product Type", Pfact."Product ID");
                                SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                                SavingsAccounts.SetFilter("Product Category", '<>%1', SavingsAccounts."Product Category"::"Entrance Fee");
                                IF SavingsAccounts.FindSet() THEN BEGIN
                                    REPEAT
                                        IF (SavingsAccounts."Monthly Contribution" > 0) or (Pfact."Minimum Contribution" > 0) THEN BEGIN

                                            AcctType := AcctType::Savings;
                                            TransType := TransType::" ";
                                            LineNo := LineNo + 10000;
                                            BalAccNo := '';
                                            if SavingsAccounts."Monthly Contribution" < Pfact."Minimum Contribution" then
                                                SavingsAccounts."Monthly Contribution" := Pfact."Minimum Contribution";
                                            if SavingsAccounts."Monthly Contribution" < CUstomCuesCU.Prorata(SavingsAccounts."Member No.", '1') then
                                                SavingsAccounts."Monthly Contribution" := CUstomCuesCU.Prorata(SavingsAccounts."Member No.", '1');

                                            IF RunBal > SavingsAccounts."Monthly Contribution" THEN
                                                Amt := SavingsAccounts."Monthly Contribution" * -1
                                            ELSE
                                                Amt := RunBal * -1;

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                CheckoffHeader.description, Amt, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);
                                        END;
                                    UNTIL SavingsAccounts.NEXT = 0;
                                END;
                            until Pfact.Next = 0;
                        end;
                    END;
                    //End of Savings Priority
                    //Excess to Unalocated
                    IF RunBal > 0 THEN BEGIN
                        UnallocatedAccount := '';
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                        if SavingsAccounts.Find('-') then begin
                            UnallocatedAccount := SavingsAccounts."No.";
                        end else begin
                            Pfact.reset;
                            Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                            Pfact.SetRange(status, Pfact.status::Active);
                            if Pfact.find('-') then begin
                                MembersII.Get(CheckoffLines."Member No.");
                                UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                            end;
                        end;
                        AcctType := Accttype::Savings;
                        LineNo := LineNo + 10000;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                          Txt0003, RunBal * -1, UnallocatedAccount, CheckoffHeader."Posting Date", BalAccType,
                          BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        //End of excess to unalocated

                    end;
                end;

                //Balance with Employer Code
                //Customer Amount
                if BulkPosting = false then begin
                    AcctType := Accttype::Customer;
                    LineNo := LineNo + 10000;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                      TransDescription, CheckoffLines.Amount, CheckoffHeader."Account No.", CheckoffHeader."Posting Date", BalAccType,
                      BalAccNo, '', Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Modify Lines
                    //ERROR('Testing');
                    JournalPosting.CompletePosting(Jtemplate, JBatch);

                    CheckoffLines.Posted := true;
                    CheckoffLines.Modify;


                    Commit;
                end;
            until CheckoffLines.Next = 0;
        end;
        if BulkPosting = true then begin
            AcctType := Accttype::Customer;
            LineNo := LineNo + 10000;

            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
              TransDescription, CheckoffHeader.amount, CheckoffHeader."Account No.", CheckoffHeader."Posting Date", BalAccType,
              BalAccNo, '', Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            //Modify Lines
            //ERROR('Testing');
            //JournalPosting.CompletePosting(Jtemplate, JBatch);
            SaccoTrans.PostJournal(JTemplate, JBatch, false);
            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange(CheckoffLines.Posted, false);
            CheckoffLines.ModifyAll(Posted, true);
            Commit;
        end;

        CheckoffHeader.Posted := true;
        CheckoffHeader.Modify;

        Message(Txt0005);

    end;

    procedure NewPostCheckoffAPI(CheckoffHeader: Record "Checkoff Header"; BulkPosting: Boolean)
    var
        Loans: Record Loans;
        CheckoffLines: Record "Checkoff Lines";
        RunBal: Decimal;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Txt0000: label 'Loan Repayment';
        CreditAccounts: Record "Credit Accounts";
        Txt0001: label 'Interest Paid';
        TransDescription: Text;
        TransDescriptions: Text;
        Amortised: Decimal;
        Recovery: Decimal;
        Interest: Decimal;
        Txt0002: label 'Deposit Contribution';
        SavingsAccounts: Record "Savings Accounts";
        DepositCont: Decimal;
        Txt0003: label 'Excess Amount';
        LoanAmount: Decimal;
        Txt0004: label 'Checkoff schedule and amount is not equal';
        Txt0005: label 'Batch Posted successfully';
        Txt0006: label 'Principle Recovery';
        LoansBill: Record Loans;
        Txt0007: label 'Loan Repayment -Bills';
        ProductF: Record "Product Factory";
        ShareCap: Decimal;
        PrdFac: Record "Product Factory";
        Txt0008: label 'Share Capital';
        ProgressWindow: Dialog;
        Dim1: Code[20];
        Dim2: Code[20];
        Members: Record Members;
        MembersII: Record Members;
        MemberClass: Record "Member Classes";
        UserSetup: Record "User Setup";
        Txt0009: label 'Vendor:-';
        SavingsAcc: Code[20];
        Text010: label '<Month Text>';
        Text011: label 'Contribution';
        TextIntDue: Label ' Interest Due';
        SavingsAccountsBlock: Record "Savings Accounts";
        CreditAccountsBlock: Record "Credit Accounts";
        DepositAccount: Record "Savings Accounts";
        UnallocatedAccount: code[20];
        MemberRegistration: codeunit "Registration Process";
        Pfact: Record "Product Factory";
        DepositAccountPost: Code[20];
        DepositAccountPostRec: Record "Savings Accounts";
        UnpostedInterestAccrued: Decimal;
        DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
        RecoveredAmount: Decimal;
    begin

        CheckoffHeader.CalcFields(CheckoffHeader."Scheduled Amount", Amount);
        // if ROUND(CheckoffHeader."Scheduled Amount", 0.01, '=') <> ROUND(CheckoffHeader.Amount, 0.01, '=') then
        //     Error(Txt0004);
        RunBal := 0;
        TransDescription := CheckoffHeader.Description;
        CheckoffHeader.CalcFields("Scheduled Amount");
        Temp.Get(UserId);

        Temp.TestField(Temp."Check Off Template");
        Temp.TestField(Temp."Check Off Batch");

        Jtemplate := Temp."Check Off Template";
        JBatch := Temp."Check Off Batch";

        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        //MESSAGE('%1',JBatch);
        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
        if BulkPosting = false then
            CheckoffLines.SetRange(CheckoffLines.Posted, false);
        if CheckoffLines.FindSet() then begin
            //Progress Window
            ProgressWindow.OPEN('Processing check off for Entry No: #1#######');
            repeat
                UnallocatedAccount := '';
                DepositAccountPost := '';
                //Blocked Account
                SavingsAccountsBlock.Reset;
                SavingsAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                SavingsAccountsBlock.SetRange(Blocked, SavingsAccountsBlock.Blocked::All);
                SavingsAccountsBlock.SetFilter(SavingsAccountsBlock."Product Category", '<>1', SavingsAccountsBlock."Product Category"::"BOSA Deposits");
                if SavingsAccountsBlock.FindSet() then begin
                    repeat
                        SavingsAccountsBlock.Blocked := SavingsAccountsBlock.Blocked::" ";
                        SavingsAccountsBlock.Modify;
                    until SavingsAccountsBlock.Next = 0;
                end;

                CreditAccountsBlock.Reset;
                CreditAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                CreditAccountsBlock.SetRange(Blocked, CreditAccountsBlock.Blocked::All);
                if CreditAccountsBlock.Find('-') then begin
                    repeat
                        CreditAccountsBlock.Blocked := CreditAccountsBlock.Blocked::" ";
                        CreditAccountsBlock.Modify;
                    until CreditAccountsBlock.Next = 0;
                end;

                if DepositAccount.Get(CheckoffLines."Account No.") then begin
                    DepositAccountPost := DepositAccount."No.";
                    if DepositAccount."Product Category" = DepositAccount."Product Category"::"BOSA Deposits" then begin
                        if (DepositAccount.Status = DepositAccount.Status::Closed) or (DepositAccount.Status = DepositAccount.Status::Deceased)
                        then begin
                            //Post to unallocated funds
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                            if SavingsAccounts.Find('-') then begin
                                UnallocatedAccount := SavingsAccounts."No.";
                            end else begin
                                Pfact.reset;
                                Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                Pfact.SetRange(status, Pfact.status::Active);
                                if Pfact.find('-') then begin
                                    MembersII.Get(CheckoffLines."Member No.");
                                    UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                    MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                end;
                            end;
                            DepositAccountPost := UnallocatedAccount;
                        end;
                    end;
                    // if Members.Get(CheckoffLines."Member No.") then begin
                    //     if (Members.Status = Members.Status::Dormant) or (Members.Status = Members.Status::New) then begin
                    //         Members.Status := Members.Status::Active;
                    //         Members.Modify;
                    //     end;
                    // end;
                end;


                ProgressWindow.UPDATE(1, CheckoffLines."Entry No");
                CheckoffLines.TESTFIELD(CheckoffLines."Member No.");
                RunBal := CheckoffLines.Amount;
                //Get Dimensions
                if Members.Get(CheckoffLines."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                end else begin
                    if UserSetup.Get(UserId) then begin
                        Dim1 := UserSetup."Global Dimension 1 Code";
                        Dim2 := UserSetup."Global Dimension 2 Code";
                    end;
                end;

                LoanAmount := CheckoffLines.Amount;
                TransDescription := CheckoffLines.Remarks;
                if TransDescription = '' then TransDescription := CheckoffHeader.Description;
                TransDescriptions := TransDescription;

                //If not Bulk Upload 
                if CheckoffHeader."CheckOff Type" <> CheckoffHeader."CheckOff Type"::Lumpsum then begin
                    //Savings Account
                    if CheckoffLines."Savings Account" = true then begin
                        if CheckoffLines."Account No." = '' then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                            if SavingsAccounts.Find('-') then begin
                                UnallocatedAccount := SavingsAccounts."No.";
                            end else begin
                                Pfact.reset;
                                Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                Pfact.SetRange(status, Pfact.status::Active);
                                if Pfact.find('-') then begin
                                    MembersII.Get(CheckoffLines."Member No.");
                                    UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                    MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                end;
                            end;
                            DepositAccountPost := UnallocatedAccount;
                            CheckoffLines."Account No." := DepositAccountPost;
                            TransDescriptions := CopyStr(('Err.  ATS' + CheckoffLines."Product Code" + ' ' + TransDescription), 1, 50);
                        end;
                        AcctType := Accttype::Savings;
                        TransType := Transtype::" ";
                        LineNo := LineNo + 10000;
                        if CheckoffLines."Account No." <> '' then begin
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                              TransDescriptions, CheckoffLines.Amount * -1, DepositAccountPost/*CheckoffLines."Account No."*/, CheckoffHeader."Posting Date", BalAccType,
                              BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LoanAmount := 0;
                        end;
                    end;


                    //Credit Account
                    if CheckoffLines."Credit Account" = true then begin
                        LoanAmount := CheckoffLines.Amount;

                        Loans.Reset;
                        Loans.SetCurrentkey(Loans."Recovery Priority");
                        //Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                        Loans.SetRange(Loans."Member No.", CheckoffLines."Member No.");
                        Loans.SetRange(Loans."Loan No.", CheckoffLines."Loan No.");
                        Loans.SetAutoCalcFields("Daily Interest", "Outstanding Interest", "Outstanding Balance");
                        if Loans.Find('-') then begin
                            if BulkPosting = true then
                                //Loans."Outstanding Interest" := Loans."Outstanding Interest" - ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::"interest Paid");

                                //if AmountClearsLoanIfPosted(Loans."Loan No.", (LoanAmount + (ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment)))) then begin
                                // if Loans."Daily Interest" > 0 then begin
                                //     UnpostedInterestAccrued := Loans."Daily Interest";
                                //     If Loans."Outstanding Interest" < 0 then
                                //         Loans."Outstanding Interest" := 0;
                                //     //LoansProcess.CapitalizeDailyInterest(loans."Loan No.");
                                //     /*
                                //                                         // Accrue Interest;
                                //                                         Pfact.Get(Loans."Loan Product Type");
                                //                                         Pfact.TestField("Loan Interest Account [G/L]");
                                //                                         AcctType := Accttype::Credit;
                                //                                         TransType := Transtype::"Interest Due";
                                //                                         LineNo := LineNo + 10000;
                                //                                         AccNo := Loans."Loan Account";
                                //                                         BalAccType := BalAccType::"G/L Account";
                                //                                         BalAccNo := Pfact."Loan Interest Account [G/L]";
                                //                                         Amt := UnpostedInterestAccrued;

                                //                                         JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                //                                         'Daily Interest Capitalized', Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                //                                         BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                //                                         Loans."Outstanding Interest" += UnpostedInterestAccrued;

                                //                                         LoansProcess.ClearDailyInterest(Loans."Loan No.");
                                //     */
                                //     LoansProcess.AdviceLoan(Loans."Loan No.", true, CheckoffHeader."Document No.");
                                // end;
                                //end;

                                if Loans."Outstanding Interest" > 0 then begin
                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::"Interest Paid";
                                    LineNo := LineNo + 10000;
                                    AccNo := loans."Loan Account";
                                    BalAccNo := '';
                                    Amt := 0;
                                    if LoanAmount > Loans."Outstanding Interest" then
                                        Amt := Loans."Outstanding Interest" * -1
                                    else
                                        Amt := LoanAmount * -1;
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                   TransDescription, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := LoanAmount - Abs(Amt);
                                end;
                            if LoanAmount > 0 then begin
                                AcctType := Accttype::Credit;
                                TransType := Transtype::Repayment;
                                LineNo := LineNo + 10000;
                                BalAccNo := '';
                                AccNo := loans."Loan Account";
                                Amt := 0;
                                RecoveredAmount := 0;
                                if BulkPosting = true then begin
                                    RecoveredAmount := ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment);
                                    Loans."Outstanding Balance" := Loans."Outstanding Balance" - RecoveredAmount;
                                end;
                                if LoanAmount > (Loans."Outstanding Balance") then
                                    Amt := ROUND(Loans."Outstanding Balance") * -1
                                else
                                    Amt := ROUND(LoanAmount) * -1;
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                TransDescription, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                LoanAmount := LoanAmount - Abs(Amt);
                                BalAccNo := '';
                                //Excess to unallocated Funds
                                if LoanAmount > 0 then begin
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                                    if SavingsAccounts.Find('-') then begin
                                        UnallocatedAccount := SavingsAccounts."No.";
                                    end else begin
                                        Pfact.reset;
                                        Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                                        Pfact.SetRange(status, Pfact.status::Active);
                                        if Pfact.find('-') then begin
                                            MembersII.Get(CheckoffLines."Member No.");
                                            UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                            MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                                        end;
                                    end;
                                    AcctType := Accttype::Savings;
                                    LineNo := LineNo + 10000;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                     Txt0003 + ' ' + Loans."Loan No.", LoanAmount * -1, UnallocatedAccount, CheckoffHeader."Posting Date", BalAccType,
                                     BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := 0;
                                end;
                            end;
                        end;
                    end;
                    //Bulk Postings
                end else if CheckoffHeader."CheckOff Type" = CheckoffHeader."CheckOff Type"::Lumpsum then begin
                    Pfact.reset;
                    Pfact.SetRange("Product Class Type", Pfact."Product Class Type"::Loan);
                    Pfact.SetCurrentKey("Recovery Priority");
                    // Pfact.SetRange(status, Pfact.status::Active);
                    if Pfact.FindSet() then begin
                        repeat
                            Loans.RESET;
                            loans.setrange("Loan Product Type", Pfact."Product ID");
                            Loans.SETCURRENTKEY(Loans."Recovery Priority");
                            Loans.SETFILTER(Loans."Outstanding Balance", '>0');
                            Loans.SETRANGE(Loans."Member No.", CheckoffLines."Member No.");
                            Loans.SETRANGE(Loans."Recovery Mode", Loans."Recovery Mode"::Checkoff);
                            IF Loans.FindSet() THEN BEGIN
                                REPEAT
                                    //Capitalize Interest
                                    LoansProcess.CapitalizeDailyInterest(loans."Loan No.");
                                    //***Repayment Methods other than Reducing Flat 
                                    IF Loans."Interest Calculation Method" <> Loans."Interest Calculation Method"::"Reducing Flat" THEN BEGIN
                                        IF RunBal > 0 THEN BEGIN
                                            Loans.CALCFIELDS(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Daily Interest");
                                            RecoveredAmount := 0;
                                            if BulkPosting = true then begin
                                                RecoveredAmount := ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::Repayment);
                                                Loans."Outstanding Balance" := Loans."Outstanding Balance" - RecoveredAmount;
                                                Loans."Outstanding Interest" := Loans."Outstanding Interest" - ComputeLoanJVentries(Loans."Loan No.", Jtemplate, JBatch, CheckoffHeader."Document No.", CheckoffHeader."Posting Date", TransType::"interest Paid");
                                            end;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN
                                                Amortised := Loans.Repayment - ROUND(((Loans."Outstanding Balance" * (Loans.Interest) / 1200)), 0.01, '>')
                                            ELSE
                                                Recovery := Loans.Repayment;

                                            IF (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 THEN
                                                Interest := (Loans."Outstanding Interest" + Loans."Daily Interest")
                                            ELSE
                                                Interest := 0;
                                            //Interest *****************

                                            AcctType := AcctType::Credit;
                                            AccNo := Loans."Loan Account";
                                            TransType := TransType::"Interest Paid";
                                            BalAccType := BalAccType::"G/L Account";
                                            BalAccNo := '';
                                            Amt := 0;
                                            LineNo := LineNo + 10000;
                                            IF Interest > 0 THEN BEGIN
                                                IF RunBal > Interest THEN BEGIN
                                                    IF Interest > (Loans."Outstanding Interest" + Loans."Daily Interest") THEN
                                                        Amt := ROUND((Loans."Outstanding Interest" + Loans."Daily Interest"), 0.01, '=') * -1
                                                    ELSE
                                                        Amt := ROUND(Interest, 0.01, '=') * -1;
                                                END ELSE
                                                    Amt := RunBal * -1;
                                            END;
                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            RunBal := RunBal - ABS(Amt);

                                            //Repayment**************
                                            Amt := 0;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                                                IF Amortised > 0 THEN BEGIN
                                                    IF RunBal > Amortised THEN BEGIN
                                                        IF Amortised > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Amortised, 0.01, '=') * -1;
                                                    END ELSE
                                                        Amt := RunBal * -1;
                                                END;
                                            END ELSE BEGIN
                                                IF Recovery > 0 THEN BEGIN
                                                    IF RunBal > Recovery THEN BEGIN
                                                        IF Recovery > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Recovery, 0.01, '=') * -1;
                                                    END ELSE
                                                        Amt := RunBal * -1;
                                                END;

                                            END;

                                            AcctType := AcctType::Credit;
                                            TransType := TransType::Repayment;
                                            BalAccNo := '';
                                            LineNo := LineNo + 10000;

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                               '', Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);
                                        END;////*******************************End of other Repayment methods other than Reducing Flat
                                    END ELSE BEGIN
                                        IF RunBal > 0 THEN BEGIN
                                            Loans.CALCFIELDS(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Daily Interest");
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" THEN
                                                Amortised := (Loans."Approved Amount" / Loans.Installments) ////////-Loans."Outstanding Balance"*Loans.Interest/1200
                                            ELSE
                                                Recovery := (Loans."Approved Amount" / Loans.Installments);//Loans.Repayment;

                                            IF (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 THEN
                                                Interest := (Loans.Repayment) - (Loans."Approved Amount" / Loans.Installments)
                                            ELSE
                                                Interest := 0;
                                            //Loans."Outstanding Balance"*Loans.Interest/1200;

                                            //Interest *****************

                                            AcctType := AcctType::Credit;
                                            AccNo := Loans."Loan Account";
                                            TransType := TransType::"Interest Paid";
                                            BalAccType := BalAccType::"G/L Account";
                                            BalAccNo := '';
                                            Amt := 0;
                                            LineNo := LineNo + 10000;
                                            IF Interest > 0 THEN BEGIN
                                                IF RunBal > Interest THEN BEGIN
                                                    IF Interest > (Loans."Outstanding Interest" + Loans."Daily Interest") THEN
                                                        Amt := ROUND((Loans."Outstanding Interest" + Loans."Daily Interest"), 0.01, '=') * -1
                                                    ELSE
                                                        Amt := ROUND(Interest, 0.01, '=') * -1;
                                                END;
                                            END;
                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            RunBal := RunBal - ABS(Amt);

                                            //Repayment**************
                                            Amt := 0;
                                            IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN BEGIN
                                                IF Amortised > 0 THEN BEGIN
                                                    IF RunBal > Amortised THEN BEGIN
                                                        IF Amortised > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Amortised, 0.01, '=') * -1;
                                                    END;
                                                END;
                                            END ELSE BEGIN
                                                IF Recovery > 0 THEN BEGIN
                                                    IF RunBal > Recovery THEN BEGIN
                                                        IF Recovery > Loans."Outstanding Balance" THEN
                                                            Amt := (ROUND(Loans."Outstanding Balance", 0.01, '=') * -1)
                                                        ELSE
                                                            Amt := ROUND(Recovery, 0.01, '=') * -1;
                                                    END;
                                                END;
                                            END;
                                            AcctType := AcctType::Credit;
                                            TransType := TransType::Repayment;
                                            LineNo := LineNo + 10000;
                                            BalAccNo := '';

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                                '', Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);

                                        END;
                                    END;
                                UNTIL Loans.NEXT = 0;

                            END;
                        until Pfact.next = 0;
                    end;
                    //Savings Priority
                    IF RunBal > 0 THEN BEGIN
                        Pfact.reset;
                        Pfact.SetRange("Product Class Type", Pfact."Product Class Type"::Savings);
                        Pfact.SetCurrentKey("Recovery Priority");
                        // Pfact.SetRange(status, Pfact.status::Active);
                        if Pfact.FindSet() then begin
                            repeat
                                SavingsAccounts.RESET;
                                SavingsAccounts.SetRange("Product Type", Pfact."Product ID");
                                SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                                SavingsAccounts.SetFilter("Product Category", '<>%1', SavingsAccounts."Product Category"::"Entrance Fee");
                                IF SavingsAccounts.FindSet() THEN BEGIN
                                    REPEAT
                                        IF (SavingsAccounts."Monthly Contribution" > 0) or (Pfact."Minimum Contribution" > 0) THEN BEGIN

                                            AcctType := AcctType::Savings;
                                            TransType := TransType::" ";
                                            LineNo := LineNo + 10000;
                                            BalAccNo := '';
                                            if SavingsAccounts."Monthly Contribution" < Pfact."Minimum Contribution" then
                                                SavingsAccounts."Monthly Contribution" := Pfact."Minimum Contribution";
                                            if SavingsAccounts."Monthly Contribution" < CUstomCuesCU.Prorata(SavingsAccounts."Member No.", '1') then
                                                SavingsAccounts."Monthly Contribution" := CUstomCuesCU.Prorata(SavingsAccounts."Member No.", '1');

                                            IF RunBal > SavingsAccounts."Monthly Contribution" THEN
                                                Amt := SavingsAccounts."Monthly Contribution" * -1
                                            ELSE
                                                Amt := RunBal * -1;

                                            IF Amt <> 0 THEN
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                CheckoffHeader.description, Amt, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - ABS(Amt);
                                        END;
                                    UNTIL SavingsAccounts.NEXT = 0;
                                END;
                            until Pfact.Next = 0;
                        end;
                    END;
                    //End of Savings Priority
                    //Excess to Unalocated
                    IF RunBal > 0 THEN BEGIN
                        UnallocatedAccount := '';
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                        if SavingsAccounts.Find('-') then begin
                            UnallocatedAccount := SavingsAccounts."No.";
                        end else begin
                            Pfact.reset;
                            Pfact.SetRange("Product Category", Pfact."Product Category"::"Unallocated Fund");
                            Pfact.SetRange(status, Pfact.status::Active);
                            if Pfact.find('-') then begin
                                MembersII.Get(CheckoffLines."Member No.");
                                UnallocatedAccount := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                                MemberRegistration.AutoCreateSavingsAccount(UnallocatedAccount, MembersII."No.", Pfact."Product ID");
                            end;
                        end;
                        AcctType := Accttype::Savings;
                        LineNo := LineNo + 10000;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                          Txt0003, RunBal * -1, UnallocatedAccount, CheckoffHeader."Posting Date", BalAccType,
                          BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        //End of excess to unalocated

                    end;
                end;

                //Balance with Employer Code
                //Customer Amount
                if BulkPosting = false then begin
                    AcctType := Accttype::Customer;
                    LineNo := LineNo + 10000;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                      TransDescription, CheckoffLines.Amount, CheckoffHeader."Account No.", CheckoffHeader."Posting Date", BalAccType,
                      BalAccNo, '', Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Modify Lines
                    //ERROR('Testing');
                    JournalPosting.CompletePosting(Jtemplate, JBatch);

                    CheckoffLines.Posted := true;
                    CheckoffLines.Modify;


                    Commit;
                end;
            until CheckoffLines.Next = 0;
        end;
        if BulkPosting = true then begin
            AcctType := Accttype::Customer;
            LineNo := LineNo + 10000;

            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
              TransDescription, CheckoffHeader.amount, CheckoffHeader."Account No.", CheckoffHeader."Posting Date", BalAccType,
              BalAccNo, '', Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            //Modify Lines
            //ERROR('Testing');
            //JournalPosting.CompletePosting(Jtemplate, JBatch);
            SaccoTrans.PostJournal(JTemplate, JBatch, false);
            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange(CheckoffLines.Posted, false);
            CheckoffLines.ModifyAll(Posted, true);
            Commit;
        end;

        CheckoffHeader.Posted := true;
        CheckoffHeader.Modify;

        Message(Txt0005);

    end;

    procedure ComputeLoanJVentries(LoanNo: Code[20]; JTemplate: Code[20]; Jbatch: Code[20]; DocNo: Code[20]; Pdate: date; TransactionType: enum "Transaction Types"): Decimal
    var
        GenJournalLine: Record "Gen. Journal Line";
        AmountToLoan: Decimal;
    begin
        AmountToLoan := 0;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Loan No", LoanNo);
        GenJournalLine.SetRange("Posting Date", Pdate);
        GenJournalLine.SetRange("Document No.", DocNo);
        GenJournalLine.SetRange("Transaction Type", TransactionType);
        GenJournalLine.SetFilter(Amount, '<%1', 0);
        GenJournalLine.CalcSums(Amount);
        AmountToLoan := Abs(GenJournalLine.Amount);

        exit(AmountToLoan);

    end;

    procedure PostCheckoff(CheckoffHeader: Record "Checkoff Header")
    var
        Loans: Record Loans;
        CheckoffLines: Record "Checkoff Lines";
        RunBal: Decimal;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Txt0000: label 'Loan Repayment';
        CreditAccounts: Record "Credit Accounts";
        Txt0001: label 'Interest Paid';
        Amortised: Decimal;
        Recovery: Decimal;
        Interest: Decimal;
        Txt0002: label 'Deposit Contribution';
        SavingsAccounts: Record "Savings Accounts";
        DepositCont: Decimal;
        Txt0003: label 'Excess Amount';
        LoanAmount: Decimal;
        Txt0004: label 'Checkoff schedule and amount is not equal';
        Txt0005: label 'Batch Posted successfully';
        Txt0006: label 'Principle Recovery';
        LoansBill: Record Loans;
        Txt0007: label 'Loan Repayment -Bills';
        ProductF: Record "Product Factory";
        ShareCap: Decimal;
        PrdFac: Record "Product Factory";
        Txt0008: label 'Share Capital';
        ProgressWindow: Dialog;
        Dim1: Code[20];
        Dim2: Code[20];
        Members: Record Members;
        MemberClass: Record "Member Classes";
        UserSetup: Record "User Setup";
        Txt0009: label 'Vendor:-';
        SavingsAcc: Code[20];
        Text010: label '<Month Text>';
        Text011: label 'Contribution';
        SavingsAccountsBlock: Record "Savings Accounts";
        CreditAccountsBlock: Record "Credit Accounts";
        DepositAccount: Record "Savings Accounts";
    begin

        CheckoffHeader.CalcFields(CheckoffHeader."Scheduled Amount");
        if ROUND(CheckoffHeader."Scheduled Amount", 0.01, '=') <> CheckoffHeader.Amount then
            Error(Txt0004);
        RunBal := 0;


        CheckoffHeader.CalcFields("Scheduled Amount");
        Temp.Get(UserId);

        Jtemplate := Temp."Check Off Template";
        JBatch := Temp."Check Off Batch";

        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        //MESSAGE('%1',JBatch);
        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
        CheckoffLines.SetRange(CheckoffLines.Posted, false);
        if CheckoffLines.Find('-') then begin
            //Progress Window
            ProgressWindow.OPEN('Processing check for Member No. #1#######');
            repeat

                //Blocked Account
                SavingsAccountsBlock.Reset;
                SavingsAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                SavingsAccountsBlock.SetRange(Blocked, SavingsAccountsBlock.Blocked::All);
                if SavingsAccountsBlock.Findset() then begin
                    repeat
                        SavingsAccountsBlock.Blocked := SavingsAccountsBlock.Blocked::" ";
                        SavingsAccountsBlock.Modify;
                    until SavingsAccountsBlock.Next = 0;
                end;

                CreditAccountsBlock.Reset;
                CreditAccountsBlock.SetRange("Member No.", CheckoffLines."Member No.");
                CreditAccountsBlock.SetRange(Blocked, CreditAccountsBlock.Blocked::All);
                if CreditAccountsBlock.Find('-') then begin
                    repeat
                        CreditAccountsBlock.Blocked := CreditAccountsBlock.Blocked::" ";
                        CreditAccountsBlock.Modify;
                    until CreditAccountsBlock.Next = 0;
                end;

                //**SLEEP(100);

                // if DepositAccount.Get(CheckoffLines."Account No.") then begin
                //     if Members.Get(CheckoffLines."Member No.") then begin
                //         if (Members.Status = Members.Status::Dormant) or (Members.Status = Members.Status::New) then begin
                //             Members.Status := Members.Status::Active;
                //             Members.Modify;
                //         end;
                //     end;
                // end;


                ProgressWindow.UPDATE(1, CheckoffLines."Member No.");
                CheckoffLines.TESTFIELD(CheckoffLines."Member No.");
                RunBal := CheckoffLines.Amount;
                //Get Dimensions
                if Members.Get(CheckoffLines."Member No.") then begin
                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";
                end else begin
                    if UserSetup.Get(UserId) then begin
                        Dim1 := UserSetup."Global Dimension 1 Code";
                        Dim2 := UserSetup."Global Dimension 2 Code";
                    end;
                end;
                ///******Multiple Fasle
                if CheckoffLines.Multiple = false then begin
                    Loans.Reset;
                    Loans.SetCurrentkey(Loans."Recovery Priority");
                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                    Loans.SetRange(Loans."Member No.", CheckoffLines."Member No.");
                    Loans.SetRange("Dummy Appraisal", false);
                    Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Checkoff);
                    if Loans.FindSet() then begin
                        repeat
                            //*********************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Repayment Methods other than Reducing Flat
                            if Loans."Interest Calculation Method" <> Loans."interest calculation method"::"Reducing Flat" then begin

                                if RunBal > 0 then begin
                                    Loans.CalcFields(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Outstanding Bills");
                                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                                        Amortised := Loans.Repayment - Loans."Outstanding Balance" * Loans.Interest / 1200
                                    else
                                        Recovery := Loans.Repayment;

                                    if Loans."Outstanding Interest" > 0 then
                                        Interest := Loans."Outstanding Interest"
                                    else
                                        Interest := 0;
                                    //Loans."Outstanding Balance"*Loans.Interest/1200;
                                    Message('Interest %1\%2', Interest, Loans."Loan No.");
                                    //Interest *****************

                                    AcctType := Accttype::Credit;
                                    AccNo := Loans."Loan Account";
                                    TransType := Transtype::"Interest Paid";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                    Amt := 0;
                                    LineNo := LineNo + 10000;
                                    if Interest > 0 then begin
                                        if RunBal > Interest then begin
                                            if Interest > Loans."Outstanding Interest" then
                                                Amt := ROUND(Loans."Outstanding Interest", 1, '=') * -1
                                            else
                                                Amt := ROUND(Interest, 1, '=') * -1;
                                        end;
                                    end;
                                    if Amt <> 0 then
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    RunBal := RunBal - Abs(Amt);

                                    //Repayment**************
                                    Amt := 0;
                                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                                        if Amortised > 0 then begin
                                            if RunBal > Amortised then begin
                                                if Amortised > Loans."Outstanding Balance" then
                                                    Amt := (ROUND(Loans."Outstanding Balance", 1, '=') * -1)
                                                else
                                                    Amt := ROUND(Amortised, 1, '=') * -1;
                                            end;
                                        end;
                                    end else begin
                                        if Recovery > 0 then begin
                                            if RunBal > Recovery then begin
                                                if Recovery > Loans."Outstanding Balance" then
                                                    Amt := (ROUND(Loans."Outstanding Balance", 1, '=') * -1)
                                                else
                                                    Amt := ROUND(Recovery, 1, '=') * -1;
                                            end;
                                        end;

                                    end;

                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::Repayment;
                                    LineNo := LineNo + 10000;

                                    if Amt <> 0 then
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    RunBal := RunBal - Abs(Amt);


                                    LoanAmount := LoanAmount - Abs(Amt);
                                    BalAccNo := '';
                                end;////*******************************End of other Repayment methods other than Reducing Flat
                                    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1Reducing Flat Start Harambee
                            end else begin
                                if RunBal > 0 then begin
                                    Loans.CalcFields(Loans."Outstanding Interest", Loans."Outstanding Balance", Loans."Outstanding Bills");
                                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then
                                        Amortised := RunBal//(Loans."Approved Amount"/Loans.Installments) ////////-Loans."Outstanding Balance"*Loans.Interest/1200
                                    else
                                        Recovery := RunBal;//(Loans."Approved Amount"/Loans.Installments);//Loans.Repayment;

                                    if Loans."Outstanding Interest" > 0 then begin
                                        //Interest:=(Loans.Repayment)-(Loans."Approved Amount"/Loans.Installments)
                                        // Interest:=(Loans."Approved Amount"*(Loans.Interest/24)*(Loans.Installments+1))/(Loans.Installments*100) //***Constant Reducing Flat Interest
                                        if RunBal < Loans."Outstanding Balance" then
                                            Interest := Loans."Outstanding Balance" * (Loans.Interest / 1200) //***Constant Reducing Flat Interest
                                        else
                                            Interest := Loans."Outstanding Interest"

                                    end else
                                        Interest := 0;
                                    //Loans."Outstanding Balance"*Loans.Interest/1200;

                                    //Interest *****************

                                    AcctType := Accttype::Credit;
                                    AccNo := Loans."Loan Account";
                                    TransType := Transtype::"Interest Paid";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                    Amt := 0;
                                    LineNo := LineNo + 10000;
                                    if Interest > 0 then begin
                                        if RunBal > Interest then begin
                                            if Interest > Loans."Outstanding Interest" then
                                                Amt := ROUND(Loans."Outstanding Interest", 1, '=') * -1
                                            else
                                                Amt := ROUND(Interest, 1, '=') * -1;
                                        end;
                                    end;
                                    if Amt <> 0 then
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0001, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    RunBal := RunBal - Abs(Amt);

                                    //Repayment**************
                                    Amt := 0;
                                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                                        if Amortised > 0 then begin
                                            if RunBal >= Amortised then begin
                                                if Amortised > Loans."Outstanding Balance" then
                                                    Amt := (ROUND(Loans."Outstanding Balance") * -1)
                                                else
                                                    Amt := ROUND(Amortised, 1, '=') * -1;
                                            end;
                                        end;
                                    end else begin
                                        if Recovery > 0 then begin
                                            if RunBal > Recovery then begin
                                                if Recovery > Loans."Outstanding Balance" then
                                                    Amt := (ROUND(Loans."Outstanding Balance") * -1)
                                                else
                                                    Amt := ROUND(Recovery) * -1;
                                            end;
                                        end;

                                    end;

                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::Repayment;
                                    LineNo := LineNo + 10000;

                                    if Amt <> 0 then
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0000, Amt, AccNo, CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    RunBal := RunBal - Abs(Amt);

                                    LoanAmount := LoanAmount - Abs(Amt);
                                    BalAccNo := '';
                                end;
                            end;
                        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1Reducing Flat End Harambee
                        until Loans.Next = 0;
                    end;


                    if RunBal > 0 then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetCurrentkey(SavingsAccounts."Recovery Priority");
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                        if SavingsAccounts.Find('-') then begin
                            repeat
                                if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Entrance Fee" then begin

                                    //Registration Fee***************
                                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                    ShareCap := 0;
                                    //Member Category
                                    if Members.Get(SavingsAccounts."Member No.") then begin
                                        if PrdFac.Get(SavingsAccounts."Product Type") then begin

                                            MemberClass.Reset;
                                            MemberClass.SetRange(MemberClass."No.", Members."Member Class");
                                            if MemberClass.Find('-') then begin
                                                ShareCap := MemberClass."Entrance Fee" - SavingsAccounts."Balance (LCY)";
                                                //**ShareCap:=PrdFac."Minimum Contribution"-SavingsAccounts."Balance (LCY)";
                                                if ShareCap > MemberClass."Entrance Fee" then
                                                    ShareCap := MemberClass."Entrance Fee"
                                                else
                                                    if ShareCap < 0 then
                                                        ShareCap := 0;
                                            end;

                                            AcctType := Accttype::Savings;
                                            TransType := Transtype::" ";
                                            LineNo := LineNo + 10000;
                                            if RunBal > ShareCap then
                                                Amt := ShareCap * -1
                                            else
                                                Amt := RunBal * -1;
                                            if Amt <> 0 then
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0008, Amt, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - Abs(Amt);
                                            if Amt <> 0 then begin
                                                Members.Reset;
                                                Members.SetRange("No.", SavingsAccounts."Member No.");
                                                Members.SetFilter(Status, '%1', Members.Status::New);
                                                if Members.FindFirst then
                                                    if Members.Status <> Members.Status::Deceased then
                                                        Members.Status := Members.Status::Active;
                                                Members.Modify;
                                            end;
                                        end;
                                    end;

                                end else
                                    if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Share Capital" then begin
                                        //Share Capital***************
                                        SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                        ShareCap := 0;
                                        if PrdFac.Get(SavingsAccounts."Product Type") then begin
                                            if Members.Get(SavingsAccounts."Member No.") then begin

                                                MemberClass.Reset;
                                                MemberClass.SetRange(MemberClass."No.", Members."Member Class");
                                                if MemberClass.Find('-') then begin

                                                    ShareCap := MemberClass."Share Capital" - SavingsAccounts."Balance (LCY)";
                                                    if ShareCap > MemberClass."Default Share Capital" then
                                                        ShareCap := MemberClass."Default Share Capital"
                                                    else
                                                        if ShareCap < 0 then
                                                            ShareCap := 0;
                                                end;

                                                AcctType := Accttype::Savings;
                                                TransType := Transtype::" ";
                                                LineNo := LineNo + 10000;
                                                if RunBal > ShareCap then
                                                    Amt := ShareCap * -1
                                                else
                                                    Amt := RunBal * -1;
                                                if Amt <> 0 then
                                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                    Txt0008, Amt, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                                RunBal := RunBal - Abs(Amt);
                                            end;
                                        end;

                                    end else
                                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin

                                            //Deposit Contribution**********
                                            SavingsAcc := SavingsAccounts."No.";
                                            MemberClass.Reset;
                                            MemberClass.SetRange(MemberClass."No.", Members."Member Class");
                                            if MemberClass.Find('-') then begin
                                                if MemberClass."Default BOSA Deposit" > SavingsAccounts."Monthly Contribution" then
                                                    DepositCont := MemberClass."Default BOSA Deposit"
                                                else
                                                    DepositCont := SavingsAccounts."Monthly Contribution";

                                            end;
                                            if DepositCont = 0 then
                                                DepositCont := SavingsAccounts."Monthly Contribution";

                                            AcctType := Accttype::Savings;
                                            TransType := Transtype::" ";
                                            LineNo := LineNo + 10000;
                                            if RunBal > DepositCont then
                                                Amt := DepositCont * -1
                                            else
                                                Amt := RunBal * -1;

                                            if Amt <> 0 then
                                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                                Txt0002, Amt, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            RunBal := RunBal - Abs(Amt);

                                        end;
                            until SavingsAccounts.Next = 0;
                            //Excess Deposits

                            //Clear Arreas  **********Outstanding Bills
                            /*          IF RunBal>0 THEN BEGIN
                                       LoansBill.RESET;
                                       LoansBill.SETCURRENTKEY(LoansBill."Recovery Priority");
                                       LoansBill.SETFILTER(LoansBill."Outstanding Balance",'>0');
                                       LoansBill.SETRANGE(LoansBill."Member No.",CheckoffLines."Member No.");
                                       IF LoansBill.FIND('-') THEN BEGIN
                                         REPEAT
                                           LoansBill.CALCFIELDS(LoansBill."Outstanding Bills","Outstanding Balance");
                                           IF LoansBill."Outstanding Bills">0 THEN BEGIN

                                                Amt:=0;
                                                IF RunBal>LoansBill."Outstanding Bills" THEN
                                                 Amt:=LoansBill."Outstanding Bills"*-1
                                                 ELSE
                                                 Amt:=RunBal*-1;

                            //Repayment++++++++++++

                                             IF ProductF.GET(LoansBill."Loan Product Type") THEN BEGIN
                                              ProductF.TESTFIELD(ProductF."Billed Account");
                                               BalAccNo:=ProductF."Billed Account";
                                               END;
                                               TransType:=TransType::Repayment;
                                               LineNo:=LineNo+10000;

                                               JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,CheckoffHeader."Document No.",
                                               Txt0000,Amt,LoansBill."Loan Account",CheckoffHeader."Posting Date",BalAccType,
                                               BalAccNo,LoansBill."Loan No.",Dim1,Dim2,TransType,LoansBill."Loan No.",'','',0,'',0);
                                              // LoanAmount:=LoanAmount-ABS(Amt);
                                               BalAccNo:='';




                            //Bills++++++++++++
                                             IF ProductF.GET(LoansBill."Loan Product Type") THEN BEGIN
                                              ProductF.TESTFIELD(ProductF."Billed Account");
                                               BalAccNo:=ProductF."Billed Account";
                                               END;
                                               TransType:=TransType::Bills;
                                               LineNo:=LineNo+10000;
                                               JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,CheckoffHeader."Document No.",
                                               Txt0007,Amt,LoansBill."Loan Account",CheckoffHeader."Posting Date",BalAccType,
                                               BalAccNo,LoansBill."Loan No.",Dim1,Dim2,TransType,LoansBill."Loan No.",'','',0,'',0);
                                               RunBal:=RunBal-ABS(Amt);
                                               BalAccNo:='';
                                               END;
                                           UNTIL LoansBill.NEXT=0;
                                           END;
                                         END;*/
                            //End of Arreas++++++++++++

                            if RunBal > 0 then begin

                                if CheckoffLines."Member No." <> '' then begin
                                    //------------Unallocated Account

                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                                    if SavingsAccounts.Find('-') then begin
                                        if LoanAmount > 0 then begin
                                            AcctType := Accttype::Savings;
                                            LineNo := LineNo + 10000;

                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                              Txt0003, RunBal * -1, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                              BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            LoanAmount := 0;
                                        end;
                                    end;
                                    //----------------Deposits
                                    AcctType := Accttype::Savings;
                                    TransType := Transtype::" ";
                                    LineNo := LineNo + 10000;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                    Txt0003, RunBal * -1, SavingsAcc, CheckoffHeader."Posting Date", BalAccType,
                                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                            end;
                        end;
                    end;
                    if RunBal > 0 then begin
                        //Vendor Posting
                        if CheckoffLines."Member No." = '' then begin
                            CheckoffHeader.TestField("Vendor No");
                            //Credit Vendor
                            if RunBal > 0 then begin
                                AcctType := Accttype::Vendor;
                                TransType := Transtype::" ";
                                LineNo := LineNo + 10000;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                PadStr(CheckoffLines.Name + ' ' + CheckoffLines."Payroll No.", 50), RunBal * -1, CheckoffHeader."Vendor No", CheckoffHeader."Posting Date", BalAccType,
                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end;
                    end;
                end else begin
                    //     Mutipile TRUE
                    LoanAmount := CheckoffLines.Amount;
                    //Savings Account
                    if CheckoffLines."Savings Account" = true then begin
                        AcctType := Accttype::Savings;
                        TransType := Transtype::" ";
                        LineNo := LineNo + 10000;
                        if CheckoffLines."Account No." <> '' then begin
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                              Format(CheckoffHeader."Posting Date", 0, Text010) + Text011 + '-' + CheckoffHeader."Employer Code", CheckoffLines.Amount * -1, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                              BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LoanAmount := 0;
                        end;
                    end;


                    //Credit Account
                    if CheckoffLines."Credit Account" = true then begin
                        //LoanAmount:=CheckoffLines.Amount;
                        Loans.Reset;
                        Loans.SetCurrentkey(Loans."Recovery Priority");
                        //Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                        Loans.SetRange(Loans."Member No.", CheckoffLines."Member No.");
                        Loans.SetRange(Loans."Loan No.", CheckoffLines."Loan No.");
                        Loans.SETRANGE(Loans."Recovery Mode", Loans."Recovery Mode"::Checkoff);
                        if Loans.Find('-') then begin

                            Loans.CalcFields(Loans."Outstanding Interest", Loans."Outstanding Balance");
                            ///--------------------------------------------------------With Type option
                            //Interest
                            //##################################REDUCING NORMAL
                            if (Loans."Interest Calculation Method" <> Loans."interest calculation method"::"Reducing Flat") and
                            (Loans."Interest Calculation Method" <> Loans."interest calculation method"::Amortised) then begin
                                // MESSAGE('%1',Loans."Loan No.");
                                if CheckoffLines.Type <> CheckoffLines.Type::" " then begin
                                    if Loans."Outstanding Interest" > 0 then begin
                                        // IF CheckoffLines.Type=CheckoffLines.Type::sInterest THEN BEGIN ///Daisy  not to check type
                                        AcctType := Accttype::Credit;
                                        TransType := Transtype::"Interest Paid";
                                        LineNo := LineNo + 10000;
                                        BalAccNo := '';
                                        Amt := 0;
                                        if LoanAmount > Loans."Outstanding Interest" then
                                            Amt := Loans."Outstanding Interest" * -1
                                        else
                                            Amt := LoanAmount * -1;



                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0001, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        LoanAmount := LoanAmount - Abs(Amt);
                                    end;
                                    // END;
                                    //Repayment
                                    // IF CheckoffLines.Type=CheckoffLines.Type::sLoan THEN BEGIN///Daisy not to check type
                                    if Loans."Outstanding Balance" > 0 then begin
                                        AcctType := Accttype::Credit;
                                        TransType := Transtype::Repayment;
                                        LineNo := LineNo + 10000;
                                        BalAccNo := '';
                                        Amt := 0;
                                        if LoanAmount > Loans."Outstanding Balance" then
                                            Amt := ROUND(Loans."Outstanding Balance") * -1
                                        else
                                            Amt := ROUND(LoanAmount) * -1;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0000, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        LoanAmount := LoanAmount - Abs(Amt);


                                        BalAccNo := '';
                                    end;
                                    // END;
                                    ///--------------------------------------------------------With Type option
                                end else begin
                                    ///--------------------------------------------------------Without Type option
                                    //Interest
                                    if Loans."Outstanding Interest" > 0 then begin
                                        AcctType := Accttype::Credit;
                                        TransType := Transtype::"Interest Paid";
                                        LineNo := LineNo + 10000;
                                        BalAccNo := '';
                                        Amt := 0;
                                        if LoanAmount > Loans."Outstanding Interest" then
                                            Amt := ROUND(Loans."Outstanding Interest") * -1
                                        else
                                            Amt := ROUND(LoanAmount) * -1;



                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0001, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        LoanAmount := LoanAmount - Abs(Amt);
                                    end;


                                    //Repayment
                                    if Loans."Outstanding Balance" > 0 then begin
                                        AcctType := Accttype::Credit;
                                        TransType := Transtype::Repayment;
                                        LineNo := LineNo + 10000;
                                        BalAccNo := '';
                                        Amt := 0;
                                        if LoanAmount > Loans."Outstanding Balance" then
                                            Amt := ROUND(Loans."Outstanding Balance") * -1
                                        else
                                            Amt := ROUND(LoanAmount) * -1;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                        Txt0000, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        LoanAmount := LoanAmount - Abs(Amt);


                                        BalAccNo := '';
                                    end;
                                end;

                            end else begin
                                ///##################################Reducing Flat
                                //  IF Loans."Interest Calculation Method"=Loans."Interest Calculation Method"::"Reducing Flat" THEN BEGIN
                                if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") then begin
                                    Recovery := Loans."Outstanding Balance";//ROUND((Loans."Approved Amount"/Loans.Installments),0.05,'='); ////////-Loans."Outstanding Balance"*Loans.Interest/1200
                                                                            //Interest:=ROUND((Loans.Repayment)-(Loans."Approved Amount"/Loans.Installments),0.05,'=');
                                    if LoanAmount < Loans."Outstanding Balance" then
                                        Interest := ROUND(Loans."Outstanding Balance" * (Loans.Interest / 1200), 0.05, '=')
                                    else
                                        Interest := Loans."Outstanding Interest";

                                    //Interest:=ROUND((Loans."Approved Amount"*(Loans.Interest/24)*(Loans.Installments+1))/(Loans.Installments*100),0.05,'='); //***Constant Reducing Flat Interest
                                    if Interest < 0 then
                                        Interest := 0;
                                    if Recovery + Interest > LoanAmount then begin
                                        Recovery := LoanAmount - Interest;
                                        if Recovery < 0 then
                                            Recovery := LoanAmount;

                                        Interest := LoanAmount - Recovery;
                                        if Interest < 0 then
                                            Interest := 0;

                                    end;
                                end else
                                    if (Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised) then begin
                                        Recovery := Loans."Outstanding Balance";//Loans.Repayment;
                                        Interest := Loans."Outstanding Interest";
                                    end;

                                //MESSAGE('%1 and %2 and %3',Interest,LoanAmount,Recovery);
                                /*
                                                IF Loans."Outstanding Interest">0 THEN

                                                ELSE
                                                  Interest:=0;
                                               */

                                //Interest++++++++++++

                                if Interest > LoanAmount then
                                    Interest := LoanAmount;
                                if Loans."Outstanding Interest" > 0 then begin
                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::"Interest Paid";
                                    LineNo := LineNo + 10000;
                                    BalAccNo := '';
                                    Amt := 0;
                                    if Interest > Loans."Outstanding Interest" then
                                        Amt := ROUND(Loans."Outstanding Interest") * -1
                                    else
                                        Amt := ROUND(Interest) * -1;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                    Txt0001, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := LoanAmount - Abs(Amt);
                                end;
                                //Repayment++++++++
                                //IF Recovery>LoanAmount THEN
                                Recovery := LoanAmount;
                                if Loans."Outstanding Balance" > 0 then begin
                                    AcctType := Accttype::Credit;
                                    TransType := Transtype::Repayment;
                                    LineNo := LineNo + 10000;
                                    BalAccNo := '';
                                    Amt := 0;
                                    if Recovery > Loans."Outstanding Balance" then
                                        Amt := ROUND(Loans."Outstanding Balance" * -1)
                                    else
                                        Amt := Recovery * -1;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                    Txt0000, Amt, CheckoffLines."Account No.", CheckoffHeader."Posting Date", BalAccType,
                                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := LoanAmount - Abs(Amt);


                                    BalAccNo := '';
                                end;
                                //End Reducing Flat
                            end;
                        end;

                        //Excess Deposit
                        //------------Unallocated Account

                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                        if SavingsAccounts.Find('-') then begin
                            if LoanAmount > 0 then begin
                                AcctType := Accttype::Savings;
                                LineNo := LineNo + 10000;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                 Txt0003, LoanAmount * -1, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                 BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                LoanAmount := 0;

                            end;
                        end;

                        //-------------Deposits
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetCurrentkey(SavingsAccounts."Recovery Priority");
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                        SavingsAccounts.SetRange(SavingsAccounts."Can Guarantee Loan", true);
                        if SavingsAccounts.Find('-') then begin
                            if LoanAmount > 0 then begin
                                AcctType := Accttype::Savings;
                                LineNo := LineNo + 10000;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                 Txt0003, LoanAmount * -1, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                 BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end;

                    end else begin
                        if CheckoffLines."Savings Account" = false then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                            if SavingsAccounts.Find('-') then begin
                                if LoanAmount > 0 then begin
                                    AcctType := Accttype::Savings;
                                    LineNo := LineNo + 10000;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                                     Txt0003, LoanAmount * -1, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                                     BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    LoanAmount := 0;

                                end;
                            end;
                        end;
                    end;
                end;

                if LoanAmount > 0 then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Unallocated Fund");
                    if SavingsAccounts.Find('-') then begin
                        if LoanAmount > 0 then begin
                            AcctType := Accttype::Savings;
                            LineNo := LineNo + 10000;

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                             Txt0003, LoanAmount * -1, SavingsAccounts."No.", CheckoffHeader."Posting Date", BalAccType,
                             BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LoanAmount := 0;
                        end;
                    end;
                end;
                ;

                //Customer Amount
                AcctType := Accttype::Customer;
                LineNo := LineNo + 10000;

                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CheckoffHeader."Document No.",
                  CheckoffHeader.Description + '-' + CheckoffHeader."Employer Code", CheckoffLines.Amount, CheckoffHeader."Account No.", CheckoffHeader."Posting Date", BalAccType,
                  BalAccNo, '', Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //Modify Lines
                //ERROR('Testing');
                JournalPosting.CompletePosting(Jtemplate, JBatch);

                CheckoffLines.Posted := true;
                CheckoffLines.Modify;


                Commit;

            until CheckoffLines.Next = 0;
        end;

        CheckoffHeader.Posted := true;
        CheckoffHeader.Modify;

        Message(Txt0005);

    end;



    procedure ProcessAdvice(CheckoffAdviceHeader: Record "Checkoff Advice Header")
    var
        AdviceLine: Record "Checkoff Advice Line";
    begin
        AdviceLine.Reset;
        AdviceLine.SetRange(AdviceLine."Advice Header No.", CheckoffAdviceHeader."No.");
        if AdviceLine.Find('-') then begin
            repeat
                AdviceLine.Processed := true;
                AdviceLine.Modify;
            until AdviceLine.Next = 0;
        end;

        AdviceLine.Reset;
        AdviceLine.SetRange(Transfered, true);
        if AdviceLine.Find('-') then begin
            repeat
                AdviceLine.Processed := true;
                AdviceLine.Modify;
            until AdviceLine.Next = 0;
        end;

        CheckoffAdviceHeader.Processed := true;
        CheckoffAdviceHeader.Modify;
        if CheckoffAdviceHeader.Processed = true then
            Message('Advice Processed Successfully');
    end;



    procedure RescheduleLoan(LoanRescheduling: Record "Loan Rescheduling")
    var
        Loans: Record Loans;
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        LastCount: Integer;
        InPeriod: DateFormula;
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[10];
        LoanSch: Record Loans;
        PaymentMethods: Record "Payment Methods";
        PaymentMethodsApplication: Record "Payment Methods Application";
    begin
        if Loans.Get(LoanRescheduling."Loan No.") then begin
            //Claer Reamaing Reschedule before creating the new Reschedule
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", LoanRescheduling."Rescheduling Date", 99991230D);
            if LoanRepaymentSchedule.Find('-') then begin
                LoanRepaymentSchedule.DeleteAll;
            end;

            //Check last installment NO.

            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", 0D, 99991230D);
            if LoanRepaymentSchedule.FindLast then begin
                LastCount := LoanRepaymentSchedule."Instalment No";
            end;

            if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                Evaluate(InPeriod, '1D')
            else
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                    Evaluate(InPeriod, '1W')
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                        Evaluate(InPeriod, '1M')
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                            Evaluate(InPeriod, '1Q');

            QCounter := 0;
            QCounter := 3;


            LoanRescheduling.TestField(LoanRescheduling."Rescheduling Date");

            LoanAmount := LoanRescheduling."Outstanding Balance";
            //InterestRate := Loans.Interest;
            InterestRate := LoanRescheduling."New Interest Rate";
            RepayPeriod := LoanRescheduling."New Installments";
            InitialInstal := LoanRescheduling."New Installments";
            LBalance := LoanRescheduling."Outstanding Balance";
            RunDate := LoanRescheduling."Rescheduling Date";

            InstalNo := LastCount;
            //Repayment Frequency
            if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                            RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;

                //Repayment Frequency
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate);
                //Repayment Frequency

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    Loans.TestField(Loans.Interest);
                    LoanRescheduling.TestField("New Installments");
                    TotalMRepay := ROUND((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;

                    //Update Reschedule
                    Loans.Repayment := LInterest + LPrincipal;
                    Loans."Loan Principle Repayment" := LPrincipal;
                    Loans."Loan Interest Repayment" := LInterest;

                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                    Loans.TestField(Loans.Interest);
                    LoanRescheduling.TestField("New Installments");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LoanAmount;

                    //Update Reschedule
                    Loans.Repayment := LPrincipal;
                    Loans."Loan Principle Repayment" := LPrincipal;
                    Loans."Loan Interest Repayment" := LInterest;

                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then begin
                    Loans.TestField(Loans.Interest);
                    LoanRescheduling.TestField("New Installments");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LBalance;
                    //Update Reschedue
                    Loans.Repayment := LPrincipal;
                    Loans."Loan Principle Repayment" := LPrincipal;
                    Loans."Loan Interest Repayment" := LInterest;
                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
                    Loans.TestField(Loans.Interest);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
                    LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                    Loans.Repayment := LPrincipal + LInterest;
                    if LBalance < Loans.Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Loans.Repayment;
                    LInterest := Loans.Interest;

                    //Update Reschedule
                    Loans.Repayment := LPrincipal;

                end;
                //Loop the Balance
                LBalance := LBalance - LPrincipal;

                Evaluate(RepayCode, Format(InstalNo));
                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                if LoanRepaymentSchedule.FindFirst() then
                    LoanRepaymentSchedule.DeleteAll();

                LoanRepaymentSchedule.Init;
                LoanRepaymentSchedule."Repayment Code" := RepayCode;
                LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                LoanRepaymentSchedule."Loan Amount" := LoanRescheduling."Outstanding Balance";
                LoanRepaymentSchedule."Instalment No" := RepayPeriod;
                LoanRepaymentSchedule."Repayment Date" := RunDate;
                LoanRepaymentSchedule."Member No." := LoanRescheduling."Member No.";
                LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal;
                LoanRepaymentSchedule."Monthly Interest" := LInterest;
                LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                LoanRepaymentSchedule."Reset Doc No." := LoanRescheduling."No.";
                LoanRepaymentSchedule."Reset Schedule" := true;
                LoanRepaymentSchedule.Insert;
            until LBalance < 1;

            Loans."New No. of Installment" := LoanRescheduling."New Installments";
            Loans.Installments := RepayPeriod;

            Loans."New Interest Rate" := LoanRescheduling."New Interest Rate";
            Loans.Interest := LoanRescheduling."New Interest Rate";
            Loans."Loan Rescheduled" := true;
            Loans."Date Rescheduled" := Today;
            Loans."Reschedule by" := UserId;
            Loans."Loan Balance at Rescheduling" := LoanRescheduling."Outstanding Balance";
            Loans."Last Advice Date" := Today;
            Loans."Advice Type" := Loans."advice type"::Adjustment;
            Loans.Validate(Loans.Repayment);
            Loans.Modify;

            LoanRescheduling."New Amortised" := LInterest + LPrincipal;
            LoanRescheduling.Modify;
            Commit;

            //Run the Generated Schedule
            // LoanSch.Reset;
            // LoanSch.SetRange(LoanSch."Loan No.", Loans."Loan No.");
            // if LoanSch.Find('-') then
            //     Report.Run(Report::"Posted Checkoff Receipts", true, false, LoanSch);

            Loans."New No. of Installment" := LoanRescheduling."New Installments";
            Loans."Loan Rescheduled" := true;
            Loans.Repayment := LoanRescheduling."New Amortised";
            Loans.Modify;
            LoanRescheduling.Rescheduled := true;
            LoanRescheduling."Date Commited" := Today;
            LoanRescheduling.Modify;
        end;

    end;

    procedure RescheduleLoanII(LoanRescheduling: Record "Loan Rescheduling")
    var
        Loans: Record Loans;
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        LastCount: Integer;
        InPeriod: DateFormula;
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[10];
        LoanSch: Record Loans;
        PaymentMethods: Record "Payment Methods";
        PaymentMethodsApplication: Record "Payment Methods Application";
    begin
        //with LoanRescheduling do
        begin
            if Loans.Get(LoanRescheduling."Loan No.") then begin
                //Claer Reamaing Reschedule before creating the new Reschedule
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
                //LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", LoanRescheduling."Rescheduling Date", 99991230D);
                if LoanRepaymentSchedule.Find('-') then begin
                    LoanRepaymentSchedule.DeleteAll;
                end;

                //Check last installment NO.

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
                LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", 0D, 99991230D);
                if LoanRepaymentSchedule.FindLast then begin
                    LastCount := LoanRepaymentSchedule."Instalment No";
                end;

                // if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                //     Evaluate(InPeriod, '1D')
                // else
                //     if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                //         Evaluate(InPeriod, '1W')
                //     else
                //         if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                //             Evaluate(InPeriod, '1M')
                //         else
                //             if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                //                 Evaluate(InPeriod, '1Q');

                QCounter := 0;
                QCounter := 3;

                LoanRescheduling.TestField(LoanRescheduling."Rescheduling Date");
                LoanAmount := LoanRescheduling."Outstanding Balance";
                //InterestRate := Loans.Interest;
                InterestRate := LoanRescheduling."New Interest Rate";
                RepayPeriod := LoanRescheduling."New Installments";
                InitialInstal := LoanRescheduling."New Installments";
                LBalance := LoanRescheduling."Outstanding Balance";
                RunDate := calcdate('<CM>', LoanRescheduling."Rescheduling Date");

                InstalNo := LastCount;

                repeat
                    InstalNo := InstalNo + 1;
                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                        Loans.TestField(Loans.Interest);
                        LoanRescheduling.TestField("New Installments");
                        TotalMRepay := ROUND((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;

                        // //Update Reschedule
                        // Loans.Repayment := LInterest + LPrincipal;
                        // Loans."Loan Principle Repayment" := LPrincipal;
                        // Loans."Loan Interest Repayment" := LInterest;

                    end;

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                        Loans.TestField(Loans.Interest);
                        LoanRescheduling.TestField("New Installments");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LoanAmount;

                        // //Update Reschedule
                        // Loans.Repayment := LPrincipal;
                        // Loans."Loan Principle Repayment" := LPrincipal;
                        // Loans."Loan Interest Repayment" := LInterest;

                    end;

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then begin
                        Loans.TestField(Loans.Interest);
                        LoanRescheduling.TestField("New Installments");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LBalance;
                        //Update Reschedue
                        // Loans.Repayment := LPrincipal;
                        // Loans."Loan Principle Repayment" := LPrincipal;
                        // Loans."Loan Interest Repayment" := LInterest;
                    end;

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
                        Loans.TestField(Loans.Interest);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        Loans.Repayment := LPrincipal + LInterest;
                        if LBalance < Loans.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := Loans.Repayment;
                        LInterest := Loans.Interest;

                        //Update Reschedule
                        // Loans.Repayment := LPrincipal;

                    end;
                    //Loop the Balance
                    LBalance := LBalance - LPrincipal;

                    Evaluate(RepayCode, Format(InstalNo));

                    LoanRepaymentSchedule.Init;
                    LoanRepaymentSchedule."Repayment Code" := RepayCode;
                    LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                    LoanRepaymentSchedule."Loan Amount" := LoanRescheduling."Outstanding Balance";
                    LoanRepaymentSchedule."Instalment No" := RepayPeriod;
                    LoanRepaymentSchedule."Repayment Date" := RunDate;
                    LoanRepaymentSchedule."Member No." := LoanRescheduling."Member No.";
                    LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                    LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    LoanRepaymentSchedule."Ideal Loan Bal" := LBalance;
                    LoanRepaymentSchedule."Monthly Interest" := LInterest;
                    LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                    LoanRepaymentSchedule."Reset Doc No." := LoanRescheduling."No.";
                    LoanRepaymentSchedule."Reset Schedule" := true;
                    LoanRepaymentSchedule.Insert;

                    // Repayment Frequency
                    //Repayment Frequency
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                            RunDate := calcdate('<CW>', (CalcDate('1W', RunDate)))
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                                RunDate := calcdate('<CM>', (CalcDate('1M', RunDate)))
                            else
                                if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                    RunDate := calcdate('<CM>', (CalcDate('1Q', RunDate)));
                until LBalance < 1;
            end;
        end;
    end;


    procedure CheckSavingsAccountBal(ATMApplications: Record "ATM Applications")
    var
        SavingsAccounts: Record "Savings Accounts";
        Account: Record "Savings Accounts";
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        ProdType: Record "Product Factory";
        TChargeAmount: Decimal;
    begin
        AvailableBalance := 0;
        MinBalance := 0;
        TChargeAmount := 0;
        if Account.Get(ATMApplications."Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft");

            ProdType.Reset;
            ProdType.SetRange(ProdType."Product ID", Account."Product Type");
            if ProdType.Find('-') then begin
                MinBalance := ProdType."Minimum Balance";

                AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques");
            end;
        end;
        Message('balance is %1', AvailableBalance);
    end;


    procedure PostATMApplicationCharges(ATMLinking: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        SavingsAccounts: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        Trans: Record "Cashier Transactions";
        GenSetup: Record "General Set-Up";
        AccountTypes: Record "Product Factory";
        TransType: Record "Transaction Types";
        JTemp: Code[20];
        JBatch: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        MSGPosted: label 'Posted Successfuly';
        ATMCharge: label 'Atm Card Charges';
        ATMCardTypes: Record "ATM Card Types";
        SendSMS: Codeunit SendSms;
        SavingsAcc: Record "Savings Accounts";
        Txt004: label 'Your ATM Card application has been received and is being processed.';
        CashierTransactions: Record "Cashier Transactions";
        ATMApplications: record "ATM Applications";
        AvaialableBal: Decimal;
        GlobalFunc: Codeunit "Global Functions";
        TotalCharge: Decimal;

    begin
        ATMApplications.reset;
        ATMApplications.setrange("No.", ATMLinking."ATM Application No.");
        if ATMApplications.FindFirst() then begin
            if ATMApplications."ATM Charges Applied" = true then begin
                ATMLinking."ATM Charges Applied" := true;
                ATMLinking.Modify;
                Commit();
                Error('This account has already been applied ATM charges');
            end;
            if Confirm('Confirm ATM Charges?') then begin
                if ATMApplications."Request Type" = ATMApplications."request type"::New then begin

                    //Check FOSA Account Bal
                    SavingsAcc.Reset();
                    SavingsAcc.SetRange("No.", ATMApplications."Account No");
                    if SavingsAcc.FindFirst() then begin
                        SavingsAcc.CalcFields("Balance (LCY)");
                        AvaialableBal := GlobalFunc.GetSavingsAccountAvailableBalance(SavingsAcc, true);
                    end;

                    // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                    BankingUserTemplate.Get(UserId);
                    JTemp := BankingUserTemplate."ATM Charges Journal Template";
                    JBatch := BankingUserTemplate."ATM Charges Journal Batch";

                    if JTemp = '' then Error('ATM Charges journal template must be present for you to proceed');
                    if JBatch = '' then Error('ATM Charges journal batch must be present for you to proceed');

                    LineNo := 0;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemp);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;

                    GenSetup.Get;
                    ChargeAmount := 0;
                    ATMCardTypes.Reset;
                    ATMCardTypes.SetRange(ATMCardTypes.Code, ATMApplications."Card Type");
                    if ATMCardTypes.Find('-') then begin
                        //   MESSAGE('here');
                        TransType.Reset;
                        TransType.SetRange(TransType.Code, ATMCardTypes."Application Charge Code");//TransType.Type::"ATM Applications");
                        if TransType.Find('-') then begin
                            ChargeAmount := 0;
                            TotalCharge := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransType.Code);
                            if TransactionCharges.Find('-') then begin
                                repeat
                                    ChargeAmount := 0;
                                    TotalCharge := 0;
                                    // if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                                    // (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin
                                    //     if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                    //         ChargeAmount := TransactionCharges."Charge Amount"//(TransType.Amount*TransactionCharges."Percentage of Amount")*0.01
                                    //     else
                                    //         ChargeAmount := TransactionCharges."Charge Amount";
                                    //     TChargeAmount += ChargeAmount;

                                    //                    IF TransactionCharges."Transaction Charge Category"<>TransactionCharges."Transaction Charge Category"::"Stamp Duty" THEN
                                    //                      BEGIN
                                    //                    //Excise Duty
                                    //                    TChargeAmount:=TChargeAmount+(ChargeAmount*GenSetup."Excise Duty (%)")*0.01;;
                                    //                    END;
                                    // end;
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Reset;
                                    GenJournalLine."Journal Template Name" := JTemp;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := ATMApplications."No.";
                                    GenJournalLine."External Document No." := ATMApplications."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := ATMCharge;
                                    GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Reset;
                                    GenJournalLine."Journal Template Name" := JTemp;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := ATMApplications."No.";
                                    GenJournalLine."External Document No." := ATMApplications."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := ATMApplications."Account No";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := ATMCharge;
                                    GenJournalLine.Amount := TransactionCharges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



                                    if TransactionCharges."Recover Excise Duty" then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := JTemp;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Document No." := ATMApplications."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := GenSetup."Excise Duty G/L";
                                        //GenJournalLine."Account No." := ATMApplications."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Excise Duty';
                                        GenJournalLine."Currency Code" := '';
                                        GenJournalLine.Amount := -(TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        // GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";

                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Reset;
                                        GenJournalLine."Journal Template Name" := JTemp;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Document No." := ATMApplications."No.";
                                        GenJournalLine."External Document No." := ATMApplications."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := ATMApplications."Account No";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := ATMCharge;
                                        GenJournalLine.Amount := (TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;



                                    // TChargeAmount := TChargeAmount + ChargeAmount;
                                    TotalCharge := TotalCharge + (TransactionCharges."Charge Amount" + ((TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)") * 0.01));


                                // MESSAGE('Charge Amount %1',ChargeAmount)
                                until TransactionCharges.Next = 0;

                                if TotalCharge > AvaialableBal then begin
                                    error('Total Charge is > Available Bal');
                                end;
                                //MESSAGE('Charge Amountwww %1',ChargeAmount)
                                //      END;

                                //END;

                                // LineNo := LineNo + 10000;

                                // GenJournalLine.Reset;
                                // GenJournalLine."Journal Template Name" := JTemp;
                                // GenJournalLine."Journal Batch Name" := JBatch;
                                // GenJournalLine."Document No." := ATMApplications."No.";
                                // GenJournalLine."External Document No." := ATMApplications."No.";
                                // GenJournalLine."Line No." := LineNo;
                                // GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                // GenJournalLine."Account No." := ATMApplications."Account No";
                                // GenJournalLine."Posting Date" := Today;
                                // GenJournalLine.Description := ATMCharge;
                                // GenJournalLine.Amount := TChargeAmount;
                                // GenJournalLine.Validate(GenJournalLine.Amount);
                                // GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                // GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                // //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                // //GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
                                // if GenJournalLine.Amount <> 0 then
                                //     GenJournalLine.Insert;

                                //Excise Duty
                                //     if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                // (TransactionCharges."Recover Excise Duty" = true) then begin

                                // GenJournalLine.Init;
                                // GenJournalLine."Journal Template Name" := Jtemplate;
                                // GenJournalLine."Journal Batch Name" := JBatch;
                                // GenJournalLine."Line No." := LineNo;
                                // GenJournalLine."Document No." := ATMApplications."No.";
                                // GenJournalLine."Posting Date" := ATMApplications."ATM Charged Date";
                                // GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                // GenJournalLine."Account No." := SalLines."Account No.";
                                // GenJournalLine.Validate(GenJournalLine."Account No.");
                                // GenJournalLine.Description := PostingRemarks;
                                // GenJournalLine.Amount := -SalLines.Amount;
                                // GenJournalLine.Validate(GenJournalLine.Amount);
                                // GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                // GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                // if GenJournalLine.Amount <> 0 then
                                //     GenJournalLine.Insert;


                            end;
                            //Excise Duty

                            // MESSAGE('Charge Amount %1',ChargeAmount)
                            //send sms
                            // if SavingsAcc.Get(ATMApplications."Account No") then begin
                            //     SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Mobile Phone No", Txt004, Format(ATMApplications."No."), '', true, 0, false, 'CBS', ATMApplications."No.", 'CBS');
                            // end;
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", JTemp);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                /*SavingsAcc.Reset();
                                SavingsAcc.SetRange("Payroll/Staff No.",ATMApplications."Service No");
                                SavingsAcc.SetRange("Product Category", SavingsAcc."product category"::"FOSA Account");
                                if savingsAcc.Find('-') then begin
                                    SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Transactional Mobile No", Txt004+format(TotalCharge), Format(ATMApplications."No."), '', true, 0, false, 'CBS', ATMApplications."No.", 'CBS');
                                end;*/
                            end;
                            //Post New
                            ATMApplications."ATM Charges Applied" := true;
                            ATMApplications."ATM Charged Date" := Today;
                            ATMApplications.Modify;
                            CashierTransactions.Reset;
                            CashierTransactions.SetRange(CashierTransactions."Account No", ATMApplications."Account No");
                            CashierTransactions.SetRange(Remarks, 'ATM Application Charges');
                            if CashierTransactions.Find('-')
                              then begin
                                repeat
                                    //ERROR('here');
                                    CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                                    CashierTransactions.Modify;
                                until CashierTransactions.Next = 0;
                            end;

                            ATMApplications."Card Charged" := true;
                            ATMApplications.Modify();
                            Message(MSGPosted);

                        end;

                        // end;
                    end else begin
                        Error('ATM Card Types: %1 does not exist', ATMApplications."Card Type");
                    end;
                end
                else begin
                    BankingUserTemplate.Get(UserId);
                    JTemp := BankingUserTemplate."ATM Charges Journal Template";
                    JBatch := BankingUserTemplate."ATM Charges Journal Batch";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemp);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;
                    GenSetup.Get;
                    ChargeAmount := 0;
                    ATMCardTypes.Reset;
                    ATMCardTypes.SetRange(ATMCardTypes.Code, ATMApplications."Card Type");
                    if ATMCardTypes.Find('-') then begin
                        //   MESSAGE('here');
                        TransType.Reset;
                        TransType.SetRange(TransType.Code, ATMCardTypes."Replacement Charge Code");//."Application Charge Code");//TransType.Type::"ATM Applications");
                        if TransType.Find('-') then begin
                            ChargeAmount := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransType.Code);
                            if TransactionCharges.Find('-') then begin
                                repeat
                                    ChargeAmount := 0;
                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin
                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                            ChargeAmount := TransactionCharges."Charge Amount"//(TransType.Amount*TransactionCharges."Percentage of Amount")*0.01
                                        else
                                            ChargeAmount := TransactionCharges."Charge Amount";
                                        TChargeAmount += ChargeAmount;

                                        //                    IF TransactionCharges."Transaction Charge Category"<>TransactionCharges."Transaction Charge Category"::"Stamp Duty" THEN
                                        //                      BEGIN
                                        //                    //Excise Duty
                                        //                    TChargeAmount:=TChargeAmount+(ChargeAmount*GenSetup."Excise Duty (%)")*0.01;;
                                        //                    END;
                                    end;
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Reset;
                                    GenJournalLine."Journal Template Name" := JTemp;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := ATMApplications."No.";
                                    GenJournalLine."External Document No." := ATMApplications."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := ATMCharge;
                                    GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                // MESSAGE('Charge Amount %1',ChargeAmount)
                                until TransactionCharges.Next = 0;
                                //MESSAGE('Charge Amountwww %1',ChargeAmount)
                                //      END;

                                //END;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Reset;
                                GenJournalLine."Journal Template Name" := JTemp;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := ATMApplications."No.";
                                GenJournalLine."External Document No." := ATMApplications."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := ATMApplications."Account No";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := ATMCharge;
                                GenJournalLine.Amount := TChargeAmount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                //GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                // MESSAGE('Charge Amount %1',ChargeAmount)
                                //send sms
                                if SavingsAcc.Get(ATMApplications."Account No") then begin
                                    SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Mobile Phone No", Txt004, Format(ATMApplications."No."), '', true, 0, false, 'CBS', ATMApplications."No.", 'CBS');
                                end;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", JTemp);
                                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;
                                //Post New
                                ATMApplications."ATM Charges Applied" := true;
                                ATMApplications."ATM Charged Date" := Today;
                                ATMApplications.Modify;
                                CashierTransactions.Reset;
                                CashierTransactions.SetRange(CashierTransactions."Account No", ATMApplications."Account No");
                                CashierTransactions.SetRange(Remarks, 'ATM Application Charges');
                                if CashierTransactions.Find('-')
                                  then begin
                                    repeat
                                        //ERROR('here');
                                        CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                                        CashierTransactions.Modify;
                                    until CashierTransactions.Next = 0;
                                end;
                                ATMApplications."Card Charged" := true;
                                ATMApplications.Modify();
                                Message(MSGPosted);
                            end;
                        end;
                    end;
                end;
            end;
        end
        else
            Error('An Applicaion for this card must be present for this ATM');
    end;

    procedure RecoverLoan(LoanRecoveryHeader: Record "Loan Recovery Header")
    var
        TotalAssets: Decimal;
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        LoanNo: Code[30];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        Loans: Record Loans;
        LoanRecoveryLines: Record "Loan Recovery Lines";
        RecoveryLevel: Option " ","Level 1","Level 2","Level 3","Level 4";
        GuarantorLoan: Record Loans;
        InterestBalance: Decimal;
        Comments: Record Comments;
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
    begin
        LoanRecoveryHeader.GetLoanBalances(LoanRecoveryHeader."Loan No.", OutInt, OutBal, TotalBal);
        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);
        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;
        Loans.Get(LoanRecoveryHeader."Loan No.");

        Dim1 := Loans."Global Dimension 1 Code";
        Dim2 := Loans."Global Dimension 2 Code";

        //CLEAR BATCH
        SaccoTrans.InitJournal(JTemplate, JBatch);

        LoanRecoveryLines.Reset();
        LoanRecoveryLines.SetRange("Header No.", LoanRecoveryHeader."No.");
        if LoanRecoveryLines.FindFirst() then begin
            repeat
                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Attached Loan Recovery") then begin

                    if GuarantorLoan.Get(LoanRecoveryLines."Attached Loan Number") then begin
                        Description := 'Deposits attached to ' + LoanRecoveryLines."Attached Loan Number" + ' Principle';
                        AccNo := LoanRecoveryLines."Account No.";
                        TransAmt := 0;
                        TransAmt := LoanRecoveryLines."Principle Amount";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, GuarantorLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                        Description := 'Deposits attached to ' + LoanRecoveryLines."Attached Loan Number" + ' Interest';
                        AccNo := LoanRecoveryLines."Account No.";
                        TransAmt := 0;
                        TransAmt := LoanRecoveryLines."Interest Amount";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, GuarantorLoan."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                    end;
                end;

                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Deposits Recovery") then begin

                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Principle';
                    AccNo := LoanRecoveryLines."Account No.";
                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);


                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Interest';
                    AccNo := LoanRecoveryLines."Account No.";
                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    //SEPARATE ABOVE

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Principle';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);



                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Interest';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                end;

                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Guarantor Attachment") then begin
                    LoanRecoveryLines."Loan No." := CreateGuarantorLoan(LoanRecoveryLines."Account No.", Loans, LoanRecoveryLines, Dim1, Dim2, DocNo, PDate);

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    Description := 'Guarantor Attachment to principle ' + LoanRecoveryLines."Member No." + ' ' + LoanRecoveryLines."Loan No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    Description := 'Guarantor Attachment to interest ' + LoanRecoveryLines."Member No." + ' ' + LoanRecoveryLines."Loan No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                    LoanRecoveryLines.Modify();
                end;

            until LoanRecoveryLines.Next() = 0;
        end;

        if LoanRecoveryHeader."Flag Member Account" <> '' then begin
            Comments.Init();
            Comments.Comment := LoanRecoveryHeader."Flag Member Account";
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := Dim1;
            Comments."Global Dimension 2 Code" := Dim2;
            Comments."Header No." := LoanRecoveryHeader."Member No.";
            Comments.Types := Comments.Types::"Member Flagging";
            Comments.Insert(true);
        end;

        Loans.Defaulted := true;
        RecoveryLevel := Loans."Recovery Level";
        if RecoveryLevel = Loans."Recovery Level"::" " then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 1";
        if RecoveryLevel = Loans."Recovery Level"::"Level 1" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 2";
        if RecoveryLevel = Loans."Recovery Level"::"Level 2" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 3";
        if RecoveryLevel = Loans."Recovery Level"::"Level 3" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 4";

        Loans."Out. Bal. On Attachment" := OutBal;
        Loans."Out. Int. On Attachment" := OutInt;
        Loans.Modify();

        SaccoTrans.PostJournal(Jtemplate, JBatch, false);
    end;



    procedure RecoverLoanII(LoanRecoveryHeader: Record "Loan Recovery Header II")
    var
        TotalAssets: Decimal;
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        LoanNo: Code[30];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        Loans: Record Loans;
        LoanRecoveryLines: Record "Loan Recovery Lines II";
        RecoveryLevel: Option " ","Level 1","Level 2","Level 3","Level 4";
        GuarantorLoan: Record Loans;
        InterestBalance: Decimal;
        Comments: Record Comments;
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);

        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;
        Loans.Get(LoanRecoveryHeader."Loan No.");

        Dim1 := Loans."Global Dimension 1 Code";
        Dim2 := Loans."Global Dimension 2 Code";

        //CLEAR BATCH
        SaccoTrans.InitJournal(JTemplate, JBatch);

        LoanRecoveryLines.Reset();
        LoanRecoveryLines.SetRange("Header No.", LoanRecoveryHeader."No.");
        if LoanRecoveryLines.FindFirst() then begin
            repeat
                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Attached Loan Recovery") then begin

                    if GuarantorLoan.Get(LoanRecoveryLines."Attached Loan Number") then begin
                        Description := 'Deposits attached to ' + LoanRecoveryLines."Attached Loan Number" + ' Principle';
                        AccNo := LoanRecoveryLines."Account No.";
                        TransAmt := 0;
                        TransAmt := LoanRecoveryLines."Principle Amount";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, GuarantorLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                        Description := 'Deposits attached to ' + LoanRecoveryLines."Attached Loan Number" + ' Interest';
                        AccNo := LoanRecoveryLines."Account No.";
                        TransAmt := 0;
                        TransAmt := LoanRecoveryLines."Interest Amount";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, GuarantorLoan."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                    end;
                end;

                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Deposits Recovery") then begin

                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Principle';
                    AccNo := LoanRecoveryLines."Account No.";
                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);


                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Interest';
                    AccNo := LoanRecoveryLines."Account No.";
                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    //SEPARATE ABOVE

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Principle';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);



                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    Description := 'Deposits Attached to ' + LoanRecoveryHeader."Loan No." + ' Interest';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                end;

                if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Guarantor Attachment") then begin
                    LoanRecoveryLines."Loan No." := CreateGuarantorLoanII(LoanRecoveryLines."Account No.", Loans, LoanRecoveryLines, Dim1, Dim2, DocNo, PDate);

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Principle Amount";
                    Description := 'Guarantor Attachment ' + LoanRecoveryLines."Member No." + ' ' + LoanRecoveryLines."Loan No." + ' Principle';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                    TransAmt := 0;
                    TransAmt := LoanRecoveryLines."Interest Amount";
                    Description := 'Guarantor Attachment ' + LoanRecoveryLines."Member No." + ' ' + LoanRecoveryLines."Loan No." + ' Interest';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                        '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                    LoanRecoveryLines.Modify();
                end;

            until LoanRecoveryLines.Next() = 0;
        end;

        if LoanRecoveryHeader."Flag Member Account" <> '' then begin
            Comments.Init();
            Comments.Comment := LoanRecoveryHeader."Flag Member Account";
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := Dim1;
            Comments."Global Dimension 2 Code" := Dim2;
            Comments."Header No." := LoanRecoveryHeader."Member No.";
            Comments.Types := Comments.Types::"Member Flagging";
            Comments.Insert(true);
        end;

        Loans.Defaulted := true;
        RecoveryLevel := Loans."Recovery Level";
        if RecoveryLevel = Loans."Recovery Level"::" " then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 1";
        if RecoveryLevel = Loans."Recovery Level"::"Level 1" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 2";
        if RecoveryLevel = Loans."Recovery Level"::"Level 2" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 3";
        if RecoveryLevel = Loans."Recovery Level"::"Level 3" then
            loans."Recovery Level" := Loans."Recovery Level"::"Level 4";
        Loans.Modify();

        SaccoTrans.PostJournal(Jtemplate, JBatch);
    end;


    procedure CreateGuarantorLoan(AccountNo: Code[30]; Loans: Record Loans; LoanRecLines: Record "Loan Recovery Lines"; Dim1: Code[30]; Dim2: Code[30]; DocNo: Code[50]; PDate: Date) LoanNumber: Code[30]
    var
        MainProductFactory: Record "Product Factory";
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        CreditAccountNo: Code[30];
        CreditAcount: Record "Credit Accounts";
        LoanProcess: Codeunit "Loans Process";
        NewLoans: Record Loans;
        LoanRepaymentShedule: Record "Ideal Repayment Schedule";
        MonthlyRepayment: Decimal;
        Duration: Integer;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        TransAmt: Decimal;
        Description: Text;
        LoanNo: Code[30];
        SystemCreated: Boolean;
        TransType: Enum "Transaction Types";
        // SkyMbanking: Codeunit "Sky Mbanking";
        SMSSourse: Enum "SMS Source";
        companyinfo: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        msg: Text;
        FirstName: Text;
        PhoneNumber: Text;
    begin
        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
        SavingsAccounts.Get(AccountNo);
        MainProductFactory.Get(Loans."Loan Product Type");
        if ProductFactory.Get(MainProductFactory."Deafulter Loan Product") then begin

            CreditAccountNo := ProductFactory."Account No. Prefix" + SavingsAccounts."Member No.";
            if not CreditAcount.Get(CreditAccountNo) then begin
                CreditAccountNo := LoanProcess.CreateLoanAccount(SavingsAccounts."Member No.", ProductFactory."Product ID");
            end;

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", SavingsAccounts."Member No.");
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then
                NewLoans.DeleteAll;

            LoanRepaymentShedule.Reset;
            LoanRepaymentShedule.SetRange(LoanRepaymentShedule."Loan No.", Loans."Loan No.");
            if not LoanRepaymentShedule.FindFirst then
                LoanProcess.GenerateSchedule(Loans, true);

            NewLoans.Init;
            NewLoans."Loan No." := '';
            NewLoans."Member No." := SavingsAccounts."Member No.";
            if Members.Get(SavingsAccounts."Member No.") then begin
                NewLoans."Member Name" := Members.Name;
                NewLoans."Staff No" := Members."Payroll/Staff No.";
                NewLoans."Employer Code" := Members."Employer Code";
                NewLoans."Application Date" := Today;
            end;
            NewLoans."Loan Product Type" := ProductFactory."Product ID";
            //NewLoans.VALIDATE(NewLoans."Loan Product Type");
            NewLoans."Loan Product Type Name" := ProductFactory."Product Description";
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans.Interest := Loans.Interest;
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
            Loans.CalcFields("Loan Span");
            NewLoans."Loan Span" := Loans."Loan Span";
            NewLoans.Installments := GlobalFunctions.GetRemainingInstallments(Loans, Today);
            NewLoans."Compute Interest Due on Postin" := Loans."Compute Interest Due on Postin";
            NewLoans."Repayment Frequency" := Loans."Repayment Frequency";
            NewLoans."Recovery Mode" := MainProductFactory."Repay Mode";
            NewLoans."Appraisal Parameter Type" := ProductFactory."Appraisal Parameter Type";
            NewLoans."Recovery Priority" := ProductFactory."Recovery Priority";
            NewLoans."Application Date" := PDate;
            NewLoans."Requested Amount" := LoanRecLines."Principle Amount" + LoanReclines."Interest Amount";
            NewLoans."Approved Amount" := LoanRecLines."Principle Amount" + LoanReclines."Interest Amount";
            NewLoans.Validate(NewLoans."Approved Amount");
            NewLoans.Status := NewLoans.Status::Approved;
            NewLoans."Disbursement Date" := PDate;
            NewLoans."Repayment Start Date" := PDate;
            //Expected Completion Date

            if MainProductFactory.Get(NewLoans."Loan Product Type") then begin
                if Format(MainProductFactory."Grace Period - Principle") <> '' then begin
                    // Apply grace period
                    NewLoans."Repayment Start Date" := CalcDate(MainProductFactory."Grace Period - Principle", NewLoans."Disbursement Date");

                    // Apply repayment start date logic based on loan application date
                    if Date2DMY(NewLoans."Repayment Start Date", 1) <= 10 then
                        NewLoans."Repayment Start Date" := CalcDate('CM', NewLoans."Repayment Start Date") // End of current month
                    else
                        NewLoans."Repayment Start Date" := CalcDate('CM+1M', NewLoans."Repayment Start Date"); // End of following month

                    IntstallMentPeriodText := Format(NewLoans.Installments) + 'M';
                    Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                    NewLoans."Expected Date of Completion" := CalcDate(InstalmentPeriods, NewLoans."Repayment Start Date");

                end else begin
                    // No grace period, apply repayment start date logic
                    if Date2DMY(NewLoans."Disbursement Date", 1) <= 10 then
                        NewLoans."Repayment Start Date" := CalcDate('CM', NewLoans."Disbursement Date") // End of current month
                    else
                        NewLoans."Repayment Start Date" := CalcDate('CM+1M', NewLoans."Disbursement Date"); // End of following month

                    IntstallMentPeriodText := Format(NewLoans.Installments) + 'M';
                    Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                    NewLoans."Expected Date of Completion" := CalcDate(InstalmentPeriods, NewLoans."Repayment Start Date");
                end;
            end;
            // End of Expected Completion Date
            //NewLoans.batch"Batch No.":="Batch No.";
            NewLoans."Loan Account" := CreditAccountNo;
            NewLoans.Repayment := ROUND(NewLoans.Repayment, 1, '>');
            NewLoans.Advice := true;
            NewLoans."Advice Type" := NewLoans."advice type"::"Fresh Loan";

            NewLoans."Loan Recovery No." := DocNo;
            NewLoans."Recovered Loan" := Loans."Loan No.";
            NewLoans."Source Unit" := ProductFactory."Source Unit";
            NewLoans.Insert(true);

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", SavingsAccounts."Member No.");
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then begin
                Dim1 := Loans."Global Dimension 1 Code";
                Dim2 := Loans."Global Dimension 2 Code";
                ////DEFAULTER ATTACHMENT MNO-GUARANTOR LNO-GUARANTOR

                LoanNo := NewLoans."Loan No.";
                SystemCreated := true;
                TransAmt := NewLoans."Approved Amount";
                Description := 'Defaulter Attachment ' + Loans."Member No." + ' ' + Loans."Loan No.";

                if NewLoans."Approved Amount" <> 0 then
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                           '', TransAmt, DocNo, LoanNo, TransType::Loan, Dim1, Dim2, SystemCreated);

                // if LoanRecLines."Interest Amount" <> 0 then
                // SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                //        '', LoanRecLines."Interest Amount", DocNo, LoanNo, TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                NewLoans.Posted := true;
                NewLoans.Modify;

                //Generate Schedule
                LoanProcess.GenerateSchedule(NewLoans, true);

                //Advice Loan
                NewLoans.Validate(Repayment);
                companyinfo.get();
                Members.Get(NewLoans."Member No.");

                GlobalFunctions.GetMemberData(Members."No.", FirstName, PhoneNumber);
                LoanNumber := NewLoans."Loan No.";

                // msg := 'Dear member your have been attached Loan of Kes'
                // + Format(ROUND(NewLoans."Approved Amount", 1, '=')) + ' ' + 'for defaulted loan you guaranteed Member No.' + Loans."Member No." + '-' + Loans."Member Name" + '' +
                // ' if in dispute call ' + companyinfo."Phone No.";

                msg := 'Dear ' + FirstName + ', you have been attached defaulted ' + NewLoans."Loan Product Type Name" + ' KES ' + Format(Abs(TransAmt) + Abs(LoanRecLines."Interest Amount")) +
                'for the loan guaranteed to ' + Loans."Member No." + '-' + Loans."Member Name" + '. ' + ForMoreInfo;

                SendSMS.SendSms(Source::MBANKING, PhoneNumber, CopyStr(msg, 1, 250), Format(NewLoans."Loan No."), '', true, 0, false, 'CBS', NewLoans."Loan No.", 'CBS');

            end;
        end else
            Error('Defaulter loan product does not exist');
    end;



    procedure CreateGuarantorLoanII(AccountNo: Code[30]; Loans: Record Loans; LoanRecLines: Record "Loan Recovery Lines II"; Dim1: Code[30]; Dim2: Code[30]; DocNo: Code[50]; PDate: Date) LoanNumber: Code[30]
    var
        MainProductFactory: Record "Product Factory";
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        CreditAccountNo: Code[30];
        CreditAcount: Record "Credit Accounts";
        LoanProcess: Codeunit "Loans Process";
        NewLoans: Record Loans;
        LoanRepaymentShedule: Record "Ideal Repayment Schedule";
        MonthlyRepayment: Decimal;
        Duration: Integer;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        TransAmt: Decimal;
        Description: Text;
        LoanNo: Code[30];
        SystemCreated: Boolean;
        TransType: Enum "Transaction Types";
        // SkyMbanking: Codeunit "Sky Mbanking";
        SMSSourse: Enum "SMS Source";
        companyinfo: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        msg: Text;

        FirstName: Text;
        PhoneNumber: Text;
    begin
        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
        SavingsAccounts.Get(AccountNo);
        MainProductFactory.Get(Loans."Loan Product Type");
        if ProductFactory.Get(MainProductFactory."Deafulter Loan Product") then begin

            CreditAccountNo := ProductFactory."Account No. Prefix" + SavingsAccounts."Member No.";
            if not CreditAcount.Get(CreditAccountNo) then begin
                CreditAccountNo := LoanProcess.CreateLoanAccount(SavingsAccounts."Member No.", ProductFactory."Product ID");
            end;

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", SavingsAccounts."Member No.");
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then
                NewLoans.DeleteAll;

            LoanRepaymentShedule.Reset;
            LoanRepaymentShedule.SetRange(LoanRepaymentShedule."Loan No.", Loans."Loan No.");
            if not LoanRepaymentShedule.FindFirst then
                LoanProcess.GenerateSchedule(Loans, true);

            NewLoans.Init;
            NewLoans."Loan No." := '';
            NewLoans."Member No." := SavingsAccounts."Member No.";
            if Members.Get(SavingsAccounts."Member No.") then begin
                NewLoans."Member Name" := Members.Name;
                NewLoans."Staff No" := Members."Payroll/Staff No.";
                NewLoans."Employer Code" := Members."Employer Code";
                NewLoans."Application Date" := Today;
            end;
            NewLoans."Loan Product Type" := ProductFactory."Product ID";
            //NewLoans.VALIDATE(NewLoans."Loan Product Type");
            NewLoans."Loan Product Type Name" := ProductFactory."Product Description";
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans.Interest := Loans.Interest;
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
            Loans.CalcFields("Loan Span");
            NewLoans."Loan Span" := Loans."Loan Span";
            NewLoans.Installments := GlobalFunctions.GetRemainingInstallments(Loans, Today);
            NewLoans."Compute Interest Due on Postin" := Loans."Compute Interest Due on Postin";
            NewLoans."Repayment Frequency" := Loans."Repayment Frequency";
            NewLoans."Recovery Mode" := ProductFactory."Repay Mode";
            NewLoans."Appraisal Parameter Type" := ProductFactory."Appraisal Parameter Type";
            NewLoans."Recovery Priority" := ProductFactory."Recovery Priority";
            NewLoans."Application Date" := PDate;
            NewLoans."Requested Amount" := LoanRecLines."Principle Amount" + LoanRecLines."Interest Amount";
            NewLoans."Approved Amount" := LoanRecLines."Principle Amount" + LoanRecLines."Interest Amount";
            NewLoans.Validate(NewLoans."Approved Amount");
            NewLoans.Status := NewLoans.Status::Approved;
            NewLoans."Disbursement Date" := PDate;
            NewLoans."Repayment Start Date" := PDate;
            //NewLoans.batch"Batch No.":="Batch No.";
            NewLoans."Loan Account" := CreditAccountNo;
            NewLoans.Repayment := ROUND(NewLoans.Repayment, 1, '>');
            NewLoans.Advice := true;
            NewLoans."Advice Type" := NewLoans."advice type"::"Fresh Loan";

            NewLoans."Loan Recovery No." := DocNo;
            NewLoans."Recovered Loan" := Loans."Loan No.";
            NewLoans."Source Unit" := ProductFactory."Source Unit";
            NewLoans.Insert(true);

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", SavingsAccounts."Member No.");
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then begin

                ////DEFAULTER ATTACHMENT MNO-GUARANTOR LNO-GUARANTOR

                LoanNo := NewLoans."Loan No.";
                SystemCreated := true;
                TransAmt := NewLoans."Approved Amount";
                Description := 'Defaulter P+I Attachment ' + Loans."Member No." + ' ' + Loans."Loan No.";

                if TransAmt <> 0 then
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                           '', TransAmt, DocNo, LoanNo, TransType::Loan, Dim1, Dim2, SystemCreated);

                // if LoanRecLines."Interest Amount" <> 0 then
                //     SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                //            '', LoanRecLines."Interest Amount", DocNo, LoanNo, TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                NewLoans.Posted := true;
                NewLoans.Modify;

                //Generate Schedule
                LoanProcess.GenerateSchedule(NewLoans, true);

                //Advice Loan
                NewLoans.Validate(Repayment);
                companyinfo.get();
                Members.Get(NewLoans."Member No.");

                GlobalFunctions.GetMemberData(Members."No.", FirstName, PhoneNumber);

                // msg := 'Dear member your have been attached Loan of Kes'
                // + Format(ROUND(NewLoans."Approved Amount", 1, '=')) + ' ' + 'for defaulted loan you guaranteed Member No.' + Loans."Member No." + '-' + Loans."Member Name" + '' +
                // ' if in dispute call ' + companyinfo."Phone No.";

                msg := 'Dear ' + FirstName + ', you have been attached defaulted ' + NewLoans."Loan Product Type Name" + ' KES ' + Format(Abs(TransAmt) + Abs(LoanRecLines."Interest Amount")) +
                'for the loan guaranteed to ' + Loans."Member No." + '-' + Loans."Member Name" + '. ' + ForMoreInfo;

                SendSMS.SendSms(Source::MBANKING, PhoneNumber, CopyStr(msg, 1, 250), Format(NewLoans."Loan No."), '', true, 0, false, 'CBS', NewLoans."Loan No.", 'CBS');

            end;
        end else
            Error('Defaulter loan product does not exist');
    end;


    procedure ReverseLoan(LoanRecoveryHeader: Record "Loan Recovery Header")
    var
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[100];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;

        GuarantorMember: Record Members;
        MemStatus: enum "Member Status";
        HeldMoney: Record "One Month Installment";
        msg: Text;
        FirstName: Text;
        PhoneNumber: Text;

        SavingsAccounts: Record "Savings Accounts";
        RecoveryAccount: Record "Savings Accounts";
        ReversalLines: Record "Loan Reversal Lines";
        OriginalHeader: Record "Loan Recovery Header";
        OriginalLoan: Record Loans;
        GuarantorLoan: Record Loans;
        GuarantorFOSA: Record "Savings Accounts";
        ReappotionmentHeaders: Record "Loan Recovery Header";
        ReappotionmentLines: Record "Loan Reapotionment Lines";
        GlobalFunctionsCodeunit: Codeunit "Global Functions";
        DefaulterMember: Record Members;
        Comments: Record Comments;
        LoansProces: Codeunit "Loans Process";

        OtherRecoveryHeaders: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        StillADefaulter: Boolean;
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);

        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;

        //Clear Batch
        SaccoTrans.InitJournal(JTemplate, JBatch);

        OriginalHeader.Get(LoanRecoveryHeader."Detach Recovery No");

        OriginalLoan.Get(LoanRecoveryHeader."Loan No.");

        Dim1 := OriginalLoan."Global Dimension 1 Code";
        Dim2 := OriginalLoan."Global Dimension 2 Code";

        DefaulterMember.Get(LoanRecoveryHeader."Member No.");

        ReversalLines.Reset();
        ReversalLines.SetRange("Header No.", LoanRecoveryHeader."No.");
        if ReversalLines.FindFirst() then begin
            repeat
                //Reverse deposits
                if ReversalLines."Refund Type" = ReversalLines."Refund Type"::"Deposits Reversal" then begin
                    RecoveryAccount.Reset();
                    RecoveryAccount.SetRange("Member No.", LoanRecoveryHeader."Member No.");
                    RecoveryAccount.SetRange("Product Type", OriginalHeader."Account to Use");
                    if RecoveryAccount.FindFirst() then begin
                        Description := 'Loan Reversal Deposits Detach ' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Interest Attached Amount";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, RecoveryAccount."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Deposits Detach' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Principle Attached Amount";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, RecoveryAccount."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);
                    end;
                end;


                if ReversalLines."Refund Type" = ReversalLines."Refund Type"::"Guarantor Payoff" then begin
                    //Clear Guarantor Loan Balances

                    GuarantorLoan.Get(ReversalLines."Guarantor Loan No");

                    Description := 'Loan Reversal Loan Bal (Int)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                    TransAmt := 0;
                    TransAmt := ReversalLines."Guarantor Interest Balance";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, GuarantorLoan."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);

                    Description := 'Loan Reversal Loan Bal (Int)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);


                    Description := 'Loan Reversal Loan Bal (Pr)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                    TransAmt := 0;
                    TransAmt := ReversalLines."Guarantor Principal Balance";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, GuarantorLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                    Description := 'Loan Reversal Loan Bal (Pr)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                    //Refund FOSA
                    GuarantorFOSA.Reset();
                    GuarantorFOSA.SetRange("Product Category", GuarantorFOSA."Product Category"::"FOSA Account");
                    GuarantorFOSA.SetRange("Member No.", ReversalLines."Guarantor Member No.");
                    if GuarantorFOSA.FindFirst() then begin
                        Description := 'Loan Reversal Guar Payoff (Int)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Interest Paid By Guarantor";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, GuarantorFOSA."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Guar Payoff (Int)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Guar Payoff (Pr)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Principle Paid By Guarantor";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, GuarantorFOSA."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                    '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Guar Payoff (Pr)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                        if GuarantorMember.Get(ReversalLines."Guarantor Member No.") then begin
                            if (GuarantorMember.Status = MemStatus::Closed) or (GuarantorMember.Status = MemStatus::Deceased) then begin
                                GlobalFunctionsCodeunit.HoldMoneyInAccount(LoanRecoveryHeader."No.", GuarantorMember."No.", GuarantorFOSA."No.", ReversalLines."Interest Paid By Guarantor",
                                ReversalLines."Principle Paid By Guarantor", (ReversalLines."Interest Paid By Guarantor" + ReversalLines."Principle Paid By Guarantor"), HeldMoney.Type::"Reverse Guarantor Payment");
                            end;
                        end;

                    end;
                    GlobalFunctionsCodeunit.GetMemberData(GuarantorMember."No.", FirstName, PhoneNumber);

                    // LoansProces.AdviceLoan(ReversalLines."Guarantor Loan No", true, ReversalLines."Header No.");

                    // msg := 'Dear ' + FirstName + ' the ' + OriginalLoan."Loan Product Type Name" + ' for ' + DefaulterMember."No." + '-' + DefaulterMember.Name +
                    //  ' attached to your account KES ' + Format(ReversalLines."Interest Attached Amount" + ReversalLines."Principle Attached Amount") + ' has been reversed. ' + ForMoreInfo;

                    msg := 'The ' + OriginalLoan."Loan Product Type Name" + ' attached to your account ' + ReversalLines."Guarantor Member No." + '-' + FirstName + ' KES ' +
                    Format(ReversalLines."Interest Attached Amount" + ReversalLines."Principle Attached Amount") + ' has been reversed. ' + ForMoreInfo;

                    SendSMS.SendSms(Source::DMU, PhoneNumber, msg, LoanRecoveryHeader."No.", GuarantorMember."No.", false, 250, false, 'CBS', '', 'CBS');
                end;
            until ReversalLines.Next() = 0;
        end;

        GlobalFunctionsCodeunit.GetMemberData(DefaulterMember."No.", FirstName, PhoneNumber);
        msg := 'Dear ' + FirstName + ' your defaulted loan ' + LoanRecoveryHeader."Loan No." + ' has been reversed. ' + ForMoreInfo;
        SendSMS.SendSms(Source::DMU, PhoneNumber, msg, LoanRecoveryHeader."No.", GuarantorMember."No.", false, 250, false, 'CBS', '', 'CBS');

        //Mark all reappotionments as reversed
        ReappotionmentHeaders.Reset();
        ReappotionmentHeaders.SetRange("Member No.", LoanRecoveryHeader."Member No.");
        ReappotionmentHeaders.SetRange("Loan No.", OriginalHeader."Loan No.");
        ReappotionmentHeaders.SetRange(Action, ReappotionmentHeaders.Action::Reappotioned);
        ReappotionmentHeaders.SetRange("Header Reversed", false);
        if ReappotionmentHeaders.FindFirst() then begin
            repeat
                ReappotionmentLines.Reset();
                ReappotionmentLines.SetRange("Header No.", ReappotionmentHeaders."No.");
                if ReappotionmentLines.FindFirst() then
                    ReappotionmentLines.ModifyAll(Reversed, true);

                ReappotionmentHeaders."Reversed By Header No" := LoanRecoveryHeader."No.";
                ReappotionmentHeaders."Header Reversed" := true;
                ReappotionmentHeaders.Modify();

            until ReappotionmentHeaders.Next() = 0;
        end;

        //Mark original header as reversed
        OriginalHeader."Header Reversed" := true;
        OriginalHeader."Reversed By Header No" := LoanRecoveryHeader."No.";
        OriginalHeader.Modify();

        OriginalLoan.Defaulted := false;
        OriginalLoan."Loan Recovery No." := '';
        OriginalLoan.Modify();

        //Manage flaging
        OtherRecoveryHeaders.Reset();
        OtherRecoveryHeaders.SetRange("Member No.", OriginalHeader."Member No.");
        OtherRecoveryHeaders.SetRange(Action, OtherRecoveryHeaders.Action::Recovered);
        OtherRecoveryHeaders.SetRange("Header Reversed", false);
        OtherRecoveryHeaders.SetFilter("No.", '<>%1', OriginalHeader."No.");
        if OtherRecoveryHeaders.FindFirst() then begin
            StillADefaulter := true;
        end;

        LoanrecoveryHeaderII.Reset();
        LoanrecoveryHeaderII.SetRange("Member No.", OriginalHeader."Member No.");
        LoanrecoveryHeaderII.SetRange(Action, LoanrecoveryHeaderII.Action::Recovered);
        LoanrecoveryHeaderII.SetRange("Header Reversed", false);
        if LoanrecoveryHeaderII.FindFirst() then begin
            StillADefaulter := true;
        end;

        if not StillADefaulter then begin
            DefaulterMember.Subflag := DefaulterMember."Subflag Backup";
            DefaulterMember.Modify();
        end;

        if LoanRecoveryHeader."Flag Member Account" <> '' then begin
            Comments.Init();
            Comments.Comment := LoanRecoveryHeader."Flag Member Account";
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := Dim1;
            Comments."Global Dimension 2 Code" := Dim2;
            Comments."Header No." := DefaulterMember."No.";
            Comments.Types := Comments.Types::"Member Flagging";
            Comments.Insert(true);
        end;

        // LoansProces.AdviceLoan(OriginalLoan."Loan No.", false, ReversalLines."Header No.");
        //Post Batch
        SaccoTrans.PostJournal(Jtemplate, JBatch, false);
    END;

    procedure ReverseLoanII(LoanRecoveryHeader: Record "Loan Recovery Header II")
    var
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;

        GuarantorMember: Record Members;
        MemStatus: enum "Member Status";
        HeldMoney: Record "One Month Installment";
        msg: Text;
        FirstName: Text;
        PhoneNumber: Text;

        SavingsAccounts: Record "Savings Accounts";
        RecoveryAccount: Record "Savings Accounts";
        ReversalLines: Record "Loan Reversal Lines II";
        OriginalHeader: Record "Loan Recovery Header II";
        OriginalLoan: Record Loans;
        GuarantorLoan: Record Loans;
        GuarantorFOSA: Record "Savings Accounts";
        ReappotionmentHeaders: Record "Loan Recovery Header II";
        ReappotionmentLines: Record "Loan Reapotionment Lines II";
        GlobalFunctionsCodeunit: Codeunit "Global Functions";
        DefaulterMember: Record Members;
        Comments: Record Comments;
        LoansProces: Codeunit "Loans Process";

        OtherRecoveryHeadersII: Record "Loan Recovery Header II";
        LoanRecoeryHeaders: Record "Loan Recovery Header";
        StillADefaulter: Boolean;
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);

        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;

        //Clear Batch
        SaccoTrans.InitJournal(JTemplate, JBatch);

        OriginalHeader.Get(LoanRecoveryHeader."Detach Recovery No");

        OriginalLoan.Get(LoanRecoveryHeader."Loan No.");

        Dim1 := OriginalLoan."Global Dimension 1 Code";
        Dim2 := OriginalLoan."Global Dimension 2 Code";

        DefaulterMember.Get(LoanRecoveryHeader."Member No.");

        if not LoanRecoveryHeader."Allow Zero Reversal" then begin
            ReversalLines.Reset();
            ReversalLines.SetRange("Header No.", LoanRecoveryHeader."No.");
            if ReversalLines.Find('-') then begin
                repeat
                    //Reverse deposits
                    if ReversalLines."Refund Type" = ReversalLines."Refund Type"::"Deposits Reversal" then begin
                        RecoveryAccount.Reset();
                        RecoveryAccount.SetRange("Member No.", LoanRecoveryHeader."Member No.");
                        RecoveryAccount.SetRange("Product Type", OriginalHeader."Account to Use");
                        if RecoveryAccount.FindFirst() then begin
                            Description := 'Loan Reversal Deposits Detach ' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                            TransAmt := 0;
                            TransAmt := ReversalLines."Total Int To Defaulter";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                            '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, RecoveryAccount."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                            Description := 'Loan Reversal Deposits Detach' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                            TransAmt := 0;
                            TransAmt := ReversalLines."Total Pr To Defaulter";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                            '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, RecoveryAccount."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);
                        end;
                    end;


                    if ReversalLines."Refund Type" = ReversalLines."Refund Type"::"Guarantor Payoff" then begin
                        //Clear Guarantor Loan Balances

                        GuarantorLoan.Get(ReversalLines."Guarantor Loan No");

                        Description := 'Loan Reversal Loan Bal (Int)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Guarantor Interest Balance";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, GuarantorLoan."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Loan Bal (Int)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);


                        Description := 'Loan Reversal Loan Bal (Pr)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                        TransAmt := 0;
                        TransAmt := ReversalLines."Guarantor Principal Balance";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, GuarantorLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                        Description := 'Loan Reversal Loan Bal (Pr)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                        //Refund FOSA
                        GuarantorFOSA.Reset();
                        GuarantorFOSA.SetRange("Product Category", GuarantorFOSA."Product Category"::"FOSA Account");
                        GuarantorFOSA.SetRange("Member No.", ReversalLines."Guarantor Member No.");
                        if GuarantorFOSA.FindFirst() then begin
                            Description := 'Loan Reversal Guar Payoff (Int)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                            TransAmt := 0;
                            TransAmt := ReversalLines."Interest Refund";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, GuarantorFOSA."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                            Description := 'Loan Reversal Guar Payoff (Int)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                            '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated);

                            Description := 'Loan Reversal Guar Payoff (Pr)' + ReversalLines."Defaulter Member No." + ' ' + ReversalLines."Defaulter Loan No";
                            TransAmt := 0;
                            TransAmt := ReversalLines."Principle Refund";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, GuarantorFOSA."No.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                        '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                            Description := 'Loan Reversal Guar Payoff (Pr)' + ReversalLines."Guarantor Member No." + ' ' + ReversalLines."Guarantor Loan No";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, OriginalLoan."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                            '', TransAmt, DocNo, OriginalLoan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                            if GuarantorMember.Get(ReversalLines."Guarantor Member No.") then begin
                                if (GuarantorMember.Status = MemStatus::Closed) or (GuarantorMember.Status = MemStatus::Deceased) then begin
                                    GlobalFunctionsCodeunit.HoldMoneyInAccount(LoanRecoveryHeader."No.", GuarantorMember."No.", GuarantorFOSA."No.", ReversalLines."Interest Paid By Guarantor",
                                    ReversalLines."Principle Paid By Guarantor", (ReversalLines."Interest Paid By Guarantor" + ReversalLines."Principle Paid By Guarantor"), HeldMoney.Type::"Reverse Guarantor Payment");
                                end;
                            end;

                        end;
                        GlobalFunctionsCodeunit.GetMemberData(GuarantorMember."No.", FirstName, PhoneNumber);

                        // LoansProces.AdviceLoan(ReversalLines."Guarantor Loan No", true, ReversalLines."Header No.");

                        // msg := 'Dear ' + FirstName + ' your attached loan of KES ' + Format((ReversalLines."Interest Refund" + ReversalLines."Principle Refund")) +
                        // ' has been reversed to the owner successfully';

                        msg := 'The ' + OriginalLoan."Loan Product Type Name" + 'attached to your account ' + ReversalLines."Guarantor Member No." + '-' + FirstName + 'KES ' +
                        Format(ReversalLines."Attached Amount") + ' has been reversed. ' + ForMoreInfo;

                        SendSMS.SendSms(Source::DMU, PhoneNumber, msg, LoanRecoveryHeader."No.", GuarantorMember."No.", false, 250, false, 'CBS', '', 'CBS');
                    end;
                until ReversalLines.Next() = 0;
            end;


            GlobalFunctionsCodeunit.GetMemberData(DefaulterMember."No.", FirstName, PhoneNumber);
            msg := 'Dear ' + FirstName + ' your defaulted loan ' + LoanRecoveryHeader."Loan No." + ' has been successfully returned to you';
            SendSMS.SendSms(Source::DMU, PhoneNumber, msg, LoanRecoveryHeader."No.", GuarantorMember."No.", false, 250, false, 'CBS', '', 'CBS');
        end;

        //Mark all reappotionments as reversed
        ReappotionmentHeaders.Reset();
        ReappotionmentHeaders.SetRange("Member No.", LoanRecoveryHeader."Member No.");
        ReappotionmentHeaders.SetRange("Loan No.", OriginalHeader."Loan No.");
        ReappotionmentHeaders.SetRange(Action, ReappotionmentHeaders.Action::Reappotioned);
        ReappotionmentHeaders.SetRange("Header Reversed", false);
        if ReappotionmentHeaders.FindFirst() then begin
            repeat
                ReappotionmentLines.Reset();
                ReappotionmentLines.SetRange("Header No.", ReappotionmentHeaders."No.");
                if ReappotionmentLines.FindFirst() then
                    ReappotionmentLines.ModifyAll(Reversed, true);

                ReappotionmentHeaders."Reversed By Header No" := LoanRecoveryHeader."No.";
                ReappotionmentHeaders."Header Reversed" := true;
                ReappotionmentHeaders.Modify();

            until ReappotionmentHeaders.Next() = 0;
        end;

        //Mark original header as reversed
        OriginalHeader."Header Reversed" := true;
        OriginalHeader."Reversed By Header No" := LoanRecoveryHeader."No.";
        OriginalHeader.Modify();

        OriginalLoan.Defaulted := false;

        //Manage flaging
        OtherRecoveryHeadersII.Reset();
        OtherRecoveryHeadersII.SetRange("Member No.", OriginalHeader."Member No.");
        OtherRecoveryHeadersII.SetRange(Action, OtherRecoveryHeadersII.Action::Recovered);
        OtherRecoveryHeadersII.SetRange("Header Reversed", false);
        OtherRecoveryHeadersII.SetFilter("No.", '<>%1', OriginalHeader."No.");
        if OtherRecoveryHeadersII.FindFirst() then begin
            StillADefaulter := true;
        end;

        LoanRecoeryHeaders.Reset();
        LoanRecoeryHeaders.SetRange("Member No.", OriginalHeader."Member No.");
        LoanRecoeryHeaders.SetRange(Action, LoanRecoeryHeaders.Action::Recovered);
        LoanRecoeryHeaders.SetRange("Header Reversed", false);
        if LoanRecoeryHeaders.FindFirst() then begin
            StillADefaulter := true;
        end;

        if not StillADefaulter then begin
            DefaulterMember.Subflag := DefaulterMember."Subflag Backup";
            DefaulterMember.Modify();
        end;

        if LoanRecoveryHeader."Flag Member Account" <> '' then begin
            Comments.Init();
            Comments.Comment := LoanRecoveryHeader."Flag Member Account";
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := Dim1;
            Comments."Global Dimension 2 Code" := Dim2;
            Comments."Header No." := DefaulterMember."No.";
            Comments.Types := Comments.Types::"Member Flagging";
            Comments.Insert(true);
        end;

        // LoansProces.AdviceLoan(OriginalLoan."Loan No.", false, ReversalLines."Header No.");

        //Post Batch
        SaccoTrans.PostJournal(Jtemplate, JBatch);
    END;


    procedure Reappotion(LoanRecoveryHeader: Record "Loan Recovery Header")
    var
        RpptLns: Record "Loan Reapotionment Lines";
        GuarantorLoans: Record Loans;
        HoldMoney: Boolean;
        Members: Record Members;
        LoanSecurity: Record "One Month Installment";
        SavingsAccounts: Record "Savings Accounts";
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        DefaulterDebitAccount: Code[30];
        GlobalFunctionsCodeunit: Codeunit "Global Functions";
        HoldReason: Enum "Funds Witheld Types";
        DefaulterName: Text;
        SMSSource: Enum "SMS Source";
        DefaultedLoan: Record Loans;
        DefaultedLoanProduct: Record "Product Factory";
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);

        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;

        if DefaultedLoan.Get(LoanRecoveryHeader."Loan No.") then begin
            DefaultedLoan.TestField("Loan Product Type");
            DefaultedLoanProduct.Get(DefaultedLoan."Loan Product Type");
            DefaultedLoanProduct.TestField("Recovery Product");

            Dim1 := DefaultedLoan."Global Dimension 1 Code";
            Dim2 := DefaultedLoan."Global Dimension 2 Code";

        end else
            Error('The defaulted loan does not exist');

        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", LoanRecoveryHeader."Member No.");
        SavingsAccounts.SetRange("Product Type", DefaultedLoanProduct."Recovery Product");
        if SavingsAccounts.FindFirst() then begin
            DefaulterDebitAccount := SavingsAccounts."No.";
            DefaulterName := SavingsAccounts.Name;
        end;

        //CLEAR BATCH
        SaccoTrans.InitJournal(JTemplate, JBatch);

        RpptLns.Reset();
        RpptLns.SetRange("Header No.", LoanRecoveryHeader."No.");
        if RpptLns.FindSet() then begin
            repeat

                HoldMoney := false;
                AccNo := '';
                GuarantorLoans.Get(RpptLns."Guarantor Loan No.");

                if Members.Get(RpptLns."Guarantor Member No.") then begin
                    if (Members.Status = Members.Status::Closed) or (Members.Status = Members.Status::Deceased) then begin
                        HoldMoney := true;
                        Members.Get(Members."No.");
                    end;
                end;

                Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No.";
                TransAmt := RpptLns."Interest Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, DefaulterDebitAccount, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No.";
                TransAmt := RpptLns."Principle Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, DefaulterDebitAccount, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                Description := 'Reappotionment from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                TransAmt := RpptLns."Interest Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoans."Loan Account", CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                            '', -TransAmt, DocNo, GuarantorLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);

                Description := 'Reapp from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                TransAmt := RpptLns."Principle Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoans."Loan Account", CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                            '', -TransAmt, DocNo, GuarantorLoans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", RpptLns."Guarantor Member No.");
                //SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                SavingsAccounts.setrange("Product Type", '191');
                if SavingsAccounts.FindFirst() then begin
                    AccNo := SavingsAccounts."No.";
                    TransAmt := RpptLns."Money To FOSA";
                    Description := 'Reappotionment from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', -TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    AccNo := DefaulterDebitAccount;
                    TransAmt := RpptLns."Money To FOSA";
                    Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    //HOLD MONEY TO FOSA
                    if HoldMoney then begin
                        GlobalFunctionsCodeunit.HoldMoneyInAccount(LoanRecoveryHeader."No.", SavingsAccounts."Member No.", SavingsAccounts."No.", 0, 0, TransAmt, HoldReason::"Reverse Guarantor Payment");
                    end;

                    //SEND SMS
                    msg := 'Dear ' + Members."First Name" + ', your guarantor loan ' + GuarantorLoans."Loan No." + ' has been serviced by KES ' + Format(RpptLns."Appotionment Amount") +
                    ' by ' + DefaulterName;
                    SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Members."First Name"), '', true, 250, false, 'CBS', GuarantorLoans."Loan No.", 'CBS');

                end else
                    Error('Guarantor No.: %1 Name: %2 doesn''t have a Deposit Account.', RpptLns."Guarantor Member No.", RpptLns."Guarantor Name");
            until RpptLns.Next() = 0;
        end;
        SaccoTrans.PostJournal(Jtemplate, JBatch, false);
    end;

    procedure ReappotionII(LoanRecoveryHeader: Record "Loan Recovery Header II")
    var
        RpptLns: Record "Loan Reapotionment Lines II";
        GuarantorLoans: Record Loans;
        HoldMoney: Boolean;
        Members: Record Members;
        LoanSecurity: Record "One Month Installment";
        SavingsAccounts: Record "Savings Accounts";
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        DefaulterDebitAccount: Code[30];
        GlobalFunctionsCodeunit: Codeunit "Global Functions";
        HoldReason: Enum "Funds Witheld Types";
        DefaulterName: Text;
        SMSSource: Enum "SMS Source";
        DefaultedLoan: Record Loans;
        DefaultedLoanProduct: Record "Product Factory";
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);

        DocNo := LoanRecoveryHeader."No.";
        ExtDoc := LoanRecoveryHeader."No.";
        PDate := Today;

        if DefaultedLoan.Get(LoanRecoveryHeader."Loan No.") then begin
            DefaultedLoan.TestField("Loan Product Type");
            DefaultedLoanProduct.Get(DefaultedLoan."Loan Product Type");
            DefaultedLoanProduct.TestField("Recovery Product");

            Dim1 := DefaultedLoan."Global Dimension 1 Code";
            Dim2 := DefaultedLoan."Global Dimension 2 Code";
        end else
            Error('The defaulted loan does not exist');

        LoanRecoveryHeader.TestField("Account Number");
        if SavingsAccounts.Get(LoanRecoveryHeader."Account Number") then begin
            DefaulterDebitAccount := SavingsAccounts."No.";
            DefaulterName := SavingsAccounts.Name;
        end;

        //CLEAR BATCH
        SaccoTrans.InitJournal(JTemplate, JBatch);

        RpptLns.Reset();
        RpptLns.SetRange("Header No.", LoanRecoveryHeader."No.");
        if RpptLns.FindSet() then begin
            repeat
                HoldMoney := false;
                AccNo := '';
                GuarantorLoans.Get(RpptLns."Guarantor Loan No.");

                if Members.Get(RpptLns."Guarantor Member No.") then begin
                    if (Members.Status = Members.Status::Closed) or (Members.Status = Members.Status::Deceased) then begin
                        HoldMoney := true;
                        Members.Get(Members."No.");
                    end;
                end;

                Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No.";
                TransAmt := RpptLns."Interest Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, DefaulterDebitAccount, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No.";
                TransAmt := RpptLns."Principle Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, DefaulterDebitAccount, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                Description := 'Reappotionment from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                TransAmt := RpptLns."Interest Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoans."Loan Account", CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                            '', -TransAmt, DocNo, GuarantorLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);

                Description := 'Reappotionment from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                TransAmt := RpptLns."Principle Portion";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, GuarantorLoans."Loan Account", CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                            '', -TransAmt, DocNo, GuarantorLoans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);


                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", RpptLns."Guarantor Member No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                if SavingsAccounts.FindFirst() then begin
                    AccNo := SavingsAccounts."No.";
                    TransAmt := RpptLns."Money To FOSA";
                    Description := 'Reappotionment from ' + LoanRecoveryHeader."Loan No." + ' ' + LoanRecoveryHeader."Member No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', -TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    AccNo := DefaulterDebitAccount;
                    TransAmt := RpptLns."Money To FOSA";
                    Description := 'Reappotionment to ' + RpptLns."Guarantor Member No." + ' ' + RpptLns."Guarantor Loan No." + ' Cleared';
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 40), BalAccountType::"G/L Account",
                                        '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    //HOLD MONEY TO FOSA
                    if HoldMoney then begin
                        GlobalFunctionsCodeunit.HoldMoneyInAccount(LoanRecoveryHeader."No.", SavingsAccounts."Member No.", SavingsAccounts."No.", 0, 0, TransAmt, HoldReason::"Reverse Guarantor Payment");
                    end;

                    //SEND SMS
                    msg := 'Dear ' + Members."First Name" + ', your guarantor loan ' + GuarantorLoans."Loan No." + ' has been serviced by KES ' + Format(RpptLns."Appotionment Amount") +
                    ' by ' + DefaulterName;
                    SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Members."First Name"), '', true, 250, false, 'CBS', GuarantorLoans."Loan No.", 'CBS');

                end else
                    Error('Guarantor No.: %1 Name: %2 doesn''t have a FOSA Account.', RpptLns."Guarantor Member No.", RpptLns."Guarantor Name");
            until RpptLns.Next() = 0;
        end;
        SaccoTrans.PostJournal(Jtemplate, JBatch);
    end;


    procedure Token(var Text: Text; Separator: Text) Token: Text[250]
    var
        Pos: Integer;
        Times: Integer;
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;

    local procedure GetInstallments(LoanNo: Code[20])
    var
        Loans: Record Loans;
        NoSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        Mem: Record Members;
        RemInstallments: Integer;
        Loan: Record Loans;
        ProdF: Record "Product Factory";
        LoanSched: Record "Ideal Repayment Schedule";
        PastInstallments: Integer;
        InstallmentsNew: Decimal;
        LoansR: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanApp: Record Loans;
        PartialSched: Record "Partial Disbursement Schedule";
        UserSet: Record "User Setup";
        ProductInt: Integer;
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.Find('-') then begin
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Repayment Date", Today, 99991230D);
            LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
            LoanRepaymentSchedule.SetRange("Reset Schedule", true);
            if LoanRepaymentSchedule.Find('-') then
                LoanRepaymentSchedule.DeleteAll;
            ProductInt := 0;
            ProdF.Reset;
            ProdF.SetRange("Product ID", Loans."Loan Product Type");
            if ProdF.Find('-') then begin
                ProductInt := ProdF."Interest Rate (Max.)";
            end;
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
            LoanAmount := Loans."Outstanding Balance" + Loans."Outstanding Interest";
            if Loans.Interest = 0 then
                InterestRate := ProductInt else
                InterestRate := Loans.Interest;
            RepayPeriod := Loans.Installments;
            LBalance := Loans."Outstanding Balance" + Loans."Outstanding Interest";//LoansR."Approved Amount";
            LInterest := 0;
            TotalMRepay := 0;
            LPrincipal := 0;

            RunDate := Today;
            repeat
                InstalNo := InstalNo + 1;


                //Repayment Frequency
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate);
                //Repayment Frequency

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    if Loans.Interest > 0 then
                        Loans.TestField(Loans.Interest);
                    //TESTFIELD("New Amortised");
                    TotalMRepay := ROUND((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;

                    //Update Reschedule
                    Loans.Repayment := LInterest + LPrincipal;

                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                    if Loans.Interest > 0 then
                        Loans.TestField(Loans.Interest);
                    Loans.TestField(Loans.Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LoanAmount;

                    //Update Reschedule
                    Loans.Repayment := LPrincipal;

                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then begin
                    if Loans.Interest > 0 then
                        Loans.TestField(Loans.Interest);
                    //TESTFIELD("New Amortised");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LBalance;

                    //Update Reschedue
                    Loans.Repayment := LPrincipal;
                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
                    Loans.TestField(Loans.Repayment);
                    if LBalance < Loans.Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Loans.Repayment;
                    //LInterest:=Loans.Interest;
                    LInterest := (Loans."Approved Amount" * (Loans.Interest / 24) * (Loans.Installments + 1)) / (Loans.Installments * 100); //***Constant Reducing Flat Interest
                                                                                                                                            //Update Reschedule
                    Loans.Repayment := LPrincipal;

                end;
                //Loop the Balance
                LBalance := LBalance - LPrincipal;

                Evaluate(RepayCode, Format(InstalNo));


                LoanRepaymentSchedule.Init;
                LoanRepaymentSchedule."Repayment Code" := RepayCode;
                LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                LoanRepaymentSchedule."Loan Amount" := Loans."Outstanding Balance";
                LoanRepaymentSchedule."Instalment No" := InstalNo;
                LoanRepaymentSchedule."Repayment Date" := RunDate;
                LoanRepaymentSchedule."Member No." := Loans."Member No.";
                LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal;
                LoanRepaymentSchedule."Monthly Interest" := LInterest;
                LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                // LoanRepaymentSchedule."Reset Doc No.":=Loans."Loan Recovery No.""No.";
                LoanRepaymentSchedule."Reset Schedule" := true;
                LoanRepaymentSchedule.Insert;
            until LBalance < 1;
            /*
            IF "Original Installments"<InstalNo THEN
              ERROR(Text0003);
            "New Installments":=InstalNo;*/

            //Loans."New No. of Installment":=InstalNo;

            //MESSAGE('%1',InstalNo);
            //MODIFY;
        end;

    end;


    procedure ConsolidateBuffer(CheckoffBuffer: Record "Checkoff Buffer")
    var
        Buffer: Record "Checkoff Buffer";
        BufferConsolidation: Record "Checkoff Buffer Consolidation";
        Totals: Decimal;
        CheckoffNo: Code[20];
        BufferNo: Code[20];
        EntryNo: Integer;
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
    begin
        //Creating Progress Bar------------------------------------
        intProgressTotal := Buffer.Count;
        diaProgress.Open(Genrating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
        intProgressI := 0;
        TimeProgress := Time;
        NoOfRecsProgress := intProgressTotal DIV 100;
        NoOfProgressed := 0;

        //Creating Progress Bar-------------------------------------


        // CountNo:=0;

        BufferConsolidation.DeleteAll;
        Buffer.Reset;
        Buffer.SetRange(Buffer."Checkoff No", CheckoffBuffer."Checkoff No");
        //Buffer.SETFILTER(Amount,'>0');
        if Buffer.Find('-') then begin
            repeat

                //Progress---

                //Progress-------------------------------
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := Time;
                end;
                //Progress------------------------------

                BufferConsolidation.Reset;
                BufferConsolidation.SetRange("Upload No.", Buffer."Upload No.");
                if not BufferConsolidation.Find('-') then begin
                    BufferConsolidation.Init;
                    BufferConsolidation.No := Buffer.No;
                    BufferConsolidation."Upload No." := Buffer."Upload No.";
                    BufferConsolidation.Name := Buffer.Name;
                    BufferConsolidation."Checkoff No" := Buffer."Checkoff No";
                    BufferConsolidation.Amount := Buffer.Amount;
                    BufferConsolidation.Insert;
                end else begin
                    BufferConsolidation.Amount := BufferConsolidation.Amount + Buffer.Amount;
                    BufferConsolidation.Modify;
                end;
                CheckoffNo := Buffer."Checkoff No";
            until Buffer.Next = 0;
        end;

        Buffer.Reset;
        Buffer.SetRange(Buffer."Checkoff No", CheckoffNo);
        if Buffer.Find('-') then
            Buffer.DeleteAll;

        BufferConsolidation.Reset;
        BufferConsolidation.SetRange("Checkoff No", CheckoffNo);
        if BufferConsolidation.Find('-') then begin
            repeat
                EntryNo += 1;
                Buffer.No := EntryNo;
                Buffer."Checkoff No" := BufferConsolidation."Checkoff No";
                Buffer.Name := BufferConsolidation.Name;
                Buffer."Upload No." := BufferConsolidation."Upload No.";
                Buffer.Amount := BufferConsolidation.Amount;
                Buffer.Insert;
            until BufferConsolidation.Next = 0;
        end;
        diaProgress.Close;
    end;


    procedure SendNotcieSMS(MemberNo: Code[20]; DocumentNo: Code[20])
    var
        Members: Record Members;
        CompInfo: Record "Company Information";
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
    begin
        //^^SMS
        TotalLoan := 0;
        if Members.Get(MemberNo) then begin
            CompInfo.Get;
            if MemberwithdrawalNotice.Get(DocumentNo) then begin
                if Members."Phone No." <> '' then begin
                    TotalLoan := MemberwithdrawalNotice."Loans Outstanding Balance" + MemberwithdrawalNotice."Loans Outstanding Interest";

                    msg := 'Dear ' + Members."First Name" + ' Your withdrawal notice has been received & matures on ' + Format(MemberwithdrawalNotice."Maturity Date") + '. Your Deposits: ' +
                    Format(MemberwithdrawalNotice."Member Deposit") + ' ' + 'and Total Loans of' + ' ' + Format(TotalLoan) + '. If in dispute call' + ' ' + CompInfo."Phone No.";
                    SendSMS.SendSms(Source::MEMBER_CHANGES, Members."Phone No.", msg, Format(DocumentNo), '', true, 0, false, 'CBS', DocumentNo, 'CBS');

                end;
                Members.Subflag := Members.Subflag::"Pending Withdrawal";
                Members.Modify;
            end;
        end;
        //SMS
    end;


    procedure PostPINResetCharges(MSACCOChangePINNo: Record "M-SACCO Change PIN No")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        SavingsAccounts: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        Trans: Record "Cashier Transactions";
        GenSetup: Record "General Set-Up";
        AccountTypes: Record "Product Factory";
        TransType: Record "Transaction Types";
        JTemp: Code[20];
        JBatch: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        MSGPosted: label 'Posted Successfuly';
        ATMCharge: label 'Atm Card Charges';
        ATMCardTypes: Record "ATM Card Types";
        // SendSMS: Codeunit SendSms;
        SavingsAcc: Record "Savings Accounts";
        Txt004: label 'Your ATM Card application has been received and is being processed.';
        CashierTransactions: Record "Cashier Transactions";
    begin
        GenSetup.Get();
        if MSACCOChangePINNo."PIN Rest Charges Applied" = true then Error('This account has already been applied PIN Rest charges');
        //IF CONFIRM('Confirm Pin Rest Charges?') THEN
        begin
            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
            BankingUserTemplate.Get(UserId);
            UserSetup.Get(UserId);
            BankingUserTemplate.TestField("ATM Charges Journal Batch");
            BankingUserTemplate.TestField("ATM Charges Journal Template");
            JTemp := BankingUserTemplate."ATM Charges Journal Template";
            JBatch := BankingUserTemplate."ATM Charges Journal Batch";
            GenJournalLine.Reset;
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemp);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;
            GenSetup.Get;
            ChargeAmount := 0;
            //  MESSAGE('here');

            ChargeAmount := 0;
            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", MSACCOChangePINNo."Charge Transaction Type");
            if TransactionCharges.Find('-') then begin
                repeat
                    ChargeAmount := 0;
                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            ChargeAmount := TransactionCharges."Charge Amount"//(TransType.Amount*TransactionCharges."Percentage of Amount")*0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";
                        TChargeAmount += ChargeAmount;

                    end;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Reset;
                    GenJournalLine."Journal Template Name" := JTemp;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Document No." := MSACCOChangePINNo.No;
                    GenJournalLine."External Document No." := MSACCOChangePINNo.No;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Msacco PIN Reset Fee' + '-' + MSACCOChangePINNo.AccountNo;
                    GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                until TransactionCharges.Next = 0;


                LineNo := LineNo + 10000;

                GenJournalLine.Reset;
                GenJournalLine."Journal Template Name" := JTemp;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := MSACCOChangePINNo.No;
                GenJournalLine."External Document No." := MSACCOChangePINNo.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                GenJournalLine."Account No." := MSACCOChangePINNo.AccountNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Msacco PIN Reset Fee' + '-' + MSACCOChangePINNo.AccountNo;
                ;
                GenJournalLine.Amount := TChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
            //Excise Duty
            if TransactionCharges."Recover Excise Duty" = true then begin

                TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                ;


                LineNo := LineNo + 10000;

                GenJournalLine.Reset;
                GenJournalLine."Journal Template Name" := JTemp;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := MSACCOChangePINNo.No;
                GenJournalLine."External Document No." := MSACCOChangePINNo.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := GenSetup."Excise Duty G/L";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Msacco Repin Excise Duty' + MSACCOChangePINNo.AccountNo;
                GenJournalLine.Amount := (TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)" / 100) * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;

                GenJournalLine.Reset;
                GenJournalLine."Journal Template Name" := JTemp;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := MSACCOChangePINNo.No;
                GenJournalLine."External Document No." := MSACCOChangePINNo.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                GenJournalLine."Account No." := MSACCOChangePINNo.AccountNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Msacco Repin Excise Duty' + MSACCOChangePINNo.AccountNo;
                GenJournalLine.Amount := (TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)" / 100);
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemp);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                // if GenJournalLine.Find('-') then begin
                //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine)
                // end;
                MSACCOChangePINNo."PIN Rest Charges Applied" := true;
                MSACCOChangePINNo."PIN Rest Charged Date" := Today;
                MSACCOChangePINNo.Modify;

                Message(MSGPosted);
            end;
        end;
    end;


    procedure SendBirthdayMessages()
    var
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        BirthdayMessage: Text;
        AnniversaryMessage: Text;
        Years: Integer;
    begin
        GeneralSetUp.Get;
        GeneralSetUp.TestField("Birthday Message");
        Members.Reset;
        Members.SetFilter(Status, '%1', Members.Status::Active);
        Members.SetFilter("Date of Birth", '<>%1', 0D);
        if Members.FindFirst then begin
            repeat
                if ((Date2dmy(Members."Date of Birth", 1)) = (Date2dmy(Today, 1)))
                 and ((Date2dmy(Members."Date of Birth", 2)) = (Date2dmy(Today, 2)))
                   then begin
                    BirthdayMessage := StrSubstNo(GeneralSetUp."Birthday Message", Members."First Name");
                    SendSMS.SendSms(Source::ACCOUNT_STATUS, Members."Phone No.", BirthdayMessage, Format(Members."No."), '', true, 0, false, 'CBS', Members."No.", 'CBS');
                end;
            until Members.Next = 0;
        end;
        //------------------------------------------------------!!
    end;

    procedure SendMemberBirthdayMessages(MemberNo: code[20])
    var
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        BirthdayMessage: Text;
        AnniversaryMessage: Text;
        Years: Integer;
    begin
        GeneralSetUp.Get;
        GeneralSetUp.TestField("Birthday Message");
        Members.Reset;
        Members.SetFilter(Status, '%1|%2', Members.Status::Active, Members.Status::New);
        Members.setrange("No.", MemberNo);
        Members.SetFilter("Date of Birth", '<>%1', 0D);
        if Members.FindFirst then begin
            repeat
                if ((Date2dmy(Members."Date of Birth", 1)) = (Date2dmy(Today, 1)))
                 and ((Date2dmy(Members."Date of Birth", 2)) = (Date2dmy(Today, 2)))
                   then begin
                    BirthdayMessage := StrSubstNo(GeneralSetUp."Birthday Message", Members."First Name");
                    SendSMS.SendSms(Source::CRM, Members."Phone No.", BirthdayMessage, Format(Members."No."), '', true, 0, false, 'CBS', Members."No.", 'CBS');
                end;
            until Members.Next = 0;
        end;
        //------------------------------------------------------!!
    end;


    procedure SendAnnversaryMessages()
    var
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        BirthdayMessage: Text;
        AnniversaryMessage: Text;
        Years: Integer;
    begin
        //Francis!!!!
        GeneralSetUp.Get();
        //Anniversary Date
        //-----------------------------------------------------!!
        Members.Reset;
        Members.SetFilter(Status, '%1|%2', Members.Status::Active, Members.Status::New);
        Members.SetFilter("Registration Date", '<>%1', 0D);
        if Members.FindFirst then begin
            repeat
                if ((Date2dmy(Members."Registration Date", 1)) = (Date2dmy(Today, 1)))
                 and ((Date2dmy(Members."Registration Date", 2)) = (Date2dmy(Today, 2)))
                   then begin
                    Years := Date2dmy(Today, 3) - Date2dmy(Members."Registration Date", 3);
                    AnniversaryMessage := StrSubstNo(GeneralSetUp."Membership Anniversary", Members."First Name", Years);
                    SendSMS.SendSms(Source::ACCOUNT_STATUS, Members."Phone No.", AnniversaryMessage, Format(Members."No."), '', true, 0, false, 'CBS', Members."No.", 'CBS');
                end;
            until Members.Next = 0;
        end;
        //--------------------------------------------------- ---!!
    end;


    procedure SendTotoBirthdayMessages()
    var
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        BirthdayMessage: Text;
        AnniversaryMessage: Text;
        Years: Integer;
        SavingsAccounts: Record "Savings Accounts";
    begin
        GeneralSetUp.Get;
        GeneralSetUp.TestField("Junior Birthday Message");
        //-----------------------------------------------------!!
        SavingsAccounts.Reset;
        SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::New);
        SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."product category"::"Junior Account");
        SavingsAccounts.SetFilter("Date of Birth", '<>%1', 0D);
        if SavingsAccounts.FindFirst then begin
            repeat
                if ((Date2dmy(SavingsAccounts."Date of Birth", 1)) = (Date2dmy(Today, 1)))
                 and ((Date2dmy(SavingsAccounts."Date of Birth", 2)) = (Date2dmy(Today, 2)))
                   then begin
                    BirthdayMessage := StrSubstNo(GeneralSetUp."Junior Birthday Message", SavingsAccounts.Name);
                    SendSMS.SendSms(Source::ACCOUNT_STATUS, SavingsAccounts."Mobile Phone No", BirthdayMessage, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
                end;
            until SavingsAccounts.Next = 0;
        end;
        //------------------------------------------------------!!
    end;

    procedure SendMemberTotoBirthdayMessages(MemberNo: code[20])
    var
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        BirthdayMessage: Text;
        AnniversaryMessage: Text;
        Years: Integer;
        SavingsAccounts: Record "Savings Accounts";
    begin
        GeneralSetUp.Get;
        GeneralSetUp.TestField("Junior Birthday Message");
        //-----------------------------------------------------!!
        SavingsAccounts.Reset;
        SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::New);
        SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."product category"::"Junior Account");
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetFilter("Date of Birth", '<>%1', 0D);
        if SavingsAccounts.FindFirst then begin
            repeat
                if ((Date2dmy(SavingsAccounts."Date of Birth", 1)) = (Date2dmy(Today, 1)))
                 and ((Date2dmy(SavingsAccounts."Date of Birth", 2)) = (Date2dmy(Today, 2)))
                   then begin
                    BirthdayMessage := StrSubstNo(GeneralSetUp."Junior Birthday Message", SavingsAccounts.Name);
                    SendSMS.SendSms(Source::ACCOUNT_STATUS, SavingsAccounts."Mobile Phone No", BirthdayMessage, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
                end;
            until SavingsAccounts.Next = 0;
        end;
        //------------------------------------------------------!!
    end;


    procedure GetAccountBalance(AcctNo: Code[20]): Decimal
    var
        Bal: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
    begin
        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "ATM Transactions", "Lien Placed", "Authorised Over Draft");
            if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                Bal := (SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") - ProductFactory."Minimum Balance" - SavingsAccounts."Uncleared Cheques" -
                      SavingsAccounts."Lien Placed" - SavingsAccounts."ATM Transactions";
            end;
        end;
        exit(Bal);
    end;


    procedure BillMonthlySinkFund(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        ProdType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
        Accounts: Record "Savings Accounts";
        BenevolentAcc: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;

            BenevolentAcc.Reset;
            BenevolentAcc.SetFilter("Product Category", '%1', BenevolentAcc."Product Category"::"Benevolent (BBF)");
            if BenevolentAcc.FindFirst then begin
                repeat
                    BenevolentAcc.CalcFields("Balance (LCY)");
                    Memb.Get(BenevolentAcc."Member No.");
                    if (Memb.Status = Memb.Status::Active) or
                       (Memb.Subflag = Memb.Subflag::Defaulter) or
                      (Memb.Status = Memb.Status::New) then begin


                        LoansInterest.Init;
                        LoansInterest.No := InterestBuffer."No.";
                        LoansInterest."Account Type" := LoansInterest."account type"::Savings;
                        LoansInterest."Account No" := BenevolentAcc."No.";
                        LoansInterest."Interest Date" := Today;
                        LoansInterest."Interest Bill" := ProdType."Minimum Contribution";
                        LoansInterest."Interest Amount" := ProdType."Minimum Contribution";
                        LoansInterest."Repayment Bill" := ProdType."Minimum Contribution";
                        LoansInterest.Description := InterestBuffer.Description;
                        LoansInterest."Shortcut Dimension 1 Code" := BenevolentAcc."Global Dimension 1 Code";
                        LoansInterest."Shortcut Dimension 2 Code" := BenevolentAcc."Global Dimension 2 Code";
                        LoansInterest."Loan Product type" := BenevolentAcc."Product Type";
                        if ProdType.Get(BenevolentAcc."Product Type") then begin
                            LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                            LoansInterest."Bal. Account No." := ProdType."Accrual Fee Acc. (Income)";
                        end;
                        LoansInterest."Outstanding Balance" := BenevolentAcc."Balance (LCY)";
                        ;
                        LoansInterest."Interest Bill" := ProdType."Minimum Contribution";
                        if LoansInterest."Interest Bill" = 0 then
                            LoansInterest."Interest Bill" := ProdType."Minimum Contribution";
                        LoansInterest.Status := Memb.Status;
                        LoansInterest.Insert;
                    end;
                until BenevolentAcc.Next = 0;

            end;
        end;
    end;


    procedure BillMembershipFee(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        ProdType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
        Accounts: Record "Savings Accounts";
        RegFeeAcc: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;



            RegFeeAcc.Reset;
            RegFeeAcc.SetFilter("Product Category", '%1', RegFeeAcc."product category"::"Entrance Fee");
            RegFeeAcc.SetFilter("Balance (LCY)", '=0');
            RegFeeAcc.SetRange("Date Billed", 0D);
            if RegFeeAcc.Find('-') then begin
                repeat
                    RegFeeAcc.CalcFields("Balance (LCY)", "Date Billed");
                    Memb.Get(RegFeeAcc."Member No.");
                    if Memb."Registration Date" >= Dmy2date(1, 9, 2020) then begin
                        if (Memb.Status = Memb.Status::Active) or
                          (Memb.Subflag = Memb.Subflag::Defaulter) or
                         (Memb.Status = Memb.Status::New) then begin

                            Memb.TestField("Member Class");
                            MemberClass.Get(Memb."Member Class");
                            MemberClass.TestField("Entrance Fee");

                            LoansInterest.Init;
                            LoansInterest.No := InterestBuffer."No.";
                            LoansInterest."Account Type" := LoansInterest."account type"::Savings;
                            LoansInterest."Account No" := RegFeeAcc."No.";
                            LoansInterest."Interest Date" := Today;
                            LoansInterest."Interest Bill" := MemberClass."Entrance Fee";
                            LoansInterest.Description := InterestBuffer.Description;
                            LoansInterest."Shortcut Dimension 1 Code" := RegFeeAcc."Global Dimension 1 Code";
                            LoansInterest."Shortcut Dimension 2 Code" := RegFeeAcc."Global Dimension 2 Code";
                            LoansInterest."Loan Product type" := RegFeeAcc."Product Type";
                            if ProdType.Get(RegFeeAcc."Product Type") then begin
                                LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                                LoansInterest."Bal. Account No." := ProdType."Accrual Fee Acc. (Income)";
                            end;
                            RegFeeAcc.CalcFields("Balance (LCY)");
                            LoansInterest."Outstanding Balance" := RegFeeAcc."Balance (LCY)";
                            ;
                            LoansInterest.Status := Memb.Status;
                            if LoansInterest."Interest Bill" <> 0 then
                                LoansInterest.Insert;
                        end;
                    end;
                until RegFeeAcc.Next = 0;
            end;
        end;
    end;


    procedure BillMonthlyPremierClub(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        ProdType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
        Accounts: Record "Savings Accounts";
        PremierClub: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;

            //create premier account
            // Members.Reset;
            // Members.SetRange("Member Category", 'PREMIER');
            // if Members.Find('-') then begin
            //     repeat
            //         Accounts.Reset;
            //         Accounts.SetRange("Member No.", Members."No.");
            //         Accounts.SetRange("Product Category", Accounts."product category"::"Premier Club Account");
            //         if not Accounts.Find('-') then
            //             RegistrationProcess.AnySavingsAccountRegistration(Members."No.", '07');

            //         Accounts.Reset;
            //         Accounts.SetRange("Member No.", Members."No.");
            //         Accounts.SetRange("Product Category", Accounts."product category"::"Premier Club Reg Fee");
            //         if not Accounts.Find('-') then
            //             RegistrationProcess.AnySavingsAccountRegistration(Members."No.", '06');
            //     until Members.Next = 0;
            // end;


            // PremierClub.Reset;
            // PremierClub.SetFilter("Product Category", '%1', PremierClub."product category"::"Premier Club Account");
            // if PremierClub.Find('-') then begin
            //     repeat
            //         PremierClub.CalcFields("Balance (LCY)", "Date Billed");
            //         Memb.Get(PremierClub."Member No.");
            //         if (Memb.Status = Memb.Status::Active) or
            //           (Memb.Status = Memb.Status::Defaulter) or
            //          (Memb.Status = Memb.Status::New) then begin
            //             ProdType.Get(PremierClub."Product Type");
            //             LoansInterest.Init;
            //             LoansInterest.No := InterestBuffer."No.";
            //             LoansInterest."Account Type" := LoansInterest."account type"::Savings;
            //             LoansInterest."Account No" := PremierClub."No.";
            //             LoansInterest."Interest Date" := Today;
            //             //LoansInterest."Interest Bill":=ProdType."Monthly Charges";
            //             LoansInterest."Interest Bill" := ProdType."Minimum Contribution";
            //             LoansInterest.Description := InterestBuffer.Description;
            //             LoansInterest."Shortcut Dimension 1 Code" := PremierClub."Global Dimension 1 Code";
            //             LoansInterest."Shortcut Dimension 2 Code" := PremierClub."Global Dimension 2 Code";
            //             LoansInterest."Loan Product type" := PremierClub."Product Type";
            //             if ProdType.Get(PremierClub."Product Type") then begin
            //                 LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
            //                 LoansInterest."Bal. Account No." := ProdType."Accrual Fee Acc. (Income)";
            //             end;
            //             PremierClub.CalcFields("Balance (LCY)");
            //             LoansInterest."Outstanding Balance" := PremierClub."Balance (LCY)";
            //             ;
            //             LoansInterest.Status := Memb.Status;
            //             if LoansInterest."Interest Bill" <> 0 then
            //                 LoansInterest.Insert;
            //         end;
            //     until PremierClub.Next = 0;
            // end;
        end;
    end;


    procedure BillPremierClubMembership(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        ProdType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
        Accounts: Record "Savings Accounts";
        RegFeeAcc: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;

            // Members.Reset;
            // Members.SetRange("Member Category", 'PREMIER');
            // if Members.Find('-') then begin
            //     repeat
            //         Accounts.Reset;
            //         Accounts.SetRange("Member No.", Members."No.");
            //         Accounts.SetRange("Product Category", Accounts."product category"::"Premier Club Reg Fee");
            //         if not Accounts.Find('-') then
            //             RegistrationProcess.AnySavingsAccountRegistration(Members."No.", '06');
            //     until Members.Next = 0;
            // end;


            // RegFeeAcc.Reset;
            // RegFeeAcc.SetFilter("Product Category", '%1', RegFeeAcc."product category"::"Premier Club Reg Fee");
            // RegFeeAcc.SetFilter("Balance (LCY)", '=0');
            // RegFeeAcc.SetRange("Date Billed", 0D);
            // if RegFeeAcc.Find('-') then begin
            //     repeat
            //         RegFeeAcc.CalcFields("Balance (LCY)", "Date Billed");
            //         Memb.Get(RegFeeAcc."Member No.");
            //         if RegFeeAcc."Registration Date" >= Dmy2date(1, 9, 2020) then begin
            //             if (Memb.Status = Memb.Status::Active) or
            //               (Memb.Status = Memb.Status::Defaulter) or
            //              (Memb.Status = Memb.Status::New) then begin

            //                 Memb.TestField("Member Category");
            //                 Category.Get(Memb."Member Class");
            //                 Category.TestField("Premier Club Reg Fee");
            //                 ProdType.Get(RegFeeAcc."Product Type");
            //                 LoansInterest.Init;
            //                 LoansInterest.No := InterestBuffer."No.";
            //                 LoansInterest."Account Type" := LoansInterest."account type"::Savings;
            //                 LoansInterest."Account No" := RegFeeAcc."No.";
            //                 LoansInterest."Interest Date" := Today;
            //                 LoansInterest."Interest Bill" := Category."Premier Club Reg Fee";
            //                 LoansInterest.Description := InterestBuffer.Description;
            //                 LoansInterest."Shortcut Dimension 1 Code" := RegFeeAcc."Global Dimension 1 Code";
            //                 LoansInterest."Shortcut Dimension 2 Code" := RegFeeAcc."Global Dimension 2 Code";
            //                 LoansInterest."Loan Product type" := RegFeeAcc."Product Type";
            //                 if ProdType.Get(RegFeeAcc."Product Type") then begin
            //                     LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
            //                     LoansInterest."Bal. Account No." := ProdType."Accrual Fee Acc. (Income)";
            //                 end;
            //                 RegFeeAcc.CalcFields("Balance (LCY)");
            //                 LoansInterest."Outstanding Balance" := RegFeeAcc."Balance (LCY)";
            //                 ;
            //                 LoansInterest.Status := Memb.Status;
            //                 if LoansInterest."Interest Bill" <> 0 then
            //                     LoansInterest.Insert;
            //             end;
            //         end;
            //     until RegFeeAcc.Next = 0;
            // end;
        end;
    end;


    procedure PostMonthlyBillingEntries(InterestBufferBillAndAccrue: Record "Interest Header")
    var
        // PeriodicActivities: Codeunit "Periodic Activities";
        members: Record Members;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Product Factory";
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Interest Due Period";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        LoansInterest: Record "Loans Interest";
        GeneratesuccMSG: label 'Billing Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Loans Template is set up in Cash Office Setup';
        NoBatchErr: label 'Ensure the Loans Batch is set up in the Cash Office Setup';
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        SavingsAccounts: Record "Savings Accounts";
    begin
        //with InterestBufferBillAndAccrue do
        begin
            if InterestBufferBillAndAccrue.Posted = true then
                Error(AlreadyPostedErr);

            Temp.Get(UserId);

            Jtemplate := Temp."Bills Template";
            JBatch := Temp."Bills Batch";

            if Jtemplate = '' then begin
                Error(NoTemplateErr);
            end;
            if JBatch = '' then begin
                Error(NoBatchErr)
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            LoansInterest.Reset;
            LoansInterest.SetRange(LoansInterest.No, InterestBufferBillAndAccrue."No.");
            LoansInterest.SetRange(Posted, false);
            if LoansInterest.Find('-') then begin
                repeat
                    if LoansInterest."Shortcut Dimension 1 Code" = '' then
                        LoansInterest."Shortcut Dimension 1 Code" := 'Credit';
                    if LoansInterest."Shortcut Dimension 2 Code" = '' then
                        LoansInterest."Shortcut Dimension 2 Code" := 'NBI';
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("No.", LoansInterest."Account No");
                    SavingsAccounts.SetFilter(Blocked, '<>%1', SavingsAccounts.Blocked::" ");
                    if SavingsAccounts.FindFirst then begin
                        LoansInterest."Account Blocked" := SavingsAccounts.Blocked;
                        LoansInterest.Modify;
                        if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then begin
                            SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
                            SavingsAccounts.Modify;
                        end;
                    end;

                    if LoansInterest."Interest Bill" <> 0 then begin
                        //INTEREST
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Posting Date" := InterestBufferBillAndAccrue."Posting Date";
                        GenJournalLine.Description := InterestBufferBillAndAccrue.Description;
                        GenJournalLine."Account Type" := LoansInterest."Account Type";
                        GenJournalLine."Account No." := LoansInterest."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := InterestBufferBillAndAccrue."Document No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := LoansInterest."Shortcut Dimension 1 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := LoansInterest."Shortcut Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.Amount := LoansInterest."Interest Bill";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := LoansInterest."Bal. Account No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    // if GenJournalLine.Find('-') then begin
                    //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    // end;



                    LoansInterest.Transferred := true;
                    LoansInterest.Posted := true;
                    LoansInterest.Modify;
                until LoansInterest.Next = 0;
            end;
            LoansInterest.Reset;
            LoansInterest.SetRange(LoansInterest.No, InterestBufferBillAndAccrue."No.");
            LoansInterest.SetRange("Account No", SavingsAccounts."No.");
            LoansInterest.SetFilter("Account Blocked", '<>%1', LoansInterest."account blocked"::" ");
            if LoansInterest.Find('-') then begin
                SavingsAccounts.Blocked := LoansInterest."Account Blocked";
                SavingsAccounts.Modify;
            end;




            InterestBufferBillAndAccrue.Posted := true;
            InterestBufferBillAndAccrue."Posted By" := UserId;
            InterestBufferBillAndAccrue."Posting Date" := Today;
            InterestBufferBillAndAccrue.Modify;

            Message(GeneratesuccMSG);
        end;
    end;

    procedure RecoverLoanFromDeposit(MemNo: Code[30])
    var
        TotalAssets: Decimal;
        Dim1: Code[30];
        Dim2: Code[30];
        DocNo: Code[50];
        PDate: Date;
        AccountType: enum "Gen. Journal Account Type";
        BalAccountType: enum "Gen. Journal Account Type";
        AccNo: Code[30];
        Description: Text[50];
        TransAmt: Decimal;
        ExtDoc: Code[50];
        LoanNo: Code[30];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        Loans: Record Loans;
        LoanRecoveryLines: Record "Loan Recovery Lines";
        RecoveryLevel: Option " ","Level 1","Level 2","Level 3","Level 4";
        GuarantorLoan: Record Loans;
        InterestBalance: Decimal;
        Comments: Record Comments;
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        SavAcc: Record "Savings Accounts";
        AccBal: Decimal;
        DepositAccNo: Code[30];
    begin
        // LoanRecoveryHeader.GetLoanBalances(LoanRecoveryHeader."Loan No.", OutInt, OutBal, TotalBal);//

        Temp.Get(UserId);

        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.Get(UserId);
        // DocNo := 'Loan Recovery for';
        // ExtDoc := 'Loan Recovery for';
        PDate := Today;
        // Loans.Get(LoanRecoveryHeader."Loan No.");

        Dim1 := Loans."Global Dimension 1 Code";
        Dim2 := Loans."Global Dimension 2 Code";

        //CLEAR BATCH
        SaccoTrans.InitJournal(JTemplate, JBatch);

        Loans.Reset();
        // Loans.SetRange(Loans."Source Unit", Loans."Source Unit"::BOSA);
        Loans.SetRange("Member No.", MemNo);

        Loans.SetFilter("Outstanding Balance", '>%1', 0);
        // Loans.SetRange("Loan No.", Loans."Loan No.");
        if Loans.FindFirst() then begin
            // repeat
            // if (LoanRecoveryLines."Recovery Type" = LoanRecoveryLines."Recovery Type"::"Deposits Recovery") then begin
            // get deposit acc no and available balance
            SavAcc.Reset;
            SavAcc.SetRange("Member No.", MemNo);
            SavAcc.SetRange("Product Category", SavAcc."product category"::"BOSA Deposits");
            if SavAcc.Find('-') then begin
                // SavAcc.CalcFields(SavAcc.Balance);
                AccBal := SavAcc.GetAvailableBalance(SavAcc."No.");
                DepositAccNo := SavAcc."No.";

            end;
            //code
            DocNo := Loans."Loan No." + ' Recovery';
            ExtDoc := Loans."Loan No." + ' Recovery';
            Description := 'Deposits Recovery to ' + Loans."Loan No." + ' Principle';
            AccNo := DepositAccNo;//DCS
            TransAmt := 0;


            Loans.CalcFields("Outstanding Balance");
            TransAmt := Loans."Outstanding Balance";

            //check if transamt  greater than deposit
            if TransAmt > AccBal then
                TransAmt := AccBal;


            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);


            Description := 'Deposits Recovery to ' + Loans."Loan No." + ' Interest';
            AccNo := DepositAccNo;//DCS
            TransAmt := 0;
            Loans.CalcFields("Outstanding Interest");
            TransAmt := Loans."Outstanding Interest";
            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, AccNo, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                '', TransAmt, ExtDoc, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

            //SEPARATE ABOVE

            TransAmt := 0;
            Loans.CalcFields("Outstanding Balance");
            TransAmt := Loans."Outstanding Balance";
            Description := 'Deposits Recovery to ' + Loans."Loan No." + ' Principle';
            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);



            TransAmt := 0;
            Loans.CalcFields("Outstanding Interest");
            TransAmt := Loans."Outstanding Interest";
            Description := 'Deposits Recovery to ' + Loans."Loan No." + ' Interest';
            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, Loans."Loan Account", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                '', -TransAmt, ExtDoc, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
            // end;
            // until Loans.Next() = 0;
        end;
        SaccoTrans.PostJournal(Jtemplate, JBatch);
    end;

    procedure BillRejoiningFee(InterestBuffer: Record "Interest Header")
    var
        Loans: Record Loans;
        ProdType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        DailyLoansInterest: Record "Daily Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Memb: Record Members;
        Accounts: Record "Savings Accounts";
        RegFeeAcc: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
    begin
        //with InterestBuffer do
        begin
            if InterestBuffer.Posted = true then
                Error(AlreadyPostedErr);
            InterestBuffer.TestField("Document No.");
            InterestBuffer.TestField("Interest Due Date");
            InterestBuffer.TestField(Description);
            InterestBuffer.TestField("Posting Date");
            IntCharged := 0;
            Principle := 0;

            GeneralSetUp.Get();

            RegFeeAcc.Reset;
            RegFeeAcc.SetFilter("Product Category", '%1', RegFeeAcc."product category"::"Entrance Fee");
            RegFeeAcc.SetRange("Rejoin Bil Date", 0D);
            if RegFeeAcc.Find('-') then begin
                repeat
                    RegFeeAcc.CalcFields("Balance (LCY)", "Date Billed");
                    Memb.Get(RegFeeAcc."Member No.");
                    if Memb."Rejoinig Date" >= Dmy2date(1, 9, 2020) then begin
                        if (Memb.Status = Memb.Status::Active) or
                          (Memb.Subflag = Memb.Subflag::Defaulter) or
                         (Memb.Status = Memb.Status::New) then begin


                            LoansInterest.Init;
                            LoansInterest.No := InterestBuffer."No.";
                            LoansInterest."Account Type" := LoansInterest."account type"::Savings;
                            LoansInterest."Account No" := RegFeeAcc."No.";
                            LoansInterest."Interest Date" := Today;
                            LoansInterest."Interest Bill" := GeneralSetUp."Rejoining Fee";
                            LoansInterest.Description := InterestBuffer.Description;
                            LoansInterest."Shortcut Dimension 1 Code" := RegFeeAcc."Global Dimension 1 Code";
                            LoansInterest."Shortcut Dimension 2 Code" := RegFeeAcc."Global Dimension 2 Code";
                            LoansInterest."Loan Product type" := RegFeeAcc."Product Type";
                            if ProdType.Get(RegFeeAcc."Product Type") then begin
                                LoansInterest."Bal. Account Type" := LoansInterest."bal. account type"::"G/L Account";
                                LoansInterest."Bal. Account No." := ProdType."Accrual Fee Acc. (Income)";
                            end;
                            RegFeeAcc.CalcFields("Balance (LCY)");
                            LoansInterest."Outstanding Balance" := RegFeeAcc."Balance (LCY)";
                            LoansInterest.Status := Memb.Status;
                            if LoansInterest."Interest Bill" <> 0 then
                                LoansInterest.Insert;
                        end;
                    end;
                until RegFeeAcc.Next = 0;
            end;
        end;
    end;

    var
        Source: Enum "SMS Source";
        msg: Text;
        MemberCategory: Record "Member Classes";
        CUstomCuesCU: Codeunit CustomCuesCodeunit;
        InstalmentPeriods: DateFormula;
        IntstallMentPeriodText: Text;
        ForMoreInfo: Label 'For more info call 0709 898 000';

}



