page 52186145 "HR BSC Appraisal Header-Q1"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Approvals,Functions,Training';
    SourceTable = "HR Individual Targets Header";
    ApplicationArea = Basic;
    UsageCategory = Lists;


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
                            OpenPeriod := AppraisalPeriod."Appraisal Month"
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
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Financial Targeted Score"; Rec."Financial Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Achieved Financial  Score"; Rec."Achieved Financial  Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Training Targeted Score"; Rec."Training Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Training Achieved  Score"; Rec."Training Achieved  Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Service Delivery Target Score"; Rec."Service Delivery Target Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Service Delivery Achieved"; Rec."Service Delivery Achieved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Target Score"; Rec."Customer Target Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Achieved  Score"; Rec."Customer Achieved  Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Finance Rating"; Rec."Finance Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
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
                        MODIFY; */

                    end;
                }
                field("Customer Rating"; Rec."Customer Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
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

                    end;
                }
                field("Training Rating"; Rec."Training Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
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

                    end;
                }
                field("Service Rating"; Rec."Service Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
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

                    end;
                }
                field("Overall Perc Score"; Rec."Overall Perc Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
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
            part("Financial Targets"; "HR Financial BSC Lines")
            {
                Caption = 'Financial Targets';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Perspective Code" = CONST(1);
            }
            part("Internal Processes Targets"; "HR Service BSC Lines")
            {
                Caption = 'Internal Processes Targets';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Perspective Code" = CONST(4);
            }
            part("Customer Targets"; "HR Customer BSC Lines")
            {
                Caption = 'Customer Targets';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Perspective Code" = CONST(2);
            }
            part("Learning and Growth Targets"; "HR Training Target Lines")
            {
                Caption = 'Learning and Growth Targets';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Perspective Code" = CONST(3);
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
                Enabled = (Rec.Status = Rec.Status::Open) and (Rec."Appraisal Type" = Rec."Appraisal Type"::"Target Setting");

                trigger OnAction()
                var
                    Assignment: Record "HR Employee Target Assignment";
                    DeptTargetNo: Code[20];
                    DeptTargetList: Page "HR Employee Target Assgns List";
                begin
                    if Rec."Appraisal Type" <> Rec."Appraisal Type"::"Target Setting" then
                        Error('Can only import assigned targets into Target Setting appraisals.');

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
            action("Send to supervisor")
            {
                Caption = 'Submit to Supervisor';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    //OLD CODE - SIMPLE STATUS CHANGE WITHOUT VALIDATION
                    //if Confirm('Send this Appraisal to Supervisor?', true) = false then exit;
                    //Rec.Status := Rec.Status::"Pending Approval";
                    //Rec.Modify;

                    //NEW: USE PROCEDURE WITH SELF-RATING VALIDATION
                    if Confirm('Submit this appraisal to your supervisor for review?', true) = false then exit;
                    Rec.SubmitToSupervisor();
                    CurrPage.Update();
                end;
            }
            action("Move to Discussion")
            {
                Caption = 'Move to Discussion';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Can only move to Discussion from Pending Approval status.');

                    if Confirm('Move this appraisal to Discussion status? This indicates there are disagreements that need to be resolved.', true) = false then exit;

                    Rec.Status := Rec.Status::Discussed;
                    Rec.Modify();
                    CurrPage.Update();

                    Message('Appraisal moved to Discussion status. Both parties can now record discussion points in the Discussion Log tab.');
                end;
            }
            action("Record Discussion Point")
            {
                Caption = 'Record Discussion Point';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = Rec.Status::Discussed;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Discussed then
                        Error('Discussion points can only be recorded when appraisal status is "Discussed".');

                    Message('Please navigate to the Discussion Log tab to add discussion points.');
                    CurrPage.Update();
                end;
            }
            action("Resolve and Approve")
            {
                Caption = 'Resolve and Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = Rec.Status::Discussed;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Discussed then
                        Error('Can only approve from Discussed status.');

                    if Rec.CheckUnresolvedDiscussions() then begin
                        if not Confirm('There are still unresolved discussion points. Do you want to proceed with approval anyway?', false) then
                            exit;
                    end;

                    if Confirm('Approve this appraisal? This confirms all discussions have been resolved.', true) = false then exit;

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

                    Rec."Appraisal Type" := Rec."Appraisal Type"::"Target Setting";
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
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Appraisal Type" = Rec."Appraisal Type"::"Quarter 1" then begin
                        Rec.TestField(Status, Rec.Status::Discussed);
                    end;

                    if Rec."Appraisal Type" = Rec."Appraisal Type"::"Target Setting" then begin
                        Rec.TestField(Status, Rec.Status::Approved);
                    end;

                    if Confirm('Are you sure you want to post?', false) = true then begin
                        Testfields;
                        //post
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
        //ApprovalEntries: Page "Approval Entries";
        HRIndividualTargetsHeader: Record "HR Individual Targets Header";
        OpenPeriod: Integer;
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

