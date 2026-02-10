page 52185870 "Posted Account Interest Header"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Savings Interest Header";
    SourceTableView = WHERE(Posted = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = pageEditable;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEditable;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = pageEditable;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = pageEditable;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = pageEditable;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {

                }
                field("Product Name"; Rec."Product Name")
                {

                }
                field("Distributed Amount"; Rec."Distributed Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control18; "Account Interest Buffer")
            {
                SubPageLink = No = FIELD("No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Action31)
            {
                action("Generate Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate Entries';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        SelectOpttionsErr: Label 'Select Options';
                    begin
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField(Description);
                        Rec.TestField("Responsibility Center");
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Document No.");
                        Rec.TestField("Shortcut Dimension 2 Code");


                        if Confirm(MSGConfirmation, true, Rec."Start Date", Rec."End Date") then begin
                            InterestBuffer2.Reset;
                            InterestBuffer2.SetRange(InterestBuffer2.No, Rec."No.");
                            if InterestBuffer2.Find('-') then
                                if Rec.Posted = false then
                                    InterestBuffer2.DeleteAll else
                                    Error(ErrPosted);

                            Evaluate(FromDateS, Format(Rec."Start Date"));
                            Evaluate(ToDateS, Format(Rec."End Date"));
                            DateFilter := FromDateS + '..' + ToDateS;

                            SavingsAccounts.Reset;
                            SavingsAccounts.SetFilter(SavingsAccounts."Date Filter", DateFilter);
                            if SavingsAccounts.Find('-') then begin
                                repeat
                                    SavingsAccounts.CalcFields(SavingsAccounts.Balance);
                                    if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                                        ProductFactoryCode := ProductFactory."Product ID";
                                        InterestRate := ProductFactory."Interest Rate (Min.)";
                                        PayableAccount := ProductFactory."Interest Payable Account";
                                        ExpenseAccount := ProductFactory."Interest Expense Account";
                                    end;

                                    InterestBuffer.Init;
                                    InterestBuffer.No := Rec."No.";
                                    InterestBuffer."Account No" := SavingsAccounts."No.";
                                    InterestBuffer.Name := SavingsAccounts.Name;
                                    InterestBuffer."Account Type" := InterestBuffer."Account Type"::Savings;
                                    InterestBuffer."Bal. Account Type" := InterestBuffer."Bal. Account Type"::"G/L Account";
                                    InterestBuffer."Payable Account" := PayableAccount;
                                    InterestBuffer."Expense Account" := ExpenseAccount;
                                    InterestBuffer."Account Balance" := SavingsAccounts.Balance;
                                    InterestBuffer.Blocked := SavingsAccounts.Blocked;
                                    InterestBuffer.Description := Rec.Description;
                                    InterestBuffer."Interest Date" := CalcDate('<CM>', Rec."Start Date");
                                    InterestBuffer."Interest Rate" := InterestRate;
                                    if (SavingsAccounts.Balance * InterestRate / 100) < 0 then
                                        InterestBuffer."Interest Amount" := 0 else
                                        InterestBuffer."Interest Amount" := SavingsAccounts.Balance * InterestRate / 100;
                                    InterestBuffer."Product Factory Code" := ProductFactoryCode;
                                    if Members.Get(SavingsAccounts."Member No.") then begin
                                        InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";//SavingsAccounts."Global Dimension 1 Code";
                                        InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";//SavingsAccounts."Global Dimension 2 Code";
                                    end;
                                    InterestBuffer."User ID" := UserId;
                                    if InterestBuffer."Interest Amount" <> 0 then
                                        InterestBuffer.Insert(true);

                                until SavingsAccounts.Next = 0;
                            end;
                        end;
                        Message(MSGEntriesGenerated);
                    end;
                }
                action("Post Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF Status<>Status::Approved THEN
                        //  ERROR(ErrNotApproved);
                        if Rec.Posted = true then
                            Error(ErrPosted);
                        Rec.CalcFields("Distributed Amount");
                        if Rec."Distributed Amount" = 0 then
                            Error(ErrNoEntries);
                        if BankingUserTemplate.Get(UserId) then begin
                            JTemp := BankingUserTemplate."Interest Account Template";
                            JBatch := BankingUserTemplate."Interest Account Batch";
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", JTemp);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        if GenJournalLine.Find('-') then
                            GenJournalLine.DeleteAll;

                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer.No, Rec."No.");
                        if InterestBuffer.Find('-') then begin
                            repeat
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := JTemp;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                GenJournalLine."Account No." := InterestBuffer."Expense Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := Rec."Document No.";
                                GenJournalLine."Posting Date" := Rec."Posting Date";
                                GenJournalLine.Description := Rec.Description;
                                GenJournalLine.Amount := InterestBuffer."Interest Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := InterestBuffer."Payable Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until InterestBuffer.Next = 0;
                        end;

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", JTemp);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        if GenJournalLine.Find('-') then begin
                            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
                        end;
                        Message('Posted Successfully');
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting Date" := Today;
                        Rec.Modify;
                    end;
                }
                separator(Action28)
                {
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
                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Posting Date");
                        Rec.TestField("Document No.");
                        Rec.TestField(Description);
                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        // CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;

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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        InterestBuffer: Record "Savings Interest Buffer";
        InterestBuffer2: Record "Savings Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        MSGEntriesGenerated: Label 'Entries Generated Successfully';
        MSGConfirmation: Label 'Confirm interest Generation for period starting %1 and Ending %2';
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: Label 'This document has already been posted';
        PageEditable: Boolean;
        Members: Record Members;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Posted = true then begin
            PageEditable := false;
        end;
    end;
}

