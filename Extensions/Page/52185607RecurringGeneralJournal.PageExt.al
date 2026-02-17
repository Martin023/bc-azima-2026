#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185607 pageextension52185607 extends "Recurring General Journal"
{
    Caption = 'Recurring General Journal';

    PromotedActionCategories = 'Send Approval Request';
    layout
    {
        // addafter("Account Type")
        // {
        //     field("FA Posting Type"; Rec."FA Posting Type")
        //     {
        //         ApplicationArea = Basic;
        //     }
        // }
        modify(CurrentJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Method")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Frequency")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Type")
        {
            ApplicationArea = Basic;
            visible = true;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Business Unit Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Debit Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Debit Amount"(Control 1000)".

        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Credit Amount"(Control 1001)".

        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to ID")
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Payment Type")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Allocated Amt. (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to/Pay-to No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to/Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify(AccName)
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify(TotalBalance)
        {
            ApplicationArea = Basic;
        }



        modify("Amount (LCY)")
        {
            Visible = false;
        }


        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }



        addafter("VAT Difference")
        {
            // field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }

        }
        addafter(JournalLineDetails)
        {

            part(WorkflowStatusBatch; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Batch Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnBatch;
            }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Line Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }
        }
    }

    actions
    {

        modify(Allocations)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Allocations(Action 84)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;

        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }
        addafter("&Line")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Promoted = true;
                        //PromotedCategory = Category4;
                        Caption = 'Send Approval Request-Journal Batch';
                        //Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist AND CanRequestFlowApprovalForBatchAndAllLines AND EnabledGenJnlBatchWorkflowsExist;
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
                        ApplicationArea = Basic, Suite;
                        Caption = 'Send pproval Request-Selected Journal Lines';
                        Promoted = true;
                        //PromotedCategory = Category4;
                        //Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist AND CanRequestFlowApprovalForBatchAndCurrentLine AND EnabledGenJnlLineWorkflowsExist;
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
                        Promoted = true;
                        //PromotedCategory = Category4;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval request-Journal Batch';
                        //Enabled = CanCancelApprovalForJnlBatch OR CanCancelFlowApprovalForBatch;
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
                        Promoted = true;
                        //PromotedCategory = Category4;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval request-Selected Journal Lines';
                        //Enabled = CanCancelApprovalForJnlLine OR CanCancelFlowApprovalForLine;
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
                }

            }
        }
        addafter("P&osting")
        {
            group("Imports")
            {
                action(Import)
                {
                    image = Import;
                    promoted = true;
                    RunObject = xmlport "Reccuring Fixed Assets Journal";
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin


                    end;
                }

            }


        }
    }


    local procedure SetControlAppearanceFromBatch()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then
            exit;

        ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RecordId);
        SetApprovalStateForBatch(GenJournalBatch, Rec, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlBatchExist, OpenApprovalEntriesOnBatchOrAnyJnlLineExist, CanCancelApprovalForJnlBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, CanRequestFlowApprovalForBatchAndAllLines, ApprovalEntriesExistSentByCurrentUser, EnabledGenJnlBatchWorkflowsExist, EnabledGenJnlLineWorkflowsExist);
        BackgroundErrorCheck := BackgroundErrorHandlingMgt.BackgroundValidationFeatureEnabled();
        ShowAllLinesEnabled := true;
        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
        JournalErrorsMgt.SetFullBatchCheck(true);
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

    local procedure SetControlAppearance()
    begin
        SetApprovalState(Rec.RecordId, OpenApprovalEntriesOnJnlBatchExist, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForLine, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlLineExist, OpenApprovalEntriesOnBatchOrCurrJnlLineExist, CanCancelApprovalForJnlLine, CanRequestFlowApprovalForBatchAndCurrentLine);
        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        //SetPayrollAppearance();
    end;

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet());
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
}