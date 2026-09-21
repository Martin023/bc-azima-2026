// namespace MNSProjectMwanga.MNSProjectMwanga;

// page 52186745 "Detailed Member Balance List"
// {
//     ApplicationArea = All;
//     Caption = 'Detailed Member Balance List';
//     PageType = List;
//     SourceTable = "Member FactBox";
//     UsageCategory = Lists;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PromotedActionCategories = ',,,Update Entries';

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("Member No."; Rec."Member No.")
//                 {
//                     ToolTip = 'Specifies the value of the Member No. field.';
//                 }
//                 field("Member Name"; rec."Member Name")
//                 {
//                     ApplicationArea = Basci, Suite;
//                 }
//                 // field(BBF; Rec.BBF)
//                 // {
//                 //     ToolTip = 'Specifies the value of the BBF field.';
//                 // }
//                 // field("BBF Contribution"; Rec."BBF Contribution")
//                 // {
//                 //     ToolTip = 'Specifies the value of the BBF Contribution field.', Comment = '%';
//                 // }
//                 field("Entrance Fee"; Rec."Entrance Fee")
//                 {
//                     ToolTip = 'Specifies the value of the Entrance Fee field.', Comment = '%';
//                 }
//                 field("BOSA Deposit"; Rec."BOSA Deposit")
//                 {
//                     ToolTip = 'Specifies the value of the BOSA Deposit field.';
//                 }
//                 field("Share Capital"; Rec."Share Capital")
//                 {
//                     ToolTip = 'Specifies the value of the Share Capital field.';
//                 }
//                 // field("Unallocated Funds"; Rec."Unallocated Funds")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Unallocated Funds field.', Comment = '%';
//                 // }
//                 // field("Kesasa Savings"; Rec."Kesasa Savings")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Kesasa Savings field.', Comment = '%';
//                 // }
//                 field("FOSA Savings"; Rec."FOSA Savings")
//                 {
//                     ToolTip = 'Specifies the value of the FOSA Savings.';
//                 }
//                 field("BOSA Loans"; Rec."BOSA Loans")
//                 {
//                     ToolTip = 'Specifies the value of the BOSA Loans Issued field.';
//                 }
//                 // field("BUSINESS Loans"; Rec."BUSINESS Loans")
//                 // {
//                 //     ToolTip = 'Specifies the value of the BUSINESS Loans Issued field.';
//                 // }
//                 // field("Bosa Monthly Contribution"; Rec."Bosa Monthly Contribution")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Bosa Monthly Contribution field.', Comment = '%';
//                 // }
//                 // field("Business Deposits"; Rec."Business Deposits")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Business Deposits field.', Comment = '%';
//                 // }

//                 field("FOSA Loans"; Rec."FOSA Loans")
//                 {
//                     ToolTip = 'Specifies the value of the FOSA Loans Issued field.';
//                 }

//                 // field("HR Loans"; Rec."HR Loans")
//                 // {
//                 //     ToolTip = 'Specifies the value of the HR Loans Issued field.';
//                 // }
//                 // field(Risk; Rec.Risk)
//                 // {
//                 //     ToolTip = 'Specifies the value of the Risk field.';
//                 // }
//                 // field("Risk Contribution"; Rec."Risk Contribution")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Risk Contribution field.', Comment = '%';
//                 // }

//                 field("Total Loans"; Rec."Total Loans")
//                 {
//                     ToolTip = 'Specifies the value of the Total Loans field.', Comment = '%';
//                 }
//                 // field("Transferred Share Capital"; Rec."Transferred Share Capital")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Transferred Share Capital field.';
//                 // }

//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             group("Update Member Bal .Entries")
//             {
//                 Caption = 'Update Entries';
//                 action("Update Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Update Entries';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         MemFactbox: record "Member FactBox";
//                         MemberList: record Members;
//                     begin
//                         // MemFactbox.reset;
//                         // MemFactbox.deleteall();
//                         //
//                         MemberList.reset;
//                         if MemberList.findset() then begin
//                             repeat
//                                 if not MemFactbox.get(MemberList."No.") then begin
//                                     MemFactbox.Init();
//                                     MemFactbox."Member No." := MemberList."No.";
//                                     MemFactbox."Member Name" := MemberList.Name;
//                                     MemFactbox.Insert();
//                                 end;
//                             until MemFactbox.next = 0;
//                         end;
//                     end;
//                 }
//             }

//         }

//     }


// }
