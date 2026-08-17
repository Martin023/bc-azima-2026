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
        addafter(ToApprove)
        {
            field(RecordIdentifier; RecordIdentifier)
            {
                ApplicationArea = Basic;
                Editable = false;
                Caption = 'Record No.';
                Visible = ShowRecordFields;
            }
            field(RecordName; RecordName)
            {
                ApplicationArea = Basic;
                Editable = false;
                Caption = 'Record Name';
                Visible = ShowRecordFields;
            }
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
                MemberAppRec: Record "Member Application";
                SystemEditsRec: Record "System Edits";
                SystemEditsCodeunit: Codeunit "System Editss";
                RecRef: RecordRef;
                Action: Option SetFilter,PostChanges;
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

                // Member Application approval
                MemberAppRec.Reset();
                MemberAppRec.SetRange("No.", Rec."Document No.");
                if MemberAppRec.FindFirst() then begin
                    if MemberAppRec.Status <> MemberAppRec.Status::Approved then begin
                        IF not ApprovalsMgmt.HasOpenApprovalEntries(MemberAppRec.RecordId) THEN BEGIN
                            MemberAppRec.Status := MemberAppRec.Status::Approved;
                            MemberAppRec.Validate(Status, MemberAppRec.Status::Approved);
                            MemberAppRec.Modify();
                        end;
                    end;
                end;

                // System Edits approval
                SystemEditsRec.Reset();
                SystemEditsRec.SetRange("No.", Rec."Document No.");
                if SystemEditsRec.FindFirst() then begin
                    if SystemEditsRec.Status <> SystemEditsRec.Status::Approved then begin
                        IF not ApprovalsMgmt.HasOpenApprovalEntries(SystemEditsRec.RecordId) THEN BEGIN
                            SystemEditsRec.Status := SystemEditsRec.Status::Approved;
                            SystemEditsRec.Validate(Status, SystemEditsRec.Status::Approved);
                            SystemEditsRec.Modify();
                        end;
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
        RecordIdentifier: Code[50];
        RecordName: Text[100];
        ShowRecordFields: Boolean;
        Loans: Record Loans;

    trigger OnAfterGetRecord()
    var
        LoanRec: Record Loans;
        MemberAppRec: Record "Member Application";
        SystemEditsRec: Record "System Edits";
        SystemEditsFilters: Record "System Edits Filters";
        MemberRec: Record Members;
        LeaveAppRec: Record "HR Leave Application";
    begin
        // Reset visibility and values
        ShowRecordFields := false;
        RecordIdentifier := '';
        RecordName := '';

        // Detect record type and populate fields accordingly
        
        // 1. Check if it's a Loan approval
        if LoanRec.Get(Rec."Record ID to Approve") then begin
            RecordIdentifier := LoanRec."Member No.";
            RecordName := LoanRec."Member Name";
            ShowRecordFields := true;
        end
        // 2. Check if it's a Member Application approval
        else if MemberAppRec.Get(Rec."Document No.") then begin
            RecordIdentifier := MemberAppRec."No.";
            RecordName := MemberAppRec.Name;
            ShowRecordFields := true;
        end
        // 3. Check if it's a Leave Application approval
        else if LeaveAppRec.Get(Rec."Document No.") then begin
            RecordIdentifier := LeaveAppRec."Applicant Staff No.";
            RecordName := LeaveAppRec.Names;
            ShowRecordFields := true;
        end
        // 4. Check if it's a System Edits approval
        else if SystemEditsRec.Get(Rec."Document No.") then begin
            // Only show for Members table (52185700) or Image Data table (52185702)
            if (SystemEditsRec."Table ID" = 52185700) or (SystemEditsRec."Table ID" = 52185702) then begin
                // Read the filter value which contains the Member No.
                SystemEditsFilters.Reset();
                SystemEditsFilters.SetRange("Record ID", SystemEditsRec."No.");
                if SystemEditsFilters.FindFirst() then begin
                    RecordIdentifier := SystemEditsFilters.Filter;
                    
                    // Get member name
                    if MemberRec.Get(SystemEditsFilters.Filter) then
                        RecordName := MemberRec.Name;
                    
                    ShowRecordFields := true;
                end;
            end;
        end;
    end;

    trigger OnOpenPage()
    BEGIN
        // Initialize loan member data on page open if exists
        if Loans.get(rec."Record ID to Approve") then begin
            RecordIdentifier := Loans."Member No.";
            RecordName := Loans."Member Name";
            ShowRecordFields := true;
        end;
    END;

}
