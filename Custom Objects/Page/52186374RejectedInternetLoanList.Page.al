// page 52186374 "Rejected Internet Loan List"
// {
//     CardPageID = "Internet Loan Application Card";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = Loans;
//     SourceTableView = WHERE(Posted = CONST(false),
//                             "Dummy Appraisal" = FILTER(false),
//                             "Picked Mobile Loan" = FILTER(false),
//                             Status = FILTER(Rejected),
//                             "Sent Online" = FILTER(true));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Loan No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Staff No"; Rec."Staff No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(GhrisPassword; Rec.GhrisPassword)
//                 // {
//                 //     Caption = 'Ghris Password';
//                 // }
//                 field("Member No."; Rec."Member No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(MobileNo; Rec.MobileNo)
//                 // {
//                 //     Caption = 'Mobile No.';
//                 // }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Approval Date"; Rec."Approval Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(branch; Rec.branch)
//                 // {
//                 //     Caption = 'Branch';
//                 // }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Msacco Loans Report")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 //RunObject = Report "Msacco Loans Report";
//             }
//             action("Online Application Loan Report")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Report2;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 //RunObject = Report "Online Application Loan Report";
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         MobileNo := '';
//         branch := '';
//         Members.Get(Rec."Member No.");
//         MobileNo := Members."Phone No.";
//         branch := Members."Global Dimension 2 Code";

//         InternetLoans.Reset;
//         InternetLoans.SetRange("Loan No", Rec."Loan No.");
//         if InternetLoans.FindFirst then begin
//             GhrisPassword := InternetLoans."Ghris Password";
//         end;
//     end;

//     var
//         LoansR: Record Loans;
//         MobileNo: Code[20];
//         Members: Record Members;
//         GhrisPassword: Text;
//         InternetLoans: Record "Online Loans Applications";
//         branch: Text;
// }

