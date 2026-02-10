#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185859 "Update Picked Mobile Loan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Update Picked Mobile Loan.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Posted = const(Yes), "Picked Mobile Loan" = const(No), "Loan No." = filter("EM*" | "JS*" | "SF*" | "DE*"));
            RequestFilterFields = "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans."Picked Mobile Loan" := true;
                Loans.Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Successful');
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
