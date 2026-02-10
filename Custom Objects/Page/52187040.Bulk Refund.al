page 52187040 "Bulk Refunds Card"
{
    ApplicationArea = All;
    Caption = 'Bulk Refunds Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Import,Approvals,Post,Clear Lines,Reset Tranction Date,Refresh,Validate,Reset Transaction';
    SourceTable = "Refund,Account Transfer Header";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.';
                    Editable = false;
                }

                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                    Editable = false;
                }
                field("Refund Type"; Rec."Refund Type")
                {
                    Editable = RefundEdit;
                    trigger OnValidate()
                    begin
                        PageControl();
                    end;
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description.';
                }
                field(SendSMS; Rec."Send SMS")
                {
                    ToolTip = 'Specifies the value of the SendSMS field.';
                    Caption = 'Send SMS Notification';
                }
                field("Posting date"; Rec."Posting date")
                {
                    ToolTip = 'Specifies the value of the Posting date field.';
                }
                field("Time Posted"; Rec."Time Posted") { editable = false; }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                    Visible = false;
                }

                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Caption = 'Scheduled Amount';
                    ToolTip = 'Specifies the value of the Scheduled Amount field.';
                }

                field(Validated; Rec.Validated)
                {
                    ToolTip = 'Specifies the value of the Validated field.';
                    Editable = false;
                }


                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { Editable = false; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { Editable = false; }
                field("Responsibility Center"; Rec."Responsibility Center") { Editable = false; }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                    Editable = false;
                }
            }
            part(Control17; "Bulk Refund Account Transfers")
            {
                SubPageLink = "Refund Header No." = FIELD(No);
                ApplicationArea = Basic;
                Visible = RefundLinesVisible;
                // Visible = (rec."Responsibility Center" <> 'FINANCE') and RefundLinesVisible;

            }

            part(Control18; "Loan Clearance Lines")
            {
                SubPageLink = "Header No." = FIELD(No);
                ApplicationArea = Basic;
                Visible = LoanClearanceLinesVisible;
            }
        }

    }
    actions
    {
        area(creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Responce: List of [Text[200]];
                    i: Integer;
                    ErrorText: Text;
                begin
                    Rec.TestField("Document No");
                    Rec.TestField("Posting date");
                    Rec.CalcFields("Total Count", Rec."Scheduled Amount", Rec.Amount);
                    rec.TestField(Validated, true);


                    if Rec."Refund Type" = Rec."Refund Type"::Refund then begin

                        ValidateAccounts;
                        ValidateDescription;
                        rec.TestField(Validated, true);
                        if rec."Scheduled Amount" = 0 then
                            Error('Scheduled Amount must be greater than 0.');
                    end;
                    if Rec."Refund Type" = Rec."Refund Type"::"Loan Clearance" then
                        Responce := CompareAssetsAndLiabilities();

                    if Responce.Count > 0 then begin
                        for i := 1 to Responce.Count do begin
                            if i < Responce.Count then
                                ErrorText += Format(i) + '. ' + Responce.Get(i) + '\'
                            else
                                ErrorText += Format(i) + '. ' + Responce.Get(i);
                        end;

                        Error(ErrorText);
                    end;

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                    CurrPage.Close();
                end;

            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category5;

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
                promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("XML IMPORT")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                caption = 'Import';
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = xmlport "Inter Account";
                Enabled = RefundLinesVisible;
                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    if Rec.Status <> Rec.Status::Open then
                        Error('Status must be open.');
                end;

            }
            action("Generate Bulk Refunds Entries(Unallocated)")
            {
                ApplicationArea = Basic, Suite;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    INHeader: Record "Refund,Account Transfer Header";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    INHeader.Reset();
                    INHeader.SetRange("No", Rec."No");
                    if INHeader.FindFirst() then begin
                        REPORT.Run(Report::"Generate Bulk Refunds", true, false, INHeader);
                    end;
                end;
            }
            action("Recover Loan arrears Amount")
            {
                ApplicationArea = Basic, Suite;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    INHeader: Record "Refund,Account Transfer Header";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    INHeader.Reset();
                    INHeader.SetRange("No", Rec."No");
                    if INHeader.FindFirst() then begin
                        REPORT.Run(Report::"Recover Arrears", true, false, INHeader);
                    end;
                end;
            }
            action("Recover FOSA Arrears")
            {
                ApplicationArea = Basic, Suite;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    INHeader: Record "Refund,Account Transfer Header";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    INHeader.Reset();
                    INHeader.SetRange("No", Rec."No");
                    if INHeader.FindFirst() then begin
                        REPORT.Run(Report::"Recover FOSA Arrears", true, false, INHeader);
                    end;
                end;
            }
            // action("Refund Excess Int to Principle")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = GetEntries;
            //     Promoted = true;
            //     PromotedCategory = "Process";
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         INHeader: Record "Refund,Account Transfer Header";
            //     begin
            //         Rec.TestField(Status, Rec.Status::Open);

            //         INHeader.Reset();
            //         INHeader.SetRange("No", Rec."No");
            //         if INHeader.FindFirst() then begin
            //             REPORT.Run(Report::"Refund Excess I to P", true, false, INHeader);
            //         end;
            //     end;
            // }
            action("Recover Loans Below Amount")
            {
                ApplicationArea = Basic, Suite;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    INHeader: Record "Refund,Account Transfer Header";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    rec.TestField(Description);
                    INHeader.Reset();
                    INHeader.SetRange("No", Rec."No");
                    if INHeader.FindFirst() then begin
                        REPORT.Run(Report::"Recover Loans Below 100", true, false, INHeader);
                    end;
                end;
            }
            action("Recover Overpaid Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = OverdueEntries;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    INHeader: Record "Refund,Account Transfer Header";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    rec.TestField(Description);
                    INHeader.Reset();
                    INHeader.SetRange("No", Rec."No");
                    if INHeader.FindFirst() then begin
                        REPORT.Run(Report::"Recover Overpaid Loans", true, false, INHeader);
                    end;
                end;
            }

            action("Post")
            {
                ApplicationArea = basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    if Rec."Refund Type" = Rec."Refund Type"::Refund then
                        BulkRefundPost(true);

                    if Rec."Refund Type" = Rec."Refund Type"::"Loan Clearance" then
                        ClearLoan(true);

                    CurrPage.Close();
                end;

            }

            action("Post Preview")
            {
                ApplicationArea = basic, Suite;
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Category6;
                Visible = false;
                trigger OnAction()
                begin
                    if Rec."Refund Type" = Rec."Refund Type"::Refund then
                        BulkRefundPost(false);
                    if Rec."Refund Type" = Rec."Refund Type"::"Loan Clearance" then
                        ClearLoan(false);
                end;
            }

            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category9;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            group("Reset User & Transaction")
            {
                action(ResetUser)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Restore;
                    Promoted = true;
                    PromotedCategory = Category11;
                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        rec.testfield(Posted, false);
                        if rec.Status = Rec.Status::Approved then
                            Error('Status must be open before resetting');

                        rec."Entered By" := UserId;
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.Find('-') then begin
                            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                            UserSetup.TestField(UserSetup."Global Dimension 2 Code");

                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            rec.Modify();
                        end;

                    end;
                }
                //action("Reset Transaction")
            }

            action("Clear Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    case
                        Rec."Refund Type" of
                        Rec."Refund Type"::Refund:
                            begin
                                AccTransLines.Reset();
                                AccTransLines.SetRange("Refund Header No.", Rec.No);
                                if AccTransLines.FindSet() then
                                    AccTransLines.DeleteAll();
                            end;
                        Rec."Refund Type"::"Loan Clearance":
                            begin
                                LoanTransLines.Reset();
                                LoanTransLines.SetRange("Header No.", Rec.No);
                                if LoanTransLines.FindSet() then
                                    LoanTransLines.DeleteAll();
                            end;
                    end;
                    Message('Transfer Lines Cleared');
                end;
            }
            Action("Clear UnValidated Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category10;
                Enabled = Rec."Refund Type" = Rec."Refund Type"::Refund;
                trigger OnAction()
                begin
                    case
                        Rec."Refund Type" of
                        Rec."Refund Type"::Refund:
                            begin
                                AccTransLines.Reset();
                                AccTransLines.SetRange("Refund Header No.", Rec.No);
                                AccTransLines.SetRange(Validated, false);
                                if AccTransLines.FindSet() then
                                    AccTransLines.DeleteAll();
                            end;
                    end;
                    Message('Unavalidated Transfer Lines Cleared Successfullty');
                end;
            }
            Action("Validate Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                begin

                    // ValidateAccounts;
                    // ValidateDescription;
                    if rec.Validated = true then
                        if Confirm('The lines were already validated. Do you want to re-validate?', false) = false then
                            exit;
                    ValidateLinesII;
                    if Verify() then begin
                        Rec.validated := true;
                        rec.Modify();
                        message('Validation has been completed successfully. All lines have been validated successfully');
                    end
                    else
                        Message('Validation has been completed successfully. There are some lines that have not been validated. Kindly check the lines before Proceeding.');
                end;
            }
            // Action("Clear Un-validated Lines")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = delete;
            //     Promoted = true;
            //     PromotedCategory = Category10;
            //     trigger OnAction()
            //     begin

            //         // ValidateAccounts;
            //         // ValidateDescription;
            //         ValidateLinesII;
            //         if Verify() then begin
            //             Rec.validated := true;
            //             rec.Modify();
            //             message('Validation has been completed successfully. All lines have been validated successfully');
            //         end
            //         else
            //             Message('Validation has been completed successfully. There are some lines that have not been validated. Kindly check the lines before Proceeding.');
            //     end;
            // }

            action("Reset Transaction Date")
            {
                ApplicationArea = Basic, Suite;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Category8;
                Enabled = Rec.Posted = false;
                trigger OnAction()
                begin
                    rec."Posting date" := Today;
                    rec.Modify();
                    Message('Posting Date updated successfully!')
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                        Rec.TestField(Posted, false);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        CurrPage.Close();
                    end;
                end;
            }
            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category5;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field(No);
                RunPageView = where(Types = CONST(comment));
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Image = Print;
                Promoted = true;
                Caption = 'Print';
                PromotedCategory = Report;
                trigger OnAction()
                var
                    RefundAccTransHdr: Record "Refund,Account Transfer Header";
                begin
                    RefundAccTransHdr.Reset();
                    RefundAccTransHdr.SetRange(No, Rec.No);
                    if RefundAccTransHdr.FindFirst() then
                        Report.Run(Report::"Bulk Account Refunds Report", true, false, RefundAccTransHdr);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        editCard := true;
        if (rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            CurrPage.Editable := False;
            editCard := false;
        end else
            CurrPage.Editable := true;
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
        PageControl();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Refund Type" := rec."Refund Type"::Refund;
    end;

    trigger OnAfterGetRecord()

    begin
        editCard := true;
        if (rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            CurrPage.Editable := False;
            editCard := false;
        end else
            CurrPage.Editable := true;
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
        PageControl();

        RefundEdit := true;
        if Rec."Refund Type" <> Rec."Refund Type"::" " then begin
            RefundEdit := false;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PageControl();
        RefundEdit := true;
        if Rec."Refund Type" <> Rec."Refund Type"::" " then begin
            RefundEdit := false;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
        Rec."Refund Type" := Rec."Refund Type"::Refund;
    end;

    procedure ValidateDescription()
    begin
        case Rec."Refund Type" of
            Rec."Refund Type"::Refund:
                begin
                    AccTransLines.Reset();
                    AccTransLines.SetRange("Refund Header No.", Rec.No);
                    if AccTransLines.FindSet() then
                        repeat
                            if AccTransLines.Description = '' then
                                Error('Description is required in line for account %1', AccTransLines."Account No.");
                        until AccTransLines.Next() = 0;
                end;
            Rec."Refund Type"::"Loan Clearance":
                begin
                    Rec.TestField(Description);
                end;
        end;
    end;

    local procedure BulkRefundPost(PostTransaction: Boolean)
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        Pfact: Record "Product Factory";
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
        RemainingAmt: Decimal;
        GLEntry: Record "G/L Entry";

    begin

        Rec.TestField(Posted, false);
        if Rec.Status <> Rec.Status::Approved then
            Error('Status must be approved before posting');
        Temp.Get(UserId);

        JTemplate := Temp."Transfer Journal Template";
        JBatch := Temp."Transfer Journal Batch";

        GLEntry.Reset();
        GLEntry.SetRange("Document No.", rec.No);
        if GLEntry.FindFirst() then begin
            Rec.Posted := true;
            Rec."Posted By" := UserId;
            Rec."Posting date" := Today;
            Rec."Time Posted" := time;
            Rec.Modify;
            Message('Transaction Posted succesfully');
            exit;
        end;


        if JTemplate = '' then begin
            Error('Ensure the Transfer Journal Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Transfer Journal Batch is set up in Banking  User Setup')
        end;

        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := '';

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";

        DocNo := Rec.No;
        PDate := Rec."Posting date";

        LoanNo := '';
        TransType := Transtype::" ";

        SystCreated := true;

        if rec.Posted = true then begin
            Error(Text0001);
        end;

        SaccoT.InitJournal(JTemplate, JBatch);
        // RunBal := 0;
        TransAmt := 0;
        RemainingAmt := 0;

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        if RefundLines.FindSet then begin
            repeat
                RemainingAmt := 0;
                RemainingAmt := RefundLines.Amount;

                //Debit Accounts
                TransAmt := 0;
                TransAmt := RefundLines.Amount;
                AccNo := RefundLines."Source Account";
                Dim1 := RefundLines."Global Dimension 1 Code";
                Dim2 := RefundLines."Global Dimension 2 Code";
                // BalAccNo := RefundLines.AccNo;
                ExtDoc := RefundLines."Document No.";
                if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                if MyLoans.Get(RefundLines."Source Loan No.") and (RefundLines."Source Loan No." <> '') then begin
                    RefundLines.TestField("Source Loan Transaction.");
                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, MyLoans."Loan Account", CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                '', TransAmt, ExtDoc, MyLoans."Loan No.", RefundLines."Source Loan Transaction.", Dim1, Dim2, SystCreated);
                end else begin
                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                end;

                TransAmt := 0;
                //Credit Accounts
                if savingsAaacounts.get(RefundLines."Destination Account") and (RefundLines."Destination Account" <> '') then begin
                    TransAmt := 0;
                    TransAmt := RefundLines.Amount * -1;
                    AccNo := RefundLines."Destination Account";
                    Dim1 := RefundLines."Global Dimension 1 Code";
                    Dim2 := RefundLines."Global Dimension 2 Code";
                    // BalAccNo := RefundLines.AccNo;
                    ExtDoc := RefundLines."Document No.";
                    if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                    '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                end
                else begin
                    if MyLoans.get(RefundLines."Loan No.") and (MyLoans."Loan No." <> '') then begin
                        // MyLoans.CalcFields(MyLoans."Outstanding Balance", MyLoans."Outstanding Interest");

                        //if PeriodicActivities.AmountClearsLoanIfPosted(MyLoans."Loan No.", RefundLines.Amount) then begin
                        // if RefundLines.Amount >= (MyLoans."Outstanding Balance" + MyLoans."Outstanding Interest" + MyLoans."Daily Interest") then Begin
                        // if MyLoans."Daily Interest" > 0 then begin
                        //     If MyLoans."Outstanding Interest" < 0 then
                        //         MyLoans."Outstanding Interest" := 0;
                        //     // Accrue Interest;

                        //     TransAmt := 0;
                        //     TransAmt := MyLoans."Daily Interest";
                        //     Pfact.Get(MyLoans."Loan Product Type");
                        //     Pfact.TestField("Loan Interest Account [G/L]");
                        //     AcctType := Accttype::Credit;
                        //     TransType := Transtype::"Interest Due";
                        //     LineNo := LineNo + 10000;
                        //     AccNo := MyLoans."Loan Account";
                        //     BalAccType := BalAccType::"G/L Account";
                        //     BalAccNo := Pfact."Loan Interest Account [G/L]";


                        //     // Post daily interest-TODO
                        //     // JournalPosting.PostJournal(JTemplate, JBatch, LineNo, "Gen. Journal Account Type"::Credit, receiptline.No, 'Daily Interest Capitalized ' + Loan."Loan No.", Loans."Daily Interest", Loans."Loan Account", rec.Date, "Gen. Journal Account Type"::"G/L Account",
                        //     //                        ProductFactory."Loan Interest Account [G/L]", ReceiptLine."Loan No.", ReceiptLine."Global Dimension 1 Code", ReceiptLine."Shortcut Dimension 2 Code", ReceiptLine."Transaction Type"::"Interest due", ReceiptLine."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                        // //     SaccoT.JournalInsert(LoanTemp, loanBatch, DocNo, Today, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                        // // BalAccNo, MyLoans."Daily Interest", ExtDoc, MyLoans."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystCreated);

                        // //     SaccoT.PostJournal(LoanTemp, loanBatch, false);

                        // //     LoansProcess.ClearDailyInterest(MyLoans."Loan No.");

                        // end;
                        // end;

                        MyLoans.CalcFields("Outstanding Balance", "Outstanding Interest");

                        if MyLoans."Outstanding Interest" > 0 then begin
                            if RemainingAmt >= MyLoans."Outstanding Interest" then begin
                                //MyLoans."Outstanding Interest" := RemainingAmt;

                                TransAmt := 0;
                                TransAmt := (MyLoans."Outstanding Interest" * -1);
                                AccNo := MyLoans."Loan Account";
                                Dim1 := RefundLines."Global Dimension 1 Code";
                                Dim2 := RefundLines."Global Dimension 2 Code";
                                // BalAccNo := RefundLines.AccNo;
                                ExtDoc := RefundLines."Document No.";
                                if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                                '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystCreated);
                                //RunBal += TransAmt;

                                RemainingAmt -= MyLoans."Outstanding Interest";
                            end
                            else begin
                                TransAmt := 0;
                                TransAmt := -(RemainingAmt);
                                AccNo := MyLoans."Loan Account";
                                Dim1 := RefundLines."Global Dimension 1 Code";
                                Dim2 := RefundLines."Global Dimension 2 Code";
                                // BalAccNo := RefundLines.AccNo;
                                ExtDoc := RefundLines."Document No.";
                                if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                                '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystCreated);
                                //RunBal += TransAmt;

                                RemainingAmt := 0;
                            end;
                        end;
                        if RemainingAmt > 0 then begin
                            TransAmt := 0;
                            TransAmt := RemainingAmt * -1;
                            AccNo := MyLoans."Loan Account";
                            Dim1 := RefundLines."Global Dimension 1 Code";
                            Dim2 := RefundLines."Global Dimension 2 Code";
                            // BalAccNo := RefundLines.AccNo;
                            ExtDoc := RefundLines."Document No.";
                            if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                            SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                            '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::Repayment, Dim1, Dim2, SystCreated);
                        end;
                    end;
                end;
            //Credit Loans




            until RefundLines.Next() = 0;
        end;
        if PostTransaction then begin
            SaccoT.PostJournal(JTemplate, JBatch, false);
            Rec.Posted := true;
            Rec."Posted By" := UserId;
            Rec."Posting date" := Today;
            Rec."Time Posted" := time;
            Rec.Modify;
            Message('Transaction Posted succesfully');
            //to do: send sms
            //get member details
            if rec."Send SMS" then begin
                RefundLines.Reset;
                RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
                RefundLines.setrange(RefundLines."Recover Arrears", true);
                RefundLines.setfilter(Amount, '>100');
                if RefundLines.FindSet then begin
                    repeat
                        // if (RefundLines."Recover Arrears") and (RefundLines.Amount > 100) then begin
                        SavingsAccounts.get(RefundLines."Source Account");
                        MemberNo := savingsAccounts."Member No.";
                        Member.Get(MemberNo);
                        if Loans.Get(RefundLines."Loan No.") then begin
                            if Member."First Name" <> '' then
                                msg := 'Dear ' + Member."First Name" + ', arrears of ' + Format(RefundLines.Amount) + ' has been recovered for ' + Loans."Loan Product Type Name" + ': ' + Loans."Loan No." + ' on ' + Format(Today) + ' ' + Format(Time)
                            else
                                msg := 'Dear ' + Member.Name + ', arrears of ' + Format(RefundLines.Amount) + ' has been recovered for ' + Loans."Loan Product Type Name" + ': ' + Loans."Loan No." + ' on ' + Format(Today) + ' ' + Format(Time);

                            // msg := 'Dear ' + Member.Name + ', arrears of ' + Format(RefundLines.Amount) + ' has been recovered for ' + Loans."Loan Product Type Name" + ': ' + Loans."Loan No." + ' on ' + Format(Today) + ' ' + Format(Time);
                            SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Member."Phone No.", msg, Format(Member."No."), '', true, 0, false, 'CBS', Member."No.", 'CBS');
                        end;
                    // end;
                    until RefundLines.Next() = 0;
                end;
            end;
        end
        else
            SaccoT.PreviewJournal(JTemplate, JBatch);
    end;

    local procedure ClearLoan(PostTransaction: Boolean)
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        Pfact: Record "Product Factory";
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
        // LoanClearanceLines: Record "Loan Clearance Lines";
        LoanClearanceLines: Record "Refund,Account Transfer lines";
        IntBal: Decimal;
        PrBal: Decimal;
        TotalBal: Decimal;
        LoanAccount: Code[100];
        LoanNo: Code[50];
        TransactionType: Enum "Transaction Types";
        AccNo: Code[50];
    begin
        Rec.TestField(Posted, false);
        if Rec.Status <> Rec.Status::Approved then
            Error('Status must be approved before posting');
        Temp.Get(UserId);

        JTemplate := Temp."Transfer Journal Template";
        JBatch := Temp."Transfer Journal Batch";

        if JTemplate = '' then begin
            Error('Ensure the Transfer Journal Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Transfer Journal Batch is set up in Banking  User Setup')
        end;

        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := '';

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";

        DocNo := Rec.No;
        PDate := Rec."Date Entered";

        LoanNo := '';
        TransType := Transtype::" ";

        SystCreated := true;

        if rec.Posted = true then begin
            Error(Text0001);
        end;

        SaccoT.InitJournal(JTemplate, JBatch);
        RunBal := 0;
        TransAmt := RefundLines.Amount;


        LoanClearanceLines.Reset;
        LoanClearanceLines.SetRange("Refund Header No.", Rec.No);
        if LoanClearanceLines.FindSet then begin
            repeat
                LoansProcess.PostCapitalizedInterestDMU(LoanClearanceLines."Loan No.", LoanClearanceLines."Refund Header No.");
            until LoanClearanceLines.Next() = 0;
        end;

        LoanClearanceLines.Reset;
        LoanClearanceLines.SetRange("Refund Header No.", Rec.No);
        if LoanClearanceLines.FindSet then begin
            repeat

                // IntBal := LoanClearanceLines."Interest Balance";
                // PrBal := LoanClearanceLines."Principle Balance";
                // TotalBal := IntBal + PrBal;
                TotalBal := LoanClearanceLines.Amount;
                if Loans.Get(LoanClearanceLines."Loan No.") then
                    LoanAccount := Loans."Loan Account";


                Dim1 := Rec."Global Dimension 1 Code";
                Dim2 := Rec."Global Dimension 2 Code";
                ExtDoc := Rec.No;
                DepDesc := Rec.Description;
                AccNo := LoanClearanceLines."Source Account";
                LoanNo := LoanClearanceLines."Loan No.";

                // SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                // '', -IntBal, ExtDoc, LoanNo, TransactionType::"Interest Paid", Dim1, Dim2, SystCreated);

                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                '', -TotalBal, ExtDoc, LoanNo, TransactionType::Repayment, Dim1, Dim2, SystCreated);

                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                '', TotalBal, ExtDoc, '', TransactionType::" ", Dim1, Dim2, SystCreated);


                //to do: send sms
                //get member details
                SavingsAccounts.get(LoanClearanceLines."Source Account");
                MemberNo := savingsAccounts."Member No.";
                Member.Get(MemberNo);
                Loans.Get(LoanClearanceLines."Loan No.");

                msg := 'Dear ' + Member.Name + ', arrears of ' + Format(LoanClearanceLines.Amount) + ' has been recovered for loan ' + Loans."Loan Product Type Name" + ' on ' + Format(Today) + ' ' + Format(Time);

                SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Member."Phone No.", msg, Format(Member."No."), '', true, 0, false, 'CBS', Member."No.", 'CBS');
            until LoanClearanceLines.Next() = 0;

            if PostTransaction then begin
                SaccoT.PostJournal(JTemplate, JBatch);
                Rec.Posted := true;
                Rec."Posted By" := UserId;
                Rec."Posting date" := Today;
                Rec."Time Posted" := time;
                Rec.Modify;

                LoanClearanceLines.Reset;
                LoanClearanceLines.SetRange("Refund Header No.", Rec.No);
                if LoanClearanceLines.FindSet then begin
                    repeat
                        LoansProcess.AdviceLoan(LoanClearanceLines."Loan No.", false, Rec.No);
                    until LoanClearanceLines.Next() = 0;
                end;
                Message('Transaction Posted succesfully');

                exit;
            end else
                SaccoT.PreviewJournal(JTemplate, JBatch);
        end;
    end;


    local procedure CompareAssetsAndLiabilities(): List of [Text[200]]
    var
        ClearanceLines: Record "Loan Clearance Lines";
        SourceAccounts: list of [code[50]];
        i: Integer;
        ListResponse: list of [Text[200]];
        AccountBalance: Decimal;
        LoanBalances: Decimal;
        LoanBal: Decimal;
        RecoveryHeader: Record "Loan Recovery Header";
        SavingsAccounts: Record "Savings Accounts";
    begin
        ClearanceLines.Reset();
        ClearanceLines.SetRange("Header No.", Rec.No);
        if ClearanceLines.Find('-') then begin
            repeat
                if not SourceAccounts.Contains(ClearanceLines."Source Account No.") then
                    SourceAccounts.Add(ClearanceLines."Source Account No.");
            until ClearanceLines.Next() = 0;
        end;

        for i := 1 to SourceAccounts.Count do begin
            AccountBalance := SavingsAccounts.GetAvailableBalance(SourceAccounts.Get(i));
            ClearanceLines.Reset();
            ClearanceLines.SetRange("Source Account No.", SourceAccounts.Get(i));
            if ClearanceLines.Find('-') then begin
                repeat
                    if ClearanceLines."Loan No." <> '' then
                        RecoveryHeader.GetLoanBalances(ClearanceLines."Loan No.", LoanBal);

                    LoanBalances += LoanBal;
                until ClearanceLines.Next() = 0;
            end;
            if LoanBalances > AccountBalance then
                ListResponse.Add('Account No''s ' + SourceAccounts.Get(i) + ', balance of KES ' + Format(AccountBalance) + ', can not clear liabilities worth KES ' + Format(LoanBalances));
        end;
        exit(ListResponse);
    end;

    local procedure PageControl()
    begin
        if Rec."Refund Type" = Rec."Refund Type"::"Loan Clearance" then begin
            RefundLinesVisible := false;
            LoanClearanceLinesVisible := true;
        end;
        if Rec."Refund Type" = Rec."Refund Type"::Refund then begin
            RefundLinesVisible := true;
            LoanClearanceLinesVisible := false;
        end;
    end;

    var
        AccTransLines: Record "Refund,Account Transfer lines";
        LoanTransLines: Record "Loan Clearance Lines";
        msg: Text[250];
        RefundEdit: Boolean;

        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        RefundLines: Record "Refund,Account Transfer lines";

        SaccoT: Codeunit "Sacco Transactions";
        BankLed: Record "Cust. Ledger Entry";

        Temp: Record "Banking User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        // CashOfficeSetup: Record "Cash Office Setup";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        MyLoans: Record Loans;
        Text0001: label 'Transaction Already Posted';


        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Factory";
        LT: Text;
        AccountToCharge: Code[20];
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "General Set-Up";
        DepDesc: Text;
        MobileNo: Code[20];
        LengthWithin: Boolean;
        FosaAcc: Record "Savings Accounts";
        NewAccBalance: Decimal;
        BusinessAccount: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        BusinessProdCode: Code[30];
        AgentSavings: Record "Savings Accounts";
        AgentFloatAcc: Record "Savings Accounts";
        Agent: Record "Agent Applications";
        ReceipientPhoneNumber: Text;
        ReceipientsName: Text;
        LineNo: Integer;
        TransAmt: Decimal;
        editCard: Boolean;
        savingsAaacounts: Record "Savings Accounts";
        Loans: Record loans;

        //Controls
        RefundLinesVisible: Boolean;
        LoanClearanceLinesVisible: Boolean;
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        Member: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        MemberNo: Code[20];


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    procedure ValidateAccounts()
    var
        myInt: Integer;
        Savacc: Record "Savings Accounts";
    begin

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        RefundLines.SetFilter(Amount, '>%1', 0);
        if RefundLines.Find('-') then begin
            repeat
                if Savacc.get(RefundLines."Source Account") then begin
                    if RefundLines.Amount > Savacc.GetAvailableBalance(Savacc."No.") then
                        Error('This Account :%1 has a balance of %2 insufficient to complete transfer of %3.', Savacc."No.", Savacc.GetAvailableBalance(Savacc."No."), RefundLines.Amount);
                    if RefundLines.Amount <= 0 then Error('The %1 amount is invalid.', RefundLines.Amount);
                end else
                    RefundLines.TestField("Source Loan No.");
                if Loans.get(RefundLines."Loan No.") then begin
                    loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    if RefundLines.Amount > (loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance") then
                        Error('This transaction of %1 will lead to overpayment of Loan %2. Current total loan balance is %3.', RefundLines.Amount, loans."Loan No.", (loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance"));
                end;
            until RefundLines.Next = 0;
        end;
    end;

    procedure ValidateLinesII()
    var
        Savacc: Record "Savings Accounts";
        DimValue: record Dimension;
        CreditAccount: Record "Credit Accounts";
        loanz: record loans;
    begin
        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        RefundLines.SetFilter(Amount, '>%1', 0);
        if RefundLines.Find('-') then begin
            repeat
                RefundLines.validated := true;
                RefundLines."Non Validated Reason" := '';
                if RefundLines.Amount <= 0 then begin
                    RefundLines."Non Validated Reason" := 'The amount is 0';
                    RefundLines.validated := false;
                end;
                if RefundLines."Source Account" <> '' then begin
                    if Savacc.get(RefundLines."Source Account") then begin
                        if RefundLines.Amount > Savacc.GetAvailableBalance(Savacc."No.") then begin
                            RefundLines."Non Validated Reason" := 'This Account  has a balance of ' + format(Savacc.GetAvailableBalance(Savacc."No.")) + ' Insufficient balance';
                            RefundLines."Validated" := false;
                            if (Savacc.Blocked = Savacc.Blocked::All) or (Savacc.Blocked = Savacc.Blocked::Debit) then begin
                                RefundLines."Non Validated Reason" := 'Account is blocked with type ' + format(Savacc.Blocked);
                                RefundLines."Validated" := false;
                                RefundLines.Name := Savacc.Name;
                            end;
                        end;
                        // if RefundLines.Validated then begin
                        //     //RefundLines.validate("Account No.");
                        //     RefundLines.Validate("Source Account");
                        // end;
                    end
                    else begin
                        RefundLines.Validated := false;
                        RefundLines."Non Validated Reason" := 'Source Account was not found';
                    end;
                end
                else begin
                    if RefundLines."Source Loan No." <> '' then begin
                        if RefundLines."Source Account" <> '' then begin
                            RefundLines.Validated := false;
                            RefundLines."Non Validated Reason" := 'Both Source acc and loan no cannot be the source at a given time';
                        end;
                        if not loanz.Get(RefundLines."Source Loan No.") then begin
                            RefundLines."Non Validated Reason" := 'The source Loan was not found in loans table';
                            RefundLines."Validated" := false;
                        end;
                        // if RefundLines."Loan No." <> '' then begin
                        //     if not Loans.get(RefundLines."Loan No.") then begin
                        //         RefundLines."Non Validated Reason" := 'The destination Loan was not found in loans table';
                        //         RefundLines."Validated" := false;
                        //     end;
                        // end;

                        if (RefundLines."Source Loan Transaction." <> RefundLines."Source Loan Transaction."::"Interest Due") and (RefundLines."Source Loan Transaction." <> RefundLines."Source Loan Transaction."::Loan) then begin
                            RefundLines."Non Validated Reason" := 'No source loan transaction was provided/Invalid source loan transaction';
                            RefundLines."Validated" := false;
                        end;
                        if not CreditAccount.Get(loanz."Loan Account") then begin
                            RefundLines."Non Validated Reason" := 'The source loan account was not found in the credit accounts table';
                            RefundLines."Validated" := false;
                        end
                        else if (CreditAccount.Blocked = Savacc.Blocked::All) or (CreditAccount.Blocked = CreditAccount.Blocked::Debit) then begin
                            RefundLines."Non Validated Reason" := 'Account is blocked with type ' + format(Savacc.Blocked);
                            RefundLines."Validated" := false;
                        end;
                        RefundLines.Name := loanz."Member Name";

                    end
                    else begin
                        RefundLines."Non Validated Reason" := 'No source account or loan no was provided';
                        RefundLines."Validated" := false;
                    end;
                end;
                // Destination Acc
                if refundlines."Destination Account" <> '' then begin
                    if not Savacc.get(refundlines."Destination Account") then begin
                        RefundLines."Non Validated Reason" := 'Destination Account was not found';
                        RefundLines."Validated" := false;
                    end
                    else
                        if (Savacc.Blocked = Savacc.Blocked::All) or (Savacc.Blocked = Savacc.Blocked::Credit) then begin
                            RefundLines."Non Validated Reason" := 'Account is blocked with type ' + format(Savacc.Blocked);
                            RefundLines."Validated" := false
                        end
                        else
                            RefundLines.Validate("Destination Account");
                end
                else if RefundLines."Loan No." <> '' then begin
                    if not Loans.get(RefundLines."Loan No.") then begin
                        RefundLines."Non Validated Reason" := 'The Loan was not found in loans table';
                        RefundLines."Validated" := false;
                    end
                    else
                        if RefundLines."Destination Account" <> '' then begin
                            RefundLines."Non Validated Reason" := 'Both destination Acc. and loan cannot have a value.';
                            RefundLines."Validated" := false;
                        end;
                    if RefundLines.Amount > 0 then begin
                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                        if RefundLines.Amount > (Loans."Outstanding Interest" + Loans."Daily Interest" + Loans."Outstanding Balance") then begin
                            RefundLines."Non Validated Reason" := 'This transaction of ' + format(RefundLines.Amount) + ' will lead to overpayment of Loan ' + Loans."Loan No." + '. Current total loan balance is ' + format(Loans."Outstanding Interest" + Loans."Daily Interest" + Loans."Outstanding Balance");
                            RefundLines."Validated" := false;
                        end;
                    end;
                    if not CreditAccount.Get(Loans."Loan Account") then begin
                        RefundLines."Non Validated Reason" := 'The source loan transaction was not found in the credit accounts table';
                        RefundLines."Validated" := false;
                    end
                    else if (CreditAccount.Blocked = CreditAccount.Blocked::All) or (CreditAccount.Blocked = CreditAccount.Blocked::Credit) then begin
                        RefundLines."Non Validated Reason" := 'Account is blocked with type ' + format(Savacc.Blocked);
                        RefundLines."Validated" := false;
                    end;
                end
                else if (RefundLines."Loan No." = '') and (RefundLines."Destination Account" = '') then begin
                    RefundLines."Non Validated Reason" := 'No destination account or loan no was provided';
                    RefundLines."Validated" := false;
                end;
                RefundLines.Modify;
            until RefundLines.Next = 0;
        end
        else begin
            Message('No records were found for validation');
        end
    end;


    procedure Verify(): Boolean
    begin

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        if RefundLines.find('-') then
            repeat
                if RefundLines."Validated" = false then
                    exit(false);
            until RefundLines.Next = 0;
        exit(true);
    end;
}
