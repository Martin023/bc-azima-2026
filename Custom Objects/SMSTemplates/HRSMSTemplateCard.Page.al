page 52185960 "HR SMS Template Card"
{
    Caption = 'HR SMS Template';
    PageType = Card;
    SourceTable = "HR SMS Template";
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
                    ToolTip = 'Select the event that triggers this SMS. Picking from the list seeds the tokens automatically.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        EventCodes: Text;
                        Selected: Integer;
                    begin
                        // SAME 7 EVENTS AS EMAIL — CONSISTENT ACROSS BOTH CHANNELS
                        EventCodes :=
                            'LEAVE-APPROVAL' + ',' +
                            'LEAVE-RELIEVER' + ',' +
                            'LEAVE-RECALL' + ',' +
                            'APPRAISAL-SUBMITTED' + ',' +
                            'APPRAISAL-APPROVED' + ',' +
                            'CEO-GOAL-ASSIGNED' + ',' +
                            'HOD-GOAL-ACKNOWLEDGED';

                        Selected := Dialog.StrMenu(EventCodes, 0, 'Select the event for this SMS template:');

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
                        if Rec."Event Code" <> '' then begin
                            // SEED SOURCE AND DEFAULT SMS SOURCE PER EVENT
                            if Rec."SMS Source" = Rec."SMS Source"::NEW_MEMBER then
                                SetDefaultSMSSource(Rec."Event Code");

                            if not SystemTokensExist(Rec."Event Code") then
                                SeedSystemTokens(Rec."Event Code");

                            if Rec.Body = '' then
                                Rec.Body := GetDefaultBody(Rec."Event Code");
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
                field("SMS Source"; Rec."SMS Source")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Controls the priority and category in the Sky SMS queue.';
                }
                field(TestPhoneNo; TestPhoneNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Phone No.';
                    ToolTip = 'Enter a phone number here then click Test Send to preview this template with dummy values.';
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

            // TOKENS VISIBLE BEFORE BODY — USER SEES WHAT TO TYPE
            group(TokenReference)
            {
                Caption = 'Available Tokens — Paste a token into the message body below';

                part(Variables; "HR SMS Template Variables")
                {
                    ApplicationArea = Basic;
                    SubPageLink = "Event Code" = field("Event Code");
                    UpdatePropagation = Both;
                }
            }

            group(MessageContent)
            {
                Caption = 'Message';

                field(Body; Rec.Body)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    ShowMandatory = true;
                    ToolTip = 'SMS message body. Max 320 characters. Use tokens e.g. [EMPLOYEE_NAME]. Shorter is better — aim for 160 chars to avoid split messages.';

                    trigger OnValidate()
                    begin
                        // WARN IF OVER 160 CHARS — WILL SEND AS MULTI-PART SMS
                        if StrLen(Rec.Body) > 160 then
                            Message('NOTE: MESSAGE IS %1 CHARACTERS. MESSAGES OVER 160 WILL BE SENT AS MULTI-PART SMS AND COUNT AS 2 OR MORE MESSAGES.', StrLen(Rec.Body));
                    end;
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
                ToolTip = 'Seeds the system tokens and loads the default message body for the selected event.';

                trigger OnAction()
                begin
                    Rec.TestField("Event Code");

                    if not Confirm('Initialise tokens and default body for event "%1"? Existing tokens will be preserved.', true, Rec."Event Code") then
                        exit;

                    SeedSystemTokens(Rec."Event Code");
                    SetDefaultSMSSource(Rec."Event Code");

                    if Rec.Body = '' then
                        Rec.Body := GetDefaultBody(Rec."Event Code");

                    CurrPage.Update(true);
                    Message('TEMPLATE INITIALISED. EDIT THE BODY ABOVE AS NEEDED.');
                end;
            }

            action("Test Send")
            {
                ApplicationArea = Basic;
                Caption = 'Test Send';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send a test SMS to the Test Phone No. with token labels substituted.';

                trigger OnAction()
                var
                    SmsCU: Codeunit SendSms;
                    VarRec: Record "HR SMS Template Variables";
                    TokenVals: Text;
                    ResolvedBody: Text;
                begin
                    Rec.TestField("Event Code");
                    Rec.TestField(Body);

                    if TestPhoneNo = '' then
                        Error('ENTER A TEST PHONE NUMBER BEFORE CLICKING TEST SEND.');

                    if not Rec.Enabled then
                        if not Confirm('THIS TEMPLATE IS DISABLED. SEND TEST ANYWAY?', false) then
                            exit;

                    // BUILD DUMMY TokenVals FROM VARIABLE DEFINITIONS
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

                    // RESOLVE AND SEND VIA SKY SMS QUEUE
                    ResolvedBody := Rec.Body;
                    VarRec.Reset();
                    VarRec.SetRange("Event Code", Rec."Event Code");
                    VarRec.SetRange("System Defined", true);
                    if VarRec.FindSet() then
                        repeat
                            ResolvedBody := ResolvedBody.Replace(
                                Format(VarRec.Token),
                                '[' + VarRec."Variable Name" + ']'
                            );
                        until VarRec.Next() = 0;

                    SmsCU.SendSms(
                        Rec."SMS Source",
                        TestPhoneNo,
                        ResolvedBody,
                        'TEST',
                        '',
                        false,
                        0,
                        false,
                        'HR',
                        'TEST',
                        'HR_MODULE'
                    );

                    Message('TEST SMS QUEUED FOR %1. IT WILL BE SENT BY THE SKY GATEWAY.', TestPhoneNo);
                end;
            }

            action("View Send Log")
            {
                ApplicationArea = Basic;
                Caption = 'Send Log';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Log: Record "HR SMS Notification Log";
                    LogPage: Page "HR SMS Notification Log";
                begin
                    Log.SetRange("Event Code", Rec."Event Code");
                    LogPage.SetTableView(Log);
                    LogPage.RunModal();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Event Code" <> '' then
            if not SystemTokensExist(Rec."Event Code") then
                SeedSystemTokens(Rec."Event Code");
    end;

    local procedure SetDefaultSMSSource(EventCode: Code[50])
    begin
        // MAP EVENT TO APPROPRIATE SMS SOURCE FOR PRIORITY ROUTING
        case EventCode of
            'LEAVE-APPROVAL', 'LEAVE-RELIEVER', 'LEAVE-RECALL':
                Rec."SMS Source" := Rec."SMS Source"::HR_LEAVE;
            'APPRAISAL-SUBMITTED', 'APPRAISAL-APPROVED':
                Rec."SMS Source" := Rec."SMS Source"::HR_APPRAISAL;
            'CEO-GOAL-ASSIGNED', 'HOD-GOAL-ACKNOWLEDGED':
                Rec."SMS Source" := Rec."SMS Source"::HR_GOALS;
        end;
    end;

    local procedure SeedSystemTokens(EventCode: Code[50])
    begin
        // SAME TOKEN SET AS EMAIL — CONSISTENT ACROSS BOTH CHANNELS
        case EventCode of
            'LEAVE-APPROVAL':
                begin
                    InsertToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Leave applicant full name', 1);
                    InsertToken(EventCode, '[LEAVE_TYPE]', 'Leave Type', 'Type of leave', 2);
                    InsertToken(EventCode, '[START_DATE]', 'Start Date', 'First day of leave', 3);
                    InsertToken(EventCode, '[END_DATE]', 'End Date', 'Last day of leave', 4);
                    InsertToken(EventCode, '[DAYS_APPROVED]', 'Days Approved', 'Number of days approved', 5);
                    InsertToken(EventCode, '[RETURN_DATE]', 'Return Date', 'Date to return to work', 6);
                    InsertToken(EventCode, '[APPLICATION_CODE]', 'Application Code', 'Leave application reference', 7);
                end;
            'LEAVE-RELIEVER':
                begin
                    InsertToken(EventCode, '[RELIEVER_NAME]', 'Reliever Name', 'Reliever full name', 1);
                    InsertToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Employee going on leave', 2);
                    InsertToken(EventCode, '[LEAVE_TYPE]', 'Leave Type', 'Type of leave', 3);
                    InsertToken(EventCode, '[START_DATE]', 'Start Date', 'Leave start date', 4);
                    InsertToken(EventCode, '[END_DATE]', 'End Date', 'Leave end date', 5);
                    InsertToken(EventCode, '[RETURN_DATE]', 'Return Date', 'Employee return date', 6);
                end;
            'LEAVE-RECALL':
                begin
                    InsertToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Recalled employee name', 1);
                    InsertToken(EventCode, '[RECALL_DATE]', 'Recall Date', 'Date to report back', 2);
                    InsertToken(EventCode, '[DAYS_RECALLED]', 'Days Recalled', 'Number of days recalled', 3);
                    InsertToken(EventCode, '[REASON]', 'Reason', 'Reason for recall', 4);
                    InsertToken(EventCode, '[LEAVE_APP_CODE]', 'Leave Application Code', 'Leave reference number', 5);
                end;
            'APPRAISAL-SUBMITTED':
                begin
                    InsertToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Appraisee name', 1);
                    InsertToken(EventCode, '[APPRAISAL_NO]', 'Appraisal No', 'Appraisal reference', 2);
                    InsertToken(EventCode, '[SUPERVISOR_NAME]', 'Supervisor Name', 'Supervisor name', 3);
                    InsertToken(EventCode, '[SUBMISSION_DATE]', 'Submission Date', 'Date submitted', 4);
                end;
            'APPRAISAL-APPROVED':
                begin
                    InsertToken(EventCode, '[EMPLOYEE_NAME]', 'Employee Name', 'Appraisee name', 1);
                    InsertToken(EventCode, '[APPRAISAL_NO]', 'Appraisal No', 'Appraisal reference', 2);
                    InsertToken(EventCode, '[SUPERVISOR_NAME]', 'Supervisor Name', 'Approving supervisor', 3);
                    InsertToken(EventCode, '[APPROVAL_DATE]', 'Approval Date', 'Date approved', 4);
                end;
            'CEO-GOAL-ASSIGNED':
                begin
                    InsertToken(EventCode, '[HOD_NAME]', 'HOD Name', 'HOD receiving the goal', 1);
                    InsertToken(EventCode, '[GOAL_NO]', 'Goal No', 'CEO goal reference', 2);
                    InsertToken(EventCode, '[OBJECTIVE]', 'Objective', 'Goal objective', 3);
                    InsertToken(EventCode, '[CEO_NAME]', 'CEO Name', 'CEO who assigned the goal', 4);
                end;
            'HOD-GOAL-ACKNOWLEDGED':
                begin
                    InsertToken(EventCode, '[HOD_NAME]', 'HOD Name', 'Acknowledging HOD', 1);
                    InsertToken(EventCode, '[GOAL_NO]', 'Goal No', 'CEO goal reference', 2);
                    InsertToken(EventCode, '[CEO_NAME]', 'CEO Name', 'CEO name', 3);
                end;
        end;
    end;

    local procedure InsertToken(EventCode: Code[50]; Token: Code[50]; VarName: Text[100]; Descr: Text[250]; SortOrder: Integer)
    var
        Vars: Record "HR SMS Template Variables";
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
        Vars: Record "HR SMS Template Variables";
    begin
        Vars.Reset();
        Vars.SetRange("Event Code", EventCode);
        Vars.SetRange("System Defined", true);
        exit(not Vars.IsEmpty);
    end;

    local procedure GetDefaultBody(EventCode: Code[50]): Text[320]
    begin
        // SHORT BODIES — AIM FOR UNDER 160 CHARS AFTER TOKEN SUBSTITUTION
        case EventCode of
            'LEAVE-APPROVAL':
                exit('Dear [EMPLOYEE_NAME], your [LEAVE_TYPE] leave from [START_DATE] to [END_DATE] ([DAYS_APPROVED] days) is approved. Return: [RETURN_DATE]. Ref: [APPLICATION_CODE]');
            'LEAVE-RELIEVER':
                exit('Dear [RELIEVER_NAME], you are covering [EMPLOYEE_NAME] who is on [LEAVE_TYPE] leave from [START_DATE] to [END_DATE]. Return date: [RETURN_DATE].');
            'LEAVE-RECALL':
                exit('Dear [EMPLOYEE_NAME], you are recalled from leave. Report on [RECALL_DATE]. Reason: [REASON]. Days reimbursed: [DAYS_RECALLED]. Ref: [LEAVE_APP_CODE]');
            'APPRAISAL-SUBMITTED':
                exit('Dear [SUPERVISOR_NAME], [EMPLOYEE_NAME] has submitted their appraisal [APPRAISAL_NO] for your review on [SUBMISSION_DATE]. Please log in to review.');
            'APPRAISAL-APPROVED':
                exit('Dear [EMPLOYEE_NAME], your appraisal [APPRAISAL_NO] has been approved by [SUPERVISOR_NAME] on [APPROVAL_DATE].');
            'CEO-GOAL-ASSIGNED':
                exit('Dear [HOD_NAME], a CEO goal has been assigned to your department by [CEO_NAME]. Ref: [GOAL_NO]. Objective: [OBJECTIVE]. Please log in to acknowledge.');
            'HOD-GOAL-ACKNOWLEDGED':
                exit('Dear [CEO_NAME], [HOD_NAME] has acknowledged goal [GOAL_NO].');
        end;
        exit('Dear employee, you have a new HR notification. Please log in for details.');
    end;

    var
        TestPhoneNo: Text[20];
}
