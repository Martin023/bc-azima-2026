codeunit 52187101 "Sky Send Email"
{
    procedure QueueOutgoingEmail(
        ReceiverEmailAddress: Text;
        Subject: Text;
        Content: Text;
        ContentType: Text; // TEXT, HTML
        EmailCategory: Text;
        RequestApplication: Text
    )
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin

        if ReceiverEmailAddress <> '' then begin
            theTable.Init();

            theTable.originator_id := globalFunc.CleanGuid();
            theTable.status_code := '10';
            theTable.status_name := 'QUEUED';
            theTable.status_description := 'New Email';
            theTable.status_date := CurrentDateTime;

            if GeneralLedgerSetup.Get then begin
                theTable.sender_email_name := GeneralLedgerSetup."EMAIL Sender Name";
                theTable.sender_email_address := GeneralLedgerSetup."EMAIL Sender Address";
            end else begin
                theTable.sender_email_name := 'Kenpipe SACCO';
                theTable.sender_email_address := 'members.portal@kenpipesacco.com';
            end;

            theTable.email_type := 'OUTBOUND_EMAIL';
            theTable.sensitivity := 'NORMAL';
            theTable.priority := 200;
            theTable.send_count := 0;
            theTable.request_correlation_id := globalFunc.CleanGuid();
            theTable.source_application := 'BUSINESS CENTRAL';
            theTable.source_reference := globalFunc.CleanGuid();
            theTable.schedule_email := 'NO';
            theTable.date_scheduled := 0DT;
            theTable.send_integrity_hash := '';
            theTable.general_flag := '';
            theTable.date_created := CurrentDateTime;

            theTable.receiver_email_addresses := ReceiverEmailAddress;
            theTable.email_subject := Subject;
            // theTable.email_content_type := ContentType;
            theTable.email_content_type := 'HTML';
            theTable.category := EmailCategory;
            theTable.request_application := RequestApplication;
            theTable.email_message_body := Content;

            // theTable.TestField(receiver_email_addresses);
            theTable.TestField(email_subject);
            theTable.TestField(email_content_type);
            theTable.TestField(category);
            theTable.TestField(request_application);
            theTable.TestField(email_message_body);

            theTable.Insert(true);
        end;

    end;

    procedure SetEmailAttachments(
        var theEmailRecord: Record "Sky Email Buffer";
        theAttachments: JsonToken // { "file":"filename","contents":"base64" } []
    )
    var
        OutStr: OutStream;
        theAttachment: JsonToken; // { "file":"filename","contents":"base64" }
        theAttachmentFile: JsonToken;
        theAttachmentContents: JsonToken;
        theAttachmentXML: Text;
    begin
        Clear(theEmailRecord.attachments);
        theEmailRecord.attachments.CreateOutStream(OutStr, TextEncoding::UTF8);

        if theAttachments.AsArray.Count = 0 then begin
            theAttachmentXML := '<ATTACHMENTS/>';
        end else begin
            theAttachmentXML := '<ATTACHMENTS>';

            foreach theAttachment in theAttachments.AsArray do begin
                theAttachment.SelectToken('file', theAttachmentFile);
                theAttachment.SelectToken('contents', theAttachmentContents);

                theAttachmentXML += '<ATTACHMENT NAME="' + theAttachmentFile.AsValue.AsText + '">' + theAttachmentContents.AsValue.AsText + '</ATTACHMENT>';
            end;

            theAttachmentXML += '</ATTACHMENTS>';
        end;

        OutStr.WriteText(theAttachmentXML);
    end;

    procedure QueueOutgoingEmailWithAttachments(
        ReceiverEmailAddress: Text;
        Subject: Text;
        Content: Text;
        ContentType: Text; // TEXT, HTML
        EmailCategory: Text;
        RequestApplication: Text;
        theAttachments: JsonToken // { "file":"filename","contents":"base64" } []
    )
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin

        if ReceiverEmailAddress <> '' then begin
            theTable.Init();

            theTable.originator_id := globalFunc.CleanGuid();
            theTable.status_code := '10';
            theTable.status_name := 'QUEUED';
            theTable.status_description := 'New Email';
            theTable.status_date := CurrentDateTime;

            if GeneralLedgerSetup.Get then begin
                theTable.sender_email_name := GeneralLedgerSetup."EMAIL Sender Name";
                theTable.sender_email_address := GeneralLedgerSetup."EMAIL Sender Address";
            end else begin
                theTable.sender_email_name := 'Mwalimu National SACCO';
                theTable.sender_email_address := 'mnserp@mwalimunational.coop';
            end;

            theTable.email_type := 'OUTBOUND_EMAIL';
            theTable.sensitivity := 'NORMAL';
            theTable.priority := 200;
            theTable.send_count := 0;
            theTable.request_correlation_id := globalFunc.CleanGuid();
            theTable.source_application := 'BUSINESS CENTRAL';
            theTable.source_reference := globalFunc.CleanGuid();
            theTable.schedule_email := 'NO';
            theTable.date_scheduled := 0DT;
            theTable.send_integrity_hash := '';
            theTable.general_flag := '';
            theTable.date_created := CurrentDateTime;

            theTable.receiver_email_addresses := ReceiverEmailAddress;
            theTable.email_subject := Subject;
            // theTable.email_content_type := ContentType;
            theTable.email_content_type := 'HTML';
            theTable.category := EmailCategory;
            theTable.request_application := RequestApplication;
            theTable.email_message_body := Content;

            // theTable.TestField(receiver_email_addresses);
            theTable.TestField(email_subject);
            theTable.TestField(email_content_type);
            theTable.TestField(category);
            theTable.TestField(request_application);
            theTable.TestField(email_message_body);

            SetEmailAttachments(theTable, theAttachments);

            theTable.Insert(true);
        end;

    end;

    var
        theTable: Record "Sky Email Buffer";
        globalFunc: Codeunit "Global Functions";
}