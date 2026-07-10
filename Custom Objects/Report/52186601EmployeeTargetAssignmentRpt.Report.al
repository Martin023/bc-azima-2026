report 52186601 "Employee Target Assignment Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layout\EmployeeTargetAssignmentRpt.rdl';
    Caption = 'Employee Target Assignment Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Employee Target Assignment"; "HR Employee Target Assignment")
        {
            RequestFilterFields = "Assignment No", "Department Target No", "Employee No", Status, "Appraisal Year";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Assignment_No; "Assignment No")
            {
            }
            column(Department_Target_No; "Department Target No")
            {
            }
            column(Department_Name; "Department Name")
            {
            }
            column(HOD_Name; "HOD Name")
            {
            }
            column(Employee_No; "Employee No")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Perspective_Code; "Perspective Code")
            {
            }
            column(Perspective_Name; "Perspective Name")
            {
            }
            column(Objective; Objective)
            {
            }
            column(Strategy; Strategy)
            {
            }
            column(Measures; Measures)
            {
            }
            column(Baseline; Baseline)
            {
            }
            column(Targeted_Score; "Targeted Score")
            {
            }
            column(Status; Status)
            {
            }
            column(Employee_Accepted; "Employee Accepted")
            {
            }
            column(Employee_Comments; "Employee Comments")
            {
            }
            column(Appraisal_Year; "Appraisal Year")
            {
            }
            column(Assigned_Date; "Assigned Date")
            {
            }
            column(Incorporated_Into_Appraisal_No; "Incorporated Into Appraisal No")
            {
            }
            column(Incorporated_Date; "Incorporated Date")
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
