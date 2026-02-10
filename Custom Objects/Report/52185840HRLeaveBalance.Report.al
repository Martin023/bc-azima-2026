#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185840 "HR Leave Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/HR Leave Balance.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(JobTitle_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(LeaveTypeFilter; LeaveTypeFilter)
            {
            }
            column(GlobalDimension2Code_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(GlobalDimension1Code_HREmployees; "HR Employees"."Global Dimension 1 Code")
            {
            }
            column(DaysAllocated; DaysAllocated)
            {
            }
            column(DaysTaken; DaysTaken)
            {
            }
            column(LeaveBalance; LeaveBalance)
            {
            }
            column(AppliedFilters; AppliedFilters)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(r; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(Rcount; Rcount)
            {
            }
            column(LeaveName; LeaveName)
            {
            }
            column(BF; BroughtForward)
            {

            }
            column(cost; cost)
            {

            }
            column(Monthly_Leave_Days; MonthlyDays)
            {

            }

            trigger OnAfterGetRecord()
            var
                PRSalaryCard: Record "PR Salary Card";
                HrEmp: Record "HR Employees";
                strExtractedFrml: Text[250];
                curTransAmount: Decimal;
                EmpCode: code[20];
                intMonth: Integer;
                intYear: Integer;
                Bpay: Text[200];
                Extract: text;
                HrSetup: record "HR Setup";

            begin
                //Initialize
                DaysAllocated := 0;
                DaysTaken := 0;
                LeaveBalance := 0;
                BroughtForward := 0;
                Rcount := Rcount + 1;



                cost := 0;
                curTransAmount := 0;
                HREmp.Reset;
                if HrEmp.Get("HR EMPLOYEES"."No.") then begin
                    MonthlyDays := Round("HR EMPLOYEES"."Monthly Leave Days", 1, '<');
                    HrEmp.CalcFields("Reimbursed Leave Days");
                    PRSalaryCard.reset();
                    PRSalaryCard.setrange("Employee Code", HrEmp."No.");
                    if PRSalaryCard.FindSet() then begin
                        EmpCode := HrEmp."No.";
                        intMonth := Date2DMY(today, 2);
                        Intyear := Date2DMY(today, 3);
                        curTransAmount := 0;
                        strExtractedFrml := '';
                        if HrSetup.get() then
                            IF COPYSTR(HrSEtup.Formula, 3, 4) = 'BPAY' then
                                Bpay := CopyStr(HrSEtup.Formula, 1, 1) + Format(PRSalaryCard."Basic Pay") + CopyStr(HrSEtup.Formula, 8, 12);
                        curTransAmount := ROUND(Payroll.fnFormulaResult(Bpay), 1, '<');
                        Cost := Round((curTransAmount * (HrEmp."Monthly Leave Days" + HrEmp."Reimbursed Leave Days")), 0.01, '<');
                    end;
                end;



                //Allocated Leave Days
                HRLeaveLedger.Reset;
                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", HRLeaveLedger."leave entry type"::Positive);
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", LeaveTypeFilter);
                if HRLeaveLedger.Find('-') then begin
                    HRLeaveLedger.CalcSums(HRLeaveLedger."No. of days");
                    DaysAllocated := Round(HRLeaveLedger."No. of days", 0.01, '>');
                end;
                //Days Reimbursed

                HRLeaveLedger.Reset;
                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", HRLeaveLedger."leave entry type"::Reimbursement);
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", LeaveTypeFilter);
                if HRLeaveLedger.Find('-') then begin
                    HRLeaveLedger.CalcSums(HRLeaveLedger."No. of days");
                    BroughtForward := Round(HRLeaveLedger."No. of days", 0.01, '>');
                end;

                //Days Taken
                HRLeaveLedger.Reset;
                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", HRLeaveLedger."leave entry type"::Negative);
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", LeaveTypeFilter);
                if HRLeaveLedger.Find('-') then begin
                    HRLeaveLedger.CalcSums(HRLeaveLedger."No. of days");
                    DaysTaken := round(Abs(HRLeaveLedger."No. of days"), 0.01, '>');
                end;

                //Leave Balance
                LeaveBalance := DaysAllocated - DaysTaken;

                if (DaysAllocated = 0) and (DaysTaken = 0) and (LeaveBalance = 0) then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(LeaveTypeFilter; LeaveTypeFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Type Filter';
                    TableRelation = "HR Leave Types".Code;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if LeaveTypeFilter = '' then Error('Please select leave type');
        AppliedFilters := LeaveTypeFilter + ' Leave, ' + "HR Employees".GetFilters;

        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture);


        HRLeaveTypes.Reset;
        HRLeaveTypes.SetRange(HRLeaveTypes.Code, LeaveTypeFilter);
        if HRLeaveTypes.Find('-') then begin
            LeaveName := HRLeaveTypes.Description;
        end;
    end;

    var
        LeaveTypeFilter: Code[20];
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        DaysAllocated: Decimal;
        DaysTaken: Decimal;
        LeaveBalance: Decimal;
        AppliedFilters: Text;
        CompInfo: Record "Company Information";
        Payroll: codeunit "PR Payroll Processing";
        Rcount: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        LeaveName: Text[30];
        BroughtForward: decimal;
        cost: decimal;
        MonthlyDays: Decimal;
}
