report 50110 Sendingemails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'MemberSendMail';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/emailstatement.rdlc';

    dataset
    {
        dataitem(members; Members)
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                email: codeunit Email;
                userset: Record "User Setup";
                EmailMsg: Codeunit "Email Message";
                Filename: Text;
                usermail: Text;
                username: text;
                instr: InStream;
                emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';
            begin
                CreatebackupStatement("No.", 52185621);
                userset.Reset();
                userset.SetRange("User ID", UserId);
                if userset.FindFirst() then begin
                    usermail := userset."E-Mail";
                    username := userset."Full Name";
                    Message(username);
                end;
                EmailMsg.Create(usermail, 'Request to approve', '', true);
                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                if UploadIntoStream('Select the file', Fromfolder, 'This files|*.jpg;*.pdf;*.docx;*.png', Filename, instr) then
                    EmailMsg.AddAttachment(Filename, '', instr)
                else
                    Message('There was an error in uploading %1', GetLastErrorText());
                if email.Send(EmailMsg) then
                    Message('Email sent successfully')
                else
                    Message('There was an error in sendingmail,%1', GetLastErrorText());

            end;
        }
    }
    procedure CreatebackupStatement(var memberNumber: Code[30]; ReportNum: Integer)
    var
        Edms: Record EDMS;
        Member: Record Members;
        Url: Text;
        filePath: Text;
    begin
        Member.Reset();
        Member.SetRange("No.", memberNumber);
        if Member.FindFirst() then begin
            Edms.Reset();
            ;
            Edms.SetRange("Key", Edms."Key"::"Member Statement");
            if Edms.FindFirst() then begin
                Url := Edms."url path";
                FilePath := url + 'statement' + Member."No." + Member."Primary Identification" + '.pdf';
                if filePath <> '' then
                    Fromfolder := filePath;
                //Report.SaveAsPdf(ReportNum, filePath, Member);
                //Report.SaveAsPdf(ReportNum, filePath, Member);
            end;
        end;

    end;

    var
        myInt: Integer;
        Fromfolder: Text;
        client: HttpClient;
}