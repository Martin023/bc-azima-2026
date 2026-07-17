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
            column(BalBroughtForward; BalBroughtForwardAmt) { }
            column(TotalReceipts; TotalReceiptsAmt) { }
            column(TotalPayments; TotalPaymentsAmt) { }
            column(BalCarriedDown; BalCarriedDownAmt) { }
            column(SystemCashAtHand; "Till Balance") { }

            column(ActualCashAtHand; ActualCashAtHandAmt) { }
            column(Difference; DifferenceAmt) { }

            column(CashDeposit; CashDepositAmt) { }
            column(MPesaCashDeposit; MPesaCashDepositAmt) { }
            column(ReceiveFromTreasury; ReceiveFromTreasuryAmt) { }
            column(SpecialReceipt; SpecialReceiptAmt) { }
            column(GrandTotalReceipts; GrandTotalReceiptsAmt) { }
            column(CashWithdrawal; CashWithdrawalAmt) { }
            column(EndOfDay; EndOfDayAmt) { }
            column(MPesaCashWithdraw; MPesaCashWithdrawAmt) { }
            column(PettyCashAmt; PettyCashAmt) { }
            column(ReturnToTreasuryAmt; ReturnToTreasuryAmt) { }
            column(GrandTotalPayments; GrandTotalPaymentsAmt) { }
            column(AccuracyLevel; AccuracyLevelTxt) { }

            dataitem(Coinage; Coinage)
            {
                DataItemLink = No = field(No);
                column(DenomCode; Code) { }
                column(DenomCount; Quantity) { }
                column(DenomAmount; "Total Amount") { }
            }

            trigger OnAfterGetRecord()
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

                DifferenceAmt := ActualCashAtHandAmt - "Till Balance";

                if "Till Balance" <> 0 then begin
                    if DifferenceAmt = 0 then
                        AccuracyLevelTxt := '100%'
                    else
                        AccuracyLevelTxt := Format(Round(((ActualCashAtHandAmt / "Till Balance") * 100), 0.01)) + '%';
                end else
                    AccuracyLevelTxt := '100%';

                // Initialize all Amounts to Zero
                ClearAllAmounts();

                // Set filter date from the main record being processed
                FilterDate := TreasuryTrans."Date Posted";

                CashierTrans.Reset();
                CashierTrans.SetRange(Cashier, "From Account");
                CashierTrans.SetRange("Date Posted", FilterDate);
                CashierTrans.SetRange(Posted, true);
                if CashierTrans.FindSet() then begin
                    repeat
                        case CashierTrans.Type of
                            CashierTrans.Type::"Cash Deposit":
                                CashDepositAmt += CashierTrans.Amount;
                            CashierTrans.Type::"MPESA Deposit":
                                MPesaCashDepositAmt += CashierTrans.Amount;
                            CashierTrans.Type::"Cash Withdrawal":
                                CashWithdrawalAmt += CashierTrans.Amount;
                            CashierTrans.Type::"MPESA Withdrawal":
                                MPesaCashWithdrawAmt += CashierTrans.Amount;
                        end;
                    until CashierTrans.Next() = 0;
                end;

                TreasuryTransIn.Reset();
                TreasuryTransIn.SetRange("To Account", "From Account");
                TreasuryTransIn.SetRange("Date Posted", FilterDate);
                TreasuryTransIn.SetRange("Transaction Type", TreasuryTransIn."Transaction Type"::"Issue To Teller");
                TreasuryTransIn.SetRange(Posted, true);
                if TreasuryTransIn.FindSet() then begin
                    repeat
                        ReceiveFromTreasuryAmt += TreasuryTransIn.Amount;
                    until TreasuryTransIn.Next() = 0;
                end;

                TreasuryTransOut.Reset();
                TreasuryTransOut.SetRange("From Account", "From Account");
                TreasuryTransOut.SetRange("Date Posted", FilterDate);
                TreasuryTransOut.SetRange("Transaction Type", TreasuryTransOut."Transaction Type"::"Return To Treasury");
                TreasuryTransOut.SetRange(Posted, true);
                if TreasuryTransOut.FindSet() then begin
                    repeat
                        ReturnToTreasuryAmt += TreasuryTransOut.Amount;
                    until TreasuryTransOut.Next() = 0;
                end;

                PaymentsHeader.Reset();
                PaymentsHeader.SetRange("Payment Type", PaymentsHeader."Payment Type"::"Petty Cash");
                PaymentsHeader.SetRange("Paying Bank Account", "From Bank");
                PaymentsHeader.SetRange("Date Posted", FilterDate);
                PaymentsHeader.SetRange(Posted, true);
                if PaymentsHeader.FindSet() then begin
                    repeat
                        PaymentsHeader.CalcFields("Total Net Amount");
                        PettyCashAmt += PaymentsHeader."Total Net Amount";
                    until PaymentsHeader.Next() = 0;
                end;

                EndOfDayAmt := Amount;

                GrandTotalReceiptsAmt := CashDepositAmt + MPesaCashDepositAmt + ReceiveFromTreasuryAmt + SpecialReceiptAmt;
                GrandTotalPaymentsAmt := CashWithdrawalAmt + EndOfDayAmt + MPesaCashWithdrawAmt + PettyCashAmt + ReturnToTreasuryAmt;

                TotalReceiptsAmt := GrandTotalReceiptsAmt;

                TotalPaymentsAmt := GrandTotalPaymentsAmt - EndOfDayAmt;
                BalBroughtForwardAmt := 0.00;

                BalCarriedDownAmt := BalBroughtForwardAmt + GrandTotalReceiptsAmt - GrandTotalPaymentsAmt;
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
        CashierTrans: Record "Cashier Transactions";
        TreasuryTransIn: Record "Treasury Cashier Transactions";
        TreasuryTransOut: Record "Treasury Cashier Transactions";
        PaymentsHeader: Record "Payments Header";
        CoinageRec: Record Coinage;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";

        ActualCashAtHandAmt: Decimal;
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
        GrandTotalReceiptsAmt: Decimal;
        CashWithdrawalAmt: Decimal;
        EndOfDayAmt: Decimal;
        MPesaCashWithdrawAmt: Decimal;
        PettyCashAmt: Decimal;
        ReturnToTreasuryAmt: Decimal;
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
        GrandTotalReceiptsAmt := 0;
        CashWithdrawalAmt := 0;
        EndOfDayAmt := 0;
        MPesaCashWithdrawAmt := 0;
        PettyCashAmt := 0;
        ReturnToTreasuryAmt := 0;
        GrandTotalPaymentsAmt := 0;
        BalCarriedDownAmt := 0;
    end;
}