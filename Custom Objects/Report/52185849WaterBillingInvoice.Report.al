// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185849 "Water Billing Invoice"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Water Billing Invoice.rdl';

//     dataset
//     {
//         dataitem(52186021;52186021)
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(InvoiceNo_BillUnitsmeterRatings;"Bill Units meter Ratings"."Invoice No.")
//             {
//             }
//             column(PostingDate_BillUnitsmeterRatings;"Bill Units meter Ratings"."Posting Date")
//             {
//             }
//             column(TenantName_BillUnitsmeterRatings;"Bill Units meter Ratings"."Tenant Name")
//             {
//             }
//             column(PreviousReading_BillUnitsmeterRatings;"Bill Units meter Ratings"."Previous Reading")
//             {
//             }
//             column(CurrentReading_BillUnitsmeterRatings;"Bill Units meter Ratings"."Current Reading")
//             {
//             }
//             column(Consumption_BillUnitsmeterRatings;"Bill Units meter Ratings".Consumption)
//             {
//             }
//             dataitem(52186015;52186015)
//             {
//                 DataItemTableView = sorting("Tier Code");
//                 column(ReportForNavId_8; 8)
//                 {
//                 }
//                 column(TierCode_WaterBillingrate;"Water Billing rate"."Tier Code")
//                 {
//                 }
//                 column(BillRatetier_WaterBillingrate;"Water Billing rate"."Bill Rate tier")
//                 {
//                 }
//                 column(Rate_WaterBillingrate;"Water Billing rate".Rate)
//                 {
//                 }
//                 column(Distribution_WaterBillingrate;"Water Billing rate".Distribution)
//                 {
//                 }
//             }
//             dataitem(52186026;52186026)
//             {
//                 DataItemTableView = sorting(No) where(No=filter(2));
//                 column(ReportForNavId_13; 13)
//                 {
//                 }
//                 column(BHoleAverageSewerCharge_CommonAreaCharges;"Common Area Charges"."B/Hole Average Sewer Charge")
//                 {
//                 }
//                 column(MeterRent_CommonAreaCharges;"Common Area Charges"."Meter Rent")
//                 {
//                 }
//                 column(CAreaFixedCharge_CommonAreaCharges;"Common Area Charges"."C/Area Fixed Charge")
//                 {
//                 }
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
// }
