// page 52185531 "HR Employee-List(Interns)App1"
// {
//     CardPageID = "HR Employees Factbox";
//     Editable = false;
//     PageType = List;
//     SourceTable = "HR Employees";
//     SourceTableView = SORTING("No.")
//                       ORDER(Ascending)
//                       WHERE("Contract Type" = FILTER('4'),
//                             Status = FILTER(Active));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                     Style = StrongAccent;
//                     StyleExpr = TRUE;
//                 }
//                 field("First Name"; Rec."First Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Name"; Rec."Last Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Position; Rec.Position)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Job Title"; Rec."Job Title")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Department Code"; Rec."Department Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Office; Rec.Office)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Cellular Phone Number"; Rec."Cellular Phone Number")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Company E-Mail"; Rec."Company E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Import Notches")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Import Notches';
//                 ////RunObject = XMLport XMLport50051;
//             }
//             action("Import Notch Transactions")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Import Notch Transactions';
//                 ////RunObject = XMLport XMLport50061;
//             }
//             action("Import Payroll Variations")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Import Payroll Variations';
//                 ////RunObject = XMLport "Checkoff Buffer";
//             }
//             action("Import Employee Trans")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Import Employee Trans';
//                 ////RunObject = XMLport XMLport50060;
//             }
//             action(Abscence)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Abscence';
//                 Image = Absence;
//                 Promoted = true;
//                 RunObject = Page "Employee Absences";
//                 RunPageLink = "Employee No." = FIELD("No.");
//                 Visible = false;
//             }
//             action(Lateness)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Lateness';
//                 Image = AbsenceCalendar;
//                 Promoted = true;
//                 RunObject = Page prLatenessLedger;
//                 RunPageLink = "Employee Code" = FIELD("No.");
//                 Visible = false;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         DepName := '';
//         DValues.Reset;
//         DValues.SetRange(DValues.Code, Rec."Department Code");
//         if DValues.Find('-') then
//             DepName := DValues.Name;

//         BankName := '';
//         Banks.Reset;
//         Banks.SetRange(Banks."Branch Code", Rec."Main Bank");
//         Banks.SetRange(Banks."Branch Name", Rec."Branch Bank");
//         if Banks.Find('-') then
//             BankName := Banks."Bank Name";
//     end;

//     trigger OnOpenPage()
//     begin
//         if (DepCode <> '') then
//             Rec.SetFilter("Department Code", ' = %1', DepCode);
//         if (OfficeCode <> '') then
//             Rec.SetFilter(Office, ' = %1', OfficeCode);
//     end;

//     var
//         Mail: Codeunit Mail;
//         PictureExists: Boolean;
//         DepCode: Code[10];
//         OfficeCode: Code[10];
//         DepName: Text[100];
//         BankName: Text[200];
//         DValues: Record "Dimension Value";
//         Banks: Record "PR Bank Branches";

//     //[Scope('OnPrem')]
//     procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
//     begin
//         DepCode := DepartmentCode;
//         OfficeCode := "Office Code";
//     end;
// }

