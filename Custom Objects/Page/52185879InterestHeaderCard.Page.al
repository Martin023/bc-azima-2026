page 52185879 "Interest Header Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Interest Header";
    PromotedActionCategories = 'New,Process,Reports,Workflow,Reopen Document';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Due Date"; Rec."Interest Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Distributed Amount"; Rec."Distributed Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Count"; Rec."Loan Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted Loan Count"; Rec."Posted Loan Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Entered By.';
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                { }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                { }
            }
            part(Control1000000008; "Loans Interest")
            {
                Editable = PageEditable;
                SubPageLink = No = FIELD("No.");
                ApplicationArea = Basic, Suite;

            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Action1000000010)
            {
                // action("Generate Entries")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Generate Entries';
                //     Image = GetEntries;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = false;

                //     trigger OnAction()
                //     var
                //         SelectOpttionsErr: Label 'Select Options';
                //         Periodicactivities: Codeunit "Periodic Activities";
                //         LoanInterestBuffer: Record "Loans Interest Buffer";
                //         LoansInt: Record "Loans Interest";
                //     begin

                //         if Rec.Status <> Rec.Status::Open then
                //             Error('You canot generate entries since the document is already %1', Rec.Status);
                //         if not Rec.Posted then begin
                //             //Delete existing entries
                //             LoansInterest.Reset;
                //             LoansInterest.SetRange(LoansInterest.No, Rec."No.");
                //             if LoansInterest.Find('-') then
                //                 LoansInterest.DeleteAll;
                //             // if Rec.Status = Rec.Status::Open then begin
                //                 PeriodicActivities.GenerateDailyInterest(LoansInt, Rec."No.", Rec."Employer Code");
                //                 // PeriodicActivities.GenerateDailyInterest(LoanInterestBuffer, Rec."No.", Rec."Employer Code");LoansInterest
                //             // end;
                //         end else
                //             Error('These Entries have already been posted.');
                //     end;
                // }
                action("Post Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error(ErrNotApproved);
                        Rec.CalcFields("Distributed Amount");
                        if Rec."Distributed Amount" = 0 then
                            Error(ErrNoEntries);
                        if not Confirm('Do you want to post these entries?') then
                            exit else
                            PeriodicActivities.PostEntries(Rec);
                    end;
                }
                action("Generate Entries Selectively")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = "Process";
                    PromotedIsBig = true;
                    //RunObject = Report "Generate Monthly Interest";
                    trigger OnAction()
                    var
                        myInt: Integer;
                        INHeader: Record "Interest Header";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        rec.TestField("End Date");
                        INHeader.Reset();
                        INHeader.SetRange("No.", Rec."No.");
                        if INHeader.FindFirst() then begin
                            REPORT.Run(Report::"Generate Monthly Interest", true, false, INHeader);
                        end;
                    end;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if not Confirm('Do you want to reopen this document?') then exit;
                        Rec.TestField(Posted, false);
                        rec.TestField(Status, Rec.Status::Approved);
                        if Rec.Status = Rec.Status::Approved then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;

                    end;
                }
                separator(Action1000000020)
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
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    Enabled = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Posting Date");
                        Rec.TestField("Document No.");
                        Rec.TestField(Description);
                        Rec.TestField("Interest Due Date");
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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

                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then Error('You cannot modify this record');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        RecBuffer: Record "Loans Interest";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        aaaaa: Date;
        DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        LoansInterest: Record "Loans Interest";

        RecBuffLines: Record "Loans Interest";
        PageEditable: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if (Rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            PageEditable := false;
        end else
            PageEditable := true;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

