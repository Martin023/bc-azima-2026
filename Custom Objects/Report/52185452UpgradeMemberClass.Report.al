#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185452 "Upgrade Member Class"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Upgrade Member Class.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Member Class Account Type" = filter("Child Hope" | Nominee));

            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Members.CalcFields("Member Class Account Type");
                if Members."Member Class Account Type" = Members."Member Class Account Type"::"Child Hope" then begin
                    GlobalFunctions.ChildHopeGraduation(Members);
                end;
                if Members."Member Class Account Type" = Members."Member Class Account Type"::Nominee then begin
                    GlobalFunctions.NomineeGraduation(Members);
                end;
            end;

            trigger OnPostDataItem()
            begin
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
        GlobalFunctions: Codeunit "Global Functions";
}
