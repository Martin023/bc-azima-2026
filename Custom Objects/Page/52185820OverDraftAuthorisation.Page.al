page 52185820 "Over Draft Authorisation"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Workflows,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Over Draft Authorisation";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ODFee;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccNo;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ReqAmount;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AppAmount;
                }
                field("Overdraft Interest %"; Rec."Overdraft Interest %")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ODInt;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EstartDate;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Durationn;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Remmarks;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GlobDim1;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GlobDim2;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Expired; Rec.Expired)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Liquidated; Rec.Liquidated)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Liquidated"; Rec."Date Liquidated")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Liquidated By"; Rec."Liquidated By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RespCenter;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755033; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755034; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755035; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755036; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SaccoT: Codeunit "Sacco Transactions";
                    begin
                        SaccoT.PostOverDraft(Rec);
                    end;
                }
                action(Account)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        Rec.TestField("Transaction Type");
                        Rec.TestField("Account No.");
                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Duration);
                        Rec.TestField("Expiry Date");
                        Rec.TestField("Requested Amount");
                        Rec.TestField("Approved Amount");
                        Rec.TestField("Overdraft Interest %");


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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        DocMustbeOpen: Label 'This application request must be open';
        AccNo: Boolean;
        ReqAmount: Boolean;
        AppAmount: Boolean;
        ODInt: Boolean;
        EstartDate: Boolean;
        Durationn: Boolean;
        ODFee: Boolean;
        Remmarks: Boolean;
        RespCenter: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GlobDim1: Boolean;
        GlobDim2: Boolean;
        DocMustbePending: Label 'This application request must be Pending';

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin




        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            ReqAmount := true;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
            RespCenter := true;
            GlobDim1 := true;
            GlobDim2 := true;

        end;


        if Rec.Status = Rec.Status::Pending then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;

        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;


        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;

        end;
    end;

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

