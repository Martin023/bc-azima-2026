page 52186657 "Mobile Banking Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    SourceTable = "Mobile Banking Table";


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field("Capture Date"; Rec."Capture Date")
                {

                }
                field("RePIN Processed"; Rec."RePIN Processed")
                {
                    Editable = false;
                }
                field("RePIN Requested"; Rec."RePIN Requested")
                {
                    Editable = false;

                }
            }
            group(Communication)
            {
                Editable = false;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("ATM Parameters")
            // {
            //     Editable = PageEditable;
            //     field("Application Date"; Rec."Application Date")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Card No"; Rec."Card No")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Date Issued"; Rec."Date Issued")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Card Expiry Date"; Rec."Card Expiry Date")
            //     {
            //         Editable = false;
            //     }
            // }
            // group("ATM Linking")
            // {
            //     Editable = false;
            //     field("Card Issued"; Rec."Card Issued")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Linked Date"; Rec."Linked Date")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("ATM Linked"; Rec."ATM Linked")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Card Status"; Rec."Card Status")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Date Activated"; Rec."Date Activated")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Date Frozen"; Rec."Date Frozen")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Replacement For Card No"; Rec."Replacement For Card No")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field(Collected; Rec.Collected)
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Card Issued By"; Rec."Card Issued By")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Approval Date"; Rec."Approval Date")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Date Collected"; Rec."Date Collected")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Delinked By"; Rec."Delinked By")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("ATM Delinked"; Rec."ATM Delinked")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("ATM Delinked Date"; Rec."ATM Delinked Date")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("ATM Linking Statistics"; Rec."ATM Linking Statistics")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
            group("PIN Details")
            {
                Editable = false;
                Visible = false;
                field("RePIN Issued"; Rec."RePIN Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("RePIN Issued Date"; Rec."RePIN Issued Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("RePIN Issued By"; Rec."RePIN Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action("Request RePin")
                {
                    Caption = 'Request RePin';
                    ApplicationArea = Basic, Suite;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    Enabled = rec."RePIN Requested" = false;

                    trigger OnAction()
                    begin

                        rec."RePIN Requested" := true;

                        Message('RePIN Requested Successfully.');
                    end;
                }
                action("Process RePin")
                {
                    Caption = 'Process RePin';
                    ApplicationArea = Basic, Suite;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    Enabled = (rec."RePIN Requested");

                    trigger OnAction()
                    var
                        BankingSetup: Record "Banking User Template";
                    begin
                        if Rec."RePIN Requested" = true then begin

                            ChargeRepin(Rec);

                            rec."RePIN Processed" := true;
                            Rec.Modify();

                            Message('RePIN Processed Successfully.');
                        end;
                    end;
                }
                action("Issue Pin")
                {
                    Caption = 'Issue RePin';
                    ApplicationArea = Basic, Suite;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    Enabled = (rec."RePIN Requested") and (rec."RePIN Processed");

                    trigger OnAction()
                    begin
                        rec.TestField("RePIN Issued", false);
                        rec.TestField("RePIN Processed", true);
                        // rec.TestField("Card No");
                        // rec.TestField("Card Expiry Date");
                        if Confirm(ConfirmPinIssue) then begin

                            // if rec."Card Issued By" = UserId then
                            //     Error(ErrorIssue) else begin
                            rec."RePIN Issued" := true;
                            rec."RePIN Issued By" := UserId;
                            rec."RePIN Issued Date" := Today;
                            // end;
                        end;
                        Message(MSGPINIssued);
                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PageEditable := true;
        // if rec.Status <> rec.Status::Open then
        //     PageEditable := false;
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        // if rec.Status <> rec.Status::Open then
        //     Error(errorTxt, rec.Status);
    end;

    trigger OnOpenPage()
    begin
        PageEditable := true;
        // if rec.Status <> rec.Status::Open then
        //     PageEditable := false;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
        SaccoTransactions: Codeunit "Sacco Transactions";
        PageEditable: Boolean;
        MyDialog: Dialog;
        MyComment: Text;
        EnterComment: Label 'Enter Comment';
        SMSText: Label 'Your ATM Card is ready for collection. Kindly come to Our offices with original copy of your National ID Card.';
        errorTxt: Label 'You cannot modify this document with status %1  ';
        ConfirmPinIssue: Label 'Are you sure you want to issue this repin?';
        ErrorIssue: Label 'You cannot Issue Pin since you Issued Card';
        MSGPINIssued: Label 'RePIN Successfully Issued.';

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
    end;

    local procedure ChargeRepin(MobileBanking: Record "Mobile Banking Table")
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
        GenJnlLine: Record "Gen. Journal Line";
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
        if SavAcc.get(Rec."Account No") then begin
            TransactionTypes.Reset;
            TransactionTypes.SetRange(Code, GenSetup."Mobile Banking PIN Reset");
            if TransactionTypes.Find('-') then begin
                TransactionCharges.Reset;
                TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                if TransactionCharges.Find('-') then begin
                    TransactionCharges.TestField("G/L Account");

                    SavAcc.CalcFields("Balance (LCY)");
                    SavBal := SavAcc."Balance (LCY)";
                    if SavBal >= TransactionCharges."Charge Amount" then begin
                        PDate := Today;
                        DocNo := rec."No.";
                        DActivity2 := rec."Shortcut Dimension 1 Code";
                        DBranch2 := rec."Shortcut Dimension 2 Code";

                        LineNo := LineNo + 10000;
                        AccType := Acctype::"G/L Account";
                        AccNo := TransactionCharges."G/L Account";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := TransactionCharges."Charge Amount";
                        Amt := Amt * -1;
                        JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description, Amt, AccNo, PDate, BalAccType,
                      BalAccNo, '', DActivity2, DBranch2, TransType, Rec."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := SavAcc."No.";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := TransactionCharges."Charge Amount";

                        JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description, Amt, AccNo, PDate, BalAccType,
                      BalAccNo, '', DActivity2, DBranch2, TransType, Rec."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

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
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + '-Excise Duty'), 1, 50), Amt * -1, AccNo, PDate, BalAccType,
                            BalAccNo, '', DActivity2, DBranch2, TransType, Rec."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

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
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                            BalAccNo, '', DActivity2, DBranch2, TransType, Rec."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        end;

                    end;
                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                end else
                    Error('There is no enough balance to charge activation fee.');

            end;
        end;


    end;
}

