page 52185579 "Insurance Claims - Card"
{
    Caption = 'Fixed Asset Insurance Claims - Card';
    PageType = Card;
    SourceTable = "Insurance Claims";
    PromotedActionCategories = 'New, Process, Reports, Workflows';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEditable;
                field("Claim No."; Rec."Claim No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim No. field.';
                    Editable = false;
                }
                field("Insurance Claims"; Rec."Insurance Claims")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Claims field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Insurance Claims" = Rec."Insurance Claims"::" " then begin
                            VisibleSingleAsset := false;
                            VisibleCollectiveAsset := false;
                            VisibleNonAsset := false;
                        end
                        else
                            if Rec."Insurance Claims" = Rec."Insurance Claims"::"Single Asset" then begin
                                VisibleSingleAsset := true;
                                VisibleCollectiveAsset := false;
                                VisibleNonAsset := false;
                            end
                            else
                                if
                                Rec."Insurance Claims" = Rec."Insurance Claims"::"Multiple Assets" then begin
                                    VisibleSingleAsset := false;
                                    VisibleCollectiveAsset := true;
                                    VisibleNonAsset := false;
                                end
                                else
                                    if
                                    Rec."Insurance Claims" = Rec."Insurance Claims"::"Non Assets" then begin
                                        VisibleSingleAsset := false;
                                        VisibleCollectiveAsset := false;
                                        VisibleNonAsset := true;
                                    end;

                    end;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset Description field.';
                    Editable = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Insurance Cover"; Rec."Insurance Cover")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Cover field.';
                    Editable = false;
                }
                field("Policy No."; Rec."Policy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy No. field.';
                    Editable = false;
                }
                field("Policy Amount"; Rec."Policy Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Amount field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Captured By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                    Editable = false;
                }
                field("Captured Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured Date field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }

            }
            group("Claim Details")
            {
                Caption = 'Claim Details';
                Editable = PageEditable;
                field("Nature of the Claim"; Rec."Nature of the Claim")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nature of Claim field.';
                    MultiLine = true;
                }
                Field("Date of Incident"; Rec."Date of Incident")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Incident field.';
                }
                field("Date of Reporting"; Rec."Date of Reporting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Reporting field.';
                }
                field("Date of Claim"; Rec."Date of Claim")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Claim field.';
                }
                field("Staff Responsible PF. No."; Rec."Staff Responsible PF. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Responsible PF. No. field.';
                }
                field("Staff Responsible Name"; Rec."Staff Responsible Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Responsible Name field.';
                    Editable = false;
                }
                field("Claim Amount"; Rec."Amount in Claims")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Amount field.';
                }
            }

            part("Collective Asset Insurance"; "Collective Asset Insurance")
            {
                Visible = VisibleCollectiveAsset;
                ApplicationArea = Basic;
                Editable = TRUE;
                Caption = 'Collective Asset Insurance';
                SubpageLink = "Insurance No." = field("Insurance No.");
            }

            group("Claim Closure")
            {
                Caption = 'Claim Closure';
                Editable = ClaimEditable;
                field("Date of Closure"; Rec."Date of Closure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Closure field.';
                    Editable = false;
                }
                field("Amount in Compensation"; Rec."Amount in Compensation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount in Compensation field.';
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed By field.';
                    Editable = false;
                }
                field("Closed"; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                    Editable = false;
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('Document is already open');
                        GlobalFunctions.CommentsManagement(Rec."Claim No.");
                        if not Confirm('Are you sure you want to re-open this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Document Reopened Sucessfully.');
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
                    Enabled = SendApproval;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        ContractDocuments: Record "Contract Documents";
                        FileName: Text;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CancelApproval;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            action("Close Claim")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Claim';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()

                begin
                    //Rec.TestField(Status, Rec.Status::Approved);
                    Rec."Date of Closure" := Today;
                    Rec.Closed := true;
                    Rec."Closed By" := USERID;
                    Rec.Modify(true);
                end;
            }
            action("Document Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Claim No.");
                RunPageView = where(Types = CONST(comment));
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    var

        OpenApprovalEntriesExistForCurrUser: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        SendApproval: Boolean;
        CancelApproval: Boolean;
        ClaimEditable: Boolean;
        PageEditable: Boolean;
        VisibleSingleAsset: Boolean;
        VisibleCollectiveAsset: Boolean;

        GlobalFunctions: Codeunit "Global Functions";
        VisibleNonAsset: Boolean;

    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin

            SendApproval := true;
            CancelApproval := false;
            PageEditable := true;
            ClaimEditable := false;

        end;

        if Rec.Status = Rec.Status::Approved then begin
            SendApproval := false;
            CancelApproval := false;
            PageEditable := false;
            ClaimEditable := true;

        end;

        if Rec.Status = Rec.Status::Pending then begin
            SendApproval := false;
            CancelApproval := true;
            PageEditable := true;
            ClaimEditable := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            SendApproval := false;
            CancelApproval := false;
            PageEditable := true;
            ClaimEditable := false;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec."Insurance Claims" = Rec."Insurance Claims"::" " then begin
            VisibleSingleAsset := false;
            VisibleCollectiveAsset := false;
            VisibleNonAsset := false;
        end
        else
            if Rec."Insurance Claims" = Rec."Insurance Claims"::"Single Asset" then begin
                VisibleSingleAsset := true;
                VisibleCollectiveAsset := false;
                VisibleNonAsset := false;
            end
            else
                if
                Rec."Insurance Claims" = Rec."Insurance Claims"::"Multiple Assets" then begin
                    VisibleSingleAsset := false;
                    VisibleCollectiveAsset := true;
                    VisibleNonAsset := false;
                end
                else
                    if
                    Rec."Insurance Claims" = Rec."Insurance Claims"::"Non Assets" then begin
                        VisibleSingleAsset := false;
                        VisibleCollectiveAsset := false;
                        VisibleNonAsset := true;
                    end;


    end;
}