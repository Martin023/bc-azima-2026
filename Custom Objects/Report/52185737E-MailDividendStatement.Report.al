// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185737 "E-Mail Dividend Statement"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         //dataitem(52185700;52185700)
//         dataitem(Members; "Members")
//         {
//             DataItemTableView = where("E-Mail" = filter(<> ' '), Status = filter(Active | Defaulter | Dormant));
//             RequestFilterFields = "Employer Code", "No.";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(No_Members; Members."No.")
//             {
//             }
//             column(Name_Members; Members.Name)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 GeneralSetUp.Get();
//                 CompanyInformation.Get();
//                 Year := Date2dmy(Today, 3);
//                 PreviousYear := Year - 1;

//                 Member.Reset;
//                 Member.SetRange("No.", Members."No.");
//                 if Member.Find('-') then begin
//                     if Exists(Filename) then
//                         Erase(Filename);

//                     SMTPSetup.Get;

//                     Filename := 'C:\Member Statement\' + 'Member Statement.pdf';
//                     Report.SaveAsPdf(Report::"Dividend Slip", Filename, Member);

//                     SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", "E-Mail", 'Dividend Statement for the year ' + Format(PreviousYear), '', true);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Dear ' + Members.Name);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Thank you for your continued patronage of Harambee Sacco Society');
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Your eStatement is attached and is ready for viewing. You can save, view and print it at your own convenience.');
//                     SMTPMail.AppendBody('You can also access our services through Web portal');
//                     SMTPMail.AppendBody('<br>');
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Kindly note this is an automated delivery system; do not reply to this email address.');
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('For any queries kindly contact Customer Service on phone number: ' + CompanyInformation."Phone No.");
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Email:' + CompanyInformation."E-Mail");
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('Best Regards');
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('*****************************.');
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody(CompanyInformation.Name);
//                     //SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
//                     SMTPMail.AppendBody('<br>');
//                     //SMTPMail.AppendBody(CompanyInformation.Mission);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('<HR>');
//                     CompanyInformation.Get();
//                     //SMTPMail.AppendBody('This is a system generated mail.For any complains/ compliments call '+CompanyInformation."Phone No.");
//                     SMTPMail.AddAttachment('C:\Member Statement\' + 'Member Statement.pdf', Filename);

//                     SMTPMail.Send;

//                     if Exists(Filename) then
//                         Erase(Filename);
//                 end;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         Member: Record "Members";
//         SMTPSetup: Record "SMTP Mail Setup";
//         Filename: Text[150];
//         SMTPMail: Codeunit "Dimension Value-Indent";
//         MailBody: label 'You can also access our services through Web portal,Mobile App(MSACCO+) and M-SACCO Banking services. ''+''For more details, please visit our website at <a href=''+''www.ushurusacco.com at . You can also follow our facebook page www.facebook.com/ ''';
//         CompanyInformation: Record "Company Information";
//         RunOnceFile: Text;
//         GeneralSetUp: Record "General Set-Up";
//         Year: Integer;
//         PreviousYear: Integer;
// }
