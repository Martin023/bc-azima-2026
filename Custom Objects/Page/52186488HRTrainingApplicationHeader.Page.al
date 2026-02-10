page 52186488 "HR Training Application Header"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Approvals';
    SourceTable = "HR Training App Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    TableRelation = "HR Training Needs" WHERE(Status = filter(Approved));
                    Editable = InvTcode;

                }
                field("Bonded Training?"; Rec."Bonded Training?")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;
                }
                field(Sponsored; Rec.Sponsored)
                {
                    Editable = false;
                }

                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                    editable = false;
                }
            }
            part(Control3; "HR Training Application Lines")
            {
                Editable = InvTcode;

                ApplicationArea = Basic;
                SubPageLink = "Application No." = FIELD("Application No");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = basic;
                Caption = 'Attachments';

            }
            systempart(Control14; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control15; Notes)
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
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //TESTFIELD("No of Posts");
                        /*TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");*/
                        VarVariant := Rec;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        if rec.Status = rec.Status::Approved then begin
                            repeat
                                HRTrainingAppLines.reset();
                                HRTrainingAppLines.setrange("Application No.", rec."Application No");
                                HRTrainingAppLines.SetRange("Employee No.", HRTrainingAppLines."Employee No.");
                                if HRTrainingAppLines.FindSet() then begin
                                    LeaveApplication.reset();
                                    LeaveApplication.SetRange(LeaveApplication.Status, LeaveApplication.Status::Approved);
                                    LeaveApplication.SetRange("Start Date", rec."Actual Start Date");
                                    LeaveApplication.SetRange("Applicant Staff No.", HRTrainingAppLines."Application No.");
                                    if LeaveApplication.FindSet() then begin
                                        HRTrainingAppLines."On Leave" := true;
                                        HRTrainingAppLines.modify();
                                        msg := 'Employee No: ' + HRTrainingAppLines."Employee No." + 'Name' + HRTrainingAppLines.Name;
                                        SendSms.SendSms(Source::"Employee Status", number, msg, '', '', true, 0, false, 'CBS', '', 'CBS');
                                        //SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loans2."Disbursement Account No"), '', true, 0, false, 'CBS', Loans2."Disbursement Account No", 'CBS');



                                    end;
                                end;
                            until HRTrainingAppLines.Next = 0;
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
                    PromotedCategory = Category5;
                    ;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                    PromotedCategory = Category5;
                    ;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Suggest Participants")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Participants';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //DW
                        HRCodeunit.fn_SuggestParticipants(39003976, Rec."Application No", 1); // Parameters = LineTable ID & Document No
                    end;
                }
                action("Get Participants")
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Closed,FALSE);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Application No.", Rec."Application No");
                        if HRActivityApprovalEntry.Find('-') then
                            HRActivityApprovalEntry.DeleteAll;

                        //GET ONLY ACTIVE EMPLOYEES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.FindFirst;
                        begin
                            HRActivityApprovalEntry.Reset;
                            repeat
                                HRActivityApprovalEntry.Init;
                                //HREmp.TESTFIELD(HREmp."User ID");
                                HRActivityApprovalEntry."Employee No." := HREmp."No.";
                                HRActivityApprovalEntry.Name := HREmp."Full Name";
                                //HRActivityApprovalEntry."Participant E-Mail":= HREmp."Company E-Mail";
                                HRActivityApprovalEntry."Application No." := Rec."Application No";
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry."Employee No.");
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }
                action("Notify Participants")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                        //TESTFIELD(Closed,FALSE);
                        
                        HRActivityApprovalEntry.RESET;
                        HRActivityApprovalEntry.SETRANGE(HRActivityApprovalEntry."Application No.","Application No");
                        
                        //IF NO PARTICIPANTS ARE IMPORTED
                        IF HRActivityApprovalEntry.COUNT=0 THEN
                        ERROR('You must get participants to notify before using this function');
                        
                        //ELSE
                        GET("Application No");
                        HRActivityApprovalEntry.RESET;
                        
                        WITH HRActivityApprovalEntry DO BEGIN
                        
                        
                        //DocType:=DocType::CompAct;
                        
                        
                        //SETRANGE("Table ID",DATABASE::"HR Activity Participants");
                        //SETRANGE("Document Type",DocType);
                        //SETRANGE(""Document no.", Code);
                        //SETRANGE("Activity Status","Activity Status"::Created);
                        //
                        REPEAT
                        
                        //ApprovalsMgtNotification.SendActivityNotificationMail(Rec,HRActivityApprovalEntry);
                        
                        
                        HRActivityApprovalEntry.GET("Employee No.");
                        //HREmp.TESTFIELD(HREmp."Company E-Mail");
                        
                        HREmailParameters.RESET;
                        HREmailParameters.GET(HREmailParameters."Associate With"::"Leave Notifications");
                        smtp.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
                        HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
                        HREmailParameters.Body+' '+"Application No"+' '+ HREmailParameters."Body 2",TRUE);
                        smtp.Send();
                        //MESSAGE('Leave applicant has been notified successfully');
                        
                        HRActivityApprovalEntry.Notified:=TRUE;
                        HRActivityApprovalEntry.MODIFY;
                        
                        UNTIL HRActivityApprovalEntry.NEXT = 0;
                        MESSAGE('%1',Text001)
                        END
                        //END
                        */



                        if Rec.Status = Rec.Status::New then
                            Error('You Cannot notify Trainers when the application is not approved');

                        // smtp.CreateMessage('Dear' + ' ' + HRTrainingAppLines.Name + ',' + 'Training Approval Notification', HRTrainingAppLines."Participant Email", HRTrainingAppLines."Participant Email",
                        //    'Training Approval Notification', 'You have Training Notification,' + "Application No" + '  ' +
                        //     HRTrainingAppLines."Employee No." + ' ', true);//"Drop Off Point"+'  '+"Pickup Point"+'  '+FORMAT("Transport Type")+'   '+'Days Applied'+'   '+FORMAT("Days Applied")+'   '+'   '+'Start Time'+'   ',TRUE)
                        //                                                    // '  '+FORMAT(Time)+'   '+'Start Date'+FORMAT("Start Date")+'   '+'   '+'Return Date'+'   '+ FORMAT("Return Date")+'  ''Driver Name'+'  '+"Driver Name"+'  '+'Vehicle'+'  '+Vehicle+'  '+"Name Vehicle",TRUE);
                        // smtp.Send();

                        Message('Email sent to participants');

                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Application No");
                    RunPageView = where(Types = CONST(comment));
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls
    end;

    trigger OnInit()
    begin

    end;

    trigger OnOpenPage()
    begin
        UpdateControls
    end;

    var
        HREmp: Record "HR Employees";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training App Header";
        ApprovalComments: Page "Approval Comments";
        // [InDataSet]
        "Responsibility CenterEditable": Boolean;
        Source: enum "SMS Source";
        // [InDataSet]
        "Application NoEditable": Boolean;
        //[InDataSet]
        "Employee No.Editable": Boolean;
        //[InDataSet]
        "Employee NameEditable": Boolean;
        //[InDataSet]
        "Employee DepartmentEditable": Boolean;
        //[InDataSet]
        "Purpose of TrainingEditable": Boolean;
        //[InDataSet]
        "Course TitleEditable": Boolean;
        HRExitTrainingBond: Record "HR Exit Training Bonding";
        HRTrainingAppLines: Record "HR Training App Lines";
        HRTrainingNeeds: Record "HR Training Needs";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit2";
        msg: text[200];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        LeaveApplication: record "HR Leave Application";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        HRActivityApprovalEntry: Record "HR Training App Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        number: text[10];
        //smtp: Codeunit "SMTP Mail";
        Text001: Label 'All Participants have been notified via E-Mail';
        SendSms: codeunit SendSms;
        InvTcode: boolean;

    procedure UpdateControls()
    begin


        if Rec.Status = Rec.Status::New then begin
            InvTcode := true;

        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;

        end;


        if Rec.Status = Rec.Status::Approved then begin
            InvTcode := false;

        end;


    end;

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
    end;

    local procedure get_LastLineNo() LastLineNo: Integer
    var
        HRExitTrainingBonding2: Record "HR Exit Training Bonding";
    begin
        HRExitTrainingBonding2.Reset;
        if HRExitTrainingBonding2.Find('+') then begin
            Rec.Status := Rec.Status::Approved;
            LastLineNo := HRExitTrainingBonding2."Line No.";
        end else begin
            Rec.Status := Rec.Status::Approved;
            LastLineNo := 1;
        end;
    end;
}

