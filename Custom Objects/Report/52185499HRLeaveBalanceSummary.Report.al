#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185499 "HR Leave Balance Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Leave Balance Summary.rdl';

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
            column(AnnualAlloc; AnnualAlloc)
            {
            }
            column(Annual25Alloc; Annual25Alloc)
            {
            }
            column(Annual25Taken; Annual25Taken)
            {
            }
            column(AnnualTaken; AnnualTaken)
            {
            }
            column(MaternityTaken; MaternityTaken)
            {
            }
            column(MaternityAlloc; MaternityAlloc)
            {
            }
            column(PaternityTaken; PaternityTaken)
            {
            }
            column(PaternityAlloc; PaternityAlloc)
            {
            }
            column(StudyAlloc; StudyAlloc)
            {
            }
            column(StudyTaken; StudyTaken)
            {
            }
            column(AnnualLeaveAll; AnnualLeaveAll)
            {
            }
            column(AnnaulLeaveTake; AnnaulLeaveTake)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Initialize
                DaysAllocated := 0;
                DaysTaken := 0;
                LeaveBalance := 0;
                Rcount := Rcount + 1;
                AnnualAlloc := 0;
                Annual25Alloc := 0;
                AnnualTaken := 0;
                Annual25Taken := 0;
                MaternityAlloc := 0;
                MaternityTaken := 0;
                PaternityTaken := 0;
                PaternityAlloc := 0;
                StudyTaken := 0;
                StudyAlloc := 0;
                AnnaulLeaveTake := 0;
                AnnualLeaveAll := 0;

                //Allocated Leave Days
                HRLeaveLedger.Reset;
                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", HRLeaveLedger."leave entry type"::Positive);
                //HRLeaveLedger.SETRANGE(HRLeaveLedger."Leave Type",'LTY05');
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Calendar Code", LeaveCodeFilter);
                if HRLeaveLedger.Find('-') then begin
                    repeat
                        // HRLeaveLedger.CALCSUMS(HRLeaveLedger."No. of days");
                        DaysAllocated := HRLeaveLedger."No. of days";

                        case HRLeaveLedger."Leave Type" of
                            'LTY01':
                                begin
                                    AnnualAlloc += HRLeaveLedger."No. of days";
                                end;
                            'LTY02':
                                begin
                                    Annual25Alloc += HRLeaveLedger."No. of days";
                                end;
                            'LTY03':
                                begin
                                    MaternityAlloc += HRLeaveLedger."No. of days";
                                end;
                            'LTY04':
                                begin
                                    PaternityAlloc += HRLeaveLedger."No. of days";
                                end;
                            'LTY05':
                                begin
                                    StudyAlloc += HRLeaveLedger."No. of days";
                                end;
                            'LTY07':
                                begin
                                    AnnualLeaveAll := HRLeaveLedger."No. of days";
                                end;
                        end;
                    until HRLeaveLedger.Next = 0;
                end;

                //Days Taken
                HRLeaveLedger.Reset;
                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetFilter(HRLeaveLedger."Leave Entry Type", '%1|%2', HRLeaveLedger."leave entry type"::Negative, HRLeaveLedger."leave entry type"::Reimbursement);
                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Calendar Code", LeaveCodeFilter);
                //HRLeaveLedger.SETRANGE(HRLeaveLedger."Leave Type",'LTY05');
                if HRLeaveLedger.Find('-') then begin
                    repeat
                        // HRLeaveLedger.CALCSUMS(HRLeaveLedger."No. of days");
                        DaysTaken := Abs(HRLeaveLedger."No. of days");
                        case HRLeaveLedger."Leave Type" of
                            'LTY01':
                                begin
                                    AnnualTaken += HRLeaveLedger."No. of days";
                                end;
                            'LTY02':
                                begin
                                    Annual25Taken += HRLeaveLedger."No. of days";
                                end;
                            'LTY03':
                                begin
                                    MaternityTaken += HRLeaveLedger."No. of days";
                                end;
                            'LTY04':
                                begin
                                    PaternityTaken += HRLeaveLedger."No. of days";
                                end;
                            'LTY05':
                                begin
                                    StudyTaken += HRLeaveLedger."No. of days";
                                end;
                            'LTY07':
                                begin
                                    AnnaulLeaveTake := HRLeaveLedger."No. of days";
                                end;
                        end;




                    until HRLeaveLedger.Next = 0;
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
                field(LeaveCodeFilter; LeaveCodeFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Code Filter';
                    TableRelation = "HR Leave Calendar"."Calendar Code";
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
        //IF LeaveTypeFilter = '' THEN ERROR('Please select leave type');
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
        Rcount: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        LeaveName: Text[30];
        LeaveCodeFilter: Code[20];
        AnnualAlloc: Decimal;
        Annual25Alloc: Decimal;
        Annual25Taken: Decimal;
        AnnualTaken: Decimal;
        MaternityTaken: Decimal;
        MaternityAlloc: Decimal;
        PaternityTaken: Decimal;
        PaternityAlloc: Decimal;
        StudyTaken: Decimal;
        StudyAlloc: Decimal;
        AnnualLeaveAll: Decimal;
        AnnaulLeaveTake: Decimal;
        AnnualLeaveRem: Decimal;
}
