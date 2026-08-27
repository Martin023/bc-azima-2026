// page 52185548 "Key Creation Card"
// {
//     Caption = 'Key Creation Card';
//     PageType = Card;
//     SourceTable = "Office Keys List";
//     PromotedActionCategories = 'New,Process,Reports,Approvals,Views,Home,Creation';
    
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
                
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Code field.';
//                     Editable = false;
//                 }
//                 field(Department; Rec.Department)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Department field.';
//                 }
//                 field("Key Category"; Rec."Key Category")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Key Category field.';
//                     trigger OnValidate()
//                     begin
//                         if Rec."Key Category" = Rec."Key Category"::Others then
//                         begin
//                             VisibleOthers := true;
//                         end
//                         else
//                         begin
//                             VisibleOthers := false;
//                         end;
//                     end;
//                 }
//                 field("Other Key Category"; Rec."Other Key Category")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Others Key Category field.';
//                     Editable = VisibleOthers;
//                 }

//                 field("Office/Store/Room Name"; Rec."Office/Store/Room Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Office/Store/Room Name field.';
//                 }
//                 field("Floor"; Rec.Floor)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Floor field.';
//                 }
//                 field("Number of Keys"; Rec."Key Number")
//                 {
//                     Caption = 'Number of Keys';
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Key Number field.';
//                 }
//                 field("Responsibility Centre"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Responsibility Centre field.';
//                     Editable = false;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
//                     Editable = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
//                     Editable = false;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Created By field.';
//                     Editable = false;
//                 }
//                 field("Created At"; Rec."Created At")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Created At field.';
//                     Editable = false;
//                 }
//                 // field(Status; Rec.Status)
//                 // {
//                 //     ApplicationArea = All;
//                 //     ToolTip = 'Specifies the value of the Status field.';
//                 //     Editable = false;
//                 // }
//                 field("Key Status"; Rec."Key Status")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Key Statys field.';
//                     Editable = false;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Creation)
//         {
//             // action(SendApprovalRequest)
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Caption = 'Send A&pproval Request';
//             //     Enabled = NOT OpenApprovalEntriesExist;
//             //     Image = SendApprovalRequest;
//             //     Promoted = true;
//             //     PromotedCategory = Category4;

//             //     trigger OnAction()

//             //     var
//             //         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//             //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//             //     begin
                    
//             //         Rec.TestField(Status, Rec.Status::Open);

//             //         VarVariant := Rec;
//             //         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//             //             CustomApprovals.OnSendDocForApproval(VarVariant);
//             //     end;
//             // }
//             // action(CancelApprovalRequest)
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Caption = 'Cancel Approval Re&quest';
//             //     Enabled = OpenApprovalEntriesExist;
//             //     Image = Cancel;
//             //     Promoted = true;
//             //     PromotedCategory = Category4;

//             //     trigger OnAction()
//             //     var
//             //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//             //     begin

//             //         if Rec.Status <> Rec.Status::Pending then
//             //             Error(DocMustbePending);

//             //         VarVariant := Rec;
//             //         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//             //     end;
//             // }
//             // action("Re-Open Document")
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Visible = true;
//             //     Promoted = true;
//             //     PromotedIsBig = true;
//             //     PromotedCategory = Category4;
//             //     Image = ReOpen;

//             //     trigger OnAction()
//             //     begin
//             //         if Rec.Status = Rec.Status::Open then
//             //         Error('Document is Open!');
//             //         if not Confirm('Are you sure you want to re-open this document?') then exit;
//             //         Rec.Status := Rec.Status::Open;
//             //         Rec.Modify;
//             //         Message('Document Reopened Sucessfully.');
//             //     end;
//             // }
//             // action(Approvals)
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Caption = 'Approvals';
//             //     Image = Approvals;
//             //     Promoted = true;
//             //     PromotedCategory = Category4;
//             //     PromotedIsBig = true;

//             //     trigger OnAction()
//             //     var
//             //         ApprovalEntries: Page "Approval Entries";
//             //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//             //     begin
//             //         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//             //     end;
//             // }
//             action("Create Key")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Create Key';
//                 Image = Create;
//                 Promoted = true;
//                 PromotedCategory = Category7;
//                 PromotedIsBig = true;

//                 trigger OnAction()
                
//                 begin
//                     Rec.TestField(Department);
//                     Rec.TestField("Key Category");
//                     Rec.TestField("Floor");
//                     Rec.TestField("Key Status", Rec."Key Status"::Creation);
//                     //if Rec.Status = Rec.Status::Approved then
//                     begin
//                         Rec."Key Status" := Rec."Key Status"::Created;
//                         Rec.Modify;
//                         Message('Key Creation Sucessful!');
//                     end;
//                 end;
//             }
//             action("Deactivate Key")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Deactivate Key';
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category7;
//                 PromotedIsBig = true;

//                 trigger OnAction()
                
//                 begin
//                     //Rec.TestField(Status, Rec.Status::Approved);
//                     Rec.TestField("Key Status", Rec."Key Status"::Created);
//                     //if Rec.Status = Rec.Status::Approved then
//                     begin
//                         Rec."Key Status" := Rec."Key Status"::Inactive;
//                         Rec.Modify;
//                         Message('Key Deactivated Sucessfully.');
//                     end;
//                 end;
//             }
//         }
//     }
//     trigger OnOpenPage();
//     begin
//         if UserSetup.Get(Rec."Created By") then begin
//             Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
//             Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
//             Rec."Responsibility Center" := UserSetup."Responsibility Centre";
//             Rec."Created By" := UserId;
//             Rec.SystemCreatedAt := CURRENTDATETIME;
//             Rec.Modify;
//         end;
//     end;


//     var

//         UserSetup: Record "User Setup";
//         PageEdit: Boolean;
//         VarVariant: Variant;
//         OpenApprovalEntriesExist: boolean;
//         DocMustbePending: Label 'This application request must be Pending';
//         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         VisibleOthers : Boolean;
// }
