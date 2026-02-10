// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185947 "Modify KIN Type"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(NextofKIN; NextofKIN)
//         {
//             RequestFilterFields = "Account No";
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if NextofKIN.Relationship = KinOLdType then begin
//                     NextofKIN.Relationship := KinNewType;
//                     NextofKIN.Modify;
//                 end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Done!!!');
//             end;

//             trigger OnPreDataItem()
//             begin
//                 // KinNewType:=DELCHR(KinNewType,'=',' ');
//                 // KinOLdType:=DELCHR(KinOLdType,'=',' ');

//                 if KinNewType = '' then Error('Kindly select the new Kin type');
//                 if KinOLdType = '' then Error('Kindly select the old Kin type');
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(KinOLdType; KinOLdType)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Kin Old Relationship';
//                     TableRelation = "Relationship Types".Description;
//                 }
//                 field(KinNewType; KinNewType)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Kin New Relationship';
//                     TableRelation = "Relationship Types".Description;
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         KinOLdType: Text;
//         KinNewType: Text;
// }
