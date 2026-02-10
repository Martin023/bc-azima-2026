#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52186795 "Process FallOff"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    RDLCLayout = './bc-kenpipe-2024/Layout/FallOff Run.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Loan Product Type", "Disbursement Date";
            column(Loan_No_; "Loan No.")
            {

            }

            trigger OnAfterGetRecord()
            begin
                BulkProcessing.GenerateLoanFallOffOutPut(Loans, BatchNo, AsAt);
            end;

            trigger OnPreDataItem()
            var
                LoanFallOff: Record "Loan FallOff";
                BulkErrors: Record "Bulk Processing Errors";
            begin
                BatchNo := Format(CurrentDateTime);


                LoanFallOff.Reset();
                LoanFallOff.DeleteAll();

                BulkErrors.Reset();
                BulkErrors.SetRange(Process, BulkErrors.Process::"Loan Fall Off");
                BulkErrors.DeleteAll();

                if AsAt = 0D then AsAt := Today;
            end;


        }
    }

    // Request Page
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
                        ToolTip = 'Select the date to filter the report data.';
                    }
                }
            }
        }
    }

    var
        BulkProcessing: Codeunit "Bulk Processing";
        BatchNo: Code[100];
        AsAt: Date;
}
