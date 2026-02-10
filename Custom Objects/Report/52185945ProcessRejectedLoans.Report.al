#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185945 "Process Rejected Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Process Rejected Loans.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Posted = filter(No), "Application Date" = filter(<> ""));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CalcDate('3M', Loans."Application Date") < Today then begin
                    Loans.Status := Loans.Status::Rejected;
                    if Loans."Loan Rejection Reason" = '' then
                        Loans."Loan Rejection Reason" := 'Loan application expired';
                    Loans.Modify;
                end;
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
