page 52186811 "Debt Collecrtors header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Debt Collectors Header";
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FastTabsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Debt Collector No.";Rec."Debt Collector No.")
                {
                }
                field("Debt Collector Name";Rec."Debt Collector Name")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }
                field("Entry Time";Rec."Entry Time")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field(Closed;Rec.Closed)
                {
                    Editable = false;
                }
                field("Date Closed";Rec."Date Closed")
                {
                    Editable = false;
                }
                field("Closed By";Rec."Closed By")
                {
                    Editable = false;
                }
                field("Responsible Officer";Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID";Rec."Supervisor ID")
                {

                }
            }
            part(DebtLines; "Debt Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Header No." = FIELD("No.");
                
            }
            part(DebtLinesLogs; "Debt Lines Logs")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Header No." = FIELD("No.");
                
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Close Case")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to close this case?') then exit;
                    Rec.Closed := true;
                    Rec."Date Closed" := CurrentDateTime;
                    Rec."Closed By" := UserId;
                    Rec.Modify();
                    Message('Case closed successfully');
                end;
            }
        }
        area(Processing)
        {
            group(Workflows)

            {
                Caption = 'Approvals';
                Visible = false;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Visible = SendApprovalRequestVisible;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ExistingAttachment: Record "Loan Recovery Header";
                    begin

                        if not Confirm('Are you sure you want to send this record for approval?') then exit;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this document?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you you want to cancel this record for approval?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        Message('Document cancelled successfully');
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to reject this approval request?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to delegate this approval request?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reaopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reaopen Card';
                    Image = ReOpen;
                    Visible = ReopenVisible;

                    trigger OnAction()
                    var

                    begin
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    Visible = DeferVisible;

                    trigger OnAction()
                    var
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Confirm('Are you sure you want to deffer this record?') then exit;
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                        Rec.Status := Rec.Status::Deffered;
                        Rec.Validate(Status);
                        Rec.Modify();
                        Message('Record deffered succsessfully');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    var
        Comments: Record Comments;
        ManualFlag: Text;
        Counter: Integer;
    begin
        SetControlAppearance();
    end;

    procedure MimicLoanAttachment(RecoveryHeader: Record "Loan Recovery Header II")
    begin
        if Members.Get(RecoveryHeader."Member No.") then begin
            Members.Subflag := Members.Subflag::Defaulter;
            Members.Modify;

            RecoveryHeader.Action := RecoveryHeader.Action::Recovered;
            RecoveryHeader.Status := RecoveryHeader.Status::Approved;
            RecoveryHeader.Modify();

            if Loans.Get(RecoveryHeader."Loan No.") then begin
                Loans.Defaulted := true;
                Loans."Recovery Level" := Loans."Recovery Level"::"Level 1";
                Loans.Modify();

                RecoveryLines.Reset();
                RecoveryLines.SetRange("Header No.", RecoveryHeader."No.");
                RecoveryLines.SetRange("Recovery Type", RecoveryLines."Recovery Type"::"Guarantor Attachment");
                if RecoveryLines.Find('-') then begin
                    repeat
                        if NewLoans.Get(RecoveryLines."Loan No.") then begin
                            NewLoans."Loan Recovery No." := RecoveryHeader."No.";
                            NewLoans."Recovered Loan" := Loans."Loan No.";
                            NewLoans.Modify();
                        end;
                    until RecoveryLines.Next() = 0;
                end;
            end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

            DetachmentDetailsVisible := true;
            RecoveryLinesVisible := false;
            RecoveryDetailsVisible := false;
            ReversalActionVisible := true;
            RecoveryActionVisible := false;
            ReappotionmentLinesVisible := false;
            ReappotionmentDetailsVisible := false;
            ReappotionActionVisible := false;
            ReversalLinesVisible := true;

            

            DetachmentDetailsVisible := false;
            RecoveryLinesVisible := true;
            RecoveryDetailsVisible := true;
            ReversalActionVisible := false;
            RecoveryActionVisible := true;
            ReappotionmentDetailsVisible := false;
            ReappotionActionVisible := false;
            ReversalLinesVisible := false;
            NullifyActionVisible := false;

            DetachmentDetailsVisible := false;
            RecoveryLinesVisible := false;
            RecoveryDetailsVisible := false;
            ReversalActionVisible := false;
            RecoveryActionVisible := false;
            ReappotionmentLinesVisible := true;
            ReappotionmentDetailsVisible := true;
            ReappotionActionVisible := true;
            ReversalLinesVisible := false;
            NullifyActionVisible := false;

            OpenApprovalEntriesExistForCurrUser := false;
            OpenApprovalEntriesExist := false;
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := true;
            FastTabsEditable := true;
            DeferVisible := false;
            ReopenVisible := false;
            NullifyActionVisible := false;
            RecoveryLinesEditable := true;

        if Rec.Status = Rec.Status::Pending then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := true;
            ReopenVisible := true;
            NullifyActionVisible := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            RecoveryActionEnabled := true;
            ReversalActionEnabled := true;
            ReappotionActionEnabled := true;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := true;
            ReopenVisible := true;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := false;
            ReopenVisible := false;
            ReversalLinesVisible := false;
            NullifyActionVisible := true;
        end;

        if Rec.Status = Rec.Status::Deffered then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := false;
            ReopenVisible := true;
            ReversalLinesVisible := false;
            NullifyActionVisible := true;

        end;

    end;



    var
        PeriodicActivities: Codeunit "Periodic Activities";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        LoansProcess: Codeunit "Loans Process";
        UserSetup: Record "User Setup";
        Members: Record Members;
        SMSSource: enum "SMS Source";
        SendSMS: Codeunit SendSms;
        Loans: Record Loans;
        RecoveryLines: Record "Loan Recovery Lines II";
        ReversalLines: Record "Loan Reversal Lines II";
        NewLoans: Record Loans;
        NullifyActionVisible: Boolean;
        msg: Text;
        FastTabCaption: Text;
        FastTabsEditable: Boolean;
        RecoveryDetailsVisible: Boolean;
        ReappotionmentDetailsVisible: Boolean;
        RecoveryLinesVisible: Boolean;
        ReappotionmentLinesVisible: Boolean;
        DetachmentDetailsVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        RecoveryActionVisible: Boolean;
        RecoveryActionEnabled: Boolean;
        ReversalActionVisible: Boolean;
        ReversalActionEnabled: Boolean;
        ReappotionActionVisible: Boolean;
        ReappotionActionEnabled: Boolean;
        SendApprovalRequestVisible: Boolean;
        HistoryVisible: Boolean;
        ReopenVisible: Boolean;
        DeferVisible: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        ReversalLinesVisible: Boolean;
        RecoveryLinesEditable: Boolean;
}
