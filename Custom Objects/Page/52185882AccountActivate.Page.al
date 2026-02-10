page 52186882 "Account Activation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Account Activation";
    PromotedActionCategories = 'New,Process,Approvals,Workflow';
    Caption = 'FOSA Account Activation';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Action; Rec.Action)
                {
                    Editable = ApprovedEdit;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        VBlock := false;

                        if rec.Action = rec.Action::Block then
                            VBlock := true;
                    end;
                }
                group(Block)
                {
                    Caption = '.';
                    Visible = VBlock;
                    field(Blocked; Rec.Blocked)
                    {

                    }
                }
                field("Reason for the Action"; Rec."Reason for the Action")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activation Date"; Rec."Activation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Activated; Rec.Activated)
                {
                    Caption = 'Posted';
                    ApplicationArea = Basic, Suite;
                }
                field("Date Activated"; Rec."Date Activated")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    PromotedCategory = Category4;
                    Promoted = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField("Activation Date");
                        Rec.TestField("Account No");
                        Rec.TestField("Member No");
                        Rec.Testfield("Reason for the Action");

                        if Rec."Activation Date" <> Today then Error('Activation Date must be today');

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // rec.Status := rec.Status::Approved;
                        // rec.Modify();
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
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
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
                    // Promoted = true;
                    // PromotedCategory = Process;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Activated, false);
                        if not Confirm('Are you sure you want to reopen this document?') then
                            exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
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
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
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
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Activate)
                {
                    Caption = 'Post Changes';
                    ApplicationArea = Basic, Suite;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    //PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MemberNo: Code[20];
                        PDate: Date;
                        RunBal: Decimal;
                        DocNo: Code[20];
                        PostingRemarks: Text[50];
                        DActivity2: Code[20];
                        DBranch2: Code[20];
                        // SaccoTrans: Codeunit "Sacco Transactions";
                        Salaccno: Code[20];
                    begin
                        Rec.TestField(Activated, false);
                        Rec.TestField(Status, Rec.Status::Approved);

                        if rec.Action = rec.Action::Activate then begin
                            ActivateDormant(Rec);
                            rec.Activated := true;
                            rec.Status := rec.Status::Activated;
                            rec.Modify();
                            Message('Activated Successfully!!');
                        end;

                        if rec.Action = rec.Action::Block then begin
                            rec.Status := rec.Status::Blocked;
                            rec.Activated := true;
                            rec."Activation Date" := Today;
                            rec."Posted By" := UserId;
                            rec.Modify();

                            SavingsAccounts.get(Rec."Account No");
                            SavingsAccounts.Blocked := rec.Blocked;
                            SavingsAccounts."Status Change Reason" := 'Blocking the Account';
                            SavingsAccounts.Modify;
                        end;

                        if rec.Action = rec.Action::Freeze then begin
                            rec.Status := rec.Status::Frozen;
                            rec.Activated := true;
                            rec."Date Activated" := Today;
                            rec."Posted By" := UserId;
                            rec.Modify();

                            SavingsAccounts.get(Rec."Account No");
                            SavingsAccounts.Status := SavingsAccounts.Status::Frozen;
                            SavingsAccounts."Status Change Reason" := 'Freezing the Account';
                            SavingsAccounts.Modify;
                        end;

                        if rec.Action = rec.Action::Unblock then begin
                            rec.Status := rec.Status::Activated;
                            rec.Activated := true;
                            rec."Date Activated" := Today;
                            rec."Posted By" := UserId;
                            rec.Modify();

                            SavingsAccounts.get(Rec."Account No");
                            SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
                            SavingsAccounts."Status Change Reason" := 'Unblocking the Account';
                            SavingsAccounts.Modify;
                        end;

                    end;
                }

                action("Reset Card")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Restore;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Visible = (Rec.status = filter("Open"));

                    trigger OnAction()
                    var
                        // ApprovalsMgmt: Codeunit 1535;
                        UserSetup: Record "User Setup";
                    begin
                        Rec."User Id" := UserId;
                        Rec."Activation Date" := Today;
                        Rec.Date := Today;
                        if UserSetup.Get(UserId) then begin
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                        end;

                        Rec.Modify();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        VBlock := false;
        if rec.Action = rec.Action::Block then
            VBlock := true;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;

    end;


    trigger OnOpenPage()
    begin
        if (Rec.Status <> Rec.Status::Open) then CurrPage.Editable := false;
        if Rec.Activated = true then CurrPage.Editable := false;

        SetControlAppearance;
    end;

    var
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        JournlPosted: Codeunit "Journal Post Successful";
        CashOfficeSetup: Record "Cash Office Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        Members: Record Members;
        CompanyInformation: Record "Company Information";
        SendSMS: Codeunit SendSms;
        ApplicationDetailsEdit: Boolean;
        ApprovedEdit: Boolean;
        SavingsAccounts: Record "Savings Accounts";
        Source: Enum "SMS Source";
        msg: Text;
        VBlock: Boolean;

    //[Scope('OnPrem')]

    local procedure ActivateDormant(AccActive: Record "Account Activation")
    var
        SavAcc: Record "Savings Accounts";
        TransactionCharges: Record "Transaction Charges";
        TransactionTypes: Record "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        GenSetup: Record "General Set-Up";
        DocNo: Code[20];
        PDate: Date;
        DActivity2: Code[20];
        DBranch2: Code[20];
        Jtemplate: Code[20];
        Jbatch: Code[20];
        RunBal: Decimal;
        MemberNo: Code[20];
        LineNo: Integer;
        Salaccno: Code[20];
        Temp: Record "Banking User Template";
        SavBal: Decimal;
        OtherSavingAccounts: Record "Savings Accounts";
        Excise: Decimal;
    begin
        //Auto Activate Dormant On Loan Posting
        GenSetup.Get;
        Temp.Get(UserId);
        Excise := 0;
        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";
        if Jtemplate = '' then
            Error('Cashier Template must have a value in banking user template.');
        if Jbatch = '' then
            Error('Cashier Batch must have a value in banking user template.');

        Rec.TestField("Account No");
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;

        // SavAcc.Reset;
        // SavAcc.get(rec."Account No");
        // SavAcc.TestField(Status, SavAcc.Status::Dormant);
        if SavAcc.get(Rec."Account No") then begin
            TransactionTypes.Reset;
            TransactionTypes.SetRange(Code, AccActive."Transaction Type");
            if TransactionTypes.Find('-') then begin
                TransactionCharges.Reset;
                TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                if TransactionCharges.Find('-') then begin
                    TransactionCharges.TestField("G/L Account");
                    // SavAcc.TestField(Status, SavAcc.Status::Dormant);
                    SavAcc.CalcFields("Balance (LCY)");
                    SavBal := SavAcc."Balance (LCY)";
                    if TransactionCharges."Recover Excise Duty" then
                        Excise := TransactionCharges."Charge Amount" * GenSetup."Excise Duty (%)" * 0.01;
                    if SavBal >= (TransactionCharges."Charge Amount" + Excise) then begin
                        PDate := Today;
                        DocNo := rec.No;
                        DActivity2 := rec."Global Dimension 1 Code";
                        DBranch2 := rec."Global Dimension 2 Code";

                        LineNo := LineNo + 10000;
                        AccType := Acctype::"G/L Account";
                        AccNo := TransactionCharges."G/L Account";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := TransactionCharges."Charge Amount";
                        Amt := Amt * -1;
                        JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                      BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := SavAcc."No.";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := TransactionCharges."Charge Amount";

                        JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                      BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        if TransactionCharges."Recover Excise Duty" = true then begin
                            GenSetup.TestField("Excise Duty G/L");
                            GenSetup.TestField("Excise Duty (%)");
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            Amt := TransactionCharges."Charge Amount";
                            AccNo := GenSetup."Excise Duty G/L";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt * -1, AccNo, PDate, BalAccType,
                            BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            LineNo := LineNo + 10000;
                            GenSetup.TestField("Excise Duty G/L");
                            GenSetup.TestField("Excise Duty (%)");
                            Amt := TransactionCharges."Charge Amount";
                            AccType := Acctype::Savings;
                            AccNo := SavAcc."No.";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::Savings;
                            BalAccNo := '';
                            Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                            BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        end;

                    end
                    else
                        Error('There is no enough balance to charge activation fee.');
                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                    // if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                    //     SavAcc.Blocked := SavAcc.Blocked::" ";

                    // end;
                end;
                //  else
                //     Error('There is no enough balance to charge activation fee.');
            end;
            SavAcc.Status := SavAcc.Status::Active;
            SavAcc."Status Change Reason" := 'Activation';
            SavAcc.Modify;
        end;


    end;
    //block account if



    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true else
            CurrPage.Editable := false;


        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDetailsEdit := true;
                    ApprovedEdit := true;
                end;

            Rec.Status::Approved:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Pending:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Rejected:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
        end;
    end;
}

