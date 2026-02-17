page 52187118 "MKey Page"
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "MKey Forwarding";
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals';
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralTabEditable;
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field(Instructions; Rec.Instructions)
                {
                    MultiLine = true;
                }
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }

                field("Total Issues"; Rec."Total Issues")
                {
                    Editable = false;
                }

                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }
                field("Originating Status"; Rec."Originating Status")
                {
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Recepient Status"; Rec."Recepient Status")
                {
                    Editable = false;
                }
                field("Case Closed"; Rec."Case Closed")
                {
                    Editable = false;
                }
                field("Viewed By Recepient"; Rec."Viewed By Recepient")
                {
                    Editable = false;
                }
                field("Case Closed At"; Rec."Case Closed At")
                {
                    Editable = false;
                }
                field("Case Closed By"; Rec."Case Closed By")
                {
                    Editable = false;
                }
                field("Sent At"; Rec."Sent At")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }

            }

            part("MKey Lines"; "MKey Lines")
            {
                Editable = LinesTabEditable;
                SubPageLink = "Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(Creation)
        {
          

        }

        area(processing)
        {
            group(MkeyProcesessing)
            {
                Caption = 'Case Details';

                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
                action("Case History")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;


                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(History));
                }
                action("Recall this Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    Visible = RecallVisible;
                    trigger OnAction()
                    var
                        myInt: Integer;
                        CaseTracker: Record "CF Tracker";
                    begin
                        if not Confirm('Are you sure you want to recall this case?') then exit;
                        Rec.CalcFields("Viewed By Recepient");
                        if not Rec."Viewed By Recepient" then begin
                            CaseTracker.Reset();
                            CaseTracker.SetRange("Header No.", Rec."No.");
                            if CaseTracker.FindLast() then
                                CaseTracker.Delete();

                            CaseTracker.Reset();
                            CaseTracker.SetRange("Header No.", Rec."No.");
                            if CaseTracker.FindLast() then begin
                                CaseTracker."Current Department" := true;
                                CaseTracker.Modify();
                            end;

                            Rec."Current Departmrnt" := Rec."Originating Department";
                            Rec."Originating Status" := Rec."Originating Status"::New;
                            Rec.Modify();

                        end else
                            Error('This case has already been viewed by the receipient');


                        Message('Case recalled successfully');
                    end;

                }

            }
            group(Workflows)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = SendApprovalVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        if not Confirm('Are you sure you want to reject this request?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
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
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        CurrPage.Update();
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
                // action(Deffer)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Deffer Application';
                //     Image = ReOpen;
                //     // Visible = DeferVisible;

                //     trigger OnAction()
                //     var

                //     begin

                //         GlobalFunctions.CommentsManagement(Rec."No.");
                //         if not Rec."Case Closed" then begin
                //             if not Confirm('Are you sure you want to deffer this record?') then exit;
                //             GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                //             Rec.Status := Rec.Status::Deffered;
                //             Rec.Validate(Status);
                //             Rec.Modify();
                //             Message('Record deffered succsessfully');
                //         end else
                //             Error('You cannot deffer a posted record');
                //     end;
                // }
                // action(Archive)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Archive Application';
                //     Image = Archive;
                //     // Visible = DeferVisible;

                //     trigger OnAction()
                //     var

                //     begin

                //         GlobalFunctions.CommentsManagement(Rec."No.");
                //         if not Rec."Case Closed" then begin
                //             if not Confirm('Are you sure you want to archive this record?') then exit;
                //             GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                //             Rec.Status := Rec.Status::Archived;
                //             Rec.Validate(Status);
                //             Rec.Modify();
                //             Message('Record archive succsessfully');
                //         end else
                //             Error('You cannot archive a posted record');
                //     end;
                // }

                // group(TaskAssignment)
                // {
                //     Caption = 'Assign Task';
                //     action(AssinedUser)
                //     {
                //         ApplicationArea = all;
                //         Image = Task;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         RunObject = Page "User Tasks";
                //         RunPageLink = "Record ID" = FIELD("No.");
                //         Caption = 'User Assigned';
                //     }
                // }
            }
              action("Import MKey Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = xmlport "Mkey Lines";
                Visible = CloseCaseVisible;
            }
            action("Send Case")
            {
                ApplicationArea = Basic, Suite;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = SendCaseVisible;

                trigger OnAction()
                var
                begin
                    MkeyLines.Reset();
                    MkeyLines.SetRange("Header No.", Rec."No.");
                    if MkeyLines.Find('-') then begin
                        repeat
                            if MkeyLines."Member No. " = '' then Error('One of the MKey lines does not have member number');
                            if MkeyLines."Old Employer Code" = '' then Error('One of the MKey lines does not have Old Employer code');
                            if MkeyLines."Old Payroll Number" = '' then Error('One of the MKey lines does not have Old Payroll Number');
                            if MkeyLines."New Employer Code" = '' then Error('One of the MKey lines does not have New Employer Code');
                            if MkeyLines."New Payroll Number" = '' then Error('One of the MKey lines does not have New Payroll Number');
                        until MkeyLines.Next() = 0;
                    end;

                    if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                    Comments.Reset();
                    Comments.SetRange("Header No.", Rec."No.");
                    if Comments.FindLast() then begin
                        ;
                        if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                        if Comments.Comment = '' then Error('Kindly leave a comment');
                    end else
                        Error('Kindly add a comment');
                    if not Confirm('Are you sure you want to send this case?') then exit;
                    Rec."Originating Status" := Rec."Originating Status"::Sent;
                    Rec."Recepient Status" := Rec."Recepient Status"::New;
                    Rec."Current Departmrnt" := Rec."Send/Forward to";

                    if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        Rec."Originating Status" := Rec."Originating Status"::Returned;
                        Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                    end;
                    CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                    Rec."Sent At" := CurrentDateTime;
                    Rec."Sent By" := UserId;
                    Rec.Modify();
                    Message('Case sent successfully');
                end;
            }
            action("Close this Case")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Case';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = CloseCaseVisible;

                trigger OnAction()
                var
                    DMUCFLines: Record "DMU Case Forwarding Lines";
                begin
                    if not Confirm('Are you sure you want to mark these cases as actioned?') then exit;
                    CloseAll();
                    Rec."Case Closed" := true;
                    Rec.Modify();
                    Message('Case closed successfully');
                end;
            }



        }
    }

    trigger OnOpenPage()
    var
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");

            if Rec."Current Departmrnt" = UserSetUp."Responsibility Centre" then begin
                if Rec."Originating Status" <> Rec."Originating Status"::New then begin
                    CaseTracker.Reset();
                    CaseTracker.SetRange("Header No.", Rec."No.");
                    if CaseTracker.FindLast() then begin
                        CaseTracker."Viewed By Recepient" := true;
                        CaseTracker.Modify();
                    end;
                end;
            end;
        end else
            Error('You must be set up in user setup');

        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        SetControlAppearance();
    end;



    procedure InsertHistory()
    var
        Comments: Record Comments;
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin

            Comments.Init();
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            Comments."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            Comments."Responsibility Center" := UserSetUp."Responsibility Centre";
            Comments."Header No." := Rec."No.";
            Comments.Types := Comments.Types::History;
            Comments.Insert(true);
        end;

    end;


    procedure InsertTracker(HeaderNo: Code[30]; AtDept: Code[30]; IsCurrDept: Boolean; ForwardedBy: Code[100]; TimeForwarded: DateTime)
    begin
        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        if CaseTracker.FindLast() then begin
            CaseTracker."Current Department" := false;
            CaseTracker.Modify();
        end;

        Clear(CaseTracker);

        CaseTracker.Init();
        CaseTracker."Header No." := HeaderNo;
        CaseTracker."At Department" := AtDept;
        CaseTracker."Current Department" := IsCurrDept;
        CaseTracker."Forwarded By" := ForwardedBy;
        CaseTracker."Time Forwarded" := TimeForwarded;
        CaseTracker.Insert(true);
    end;

    procedure GetPreviousResponsibilityCenter(HeaderNo: Code[30]): Code[50]
    begin

        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        if CaseTracker.Find('-') then
            if CaseTracker.Count = 1 then Error('This case has to move at least once');

        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        CaseTracker.SetRange("Current Department", false);
        if CaseTracker.FindLast() then begin
            exit(CaseTracker."At Department");
        end;


    end;

    procedure CloseAll()
    var
    begin
        DMUCFLines.Reset();
        DMUCFLines.SetRange("Header No.", Rec."No.");
        if DMUCFLines.FindSet() then begin
            DMUCFLines.ModifyAll(Closed, true);
        end;
    end;

    procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        OpenApprovalEntriesExistForCurrUser := true;
        OpenApprovalEntriesExist := true;


        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            CurrentUsersDept := UserSetUp."Responsibility Centre";
        end else
            Error('You must be set up in user setup');

        GeneralTabEditable := true;
        LinesTabEditable := true;

        SendCaseVisible := true;
        CloseCaseVisible := true;
        ActionCaseVisible := true;

        RecallVisible := true;

        EmployerCodeEditable := true;
        RunSasraandFallOffVisible := true;

        PeriodEditable := true;
        PeriodNameEditable := true;

        CaseInstructionEditable := true;

        if Rec."Current Departmrnt" <> '' then begin
            Rec.CalcFields("Viewed By Recepient");

            if CurrentUsersDept <> Rec."Current Departmrnt" then begin
                SendCaseVisible := false;
                CloseCaseVisible := false;
                ActionCaseVisible := false;
            end;

            if Rec."Originating Status" = Rec."Originating Status"::New then begin
                CloseCaseVisible := false;
                ActionCaseVisible := false;
            end;

            if CurrentUsersDept <> Rec."Originating Department" then begin
                RecallVisible := false;
                CaseInstructionEditable := false;
                PeriodEditable := false;
            end;

            if Rec."Viewed By Recepient" then
                RecallVisible := false;

            if Rec."Originating Status" = Rec."Originating Status"::New then
                RecallVisible := false;

            if CurrentUsersDept <> Rec."Current Departmrnt" then begin
                GeneralTabEditable := false;
                LinesTabEditable := false;
            end else begin
                if Rec."Case Closed" then begin
                    GeneralTabEditable := false;
                    LinesTabEditable := false;
                end;
            end;

            if CurrentUsersDept <> Rec."Originating Department" then
                RunSasraandFallOffVisible := false;

            CFStations.Reset();
            CFStations.SetRange(Department, CurrentUsersDept);
            CFStations.SetRange("Allowed Action", CFStations."Allowed Action"::"Can Edit Employer Code");
            if CFStations.FindFirst() then begin
                if CurrentUsersDept <> Rec."Originating Department" then
                    EmployerCodeEditable := false;
            end else
                EmployerCodeEditable := false;

            if Rec.Status = Rec.Status::Open then
                SendApprovalVisible := true;

            if  rec.Status <> rec.Status :: Open then begin
               NewRecord:=false;
            end;

        end;
    end;



    var
        UserSetUp: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        DMUCFLines: Record "DMU Case Forwarding Lines";
        GlobalFunctions: Codeunit "Global Functions";
        MkeyLines: Record "MKey Lines";
        GeneralTabEditable: Boolean;
        LinesTabEditable: Boolean;
        SendCaseVisible: Boolean;
        RecallVisible: Boolean;
        CurrentUsersDept: Code[30];
        EmployerCodeEditable: Boolean;

        RunSasraandFallOffVisible: Boolean;
        CloseCaseVisible: Boolean;
        ActionCaseVisible: Boolean;
        PeriodEditable: Boolean;
        PeriodNameEditable: Boolean;
        CaseInstructionEditable: Boolean;
        //Workflows
        SendApprovalVisible: Boolean;
        ReopenVisible: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

        NewRecord: Boolean;
}
