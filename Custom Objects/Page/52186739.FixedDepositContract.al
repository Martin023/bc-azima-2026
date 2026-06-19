page 52186739 "Fixed Deposit Contract"
{
    Caption = 'Fixed/Call Deposit Card';
    Editable = true;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Fixed Deposit Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(Comment; Rec.Comment)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Account No."; Rec."Fixed Deposit Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Fosa Account No"; Rec."FOSA Main Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field("Fosa Balance"; Rec."Fosa Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;

                }
                field("Fixed Deposit Amount"; Rec."Fixed Deposit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }

                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("FD Maturity Instructions"; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Forecasted Interest"; Rec."Forecasted Interest")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = HeaderA;
                }
                field("FD Date Renewed"; Rec."FD Date Renewed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Interest rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Fixed Deposit cert. no"; Rec."Fixed Deposit cert. no")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                // field("Untranfered Interest"; Rec."Untranfered Interest")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }



    actions
    {
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action(FixedDepositContract)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed/Call Deposit Certificate';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                        FixedDepositContract: Record "Fixed Deposit Contract";
                    begin
                        FixedDepositContract.Reset;
                        FixedDepositContract.SetFilter("No.", Rec."No.");
                        if FixedDepositContract.findFirst() then
                            Report.Run(Report::"Fixed Deposit Certificate", true, true, FixedDepositContract);
                    end;
                }
                action(FixedDepositReceipt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed/Call Deposit Receipt';
                    // Enabled = OpenApprovalEntriesExist;
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        rec.Reset;
                        rec.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Fixed Deposit Receipt", true, true, Rec);
                    end;
                }
                action(ProcessFixed)
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Fixed Deposit';
                    // Enabled = OpenApprovalEntriesExist;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    visible = TerminateVisible;
                    trigger OnAction()
                    var
                        "Fixed Deposit Contract": Record "Fixed Deposit Contract";
                    begin

                        Rec.TestField("FOSA Main Account No.");
                        Rec.CalcFields(Balance);
                        rec.TestField("FD Duration");

                        // "Fixed Deposit Contract".Reset();
                        // "Fixed Deposit Contract".SetRange("No.", Rec."No.");
                        // if "Fixed Deposit Contract".FindFirst() then
                        //     Report.Run(Report::"Process Fixed Deposit", true, false, "Fixed Deposit Contract");
                        if Rec.Balance <= 0 then Error('Fixed Deposit Contract must have a a balance of greater 0, current balance is %1.', Rec.Balance);
                        if Rec."FD Maturity Date" > Today then Error('This Fixed deposit maturity is %1. For payment, proceed to terminate.', Rec."FD Maturity Date");
                        // RunDate := Rec."FD Maturity Date";
                        // if RunDate = 0D then begin
                        //     if Rec."Application Date" = 0D then Rec."Application Date" := today;
                        //     if Format(Rec."FD Duration") <> '' then
                        //         RunDate := CalcDate(Rec."FD Duration", Rec."Application Date") else
                        //         RunDate := CalcDate('1D', Rec."Application Date")
                        // end;
                        //IF RunDate = 0D THEN
                        RunDate := TODAY;

                        if "Fixed Deposit Contract".get(rec."No.") then begin
                            if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal & Interest" then
                                FDManagement.RollOver("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                            else
                                if ("Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal") or ("Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::" ") then
                                    FDManagement.Renew("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                                else
                                    if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Transfer all to Savings" then
                                        FDManagement.CloseNonRenewable("Fixed Deposit Contract", RunDate, JTemplate, JBatch);

                        end;
                    end;
                }
                action(TransferFunds)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transfer Funds';
                    Image = TerminationDescription;
                    Promoted = true;
                    PromotedCategory = Process;

                    Visible = true;


                }
                action(Terminate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Terminate';
                    // Enabled = OpenApprovalEntriesExist;
                    Image = TerminationDescription;
                    Visible = TerminateVisible;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        FixedSetup: Record "Fixed Deposit Type";
                        JournalPosting: Codeunit "Journal Posting";
                        AccType: Enum "Gen. Journal Account Type";
                        BalAccType: Enum "Gen. Journal Account Type";
                        AccNo: Code[20];
                        BalAccNo: Code[20];
                        Amt: Decimal;
                        LineNo: Integer;
                        TransType: Enum "Transaction Types";
                        DocNo: Code[20];
                        PDate: Date;
                        Dim1: Code[20];
                        Dim2: Code[20];
                        GlEntry: Record "G/L Entry";
                    begin

                        if Rec."Fixed Deposit Status" = Rec."Fixed Deposit Status"::Closed then
                            Error('The Fixed/Call Deposit is Closed, it has already been processed!');

                        if Rec."Fixed Deposit Status" = Rec."Fixed Deposit Status"::Terminated then
                            Error('The Fixed/Call Deposit is Terminated, it has already been processed!');
                        Temp.Get(UserId);
                        Jtemplate := Temp."Fixed/Call Journal Template";
                        JBatch := Temp."Fixed/Call Journal Batch";

                        if Jtemplate = '' then begin
                            Error('Ensure the Fixed/Call Deposit Journal Template is set up in Banking User Setup');
                        end;

                        if JBatch = '' then begin
                            Error('Ensure the Fixed/Call Deposit Journal Batch is set up in Banking User Setup');
                        end;

                        GlEntry.Reset();
                        GlEntry.SetRange("Document No.", rec."No.");
                        GlEntry.SetRange(Description, 'FD Termination-' + rec."No.");
                        if GlEntry.FindFirst() then begin
                            rec."Fixed Deposit Status" := rec."Fixed Deposit Status"::Terminated;
                            Rec.Modify();
                            Message('Terminated Successfully!');
                            exit;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        GenJournalLine.DeleteAll;
                        Rec.TestField("FD Maturity Date");

                        FixedSetup.Reset();
                        FixedSetup.SetRange(FixedSetup.Code, Rec."Fixed Deposit Type");
                        if FixedSetup.Find('-') then begin
                            Rec.CalcFields(Balance);
                            // if FixedSetup."Call Deposit" = false then begin
                            if Rec."FD Maturity Date" > Today then begin

                                //Debit FD Account
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Document No." := rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Rec."Fixed Deposit Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Termination-' + rec."No.";
                                //GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                GenJournalLine.Amount := Rec.Balance;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := '';
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Fixed Deposit Contract" := Rec."No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := rec."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Credit Fosa Main
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Document No." := rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Rec."FOSA Main Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Credit Ordinary Acc- ' + rec."No." + ' FD terminantion.';
                                GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                GenJournalLine.Amount := (Rec.Balance) * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := '';
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Fixed Deposit Contract" := rec."No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := rec."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                end;
                                // Amt := Rec."Fixed Deposit Amount";
                                // Dim1 := rec."Global Dimension 1 Code";
                                // Dim2 := rec."Global Dimension 2 Code";
                                // //Debit FD Account
                                // LineNo := LineNo + 10000;
                                // AccType := Acctype::Savings;
                                // AccNo := Rec."Fixed Deposit Account No.";
                                // DocNo := Rec."No.";
                                // PDate := Today;
                                // TransType := Transtype::" ";
                                // BalAccType := Balacctype::"G/L Account";
                                // BalAccNo := '';
                                // Amt := Amt;
                                // JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, DocNo, 'Termination', Amt, AccNo, PDate, BalAccType,
                                // BalAccNo, DocNo, Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                // //Credit Fosa Main
                                // LineNo := LineNo + 10000;
                                // AccType := Acctype::Savings;
                                // AccNo := rec."FOSA Main Account No.";
                                // TransType := Transtype::" ";
                                // BalAccType := Balacctype::"G/L Account";
                                // BalAccNo := '';
                                // Amt := Amt;
                                // JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, DocNo, 'Termination', Amt * -1, AccNo, PDate, BalAccType,
                                // BalAccNo, DocNo, Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                // JournalPosting.CompletePosting(Jtemplate, JBatch);


                                rec."Fixed Deposit Status" := rec."Fixed Deposit Status"::Terminated;
                                Rec.Modify();
                                Message('Terminated Successfully!');
                            end else
                                Error('This is a matured contract. Proceed to process, Maturity date is %1. ', Rec."FD Maturity Date");
                            // end;
                        end;
                    end;
                }

            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    // Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        rec.TestField("Interest Rate");
                        if rec."FD Maturity Instructions" = rec."FD Maturity Instructions"::" " then Error('Maturity instructions must be indicated before performing the action!');
                        if rec."FD Maturity Date" = 0D then Error('Maturity date must be indicated before performing the action!');

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // Rec.Status := Rec.Status::Approved;
                        // Rec.Modify;
                        // Message('Fixed Deposit Approved');

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    // Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";

                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re Open';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = OpenWorksheet;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        if not confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        rec."Fixed Deposit Status" := rec."Fixed Deposit Status"::" ";
                        ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
                        rec.modify;
                        Message('The document have been opened successfully.');
                    end;
                }
                action(ApprovalEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    PromotedCategory = Category4;
                    promoted = true;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OtherFixed.Reset();
        OtherFixed.SetRange(Status, OtherFixed.Status::open);
        OtherFIxed.SetRange("No.", '<>%1', rec."No.");
        if OtherFixed.count > 2 then Error('Please use the open cards instead of opening an new entry.');
    end;

    trigger OnOpenPage()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        AControl;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        AControl;
        SetControlAppearance;
    end;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        TerminateVisible := true;

        if Rec."Fixed Deposit Status" = Rec."Fixed Deposit Status"::Active then
            TerminateVisible := true else
            TerminateVisible := false;

    end;

    var

        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";

        Members: Record Members;

        FDManagement: Codeunit "Sacco Transactions";
        RunDate: Date;
        GenJournalLine: Record "Gen. Journal Line";
        FDDays: Integer;
        DefaultBatch: Record "Gen. Journal Batch";
        JTemplate: Code[10];
        JBatch: Code[10];
        // Members: Record "Members";
        SendSMS: Codeunit SendSms;
        Loans: Record Loans;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        SendMessage: Boolean;
        Temp: Record "Banking User Template";
        Source: Enum "SMS Source";
        msg: Text;
        HeaderA: Boolean;
        SourceA: Boolean;
        DestinationA: Boolean;
        TerminateVisible: Boolean;
        OtherFixed: record "Fixed Deposit Contract";


    procedure AControl()
    begin
        case rec.Status of
            rec.Status::Open:
                begin
                    SourceA := true;
                    DestinationA := true;
                    HeaderA := true;
                end;

            rec.Status::Pending, rec.Status::Approved, rec.Status::Rejected:
                begin
                    SourceA := false;
                    DestinationA := false;
                    HeaderA := false;
                end;
        end;

        // if (rec.Status = rec.Status::Approved) and (rec.Posted = false) then
        //     RejectApproved := true
        // else
        //     RejectApproved := false;
    end;

}

