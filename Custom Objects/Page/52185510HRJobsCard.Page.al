page 52185510 "HR Jobs Card"
{
    PageType = Card;
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Job Succession, ,,Approvals';
    SourceTable = "HR Jobs";
    SourceTableView = WHERE("Job Type" = CONST(Jobs));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = False;

                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Importance = Promoted;
                    Editable = Inst;
                }
                group(Control17)
                {
                    ShowCaption = false;
                    grid(Control16)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control15)
                        {
                            ShowCaption = false;
                            field("Position Reporting to"; Rec."Position Reporting to")
                            {
                                ApplicationArea = Basic;
                                Importance = Promoted;
                                Editable = CurrCode;

                            }
                            field("Position Reporting Name"; Rec."Position Reporting Name")
                            {
                                ApplicationArea = Basic;
                                //ShowCaption = false;
                                Editable = DepType;
                            }
                        }
                    }
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Editable = RespCenter;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Editable = Rmks;
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                group(Control33)
                {
                    ShowCaption = false;
                    grid(Control31)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control30)
                        {
                            ShowCaption = false;
                            field("Responsibility Center"; Rec."Responsibility Center")
                            {
                                ApplicationArea = Basic;

                                Enabled = true;
                                HideValue = false;
                                ShowCaption = true;
                                Visible = true;
                                Editable = pType;
                            }
                            field("Responsibility Center Name"; Rec."Responsibility Center Name")
                            {
                                ApplicationArea = Basic;
                                Editable = false;
                            }
                        }
                    }
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                }
                field("Current Approval Level"; Rec."Current Approval Level")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Level';
                    Importance = Additional;
                }
                field("Pending At"; Rec."Pending At")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending At';
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = Rec.Status = Rec.Status::"Pending Approval";
                }
                field(UserID; Rec.UserID)
                {

                }
                field(Competences; Rec.Competences)
                {
                    ApplicationArea = Basic;
                    Editable = Mmarketpage;
                    //ValuesAllowed=  ,"customer focus", integrity, Professionalism, transparency ,accountability, teamwork, creativity,  innovation;

                }
                field("Marked for Succession"; Rec."Marked for Succession")
                {
                    ApplicationArea = Basic;
                }
                field("Advertisement Date"; Rec."Advertisemnt Date")
                {
                    Caption = 'Advertisement Date';

                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                group(Control29)
                {
                    ShowCaption = false;
                    grid(Control10)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control9)
                        {
                            ShowCaption = false;
                            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                                Editable = Intrate;
                            }
                            field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                                Editable = False;
                            }
                        }
                    }
                }
                group(Control6)
                {
                    ShowCaption = false;
                    grid(Control5)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control4)
                        {
                            ShowCaption = false;
                            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                                Editable = Dimension;
                            }
                            field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                                Editable = false;
                            }
                            field(Comments; Rec.Comments)
                            {

                            }
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job Description" = FIELD("Job ID");
                ApplicationArea = All;
            }
            systempart(Control1102755006; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
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
                // action(Comment)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     RunObject = Page "Approval Comments";
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                // }
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

                        // Rec.TestField("Position Reporting to");
                        //TESTFIELD("Responsibility Center");
                        Rec.TestField("No of Posts");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");


                        Rec.CalcFields("No. of Requirements");
                        if Rec."No. of Requirements" = 0 then Error('Please Specify the Job Requirements');
                        Rec.CalcFields("No. of Responsibilities");

                        if Rec."No. of Responsibilities" = 0 then Error('Please Specify the Job Responsibilities');


                        VarVariant := Rec;




                        // Rec.Status := Rec.Status::Approved;
                        // Rec.MODIFY;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        //MESSAGE('Job Approved and now can be occupied')
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
                        GlobalFunctions: Codeunit "Global Functions";
                    begin

                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        
                        //VALIDATE COMMENTS EXIST BEFORE REJECTION
                        GlobalFunctions.CommentsManagement(Rec."Job ID");

                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            group(Job)
            {
                action("Job Requirements")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
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
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Mark for Succession")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark for Succession';
                    Image = Check;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Approved then begin
                            Rec."Marked for Succession" := true;
                            Rec.Modify;
                        end;
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
                        Message('Sets the status of job to open');

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
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
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Job ID");
                    RunPageView = where(Types = CONST(comment));
                }
                // action("Board Minutes[case 360 Docs]")
                // {
                //     ApplicationArea = Basic;
                //     Image = Document;
                //     Promoted = true;
                //     PromotedCategory = New;

                //     trigger OnAction()
                //     begin
                //         Message('Opens ed from browser if any doc for board mins is available');
                //         DMS.Reset;
                //         DMS.SetRange(DMS.Key, DMS.Key::"Board Minutes");
                //         if DMS.Find('-') then begin
                //             HyperLink(DMS."url path" + Rec."Job ID");
                //         end;
                //     end;
                // }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.UserID := UserId;
        usersetup.reset();
        usersetup.SetRange("User ID", UserId);
        IF usersetup.FindFirst() then begin
            //rec."Global Dimension 1 Code":=usersetup."Global Dimension 1 Code";
            //rec."Global Dimension 2 Code":=usersetup."Global Dimension 2 Code";
            //rec."Responsibility Center":=usersetup."Responsibility Centre";



        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;
        SetControlAppearance;
        rec.CalcFields("Occupied Positions");
        rec."Vacant Positions" := rec."No of Posts" - rec."Occupied Positions";
        
        //UPDATE PENDING AT FIELD
        rec.UpdatePendingAtField();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;

        //  OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //  OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        Rec.Validate("Vacant Positions");
        
        //UPDATE PENDING AT FIELD
        rec.UpdatePendingAtField();
    end;

    trigger OnOpenPage()
    begin

        UpdateControls;

    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

    end;

    var
        HREmployees: Record "HR Employees";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit2";

        PageEditable: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        DMS: Record EDMS;
        usersetup: record "User Setup";

    //[Scope('OnPrem')]
    procedure RecordLinkCheck(job: Record "HR Jobs") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;

    local procedure UpdateControls()
    begin
        if rec.Status <> rec.Status::Open then
            CurrPage.EDITABLE := false;


        if Rec.Status = Rec.Status::Open then begin
            InvTcode := true;
            Inst := true;
            DepType := false;
            IntMode := false;
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

