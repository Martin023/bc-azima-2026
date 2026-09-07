// namespace ALProject.ALProject;
// using System.Security.User;

// page 52186484 "HR Collateral List"
// {
//     CardPageID = "HR Collateral Register";
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     SourceTable = "Securities Register";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Collateral No.';
//                 }
//                 field("Collateral Category"; Rec."Collateral Category")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }

//                 field("Account No."; Rec."Account No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Account Name"; Rec."Account Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Collateral Ref No."; Rec."Collateral Ref No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Collateral; Rec.Collateral)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 field("Market Value"; Rec."Market Value")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field("Captured By"; Rec."Captured By")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 // field("Date Captured"; Rec."Date Captured")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(Remarks; Rec.Remarks)
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Perfected"; Rec."Collateral Perfected")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Discharged"; Rec."Collateral Discharged")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Substituted; Rec."Collateral Substituted")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }

//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control5; Notes)
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             systempart(Control6; MyNotes)
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             systempart(Control7; Links)
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }

//     actions
//     {
//     }
//     trigger OnOpenPage()
//     var
//         UserSetup: Record "User Setup";
//     begin
//         if UserSetup.Get(UserId) then begin
//             UserSetup.TestField("Responsibility Centre");
//             Rec.SetFilter("Current Departmrnt", UserSetup."Responsibility Centre");
//         end else
//             Error('You must be set up in user setup');
//     end;
// }


