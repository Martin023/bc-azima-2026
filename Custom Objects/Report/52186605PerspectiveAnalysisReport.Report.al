report 52186605 "Perspective Analysis Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/PerspectiveAnalysisReport.rdl';
    Caption = 'Perspective Analysis Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Perspectives Setup"; "HR Perspectives Setup")
        {
            RequestFilterFields = "Perspective No", "Perspective Name", "Scoring Method";
            
            // Full Company Information
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code") { }
            column(CompanyInfo_Phone; CompanyInfo."Phone No." + ' ' + CompanyInfo."Phone No. 2") { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }

            // Perspective Header Fields
            column(Perspective_No; "Perspective No") { }
            column(Perspective_Name; "Perspective Name") { }
            column(Description; Description) { }
            column(Scoring_Method; "Scoring Method") { }
            column(Result_Label; "Result Label") { }
            
            // Perspective Summary Averages
            column(Average_Targeted; AverageTargeted) { }
            column(Average_Achieved; AverageAchieved) { }
            column(Average_Rating; AverageRating) { }

            dataitem("HR Individual Target Line"; "HR Individual Target Line")
            {
                DataItemLink = "Perspective Code" = FIELD("Perspective No");
                DataItemTableView = WHERE(Status = FILTER(Approved | Posted));
                
                column(Target_Line_No; "Line No") { }
                column(Target_Appraisal_No; "Appraisal No") { }
                column(Target_Objective; Objective) { }
                column(Target_Targeted_Score; "Targeted Score") { }
                column(Target_Achieved_Score; "Achieved Score") { }
                column(Target_Agreed_Rating; "Agreed Rating") { }
                column(Target_Employee_Name; EmployeeName) { }
                column(Target_Achievement_Percentage; AchievementPercentage) { }

                trigger OnAfterGetRecord()
                var
                    IndivHeader: Record "HR Individual Targets Header";
                begin
                    if IndivHeader.Get("Appraisal No") then
                        EmployeeName := IndivHeader."Employee Name"
                    else
                        EmployeeName := '';

                    if "Targeted Score" <> 0 then
                        AchievementPercentage := ("Achieved Score" / "Targeted Score") * 100
                    else
                        AchievementPercentage := 0;

                    TotalTargeted += "Targeted Score";
                    TotalAchieved += "Achieved Score";
                    TotalAgreedRating += "Agreed Rating";
                    RecordCount += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalTargeted := 0;
                TotalAchieved := 0;
                TotalAgreedRating := 0;
                RecordCount := 0;
            end;

            trigger OnPostDataItem()
            begin
                if RecordCount > 0 then begin
                    AverageTargeted := TotalTargeted / RecordCount;
                    AverageAchieved := TotalAchieved / RecordCount;
                    AverageRating := TotalAgreedRating / RecordCount;
                end else begin
                    AverageTargeted := 0;
                    AverageAchieved := 0;
                    AverageRating := 0;
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        EmployeeName: Text[200];
        AchievementPercentage: Decimal;
        TotalTargeted: Decimal;
        TotalAchieved: Decimal;
        TotalAgreedRating: Decimal;
        RecordCount: Integer;
        AverageTargeted: Decimal;
        AverageAchieved: Decimal;
        AverageRating: Decimal;
}