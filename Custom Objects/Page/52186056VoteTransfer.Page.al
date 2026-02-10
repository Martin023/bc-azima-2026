page 52186056 "Vote Transfer"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Vote Transfer";
    //SourceTableView = WHERE(Posted = CONST(false));
    PromotedActionCategories = 'New,Process,Reports,Workflows';
    layout
    {
        area(content)
        {
            group("Budget Transfer")
            {
                Editable = Edit;
                Caption = 'Budget Transfer';
                label(Control1000000023)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = Text19066037;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists
                    end;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                label(Source)
                {
                    CaptionClass = Text19004057;
                    Caption = 'Source';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Source Vote"; Rec."Source Vote")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists
                    end;
                }
                field("Source Dimension 1"; Rec."Source Dimension 1")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists
                    end;
                }
                field("Source Dimension 2"; Rec."Source Dimension 2")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists
                    end;
                }
                field("Amount Available"; Rec."Amount Available")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CheckBudgetExists();
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Destination)
                {
                    CaptionClass = Text19061585;
                    Caption = 'Destination';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Destination Dimension 1"; Rec."Destination Dimension 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 2"; Rec."Destination Dimension 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted"; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Posted", false);
                    if Confirm('Do You wish To Post The Vote Transfer ?') then begin
                        Post_Vote();
                    end;
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
                    begin
                        VoteBookExists();
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
                    PromotedCategory = Category4;
                    visible = false;

                    trigger OnAction()
                    var
                    //   // //ApprovalEntries: Page "Approval Entries";
                    //   // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        //   // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);

                    end;
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
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
#pragma warning disable AL0171
                    // RunPageLink = "Table ID" = CONST(52185914),
                    //               "Document No." = FIELD("No. Series");
#pragma warning restore AL0171
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
    }

    var
        EntryNo: Integer;
        BudgetEntry: Record "G/L Budget Entry";
        Text19066037: Label 'Transfer Details';
        Text19004057: Label 'Transfer From Details';
        Text19061585: Label 'Transfer To Details';
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GLAccount: Record "G/L Account";
        Edit: boolean;

    procedure CheckPosted()
    begin
        if( rec.Posted) or (Rec.Status <> Rec.Status::Open) then
            Edit := false
        else
            Edit := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckPosted();
    end;

    trigger OnOpenPage()
    begin
        CheckPosted();
    end;

    procedure Post_Vote()
    begin
        CheckBudgetExists();
        Rec.TestField(Date);
        Rec.TestField("Budget Name");
        Rec.TestField(Amount);
        Rec.TestField(Rec."Source Vote");
        Rec.TestField("Destination Vote");

        if BudgetEntry.FindLast() then begin
            EntryNo := BudgetEntry."Entry No.";
        end;

        //.........Post Reducing Vote
        EntryNo := EntryNo + 1;

        BudgetEntry.Init;
        BudgetEntry."Entry No." := EntryNo;
        BudgetEntry."Budget Name" := Rec."Budget Name";
        BudgetEntry."G/L Account No." := Rec."Source Vote";
        BudgetEntry.Date := Rec.Date;
        BudgetEntry."Global Dimension 1 Code" := Rec."Source Dimension 1";
        BudgetEntry."Global Dimension 2 Code" := Rec."Source Dimension 2";
        //BudgetEntry."Budget Dimension 1 Code":="Source Dimension 2";
        BudgetEntry.Amount := -(Rec.Amount);
        BudgetEntry.Description := Rec.Remarks;
        BudgetEntry."User ID" := UserId;
        BudgetEntry.Insert(true);

        //.........Post Incresing Vote

        EntryNo := EntryNo + 1;
        BudgetEntry.Init;
        BudgetEntry."Entry No." := EntryNo;
        BudgetEntry."Budget Name" := Rec."Budget Name";
        BudgetEntry."G/L Account No." := Rec."Destination Vote";
        BudgetEntry.Date := Rec.Date;
        BudgetEntry."Global Dimension 1 Code" := Rec."Destination Dimension 1";
        BudgetEntry."Global Dimension 2 Code" := Rec."Destination Dimension 2";
        // BudgetEntry."Budget Dimension 1 Code":="Destination Dimension 2";
        BudgetEntry.Amount := Rec.Amount;
        BudgetEntry.Description := Rec.Remarks;
        BudgetEntry."User ID" := UserId;
        BudgetEntry.Insert(true);

        Rec.Posted := true;
        Rec."Posted Date" := Today;
        Rec."Posted By" := UserId;
        Rec.Modify;
        Message('Vote Transfered Successfully');
    end;

    local procedure VoteBookExists()
    var
        GLAccount: Record "G/L Account";
        BudgetaryControlSetup: Record "Budgetary Control Setup";
    begin
        BudgetaryControlSetup.Get;
        GLAccount.Reset;
        GLAccount.SetRange(GLAccount."No.", Rec.No);
        GLAccount.SetRange(GLAccount."Date Filter", BudgetaryControlSetup."Current Budget Start Date", BudgetaryControlSetup."Current Budget End Date");
        //GLAccount.SetRange(GLAccount."Global Dimension 1 Filter", Rec."Source Dimension 1");
        //GLAccount.SetRange(GLAccount."Global Dimension 2 Filter", Rec."Source Dimension 2");
        GLAccount.CalcFields("Budgeted Amount");
        if GLAccount."Budgeted Amount" < 0 then
            Error('Vote not available for transaction.');
    end;

    local procedure CheckBudgetExists()
    begin
        GLAccount.Reset;
        GLAccount.SetRange("No.", Rec."Source Vote");
        GLAccount.SetFilter("Date Filter", '<=%1', Rec.Date);
        GLAccount.SetRange(GLAccount."Budget Filter", Rec."Budget Name");
        //GLAccount.SetRange(GLAccount."Global Dimension 1 Filter", Rec."Source Dimension 1");
        GLAccount.SetRange(GLAccount."Global Dimension 2 Filter", Rec."Source Dimension 2");
        if GLAccount.FindSet then begin
            GLAccount.CalcFields(GLAccount."Budgeted Amount");
            Rec."Amount Available" := GLAccount."Budgeted Amount";
            if Rec.Amount > GLAccount."Budgeted Amount" then Error('Insufficient Budget in that branch or department');
        end;
    end;
}

