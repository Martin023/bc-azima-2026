page 52186050 "Overtime Claim Header"
{
    PageType = Card;
    SourceTable = "Overtime Claim Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,,SendToPayroll,,,,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = load;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Need Request"; Rec."Need Request")
                {
                    Editable = load;
                }
                field("Employee Group"; rec."Employee Group")
                {
                    Editable = false;
                }

                field("Sent to Payroll"; Rec."Sent to Payroll")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable=false;
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = load;
                }
            }
            group("Overtime Hours")
            {
                Editable = edEditable;
                field("Total Overtime Week Days"; Rec."Total Overtime Week Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Overtime Weekend & Holid"; Rec."Total Overtime Weekend & Holid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Overtime Hrs"; Rec."Total Overtime Hrs")
                {
                    ApplicationArea = Basic, Suite;
                }
               

            }
             field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable=true;
                    
                }
            part(Lines; "Overtime Claim Lines")
            {
                ApplicationArea = Basic, Suite;
                Editable = load;
                SubPageLink = "Claim No" = FIELD("Claim No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);

                    Rec.Reset;
                    Rec.SetFilter("Claim No", Rec."Claim No");
                    //REPORT.Run(39005909, true, true, Rec);
                    Rec.Reset;
                end;
            }
            separator(Action23)
            {
            }
            action("Cancel Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to cancel this Document?';
                    Text001: Label 'You have selected not to Cancel the Document';
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm(Text000, true) then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify;
                    end else
                        Error(Text001);
                end;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        rec.testfield("Transaction Code");
                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        /*
                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                          ERROR('There are some lines that have not been committed');
                        */
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                   trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
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

                    // RunPageLink = "Table ID" = CONST(52185936),
                    //               "Document No." = FIELD("Claim No");

                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(SendToPayrolll)
            {
                action(SendOvertimeToPayroll)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send To Payroll';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    begin
                        rec.TestField("Transaction Code");

                        if rec.Status = rec.status::Approved then begin
                            SendToPayroll;
                            Message('Transferred To Payroll Succesfully');
                        end else
                            Error(Text01);

                    end;

                }
            }
        }
    }


    // Rec.TestField(Status, Rec.Status::Approved);
    //                 if Confirm(Text000, true) then begin

    trigger OnAfterGetRecord()
    begin
        ActivatControls;
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        ActivatControls;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
        ActivatControls;
         rec.Reset;
        rec.SetFilter("Staff No.",rec."Staff No.");
    end;

    var
        //// //ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        // DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        ApprovalEntry: Record "Approval Entry";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;

        edEditable: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        load: Boolean;

        Text01: label 'Document Must Be Approved';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";



    //[Scope('OnPrem')]
    procedure ActivatControls()
    begin
        /*
          IF Status <> Status::Pending THEN BEGIN
                CurrPage.Lines.EDITABLE :=FALSE;
                CurrPage."Responsibility Center".EDITABLE := FALSE;
                CurrPage.Department.EDITABLE := FALSE;
        
                CurrPage.UPDATECONTROLS;
          END ELSE BEGIN
               CurrPage.Lines.EDITABLE :=TRUE;
               CurrPage."Responsibility Center".EDITABLE := TRUE;
                CurrPage.Department.EDITABLE := TRUE;
        
               CurrPage.UPDATECONTROLS;
          END
        */
        /*
        xRec:=Rec;
        UpdateControls;
        UpdatePageControls();
        CurrPage.UPDATE;
        
          IF Status <> Status::Pending THEN
            CurrPage.EDITABLE := false
          else
            CurrPage.EDITABLE := true;
        */
        if Rec.Status = Rec.Status::"Open" then begin
            load := true;
        end;
        if rec.status = rec.status::"Pending Approval" then begin
            load := false;
        end;
        if rec.status = rec.status::Approved then begin
            load := false;
        end;
    end;

    //[Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        OTLines: Record "Overtime Claim Lines";
    begin
        AllKeyFieldsEntered := true;
        OTLines.Reset;
        OTLines.SetRange(OTLines."Claim No", Rec."Claim No");
        if OTLines.Find('-') then begin
            repeat
                if (OTLines."Work Description/Reason" = '') or (OTLines.Amount <= 0) or (OTLines.Date = 0D) then
                    AllKeyFieldsEntered := false;
            until OTLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Overtime Claim Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Claim No", Rec."Claim No");
        if PayLines.Find('-') then
            repeat
                PayLines.TestField(PayLines.Amount);
                HasLines := true;
                exit(HasLines);
            until PayLines.Next = 0;
    end;

    Procedure SendToPayroll()
    var
        ProcessPayroll: codeunit "PR Payroll Processing";
    begin
        if (rec.Status = rec.status::Approved) and (rec."Sent to Payroll" = False) then begin
            ProcessPayroll.Overtime(rec);
            rec."Sent to Payroll" := true;
            rec.Modify(true);
        end;

    end;


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
        Payline: Record "Overtime Claim Lines";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        Payline.Reset;
        Payline.SetRange(Payline."Claim No", Rec."Claim No");
        //Payline.SETRANGE(Payline.Committed,FALSE);
        //Payline.SETRANGE(Payline."Budgetary Control A/C",TRUE);
        if Payline.Find('-') then
            Exists := true;
    end;


}

