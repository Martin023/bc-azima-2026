page 52186511 "HR Appraissal Appeal1"
{
    Caption='Hr Appraissal Appeal';
    PageType = Card;
    SourceTable = "HR Appraissal Appeal";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    PromotedActionCategories=',,,,,,,,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisser No."; Rec."Appraisser No.")
                {
                    ApplicationArea = Basic;
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    ApplicationArea = Basic;
                }
                field("Appraissal Period"; Rec."Appraissal Period")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Rec.Comments)
                {

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    VarVariant := Rec;
                     if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                         CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                // // //ApprovalEntries: Page "Approval Entries";
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                     ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
        }
    }

    var
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
          CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}

