#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185589 "Job Interview results"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Job Interview results.rdl';

    dataset
    {
        dataitem("HR Shortlisted Applicants"; "HR Shortlisted Applicants")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(EmployeeRequisitionNo_HRShortlistedApplicants; "HR Shortlisted Applicants"."Employee Requisition No")
            {
            }
            column(StageCode_HRShortlistedApplicants; "HR Shortlisted Applicants"."Stage Code")
            {
            }
            column(JobApplicationNo_HRShortlistedApplicants; "HR Shortlisted Applicants"."Job Application No")
            {
            }
            column(StageScore_HRShortlistedApplicants; "HR Shortlisted Applicants"."Stage Score")
            {
            }
            column(Qualified_HRShortlistedApplicants; "HR Shortlisted Applicants".Qualified)
            {
            }
            column(FirstName_HRShortlistedApplicants; "HR Shortlisted Applicants"."First Name")
            {
            }
            column(MiddleName_HRShortlistedApplicants; "HR Shortlisted Applicants"."Middle Name")
            {
            }
            column(LastName_HRShortlistedApplicants; "HR Shortlisted Applicants"."Last Name")
            {
            }
            column(IDNo_HRShortlistedApplicants; "HR Shortlisted Applicants"."ID No")
            {
            }
            column(Gender_HRShortlistedApplicants; "HR Shortlisted Applicants".Gender)
            {
            }
            column(MaritalStatus_HRShortlistedApplicants; "HR Shortlisted Applicants"."Marital Status")
            {
            }
            column(ManualChange_HRShortlistedApplicants; "HR Shortlisted Applicants"."Manual Change")
            {
            }
            column(Employ_HRShortlistedApplicants; "HR Shortlisted Applicants".Employ)
            {
            }
            column(Date_HRShortlistedApplicants; "HR Shortlisted Applicants".Date)
            {
            }
            column(Position_HRShortlistedApplicants; "HR Shortlisted Applicants".Position)
            {
            }
            column(ReportingDate_HRShortlistedApplicants; "HR Shortlisted Applicants"."Reporting Date")
            {
            }
            column(FullName_HRShortlistedApplicants; "HR Shortlisted Applicants"."Full Name")
            {
            }
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
        CompInfo.Reset;
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture)
    end;

    var
        CompInfo: Record "Company Information";
}
