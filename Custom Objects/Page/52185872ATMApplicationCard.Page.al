page 52185872 "ATM Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ATM Applications";
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    SourceTableView = WHERE(Status = FILTER(<> Approved));

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
                field("Auto Applied"; Rec."Auto Applied")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CardReplacement;
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }

                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sales Agent Type"; Rec."Sales Agent Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sales Agent"; Rec."Sales Agent")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Capture Date"; Rec."Capture Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Collection Point';

                }
            }
            group(Communication)
            {
                Editable = PageEditable;
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
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Terms Read and Understood"; Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Replacement For Card No"; Rec."Replacement For Card No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ReplaceEditable;
                }
            }
            group("ATM Linking")
            {
                Editable = false;
                Visible = false;
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
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Issued By"; Rec."Card Issued By")
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
                field("Date Collected"; Rec."Date Collected")
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
            group("Pesa Point ATM Card")
            {
                Caption = 'Pesa Point ATM Card';
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        rec.TestField("Account No");
                        rec.TestField("Card Type");
                        rec.TestField("Terms Read and Understood");
                        rec.TestField("Shortcut Dimension 1 Code");
                        rec.TestField("Shortcut Dimension 2 Code");
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        CardReplacement;
        UpdateControls;
    end;

    trigger OnInit()
    begin
        CompanyInformation.Get();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CardReplacement
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //CardReplacement;
    end;

    trigger OnOpenPage()
    begin
        CompanyInformation.Get();
        CardReplacement;
        UpdateControls;
    end;

    var
        CompanyInformation: Record "Company Information";
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
        ReplaceEditable: Boolean;
        PageEditable: Boolean;
        SalesAgentVisible: Boolean;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
    end;

    local procedure CardReplacement()
    begin
        if rec."Request Type" = rec."Request Type"::New then
            ReplaceEditable := false else
            ReplaceEditable := true;
    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if rec.Status <> rec.Status::Open then begin
            PageEditable := false;
        end else
            PageEditable := true;
        CompanyInformation.Get();
        if CompanyInformation."Use Sales Agents" then
            SalesAgentVisible := true else
            SalesAgentVisible := false;
    end;
}

