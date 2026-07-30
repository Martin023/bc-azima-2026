page 52185849 "Loan Rescheduling"
{
    // CardPageID = "Loan Rescheduling List";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Rescheduling";
    PromotedActionCategories = 'Ne,Reports,Process,Workflows,Loan Process';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Schedule Type"; Rec."Schedule Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
                            RescheduleParams := false;
                        end else
                            if Rec."Schedule Type" = Rec."Schedule Type"::Reschedule then begin
                                RescheduleParams := true;
                            end;
                    end;
                }
                field("Rescheduling Date"; Rec."Rescheduling Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximun Installments"; Rec."Maximun Installments")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("New Installments"; Rec."New Installments")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RescheduleParams;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Interest Limits"; Rec."Interest Limits")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Interest Limits %';
                    Visible = false;
                }
                field("Current Interest Rate"; Rec."Current Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Interest Rate"; Rec."New Interest Rate")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Old Amortised"; Rec."Old Amortised")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Amortised"; Rec."New Amortised")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Original Installments"; Rec."Original Installments")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Rescheduled By"; Rec."Rescheduled By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                action("Reschedule Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = ProcessMo;

                    trigger OnAction()
                    begin
                        //IF "Rescheduled By"<>USERID THEN ERROR('This transaction can only be commited by the person who initiated it');
                        if Rec.Rescheduled then Error('This Loan Has already been rescheduled');
                        IF rec.Status <> rec.Status::Approved THEN ERROR(Txt0000);
                        if Rec."Schedule Type" <> Rec."Schedule Type"::"Defaulter Loan Conversion" then begin
                            PeriodicActivities.RescheduleLoan(Rec);
                            LoansProcess.PostLoanReshedule(Rec."Loan No.");
                        end else begin
                            LoansProcess.DefaulterLoanRecovery(Rec);
                        end;

                        //Run the Generated Schedule
                        // LoanSch.Reset;
                        // LoanSch.SetRange(LoanSch."Loan No.", Rec."Loan No.");
                        // if LoanSch.Find('-') then
                        //     REPORT.Run(Report::"Ideal Repayment Schedule", true, false, LoanSch);
                    end;
                }
                action("Preview Old Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReceivableBill;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        LoanApp: Record Loans;
                    begin
                        //Message('No loan number for this specified member');
                        Rec.TestField("Loan No.");
                        Rec.TestField("Member No.");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                        if LoanApp.Find('-') then
                            REPORT.Run(Report::"Ideal Repayment Schedule", true, true, LoanApp);
                    end;
                }
                action("Loan Payment Method")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Payment Methods Application";
                    RunPageLink = "Loan No." = FIELD("Loan No.");
                    Visible = false;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    // Enabled = SendAppEdi;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        if Rec."New Installments" < 0 then
                            Error(' New Installments must be greater than Zero');
                        Rec.TestField("Loan No.");
                        Rec.TestField("Member No.");
                        Rec.TestField("New Installments");
                        Rec.TestField("New Amortised");
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CancelApp;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(ReopenDocument)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen Document';
                    Enabled = CancelApp;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        rec.TestField(Rescheduled, false);
                        rec.Status := rec.Status::Open;
                        rec.Modify;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Enabled = CancelApp;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

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

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
            CurrPage.Editable := false;
        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
            RescheduleParams := false;
        end else
            if Rec."Schedule Type" = Rec."Schedule Type"::Reschedule then begin
                RescheduleParams := true;
            end;
    end;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                end;
        end;
        if Rec.Rescheduled = true then begin
            CurrPage.Editable := false;
            ProcessMo := false;
            SendAppEdi := false;
            CancelApp := false;
            RejectM := false;
        end;

        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin

            RescheduleParams := false;
        end else
            if Rec."Schedule Type" = Rec."Schedule Type"::Reschedule then begin

                RescheduleParams := true;
            end;

        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Schedule Type" := Rec."Schedule Type"::Reschedule;
    end;

    trigger OnOpenPage()
    begin
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then CurrPage.Editable := false;

        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin

            RescheduleParams := false;
        end else
            if Rec."Schedule Type" = Rec."Schedule Type"::Reschedule then begin

                RescheduleParams := true;
            end;
    end;

    var
        Txt0000: Label 'Status must be approved before rescheduling';
        PeriodicActivities: Codeunit "Periodic Activities";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        LoanSch: Record Loans;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Birthday,"Defaulter - Notice 1","Defaulter - Notice 2","Defaulter - Notice 3",Statement,"Loan Cleared I","Loan Cleared II","Loan Reschedule","Loan Reschedule Guar";
        Cust: Record Members;
        SendSMS: Codeunit SendSms;
        LoanGua: Record "Loan Guarantors and Security";
        RescheduleParams: Boolean;
        ProcessMo: Boolean;
        SendAppEdi: Boolean;
        CancelApp: Boolean;
        RejectM: Boolean;
        LoansProcess: Codeunit "Loans Process";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

