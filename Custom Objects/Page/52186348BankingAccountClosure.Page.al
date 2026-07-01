page 52186348 "Banking Account Closure"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Banking Account Closure";
    PromotedActionCategories = 'New,Process,Approvals,Workflow';

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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
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
                field("Reason For Account Closure"; Rec."Reason For Account Closure")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Date"; Rec."Closure Date")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Closed; Rec.Closed)
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
                        Rec.TestField("Closure Date");
                        Rec.TestField("Reason For Account Closure");
                        Rec.TestField("Account No");
                        Rec.TestField("Member No");

                        if Rec."Closure Date" <> Today then Error('Closure Date must be today');

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
                        Rec.TestField(Closed, false);
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
                action("Post Closure")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    //PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RunPeriodicTrans: Codeunit "Sacco Transactions";
                        SinkFund: Record "SinkFund Report Information";
                        GenJnlLine: Record "Gen. Journal Line";
                        DefaultBatch: Record "Gen. Journal Batch";
                        CashierLinks: Record "Cash Office User Template";
                        LineNo: Integer;
                        Temp: Record "Cash Office User Template";
                        JTemplate: Code[10];
                        JBatch: Code[10];
                        Post: Boolean;
                        strText: Text[100];
                        CashOfficeSetup: Record "Cash Office Setup";
                        BankLed: Record "Cust. Ledger Entry";
                    begin
                        Rec.TestField(Closed, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        CloseAccount(Rec);

                        rec.Closed := true;
                        rec.Modify();
                        Message('Account Closed Successfully.');
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;

    end;

    trigger OnOpenPage()
    begin
        if (Rec.Status <> Rec.Status::Open) then CurrPage.Editable := false;
        if Rec.Closed = true then CurrPage.Editable := false;

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

    //[Scope('OnPrem')]

    // local procedure CloseAccount(AccClose: Record "Banking Account Closure")
    // var
    //     SavAcc: Record "Savings Accounts";
    //     TransactionCharges: Record "Transaction Charges";
    //     TransactionTypes: Record "Transaction Types";
    //     AccType: Enum "Gen. Journal Account Type";
    //     AccNo: Code[20];
    //     TransType: Enum "Transaction Types";
    //     BalAccType: Enum "Gen. Journal Account Type";
    //     BalAccNo: Code[20];
    //     Amt: Decimal;
    //     JournalPosting: Codeunit "Journal Posting";
    //     GenSetup: Record "General Set-Up";
    //     DocNo: Code[20];
    //     PDate: Date;
    //     DActivity2: Code[20];
    //     DBranch2: Code[20];
    //     Jtemplate: Code[20];
    //     Jbatch: Code[20];
    //     RunBal: Decimal;
    //     MemberNo: Code[20];
    //     LineNo: Integer;
    //     Salaccno: Code[20];
    //     Temp: Record "Banking User Template";
    //     SavBal: Decimal;
    // begin
    //     //Auto Activate Dormant On Loan Posting
    //     GenSetup.Get;
    //     Temp.Get(UserId);
    //     //with SalHeaD do


    //     Jtemplate := Temp."Cashier Journal Template";
    //     JBatch := Temp."Cashier Journal Batch";
    //     if Jtemplate = '' then
    //         Error('Cashier Template must have a value.');
    //     if Jbatch = '' then
    //         Error('Cashier Batch must have a value.');

    //     Rec.TestField("Account No");
    //     GenJnlLine.Reset;
    //     GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
    //     GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
    //     GenJnlLine.DeleteAll;

    //     // SavAcc.Reset;
    //     // SavAcc.get(rec."Account No");
    //     // SavAcc.TestField(Status, SavAcc.Status::Dormant);
    //     Gensetup.TestField("Closure Account Fee");
    //     TransactionTypes.Reset;
    //     TransactionTypes.SetRange(Code, GenSetup."Closure Account Fee");
    //     if TransactionTypes.Find('-') then begin
    //         TransactionCharges.Reset;
    //         TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
    //         if TransactionCharges.Find('-') then begin
    //             TransactionCharges.TestField("G/L Account");
    //             if SavAcc.get(Rec."Account No") then begin
    //                 // SavAcc.TestField(Status, SavAcc.Status::Dormant);
    //                 SavAcc.CalcFields("Balance (LCY)");
    //                 SavBal := SavAcc."Balance (LCY)";
    //                 if SavBal >= TransactionCharges."Charge Amount" then begin
    //                     PDate := rec."Closure Date";
    //                     DocNo := rec.No;
    //                     DActivity2 := rec."Global Dimension 1 Code";
    //                     DBranch2 := rec."Global Dimension 2 Code";

    //                     LineNo := LineNo + 10000;
    //                     AccType := Acctype::"G/L Account";
    //                     AccNo := TransactionCharges."G/L Account";
    //                     TransType := Transtype::" ";
    //                     BalAccType := Balacctype::"G/L Account";
    //                     BalAccNo := '';
    //                     Amt := TransactionCharges."Charge Amount";
    //                     Amt := Amt * -1;
    //                     JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
    //                   BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

    //                     LineNo := LineNo + 10000;
    //                     AccType := Acctype::Savings;
    //                     AccNo := SavAcc."No.";
    //                     TransType := Transtype::" ";
    //                     BalAccType := Balacctype::"G/L Account";
    //                     BalAccNo := '';
    //                     Amt := TransactionCharges."Charge Amount";

    //                     JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
    //                   BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

    //                     if TransactionCharges."Recover Excise Duty" = true then begin
    //                         GenSetup.TestField("Excise Duty G/L");
    //                         GenSetup.TestField("Excise Duty (%)");
    //                         LineNo := LineNo + 10000;
    //                         AccType := Acctype::"G/L Account";
    //                         Amt := TransactionCharges."Charge Amount";
    //                         AccNo := GenSetup."Excise Duty G/L";
    //                         TransType := Transtype::" ";
    //                         BalAccType := Balacctype::"G/L Account";
    //                         BalAccNo := '';
    //                         Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
    //                         JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt * -1, AccNo, PDate, BalAccType,
    //                         BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

    //                         LineNo := LineNo + 10000;
    //                         GenSetup.TestField("Excise Duty G/L");
    //                         GenSetup.TestField("Excise Duty (%)");
    //                         Amt := TransactionCharges."Charge Amount";
    //                         AccType := Acctype::Savings;
    //                         AccNo := SavAcc."No.";
    //                         TransType := Transtype::" ";
    //                         BalAccType := Balacctype::Savings;
    //                         BalAccNo := '';
    //                         Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
    //                         JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
    //                         BalAccNo, '', DActivity2, DBranch2, TransType, Rec.No, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

    //                     end;
    //                     SavAcc.Status := SavAcc.Status::Closed;
    //                     SavAcc."Status Change Reason" := 'Account Closure';
    //                     SavAcc.Modify;
    //                 end;
    //                 JournalPosting.CompletePosting(Jtemplate, JBatch);
    //                 // if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
    //                 //     SavAcc.Blocked := SavAcc.Blocked::" ";

    //                 // end;
    //             end else
    //                 Error('There is no enough balance to charge closure fee.');

    //         end;

    //     end else error('There is no transaction type set up for closure fee. ');

    // end;

    local procedure CloseAccount(AccClose: Record "Banking Account Closure")
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
        GlobalFunc : Codeunit "Global Functions";
        FosaAccountNo : Code[100];
        FosaBal : decimal;
        TotalCharges : decimal;
    begin
        //Auto Activate Dormant On Loan Posting
        GenSetup.Get;
        Temp.Get(UserId);
        //with SalHeaD do


        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";
        if Jtemplate = '' then
            Error('Cashier Template must have a value.');
        if Jbatch = '' then
            Error('Cashier Batch must have a value.');

        Rec.TestField("Account No");
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;

        // SavAcc.Reset;
        // SavAcc.get(rec."Account No");
        // SavAcc.TestField(Status, SavAcc.Status::Dormant);
        Rec.TestField("Transaction Type");
        //Gensetup.TestField("Closure Account Fee");
        TransactionTypes.Reset;
        TransactionTypes.SetRange(Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            TransactionCharges.Reset;
            TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
            if TransactionCharges.Find('-') then begin
                TransactionCharges.TestField("G/L Account");
                if SavAcc.get(Rec."Account No") then begin
                    // SavAcc.TestField(Status, SavAcc.Status::Dormant);
                    Clear(fosaAccountNo);
                    clear(fosaBal);
                    clear(totalCharges);
                    fosaAccountNo := GlobalFunc.GetFOSAAccount(SavAcc."Member No.");
                    totalCharges := GlobalFunc.getChargesAmt(TransactionTypes.Code,0);
                    FosaBal := SavAcc.GetAvailableBalance(fosaAccountNo);
                    SavAcc.CalcFields("Balance (LCY)");
                    SavBal := SavAcc."Balance (LCY)";
                    if FosaBal >= totalCharges then begin
                        PDate := rec."Closure Date";
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
                        SavAcc.Status := SavAcc.Status::Closed;
                        SavAcc."Status Change Reason" := 'Account Closure';
                        SavAcc.Modify;
                        JournalPosting.CompletePosting(Jtemplate, JBatch);
                    end else
                        Error('There is no enough balance to charge closure fee.');
                    // if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                    //     SavAcc.Blocked := SavAcc.Blocked::" ";

                    // end;
                end else
                    Error('Savings account %1 does not exist.', Rec."Account No");

            end else
                Error('There is no transaction charge set up for the closure fee transaction type.');

        end else Error('There is no transaction type set up for closure fee.');

    end;

    procedure PostAccountClosure(Rec: Record "Banking Account Closure")
    var
        BankLed: Record "Savings Ledger Entry";
    begin
        BankLed.Reset;
        BankLed.SetRange("Document No.", Rec.No);
        BankLed.SetRange(BankLed."Posting Date", Rec."Closure Date");
        if BankLed.Find('-') then begin
            Rec.Closed := true;
            Rec.Modify;
            Message('Account Closed succesfully');
            exit;
        end;
        Temp.Get(UserId);

        JTemplate := Temp."Receipt Journal Template";
        JBatch := Temp."Receipt Journal Batch";

        if JTemplate = '' then begin
            Error('Ensure the Loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in Banking User Setup')
        end;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;
        CashOfficeSetup.Get();


        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Closure Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := Rec.No;
        GenJnlLine."External Document No." := Rec.No + '-' + Rec."Member No";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
        GenJnlLine."Account No." := Rec."Account No";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := CopyStr('FOSA Account Closure: ' + Rec."Account No", 1, 50);
        //CALCFIELDS("Total Net Amount");
        GenJnlLine.Amount := Rec."Account Balance";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := Rec.No;
        GenJnlLine."External Document No." := Rec.No + '-' + Rec."Member No";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := CashOfficeSetup."Sundry Income for Account  Clo";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := CopyStr('FOSA Account Closure: ' + Rec."Account No", 1, 50);
        ;
        //CALCFIELDS("Total Net Amount");
        GenJnlLine.Amount := (Rec."Account Balance" * -1);
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';//CashOfficeSetup."Insurance Claim Received";
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        Post := false;
        Post := JournlPosted.PostedSuccessfully();
        if (Post) or (GenJnlLine.Amount = 0) then begin
            Rec.Closed := true;
            Rec."Closed By" := UserId;
            Rec."Date Closed" := Today;
            Rec.Modify;
            if Members.Get(Rec."Member No") then begin

                CompanyInformation.Get();

                SendSMS.SendSms(Source::ACCOUNT_STATUS, Members."Phone No.", msg, Format(Rec."Account No"), '', true, 0, false, 'CBS', Rec."Account No", 'CBS');

            end;
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("No.", Rec."Account No");
            if SavingsAccounts.Find('-') then begin
                SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                SavingsAccounts."Status Change Reason" := 'Account Closed on ' + Format(Today) + ' - Document No' + Rec.No;
                SavingsAccounts.Modify;
            end;
        end;
    end;

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

