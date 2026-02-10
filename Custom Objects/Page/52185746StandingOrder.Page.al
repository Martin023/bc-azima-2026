page 52185746 "Standing Order"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments,Suggest Accounts,Refresh';
    SourceTable = "Standing Order Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {

                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                    ApplicationArea = Basic;
                    Editable = TransactionTypeEdit;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {

                    ApplicationArea = Basic;
                    Editable = false;
                    ValuesAllowed = Savings;

                }
                field("Source Account No."; Rec."Source Account No.")
                {

                    ApplicationArea = Basic;
                    Editable = SourceAccountNoEtit;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {

                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {

                    ApplicationArea = Basic;
                }
                field("ID Number"; Rec."ID Number")
                {

                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {

                    ApplicationArea = Basic;
                    Editable = DescriptionEdit;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {

                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {

                    ApplicationArea = Basic;
                    Editable = AmountEdit;
                }
                field(Type; Rec.Type)
                {

                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Allow Partial Deduction"; Rec."Allow Partial Deduction")
                {

                    ApplicationArea = Basic;
                    Editable = AllowPartialEdit;
                }
                field("Income Type"; Rec."Income Type")
                {

                    ApplicationArea = Basic;
                    Editable = IncomeTypeEdit;
                }
                field(Branch; Rec."Global Dimension 1 Code")
                {

                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Activity; Rec."Global Dimension 2 Code")
                {

                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Standing Order Type"; Rec."Standing Order Type")
                {

                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Priority; Rec.Priority)
                {

                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {

                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        statusControl;
                        if Rec.Status = Rec.Status::Approved then
                            if Rec."Allow Partial Deduction" <> true then
                                Error('Periodic STOs must be partial');
                    end;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {

                    ApplicationArea = Basic;
                    Editable = EffectiveDateEdit;
                }
                field("Frequency (Months)"; Rec."Frequency (Months)")
                {

                    ApplicationArea = Basic;
                    Editable = FrequencyEdit;
                }
                field("Duration (Months)"; Rec."Duration (Months)")
                {

                    ApplicationArea = Basic;
                    Editable = DurationEdit;
                }
                field("End Date"; Rec."End Date")
                {

                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Target Amount"; Rec."Target Amount")
                {

                }
                field("Contributed Amount"; Rec."Contributed Amount")
                {
                    Editable = false;
                }
                field("Target Amount Balance"; Rec."Target Amount" - Rec."Contributed Amount")
                {
                    Editable = false;

                }
                field("Source Application"; Rec."Source Application")
                {
                    Editable = false;
                }

            }
            part(Control46; "Standing Order Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = Basic;
                Editable = SOLinesEdit;
            }
            group(Statistics)
            {
                field(Balance; Rec.Balance)
                {

                    ApplicationArea = Basic;
                }
                field("Stopped By"; Rec."Stopped By")
                {

                    ApplicationArea = Basic;
                }
                field("Date Stopped"; Rec."Date Stopped")
                {

                    ApplicationArea = Basic;
                }
                field(Effected; Rec.Effected)
                {

                    ApplicationArea = Basic;
                }
                field(Unsuccessfull; Rec.Unsuccessfull)
                {

                    ApplicationArea = Basic;
                }
                field("Next Run Date"; Rec."Next Run Date")
                {

                    ApplicationArea = Basic;
                }
                field("Auto Process"; Rec."Auto Process")
                {

                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Reset"; Rec."Date Reset")
                {

                    ApplicationArea = Basic;
                }
            }
        }
        // area(factboxes)
        // {
        //     part(Control45; "Signatory Factbox")
        //     {
        //         SubPageLink = "Member No." = FIELD("Member No.");
        //         ApplicationArea = Basic;
        //     }
        // }
    }

    actions
    {
        area(creation)
        {
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
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
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        StandingOrderLines: Record "Standing Order Lines";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Source Account No.");
                        Rec.TestField(Amount);
                        Rec.TestField("Effective/Start Date");
                        Rec.TestField("Duration (Months)");
                        Rec.TestField("Frequency (Months)");
                        Rec.CalcFields("Allocated Amount");
                        if Rec."Allocated Amount" <> Rec.Amount then Error(AmountError);

                        StandingOrderLines.Reset;
                        StandingOrderLines.SetRange(StandingOrderLines."Document No.", Rec."No.");
                        if StandingOrderLines.Find('-') then begin
                            repeat
                                StandingOrderLines.TestField(StandingOrderLines."Destination Account No.");
                                StandingOrderLines.TestField(StandingOrderLines.Amount);

                                case StandingOrderLines."Destination Account Type" of
                                    StandingOrderLines."Destination Account Type"::"G/L Account":
                                        begin
                                            StandingOrderLines.TestField(StandingOrderLines."Bank Code");
                                            StandingOrderLines.TESTFIELD(StandingOrderLines."Branch Code");
                                            StandingOrderLines.TestField(StandingOrderLines."Destination Account No.");
                                            Rec."Transfered to EFT" := true;
                                            Rec.Modify;
                                        end;

                                    StandingOrderLines."Destination Account Type"::Credit:
                                        begin
                                            StandingOrderLines.TestField(StandingOrderLines."Loan No.");
                                        end;

                                end;
                            until StandingOrderLines.Next = 0;
                        end;

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                            Currpage.close;
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Stop)
                {
                    ApplicationArea = Basic;
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        StopConfirm: Label 'Are you sure you want to Stop this standing order?';
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if not Confirm(StopConfirm, true) then exit;

                        Rec.Status := Rec.Status::Stopped;
                        Rec."Stopped By" := UserId;
                        Rec."Date Stopped" := Today;
                        Rec.Modify;
                        Message('This standing order has been stopped');

                        // VarVariant := Rec;
                        // IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);
                        CurrPage.Close();
                    end;
                }
                action("Process Periodic STO")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ProcessConfirm: Label 'Are you sure you want to Process Periodic Standing Order?';
                    begin
                        // Rec.TestField(Status, Rec.Status::Approved);
                        //if not Confirm(ProcessConfirm, true) then exit;

                        if rec."Income Type" = Rec."Income Type"::Periodic then
                            REPORT.Run(Report::"Standing Order Processing", true, false, Rec);

                    end;
                }
                action("ReOpen ")
                {
                    ApplicationArea = Basic;
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        StartConfirm: Label 'Are you sure you want to Re- open this standing order?';
                        StatusError: Label 'Status can only be %1  for you to run this process.';
                    begin
                        if (Rec.Status <> Rec.Status::Stopped) then
                            Error(StatusError, Format(Rec.Status::Stopped));

                        if Confirm(StartConfirm, false) = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                            Message('This standing order has been re-opened');
                        end else
                            Message('Standing order reopening has been aborted.');

                        CurrPage.close();

                        // VarVariant := Rec;
                        // IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);


                    end;
                }
            }
            group("Suggest Member Accounts")
            {
                action("Suggest Savings Accounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Saving Accounts';
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        StoLines: Record "Standing Order Lines";
                        SavingsREC: record "Savings Accounts";
                    begin
                        StoLines.Reset();
                        StoLines.SetRange("Member No", Rec."Member No.");
                        StoLines.SetRange("Document No.", Rec."No.");
                        Stolines.setrange("Destination Account Type", StoLines."Destination Account Type"::Savings);
                        StoLines.DeleteAll();

                        StoLines.Reset();
                        SavingsREC.Reset;
                        SavingsREC.SetRange(SavingsREC."Member No.", rec."Member No.");
                        SavingsREC.setfilter("Product Category", '<>%1&<>%2', SavingsREC."Product Category"::"Unallocated Fund", SavingsREC."Product Category"::"Entrance Fee");
                        if SavingsREC.Find('-') then begin
                            repeat
                                Stolines.Init();
                                StoLines."Document No." := Rec."No.";
                                StoLines."Member No" := Rec."Member No.";
                                StoLines."Destination Account Type" := StoLines."Destination Account Type"::Savings;
                                StoLines.validate("Destination Account No.", SavingsREC."No.");
                                stoLines."Transaction Type" := StoLines."Transaction Type"::" ";
                                StoLines."Loan No." := '';
                                StoLines.insert();
                            until SavingsREC.Next = 0;
                        end;
                        Message('Savings Accounts have been suggested successfully!');
                    end;
                }
                action("Suggest Member Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Member Loans';
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        StoLines: Record "Standing Order Lines";
                        Loans: record Loans;
                    begin
                        StoLines.Reset();
                        StoLines.SetRange("Member No", Rec."Member No.");
                        StoLines.SetRange("Document No.", Rec."No.");
                        Stolines.setrange("Destination Account Type", StoLines."Destination Account Type"::Credit);
                        StoLines.DeleteAll();

                        StoLines.Reset();
                        Loans.Reset;
                        Loans.SetRange("Member No.", rec."Member No.");
                        Loans.setloadfields("Total Loan Balance");
                        Loans.setfilter("Total Loan Balance", '>%1', 0);
                        if Loans.Find('-') then begin
                            repeat
                                Stolines.Init();
                                StoLines."Document No." := Rec."No.";
                                StoLines."Member No" := Rec."Member No.";
                                StoLines."Destination Account Type" := StoLines."Destination Account Type"::credit;
                                Stolines."Destination Account Name" := Loans."Member Name";
                                StoLines.validate("Loan No.", Loans."Loan No.");
                                stoLines."Transaction Type" := StoLines."Transaction Type"::Armotised;
                                StoLines.insert();
                            until Loans.Next = 0;
                        end;
                        Message('Member Loans have been suggested successfully!');
                    end;

                }
                action("Clear Unallocated lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Clear Unallocated lines';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        StoLines: Record "Standing Order Lines";
                    begin
                        StoLines.Reset();
                        //StoLines.SetRange("Member No", Rec."Member No.");
                        StoLines.SetRange("Document No.", Rec."No.");
                        Stolines.setfilter(Amount, '=%1', 0);
                        StoLines.DeleteAll();
                        Message('Unallocated lines have been cleared successfully!');
                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = Basic;
                    Caption = 'Refresh';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        StoLines: Record "Standing Order Lines";
                    begin
                        rec.CalcFields("Allocated Amount");
                        Currpage.update;
                        Message('Page refreshed successfully!');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        statusControl;
        SetControlAppearance;
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
        statusControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Source Account Type" := Rec."Source Account Type"::Savings;
        PendingStO.reset;
        PendingStO.setrange(Status, PendingStO.Status::Open);
        PendingStO.setrange("Created By", UserId);
        if PendingStO.FindSet() then begin
            if PendingStO.Count > 3 then Error('You cannot create more than 3 open standing orders at a time. Please stop or process some of your open standing orders before creating a new one.');
        end;
    end;

    // trigger OnOpenPage()
    // begin

    //     if Rec.Status <> Rec.Status::Open then
    //         CurrPage.Editable := false;
    // end;

    var
        TransactionTypeEdit: Boolean;
        SourceAccountNoEtit: Boolean;
        DescriptionEdit: Boolean;
        AmountEdit: Boolean;
        AllowPartialEdit: Boolean;
        IncomeTypeEdit: Boolean;
        EffectiveDateEdit: Boolean;
        FrequencyEdit: Boolean;
        DurationEdit: Boolean;
        SOLinesEdit: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        AmountError: Label 'Allocated amount and amount are not the same.';
        PendingStO: record "Standing Order Header";

    //[Scope('OnPrem')]
    procedure statusControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    TransactionTypeEdit := true;
                    SourceAccountNoEtit := true;
                    DescriptionEdit := true;
                    AmountEdit := true;
                    AllowPartialEdit := true;
                    IncomeTypeEdit := true;
                    EffectiveDateEdit := true;
                    FrequencyEdit := true;
                    DurationEdit := true;
                    SOLinesEdit := true;
                end;

            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected, Rec.Status::Stopped:
                begin
                    TransactionTypeEdit := false;
                    SourceAccountNoEtit := false;
                    DescriptionEdit := false;
                    AmountEdit := false;
                    AllowPartialEdit := false;
                    IncomeTypeEdit := false;
                    EffectiveDateEdit := false;
                    FrequencyEdit := false;
                    DurationEdit := false;
                    SOLinesEdit := false;
                end;
        end;
    end;

    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

