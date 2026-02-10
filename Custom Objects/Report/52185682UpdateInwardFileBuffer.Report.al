#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185682 "Update Inward File Buffer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Update Inward File Buffer.rdl';

    dataset
    {
        dataitem("Inward file Buffer"; "Inward file Buffer")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Refno.Reset;
                Refno.SetRange(Refno.CurrUserID, "Inward file Buffer".CurrentUserID);
                if Refno.Find('-') then begin
                    "Inward file Buffer"."Transaction Code2" := Refno."Reference No";
                    "Inward file Buffer".Modify;
                end;
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
        Refno: Record "Refference Number";
}
