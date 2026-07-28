#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 
Report 52185446 "End of Day Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/EndOfDayReconciliation.rdl';

    dataset
    {
        dataitem(TreasuryTrans; "Treasury Cashier Transactions")
        {
            DataItemTableView = sorting(No) where("Transaction Type" = const("End of Day Return to Treasury"));
            RequestFilterFields = No, "From Account", "Date Posted";

            column(CompanyInfo_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy_Header; PrintedBy) { }
            column(CompanyBranch_Name; CompanyInformation.Name + ' SASA Section') { }
            column(PrintDate; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(TellerName; "From Account") { }
            column(EndOfDayDate; Format("Date Posted", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(EODPostedStatus; EODPostedStatusTxt) { }
            column(TellerAccount; "From Bank") { }
            column(PostedBy; "Posted By") { }
            column(ShortageAcc; ShortageAccCode) { }
            column(SurplusAcc; SurplusAccCode) { }

            // SUMMARY BALANCES
            column(BalBroughtForward; BalBroughtForwardAmt) { }
            column(TotalReceipts; TotalReceiptsAmt) { }
            column(TotalPayments; TotalPaymentsAmt) { }
            column(BalCarriedDown; BalCarriedDownAmt) { }
            column(SystemCashAtHand; SystemCashAtHandAmt) { }
            column(ActualCashAtHand; ActualCashAtHandAmt) { }
            column(Difference; DifferenceAmt) { }
            column(AccuracyLevel; AccuracyLevelTxt) { }

            // DETAILED RECEIPTS
            column(CashDepositAmt; CashDepositAmt) { }
            column(MPesaCashDepositAmt; MPesaCashDepositAmt) { }
            column(ReceiveFromTreasuryAmt; ReceiveFromTreasuryAmt) { }
            column(SpecialReceiptAmt; SpecialReceiptAmt) { }
            column(JournalVoucherReceiptsAmt; JournalVoucherReceiptsAmt) { }
            column(GrandTotalReceiptsAmt; GrandTotalReceiptsAmt) { }

            // DETAILED PAYMENTS
            column(CashWithdrawalAmt; CashWithdrawalAmt) { }
            column(MPesaCashWithdrawAmt; MPesaCashWithdrawAmt) { }
            column(TotalVoucherPaymentsAmt; TotalVoucherPaymentsAmt) { } // Replaced PettyCash
            column(JournalVoucherPaymentsAmt; JournalVoucherPaymentsAmt) { }
            column(ReturnToTreasuryAmt; ReturnToTreasuryAmt) { }
            column(EndOfDayAmt; EndOfDayAmt) { }
            column(GrandTotalPaymentsAmt; GrandTotalPaymentsAmt) { }

            dataitem(Coinage; Coinage)
            {
                DataItemLink = No = field(No);
                column(DenomCode; Value) { } // Reused DenomCode to pass the Value field to RDLC
                column(DenomCount; Quantity) { }
                column(DenomAmount; "Total Amount") { }
                trigger OnAfterGetRecord()
                begin
                    if Quantity = 0 then
                        CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord()
            var
                Matched: Boolean;
                IsReceipt: Boolean;
                AbsAmt: Decimal;
            begin
                ActualCashAtHandAmt := 0;
                CoinageRec.Reset();
                CoinageRec.SetRange(No, No);
                if CoinageRec.FindSet() then begin
                    repeat
                        ActualCashAtHandAmt += CoinageRec."Total Amount";
                    until CoinageRec.Next() = 0;
                end;

                if BankingUserTemp.Get("From Account") then begin
                    ShortageAccCode := BankingUserTemp."Shortage Account";
                    SurplusAccCode := BankingUserTemp."Excess Account";
                end;

                if Posted then
                    EODPostedStatusTxt := 'YES'
                else
                    EODPostedStatusTxt := 'NO';

                // Initialize all Amounts to Zero
                ClearAllAmounts();

                FilterDate := TreasuryTrans."Date Posted";

                // 1. CALCULATE BALANCE BROUGHT FORWARD
                BankLedgEntry.Reset();
                BankLedgEntry.SetRange("Bank Account No.", "From Bank");
                BankLedgEntry.SetFilter("Posting Date", '<%1', FilterDate);
                BankLedgEntry.CalcSums("Amount (LCY)");
                BalBroughtForwardAmt := BankLedgEntry."Amount (LCY)";

                // 2. LOOP TODAY'S BANK ACCOUNT LEDGER ENTRIES
                BankLedgEntry.Reset();
                BankLedgEntry.SetRange("Bank Account No.", "From Bank");
                BankLedgEntry.SetRange("Posting Date", FilterDate);
                if BankLedgEntry.FindSet() then begin
                    repeat
                        // IGNORING REVERSED TRANSACTIONS NATIVELY
                        if not BankLedgEntry.Reversed then begin

                            AbsAmt := Abs(BankLedgEntry."Amount (LCY)");
                            IsReceipt := BankLedgEntry."Amount (LCY)" > 0;
                            Matched := false;

                            // A. Check Cashier Transactions
                            if CashierTrans.Get(BankLedgEntry."Document No.") then begin
                                Matched := true;
                                case CashierTrans.Type of
                                    CashierTrans.Type::"Cash Deposit":
                                        CashDepositAmt += AbsAmt;
                                    CashierTrans.Type::"MPESA Deposit":
                                        MPesaCashDepositAmt += AbsAmt;
                                    CashierTrans.Type::"Cash Withdrawal":
                                        CashWithdrawalAmt += AbsAmt;
                                    CashierTrans.Type::"MPESA Withdrawal":
                                        MPesaCashWithdrawAmt += AbsAmt;
                                    CashierTrans.Type::"Credit Receipt":
                                        SpecialReceiptAmt += AbsAmt;
                                    else begin
                                        if IsReceipt then
                                            SpecialReceiptAmt += AbsAmt
                                        else
                                            JournalVoucherPaymentsAmt += AbsAmt;
                                    end;
                                end;
                            end

                            // B. Check Payment Vouchers (All PVs)
                            else if PaymentsHeader.Get(BankLedgEntry."Document No.") then begin
                                Matched := true;
                                TotalVoucherPaymentsAmt += AbsAmt;
                            end

                            // C. Check Treasury Transactions
                            else if TreasuryTransLog.Get(BankLedgEntry."Document No.") then begin
                                Matched := true;
                                if TreasuryTransLog."Transaction Type" = TreasuryTransLog."Transaction Type"::"Issue To Teller" then
                                    ReceiveFromTreasuryAmt += AbsAmt
                                else if TreasuryTransLog."Transaction Type" = TreasuryTransLog."Transaction Type"::"Return To Treasury" then
                                    ReturnToTreasuryAmt += AbsAmt
                                else if TreasuryTransLog."Transaction Type" = TreasuryTransLog."Transaction Type"::"End of Day Return to Treasury" then
                                    EndOfDayAmt += AbsAmt
                                else begin
                                    if IsReceipt then
                                        ReceiveFromTreasuryAmt += AbsAmt
                                    else
                                        ReturnToTreasuryAmt += AbsAmt;
                                end;
                            end;

                            // D. If no match, treat as generic Journal Voucher entry
                            if not Matched then begin
                                if IsReceipt then
                                    JournalVoucherReceiptsAmt += AbsAmt
                                else
                                    JournalVoucherPaymentsAmt += AbsAmt;
                            end;
                        end;
                    until BankLedgEntry.Next() = 0;
                end;

                // 3. AGGREGATE TOTALS (FIXED DOUBLE COUNTING HERE)
                TotalReceiptsAmt := CashDepositAmt + MPesaCashDepositAmt + ReceiveFromTreasuryAmt + SpecialReceiptAmt + JournalVoucherReceiptsAmt;
                GrandTotalReceiptsAmt := TotalReceiptsAmt + BalBroughtForwardAmt;

                TotalPaymentsAmt := CashWithdrawalAmt + MPesaCashWithdrawAmt + TotalVoucherPaymentsAmt + ReturnToTreasuryAmt + JournalVoucherPaymentsAmt;
                GrandTotalPaymentsAmt := TotalPaymentsAmt + EndOfDayAmt;

                // 4. CALCULATE EXPECTED CASH & DIFFERENCES
                SystemCashAtHandAmt := BalBroughtForwardAmt + TotalReceiptsAmt - TotalPaymentsAmt;
                DifferenceAmt := ActualCashAtHandAmt - SystemCashAtHandAmt;

                if SystemCashAtHandAmt <> 0 then begin
                    if DifferenceAmt = 0 then
                        AccuracyLevelTxt := '100%'
                    else
                        AccuracyLevelTxt := Format(Round(((ActualCashAtHandAmt / SystemCashAtHandAmt) * 100), 0.01)) + '%';
                end else
                    AccuracyLevelTxt := '100%';

                BalCarriedDownAmt := SystemCashAtHandAmt - EndOfDayAmt;
                BalCarriedDownAmt := abs(Round(BalCarriedDownAmt, 0.01));
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        CompanyInfo: Record "Company Information";
        BankingUserTemp: Record "Banking User Template";
        BankLedgEntry: Record "Bank Account Ledger Entry";
        CashierTrans: Record "Cashier Transactions";
        TreasuryTransLog: Record "Treasury Cashier Transactions";
        PaymentsHeader: Record "Payments Header";
        CoinageRec: Record Coinage;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";

        ActualCashAtHandAmt: Decimal;
        SystemCashAtHandAmt: Decimal;
        EODPostedStatusTxt: Text[10];
        ShortageAccCode: Code[20];
        SurplusAccCode: Code[20];
        DifferenceAmt: Decimal;
        AccuracyLevelTxt: Text[20];
        BalBroughtForwardAmt: Decimal;
        BalCarriedDownAmt: Decimal;
        TotalReceiptsAmt: Decimal;
        TotalPaymentsAmt: Decimal;
        CashDepositAmt: Decimal;
        MPesaCashDepositAmt: Decimal;
        ReceiveFromTreasuryAmt: Decimal;
        SpecialReceiptAmt: Decimal;
        JournalVoucherReceiptsAmt: Decimal;
        GrandTotalReceiptsAmt: Decimal;
        CashWithdrawalAmt: Decimal;
        EndOfDayAmt: Decimal;
        MPesaCashWithdrawAmt: Decimal;
        TotalVoucherPaymentsAmt: Decimal;
        ReturnToTreasuryAmt: Decimal;
        JournalVoucherPaymentsAmt: Decimal;
        GrandTotalPaymentsAmt: Decimal;
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
        FilterDate: Date;

    procedure ClearAllAmounts()
    begin
        BalBroughtForwardAmt := 0;
        TotalReceiptsAmt := 0;
        TotalPaymentsAmt := 0;
        CashDepositAmt := 0;
        MPesaCashDepositAmt := 0;
        ReceiveFromTreasuryAmt := 0;
        SpecialReceiptAmt := 0;
        JournalVoucherReceiptsAmt := 0;
        GrandTotalReceiptsAmt := 0;

        CashWithdrawalAmt := 0;
        EndOfDayAmt := 0;
        MPesaCashWithdrawAmt := 0;
        TotalVoucherPaymentsAmt := 0;
        ReturnToTreasuryAmt := 0;
        JournalVoucherPaymentsAmt := 0;
        GrandTotalPaymentsAmt := 0;

        SystemCashAtHandAmt := 0;
        BalCarriedDownAmt := 0;
    end;
}