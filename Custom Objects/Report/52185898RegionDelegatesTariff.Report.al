// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185898 "Region Delegates Tariff"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './BCSacco/Layout/Region Delegates Tariff.rdl';

//     dataset
//     {
//         dataitem("Delegate Members"; "Delegate Members")
//         {
//             RequestFilterFields = "Delegate MNO.", "Code";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(Code_DelegateMemberss; "Delegate Members".Code)
//             {
//             }
//             column(DelegateMNO_DelegateMemberss; "Delegate Members"."Delegate MNO.")
//             {
//             }
//             column(DelegateName_DelegateMemberss; "Delegate Members"."Delegate Name")
//             {
//             }
//             column(Position_DelegateMemberss; "Delegate Members".Position)
//             {
//             }
//             column(JobTittle_DelegateMemberss; "Delegate Members"."Job Tittle")
//             {
//             }
//             column(Status_DelegateMemberss; "Delegate Members".Status)
//             {
//             }
//             // column(RetireDate_DelegateMemberss;"Delegate Members"."Retire Date")
//             // {
//             // }
//             column(ZoneName; ZoneName)
//             {
//             }
//             dataitem("Region Delegates Tariff"; "Region Delegates Tariff")
//             {
//                 DataItemLink = "Region Code" = field(Code);
//                 column(ReportForNavId_42; 42)
//                 {
//                 }
//                 column(Description; "Region Delegates Tariff".Description)
//                 {
//                 }
//                 column(Frequency; "Region Delegates Tariff"."Payment Frequency")
//                 {
//                 }
//                 column(Amount; "Region Delegates Tariff".Amount)
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 ZoneName := '';
//                 DelegateRegion.Reset;
//                 DelegateRegion.SetRange(Code, Code);
//                 if DelegateRegion.Find('-') then begin
//                     ZoneName := DelegateRegion."Delegate Region Description";
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Company.Get;
//                 Company.CalcFields(Company.Picture);
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
//         Company: Record "Company Information";
//         DelegateRegion: Record "Delegate Region";
//         ZoneName: Text;
// }
