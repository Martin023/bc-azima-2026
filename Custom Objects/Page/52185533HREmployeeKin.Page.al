// page 52185533 "HR Employee Kin"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = Card;
//     SaveValues = true;
//     SourceTable = "HR Employees";

//     layout
//     {
//         area(content)
//         {
//             group("Employee Details")
//             {
//                 Caption = 'Employee Details';
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(FullName; Rec.FullName)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Name';
//                     Editable = false;
//                     Enabled = false;
//                     Importance = Promoted;
//                     StyleExpr = TRUE;
//                 }
//                 field("Job Title"; Rec."Job Title")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = false;
//                     Importance = Promoted;
//                     StyleExpr = TRUE;
//                 }
//                 field(Gender; Rec.Gender)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = false;
//                     StyleExpr = TRUE;
//                 }
//                 field("Post Code"; Rec."Post Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = false;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("E-Mail"; Rec."E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(Control1102755008; "HR Employee Kin SF")
//             {
//                 SubPageLink = "Employee Code" = FIELD("No.");
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1102755002; Outlook)
//             {
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         D: Date;
//         EmpNames: Text[30];
//         HREmp: Record "HR Succession Job Rotation";
//         Text19032351: Label 'Next Of Kin/Beneficiaries';
// }

