#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185479 "HR Leave Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Leave Schedule.rdl';

    dataset
    {
        dataitem("HR Leave Planner Header"; "HR Leave Planner Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("HR Leave Planner Lines"; "HR Leave Planner Lines")
            {
                DataItemLink = "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"), "Shortcut Dimension 3 Code" = field("Shortcut Dimension 3 Code"), "Shortcut Dimension 4 Code" = field("Shortcut Dimension 4 Code"), Year = field(Year), "Document Number" = field(No);
                column(ReportForNavId_2; 2)
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
}
