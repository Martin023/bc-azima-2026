// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185636 "E-Mail Frequency Statement"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(SavingsAccounts; "Savings Accounts")
//         {
//             DataItemTableView = where("Send Statement Freq." = filter(<> ""));
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 SavingsAccounts.TestField(SavingsAccounts."E-Mail");
//                 //Variablename = Newmessage(To,CC,Subject,Body,Attachfilename,opendialog)
//                 AccountNotification.Reset;
//                 AccountNotification.SetFilter(AccountNotification."Document Type", '%1', AccountNotification."document type"::"Account Statement");
//                 if AccountNotification.Find('-') then begin
//                     AccountNotification.TestField(AccountNotification."Sender Name");
//                     AccountNotification.TestField(AccountNotification."Sender E-Mail");

//                     FileName := AccountNotification."Path To Save Report" + SavingsAccounts."No." + '-' + 'Savings Statement.pdf';
//                     if FILE.Exists(FileName) then
//                         FILE.Erase(FileName);
//                     Report.SaveAsPdf(39004257, FileName, SavingsAccounts);

//                     SMTPMail.CreateMessage(AccountNotification."Sender Name", AccountNotification."Sender E-Mail", SavingsAccounts."E-Mail",
//                                            AccountStatementTxt, '', true);
//                     SMTPMail.AppendBody(SalutationTxt);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody(BodyTxt);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody(RegardsTxt);
//                     SMTPMail.AppendBody('<br>');
//                     SMTPMail.AppendBody(COMPANYNAME);
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AppendBody('<HR>');
//                     SMTPMail.AppendBody(DesclaimerTxt);
//                     SMTPMail.AddAttachment(AccountNotification."Path To Save Report", SavingsAccounts."No." + '-' + 'Savings Statement.pdf');
//                     if AccountNotification."Send To CC" <> '' then
//                         SMTPMail.AddCC(AccountNotification."Send To CC");
//                     if AccountNotification."Send To BCC" <> '' then
//                         SMTPMail.AddBCC(AccountNotification."Send To BCC");
//                     SMTPMail.Send;
//                 end;

//                 "Last Statement Date" := CalcDate("Send Statement Freq.", "Last Statement Date");
//                 SavingsAccounts.Modify;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message(ProcessTxt);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 SavingsAccounts.SetFilter("Last Statement Date", '%1', Today);
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
//         FileName: Text;
//         //SMTPSetup: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit 400;
//         AccountNotification: Record "E-Mail Notification";
//         AccountStatementTxt: label 'Account Statement';
//         SalutationTxt: label 'Dear Sir / Madam,';
//         BodyTxt: label 'Please find attached you Account Statement.';
//         RegardsTxt: label 'Regards.';
//         DesclaimerTxt: label 'This is a system generated email. please do not respone to this email';
//         ProcessTxt: label 'Successfully Processed.';
// }
