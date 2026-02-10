page 52185881 "ATM Linking Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    SourceTable = "ATM Linking Applications";


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
                field("ATM Application No."; Rec."ATM Application No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    Caption = 'ATM Card No';

                }
                field("Form No"; Rec."Form No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                field("Sales Agent"; Rec."Sales Agent")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
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
            group("ATM Parameters")
            {
                Editable = PageEditable;
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Terms Read and Understood"; Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    Editable = false;

                }
            }
            group("ATM Linking")
            {
                Editable = false;
                field("Card Issued"; Rec."Card Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Linked Date"; Rec."Linked Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Linked"; Rec."ATM Linked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Status"; Rec."Card Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Activated"; Rec."Date Activated")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Frozen"; Rec."Date Frozen")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Replacement For Card No"; Rec."Replacement For Card No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Issued By"; Rec."Card Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Collected"; Rec."Date Collected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delinked By"; Rec."Delinked By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Delinked"; Rec."ATM Delinked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Delinked Date"; Rec."ATM Delinked Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Linking Statistics"; Rec."ATM Linking Statistics")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("PIN Details")
            {
                Editable = false;
                field("PIN Issued"; Rec."PIN Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN Issued Date"; Rec."PIN Issued Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN Issued By"; Rec."PIN Issued By")
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
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RecordId);
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
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        rec.TestField("Account No");
                        // rec.TestField("ATM Application No.");
                        rec.TestField("Card No");

                        if rec."Card Expiry Date" = 0D then begin
                            if not Confirm('Card Expiry Date is not set. Do you want to continue?', true) then
                                rec.TestField("Card Expiry Date");
                        end;

                        rec.TestField("Account No");
                        // rec.TestField("Form No");
                        //rec.TestField("Card Type");
                        // rec.TestField("Customer ID");
                        // rec.TestField("Terms Read and Understood");
                        VarVariant := Rec;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }

                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this document?';
                        Text001: Label 'You have Selected not to cancle this document';
                    begin
                        rec.TESTFIELD(Status, rec.Status::"Pending Approval");
                        if Confirm(Text000, true) then begin
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen Document';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you wish to reopen this document?';
                        Approvalsmgt: Codeunit 1535;
                    begin
                        if rec."ATM Linked" or rec."ATM Delinked" then
                            Error('You cannot reopen this document as it has already been linked or delinked');
                        if Confirm(Text000, true) then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                            Approvalsmgt.DeleteApprovalEntries(Rec.RecordId);
                        end else
                            Message('You have selected not to reopen this document');
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // approvalsMgmt: Codeunit 1535;
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group(Action62)
            {
                Caption = 'ATM Parameters';
                action("Collect ATM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Confirm Card Collection';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        SaccoTransactions.CollectATM(Rec);
                    end;
                }
                action("Link ATM")
                {
                    Caption = 'Link ATM Card';
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                    // [RunOnClient]
                    // Window: DotNet Interaction;
                    begin
                        SaccoTransactions.LinkATM(Rec);
                    end;
                }
                action("Issue Pin")
                {
                    ApplicationArea = Basic, Suite;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.TestField("PIN Issued", false);
                        rec.TestField("Card Issued", true);
                        rec.TestField("Card No");
                        rec.TestField("Card Expiry Date");
                        if Confirm(ConfirmPinIssue) then begin

                            if rec."Card Issued By" = UserId then
                                Error(ErrorIssue) else begin
                                rec."PIN Issued" := true;
                                rec."PIN Issued By" := UserId;
                                rec."PIN Issued Date" := Today;
                            end;
                        end;
                        Message(MSGPINIssued);
                    end;
                }
                action("Delink ATM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'DeLink ATM Card';
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                    // [RunOnClient]
                    // Window: DotNet Interaction;
                    begin
                        // MyComment:=Window.InputBox('Enter reason for changing delinking','account:'+Rec."Account No",'',100,100);
                        //MESSAGE(MyComment);
                        SaccoTransactions.DeLinkATM(Rec);
                    end;
                }
            }
            group("Requests for approval")
            {
                Caption = 'Requests for approval';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PageEditable := true;
        if rec.Status <> rec.Status::Open then
            PageEditable := false;
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if rec.Status <> rec.Status::Open then
            Error(errorTxt, rec.Status);
    end;

    trigger OnOpenPage()
    begin
        PageEditable := true;
        if rec.Status <> rec.Status::Open then
            PageEditable := false;
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
        ConfirmPinIssue: Label 'Are you sure you want to issue this pin?';
        ErrorIssue: Label 'You cannot Issue Pin since you Issued Card';
        MSGPINIssued: Label 'PIN Successfully Issued.';

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
    end;
}

