// page 52185581 "HR OSInspection Card"
// {
//     PageType = Card;
//     SourceTable = "HR OSInvestigation";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Editable = false;
//                 field("Investigation No"; Rec."Investigation No")
//                 {
//                 }
//                 field("Incident No"; Rec."Incident No")
//                 {
//                 }
//                 field("Incident Description"; Rec."Incident Description")
//                 {
//                 }
//                 field("Date of Incident"; Rec."Date of Incident")
//                 {
//                 }
//                 field("Location Name"; Rec."Location Name")
//                 {
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Editable = false;
//                 }
//             }
//             part(Control9; "HR OSSafety Checklist List")
//             {
//                 SubPageLink = "Incident No" = FIELD("Incident No");
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Return for Investigation")
//             {
//                 Caption = 'Return for Investigation';

//                 trigger OnAction()
//                 begin
//                     if Confirm('Are you sure you want to Retrun for Investigation?', true, false) then begin
//                         Rec.Status := Rec.Status::"Reported Investigation";
//                         Rec.Modify;
//                     end;
//                 end;
//             }
//             action("Generate Training Need")
//             {
//                 Caption = 'Generate Training Need';

//                 trigger OnAction()
//                 begin
//                     if Confirm('Are you sure you want to Generate Training Need for this Measures?', true, false) then begin
//                         Message('Training Need Has been created Successfully');
//                     end;
//                 end;
//             }
//         }
//     }
// }

