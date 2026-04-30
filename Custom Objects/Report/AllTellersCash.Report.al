// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185439 "All Tellers Cash Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/AllTellersCashReport.rdl';

//     dataset
//     {
//         dataitem(Treasury_transaction; "Treasury Cashier Transactions")
//         {
//             RequestFilterFields = "Transaction Date", "Global Dimension 1 Code", "From Account";

//             column(CompanyName; CompanyInformation.Name) { }
//             column(CompanyAddress; CompanyAddress) { }
//             column(ReportDateParam; DateFilterText) { }
//             column(PrintDateTime; CURRENTDATETIME) { }

//             // RECEIPTS SUMMARY
//             column(TotalCashDeposit; TotalCashDeposit) { }
//             column(TotalJournalVoucherReceipts; TotalJournalVoucherReceipts) { }
//             column(TotalMPesaCashDeposit; TotalMPesaCashDeposit) { }
//             column(TotalReceiveFromTreasury; TotalReceiveFromTreasury) { }
//             column(TotalSpecialReceipt; TotalSpecialReceipt) { }
//             column(GrandTotalReceipts; GrandTotalReceipts) { }

//             // PAYMENTS SUMMARY
//             column(TotalCashWithdrawal; TotalCashWithdrawal) { }
//             column(TotalEndOfDay; TotalEndOfDay) { }
//             column(TotalJournalVoucherPayments; TotalJournalVoucherPayments) { }
//             column(TotalMPesaCashWithdrawal; TotalMPesaCashWithdrawal) { }
//             column(GrandTotalPayments; GrandTotalPayments) { }

//             // BALANCES (DUMMY VALUES BASED ON YOUR IMAGE)
//             column(TellersOpeningBalances; 0.00) { }
//             column(TellersClosingBalances; 0.00) { }
//             column(TreasuryOpeningBalance; 25192336.00) { }
//             column(TreasuryClosingBalance; 24142204.00) { }

//             column(ReportProducedBy; ReportProducedBy) { }
//             column(AmountInWords; AmountInWords[1]) { }

//             trigger OnPreDataItem()
//             begin
//                 DateFilterText := GETFILTER("Transaction Date");

                
//                 TreasuryCashierTransFilter.COPYFILTERS(Treasury_transaction);
//                 IF TreasuryCashierTransFilter.FINDSET THEN BEGIN
//                     REPEAT
                        
//                         IF (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'DEPOSIT') > 0) AND (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'MPESA') = 0) THEN
//                             TotalCashDeposit += TreasuryCashierTransFilter.Amount
//                         ELSE IF (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'JOURNAL VOUCHER') > 0) AND (TreasuryCashierTransFilter."Transaction Type" IN[TreasuryCashierTransFilter."Transaction Type"::"Issue From Treasury Control", TreasuryCashierTransFilter."Transaction Type"::"Return To Bank"]) THEN
//                             TotalJournalVoucherReceipts += TreasuryCashierTransFilter.Amount
//                         ELSE IF STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'MPESA CASH DEPOSIT') > 0 THEN
//                             TotalMPesaCashDeposit += TreasuryCashierTransFilter.Amount
//                         ELSE IF TreasuryCashierTransFilter."Transaction Type" = TreasuryCashierTransFilter."Transaction Type"::"Issue From Treasury Control" THEN
//                             TotalReceiveFromTreasury += TreasuryCashierTransFilter.Amount
//                         ELSE IF STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'SPECIAL RECEIPT') > 0 THEN
//                             TotalSpecialReceipt += TreasuryCashierTransFilter.Amount

//                         // CATEGORIZE PAYMENTS
//                         ELSE IF (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'WITHDRAW') > 0) AND (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'MPESA') = 0) THEN
//                             TotalCashWithdrawal += TreasuryCashierTransFilter.Amount
//                         ELSE IF TreasuryCashierTransFilter."Transaction Type" = TreasuryCashierTransFilter."Transaction Type"::"End of Day Return to Treasury" THEN
//                             TotalEndOfDay += TreasuryCashierTransFilter.Amount
//                         ELSE IF (STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'JOURNAL VOUCHER') > 0) THEN
//                             TotalJournalVoucherPayments += TreasuryCashierTransFilter.Amount
//                         ELSE IF STRPOS(UPPERCASE(TreasuryCashierTransFilter.Description), 'MPESA CASH WITHDRAW') > 0 THEN
//                             TotalMPesaCashWithdrawal += TreasuryCashierTransFilter.Amount;

//                     UNTIL TreasuryCashierTransFilter.NEXT = 0;
//                 END;

//                 GrandTotalReceipts := TotalCashDeposit + TotalJournalVoucherReceipts + TotalMPesaCashDeposit + TotalReceiveFromTreasury + TotalSpecialReceipt;
//                 GrandTotalPayments := TotalCashWithdrawal + TotalEndOfDay + TotalJournalVoucherPayments + TotalMPesaCashWithdrawal;

                
//                 AmountInWords[1] := ConvertAmountToWords(GrandTotalReceipts);

//                 // FETCH SIGNATURE NAME
//                 USER.RESET;
//                 USER.SETRANGE("User Name", USERID);
//                 IF USER.FINDFIRST THEN
//                     ReportProducedBy := USER."Full Name"
//                 ELSE
//                     ReportProducedBy := USERID;
//             end;
//         }

//         dataitem(CoinageSummary; "Integer")
//         {
//             DataItemTableView = sorting(Number);

//             column(DenomRecordNumber; Number) { }
//             column(DenomCode; TempCoinage.Code) { }
//             column(DenomCount; TempCoinage.Quantity) { }
//             column(DenomTotalAmount; TempCoinage."Total Amount") { }

//             trigger OnPreDataItem()
//             begin
                
//                 TempCoinage.RESET;
//                 TempCoinage.DELETEALL;

//                 TreasuryCashierTransFilter.COPYFILTERS(Treasury_transaction);
//                 IF TreasuryCashierTransFilter.FINDSET THEN BEGIN
//                     REPEAT
//                         CoinageRec.RESET;
//                         CoinageRec.SETRANGE(No, TreasuryCashierTransFilter.No);
//                         IF CoinageRec.FINDSET THEN BEGIN
//                             REPEAT
//                                 TempCoinage.RESET;
//                                 TempCoinage.SETRANGE(Code, CoinageRec.Code);
//                                 IF TempCoinage.FINDFIRST THEN BEGIN
//                                     TempCoinage.Quantity += CoinageRec.Quantity;
//                                     TempCoinage."Total Amount" += CoinageRec."Total Amount";
//                                     TempCoinage.MODIFY;
//                                 END ELSE BEGIN
//                                     TempCoinage.INIT;
//                                     TempCoinage.Code := CoinageRec.Code;
//                                     TempCoinage.Quantity := CoinageRec.Quantity;
//                                     TempCoinage."Total Amount" := CoinageRec."Total Amount";
//                                     TempCoinage.INSERT;
//                                 END;
//                             UNTIL CoinageRec.NEXT = 0;
//                         END;
//                     UNTIL TreasuryCashierTransFilter.NEXT = 0;
//                 END;

//                 TempCoinage.RESET;
//                 SETRANGE(Number, 1, TempCoinage.COUNT);
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 IF Number = 1 THEN
//                     TempCoinage.FINDFIRST
//                 ELSE
//                     TempCoinage.NEXT;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout { }
//         actions { }
//     }

//     trigger OnPreReport()
//     begin
//         CompanyInformation.GET;
//         CompanyInformation.CALCFIELDS(Picture);
//         CompanyAddress := CompanyInformation.Address + ' - Post Code: ' + CompanyInformation."Post Code" + ' - City: ' + CompanyInformation.City;
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         USER: Record User;
//         ReportProducedBy: Text[50];
//         DateFilterText: Text;
//         TreasuryCashierTransFilter: Record "Treasury Cashier Transactions";
//         CoinageRec: Record Coinage;
//         TempCoinage: Record Coinage temporary;

//         TotalCashDeposit: Decimal;
//         TotalJournalVoucherReceipts: Decimal;
//         TotalMPesaCashDeposit: Decimal;
//         TotalReceiveFromTreasury: Decimal;
//         TotalSpecialReceipt: Decimal;
//         GrandTotalReceipts: Decimal;

//         TotalCashWithdrawal: Decimal;
//         TotalEndOfDay: Decimal;
//         TotalJournalVoucherPayments: Decimal;
//         TotalMPesaCashWithdrawal: Decimal;
//         GrandTotalPayments: Decimal;
        
//         AmountInWords: array[2] of Text;
//         OnesText: array[20] of Text[30];
//         TensText: array[10] of Text[30];

//     local procedure InitTextVariable()
//     begin
//         OnesText[1] := 'One'; OnesText[2] := 'Two'; OnesText[3] := 'Three'; OnesText[4] := 'Four';
//         OnesText[5] := 'Five'; OnesText[6] := 'Six'; OnesText[7] := 'Seven'; OnesText[8] := 'Eight';
//         OnesText[9] := 'Nine'; OnesText[10] := 'Ten'; OnesText[11] := 'Eleven'; OnesText[12] := 'Twelve';
//         OnesText[13] := 'Thirteen'; OnesText[14] := 'Fourteen'; OnesText[15] := 'Fifteen'; OnesText[16] := 'Sixteen';
//         OnesText[17] := 'Seventeen'; OnesText[18] := 'Eighteen'; OnesText[19] := 'Nineteen';
//         TensText[1] := ''; TensText[2] := 'Twenty'; TensText[3] := 'Thirty'; TensText[4] := 'Forty';
//         TensText[5] := 'Fifty'; TensText[6] := 'Sixty'; TensText[7] := 'Seventy'; TensText[8] := 'Eighty';
//         TensText[9] := 'Ninety';
//     end;

//     local procedure ConvertAmountToWords(AmountToConvert: Decimal): Text
//     var
//         WholeAmount: Decimal;
//         CentsAmount: Decimal;
//         Words: Text;
//         CentsWords: Text;
//     begin
//         if AmountToConvert = 0 then exit('Zero');
//         WholeAmount := Round(AmountToConvert, 1, '<');
//         CentsAmount := Round((AmountToConvert - WholeAmount) * 100, 1, '=');
//         InitTextVariable();
//         Words := ConvertNumberToText(WholeAmount);
//         if CentsAmount > 0 then begin
//             CentsWords := ConvertNumberToText(CentsAmount);
//             exit(Words + ' And ' + CentsWords + ' Cents Only');
//         end;
//         exit(Words + ' Only');
//     end;

//     local procedure ConvertNumberToText(Number: Decimal): Text
//     var
//         ResultText: Text;
//         Millions: Integer;
//         Thousands: Integer;
//         Hundreds: Integer;
//         TensAndOnes: Integer;
//     begin
//         if Number = 0 then exit('');
//         Millions := Round(Number / 1000000, 1, '<');
//         Number := Number - (Millions * 1000000);
//         Thousands := Round(Number / 1000, 1, '<');
//         Number := Number - (Thousands * 1000);
//         Hundreds := Round(Number / 100, 1, '<');
//         TensAndOnes := Round(Number - (Hundreds * 100), 1, '<');
//         ResultText := '';
//         if Millions > 0 then ResultText += ConvertHundreds(Millions) + ' Million ';
//         if Thousands > 0 then ResultText += ConvertHundreds(Thousands) + ' Thousand ';
//         if Hundreds > 0 then ResultText += ConvertHundreds(Hundreds) + ' Hundred ';
//         if TensAndOnes > 0 then begin
//             if ResultText <> '' then ResultText += 'and ';
//             ResultText += ConvertTens(TensAndOnes);
//         end;
//         exit(DelChr(ResultText, '>', ' '));
//     end;

//     local procedure ConvertHundreds(Number: Integer): Text
//     var
//         Hundreds: Integer;
//         TensAndOnes: Integer;
//         ResultText: Text;
//     begin
//         Hundreds := Number div 100;
//         TensAndOnes := Number mod 100;
//         if Hundreds > 0 then begin
//             ResultText := OnesText[Hundreds] + ' Hundred';
//             if TensAndOnes > 0 then ResultText += ' and ' + ConvertTens(TensAndOnes);
//             exit(ResultText);
//         end else exit(ConvertTens(TensAndOnes));
//     end;

//     local procedure ConvertTens(Number: Integer): Text
//     begin
//         if Number = 0 then exit('');
//         if Number < 20 then exit(OnesText[Number]);
//         if (Number mod 10) = 0 then exit(TensText[Number div 10])
//         else exit(TensText[Number div 10] + ' ' + OnesText[Number mod 10]);
//     end;
// }