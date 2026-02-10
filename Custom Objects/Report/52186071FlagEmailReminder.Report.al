#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186071 "Flag Email Reminder"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Loanee Infomation Base"; "Loanee Infomation Base")
        {

            trigger OnAfterGetRecord()
            var
                SavAcc: Record "Savings Accounts";
                myInt: Integer;
                email: codeunit Email;
                userset: Record "User Setup";
                Filename: Text;
                usermail: Text;
                username: text;
                instr: InStream;
                emailbody: Label 'Dear <b>%1</b>, <br><h>';
                EmailMsg: Codeunit "Email Message";
                EmailRecipientList: List of [Text];
                AttachmentInstream: InStream;
                AttachmentOutstream: OutStream;
                Temp: Codeunit "Temp Blob";
                msg: text;
                subject: text;
            begin
                "Loanee Infomation Base".Reset();
                "Loanee Infomation Base".SetRange("Member No.", SavAcc."No.");
                "Loanee Infomation Base".SetFilter(Info, '<>%1', '');
                if "Loanee Infomation Base".Find('-') then begin
                    repeat
                        userset.Reset();
                        userset.SetRange("User ID", UserId);
                        userset.setrange("Responsibility Centre", 'FOSA');
                        if userset.Find('-') then begin
                            repeat
                                usermail := userset."E-Mail";
                                username := userset."Full Name";


                                if Abs("Loanee Infomation Base"."Expiry Date" - Today) = 1 then begin
                                    "Loanee Infomation Base".Get(SavAcc."No.");
                                    msg := 'Dear ' + ' ' + username + ' ' + 'the Account No.' + ' ' + SavAcc."No." + ' ' + 'will expire tomorrow.';
                                    subject := 'Flagging an Account.';
                                end;

                                EmailMsg.Create(usermail, subject, msg, true);
                                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                            until userset.next = 0;

                        end;
                    until "Loanee Infomation Base".Next = 0;
                end;


            end;


            trigger OnPostDataItem()
            begin
                ProgressWindow.Close;
                Message('Done!!!');
            end;

            trigger OnPreDataItem()
            begin

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {

        }
    }

    trigger OnPreReport()
    begin
        AsAt := today;
    end;

    var
        ProgressWindow: Dialog;
        AsAt: Date;
}
