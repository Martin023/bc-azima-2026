namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Finance.GeneralLedger.Journal;

report 52186242 ReverseEntries
{
    ApplicationArea = All;
    Caption = 'Reverse CAS Entries';
    UsageCategory = Lists;
    ProcessingOnly = true;
    dataset
    {
        dataitem("PR Employee Transactions"; "PR Employee Transactions")
        {
            DataItemTableView = where("Period Month" = filter(8));
            trigger OnAfterGetRecord()
            begin
                PREMpTrans.Reset();
                PREMpTrans.SetRange("Transaction Code", "PR Employee Transactions"."Transaction Code");
                PREMpTrans.SetRange("Period Month", 9);
                if PREMpTrans.FindFirst() then begin
                    PREMpTrans.Amount := "PR Employee Transactions".Amount;
                    PREmpTrans.modify;
                end;
            end;
        }

    }

    var
        PREMpTrans: record "PR Employee Transactions";
}
