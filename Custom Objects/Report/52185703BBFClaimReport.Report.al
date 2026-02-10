#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185703 "BBF Claim TAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BBF Claim Report.rdl';

    dataset
    {
        dataitem("Insurance Claims"; "Insurance Claims")
        {

            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(Claim_No_; "Claim No.")
            {
            }
            column(Date_of_Claim; "Date of Claim")
            {
            }
            column(Created_By; "Created By")
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        sno: Integer;
        CompanyInformation: Record "Company Information";
}
