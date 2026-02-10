#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185466 SendSms
{

    trigger OnRun()
    begin
    end;

    var
        Subs: Record "Notification Subscription";


    procedure SendSms(Source: enum "SMS Source"; Telephone: Text[200]; Textsms: Text; Reference: Text[50]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; RequestApplication: Text[30]; RequestCorrelationID: Text[50]; SourceApplication: Text[30])
    var
        EntryNo: Integer;
        SkySMS: Record "Sky SMS Messages";
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin

        EntryNo := EntryNo + 1;


        if StrLen(Telephone) = 13 then begin
            Telephone := CopyStr(Telephone, 2, 12);
        end;

        if StrLen(Telephone) = 10 then begin
            if CopyStr(Telephone, 1, 1) = '0' then
                Telephone := '254' + CopyStr(Telephone, 2, 9);
        end;

        if StrLen(Telephone) = 9 then begin
            if CopyStr(Telephone, 1, 1) = '7' then
                Telephone := '254' + Telephone
        end;



        Category := Format(Source);

        Priority := GetSMSPriority(Category);

        if Priority = 0 then
            Priority := 250;

        GeneralLedgerSetup.Get;

        if StrLen(Telephone) = 12 then begin


            SkySMS.Init;
            SkySMS.Source := Source;
            SkySMS.originator_id := CreateGuid;
            SkySMS.msg_id := 0;
            GeneralLedgerSetup.TestField("SMS Sender ID");
            GeneralLedgerSetup.TestField("SMS Sender Name");

            SkySMS.msg_product_id := GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code := '0';
            SkySMS.msg_charge := '';
            SkySMS.msg_status_code := 10;
            SkySMS.msg_status_description := 'New MSG';
            SkySMS.msg_status_date := CurrentDatetime;
            SkySMS.sender := GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver := Telephone;
            SkySMS.msg := Textsms;
            SkySMS.msg_type := 'MT';
            SkySMS.msg_source_reference := '';
            SkySMS.msg_destination_reference := Reference;
            SkySMS.msg_xml_data := '<OTHER_DETAILS/>';
            SkySMS.msg_category := Category;
            SkySMS.msg_priority := Priority;
            SkySMS.msg_mode := 'SAF';

            SkySMS.msg_send_count := 0;
            SkySMS.schedule_msg := 'NO';
            SkySMS.date_scheduled := CurrentDatetime;
            SkySMS.msg_send_integrity_hash := '';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date := CurrentDatetime;
            SkySMS.date_created := CurrentDatetime;
            SkySMS."SMS Date" := Today;
            //if Chargeable then
            SkySMS."Account To Charge" := AccNo;

            SkySMS.msg_request_application := RequestApplication;
            SkySMS.msg_request_correlation_id := RequestCorrelationID;
            SkySMS.msg_source_application := SourceApplication;

            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied := '';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CurrentDatetime;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date := CurrentDatetime;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            if Source = Source::MOBILE_PIN then begin
                SkySMS.msg_general_flag := 'NOT_MASKED';
            end;
            SkySMS."Charge Member" := ChargeMember;
            if Source = Source::CASH_WITHDRAWAL_CONFIRM then
                SkySMS."Split Charge" := true;

            SkySMS.Insert;
        end;
    end;

    procedure SendSms(Source: enum "SMS Source"; Telephone: Text[200]; Textsms: Text; Reference: Text[50]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; RequestApplication: Text[30]; RequestCorrelationID: Text[50]; SourceApplication: Text[30]; SMSDate: Date)
    var
        EntryNo: Integer;
        SkySMS: Record "Sky SMS Messages";
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin

        EntryNo := EntryNo + 1;


        if StrLen(Telephone) = 13 then begin
            Telephone := CopyStr(Telephone, 2, 12);
        end;

        if StrLen(Telephone) = 10 then begin
            if CopyStr(Telephone, 1, 1) = '0' then
                Telephone := '254' + CopyStr(Telephone, 2, 9);
        end;

        if StrLen(Telephone) = 9 then begin
            if CopyStr(Telephone, 1, 1) = '7' then
                Telephone := '254' + Telephone
        end;



        Category := Format(Source);

        Priority := GetSMSPriority(Category);

        if Priority = 0 then
            Priority := 250;

        GeneralLedgerSetup.Get;

        if StrLen(Telephone) = 12 then begin


            SkySMS.Init;
            SkySMS.Source := Source;
            SkySMS.originator_id := CreateGuid;
            SkySMS.msg_id := 0;
            GeneralLedgerSetup.TestField("SMS Sender ID");
            GeneralLedgerSetup.TestField("SMS Sender Name");

            SkySMS.msg_product_id := GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code := '0';
            SkySMS.msg_charge := '';
            SkySMS.msg_status_code := 10;
            SkySMS.msg_status_description := 'New MSG';
            SkySMS.msg_status_date := CurrentDatetime;
            SkySMS.sender := GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver := Telephone;
            SkySMS.msg := Textsms;
            SkySMS.msg_type := 'MT';
            SkySMS.msg_source_reference := '';
            SkySMS.msg_destination_reference := '';
            SkySMS.msg_xml_data := '<OTHER_DETAILS/>';
            SkySMS.msg_category := Category;
            SkySMS.msg_priority := Priority;
            SkySMS.msg_mode := 'SAF';

            SkySMS.msg_send_count := 0;
            SkySMS.schedule_msg := 'NO';
            SkySMS.date_scheduled := CurrentDatetime;
            SkySMS.msg_send_integrity_hash := '';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date := CurrentDatetime;
            SkySMS.date_created := CurrentDatetime;
            SkySMS."SMS Date" := Today;
            if Chargeable then
                SkySMS."Account To Charge" := AccNo;

            SkySMS.msg_request_application := RequestApplication;
            SkySMS.msg_request_correlation_id := RequestCorrelationID;
            SkySMS.msg_source_application := SourceApplication;

            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied := '';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CurrentDatetime;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date := CurrentDatetime;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            if Source = Source::MOBILE_PIN then begin
                SkySMS.msg_general_flag := 'NOT_MASKED';
            end;
            SkySMS."Charge Member" := ChargeMember;
            if Source = Source::CASH_WITHDRAWAL_CONFIRM then
                SkySMS."Split Charge" := true;

            SkySMS.Insert;
        end;
    end;

    local procedure GetSMSPriority(Category: Text) Priority: Integer
    begin
        case Category of
            'ATM_COLLECTION',
            'B2B_WITHDRAWAL',
            'CASH_WITHDRAWAL_CONFIRM',
            'DEPOSIT_CONFIRMATION',
            'LOW_FLOAT_ALERT',
            'LOW_FLOAT_INFO',
            'LOW_FLOAT_MIN',
            'LOW_FLOAT_WARNING',
            'MAPP_ACTIVATION',
            'MAPP_DEACTIVATION',
            'MBANKING',
            'MOBILE_PIN',
            'ONE_TIME_PASSWORD',
            'TELLER_CASH_DEPOSIT',
            'MPESA_WITHDRAWAL',
            'MPESA_WITHDRAWAL_REVERSAL',
            'WITHDRAWAL':
                Priority := 205;
            'FIXED_DEPOSIT_MATURITY',
            'LOAN_DEFAULTED',
            'LOAN_GUARANTORS',
            'LOAN_POSTED',
            'MEMBER_CHANGES',
            'IFT_ACCOUNT',
            'IFT_LOAN':
                Priority := 220;
            'LOAN_APPLICATION',
            'NEW_ACCOUNT',
            'NEW_MEMBER',
            'LOAN_APPRAISAL':
                Priority := 220;
            'LOAN_REJECTED',
            'TELLER_CAS':
                Priority := 225;
            'SALARY_PROCESSING',
            'LOAN_ACCOUNT_APPROVAL':
                Priority := 245;
            else
                Priority := 250;
        end;
    end;


    procedure Replacestring(string: Text[200]; findwhat: Text[30]; replacewith: Text[200]) Newstring: Text[200]
    begin
        while StrPos(string, findwhat) > 0 do
            string := DelStr(string, StrPos(string, findwhat)) + replacewith + CopyStr(string, StrPos(string, findwhat) + StrLen(findwhat));
        Newstring := string;
    end;
}
