#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185858 "Update Posted"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Update Posted.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Status = const(Approved));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Posted := true;
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
