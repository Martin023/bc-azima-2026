#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185591 "Shortlisting Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Shortlisting Report.rdl';

    dataset
    {
        dataitem("HR Job Interview"; "HR Job Interview")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(ApplicantNo_HRJobInterview; "HR Job Interview"."Applicant No")
            {
            }
            column(InterviewCode_HRJobInterview; "HR Job Interview"."Interview Code")
            {
            }
            column(InterviewDescription_HRJobInterview; "HR Job Interview"."Interview Description")
            {
            }
            column(Score_HRJobInterview; "HR Job Interview".Score)
            {
            }
            column(TotalScore_HRJobInterview; "HR Job Interview"."Total Score")
            {
            }
            column(Category_HRJobInterview; "HR Job Interview".Category)
            {
            }
            column(SubCategory_HRJobInterview; "HR Job Interview"."Sub Category")
            {
            }
            column(Group_HRJobInterview; "HR Job Interview".Group)
            {
            }
            column(LineNo_HRJobInterview; "HR Job Interview"."Line No")
            {
            }
            column(Comments_HRJobInterview; "HR Job Interview".Comments)
            {
            }
            column(Interviewer_HRJobInterview; "HR Job Interview".Interviewer)
            {
            }
            column(InterviewerName_HRJobInterview; "HR Job Interview"."Interviewer Name")
            {
            }
            column(Picture; CompInfo.Picture)
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
