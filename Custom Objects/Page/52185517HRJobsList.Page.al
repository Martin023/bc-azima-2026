page 52185517 "HR Jobs List"
{
    CardPageID = "HR Jobs Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Administration,,,Approvals';
    RefreshOnActivate = true;
    SourceTable = "HR Jobs";
    SourceTableView = WHERE("Job Type" = CONST(Jobs));
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                }
                field("Variance"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Name"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Name"; Rec."Global Dimension 2 Code")
                {

                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field("Current Approval Level"; Rec."Current Approval Level")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Level';
                    Visible = true;
                }
                field("Pending At"; Rec."Pending At")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending At';
                    Visible = true;
                    Style = Attention;
                    StyleExpr = Rec.Status = Rec.Status::"Pending Approval";
                }
            }
        }
        area(factboxes)
        {
            part("<Page39003906>"; "HR Jobs Factbox")
            {
                ApplicationArea = Basic;
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755004; Outlook)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //  ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                visible = false;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // Rec.TestField("No of Posts");
                        // /*TESTFIELD("Document No.");
                        // TESTFIELD(Description);
                        // TESTFIELD("Interest Due Date");*/
                        // VarVariant := Rec;
                        // MESSAGE('Sending For Approval!');
                        // Rec.Status := Rec.Status::Approved;
                        // Rec.MODIFY;
                        // MESSAGE('Approvedl!')
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //  CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
        StyleText:=HRCodeunit.fn_SetStyle(FORMAT(Status));
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
// OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        */
        
        //UPDATE PENDING AT FIELD
        Rec.UpdatePendingAtField();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        rec.CalcFields("Occupied Positions");
        Rec."Vacant Positions" := Rec."No of Posts" - Rec."Occupied Positions";
        
        //UPDATE PENDING AT FIELD
        Rec.UpdatePendingAtField();
    end;

    var
        HRCodeunit: Codeunit "HR Codeunit2";
        StyleText: Text;
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
    //   CustomApprovals: Codeunit "Custom Approvals Codeunit";

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserID);
        ChangePermission.SetRange("View Payroll", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserID);
    end;
}

