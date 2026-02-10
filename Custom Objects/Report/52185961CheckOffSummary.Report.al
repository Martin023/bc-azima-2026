#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185961 "CheckOff Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/CheckOff Summary.rdl';

    dataset
    {
        dataitem(CheckoffHeader; "Checkoff Header")
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "Posting Date", "Account Type", "Account No.";
            column(ReportForNavId_1; 1)
            {
            }


            column(Picture; Company.Picture)
            {
            }
            column(Company_Name; Company.Name)
            {
            }

            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }

            trigger OnPreDataItem()
            begin
                StartDate := CheckoffHeader.GetRangeMin("Posting Date");
                EndDate := CheckoffHeader.GetRangemax("Posting Date");

                Company.Get;
                Company.CalcFields(Company.Picture);
                //DateFilter:=Loan.GETFILTER("Date Filter");
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
        Company: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
}
