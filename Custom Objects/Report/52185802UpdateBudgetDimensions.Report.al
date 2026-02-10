#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185802 "Update Budget Dimensions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Update Budget Dimensions.rdl';

    dataset
    {
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "G/L Budget Entry".Validate("G/L Budget Entry"."Global Dimension 1 Code");
                "G/L Budget Entry".Validate("G/L Budget Entry"."Global Dimension 2 Code");
                "G/L Budget Entry".Validate("G/L Budget Entry"."Budget Dimension 1 Code");
                "G/L Budget Entry".Validate("G/L Budget Entry"."Budget Dimension 2 Code");
                "G/L Budget Entry".Modify;
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
