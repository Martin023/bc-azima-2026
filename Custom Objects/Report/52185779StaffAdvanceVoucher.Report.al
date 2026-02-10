// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185779 "Staff Advance Voucher"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Staff Advance Voucher.rdl';

//     dataset
//     {
//         dataitem("Payments Header"; "Payments Header")
//         {
//             RequestFilterFields = "No.";
//             column(ReportForNavId_6437; 6437)
//             {
//             }
//             column(Picture; objLogos.Picture)
//             {
//             }
//             column(From; "Payments Header".Payee)
//             {
//             }
//             column(PF; "Payments Header"."Account No.")
//             {
//             }
//             column(Project; "Payments Header"."Shortcut Dimension 2 Code")
//             {
//             }
//             column(Date; "Payments Header"."Date Posted")
//             {
//             }
//             dataitem("Payment Line"; "Payment Line")
//             {
//                 DataItemLink = No = field("No.");
//                 column(ReportForNavId_3474; 3474)
//                 {
//                 }
//                 column(Name; "Payment Line"."Account Name")
//                 {
//                 }
//                 column(Type; "Payment Line"."Advance Type")
//                 {
//                 }
//                 column(Amount; Amount)
//                 {
//                 }
//                 column(NumberText; NumberText[1])
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     //Amount := Amount + "Payment Line".Amount;

//                     CheckReport.InitTextVariable();
//                     CheckReport.FormatNoText(NumberText, Amount, '');
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     Amount := 0;
//                     "Payment Line".Reset;
//                     "Payment Line".SetRange("Payment Line".No, "Payments Header"."No.");
//                     if "Payment Line".Find('-') then
//                         "Payment Line".CalcSums("Payment Line".Amount);
//                     Amount := "Payment Line".Amount;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 objLogos.Get;
//                 objLogos.CalcFields(objLogos.Picture);
//                 /*
//                  objLogos.RESET;
//                  objLogos.SETRANGE(objLogos.Code,"Payments Header"."Global Dimension 1 Code");
//                 IF objLogos.FIND('-') THEN BEGIN
//                     objLogos.CALCFIELDS(objLogos.Picture);
//                 END ELSE BEGIN
//                     objLogos.SETRANGE(objLogos.Default,TRUE);
//                     objLogos.CALCFIELDS(objLogos.Picture);
//                 END;
//                  */

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
//         STAFF_ADVANCE_REQUESTCaptionLbl: label 'CASH ADVANCE REQUEST';
//         PAYEMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
//         AmountCaptionLbl: label 'Amount';
//         Document_No__CaptionLbl: label 'Document No.:';
//         Currency_CaptionLbl: label 'Currency:';
//         Payment_To_CaptionLbl: label 'Payment To:';
//         Document_Date_CaptionLbl: label 'Document Date:';
//         Cheque_No__CaptionLbl: label 'Cheque No.:';
//         PURPOSECaptionLbl: label 'PURPOSE';
//         Payee_CaptionLbl: label 'Payee:';
//         Purpose_CaptionLbl: label 'Purpose:';
//         TotalCaptionLbl: label 'Total';
//         Printed_By_CaptionLbl: label 'Printed By:';
//         Amount_in_wordsCaptionLbl: label 'Amount in words';
//         RecipientCaptionLbl: label 'Recipient';
//         Name_CaptionLbl: label 'Name:';
//         Date_CaptionLbl: label 'Date:';
//         Signature_CaptionLbl: label 'Signature:';
//         objLogos: Record "Company Information";
//         Amount: Decimal;
//         CheckReport: Report Check;
//         NumberText: array[2] of Text;
// }
