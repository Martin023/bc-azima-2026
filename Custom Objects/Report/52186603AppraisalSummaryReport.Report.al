report 52186603 "Appraisal Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layout\AppraisalSummaryReport.rdl';
    Caption = 'Appraisal Summary Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Individual Targets Header"; "HR Individual Targets Header")
        {
            RequestFilterFields = "Appraisal Year", "Appraisal Cycle Stage", Status, "Responsibility Center", "Supervisor ID";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Filter_Appraisal_Year; FilterAppraisalYear)
            {
            }
            column(Filter_Cycle_Stage; FilterCycleStage)
            {
            }
            column(Filter_Status; FilterStatus)
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
            column(Appraisal_Cycle_Stage; "Appraisal Cycle Stage")
            {
            }
            column(Status; Status)
            {
            }
            column(Responsibility_Center; "Responsibility Center")
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
            column(Achievement_Percentage; AchievementPercentage)
            {
            }
            column(Appraisee_Submitted; "Appraisee Submitted")
            {
            }
            column(Has_Disagreements; "Has Disagreements")
            {
            }
            column(Unresolved_Discussions; "Unresolved Discussions")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Total Targeted Score", "Total Achieved Score", "Total Agreed Rating", "Has Disagreements", "Unresolved Discussions");
                
                if "Total Targeted Score" <> 0 then
                    AchievementPercentage := ("Total Achieved Score" / "Total Targeted Score") * 100
                else
                    AchievementPercentage := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowOnlyCompleted; ShowOnlyCompleted)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Completed Appraisals';
                    }
                    field(ShowOnlyWithDisagreements; ShowOnlyWithDisagreements)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Appraisals with Disagreements';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);

        FilterAppraisalYear := "HR Individual Targets Header".GetFilter("Appraisal Year");
        FilterCycleStage := Format("HR Individual Targets Header".GetFilter("Appraisal Cycle Stage"));
        FilterStatus := Format("HR Individual Targets Header".GetFilter(Status));

        if ShowOnlyCompleted then
            "HR Individual Targets Header".SetFilter(Status, '%1|%2', "HR Individual Targets Header".Status::Posted, "HR Individual Targets Header".Status::Closed);

        if ShowOnlyWithDisagreements then
            "HR Individual Targets Header".SetRange("Has Disagreements", true);
    end;

    var
        CompanyInfo: Record "Company Information";
        AchievementPercentage: Decimal;
        FilterAppraisalYear: Text;
        FilterCycleStage: Text;
        FilterStatus: Text;
        ShowOnlyCompleted: Boolean;
        ShowOnlyWithDisagreements: Boolean;
}
