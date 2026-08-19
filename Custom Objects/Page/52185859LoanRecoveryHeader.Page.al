page 52185859 "Loan Recovery Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Recovery Header";
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FastTabsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    var
                        CreditNosSeries: Record "Credit Nos. Series";
                        NoSeries: Codeunit "No. Series";
                    begin
                        if Rec."No." <> '' then Error('You cannot change the recovery type after the header has already been created');
                        if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                            if Rec."No." = '' then begin
                                CreditNosSeries.Get;
                                CreditNosSeries.TestField(CreditNosSeries."Loan Attachment");
                                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Attachment", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
                                Rec."No." := NoSeries.GetNextNo(CreditNosSeries."Loan Attachment");


                            end;
                        end;
                        if Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
                            if Rec."No." = '' then begin
                                CreditNosSeries.Get;
                                CreditNosSeries.TestField(CreditNosSeries."Loan Reappotionment");
                                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Reappotionment", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
                                Rec."No." := NoSeries.GetNextNo(CreditNosSeries."Loan Reappotionment");
                            end;
                        end;
                        if Rec."Recovery Type" = Rec."Recovery Type"::Reversal then begin
                            if Rec."No." = '' then begin
                                CreditNosSeries.Get;
                                CreditNosSeries.TestField(CreditNosSeries."Loan Reversal");
                                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Reversal", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
                                Rec."No." := NoSeries.GetNextNo(CreditNosSeries."Loan Reversal");
                            end;
                        end;
                    end;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        if Rec."Recovery Type" = Rec."Recovery Type"::" " then Error('Please define the recovery type');
                        SetControlAppearance();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("FOSA Balance"; Rec."FOSA Balance")
                {
                    Editable = false;
                }
            }
            group("Recovery Details")
            {
                Editable = FastTabsEditable;
                Visible = RecoveryDetailsVisible;
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Prorate Deposits"; Rec."Prorate Deposits")
                {
                }
                field("Equal Guarantor Disribution"; Rec."Equal Guarantor Disribution")
                {
                }
                // field("Recover Attached Loan"; Rec."Recover Attached Loan")
                // {

                // }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    Editable = false;
                }

                field("Principle Balance"; Rec."Principle Balance")
                {
                    Editable = false;
                }

                field("Total Balance"; Rec."Total Balance")
                {
                    Caption = 'Total Loan Balance';
                    Editable = false;
                }
                field("Account to Use"; Rec."Account to Use")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Account Number"; Rec."Account Number")
                {
                    Editable = false;
                }
                field("Total Attached Recoverable"; Rec."Total Attached Recoverable")
                {
                    Editable = false;
                    ToolTip = 'This field will carry all the amount that will be cleared as part of the loanee previously attached loans and are in default';

                }
                field("Account Balance"; Rec."Account Balance")
                {
                    Editable = false;
                }

                field("Prorated Funds"; Rec."Prorated Funds")
                {
                    Editable = false;
                }
                field("Amount To Use"; Rec."Amount To Use")
                {

                }
                field("Loan SASRA Status"; Rec."Loan SASRA Status")
                {
                    Editable = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                }
                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    Editable = false;
                }
                field("Flag Member Accounts"; Rec."Flag Member Account")
                {
                    MultiLine = true;
                }

            }

            group("Reappotionment Details")
            {
                Visible = ReappotionmentDetailsVisible;
                Editable = FastTabsEditable;
                field("Attachment Header No."; Rec."Detach Recovery No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attachment Header No.';
                }
                field("Attached Loan No."; Rec."Loan No.")
                {
                    Editable = false;
                }
                field("All FOSA Loans"; Rec."All FOSA Loans")
                {
                    ToolTip = 'This is Balances for all FOSA Loans';
                }
                field("Amount Attached"; Rec."Amount Attached")
                {
                    ToolTip = 'This is the total amount that was innitially attached to all guarantors to this loan';
                }
                field("Total Amount Attached"; Rec."Total Amount Attached")
                {
                    Editable = false;
                    ToolTip = 'This is the total amount that was attached to all guarantors for all the loans that this member has ever defaulted and attached and not reversed. This loans are recovered by the same product under the products setup';
                }
                field("Accounts to Use"; Rec."Account to Use")
                {
                    Editable = false;
                }
                field("Accounts Name"; Rec."Account Name")
                {
                    Editable = false;

                }
                field("Accounts Number"; Rec."Account Number")
                {
                    Editable = false;

                }
                field("Account Balances"; Rec."Account Balance")
                {
                    Editable = false;
                    Caption = 'Account Balance';
                }
                field("Available For Reappotionment"; Rec."Available For Reappotionment")
                {
                    Editable = false;
                }

                field("Amounts To Use"; Rec."Amount To Use")
                {
                    Caption = 'Amount To Use';
                }

            }

            part(LoanRecoveryLines; "Loan Recovery Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Header No." = FIELD("No.");
                Visible = RecoveryLinesVisible;
                Editable = false;
            }
            part(LoanReappotionmentLines; "Loan Reappotionment Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Header No." = FIELD("No.");
                Visible = ReappotionmentLinesVisible;
                Editable = false;
            }

            group("Detachment Details")
            {
                Caption = 'Detachment / Reappotionment Details';
                Visible = DetachmentDetailsVisible;
                Editable = FastTabsEditable;
                field("Detach Recovery No"; Rec."Detach Recovery No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Original Recovery No';
                }
                field("Detachment Reason"; Rec."Detachment Reason")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detachment / Reappotionment Reason';
                }
                field("Flag Member Account"; Rec."Flag Member Account")
                {
                    MultiLine = true;
                }
                field("Loans No."; Rec."Loan No.")
                {
                    Editable = false;
                }
            }
            part(LoanReversalLines; "Loan Reversal Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Header No." = FIELD("No.");
                Visible = ReversalLinesVisible;
                Editable = false;
            }
            group("Other Details")
            {
                Editable = false;
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                    begin
                        SetControlAppearance();
                    end;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Action; Rec.Action)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field(Nullified; Rec.Nullified)
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
            }

            group(History)
            {
                Visible = HistoryVisible;
                field("Header Reversed"; Rec."Header Reversed")
                {
                    Editable = false;
                    ToolTip = 'Defines if this particular header has been revesed by another header to avoid second reversals';
                }
                field("Reversed By Header No"; Rec."Reversed By Header No")
                {
                    Editable = false;
                    ToolTip = 'Stores the header no that was involved in reversing this one';

                }
            }

        }
    }
    actions
    {
        area(Creation)
        {
            action("Attachment Certificate")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = AttachmentCertificateVisible;
                trigger OnAction()
                var
                begin
                    RecoveryLines.Reset();
                    RecoveryLines.SetRange("Header No.", Rec."No.");
                    if RecoveryLines.Find('-') then begin
                        Report.Run(52186793, true, false, RecoveryLines);
                    end;
                end;
            }
            action("Recover Defaulted Loan")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RecoveryActionVisible;
                Enabled = RecoveryActionEnabled;
                trigger OnAction()
                var
                    RecoveryLines: Record "Loan Recovery Lines";
                    GuarantorsAttached: Boolean;
                    FirstName: Text;
                    PhoneNumber: Text;
                    Loans: Record Loans;
                begin
                    Rec.TestField("Member No.");
                    Members.Get(Rec."Member No.");
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This document must be approved');
                    if Rec.Action = Rec.Action::Recovered then
                        Error('This loan has already been recovered');

                    if Confirm('Are you sure you want to recover this loan?') then begin
                        CheckLinesAmountAgainstLoan();
                        PostUpfrontInterests();
                        Commit();
                        PeriodicActivities.RecoverLoan(Rec);
                        Members."Subflag Backup" := Members.Subflag;
                        Members.Subflag := Members.Subflag::Defaulter;
                        Rec.Action := rec.Action::Recovered;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        Members.Modify;

                        GlobalFunctions.GetMemberData(Members."No.", FirstName, PhoneNumber);

                        RecoveryLines.Reset();
                        RecoveryLines.SetRange("Header No.", Rec."No.");
                        RecoveryLines.SetRange("Recovery Type", RecoveryLines."Recovery Type"::"Guarantor Attachment");
                        if RecoveryLines.FindFirst() then
                            GuarantorsAttached := true;

                        if Loans.Get(Rec."Loan No.") then begin
                            if GuarantorsAttached then
                                msg := 'Dear ' + FirstName + ' your defaulted ' + Loans."Loan Product Type Name" + ' KES ' + Format(Rec."Total Balance") + ' has been attached to your guarantors. ' + ForMoreInfo
                            else
                                msg := 'Dear ' + FirstName + ' your defaulted ' + Loans."Loan Product Type Name" + ' KES ' + Format(Rec."Total Balance") + ' has been attached to your deposits. ' + ForMoreInfo;
                        end;
                        SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Rec."No."), '', true, 0, false, 'CBS', Rec."No.", 'CBS');
                        Message('Process completed Successfully');
                    end;
                end;
            }

            action("Reverse and Detach")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReversalActionVisible;
                Enabled = ReversalActionEnabled;

                trigger OnAction()
                var
                    OriginalHeader: Record "Loan Recovery Header";
                begin
                    Rec.TestField("Member No.");
                    Members.Get(Rec."Member No.");
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This document must be approved');
                    if Rec.Action = Rec.Action::Reversed then
                        Error('This case has already been reversed');

                    if Confirm('Are you sure you want to reverse this loan?') then begin
                        PostUpfrontInterests();
                        PeriodicActivities.ReverseLoan(Rec);
                        Rec.Action := Rec.Action::Reversed;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        Message('Process completed Successfully');
                    end;
                end;
            }
            action(Reappotion)
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReappotionActionVisible;
                Enabled = ReappotionActionEnabled;

                trigger OnAction()
                var
                    TotalReappotionments: Decimal;
                    ReappotionmentLines: Record "Loan Reapotionment Lines";
                begin
                    if Rec."Amount To Use" <= 0 then Error('Amount to use must have a value');
                    TotalReappotionments := 0;
                    ReappotionmentLines.Reset();
                    ReappotionmentLines.SetRange("Header No.", Rec."No.");
                    if ReappotionmentLines.FindFirst() then begin
                        repeat
                            TotalReappotionments += ReappotionmentLines."Appotionment Amount";
                        until ReappotionmentLines.Next() = 0;
                    end;
                    if TotalReappotionments <> Rec."Amount To Use" then begin
                        Error('WARNING!\Total Reappotionments: KES %1\Amount to Use: KES %2\Diffrence: %3\Please revalidate amount to use', TotalReappotionments, Rec."Amount To Use", (TotalReappotionments - Rec."Amount To Use"));
                    end;

                    Rec.TestField("Member No.");
                    Members.Get(Rec."Member No.");
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This document must be approved');
                    if Rec.Action = Rec.Action::Reappotioned then
                        Error('This case has already been reappotioned');

                    if Confirm('Are you sure you want to reappotion this loan?') then begin
                        PostUpfrontInterests();

                        PeriodicActivities.Reappotion(Rec);
                        Rec.Action := Rec.Action::Reappotioned;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        msg := 'Dear ' + Members."First Name" + ' KES ' + Format(Rec."Account Balance") + ' has successfully been used to service your defaulted loan No. ' +
                        Rec."Loan No." + ' that was attached to your guarantors.';
                        SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Rec."No."), '', true, 0, false, 'CBS', Rec."No.", 'CBS');

                        Message('Process completed Successfully');
                    end;
                end;
            }

            action("Run Generated Advice")
            {
                ApplicationArea = Basic, Suite;
                Image = Installments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoansProcess: Codeunit "Loans Process";
                begin
                    LoansProcess.RunSpecificConsolidatedCheckOffAdviceReport(Rec."No.");
                end;
            }

            action("Reset Card")
            {
                ApplicationArea = Basic, Suite;
                Image = ReOpen;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) and (Rec.Action = Rec.Action::" ") then begin
                        if Confirm('Are you sure you want to reset the date?', false) = true then begin
                            // Rec."Date Entered" := Today;
                            Rec."Entered By" := UserId;
                            Rec.Modify;
                        end;
                    end
                    else
                        Error('The Date cannot be reset if Recovered is true or the document status is not open');
                end;
            }
            // action(AssinedUser)
            // {
            //     ApplicationArea = all;
            //     Image = Task;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "User Tasks";
            //     RunPageLink = "Record ID" = FIELD("No.");
            //     Caption = 'User Assigned';
            // }
            // action("Original Case")
            // {
            //     ApplicationArea = all;
            //     Image = OrderPromising;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Caption = 'Open Original Case';

            //     trigger OnAction()
            //     var
            //         DMUCFLines: Record "DMU Case Forwarding Lines";
            //         CaseForwarding: Record "DMU Case Forwarding";
            //     begin
            //         DMUCFLines.Reset();
            //         DMUCFLines.SetRange("Entry No",Rec."Case Line No");
            //         if DMUCFLines.FindFirst() then begin
            //             CaseForwarding.Get(DMUCFLines."Header No.");
            //             Page.RunModal(52187098,CaseForwarding);
            //         end;
            //     end;
            // }


        }
        area(Processing)
        {
            group(Workflows)
            {
                Caption = 'Approvals';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Visible = SendApprovalRequestVisible;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ExistingAttachment: Record "Loan Recovery Header";
                        ReappotionmentLines: Record "Loan Reapotionment Lines";
                        ReappotionmentAmount: Decimal;
                        ActualDefaultBalances: Decimal;
                        TotalBal: Decimal;


                        CurrentLoan: Record Loans;
                        OtherHeaderLoan: Record Loans;
                    begin
                        // ReappotionmentLines.Reset();
                        // ReappotionmentLines.SetRange();
                        CheckLinesAmountAgainstLoan();
                        Rec."Posting Date" := Today;
                        Rec."Entered By" := UserId;
                        // Rec."Date Entered" := Today;
                        Rec.Modify;
                        if Rec.Status <> Rec.Status::Open then Error('Document must be open');
                        if Rec."Recovery Type" = Rec."Recovery Type"::Reversal then begin
                            Rec.TestField("Detach Recovery No");
                            Rec.TestField("Detachment Reason");
                        end;

                        if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                            RecoveryLines.Reset();
                            RecoveryLines.SetRange("Header No.", Rec."No.");
                            RecoveryLines.SetRange("Recovery Type", RecoveryLines."Recovery Type"::"Attached Loan Recovery");
                            if RecoveryLines.Find('-') then begin
                                repeat
                                    Rec.GetLoanBalances(RecoveryLines."Attached Loan Number", TotalBal);
                                    ActualDefaultBalances += TotalBal;
                                until RecoveryLines.Next() = 0;
                            end;

                            if ActualDefaultBalances <> Rec."Total Attached Recoverable" then Error('Total Defaulted recoverable loan balances are not equal to the current balances');

                            ExistingAttachment.Reset();
                            ExistingAttachment.SetFilter("No.", '<>%1', Rec."No.");
                            ExistingAttachment.SetRange("Member No.", Rec."Member No.");
                            ExistingAttachment.SetFilter(Status, '%1|%2|%3|%4', Rec.Status::Open, Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Deffered);
                            ExistingAttachment.SetRange(Action, Rec.Action::" ");
                            ExistingAttachment.SetRange("Recovery Type", Rec."Recovery Type"::"Recovery and Attachment");
                            if ExistingAttachment.FindFirst() then begin
                                Rec.CalcFields("Source Unit");
                                ExistingAttachment.CalcFields("Source Unit");
                                if (Rec."Source Unit" <> Rec."Source Unit"::FOSA) and (ExistingAttachment."Source Unit" <> ExistingAttachment."Source Unit"::FOSA) then
                                    Error('There is another attachment ongoing attachment Status: %1 No: %2', ExistingAttachment.Status, ExistingAttachment."No.");
                            end;
                        end;

                        // if Rec."Recovery Type" <> Rec."Recovery Type"::Reversal then begin
                        //     if Rec."Amount To Use" = 0 then Error('Amount to use cannot be 0');
                        // end;

                        if not Confirm('Are you sure you want to send this record for approval?') then exit;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this document?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you you want to cancel this record for approval?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        Message('Document cancelled successfully');
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    // Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to reject this approval request?') then exit;
                        // Rec.TestField(Rec.Status, Rec.Status::Rejected);
                        if Rec.Status = Rec.Status::Pending then begin
                            ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                            // if Rec.Status <> Rec.Status::Pending thenb
                        end else begin
                            Message('Status must be pending');
                        end;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to delegate this approval request?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reaopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reaopen Card';
                    Image = ReOpen;
                    Visible = ReopenVisible;

                    trigger OnAction()
                    var

                    begin
                        Rec.CalcFields("Responsible Officer");
                        // if UserId = Rec."Responsible Officer" then begin

                        if Rec.Status = Rec.Status::Approved then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            Message('Record opened successfully');
                        end else begin
                            VarVariant := Rec;
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                            CurrPage.Update();
                            Message('Record opened successfully');
                        end;
                        // end else
                        //     Message('You cannot reopen a document that you did not work on');
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    Visible = DeferVisible;

                    trigger OnAction()
                    var

                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if Rec.Status <> Rec.Status::Open then
                            Error('Status must be equal to open');
                        if Rec.Action = Rec.Action::" " then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;

                            // VarVariant := Rec;
                            // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                            Rec.Status := Rec.Status::Deffered;
                            Rec.Validate(Status);
                            Rec.Modify();
                            Message('Record deffered succsessfully');
                        end else
                            Error('You cannot deffer a posted record');
                    end;
                }
                action("Nullify This Reversal")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = NullifyActionVisible;
                    trigger OnAction()
                    var
                        ReappotionmentHeaders: Record "Loan Recovery Header";
                        ReappotionmentLines: Record "Loan Reapotionment Lines";
                        AttachmentHeader: Record "Loan Recovery Header";
                        OriginalLoan: Record Loans;
                        DefaulterMember: Record Members;
                        Comments: Record Comments;
                        CreditLedgerEntry: Record "Credit Ledger Entry";
                    begin
                        if Rec.Nullified then Error('This header has already been nullified');
                        CreditLedgerEntry.Reset();
                        CreditLedgerEntry.SetRange("Document No.", Rec."No.");
                        CreditLedgerEntry.SetRange(Reversed, true);
                        if not CreditLedgerEntry.FindFirst() then Error('You cannot nullify an un-reversed transaction');

                        if not Confirm('Are you sure you want to nullify this reversal?') then exit;

                        //Mark all reappotionments as reversed
                        ReappotionmentHeaders.Reset();
                        ReappotionmentHeaders.SetRange("Member No.", Rec."Member No.");
                        ReappotionmentHeaders.SetRange(Action, ReappotionmentHeaders.Action::Reappotioned);
                        ReappotionmentHeaders.SetRange("Header Reversed", true);
                        ReappotionmentHeaders.SetRange("Reversed By Header No", Rec."No.");
                        if ReappotionmentHeaders.FindFirst() then begin
                            repeat
                                ReappotionmentLines.Reset();
                                ReappotionmentLines.SetRange("Header No.", ReappotionmentHeaders."No.");
                                if ReappotionmentLines.FindFirst() then
                                    ReappotionmentLines.ModifyAll(Reversed, false);

                                ReappotionmentHeaders."Reversed By Header No" := '';
                                ReappotionmentHeaders."Header Reversed" := false;
                                ReappotionmentHeaders.Modify();

                            until ReappotionmentHeaders.Next() = 0;
                        end;

                        //Mark original header as reversed
                        AttachmentHeader.Get(Rec."Detach Recovery No");
                        AttachmentHeader."Header Reversed" := false;
                        AttachmentHeader."Reversed By Header No" := '';
                        AttachmentHeader.Modify();

                        OriginalLoan.Get(AttachmentHeader."Loan No.");

                        OriginalLoan.Defaulted := true;
                        OriginalLoan."Loan Recovery No." := Rec."Detach Recovery No";
                        OriginalLoan.Modify();

                        //Manage flaging
                        DefaulterMember.Get(Rec."Member No.");
                        DefaulterMember.Subflag := DefaulterMember.Subflag::Defaulter;
                        DefaulterMember.Modify();

                        if Rec."Flag Member Account" <> '' then begin
                            Comments.Reset();
                            Comments.SetRange("Header No.", Rec."Member No.");
                            Comments.SetRange(Comment, Rec."Flag Member Account");
                            if Comments.FindFirst() then Comments.Delete();
                        end;

                        Rec.Nullified := true;
                        Rec.Modify();

                        Message('Transaction has been nullified successfully');
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    var
        Comments: Record Comments;
        ManualFlag: Text;
        Counter: Integer;
    begin
        SetControlAppearance();

        Counter := 0;
        if Rec."No." <> '' then begin
            Comments.Reset();
            Comments.SetRange("Header No.", Rec."No.");
            Comments.SetRange(Types, Comments.Types::Comment);
            Comments.SetFilter(Comment, '<>%1', '');
            if Comments.FindFirst() then begin
                repeat
                    Counter += 1;
                    ManualFlag += Format(Counter) + '. ' + Comments.Comment + '\';

                    if StrLen(ManualFlag) = 250 then exit;
                until Comments.Next() = 0;
            end;
        end;

        if Counter > 1 then
            MESSAGE('ALERT!\This case has the following warnings\' + ManualFlag + 'To view more, head to the comments section.');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LoanRecoHeader: Record "Loan Recovery Header";
    begin
        LoanRecoHeader.reset;
        LoanRecoHeader.SetRange("Entered By", UserId);
        LoanRecoHeader.SetRange(Status, LoanRecoHeader.Status::Open);
        LoanRecoHeader.SetRange("No.", '<>%1', rec."No.");
        if LoanRecoHeader.count > 2 then
            Error('You cannot create more than 2 open cases at a time. Kindly use the existing ones or contact the system administrator for assistance');

        LoanRecoHeader.reset;
        LoanRecoHeader.SetRange("Member No.", rec."Member No.");
        LoanRecoHeader.setfilter(Status, '<>%1', LoanRecoHeader.Status::Rejected);
        LoanRecoHeader.SetRange("No.", '<>%1', rec."No.");
        if LoanRecoHeader.findset() then
            Error('This member has an existing open case %1', LoanRecoHeader."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        if Rec."Recovery Type" = Rec."Recovery Type"::Reversal then begin
            DetachmentDetailsVisible := true;
            RecoveryLinesVisible := false;
            RecoveryDetailsVisible := false;
            ReversalActionVisible := true;
            RecoveryActionVisible := false;
            ReappotionmentLinesVisible := false;
            ReappotionmentDetailsVisible := false;
            ReappotionActionVisible := false;
            ReversalLinesVisible := true;

            if Rec.Action = Rec.Action::Reversed then begin
                if not Rec.Nullified then
                    NullifyActionVisible := true;
            end;
        end;

        if (Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment") then begin
            DetachmentDetailsVisible := false;
            RecoveryLinesVisible := true;
            RecoveryDetailsVisible := true;
            ReversalActionVisible := false;
            RecoveryActionVisible := true;
            ReappotionmentDetailsVisible := false;
            ReappotionActionVisible := false;
            ReversalLinesVisible := false;
            NullifyActionVisible := false;
        end;

        if (Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment) then begin
            DetachmentDetailsVisible := false;
            RecoveryLinesVisible := false;
            RecoveryDetailsVisible := false;
            ReversalActionVisible := false;
            RecoveryActionVisible := false;
            ReappotionmentLinesVisible := true;
            ReappotionmentDetailsVisible := true;
            ReappotionActionVisible := true;
            ReversalLinesVisible := false;
            NullifyActionVisible := false;
        end;

        if Rec.Status = Rec.Status::Open then begin
            OpenApprovalEntriesExistForCurrUser := false;
            OpenApprovalEntriesExist := false;
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := true;
            FastTabsEditable := true;
            DeferVisible := false;
            ReopenVisible := false;
            NullifyActionVisible := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := true;
            ReopenVisible := true;
            NullifyActionVisible := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            RecoveryActionEnabled := true;
            ReversalActionEnabled := true;
            ReappotionActionEnabled := true;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := true;
            ReopenVisible := true;

            if (Rec."Recovery Type" = Rec."Recovery Type"::Reversal) and (Rec.Action = Rec.Action::Reversed) then begin
                if not Rec.Nullified then
                    NullifyActionVisible := true;
            end;
            AttachmentCertificateVisible := true;
        end;
        if Rec.Status = Rec.Status::Rejected then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := false;
            ReopenVisible := false;
            ReversalLinesVisible := false;
            NullifyActionVisible := true;
        end;

        if Rec.Status = Rec.Status::Deffered then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            DeferVisible := false;
            ReopenVisible := true;
            ReversalLinesVisible := false;
            NullifyActionVisible := true;

        end;

        if Rec.Action <> Rec.Action::" " then begin
            RecoveryActionEnabled := false;
            ReversalActionEnabled := false;
            ReappotionActionEnabled := false;
            SendApprovalRequestVisible := false;
            FastTabsEditable := false;
            if Rec.Action = Rec.Action::Recovered then begin
                HistoryVisible := true;
            end;

        end;

        // Rec.CalcFields("Responsible Officer", "Supervisor ID");
        // if Rec."No." <> '' then begin
        //     if (UserId <> Rec."Responsible Officer") and (UserId <> Rec."Supervisor ID") then begin
        //         FastTabsEditable := false;
        //     end;
        // end;
    end;

    local procedure PostUpfrontInterests()
    begin
        if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
            LoansProcess.PostCapitalizedInterestDMU(Rec."Loan No.", Rec."No.");
            RecoveryLines.Reset();
            RecoveryLines.SetRange("Header No.", Rec."No.");
            RecoveryLines.SetRange("Recovery Type", RecoveryLines."Recovery Type"::"Attached Loan Recovery");
            if RecoveryLines.Find('-') then begin
                repeat

                    LoansProcess.PostCapitalizedInterestDMU(RecoveryLines."Attached Loan Number", Rec."No.");
                until RecoveryLines.Next() = 0;
            end;
        end;
        if Rec."Recovery Type" = Rec."Recovery Type"::Reversal then begin
            ReversalLines.Reset();
            ReversalLines.SetRange("Header No.", Rec."No.");
            if ReversalLines.Find('-') then begin
                repeat
                    LoansProcess.PostCapitalizedInterestDMU(ReversalLines."Guarantor Loan No", Rec."No.");
                until ReversalLines.Next() = 0;
            end;
        end;
        if Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
            ReappotionmentLines.Reset();
            ReappotionmentLines.SetRange("Header No.", Rec."No.");
            if ReappotionmentLines.Find('-') then begin
                repeat
                    LoansProcess.PostCapitalizedInterestDMU(ReappotionmentLines."Guarantor Loan No.", Rec."No.");
                until ReappotionmentLines.Next() = 0;
            end;
        end;
    end;

    local procedure CheckLinesAmountAgainstLoan()
    var
        RecoveryAmount: Decimal;
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
    begin
        RecoveryLines.Reset();
        RecoveryLines.SetRange("Header No.", Rec."No.");
        RecoveryLines.SetFilter("Recovery Type", '<>%1', RecoveryLines."Recovery Type"::"Attached Loan Recovery");
        if RecoveryLines.Find('-') then begin
            RecoveryLines.CalcSums("Recovery Amount");
            RecoveryAmount := RecoveryLines."Recovery Amount";
            Rec.GetLoanBalances(Rec."Loan No.", OutInt, OutBal, TotalBal);
            if RecoveryAmount <> TotalBal then
                Error('Loan amount %1 is not equal to the total amount being recovered %2. Kindly reopen the case and refresh', TotalBal, RecoveryAmount);
        end;
    end;



    var
        PeriodicActivities: Codeunit "Periodic Activities";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        LoansProcess: Codeunit "Loans Process";
        UserSetup: Record "User Setup";
        Members: Record Members;
        SMSSource: enum "SMS Source";
        SendSMS: Codeunit SendSms;
        RecoveryLines: Record "Loan Recovery Lines";
        RecoveryHeader: Record "Loan Recovery Header";
        ReversalLines: Record "Loan Reversal Lines";
        ReappotionmentLines: Record "Loan Reapotionment Lines";
        NullifyActionVisible: Boolean;
        msg: Text;
        FastTabCaption: Text;
        FastTabsEditable: Boolean;
        RecoveryDetailsVisible: Boolean;
        ReappotionmentDetailsVisible: Boolean;
        RecoveryLinesVisible: Boolean;
        ReappotionmentLinesVisible: Boolean;
        DetachmentDetailsVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        RecoveryActionVisible: Boolean;
        RecoveryActionEnabled: Boolean;
        ReversalActionVisible: Boolean;
        ReversalActionEnabled: Boolean;
        ReappotionActionVisible: Boolean;
        ReappotionActionEnabled: Boolean;
        SendApprovalRequestVisible: Boolean;
        HistoryVisible: Boolean;
        ReopenVisible: Boolean;
        DeferVisible: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        ReversalLinesVisible: Boolean;
        AttachmentCertificateVisible: Boolean;
        ForMoreInfo: Label 'For more info call 0748293268/0737727528';

}
