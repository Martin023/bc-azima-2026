// page 52186590 "HR Overtime Card"
// {
//     Caption = 'Overtime Need Request';
//     PageType = Card;
//     PromotedActionCategories = 'Manage,Process,Report,Convert,,,,,Approvals';
//     SourceTable = "HR Overtime Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Application Code"; Rec."Application Code")
//                 {
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                 }
//                 field(HOD;Rec.HOD)
//                 {
//                     caption='HOD NO.';
//                 }
//                 field("HOD Name";Rec."HOD Name")
//                 {
//                    Editable=false; 
//                 }
                
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                 }
//                 field("Responsibility Center";Rec."Responsibility Center")
//                 {
//                   Editable=false;  
//                 }
//                 field("User ID";Rec."User ID")
//                 {
                    
//                 }
//                 // field("Weekend Hours"; Rec."Weekend Hours")
//                 // {
//                 // }
//                 // field("Holiday Hours"; Rec."Holiday Hours")
//                 // {
//                 // }
//                 // field("Extra Hours"; Rec."Extra Hours")
//                 // {
//                 // }
//                 field("Total Overtime Hours"; Rec."Total Overtime Hours")
//                 {
//                 }
//                 field(Reason; Rec.Reason)
//                 {

//                 }
//                 field(Status;Rec.Status)
//                 {
//                     Editable=false;

//                 }
//                 field("Convert To?"; Rec."Convert To?")
//                 {
//                     Visible = false;

//                 }
//                 field(Converted; Rec.Converted)
//                 {
//                     Visible = false;

//                 }
//                 field("Posted to Payroll"; Rec."Posted to Payroll")
//                 {
//                     Visible = false;
//                 }
//             }
//              part(Control3; OvertimeNeedsLines)
//             {
//                 ApplicationArea = Basic;
//                 SubPageLink = "Need No" = FIELD("Application Code");
//             }
//         }
//     }
    

//     actions
//     {
//         area(creation)
//         {
//             action(Convert)
//             {
//                 Image = ProjectExpense;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 visible=false;

//                 trigger OnAction()
//                 begin
//                     //TESTFIELD(Status,Status::Approved);

//                     if Confirm('Do you want to convert this Overtime?', true) = false then exit;

//                     if Rec.Converted = true then
//                         Message(Txt001);

//                     if Rec."Convert To?" = Rec."Convert To?"::" " then
//                         Message(Txt002);

//                     if Rec."Convert To?" = Rec."Convert To?"::"Convert to Leave" then begin

//                         Message(Txt003);
//                         Rec.Converted := true;
//                     end;


//                     if Rec."Convert To?" = Rec."Convert To?"::"Convert to Pay" then begin

//                         Message(Txt004);
//                         Rec.Converted := true;
//                     end;
//                 end;
//             }
//             action("Overtime Report")
//             {
//                 Image = PrintReport;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 visible=false;

//                 trigger OnAction()
//                 begin
//                     Overtime.Reset;
//                     Overtime.SetRange(Overtime."Application Code", Rec."Application Code");
//                     //if Overtime.Find('-') then
//                     //REPORT.Run(REPORT::"HR Overtime Report", true, true, Overtime);
//                 end;
//             }
//               action(Approve)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }

//                 action(Delegate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page "Approval Comments";
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
            
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                     //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

                      

                      
//                        rec.TestField(Reason);
//                         VarVariant := Rec;

//                         // Rec.Status := Rec.Status::Approved;
//                         // Rec.MODIFY;

//                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                             CustomApprovals.OnSendDocForApproval(VarVariant);
//                         //MESSAGE('Job Approved and now can be occupied')
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         VarVariant := Rec;
//                         Rec.TestField(Status, Rec.Status::"Pending Approval");
//                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                             CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     Enabled = OpenApprovalEntriesExist;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
                        
//                         Rec.TestField(Status, Rec.Status::"Pending Approval");

//                         ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         HRSetup: Record "HR Setup";
//         Txt001: Label 'This overtime has already been converted';
//         Txt002: Label 'Kindly select what you want to convert to';
//         Txt003: Label 'Overtime succesfully converted to Leave';
//         Txt004: Label 'Overtime succesfully converted to Pay';
//         Overtime: Record "HR Overtime Header";
//          OpenApprovalEntriesExistCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         VarVariant: Variant;
//         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         DocMustbePending: Label 'This application request must be Pending';
// }

