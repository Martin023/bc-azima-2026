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
            RequestFilterFields = "Requisition No.", "Job ID", "Requisition Date", "Approval Status";

            // Company Info for the Header
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }

            // Requisition Header Details
            column(Requisition_No; "Requisition No.") { }
            column(Job_ID; "Job ID") { }
            column(Job_Description; "Job Description") { }
            column(Requisition_Date; Format("Requisition Date")) { }
            column(Approval_Status; Format("Approval Status")) { }
            column(Total_Recruitment_Cost; "Total Recruitment Cost") { }

            // Child DataItem for the Multiple Costs
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