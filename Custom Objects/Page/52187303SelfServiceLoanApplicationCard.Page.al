page 52187303 "Self Loan Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Home,Process,Report,Functions,,,,,Approvals';
    SourceTable = "Self Loan Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                        if Rec.Status = Rec.Status::New then begin
                            Rec."Application Date" := Today;
                            Rec.Modify
                        end;
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                    Caption = ' Staff No.';
                    Enabled = true;
                    Importance = Promoted;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }

                field(Names; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Importance = Promoted;
                }


                label("**")
                {
                    Caption = '*';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;


                    trigger OnValidate()
                    begin


                    end;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {

                }

                field("Purpose of Loan"; Rec."Purpose of Loan")
                {
                    ApplicationArea = all;
                    Editable = true;
                    ShowMandatory = true;

                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(Installments; Rec.Installments)
                {

                }
                field(Interest; Rec.Interest)
                {
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }

                label("*****")
                {
                    Caption = '*';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Applicant User ID"; Rec."Applicant User ID")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Applicant Supervisor"; Rec."Applicant Supervisor")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Submitted"; Rec."Time Submitted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            group("Sectoral Classification")
            {
                Caption = 'Sectoral Classification';
                Editable = true;
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level1"; Rec."Sub Sector Level1")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SubSectorLevel2; Rec."Sub Sector Level2")
                {
                    Caption = 'Sub Sector Level2';
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }

        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
            group(Reliver)
            {
                action("Submit Loan")
                {
                    ApplicationArea = Basic;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanNos: Code[20];
                    begin
                        TESTFIELDS();

                        NewLoans.Reset;
                        NewLoans.SetRange(NewLoans."Member No.", Rec."Member No.");
                        NewLoans.SetRange(NewLoans."Loan Product Type", Rec."Loan Type");
                        NewLoans.SetRange(NewLoans.Posted, false);
                        NewLoans.SetFilter(Status, '%1|%2|%3', NewLoans.status::Open, NewLoans.status::Pending, NewLoans.status::Approved);
                        if NewLoans.Find('-') then begin
                            Error('Application Failed, You have %1 loan of %2 under processing.', NewLoans."Loan Product Type Name", NewLoans."Requested Amount");
                        end;
                        CreditProcess.SubmitHRLoans(rec);
                        Rec.Submitted := true;
                        Rec."Submitted By" := UserId;
                        Rec."Date Submitted" := Today;
                        Rec."Time Submitted" := Time;
                        Rec.Modify();

                    end;
                }
                action("Return To Application")
                {
                    ApplicationArea = all;
                    Image = Return;
                    Promoted = true;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        myInt: Integer;
                        loansRec: Record Loans;
                    begin
                        Rec.TestField(Submitted, true);
                        if Confirm('Do you want to re-Subtmit this application?') = true then begin
                            loansRec.Reset();
                            loansRec.SetRange("CRM Application No.", Rec."Application Code");
                            if loansRec.Find('-') then begin
                                loansRec."Sent Back to CRM" := false;
                                loansRec.Modify();
                            end;
                            Rec."Return To user" := false;
                            Rec.Modify();
                        end;

                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Get Employee Details
        FillVariables;

        //Approvals
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin


        Rec.Reset;
        Rec.SetRange(Rec."Applicant User ID", UserId);
        Rec.SetRange(Rec.Submitted, false);
        if xRec.Find('-') then
            Error('Your application no' + ' ' + xRec."Application Code" + 'is still  pending.')
    end;

    trigger OnOpenPage()
    begin
        if Rec."Application Code" <> '' then begin
            if Rec.Submitted = false then begin
                Rec."Application Date" := Today;
                Rec.Modify
            end;
        end;

        if Rec.Submitted = true then
            CurrPage.Editable := false
    end;

    var
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        HREmp: Record "HR Employees";
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        NewLoans: Record Loans;
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRLeaveCal: Record "HR Leave Calendar";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CreditProcess: Codeunit "Loans Process";

    //[Scope('OnPrem')]
    procedure FillVariables()
    begin
        //Only modify document if status is not NEW
        if Rec.Status <> Rec.Status::New then begin
            //Fill Employee Details

        end;
    end;

    //[Scope('OnPrem')]
    procedure GetLeaveStats(LeaveType: Text[50])
    begin

        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        HREmp.Reset;
        if HREmp.Get(Rec."Applicant Staff No.") then begin

            HRLeaveCal.Reset;
            HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
            if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');

            //Filter by Leave Period from HR Setup
            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Positive);
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            if HRLeaveLedgerEntries.Find('-') then begin
                dAlloc := 0;
                repeat
                    dAlloc := HRLeaveLedgerEntries."No. of days" + dAlloc;
                until HRLeaveLedgerEntries.Next = 0;
            end;


            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.SetFilter("Leave Entry Type", '%1|%2', HRLeaveLedgerEntries."Leave Entry Type"::Reimbursement, HRLeaveLedgerEntries."Leave Entry Type"::Negative);
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            if HRLeaveLedgerEntries.Find('-') then begin
                dTaken := 0;
                repeat
                    dTaken := HRLeaveLedgerEntries."No. of days" + dTaken;
                until HRLeaveLedgerEntries.Next = 0;
            end;

            //Leave Balance
            dEarnd := dAlloc;// + dTaken;
            dLeft := dAlloc + dTaken;

            //Reimbursed Leave Days
            cbf := HREmp."Reimbursed Leave Days";
            cReimbsd := HREmp."Cash - Leave Earned";
            cPerDay := HREmp."Cash per Leave Day";

        end;
    end;

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        Rec.TestField("Loan Type");
        Rec.TestField("Requested Amount");
        Rec.TestField("Application Date");
        Rec.TestField(Submitted, false);
        Rec.TestField("Main Sector");
        Rec.TestField("Sub Sector Level1");
        Rec.TestField("Sub Sector Level2");
    end;

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

