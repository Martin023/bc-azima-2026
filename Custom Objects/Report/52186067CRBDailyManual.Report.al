

Report 52186067 "CRB Daily Manual"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/CRB Daily Manual.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Application Date", "Disbursement Date", "Loan Product Type";

            DataItemTableView = where(Posted = const(true), Defaulted = const(false));
            column(Loan_No_; "Loan No.")
            {

            }


            trigger OnAfterGetRecord()
            begin
                BulkProcessing.GenerateCRBDaily(Loans, BatchNo);
            end;


            trigger OnPreDataItem()
            var
                CRBDaily: Record "CRB Daily Manual";
                BulkErrors: Record "Bulk Processing Errors";
            begin
                BatchNo := Format(CurrentDateTime);

                CRBDaily.Reset();
                CRBDaily.DeleteAll();

                BulkErrors.Reset();
                BulkErrors.SetRange(Process, BulkErrors.Process::"CRB Daily");
                BulkErrors.DeleteAll();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {

            }
        }
    }

    var
        BatchNo: Code[20];
        BulkProcessing: Codeunit "Bulk Processing";


}
