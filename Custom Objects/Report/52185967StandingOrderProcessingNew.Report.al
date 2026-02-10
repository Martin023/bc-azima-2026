#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185967 "Standing Order Processing New"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(StandingOrderHeader; "Standing Order Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                SOProcessing: Codeunit "Mngt. Routine Processes";
            begin
                // SOProcessing.StandingOrderHeaderP(NextRunDate, StandingOrderHeader);

                GeneralSetUp.Get;
                GenSetup.Get;

                AvailableBal := 0;
                RunBal := 0;
                AmountDedu := 0;
                STOAmount := 0;

                StandingOrderHeader."Allow Partial Deduction" := true;
                if SavingsAccounts.Get(StandingOrderHeader."Source Account No.") then begin
                    //MESSAGE('t1');
                    GlobalDim1 := SavingsAccounts."Global Dimension 1 Code";
                    GlobalDim2 := SavingsAccounts."Global Dimension 2 Code";

                    TCharges := 0;
                    getTransactionCharges(StandingOrderHeader, false);
                    // AvailableBal := Periodic.GetAccountBalance(SavingsAccounts."No.");
                    AvailableBal -= TCharges;

                    RunBal := AvailableBal;



                    STOAmount := StandingOrderHeader.Amount;

                    if StandingOrderHeader.Balance > STOAmount then
                        StandingOrderHeader.Balance := STOAmount;

                    if StandingOrderHeader.Balance > 0 then
                        STOAmount := StandingOrderHeader.Balance;

                    if STOAmount <= 0 then
                        CurrReport.Skip;

                    if AvailableBal >= STOAmount then begin
                        DeductionStatus := Deductionstatus::Successfull;
                        StandingOrderHeader.Balance := 0;
                        RunBal := STOAmount;
                    end else begin
                        if not StandingOrderHeader."Allow Partial Deduction" then begin
                            DeductionStatus := Deductionstatus::Failed;
                            RunBal := 0;
                        end else begin
                            if AvailableBal >= TCharges then begin
                                DeductionStatus := Deductionstatus::"Partial Deduction";
                                StandingOrderHeader.Balance := STOAmount - AvailableBal;
                                RunBal := AvailableBal;
                            end else begin
                                DeductionStatus := Deductionstatus::Failed;
                                StandingOrderHeader.Balance := STOAmount;
                                RunBal := 0;
                            end;
                        end;
                    end;

                    //MESSAGE('%1',RunBal);
                    StandingOrderLines.Reset;
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                    if StandingOrderLines.Find('-') then begin
                        // SaccoTrans.InitJournal(JTemplate, JBatch);

                        if RunBal > 0 then
                            repeat
                                STOlinesname := StandingOrderLines."Destination Account Name";
                                //MESSAGE('t2');
                                case StandingOrderLines."Destination Account Type" of
                                    StandingOrderLines."destination account type"::Savings,
                                    StandingOrderLines."destination account type"::"G/L Account":
                                        //StandingOrderLines."destination account type"::"G/L Account":
                                        begin
                                            case StandingOrderLines."Destination Account Type" of
                                                StandingOrderLines."destination account type"::"G/L Account":
                                                    begin
                                                        AcctType := Accttype::"G/L Account";
                                                        AcctNo := GenSetup."External STO Account No.";
                                                    end;
                                                //***Sto to gensetup ext account joan
                                                //StandingOrderLines."destination account type"::"G/L Account",
                                                StandingOrderLines."destination account type"::Savings:
                                                    begin
                                                        AcctType := StandingOrderLines."Destination Account Type";
                                                        AcctNo := StandingOrderLines."Destination Account No.";
                                                    end;
                                            end;
                                            Desc := PadStr('STO:-' + Format(StandingOrderHeader."No.") + ' : ' + Format(StandingOrderHeader."Next Run Date") +
                                                  ' : ' + Format(StandingOrderHeader."Source Account Name"), 50);

                                            if RunBal > StandingOrderLines.Amount then
                                                Amt := -StandingOrderLines.Amount
                                            else
                                                Amt := -RunBal;

                                            LoanNo := StandingOrderLines."Loan No.";
                                            BalAcctType := Balaccttype::"G/L Account";
                                            BalAcctNo := '';
                                            ExtDocNo := StandingOrderHeader."No.";

                                            // SaccoTrans.JournalInsert(JTemplate, JBatch, StandingOrderHeader."No.", PDate, AcctType, AcctNo, Desc, BalAcctType,
                                            // BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true);

                                            RunBal -= Abs(Amt);
                                            AmountDedu += Abs(Amt);
                                        end;

                                    StandingOrderLines."destination account type"::Credit:
                                        begin
                                            //MESSAGE('t3');
                                            LoanInterest := 0;
                                            LoanPrincipal := 0;
                                            LoanRepayment := 0;

                                            LoanApps.Reset;
                                            LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                            if LoanApps.Find('-') then begin
                                                LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Bills", LoanApps."Outstanding Balance");

                                                LoanPrincipal := StandingOrderLines.Amount;

                                                if StandingOrderLines."Destination Account No." = '' then begin
                                                    StandingOrderLines."Destination Account No." := LoanApps."Loan Account";
                                                    //StandingOrderLines.MODIFY;
                                                end;
                                                //MESSAGE('RUn Bal %1',RunBal);


                                                //MESSAGE('RUn Bal %1',RunBal);

                                                //MESSAGE('RUn Bal %1\%2',RunBal,LoanApps."Outstanding Interest");

                                                if LoanApps."Outstanding Interest" > 0 then begin

                                                    AcctType := StandingOrderLines."Destination Account Type";
                                                    AcctNo := StandingOrderLines."Destination Account No.";
                                                    Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                              Format(GenJLine."transaction type"::"Interest Paid"), 50);

                                                    LoanNo := StandingOrderLines."Loan No.";
                                                    BalAcctType := Balaccttype::"G/L Account";
                                                    BalAcctNo := '';
                                                    ExtDocNo := StandingOrderHeader."No.";
                                                    TransType := Transtype::"Interest Paid";
                                                    LoanInterest := LoanApps."Outstanding Interest";

                                                    if LoanInterest > StandingOrderLines.Amount then begin
                                                        LoanInterest := StandingOrderLines.Amount;
                                                        LoanPrincipal := 0;
                                                    end;

                                                    if RunBal > LoanInterest then
                                                        Amt := -LoanInterest
                                                    else
                                                        Amt := -RunBal;

                                                    //MESSAGE('Amt %1',Amt);
                                                    // SaccoTrans.JournalInsert(JTemplate, JBatch, StandingOrderHeader."No.", PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                    // BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true);

                                                    RunBal -= Abs(Amt);
                                                    AmountDedu += Abs(Amt);
                                                    LoanPrincipal -= Abs(Amt);
                                                end;

                                                // MESSAGE('RUn Bal %1',RunBal);
                                                if LoanPrincipal > 0 then
                                                    if (LoanApps."Outstanding Balance" > 0) /*AND (LoanApps."Outstanding Bills" >0)*/ then begin

                                                        AcctType := StandingOrderLines."Destination Account Type";
                                                        AcctNo := StandingOrderLines."Destination Account No.";
                                                        Desc := PadStr('Destination:- ' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                  Format(GenJLine."transaction type"::Bills), 50);

                                                        LoanNo := StandingOrderLines."Loan No.";

                                                        BalAcctType := Balaccttype::"G/L Account";
                                                        if ProductFactory.Get(LoanApps."Loan Product Type") then
                                                            BalAcctNo := ProductFactory."Billed Account";

                                                        ExtDocNo := StandingOrderHeader."No.";
                                                        TransType := Transtype::Bills;

                                                        if LoanApps."Outstanding Balance" >= LoanPrincipal then
                                                            LoanRepayment := LoanPrincipal
                                                        else
                                                            LoanRepayment := LoanApps."Outstanding Balance";

                                                        if RunBal >= LoanRepayment then
                                                            Amt := -LoanRepayment
                                                        else
                                                            Amt := -RunBal;


                                                        // SaccoTrans.JournalInsert(JTemplate, JBatch, StandingOrderHeader."No.", PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                        // BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true);

                                                        Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                              Format(GenJLine."transaction type"::Repayment), 50);

                                                        BalAcctType := Balaccttype::"G/L Account";
                                                        BalAcctNo := '';
                                                        TransType := Transtype::Repayment;

                                                        // SaccoTrans.JournalInsert(JTemplate, JBatch, StandingOrderHeader."No.", PDate, AcctType, AcctNo, Desc, BalAcctType,
                                                        // BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true);

                                                        RunBal -= Abs(Amt);
                                                        AmountDedu += Abs(Amt);
                                                    end;
                                            end;
                                        end;
                                end;
                            until StandingOrderLines.Next = 0;
                    end;

                    AcctType := StandingOrderHeader."Source Account Type";
                    AcctNo := StandingOrderHeader."Source Account No.";
                    Desc := PadStr('STO:-' + Format(StandingOrderHeader."No.") + ' : ' + Format(StandingOrderHeader."Next Run Date") + '-' + Format(STOlinesname), 50);
                    Amt := AmountDedu;
                    LoanNo := '';
                    BalAcctType := Balaccttype::"G/L Account";
                    BalAcctNo := '';
                    ExtDocNo := StandingOrderHeader."No.";

                    // SaccoTrans.JournalInsert(JTemplate, JBatch, StandingOrderHeader."No.", PDate, AcctType, AcctNo, Desc, BalAcctType,
                    // BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, GlobalDim1, GlobalDim2, true);

                    if AmountDedu < StandingOrderHeader.Amount then begin
                        DeductionStatus := Deductionstatus::"Partial Deduction";
                        if DeductionStatus = Deductionstatus::"Partial Deduction" then
                            StandingOrderHeader."Next Run Date" := Today;
                    end;

                    if AmountDedu >= StandingOrderHeader.Amount then begin
                        if DeductionStatus = Deductionstatus::Successfull then
                            StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", StandingOrderHeader."Next Run Date");
                    end;

                    if AmountDedu = 0 then
                        DeductionStatus := Deductionstatus::Failed;

                end;


                if StandingOrderHeader.Status <> StandingOrderHeader.Status::Stopped then
                    if DeductionStatus = Deductionstatus::Successfull then
                        StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", StandingOrderHeader."Next Run Date");

                if DeductionStatus <> Deductionstatus::Failed then
                    getTransactionCharges(StandingOrderHeader, true);

                StandingOrderHeader.Modify;
                // SaccoTrans.PostJournal(JTemplate, JBatch);

                InitializeStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                DeductionStatus, StandingOrderHeader.Amount, AmountDedu, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");

                StandingOrderLines.Reset;
                StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                StandingOrderLines.SetRange(StandingOrderLines."Destination Account Type", StandingOrderLines."destination account type"::Credit);
                if StandingOrderLines.Find('-') then begin
                    LoanApps.Reset;
                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                    if LoanApps.Find('-') then begin
                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Bills", LoanApps."Outstanding Balance");
                        if LoanApps."Outstanding Interest" + LoanApps."Outstanding Balance" <= 0 then begin
                            StandingOrderHeader.Status := StandingOrderHeader.Status::Stopped;
                            StandingOrderHeader.Modify;
                        end;
                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message(SuccessfullyPosted);
            end;

            trigger OnPreDataItem()
            begin
                if NextRunDate = 0D then
                    NextRunDate := Today;

                BankingUserTemplate.Get(UserId);
                BankingUserTemplate.TestField("Transfer Journal Batch");
                BankingUserTemplate.TestField("Transfer Journal Template");

                JTemplate := BankingUserTemplate."Transfer Journal Template";
                JBatch := BankingUserTemplate."Transfer Journal Batch";

                GenJLine.Reset;
                GenJLine.SetRange(GenJLine."Journal Template Name", JTemplate);
                GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
                GenJLine.DeleteAll;

                StandingOrderHeader.SetFilter("Next Run Date", '..%1', NextRunDate);
                PDate := Today;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Next Run Date"; NextRunDate)
                {
                    ApplicationArea = Basic;
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

    var
        SuccessfullyPosted: label 'Successfully Processed.';
        NextRunDate: Date;
        GeneralSetUp: Record "General Set-Up";
        SavingsAccounts: Record "Savings Accounts";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        ProductFactory: Record "Product Factory";
        TCharges: Decimal;
        AvailableBal: Decimal;
        RunBal: Decimal;
        AmountDedu: Decimal;
        BankingUserTemplate: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        GenJLine: Record "Gen. Journal Line";
        StandingOrderLines: Record "Standing Order Lines";
        LoanApps: Record Loans;
        DeductionStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        LoanInterest: Decimal;
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        MobNo: Code[20];
        Account: Record "Savings Accounts";
        SendSMS: Codeunit SendSms;
        Bal: Decimal;
        Text0001: label 'Your standing order of ';
        Text0002: label ' has been effected partially the amount due is ';
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book";
        Text0003: label ' has been effected successfully ';
        Text0004: label ' has been unsuccessful ';
        Text0005: label ' is due to expire on ';
        STOlinesname: Text[80];
        GenSetup: Record "General Set-Up";
        Periodic: Codeunit "Periodic Activities";
        STOAmount: Decimal;
        PDate: Date;
        //SaccoTrans: Codeunit SaccoTrans
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        Amt: Decimal;
        ExtDocNo: Code[20];
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,"Appraisal Due","Ledger Fee","Appraisal Paid","Pre-Earned Interest","Penalty Due","Penalty Paid";
        Desc: Text[50];
        LoanNo: Code[20];
        SLedger: Record "Savings Ledger Entry";
        STOAmountPosted: Decimal;
        LoanAppraisal: Decimal;
        LoanPenalty: Decimal;


    procedure getTransactionCharges(StandingOrderHeader: Record "Standing Order Header"; InsertJournal: Boolean)
    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GenSetup: Record "General Set-Up";
    begin
        //*Charges Posting

        GenSetup.Get;

        TCharges := 0;
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat

                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                        ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" then
                                        ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                    else
                                        ChargeAmount := TariffDetails."Charge Amount";
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    LineN += 1;
                    GenJLine.Init;
                    GenJLine."Journal Template Name" := JTemplate;
                    GenJLine."Journal Batch Name" := JBatch;
                    GenJLine."Line No." := LineN;
                    GenJLine."Posting Date" := Today;
                    GenJLine."Document No." := StandingOrderHeader."No.";
                    GenJLine."External Document No." := StandingOrderHeader."Member No.";
                    GenJLine."Account Type" := StandingOrderHeader."Source Account Type";
                    GenJLine.Validate(GenJLine."Account No.", StandingOrderHeader."Source Account No.");
                    GenJLine.Description := TransactionCharges.Description;
                    GenJLine.Validate(GenJLine.Amount, ChargeAmount);
                    GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Bal. Account No.", TransactionCharges."G/L Account");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                    if InsertJournal then
                        if GenJLine.Amount <> 0 then
                            GenJLine.Insert;

                    TChargeAmount += GenJLine.Amount;


                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty" = true) then begin
                        //Excise
                        LineN += 1;
                        GenJLine.Init;
                        GenJLine."Journal Template Name" := JTemplate;
                        GenJLine."Journal Batch Name" := JBatch;
                        GenJLine."Line No." := LineN;
                        GenJLine."Posting Date" := Today;
                        GenJLine."Document No." := StandingOrderHeader."No.";
                        GenJLine."External Document No." := StandingOrderHeader."Member No.";
                        GenJLine."Account Type" := StandingOrderHeader."Source Account Type";
                        GenJLine.Validate(GenJLine."Account No.", StandingOrderHeader."Source Account No.");
                        GenJLine.Description := 'Excise Duty';//TransactionCharges.Description;
                        GenJLine.Validate(GenJLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                        GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                        GenJLine.Validate(GenJLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                        if InsertJournal then
                            if GenJLine.Amount <> 0 then
                                GenJLine.Insert;

                        TChargeAmount += GenJLine.Amount;
                        //Excise
                    end;

                end;
            until TransactionCharges.Next = 0;
        end;

        TCharges := TChargeAmount;
    end;


    procedure InitializeStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[10]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Text; Reft: Boolean; RTransferEft: Boolean; STONo: Code[20])
    var
        LineNo: Code[10];
        StandingOrdSRegister: Record "Standing Order Register";
    begin

        StandingOrdSRegister.Reset;
        StandingOrdSRegister.SetRange("Standing Order No.", STONo);
        StandingOrdSRegister.SetRange("Date Processed", RDateProcessed);
        StandingOrdSRegister.SetRange("Deduction Status", RDeductionStatus);
        StandingOrdSRegister.SetRange("Amount Deducted", RAmountDeducted);
        StandingOrdSRegister.SetRange(Amount, RDeductionAmount);
        StandingOrdSRegister.SetRange("Source Account No.", RSourceAccountNo);
        if not StandingOrdSRegister.FindFirst then begin

            StandingOrdSRegister.Init;
            StandingOrdSRegister."No." := RNo;
            StandingOrdSRegister."Date Processed" := RDateProcessed;
            StandingOrdSRegister."Document No." := RDocNo;
            StandingOrdSRegister."No. Series" := RNoSeries;
            StandingOrdSRegister."Source Account No." := RSourceAccountNo;
            StandingOrdSRegister."Source Account Name" := RSourceAccountName;
            StandingOrdSRegister."Member No" := RMemberNo;
            StandingOrdSRegister."Staff/Payroll No." := RStaffNo;
            StandingOrdSRegister."Allow Partial Deduction" := RPartialDeduction;
            StandingOrdSRegister."Deduction Status" := RDeductionStatus;
            StandingOrdSRegister.Amount := RDeductionAmount;
            StandingOrdSRegister."Amount Deducted" := RAmountDeducted;
            StandingOrdSRegister."Effective/Start Date" := RStartDate;
            StandingOrdSRegister.Duration := RDuration;
            StandingOrdSRegister.Frequency := RFrequency;
            StandingOrdSRegister."End Date" := REndDate;
            StandingOrdSRegister.Remarks := Rremarks;
            StandingOrdSRegister.EFT := Reft;
            StandingOrdSRegister."Transfered to EFT" := RTransferEft;
            StandingOrdSRegister."Standing Order No." := STONo;
            StandingOrdSRegister.Insert(true);

        end;
        StandingOrderLines.Reset;
        StandingOrderLines.SetRange("Document No.", StandingOrdSRegister."Document No.");
        StandingOrderLines.SetFilter("Destination Account Type", '', StandingOrderLines."destination account type"::"G/L Account");
        if StandingOrderLines.FindFirst then begin
            StandingOrdSRegister.EFT := true;
            StandingOrdSRegister.Modify;
        end;
    end;


    procedure getTransactionChargesFailedSTO(StandingOrderHeader: Record "Standing Order Header"; InsertJournal: Boolean)
    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GenSetup: Record "General Set-Up";
    begin
        //*Charges Posting

        GenSetup.Get;

        TCharges := 0;
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat

                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Failed STO Charge") then begin

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                        ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" then
                                        ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                    else
                                        ChargeAmount := TariffDetails."Charge Amount";
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    LineN += 1;
                    GenJLine.Init;
                    GenJLine."Journal Template Name" := JTemplate;
                    GenJLine."Journal Batch Name" := JBatch;
                    GenJLine."Line No." := LineN;
                    GenJLine."Posting Date" := Today;
                    GenJLine."Document No." := StandingOrderHeader."No.";
                    GenJLine."External Document No." := StandingOrderHeader."Member No.";
                    GenJLine."Account Type" := StandingOrderHeader."Source Account Type";
                    GenJLine.Validate(GenJLine."Account No.", StandingOrderHeader."Source Account No.");
                    GenJLine.Description := TransactionCharges.Description;
                    GenJLine.Validate(GenJLine.Amount, ChargeAmount);
                    GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Bal. Account No.", TransactionCharges."G/L Account");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                    if InsertJournal then
                        if GenJLine.Amount <> 0 then
                            GenJLine.Insert;

                    TChargeAmount += GenJLine.Amount;


                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty" = true) then begin
                        //Excise
                        LineN += 1;
                        GenJLine.Init;
                        GenJLine."Journal Template Name" := JTemplate;
                        GenJLine."Journal Batch Name" := JBatch;
                        GenJLine."Line No." := LineN;
                        GenJLine."Posting Date" := Today;
                        GenJLine."Document No." := StandingOrderHeader."No.";
                        GenJLine."External Document No." := StandingOrderHeader."Member No.";
                        GenJLine."Account Type" := StandingOrderHeader."Source Account Type";
                        GenJLine.Validate(GenJLine."Account No.", StandingOrderHeader."Source Account No.");
                        GenJLine.Description := 'Excise Duty';//TransactionCharges.Description;
                        GenJLine.Validate(GenJLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                        GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                        GenJLine.Validate(GenJLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                        if InsertJournal then
                            if GenJLine.Amount <> 0 then
                                GenJLine.Insert;

                        TChargeAmount += GenJLine.Amount;
                        //Excise
                    end;

                end;
            until TransactionCharges.Next = 0;
        end;

        TCharges := TChargeAmount;
    end;
}
