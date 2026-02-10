report 50101 "Send SMS to Member"
{
    Caption = 'Send SMS to All Member';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(MemberRec; Members)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                SMSID: Guid;
                SkySMS: Codeunit SendSms;
                SMSSource: Enum "SMS Source";
            begin
                if MsgText = '' then
                    Error('Please enter a message before sending.');

                if "Phone No." <> '' then begin
                    SMSID := CreateGuid();
                    SkySMS.SendSms(
                        SMSSource::BULK_SMS,
                        "Phone No.",
                        MsgText,
                        SMSID,
                        '',
                        false,
                        0,
                        false,
                        'CBS',
                        '',
                        'CBS'
                    );
                end;
                Message('Bulk SMS has been sent successfully.');
            end;

            
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(MsgText; MsgText)
                    {
                        ApplicationArea = All;
                        Caption = 'Message';
                        MultiLine = true;
                        ToolTip = 'Enter the SMS message to send to the selected member.';
                    }
                }
            }
        }
    }

    var
        MsgText: Text[1000];
}
