page 52186476 "General SMS Header Card"
{
    ApplicationArea = All;
    Caption = 'General SMS Header Card';
    PageType = Card;
    SourceTable = "General SMS Header";
    DeleteAllowed = false;
    PromotedActionCategories = 'New, Process, Reports,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = GeneralTabEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field(SMS; Rec.SMS)
                {
                    ToolTip = 'Specifies the value of the SMS field.';
                }


                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        SetControlAppearance();
                    end;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the Created At field.';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
                }

                field("Posted At"; Rec."Posted At")
                {
                    ToolTip = 'Specifies the value of the Posted At field.';
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                    Editable = false;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
            }


            part("General SMS Lines"; "General SMS Lines")
            {
                Editable = SMSLinesEditable;
                SubPageLink = "Header No" = field("No."), SMS = field(SMS);

            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Import SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "General SMS Lines";
            }


            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = PostSMSEnabled;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post these SMS?') then begin
                        PostNotifications();
                        Rec.Posted := true;
                        rec."Posted By" := UserId;
                        Rec."Posted At" := CurrentDateTime;
                        rec.Modify();
                        Message('POSTED SUCCESSFULLY👌');
                    end else
                        Message('Operation aborted!');
                end;
            }

            action(AssinedUser)
            {
                ApplicationArea = all;
                Image = Task;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "User Tasks";
                RunPageLink = "Record ID" = FIELD("No.");
                Caption = 'User Assigned';
            }

        }
        area(Processing)
        {
            group(Workflows)
            {
                Caption = 'Approvals';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = SendApprovalVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        LoanLines: Record "Alerts Loan Lines";
                    begin

                        SMSAlertsLines.Reset();
                        SMSAlertsLines.SetRange("Header No", Rec."No.");
                        if (not SMSAlertsLines.FindFirst()) and (not LoanLines.FindFirst()) then Error('There are no any notices to send');

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        if Confirm('Are you sure you want to send this document for approval?') then begin
                            VarVariant := Rec;
                            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                                CustomApprovals.OnSendDocForApproval(VarVariant);
                        end else
                            Message('Operation aborted!');
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }

                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
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

                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen the Document';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = ReopenVisible;

                    trigger OnAction()
                    var
                    begin
                        if Confirm('Are you sure you want to open this document?') then begin


                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            Message('Record opened successfully');
                        end else
                            Message('Operation aborted!');
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
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
                    PromotedCategory = Category4;
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
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        CreateAttachmentHeadersEnabled := true;

        EmployercodeEditable := true;
        PeriodEditable := true;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if Rec.Status = Rec.Status::Open then begin
            GeneralTabEditable := true;
            SMSLinesEditable := true;
            GenerateSMSEnabled := true;
            PostSMSEnabled := false;
            OpenApprovalEntriesExist := false;
            OpenApprovalEntriesExistForCurrUser := false;
            ReopenVisible := false;
            SendApprovalVisible := true;

        end;
        if Rec.Status = Rec.Status::Pending then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := true;
            SendApprovalVisible := false;


        end;
        if Rec.Status = Rec.Status::Approved then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := true;
            ReopenVisible := true;
            SendApprovalVisible := false;


        end;
        if Rec.Status = Rec.Status::Rejected then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := false;
            SendApprovalVisible := false;


        end;
        if Rec.Posted then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := false;
            SendApprovalVisible := false;


        end;


        Rec.CalcFields("Responsible Officer", "Supervisor ID");
        if Rec."No." <> '' then begin
            if (UserId <> Rec."Responsible Officer") and (UserId <> Rec."Supervisor ID") then begin
                GeneralTabEditable := false;
                SMSLinesEditable := false;
                GenerateSMSEnabled := false;
                PostSMSEnabled := false;
                ReopenVisible := false;
                SendApprovalVisible := false;

            end;
        end;

    end;

    local procedure AddSingleDocument(SmsAlertLine: Record "General SMS Lines"; Zip: Codeunit "Data Compression")
    var
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FileMgt: Codeunit "File Management";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        FileNameArchive: Text;
        OutS: OutStream;
        InS: InStream;

        FilePath: Text;
    begin
        FilePath := 'C:\Users\Administrator\Downloads\Files\';
        // FileName := SmsAlertLine."Member No" + Format(SmsAlertLine."Notice Type") + '.pdf';



        TempBlob.CreateOutStream(OutS);
        RecRef.GetTable(SmsAlertLine);

        // if SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"First Notice" then
        //     Report.SaveAs(Report::"First Notice", '', ReportFormat::Pdf, OutS, RecRef);
        // if (SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"Second Notice") and (SmsAlertLine.Recepient = SmsAlertLine.Recepient::Lonee) then
        //     Report.SaveAs(52186796, '', ReportFormat::Pdf, OutS, RecRef);
        // if (SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"Second Notice") and (SmsAlertLine.Recepient = SmsAlertLine.Recepient::Guarantor) then
        //     Report.SaveAs(52186797, '', ReportFormat::Pdf, OutS, RecRef);

        // FileName := SmsAlertLine."Member No" + Format(SmsAlertLine."Notice Type") + '.pdf';

        TempBlob.CreateInStream(InS);
        Zip.AddEntry(InS, FileName);
    end;


    local procedure PostNotifications()
    var

    begin
        SMSAlertsLines.Reset();
        SMSAlertsLines.SetRange("Header No", Rec."No.");
        SMSAlertsLines.SetRange("SMS Sent", false);
        if SMSAlertsLines.FindSet() then begin
            repeat
                SendSMS.SendSms(Source::DMU, SMSAlertsLines."Phone Number", Rec.SMS, Format(Rec."No."), '', true, 0, false, 'CBS', Rec."No.", 'CBS');
                SMSAlertsLines."SMS Sent" := true;
                SMSAlertsLines."Time Sent" := CurrentDateTime;
                SMSAlertsLines."Sent By" := UserId;
                SMSAlertsLines.Modify();
            until SMSAlertsLines.Next() = 0;
        end;

        SMSAlertsLines.Reset();
        SMSAlertsLines.SetRange("Header No", Rec."No.");
        // SMSAlertsLines.SetRange("Email Sent", false);
        // SMSAlertsLines.SetRange(sms, SMSAlertsLines.SMS);
        // SMSAlertsLines.SetRange(SMSAlertsLines."SMS Sent", true);
        // SMSAlertsLines.SetFilter("Email Address", '<>%1', '');
        if SMSAlertsLines.FindSet() then begin
            repeat
                SMSAlertsLines."SMS Sent" := true;
                SMSAlertsLines."Time Sent" := CurrentDateTime;
                SMSAlertsLines."Sent By" := UserId;
                SMSAlertsLines.Modify();
            until SMSAlertsLines.Next() = 0;

        end;
    end;



    var
        DocMustbeOpen: Label 'This application request must be open';
        Generating: Label 'Generating Alerts';


        VarVariant: Variant;
        SMSLinesEditable: Boolean;
        GeneralTabEditable: Boolean;
        GenerateSMSEnabled: Boolean;
        PostSMSEnabled: Boolean;
        ReopenVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        SendApprovalVisible: Boolean;
        EmployercodeEditable: Boolean;
        PeriodEditable: Boolean;
        CreateAttachmentHeadersEnabled: Boolean;


        sms: Text;
        PhoneNumber: Text;
        Email: Text;
        OutInt: Decimal;
        OutBal: Decimal;
        LoanNo: Code[30];


        PreviousHeaderNo: Code[30];
        SendFirstNotice: Boolean;
        MarkForAttachment: Boolean;

        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SMSAlertsLines: Record "General SMS Lines";
        SendSMS: Codeunit SendSms;
        Source: enum "SMS Source";
        LoanProcess: Codeunit "Loans Process";
        SMSTemplates: Record "DMU SMS Templates";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        SMSLines: Record "General SMS Lines";
        Members: Record Members;

        PreviousHeader: Record "General SMS Header";
        AlertLines: Record "General SMS Lines";


        Notices: Dictionary of [Text, Text];

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
}

