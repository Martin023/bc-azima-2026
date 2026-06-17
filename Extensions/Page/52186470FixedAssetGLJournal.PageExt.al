#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186470 pageextension52186470 extends "Fixed Asset G/L Journal"
{
    Caption = 'Fixed Asset G/L Journal';
    layout
    {
        modify("Debit Amount")
        {
            visible = true;
        }
        modify("Credit Amount")
        {
            visible = true;
        }
    }

    actions
    {
        addafter("Apply Entries")
        {
            group(SendApprovalRequest)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;

                action(SendApprovalRequestJournalBatch)
                {
                    //  ApplicationArea = Basic, Suite;
                    ApplicationArea = FixedAssets;
                    Caption = 'Journal Batch';
                    // Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist AND CanRequestFlowApprovalForBatchAndAllLines AND EnabledGenJnlBatchWorkflowsExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                        SetControlAppearanceFromBatch();
                        SetControlAppearance();
                    end;
                }
                action(SendApprovalRequestJournalLine)
                {
                    //ApplicationArea = Basic, Suite;
                    ApplicationArea = FixedAssets;
                    Caption = 'Selected Journal Lines';
                    // Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist AND CanRequestFlowApprovalForBatchAndCurrentLine AND EnabledGenJnlLineWorkflowsExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Send selected journal lines for approval.';

                    trigger OnAction()
                    var
                        [SecurityFiltering(SecurityFilter::Filtered)]
                        GenJournalLine: Record "Gen. Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GetCurrentlySelectedLines(GenJournalLine);
                        ApprovalsMgmt.SendJournalLinesApprovalRequests(GenJournalLine);
                        SetControlAppearanceFromBatch();
                    end;
                }
            }
            group(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                action(CancelApprovalRequestJournalBatch)
                {
                    // ApplicationArea = Basic, Suite;
                    ApplicationArea = FixedAssets;
                    Caption = 'Journal Batch';
                    // Enabled = CanCancelApprovalForJnlBatch OR CanCancelFlowApprovalForBatch;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                        SetControlAppearance();
                        SetControlAppearanceFromBatch();
                    end;
                }
                action(CancelApprovalRequestJournalLine)
                {
                    // ApplicationArea = Basic, Suite;
                    ApplicationArea = FixedAssets;
                    Caption = 'Selected Journal Lines';
                    // Enabled = CanCancelApprovalForJnlLine OR CanCancelFlowApprovalForLine;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel sending selected journal lines for approval.';

                    trigger OnAction()
                    var
                        [SecurityFiltering(SecurityFilter::Filtered)]
                        GenJournalLine: Record "Gen. Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GetCurrentlySelectedLines(GenJournalLine);
                        ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                    end;
                }
                customaction(CreateFlowFromTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create approval flow';
                    ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
#if not CLEAN22
                    // Visible = IsSaaS and PowerAutomateTemplatesEnabled and IsPowerAutomatePrivacyNoticeApproved;
#else
                    Visible = IsSaaS and IsPowerAutomatePrivacyNoticeApproved;
#endif
                    CustomActionType = FlowTemplateGallery;
                    FlowTemplateCategoryName = 'd365bc_approval_generalJournal';
                }
#if not CLEAN22
                action(CreateFlow)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create a Power Automate approval flow';
                    Image = Flow;
                    ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
                    //   Visible = IsSaaS and not PowerAutomateTemplatesEnabled and IsPowerAutomatePrivacyNoticeApproved;
                    ObsoleteReason = 'This action will be handled by platform as part of the CreateFlowFromTemplate customaction';
                    ObsoleteState = Pending;
                    ObsoleteTag = '22.0';

                    trigger OnAction()
                    var
                        FlowServiceManagement: Codeunit "Flow Service Management";
                    // FlowTemplateSelector: Page "Flow Template Selector";
                    begin
                        // Opens page 6400 where the user can use filtered templates to create new flows.
                        // FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetJournalTemplateFilter());
                        // FlowTemplateSelector.Run();
                    end;
                }
#endif
#if not CLEAN21
                action(SeeFlows)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'See my flows';
                    Image = Flow;
                    // RunObject = Page "Flow Selector";
                    ToolTip = 'View and configure Power Automate flows that you created.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'This action has been moved to the tab dedicated to Power Automate';
                    ObsoleteTag = '21.0';
                }
#endif
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser or ApprovalEntriesExistSentByCurrentUser;

                    trigger OnAction()
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                }

            }

        }

    }
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        PayrollManagement: Codeunit "Payroll Management";
        ClientTypeManagement: Codeunit "Client Type Management";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        JournalErrorsMgt: Codeunit "Journal Errors Mgt.";
        BackgroundErrorHandlingMgt: Codeunit "Background Error Handling Mgt.";
        PrivacyNotice: Codeunit "Privacy Notice";
        PrivacyNoticeRegistrations: Codeunit "Privacy Notice Registrations";
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        AccName: Text[100];
        BalAccName: Text[100];
        GenJnlBatchApprovalStatus: Text[20];
        GenJnlLineApprovalStatus: Text[20];
        Balance: Decimal;
        TotalBalance: Decimal;
        NumberOfRecords: Integer;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        HasIncomingDocument: Boolean;
        ApplyEntriesActionEnabled: Boolean;
        BalanceVisible: Boolean;
        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        IsPowerAutomatePrivacyNoticeApproved: Boolean;
        ApprovalEntriesExistSentByCurrentUser: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        EnabledGenJnlLineWorkflowsExist: Boolean;
        EnabledGenJnlBatchWorkflowsExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        ImportPayrollTransactionsAvailable: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        IsSaaS: Boolean;
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;
        CurrentDocNo: Code[20];
        CurrentPostingDate: Date;
        CurrentCurrencyCode: Code[10];
        IsChangingDocNo: Boolean;
        VATDateEnabled: Boolean;
        MissingExchangeRatesQst: Label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        ActionOnlyAllowedForAllocationAccountsErr: Label 'This action is only available for lines that have Allocation Account set as Account Type or Balancing Account Type.';
        PostedFromSimplePage: Boolean;
        DocumentNumberMsg: Label 'Document No. must have a value in Gen. Journal Line.';
        UseAllocationAccountNumber: Boolean;

    local procedure SetControlAppearanceFromBatch()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), Rec."Journal Batch Name") then
            exit;

        // ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RecordId);
        SetApprovalStateForBatch(GenJournalBatch, Rec, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlBatchExist, OpenApprovalEntriesOnBatchOrAnyJnlLineExist, CanCancelApprovalForJnlBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, CanRequestFlowApprovalForBatchAndAllLines, ApprovalEntriesExistSentByCurrentUser, EnabledGenJnlBatchWorkflowsExist, EnabledGenJnlLineWorkflowsExist);
        BackgroundErrorCheck := BackgroundErrorHandlingMgt.BackgroundValidationFeatureEnabled();
        ShowAllLinesEnabled := true;
        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
        JournalErrorsMgt.SetFullBatchCheck(true);
    end;

    local procedure SetControlVisibility()
    var
        GLSetup: Record "General Ledger Setup";
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        //     IsSaaS := EnvironmentInfo.IsSaaS();
        //     GLSetup.Get();
        //     if IsSimplePage then begin
        //         AmountVisible := false;
        //         DebitCreditVisible := true;
        //     end else begin
        //         AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        //         DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
        //     end;
    end;



    internal procedure SetApprovalState(RecordId: RecordId; OpenApprovalEntriesOnJournalBatchExist: Boolean; LocalCanRequestFlowApprovalForBatch: Boolean; var LocalCanCancelFlowApprovalForLine: Boolean; var OpenApprovalEntriesExistForCurrentUser: Boolean; var OpenApprovalEntriesOnJournalLineExist: Boolean; var OpenApprovalEntriesOnBatchOrCurrentJournalLineExist: Boolean; var CanCancelApprovalForJournalLine: Boolean; var LocalCanRequestFlowApprovalForBatchAndCurrentLine: Boolean)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForLine: Boolean;
    begin
        OpenApprovalEntriesExistForCurrentUser := OpenApprovalEntriesExistForCurrentUser or ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesOnJournalLineExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        OpenApprovalEntriesOnBatchOrCurrentJournalLineExist := OpenApprovalEntriesOnJournalBatchExist or OpenApprovalEntriesOnJournalLineExist;
        CanCancelApprovalForJournalLine := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId, CanRequestFlowApprovalForLine, LocalCanCancelFlowApprovalForLine);
        LocalCanRequestFlowApprovalForBatchAndCurrentLine := LocalCanRequestFlowApprovalForBatch and CanRequestFlowApprovalForLine;
    end;

    internal procedure SetApprovalStateForBatch(GenJournalBatch: Record "Gen. Journal Batch"; GenJournalLine: Record "Gen. Journal Line"; var OpenApprovalEntriesExistForCurrentUser: Boolean; var OpenApprovalEntriesOnJournalBatchExist: Boolean; var OpenApprovalEntriesOnBatchOrAnyJournalLineExist: Boolean; var CanCancelApprovalForJournalBatch: Boolean; var LocalCanRequestFlowApprovalForBatch: Boolean; var LocalCanCancelFlowApprovalForBatch: Boolean; var LocalCanRequestFlowApprovalForBatchAndAllLines: Boolean; var LocalApprovalEntriesExistSentByCurrentUser: Boolean; var EnabledGeneralJournalBatchWorkflowsExist: Boolean; var EnabledGeneralJournalLineWorkflowsExist: Boolean)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        CanRequestFlowApprovalForAllLines: Boolean;
    begin
        OpenApprovalEntriesExistForCurrentUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(GenJournalBatch.RecordId);
        OpenApprovalEntriesOnJournalBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(GenJournalBatch.RecordId);
        OpenApprovalEntriesOnBatchOrAnyJournalLineExist := OpenApprovalEntriesOnJournalBatchExist or ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");
        CanCancelApprovalForJournalBatch := ApprovalsMgmt.CanCancelApprovalForRecord(GenJournalBatch.RecordId);
        WorkflowWebhookManagement.GetCanRequestAndCanCancelJournalBatch(GenJournalBatch, LocalCanRequestFlowApprovalForBatch, LocalCanCancelFlowApprovalForBatch, CanRequestFlowApprovalForAllLines);
        LocalCanRequestFlowApprovalForBatchAndAllLines := LocalCanRequestFlowApprovalForBatch and CanRequestFlowApprovalForAllLines;
        LocalApprovalEntriesExistSentByCurrentUser := ApprovalsMgmt.HasApprovalEntriesSentByCurrentUser(GenJournalBatch.RecordId);

        EnabledGeneralJournalLineWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Gen. Journal Line", WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode());
        EnabledGeneralJournalBatchWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Gen. Journal Batch", WorkflowEventHandling.RunWorkflowOnSendGeneralJournalBatchForApprovalCode());
    end;

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet());
    end;

    local procedure GetPostingDate(): Date
    begin
        //if IsSimplePage then
        //    exit(CurrentPostingDate);
        exit(Workdate());
    end;

    local procedure SetControlAppearance()
    begin
        SetApprovalState(Rec.RecordId, OpenApprovalEntriesOnJnlBatchExist, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForLine, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlLineExist, OpenApprovalEntriesOnBatchOrCurrJnlLineExist, CanCancelApprovalForJnlLine, CanRequestFlowApprovalForBatchAndCurrentLine);
        // ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        //SetPayrollAppearance();
    end;



}
