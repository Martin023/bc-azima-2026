// page 52186394 "MBanking Loan Application List"
// {
//     CardPageID = "MBanking Loan Application Card";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = Loans;
//     SourceTableView = WHERE(Posted = CONST(false),
//                             "Dummy Appraisal" = FILTER(false),
//                             "Picked Mobile Loan" = FILTER(true),
//                             Status = FILTER(Open));
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
//                 // field("Salary Through FOSA"; Rec.SalaryThroughFOSA)
//                 // {
//                 // }
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
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
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
//         SalaryThroughFOSA := false;
//         SavingsAccounts.Reset;
//         SavingsAccounts.SetRange("Member No.", Rec."Member No.");
//         SavingsAccounts.SetRange("Product Type", '505');
//         if SavingsAccounts.FindFirst then
//             if SavingsAccounts."Salary Through FOSA" then
//                 SalaryThroughFOSA := true;
//         /*
//         MSACCOLoans.RESET;
//         MSACCOLoans.SETRANGE("Loan No","Loan No.");
//         IF MSACCOLoans.FINDFIRST THEN BEGIN
//           GhrisPassword:=MSACCOLoans."Ghris Password";
//           branch:=MSACCOLoans.Branch;
//           END;
        
        
//         IF "Member No."<>'' THEN BEGIN
//           IF SavingsAccounts.GET(MSACCOLoans."Account No") THEN BEGIN
//             "Member No.":=SavingsAccounts."Member No.";
//             MobileNo:=SavingsAccounts."Mobile Phone No";
//             //MODIFY;
//           END ELSE BEGIN
//             Members.GET("Member No.");
//             MobileNo:=Members."Phone No.";
//             END;
//             END;
//         */


//         SkyMobileLoans.Reset;
//         SkyMobileLoans.SetRange("Loan No.", Rec."Loan No.");
//         if SkyMobileLoans.FindFirst then begin
//             GhrisPassword := SkyMobileLoans.Password;
//             MobileNo := SkyMobileLoans."Telephone No";
//         end;

//     end;

//     var
//         LoansR: Record Loans;
//         MobileNo: Code[20];
//         Members: Record Members;
//         GhrisPassword: Text;
//         MSACCOLoans: Record "M-SACCO Loans";
//         branch: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyMobileLoans: Record "Sky Mobile Loans";
//         SalaryThroughFOSA: Boolean;
// }

