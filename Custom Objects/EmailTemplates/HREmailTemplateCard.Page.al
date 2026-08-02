page 52185918 "HR Email Template Card"
{
    Caption = 'HR Email Template';
    PageType = Card;
    SourceTable = "HR Email Template";
    ApplicationArea = Basic;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Select the event that triggers this email. Picking from the list ensures tokens and default body are loaded correctly.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        EventCodes: Text;
                        Selected: Integer;
                    begin
                        // SHOW STANDARD EVENT CODES — HR PICKS FROM LIST
                        EventCodes :=
                            'LEAVE-APPROVAL' + ',' +
                            'LEAVE-RELIEVER' + ',' +
                            'LEAVE-RECALL' + ',' +
                            'APPRAISAL-SUBMITTED' + ',' +
                            'APPRAISAL-APPROVED' + ',' +
                            'CEO-GOAL-ASSIGNED' + ',' +
                            'HOD-GOAL-ACKNOWLEDGED';

                        Selected := Dialog.StrMenu(EventCodes, 0, 'Select the event for this email template:');

                        case Selected of
                            1: Text := 'LEAVE-APPROVAL';
                            2: Text := 'LEAVE-RELIEVER';
                            3: Text := 'LEAVE-RECALL';
                            4: Text := 'APPRAISAL-SUBMITTED';
                            5: Text := 'APPRAISAL-APPROVED';
                            6: Text := 'CEO-GOAL-ASSIGNED';
                            7: Text := 'HOD-GOAL-ACKNOWLEDGED';
                            else exit(false);
                        end;

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        // SEED TOKENS AND DEFAULT BODY IMMEDIATELY ON VALID EVENT CODE SELECTION
                        if Rec."Event Code" <> '' then begin
                            if not SystemTokensExist(Rec."Event Code") then
                                SeedSystemTokens(Rec."Event Code");
                            if Rec.GetBody() = '' then
                                Rec.SetBody(GetDefaultBody(Rec."Event Code"));
                        end;
                        CurrPage.Variables.Page.Update(false);
                    end;
                }
                field("Recipient Role"; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Enabled;
                    ToolTip = 'When off the dispatcher silently skips this template.';
                }
                field("CC Email"; Rec."CC Email")
                {
                    ApplicationArea = Basic;
                }
                field(TestEmailAddress; TestEmailAddress)
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Email Address';
                    ToolTip = 'Enter an address here then click Test Send to preview this template.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group(EmailContent)
            {
                Caption = 'Email Content';

                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Subject line. Paste tokens from the Variables tab e.g. [EMPLOYEE_NAME].';
                }
            }

            // VARIABLES ABOVE BODY AREA SO USER SEES TOKENS BEFORE OPENING EDITOR
            group(TokenReference)
            {
                Caption = 'Available Tokens';

                part(Variables; "HR Email Template Variables")
                {
                    ApplicationArea = Basic;
                    SubPageLink = "Event Code" = field("Event Code");
                    UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Initialise Template")
            {
                ApplicationArea = Basic;
                Caption = 'Initialise Template';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Seeds the system tokens and loads the default email body for the selected event. Run this once after creating a new template.';

                trigger OnAction()
                begin
                    Rec.TestField("Event Code");

                    if not Confirm('Initialise tokens and default body for event "%1"? Existing tokens will be preserved.', true, Rec."Event Code") then
                        exit;

                    SeedSystemTokens(Rec."Event Code");

                    if Rec.GetBody() = '' then
                        Rec.SetBody(GetDefaultBody(Rec."Event Code"));

                    CurrPage.Update(true);
                    Message('TEMPLATE INITIALISED. USE "EDIT BODY" TO COMPOSE THE EMAIL BODY.');
                end;
            }

            action("Edit Body")
            {
                ApplicationArea = Basic;
                Caption = 'Edit Body';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open the email body editor. Use tokens from the Variables tab e.g. [EMPLOYEE_NAME].';

                trigger OnAction()
                var
                    BodyEditorPage: Page "HR Email Body Editor";
                begin
                    Rec.TestField("Event Code");
                    BodyEditorPage.SetTemplate(Rec);
                    BodyEditorPage.RunModal();
                    CurrPage.Update(false);
                end;
            }

            action("Test Send")
            {
                ApplicationArea = Basic;
                Caption = 'Test Send';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send a preview email to the Test Email Address with token labels substituted.';

                trigger OnAction()
                var
                    Dispatcher: Codeunit "HR Email Dispatcher";
                    VarRec: Record "HR Email Template Variables";
                    TokenVals: Text;
                begin
                    Rec.TestField("Event Code");
                    Rec.TestField(Subject);

                    if TestEmailAddress = '' then
                        Error('ENTER A TEST EMAIL ADDRESS BEFORE CLICKING TEST SEND.');

                    if not Rec.Enabled then
                        if not Confirm('THIS TEMPLATE IS DISABLED. SEND TEST ANYWAY?', false) then
                            exit;

                    // BUILD DUMMY TokenVals — SHOWS VARIABLE NAME LABELS INSTEAD OF REAL VALUES
                    TokenVals := '';
                    VarRec.Reset();
                    VarRec.SetRange("Event Code", Rec."Event Code");
                    VarRec.SetRange("System Defined", true);
                    if VarRec.FindSet() then
                        repeat
                            if TokenVals <> '' then
                                TokenVals += '||';
                            TokenVals += DelChr(DelChr(Format(VarRec.Token), '=', '['), '=', ']') +
                                         '=[' + VarRec."Variable Name" + ']';
                        until VarRec.Next() = 0;

                    Dispatcher.SendToAddress(
                        Rec."Event Code",
                        Rec."Recipient Role",
                        TestEmailAddress,
                        'TEST',
                        TokenVals
                    );

                    Message('TEST EMAIL SENT TO %1.', TestEmailAddress);
                end;
            }

            action("View Send Log")
            {
                ApplicationArea = Basic;
                Caption = 'Send Log';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View all send attempts for this event.';

                trigger OnAction()
                var
                    Log: Record "HR Email Notification Log";
                    LogPage: Page "HR Email Notification Log";
                begin
                    Log.SetRange("Event Code", Rec."Event Code");
                    LogPage.SetTableView(Log);
                    LogPage.RunModal();
                end;
            }
        }
    }

    // SEED AFTER RECORD IS COMMITTED
    trigger OnAfterGetRecord()
    begin
        if Rec."Event Code" <> '' then begin
            if not SystemTokensExist(Rec."Event Code") then
                SeedSystemTokens(Rec."Event Code");
        end;
    end;

    local procedure SeedSystemTokens(EventCode: Code[50])
    begin
        case EventCode of
            'LEAVE-APPROVAL':
                begin
                    InsertSystemToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Full name of the leave applicant', 1);
                    InsertSystemToken(EventCode, '[LEAVE_TYPE]', 'Leave Type', 'Type of leave applied for', 2);
                    InsertSystemToken(EventCode, '[START_DATE]', 'Start Date', 'First day of approved leave', 3);
                    InsertSystemToken(EventCode, '[END_DATE]', 'End Date', 'Last day of approved leave', 4);
                    InsertSystemToken(EventCode, '[DAYS_APPROVED]', 'Days Approved', 'Number of leave days approved', 5);
                    InsertSystemToken(EventCode, '[RETURN_DATE]', 'Return Date', 'Date employee is expected back at work', 6);
                    InsertSystemToken(EventCode, '[APPLICATION_CODE]', 'Application Code', 'Leave application reference number', 7);
                end;
            'LEAVE-RELIEVER':
                begin
                    InsertSystemToken(EventCode, '[RELIEVER_NAME]', 'Reliever Name', 'Full name of the reliever', 1);
                    InsertSystemToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Name of the employee going on leave', 2);
                    InsertSystemToken(EventCode, '[LEAVE_TYPE]', 'Leave Type', 'Type of leave', 3);
                    InsertSystemToken(EventCode, '[START_DATE]', 'Start Date', 'First day of leave', 4);
                    InsertSystemToken(EventCode, '[END_DATE]', 'End Date', 'Last day of leave', 5);
                    InsertSystemToken(EventCode, '[RETURN_DATE]', 'Return Date', 'Date employee returns', 6);
                    InsertSystemToken(EventCode, '[APPLICATION_CODE]', 'Application Code', 'Leave application reference number', 7);
                end;
            'LEAVE-RECALL':
                begin
                    InsertSystemToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Full name of the recalled employee', 1);
                    InsertSystemToken(EventCode, '[LEAVE_APP_CODE]', 'Leave Application Code', 'Reference of the leave being recalled from', 2);
                    InsertSystemToken(EventCode, '[RECALL_DATE]', 'Recall Date', 'Date employee must return to work', 3);
                    InsertSystemToken(EventCode, '[DAYS_RECALLED]', 'Days Recalled', 'Number of leave days recalled', 4);
                    InsertSystemToken(EventCode, '[REASON]', 'Reason', 'Reason for the recall', 5);
                    InsertSystemToken(EventCode, '[RECALL_END_DATE]', 'Recall End Date', 'Last day of the recall period', 6);
                end;
            'APPRAISAL-SUBMITTED':
                begin
                    InsertSystemToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Name of the appraisee', 1);
                    InsertSystemToken(EventCode, '[APPRAISAL_NO]', 'Appraisal No', 'Appraisal reference number', 2);
                    InsertSystemToken(EventCode, '[SUPERVISOR_NAME]', 'Supervisor Name', 'Name of the supervisor', 3);
                    InsertSystemToken(EventCode, '[SUBMISSION_DATE]', 'Submission Date', 'Date appraisal was submitted', 4);
                end;
            'APPRAISAL-APPROVED':
                begin
                    InsertSystemToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Name of the appraisee', 1);
                    InsertSystemToken(EventCode, '[APPRAISAL_NO]', 'Appraisal No', 'Appraisal reference number', 2);
                    InsertSystemToken(EventCode, '[SUPERVISOR_NAME]', 'Supervisor Name', 'Approving supervisor name', 3);
                    InsertSystemToken(EventCode, '[APPROVAL_DATE]', 'Approval Date', 'Date appraisal was approved', 4);
                    InsertSystemToken(EventCode, '[TOTAL_AGREED_RATING]', 'Total Agreed Rating', 'Final agreed performance rating', 5);
                end;
            'CEO-GOAL-ASSIGNED':
                begin
                    InsertSystemToken(EventCode, '[HOD_NAME]', 'HOD Name', 'Name of the HOD receiving the goal', 1);
                    InsertSystemToken(EventCode, '[GOAL_NO]', 'Goal No', 'CEO goal reference number', 2);
                    InsertSystemToken(EventCode, '[GOAL_TITLE]', 'Goal Title', 'Title of the CEO goals document', 3);
                    InsertSystemToken(EventCode, '[OBJECTIVE]', 'Objective', 'The specific goal objective assigned', 4);
                    InsertSystemToken(EventCode, '[TARGETED_SCORE]', 'Targeted Score', 'Target score for this goal', 5);
                    InsertSystemToken(EventCode, '[CEO_NAME]', 'CEO Name', 'Name of the CEO who assigned the goal', 6);
                end;
            'HOD-GOAL-ACKNOWLEDGED':
                begin
                    InsertSystemToken(EventCode, '[HOD_NAME]', 'HOD Name', 'Name of the acknowledging HOD', 1);
                    InsertSystemToken(EventCode, '[GOAL_NO]', 'Goal No', 'CEO goal reference number', 2);
                    InsertSystemToken(EventCode, '[ACKNOWLEDGED_DATE]', 'Acknowledged Date', 'Date HOD acknowledged the goal', 3);
                    InsertSystemToken(EventCode, '[CEO_NAME]', 'CEO Name', 'Name of the CEO', 4);
                end;
        end;
    end;

    local procedure InsertSystemToken(EventCode: Code[50]; Token: Code[50]; VarName: Text[100]; Descr: Text[250]; SortOrder: Integer)
    var
        Vars: Record "HR Email Template Variables";
    begin
        if Vars.Get(EventCode, Token) then
            exit;
        Vars.Init();
        Vars."Event Code" := EventCode;
        Vars.Token := Token;
        Vars."Variable Name" := VarName;
        Vars.Description := Descr;
        Vars."System Defined" := true;
        Vars."Sort Order" := SortOrder;
        Vars.Insert();
    end;

    local procedure SystemTokensExist(EventCode: Code[50]): Boolean
    var
        Vars: Record "HR Email Template Variables";
    begin
        Vars.Reset();
        Vars.SetRange("Event Code", EventCode);
        Vars.SetRange("System Defined", true);
        exit(not Vars.IsEmpty);
    end;

    local procedure GetDefaultBody(EventCode: Code[50]): Text
    begin
        case EventCode of
            'LEAVE-APPROVAL':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[EMPLOYEE_NAME]</strong>,</p>' +
                    '<p>Your leave application has been <strong>approved</strong>.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Application No.</strong></td><td style="padding:8px;border:1px solid #ddd;">[APPLICATION_CODE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Leave Type</strong></td><td style="padding:8px;border:1px solid #ddd;">[LEAVE_TYPE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Start Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[START_DATE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>End Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[END_DATE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Days Approved</strong></td><td style="padding:8px;border:1px solid #ddd;">[DAYS_APPROVED]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Return Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[RETURN_DATE]</td></tr>' +
                    '</table>' +
                    '<p>Please ensure your reliever is briefed before your leave commences.</p>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
            'LEAVE-RELIEVER':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[RELIEVER_NAME]</strong>,</p>' +
                    '<p>You have been assigned as reliever for <strong>[EMPLOYEE_NAME]</strong>.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Leave Type</strong></td><td style="padding:8px;border:1px solid #ddd;">[LEAVE_TYPE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Start Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[START_DATE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>End Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[END_DATE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Return Date</strong></td><td style="padding:8px;border:1px solid #ddd;">[RETURN_DATE]</td></tr>' +
                    '</table>' +
                    '<p>Please ensure you are available to cover responsibilities during this period.</p>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
            'LEAVE-RECALL':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[EMPLOYEE_NAME]</strong>,</p>' +
                    '<p>You have been <strong>recalled from leave</strong> effective <strong>[RECALL_DATE]</strong>.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Leave Application</strong></td><td style="padding:8px;border:1px solid #ddd;">[LEAVE_APP_CODE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Recall Date</strong></td><td style="padding:8px;border:1px solid #ddd;color:#d9534f;"><strong>[RECALL_DATE]</strong></td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Days Recalled</strong></td><td style="padding:8px;border:1px solid #ddd;">[DAYS_RECALLED]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Reason</strong></td><td style="padding:8px;border:1px solid #ddd;">[REASON]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Recall Period Ends</strong></td><td style="padding:8px;border:1px solid #ddd;">[RECALL_END_DATE]</td></tr>' +
                    '</table>' +
                    '<p>The recalled days have been reimbursed to your leave balance.</p>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
            'APPRAISAL-SUBMITTED':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[SUPERVISOR_NAME]</strong>,</p>' +
                    '<p><strong>[EMPLOYEE_NAME]</strong> has submitted their appraisal for your review.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Appraisal No.</strong></td><td style="padding:8px;border:1px solid #ddd;">[APPRAISAL_NO]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Submitted On</strong></td><td style="padding:8px;border:1px solid #ddd;">[SUBMISSION_DATE]</td></tr>' +
                    '</table>' +
                    '<p>Please log in to review and rate the appraisal.</p>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
            'APPRAISAL-APPROVED':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[EMPLOYEE_NAME]</strong>,</p>' +
                    '<p>Your appraisal has been <strong>approved</strong> by <strong>[SUPERVISOR_NAME]</strong>.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Appraisal No.</strong></td><td style="padding:8px;border:1px solid #ddd;">[APPRAISAL_NO]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Approved On</strong></td><td style="padding:8px;border:1px solid #ddd;">[APPROVAL_DATE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Total Agreed Rating</strong></td><td style="padding:8px;border:1px solid #ddd;">[TOTAL_AGREED_RATING]</td></tr>' +
                    '</table>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
            'CEO-GOAL-ASSIGNED':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[HOD_NAME]</strong>,</p>' +
                    '<p>A CEO institutional goal has been assigned to your department by <strong>[CEO_NAME]</strong>.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Goal Reference</strong></td><td style="padding:8px;border:1px solid #ddd;">[GOAL_NO]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Goals Document</strong></td><td style="padding:8px;border:1px solid #ddd;">[GOAL_TITLE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Objective</strong></td><td style="padding:8px;border:1px solid #ddd;">[OBJECTIVE]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Targeted Score</strong></td><td style="padding:8px;border:1px solid #ddd;">[TARGETED_SCORE]</td></tr>' +
                    '</table>' +
                    '<p>Please log in to acknowledge and incorporate this goal into your department targets.</p>' +
                    '<p>Regards,<br><strong>[CEO_NAME]</strong></p>' +
                    '</body></html>'
                );
            'HOD-GOAL-ACKNOWLEDGED':
                exit(
                    '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
                    '<p>Dear <strong>[CEO_NAME]</strong>,</p>' +
                    '<p><strong>[HOD_NAME]</strong> has acknowledged the CEO goal assignment.</p>' +
                    '<table style="border-collapse:collapse;width:100%;margin:16px 0;">' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;width:40%;"><strong>Goal Reference</strong></td><td style="padding:8px;border:1px solid #ddd;">[GOAL_NO]</td></tr>' +
                    '<tr><td style="padding:8px;border:1px solid #ddd;"><strong>Acknowledged On</strong></td><td style="padding:8px;border:1px solid #ddd;">[ACKNOWLEDGED_DATE]</td></tr>' +
                    '</table>' +
                    '<p>Regards,<br><strong>HR Department</strong></p>' +
                    '</body></html>'
                );
        end;
        exit(
            '<html><body style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#333;">' +
            '<p>Dear <strong>[RECIPIENT_NAME]</strong>,</p>' +
            '<p>This is an automated notification from the HR Management System.</p>' +
            '<p>Regards,<br><strong>HR Department</strong></p>' +
            '</body></html>'
        );
    end;

    var
        TestEmailAddress: Text[100];
}
