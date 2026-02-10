// page 52186616 "HR Shift Schedule Lines"
// {
//     PageType = ListPart;
//     SourceTable = "HR Shift Schedule Lines";

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Employee No."; Rec."Employee No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Full Name"; Rec."Full Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 1 Rec.Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 2 Rec.Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Clock In Time"; Rec."Clock In Time")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Clock Out Time"; Rec."Clock Out Time")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Duration; Rec.Duration)
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
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 Image = Line;
//                 action("Suggest Participants")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Suggest Participants';

//                     trigger OnAction()
//                     begin
//                         HRShiftScheduleHeader.Reset;
//                         HRShiftScheduleHeader.SetRange(HRShiftScheduleHeader.Code, Rec.Code);
//                         if HRShiftScheduleHeader.Find('-') then begin
//                             //  HRShiftScheduleHeader.TESTFIELD(HRShiftScheduleHeader.Status,HRShiftScheduleHeader.Status::Approved);
//                         end;



//                         Rec.Reset;
//                         Rec.SetFilter(Code, Rec.Code);
//                         REPORT.Run(REPORT::"HR Suggest Participants OLD", true, true, Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         HRShiftScheduleHeader: Record "HR Shift Schedule Header";
//         HRShiftScheduleLines: Record "HR Shift Schedule Lines";
// }

