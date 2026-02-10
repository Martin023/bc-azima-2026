#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52185434 "CRB Monthly Manual"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/CRB Mothly Manual.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Total Loan Balance", "Application Date", "Disbursement Date", "Loan Product Type", "Actively Attached", "Actively Attached II";
            DataItemTableView = where(Posted = const(true), "Disbursement Date" = filter(<> ''), "Total Loan Balance" = filter(> 0));
            column(Loan_No_; "Loan No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                BulkProcessing.GenerateCRBMonthly(Loans, BatchNo);
            end;

            trigger OnPreDataItem()
            var
                CRBMonthly: Record "CRB Monthly Manual";
                BulkErrors: Record "Bulk Processing Errors";
            begin
                BatchNo := Format(CurrentDateTime);

                CRBMonthly.Reset();
                CRBMonthly.DeleteAll();

                BulkErrors.Reset();
                BulkErrors.SetRange(Process, BulkErrors.Process::"CRB Monthly");
                BulkErrors.DeleteAll();
            end;
        }
    }

    var
        BatchNo: Code[100];
        BulkProcessing: Codeunit "Bulk Processing";
}
