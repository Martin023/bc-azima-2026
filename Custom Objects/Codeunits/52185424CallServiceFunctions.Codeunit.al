// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185424 CallServiceFunctions
// {

//     trigger OnRun()
//     begin

//         /*
//         FOR j := 1 TO 10 DO BEGIN
//             k := RANDOM(5);
//             SkyMbanking.CallServiceFunction(k);
//         END;
//         */

//         ResendNewPins;
//         Message('DOne');

//     end;

//     var
//         SendSMS: Codeunit SendSms;
//         k: Integer;
//         j: Integer;
//         SkySMSMessages: Record "Sky SMS Messages";
//         SkyUSSDAuth: Record "Sky USSD Auth";

//         Source: Enum "SMS Source";

//     local procedure ResendNewPins()
//     begin

//         SkyUSSDAuth.Reset;
//         SkyUSSDAuth.SetRange(IMSI, '');
//         //SkyUSSDAuth.SETRANGE("Mobile No.",'+254110444395');
//         SkyUSSDAuth.SetRange("Pin Resent", false);
//         if SkyUSSDAuth.FindFirst then begin
//             repeat
//                 SkySMSMessages.Reset;
//                 SkySMSMessages.SetRange(receiver, CopyStr(SkyUSSDAuth."Mobile No.", 2, 13));
//                 SkySMSMessages.SetRange(msg_category, 'MOBILE_PIN');
//                 if SkySMSMessages.FindFirst then begin
//                     if SkySMSMessages.Count = 1 then begin
//                         SkyUSSDAuth."Pin Resent" := true;
//                         SkyUSSDAuth.Modify;
//                         SendSMS.SendSms(Source::MOBILE_PIN, SkyUSSDAuth."Mobile No.", SkySMSMessages.msg, Format(SkyUSSDAuth."Account No."), '', true, 0, false, 'CBS', SkyUSSDAuth."Account No.", 'CBS');

//                     end;
//                 end;
//             until SkyUSSDAuth.Next = 0;
//         end;
//     end;
// }
