namespace BCWMNS.BCWMNS;

report 52186176 "Delete From PR Transactioncode"
{

    ApplicationArea = All;
    Caption = 'Delete From PR Transactioncode';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PRTransactionCodes; "PR Transaction Codes")
        {
            
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
