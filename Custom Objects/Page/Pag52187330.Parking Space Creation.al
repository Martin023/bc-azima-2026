page 52187325 "Parking Space Creation"
{
    ApplicationArea = All;
    Caption = 'Parking Space Creation';
    PageType = Card;
    SourceTable = "Parking List Table";
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("CODE"; Rec."No")
                {
                    ToolTip = 'Specifies the value of the CODE field.';
                    Editable = false;
                }
                field("Parking Area"; Rec."Parking Area")
                {
                    ToolTip = 'Specifies the value of the Parking Area field.';
                }
                field("Parking Slot Number"; Rec."Parking Slot Number")
                {
                    ToolTip = 'Specifies the value of the Parking Slot Number field.';
                }
                // field("Parking Slot Status"; Rec."Parking Slot Status")
                // {
                //     ToolTip = 'Specifies the value of the Parking Slot Status field.';
                //     Editable = false;
                // }
                // field(Status;Rec.Status)
                // {
                //     Editable = false;
                // }
                field(Created;Rec.Created)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("created On"; Rec."Created At")
                {
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                    Multiline = true;
                }
            }
        }
        
    }
    actions
    {
        area (Creation)
        {
            // action(SendApprovalRequest)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Send A&pproval Request';
            //     Enabled = NOT OpenApprovalEntriesExist;
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()

            //     var
            //         CustomApprovals: Codeunit "Custom Approvals Codeunit";
            //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     begin
                    
            //         Rec.TestField(Status, Rec.Status::Open);

            //         VarVariant := Rec;
            //         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
            //             CustomApprovals.OnSendDocForApproval(VarVariant);
            //     end;

            // }
            // action(CancelApprovalRequest)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Cancel Approval Re&quest';
            //     Enabled = OpenApprovalEntriesExist;
            //     Image = Cancel;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     var
            //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     begin

            //         if Rec.Status <> Rec.Status::Pending then
            //             Error(DocMustbePending);

            //         VarVariant := Rec;
            //         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            //     end;
            // }
            // action("Re-Open Document")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Category4;
            //     Image = ReOpen;

            //     trigger OnAction()
            //     begin

            //         if not Confirm('Are you sure you want to re-open this document?') then exit;
            //         Rec.Status := Rec.Status::Open;
            //         Rec.Modify;
            //         Message('Document Reopened Sucessfully.');
            //     end;
            // }
            // action(Approvals)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Approvals';
            //     Image = Approvals;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     var
            //         //// //ApprovalEntries: Page "Approval Entries";
            //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     begin
            //         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
            //     end;
            // }
            action("Create Parking Space")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Parking Space';
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.TestField("Parking Area");
                    Rec.TestField("Parking Slot Number");
                    
                    if Rec.Created = true then begin
                        Error('Parking Space Already Exists');
                    end;
                    //if not Confirm('Are you sure you want to create this parking space?') then exit;
                    if Confirm('Are you sure you want to create this parking space?') then begin
                    Rec.Created := true;
                    Rec.Modify;
                    Message('Parking Space Created Sucessfully.', Rec.No);
                    end;
                end;
            }
        }
    }
    var
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
}
