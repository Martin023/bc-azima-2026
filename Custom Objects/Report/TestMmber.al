// report 50123 UssdMember
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     Caption = 'Test Members';
//     RDLCLayout = './bc-azima-2026/Layout/Memberussdtest.rdlc';

//     dataset
//     {
//         dataitem(DataItemName; Members)
//         {
//             column(No_; "No.")
//             {

//             }
//             column(Name; Name)
//             {

//             }
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = All;

//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     var
//         myInt: Integer;
//         StartDate: Date;
// }