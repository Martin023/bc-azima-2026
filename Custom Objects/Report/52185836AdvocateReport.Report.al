#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185836 "Advocate Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Advocate Report.rdl';

    dataset
    {
        dataitem(Advocate; Advocate)
        {

            column(No_Advocate; Advocate.No)
            {
            }
            column(Name_Advocate; Advocate.Name)
            {
            }
            column(TypeofFirm_Advocate; Advocate."Type of Firm")
            {
            }
            column(LineNo_Advocate; Advocate."Line No")
            {
            }
            column(FirmNo_Advocate; Advocate."Firm No")
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
}
