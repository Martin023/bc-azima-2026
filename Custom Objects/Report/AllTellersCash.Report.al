#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185439 "All Tellers Cash Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/AllTellersCashReport.rdl';
    Caption = 'All Tellers Cash Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Treasury_transaction; "Treasury Cashier Transactions")
        {
            RequestFilterFields = "Date Posted";

            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(CompanyPicture; CompanyInformation.Picture) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy_Header; PrintedBy) { }

            column(DateFilterTxt; DateFilterTxt) { }

            // RECEIPTS
            column(CashDepositAmt; CashDepositAmt) { }
            column(JournalVoucherReceiptsAmt; JournalVoucherReceiptsAmt) { }
            column(MPesaCashDepositAmt; MPesaCashDepositAmt) { }
            column(ReceiveFromTreasuryAmt; ReceiveFromTreasuryAmt) { }
            column(SpecialReceiptAmt; SpecialReceiptAmt) { }
            column(GrandTotalReceiptsAmt; GrandTotalReceiptsAmt) { }

            // PAYMENTS
            column(CashWithdrawalAmt; CashWithdrawalAmt) { }
            column(EndOfDayAmt; EndOfDayAmt) { }
            column(ReturnToTreasuryAmt; ReturnToTreasuryAmt) { }
            column(JournalVoucherPaymentsAmt; JournalVoucherPaymentsAmt) { }
            column(MPesaCashWithdrawAmt; MPesaCashWithdrawAmt) { }
            column(TotalVoucherPaymentsAmt; TotalVoucherPaymentsAmt) { }
            column(GrandTotalPaymentsAmt; GrandTotalPaymentsAmt) { }

            // BALANCES
            column(TellersOpeningBalancesAmt; TellersOpeningBalancesAmt) { }
            column(TellersClosingBalancesAmt; TellersClosingBalancesAmt) { }
            column(TreasuryOpeningBalanceAmt; TreasuryOpeningBalanceAmt) { }
            column(TreasuryClosingBalanceAmt; TreasuryClosingBalanceAmt) { }

            column(AmountInWords; AmountInWords[1]) { }

            trigger OnPreDataItem()
            var
                Matched: Boolean;
                IsReceipt: Boolean;
                AbsAmt: Decimal;
            begin
                if Treasury_transaction.GetFilter("Date Posted") = '' then
                    Treasury_transaction.SetRange("Date Posted", Today);

                DateFilterTxt := Treasury_transaction.GetFilter("Date Posted");
                MinFilterDate := Treasury_transaction.GetRangeMin("Date Posted");
                MaxFilterDate := Treasury_transaction.GetRangeMax("Date Posted");

                // Initialize variables
                CashDepositAmt := 0;
                JournalVoucherReceiptsAmt := 0;
                MPesaCashDepositAmt := 0;
                ReceiveFromTreasuryAmt := 0;
                SpecialReceiptAmt := 0;
                CashWithdrawalAmt := 0;
                EndOfDayAmt := 0;
                ReturnToTreasuryAmt := 0;
                JournalVoucherPaymentsAmt := 0;
                MPesaCashWithdrawAmt := 0;
                TotalVoucherPaymentsAmt := 0;
                TellersOpeningBalancesAmt := 0;
                TellersClosingBalancesAmt := 0;
                TreasuryOpeningBalanceAmt := 0;
                TreasuryClosingBalanceAmt := 0;

                BankAcc.Reset();
                BankAcc.SetRange("Bank Type", BankAcc."Bank Type"::Cashier);
                if BankAcc.FindSet() then begin
                    repeat
                        // A. Tellers' Opening Balance
                        BankLedgEntry.Reset();
                        BankLedgEntry.SetRange("Bank Account No.", BankAcc."No.");
                        BankLedgEntry.SetFilter("Posting Date", '<%1', MinFilterDate);
                        BankLedgEntry.CalcSums("Amount (LCY)");
                        TellersOpeningBalancesAmt += BankLedgEntry."Amount (LCY)";

                        // B. Tellers' Closing Balance
                        BankLedgEntry.Reset();
                        BankLedgEntry.SetRange("Bank Account No.", BankAcc."No.");
                        BankLedgEntry.SetFilter("Posting Date", '<=%1', MaxFilterDate);
                        BankLedgEntry.CalcSums("Amount (LCY)");
                        TellersClosingBalancesAmt += BankLedgEntry."Amount (LCY)";

                        // C. Loop Tellers' Transactions for the filtered period
                        BankLedgEntry.Reset();
                        BankLedgEntry.SetRange("Bank Account No.", BankAcc."No.");
                        BankLedgEntry.SetFilter("Posting Date", DateFilterTxt);
                        if BankLedgEntry.FindSet() then begin
                            repeat
                                // IGNORING REVERSED TRANSACTIONS
                                if not BankLedgEntry.Reversed then begin

                                    AbsAmt := Abs(BankLedgEntry."Amount (LCY)");
                                    IsReceipt := BankLedgEntry."Amount (LCY)" > 0;
                                    Matched := false;

                                    // Check Cashier Transactions
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

                                    // Check Payment Vouchers (All PVs)
                                    else if PaymentsHeader.Get(BankLedgEntry."Document No.") then begin
                                        Matched := true;
                                        TotalVoucherPaymentsAmt += AbsAmt;
                                    end

                                    // Check Treasury Transactions
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

                                    // If no match, treat as generic Journal Voucher entry
                                    if not Matched then begin
                                        if IsReceipt then
                                            JournalVoucherReceiptsAmt += AbsAmt
                                        else
                                            JournalVoucherPaymentsAmt += AbsAmt;
                                    end;
                                end;
                            until BankLedgEntry.Next() = 0;
                        end;
                    until BankAcc.Next() = 0;
                end;
                BankAcc.Reset();
                BankAcc.SetRange("Bank Type", BankAcc."Bank Type"::Treasury);
                if BankAcc.FindSet() then begin
                    repeat
                        // A. Treasury Opening Balance
                        BankLedgEntry.Reset();
                        BankLedgEntry.SetRange("Bank Account No.", BankAcc."No.");
                        BankLedgEntry.SetFilter("Posting Date", '<%1', MinFilterDate);
                        BankLedgEntry.CalcSums("Amount (LCY)");
                        TreasuryOpeningBalanceAmt += BankLedgEntry."Amount (LCY)";

                        // B. Treasury Closing Balance
                        BankLedgEntry.Reset();
                        BankLedgEntry.SetRange("Bank Account No.", BankAcc."No.");
                        BankLedgEntry.SetFilter("Posting Date", '<=%1', MaxFilterDate);
                        BankLedgEntry.CalcSums("Amount (LCY)");
                        TreasuryClosingBalanceAmt += BankLedgEntry."Amount (LCY)";
                    until BankAcc.Next() = 0;
                end;
                GrandTotalReceiptsAmt := CashDepositAmt + JournalVoucherReceiptsAmt + MPesaCashDepositAmt + ReceiveFromTreasuryAmt + SpecialReceiptAmt;
                GrandTotalPaymentsAmt := CashWithdrawalAmt + EndOfDayAmt + ReturnToTreasuryAmt + JournalVoucherPaymentsAmt + MPesaCashWithdrawAmt + TotalVoucherPaymentsAmt;

                AmountInWords[1] := ConvertAmountToWords(GrandTotalReceiptsAmt);
            end;

            trigger OnAfterGetRecord()
            begin
                if HasPrinted then
                    CurrReport.Break();
                HasPrinted := true;
            end;
        }

        dataitem(CoinageSummary; "Integer")
        {
            DataItemTableView = sorting(Number);

            column(DenomRecordNumber; Number) { }
            column(DenomCode; TempCoinage.Code) { }
            column(DenomCount; TempCoinage.Quantity) { }
            column(DenomAmount; TempCoinage."Total Amount") { }

            trigger OnPreDataItem()
            begin
                TempCoinage.Reset();
                TempCoinage.DeleteAll();

                TreasuryTransLog.Reset();
                TreasuryTransLog.SetFilter("Date Posted", DateFilterTxt);
                TreasuryTransLog.SetRange(Posted, true);
                if TreasuryTransLog.FindSet() then begin
                    repeat
                        CoinageRec.Reset();
                        CoinageRec.SetRange(No, TreasuryTransLog.No);
                        if CoinageRec.FindSet() then begin
                            repeat
                                // ONLY WRITE IF DENOMINATION > 0
                                if CoinageRec.Quantity > 0 then begin
                                    TempCoinage.Reset();
                                    TempCoinage.SetRange(Code, CoinageRec.Code);
                                    if TempCoinage.FindFirst() then begin
                                        TempCoinage.Quantity += CoinageRec.Quantity;
                                        TempCoinage."Total Amount" += CoinageRec."Total Amount";
                                        TempCoinage.Modify();
                                    end else begin
                                        TempCoinage.Init();
                                        TempCoinage.Code := CoinageRec.Code;
                                        TempCoinage.Quantity := CoinageRec.Quantity;
                                        TempCoinage."Total Amount" := CoinageRec."Total Amount";
                                        TempCoinage.Insert();
                                    end;
                                end;
                            until CoinageRec.Next() = 0;
                        end;
                    until TreasuryTransLog.Next() = 0;
                end;

                TempCoinage.Reset();
                SetRange(Number, 1, TempCoinage.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    TempCoinage.FindFirst()
                else
                    TempCoinage.Next();
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
        CompanyAddress := CompanyInformation.Address + ' - P.O BOX ' + CompanyInformation."Post Code" + ' - ' + CompanyInformation.City;
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";

        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time);
        PrintedBy := UserId;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;

        DateFilterTxt: Text;
        HasPrinted: Boolean;

        BankLedgEntry: Record "Bank Account Ledger Entry";
        CashierTrans: Record "Cashier Transactions";
        TreasuryTransLog: Record "Treasury Cashier Transactions";
        PaymentsHeader: Record "Payments Header";
        BankAcc: Record "Bank Account";
        CoinageRec: Record Coinage;
        TempCoinage: Record Coinage temporary;
        MinFilterDate: Date;
        MaxFilterDate: Date;

        CashDepositAmt: Decimal;
        JournalVoucherReceiptsAmt: Decimal;
        MPesaCashDepositAmt: Decimal;
        ReceiveFromTreasuryAmt: Decimal;
        SpecialReceiptAmt: Decimal;
        GrandTotalReceiptsAmt: Decimal;

        CashWithdrawalAmt: Decimal;
        EndOfDayAmt: Decimal;
        ReturnToTreasuryAmt: Decimal;
        JournalVoucherPaymentsAmt: Decimal;
        MPesaCashWithdrawAmt: Decimal;
        TotalVoucherPaymentsAmt: Decimal;
        GrandTotalPaymentsAmt: Decimal;

        TellersOpeningBalancesAmt: Decimal;
        TellersClosingBalancesAmt: Decimal;
        TreasuryOpeningBalanceAmt: Decimal;
        TreasuryClosingBalanceAmt: Decimal;

        AmountInWords: array[2] of Text;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];

    local procedure InitTextVariable()
    begin
        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';
        TensText[1] := '';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Forty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';
    end;

    local procedure ConvertAmountToWords(AmountToConvert: Decimal): Text
    var
        WholeAmount: Decimal;
        CentsAmount: Decimal;
        Words: Text;
        CentsWords: Text;
    begin
        if AmountToConvert = 0 then exit('Zero');
        WholeAmount := Round(AmountToConvert, 1, '<');
        CentsAmount := Round((AmountToConvert - WholeAmount) * 100, 1, '=');
        InitTextVariable();
        Words := ConvertNumberToText(WholeAmount);
        if CentsAmount > 0 then begin
            CentsWords := ConvertNumberToText(CentsAmount);
            exit(Words + ' And ' + CentsWords + ' Cents Only');
        end;
        exit(Words + ' Only');
    end;

    local procedure ConvertNumberToText(Number: Decimal): Text
    var
        ResultText: Text;
        Millions: Integer;
        Thousands: Integer;
        Hundreds: Integer;
        TensAndOnes: Integer;
    begin
        if Number = 0 then exit('');
        Millions := Round(Number / 1000000, 1, '<');
        Number := Number - (Millions * 1000000);
        Thousands := Round(Number / 1000, 1, '<');
        Number := Number - (Thousands * 1000);
        Hundreds := Round(Number / 100, 1, '<');
        TensAndOnes := Round(Number - (Hundreds * 100), 1, '<');
        ResultText := '';
        if Millions > 0 then ResultText += ConvertHundreds(Millions) + ' Million ';
        if Thousands > 0 then ResultText += ConvertHundreds(Thousands) + ' Thousand ';
        if Hundreds > 0 then ResultText += ConvertHundreds(Hundreds) + ' Hundred ';
        if TensAndOnes > 0 then begin
            if ResultText <> '' then ResultText += 'and ';
            ResultText += ConvertTens(TensAndOnes);
        end;
        exit(DelChr(ResultText, '>', ' '));
    end;

    local procedure ConvertHundreds(Number: Integer): Text
    var
        Hundreds: Integer;
        TensAndOnes: Integer;
        ResultText: Text;
    begin
        Hundreds := Number div 100;
        TensAndOnes := Number mod 100;
        if Hundreds > 0 then begin
            ResultText := OnesText[Hundreds] + ' Hundred';
            if TensAndOnes > 0 then ResultText += ' and ' + ConvertTens(TensAndOnes);
            exit(ResultText);
        end else
            exit(ConvertTens(TensAndOnes));
    end;

    local procedure ConvertTens(Number: Integer): Text
    begin
        if Number = 0 then exit('');
        if Number < 20 then exit(OnesText[Number]);
        if (Number mod 10) = 0 then
            exit(TensText[Number div 10])
        else
            exit(TensText[Number div 10] + ' ' + OnesText[Number mod 10]);
    end;
}