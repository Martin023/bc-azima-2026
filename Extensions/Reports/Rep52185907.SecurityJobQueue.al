namespace ALProject.ALProject;
using System.Email;
using System.Security.User;
using System.Utilities;

report 52185907 "Security Job Queue "
{
    ApplicationArea = All;
    Caption = 'Security Job Queue ';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SecuritiesRegister; "Securities Register")
        {
            DataItemTableView = where(Status = filter(Approved));
            trigger OnAfterGetRecord()
            begin

                GenSetup.Get;
                if "Last Valuation Date" <> 0D then begin
                    if "Last Valuation Date" > Today then exit;

                    GenSetup.TestField("Maximum Valuation Period");
                    if CalcDate(GenSetup."Maximum Valuation Period", "Last Valuation Date") < Today then exit;

                    SecurityRegSetUp.Reset;
                    SecurityRegSetUp.SetRange(SecurityRegSetUp.Type, "Collateral Type");
                    if SecurityRegSetUp.Find('-') then begin
                        if Format(SecurityRegSetUp."Revaluation Frequency") <> '' then
                            "Next Valuation Date" := CalcDate(SecurityRegSetUp."Revaluation Frequency", "Last Valuation Date");
                        if "Next Valuation Date" = Today then begin
                            msg := 'Dear ' + SecuritiesRegister."Account Name" + ', Your re-evaluation date is today' + ' for Collateral' + Format(SecuritiesRegister."Collateral Name");
                            if Members.get(SecuritiesRegister."Account No.") then
                                SendSMS.SendSms(Source::"HR Security", Members."Phone No.", msg, Format(SecuritiesRegister."No."), '', true, 0, false, 'CBS', '', 'CBS');
                        end;
                    end;
                end;
                IF Loans.get(SecuritiesRegister."Loan No.") then
                    IF Loans."Outstanding Balance" > 0 then begin
                        if "Collateral Hold Types" = "Collateral Hold Types"::"Lease Hold" then begin
                            DueDate1 := CalcDate("Due Date", "Land Rate Renewal");
                            if DueDate1 = Today then begin
                                IF Members.get(SecuritiesRegister."Account No.") then begin
                                    Email1 := Members."E-Mail";

                                    msg := 'Your Land Rate is almost expiring,Kindly Renew';
                                    Subject := 'Land Rates Expiry';
                                    EmailMsg.Create(Email1, subject, msg, true);
                                    EmailMsg.AppendToBody(StrSubstNo(emailbody, Members.Name));
                                    Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                end;
                                IF Usersetup.get(SecuritiesRegister."User ID") then begin

                                    Email2 := Usersetup."E-Mail";

                                    msg := 'Land Rate For Employee No' + ' ' + SecuritiesRegister."Account No." + ' ' + SecuritiesRegister."Account Name" + ' ' + 'is almost expiring';
                                    Subject := 'Land Rates Expiry';
                                    EmailMsg.Create(Email2, subject, msg, true);
                                    EmailMsg.AppendToBody(StrSubstNo(emailbody, Usersetup."Full Name"));
                                    Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
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
    var
        SecurityRegSetUp: Record "Loan Securities Set-up";
        Text001: Label 'This collateral is blocked thus not avaialable for use.';
        Text002: Label 'This application is %1 thus cannot modify.';
        GenSetup: Record "General Set-Up";
        Text003: Label 'The last valuation day is more than %1 hence is invalid';
        Text004: Label 'Last valuation date cannot be greater than today';
        Text005: Label 'The forced sale value cannot be greater than collateral maximum limit of %1';
        SendSMS: Codeunit SendSms;
        Source: enum "SMS Source";
        msg: Text;
        Members: record Members;
        Loans: record Loans;
        DueDate1: date;
        Email1: Text[50];
        emailbody: Label 'Dear <b>%1</b>, <br> <h>';
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentOutstream: OutStream;
        Temps: Codeunit "Temp Blob";
        email: codeunit Email;
        subject: text;
        Usersetup: record "User Setup";
        Email2: text[100];


}
