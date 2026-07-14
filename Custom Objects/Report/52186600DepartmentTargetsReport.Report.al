report 52186600 "Department Targets Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout\DepartmentTargetsReport.rdl';
    Caption = 'Department Targets Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Department Targets Header"; "HR Department Targets Header")
        {
            RequestFilterFields = "Target No", "Responsibility Center", "Appraisal Year", Status;
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Target_No; "Target No")
            {
            }
            column(Responsibility_Center; "Responsibility Center")
            {
            }
            column(Department_Name; "Department Name")
            {
            }
            column(HOD_Employee_No; "HOD Employee No")
            {
            }
            column(HOD_Name; "HOD Name")
            {
            }
            column(Appraisal_Year; "Appraisal Year")
            {
            }
            column(Status; Status)
            {
            }
            column(Created_By; "Created By")
            {
            }

            dataitem("HR Department Target Line"; "HR Department Target Line")
            {
                DataItemLink = "Department Target No" = FIELD("Target No");
                column(Line_No; "Line No")
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
