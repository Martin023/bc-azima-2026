page 52187092 "System Reversal Card"
{
    ApplicationArea = All;
    PromotedActionCategories = 'Home,Process,Reports,History,Approval request';

    Caption = 'System Reversal Card';
    PageType = Card;
    SourceTable = "System Reversal";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEitable;

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                    MultiLine = true;
                }
                field("Entry No."; Rec."Entry No.")
                {

                }

                field("Transaction Number"; Rec."Transaction Number")
                {
                    Caption = 'Transaction No';
                    Editable = false;

                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    Editable = false;

                }


                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date.';
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date';
                    Editable = false;
                }
                field("Approved by User ID"; Rec."Approved by User ID")
                {
                    ToolTip = 'Specifies the value of the Approved by User ID field.';
                    Editable = false;
                }
                field("Created by User ID"; Rec."Created by User ID")
                {
                    ToolTip = 'Specifies the value of the Created by User ID field.';
                    Editable = false;
                }
                field("Reversed by"; Rec."Reversed by")
                { }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { Editable = false; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { Editable = false; }
                field("Approved date"; Rec."Approved date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Registers")
            {
                Visible = true;
                Enabled = AllowViewRegister;
                ApplicationArea = Basic, Suite;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Custom GL Register";
                RunPageLink = "No." = FIELD("Transaction Number");
            }
        }

        area(processing)
        {
            group(Workflows)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin

                        Rec.TestField(Comments);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }

                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }

                action("Re-Open")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-Open Document';
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Image = ReOpen;

                    trigger OnAction()
                    var

                    begin
                        if not Confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('This document has been reopened sucessfully.');
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    PromotedCategory = Category5;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunPageLink = "Document No." = FIELD("No.");
                    RunObject = Page "Approval Entries";

                    // trigger OnAction()
                    // var
                    //     //ApprovalEntries: Page "Approval Entries";
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    // end;
                }

            }
        }
    }
    procedure ValidateReq()
    var
        myInt: Integer;
    begin
        AllowPost := false;
        if Rec.Status <> Rec.Status::Open then
            PageEitable := false else
            PageEitable := true;
        if Rec.Reversed = true then
            PageEitable := false;
        if ReC.Status = Rec.Status::Approved then
            AllowPost := true Else
            AllowPost := false;

        AllowViewRegister := (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved);

        if Rec.Reversed = false then begin
            if Rec."No." <> '' then begin
                Rec."Transaction Date" := Today;
                Rec.Modify();
            end;
        end;// Else
            // AllowPost := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ValidateReq;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        ValidateReq;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        PageEitable: Boolean;
        AllowPost: Boolean;

        AllowViewRegister: Boolean;
}
