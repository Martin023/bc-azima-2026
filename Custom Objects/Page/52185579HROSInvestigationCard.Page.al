// page 52185579 "HR OSInvestigation Card"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     SourceTable = "HR OSInvestigation";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Investigation No"; Rec."Investigation No")
//                 {
//                     Editable = false;
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
//                 field("Person Investigating"; Rec."Person Investigating")
//                 {
//                 }
//                 field("Date of Assigning"; Rec."Date of Assigning")
//                 {
//                     Editable = false;
//                 }
//                 field(Cause; Rec.Cause)
//                 {
//                     MultiLine = true;
//                 }
//                 field("Resolution/Recommendation"; Rec."Resolution/Recommendation")
//                 {
//                     MultiLine = true;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Send For Inspection")
//             {
//                 Caption = 'Send For Inspection';

//                 trigger OnAction()
//                 begin
//                     Rec.TestField("Person Investigating");
//                     if Confirm('Are you sure you want to Send for Inspection?', true, false) then begin
//                         Rec.Status := Rec.Status::"Assigned Investigation";
//                         Rec.Modify;
//                     end;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         /*
//         Status:=Status::"Reported Investigation";
//         MODIFY;
//         */

//     end;
// }

