page 52187094 "User Termination Card"
{
    DeleteAllowed = false;
    ApplicationArea = All;
    Caption = 'User Termination Card';
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
                field(Terminate; Rec.Terminate)
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
            action("Deactivate User")
            {
                ApplicationArea = all;
                Image = DisableAllBreakpoints;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    user: Record User;
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        user.Reset();
                        user.SetRange("User Name", Rec."User Name");
                        if user.FindFirst() then begin
                            user.State := user.State::Disabled;
                            user."Expiry Date" := CurrentDateTime - 5;
                            user.Modify();
                            Commit();

                            // Update the current record's Terminate field
                            Rec.Terminate := true;
                            Rec.Activate := false;
                            Rec.Modify();
                            Commit();

                            Message('User "' + user."User Name" + '" has been successfully disabled.');
                        end else
                            Error('User not found.');
                    end else
                        Error('Status must be equal to Approved.');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        usertermination."Request Date" := Today;

    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        RequestType: Boolean;
        LinesEditable: Boolean;
        user: Record User;

        usertermination: record "User Termination";
}
