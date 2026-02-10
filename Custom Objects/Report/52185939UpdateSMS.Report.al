// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185939 "Update SMS"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(MsaccoSMS; "M-SACCO SMS Messages")
//         {
//             //DataItemTableView = where(Source = filter(MSACCO), "Sent To Server" = filter(No));
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 // if (MsaccoSMS.Source = MsaccoSMS.Source::MSACCO) and (MsaccoSMS."Sent To Server" = MsaccoSMS."sent to server"::No) and
//                 //   (MsaccoSMS."SMS Message" = 'Dear member, channel your salary through Harambee SACCO FOSA and enjoy salary advance of up to 24 months, maximum of Kshs 250,000 available online via *346# loans menu.') then begin
//                 //     MsaccoSMS."Sent To Server" := MsaccoSMS."sent to server"::Yes;
//                 //     MsaccoSMS.Modify;
//                 // end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Successfuly updated');
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
// }
