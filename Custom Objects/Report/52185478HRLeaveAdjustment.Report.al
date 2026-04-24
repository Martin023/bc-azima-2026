Report 52185478 "HR Leave Adjustment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR Employees")
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

            trigger OnAfterGetRecord()
            Var
                LeaveDays: decimal;
                SalaryGrades: record "Salary Grades";
            begin
                "HR EMPLOYEES".TestField(Gender);
                // "HR EMPLOYEES".TestField("Global Dimension 1 Code");
                // "HR EMPLOYEES".TestField("Global Dimension 2 Code");

                //Get current leave period
                HRLeaveCal.Reset;
                HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                if HRLeaveCal.Find('-') then begin
                    HRLeaveTypes.Reset;
                    if LeaveTypeFilter <> '' then begin
                        HRLeaveTypes.SetRange(HRLeaveTypes.Code, LeaveTypeFilter);
                    end;
                    HRLeaveTypes.setrange("Is Annual Leave", True);
                    if HRLeaveTypes.FindFirst() then begin
                        //repeat
                        HRLeaveLedger.Reset();
                        HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", "HR EMPLOYEES"."No.");
                        HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", HRLeaveTypes.Code);
                        HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", LeaveEntryType);
                        //HRLeaveLedger.SetFilter(HRLeaveLedger."Leave Posting Description", '<>%1', '*B/F');
                        HRLeaveLedger.SetRange(HRLeaveLedger."Leave Calendar Code", HRLeaveCal."Calendar Code");
                        if not HRLeaveLedger.Find('-') then begin

                            OK := CheckGender("HR EMPLOYEES", HRLeaveTypes);
                            if OK then begin
                                //with HRJournalLine do begin
                                HRJournalLine.Init;

                                HRJournalLine."Journal Template Name" := Text0001;
                                HRJournalLine.Validate("Journal Template Name");

                                HRJournalLine."Journal Batch Name" := Format(BatchName);
                                HRJournalLine."Line No." := HRJournalLine."Line No." + 1000;

                                HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
                                HRJournalLine.Validate("Leave Calendar Code");

                                HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
                                HRJournalLine.Validate("Leave Period Start Date");

                                HRJournalLine."Staff No." := "HR EMPLOYEES"."No.";
                                HRJournalLine.Validate("Staff No.");

                                HRJournalLine."Posting Date" := Today;
                                HRJournalLine.Description := PostingDescription;
                                HRJournalLine.Status := HRJournalLine.Status::Approved;
                                HRJournalLine."Is Annual Leave" := true;
                                HRJournalLine."Leave Type Enum" := HRLeaveTypes."Leave type Enum";

                                HRJournalLine."Leave Entry Type" := LeaveEntryType;
                                HRJournalLine."Leave Type" := HRLeaveTypes.Code;
                                HRJournalLine."Salary Grade" := "HR EMPLOYEES"."Salary Grade";
                                HRJournalLine."Document No." := HRLeaveCal."Calendar Code";

                                HRJournalLine."Global Dimension 1 Code" := "HR EMPLOYEES"."Global Dimension 1 Code";
                                HRJournalLine.Validate("Global Dimension 1 Code");

                                HRJournalLine."Global Dimension 2 Code" := "HR EMPLOYEES"."Global Dimension 2 Code";
                                HRJournalLine.Validate("Global Dimension 2 Code");
                                HRJournalLine."No. of Days" := 0;

                                if ("HR EMPLOYEES"."Employee Group" <> '') and ("HR EMPLOYEES"."Salary Grade" <> '') then begin
                                    // HRLeaveType.Reset();
                                    // HRLeaveType.SetRange("Is Annual Leave", true);
                                    // if HRLeaveType.FindFirst() then begin
                                    SalaryGrades.reset();
                                    SalaryGrades.SetRange("Employee Group", "HR EMPLOYEES"."Employee Group");
                                    SalaryGrades.setrange("Salary Grade", "HR EMPLOYEES"."Salary Grade");
                                    if SalaryGrades.FindFirst() then begin
                                        //repeat
                                        HRJournalLine."No. of Days" := SalaryGrades."Leave Days";
                                        //until SalaryGrades.next = 0;
                                    end;
                                    //end;
                                end else
                                    HRJournalLine."No. of Days" := HRLeaveTypes.Days;
                                if HRJournalLine."No. of Days" <> 0 then
                                    HRJournalLine.Insert(true);
                            end;
                        end;
                        //until HRLeaveTypes.Next = 0;
                    end else begin
                        Error('No Leave Type found within the applied filters [%1]', HRLeaveTypes.GetFilters);
                    end;
                end else begin
                    Error('No Current leave calendar exists!');
                end;
            end;
        }
        dataitem("HR Leave Types"; "HR Leave Types")
        {
            RequestFilterFields = "Code";

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(LeaveEntryType; LeaveEntryType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Entry Type';
                }
                field(PostingDescription; PostingDescription)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Description';
                }
                field(BatchName; BatchName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Batch Name';


                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PostingDescription := 'Leave Allocation on ' + Format(Today);
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Process complete');
    end;

    trigger OnPreReport()
    begin
        if PostingDescription = '' then Error('Please enter posting description');
        // with HRJournalLine do begin
        HRJournalLine.Reset();
        if not HRJournalLine.IsEmpty then begin
            if Confirm(Text0002 + Text0003, false, HRJournalLine.Count, UpperCase(HRJournalLine.TableCaption), Text0001, BatchName) = true then begin
                HRJournalLine.DeleteAll;
            end else begin
                Error('Process aborted');
            end;
        end;
        // end;

        //Get Leave type filter
        LeaveTypeFilter := "HR Leave Types".GetFilter("HR Leave Types".Code);
    end;

    var
        AllocationDone: Boolean;
        HRLeaveTypes: Record "HR Leave Types";
        HRLeaveType: Record "HR Leave Types";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        LeaveEntryType: Option Postive,Negative,Reimbursement;
        OK: Boolean;
        HRJournalLine: Record "HR Leave Journal Line";
        PostingDescription: Text;
        BatchName: Option DEFAULT,POSITIVE,NEGATIVE;
        JournalTemplate: Code[20];
        Text0001: label 'LEAVE';
        Text0002: label 'There are [%1] entries in [%2  TABLE], Journal Template Name - [%3], Journal Batch Name [%4]';
        Text0003: label '\\Do you want to proceed and overwite these entries?';
        LeaveTypeFilter: Text;
        i: Integer;
        HRLeaveCal: Record "HR Leave Calendar";
        HrEmp: Record "HR Employees";


    procedure CheckGender(Emp: Record "HR Employees"; LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin
        if Emp.Gender = Emp.Gender::Male then begin
            if LeaveType.Gender = LeaveType.Gender::Male then Allocate := true;
        end;

        if Emp.Gender = Emp.Gender::Female then begin
            if LeaveType.Gender = LeaveType.Gender::Female then Allocate := true;
        end;

        if LeaveType.Gender = LeaveType.Gender::Both then Allocate := true;
        exit(Allocate);

        if Emp.Gender <> LeaveType.Gender then Allocate := false;

        exit(Allocate);
    end;
}