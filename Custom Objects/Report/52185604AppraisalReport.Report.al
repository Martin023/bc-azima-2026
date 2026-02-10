#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185604 "Appraisal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Appraisal Report.rdl';

    dataset
    {
        dataitem("HR Individual Targets Header"; "HR Individual Targets Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(AppraisalNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal No")
            {
            }
            column(AppraisalPeriod_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Period")
            {
            }
            column(AppraisalDate_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Date")
            {
            }
            column(EmployeeNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee No")
            {
            }
            column(Status_HRIndividualTargetsHeader; "HR Individual Targets Header".Status)
            {
            }
            column(UserID_HRIndividualTargetsHeader; "HR Individual Targets Header"."User ID")
            {
            }
            column(SupervisorID_HRIndividualTargetsHeader; "HR Individual Targets Header"."Supervisor ID")
            {
            }
            column(SupervisorName_HRIndividualTargetsHeader; "HR Individual Targets Header"."Supervisor Name")
            {
            }
            column(EmployeeName_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee Name")
            {
            }
            // column(Picture; Compinfo.Picture)
            // {
            // }
            dataitem("HR Individual Target Line"; "HR Individual Target Line")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");
                column(ReportForNavId_11; 11)
                {
                }
                column(AppraisalNo_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal No")
                {
                }
                column(PerspectiveCode_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Code")
                {
                }
                column(PerspectiveDescription_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Description")
                {
                }
                column(TargetedScore_HRIndividualTargetLine; "HR Individual Target Line"."Targeted Score")
                {
                }
                column(PerspectiveType_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Type")
                {
                }
                column(AchievedScore_HRIndividualTargetLine; "HR Individual Target Line"."Achieved Score")
                {
                }
                column(AppraiseeComments_HRIndividualTargetLine; "HR Individual Target Line"."Appraisee Comments")
                {
                }
                column(Objective_HRIndividualTargetLine; "HR Individual Target Line".Objective)
                {
                }
                column(AgreedRating_HRIndividualTargetLine; "HR Individual Target Line"."Agreed Rating")
                {
                }
                column(AppraisalPeriod_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal Period")
                {
                }
                column(Strategy_HRIndividualTargetLine; "HR Individual Target Line".Strategy)
                {
                }
                column(Measures_HRIndividualTargetLine; "HR Individual Target Line".Measures)
                {
                }
                column(Baseline_HRIndividualTargetLine; "HR Individual Target Line".Baseline)
                {
                }
                column(Change_HRIndividualTargetLine; "HR Individual Target Line".Change)
                {
                }
            }
            dataitem("Performance Attributes"; "Performance Attributes")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");
                column(ReportForNavId_26; 26)
                {
                }
                column(LineNo_PerformanceAttributes; "Performance Attributes"."Line No.")
                {
                }
                column(AppraisalNo_PerformanceAttributes; "Performance Attributes"."Appraisal No")
                {
                }
                column(Attribute_PerformanceAttributes; "Performance Attributes".Attribute)
                {
                }
                column(Description_PerformanceAttributes; "Performance Attributes".Description)
                {
                }
                column(Target_PerformanceAttributes; "Performance Attributes".Target)
                {
                }
                column(Weight_PerformanceAttributes; "Performance Attributes".Weight)
                {
                }
                column(AdditionalComments_PerformanceAttributes; "Performance Attributes"."Additional Comments")
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Compinfo.Reset;
        Compinfo.Get;
        Compinfo.CalcFields(Compinfo.Picture);
    end;

    var
        Compinfo: Record "Company Information";
}
