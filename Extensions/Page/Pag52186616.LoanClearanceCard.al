namespace MNS.MNS;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.Dimension;
using System.Automation;

page 52186616 "Loan Clearance Card"
{
    Caption = 'Loan Clearance Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Import,Approvals,Post,Clear Lines,Reset Tranction Date,Refresh,Validate';
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
            // part(Control17; "Bulk Refund Account Transfers")
            // {
            //     SubPageLink = "Refund Header No." = FIELD(No);
            //     ApplicationArea = Basic;
            //     Visible = RefundLinesVisible;

            // }
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

                    Responce: List of [Text[200]];
                    i: Integer;
                    ErrorText: Text;
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Description);
                    Rec.TestField("Posting date");
                    Rec.CalcFields("Total Count", Rec."Scheduled Amount", Rec.Amount);

                    if Rec."Refund Type" = Rec."Refund Type"::Refund then begin

                        ValidateAccounts;
                        ValidateDescription;
                        rec.TestField(Validated, true);
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
                    //ApprovalEntries: Page "Approval Entries";
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
        Rec."Refund Type" := Rec."Refund Type"::"Loan Clearance";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
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
        PDate := Rec."Posting date";

        LoanNo := '';
        TransType := Transtype::" ";

        SystCreated := true;

        if rec.Posted = true then begin
            Error(Text0001);
        end;

        SaccoT.InitJournal(JTemplate, JBatch);
        RunBal := 0;
        TransAmt := RefundLines.Amount;

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        if RefundLines.FindSet then begin
            repeat
                //Debit Account
                RunBal := RefundLines.Amount;
                TransAmt := 0;
                TransAmt := RefundLines.Amount;
                AccNo := RefundLines."Source Account";
                Dim1 := RefundLines."Global Dimension 1 Code";
                Dim2 := RefundLines."Global Dimension 2 Code";
                // BalAccNo := RefundLines.AccNo;
                ExtDoc := RefundLines."Document No.";
                if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                if MyLoans.Get(RefundLines."Source Loan No.") then begin
                    RefundLines.TestField("Source Loan Transaction.");
                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, MyLoans."Loan Account", CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                '', TransAmt, ExtDoc, MyLoans."Loan No.", RefundLines."Source Loan Transaction.", Dim1, Dim2, SystCreated);
                end else begin
                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                end;


                //Credit Accounts
                if savingsAaacounts.get(RefundLines."Destination Account") then begin
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
                end;
                //Credit Loans
                if MyLoans.get(RefundLines."Loan No.") then begin
                    MyLoans.CalcFields(MyLoans."Outstanding Balance", MyLoans."Outstanding Interest", "Daily Interest");

                    if PeriodicActivities.AmountClearsLoanIfPosted(MyLoans."Loan No.", RefundLines.Amount) then begin
                        if MyLoans."Daily Interest" > 0 then begin
                            If MyLoans."Outstanding Interest" < 0 then
                                MyLoans."Outstanding Interest" := 0;
                            // Accrue Interest;

                            TransAmt := MyLoans."Daily Interest";
                            Pfact.Get(MyLoans."Loan Product Type");
                            Pfact.TestField("Loan Interest Account [G/L]");
                            AcctType := Accttype::Credit;
                            TransType := Transtype::"Interest Due";
                            LineNo := LineNo + 10000;
                            AccNo := MyLoans."Loan Account";
                            BalAccType := BalAccType::"G/L Account";
                            BalAccNo := Pfact."Loan Interest Account [G/L]";

                            SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                        BalAccNo, TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystCreated);

                            MyLoans."Outstanding Interest" += TransAmt;

                            if PostTransaction then
                                LoansProcess.ClearDailyInterest(Loans."Loan No.");

                        end;
                    end;

                    if MyLoans."Outstanding Interest" > 0 then begin
                        if RefundLines.Amount < MyLoans."Outstanding Interest" then
                            MyLoans."Outstanding Interest" := RefundLines.Amount;
                        TransAmt := 0;
                        TransAmt := MyLoans."Outstanding Interest" * -1;
                        AccNo := MyLoans."Loan Account";
                        Dim1 := RefundLines."Global Dimension 1 Code";
                        Dim2 := RefundLines."Global Dimension 2 Code";
                        // BalAccNo := RefundLines.AccNo;
                        ExtDoc := RefundLines."Document No.";
                        if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                        SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines.Description, 1, 50), Balacctype::"G/L Account",
                        '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystCreated);
                        RunBal += TransAmt;
                    end;
                    if RunBal > 0 then begin
                        TransAmt := 0;
                        TransAmt := RunBal * -1;
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
            until RefundLines.Next() = 0;
        end;
        if PostTransaction then begin
            SaccoT.PostJournal(JTemplate, JBatch);
            Rec.Posted := true;
            Rec."Posted By" := UserId;
            Rec."Posting date" := Today;
            Rec."Time Posted" := time;
            Rec.Modify;
            Message('Transaction Posted succesfully');
            exit;
        end else
            SaccoT.PreviewJournal(JTemplate, JBatch);
    end;

    local procedure ClearLoan(PostTransaction: Boolean)
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        Pfact: Record "Product Factory";
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
        LoanClearanceLines: Record "Loan Clearance Lines";
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
        LoanClearanceLines.SetRange("Header No.", Rec.No);
        if LoanClearanceLines.FindSet then begin
            repeat
                LoansProcess.PostCapitalizedInterestDMU(LoanClearanceLines."Loan No.", LoanClearanceLines."Header No.");
            until LoanClearanceLines.Next() = 0;
        end;

        LoanClearanceLines.Reset;
        LoanClearanceLines.SetRange("Header No.", Rec.No);
        if LoanClearanceLines.FindSet then begin
            repeat

                IntBal := LoanClearanceLines."Interest Balance";
                PrBal := LoanClearanceLines."Principle Balance";
                TotalBal := IntBal + PrBal;
                LoanAccount := LoanClearanceLines."Loan Account";

                Dim1 := Rec."Global Dimension 1 Code";
                Dim2 := Rec."Global Dimension 2 Code";
                ExtDoc := Rec.No;
                DepDesc := Rec.Description;
                AccNo := LoanClearanceLines."Source Account No.";
                LoanNo := LoanClearanceLines."Loan No.";

                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                '', -IntBal, ExtDoc, LoanNo, TransactionType::"Interest Paid", Dim1, Dim2, SystCreated);

                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                '', -PrBal, ExtDoc, LoanNo, TransactionType::Repayment, Dim1, Dim2, SystCreated);

                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                '', TotalBal, ExtDoc, '', TransactionType::" ", Dim1, Dim2, SystCreated);
            until LoanClearanceLines.Next() = 0;

            if PostTransaction then begin
                SaccoT.PostJournal(JTemplate, JBatch);
                Rec.Posted := true;
                Rec."Posted By" := UserId;
                Rec."Posting date" := Today;
                Rec."Time Posted" := time;
                Rec.Modify;

                LoanClearanceLines.Reset;
                LoanClearanceLines.SetRange("Header No.", Rec.No);
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
        RefundEdit: Boolean;

        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        RefundLines: Record "Refund,Account Transfer lines";

        SaccoT: Codeunit "Sacco Transactions";
        // BankLed: Record "Cust. Ledger Entry";

        Temp: Record "Banking User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine: record "Gen. Journal Line";
        // DefaultBatch: Record "Gen. Journal Batch";
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
    begin
        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        RefundLines.SetFilter(Amount, '>%1', 0);
        if RefundLines.Find('-') then begin
            repeat
                RefundLines.validated := true;
                if RefundLines."Source Account" <> '' then
                    if Savacc.get(RefundLines."Source Account") then begin
                        if RefundLines.Amount > Savacc.GetAvailableBalance(Savacc."No.") then begin
                            RefundLines."Non Validated Reason" := 'This Account  has a balance of ' + format(Savacc.GetAvailableBalance(Savacc."No.")) + ' Insufficient balance';
                            RefundLines."Validated" := false;
                            RefundLines.Name := Savacc.Name;
                        end
                        else begin
                            RefundLines.Validated := false;
                            RefundLines."Non Validated Reason" := 'Source account not found in Savings Accounts table'
                        end;
                    end;

                if RefundLines."Source Loan No." <> '' then
                    if Loans.get(RefundLines."Loan No.") then begin
                        loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                        if RefundLines.Amount > (loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance") then begin
                            RefundLines."Non Validated Reason" := 'This transaction will lead to overpayment of Loan ' + loans."Loan No." + ' Current total loan balance is ' + format(loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance");
                            RefundLines."Validated" := false;
                        end;
                        RefundLines.Name := Loans."Member Name";
                    end
                    else begin
                        RefundLines."Non Validated Reason" := 'The Loan was not found in loans table';
                        RefundLines."Validated" := false;
                    end;


                if (rec."Global Dimension 1 Code" <> '') and not DimValue.get(rec."Global Dimension 1 Code") then begin
                    RefundLines.Validated := false;
                    RefundLines."Non Validated Reason" := 'Branch code not found';
                end;
                if (rec."Global Dimension 2 Code" <> '') and not DimValue.get(rec."Global Dimension 2 Code") then begin
                    RefundLines.Validated := true;
                    RefundLines."Non Validated Reason" := 'Activity Code was not found';
                end;
                RefundLines.Modify;
            until RefundLines.Next = 0;
        end;
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

