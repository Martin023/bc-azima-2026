page 52186145 "HR Individual Appraisal Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Approvals,Appraisal Actions,Training';
    SourceTable = "HR Individual Targets Header";
    ApplicationArea = Basic;
    UsageCategory = Documents;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AppraisalPeriod.Reset;
                        AppraisalPeriod.SetRange(AppraisalPeriod.Closed, false);
                        if AppraisalPeriod.Find('-') then begin
                            OpenPeriod := AppraisalPeriod."Appraisal Period Description"
                        end;

                        HRIndividualTargetsHeader.Reset;
                    end;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Review Sequence No"; Rec."Review Sequence No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Total Targeted Score"; Rec."Total Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Achieved Score"; Rec."Total Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Agreed Rating"; Rec."Total Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Lock appraisal"; Rec."Lock appraisal")
                {
                    ApplicationArea = Basic;
                }
                field("Initiated By User ID"; Rec."Initiated By User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Initiated By Employee No"; Rec."Initiated By Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisee Submitted"; Rec."Appraisee Submitted")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisee Submission Date"; Rec."Appraisee Submission Date")
                {
                    ApplicationArea = Basic;
                }
                field("Has Disagreements"; Rec."Has Disagreements")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = Rec."Has Disagreements";
                }
                field("Discussion Log Count"; Rec."Discussion Log Count")
                {
                    ApplicationArea = Basic;
                }
                field("Unresolved Discussions"; Rec."Unresolved Discussions")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = Rec."Unresolved Discussions" > 0;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Department Target No"; Rec."Source Department Target No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Individual Targets"; "Mid Year Review")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(Control4; "Performance Attributes Sheet")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part("Discussion Log"; "HR Appraisal Discussion Log")
            {
                Caption = 'Discussion Log';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Visible = ShowDiscussionLog;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Import Assigned Department Targets")
            {
                Caption = 'Import Assigned Department Targets';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Open) and (Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Target Setting");

                trigger OnAction()
                var
                    Assignment: Record "HR Employee Target Assignment";
                    DeptTargetNo: Code[20];
                    DeptTargetList: Page "HR Employee Target Assgns List";
                begin
                    if Rec."Appraisal Cycle Stage" <> Rec."Appraisal Cycle Stage"::"Target Setting" then
                        Error('Can only import assigned targets during Target Setting stage.');

                    if Rec.Status <> Rec.Status::Open then
                        Error('Can only import targets when appraisal status is Open.');

                    Assignment.Reset;
                    Assignment.SetRange("Employee No", Rec."Employee No");
                    Assignment.SetFilter(Status, '%1|%2', Assignment.Status::Assigned, Assignment.Status::Accepted);
                    if Assignment.IsEmpty then
                        Error('You have no assigned department targets available for import. Please contact your HOD.');

                    DeptTargetList.SetTableView(Assignment);
                    DeptTargetList.LookupMode := true;
                    if DeptTargetList.RunModal = ACTION::LookupOK then begin
                        DeptTargetList.GetRecord(Assignment);
                        DeptTargetNo := Assignment."Department Target No";

                        if Confirm('Import all assigned targets from Department Target %1?', true, DeptTargetNo) then begin
                            Rec.ImportFromAssignedTargets(DeptTargetNo);
                            CurrPage.Update(false);
                        end;
                    end;
                end;
            }
            action("Submit to Supervisor")
            {
                Caption = 'Submit to Supervisor';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = (Rec.Status = Rec.Status::Open) and ((Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Evaluation Review") or (Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Year-End Review"));

                trigger OnAction()
                begin
                    if Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Target Setting" then
                        Error('Cannot submit appraisal during Target Setting stage. Appraisals can only be submitted during Evaluation Review or Year-End Review.');

                    if Confirm('Submit this appraisal to your supervisor for review?', true) = false then exit;
                    Rec.SubmitToSupervisor();
                    CurrPage.Update();
                end;
            }
            action("Move to Discussion")
            {
                Caption = 'Disagree - Move to Discussion';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::"Pending Approval") and ((Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Evaluation Review") or (Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Year-End Review"));

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Can only move to Discussion from Pending Approval status.');

                    if Confirm('Move this appraisal to Discussion status? Use this when there are disagreements that need to be resolved between employee and supervisor.', true) = false then exit;

                    Rec.Status := Rec.Status::Discussed;
                    Rec.Modify();
                    CurrPage.Update();

                    Message('Appraisal moved to Discussion status. Both parties can now record discussion points in the Discussion Log tab below.');
                end;
            }
            action("Record Discussion Point")
            {
                Caption = 'Add Discussion Point';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = Rec.Status::Discussed;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Discussed then
                        Error('Discussion points can only be recorded when appraisal status is "Discussed".');

                    Message('Navigate to the "Discussion Log" tab below to add discussion points, responses, and mark items as resolved.');
                    CurrPage.Update();
                end;
            }
            action("Resolve and Approve")
            {
                Caption = 'Approve Appraisal';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = ((Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Discussed)) and ((Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Evaluation Review") or (Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Year-End Review"));

                trigger OnAction()
                begin
                    if not (Rec.Status in [Rec.Status::"Pending Approval", Rec.Status::Discussed]) then
                        Error('Can only approve from Pending Approval or Discussed status.');

                    if Rec.Status = Rec.Status::Discussed then begin
                        if Rec.CheckUnresolvedDiscussions() then begin
                            if not Confirm('There are still unresolved discussion points. Do you want to proceed with approval anyway?', false) then
                                exit;
                        end;
                    end;

                    if Confirm('Approve this appraisal? This confirms agreement between employee and supervisor on performance ratings.', true) = false then exit;

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify();
                    CurrPage.Update();

                    Message('Appraisal approved successfully.');
                end;
            }
            action("Return to Supervisor")
            {
                Caption = 'Return to Supervisor';
                Image = Pause;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    if Confirm('Do you want to return this Appraisal to Supervisor?', true) = false then exit;

                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify;
                end;
            }
            action("Send back to Target Setting")
            {
                Caption = 'Send Back to Target Setting';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Confirm('Send this Appraisal back to Target Setting?', true) = false then exit;

                    Rec."Appraisal Cycle Stage" := Rec."Appraisal Cycle Stage"::"Target Setting";
                    Rec.Modify;
                end;
            }
            action(Action1000000020)
            {
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category5;
            }
            action("Print Individual Targets")
            {
                Caption = 'Print Individual Targets';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    IndivHeader: Record "HR Individual Targets Header";
                begin
                    IndivHeader.SetRange("Appraisal No", Rec."Appraisal No");
                    Report.Run(Report::"Individual Targets Report", true, false, IndivHeader);
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Evaluation Review" then begin
                        Rec.TestField(Status, Rec.Status::Discussed);
                    end;

                    if Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Target Setting" then begin
                        Rec.TestField(Status, Rec.Status::Approved);
                    end;

                    if Confirm('Are you sure you want to post?', false) = true then begin
                        Testfields;
                        HRIndividualTargetsHeader.Reset;
                        HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Appraisal No", Rec."Appraisal No");
                        if HRIndividualTargetsHeader.Find('-') then begin
                            HRIndividualTargetsHeader.CreateLedgerEntries;
                        end;
                    end;
                end;
            }
            action("Training needs")
            {
                Image = List;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "MBanking Other Services";
                //RunPageLink = Field29 = FIELD("Employee No");
                Visible = false;
            }
            action(Print)
            {
            }
            action("Close Appraisal")
            {
                Image = Close;
                Promoted = true;

                trigger OnAction()
                begin
                    if Confirm('Send this Appraisal to Supervisor?', true) = false then exit;

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /* CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
         IF ("Training Rating"<>0) AND(Training<>0) THEN
         "Training Perc Score":=("Training Rating"*25)/(Training*5);
         IF ("Service Rating"<>0) AND (Service<>0)THEN
         "Service Perc Score":=("Service Rating"*25)/(Service*5);
         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
         MODIFY;*/

        //NEW: SHOW DISCUSSION LOG ONLY IN DISCUSSED, APPROVED, OR POSTED STATUS
        ShowDiscussionLog := Rec.Status in [Rec.Status::Discussed, Rec.Status::Approved, Rec.Status::Posted];
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Lock appraisal" = true then
            Error('You connot modify a locked Appraisal');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ExistingAppraisal: Record "HR Individual Targets Header";
        CurrentEmpNo: Code[50];
    begin
        //OLD CHECK - ONLY CHECKED USER ID MATCH
        //if (UserId = xRec."User ID") and (Rec.Status <> Rec.Status::Approved) then
        //    Error('You have an open appraisal for the current period')

        //NEW: CHECK FOR EXISTING OPEN APPRAISALS FOR CURRENT USER
        CurrentEmpNo := Rec.CurrentEmployee();
        ExistingAppraisal.Reset;
        ExistingAppraisal.SetRange("Employee No", CurrentEmpNo);
        ExistingAppraisal.SetFilter(Status, '<%1', ExistingAppraisal.Status::Approved);
        if not ExistingAppraisal.IsEmpty then
            Error('You already have an open appraisal for the current period. Please complete or close it before creating a new one.');
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //IndividualTarget.VALIDATE(IndividualTarget."Finance Perc Score");
    end;

    trigger OnOpenPage()
    begin
        /*
        IF "Lock appraisal"=TRUE THEN
          CurrPage.EDITABLE:=FALSE;
        */
        //CurrPage.EDITABLE:=FALSE

    end;

    var
        HRIndividualTargetsHeader: Record "HR Individual Targets Header";
        OpenPeriod: Text[100];
        AppraisalPeriod: Record "HR Appraisal Period";
        Editpage: Boolean;
        ShowDiscussionLog: Boolean;

    //[Scope('OnPrem')]
    procedure Testfields()
    begin
        Rec.TestField("Appraisal Period");
        Rec.TestField("Appraisal No");
        Rec.TestField("Appraisal Period");
        Rec.TestField("Appraisal Date");
        Rec.TestField("Employee No");
    end;

    //[Scope('OnPrem')]
    procedure EditFields()
    begin
        /*
        IF Status<>Status::Open THEN
         Editpage:=FALSE ELSE
         Editpage:=TRUE;
         */

    end;
}

