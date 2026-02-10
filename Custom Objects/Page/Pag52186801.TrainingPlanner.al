page 52186801 "Training Planner"
{
    ApplicationArea = All;
    Caption = 'Training Planner';
    PageType = Card;
    SourceTable = "hr training Planner";
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Approvals';

    layout
    {
        area(content)
        {
            Group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = False;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Editable = InvTcode;

                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    Editable = InvTcode;

                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                    Editable = False;
                }
                field("Training Category"; Rec."Training Category")
                {
                    Editable = InvTcode;

                }

                field("No Of Participants"; Rec."No Of Participants")
                {
                    ToolTip = 'Specifies the value of the No Of Participants field.';
                    Editable = InvTcode;

                }


                field("Training Course"; Rec."Training Course")
                {
                    ToolTip = 'Specifies the value of the Training Course field.';
                    Editable = InvTcode;

                }

                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the value of the Year field.';
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    Editable = False;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;

                }
            }
        }
    }
    actions
    {

        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    // ApplicationArea = Basic;
                    // Caption = 'Approve';
                    // Image = Approve;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    // PromotedIsBig = true;
                    // //Visible = OpenApprovalEntriesExistForCurrUser;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    // end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.CommRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Defer)
                {
                    ApplicationArea = All;
                    Caption = 'Defer';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ReOpen;
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Deffered;

                        MESSAGE('Record Deferred');
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";

                    begin

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";

                    begin
                        if Rec.Status <> Rec.Status::"Pending Approval" then
                            Error(DocMustbePending);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Reopen Job Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen Job Card';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Process;


                    trigger OnAction()
                    begin
                        Message('Sets the status of Planner to open');

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(No);
                    RunPageView = where(Types = CONST(comment));
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;

    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        DocMustbePending: Label 'Document Must be Pending Approval';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        InvTcode: boolean;

    procedure UpdateControls()
    begin


        if Rec.Status = Rec.Status::Open then begin
            InvTcode := true;

        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;

        end;


        if Rec.Status = Rec.Status::Approved then begin
            InvTcode := false;

        end;


    end;

}


