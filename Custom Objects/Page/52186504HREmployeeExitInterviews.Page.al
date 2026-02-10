page 52186504 "HR Employee Exit Interviews1"
{
    Caption = 'Hr Exit';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview,,,,,Approvals';
    SourceTable = "HR Employee Exit Interviews";

    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Interview No"; Rec."Exit Interview No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Of Interview"; Rec."Date Of Interview")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interview Done By"; Rec."Interview Done By")
                {
                    ApplicationArea = Basic;
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                }
                field(Department; Rec.Department)
                {

                }
                field("Reason For Leaving"; Rec."Reason For Leaving")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic;
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comment)
                {
                    MultiLine = true;
                }
                field("Form Submitted"; Rec."Form Submitted")
                {
                    ApplicationArea = Basic;
                }
                field("Dues Amount"; Rec."Dues Amount")
                {


                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {

                }
            }
            group(rating)
            {
                field("Work Experience"; Rec."Work Experience")
                {

                }
                field("role played"; Rec."role played")
                {

                }
                field("Training Received"; Rec."Training Received")
                {

                }
                field("Support Received"; Rec."Support Received")
                {

                }

            }
            // part(SF; "Misc. Article Information List")
            // {
            //     Caption = 'Allocated Assets';
            //     SubPageLink = "Exit Interview No" = FIELD("Exit Interview No");
            //     SubPageView = WHERE("In Use" = FILTER(true));
            // }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755010; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action("Close Interview")
                {
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Rec.TestField("Form Submitted");
                        Rec.TestField("Reason For Leaving");
                        Rec.TestField("Employee No.");


                        if Confirm(Text001, true) = false then exit;
                        if rec.Status <> rec.Status::Approved then exit;

                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."Employee No.");
                        if HREmp.Find('-') then begin
                            if Hremp.Status = HREmp.status::Active THEN BEGIN
                                HREmp."Date Of Leaving the Company" := Rec."Date Of Leaving";
                                HREmp."Termination Category" := Rec."Reason For Leaving";
                                HREmp."Exit Interview Date" := Rec."Date Of Interview";
                                HREmp."Exit Interview Done by" := Rec."Interview Done By";
                                HREmp."Allow Re-Employment In Future" := Rec."Re Employ In Future";
                                HREmp."Termination Grounds" := Rec."Reason For Leaving";
                                HREmp.Status := HREmp.Status::InActive;
                                HREmp.Modify;
                                Rec.Closed := true;
                                rec.Modify;
                            end else
                                error('This Employee is already Inactive')
                        END;


                    end;
                }
                action("Send Email To ICT")
                {
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if rec.Status <> rec.Status::Approved then exit;
                        IF Rec.Closed = true then
                            SendEmails;

                    END;
                }



                action("Reinstate")
                {
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Rec.TestField("Form Submitted");
                        Rec.TestField("Reason For Leaving");
                        Rec.TestField("Employee No.");


                        if Confirm(Text003, true) = false then exit;
                        if (rec.Status = rec.Status::Approved) and (rec.Closed = True) then begin          

                            HREmp.Reset;
                            HREmp.SetRange(HREmp."No.", Rec."Employee No.");
                            if HREmp.Find('-') then begin
                                if Hremp.Status = Hremp.Status::Inactive then begin
                                    HREmp.Status := HREmp.Status::Active;
                                    HREmp."Reengagement Date" := Today;
                                    HREmp.Modify;
                                    Rec.closed := False;
                                    Rec.Modify;
                                    Message('Reengaged');
                                end else
                                    error('This Employee is already Active');
                            end;
                            SendEmails;
                            message('Email Sent to ICT');

                        end;
                    end;
                }
            }
            action("Final Dues")
            {
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Final Dues';
                RunObject = Page "Dues Amount";
                RunPageLink = "Dues ID" = FIELD("Exit Interview No");



                trigger OnAction()
                begin

                end;

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
                    //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin




                        VarVariant := Rec;



                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
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
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Reopen Job Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen Job Card';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category9;


                    trigger OnAction()
                    begin
                        Message('Sets the status of separation to open');

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Defer)
                {
                    ApplicationArea = All;
                    Caption = 'Defer';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.TestField(Comment);
                        Rec.Status := Rec.Status::Deferred;
                        MESSAGE('Record Deferred');
                    end;

                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
       IF HREmp.GET(Dependants) THEN BEGIN
       JobTitle:=HREmp."Job Title";
       sUserID:=HREmp."User ID";
       END ELSE BEGIN
       JobTitle:='';
       sUserID:='';
       END;


       SETRANGE(Dependants);
       DAge:='';
       DService:='';
       DPension:='';
       DMedical:='';

       RecalcDates;
            */

        UpdateControls;

    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        rec.Reset;
        rec.SetFilter("Exit Interview No", Rec."Exit Interview No");
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record "HR Employees";
        Dates: Codeunit "HR Codeunit2";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HR Employee Card";
        sUserID: Code[30];
        DoclLink: Record "HR Company Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Misc: Record "Misc. Article Information";
        Text19062217: Label 'Misc Articles';
        Text001: Label 'Closing this interview will deactivate the employee. Do you want to continue?';
        Text002: Label 'Exit interview successfully closed.';
        Text003: Label 'Reinstating this interview will activate the employee. Do you want to continue?';

    //[Scope('OnPrem')]
    procedure RecalcDates()
    begin
    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        /*
       CurrPage.SAVERECORD;
       FILTERGROUP := 2;
       //Misc.SETRANGE(Misc."Employee No.",Dependants);
       FILTERGROUP := 0;
       IF Misc.FIND('-') THEN;
       CurrPage.UPDATE(FALSE);
         */

    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    procedure SendEmails()
    var
        myInt: Integer;
        email: codeunit Email;
        userset: Record "User Setup";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';
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
            until userset.next = 0;

        end;
        if rec.closed = true then begin
            msg := 'Kindly Deactivate employee No ' + ' ' + rec."Employee No." + ' ' + rec."Employee Name";
            subject := 'Request to Deactivate Separated Employee';
        end;
        if rec.closed = false then begin
            msg := 'Kindly Activate employee No ' + ' ' + rec."Employee No." + ' ' + rec."Employee Name";
            subject := 'Request to Re-activate Separated Employee';
        end;
        EmailMsg.Create(usermail, subject, msg, true);
        //EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
        message('Email Sent to ICT');

    end;
}

