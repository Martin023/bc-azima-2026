page 52187079 "User Creation Request Card"
{
    ApplicationArea = All;
    Caption = 'User Creation';
    PageType = Card;
    SourceTable = "User Creation Requests";
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    //PromotedActionCategories = 'New,Process,Reports,Information, ,Category7_caption,Category8_caption,Category9_caption,Category10_caption';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Request ID"; Rec."Request ID")
                {
                    ToolTip = 'Specifies the value of the Departments field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }

                field(Departments; Rec.Departments)
                {
                    ToolTip = 'Specifies the value of the Departments field.';
                }
                field("Email"; Rec."Contact Email")
                {
                    ToolTip = 'Specifies the value of the NewEmail field.';
                }
                field("Username"; Rec."User name")
                {
                    ToolTip = 'Specifies the value of the NewUsername field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the RequestDate field.';
                }

                field("Requester User ID"; Rec."Requester User ID")
                {
                    ToolTip = 'Specifies the value of the RequesterUserID field.';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the value of the RequesterUserID field.';
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the RequesterUserID field.';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }
                field(Department; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }

            }
        }
    }
    actions
    {

        area(processing)
        {
            action(ImportData)
            {
                RunObject = xmlport "Import Telephone Nos";
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                //Enabled = NOT OpenApprovalEntriesExist;
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
                    /* 
                                        Users.Init;
                                        Users."User Name" := UserCreation."User name";
                                        //Users."Application ID" := UserCreation."Requester User ID";
                                        Users."Expiry Date" := UserCreation."Expiry Date";
                                        Users."Contact Email" := UserCreation."Contact Email";
                                        Users."Full Name" := UserCreation."Full Name";
                                        Users.Insert; */
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
        }
    }
    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        RequestType: Boolean;
        LinesEditable: Boolean;

        Users: Record User;
        UserCreation: Record "User Creation Requests";
}
