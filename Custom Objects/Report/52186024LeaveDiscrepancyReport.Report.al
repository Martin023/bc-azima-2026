#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186024 "Leave Discrepancy Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Leave Discrepancy Report.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Date", "Leave Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(ApplicationCode_HRLeaveApplication; "HR Leave Application"."Application Code")
            {
            }
            column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
            {
            }
            column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
            {
            }
            column(EmployeeName_HRLeaveApplication; "HR Leave Application"."Employee Name")
            {
            }
            column(Names_HRLeaveApplication; "HR Leave Application".Names)
            {
            }

            trigger OnAfterGetRecord()
            begin
                intEntryNo := 0;
                HRLeaveEntries.Reset;
                HRLeaveEntries.SetRange("Document No.", "HR Leave Application"."Application Code");
                if HRLeaveEntries.FindFirst then
                    CurrReport.Skip;


                HRLeaveEntries.Reset;
                if HRLeaveEntries.FindLast then intEntryNo := HRLeaveEntries."Entry No.";

                intEntryNo := intEntryNo + 1;
                HRLeaveEntries.Init;
                HRLeaveEntries."Leave Calendar Code" := '2022';
                HRLeaveEntries."Entry No." := intEntryNo;
                HRLeaveEntries."Staff No." := "HR Leave Application"."Applicant Staff No.";
                HRLeaveEntries."Staff Name" := "HR Leave Application".Names;
                HRLeaveEntries."Posting Date" := "HR Leave Application"."Application Date";
                HRLeaveEntries."Leave Entry Type" := HRLeaveEntries."leave entry type"::Negative;
                HRLeaveEntries."Leave Approval Date" := "HR Leave Application"."Application Date";
                HRLeaveEntries."Document No." := "HR Leave Application"."Application Code";
                HRLeaveEntries."External Document No." := "HR Leave Application"."Applicant Staff No.";
                HRLeaveEntries."Job ID" := CopyStr("HR Leave Application"."Job Tittle", 1, 20);
                HRLeaveEntries."No. of days" := -"HR Leave Application"."Days Applied";
                HRLeaveEntries."Leave Start Date" := "HR Leave Application"."Start Date";
                HRLeaveEntries."Leave Posting Description" := 'Leave Taken [' + "HR Leave Application"."Application Code" + ']';
                HRLeaveEntries."Leave End Date" := "HR Leave Application"."Return Date";
                HRLeaveEntries."Leave Return Date" := "HR Leave Application"."Return Date";
                HRLeaveEntries."User ID" := "HR Leave Application"."Applicant User ID";
                HRLeaveEntries."Leave Type" := "HR Leave Application"."Leave Type";
                HRLeaveEntries.Insert;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        HRLeaveApplication: Record "HR Leave Application";
        LeaveNotFound: Code[50];
        LeaveTwo: Integer;
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
}
