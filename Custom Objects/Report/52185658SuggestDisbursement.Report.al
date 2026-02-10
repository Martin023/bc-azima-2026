#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185658 "Suggest Disbursement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Suggest Disbursement.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan Product Type", "Captured By", "Approved Amount", "Disbursement Date", "Application Date";
            column(ReportForNavId_1; 1)
            {
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

    var
        DisbLines: Record "Loan Disbursement Lines";
        DisbHeader: Record "Loan Disbursement Header";
}
