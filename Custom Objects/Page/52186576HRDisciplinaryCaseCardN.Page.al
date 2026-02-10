page 52186576 "HR Disciplinary Case Card N"
{
    Caption = 'Open Disciplinary Cases';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show,,,Approvals';
    SourceTable = "HR Disciplinary Cases NCA";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Accused Employee Name"; Rec."Accused Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Head of Department"; Rec."Head of Department")
                {
                    ApplicationArea = Basic;
                }
                field("Head of Department Name"; Rec."Head of Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Type Complaint"; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Severity Of the Complain"; Rec."Severity Of the Complain")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint was Reported"; Rec."Date of Complaint was Reported")
                {
                    ApplicationArea = Basic;
                }
                field("Accussed By"; Rec."Accussed By")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field("Reporter Name"; Rec."Reporter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Non Employee Reporter"; Rec."Non Employee Reporter")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1 Name"; Rec."Witness #1 Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #2  Name"; Rec."Witness #2  Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date To Discuss Case"; Rec."Date To Discuss Case")
                {
                    ApplicationArea = Basic;
                }
                FIELD(Duration; Rec.Duration)
                {

                }
                field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling Name"; Rec."Body Handling Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                // field("Policy Guidlines In Effect"; Rec."Policy Guidlines In Effect")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Policy Description"; Rec."Policy Description")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                    multiline = true;

                    Editable = RecommendedActionEditable;
                }
                // field("Recommended Action Description"; Rec."Recommended Action Description")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Stage Status"; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                }
                field(Discussed; Rec.Discussed)
                {

                }
            }
            group("Action Information")
            {
                Caption = 'Action Information';
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Taken Action Description"; Rec."Taken Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    MultiLine = true;
                }
                field("n jj"; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Review Findings"; Rec."Review Findings")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Action Duration Start Date"; Rec."Action Duration Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Action Duration End  Date"; Rec."Action Duration End  Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interdict Employee"; Rec."Interdict Employee")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Appeal Information")
            {
                Caption = 'Appeal Information';
                field(Appealed; Rec.Appealed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appeal Finding"; Rec."Appeal Finding")
                {
                    ApplicationArea = Basic;
                }
                field("Appeal Date"; Rec."Appeal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Appeal Decision"; Rec."Appeal Decision")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Court Information")
            {
                Caption = 'Court Information';
                field("Court Decision"; Rec."Court Decision")
                {
                    ApplicationArea = Basic;
                }
                field("Court Decision Date"; Rec."Court Decision Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Case Forwarding")
            {
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }

            }
        }
        area(factboxes)
        {
            part("HR Disciplinary Cases Factbox"; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = FIELD("Case Number");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"HR Disciplinary Cases NCA"),
                              "No." = field("Case Number");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Case Number");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // Visible = SendCaseVisible;

                    trigger OnAction()
                    var
                    begin
                        if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."Case Number");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to send this case?') then exit;
                        // Rec."Originator Status" := Rec."Originator Status"::Sent;
                        // Rec."Recepient Status" := Rec."Recepient Status"::New;
                        Rec."Current Departmrnt" := Rec."Send/Forward to";

                        // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        //     Rec."Originator Status" := Rec."Originator Status"::Returned;
                        //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                        // end;
                        CFPage.InsertTracker(Rec."Case Number", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                        Rec.Modify();
                        Message('Case sent successfully');
                    end;
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("Case Number");
                }
            }


            group("Case Status")
            {
                action("Under Investigation")
                {
                    Caption = 'Under Investigation';
                    ApplicationArea = Basic, Suite;
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."Disciplinary Stage Status"::Reported);
                        Rec.TestField("Accused Employee");
                        Rec.TestField("Description of Complaint");
                        Rec.TestField("Date of Complaint was Reported");
                        Rec.TestField("Date To Discuss Case");
                        Rec.TestField("Witness #1");

                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Under Investigation";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;
                    end;
                }
                action("In Progress")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.TestField("Disciplinary Stage Status", Rec."Disciplinary Stage Status"::"Under Investigation");



                        if Confirm('Are you sure you want to mark this case as "In Progress"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"In progress";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;
                    end;
                }
                action(Close)
                {
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        // Rec.TestField("Recommended Action");
                        // Rec.TestField(Comments);
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."Accused Employee");
                        if HREmp.Find('-') then begin
                            HREmp."Disciplinary Case" := Rec."Case Number";
                            HREmp."Disciplinary Duration" := Rec.Duration;
                            HREmp."Action Taken" := Rec."Action Taken";
                            HREmp."Hearing Date" := Rec."Court Decision Date";
                            HREmp."Date Reported" := Rec."Date of Complaint was Reported";
                            HREmp.Nature := rec."Type Complaint";
                            HREmp.Modify(True);

                            if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                                Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Closed;
                                Rec.Modify;
                                Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                            end;
                        end;
                    end;
                }
                action(Print)
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        DiscCase.Reset;
                        DiscCase.SetRange(DiscCase."Case Number", Rec."Case Number");
                        //if DiscCase.Find('-') then
                        //REPORT.Run(REPORT::"HR Disciplinary Cases", true, true, DiscCase);
                    end;
                }
                action(Appeal)
                {
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin

                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec.Appealed = true then begin
                            Error('A case can only be Appealed once');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Under review";
                            Rec.Appealed := true;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
                action("Withdraw Case")
                {
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Withdrawn;
                        Rec.Modify
                    end;
                }
                action("Sent Case to Court")
                {
                    Caption = 'Sent Case to Court';
                    Image = Status;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."Disciplinary Stage Status"::Closed);

                        if Rec.Appealed <> true then begin
                            Error('A case can only be sent to  court after one appeal');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"court case" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"closed by court" then exit;



                        if Confirm('Are you sure you want to sent this case to court?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"court case";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as closed by court', Rec."Case Number");
                        end;
                    end;
                }
                action("Court Close")
                {
                    Caption = 'Court Close';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."Disciplinary Stage Status"::"court case");

                        if Rec.Appealed <> true then begin
                            Error(Text00002);
                        end;
                        if Rec."Court Decision" = '' then
                            Error(Text00001);
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm(Text00003) then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"closed by court";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as closed by court', Rec."Case Number");
                        end;
                    end;
                }
                action("Post to Payroll")
                {
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin

                        /* //MESSAGE('yes');
                    IF Status=Status::Approved THEN BEGIN
                      IF ("Disciplinary Stage Status"="Disciplinary Stage Status"::Closed)
                        OR ("Disciplinary Stage Status"="Disciplinary Stage Status"::"closed by court") THEN
                        BEGIN
                          salCard.RESET;
                          salCard.SETRANGE(salCard."Employee Code", "Accused Employee");
                          IF salCard.FIND('-') THEN BEGIN
                            salCard."Suspend Pay":=TRUE;
                            salCard."Suspension Date":=TODAY;
                            salCard."Suspension Reasons":="Type Complaint";
                            salCard.MODIFY;
                            END;
                        END;
                    END;
                    */

                        if Rec."Interdict Employee" = true then
                            Question := 'Are you sure you want to post this to payroll?';
                        Answer := DIALOG.Confirm(Question, false);
                        if Answer = true then begin
                            salCard.Reset;
                            salCard.SetRange(salCard."Employee Code", Rec."Accused Employee");
                            if salCard.Find('-') then begin
                                salCard."Basic Pay" := salCard."Basic Pay" / 2;
                                //ERROR(FORMAT(salCard."Basic Pay"));
                                salCard.Modify

                            end
                        end

                    end;
                }
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
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
                action("Reopen Job Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen Disciplinary Card';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category9;


                    trigger OnAction()
                    begin
                        Message('Sets the status of job to open');

                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }

                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        if rec."Action Duration End  Date" <> 0D then begin
            LastDay := CalcDate('-2w', rec."Action Duration End  Date");
            if LastDay = Today then message('Case Will be closed in two weeks');
        end;
    end;



    var
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;
        DiscCase: Record "HR Disciplinary Cases NCA";
        Text00001: Label 'Please specify the decision of the court before case  closure';
        Text00002: Label 'A case can only be closed by court if its not in court';
        Text00003: Label 'Are you sure you want to mark this case as closed by Court?';
        salCard: Record "PR Salary Card";
        HREmp: Record "HR Employees";
        Answer: Boolean;
        Question: Text[250];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        LastDay: date;


    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        /*
        IF DiscCase.Status=DiscCase.Status::New THEN
        BEGIN
          RecommendedActionEditable:=FALSE;
          ActionTakenEditable:=FALSE;
          DisciplinaryRemarksEditable:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::Approved  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::"Pending Approval"  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        */

    end;
}

