page 52185867 "Account  Interest Header"
{
    DeleteAllowed = true;
    Editable = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Savings Interest Header";
    SourceTableView = WHERE(Posted = FILTER(false));
    PromotedActionCategories = 'New, Process,Reports,Workflows Actions';

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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
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
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {

                }
                field("Product Name"; Rec."Product Name")
                {
                    Editable = false;
                }
                field("Distributed Amount"; Rec."Distributed Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Accs."; Rec."No of Accs.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control18; "Account Interest Buffer")
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
            group(Action31)
            {
                action("Generate Entries")
                {
                    Caption = 'Generate Entries';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        SelectOpttionsErr: Label 'Select Options';

                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error('You canot generate entries since the document is already %1', Rec.Status);
                        if rec.Posted then Error('This entry has already been posted!');
                        //SaccoTransactions.GenerateSavingssInterest(Rec);
                        SaccoTransactions.GenerateYearSavingsInterest(rec);
                    end;
                }
                action("Generate Entries Selectively")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate Entries Selectively';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        SelectOpttionsErr: Label 'Select Options';
                        InterestBuffer: Record "Savings Interest Buffer";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error('You canot generate entries since the document is already %1', Rec.Status);
                        if rec.Posted then Error('This entry has already been posted!');

                        SavingsInterestHeader.Reset();
                        SavingsInterestHeader.SetRange("No.", rec."No.");
                        SavingsInterestHeader.SetRange(SavingsInterestHeader."Start Date", Rec."Start Date");
                        REPORT.Run(Report::"Generate Selectively", true, false, SavingsInterestHeader);
                        //REPORT.Run(Report::"Generate Selectively");

                    end;
                }
                action("Import Monthly Interest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Monthly Entries';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    runobject = xmlport "Import Saving Monthly Interest";
                    trigger OnAction()
                    var
                        SelectOpttionsErr: Label 'Select Options';
                        InterestBuffer: Record "Savings Interest Buffer";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error('You canot generate entries since the document is already %1', Rec.Status);
                        if rec.Posted then Error('This entry has already been posted!');
                    end;
                }
                action("Generate Imported Entries")
                {
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        Savimport: record "Saving Interest Import Buffer";
                    begin
                        rec.testfield(Posted, false);
                        Savimport.Reset();
                        Savimport.SetRange("Header No.", rec."No.");
                        if Savimport.FindSet() then begin
                            repeat
                                if ProductFactory.get(rec."Product Type") then begin
                                    SavingsAccounts.Reset();
                                    SavingsAccounts.SetRange("Member No.", Savimport."Member No");
                                    SavingsAccounts.setrange("Product Type", rec."Product Type");
                                    if SavingsAccounts.FindFirst() then
                                        SaccoTransactions.CreateInterestBufferEntry(SavingsAccounts, Rec, ProductFactory, Savimport."Lowest Bal", Savimport."Interest Amount", Savimport."Interest Date")
                                    else begin
                                        Savimport.NotFound := true;
                                        Savimport.Modify();
                                    end;
                                end;
                            until Savimport.Next() = 0;
                        end else
                            Error('No imported entries exist');
                    end;
                }
                action("Saving Interest Import Buffer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Saving Interest Import Buffer';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    runobject = page "Saving Interest Import Buffer";
                    RunPageLink = "Header No." = FIELD("No.");
                }
                action("Clear Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delete Interest Entries';
                    Image = DeleteRow;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        InterestLines: record "Savings Interest Buffer";
                    begin
                        rec.testfield(Posted, false);
                        InterestLines.Reset();
                        InterestLines.SetRange(No, rec."No.");
                        InterestLines.deleteall();
                        Message('Entries Cleared Successfully');
                    end;
                }
                action("Post Entries")
                {
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        rec.testfield(Posted, false);
                        rec.testfield(Status, rec.status::Approved);
                        SaccoTransactions.PostSavingsInterest(Rec);
                    end;
                }
                separator(Action28)
                {

                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec."Posting Date");
                        Rec.TestField(Rec."Document No.");
                        Rec.TestField(Rec.Description);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;


                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(ReopenDcoument)
                {
                    Caption = 'Reopen Document';
                    Enabled = OpenApprovalEntriesExist;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if rec.Posted then error('Document has already been posted');
                        ApprovalsMgmt.DeleteApprovalEntries(rec.RecordId);
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = rec.Status::Rejected) then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end
                        else
                            Message('Kindly cancel the approval request first');
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals Entries';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;
                    // Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
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
        UpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        InterestBuffer: Record "Savings Interest Buffer";
        InterestBuffer2: Record "Savings Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        MSGEntriesGenerated: Label 'Entries Generated Successfully';
        MSGConfirmation: Label 'Confirm interest Generation for period starting %1 and Ending %2';
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: Label 'This document has already been posted';
        PageEditable: Boolean;
        Members: Record Members;
        SaccoTransactions: Codeunit "Sacco Transactions";
        SavingsInterestHeader: Record "Savings Interest Header";

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if (Rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            PageEditable := false;
        end else
            PageEditable := true;
    end;
}

