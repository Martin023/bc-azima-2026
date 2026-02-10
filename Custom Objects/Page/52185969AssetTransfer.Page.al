page 52185969 "Asset Transfer"
{
    SourceTable = "Asset Transfer";
    ApplicationArea = Basic, Suite;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Approval Entries,Category10_caption';
    //UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FieldEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Transfer Date"; rec."Transfer Date")
                {
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Asset to Transfer"; Rec."Asset to Transfer")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Asset Description"; Rec."Asset Description")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("Transfer From")
            // {
            //     Caption = 'Transfer From';
            //     Editable = false;
            //     field("From Location"; Rec."From Location")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Editable = false;
            //     }
            //     field("From Responsible Employee"; Rec."From Responsible Employee")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Editable = false;
            //     }
            //     field("From Employee Name"; Rec."From Employee Name")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Editable = false;
            //         ShowCaption = false;
            //         Style = AttentionAccent;
            //         StyleExpr = TRUE;
            //     }
            //     field("From Dimension 1 Code"; Rec."From Dimension 1 Code")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("From Dimension 2 Code"; Rec."From Dimension 2 Code")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
            // group("Transfer To")
            // {
            //     Caption = 'Transfer To';
            //     Editable = FieldEditable;
            //     field("To Location"; Rec."To Location")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         ShowMandatory = true;
            //     }
            //     field("To Responsible Employee"; Rec."To Responsible Employee")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         ShowMandatory = true;
            //     }
            //     field("To Employee Name"; Rec."To Employee Name")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Editable = false;
            //         ShowCaption = false;
            //     }
            //     field("To Dimension 1 Code"; Rec."To Dimension 1 Code")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("To Dimension 2 Code"; Rec."To Dimension 2 Code")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
            part(AssetTransferLines; "Assets Transfer Line")
            {
                ApplicationArea = Basic, Suite;
                Editable = FieldEditable;
                SubPageLink = "Asset Transfer Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Transfer)
            {
                ApplicationArea = Basic, Suite;
                Image = TransferToLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    rec.TestField(Status, rec.Status::Approved);
                    if Confirm(Txt001, false) = true then begin
                        FATranserLines.reset;
                        FATranserLines.SetRange("Asset Transfer Header No.", rec."No.");
                        if FATranserLines.findfirst then begin
                            repeat
                                FA.Reset;
                                if FA.Get(FATranserLines."Asset to Transfer") then begin
                                    if FATranserLines."To Location" <> '' then
                                        FA."FA Location Code" := FATranserLines."To Location";
                                    if FATranserLines."To Responsible Employee" <> '' then
                                        FA."Employee Responsible" := FATranserLines."To Responsible Employee";
                                    if FATranserLines."To Dimension Value 1 code" <> '' then
                                        FA."Global Dimension 1 Code" := FATranserLines."To Dimension Value 1 code";
                                    if FATranserLines."To Dimension Value 2 Code" <> '' then
                                        FA."Global Dimension 2 Code" := FATranserLines."To Dimension Value 2 Code";
                                    FA.Modify;
                                    Message(Txt002, rec."No.");
                                    FATranserLines.Transferred := true;
                                    FATranserLines.Modify;
                                end;
                            until FATranserLines.next = 0;
                            rec.Transferred := true;
                            rec.Modify;
                        end;
                    end;
                end;
            }
            action(ImportAssets)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Import';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"Fixed Assets Transfer Import");
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                Var
                    AssetTransfer: record "Asset Transfer";
                begin
                    AssetTransfer.Reset;
                    AssetTransfer.Setrange("No.", rec."No.");
                    if AssetTransfer.FindFirst() then
                        REPORT.Run(report::"Fixed Asset Transfer Report", true, true, AssetTransfer);
                end;
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit 1535;
                    begin

                        // DocumentType := DocumentType::Ass;
                        // ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header", "Document Type", "No.");
                        // ApprovalEntries.RUN;
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);

                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approvals';
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RecordId)
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RecordId)
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";

                    RunPageLink = "Table ID" = CONST(52185914),
                                  "Document No." = FIELD("No.");

                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        UpdateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //UpdateControls;
    end;

    var
        FA: Record "Fixed Asset";
        FieldEditable: Boolean;
        Txt001: Label 'Do you want to effect the transfer';
        Txt002: Label 'Asset transfer No: %1 Successfully Transferred';
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ActionVisible: Boolean;
        FATranserLines: record "Asset Transfer Line";

    local procedure UpdateControls()
    begin
        if rec.Status = rec.Status::Approved then begin
            FieldEditable := false;
            ActionVisible := false;
        end else begin
            FieldEditable := true;
            ActionVisible := true;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
    end;
}

