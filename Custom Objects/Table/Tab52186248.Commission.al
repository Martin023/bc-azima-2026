// table 52186248 Commission
// {
//     Caption = 'Commission Generation List';
//     DataClassification = ToBeClassified;
//     DrillDownPageId = "Commission Generation List";

//     fields
//     {
//         field(1; ID; Code[20])
//         {
//             Caption = 'ID';
//             DataClassification = SystemMetadata;
//             Editable = false;
//         }

//         field(2; Remarks; Text[250])
//         {
//             Caption = 'Remarks';
//             DataClassification = CustomerContent;
//         }
//         field(3; "Cutoff date"; Date)
//         {
//             Caption = 'Cutoff date';
//             DataClassification = CustomerContent;
//         }
//         field(4; "Member Count"; Integer)
//         {
//             Editable = false;
//             Caption = 'Member Count';
//             DataClassification = CustomerContent;
//         }
//         field(5; "Loans Count"; Integer)
//         {
//             Editable = false;
//             Caption = 'Loans Count';
//             DataClassification = CustomerContent;
//         }
//         field(6; Status; Enum "Employee Status")
//         {
//         }
//         field(7; "Date Created"; Date)
//         {
//             Editable = false;
//             Caption = 'Date Created';
//             DataClassification = CustomerContent;
//         }


//     }
//     keys
//     {
//         key(PK; ID)
//         {
//             Clustered = true;
//         }
//     }
// }
