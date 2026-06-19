#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185473 "Poppulate Image Data"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Update Images+.rdl';
    UsageCategory = Administration;
    Caption = '1.1. Poppulate Image Data';

    dataset
    {
        dataitem("Pictures and Signtures"; Members)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Img.Reset();
                img.SetRange("Member No", "No.");
                if not Img.find('-') then begin
                    Img.Init;
                    Img."Member No" := "Pictures and Signtures"."No.";
                    Img."Old Member No." := "Pictures and Signtures"."Old Member No.";
                    Img.Insert;
                end
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

    var
        SaccoAccount: Record "Social Listening Sites App.";
        Img: Record "Image Data";
}
