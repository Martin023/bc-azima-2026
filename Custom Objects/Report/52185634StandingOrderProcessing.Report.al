#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185634 "Standing Order Processing"
{
    ProcessingOnly = true;
    //UseRequestPage = false; 

    dataset
    {
        dataitem(StandingOrderHeader; "Standing Order Header")
        {
            DataItemTableView = where(Status = const(Approved), "Income Type" = const(Periodic));
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var

            begin
                StandingOrdSRegister.Reset;
                StandingOrdSRegister.SetRange(StandingOrdSRegister."Date Processed", RunDate);
                StandingOrdSRegister.SetFilter(StandingOrdSRegister."Document No.", StandingOrderHeader."No.");
                if StandingOrdSRegister.Find('-') then
                    StandingOrdSRegister.DeleteAll;

                AvailableBal := 0;
                RunBal := 0;
                AmountDedu := 0;
                remainingBal := 0;

                if SavingsAccounts.Get(StandingOrderHeader."Source Account No.") then begin

                    GlobalDim1 := BankingUserTemplate."Global Dimension 1 Code";
                    GlobalDim2 := BankingUserTemplate."Global Dimension 2 Code";

                    getChargeAmount(StandingOrderHeader);

                    if ProductFactory.Get(SavingsAccounts."Product Type") then
                        AvailableBal := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.")
                    else
                        CurrReport.skip;

                    IF StandingOrderHeader."Next Run Date" = 0D then
                        StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", StandingOrderHeader."Effective/Start Date");

                    if StandingOrderHeader."Next Run Date" <= RunDate then begin
                        if StandingOrderHeader."End Date" < RunDate then begin
                            StandingOrderHeader.Status := StandingOrderHeader.Status::Stopped;
                            StandingOrderHeader."Stopped By" := UserId;
                            StandingOrderHeader."Date Stopped" := RunDate;
                            StandingOrderHeader.modify;
                            CurrReport.Skip();
                        end;


                        RunBal := AvailableBal;

                        if RunBal > 0 then begin

                            //Charges
                            STOlinesname := StandingOrderLines."Destination Account Name";
                            GenSetup.Get;
                            TCharges := 0;
                            remainingBal := 0;

                            // Loan STO
                            LineN += 1;
                            remainingBal := PostLoanSTO(StandingOrderHeader, StandingOrderHeader."No.", RunDate, GlobalDim2, GlobalDim1, Jtemplate, Jbatch, RunBal, StandingOrderHeader."Member No.", LineN, StandingOrderHeader."Source Account No.");
                            RunBal -= remainingBal;
                            AmountDedu += remainingBal;


                            if RunBal > 0 then begin
                                LineN += 1;
                                PostSavingSTO(StandingOrderHeader, StandingOrderHeader."No.", RunDate, GlobalDim2, GlobalDim1, Jtemplate, Jbatch, RunBal, StandingOrderHeader."Member No.", LineN, StandingOrderHeader."Source Account No.");
                            end;

                            //Almost due/proccesssed SMS
                            MobNo := '';

                            if CalcDate('3M', Today) >= StandingOrderHeader."End Date" then begin

                                if Account.Get(StandingOrderHeader."Source Account No.") then begin
                                    MobNo := Account."Transactional Mobile No";
                                end;

                                //your standing order of amount is due to expire on + end date
                                msg := Text0001 + Format(StandingOrderHeader.Amount) + Text0005 +
                                Format(StandingOrderHeader."End Date") + ' ' + Format(Today) + ' ' + Format(Time) + ' ' + COMPANYNAME;

                                SendSMS.SendSms(Source::MBANKING, MobNo, msg, Format("No."), '', true, Priority, false, 'CBS', "No.", 'CBS');
                            end;

                            GenJLine.Reset;
                            GenJLine.SetRange(GenJLine."Journal Template Name", JTemplate);
                            GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
                            if GenJLine.FindFirst() then
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post New", GenJLine);

                            StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", RunDate);
                            if StandingOrderHeader."Next Run Date" > StandingOrderHeader."End Date" then
                                StandingOrderHeader."Next Run Date" := StandingOrderHeader."End Date";
                            StandingOrderHeader.Modify();

                            //Add SMS

                        end
                        else
                            CurrReport.skip;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message(SuccessfullyPosted);
            end;

            trigger OnPreDataItem()
            begin
                if RunDate = 0D then
                    RunDate := Today;

                BankingUserTemplate.Get(UserId);
                JTemplate := BankingUserTemplate."Cashier Journal Template";
                JBatch := BankingUserTemplate."Cashier Journal Batch";

                if (JBatch = '') or (Jtemplate = '') then Error('Ensure cashier batch & template has been set up for the user.');
                GenJLine.Reset;
                GenJLine.SetRange(GenJLine."Journal Template Name", JTemplate);
                GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
                GenJLine.DeleteAll;

                // StandingOrderHeader.Reset();
                // StandingOrderHeader.Setfilter("Next Run Date", '..%1', RunDate);
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
                field("Next Run Date"; Rundate)
                {
                    Caption = 'Run Date';
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
    trigger OnPreReport()
    begin
        if RunDate = 0D then
            RunDate := Today;
    end;

    var
        SaccoTrans: Codeunit "Sacco Transactions";
        SuccessfullyPosted: label 'Successfully Processed.';
        RunDate: Date;
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
        loansProcess: Codeunit "Loans Process";
        Text0001: label 'Your periodic standing order of ';
        Text0002: label ' has been effected partially the amount due is ';
        Text0003: label ' has been effected successfully ';
        Text0004: label ' has been unsuccessful ';
        Text0005: label ' is due to expire on ';
        STOlinesname: Text[80];
        GenSetup: Record "General Set-Up";
        Source: Enum "SMS Source";
        msg: Text;
        SMSSource: Enum "SMS Source";
        remainingBal: Decimal;

    procedure getChargeAmount(StandingOrderHeader: Record "Standing Order Header")
    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
    begin
        TCharges := 0;
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat

                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                  (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Failed STO Charge") then begin

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
                                if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                    (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" then
                                        ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                    else
                                        ChargeAmount := TariffDetails."Charge Amount";
                                end;

                            until TariffDetails.Next = 0;
                        end;
                    end;

                    TChargeAmount += ChargeAmount;
                end;
            until TransactionCharges.Next = 0;
        end;
        TCharges := TChargeAmount;
    end;

    local procedure PostSavingSTO(StandingOrderHeader: record "Standing Order Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        // StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        RemainingBal: decimal;
        MaxSTO: Decimal;
    begin
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.findlast then begin
            LineNo := GenJournalLine."Line No.";
        end;
        AmtDeducted := 0;
        RemainingBal := RunBal;
        GenSetup.Get;
        SkipSTO := false;
        if SkipSTO = false then begin
            STOHeaderNo := '';
            STOHeaderNo := StandingOrderHeader."No.";

            if RunBal > StandingOrderHeader.Amount then begin
                StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
            end else begin
                StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
            end;
            if RunBal < 0 then
                RunBal := 0;

            StandingOrderLines.Reset;
            StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
            StandingOrderLines.Setfilter(StandingOrderLines."destination account type", '%1|%2', StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account");
            if StandingOrderLines.FindSet() then begin
                repeat
                    MaxSTO := StandingOrderLines.Amount;
                    if RunBal > 0 then begin
                        if RunBal <= StandingOrderLines.Amount then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                            GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                         , 50);

                            if StandingOrderLines.Amount >= RunBal then begin
                                GenJournalLine.Amount := RunBal * -1;
                                AmtDeducted += RunBal;
                                RunBal := 0;
                            end
                            else begin
                                GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                RunBal -= Abs(StandingOrderLines.Amount);
                                AmtDeducted += Abs(StandingOrderLines.Amount);
                            end;
                            GenJournalLine.Validate(Amount);

                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end
                        else begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                            GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                         , 50);

                            if StandingOrderLines.Amount >= MaxSTO then begin
                                GenJournalLine.Amount := MaxSTO * -1;
                                AmtDeducted += MaxSTO;
                                RunBal -= MaxSTO;
                                MaxSTO := 0;
                            end
                            else begin
                                GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                RunBal -= Abs(StandingOrderLines.Amount);
                                AmtDeducted += Abs(StandingOrderLines.Amount);
                                MaxSTO -= Abs(StandingOrderLines.Amount);
                            end;

                            // if StandingOrderLines.Amount >= RunBal then begin
                            //     GenJournalLine.Amount := RunBal * -1;
                            //     AmtDeducted += RunBal;
                            //     RunBal := 0;
                            // end
                            // else begin
                            //     GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                            //     RunBal -= Abs(StandingOrderLines.Amount);
                            //     AmtDeducted += Abs(StandingOrderLines.Amount);
                            // end;
                            GenJournalLine.Validate(Amount);

                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                    end;

                until StandingOrderLines.Next = 0;

                // TCharges := TChargeAmount;
                //Charges
                LineNo := LineNo + 10000;
                // AmtDeducted += TCharges;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := Jbatch;

                GenJournalLine."Line No." := LineNo;

                GenJournalLine."Posting Date" := PDate;
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."External Document No." := StandingOrderHeader."No.";
                GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                GenJournalLine.Description := PadStr('STO:-' + Format(StandingOrderHeader."No.") + '-' + Format(STOlinesname), 50);
                GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
            if AmtDeducted > 0 then begin
                UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                           StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                           StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                           StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");
            end;

        end;
        RemainingBal -= AmtDeducted;

    end;

    procedure UpdateStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[11]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Code[50]; Reft: Boolean; RTransferEft: Boolean; STONo: Code[20])
    var
        LineNo: Code[10];
        StandingOrdSRegister: Record "Standing Order Register";
    begin
        //*
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
        //StandingOrdSRegister."Destination Account Type":=Destinacctype;
        StandingOrdSRegister.Insert(true);
    end;

    local procedure PostLoanSTO(StandingOrderHeader: Record "Standing Order Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20]): Decimal
    var

        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        LoanApps: Record Loans;
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        TotalDeduction: decimal;
        MaxSTO: Decimal;
    begin
        TotalDeduction := 0;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.findlast then begin
            LineNo := GenJournalLine."Line No.";
        end;

        AmtDeducted := 0;
        SkipSTO := false;
        if SkipSTO = false then begin
            STOHeaderNo := '';
            STOHeaderNo := StandingOrderHeader."No.";

            if RunBal > StandingOrderHeader.Amount then begin
                StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
            end else begin
                StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
            end;
            if RunBal < 0 then
                RunBal := 0;

            StandingOrderLines.Reset;
            StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
            StandingOrderLines.SetRange(StandingOrderLines."destination account type", StandingOrderLines."destination account type"::Credit);
            if StandingOrderLines.FindSet() then begin
                repeat
                    MaxSTO := StandingOrderLines.Amount;
                    if RunBal > 0 then begin
                        if RunBal <= StandingOrderLines.Amount then begin
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                            if LoanApps.Find('-') then begin
                                LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                if LoanApps."Total Balance" > 0 then begin
                                    if (LoanApps."Outstanding Interest") > 0 then begin
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := STOHead."No.";
                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                        GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                     Format(GenJournalLine."transaction type"::"Interest Paid"), 50);


                                        if LoanApps."Outstanding Interest" >= RunBal then begin
                                            GenJournalLine.Amount := RunBal * -1;
                                            AmtDeducted += RunBal;
                                            RunBal := 0;
                                        end
                                        else begin
                                            GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                            RunBal -= Abs(LoanApps."Outstanding Interest");
                                            AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                        end;
                                        GenJournalLine.validate(Amount);
                                        GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                    end;
                                    if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                        if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                            LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                    if (LoanApps."Outstanding Balance" > 0) then begin
                                        if RunBal > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := STOHead."No.";
                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                            GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                         Format(GenJournalLine."transaction type"::Repayment), 50);

                                            if LoanApps."Outstanding Balance" >= RunBal then begin
                                                GenJournalLine.Amount := RunBal * -1;
                                                AmtDeducted += RunBal;
                                                RunBal := 0;
                                            end
                                            else begin
                                                GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                RunBal -= Abs(LoanApps."Outstanding Balance");
                                                AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                            end;
                                            GenJournalLine.validate(Amount);
                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;
                                end;
                            end;
                        end
                        else begin
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                            if LoanApps.Find('-') then begin
                                LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                if LoanApps."Total Balance" > 0 then begin
                                    if (LoanApps."Outstanding Interest") > 0 then begin
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := STOHead."No.";
                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                        GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                     Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                        if LoanApps."Outstanding Interest" >= MaxSTO then begin
                                            GenJournalLine.Amount := MaxSTO * -1;
                                            AmtDeducted += MaxSTO;
                                            RunBal -= MaxSTO;
                                            MaxSTO := 0;
                                        end
                                        else begin
                                            GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                            RunBal -= Abs(LoanApps."Outstanding Interest");
                                            AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                            MaxSTO -= Abs(LoanApps."Outstanding Interest");
                                        end;
                                        GenJournalLine.Validate(Amount);
                                        GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                    end;
                                    if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                        if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                            LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                    if (LoanApps."Outstanding Balance" > 0) then begin
                                        if RunBal > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := STOHead."No.";
                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                            GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                         Format(GenJournalLine."transaction type"::Repayment), 50);

                                            // if LoanApps."Outstanding Balance" >= RunBal then begin
                                            //     GenJournalLine.Amount := RunBal * -1;
                                            //     AmtDeducted += RunBal;
                                            //     RunBal := 0;
                                            // end
                                            // else begin
                                            //     GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                            //     RunBal -= Abs(LoanApps."Outstanding Balance");
                                            //     AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                            // end;
                                            if LoanApps."Outstanding Balance" >= MaxSTO then begin
                                                GenJournalLine.Amount := MaxSTO * -1;
                                                AmtDeducted += MaxSTO;
                                                RunBal -= MaxSTO;
                                                MaxSTO := 0;
                                            end
                                            else begin
                                                GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                RunBal -= Abs(LoanApps."Outstanding Balance");
                                                AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                MaxSTO -= Abs(LoanApps."Outstanding Balance");
                                            end;
                                            GenJournalLine.Validate(Amount);
                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                until StandingOrderLines.Next = 0;
            end;

            if STOHead.Get(STOHeaderNo) then begin
                //Charges
                STOlinesname := StandingOrderLines."Destination Account Name";
                GenSetup.Get;
                TCharges := 0;
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                if TransactionCharges.FindSet() then begin
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
                                if TariffDetails.FindSet() then begin
                                    repeat
                                        if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                            (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" then
                                                ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                            else
                                                ChargeAmount := TariffDetails."Charge Amount";
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                            GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                (TransactionCharges."Recover Excise Duty" = true) then begin
                                //Excise
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine."Document No." := DocNo;
                                GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                GenJournalLine.Description := StandingOrderLines."Document No." + ' Excise Duty';//TransactionCharges.Description;
                                GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Excise
                            end;
                            TChargeAmount += ChargeAmount;
                        end;
                    until TransactionCharges.Next = 0;
                end;
                TCharges := TChargeAmount;
                AmtDeducted += TCharges;
                //Charges
                LineNo := LineNo + 10000;


                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := Jbatch;

                GenJournalLine."Line No." := LineNo;

                GenJournalLine."Posting Date" := PDate;
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."External Document No." := STOHead."No.";
                GenJournalLine."Account Type" := STOHead."Source Account Type";
                GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
            if AmtDeducted > 0 then begin
                UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                           StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                           StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                           StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");
            end;

        end;
        TotalDeduction += AmtDeducted;
        exit(TotalDeduction);
    end;
}
