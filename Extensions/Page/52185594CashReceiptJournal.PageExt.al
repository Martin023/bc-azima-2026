#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185594 pageextension52185594 extends "Cash Receipt Journal"
{
    Caption = 'Cash Receipt Journal';
    // visible = true;

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Cash Receipt Journal"(Page 255)".

    layout
    {
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
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
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
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
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
        modify("Bal. VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Applied (Yes/No)")
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
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify(Correction)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Correction(Control 62)".


            //Unsupported feature: Property Modification (Name) on "Correction(Control 62)".

        }
        // modify(Control5)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Direct Debit Mandate ID")
        {
            ApplicationArea = Basic;
        }
        // modify(ShortcutDimCode7)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ShortcutDimCode7(Control 49)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "ShortcutDimCode7(Control 49)".


        //     //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode7(Control 49)".

        // }
        // modify(ShortcutDimCode8)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ShortcutDimCode8(Control 47)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "ShortcutDimCode8(Control 47)".


        //     //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode8(Control 47)".

        // }
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

        //Unsupported feature: Code Modification on "CurrentJnlBatchName(Control 33).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        SetControlAppearanceFromBatch;
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Incoming Document Entry No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 35)".



        //Unsupported feature: Code Modification on ""Account Type"(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
        EnableApplyEntriesAction;
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 8)".



        //Unsupported feature: Code Modification on ""Account No."(Control 10).OnValidate".

        //trigger "(Control 10)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
        ShowShortcutDimCode(ShortcutDimCode);
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Posting Type"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 14)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 14)".

        modify("Amount (LCY)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 1000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 1001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Difference"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Amount"(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Difference"(Control 91)".

        // modify("Bal. Account Type")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Posting Type"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Bus. Posting Group"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Prod. Posting Group"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Bus. Posting Group"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Prod. Posting Group"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied (Yes/No)"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to ID"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Correction(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control5(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Mandate ID"(Control 11)".

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
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

        //Unsupported feature: Property Deletion (CaptionClass) on "ShortcutDimCode7(Control 49)".


        //Unsupported feature: Property Deletion (TableRelation) on "ShortcutDimCode7(Control 49)".

        modify(ShortcutDimCode8)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionClass) on "ShortcutDimCode8(Control 47)".


        //Unsupported feature: Property Deletion (TableRelation) on "ShortcutDimCode8(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AccName(Control 29)".


        //Unsupported feature: Property Deletion (ShowCaption) on "AccName(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalAccName(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Balance(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalBalance(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900919607(Control 1900919607)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowStatusBatch(Control 54)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowStatusLine(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Correction)
        {
            // field("Loan N o";"Loan No")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter("Bal. Account No.")
        {
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = Basic;
                Visible = true;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic;
                Visible = true;
            }
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
        addafter("Direct Debit Mandate ID")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter(Description; Correction)
        moveafter("Bal. VAT Prod. Posting Group"; ShortcutDimCode8)
        moveafter("Shortcut Dimension 1 Code"; ShortcutDimCode7)
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Dimensions(Action 60)".

        }
        modify(IncomingDoc)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "IncomingDoc(Action 13)".

        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Ledger E&ntries"(Action 39)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 39)".

        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify("Renumber Document Numbers")
        {
            ApplicationArea = Basic;
        }
        modify("Apply Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Reconcile)
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

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 44)".

        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 45)".

        }
        modify(SendApprovalRequestJournalBatch)
        {
            ApplicationArea = Basic;
            //Enabled = not OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
        }
        modify(SendApprovalRequestJournalLine)
        {
            ApplicationArea = Basic;
            //Enabled = not OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            ApplicationArea = Basic;
            // Enabled = OpenApprovalEntriesOnJnlBatchExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequestJournalBatch(Action 21)".

        }
        modify(CancelApprovalRequestJournalLine)
        {
            ApplicationArea = Basic;
            // Enabled = OpenApprovalEntriesOnJnlLineExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequestJournalLine(Action 96)".

        }
        modify(Approve)
        {
            ApplicationArea = Basic;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Delegate)
        {
            ApplicationArea = Basic;
        }
        // modify(Comment)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 30)".


        //     //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 30)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 60)".



        //Unsupported feature: Code Modification on "IncomingDoc(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",RECORDID));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "IncomingDoc(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 38)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 38)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 39)".


        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Renumber Document Numbers"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Apply Entries"(Action 83)".


        //Unsupported feature: Property Deletion (Enabled) on ""Apply Entries"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Conv. LCY Rndg. Lines"(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reconcile(Action 42)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Reconcile(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on "Preview(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Preview(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 45)".



        //Unsupported feature: Code Modification on "SendApprovalRequestJournalBatch(Action 50).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
        SetControlAppearanceFromBatch;
        SetControlAppearance;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
        SetControlAppearance;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequestJournalBatch(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequestJournalLine(Action 48)".



        //Unsupported feature: Code Modification on "CancelApprovalRequestJournalBatch(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
        SetControlAppearanceFromBatch;
        SetControlAppearance;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
        SetControlAppearance;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequestJournalBatch(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequestJournalLine(Action 96)".

        // modify(CreateFlow)
        // {
        //     Visible = false;
        // }
        // modify(SeeFlows)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Insertion (VariableCollection) on "Approve(Action 36).OnAction".

        //trigger (Variable: GenJournalBatch)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approve(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJournalBatch.GET("Journal Template Name","Journal Batch Name");
        IF NOT ApprovalsMgmt.ApproveRecordApprovalRequest(GenJournalBatch.RECORDID) THEN
          ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 36)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Approve(Action 36)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Reject(Action 34).OnAction".

        //trigger (Variable: GenJournalBatch)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Reject(Action 34).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJournalBatch.GET("Journal Template Name","Journal Batch Name");
        IF NOT ApprovalsMgmt.RejectRecordApprovalRequest(GenJournalBatch.RECORDID) THEN
          ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 34)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reject(Action 34)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Delegate(Action 32).OnAction".

        //trigger (Variable: GenJournalBatch)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Delegate(Action 32).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJournalBatch.GET("Journal Template Name","Journal Batch Name");
        IF NOT ApprovalsMgmt.DelegateRecordApprovalRequest(GenJournalBatch.RECORDID) THEN
          ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Delegate(Action 32)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Delegate(Action 32)".

        modify(Comment)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Action 30)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Comment(Action 30)".

        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
    }

    var
    //     GenJournalBatch: Record "Gen. Journal Batch";

    // var
    //     GenJournalBatch: Record "Gen. Journal Batch";

    // var
    //     GenJournalBatch: Record "Gen. Journal Batch";


    //Unsupported feature: Property Modification (Id) on "ChangeExchangeRate(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeExchangeRate : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeExchangeRate : 1000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLReconcile(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLReconcile : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLReconcile : 1001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "AccName(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //AccName : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AccName : 50;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "BalAccName(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //BalAccName : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BalAccName : 50;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    EnableApplyEntriesAction;
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

    IF GenJournalBatch.GET("Journal Template Name","Journal Batch Name") THEN
      ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RECORDID);
    ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    CurrPage.IncomingDocAttachFactBox.PAGE.SetCurrentRecordID(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    SetControlAppearance;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalBalanceVisible := TRUE;
    BalanceVisible := TRUE;
    AmountVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalBalanceVisible := TRUE;
    BalanceVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateBalance;
    EnableApplyEntriesAction;
    SetUpNewLine(xRec,Balance,BelowxRec);
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateBalance;
    SetUpNewLine(xRec,Balance,BelowxRec);
    CLEAR(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
    IsSaaS := PermissionManager.SoftwareAsAService;
    IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
      EXIT;
    BalAccName := '';
    SetControlVisibility;
    SetDimensionsVisibility;

    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
      SetControlAppearanceFromBatch;
      EXIT;
    END;
    GenJnlManagement.TemplateSelection(PAGE::"Cash Receipt Journal",3,FALSE,Rec,JnlSelected);
    IF NOT JnlSelected THEN
      ERROR('');
    GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
    SetControlAppearanceFromBatch;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    BalAccName := '';
    #9..11
      SetControlAppearance;
    #13..18
    SetControlAppearance;
    */
    //end;


    //Unsupported feature: Code Modification on "CurrentJnlBatchNameOnAfterVali(PROCEDURE 19002411)".

    //procedure CurrentJnlBatchNameOnAfterVali();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    GenJnlManagement.SetName(CurrentJnlBatchName,Rec);
    SetControlAppearanceFromBatch;
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    GenJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(FALSE);
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: GenJournalBatch) (VariableCollection) on "SetControlAppearance(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetControlAppearance(PROCEDURE 2)".

    //procedure SetControlAppearance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExistForCurrUser :=
      OpenApprovalEntriesExistForCurrUserBatch OR ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);

    OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist OR OpenApprovalEntriesOnJnlLineExist;

    CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

    WorkflowWebhookManagement.GetCanRequestAndCanCancel(RECORDID,CanRequestFlowApprovalForLine,CanCancelFlowApprovalForLine);
    CanRequestFlowApprovalForBatchAndCurrentLine := CanRequestFlowApprovalForBatch AND CanRequestFlowApprovalForLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GenJournalBatch.GET("Journal Template Name","Journal Batch Name") THEN;
    OpenApprovalEntriesExistForCurrUser :=
      ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(GenJournalBatch.RECORDID) OR
      ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);

    OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(GenJournalBatch.RECORDID);
    #4..6
    OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
      OpenApprovalEntriesOnJnlBatchExist OR
      ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries("Journal Template Name","Journal Batch Name");
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "SetControlAppearance(PROCEDURE 2).WorkflowWebhookManagement(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "SetControlAppearance(PROCEDURE 2).CanRequestFlowApprovalForLine(Variable 1001)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
