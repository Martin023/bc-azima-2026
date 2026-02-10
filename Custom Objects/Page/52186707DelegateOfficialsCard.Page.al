page 52186707 "Delegate Officials Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Delegate Officials";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Information';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralTab;
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Number"; Rec."Member Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Official Name"; Rec."Delegate Official Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Board Member"; Rec."Board Member")
                {
                    ApplicationArea = all;
                    Caption = 'Board Member';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Retired; Rec.Retired)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registered By"; Rec."Registered By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Retirement)
            {
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RetirementDateField;
                }
                field("Reason for retirement"; Rec."Reason for retirement")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ReasonForRetirementField;
                }
                field("Retired By"; Rec."Retired By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Enabled = ApprovalButton;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    if not Confirm('Are you sure you want to approve this record?') then exit;
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            separator(Action27)
            {
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = SendApprovalButton;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                    Deloff: Record "Delegate Officials";
                begin


                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = CancelApprovalButton;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    VarVariant := Rec;
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

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    approvalsMgmt: Codeunit 1535;
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Retire Delegate Official")
            {
                ApplicationArea = Basic, Suite;
                Enabled = RetireDelegateButton;
                Image = CreateLinesFromTimesheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."Retirement Date" <> 0D then begin
                        if Rec."Retirement Date" < Rec."Appointment Date" then Error('Retirement date cannot be earlier than appointment date');
                        if Rec."Retirement Date" > Today then Error('Retirement date cannot be later than today');
                    end;

                    Rec."Retired By" := UserId;
                    Rec."Retirement Date" := Today;
                    Rec.Retired := true;

                    Rec.Modify;
                    Message('Delegate retired successfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Controls;
        if Rec.Retired then begin
            if Rec."Retire Date" = 0D then begin
                Rec."Retire Date" := Today;
                Rec.Modify();
            end;
        end;
    end;

    var
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GeneralTab: Boolean;
        ApprovalButton: Boolean;
        SendApprovalButton: Boolean;
        CancelApprovalButton: Boolean;
        RetireDelegateButton: Boolean;
        RetirementDateField: Boolean;
        ReasonForRetirementField: Boolean;

    local procedure Controls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            GeneralTab := true;
            ApprovalButton := false;
            SendApprovalButton := true;
            CancelApprovalButton := false;
            RetireDelegateButton := false;
            RetirementDateField := false;
            ReasonForRetirementField := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            GeneralTab := false;
            ApprovalButton := true;
            SendApprovalButton := false;
            CancelApprovalButton := true;
            RetireDelegateButton := false;
            RetirementDateField := false;
            ReasonForRetirementField := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            GeneralTab := false;
            ApprovalButton := false;
            SendApprovalButton := false;
            CancelApprovalButton := false;
            RetireDelegateButton := true;
            RetirementDateField := true;
            ReasonForRetirementField := true;

        end;

        if Rec.Status = Rec.Status::Rejected then begin
            GeneralTab := false;
            ApprovalButton := false;
            SendApprovalButton := false;
            CancelApprovalButton := false;
            RetireDelegateButton := false;
            RetirementDateField := false;
            ReasonForRetirementField := false;

        end;

        if Rec.Retired then begin
            GeneralTab := false;
            ApprovalButton := false;
            SendApprovalButton := false;
            CancelApprovalButton := false;
            RetireDelegateButton := false;
            RetirementDateField := false;
            ReasonForRetirementField := false;

        end;
    end;
}

