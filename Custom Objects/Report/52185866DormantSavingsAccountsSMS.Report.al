#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185866 "Dormant Savings Accounts"
{
    Caption = 'Dormant Savings Accounts SMS Notifications';
    ProcessingOnly = true;
    UsageCategory = tasks;

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where("Product Type" = filter('DCS'), Status = filter(Dormant));
            RequestFilterFields = "Member No.";
            trigger OnAfterGetRecord()
            begin
                GenSetup.Get();
                LastSMSDate := 0D;
                if format(GenSetup."Dormancy SMS Period") <> '' then begin
                    SavingsAccounts.CalcFields("Last Transaction Date");
                    if SavingsAccounts."Last Transaction Date" <> 0D then
                        LastSMSDate := SavingsAccounts."Last Transaction Date";
                    if SavingsAccounts."Last Dormancy SMS Date" <> 0D then
                        LastSMSDate := SavingsAccounts."Last Dormancy SMS Date";
                    if LastSMSDate <> 0D then begin
                        if CalcDate(GenSetup."Dormancy SMS Period", LastSMSDate) < Today then begin
                            if Members.Get(SavingsAccounts."Member No.") then begin
                                if (Members.Subflag in [Members.Subflag::"First time", Members.Subflag::Rejoined, Members.Subflag::"Pending Withdrawal", Members.Subflag::" ", Members.Subflag::Defaulter]) then
                                    if Members."Phone No." <> '' then begin
                                        msg := 'Dear ' + Members.Name + ', Thank You for being our member. Please note that your account with us has been dormant for a while. Kindly make arrangements to activate it.';
                                        SendSMS.SendSms(Source::ACCOUNT_STATUS, Members."Phone No.", msg, Format(Members."No."), '', true, 0, false, 'CBS', Format(Members."No."), 'CBS');
                                        SavingsAccounts."Last Dormancy SMS Date" := Today;
                                        SavingsAccounts.Modify();
                                    end
                                    else
                                        CurrReport.Skip();
                            end
                            else
                                CurrReport.Skip();
                        end
                        else
                            CurrReport.Skip();
                    end
                    else
                        CurrReport.Skip();

                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Members Modified Successfully');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        RunDate: Date;
    begin
        if RunDate = 0D then
            RunDate := Today;
    end;

    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Members: Record "Members";
        GenSetup: record "General Set-Up";
        LastSMSDate: Date;
        msg: Text[250];
        SendSMS: Codeunit SendSMS;
        Source: Enum "SMS Source";
}
