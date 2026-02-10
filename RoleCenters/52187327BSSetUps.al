// page 52187327 "BS SetUps Role Center"
// {
//     Caption = 'BS SetUps Role Center';
//     PageType = RoleCenter;

//     layout
//     {
//         area(RoleCenter)
//         {
//             part("Emails"; "Email Activities")
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             part(ApprovalsActivities; "Approvals Activities")
//             {
//                 ApplicationArea = Suite;
//             }
//             systempart(Control1901377608; MyNotes)
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }
//     actions
//     {
//         area(Sections)
//         {
//             group("Group")
//             {
//                 Caption = 'Group';
//             group("Group1")
//             {
//                 Caption = 'Lists';
//                 action("Approval Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approval Entries';
//                     RunObject = page "Approval Entries";
//                 }
//                 action("Item List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Item';
//                     RunObject = page "Item List";
//                 }
//                 action("Location List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Location';
//                     RunObject = page "Location List";
//                 }
//                 action("Vendor List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Vendor';
//                     RunObject = page "Vendor List";
//                 }
//                 action("Customers")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Customers';
//                     RunObject = page "Customer List";
//                 }
//                 }
//                 group("Group2")
//                 {
//                     Caption = 'Administration';
//                 action("Gen. Business Posting Groups")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Gen. Business Posting Groups';
//                     RunObject = page "Gen. Business Posting Groups";
//                 }
//                 action("Leave Allowances")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Restricted Fields';
//                     RunObject = page "Leave Allowances";
//                 }
//                 action("Salutation Tittles")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Salutation Tittles';
//                     RunObject = page "Salutation Tittles";
//                 }
//                 }
//             }
//                 group("Group3")
//             {
//                 Caption = 'Approvals';
//                 action("Requests to Approve")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Requests to Approve';
//                     RunObject = page "Requests to Approve";
//                 }
//                 action("Approval Request Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approval Request Entries';
//                     RunObject = page "Approval Request Entries";
//                 }
//                 action("Approval Entries Archive")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approval Entries Archive';
//                     RunObject = page "Approval Entries Archive";
//                 }
//             }
//         }
//     }
// }
