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
            column(CompanyInformation_Name; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
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
        CompInfo.CalcFields(CompInfo.Picture);
        CompanyAddress := CompInfo.Address + ' -Post Code: ' + CompInfo."Post Code" + ' -City:' + CompInfo.City + ' Region: ' + CompInfo."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompInfo."Phone No." + ' -Office Tel: ' + CompInfo."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompInfo."E-Mail" + '- Website: ' + CompInfo."Home Page";
    end;

    var
        CompInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
report 52185589 "Job Interview results"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/JobInterviewResults.rdl';
    Caption = 'Job Interview Results Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Shortlisted Applicants"; "HR Shortlisted Applicants")
        {
            // Forces the report to sort highest scores first per requisition
            DataItemTableView = sorting("Employee Requisition No", "Stage Score") order(descending);
            RequestFilterFields = "Employee Requisition No", "Stage Code", Qualified;

            // Full Company Information Standard
            column(CompanyInfo_Name; CompInfo.Name) { }
            column(CompanyInfo_Address; CompInfo.Address) { }
            column(CompanyInfo_Picture; CompInfo.Picture) { }
            column(CompanyInfo_City; CompInfo.City) { }
            column(CompanyInfo_PostCode; CompInfo."Post Code") { }
            column(CompanyInfo_Phone; CompInfo."Phone No." + ' ' + CompInfo."Phone No. 2") { }
            column(CompanyInfo_Email; CompInfo."E-Mail") { }

            // Candidate & Job Details
            column(EmployeeRequisitionNo; "Employee Requisition No") { }
            column(JobTitle; JobTitle) { }
            column(JobApplicationNo; "Job Application No") { }
            column(FullName; "Full Name") { }
            column(IDNo; "ID No") { }
            column(StageScore; "Stage Score") { }
            column(Qualified; Qualified) { }
            
            // Dynamic Ranking Column
            column(CandidateRank; Rank) { }

            trigger OnAfterGetRecord()
            begin
                // 1. Fetch the Actual Job Title
                JobTitle := '';
                if HREmpReq.Get("Employee Requisition No") then
                    JobTitle := HREmpReq."Job Description";

                // 2. Calculate the Rank (Option A: 1, 1, 3 rule)
                if CurrentReqNo <> "Employee Requisition No" then begin
                    // Reset rank for a new Job Requisition
                    CurrentReqNo := "Employee Requisition No";
                    Rank := 1;
                    ActualRank := 1;
                    PrevScore := "Stage Score";
                end else begin
                    ActualRank += 1;
                    // Only drop the rank number if the score is actually lower
                    if "Stage Score" < PrevScore then begin
                        Rank := ActualRank;
                        PrevScore := "Stage Score";
                    end;
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        HREmpReq: Record "HR Employee Requisitions";
        JobTitle: Text[200];
        CurrentReqNo: Code[20];
        Rank: Integer;
        ActualRank: Integer;
        PrevScore: Decimal;
}