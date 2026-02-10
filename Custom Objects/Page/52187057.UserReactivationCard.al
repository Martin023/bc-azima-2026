page 52187057 "User Reactivation Card"
{
    DeleteAllowed = false;
    ApplicationArea = All;
    Caption = 'User Reactivation Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    SourceTable = "User Termination";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(RequestID; Rec."Request ID")
                {
                    ToolTip = 'Specifies the value of the RequestID field.';
                }
                field(RequestDate; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the RequestDate field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Termination Reason"; Rec."Termination Reason")
                {
                    ToolTip = 'Specifies the value of the TargetUserID field.';
                }

                field(RequesterUserID; Rec."Requester User ID")
                {
                    ToolTip = 'Specifies the value of the RequesterUserID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Activate; Rec.Activate)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
        }
    }

    actions
    {

        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                begin
                    Rec.TestField(Status, Rec.Status::Pending);
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;

            }
            action("Approvals.")
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

            }
            action("Reactivate User")
            {
                ApplicationArea = all;
                Image = DisableAllBreakpoints;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var

                    user: Record User;
                    usertermination: record "User Termination";
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        user.Reset();
                        user.SetRange(user."User Name", Rec."User Name");
                        if user.FindFirst() then begin
                            user.State := user.State::Enabled;
                            user.Modify();
                            Message('User Enabled succesfully');
                        end;
                    end else
                        Error('Status must be equal to Approved');
                end;
            }
        }
    }

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        RequestType: Boolean;
        LinesEditable: Boolean;
        user: Record User;

        usertermination: record "User Termination";
}
