#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185591 "Shortlisting Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Shortlisting Report.rdl';

    dataset
    {
        //CHANGED FROM HR JOB INTERVIEW TO HR JOB APPLICATIONS FOR SHORTLISTED CANDIDATES
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            DataItemTableView = WHERE(Status = CONST(Shortlisted));
            RequestFilterFields = "Job Application No.", "Job Applied For", "Date Applied", "Employee Requisition No";
            column(ReportForNavId_1000; 1000)
            {
            }
            column(ApplicationNo_HRJobApplications; "HR Job Applications"."Job Application No.")
            {
                IncludeCaption = true;
            }
            column(FullName_HRJobApplications; "HR Job Applications"."Full Name")
            {
                IncludeCaption = true;
            }
            column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
            {
                IncludeCaption = true;
            }
            column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
            {
                IncludeCaption = true;
            }
            column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
            {
                IncludeCaption = true;
            }
            column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
            {
                IncludeCaption = true;
            }
            column(JobAppliedForDescription_HRJobApplications; "HR Job Applications"."Job Applied for Description")
            {
                IncludeCaption = true;
            }
            column(DateApplied_HRJobApplications; "HR Job Applications"."Date Applied")
            {
                IncludeCaption = true;
            }
            column(Status_HRJobApplications; "HR Job Applications".Status)
            {
                IncludeCaption = true;
            }
            column(IDNumber_HRJobApplications; "HR Job Applications"."ID Number")
            {
                IncludeCaption = true;
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRJobApplications; "HR Job Applications"."Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
            {
                IncludeCaption = true;
            }
            column(EmployeeRequisitionNo_HRJobApplications; "HR Job Applications"."Employee Requisition No")
            {
                IncludeCaption = true;
            }
            column(TotalScoreAfterShortlisting_HRJobApplications; "HR Job Applications"."Total Score After Shortlisting")
            {
                IncludeCaption = true;
            }
            column(QualificationsSummary; QualificationsSummary)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address)
            {
            }
            column(CompanyPhone; CompInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompInfo."E-Mail")
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                //BUILD QUALIFICATIONS SUMMARY
                QualificationsSummary := '';
                HRApplicantQual.Reset();
                HRApplicantQual.SetRange("Application No", "Job Application No.");
                if HRApplicantQual.FindSet() then begin
                    repeat
                        if QualificationsSummary <> '' then
                            QualificationsSummary += '; ';
                        QualificationsSummary += HRApplicantQual."Qualification Description";
                    until HRApplicantQual.Next() = 0;
                end;
            end;
        }
        
        //COMMENTED OUT ORIGINAL HR JOB INTERVIEW DATAITEM - NOT NEEDED FOR SHORTLISTED CANDIDATES REPORT
        //dataitem("HR Job Interview"; "HR Job Interview")
        //{
        //    column(ReportForNavId_1; 1)
        //    {
        //    }
        //    column(ApplicantNo_HRJobInterview; "HR Job Interview"."Applicant No")
        //    {
        //    }
        //    column(InterviewCode_HRJobInterview; "HR Job Interview"."Interview Code")
        //    {
        //    }
        //    column(InterviewDescription_HRJobInterview; "HR Job Interview"."Interview Description")
        //    {
        //    }
        //    column(Score_HRJobInterview; "HR Job Interview".Score)
        //    {
        //    }
        //    column(TotalScore_HRJobInterview; "HR Job Interview"."Total Score")
        //    {
        //    }
        //    column(Category_HRJobInterview; "HR Job Interview".Category)
        //    {
        //    }
        //    column(SubCategory_HRJobInterview; "HR Job Interview"."Sub Category")
        //    {
        //    }
        //    column(Group_HRJobInterview; "HR Job Interview".Group)
        //    {
        //    }
        //    column(LineNo_HRJobInterview; "HR Job Interview"."Line No")
        //    {
        //    }
        //    column(Comments_HRJobInterview; "HR Job Interview".Comments)
        //    {
        //    }
        //    column(Interviewer_HRJobInterview; "HR Job Interview".Interviewer)
        //    {
        //    }
        //    column(InterviewerName_HRJobInterview; "HR Job Interview"."Interviewer Name")
        //    {
        //    }
        //    column(Picture; CompInfo.Picture)
        //    {
        //    }
        //}

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
        HRApplicantQual: Record "HR Applicant Qualifications";
        QualificationsSummary: Text[1000];
}
