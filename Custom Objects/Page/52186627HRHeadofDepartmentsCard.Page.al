page 52186627 "HR Head of Departments Card"
{
    PageType = Card;
    SourceTable = "HR Heads of Departments";

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility center"; Rec."Responsibility center")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Approval Information")
            {
                Caption = 'Approval Information';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control12; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for Approval")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    Rec.TestField("Responsibility center");
                    Rec.TestField("Employee No.");
                    Rec.TestField("User ID");

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    if Confirm('Are you sure you want to cancel this approval request?', false) = false then exit;
                    
                    Rec.TestField(Status, Rec.Status::Pending);
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                begin
                    if Confirm('Reopen this HOD assignment? This will reset status to Open and clear approval history.', false) = false then exit;

                    Rec.Status := Rec.Status::Open;
                    Rec."Approved By" := '';
                    Rec."Approved Date" := 0D;
                    Rec.Modify;

                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Document No.", Rec."Responsibility center");
                    ApprovalEntry.SetRange("Table ID", Database::"HR Heads of Departments");
                    if ApprovalEntry.FindSet() then
                        ApprovalEntry.DeleteAll();

                    Message('HOD assignment reopened and approval entries removed.');
                end;
            }
        }
    }
}

