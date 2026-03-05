page 52186427 "Collateral Collection Card"
{
    DeleteAllowed = false;
    PageType = Card;
    Caption = 'Collateral Discharge';
    SourceTable = "Securities Collection Register";
    PromotedActionCategories = 'New,Home, Process, Approvals, Documents, Forwarding, Templates, Discharge, Communication';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Name"; Rec."Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Type Name"; Rec."Loan Type Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Document Attachment"; Rec."Document Attachments")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Reviewed By Legal Department"; Rec."Reviewed By Legal Department")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                        if Confirm('Are you sure you want to review this document?') then begin
                            //if Rec."Current Department" <> 'Legal' then Error('You can only review this document from the Legal Department');
                            Rec."Reviewed By Legal Department" := true;
                            Rec."Reviewed By" := UserId;
                            Rec.Modify();
                        end;
                    end;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
                field("Created At"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Resposibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field(Discharged; Rec.Discharged)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("EMail Sent"; Rec."EMail Sent")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
            // part("Collateral Lines"; "Perfection Lines")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Loan Collaterals';
            //     SubPageLink = "Loan No." = field("Loan No.");
            //     Editable = false;
            // }
            // part("Loan Collaterals"; "Loan Collaterals")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Loan Collaterals';
            //     SubPageLink = "Loan No" = field("Loan No.");
            //     Editable = false;
            // }
            // Part("Registered Securities"; "Collateral Register - List")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Security Perfection Lines';
            //     SubPageLink = "Loan No." = field("Loan No.");
            //     Editable = false;
            // }
            part("Perfection Lines"; "Perfection Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Collateral Discharge Lines';
                SubPageLink = "Loan No." = field("Loan No.");
                Editable = false;
            }
            group("Case Forwarding")
            {
                Editable = ForwardingEditable;
                field("Send/Forward to"; Rec."Send/Forward to")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Current Department"; Rec."Current Department")
                {
                    Caption = 'Current Department';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("Discharge Date")
            {
                Editable = ForwardingEditable;
                field("Date of Internal Discharge"; Rec."Date of Internal Discharge")
                {
                    Caption = 'Date of Internal Discharge';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Discharged By"; Rec."Discharged By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date of External Discharge"; Rec."Date of External Discharge")
                {
                    Caption = 'Date of External Discharge';
                    ApplicationArea = Basic, Suite;
                }
                field("Concatenated Property"; Rec."Concatenated Property")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                    MultiLine = true;
                }

            }
            field("SMS Body"; RichText)
            {
                ApplicationArea = Basic, Suite;
                Editable = true;
                MultiLine = true;
                ExtendedDataType = RichContent;
                trigger OnValidate()
                begin
                    Rec.SaveRichText(RichText);
                end;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52185843), "No." = field("No.");//52186080
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TestField("Loan No.");
                    Rec.TestField("Document Attachments");
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = True;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page 658;
                    approvalsMgmt: Codeunit 1535;
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category6;
                    // Visible = SendCaseVisible;

                    trigger OnAction()
                    var
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to send this case?') then exit;
                        // Rec."Originator Status" := Rec."Originator Status"::Sent;
                        // Rec."Recepient Status" := Rec."Recepient Status"::New;
                        Rec."Current Department" := Rec."Send/Forward to";

                        // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        //     Rec."Originator Status" := Rec."Originator Status"::Returned;
                        //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                        // end;
                        CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                        Rec.Modify();
                        Message('Case sent successfully');
                    end;
                }

                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot return this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to return this document?') then exit;
                        if Rec."Originating Department" = Rec."Send/Forward to" then begin
                            // Rec."Originator Status" := Rec."Originator Status"::Returned;
                            // Rec."Recepient Status" := Rec."Recepient Status"::Returned;

                            CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                            Rec."Current Department" := Rec."Send/Forward to";
                            Rec.Modify();
                            Message('Case sent successfully');
                        end
                        else begin
                            Error('You Can Only Return to the Originating Department!');
                        end;
                    end;
                }

                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }
            group(Discharge)
            {
                action("Discharge Collateral")
                {
                    ApplicationArea = All;
                    Caption = 'Discharge Collateral';
                    Promoted = true;
                    Image = Post;
                    PromotedCategory = Category8;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        Rec.TestField("Date of External Discharge");
                        //Rec.TestField(Rec.Status, Rec.Status::Approved);
                        if Rec.Status <> Rec.Status::Approved then
                            Error('You cannot discharge a collateral that is not approved')
                        else
                            if not Confirm('Are you sure you want to discharge this collateral?') then exit;
                        SecurtitiesRegister.Reset();
                        SecurtitiesRegister.SETRANGE("Loan No.", Rec."Loan No.");
                        if SecurtitiesRegister.Find('-') then begin
                            repeat
                                SecurtitiesRegister."Collateral Discharged" := true;
                                SecurtitiesRegister.Modify();
                            until SecurtitiesRegister.Next = 0;

                            PerfectionLines.RESET;
                            PerfectionLines.SETRANGE("Loan No.", Rec."Loan No.");
                            if PerfectionLines.Find('-') then begin
                                repeat
                                    PerfectionLines.Discharged := true;
                                    PerfectionLines.Modify;
                                until PerfectionLines.Next = 0;
                            end;

                            Rec.Discharged := true;
                            Rec."Discharged By" := UserId;
                            Rec."Date of Internal Discharge" := TODAY;
                            Message('Discharge successful!');
                        end;
                    end;
                }
                action("Discharge Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Discharge Templates';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Template;
                    trigger OnAction()
                    begin
                        //Rec.TestField(Status);
                        CollateralCollection.RESET;
                        CollateralCollection.SETRANGE("No.", Rec."No.");
                        if CollateralCollection.Find('-') then begin
                            //Report.Run(Report::"Discharge Template", true, false, SecurtitiesRegister);
                            Report.Run(Report::"Discharge Template", true, false, CollateralCollection);
                        end;
                    end;
                }
                action("Execution Form")
                {
                    ApplicationArea = All;
                    Caption = 'Execution Form';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Template;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        CollateralCollection.RESET;
                        CollateralCollection.SETRANGE("No.", Rec."No.");
                        //SecurityPerfection.SetRange("No.", Rec."Security No.");
                        if CollateralCollection.Find('-') then begin
                            Report.Run(Report::"Execution Form", true, false, CollateralCollection);
                        end;
                    end;
                }
                action("Send SMS")
                {
                    ApplicationArea = All;
                    Caption = 'Send SMS';
                    Promoted = true;
                    PromotedCategory = Category9;
                    Image = Comment;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        Rec.TestField(rec."SMS Sent", false);
                        Rec.TestField(Discharged, true);


                        Members.Reset();
                        Members.SetRange("No.", Rec."Member No.");
                        if Members.Find('-') then begin
                            if Members."Phone No." <> '' then begin
                                if Confirm('Do you want to send an SMS to the Loanee?') then
                                    msg := 'Dear, ' + Rec."Member Name" + ', \This is to formally inform you that the collateral(s)' + ' ' + rec."Concatenated Property" + ' ' + 'for your fully repaid ' + Rec."Loan Type" + ' of Loan Number ' + Rec."Loan No." + ' ' + 'have been discharged and Documents are now available for collection at your nearest branch.';
                                SendSMS.SendSms(Source::"Security Perfection", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Loan No.", 'CBS', Rec."Date of Internal Discharge");
                            end
                            else begin
                                msg := 'Dear, ' + Rec."Member Name" + ', \This is to formally inform you that the collateral(s)' + ' ' + rec."Concatenated Property" + ' ' + 'for your fully repaid ' + Rec."Loan Type" + ' of Loan Number ' + Rec."Loan No." + ' ' + 'have been discharged and Documents are now available for collection at your nearest branch.';
                                SendSMS.SendSms(Source::"Security Perfection", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Loan No.", 'CBS', Rec."Date of Internal Discharge");
                            end;
                            Rec."SMS Sent" := true;
                            Rec.Modify();
                        end;

                    end;

                }
                action("Send Email")
                {
                    ApplicationArea = All;
                    Caption = 'Send E-Mail';
                    Promoted = true;
                    PromotedCategory = Category9;
                    Image = Email;
                    trigger OnAction()
                    var

                        myInt: Integer;
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        Rec.TestField(rec."Email Sent", false);
                        Rec.TestField(Discharged, true);

                        if Confirm('Do you want to send an Email to Lending Units?') then
                            NotificationSetup.RESET;
                        NotificationSetup.SetRange(Notification, NotificationSetup.Notification::"Lending Units", NotificationSetup.Notification::"Legal");
                        NotificationSetup.SetRange("Send Email", true);
                        if NotificationSetup.Find('-') then begin

                            repeat
                                UserSetup.Reset();
                                UserSetup.SetRange("User ID", NotificationSetup."user id");
                                if UserSetup.FindFirst() then begin

                                    msg := 'Dear' + ' ' + NotificationSetup."Responsibility Centre" + ' \' + 'this is to bring to your attention that the collateral for loan number ' +
                                     Rec."Loan No." + ' has been discharged.' + '\Please take necessary action. \Thank you.';
                                    EmailManager.Create(UserSetup."E-Mail", 'Collateral Discharge', msg, true);
                                    Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                                end;
                            until NotificationSetup.NEXT = 0;
                            Message('Email Sent Successfully');
                        end;

                        NotificationSetup.RESET;
                        NotificationSetup.SetRange(Notification, NotificationSetup.Notification::Legal);
                        NotificationSetup.SetRange("Send Email", true);
                        if NotificationSetup.Find('-') then begin

                            repeat
                                UserSetup.Reset();
                                UserSetup.SetRange("User ID", NotificationSetup."user id");
                                if UserSetup.FindFirst() then begin

                                    msg := 'Dear' + ' ' + NotificationSetup."Responsibility Centre" + ' ' + '\this is to bring to your attention that the collateral for loan number ' +
                                     Rec."Loan No." + ' has been discharged.' + '\Please take necessary action. \Thank you.';

                                    EmailManager.Create(UserSetup."E-Mail", 'Collateral Discharge', msg, true);
                                    Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                                end;
                            until NotificationSetup.NEXT = 0;
                            Rec."Email Sent" := true;
                            Rec.Modify();
                            Message('Email Sent Successfully');
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        RichText := Rec.GetRichText(Rec);

    end;

    trigger OnAfterGetRecord()
    begin
        RichText := Rec.GetRichText(Rec);
    end;

    trigger OnOpenPage()
    begin
        Rec."Member No." := Rec."Member No.";
        if UserSetup.Get(Rec."Created By") then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";

        end;


        Rec."Created By" := UserId;
        CurrPage.UPDATE;
        if Rec.Status = Rec.Status::Open then begin
            //CurrPage.Editable := true
            PageEditable := true;
            ForwardingEditable := false;
        end
        else begin
            //CurrPage.Editable := false;
            PageEditable := false;
            ForwardingEditable := true;
        end;
    end;



    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        PageEditable: Boolean;
        ForwardingEditable: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        UserSetup: Record "User Setup";
        CollateralCollection: Record "Securities Collection Register";
        SecurtitiesRegister: Record "Securities Register";
        msg: Text;
        EmailManager: Codeunit "Email Message";
        Email: Codeunit Email;
        NotificationSetup: Record "Notification EmSms setup";
        Members: Record "Members";
        SendSMS: Codeunit SendSms;
        Source: enum "SMS Source";
        PerfectionLines: Record "Perfection Lines";
        RichText: Text;
}

