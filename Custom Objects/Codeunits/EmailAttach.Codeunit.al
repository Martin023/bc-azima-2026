codeunit 50110 EmailCodeunit
{
    trigger OnRun()
    begin

    end;

    procedure SendEmails()
    var
        myInt: Integer;
        email: codeunit Email;
        userset: Record "User Setup";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';
    begin
        userset.Reset();
        userset.SetRange("User ID", UserId);
        if userset.FindFirst() then begin
            usermail := userset."E-Mail";
            username := userset."Full Name";
            Message(username);
        end;
        EmailMsg.Create(usermail, 'Request to approve', '', true);
        EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
        if UploadIntoStream('Select the file', '', 'This files|*.jpg;*.pdf;*.docx;*.png', Filename, instr) then
            EmailMsg.AddAttachment(Filename, '', instr)
        else
            Message('There was an error in uploading %1', GetLastErrorText());
        if email.Send(EmailMsg) then
            Message('Email sent successfully')
        else
            Message('There was an error in sendingmail,%1', GetLastErrorText());
    end;

    procedure ConnectApiEdms()
    var
        myInt: Integer;
        client: HttpClient;
        Result: Text;
        content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        output: Text;
    begin
        client.Get('https://reqbin.com/echo/post/json', Response);
        if Response.IsSuccessStatusCode then
            content := Response.Content
        else
            Message('Response was negative %1,%2', Response.HttpStatusCode, Response.ReasonPhrase);
        content.ReadAs(Result);
        Message(Result);
        //method 2
        Request.SetRequestUri('https://reqbin.com/echo/post/json');
        Request.Method('Get');
        client.Send(Request, Response);
        if Response.IsSuccessStatusCode then
            content := Response.Content
        else
            Message('Response was negative %1,%2', Response.HttpStatusCode, Response.ReasonPhrase);
        content.ReadAs(output);
        Message(output)


    end;

    

   



    var
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentInstream: InStream;
        Application: Record "HR Job Applications";
        Email: Codeunit Email;
        AttachmentOutstream: OutStream;
        Temp: Codeunit "Temp Blob";
        msg:text;
        subject:text;

    //         codeunit 50100 "Applicant Response Emails"
    // {
    //     var
    //         EmailManagement: Codeunit "Email Management",
    //         ApplicantRec: Record "Applicant",
    //         Email: Record "Email";

    //     procedure SendResponseEmail(ApplicantID: Code[20]);
    //     begin
    //         // Fetch the applicant record based on the ApplicantID
    //         if ApplicantRec.Get(ApplicantID) then
    //         begin
    //             // Create and send an email to the applicant
    //             Email.INIT;
    //             Email.Subject := 'Your Application Status';
    //             Email.Body := 'Your application status: ' + ApplicantRec."Status";
    //             Email.Recipient := ApplicantRec.Email;
    //             EmailManagement.SendEmail(Email);
    //         end;
    //     end;

    //     procedure SendRejectionEmail(ApplicantID: Code[20]);
    //     begin
    //         // Fetch the applicant record based on the ApplicantID
    //         if ApplicantRec.Get(ApplicantID) then
    //         begin
    //             // Create and send a rejection email to the applicant
    //             Email.INIT;
    //             Email.Subject := 'Application Rejected';
    //             Email.Body := 'We regret to inform you that your application has been rejected.';
    //             Email.Recipient := ApplicantRec.Email;
    //             EmailManagement.SendEmail(Email);
    //         end;
    //     end;

    //     procedure SendApprovalEmail(ApplicantID: Code[20]);
    //     begin
    //         // Fetch the applicant record based on the ApplicantID
    //         if ApplicantRec.Get(ApplicantID) then
    //         begin
    //             // Check if the applicant is qualified
    //             if ApplicantRec."Status" = 'Approved' then
    //             begin
    //                 // Create and send a qualified email
    //                 Email.INIT;
    //                 Email.Subject := 'Application Approved';
    //                 Email.Body := 'Congratulations! Your application has been approved.';
    //                 Email.Recipient := ApplicantRec.Email;
    //                 EmailManagement.SendEmail(Email);
    //             end
    //             else
    //             begin
    //                 // If the status is not 'Approved', send a rejection email
    //                 SendRejectionEmail(ApplicantID);
    //             end;
    //         end;
    //     end;
    // }
}