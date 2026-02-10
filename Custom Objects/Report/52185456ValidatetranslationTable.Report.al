#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185456 "Validate translation Table"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Validate translation Table.rdl';

    dataset
    {
        dataitem("Data Translation"; "Data Translation")
        {
            //DataItemTableView = where("Cheque Account No" = filter(<> ""));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*Member.RESET;
                Member.SETRANGE("No.","Data Translation"."Member No");
                IF Member.FIND('-') THEN BEGIN
                  "Data Translation"."Member Name":=Member.Name;
                  "Data Translation".MODIFY;
                  END;
                */

                "Data Translation".Used := true;
                "Data Translation".Modify;

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
        Member: Record "Members";
}
