// page 52186579 "HR General Manager Cue"
// {
//     PageType = CardPart;
//     SourceTable = "HR Manager Cue";
//     Caption = 'Employee management';


//     layout
//     {

//         area(content)
//         {
//             cuegroup("Employee Cues")
//             {
//                 Caption = 'Jobs';

//                 field("Approved Job Posistions"; Rec."Approved Job Posistions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Requisitions Pending Approval"; Rec."Requisitions Pending Approval")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Job applications"; Rec."Job applications")
//                 {
//                     ApplicationArea = Basic;
//                 }


//             }
//             cuegroup(Control17)
//             {
//                 Caption = 'Employees';

//                 field(Active; Rec.Active)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'All Active Employees';
//                     Image = Stack;
//                 }
//                 field(Female; Rec.Female)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Female Employees';
//                     Image = Stack;
//                 }
//                 field(Male; Rec.Male)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Male Employees';
//                     Image = Stack;
//                 }
//                 // field("Contracts Due"; Rec."Contracts Due")
//                 // {
//                 //     ApplicationArea = Basic;
//                 // }

//             }
//             cuegroup(Control18)
//             {
//                 Caption = 'Employee Leave/Promotions';

//                 field("HR Promotion recommendations"; Rec."HR Promotion recommendations")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Leave applications"; Rec."Approved Leave applications")
//                 {
//                     ApplicationArea = Basic;
//                 }

//             }
//             cuegroup(Control19)
//             {
//                 Caption = 'Disciplinary Cases/Loans';
//                 field("Hr Disciplinary Cases"; Rec."Hr Disciplinary Cases")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Staff Advance loans"; Rec."Approved Staff Advance loans")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     // actions
//     // {
//     //     action(Action6)
//     //     {
//     //         RunObject = Page "HR Proffesional Body Members";
//     //     }
//     // }

//     trigger OnOpenPage()
//     begin
//         Rec.Reset;
//         if not rec.Get() then begin
//             Rec.Init;
//             Rec.Insert;
//         end;
//     end;
// }

