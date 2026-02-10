#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185923 "Clear Update Employer Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Clear Update Employer Code.rdl';

    dataset
    {
        dataitem("Update Employer Code"; "Update Employer Code")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Update Employer Code".DeleteAll
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
}
