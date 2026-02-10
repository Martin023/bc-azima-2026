// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 52185600 "CRM Connection Failures"
// {
//     Caption = 'Microsoft Dynamics CRM Connection Failures';
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = 5371;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Server Address"; "Server Address")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(ErrorMsg; ErrorMsg)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Error';
//                 }
//                 field("First Occurrence"; "First Occurrence")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Occurrence"; "Last Occurrence")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Occurrence Count"; "Occurrence Count")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Delete0days)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Delete All Entries';
//                 Image = Delete;

//                 trigger OnAction()
//                 begin
//                     DeleteEntries(0);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ErrorMsg := GetError;
//     end;

//     var
//         ErrorMsg: Text;
// }
