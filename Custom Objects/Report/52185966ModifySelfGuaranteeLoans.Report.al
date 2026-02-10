#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185966 "Modify Self Guarantee Loans"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans."Self Guarantee" := false;
                Loans.Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('DONE!!!')
            end;

            trigger OnPreDataItem()
            begin
                if Loans.GetFilter("Loan No.") = '' then Error('Kindly Specify the Loan No')
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
