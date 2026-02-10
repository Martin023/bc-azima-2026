page 52187011 "Loan Restucturing"
{
    // CardPageID = "Loan Rescheduling List";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Rescheduling";
    PromotedActionCategories = 'New,Reports,Process,Workflows,Loan Process';

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
                    Visible = true;
                    ValuesAllowed = " ", Restructure, "Defaulter Loan Conversion";
                    trigger OnValidate()
                    begin
                        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
                            InterestParams := true;
                            RescheduleParams := false;
                        end else
                            if (Rec."Schedule Type" = Rec."Schedule Type"::Reschedule) or (Rec."Schedule Type" = Rec."Schedule Type"::Restructure) then begin
                                InterestParams := false;
                                RescheduleParams := true;
                            end;
                        SetControlAppearance();
                    end;
                }
                field("Rescheduling Date"; Rec."Rescheduling Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Restructing Date';
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
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Restructured';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Rescheduled By"; Rec."Rescheduled By")
                {
                    ApplicationArea = all;
                    Caption = 'Restuctured By';
                    Editable = false;

                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                    Caption = 'Captured By';
                }
            }
            group(Reschedule)
            {
                Editable = RescheduleTypeVisible;
                Caption = 'Loan Restructure';
                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Installments"; Rec."New Installments")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = RescheduleParams;
                }
                field("Interest Limits"; Rec."Interest Limits")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Interest Limits %';
                }
                field("Current Interest Rate"; Rec."Current Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Interest Rate"; Rec."New Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = InterestParams;
                }
                field("Old Amortised"; Rec."Old Amortised")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Amortised"; Rec."New Amortised")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Original Installments"; Rec."Original Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximun Installments"; Rec."Maximun Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
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
                action("Restructure Loan")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    Image = Post;
                    PromotedCategory = Category5;
                    // Enabled = ProcessMo;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        myInt: Integer;
                        LoansProcess: Codeunit "Loans Process";
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField(Rescheduled, false);
                        if Rec."Schedule Type" = Rec."Schedule Type"::"Defaulter Loan Conversion" then begin
                            LoansProcess.DefaulterLoanRecovery(Rec);
                        end Else begin
                            PeriodicActivities.RescheduleLoan(Rec);
                            LoansProcess.PostLoanStructure(Rec."Loan No.");
                            Rec."Rescheduled By" := UserId;
                            Message('Loan restructured successfully');
                        end;
                    end;
                }
                action("Preview Schedule")
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
                    Enabled = SendAppEdi;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //  Rec.TestField("Schedule Type", Rec."Schedule Type"::Restructure);
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        Rec.TestField("Member No.");
                        Rec.TestField("Loan No.");
                        if Rec."New Installments" < 0 then
                            Error('New Installments Must have a value');

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
                        //// //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Guarantor & Security")
                {
                    ApplicationArea = all;
                    Caption = 'Guarantor & securty';
                    Image = Customer;
                    Promoted = true;
                    Enabled = GurEdt;
                    Visible = false;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Guarantors and Security";
                    RunPageLink = "Loan No" = FIELD("Loan No.");

                }
                action("Guarantor Substitution")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Customer;
                    Enabled = GurEdt;
                    PromotedIsBig = true;
                    RunObject = page "Guarantor Substitution";
                    RunPageLink = "Loan No." = field("Loan No.");
                }
            }
        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        case Rec.Status of
            rec.Status::Open:
                begin
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    GurEdt := true;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    GurEdt := false;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    GurEdt := false;
                end;

        end;
        if Rec.Rescheduled = true then begin
            CurrPage.Editable := false;
            ProcessMo := false;
            SendAppEdi := false;
            CancelApp := false;
            RejectM := false;
            GurEdt := false;
        end;
        //  Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
            InterestParams := true;
            RescheduleParams := false;
        end else
            if (Rec."Schedule Type" = Rec."Schedule Type"::Reschedule) or (Rec."Schedule Type" = Rec."Schedule Type"::Restructure) then begin
                InterestParams := false;
                RescheduleParams := true;
            end;
        SetControlAppearance();
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
                    GurEdt := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    GurEdt := false;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    GurEdt := false;
                end;
        end;
        if Rec.Rescheduled = true then begin
            CurrPage.Editable := false;
            ProcessMo := false;
            SendAppEdi := false;
            CancelApp := false;
            RejectM := false;
            GurEdt := false;
        end;

        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
            InterestParams := true;
            RescheduleParams := false;
        end else
            if (Rec."Schedule Type" = Rec."Schedule Type"::Reschedule) or (Rec."Schedule Type" = Rec."Schedule Type"::Restructure) then begin
                InterestParams := false;
                RescheduleParams := true;
            end;

        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //   Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
    end;

    trigger OnOpenPage()
    begin
        // Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then CurrPage.Editable := false;

        if Rec."Schedule Type" = Rec."Schedule Type"::"Interest Change" then begin
            InterestParams := true;
            RescheduleParams := false;
        end else
            if (Rec."Schedule Type" = Rec."Schedule Type"::Reschedule) or (Rec."Schedule Type" = Rec."Schedule Type"::Reschedule) then begin
                InterestParams := false;
                RescheduleParams := true;
            end;
        if Rec.Rescheduled = true then CurrPage.Editable := false;
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
        InterestParams: Boolean;
        RescheduleParams: Boolean;
        EditNew: Boolean;
        ProcessMo: Boolean;
        SendAppEdi: Boolean;
        CancelApp: Boolean;
        RejectM: Boolean;
        GurEdt: Boolean;
        RescheduleTypeVisible: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        RescheduleTypeVisible := true;
        if Rec."Schedule Type" = Rec."Schedule Type"::"Defaulter Loan Conversion" then
            RescheduleTypeVisible := false else
            RescheduleTypeVisible := true;

        if Rec.Status <> Rec.Status::Open then RescheduleTypeVisible := false;
        if Rec.Rescheduled = true then CurrPage.Editable := false;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        // Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
        //  Rec.Modify();
    end;
}

