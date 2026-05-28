#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185638 "Generate Dormant Accounts"
{
    ProcessingOnly = true;
    UsageCategory = tasks;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where("Product Type" = filter('1' | '191'), Status = filter(Active | Dormant));

            trigger OnAfterGetRecord()
            var
                MemberMgt: Codeunit "Registration Process";
                FirstName: text;
                SendSms: Codeunit SendSms;
                Source: Enum "SMS Source";
                Msg : Text;
                GlobalFunctions: Codeunit "Global Functions";
            begin
                SavingsAccounts.setfilter("Date Filter", '..%1', DateFilter);
                SavingsAccounts.CalcFields("Last Transaction Date",Balance);
                if SavingsAccounts."Last Transaction Date" <> 0D then begin
                    ProductFactory.Reset;
                    ProductFactory.SetFilter(ProductFactory."Product ID", SavingsAccounts."Product Type");
                    if ProductFactory.Find('-') then begin
                        if (CalcDate(ProductFactory."Dormancy Alert Period", SavingsAccounts."Last Transaction Date") <= DateFilter) and (SavingsAccounts.Balance > 0) then begin
                            // Send alert SMS
                            if not SavingsAccounts."Dormancy Alert Sent" then begin
                                if SavingsAccounts."Product Type" = '191' then begin
                                    if Members.Get(SavingsAccounts."Member No.") then begin
                                        if (Members.Status = Members.Status::Active) then begin
                                            clear(Msg);
                                            clear(FirstName);
                                            FirstName := Members."First Name";
                                            IF FirstName = '' THEN
                                                FirstName := Members."Middle Name";

                                            Msg := 'Dear ' + FirstName + ', ' + 
                                                'Your account will be updated to Dormant on ' + GlobalFunctions.FormatISODate(CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date")) + 
                                                ' owing to inactivity.';

                                            SendSMS.SendSms(Source::DEPOSIT_DORMANT, SavingsAccounts."Phone No.", Msg, '', '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');

                                            SavingsAccounts."Dormancy Alert Sent" := true;
                                            SavingsAccounts.Modify;
                                        end;
                                    end;
                                end;
                            end;

                        end
                        else if (CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") < DateFilter) and (SavingsAccounts.Balance > 0) then begin
                            SavingsAccounts.Status := SavingsAccounts.Status::Dormant;
                            SavingsAccounts."Status Change Reason" := 'Account Has Not Transacted For A Period Of ' + Format(ProductFactory."Dormancy Period") + 'months.';
                            SavingsAccounts."Last Date Modified" := Today;
                            SavingsAccounts.Modify;

                            if SavingsAccounts."Product Type" = '191' then begin
                                if Members.Get(SavingsAccounts."Member No.") then begin
                                    if (Members.Status = Members.Status::Active) then begin
                                        Members.Status := Members.Status::Dormant;
                                        Members."Last Date Modified" := Today;
                                        Members.Modify;

                                        MemberMgt.LogDormancy(SavingsAccounts."No.", Format(SavingsAccounts.Status), Format(SavingsAccounts.Status));

                                        clear(Msg);
                                        clear(FirstName);
                                        FirstName := Members."First Name";
                                        IF FirstName = '' THEN
                                            FirstName := Members."Middle Name";

                                        Msg := 'Dear ' + FirstName + ', ' + 
                                            'Your account has been updated to ' + FORMAT(SavingsAccounts.Status) + 
                                            ' as of ' + GlobalFunctions.FormatISODate(Today) + 
                                            ' owing to inactivity for over 3 months.';

                                        SendSMS.SendSms(Source::DEPOSIT_DORMANT, SavingsAccounts."Phone No.", Msg, '', '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
                                    end;
                                end;
                            end;
                        end
                        else begin
                            if (SavingsAccounts."Product Type" = '1') and (SavingsAccounts.Status = SavingsAccounts.Status::Dormant) then begin
                                SavingsAccounts.Status := SavingsAccounts.Status::Active;
                                SavingsAccounts."Status Change Reason" := 'Account Active';
                                SavingsAccounts."Last Date Modified" := Today;
                                SavingsAccounts."Dormancy Alert Sent" := false;
                                SavingsAccounts.Modify;

                                if Members.Get(SavingsAccounts."Member No.") then begin
                                    Members.Status := Members.Status::Active;
                                    Members."Last Date Modified" := Today;
                                    Members.Modify;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
                SuccessfulTxt: label 'Successfully Processed.';
            begin
                Message(SuccessfulTxt);
            end;

            trigger OnPreDataItem()
            begin
                if DateFilter = 0D then DateFilter := Today;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Date Filter:"; DateFilter)
                {
                    Caption = 'As At Date';
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateFilter: Date;
        ProductFactory: Record "Product Factory";
        Members: Record Members;
}
