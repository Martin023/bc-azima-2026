page 52186531 "CRM SMS API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'crmSMSAPI';
    DelayedInsert = true;
    EntityName = 'sms';
    EntitySetName = 'smses';
    PageType = API;
    SourceTable = "Sky SMS Messages";

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
                field(msgRequestApplication; Rec.msg_request_application)
                {
                    Caption = 'msg_request_application';
                }
                field(msgSourceApplication; Rec.msg_source_application)
                {
                    Caption = 'msg_source_application';
                }
                field(sender; Rec.sender)
                {
                    Caption = 'sender';
                }
                field(receiver; Rec.receiver)
                {
                    Caption = 'receiver';
                }
                field(msg; Rec.msg)
                {
                    Caption = 'msg';
                }
                field(msgCategory; Rec.msg_category)
                {
                    Caption = 'msg_category';
                }
                field(msgPriority; Rec.msg_priority)
                {
                    Caption = 'msg_priority';
                }
                field(msgStatusDate; Rec.msg_status_date)
                {
                    Caption = 'msg_status_date';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
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
