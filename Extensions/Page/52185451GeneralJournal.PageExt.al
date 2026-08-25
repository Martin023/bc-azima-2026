#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185451 pageextension52185451 extends "General Journal"
{
    Caption = 'General Journal';

    //PromotedActionCategoriesML
    PromotedActionCategories = 'New,Process,Reports,Comments,Reopen,Refresh';
    //'New,Process,Reports,Check Budgetary Availability,EDMS,,Refresh,Workflows';

    layout
    {
        addafter("Total Credit")
        {
            group(CreditAmt)
            {
                caption = 'Total Credit Amount';
                field(CreditAmount; TotalCreditAmt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Amount';
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                    Visible = TRUE;
                }
            }
            group(DebitAmt)
            {
                caption = 'Total Debit Amount';
                field(DebitAmount; TotalDebitAmt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit Amount';
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                    Visible = TRUE;
                }
            }
        }
        // modify("Total Debit")
        // {
        //     Visible = true;
        // }
        // modify(DisplayTotalDebit)
        // {
        //     Visible = true;
        // }
        // modify("Total Credit")
        // {
        //     Visible = true;
        // }
        modify(DisplayTotalCredit)
        {
            Visible = true;
        }

        modify(CurrentJnlBatchName)
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
            Caption = 'Document Date';
        }
        //   modify("Document Type")
        // {
        //     ApplicationArea = Basic;
        // }

        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Incoming Document Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Ext. Doc. No.")
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
            // trigger On
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Payer Information")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Information")
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
            Visible = false;

        }
        modify("Gen. Posting Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(Quantity)
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
            Visible = false;
        }
        modify("VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Amount")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bal. VAT Difference")
        {
            ApplicationArea = Basic;
        }
        // modify("Bal. Account Type")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Posting Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        // modify("Deferral Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Bal. VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bill-to/Pay-to No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Ship-to/Order Address Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Applied Automatically")
        {
            ApplicationArea = Basic;
        }
        modify(Applied)
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
        modify(AccName)
        {
            ApplicationArea = Basic;
        }
        modify(BalAccName)
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
        modify(Control120)
        {
            Visible = false;
        }


        modify("<Document No. Simple Page>")
        {
            Visible = false;
        }
        modify("<CurrentPostingDate>")
        {
            Visible = false;
        }


        modify(AccountName)
        {
            Visible = false;
        }



        modify("EU 3-Party Trade")
        {
            Visible = false;
        }


        modify("Amount (LCY)")
        {
            Visible = false;
        }


        modify("Bal. Account Type")
        {
            Visible = true;
        }


        modify("Deferral Code")
        {
            Visible = false;
        }



        modify(Correction)
        {
            Visible = false;
        }


        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
            ShowMandatory = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ShowMandatory = true;
        }
        moveafter("Shortcut Dimension 2 Code"; "Shortcut Dimension 1 Code")

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

        addafter("Payer Information")
        {
            // field("Transaction Type"; "Transaction Type")
            // {
            //     ApplicationArea = Basic;
            // }
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = Basic;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = all;
                ValuesAllowed = Loan, "Repayment", "Interest Due", "Interest Paid";
            }
            field("Staff/Payroll No"; Rec."Staff/Payroll No")
            {

                ApplicationArea = all;
                Visible = true;
            }

            field("Fixed Deposit Contract"; Rec."Fixed Deposit Contract")
            {
                ApplicationArea = Basic;
            }
            // field("Debit Amount."; Rec."Debit Amount")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Credit Amount."; Rec."Credit Amount")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter(ShortcutDimCode7)
        {
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
        addafter("Shortcut Dimension 1 Code")
        {
            field("Customer/Member/Vend Name"; Rec."Customer/Member/Vend Name")
            {
                Caption = 'Customer Name';
                ApplicationArea = Basic;
            }
            field("DocumentType"; Rec."Document Type")
            {
                ApplicationArea = Basic;

            }
        }
        addafter("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic;
            }

        }
        modify(GenJnlBatchApprovalStatus)
        {
            Visible = True;
            ApplicationArea = Basic;
        }
        moveafter("Line No."; GenJnlBatchApprovalStatus)

        moveafter("Ship-to/Order Address Code"; ShortcutDimCode8)
        moveafter("Shortcut Dimension 1 Code"; ShortcutDimCode7)
        moveafter("Fixed Deposit Contract"; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; Amount)
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Dimensions(Action 76)".

        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify("Renumber Document Numbers")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            ApplicationArea = Basic;
        }
        modify(GetStandardJournals)
        {
            ApplicationArea = Basic;
        }
        modify(SaveAsStandardJournal)
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

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 50)".

        }
        modify(Preview)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "Preview(Action 48)".

        }
        modify(PostAndPrint)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostAndPrint(Action 51)".

        }
        modify(DeferralSchedule)
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(IncomingDocAttachFile)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(RemoveIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(ImportBankStatement)
        {
            ApplicationArea = Basic;
        }
        modify(ShowStatementLineDetails)
        {
            ApplicationArea = Basic;
        }
        modify(Reconcile)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Reconcile(Action 23)".

        }
        modify("Apply Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Apply Entries"(Action 91)".

        }
        modify(Match)
        {
            ApplicationArea = Basic;
        }
        modify(AddMappingRule)
        {
            ApplicationArea = Basic;
        }
        modify(ImportPayrollFile)
        {

            //Unsupported feature: Property Modification (Name) on "ImportPayrollFile(Action 29)".

            Caption = 'Import Payroll Transactions';
            ApplicationArea = Basic;
        }
        modify(SendApprovalRequestJournalBatch)
        {
            ApplicationArea = Basic;
            trigger OnBeforeAction()
            var
                GenjnlLines: record "Gen. Journal Line";
            begin
                GenjnlLines.SetRange("Journal Template Name", Rec."Journal Template Name");
                GenjnlLines.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                if GenjnlLines.FindSet() then begin
                    repeat
                        if (GenjnlLines."Shortcut Dimension 1 Code" = '') or (GenjnlLines."Shortcut Dimension 2 Code" = '') then
                            error('Please fill in the Branch and Activity code fields');
                        if GenjnlLines."Loan No" <> '' then
                            if (GenjnlLines."Transaction Type" = GenjnlLines."Transaction Type"::" ") or (GenjnlLines."Transaction Type" = GenjnlLines."Transaction Type"::Armotised) then
                                error('Please fill in the Transaction Type field');
                        if strlen(GenjnlLines.Description) > 100 then
                            Error('The description cannot exceed 100 characters');
                    until GenjnlLines.Next = 0;
                end;
            end;

            // PromotedCategory = Category4;
            // Promoted = true;
            // Enabled = not OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
        }
        modify(SendApprovalRequestJournalLine)
        {
            ApplicationArea = Basic;
            // PromotedCategory = Category4;
            // Promoted = true;
            //Enabled = not OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            ApplicationArea = Basic;
            // PromotedCategory = Category4;
            // Promoted = true;
            //Enabled = OpenApprovalEntriesOnJnlBatchExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequestJournalBatch(Action 60)".

        }
        modify(CancelApprovalRequestJournalLine)
        {
            ApplicationArea = Basic;
            // PromotedCategory = Category4;
            // Promoted = true;
            // Enabled = OpenApprovalEntriesOnJnlLineExist;
        }
        modify(Approve)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            Visible = false;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Delegate)
        {
            ApplicationArea = Basic;
        }
        modify("Prepare journal")
        {

            Caption = 'Approvals';

        }
        addafter("Apply Entries")
        {
            action(ImportOpeningBalance)
            {
                Caption = 'Import Journal Lines';
                ApplicationArea = Basic, Suite;
                PromotedCategory = process;
                Promoted = true;
                trigger OnAction()
                begin
                    Xmlport.run(Xmlport::JOURNAL);
                end;
            }

        }



        addafter(CancelApprovalRequest)
        {
            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Journal Batch Name");
                RunPageView = where(Types = CONST(comment));
            }
            group(Reopen)
            {
                Caption = 'Re-open';
                Image = Open;
                //Promoted = true;
                action(ReopenBatch)
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Journal Batch';
                    //Enabled = CanOpenApprovalForJnlBatch OR CanOpenlFlowApprovalForBatch;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Reopen all journal lines, also those that you may not see because of filters.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                        SetControlAppearance();
                        SetControlAppearanceFromBatch();
                        Message('Journal Batch reopened successfully.');
                    end;
                }
                action(ReopenLine)
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Caption = 'Selected Journal Lines';
                    //Enabled = CanOpenApprovalForJnlBatch OR CanOpenlFlowApprovalForBatch;
                    Image = ReOpen;
                    ToolTip = 'Reopen sending selected journal lines for approval.';

                    trigger OnAction()
                    var
                        [SecurityFiltering(SecurityFilter::Filtered)]
                        GenJournalLine: Record "Gen. Journal Line";
                        AlsMpprovagmt: Codeunit "Approvals Mgmt.";
                    begin
                        GetCurrentlySelectedLines(GenJournalLine);
                        ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                        Message('Journal line reopened successfully.');
                    end;
                }
            }
            action(RefreshDocument)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                Caption = 'Refresh';
                PromotedCategory = Category6;

                trigger
                OnAction()
                begin
                    CurrPage.Update();
                    message('Page refreshed successfully.');
                end;
            }

        }


        //addfirst(Promoted){}

        modify(ImportPayrollTransactions)
        {
            Visible = false;
        }
        // modify(CreateFlow)
        // {
        //     Visible = false;
        // }
        // modify(SeeFlows)
        // {
        //     Visible = false;
        // }

        modify("Opening Balance")
        {
            Visible = false;
        }

        modify("G/L Accounts Opening balance ")
        {
            Visible = false;
        }
        modify("Customers Opening balance")
        {
            Visible = false;
        }
        modify("Vendors Opening balance")
        {
            Visible = false;
        }
        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
        modify(PreviousDocNumberTrx)
        {
            Visible = false;
        }
        modify(NextDocNumberTrx)
        {
            Visible = false;
        }
        modify(ClassicView)
        {
            Visible = false;
        }
        modify(SimpleView)
        {
            Visible = false;
        }
        modify("New Doc No.")
        {
            Visible = false;
        }
        moveafter(CancelApprovalRequestJournalLine; "Prepare journal")
    }

    var
        Gnjline: Record "Gen. Journal Line";
        Account: Record 52185730;
        GenJournalBatch: Record "Gen. Journal Batch";
        NotJournalUserErr: label 'User %1 is not attached to this batch, and hence can not modify the batch';
        approvalsMgmt: Codeunit "Approvals Mgmt.";
        Text002: label 'Standard General Journal %1 has been successfully created.';
        GenJnlBatch: Record "Gen. Journal Batch";
        CreditAccounts: Record 52185731;
        Loans: Record 52185729;
        UserSetup: Record "User Setup";
        AccTypeNotSupportedErr: label 'You cannot specify a deferral code for this type of account.';

    procedure TotalCreditAmt(): Decimal;
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        // if IsSimplePage then begin
        GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        //GenJournalLine.SetRange("Document No.", Rec."Document No.");
        GenJournalLine.CalcSums("Credit Amount");
        exit(GenJournalLine."Credit Amount");
        // end
    end;

    procedure TotalDebitAmt(): Decimal;
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        // if IsSimplePage then begin
        GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        //GenJournalLine.SetRange("Document No.", Rec."Document No.");
        GenJournalLine.CalcSums("Debit Amount");
        exit(GenJournalLine."Debit Amount");
        // end
    end;

    // trigger OnopenPage()
    // begin
    //     Gnjline.reset();
    //     Gnjline.SetRange("Journal Batch Name", Rec."Journal Batch Name");
    //     Gnjline.SetRange("Journal Template Name", Rec."Journal Template Name");
    //     Gnjline.SetRange("Document No.", Rec."Document No.");
    //     IF Gnjline.FINDSET THEN begin
    //         repeat
    //             if Gnjline."Pending Approval" then
    //                 CurrPage.editable := false;
    //         until
    //         Gnjline.next = 0;
    //     end;
    // end;

    local procedure SetControlAppearance()
    begin
        SetApprovalState(Rec.RecordId, OpenApprovalEntriesOnJnlBatchExist, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForLine, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlLineExist, OpenApprovalEntriesOnBatchOrCurrJnlLineExist, CanCancelApprovalForJnlLine, CanRequestFlowApprovalForBatchAndCurrentLine);
        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        //SetPayrollAppearance();
    end;

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

    // local procedure SetPayrollAppearance()
    // var
    //     TempPayrollServiceConnection: Record "Service Connection" temporary;
    // begin
    //     PayrollManagement.OnRegisterPayrollService(TempPayrollServiceConnection);
    //     ImportPayrollTransactionsAvailable := not TempPayrollServiceConnection.IsEmpty();
    // end;
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


    var
        CanOpenApprovalForJnlBatch: Boolean;
        CanOpenlFlowApprovalForBatch: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        EnabledGenJnlLineWorkflowsExist: Boolean;
        EnabledGenJnlBatchWorkflowsExist: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        ApprovalEntriesExistSentByCurrentUser: Boolean;
        JournalErrorsMgt: Codeunit "Journal Errors Mgt.";
        BackgroundErrorHandlingMgt: Codeunit "Background Error Handling Mgt.";
}
