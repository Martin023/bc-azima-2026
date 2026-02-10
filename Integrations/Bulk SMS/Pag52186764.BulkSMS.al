// page 52186764 "Bulk SMS"
// {
//     Caption = 'Bulk SMS';
//     PageType = Card;
//     SourceTable = "Sky SMS Messages";
//     // ApplicationArea = All;
//     // UsageCategory = Administration;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(Message; MsgText)
//                 {
//                     ApplicationArea = All;
//                     MultiLine = true;
//                     Editable = true;
//                     Caption = 'Message';
//                     ToolTip = 'Enter the message you want to send to all members.';
//                 }

//             }
//         }
//     }
//     actions
//     {
//         area(processing)
//         {
//             action(SendBulkSMS)
//             {
//                 Caption = 'Send to All Member(s)';
//                 ApplicationArea = All;
//                 Image = PutawayLines;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     MemberRec: Record Members;
//                     SMSID: Guid;
//                     SkySMS: Codeunit SendSms;
//                     SMSSource: Enum "SMS Source";
//                 begin
//                     if MsgText = '' then
//                         Error('Please enter a message before sending.');

//                     MemberRec.Reset();

//                     if not MemberRec.FindSet() then
//                         Error('No members found.');

//                     repeat
//                         if MemberRec."Phone No." <> '' then begin

//                             SMSID := CreateGuid();

//                             SkySMS.SendSms(
//                                 SMSSource::BULK_SMS,
//                                 MemberRec."Phone No.",
//                                 MsgText,
//                                 SMSID,
//                                 '',
//                                 false,
//                                 0,
//                                 false,
//                                 'CBS',
//                                 '',
//                                 'CBS'
//                             );
//                         end;
//                     until MemberRec.Next() = 0;

//                     Rec.msg := '';

//                     Message('Bulk SMS has been sent successfully.');
//                 end;
//             }
//             action(SendToSpecificMember)
//             {
//                 Caption = 'Send to Specific Member(s)';
//                 ApplicationArea = All;
//                 Promoted = true;
//                 Image = PutawayLines;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 begin
//                     Report.RunModal(Report::"Send SMS to Member", true, true);
//                 end;
//             }


//         }

//     }
//     trigger OnOpenPage()
//     begin
//         MsgText := '';
//     end;

//     var
//         MsgText: Text[1000];
// }