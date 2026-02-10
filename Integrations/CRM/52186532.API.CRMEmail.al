page 52186532 "CRM Email API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'crmEmailAPI';
    DelayedInsert = true;
    EntityName = 'email';
    EntitySetName = 'emails';
    PageType = API;
    SourceTable = "Sky Email Buffer";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(originatorId; Rec.originator_id)
                {
                    Caption = 'originator_id';
                }
                field(statusCode; Rec.status_code)
                {
                    Caption = 'status_code';
                }
                field(statusName; Rec.status_name)
                {
                    Caption = 'status_name';
                }
                field(statusDescription; Rec.status_description)
                {
                    Caption = 'status_description';
                }
                field(statusDate; Rec.status_date)
                {
                    Caption = 'status_date';
                }
                field(senderEmailName; Rec.sender_email_name)
                {
                    Caption = 'sender_email_name';
                }
                field(senderEmailAddress; Rec.sender_email_address)
                {
                    Caption = 'sender_email_address';
                }
                field(receiverEmailAddresses; Rec.receiver_email_addresses)
                {
                    Caption = 'receiver_email_addresses';
                }
                field(emailType; Rec.email_type)
                {
                    Caption = 'Email Type';
                }
                field(emailSubject; Rec.email_subject)
                {
                    Caption = 'email_subject';
                }
                field(emailContentType; Rec.email_content_type)
                {
                    Caption = 'email_content_type';
                }
                field(sensitivity; Rec.sensitivity)
                {
                    Caption = 'sensitivity';
                }
                field(category; Rec.category)
                {
                    Caption = 'category';
                }
                field(priority; Rec.priority)
                {
                    Caption = 'priority';
                }
                field(sendCount; Rec.send_count)
                {
                    Caption = 'send_count';
                }
                field(requestApplication; Rec.request_application)
                {
                    Caption = 'request_application';
                }
                field(requestCorrelationId; Rec.request_correlation_id)
                {
                    Caption = 'request_correlation_id';
                }
                field(sourceApplication; Rec.source_application)
                {
                    Caption = 'source_application';
                }
                field(sourceReference; Rec.source_reference)
                {
                    Caption = 'source_reference';
                }
                field(scheduleEmail; Rec.schedule_email)
                {
                    Caption = 'schedule_email';
                }
                field(dateScheduled; Rec.date_scheduled)
                {
                    Caption = 'date_scheduled';
                }
                field(sendIntegrityHash; Rec.send_integrity_hash)
                {
                    Caption = 'send_integrity_hash';
                }
                field(generalFlag; Rec.general_flag)
                {
                    Caption = 'general_flag';
                }
                field(dateCreated; Rec.date_created)
                {
                    Caption = 'date_created';
                }
                field(emailMessageBody; Rec.email_message_body)
                {
                    Caption = 'email_message_body';
                }
                field(attachments; Rec.attachments)
                {
                    Caption = 'attachments';
                }
                field(bcDate; Rec.bc_date)
                {
                    Caption = 'bc_date';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
