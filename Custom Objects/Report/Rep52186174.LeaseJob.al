namespace MNS.MNS;
using System.Email;
using System.Security.User;
using Microsoft.Sales.Customer;

report 52186174 "Lease Job"
{
    ApplicationArea = All;
    Caption = 'Lease Job';
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
                Source: enum "SMS Source";
            begin
                if (Lease.Status = Lease.Status::Open) AND (Lease.Status = Lease.Status::Pending) AND (Lease.Status = Lease.Status::Rejected) then
                    CurrReport.Skip();
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
                        Message('Lease No. ' + Lease."No." + ' has expired today.' + ' Lease Expiry Date: %1', Lease."Expiry Date");
                    end;

                    // userset.get(UserId);
                    // //SmtpSet.Get();
                    // msg := 'Dear Legal Department, Lease No.' + Lease."No." + ' has expired.';
                    // EmailManager.Create(userset."E-Mail", 'Lease Expiry', msg, true);
                    // Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Office: Record Unit;
        SmtpSet: Record "Email Account";
        EmailManager: Codeunit "Email Message";
        Email: Codeunit Email;
        NotificationSetup: Record "Notification EmSms setup";
        LeaseLines: Record "Lease Line";

}
