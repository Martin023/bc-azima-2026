#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185442 "Mod Already Approved Batches"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Mod Already Approved Batches.rdl';

    dataset
    {
        dataitem("Loan Disbursement Header"; "Loan Disbursement Header")
        {
            DataItemTableView = where(Status = const(Pending));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                ApprovalENt.Reset;
                ApprovalENt.SetRange(ApprovalENt."Record ID to Approve", "Loan Disbursement Header".RecordId);
                ApprovalENt.SetRange(ApprovalENt.Status, ApprovalENt.Status::Approved);
                ApprovalENt.SetRange(ApprovalENt."Due Date", 20181005D);
                if ApprovalENt.Find('-') then begin
                    "Loan Disbursement Header".Status := "Loan Disbursement Header".Status::Approved;
                    "Loan Disbursement Header".Modify;
                    //MESSAGE('the record id to approve is %1',ApprovalENt."Record ID to Approve")
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

    var
        ApprovalENt: Record "Approval Entry";
}
