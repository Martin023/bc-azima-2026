report 52187327 "Process Promise Topay"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Promise Topay Lines"; "Promise Topay Lines")
        {
            RequestFilterFields = "Loan No.", "Header No.", "Member No.";
            DataItemTableView = where("Close Promise" = filter(false));
            trigger OnAfterGetRecord()
            var
            begin
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                AmountPaid := 0;
                LastDatePaid := 0D;
                FromDate := 0D;

                if Loans.Get("Promise Topay Lines"."Loan No.") then begin
                    FromDate := DT2Date("Promise Topay Lines"."Entered At");
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange(Reversed, false);
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::Repayment, CreditLedgerEntry."Transaction Type"::"Interest Paid");
                    CreditLedgerEntry.SetRange("Posting Date", FromDate, Today);
                    if CreditLedgerEntry.Find('-') then begin
                        CreditLedgerEntry.CalcSums(Amount);
                        AmountPaid := CreditLedgerEntry.Amount;
                        AmountPaid *= -1;
                    end;

                    if CreditLedgerEntry.FindLast() then
                        LastDatePaid := CreditLedgerEntry."Posting Date";
                end;

                if AmountPaid > 0 then begin
                    "Promise Topay Lines"."Amount Paid" := AmountPaid;
                    if AmountPaid >= "Promise Topay Lines"."Amount to Pay" then begin
                        "Promise Topay Lines"."Close Promise" := true;
                        "Promise Topay Lines"."Last Date Paid" := CreateDateTime(LastDatePaid, Time);
                    end;
                    "Promise Topay Lines".Modify();
                end;

            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;

                PromiseTopayHeader.Reset();
                PromiseTopayHeader.SetRange("Promise Status", PromiseTopayHeader."Promise Status"::Active);
                if PromiseTopayHeader.Find('-') then begin
                    repeat
                        PromiseLines.Reset();
                        PromiseLines.SetRange("Header No.", PromiseTopayHeader."No.");
                        PromiseLines.SetRange("Close Promise", false);
                        if not PromiseLines.FindFirst() then begin
                            PromiseTopayHeader."Promise Status" := PromiseTopayHeader."Promise Status"::Closed;
                            PromiseTopayHeader."Closed At" := CurrentDateTime;
                            PromiseTopayHeader."Closed By" := UserId;
                            PromiseTopayHeader.Modify();
                        end;
                    until PromiseTopayHeader.Next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            { }
        }
    }
    var
        //Progress Variables
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;


        RunCategorisation: Boolean;
        RunFallOff: Boolean;
        LoadLoanLines: Boolean;

        AmountPaid: Decimal;
        LastDatePaid: Date;
        FromDate: Date;

        Loans: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        PromiseTopayHeader: Record "Promise Topay Header";
        PromiseLines: Record "Promise Topay Lines";
}