page 52185816 "Bankers Cheque Application"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    SourceTable = "Bankers Cheque Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Begining Cheque No."; Rec."Begining Cheque No.")
                {
                    Editable = BeginCHNo;
                    ApplicationArea = Basic, Suite;
                }
                field("No of Leaves"; Rec."No of Leaves")
                {
                    Editable = BeginCHNo;
                    ApplicationArea = Basic, Suite;
                }
                field("Leaf Limit Amount"; Rec."Leaf Limit Amount")
                {
                    Editable = BeginCHNo;
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    Editable = BeginCHNo;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Register Generated"; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(Branch; Rec.Branch)
                {
                    Editable = BeginCHNo;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Cheque Register")
            {
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Enabled = (not Rec."Cheque Register Generated") and (Rec.Status = Rec.Status::Approved);

                trigger OnAction()
                var
                    StartingChqNo: code[20];
                begin
                    if Rec."Cheque Register Generated" = true then
                        Error('Register already generated');

                    if Rec.Status <> Rec.Status::Approved then
                        Error('The document must be fully approved before proceeding');

                    if Confirm('Are you sure you want to generate bankers cheque register ?', false) = false then
                        exit;

                    i := 0;
                    StartingChqNo := Rec."Begining Cheque No.";

                    repeat
                        i := i + 1;

                        BankerR.Init;
                        BankerR."Cheque No." := StartingChqNo;
                        BankerR."Application No." := Rec."No.";
                        BankerR."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        BankerR."Global Dimension 1 Code" := Rec.Branch;
                        BankerR."Bank Account" := Rec."Bank Account";
                        BankerR."Leaf Limit Amount" := Rec."Leaf Limit Amount";
                        BankerR.Insert;

                        BankerR.Validate(BankerR."Bank Account");

                        StartingChqNo := IncStr(StartingChqNo);
                    until i = Rec."No of Leaves";
                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;
                    Message('Register generated successfuly');
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic, Suite;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Bankers Cheque Register List";
                RunPageLink = "Application No." = FIELD("No.");
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
                    // ApprovalsMgmt: Codeunit 1535;
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
                    // ApprovalsMgmt: Codeunit 1535;
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
                    // ApprovalsMgmt: Codeunit 1535;
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin

                        Rec.TestField("Begining Cheque No.");
                        Rec.TestField("Bank Account");

                        if Rec."Leaf Limit Amount" = 0 then
                            Error('Kindly specify the leaf limit before proceeding');


                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

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
                        if Rec.Status <> Rec.Status::"Pending Approval" then
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
                    // approvalsMgmt: Codeunit 1535;
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        i: Integer;
        BankerR: Record "Bankers Cheques Register";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        BeginCHNo: Boolean;
        NoOfLives: Boolean;
        Bnk: Boolean;
        LeafLimit: Boolean;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then begin
            BeginCHNo := true;
            NoOfLives := true;
            Bnk := true;
            LeafLimit := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;
    end;
}

