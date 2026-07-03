report 52186344 "Shortlisted Candidates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ShortListed Candidates Report.rdl';
    Caption = 'Shortlisted Candidates Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    
    dataset
    {
        dataitem(HREmployeeRequisitions; "HR Employee Requisitions")
        {
            RequestFilterFields = "Requisition No.", "Job ID", "Approval Status", "Requisition Date", "Closing Date";
            
            column(RequisitionNo; "Requisition No.")
            {
            }
            column(JobID; "Job ID")
            {
            }
            column(JobDescription; "Job Description")
            {
            }
            column(RequiredPositions; "Required Positions")
            {
            }
            column(RequisitionDate; "Requisition Date")
            {
            }
            column(ClosingDate; "Closing Date")
            {
            }
            column(TotalRecruitmentCost; "Total Recruitment Cost")
            {
            }
            column(NoOfApplications; NoOfApplications)
            {
            }
            column(NoQualified; NoQualified)
            {
            }
            column(NoDisqualified; NoDisqualified)
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(EmploymentType; "Employment Type")
            {
            }
            column(ApprovalStatus; "Approval Status")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
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
            column(ShowCostBreakdown; ShowCostBreakdown)
            {
            }
            
            dataitem(RecruitmentCosts; "Recruitment Costs")
            {
                DataItemLink = "Requisition No." = field("Requisition No.");
                DataItemTableView = sorting("Requisition No.", "Training ID", "Cost Item") order(ascending);
                
                column(CostItem; "Cost Item")
                {
                }
                column(CostItemDescription; "Cost Item Description")
                {
                }
                column(Cost; Cost)
                {
                }
            }
            
            dataitem(HRShortlistedApplicants; "HR Shortlisted Applicants")
            {
                DataItemLink = "Employee Requisition No" = field("Requisition No.");
                DataItemTableView = sorting("Stage Score") order(descending);
                
                column(JobApplicationNo; "Job Application No")
                {
                }
                column(FullName; "Full Name")
                {
                }
                column(IDNo; "ID No")
                {
                }
                column(Gender; Gender)
                {
                }
                column(MaritalStatus; "Marital Status")
                {
                }
                column(StageScore; "Stage Score")
                {
                }
                column(Qualified; Qualified)
                {
                }
                column(QualificationStatus; QualificationStatus)
                {
                }
                
                trigger OnAfterGetRecord()
                begin
                    if Qualified then
                        QualificationStatus := 'Qualified'
                    else
                        QualificationStatus := 'Disqualified';
                end;
            }
            
            trigger OnAfterGetRecord()
            begin
                HRJobApplications.Reset;
                HRJobApplications.SetRange("Employee Requisition No", "Requisition No.");
                NoOfApplications := HRJobApplications.Count;
                
                // RENAMED VARIABLE TO AVOID CONFLICT WITH DATAITEM
                ShortlistedApplicantsRec.Reset;
                ShortlistedApplicantsRec.SetRange("Employee Requisition No", "Requisition No.");
                ShortlistedApplicantsRec.SetRange(Qualified, true);
                NoQualified := ShortlistedApplicantsRec.Count;
                
                NoDisqualified := NoOfApplications - NoQualified;
                
                CalcFields("Total Recruitment Cost");
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
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowOnlyQualified; ShowOnlyQualified)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Qualified Candidates';
                    }
                    field(ShowCostBreakdown; ShowCostBreakdown)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Cost Breakdown';
                        ToolTip = 'Shows detailed breakdown of recruitment costs per requisition';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        
        // RENAMED VARIABLE TO AVOID CONFLICT WITH DATAITEM
        if ShowOnlyQualified then
            HRShortlistedApplicants.SetRange(Qualified, true);
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        HRJobApplications: Record "HR Job Applications";
        ShortlistedApplicantsRec: Record "HR Shortlisted Applicants";
        NoOfApplications: Integer;
        NoQualified: Integer;
        NoDisqualified: Integer;
        QualificationStatus: Text;
        ShowOnlyQualified: Boolean;
        ShowCostBreakdown: Boolean;
}
