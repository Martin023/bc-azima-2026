page 52186732 "SMS Alerts Header Card"
{
    ApplicationArea = All;
    Caption = 'SMS Alerts Header Card';
    PageType = Card;
    SourceTable = "SMS Alerts Header";
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

                field("Notice Type"; Rec."Notice Type")
                {
                    ToolTip = 'Specifies the value of the Notice Type field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Editable = EmployercodeEditable;
                }
                field(Period; Rec.Period)
                {
                    Editable = PeriodEditable;
                }
                field("Period Name"; Rec."Period Name")
                {

                }
                field("Send SMS"; Rec."Send SMS")
                {
                    ToolTip = 'Specifies the value of the Send SMS field.';
                }
                field("Send Email"; Rec."Send Email")
                {
                    ToolTip = 'Specifies the value of the Send Email field.';
                }

                group(CreateLetters)
                {
                    // ShowCaption = false;
                    Caption = 'Letters';
                    field("Create Letters"; Rec."Create Letters")
                    {
                    }
                    field("Equal Guarantor Disribution"; Rec."Equal Guarantor Disribution")
                    {
                    }
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

                // field("Responsible Officer"; Rec."Responsible Officer")
                // {
                //     Editable = false;
                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {
                //     Editable = false;
                // }
                // field("Case Forwarding No"; Rec."Case Forwarding No")
                // {

                // }
            }

            part("Alerts Loans Lines"; "Alerts Loan Lines")
            {
                Editable = LoanLinesEditable;
                SubPageLink = "Header No." = field("No.");
            }
            part("SMS Alerts Lines"; "SMS Alerts Lines")
            {
                Editable = SMSLinesEditable;
                SubPageLink = "Header No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Populate Loans")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate Loans';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = GenerateSMSEnabled;


                trigger OnAction()
                var
                    SMSAlertsHeader: Record "SMS Alerts Header";

                begin
                    if (rec."Notice Type" = Rec."Notice Type"::"1st Notice") or (rec."Notice Type" = rec."Notice Type"::"2nd Notice") then
                        if Rec.Period = 0D then Error('Period must have a value');
                    if Confirm('Are you sure you want to generate SMSs with the current filters?') then begin

                        SMSAlertsHeader.Reset;
                        SMSAlertsHeader.SetRange(SMSAlertsHeader."No.", Rec."No.");
                        if SMSAlertsHeader.Find('-') then
                            REPORT.Run(Report::"Generate Loans", true, false, SMSAlertsHeader);
                    end else
                        Message('Operation aborted!');
                end;
            }
            action("Import Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Alerts Loan Lines";
            }
            action("Generate Notices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate Notices';
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = GenerateSMSEnabled;


                trigger OnAction()
                var
                    LoanLines: Record "Alerts Loan Lines";
                    AlertLines: Record "SMS Alerts Lines";
                begin
                    AlertLines.Reset();
                    AlertLines.SetRange("Header No", Rec."No.");
                    if AlertLines.Find('-') then
                        AlertLines.DeleteAll();

                    LoanLines.Reset();
                    LoanLines.SetRange("Header No.", Rec."No.");
                    LoanLines.SetRange("Process Case", true);
                    if LoanLines.Find('-') then begin
                        intProgressTotal := LoanLines.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

                        repeat

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;

                            //Only process the non system generated and the allowed system generated
                            if (rec."Notice Type" = Rec."Notice Type"::"1st Notice") or (rec."Notice Type" = rec."Notice Type"::"2nd Notice") then begin
                                //if ((LoanLines."System Generated") and (LoanLines."Process Case")) or (not LoanLines."System Generated") then
                                CreateNotices(LoanLines, rec."Notice Type");
                            end;
                            if (Rec."Notice Type" <> Rec."Notice Type"::"1st Notice") and (Rec."Notice Type" <> Rec."Notice Type"::"2nd Notice") then begin
                                CreateOtherNotices(LoanLines);
                            end;
                        until LoanLines.Next() = 0;

                        diaProgress.Close();

                    end;
                end;
            }
            // action("Batch Toggle")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ToggleBreakpoint;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Enabled = GenerateSMSEnabled;
            //     trigger OnAction()
            //     var
            //         AlertLoanLines: Record "Alerts Loan Lines";
            //     begin
            //         if not Confirm('Are you sure you want to run this action?') then exit;
            //         AlertLoanLines.Reset();
            //         AlertLoanLines.SetRange("Header No.", Rec."No.");
            //         if AlertLoanLines.FindFirst() then begin
            //             Report.Run(52186799, true, false, AlertLoanLines);
            //         end;

            //     end;
            // }


            action("Generate Letters")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate Letters';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to generate letters?') then exit;
                    GenerateLetters();
                end;
            }
            action("View Generated Letters")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Generated Letters';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Guarantor Notice Letters List";
                RunPageLink = "Header No" = field("No.");
                RunPageMode = View;
                // RunObject = report "Guarantor Notice";
                // trigger OnAction()
                // var
                //     ReportParameters: Text;
                //     LoanRepay: Report "Guarantor Notice";
                // begin
                //     ReportParameters := LoanRepay.RunRequestPage();
                //     Message(ReportParameters);
                // end;


            }

            action("Skipped Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Skipped Loans";
                RunPageLink = "Header No." = field("No.");
                RunPageMode = View;

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
                    if Confirm('Are you sure you want to post these Notices?') then begin
                        PostNotifications();
                        Rec.Posted := true;
                        rec."Posted By" := UserId;
                        Rec."Posted At" := CurrentDateTime;
                        rec.Modify();
                        // if AreThereLetters() then begin
                        //     if Confirm('Do you wish to generate the letters?') then begin
                        //         GenerateLetters();
                        //         Message('SUCCESS\1. Notifications Posted successfully\2. Letters generated successfully');
                        //     end else
                        //         Message('Notifications Posted successfully');
                        // end else
                        //     Message('Notifications Posted successfully');
                    end else
                        Message('Operation aborted!');
                end;
            }
            action("Create Attachment Headers")
            {
                ApplicationArea = Basic, Suite;
                Image = CopyRouteHeader;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CreateAttachmentHeadersEnabled;

                trigger OnAction()
                var
                    AlertLoanLines: Record "Alerts Loan Lines";
                begin
                    AlertLoanLines.Reset();

                    if Confirm('Are you sure you want to create attachmnet headers?') then begin
                        CreateAttachmentHeaders();
                        Rec."Attachment Headers Created" := true;
                        Rec.Modify();
                        Message('Attachment headers have been created successfully');
                    end else
                        Message('Operation aborted!');
                end;
            }

            // action(AssinedUser)
            // {
            //     ApplicationArea = all;
            //     Image = Task;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "User Tasks";
            //     RunPageLink = "Record ID" = FIELD("No.");
            //     Caption = 'User Assigned';
            // }



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
                        LoanLines.Reset();
                        LoanLines.SetRange("Header No.", Rec."No.");
                        LoanLines.SetRange("Mark For Attachment", true);
                        LoanLines.SetRange("Create Attachment Header", true);

                        SMSAlertsLines.Reset();
                        SMSAlertsLines.SetRange("Header No", Rec."No.");
                        if (not SMSAlertsLines.FindFirst()) and (not LoanLines.FindFirst()) then Error('There are no any notices to send');

                        if Rec.Period = 0D then Error('Period must have a value');
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Posted, false);
                        if not Confirm('Are you sure you want to reopen this document?') then exit;

                        Rec.Status := Rec.Status::Open;

                        if ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) then
                            ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);

                        Rec.Modify();
                        Message('The document has been opened successfully.');
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
                        //Rec.TestField(Rec.Status, Rec.Status::Pending);
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
        AlertLoanLines: Record "Alerts Loan Lines";
    begin
        CreateAttachmentHeadersEnabled := true;
        // if not Rec."Attachment Headers Created" then begin
        //     AlertLoanLines.Reset();
        //     AlertLoanLines.SetRange("Header No.", Rec."No.");
        //     AlertLoanLines.SetRange("Mark For Attachment", true);
        //     AlertLoanLines.SetRange("Process Case", true);
        //     if AlertLoanLines.FindFirst() then begin
        //         CreateAttachmentHeadersEnabled := true;
        //     end;
        // end;

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
            LoanLinesEditable := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := true;
            SendApprovalVisible := false;
            LoanLinesEditable := false;

        end;
        if Rec.Status = Rec.Status::Approved then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := true;
            ReopenVisible := true;
            SendApprovalVisible := false;
            LoanLinesEditable := false;

        end;
        if Rec.Status = Rec.Status::Rejected then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := false;
            SendApprovalVisible := false;
            LoanLinesEditable := false;

        end;
        if Rec.Posted then begin
            GeneralTabEditable := false;
            SMSLinesEditable := false;
            GenerateSMSEnabled := false;
            PostSMSEnabled := false;
            ReopenVisible := false;
            SendApprovalVisible := false;
            LoanLinesEditable := false;

        end;

        if Rec."Case Forwarding No" <> '' then begin
            EmployercodeEditable := false;
            PeriodEditable := false;
        end;

        // Rec.CalcFields("Responsible Officer", "Supervisor ID");
        // if Rec."No." <> '' then begin
        //     if (UserId <> Rec."Responsible Officer") and (UserId <> Rec."Supervisor ID") then begin
        //         GeneralTabEditable := false;
        //         SMSLinesEditable := false;
        //         GenerateSMSEnabled := false;
        //         PostSMSEnabled := false;
        //         ReopenVisible := false;
        //         SendApprovalVisible := false;
        //         LoanLinesEditable := false;
        //     end;
        // end;

    end;

    // local procedure AddSingleDocument(SmsAlertLine: Record "SMS Alerts Lines"; Zip: Codeunit "Data Compression")
    // var
    //     TempBlob: Codeunit "Temp Blob";
    //     RecRef: RecordRef;
    //     FileMgt: Codeunit "File Management";
    //     FileName: Text;
    //     FileManagement: Codeunit "File Management";
    //     FileNameArchive: Text;
    //     OutS: OutStream;
    //     InS: InStream;

    //     FilePath: Text;
    // begin
    //     FilePath := 'C:\Users\Administrator\Downloads\Files\';
    //     FileName := SmsAlertLine."Member No" + Format(SmsAlertLine."Notice Type") + '.pdf';



    //     TempBlob.CreateOutStream(OutS);
    //     RecRef.GetTable(SmsAlertLine);

    //     if SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"First Notice" then
    //         Report.SaveAs(Report::"First Notice", '', ReportFormat::Pdf, OutS, RecRef);
    //     if (SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"Second Notice") and (SmsAlertLine.Recepient = SmsAlertLine.Recepient::Lonee) then
    //         Report.SaveAs(52186796, '', ReportFormat::Pdf, OutS, RecRef);
    //     if (SmsAlertLine."Notice Category" = SmsAlertLine."Notice Category"::"Second Notice") and (SmsAlertLine.Recepient = SmsAlertLine.Recepient::Guarantor) then
    //         Report.SaveAs(52186797, '', ReportFormat::Pdf, OutS, RecRef);

    //     FileName := SmsAlertLine."Member No" + Format(SmsAlertLine."Notice Type") + '.pdf';

    //     TempBlob.CreateInStream(InS);
    //     Zip.AddEntry(InS, FileName);
    // end;

    local procedure CreateNotices(AlertLoanLines: Record "Alerts Loan Lines"; NoticeType: Option "1st Notice","2nd Notice","Arrears Alert","CRB Notice","CRB Listing","Defaulter Notice")
    var
        PreviousHeader: Record "SMS Alerts Header";
        Prorata: Decimal;
    begin
        GetSMSs();
        SendFirstNotice := false;
        SendSecondNotice := false;
        MarkForAttachment := false;
        Loans.Get(AlertLoanLines."Loan No.");
        DaysInArreas := AlertLoanLines."Days In Arrears";
        LoanRecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
        Loans.CalcFields("Last Repayment Date", "Amount In Arreas SACCO");
        if Loans."Last Repayment Date" = 0D then
            Loans."Last Repayment Date" := Loans."Application Date";


        ReceipientsName := '';
        LoanDescription := '';
        AmountInArrears := 0;
        LoaneeFirstName := '';
        LoaneeMemberNumber := '';
        MonthlRepayment := 0;
        LastRepaymentDate := 0D;
        LoaneeLoanNo := '';

        if Members.Get(Loans."Member No.") then begin
            if Members."First Name" = '' then
                Members."First Name" := Members."Middle Name";
            if Members."First Name" = '' then
                Members."First Name" := Members."Other Names";

            PhoneNumber := Members."Phone No.";
            Email := Members."E-Mail";
        end;

        LoanDescription := Loans."Loan Product Type Name";
        LoaneeLoanNo := Loans."Loan No.";
        AmountInArrears := Loans."Amount In Arreas SACCO";
        TotalBal := Round(TotalBal, 0.01);
        LoaneeFirstName := Members."First Name";
        LoaneeMemberNumber := Loans."Member No.";
        MonthlRepayment := Loans.Repayment;
        LastRepaymentDate := Loans."Last Repayment Date";

        // PreviousPeriod := CalcDate('-1M-CM', Rec.Period);

        // PreviousAlertLoanLines.Reset();
        // PreviousAlertLoanLines.SetRange(Period, PreviousPeriod);
        // PreviousAlertLoanLines.SetRange("Loan No.", AlertLoanLines."Loan No.");
        // PreviousAlertLoanLines.SetRange("Process Case", true);
        // if PreviousAlertLoanLines.Find('-') then begin
        //     repeat
        //         PreviousHeader.Reset();
        //         PreviousHeader.SetRange(Posted, true);
        //         PreviousHeader.SetRange("No.", PreviousAlertLoanLines."Header No.");
        //         if PreviousHeader.FindFirst() then
        //             PreviousHeaderNo := PreviousAlertLoanLines."Header No.";

        //     until (PreviousAlertLoanLines.Next() = 0) or (PreviousHeaderNo <> '');
        // end;

        // if AlertLoanLines."Installments FallOff" > 0 then begin
        //     SendFirstNotice := true;
        // end;

        // if AlertLoanLines."Installments FallOff" > 1 then begin
        //     if PreviousHeaderNo <> '' then begin
        //         SendSecondNotice := true;
        //         SendFirstNotice := false;
        //         AlertLines.Reset();
        //         AlertLines.SetRange("Header No", PreviousHeaderNo);
        //         AlertLines.SetRange("Send this Notification", true);
        //         AlertLines.SetRange("Notice Category", AlertLines."Notice Category"::"First Notice");
        //         AlertLines.SetRange("Loan No", AlertLoanLines."Loan No.");
        //         if not AlertLines.Find('-') then begin
        //             SendFirstNotice := true;
        //             SendSecondNotice := false;
        //         end;
        //     end;
        // end;

        // if AlertLoanLines."Installments FallOff" > 2 then begin
        //     if PreviousHeaderNo <> '' then begin
        //         SendFirstNotice := false;
        //         SendSecondNotice := false;
        //         AlertLines.Reset();
        //         AlertLines.SetRange("Header No", PreviousHeaderNo);
        //         AlertLines.SetRange("Send this Notification", true);
        //         AlertLines.SetRange("Notice Category", AlertLines."Notice Category"::"Second Notice");
        //         AlertLines.SetRange("Loan No", AlertLoanLines."Loan No.");
        //         if AlertLines.Find('-') then begin
        //             MarkForAttachment := true
        //         end;

        //         AlertLines.Reset();
        //         AlertLines.SetRange("Header No", PreviousHeaderNo);
        //         AlertLines.SetRange("Send this Notification", true);
        //         AlertLines.SetRange("Notice Category", AlertLines."Notice Category"::"First Notice");
        //         AlertLines.SetRange("Loan No", AlertLoanLines."Loan No.");
        //         if AlertLines.Find('-') then begin
        //             SendSecondNotice := true;
        //         end else
        //             if not MarkForAttachment then
        //                 SendFirstNotice := true;
        //     end;
        // end;

        Prorata := CustomCuesCodeunit.Prorata(Loans."Member No.", '1');

        //Send First Notice
        IF NoticeType = NoticeType::"1st Notice" then begin
            // if AlertLoanLines."Installments FallOff" > 0 then begin
            ReceipientsName := LoaneeFirstName;
            if Rec."Send SMS" then begin
                sms := StrSubstNo(Notices.Get('LoaneeSMSFirstNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);

                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, 'Route', Loans."Member No.",
                                                    SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Lonee, NoticeCategory::"First Notice");
            end;

            if Rec."Create Letters" then begin
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", 'Defaulter Letter, First Notice', PhoneNumber, Email, 'Route', Loans."Member No.",
                                                    SMSLines."Notice Type"::Letter, DaysInArreas, Receipient::Lonee, NoticeCategory::"First Notice");
            end;

            if Rec."Send Email" then begin
                sms := StrSubstNo(Notices.Get('LoaneeEmailFirstNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);

                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, 'Route', Loans."Member No.",
                                                    SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Lonee, NoticeCategory::"First Notice");
            end;
            // end;
        end;


        //Second Alert
        IF NoticeType = NoticeType::"2nd Notice" then begin
            if AlertLoanLines."Installments FallOff" >= 2 then begin
                ReceipientsName := LoaneeFirstName;
                // IF (Rec."Send SMS") or (Rec."Send Email") then begin
                if Rec."Send SMS" then begin
                    sms := StrSubstNo(Notices.Get('LoaneeSMSSecondNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);

                    Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Loans."Member No.",
                                                                SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Lonee, NoticeCategory::"Second Notice");
                end;

                if Rec."Create Letters" then begin
                    Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", 'Defaulter Letter, Second Notice', PhoneNumber, Email, '', Loans."Member No.",
                                                                SMSLines."Notice Type"::Letter, DaysInArreas, Receipient::Lonee, NoticeCategory::"Second Notice");
                end;

                if Rec."Send Email" then begin
                    sms := StrSubstNo(Notices.Get('LoaneeEmailSecondNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                    Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Loans."Member No.",
                                                                SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Lonee, NoticeCategory::"Second Notice");
                end;
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(Substituted, false);
                LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
                LoanGuarantors.SetRange("Loan No", Loans."Loan No.");
                LoanGuarantors.SetRange("Self Guarantee", false);
                if LoanGuarantors.Find('-') then begin
                    repeat
                        if SavingsAccounts.Get(LoanGuarantors."Savings Account No./Member No.") then begin
                            if Members.Get(SavingsAccounts."Member No.") then begin
                                if Members.Status <> Members.Status::Deceased then begin
                                    ReceipientsName := '';
                                    PhoneNumber := '';
                                    PhoneNumber := Members."Phone No.";
                                    if StrPos(SavingsAccounts.Name, ' ') > 0 then
                                        ReceipientsName := CopyStr(SavingsAccounts.Name, 1, StrPos(SavingsAccounts.Name, ' ') - 1)
                                    else
                                        ReceipientsName := SavingsAccounts.Name + ' ';

                                    if Rec."Send SMS" then begin
                                        sms := StrSubstNo(Notices.Get('GuarantorSMSSecondNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                        LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                        OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                                        Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                                        SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Guarantor, NoticeCategory::"Second Notice");
                                    end;

                                    if Rec."Create Letters" then begin
                                        Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", 'Guarantor Letter, Second Notice', PhoneNumber, Email, '', Members."No.",
                                                                        SMSLines."Notice Type"::Letter, DaysInArreas, Receipient::Guarantor, NoticeCategory::"Second Notice");
                                    end;

                                    if Rec."Send Email" then begin
                                        sms := StrSubstNo(Notices.Get('GuarantorEmailSecondNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                        LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                        OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                                        Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                                        SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Guarantor, NoticeCategory::"Second Notice");
                                    end;
                                end;
                            end;
                        end;
                    until LoanGuarantors.Next() = 0;
                end;
                // end;
            end;
        end;

        if AlertLoanLines."Installments FallOff" >= 12 then begin
            AlertLoanLines."Mark CRB Listing" := true;
        end;

        if MarkForAttachment then begin
            AlertLoanLines."Mark For Attachment" := true;
            AlertLoanLines."Create Attachment Header" := true;
            AlertLoanLines.Modify();
        end;
    end;

    local procedure CreateOtherNotices(AlertLoanLines: Record "Alerts Loan Lines")
    var
        Prorata: Decimal;
    begin
        GetSMSs();
        Loans.Get(AlertLoanLines."Loan No.");
        DaysInArreas := AlertLoanLines."Days In Arrears";
        Loans.CalcFields("Last Repayment Date", "Amount In Arreas SACCO");
        if Loans."Last Repayment Date" = 0D then
            Loans."Last Repayment Date" := Loans."Application Date";

        ReceipientsName := '';
        LoanDescription := '';
        AmountInArrears := 0;
        TotalBal := 0;
        LoaneeFirstName := '';
        LoaneeMemberNumber := '';
        MonthlRepayment := 0;
        LastRepaymentDate := 0D;
        LoaneeLoanNo := '';

        LoanRecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

        if Members.Get(Loans."Member No.") then begin
            if Members."First Name" = '' then
                Members."First Name" := Members."Middle Name";
            if Members."First Name" = '' then
                Members."First Name" := Members."Other Names";

            PhoneNumber := Members."Phone No.";
            Email := Members."E-Mail";
        end;

        LoanDescription := Loans."Loan Product Type Name";
        LoaneeLoanNo := Loans."Loan No.";
        AmountInArrears := Loans."Amount In Arreas SACCO";
        TotalBal := Round(TotalBal, 0.01);
        LoaneeFirstName := Members."First Name";
        LoaneeMemberNumber := Loans."Member No.";
        MonthlRepayment := Loans.Repayment;
        LastRepaymentDate := Loans."Last Repayment Date";
        ReceipientsName := LoaneeFirstName;

        //Prorata := CustomCuesCodeunit.Prorata(Loans."Member No.", '1');

        if Rec."Notice Type" = Rec."Notice Type"::"Arrears Alert" then begin
            if Rec."Send SMS" then begin
                sms := StrSubstNo(Notices.Get('LoaneeSMSArrears'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Lonee, NoticeCategory::"Arrears Alert");
            end;
            if Rec."Send Email" then begin
                sms := StrSubstNo(Notices.Get('LoaneeEmailArrears'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Lonee, NoticeCategory::"Arrears Alert");
            end;
        end;
        if Rec."Notice Type" = Rec."Notice Type"::"CRB Listing" then begin
            if Rec."Send SMS" then begin
                sms := StrSubstNo(Notices.Get('LoaneeSMSCRBListing'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Lonee, NoticeCategory::"CRB Listing Notice");
            end;
            if Rec."Send Email" then begin
                sms := StrSubstNo(Notices.Get('LoaneeEmailCRBListing'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Lonee, NoticeCategory::"CRB Listing Notice");
            end;
        end;
        if Rec."Notice Type" = Rec."Notice Type"::"CRB Notice" then begin
            if Rec."Send SMS" then begin
                sms := StrSubstNo(Notices.Get('LoaneeSMSCRBNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::SMS, DaysInArreas, Receipient::Lonee, NoticeCategory::"CRB Notice");
            end;
            if Rec."Send Email" then begin
                sms := StrSubstNo(Notices.Get('LoaneeEmailCRBNotice'), ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                    LoaneeFirstName, LoaneeMemberNumber, MonthlRepayment, LastRepaymentDate, LoaneeLoanNo,
                                    OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);
                Rec.InsertNoticeLines(Rec."No.", Loans."Loan No.", sms, PhoneNumber, Email, '', Members."No.",
                                                SMSLines."Notice Type"::Email, DaysInArreas, Receipient::Lonee, NoticeCategory::"CRB Notice");
            end;
        end;

    end;



    procedure GetSMSs(): Dictionary of [Text, Text]
    begin
        SMSTemplates.Reset();
        if SMSTemplates.Find('-') then begin
            repeat
                if (SMSTemplates.Recepient = Receipient::Lonee) then begin
                    if (SMSTemplates."Notice Type" = NoticeType::SMS) then begin
                        if (SMSTemplates."Notice Category" = NoticeCategory::"First Notice") then begin
                            if not Notices.ContainsKey('LoaneeSMSFirstNotice') then
                                Notices.Add('LoaneeSMSFirstNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Second Notice") then begin
                            if not Notices.ContainsKey('LoaneeSMSSecondNotice') then
                                Notices.Add('LoaneeSMSSecondNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"CRB Listing Notice") then begin
                            if not Notices.ContainsKey('LoaneeSMSCRBListing') then
                                Notices.Add('LoaneeSMSCRBListing', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"CRB Notice") then begin
                            if not Notices.ContainsKey('LoaneeSMSCRBNotice') then
                                Notices.Add('LoaneeSMSCRBNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Arrears Alert") then begin
                            if not Notices.ContainsKey('LoaneeSMSArrears') then
                                Notices.Add('LoaneeSMSArrears', SMSTemplates."Text SMS");
                        end;
                    end;
                    if (SMSTemplates."Notice Type" = NoticeType::Email) then begin
                        if (SMSTemplates."Notice Category" = NoticeCategory::"First Notice") then begin
                            if not Notices.ContainsKey('LoaneeEmailFirstNotice') then
                                Notices.Add('LoaneeEmailFirstNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Second Notice") then begin
                            if not Notices.ContainsKey('LoaneeEmailSecondNotice') then
                                Notices.Add('LoaneeEmailSecondNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"CRB Listing Notice") then begin
                            if not Notices.ContainsKey('LoaneeEmailCRBListing') then
                                Notices.Add('LoaneeEmailCRBListing', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"CRB Notice") then begin
                            if not Notices.ContainsKey('LoaneeEmailCRBNotice') then
                                Notices.Add('LoaneeEmailCRBNotice', SMSTemplates."Text SMS");
                        end;
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Arrears Alert") then begin
                            if not Notices.ContainsKey('LoaneeEmailArrears') then
                                Notices.Add('LoaneeEmailArrears', SMSTemplates."Text SMS");
                        end;
                    end;
                end;
                if (SMSTemplates.Recepient = Receipient::Guarantor) then begin
                    if (SMSTemplates."Notice Type" = NoticeType::SMS) then begin
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Second Notice") then begin
                            if not Notices.ContainsKey('GuarantorSMSSecondNotice') then
                                Notices.Add('GuarantorSMSSecondNotice', SMSTemplates."Text SMS");
                        end;
                    end;
                    if (SMSTemplates."Notice Type" = NoticeType::Email) then begin
                        if (SMSTemplates."Notice Category" = NoticeCategory::"Second Notice") then begin
                            if not Notices.ContainsKey('GuarantorEmailSecondNotice') then
                                Notices.Add('GuarantorEmailSecondNotice', SMSTemplates."Text SMS");
                        end;
                    end;
                end;
            until SMSTemplates.Next() = 0;
        end;

        exit(Notices);
    end;

    procedure CreateAttachmentHeaders()
    var
        AlertLoanLines: Record "Alerts Loan Lines";
        AttachmentHeader: Record "Loan Recovery Header";
    begin
        AttachmentHeader.Reset();
        AttachmentHeader.SetRange("SMS Header No", Rec."No.");
        if not AttachmentHeader.FindFirst() then begin
            AlertLoanLines.Reset();
            AlertLoanLines.SetRange("Header No.", Rec."No.");
            AlertLoanLines.SetRange("Mark For Attachment");
            AlertLoanLines.SetRange("Process Case", true);
            AlertLoanLines.SetRange("Create Attachment Header", true);
            if AlertLoanLines.Find('-') then begin
                repeat
                    Clear(AttachmentHeader);

                    AttachmentHeader.Init();
                    AttachmentHeader."Member No." := AlertLoanLines."Member No.";
                    AttachmentHeader.Validate("Member No.");
                    AttachmentHeader."Recovery Type" := AttachmentHeader."Recovery Type"::"Recovery and Attachment";
                    AttachmentHeader.Validate("Recovery Type");
                    AttachmentHeader."Loan No." := AlertLoanLines."Loan No.";
                    AttachmentHeader."Auto Assign Task" := true;
                    if Loans.Get(AttachmentHeader."Loan No.") then begin
                        if not Loans."Mobile Loan" then
                            AttachmentHeader.Insert(true);
                    end;
                    // AttachmentHeader.Validate("Loan No.");
                    Clear(AttachmentHeader);
                until AlertLoanLines.Next() = 0;
            end;
        end else
            Message('Attachment headers have already been created');
    end;

    procedure SendEmailWithAttachment(var emailadress: Text[50])
    var
        ReportExample: Report "Member Detailed Statement";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        TxtRecipientsList: List of [Text];
    begin
        //ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"RFQ Printout", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        // TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Subject-Request For Quotation', 'Please Provide Prices for the Items Specified');
        EmailMsg.AddAttachment('RFQ.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    local procedure PostNotifications()
    var
        Emailmsg: Codeunit "Email Message";
        Email: Codeunit Email;
        TransactionCharges: record "Transaction Charges";
        Gensetup: record "General Set-up";
        LineNo: Integer;
        AccType: enum "Gen. Journal Account Type";
        TransType: enum "Transaction Types";
        JournalPosting: codeunit "Journal Posting";
        BankingUserSetup: record "Banking User Template";
        JTemplate: code[20];
        JBatch: code[20];
    begin
        SMSAlertsLines.Reset();
        SMSAlertsLines.SetRange("Header No", Rec."No.");
        SMSAlertsLines.SetRange("SMS Sent", false);
        SMSAlertsLines.SetRange("Notice Type", SMSAlertsLines."Notice Type"::SMS);
        SMSAlertsLines.SetRange("Send this Notification", true);
        SMSAlertsLines.SetFilter("Phone Number", '<>%1', '');
        if SMSAlertsLines.FindSet() then begin
            repeat
                // SMS Charges
                if Gensetup."Loan SMS Charge" <> '' then begin
                    BankingUserSetup.get(userid);
                    BankingUserSetup.TestField("Cashier Journal Template");
                    BankingUserSetup.TestField("Cashier Journal Batch");
                    SavingsAccounts.SetLoadFields("Member No.", "Product Type");
                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Member No.", SMSAlertsLines."Member No");
                    SavingsAccounts.setrange("Product Type", '191');
                    if SavingsAccounts.FindFirst() then begin
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."Loan SMS Charge");
                        if TransactionCharges.FindSet() then begin
                            repeat
                                LineNo := LineNo + 10000;
                                AccType := Acctype::Savings;
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, rec."No.", 'SMS Charges - ' + format(rec."Notice Type"), TransactionCharges."Charge Amount", SavingsAccounts."No.", Today, TransactionCharges."Account Type",
                                TransactionCharges."G/L Account", '', BankingUserSetup."Global Dimension 1 Code", BankingUserSetup."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                //Excise duty
                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Savings;
                                    TransType := Transtype::" ";
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, rec."No.", 'SMS charge excise duty - ' + format(rec."Notice Type"), round((TransactionCharges."Charge Amount" * Gensetup."Excise Duty (%)" * 0.01), 0.01, '<'), SavingsAccounts."No.", Today, TransactionCharges."Account Type"::"G/L Account",
                                    GenSetup."Excise Duty G/L", '', BankingUserSetup."Global Dimension 1 Code", BankingUserSetup."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                    end;
                end;
                SendSMS.SendSms(Source::DMU, SMSAlertsLines."Phone Number", SMSAlertsLines.Notice, Format(Rec."No."), '', true, 0, false, 'CBS', Rec."No.", 'CBS');
                SMSAlertsLines."SMS Sent" := true;
                SMSAlertsLines."Time Sent" := CurrentDateTime;
                SMSAlertsLines."Sent By" := UserId;
                SMSAlertsLines.Modify();
            until SMSAlertsLines.Next() = 0;
        end;

        SMSAlertsLines.Reset();
        SMSAlertsLines.SetRange("Header No", Rec."No.");
        SMSAlertsLines.SetRange("Email Sent", false);
        SMSAlertsLines.SetRange("Notice Type", SMSAlertsLines."Notice Type"::Email);
        SMSAlertsLines.SetRange("Send this Notification", true);
        SMSAlertsLines.SetFilter("Email Address", '<>%1', '');
        if SMSAlertsLines.FindSet() then begin
            repeat
                //     if CheckEmailValid(SMSAlertsLines."Email Address") then begin
                //         if SMSAlertsLines."Email Address" <> '' then begin
                //             Emailmsg.Create(SMSAlertsLines."Email Address", SMSAlertsLines."Member No", ' ', true);
                //             Emailmsg.AppendToBody(SMSAlertsLines.Notice);
                //             if Email.Send(Emailmsg) then begin
                //                 SMSAlertsLines."Email Sent" := true;
                //                 SMSAlertsLines.Modify();
                //             end;
                //         end;
                //     end;
                SMSAlertsLines."Email Sent" := true;
                SMSAlertsLines."Time Sent" := CurrentDateTime;
                SMSAlertsLines."Sent By" := UserId;
                SMSAlertsLines.Modify();
            until SMSAlertsLines.Next() = 0;

        end;
    end;

    local procedure LoanHasArrears(LoanNo: Code[50]): Boolean
    begin
        if Loans.Get(LoanNo) then begin
            Loans.CalcFields("Days In Arrears");
            if Loans."Days In Arrears" > 0 then
                exit(true)
            else
                exit(false);
        end;
    end;

    local procedure LoanIsInFallOff(LoanNo: Code[50]): Boolean
    begin
        if Loans.Get(LoanNo) then begin
            Loans.CalcFields("Installments FallOff");
            if Loans."Installments FallOff" > 0 then
                exit(true)
            else
                exit(false);
        end;
    end;


    [TryFunction]
    local procedure CheckEmailValid(EmailAddress: Text)
    var
        MailManagement: Codeunit "Mail Management";
    begin
        MailManagement.CheckValidEmailAddresses(EmailAddress);
    end;


    local procedure GenerateLetters()
    var
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FileMgt: Codeunit "File Management";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        FileNameArchive: Text;
        OutS: OutStream;
        Zip: Codeunit "Data Compression";
        InS: InStream;

        FilePath: Text;
        AlertsLinesII: Record "SMS Alerts Lines";
        AlertsLines: Record "SMS Alerts Lines";
        OutStr: OutStream;
        PdfMimeType: Text[30];
        InStreamVar: InStream;
        BlobOutStream: OutStream;
        FieldOutStream: OutStream;
        BlobInStream: InStream;
        FileContentsB64: Text;
        Base64Convert: Codeunit "Base64 Convert";
        GuarantorNoticeLetters: record "Guarantor Notice Letters";
        ReportParameters: Text;
        XmlDoc: XmlDocument;
        Alerts: List of [Integer];
        i: Integer;
        Guars: Integer;
    begin
        // Zip.CreateZipArchive();
        clear(AlertsLinesII);
        clear(Alerts);
        GuarantorNoticeLetters.reset();
        GuarantorNoticeLetters.setrange("Header No", rec."No.");
        GuarantorNoticeLetters.deleteall();

        AlertsLinesII.Reset();
        AlertsLinesII.SetRange("Header No", Rec."No.");
        AlertsLinesII.SetRange("Notice Type", AlertsLinesII."Notice Type"::Letter);
        AlertsLinesII.SetRange(Recepient, AlertsLinesII.Recepient::Guarantor);
        if AlertsLinesII.FindFirst() then
            repeat
                Alerts.Add(AlertsLinesII."Entry No");
            until AlertsLinesII.Next() = 0;

        Guars := Alerts.Count();
        // Message(Format(Guars));

        for i := 1 to Guars do begin
            if AlertsLines.Get(Alerts.Get(i)) then begin
                Clear(TempBlob);
                Clear(RecRef);

                RecRef.GetTable(AlertsLines);
                RecRef.SetRecFilter;   // scope RecRef to exactly this one record

                TempBlob.CreateOutStream(OutS);

                Report.SaveAs(
                    Report::"Guarantor Notice",
                    '',
                    ReportFormat::Pdf,
                    OutS,
                    RecRef
                );

                GuarantorNoticeLetters.Init();
                GuarantorNoticeLetters.EntryNo := AlertsLines."Entry No";
                GuarantorNoticeLetters."Loan No" := AlertsLines."Loan No";
                GuarantorNoticeLetters."Header No" := AlertsLines."Header No";
                GuarantorNoticeLetters."Recipient Member No" := AlertsLines."Member No";
                GuarantorNoticeLetters.Recepient := AlertsLines.Recepient;

                GuarantorNoticeLetters.Letter.CreateOutStream(OutS);
                TempBlob.CreateInStream(InS);
                CopyStream(OutS, InS);

                GuarantorNoticeLetters.Insert();
            end;
        end;
    end;

    local procedure AreThereLetters(): Boolean
    var
    begin
        SMSAlertsLines.Reset();
        SMSAlertsLines.SetRange("Header No", Rec."No.");
        SMSAlertsLines.SetRange("Notice Type", SMSAlertsLines."Notice Type"::Letter);
        if SMSAlertsLines.Find('-') then
            exit(true)
        else
            exit(false);
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
        LoanLinesEditable: Boolean;
        EmployercodeEditable: Boolean;
        PeriodEditable: Boolean;
        CreateAttachmentHeadersEnabled: Boolean;

        NoticeCategory: Option "First Notice","Second Notice","CRB Notice","CRB Listing Notice","Arrears Alert";
        Receipient: Option "Lonee","Guarantor";
        NoticeType: Option SMS,Email,Letter;

        /*The 9 modulus*/
        ReceipientsName: Text;
        LoanDescription: Text;
        AmountInArrears: Decimal;
        TotalBal: Decimal;
        LoaneeFirstName: Text;
        LoaneeMemberNumber: Code[30];
        MonthlRepayment: Decimal;
        LastRepaymentDate: Date;
        LoaneeLoanNo: Code[50];
        /*The 9 modulus*/



        DaysInArreas: Integer;
        sms: Text;
        PhoneNumber: Text;
        Email: Text;
        OutInt: Decimal;
        OutBal: Decimal;
        LoanNo: Code[30];

        SendSecondNotice: Boolean;
        RunLoan: Boolean;
        PreviousPeriod: Date;
        PreviousHeaderNo: Code[30];
        SendFirstNotice: Boolean;
        MarkForAttachment: Boolean;

        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SMSAlertsLines: Record "SMS Alerts Lines";
        SendSMS: Codeunit SendSms;
        Source: enum "SMS Source";
        LoanProcess: Codeunit "Loans Process";
        SMSTemplates: Record "DMU SMS Templates";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        SMSLines: Record "SMS Alerts Lines";
        Members: Record Members;
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        LoanGuarantors: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        PreviousHeader: Record "SMS Alerts Header";
        AlertLines: Record "SMS Alerts Lines";
        PreviousAlertLoanLines: Record "Alerts Loan Lines";
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

        Notices: Dictionary of [Text, Text];

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
}

