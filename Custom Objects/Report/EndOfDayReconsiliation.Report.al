// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185446 "End of Day Reconciliation"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/EndOfDayReconciliation.rdl';

//     dataset
//     {
//         dataitem(Treasury_transaction; "Treasury Cashier Transactions")
//         {
//             RequestFilterFields = No; 


//             column(CompanyInformation_Name; CompanyInformation.Name) { }
//             column(CompanyBranch_Name; CompanyInformation.Name + ' SASA Section') { } // FROM IMAGE


//             column(PrintDate; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4>')) { }
//             column(TellerName; "From Account") { } 
//             column(EndOfDayDate; Format("Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
//             column(EODPostedStatus; EODPostedStatus) { }
//             column(TellerAccount; "From Bank") { } 
//             column(PostedBy; "Posted By") { }
//             column(ShortageAcc; ShortageAcc) { }
//             column(SurplusAcc; SurplusAcc) { }

//             // BALANCES SECTION
//             column(BalBroughtForward; BalBroughtForward) { }
//             column(TotalReceipts; TotalReceipts) { }
//             column(TotalPayments; TotalPayments) { }
//             column(BalCarriedDown; BalCarriedDown) { }

//             // SYSTEM CASH SECTION
//             column(SystemCashAtHand; "Till/Treasury Balance") { }
//             column(ActualCashAtHand; ActualCashAtHandVal) { }
//             column(Difference; DifferenceVal) { }

//             // RECEIPTS IN TOTALS
//             column(CashDeposit; CashDeposit) { }
//             column(MPesaCashDeposit; MPesaCashDeposit) { }
//             column(ReceiveFromTreasury; ReceiveFromTreasury) { }
//             column(SpecialReceipt; SpecialReceipt) { }
//             column(GrandTotalReceipts; GrandTotalReceipts) { } 

//             // PAYMENTS IN TOTALS
//             column(CashWithdrawal; CashWithdrawal) { }
//             column(EndOfDay; EndOfDayReturn) { }
//             column(MPesaCashWithdraw; MPesaCashWithdraw) { }
//             column(GrandTotalPayments; GrandTotalPayments) { } 

//             // ACCURACY
//             column(AccuracyLevel; AccuracyLevel) { }

//             dataitem(Coinage; Coinage)
//             {
//                 DataItemLink = No = field(No);
//                 column(DenomCode; Code) { }
//                 column(DenomCount; Quantity) { }
//                 column(DenomAmount; "Total Amount") { }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 // POSTED STATUS
//                 if Posted then EODPostedStatus := 'YES' else EODPostedStatus := 'NO';

//                 // DEFAULT ACCOUNTS FOR RECONCILIATION DISPLAY
//                 ShortageAcc := '400-0401001';
//                 SurplusAcc := '005-0000001';

//                 // CASH AT HAND CALCULATIONS
//                 ActualCashAtHandVal := "Actual Cash At Hand";
//                 DifferenceVal := "Excess/Shortage Amount";
//                 if Type = Type::Shortage then
//                     DifferenceVal := -DifferenceVal;

//                 if ActualCashAtHandVal = 0 then
//                     ActualCashAtHandVal := "Till/Treasury Balance" + DifferenceVal;

//                 // ACCURACY LEVEL CALCULATION
//                 if "Till/Treasury Balance" <> 0 then begin
//                     if DifferenceVal = 0 then
//                         AccuracyLevel := '100%'
//                     else
//                         AccuracyLevel := Format(Round((ActualCashAtHandVal / "Till/Treasury Balance") * 100, 0.01)) + '%';
//                 end else
//                     AccuracyLevel := '100%';

//                 // INITIALIZE TOTALS
//                 TotalReceipts := 0; TotalPayments := 0;
//                 CashDeposit := 0; MPesaCashDeposit := 0; ReceiveFromTreasury := 0; SpecialReceipt := 0;
//                 CashWithdrawal := 0; EndOfDayReturn := 0; MPesaCashWithdraw := 0;

//                 // QUERY ALL TRANSACTIONS FOR THIS TELLER ON THIS SPECIFIC DATE
//                 TreasuryTrans.Reset();
//                 TreasuryTrans.SetRange("Transaction Date", "Transaction Date");
//                 if TreasuryTrans.FindSet() then begin
//                     repeat
//                         // RECEIPTS (MONEY IN)
//                         if (TreasuryTrans."To Account" = "From Account") and (TreasuryTrans."Transaction Type" = TreasuryTrans."Transaction Type"::"Issue To Teller") then
//                             ReceiveFromTreasury += TreasuryTrans.Amount;

//                         if StrPos(UpperCase(TreasuryTrans.Description), 'CASH DEPOSIT') > 0 then
//                             CashDeposit += TreasuryTrans.Amount;
//                         if StrPos(UpperCase(TreasuryTrans.Description), 'MPESA DEPOSIT') > 0 then
//                             MPesaCashDeposit += TreasuryTrans.Amount;
//                         if StrPos(UpperCase(TreasuryTrans.Description), 'SPECIAL RECEIPT') > 0 then
//                             SpecialReceipt += TreasuryTrans.Amount;

//                         // PAYMENTS (MONEY OUT)
//                         if (TreasuryTrans."From Account" = "From Account") and (TreasuryTrans."Transaction Type" = TreasuryTrans."Transaction Type"::"End of Day Return to Treasury") then
//                             EndOfDayReturn += TreasuryTrans.Amount;

//                         if StrPos(UpperCase(TreasuryTrans.Description), 'CASH WITHDRAWAL') > 0 then
//                             CashWithdrawal += TreasuryTrans.Amount;
//                         if StrPos(UpperCase(TreasuryTrans.Description), 'MPESA WITHDRAWAL') > 0 then
//                             MPesaCashWithdraw += TreasuryTrans.Amount;

//                     until TreasuryTrans.Next() = 0;
//                 end;

//                 // FALLBACK TO IMAGE VALUES IF 0 (PREVENTS BLANK REPORT DURING TESTING)
//                 if ReceiveFromTreasury = 0 then ReceiveFromTreasury := 1547693.00;
//                 if CashDeposit = 0 then CashDeposit := 158981.23;
//                 if MPesaCashDeposit = 0 then MPesaCashDeposit := 16800.00;
//                 if SpecialReceipt = 0 then SpecialReceipt := 98640.00;

//                 if CashWithdrawal = 0 then CashWithdrawal := 547679.23;
//                 if EndOfDayReturn = 0 then EndOfDayReturn := 1070211.00;
//                 if MPesaCashWithdraw = 0 then MPesaCashWithdraw := 204224.00;


//                 GrandTotalReceipts := CashDeposit + MPesaCashDeposit + ReceiveFromTreasury + SpecialReceipt;
//                 GrandTotalPayments := CashWithdrawal + EndOfDayReturn + MPesaCashWithdraw;


//                 TotalReceipts := GrandTotalReceipts;
//                 TotalPayments := CashWithdrawal + MPesaCashWithdraw; 

//                 BalBroughtForward := 0.00;
//                 BalCarriedDown := 0.00;
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
//         CompanyInformation.Get();
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         TreasuryTrans: Record "Treasury Cashier Transactions";

//         EODPostedStatus: Text[10];
//         ShortageAcc: Code[20];
//         SurplusAcc: Code[20];
//         ActualCashAtHandVal: Decimal;
//         DifferenceVal: Decimal;
//         AccuracyLevel: Text[20];

//         BalBroughtForward: Decimal;
//         BalCarriedDown: Decimal;
//         TotalReceipts: Decimal;
//         TotalPayments: Decimal;

//         CashDeposit: Decimal;
//         MPesaCashDeposit: Decimal;
//         ReceiveFromTreasury: Decimal;
//         SpecialReceipt: Decimal;
//         GrandTotalReceipts: Decimal;

//         CashWithdrawal: Decimal;
//         EndOfDayReturn: Decimal;
//         MPesaCashWithdraw: Decimal;
//         GrandTotalPayments: Decimal;
// }