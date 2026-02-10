// page 52186623 "HR All users Role Centre"
// {
//     PageType = RoleCenter;
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control6)
//             {
//                 ShowCaption = false;
//                 systempart(Control5; Outlook)
//                 {
//                 }
//             }
//             group(Control4)
//             {
//                 ShowCaption = false;
//                 systempart(Control2; Links)
//                 {
//                 }
//                 systempart(Control1; MyNotes)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(embedding)
//         {
//             group(Action8)
//             {
//                 Caption = 'Staff Applications Role Centre';
//                 action("Overtime  Application")
//                 {
//                     Caption = 'Overtime  Application';
//                     //RunObject = Page "HR Overtime List";
//                     ApplicationArea = Basic;
//                     // RunPageView = WHERE (Status = CONST (New));
//                 }
//                 action("Training Application")
//                 {
//                     Caption = 'Training Application';
//                     RunObject = Page "HR Emp Training Appl. Req List";
//                     RunPageView = WHERE(Status = CONST(New));
//                     ApplicationArea = Basic;
//                 }
//                 action("Medical Claim Application")
//                 {
//                     Caption = 'Medical Claim Application';
//                     // RunObject = Page "HR Medical Claims List";
//                     ApplicationArea = Basic;
//                 }
//                 action("Transport Request")
//                 {
//                     Caption = 'Transport Request';
//                     RunObject = Page "HR Transport Requests List";
//                     ApplicationArea = Basic;
//                 }
//                 action("Leave Application")
//                 {
//                     Caption = 'Leave Application';
//                     //  RunObject = Page "HR Leave Applications List";
//                     ApplicationArea = Basic;
//                 }
//                 action(Appraisal)
//                 {
//                     Caption = 'Appraisal';
//                     //  RunObject = Page "HR 360 Appraisals List - TS"
//                     ApplicationArea = Basic;
//                     ;
//                     //RunPageView = WHERE (Status = CONST (Open));
//                 }
//             }
//         }
//     }
// }

