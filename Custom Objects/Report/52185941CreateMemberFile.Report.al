// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185941 "Create Member File"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Cust; Members)
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //check if file exists and skip
//                 FileTracker.Reset;
//                 FileTracker.SetRange("File Number", Cust."No.");
//                 if FileTracker.FindFirst then
//                     CurrReport.Skip
//                 else begin
//                     RequestedNo := 0;
//                     FileTracker.Reset;
//                     if FileTracker.FindLast then
//                         RequestedNo := FileTracker."Request Number" + 1;

//                     FileTracker.Init;
//                     FileTracker."File Number" := Cust."No.";
//                     FileTracker."Request Number" := RequestedNo;
//                     FileTracker."Member Name" := Cust.Name;
//                     FileTracker."Staff No" := Cust."Payroll/Staff No.";
//                     FileTracker."File Created By" := 'HARAMBEESACCO\NMUTUA';
//                     FileTracker."File Creation Date" := Today;
//                     FileTracker."ID No." := Cust."Primary Identification";
//                     FileTracker.Create := true;
//                     FileTracker."File MVT User ID" := 'HARAMBEESACCO\NMUTUA';
//                     FileTracker.Insert;
//                 end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('DONE!!!');
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
//         FileTracker: Record "File Tracker";
//         RequestedNo: Integer;
// }
