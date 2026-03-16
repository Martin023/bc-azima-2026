#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185509 "Separation report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Separation report.rdl';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            RequestFilterFields = "Reason For Leaving", "Employee No.";
            RequestFilterHeading = '`';
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(ExitInterviewNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Exit Interview No")
            {
            }
            column(DateOfInterview_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Date Of Interview")
            {
            }
            column(InterviewDoneBy_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Interview Done By")
            {
            }
            column(ReEmployInFuture_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Re Employ In Future")
            {
            }
            column(ReasonForLeaving_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Reason For Leaving")
            {
            }
            column(ReasonForLeavingOther_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Reason For Leaving (Other)")
            {
            }
            column(DateOfLeaving_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Date Of Leaving")
            {
            }
            column(Comment_HREmployeeExitInterviews; "HR Employee Exit Interviews".Comment)
            {
            }
            column(EmployeeNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(NoSeries_HREmployeeExitInterviews; "HR Employee Exit Interviews"."No Series")
            {
            }
            column(FormSubmitted_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Form Submitted")
            {
            }
            column(GlobalDimension2_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Global Dimension 2")
            {
            }
            column(EmployeeName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee Name")
            {
            }
            column(InterviewerName_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Interviewer Name")
            {
            }
            column(Closed_HREmployeeExitInterviews; "HR Employee Exit Interviews".Closed)
            {
            }
            column(No; no)
            {
            }
            column(today; Today)
            {
            }
            column(User; UserId)
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(StatName; StaName)
            {
            }
            dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
            {
                DataItemLink = "No." = field("Employee No.");
                column(ReportForNavId_16; 16)
                {
                }
                column(GlobalDimension1Name_HREmployees; "HR Employees"."Global Dimension 1 Name")
                {
                }
                column(GlobalDimension2Name_HREmployees; "HR Employees"."Global Dimension 2 Name")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                no := no + 1;



                Station.Reset;
                // Station.SETRANGE(Station.Code, "HR Employees"."Department Code");
                if Station.Find('-') then
                    StaName := Station.Name;
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

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);

        no := 0;
    end;

    var
        "Termination Ground": Option " ",Resignation,Dismissal,Retirement,Deceased,Termination,"Retirement(Medical Grounds)",Desertion,Other;
        Termination: Text;
        no: Integer;
        CompanyInfo: Record "Company Information";
        Station: Record "Dimension Value";
        StaName: Text;
        Clear: Text;
        text: label 'Yes';
        Notext: label 'No';
}
