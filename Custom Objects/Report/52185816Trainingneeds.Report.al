#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185816 "Training needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Training needs.rdl';

    dataset
    {
        dataitem("HR Training Needs"; "HR Training Needs")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(TrainingType_HRTrainingNeeds; "HR Training Needs"."Training Type")
            {
            }
            column(Code_HRTrainingNeeds; "HR Training Needs".Code)
            {
            }
            column(Description_HRTrainingNeeds; "HR Training Needs".Description)
            {
            }
            column(StartDate_HRTrainingNeeds; "HR Training Needs"."Start Date")
            {
            }
            column(EndDate_HRTrainingNeeds; "HR Training Needs"."End Date")
            {
            }
            column(TotalCosts_HRTrainingNeeds; "HR Training Needs"."Total Costs")
            {
            }
            column(Status_HRTrainingNeeds; "HR Training Needs".Status)
            {
            }
            column(Duration_HRTrainingNeeds; "HR Training Needs".Duration)
            {
            }
            column(TrainingCategory_HRTrainingNeeds; "HR Training Needs"."Training Category")
            {
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
}
