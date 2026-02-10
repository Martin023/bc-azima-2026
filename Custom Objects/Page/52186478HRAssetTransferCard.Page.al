// page 52186478 "HR Asset Transfer Card"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'Manage,Proces,Report,Transfer';
//     SourceTable = "HR Asset Transfer Header";
//     SourceTableView = WHERE(Transfered = CONST(false));
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Raised by"; Rec."Raised by")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Current Holder"; Rec."Current Holder")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Current Holder Name"; Rec."Current Holder Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Asset to Transfer"; Rec."Asset to Transfer")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Asset Description"; Rec."Asset Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Serial No."; Rec."Serial No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("New Holder"; Rec."New Holder")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Holder Name"; Rec."New Holder Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Transfered; Rec.Transfered)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date Transfered"; Rec."Date Transfered")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Transfered By"; Rec."Transfered By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Time Transferred"; Rec."Time Transferred")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control16; Links)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Transfer)
//             {
//                 Image = TransferToLines;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     //TESTFIELD(Status,Status::Approved);

//                     if Confirm(Txt001, false) = true then begin

//                         EmployeeAssets.Reset;
//                         EmployeeAssets.SetRange(EmployeeAssets."Employee No.", Rec."Current Holder");
//                         EmployeeAssets.SetRange(EmployeeAssets."Misc. Article Code", Rec."Asset to Transfer");
//                         if EmployeeAssets.Find('-') then begin
//                             EmployeeAssets."In Use" := false;
//                             EmployeeAssets."To Date" := Today;
//                             EmployeeAssets.Modify;

//                             EmployeeAssets.Reset;
//                             EmployeeAssets.Init;
//                             EmployeeAssets."Employee No." := Rec."New Holder";
//                             EmployeeAssets."Misc. Article Code" := Rec."Asset to Transfer";
//                             EmployeeAssets.Description := Rec."Asset Description";
//                             EmployeeAssets."Serial No." := Rec."Serial No.";
//                             EmployeeAssets."From Date" := Today;
//                             EmployeeAssets."In Use" := true;
//                             EmployeeAssets.Insert(true);

//                             Rec.Transfered := true;
//                             Rec."Transfered By" := UserId;
//                             Rec."Date Transfered" := Today;
//                             Rec."Time Transferred" := Time;

//                             Message(Txt002, Rec."Asset to Transfer", Rec."New Holder");
//                         end;


//                     end;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         Updatecontrol;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         Updatecontrol;
//     end;

//     trigger OnInit()
//     begin
//         Edit := true;
//         Line := true;
//     end;

//     var
//         RecHeader: Record "HR Asset Transfer Header";
//         //// //ApprovalEntries: Page "Approval Entries";
//         Edit: Boolean;
//         Line: Boolean;
//         EmployeeAssets: Record "Misc. Article Information";
//         Txt001: Label 'Do you want to effect the transfer';
//         Txt002: Label 'Asset %1 Successfully Transferred to Employee %2';

//     //[Scope('OnPrem')]
//     procedure Updatecontrol()
//     begin
//         /*
//         IF Status=Status::Open THEN BEGIN
//         Edit:=TRUE;
//         Line:=TRUE;
//         END ELSE IF Status=Status::"Pending Approval" THEN BEGIN
//         Edit:=FALSE;
//         Line:=FALSE;
//         END ELSE IF Status=Status::Approved THEN BEGIN
//         Edit:=FALSE;
//         Line:=FALSE;
//         END
//          */

//     end;
// }

