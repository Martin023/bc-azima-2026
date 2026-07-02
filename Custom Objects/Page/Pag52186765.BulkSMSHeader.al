page 52186765 "Bulk SMS Header"
{
    SourceTable = "Bulk SMS Header";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Defaulter Notification';
    layout
    {
        area(content)
        {
            field(No; Rec.No)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Date Entered"; Rec."Date Entered")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Time Entered"; Rec."Time Entered")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Entered By"; Rec."Entered By")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("SMS Type"; Rec."SMS Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("SMS Status"; Rec."SMS Status")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status Date"; Rec."Status Date")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status Time"; Rec."Status Time")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status By"; Rec."Status By")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field(Message_; Rec.Message_)
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
                ShowMandatory = true;
                MultiLine = true;
            }
            field("Use Line Message"; Rec."Use Line Message")
            {
                Caption = 'Use Line Messages';
                ApplicationArea = Basic, Suite;
                trigger OnValidate()
                begin
                    if rec."Use Line Message" then begin
                        rec.Message_ := '';
                        Mssage := false;
                    end;
                end;
            }
            // field("Approval Status"; Rec."Approval Status")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            // }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("SMS Source"; Rec."SMS Source")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("Email Subject"; rec."Email Subject")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
                Editable = Mssage;
            }
            field("Email Signature"; Rec."Email Signature")
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                Editable = Mssage;
                Caption = 'Email Signature';
            }
            field("Attachment Name"; Rec."Attachment Name")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                Caption = 'Attached File';
            }

            part(Control1000000012; "Bulk SMS Lines part")
            {
                ApplicationArea = Basic, Suite;
                Editable = BulkSMSLines;
                SubPageLink = No = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
                trigger OnAction()
                var
                    PhoneNo: Text[13];
                    SMSText: text[1000];
                    BulkLines: Record "Bulk SMS Lines";
                    SMSID: Guid;
                    SkySMS: Codeunit SendSms;
                    SMSSource: Enum "SMS Source";
                    MsgText: text[10000];
                begin
                    if rec."SMS Status" = rec."SMS Status"::Sent then
                        Error('This record has already been sent.');

                    // IF Rec.Status <> Rec.Status::Approved THEN
                    //     ERROR('This document requires approval');

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Post Reversals" = false then
                            Error('You do not have permission');
                    end;
                    if Confirm('Are you sure you would like to send the SMS(ES)?', false) = true then begin

                        if not Rec."Use Line Message" = true then begin
                            Rec.TestField(Message_);
                        end;

                        BulkLines.Reset;
                        BulkLines.SetRange(No, Rec.No);
                        if BulkLines.Find('-') then begin
                            repeat
                                if Members.get(BulkLines."Member No") then begin
                                    if rec."Use Line Message" then
                                        MsgText := BulkLines."Text Message"
                                    else
                                        MsgText := Rec.Message_;

                                    SkySMS.SendSms(
                                SMSSource::BULK_SMS,
                                Members."Transactional Mobile Number",
                                MsgText,
                                rec.No,
                                '',
                                false,
                                0,
                                false,
                                'CBS',
                                '',
                                'CBS');

                                    BulkLines.Sent := true;
                                    BulkLines.Modify();
                                end else begin
                                    if rec."Use Line Message" then
                                        MsgText := BulkLines."Text Message"
                                    else
                                        MsgText := Rec.Message_;

                                    SkySMS.SendSms(
                            SMSSource::BULK_SMS,
                            BulkLines."code",
                            MsgText,
                            rec.No,
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            '',
                            'CBS');
                                    BulkLines.Sent := true;
                                    BulkLines.Modify();
                                end;
                            until BulkLines.Next = 0
                        end else
                            Error('No members to send SMS to');

                        Rec."SMS Status" := Rec."SMS Status"::Sent;
                        Rec."Status Date" := Today;
                        Rec."Status Time" := Time;
                        Rec."Status By" := UserId;
                        Rec.Modify;
                    end
                    else begin
                        Message('Cancelled successfully');
                    end;
                end;
            }

            action("Import Telephone Nos")
            {
                Caption = 'Import Telephone/ Text Messages';
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

                trigger OnAction()
                begin
                    if Rec."SMS Type" <> Rec."SMS Type"::"Selected Members" then begin
                        Error('SMS Type must be: Selected Members.');
                    end;
                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No, Rec.No);
                    if BulkHeader.Find('-') then begin
                        XMLPORT.Run(Xmlport::"Import Telephone Nos");
                    end;
                end;
            }
            action("Suggest Members")
            {
                ApplicationArea = Basic, Suite;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

                trigger OnAction()
                begin
                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No, Rec.No);
                    if BulkHeader.Find('-') then begin
                        Report.RunModal(Report::"Generate Bulk SMS Lines", true, true, BulkHeader);
                    end;
                end;
            }
            action("Upload Attachment Media")
            {
                ApplicationArea = Basic, Suite;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Upload File';
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    if UploadIntoStream('Select file to attach', '', 'All Files (*.*)|*.*', FileName, InStr) then begin
                        Clear(Rec."Attachment");
                        Rec."Attachment".ImportStream(InStr, FileName);

                        Rec."Attachment Name" := CopyStr(FileName, 1, MaxStrLen(Rec."Attachment Name"));
                        Rec."Has Attachment" := true;
                        Rec.Modify();

                        Message('File uploaded: %1', FileName);
                    end;
                end;
            }
            //  action("Send Email")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PutawayLines;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
            //     trigger OnAction()
            //     var
            //         PhoneNo: Text[13];
            //         SMSText: text[1000];
            //         BulkLines: Record "Bulk SMS Lines";
            //         Email: Codeunit Email;
            //         EmailMsg: Codeunit "Email Message";
            //     begin
            //         if rec."SMS Status" = rec."SMS Status"::Sent then
            //             Error('This record has already been sent.');
            //         if rec."Email Subject" = '' then
            //             Error('Email Subject is required.');

            //         // IF Rec.Status <> Rec.Status::Approved THEN
            //         //     ERROR('This document requires approval');

            //         if UserSetup.Get(UserId) then begin
            //             if UserSetup."Post Reversals" = false then
            //                 Error('You do not have permission');
            //         end;

            //         if Rec."SMS Status" <> Rec."SMS Status"::Pending then
            //             Error('The mail status is not open');
            //         if Confirm('Are you sure you would like to send the Email(s)?', false) = true then begin

            //             if Rec."SMS Type" = Rec."SMS Type"::"Selected Members" then begin

            //             end;
            //             if not Rec."Use Line Message" = true then begin
            //                 Rec.TestField(Message_);
            //             end;

            //             BulkLines.Reset;
            //             BulkLines.SetRange(No, Rec.No);
            //             if BulkLines.Find('-') then begin
            //                 repeat
            //                     BulkLines.Validate("Text Message");
            //                     Members.Reset();
            //                     if Members.get(BulkLines."Member No") then begin
            //                         if members."E-Mail" <> '' then begin
            //                             if Rec."Use Line Message" then begin
            //                                 EmailMsg.Create(
            //                                     Members."E-Mail",
            //                                     rec."Email Subject",
            //                                     GetGreeting() + ' ' + Members."First Name" + ', ' + BulkLines."Text Message"
            //                                 );
            //                                 Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            //                             end
            //                             else
            //                                 if Rec.Message_ <> '' then begin
            //                                     EmailMsg.Create(
            //                                         Members."E-Mail",
            //                                         rec."Email Subject",
            //                                         GetGreeting() + ' ' + Members."First Name" + ', ' + Rec.Message_
            //                                     );
            //                                     Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            //                                 end;
            //                         end;
            //                         BulkLines.Sent := true;
            //                         BulkLines.Modify();
            //                     end;
            //                 until BulkLines.Next = 0
            //             end
            //             else
            //                 Error('No members to send Emails to');
            //         end;
            //         Rec."SMS Status" := Rec."SMS Status"::Sent;
            //         Rec."Status Date" := Today;
            //         Rec."Status Time" := Time;
            //         Rec."Status By" := UserId;
            //         Rec.Modify;
            //     end;
            // }

            action("Send Email")
            {
                ApplicationArea = Basic, Suite;
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
                Caption = 'Send Email';
                trigger OnAction()
                var
                    BulkLines: Record "Bulk SMS Lines";
                    Email: Codeunit Email;
                    EmailMsg: Codeunit "Email Message";
                    EmailBody: Text;
                    EmailsSent: Integer;
                    TempBlob: Codeunit "Temp Blob";
                    InStream: InStream;
                    OutStream: OutStream;
                begin
                    if rec."SMS Status" = rec."SMS Status"::Sent then
                        Error('This record has already been sent.');

                    Rec.TestField("Email Subject");

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Post Reversals" = false then
                            Error('You do not have permission');
                    end;

                    if Confirm('Send email to member[s]?', false) then begin
                        if not Rec."Use Line Message" then
                            Rec.TestField(Message_);

                        BulkLines.Reset;
                        BulkLines.SetRange(No, Rec.No);
                        if BulkLines.Find('-') then begin
                            repeat
                                Members.Reset();
                                if Members.get(BulkLines."Member No") and (Members."E-Mail" <> '') then begin

                                    // email body
                                    EmailBody := '<html><head><meta charset="UTF-8"></head>';
                                    EmailBody += '<body style="font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, Arial, sans-serif; font-size: 14px; line-height: 1.6; color: #202124; margin: 0; padding: 0; background-color: #f8f9fa;">';
                                    EmailBody += '<div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; padding: 40px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">';

                                    // greeting
                                    EmailBody += '<p style="margin: 0 0 24px 0; font-size: 16px;">Hi ' + Members."First Name" + ',</p>';

                                    // message
                                    if Rec."Use Line Message" then
                                        EmailBody += '<div style="margin-bottom: 24px; white-space: pre-line;">' + BulkLines."Text Message" + '</div>'
                                    else
                                        EmailBody += '<div style="margin-bottom: 24px; white-space: pre-line;">' + Rec.Message_ + '</div>';

                                    // signature
                                    if Rec."Email Signature" <> '' then begin
                                        EmailBody += '<div style="margin-top: 32px; padding-top: 16px; border-top: 1px solid #e8eaed;">';
                                        EmailBody += '<div style="font-size: 13px; color: #5f6368; white-space: pre-line;">' + Rec."Email Signature" + '</div>';
                                        EmailBody += '</div>';
                                    end;

                                    EmailBody += '</div></body></html>';

                                    // Create email
                                    EmailMsg.Create(Members."E-Mail", Rec."Email Subject", EmailBody, true);

                                    if Rec."Has Attachment" and Rec."Attachment".HasValue() then begin
                                        // Clear TempBlob
                                        Clear(TempBlob);

                                        // Create OutStream from TempBlob
                                        TempBlob.CreateOutStream(OutStream);

                                        // Export the blob content to the OutStream
                                        Rec."Attachment".ExportStream(OutStream);

                                        // Create InStream from the same TempBlob
                                        TempBlob.CreateInStream(InStream);

                                        EmailMsg.AddAttachment(Rec."Attachment Name", GetMIMEType(Rec."Attachment Name"), InStream);
                                    end;

                                    if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
                                        EmailsSent += 1;
                                        BulkLines.Sent := true;
                                        BulkLines.Modify();
                                    end;
                                end;
                            until BulkLines.Next = 0;
                        end;

                        Rec."SMS Status" := Rec."SMS Status"::Sent;
                        Rec."Status Date" := Today;
                        Rec."Status Time" := Time;
                        Rec."Status By" := UserId;
                        Rec.Modify;
                        Message('Email[s] sent successfully: %1', EmailsSent);
                    end;
                end;
            }
            separator(Action4)
            {
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        BulkHeader: Record "Bulk SMS Header";
        Mssage: Boolean;
        UseHeader: Boolean;
        BulkSMSLines: Boolean;
        UserSetup: Record "User Setup";
        Members: record Members;

    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            Mssage := true;
            UseHeader := true;
            BulkSMSLines := true;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
    end;

    local procedure GetMIMEType(FileName: Text): Text
    var
        FileExt: Text;
    begin
        FileExt := LowerCase(GetFileExtension(FileName));

        case FileExt of
            'pdf':
                exit('application/pdf');
            'doc':
                exit('application/msword');
            'docx':
                exit('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
            'xls':
                exit('application/vnd.ms-excel');
            'xlsx':
                exit('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            'txt':
                exit('text/plain');
            'png':
                exit('image/png');
            'jpg', 'jpeg':
                exit('image/jpeg');
            'gif':
                exit('image/gif');
            'zip':
                exit('application/zip');
            else
                exit('application/octet-stream');
        end;
    end;

    local procedure GetFileExtension(FileName: Text): Text
    var
        DotPos: Integer;
    begin
        DotPos := StrPos(FileName, '.');
        if DotPos = 0 then
            exit('');

        exit(CopyStr(FileName, DotPos + 1));
    end;

    // local procedure GetGreeting(): Text
    // var
    //     CurrentTime: Time;
    // begin
    //     CurrentTime := Time();
    //     if CurrentTime < 120000T then
    //         exit('Good Morning,');
    //     if CurrentTime < 180000T then
    //         exit('Good Afternoon,');
    //     exit('Good Evening,');
    // end;
}