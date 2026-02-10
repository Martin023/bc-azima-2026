#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185871 "Count Of Users"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Count Of Users.rdl';

    dataset
    {
        //dataitem(52185476; 52185476)
        dataitem("Sky USSD Auth"; "Sky USSD Auth")
        {
            RequestFilterFields = IMEI, "Force PIN";
            column(ReportForNavId_1; 1)
            {
            }
            column(NumberOfUsers; NumberOfUsers)
            {
            }

            trigger OnAfterGetRecord()
            begin
                NumberOfUsers += 1;
            end;

            trigger OnPostDataItem()
            begin
                Message(Format(NumberOfUsers));
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
        NumberOfUsers: Integer;
}
