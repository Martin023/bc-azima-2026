// page 52186482 "HR Effected Asset Transfer"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "HR Asset Transfer Header";
//     SourceTableView = WHERE(Status = CONST(Approved),
//                             Transfered = CONST(true));

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
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
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
//             action(Approvals)
//             {
//                 Caption = 'Approvals';
//                 Image = Approvals;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
//                 begin

//                     DocumentType := DocumentType::"Asset Transfer";
//                     ApprovalEntries.SetRecordFilters(DATABASE::"HR Asset Transfer Header", DocumentType, Rec."No.");
//                     ApprovalEntries.Run;
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
//         //ApprovalEntries: Page "Approval Entries";
//         Edit: Boolean;
//         Line: Boolean;

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

