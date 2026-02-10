// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185893 "Fixed Deposit Notifications"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Fixed Deposit Notifications.rdl';

//     dataset
//     {
//         dataitem("Fixed Deposit Type"; "Fixed Deposit Type")
//         {
//             DataItemTableView = where(Blocked = const(No));
//             column(ReportForNavId_1; 1)
//             {
//             }
//             dataitem("Savings Accounts"; "Savings Accounts")
//             {
//                 DataItemLink = "Fixed Deposit Type" = field(Code);
//                 DataItemTableView = where("Fixed Deposit Type" = const(YES), "Fixed Deposit Status" = const(Active));
//                 column(ReportForNavId_2; 2)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     SendNotification("Savings Accounts");
//                 end;
//             }
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

//     local procedure SendNotification(SavingsAccounts: Record UnknownRecord52185730)
//     var
//         FixedDepositNotificationLis: Record "Fixed Deposit Notification Lis";
//         UserSetup: Record "User Setup";
//     begin
//         FixedDepositNotificationLis.SetRange(FixedDepositNotificationLis."Fixed Deposit Type", SavingsAccounts."Fixed Deposit Type");
//         if FixedDepositNotificationLis.FindSet then
//             repeat
//                 if FixedDepositNotificationLis."User Type" = FixedDepositNotificationLis."user type"::Member then begin
//                     SendNotificationByUser(SavingsAccounts."E-Mail")
//                 end
//                 else
//                     if FixedDepositNotificationLis."User Type" = FixedDepositNotificationLis."user type"::User then begin
//                         if UserSetup.Get(FixedDepositNotificationLis."User Id") then
//                             SendNotificationByUser(UserSetup."E-Mail");
//                     end;
//             until FixedDepositNotificationLis.Next = 0;
//     end;

//     local procedure SendNotificationByUser(Email: Text)
//     var
//         // SMTPMail: Codeunit 400;
//         SavingsAccounts: Record "Savings Accounts";
//         CompanyInformation: Record "Company Information";
//     begin
//         CompanyInformation.Get;
//         Clear(SMTPMail);
//         SMTPMail.CreateMessage('Fixed Deposit Maturity Notification',
//         CompanyInformation."E-Mail",
//         Email,
//         'Fixed Deposit Maturity Notification',
//         'Fixed deposit ' + Format(SavingsAccounts."No.") + 'worth ' + Format(SavingsAccounts."Balance (LCY)") + 'belonging to ' + SavingsAccounts.Name + 'is going to mature on ' + Format(SavingsAccounts."FD Maturity Date"),
//         true);
//         SMTPMail.Send;
//     end;
// }
