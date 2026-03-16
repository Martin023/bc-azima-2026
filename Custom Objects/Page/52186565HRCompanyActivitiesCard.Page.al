page 52186565 "HR Company Activities Card"
{
    // DeleteAllowed = true;
    // InsertAllowed = true;
    // ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions,Action,,,,Approvals';
    SaveValues = true;
    SourceTable = "HR Company Activities";


    layout
    {
        area(content)
        {
            group(Control1102755007)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Acitivity Description"; Rec."Acitivity Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = InvTcode;
                }
                field(Jobs; Rec.Jobs)
                {
                    Editable = Inst;

                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = False;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = DepType;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = IntMode;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = CurrCode;
                }
                field("Employee Responsible"; Rec."Employee Responsible")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = RespCenter;
                }
                field(Costs; Rec.Costs)
                {
                    Caption = 'Total Costs';
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                // field("G/L Account Name"; Rec."G/L Account Name")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                //     Editable=false;
                // }
                // field("G/L Account No"; Rec."G/L Account No")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                // }
                // field("Bal. Account Type"; Rec."Bal. Account Type")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                // }
                // field("Bal. Account No"; Rec."Bal. Account No")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                // }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = WtaxCode;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field("Email Message"; Rec."Email Message")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Editable = INVdate;
                }
                field("Activity Status"; Rec."Activity Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;

                }
                field(Status; Rec.Status)
                {

                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;

                }
                field(Comments; Rec.Comments)
                {

                }
            }
            part(Control1102755011; "HR Activity Participants SF")
            {


                ApplicationArea = basic;

                SubPageLink = "Document No." = FIELD(Code);
            }
        }
        area(factboxes)
        {
            part(Control1102755024; "HR Company Activities Factbox")
            {
                ApplicationArea = Basic;
                SubPageLink = Code = FIELD(Code);
            }

            systempart(Control26; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control25; Notes)
            {
                ApplicationArea = Basic;
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Doc. Attachment List Factbox")
            {
                ApplicationArea = basic;
                Caption = 'Attachments';
            }

        }

    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Notify Participants")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Acitivity Description");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("End Date");
                        Rec.TestField(Venue);
                        Rec.TestField("Email Message");
                        Rec.TestField("Activity Status", Rec."Activity Status"::Planning);

                        HRActPart.Reset;
                        HRActPart.SetRange(HRActPart."Document No.", Rec.Code);
                        if HRActPart.Find('-') then begin
                            //Check if lines filled
                            if HRActPart.Count = 0 then Error('Please suggest participants on Lines');
                            repeat

                            // IF rec.Status = rec.Status::New THEN
                            //     ERROR('You Cannot notify a participant when the application is not approved');

                            //  SMTP.CreateMessage(HRActPart."Participant E-Mail", HRActPart."Participant E-Mail",
                            //     rec."Acitivity Description", 'Dear' + ' ' + HRActPart."Participant Name", 'You are hereby notified that the above mentioned subject will he held on,' + Format(rec.Date) + '  ' + 'at' + rec.Venue + '. ' + 'Please plan to attend', true);
                            // SMTP.Send;
                            until HRActPart.Next = 0;
                            Message(HRActPart."Participant E-Mail");
                            Message('notified')

                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Rec."Activity Status" <> Rec."Activity Status"::Complete then
                            Error('You can only close an event after it is complete');

                        Rec.Closed := true;
                        Rec.Modify;
                        Message('Event :: %1 :: has been marked as Closed', Rec."Acitivity Description");
                        CurrPage.CLOSE;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.Closed := false;
                        Rec.Modify;
                        Message('Event :: %1 :: has been Re-Opened', Rec."Acitivity Description");
                        //CurrPage.CLOSE;
                    end;
                }
                // action(Print)
                // {
                //     ApplicationArea = Basic;
                //     Image = PrintForm;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         HRCompAct.Reset;
                //         HRCompAct.SetRange(HRCompAct.Code, Rec.Code);
                //         if HRCompAct.Find('-') then
                //             REPORT.Run(52185515, true, true, HRCompAct);
                //     end;
                // }
                action("Get Participants")
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Closed, false);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);
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
                                HRActivityApprovalEntry.Participant := HREmp."No.";
                                HRActivityApprovalEntry."Participant Name" := HREmp."Full Name";
                                HRActivityApprovalEntry."Participant E-Mail" := HREmp."Company E-Mail";
                                HRActivityApprovalEntry."Document No." := Rec.Code;
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry.Participant);
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }

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
                action("Defer")
                {
                    ApplicationArea = All;
                    Caption = 'Defer';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.TestField(Comments);
                        Rec.Status := Rec.Status::Deferred;
                        MESSAGE('Record Deferred');
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
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category9;
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
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category9;
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
                    PromotedCategory = Category9;
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
                    PromotedCategory = Category9;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }

                action("Training Costs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruitment Costs';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Recruitment Costs";
                    RunPageLink = "Training ID" = FIELD(Code);
                }
                action("Mark as Ongoing")
                {
                    ApplicationArea = Basic;
                    Image = Start;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec."Activity Status" := Rec."Activity Status"::"On going";
                        Rec.Modify;
                    end;
                }
                action("Mark as Complete")
                {
                    ApplicationArea = Basic;
                    Image = Completed;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec."Activity Status" := Rec."Activity Status"::Complete;
                        //ERROR('Can ')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        // UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        Text001: Label 'All Participants have been notified via E-Mail';
        HRCompAct: Record "HR Company Activities";
        HRActPart: Record "HR Activity Participants";
        HRActivityApprovalEntry: Record "HR Activity Participants";
        HREmp: Record "HR Employees";

        SMTP: Codeunit EmailCodeunit;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
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
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
        end;



    end;

    var
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

}

