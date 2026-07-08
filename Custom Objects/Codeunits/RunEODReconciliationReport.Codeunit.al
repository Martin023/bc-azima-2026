codeunit 52185437 "Run EOD Reconciliation Report"
{
    TableNo = Integer;

    trigger OnRun()
    var
        TreasuryTrans: Record "Treasury Cashier Transactions";
        BankingUser: Record "Banking User Template";
    begin
        TreasuryTrans.Reset();
        
        if BankingUser.Get(UserId) then begin
            TreasuryTrans.SetRange("From Account", BankingUser.UserID);
            if BankingUser."Default  Bank" <> '' then
                TreasuryTrans.SetRange("From Bank", BankingUser."Default  Bank");
        end;
        
        TreasuryTrans.SetRange("Transaction Date", Today);
        
        Report.Run(Report::"End of Day Reconciliation", true, false, TreasuryTrans);
    end;
}
