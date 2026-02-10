// page 52185475 "Agent Membership Applic. List"
// {
//     CardPageID = "Agent Membership Application";
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     SourceTable = "Member Application";
//     SourceTableView = WHERE(Status = FILTER(Open | Pending | Approved),
//                             "Account Type" = filter(<>"Single Member Account"),
//                             Source = FILTER(<> 'CRM'));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control13)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Customer Type"; Rec."Customer Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Phone No."; Rec."Phone No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Primary Identification"; rec."Primary Identification")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Secondary Identification";Rec."Secondary Identification")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payroll/Staff No."; Rec."Payroll/Staff No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Employer Code"; Rec."Employer Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("P.I.N Number"; Rec."P.I.N Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

