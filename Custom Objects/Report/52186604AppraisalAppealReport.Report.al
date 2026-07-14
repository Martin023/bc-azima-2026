report 52186604 "Appraisal Appeal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout\AppraisalAppealReport.rdl';
    Caption = 'Appraisal Appeal Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Appraissal Appeal"; "HR Appraissal Appeal")
        {
            RequestFilterFields = "No.", "Employee No.", "Appraissal Period", Status, Department, "Responsibility Center";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(No; "No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Appraisser_No; "Appraisser No.")
            {
            }
            column(Appraiser_Name; "Appraiser Name")
            {
            }
            column(Appraissal_Period; "Appraissal Period")
            {
            }
            column(Reason; Reason)
            {
            }
            column(Comments; Comments)
            {
            }
            column(Region; Region)
            {
            }
            column(Department; Department)
            {
            }
            column(Responsibility_Center; "Responsibility Center")
            {
            }
            column(Status; Status)
            {
            }
            column(User_ID; "User ID")
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
