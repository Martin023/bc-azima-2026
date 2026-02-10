#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185618 "BSC Appraisal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/BSC Appraisal Report.rdl';

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
            column(FinancialTargetedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Financial Targeted Score")
            {
            }
            column(AchievedFinancialScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Achieved Financial  Score")
            {
            }
            column(UnachievedTargets_HRIndividualTargetsHeader; "HR Individual Targets Header"."Unachieved Targets")
            {
            }
            column(EmployeeName_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee Name")
            {
            }
            column(LearningTargetedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Targeted Score")
            {
            }
            column(OperationalTargetScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Delivery Target Score")
            {
            }
            column(ClientMemberTargetScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Target Score")
            {
            }
            column(ClientMemberAchievedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Achieved  Score")
            {
            }
            column(OperationalAchieved_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Delivery Achieved")
            {
            }
            column(LearningAchievedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Achieved  Score")
            {
            }
            column(Status_HRIndividualTargetsHeader; "HR Individual Targets Header".Status)
            {
            }
            column(ResponsibilityCenter_HRIndividualTargetsHeader; "HR Individual Targets Header"."Responsibility Center")
            {
            }
            column(GlobalDimension1Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Shortcut Dimension 4 Code")
            {
            }
            column(AppraisalType_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Type")
            {
            }
            column(Noseries_HRIndividualTargetsHeader; "HR Individual Targets Header"."No series")
            {
            }
            column(AppraisalYear_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Year")
            {
            }
            column(FinanceRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Finance Rating")
            {
            }
            column(ClientMemberRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Rating")
            {
            }
            column(LearningRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Rating")
            {
            }
            column(OperationalRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Rating")
            {
            }
            column(OverallRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Overall Rating")
            {
            }
            column(FinancePercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Finance Perc Score")
            {
            }
            column(ClientMemberPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Perc Score")
            {
            }
            column(LearningPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Perc Score")
            {
            }
            column(OperationalPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Perc Score")
            {
            }
            column(OverallPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Overall Perc Score")
            {
            }
            column(Finance_HRIndividualTargetsHeader; "HR Individual Targets Header".Finance)
            {
            }
            column(ClientMember_HRIndividualTargetsHeader; "HR Individual Targets Header".Customer)
            {
            }
            column(Learning_HRIndividualTargetsHeader; "HR Individual Targets Header".Training)
            {
            }
            column(Operational_HRIndividualTargetsHeader; "HR Individual Targets Header".Service)
            {
            }
            column(UserID_HRIndividualTargetsHeader; "HR Individual Targets Header"."User ID")
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            // dataitem(52185526;52185526)
            // {
            //     column(ReportForNavId_41; 41)
            //     {
            //     }
            //     column(LineNo_HRIndividualTargetLine; "HR Individual Target Line"."Line No")
            //     {
            //     }
            //     column(AppraisalNo_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal No")
            //     {
            //     }
            //     column(PerspectiveCode_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Code")
            //     {
            //     }
            //     column(PerspectiveDescription_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Description")
            //     {
            //     }
            //     column(TargetedScore_HRIndividualTargetLine; "HR Individual Target Line"."Targeted Score")
            //     {
            //     }
            //     column(PerspectiveType_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Type")
            //     {
            //     }
            //     column(AchievedScore_HRIndividualTargetLine; "HR Individual Target Line"."Achieved Score")
            //     {
            //     }
            //     column(UnachievedTargets_HRIndividualTargetLine; "HR Individual Target Line"."Unachieved Targets")
            //     {
            //     }
            //     column(AppraiseeComments_HRIndividualTargetLine; "HR Individual Target Line"."Appraisee Comments")
            //     {
            //     }
            //     column(Objective_HRIndividualTargetLine; "HR Individual Target Line".Objective)
            //     {
            //     }
            //     column(CompanyTarget_HRIndividualTargetLine; "HR Individual Target Line"."Company Target")
            //     {
            //     }
            //     column(StartDate_HRIndividualTargetLine; "HR Individual Target Line"."Start Date")
            //     {
            //     }
            //     column(EndDate_HRIndividualTargetLine; "HR Individual Target Line"."End Date")
            //     {
            //     }
            //     column(SelfRating_HRIndividualTargetLine; "HR Individual Target Line"."Self Rating")
            //     {
            //     }
            //     column(SupervisorRating_HRIndividualTargetLine; "HR Individual Target Line"."Supervisor Rating")
            //     {
            //     }
            //     column(AgreedRating_HRIndividualTargetLine; "HR Individual Target Line"."Agreed Rating")
            //     {
            //     }
            //     column(AppraisalPeriod_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal Period")
            //     {
            //     }
            //     column(AppraisalType_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal Type")
            //     {
            //     }
            //     column(Status_HRIndividualTargetLine; "HR Individual Target Line".Status)
            //     {
            //     }
            //     column(AppraiserComments_HRIndividualTargetLine; "HR Individual Target Line"."Appraiser Comments")
            //     {
            //     }
            //     column(ReviewLineReference_HRIndividualTargetLine; "HR Individual Target Line"."Review Line Reference")
            //     {
            //     }
            //     column(Score_HRIndividualTargetLine; "HR Individual Target Line".Score)
            //     {
            //     }
            //     column(Attributes_HRIndividualTargetLine; "HR Individual Target Line".test)
            //     {
            //     }
            //     column(Strategy_HRIndividualTargetLine; "HR Individual Target Line".Strategy)
            //     {
            //     }
            //     column(Measures_HRIndividualTargetLine; "HR Individual Target Line".Measures)
            //     {
            //     }
            //     column(Baseline_HRIndividualTargetLine; "HR Individual Target Line".Baseline)
            //     {
            //     }
            //     dataitem(52186206;52186206)
            //     {
            //         column(ReportForNavId_69; 69)
            //         {
            //         }
            //         column(Attribute_PerformanceAttributes; "Performance Attributes1".Attribute)
            //         {
            //         }
            //         column(Description_PerformanceAttributes; "Performance Attributes1".Description)
            //         {
            //         }
            //         column(Target_PerformanceAttributes; "Performance Attributes1".Target)
            //         {
            //         }
            //         column(Weight_PerformanceAttributes; "Performance Attributes1".Weight)
            //         {
            //         }
            //         column(AdditonalComments_PerformanceAttributes; "Performance Attributes1"."Additonal Comments")
            //         {
            //         }
            //     }
            // }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
            end;
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
}
