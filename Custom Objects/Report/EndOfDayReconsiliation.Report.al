#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 
Report 52185446 "End of Day Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/EndOfDayReconciliation.rdl';

    dataset
    {
        dataitem(TreasuryTrans; "Treasury Cashier Transactions")
        {
            RequestFilterFields = No, "From Account", "From Bank", "Transaction Date";

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
            column(EndOfDayDate; Format("Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
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
            column(ActualCashAtHand; "Actual Cash At Hand") { }
            column(Difference; DifferenceAmt) { }

            column(CashDeposit; CashDepositAmt) { }
            column(MPesaCashDeposit; MPesaCashDepositAmt) { }
            column(ReceiveFromTreasury; ReceiveFromTreasuryAmt) { }
            column(SpecialReceipt; SpecialReceiptAmt) { }
            column(GrandTotalReceipts; GrandTotalReceiptsAmt) { } 

            column(CashWithdrawal; CashWithdrawalAmt) { }
            column(EndOfDay; EndOfDayAmt) { }
            column(MPesaCashWithdraw; MPesaCashWithdrawAmt) { }
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
                if BankingUserTemp.Get("From Account") then begin
                    ShortageAccCode := BankingUserTemp."Shortage Account";
                    SurplusAccCode := BankingUserTemp."Excess Account";
                end;

                if Posted then 
                    EODPostedStatusTxt := 'YES' 
                else 
                    EODPostedStatusTxt := 'NO';

                DifferenceAmt := "Excess/Shortage Amount";
                if Type = Type::Shortage then
                    DifferenceAmt := -DifferenceAmt;

                if "Till Balance" <> 0 then begin
                    if DifferenceAmt = 0 then
                        AccuracyLevelTxt := '100%'
                    else
                        AccuracyLevelTxt := Format(Round((("Actual Cash At Hand" / "Till Balance") * 100), 0.01)) + '%';
                end else
                    AccuracyLevelTxt := '100%';

                TotalReceiptsAmt := 0; TotalPaymentsAmt := 0;
                CashDepositAmt := 0; MPesaCashDepositAmt := 0; ReceiveFromTreasuryAmt := 0; SpecialReceiptAmt := 0;
                CashWithdrawalAmt := 0; EndOfDayAmt := 0; MPesaCashWithdrawAmt := 0;

                CashierTrans.Reset();
                CashierTrans.SetRange(Cashier, "From Account");
                CashierTrans.SetRange("Transaction Date", "Transaction Date");
                CashierTrans.SetRange(Posted, true);
                if CashierTrans.FindSet() then begin
                    repeat
                        if CashierTrans.Type = CashierTrans.Type::"Cash Deposit" then
                            CashDepositAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"MPESA Deposit" then
                            MPesaCashDepositAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then
                            CashWithdrawalAmt += CashierTrans.Amount
                        else if CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal" then
                            MPesaCashWithdrawAmt += CashierTrans.Amount;
                    until CashierTrans.Next() = 0;
                end;

                TreasuryTransIn.Reset();
                TreasuryTransIn.SetRange("To Account", "From Account");
                TreasuryTransIn.SetRange("Transaction Date", "Transaction Date");
                TreasuryTransIn.SetRange("Transaction Type", TreasuryTransIn."Transaction Type"::"Issue To Teller");
                TreasuryTransIn.SetRange(Posted, true);
                if TreasuryTransIn.FindSet() then begin
                    repeat
                        ReceiveFromTreasuryAmt += TreasuryTransIn.Amount;
                    until TreasuryTransIn.Next() = 0;
                end;

                EndOfDayAmt := Amount;

                GrandTotalReceiptsAmt := CashDepositAmt + MPesaCashDepositAmt + ReceiveFromTreasuryAmt + SpecialReceiptAmt;
                GrandTotalPaymentsAmt := CashWithdrawalAmt + EndOfDayAmt + MPesaCashWithdrawAmt;
                
                TotalReceiptsAmt := GrandTotalReceiptsAmt;
                TotalPaymentsAmt := CashWithdrawalAmt + MPesaCashWithdrawAmt; 
                BalBroughtForwardAmt := 0.00; 
                BalCarriedDownAmt := BalBroughtForwardAmt + TotalReceiptsAmt - TotalPaymentsAmt;
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
        GrandTotalPaymentsAmt: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
        GlobalFunctions: Codeunit "Global Functions";
}