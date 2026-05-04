#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185439 "All Tellers Cash Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/AllTellersCashReport.rdl';

    dataset
    {
        dataitem(Treasury_transaction; "Treasury Cashier Transactions")
        {
            RequestFilterFields = "Transaction Date";

            // COMPANY INFO
            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy_Header; PrintedBy) { }

            // REPORT META DATA
            column(DateFilterTxt; DateFilterTxt) { }

            // RECEIPTS SUMMARY
            column(CashDepositAmt; CashDepositAmt) { }
            column(JournalVoucherReceiptsAmt; JournalVoucherReceiptsAmt) { }
            column(MPesaCashDepositAmt; MPesaCashDepositAmt) { }
            column(ReceiveFromTreasuryAmt; ReceiveFromTreasuryAmt) { }
            column(SpecialReceiptAmt; SpecialReceiptAmt) { }
            column(GrandTotalReceiptsAmt; GrandTotalReceiptsAmt) { }

            // PAYMENTS SUMMARY
            column(CashWithdrawalAmt; CashWithdrawalAmt) { }
            column(EndOfDayAmt; EndOfDayAmt) { }
            column(JournalVoucherPaymentsAmt; JournalVoucherPaymentsAmt) { }
            column(MPesaCashWithdrawAmt; MPesaCashWithdrawAmt) { }
            column(GrandTotalPaymentsAmt; GrandTotalPaymentsAmt) { }

            // BALANCES
            column(TellersOpeningBalancesAmt; TellersOpeningBalancesAmt) { }
            column(TellersClosingBalancesAmt; TellersClosingBalancesAmt) { }
            column(TreasuryOpeningBalanceAmt; TreasuryOpeningBalanceAmt) { }
            column(TreasuryClosingBalanceAmt; TreasuryClosingBalanceAmt) { }

            // AMOUNT IN WORDS
            column(AmountInWords; AmountInWords[1]) { }

            trigger OnPreDataItem()
            begin
                // GET DATE FILTER
                if Treasury_transaction.GetFilter("Transaction Date") = '' then
                    Treasury_transaction.SetRange("Transaction Date", Today);
                DateFilterTxt := Treasury_transaction.GetFilter("Transaction Date");

                // INITIALIZE TOTALS
                CashDepositAmt := 0;
                JournalVoucherReceiptsAmt := 0;
                MPesaCashDepositAmt := 0;
                ReceiveFromTreasuryAmt := 0;
                SpecialReceiptAmt := 0;
                CashWithdrawalAmt := 0;
                EndOfDayAmt := 0;
                JournalVoucherPaymentsAmt := 0;
                MPesaCashWithdrawAmt := 0;

                // AGGREGATE CASHIER TRANSACTIONS FOR RECEIPTS AND PAYMENTS
                CashierTrans.Reset();
                CashierTrans.SetFilter("Transaction Date", DateFilterTxt);
                CashierTrans.SetRange(Posted, true);
                if CashierTrans.FindSet() then begin
                    repeat
                        // RECEIPTS
                        if CashierTrans.Type = CashierTrans.Type::"Cash Deposit" then
                            CashDepositAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"MPESA Deposit" then
                            MPesaCashDepositAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"Credit Receipt" then
                            SpecialReceiptAmt += CashierTrans.Amount
                        else if (StrPos(UpperCase(CashierTrans."Transaction Description"), 'JOURNAL') > 0) and (CashierTrans.Type = CashierTrans.Type::"Credit Receipt") then
                            JournalVoucherReceiptsAmt += CashierTrans.Amount

                        // PAYMENTS
                        else if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then
                            CashWithdrawalAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal" then
                            MPesaCashWithdrawAmt += CashierTrans.Amount
                        else if (StrPos(UpperCase(CashierTrans."Transaction Description"), 'JOURNAL') > 0) and (CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal") then
                            JournalVoucherPaymentsAmt += CashierTrans.Amount;
                    until CashierTrans.Next() = 0;
                end;

                // AGGREGATE TREASURY TRANSACTIONS FOR ISSUES AND EOD
                TreasuryTransIn.Reset();
                TreasuryTransIn.SetFilter("Transaction Date", DateFilterTxt);
                TreasuryTransIn.SetRange(Posted, true);
                if TreasuryTransIn.FindSet() then begin
                    repeat
                        if TreasuryTransIn."Transaction Type" = TreasuryTransIn."Transaction Type"::"Issue To Teller" then
                            ReceiveFromTreasuryAmt += TreasuryTransIn.Amount
                        else if TreasuryTransIn."Transaction Type" = TreasuryTransIn."Transaction Type"::"End of Day Return to Treasury" then
                            EndOfDayAmt += TreasuryTransIn.Amount;
                    until TreasuryTransIn.Next() = 0;
                end;

                // CALCULATE GRAND TOTALS
                GrandTotalReceiptsAmt := CashDepositAmt + JournalVoucherReceiptsAmt + MPesaCashDepositAmt + ReceiveFromTreasuryAmt + SpecialReceiptAmt;
                GrandTotalPaymentsAmt := CashWithdrawalAmt + EndOfDayAmt + JournalVoucherPaymentsAmt + MPesaCashWithdrawAmt;

                // DUMMY BALANCES FOR DEMONSTRATION BASED ON YOUR IMAGE
                TellersOpeningBalancesAmt := 0.00;
                TellersClosingBalancesAmt := 0.00;
                TreasuryOpeningBalanceAmt := 25192336.00;
                TreasuryClosingBalanceAmt := 24142204.00;

                // CALCULATE AMOUNT IN WORDS FOR RECEIPTS
                AmountInWords[1] := ConvertAmountToWords(GrandTotalReceiptsAmt);
            end;

            trigger OnAfterGetRecord()
            begin
                // PREVENT MULTIPLE PRINTING PAGES BY BREAKING AFTER FIRST RECORD
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
                // PREPARE TEMPORARY COINAGE AGGREGATION
                TempCoinage.Reset();
                TempCoinage.DeleteAll();

                TreasuryTransIn.Reset();
                TreasuryTransIn.SetFilter("Transaction Date", DateFilterTxt);
                TreasuryTransIn.SetRange(Posted, true);
                if TreasuryTransIn.FindSet() then begin
                    repeat
                        CoinageRec.Reset();
                        CoinageRec.SetRange(No, TreasuryTransIn.No);
                        if CoinageRec.FindSet() then begin
                            repeat
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
                            until CoinageRec.Next() = 0;
                        end;
                    until TreasuryTransIn.Next() = 0;
                end;

                TempCoinage.Reset();
                SetRange(Number, 1, TempCoinage.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                // LOOP THROUGH TEMPORARY COINAGE TABLE
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
        // HEADER GENERATION
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

        CashierTrans: Record "Cashier Transactions";
        TreasuryTransIn: Record "Treasury Cashier Transactions";
        CoinageRec: Record Coinage;
        TempCoinage: Record Coinage temporary;

        CashDepositAmt: Decimal;
        JournalVoucherReceiptsAmt: Decimal;
        MPesaCashDepositAmt: Decimal;
        ReceiveFromTreasuryAmt: Decimal;
        SpecialReceiptAmt: Decimal;
        GrandTotalReceiptsAmt: Decimal;

        CashWithdrawalAmt: Decimal;
        EndOfDayAmt: Decimal;
        JournalVoucherPaymentsAmt: Decimal;
        MPesaCashWithdrawAmt: Decimal;
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