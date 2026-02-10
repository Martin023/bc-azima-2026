// page 52186476 "HR Employee Transfer Card Effe"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'Manage,Process,Report,Redeploy';
//     SourceTable = "HR Employee Transfer Header";
//     SourceTableView = WHERE("Transfer details Updated" = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Request No"; Rec."Request No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Requested"; Rec."Date Requested")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Name"; Rec."Employee Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Job ID"; Rec."Job ID")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Job Description"; Rec."Job Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("Dimension 1 Code"; Rec."Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Dimension 1 Description"; Rec."Dimension 1 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("Dimension 2 Code"; Rec."Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Dimension 2 Description"; Rec."Dimension 2 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("Dimension 3 Code"; Rec."Dimension 3 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Dimension 3 Description"; Rec."Dimension 3 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                     Visible = false;
//                 }
//                 field("Salary Grade"; Rec."Salary Grade")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Salary Notch"; Rec."Salary Notch")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Job ID"; Rec."New Job ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Job Description"; Rec."New Job Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("New Dimension 1 Code"; Rec."New Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Dimension 1 Description"; Rec."New Dimension 1 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("New Dimension 2 Code"; Rec."New Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Dimension 2 Description"; Rec."New Dimension 2 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                 }
//                 field("New Dimension 3 Code"; Rec."New Dimension 3 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("New Dimension 3 Description"; Rec."New Dimension 3 Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowCaption = false;
//                     Visible = false;
//                 }
//                 field("New Salary Grade"; Rec."New Salary Grade")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Salary Notch"; Rec."New Salary Notch")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason for Transfer"; Rec."Reason for Transfer")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Transfer details Updated"; Rec."Transfer details Updated")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//             group("Transfer Duration")
//             {
//                 field("Effective From"; Rec."Effective From")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Duration; Rec.Duration)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Effective To"; Rec."Effective To")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Show")
//             {
//                 Caption = '&Show';
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 action("&Approvals")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
//                         //ApprovalEntries: Page "Approval Entries";
//                     begin
//                         DocumentType := DocumentType::"Employee Transfer";
//                         ApprovalEntries.SetRecordFilters(DATABASE::"HR Employee Transfer Header", DocumentType, Rec."Request No");
//                         ApprovalEntries.Run;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         ApprovalComments: Page "Approval Comments";
//         Employees: Record "HR Employees";
//         Text001: Label 'Employee No. %1 has been successfully redeployed';
//         Text002: Label 'Do you want to effect this transfer';
// }

