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
                    ToolTip = 'Unique code identifying the event e.g. LEAVE-APPROVAL. Must match exactly what the dispatcher passes.';
                }
                field("Recipient Role"; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Who receives this email for this event.';
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
                    ToolTip = 'When off the dispatcher silently skips this template. No email is sent.';
                }
                field("CC Email"; Rec."CC Email")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Optional fixed CC address. Leave blank for none.';
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
                field(TestEmailAddress; TestEmailAddress)
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Email Address';
                    ToolTip = 'Enter an email address here then click Test Send to preview this template.';
                }
            }

            group(EmailContent)
            {
                Caption = 'Email Content';

                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Email subject. Use %1 %2 etc for placeholders. See the Variables tab for what each placeholder means.';
                }
                field(BodyEditor; BodyText)
                {
                    ApplicationArea = Basic;
                    Caption = 'Body';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ToolTip = 'Full HTML email body. Use %1 %2 etc for placeholders defined in the Variables tab below.';

                    trigger OnValidate()
                    begin
                        Rec.SetBody(BodyText);
                    end;
                }
            }

            part(Variables; "HR Email Template Variables")
            {
                ApplicationArea = Basic;
                Caption = 'Placeholder Variables';
                SubPageLink = "Event Code" = field("Event Code");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(README)
            {
                ApplicationArea = Basic;
                Caption = 'Placeholder Reference';
                Image = Info;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Shows all defined placeholders for this template and what values they represent.';

                trigger OnAction()
                var
                    Vars: Record "HR Email Template Variables";
                    ReadmeText: Text;
                begin
                    Vars.Reset();
                    Vars.SetRange("Event Code", Rec."Event Code");
                    if Vars.IsEmpty then begin
                        Message('NO PLACEHOLDERS DEFINED FOR THIS TEMPLATE. ADD ROWS IN THE VARIABLES TAB BELOW.');
                        exit;
                    end;

                    ReadmeText := 'PLACEHOLDER REFERENCE FOR: ' + Rec."Event Code" + '\';
                    ReadmeText += '----------------------------------------\';
                    if Vars.FindSet() then
                        repeat
                            ReadmeText += Vars.Placeholder + '  =  ' + Vars."Variable Name" + '\';
                            if Vars.Description <> '' then
                                ReadmeText += '    (' + Vars.Description + ')\';
                        until Vars.Next() = 0;

                    Message(ReadmeText);
                end;
            }

            action("Test Send")
            {
                ApplicationArea = Basic;
                Caption = 'Test Send';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send a test email to a specified address with placeholder values shown as labels so you can preview the layout.';

                trigger OnAction()
                var
                    Dispatcher: Codeunit "HR Email Dispatcher";
                    Vars: array[10] of Text;
                    i: Integer;
                    VarRec: Record "HR Email Template Variables";
                begin
                    Rec.TestField("Event Code");
                    Rec.TestField(Subject);

                    if not Rec.Enabled then
                        if not Confirm('THIS TEMPLATE IS CURRENTLY DISABLED. SEND TEST ANYWAY?', false) then
                            exit;

                    if TestEmailAddress = '' then begin
                        Message('ENTER A TEST EMAIL ADDRESS IN THE "TEST EMAIL ADDRESS" FIELD BELOW THE ACTIONS BAR BEFORE USING TEST SEND.');
                        exit;
                    end;

                    // POPULATE DUMMY VARS FROM VARIABLE DEFINITIONS
                    VarRec.Reset();
                    VarRec.SetRange("Event Code", Rec."Event Code");
                    if VarRec.FindSet() then
                        repeat
                            for i := 1 to 10 do
                                if VarRec.Placeholder = '%' + Format(i) then
                                    Vars[i] := '[' + VarRec."Variable Name" + ']';
                        until VarRec.Next() = 0;

                    // FILL REMAINING EMPTY VARS WITH GENERIC LABELS
                    for i := 1 to 10 do
                        if Vars[i] = '' then
                            Vars[i] := '[VALUE_' + Format(i) + ']';

                    Dispatcher.SendToAddress(
                        Rec."Event Code",
                        Rec."Recipient Role",
                        TestEmailAddress,
                        'TEST',
                        Vars
                    );

                    Message('TEST EMAIL SENT TO %1. CHECK YOUR INBOX.', TestEmailAddress);
                end;
            }

            action("View Send Log")
            {
                ApplicationArea = Basic;
                Caption = 'Send Log';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View all send attempts for this event code.';

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

    trigger OnAfterGetRecord()
    begin
        BodyText := Rec.GetBody();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        BodyText := Rec.GetBody();
    end;

    var
        BodyText: Text;
        TestEmailAddress: Text[100];
}
