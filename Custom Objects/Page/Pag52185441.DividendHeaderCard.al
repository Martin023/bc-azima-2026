namespace Azima.Azima;
using System.Automation;

page 52185441 "Dividend Header Card"
{
    Caption = 'Dividend Header Card';
    PageType = Card;
    SourceTable = "Dividend Header";
    ApplicationArea = All;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.', Comment = '%';
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Code field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
                }
                field(CreatedOn; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CreatedOn field.', Comment = '%';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this record?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        if not Confirm('Are you sure you want to reject this request?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    // Visible = DeferVisible;

                    trigger OnAction()
                    var
                        theRecord: Record "Dependancies Applications";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");

                        if not Confirm('Are you sure you want to deffer this record?') then exit;

                        theRecord.Get(Rec."No.");
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                        theRecord.Status := theRecord.Status::Deffered;
                        theRecord.Validate(Status);
                        theRecord.Modify(true);
                        Message('Record deffered succsessfully');

                    end;
                }

                action(Archive)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archive Application';
                    Image = Archive;
                    // Visible = DeferVisible;

                    trigger OnAction()
                    var
                        theRecord: Record "Dependancies Applications";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if ((Rec.Status <> Rec.Status::Approved) or (Rec.Status <> Rec.Status::Rejected)) then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;

                            theRecord.Get(Rec."No.");
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                            theRecord.Status := theRecord.Status::Archived;
                            theRecord.Validate(Status);
                            theRecord.Modify(true);
                            Message('Record archive succsessfully');
                        end else
                            Error('You cannot archive an approved or rejected record');
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: Label 'You must specify next of Kin for this application.';
                        CertificateManagement: Record "Certificate Management";
                        Members: Record Members;
                        CertMngt: Record "Certificate Management";
                        NokApp: Record "Next of KIN Application";
                        AccSignatories: Record "Account Signatories";
                    begin
                        if not Confirm('Are you sure you want to send approval request for this record?') then exit;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-Open (Return) Application';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        theRecord: Record "Dependancies Applications";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure yu want to open this application?') then exit;

                        theRecord.Get(Rec."No.");
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                        theRecord.Status := theRecord.Status::Open;
                        theRecord.Modify(true);
                        Message('Record edited successfully');
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    var
        "-": Integer;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
}
