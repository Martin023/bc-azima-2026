// page 52185743 "Savings Account List"
// {
//     CardPageID = "Savings Account Card";
//     Editable = false;
//     InsertAllowed = false;
//     DeleteAllowed = false;
//     PageType = List;
//     ShowFilter = true;
//     SourceTable = "Savings Accounts";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;
//     PromotedActionCategories = 'New, Process, Approvals, Workflows';
//     SourceTableView = where("Account Profile" = const("Normal Member"));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Product Name"; Rec."Product Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Old Account No"; Rec."Old Account No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(Salutation; Rec.Salutation)
//                 // {
//                 //     Caption = 'Salutation';
//                 // }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Product Type"; Rec."Product Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }

//                 field("Member No."; Rec."Member No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Salary Through FOSA"; Rec."Salary Through FOSA")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("ID No."; Rec."ID No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transactional Mobile No"; Rec."Transactional Mobile No")
//                 {
//                     ApplicationArea = all;
//                 }
//                 // field("Sort Order"; Rec."Sort Order")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Registration Date"; Rec."Registration Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payroll/Staff No."; Rec."Payroll/Staff No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field("Transactional Mobile No"; Rec."Transactional Mobile No")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Mobile Phone No"; Rec."Mobile Phone No")
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
//                 field("Employer Code"; Rec."Employer Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Blocked; Rec.Blocked)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Balance; Rec.Balance)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field("Send Statement Freq."; Rec."Send Statement Freq.")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 // field("Last Statement Date"; Rec."Last Statement Date")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 // field("Group Account No"; Rec."Group Account No")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 // field("ATM No."; Rec.NewStr)
//                 // {
//                 // }
//                 field("Product Category"; Rec."Product Category")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(HideBal; Rec.HideBal)
//                 // {
//                 //     Caption = 'Balance (LCY)';
//                 // }
//                 // field("Employer Account No"; Rec."Employer Account No")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Loan Disbursement Account"; Rec."Loan Disbursement Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field("Salary Through FOSA"; Rec."Salary Through FOSA")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Last Date Modified"; Rec."Last Date Modified")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Last ov int Charged Date"; Rec."Last ov int Charged Date")
//                 {
//                     Caption = 'Last Interest Charged Date';
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Last Transaction Date"; Rec."Last Transaction Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field("Business Account Code"; Rec."Business Account Code")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//                 field("Customer Posting Group"; rec."Customer Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 // field(Prorata; Rec."Prorata")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 //     Image = Cash;
//                 //     ToolTip = 'Specifies prorata amount';
//                 //     trigger OnDrillDown()
//                 //     var
//                 //         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
//                 //     begin
//                 //         CustomCuesCodeunit.DrillDownProrataRecs(Rec."Member No.", Rec."Product Type");
//                 //     end;
//                 // }
//                 field("Lien Placed"; Rec."Lien Placed")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("One Month Installment"; Rec."One Month Installment")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Status"; Rec."Member Status")
//                 {
//                     Editable = false;
//                 }
//                 field("Member Sub Status"; Rec."Member Sub Status")
//                 {
//                     Editable = false;
//                 }
//                 field("Group Account No"; Rec."Group Account No")
//                 {
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(GenerateDormant)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Process;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     REPORT.Run(REPORT::"Generate Dormant Accounts", true, true, Rec);
//                 end;
//             }

//             action("Flag Email Reminder")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Process;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = true;

//                 trigger OnAction()
//                 begin
//                     REPORT.Run(REPORT::"Flag Email Reminder");
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CalculateCues;
//         NewStr := '';
//         if StrLen(Rec."ATM No.") > 4 then begin
//             Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
//             NewStr := 'xxxxxxxx' + Str;
//         end;

//         Rec.CalcFields("Balance (LCY)");
//         Evaluate(HideBal, Format(Rec."Balance (LCY)"));
//         //HideBal:='X.XX';
//         if UserSetup.Get(UserId) then begin
//             if UserSetup."Show Hidden Balance" = false then begin
//                 if Rec."Product Category" = Rec."Product Category"::"Unallocated Fund" then
//                     HideBal := 'X.XX';
//                 if Rec."Loan Disbursement Account" = true then
//                     HideBal := 'X.XX';
//             end;
//         end;
//         if Members.Get(Rec."Member No.") then begin
//             Salutation := Members.Salutation;
//         end;
//     end;

//     trigger OnOpenPage()
//     begin
//         HideAccount := GlobalFunctions.HideAccount(Rec."No.");
//         if HideAccount then begin
//             Rec.SetFilter("Account Profile", '<>%1', Rec."Account Profile"::"Normal Member");
//         end;

//         NewStr := '';
//         if StrLen(Rec."ATM No.") > 4 then begin
//             Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
//             NewStr := 'xxxxxxxx' + Str;
//         end;
//         Rec.CalcFields("Balance (LCY)");
//         Evaluate(HideBal, Format(Rec."Balance (LCY)"));

//         if UserSetup.Get(UserId) then begin
//             if UserSetup."Show Hidden Balance" = false then begin
//                 if Rec."Product Category" = Rec."Product Category"::"Unallocated Fund" then
//                     HideBal := 'X.XX';
//                 if Rec."Loan Disbursement Account" = true then
//                     HideBal := 'X.XX';

//                 // IF Rec."Account Profile" <> Rec."Account Profile"::"Normal Member" THEN BEGIN
//                 //     IF UserSetup."Show Hidden" = FALSE THEN
//                 //         Rec.SetRange(Rec."Account Profile", Rec."Account Profile"::"Normal Member");
//                 // END;
//             end;
//         end;
//         if Members.Get(Rec."Member No.") then begin
//             Salutation := Members.Salutation;
//         end;
//     end;

//     var
//         Str: Code[30];
//         NewStr: Code[30];
//         Members: Record Members;
//         Salutation: Code[10];
//         HideBal: Text;
//         UserSetup: Record "User Setup";
//         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
//         GlobalFunctions: Codeunit "Global Functions";
//         HideAccount: Boolean;

//     local procedure CalculateCues()
//     begin


//         rec.Prorata := CustomCuesCodeunit.Prorata(Rec."Member No.", Rec."Product Type");
//     end;
// }