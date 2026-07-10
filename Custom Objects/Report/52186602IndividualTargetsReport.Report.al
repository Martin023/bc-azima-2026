report 52186602 "Individual Targets Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layout\IndividualTargetsReport.rdl';
    Caption = 'Individual Targets Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Individual Targets Header"; "HR Individual Targets Header")
        {
            RequestFilterFields = "Appraisal No", "Employee No", "Appraisal Year", "Appraisal Cycle Stage", Status, "Responsibility Center";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Appraisal_No; "Appraisal No")
            {
            }
            column(Employee_No; "Employee No")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Appraisal_Year; "Appraisal Year")
            {
            }
            column(Appraisal_Period; "Appraisal Period")
            {
            }
            column(Appraisal_Cycle_Stage; "Appraisal Cycle Stage")
            {
            }
            column(Appraisal_Date; "Appraisal Date")
            {
            }
            column(Status; Status)
            {
            }
            column(Responsibility_Center; "Responsibility Center")
            {
            }
            column(Supervisor_ID; "Supervisor ID")
            {
            }
            column(Supervisor_Name; "Supervisor Name")
            {
            }
            column(Total_Targeted_Score; "Total Targeted Score")
            {
            }
            column(Total_Achieved_Score; "Total Achieved Score")
            {
            }
            column(Total_Agreed_Rating; "Total Agreed Rating")
            {
            }
            column(Appraisee_Submitted; "Appraisee Submitted")
            {
            }
            column(Appraisee_Submission_Date; "Appraisee Submission Date")
            {
            }
            column(Source_Type; "Source Type")
            {
            }
            column(Source_Department_Target_No; "Source Department Target No")
            {
            }

            dataitem("HR Individual Target Line"; "HR Individual Target Line")
            {
                DataItemLink = "Appraisal No" = FIELD("Appraisal No");
                column(Line_No; "Line No")
                {
                }
                column(Target_Perspective_Code; "Perspective Code")
                {
                }
                column(Target_Perspective_Description; "Perspective Description")
                {
                }
                column(Target_Objective; Objective)
                {
                }
                column(Target_Strategy; Strategy)
                {
                }
                column(Target_Measures; Measures)
                {
                }
                column(Target_Baseline; Baseline)
                {
                }
                column(Target_Targeted_Score; "Targeted Score")
                {
                }
                column(Target_Achieved_Score; "Achieved Score")
                {
                }
                column(Target_Unachieved_Targets; "Unachieved Targets")
                {
                }
                column(Target_Self_Rating; "Self Rating")
                {
                }
                column(Target_Supervisor_Rating; "Supervisor Rating")
                {
                }
                column(Target_Agreed_Rating; "Agreed Rating")
                {
                }
                column(Target_Appraisee_Comments; "Appraisee Comments")
                {
                }
                column(Target_Appraiser_Comments; "Appraiser Comments")
                {
                }
                column(Target_Change; Change)
                {
                }
                column(Target_Score; Score)
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
