page 52185555 "HR Leave Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,,,,,Approvals';
    SourceTable = "HR Leave Application";

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
                    Editable = Inst;
                    ShowMandatory = true;
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Enabled = true;
                    Importance = Promoted;
                    Editable = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Inst;
                    //Editable=Inst;
                    trigger OnValidate()
                    Var
                        LeaveTypes: Record "HR Leave Types";
                    begin
                        // LeaveTypes.Reset;
                        // LeaveTypes.SetRange("Is Annual Leave", true);
                        // if LeaveTypes.findfirst() then begin
                        //     if Rec."Leave Type" <> LeaveTypes.Code then
                        //         GetLeaveStats(LeaveTypes.Code)
                        //     else
                        //         GetLeaveStats(Rec."Leave Type");
                        // end;
                        // LeaveTypes.Reset;
                        // LeaveTypes.SetRange("Is Annual Leave", true);
                        // if LeaveTypes.findfirst() then begin
                        //     if Rec."Leave Type" <> LeaveTypes.Code then
                        //         GetLeaveStats(LeaveTypes.Code)
                        // end
                        // else
                        GetLeaveStats(Rec."Leave Type");
                    end;
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Applicant User ID"; Rec."Applicant User ID")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field("Applicant Supervisor"; Rec."Applicant Supervisor")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Supervisor Email"; Rec."Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("**")
                {
                    Caption = '*';
                    ApplicationArea = Basic;
                }


                // field("Days To Apply"; Rec."Days Approved")
                // {
                //     Caption = 'Days Applied';


                // }
                // field(RemainingDays; RemainingDays)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Inst;
                }
                field("Leave Start Time Calc"; Rec."Leave Start Time Calc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Starts';
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Inst;
                }
                field("Is Morning Half Day"; Rec."Is Morning Half Day")
                {
                    ApplicationArea = Basic;
                    Caption = 'Morning';
                    Editable = MorningHalfDayEditable;
                    ToolTip = 'Check this if you need only the morning off on the End Date. You will return to work in the afternoon of the End Date. Reduces leave by 0.5 days.';
                }
                field("Is Afternoon Half Day"; Rec."Is Afternoon Half Day")
                {
                    ApplicationArea = Basic;
                    Caption = 'Afternoon';
                    Editable = AfternoonHalfDayEditable;
                    ToolTip = 'Check this if you need only the afternoon off on the Start Date. Your leave starts in the afternoon of the Start Date. Reduces leave by 0.5 days.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'The date you are expected to return to work. Morning Half-Day: return afternoon of End Date. Afternoon Half-Day: return morning of next working day. No half-day: return morning of next working day.';
                }
                field("Return Time"; Rec."Return Time")
                {
                    ApplicationArea = Basic;
                    Caption = 'Returns';
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = Basic;
                }

                field("Total Leave Days"; Rec."Total Leave Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days Reimbursed"; Rec."Days Reimbursed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leave Days Balance"; Rec."Leave Days Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*
                field(dAlloc; dAlloc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Allocated days';
                    Editable = false;
                }
                field(dEarnd; dEarnd)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Days';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(dTaken; dTaken)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(dLeft; dLeft)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Balance';
                    Editable = false;
                    Enabled = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                */
                field("Leave Allowance Entittlement"; Rec."Leave Allowance Entittlement")
                {
                    ApplicationArea = Basic;
                }
                field("Request Leave Allowance"; Rec."Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("****")
                {
                    Caption = '*';
                    ApplicationArea = Basic;
                }
                field(Reliever; Rec.Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Code';
                    ShowMandatory = true;
                    //Editable = WtaxCode;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("*****")
                {
                    Caption = '*';
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Posted"; Rec."Time Posted")
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
            /*
            group("Mores Leave Details")
            {
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Leave Days"; Rec."Total Leave Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leave Days Balance"; Rec."Leave Days Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            */
            group("More Leave Details")
            {
                // Caption = 'More Leave Details';
                // field("Cell Phone Number"; Rec."Cell Phone Number")
                // {
                //     ApplicationArea = Basic;
                //     //Editable=false;
                //     //Editable = INVdate;
                // }
                // field("Alternative CellPhone No."; Rec."Alternative CellPhone No.")
                // {
                //     ApplicationArea = Basic;

                // }
                field("E-mail Address"; Rec."E-mail Address")
                {
                    ApplicationArea = Basic;
                    ///Editable = false;
                    Importance = Promoted;
                    Editable = Inst;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = DepType;

                }
                field("Details of Examination"; Rec."Details of Examination")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = Dimension;
                }
                field("Date of Exam"; Rec."Date of Exam")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = InvTcode;
                }
                field("Number of Previous Attempts"; Rec."Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                    Editable = MKS;
                }
            }
            group("Recall Lines")
            {
                Caption = 'Recall Lines';
                part("Recall Subpage"; "HR Leave Recall Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Leave Application Code" = field("Application Code");
                    UpdatePropagation = Both;
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
                action("Send Email to ICT")
                {
                    ApplicationArea = Basic;

                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;


                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        HRleave: Record "HR Leave Application";
                    begin
                        HRleave.Reset();
                        HRleave.SetRange("Application Code", Rec."Application Code");
                        if HRleave.Find('-') then begin
                            if HRleave.Status = HRleave.Status::Approved then begin
                                SendEmails;
                                message('Email has been sent to ICT');

                            end;
                        end;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        if rec.Status = rec.Status::Approved then exit;
                        IF not ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId) THEN BEGIN
                            Rec.Status := REC.Status::Approved;
                            Rec.validate(Status, Rec.Status::Approved);
                            REC.Modify();
                        end;
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
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Application Code");
                    RunPageView = where(Types = CONST(comment));
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        HRleave: Record "HR Leave Application";
                    begin
                        Rec.TestField(Reliever);
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("Leave Type");

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = rec.Status = rec.Status::"Pending Approval";
                    //enabled = false;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //// //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group(Reliver)
            {
                Caption = 'Reliver';
                action("Additional Reliver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Additional Reliver';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Reliver";
                    RunPageLink = "leave No" = FIELD("Application Code"),
                                  Employee = FIELD("Applicant Staff No.");
                }
                action("Update Dimensions")
                {
                    ApplicationArea = Basic;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        UserSetup.Reset;
                        UserSetup.SetRange("User ID", Rec."Applicant User ID");
                        if UserSetup.Find('-') then begin
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec."Application Date" := Today;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Record Leave Recall")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Leave Recall';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Record a new recall instance for this approved leave application';

                    trigger OnAction()
                    var
                        RecallLine: Record "HR Leave Recall Lines";
                        RecallPage: Page "HR Leave Recall Lines";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('Leave Recall can only be recorded for approved leave applications');

                        RecallLine.Init();
                        RecallLine."Leave Application Code" := Rec."Application Code";
                        RecallLine.Insert(true);
                        Commit();

                        RecallLine.Reset();
                        RecallLine.SetRange("Leave Application Code", Rec."Application Code");
                        RecallLine.FindLast();

                        RecallPage.SetTableView(RecallLine);
                        RecallPage.SetRecord(RecallLine);
                        RecallPage.Run();

                        CurrPage.Update(false);
                    end;
                }
                action("Leave Recall (Old)")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = false;
                    Visible = false;
                    Caption = 'Leave Recall (Old - Permanent Termination)';

                    trigger OnAction()
                    Var
                        StatusChangePermission: Record "Status Change Permissions.";
                    begin
                        StatusChangePermission.Reset;
                        StatusChangePermission.Setrange("Edit HR", True);
                        if Not StatusChangePermission.Find('-') then begin
                            Error('You do not have the permission to Conduct a Leave Recall, please contact ICT.');
                        end;

                        // UserSetup.reset;
                        // UserSetup.SetRange("User ID", UserId);
                        // if UserSetup.FindFirst() then begin
                        //     if UserSetup."Responsibility Centre" <> 'HR' then error('You do not have permission kindly contact HR Administrator');
                        // end;
                        rec.TestField("Recall Date");
                        if rec.Status <> rec.status::Approved then error('Status should be approved');


                        if rec.DetermineIfIsNonWorking(rec."Recall Date") then Error('Return date is not a working date');

                        if rec."Recall Date" >= Rec."Return Date" then Error('New Return date must be less than the return date');

                        if rec."Recall Date" < Rec."Start Date" then Error('New Return date must be greater than the start date');
                        NewReturnDate := rec."Recall Date";
                        NewReturnDateII := rec."Recall Date";
                        RemainingDays := 0;
                        while Rec."End Date" >= NewReturnDate do begin
                            if not Rec.DetermineIfIsNonWorking(NewReturnDate) then
                                RemainingDays += 1;
                            NewReturnDate := CalcDate('1D', NewReturnDate);
                        end;

                        Clear(EndDateI);
                        Clear(ItsAWorkingDay);
                        Exp1 := Format(-RemainingDays) + 'D';
                        EndDate := CalcDate('-1D', NewReturnDateII);
                        if Rec.DetermineIfIsNonWorking(EndDate) then BEGIN
                            repeat
                                EndDate := CalcDate('-1D', EndDate);
                                EndDateI := EndDate;
                                ItsAWorkingDay := not Rec.DetermineIfIsNonWorking(EndDateI);
                            until ItsAWorkingDay;

                        END;

                        Rec."Days Applied" -= RemainingDays;

                        //Rec."Recall Date" := Today;
                        Rec."End Date" := EndDateI;
                        Rec."Return Date" := NewReturnDateII;

                        //Rec.Validate("Days Applied");
                        Rec.Modify;

                        HRLeaveCal.Reset;
                        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                        if not HRLeaveCal.Find('-') then
                            Error('Leave Calendar not setup')
                        else
                            CalenderCode := HRLeaveCal."Calendar Code";


                        Message(Format(RemainingDays));


                        JBatch := 'POSITIVE';
                        JTemplate := 'LEAVE';


                        LeaveGjline.SetRange("Journal Batch Name", JBatch);
                        LeaveGjline.SetRange("Journal Template Name", JTemplate);
                        if LeaveGjline.Find('-') then LeaveGjline.DeleteAll;

                        LeaveGjline.Reset;
                        LeaveGjline.SetRange("Journal Batch Name", JBatch);
                        LeaveGjline.SetRange("Journal Template Name", JTemplate);
                        if LeaveGjline.FindLast then
                            EntryNo := LeaveGjline."Line No." + 1;

                        LeaveGjline.Init;
                        LeaveGjline."Journal Template Name" := JTemplate;
                        LeaveGjline."Journal Batch Name" := JBatch;
                        LeaveGjline.Validate("Journal Batch Name");
                        LeaveGjline."Line No." := EntryNo;
                        LeaveGjline."Leave Calendar Code" := CalenderCode;
                        LeaveGjline."Staff No." := rec."Applicant Staff No.";
                        LeaveGjline."Staff Name" := rec.Names;
                        LeaveGjline."Leave Type" := rec."Leave Type";
                        LeaveGjline."Is Annual Leave" := TRUE;
                        LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Reimbursement;
                        LeaveGjline."No. of Days" := RemainingDays;
                        LeaveGjline.Description := 'Reimbursment of Recalled days [' + Rec."Application Code" + ']';
                        LeaveGjline."Document No." := rec."Applicant Staff No.";
                        LeaveGjline."Posting Date" := Today;
                        LeaveGjline."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
                        LeaveGjline."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                        LeaveGjline.Insert;

                        LeaveGjline.Reset;
                        LeaveGjline.SetRange("Journal Batch Name", JBatch);
                        LeaveGjline.SetRange("Journal Template Name", JTemplate);
                        if LeaveGjline.Find('-') then begin
                            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);
                            Post := false;
                            Post := JournlPosted.PostedSuccessfully();

                        end;
                    end;

                    // trigger OnAction()
                    // begin
                    //     //IF TODAY>="Return Date" THEN ERROR('Recall must be done for an active Leave');
                    //     Rec.SetFilter("Application Code", Rec."Application Code");
                    //     REPORT.Run(Report::"Reimburse Recalled Leave Days", true, true, Rec);

                    //     CurrPage.EDITABLE:=TRUE;
                    //     "Recall Date":=TODAY;
                    //     RemainingDays:="End Date"-"Recall Date";
                    //     JBatch:='POSITIVE';
                    //     Jtemplate:='LEAVE';
                    //     LeaveGjline.SETRANGE("Journal Batch Name",JBatch);
                    //     LeaveGjline.SETRANGE("Journal Template Name",Jtemplate);
                    //     IF LeaveGjline.FIND('-')  LeaveGjline.DELETEALL;
                    //     LeaveGjline.RESET;
                    //     LeaveGjline.SETRANGE("Journal Batch Name",JBatch);
                    //     LeaveGjline.SETRANGE("Journal Template Name",Jtemplate);
                    //     IF LeaveGjline.FINDLAST THEN
                    //       EntryNo:="LineNo."+1;
                    //     LeaveGjline.INIT;
                    //     LeaveGjline."Journal Template Name":=Jtemplate;
                    //     LeaveGjline."Journal Batch Name":=JBatch;
                    //     LeaveGjline.VALIDATE("Journal Batch Name");
                    //     LeaveGjline."Line No.":=EntryNo;
                    //     LeaveGjline."Leave Calendar Code":='2021';
                    //     LeaveGjline."Staff No.":="Applicant Staff No.";
                    //     LeaveGjline."Staff Name":=Names;
                    //     LeaveGjline."Leave Type":="Leave Type";
                    //     LeaveGjline."Leave Entry Type":=LeaveGjline."Leave Entry Type"::Positive;
                    //     LeaveGjline."No. of Days":=RemainingDays;
                    //     LeaveGjline.Description:='Reimbursment of Recalled days';
                    //     LeaveGjline."Document No.":="Applicant Staff No.";
                    //     LeaveGjline."Posting Date":=TODAY;
                    //     LeaveGjline."Global Dimension 1 Code":="Global Dimension 1 Code";
                    //     LeaveGjline."Global Dimension 2 Code":="Global Dimension 2 Code";
                    //     LeaveGjline.INSERT;

                    //     {LeaveGjline.RESET;
                    //     LeaveGjline.SETRANGE("Journal Batch Name",JBatch);
                    //     LeaveGjline.SETRANGE("Journal Template Name",Jtemplate);
                    //     IF LeaveGjline.FINDLAST THEN BEGIN
                    //     CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post",Rec);
                    //     END;}

                    //     MESSAGE('inserted into %1 Template %2 Batch successfuly');



                    //     Datesubtraction:=TODAY-"Start Date";
                    //     RemainingDays:=DATE2DMY(TODAY-"Start Date",1);

                    // end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Get Employee Details

        UpdateControls();


        //Get leave statistics
        //GetLeaveStats(Rec."Leave Type");

        //Approvals
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        HRLeaveApp.Reset;
        HRLeaveApp.SetRange(HRLeaveApp.Status, HRLeaveApp.Status::New);
        HRLeaveApp.SetRange(HRLeaveApp."Applicant User ID", UserId);
        if HRLeaveApp.Find('-') then begin
            if HRLeaveApp.Count > 1 then begin
                Error('There are still some untilized Leave Application Documents [ %1 ]. Please utilise them first'
                      , HRLeaveApp."Application Code");
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        xRec.Reset;
        xRec.SetRange(xRec."Applicant User ID", UserId);
        xRec.SetRange(xRec.Status, xRec.Status::"Pending Approval");
        if xRec.Find('-') then
            Error('Your leave application no' + ' ' + xRec."Application Code" + 'is still  pending Approval. Kindy Contact the HR department to have it approved first');
        rec."Applicant User ID" := UserId;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Application Code" <> '' then begin
            if Rec.Status = Rec.Status::New then begin
                Rec."Application Date" := Today;
                Rec.Modify
            end;
        end;
        // rec.Reset;
        // rec.SetFilter("Application Code", Rec."Application Code");

        // GetLeaveStats(Rec."Leave Type");

    end;

    var
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        HREmp: Record "HR Employees";

        HRLeaveApp: Record "HR Leave Application";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        UserSetup: Record "User Setup";
        varDaysApplied: Decimal;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Journal Line";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRJournalBatch: Record "HR Leave Journal Batch";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRLeaveCal: Record "HR Leave Calendar";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        RemainingDays: Integer;
        Datesubtraction: Date;
        EntryNo: Integer;
        JBatch: Code[10];
        Jtemplate: Code[10];
        IntMode: Boolean;
        CurrCode: Boolean;
        RespCenter: Boolean;
        Rmks: Boolean;
        WtaxCode: Boolean;
        INVdate: Boolean;
        pType: Boolean;
        Freq: Boolean;
        Intrate: Boolean;
        Mmarketpage: Boolean;
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
        Dimension: Boolean;
        MKS: Boolean;
        MorningHalfDayEditable: Boolean;
        AfternoonHalfDayEditable: Boolean;
        Separation: record "HR Employee Exit Interviews";
        NewReturnDate2: date;
        NewReturnDate: Date;
        NewReturnDateII: Date;
        EndDateI: Date;
        ItsAWorkingDay: Boolean;
        Enddate2: date;
        ApprovalsCodeunit: codeunit "Approvals Mgmt.";
        EndDate: Date;
        Post: Boolean;
        Exp1: TEXT[30];
        JournlPosted: Codeunit "Journal Post Successful";
        CalenderCode: Code[30];

    //[Scope('OnPrem')]


    //[Scope('OnPrem')]
    procedure GetLeaveStats(LeaveType: Text[50])
    begin
        HREmp.Reset;
        if HREmp.Get(Rec."Applicant Staff No.") then begin

            HRLeaveCal.Reset;
            HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
            if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');

            //Filter by Leave Period from HR Setup
            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.setrange(HRLeaveLedgerEntries."Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Reimbursement);
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            HRLeaveLedgerEntries.CalcSums("No. of days");
            Rec."Days Reimbursed" := HRLeaveLedgerEntries."No. of days";

            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.SetRange("Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Negative);
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            HRLeaveLedgerEntries.CalcSums("No. of days");
            Rec."Total Leave Taken" := HRLeaveLedgerEntries."No. of days";

            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.SetRange("Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Positive);
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            HRLeaveLedgerEntries.CalcSums("No. of days");
            Rec."Allocated Leave Days" := HRLeaveLedgerEntries."No. of days";

            HRLeaveLedgerEntries.Reset;
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
            HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
            HRLeaveLedgerEntries.CalcSums("No. of days");
            Rec."Leave Days Balance" := HRLeaveLedgerEntries."No. of days";

            Rec."Total Leave Days" := rec."Allocated Leave Days" + rec."Days Reimbursed";

            Rec.Modify(True);
        end;
    end;

    //[Scope('OnPrem')]


    procedure SendEmails()
    var
        myInt: Integer;
        email: codeunit Email;
        userset: Record "User Setup";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br><h>';
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentInstream: InStream;
        Application: Record "HR Job Applications";

        AttachmentOutstream: OutStream;
        Temp: Codeunit "Temp Blob";
        msg: text;
        subject: text;
    begin
        userset.Reset();
        userset.SetRange("User ID", UserId);
        userset.setrange("Responsibility Centre", 'ICT');
        if userset.Find('-') then begin
            repeat
                usermail := userset."E-Mail";
                username := userset."Full Name";



                if rec."Days Applied" >= 10 then begin
                    msg := 'Kindly Deactivate employee No ' + ' ' + rec."Applicant Staff No." + ' ' + rec."Employee Name";
                    subject := 'Request to Deactivate Separated Employee';
                end;
                if rec."Return Date" = today then begin
                    msg := 'Kindly Activate employee No ' + ' ' + rec."Applicant Staff No." + ' ' + rec."Employee Name";
                    subject := 'Request to Re-activate Separated Employee';
                end;
                EmailMsg.Create(usermail, subject, msg, true);
                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            until userset.next = 0;

        end;
    end;

    local procedure SetControlAppearance()
    var

    begin

    end;

    local procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            InvTcode := true;
            Inst := true;
            DepType := true;
            IntMode := true;
            CurrCode := true;
            RespCenter := true;
            Rmks := true;
            WtaxCode := true;
            INVdate := true;
            pType := true;
            Freq := true;
            Intrate := true;
            Mmarketpage := true;
            Dimension := true;
            MKS := true;

            if (Rec."End Date" <> 0D) and (Rec.GetDayLeaveValue(Rec."End Date") = 0.5) then
                MorningHalfDayEditable := false
            else
                MorningHalfDayEditable := true;

            if (Rec."Start Date" <> 0D) and (Rec.GetDayLeaveValue(Rec."Start Date") = 0.5) then
                AfternoonHalfDayEditable := false
            else
                AfternoonHalfDayEditable := true;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
            MorningHalfDayEditable := false;
            AfternoonHalfDayEditable := false;
        end;


        if Rec.Status = Rec.Status::Approved then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            MorningHalfDayEditable := false;
            AfternoonHalfDayEditable := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
        end;
    end;
}

