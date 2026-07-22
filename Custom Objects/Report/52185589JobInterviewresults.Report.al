Report 52185589 "Job Interview results"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Job Interview results.rdl';
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