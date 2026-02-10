report 52185704 "Admin Notificaitions"
{
    ApplicationArea = All;
    Caption = 'Admin Notifications & Expiries';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Lease; Lease)
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                msg: Text;
                userset: Record "User Setup";
                LeaseExpiryDate: Date;
                Tenants: Record Customer;
                SendSMS: Codeunit SendSms;
                //msg: Text;
                Source: enum "SMS Source";
            begin
                if (Lease."Lease Status" = Lease."Lease Status"::Expired) AND (Lease."Lease Status" = Lease."Lease Status"::Terminated) then
                    CurrReport.Skip();
                //exit;
                //else
                if Lease.Status = Lease.Status::Approved then
                    if Lease."Expiry Date" = 0D then
                        exit
                    else
                        LeaseExpiryDate := CalcDate('-3M', Lease."Expiry Date");
                if LeaseExpiryDate = TODAY then begin
                    Tenants.Reset();
                    Tenants.SetRange("No.", Lease."Tenant No.");
                    if Tenants.FindFirst() then begin
                        if Tenants."Phone No." <> ' ' then begin
                            msg := 'Dear' + Tenants."Name" + ' ' + 'This is to inform you that your lease agreement with us is set to expire in three months on' + ' ' + FORMAT(Lease."Expiry Date") + '.' + ' ' + 'Kindly take necessary action. Thank you.';
                            SendSMS.SendSms(Source::LEASE, Tenants."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Lease."No.", 'CBS', Today);
                        end;
                    end
                end;

                if Lease."Expiry Date" <= TODAY then begin
                    Lease."Lease Status" := Lease."Lease Status"::Expired;
                    Lease.Expired := true;
                    Lease.modify(true);

                    LeaseLines.RESET;
                    LeaseLines.SetRange("Lease No.", Lease."No.");
                    if LeaseLines.Find('-') then begin
                        LeaseLines."Date Vacated" := TODAY;
                    end;

                    Office.Reset();
                    Office.SetRange("Floor Code", Lease."Floor No.");
                    Office.SetRange("Unit Code", Lease."Unit Code");
                    if Office.FindFirst() then begin
                        Office."Unit Status" := Office."Unit Status"::Vacant;
                        Office.Modify(true);
                        //Message('Lease No. ' + Lease."No." + ' has expired today.' + ' Lease Expiry Date: %1', Lease."Expiry Date");
                    end;

                    // userset.get(UserId);
                    // //SmtpSet.Get();
                    // msg := 'Dear Legal Department, Lease No.' + Lease."No." + ' has expired.';
                    // EmailManager.Create(userset."E-Mail", 'Lease Expiry', msg, true);
                    // Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                end;
            end;
        }
        dataitem("InsuranceClaim"; "Insurance Claims")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                msg: Text;
                usersetup: Record "User Setup";

            begin
                if (InsuranceClaim.Status <> InsuranceClaim.Status::Approved) then begin

                    // usersetup.get(UserId);
                    // msg := 'Dear Administration Department, Insurance Claim No.' + ' ' + InsuranceClaim."Claim No." + ' ' + 'is yet to be closed on. Kindly take necessary action. Thank you.';
                    // EmailManager.Create(usersetup."E-Mail", 'Pending Insurance Claim', msg, true);
                    // Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                end;
            end;
        }
        dataitem(Insurance; Insurance)
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                msg: Text;
                usersetup: Record "User Setup";
                DueDate: Date;

            begin
                if Insurance."Expiration Date" = 0D then
                    exit
                else
                    if (Insurance."Expiration Date" <= Today) then begin
                        Insurance."Insurance Status" := Insurance."Insurance Status"::Expired;
                        Insurance.Modify(true);

                        NotificationSetup.RESET;
                        NotificationSetup.SetRange(Notification, NotificationSetup.Notification::Administration);
                        NotificationSetup.SetRange("Send Email", true);
                        if NotificationSetup.Find('-') then begin
                            repeat
                                UserSetup.Reset();
                                UserSetup.SetRange("User ID", NotificationSetup."user id");
                                if UserSetup.FindFirst() then begin
                                    msg := 'Dear' + NotificationSetup."Responsibility Centre" + ' ' + 'Department, Insurance No.' + ' ' + Insurance."No." + ' ' + 'expires today the' + ' ' +
                                    FORMAT(Insurance."Expiration Date") + '.' + ' ' + 'Kindly take necessary action. Thank you.';
                                    EmailManager.Create(usersetup."E-Mail", 'Insurance Expiry Notification', msg, true);
                                    Email.Send(EmailManager, Enum::"Email Scenario"::Default)
                                end
                            until NotificationSetup.Next() = 0;
                        end;

                        //     usersetup.get(UserId);
                        //     msg := 'Dear Administration Department, Insurance No.' + ' ' + Insurance."No." + ' ' + 'expires today the' + ' ' + FORMAT(Insurance."Expiration Date") + '.' + ' ' + 'Kindly take necessary action. Thank you.';
                        //     EmailManager.Create(usersetup."E-Mail", 'Insurance Expiry', msg, true);
                        //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                    end
                    else
                        //if (Insurance."Expiration Date" <> 0D) then
                        DueDate := CalcDate('-3M', Insurance."Expiration Date");
                // Message('Due Date: %1', DueDate);
                if (DueDate = TODAY) then begin

                    NotificationSetup.RESET;
                    NotificationSetup.SetRange(Notification, NotificationSetup.Notification::Administration);
                    NotificationSetup.SetRange("Send Email", true);
                    if NotificationSetup.Find('-') then begin
                        repeat
                            UserSetup.Reset();
                            UserSetup.SetRange("User ID", NotificationSetup."user id");
                            if UserSetup.FindFirst() then begin
                                msg := 'Dear' + '' + NotificationSetup."Responsibility Centre" + 'Department, Insurance No.' + ' ' + Insurance."No." + ' ' + 'expires today on the ' + ' ' +
                                FORMAT(Insurance."Expiration Date") + '.' + ' ' + 'Kindly take necessary action. Thank you.';
                                EmailManager.Create(usersetup."E-Mail", 'Insurance Expired Notification', msg, true);
                                Email.Send(EmailManager, Enum::"Email Scenario"::Default)
                            end
                        until NotificationSetup.Next() = 0;
                    end;


                    //     usersetup.get(UserId);
                    //     msg := 'Dear Administration Department, Insurance No.' + ' ' + Insurance."No." + ' ' + 'is set to expire in three months on' + ' ' + FORMAT(Insurance."Expiration Date") + '.' + ' ' + 'Kindly take necessary action. Thank you.';
                    //     EmailManager.Create(usersetup."E-Mail", 'Insurance Expiry Reminder', msg, true);
                    //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                    // end;
                    Insurance."Insurance Status" := Insurance."Insurance Status"::Expired;
                    Insurance."Reminder Email Sent" := true;
                    Insurance.Modify(true);
                end;
                // end;
            end;
        }
        dataitem(ConferenceBookingTable; "Conference & Meeting Rooms-T")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                msg: Text;
                usersetup: Record "User Setup";
                NotificationDate: Date;

            begin
                if (ConferenceBookingTable."Status" = ConferenceBookingTable."Status"::Approved) then begin
                    NotificationDate := CalcDate('-1D', ConferenceBookingTable."Date of Meeting/Function");
                    if ConferenceBookingTable.Status = ConferenceBookingTable.Status::Approved then begin
                        if ConferenceBookingTable."Type of Meeting/Function" = ConferenceBookingTable."Type of Meeting/Function"::External then begin
                            if (NotificationDate = TODAY) then begin
                                NotificationSetup.RESET;
                                NotificationSetup.SetRange(Notification, NotificationSetup.Notification::"Treasury & Investment");
                                NotificationSetup.SetRange("Send Email", true);
                                if NotificationSetup.Find('-') then begin
                                    repeat
                                        UserSetup.Reset();
                                        UserSetup.SetRange("User ID", NotificationSetup."user id");
                                        if UserSetup.FindFirst() then begin
                                            msg := 'Dear' + NotificationSetup."Responsibility Centre" + ' ' + 'Department, + ' + 'This is to formally inform you about a Conference Room booking by and external client for Conference Room Booking No.' +
                                             ' ' + ConferenceBookingTable."No." + ' ' + 'of' + ' ' + ConferenceBookingTable."Meeting Room Name" + '.' + 'The meeting is scheduled for tomorrow the ' + FORMAT(ConferenceBookingTable."Date of Meeting/Function") + ' ' + 'Kindly take necessary action to invoice the client. Thank you.';
                                            EmailManager.Create(usersetup."E-Mail", 'Conference Room Booking Notification', msg, true);
                                            Email.Send(EmailManager, Enum::"Email Scenario"::Default)
                                        end
                                    until NotificationSetup.Next() = 0;
                                end;
                                //     usersetup.get(UserId);
                                //     msg := 'Dear' + NotificationSetup."Responsibility Centre" + ' ' + 'Department, + ' + 'This is to formally inform you about a Conference Room booking by and external client for Conference Room Booking No.' +
                                //              ' ' + ConferenceBookingTable."No." + ' ' + 'of' + ' ' + ConferenceBookingTable."Meeting Room Name" + '.' + 'The meeting is scheduled for tomorrow the ' + FORMAT(ConferenceBookingTable."Date of Meeting/Function") + ' ' + 'Kindly take necessary action to invoice the client. Thank you.';
                                //     EmailManager.Create(usersetup."E-Mail", 'Conference Room Booking Notification', msg, true);
                                //     EmailManager.Create(usersetup."E-Mail", 'Conference Room Booking Expiry', msg, true);
                                //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                                // end;
                            end;
                        end;
                    end;
                end;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    Var
        Office: Record Unit;
        SmtpSet: Record "Email Account";
        EmailManager: Codeunit "Email Message";
        Email: Codeunit Email;
        NotificationSetup: Record "Notification EmSms setup";
        LeaseLines: Record "Lease Line";

}
