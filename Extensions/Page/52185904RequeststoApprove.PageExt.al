#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185904 pageextension52185904 extends "Requests to Approve"
{

    layout
    {
        modify(ToApprove)
        {
            ApplicationArea = Basic;
        }
        modify(Details)
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("Sender ID")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }

    }
    actions
    {
        modify("Record")
        {
            ApplicationArea = Basic;

        }
        modify(Comments)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(Approve)
        {

            ApplicationArea = Basic;
            trigger OnAfterAction()
            var
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                StoreReq: record "Store Requistion Header";
                Leave: record "HR Leave Application";
                HrTable: Record "HR Employees";
                GlobalFunctions: Codeunit "Global Functions";
                SalHeader: record "Salary Header";
            begin
                StoreReq.reset;
                StoreReq.setrange("No.", rec."Document No.");
                if StoreReq.FindFirst() then begin
                    if StoreReq.Status = StoreReq.Status::Released then exit;
                    IF not ApprovalsMgmt.HasOpenApprovalEntries(StoreReq.RecordId) THEN BEGIN
                        StoreReq.Status := StoreReq.Status::Released;
                        StoreReq.Modify();
                    end;
                end;
                Leave.reset;
                Leave.setrange("Application Code", rec."Document No.");
                if Leave.FindFirst() then begin
                    if Leave.Status = Leave.Status::Approved then exit;
                    IF not ApprovalsMgmt.HasOpenApprovalEntries(Leave.RecordId) THEN BEGIN
                        Leave.Status := Leave.Status::Approved;
                        Leave.validate(Status, Leave.Status::Approved);
                        Leave.Modify();
                    end;
                end;

                SalHeader.reset;
                SalHeader.setrange(No, rec."Document No.");
                if SalHeader.FindFirst() then begin
                    if SalHeader.Status <> Leave.Status::Approved then begin
                        // IF not ApprovalsMgmt.HasOpenApprovalEntries(Leave.RecordId) THEN BEGIN
                        SalHeader.Status := SalHeader.Status::Approved;
                        SalHeader.validate(Status, SalHeader.Status::Approved);
                        SalHeader.Modify();
                        // end;
                    end;
                end;

                // HrTable.Reset;
                // HrTable.Setrange("No.", Rec."Document No.");
                // if HrTable.Find('-') then begin
                //     if HrTable.Status = HrTable.Status::Rejected then
                //         exit
                //     else begin
                //         if Confirm('Do you want to reject this loans request?') then begin
                //             GlobalFunctions.CommentsManagement(HrTable."No.");
                //             HrTable.Status := HrTable.Status::Rejected;
                //             HrTable.Modify(true);
                //         end;
                //     end
                // end
            end;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Delegate)
        {
            ApplicationArea = Basic;
        }
        modify(OpenRequests)
        {
            ApplicationArea = Basic;
        }
        modify(AllRequests)
        {
            ApplicationArea = Basic;
        }
        addafter(Approve)
        {
            action(clearApprovedEntries)
            {
                ApplicationArea = Basic;

            }
        }
    }

    var
        ApprovalCommentLine: Record "Approval Comment Line";

}
