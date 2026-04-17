page 52185535 "HR Employee Requisition Card"
{
    // DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Requisition, , , ,Approvals';
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Importance = Promoted;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Completion Status"; Rec."Completion Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                // ADDED FIELD FOR RECRUITMENT COST TRACKING
                field(TotalRecruitmentCost; Rec."Total Recruitment Cost")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recruitment Cost';
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Total cost incurred for this recruitment process';
                }
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755020; Outlook)
            {
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
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;
                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Requisition No.");
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
                    begin
                        //TESTFIELD("No of Posts");
                        /*TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");*/
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        // Rec."Approval Status" := Rec."Approval Status"::Approved;
                        // Rec.MODIFY;
                        //MESSAGE('Employee requisition Approved Now the job can be advertised');


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
            }
            group(Requisition)
            {
                Caption = 'Requisition';
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines(RO)";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Advertise (Internal Staff)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Advertise (Internal Staff)';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin

                        Rec.TestField(Rec."Approval Status", "Approval Status"::Approved);
                        Message('Employees are notified through email about the job');

                        if Rec."Requisition Type" = Rec."Requisition Type"::External then Error('Requisition Type must be "Internal" or "Both"');

                        if Confirm(Text0001, false, Rec."Job ID", Rec."Job Description") = false then exit;

                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.Find('-') then begin
                            repeat
                                HREmp.TestField(HREmp."Company E-Mail");
                                //Check if SMTP mail setup is done
                                //SMTPMailSetup.Get;

                                userset.reset;
                                userset.SetRange("User ID", HREmp."User ID");
                                if userset.Find('-') then begin
                                    usermail := userset."E-Mail";
                                    username := userset."Full Name";
                                    msg := 'Were excited to announce an internal job opening for the position of%1-%2. This is a fantastic chance to grow your career within our company!If you are interested, please send your resume and a brief cover letter.';
                                    Subject := 'Job Adverisement for' + ' ' + Format(Rec."Job ID") + ' ' + Format(rec."Job Description");
                                    EmailMsg.Create(usermail, subject, msg, true);
                                    EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                    Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                end;
                            until HREmp.Next = 0;
                            Message('[%1] Employees have been notified about this vacancy', HREmp.Count);
                        end else begin
                            Error('No E-Mail Parameters have been setup for Internal Vacany  notifications');
                        end;
                    end;

                }
                action("Close Requisition")
                {
                    ApplicationArea = Basic;
                    Enabled = CloseReq;
                    Image = Close;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Message('Requisition Closed/ Finnish the requisition process');
                        Rec.Closed := true;
                        Rec."Completion Status" := Rec."Completion Status"::Closed;
                        Rec.Modify;
                    end;
                }
                action("Job Interview details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Interview details';
                    Enabled = false;
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Applicant No" = FIELD("Job ID");
                }
                // ADDED ACTION FOR RECRUITMENT COST TRACKING
                action("Recruitment Costs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruitment Costs';
                    Image = Cost;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Recruitment Costs";
                    RunPageLink = "Requisition No." = FIELD("Requisition No.");
                    ToolTip = 'Track all costs associated with this recruitment process';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls;
        // CALCULATE RECRUITMENT COST FLOWFIELD
        Rec.CalcFields(Rec."Total Recruitment Cost");
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        if Rec."Approval Status" <> Rec."Approval Status"::Approved
          then
            CloseReq := false else
            CloseReq := true
    end;

    var
        //// //ApprovalEntries: Page "Approval Entries";
        HREmpReq: Record "HR Employee Requisitions";
        //SMTP: Codeunit "SMTP Mail";
        HRSetup: Record "HR Setup";
        CTEXTURL: Text[30];
        HREmp: Record "HR Employees";
        HREmailParam: Record "HR E-Mail Parameters";
        ContractDesc: Text[30];
        HRLookupValues: Record "HR Lookup Values";
        DimValue: Record "Dimension Value";
        objEmp: Record "HR Employees";
        Text0001: Label 'Do you want to advertise Job Position [ %1  - %2 ] to Internal Staff ?';
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //SMTPMailSetup: Record "SMTP Mail Setup";
        HRCodeunit: Codeunit "HR Codeunit2";
        Text0002: Label 'Job position ';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        email: codeunit Email;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        CloseReq: Boolean;
        userset: Record "User Setup";
        msg: text;
        subject: text;
        usermail: Text;
        username: text;
        emailbody: Label 'Dear <b>%1</b>, <br> <h>';
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];


    local procedure UpdateControls()
    begin
        CurrPage.Editable := HRCodeunit.fn_UpdateControls(Format(Rec."Approval Status"));
    end;
}

