report 52185524 "Recruitment Cost Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/RecruitmentCostReport.rdl';
    Caption = 'Recruitment Cost Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            // Added Filters so users can filter by specific requisitions or jobs
            RequestFilterFields = "Requisition No.", "Job ID", "Approval Status", "Requisition Date";
            
            // Full Company Info for Header
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code") { }
            column(CompanyInfo_Phone; CompanyInfo."Phone No." + ' ' + CompanyInfo."Phone No. 2") { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            
            // Requisition Header Fields
            column(Requisition_No; "Requisition No.") { }
            column(Job_ID; "Job ID") { }
            column(Job_Description; "Job Description") { } // Used as the Requisition Name
            column(Requisition_Date; Format("Requisition Date")) { }
            column(Approval_Status; Format("Approval Status")) { }
            column(Total_Recruitment_Cost; "Total Recruitment Cost") { }

            // Child table for multiple costs per requisition
            dataitem("Recruitment Costs"; "Recruitment Costs")
            {
                DataItemLink = "Requisition No." = FIELD("Requisition No.");
                
                column(Cost_Item; "Cost Item") { }
                column(Cost_Item_Description; "Cost Item Description") { }
                column(Cost; Cost) { }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}