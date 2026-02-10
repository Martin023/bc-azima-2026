#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185446 "HR Leave Year - Close"
{
    TableNo = "HR Leave Periods";

    trigger OnRun()
    begin
        AccountingPeriod.Copy(Rec);
        Code;
        Rec := AccountingPeriod;
    end;

    var
        Text001: label 'You must create a new fiscal year before you can close the old year.';
        Text002: label 'This function closes the fiscal year from %1 to %2. ';
        Text003: label 'Once the fiscal year is closed it cannot be opened again, and the periods in the fiscal year cannot be changed.\\';
        Text004: label 'Do you want to close the fiscal year?';
        LeaveTypes: Record "HR Leave Types";
        LeaveLedgerEntries2: Record "HR Leave Ledger Entries";
        DaystoCarryOver: Decimal;
        LeaveBalance: Decimal;
        Employees: Record "HR Employees";
        AccountingPeriod: Record "HR Leave Periods";


        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;
        LeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRSetup: Record "HR Setup";
        HRJournalLine: Record "HR Leave Journal Line";
        "LineNo.": Integer;
        Txt006: label 'There are no Leave Type Defined as Annual in the Leave Types';
        HrCalendar: Record "HR Leave Calendar";
        CalCode: Code[20];
        Ltype: Code[40];
        IsAnnual: Boolean;

    local procedure "Code"()
    var
        Yr: Code[10];

    begin
        begin
            AccountingPeriod.SetRange(Closed, false);
            AccountingPeriod.Find('-');
            FiscalYearStartDate := AccountingPeriod."Starting Date";
            AccountingPeriod.TestField("New Fiscal Year", true);

            AccountingPeriod.SetRange("New Fiscal Year", true);
            if AccountingPeriod.Find('>') then begin
                //error(format(AccountingPeriod."Starting Date"));
                //Set the fiscal year end date to be the 1st Day of the Next Month
                FiscalYearEndDate := CalcDate('<+12M-1D>', AccountingPeriod."Starting Date");
                //error(format(FiscalYearEndDate));


                AccountingPeriod.SetRange("New Fiscal Year");
                AccountingPeriod.Find('<');
            end else
                Error(Text001);
            // if Today < FiscalYearEndDate then
            //     Error('The fiscal Year Can Only Be Closed At The End of %1', FiscalYearEndDate);

            if not
               Confirm(
                 Text002 +
                 Text003 +
                 Text004, false,
                 FiscalYearStartDate, FiscalYearEndDate)
            then
                exit;

            AccountingPeriod.Reset;

            AccountingPeriod.SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod."Starting Date");
            AccountingPeriod.ModifyAll(closed, true);


            AccountingPeriod.SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod."Starting Date");
            AccountingPeriod.ModifyAll("Date Locked", true);

            AccountingPeriod.Reset;
        end;
        //Mark Ledger Entries for that Period as Closed
        LeaveLedgerEntries.Reset;
        LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Posting Date", FiscalYearStartDate, AccountingPeriod."Starting Date");//"Leave Start Date"
        if LeaveLedgerEntries.FindSet then begin
            repeat
                LeaveLedgerEntries.Closed := true;
                LeaveLedgerEntries.Modify;
            until LeaveLedgerEntries.Next = 0;
        end;

        //Carry Forward Leave Balances
        HRJournalBatch.Reset;
        HRSetup.Get;
        HRSetup.TestField(HRSetup."Default Leave Posting Template");
        HRSetup.TestField(HRSetup."Positive Leave Posting Batch");

        HRJournalBatch.Get(HRSetup."Default Leave Posting Template", HRSetup."Positive Leave Posting Batch");

        //Check whether Journal Line has any entries
        HRJournalLine.Reset;
        HRJournalLine.SetRange(HRJournalLine."Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange(HRJournalLine."Journal Batch Name", HRSetup."Positive Leave Posting Batch");
        if HRJournalLine.Find('-') then
            HRJournalLine.DeleteAll;

        "LineNo." := 0;


        //Get employees whose balances to carry over
        Employees.Reset;
        Employees.SetRange(Employees.Status, Employees.Status::Active);
        if Employees.Find('-') then begin

            repeat
                isAnnual := false;
                LeaveBalance := 0;
                DaystoCarryOver := 0;
                LeaveLedgerEntries2.Reset;
                //LeaveLedgerEntries2.SetRange(LeaveLedgerEntries2."Posting Date", FiscalYearStartDate, AccountingPeriod."Starting Date");//"Leave Start Date"
                LeaveLedgerEntries2.SetRange(LeaveLedgerEntries2."Staff No.", Employees."No.");
                //LeaveLedgerEntries2.SetFilter(LeaveLedgerEntries2."Leave Type",'');
                LeaveLedgerEntries2.SETRANGE(LeaveLedgerEntries2."Leave Type Enum", LeaveLedgerEntries2."Leave Type Enum"::Annual);
                if LeaveLedgerEntries2.FindSet then begin
                    LeaveLedgerEntries2.CalcSums("No. of days");
                    LeaveBalance := LeaveLedgerEntries2."No. of days";
                    Ltype := LeaveLedgerEntries2."Leave Type";
                    // repeat
                    // LeaveBalance := LeaveBalance + LeaveLedgerEntries2."No. of days";
                    // until LeaveLedgerEntries2.Next = 0;
                    //MESSAGE('Leave Bal %1 ',LeaveBalance);

                    //Get Maximum Days to Carry Over
                    LeaveTypes.Reset;
                    LeaveTypes.SetRange(LeaveTypes.Code, Ltype);
                    LeaveTypes.SetRange(LeaveTypes."Is Annual Leave", true);
                    if LeaveTypes.Find('-') then begin
                        IsAnnual := true;
                        // if LeaveTypes."Carry Forward Allowed" = true then begin
                        if LeaveBalance > 0 then
                            //         if LeaveBalance > LeaveTypes."Max Carry Forward Days" then
                            //             DaystoCarryOver := LeaveTypes."Max Carry Forward Days"
                            //         else
                            DaystoCarryOver := LeaveBalance;
                        //end;
                    end
                    else
                        Error(Txt006);

                end;

                if DaystoCarryOver < 0 then
                    DaystoCarryOver := 0;

                HrCalendar.Reset;
                HrCalendar.SetRange(HrCalendar."Current Leave Calendar", true);
                if HrCalendar.Find('-') then
                    CalCode := HrCalendar."Calendar Code";

                Yr := Format(Date2dmy(Today, 3));
                if CalCode <> Yr then Message('You cannot use a calendar that is not in the current year');

                //Populate Journal Lines
                "LineNo." := "LineNo." + 1000;

                HRJournalLine.Init;
                HRJournalLine."Journal Template Name" := HRSetup."Default Leave Posting Template";
                HRJournalLine."Journal Batch Name" := HRSetup."Positive Leave Posting Batch";
                HRJournalLine."Line No." := "LineNo.";
                HRJournalLine."Leave Calendar Code" := CalCode; //FORMAT(AccountingPeriod."Starting Date");
                HRJournalLine."Document No." := Format(AccountingPeriod."Starting Date");
                HRJournalLine."Staff No." := Employees."No.";
                HRJournalLine.Validate(HRJournalLine."Staff No.");
                HRJournalLine."Posting Date" := Today;
                HRJournalLine."Leave Entry Type" := HRJournalLine."leave entry type"::Reimbursement;
                HRJournalLine."Leave Approval Date" := Today;
                HRJournalLine.Description := Format(AccountingPeriod."Starting Date") + ' B/F';
                HRJournalLine."Leave Type" := Ltype;//LeaveTypes.Code;
                HRJournalLine."No. of Days" := DaystoCarryOver;
                HRJournalLine."Is Annual Leave" := IsAnnual;
                HRJournalLine."Leave Type Enum" := LeaveTypes."Leave type Enum";
                HRJournalLine.Insert(true);
                Employees."Monthly Leave Days" := 0;
            until Employees.Next = 0;

            //Post Journal
            // HRJournalLine.Reset;
            // HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
            // HRJournalLine.SetRange("Journal Batch Name", HRSetup."Positive Leave Posting Batch");
            // if HRJournalLine.Find('-') then begin
            //     Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", HRJournalLine);
            // end;
        end;
    end;
}