page 52186703 "Electoral Zones Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Electoral Zones";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Information';


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = TheGeneral;
                field("Code"; Rec.Code)
                {

                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date"; Rec."Creation Date")
                {

                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {

                    ApplicationArea = Basic, Suite;
                }
                field("County Name"; Rec."County Name")
                {

                }
                field("Sub-County"; Rec."Sub-County")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Sub County Name"; Rec."Sub County Name")
                {

                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {

                    ApplicationArea = Basic, Suite;
                }

                field("Date Entered"; Rec."Date Entered")
                {

                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control25; "Officials List Part")
            {
                ApplicationArea = Basic, Suite;
                Editable = Officials;
                SubPageLink = "Electoral Zone" = FIELD(Code);
            }
            // part(Control14; "Retired Officials List Part")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            //     SubPageLink = "Electoral Zone" = FIELD(Code);
            // }
        }
    }

    actions
    {
        area(creation)
        {


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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.TestField("Electoral Zone Name");
                    Rec.TestField(County);

                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Rec.Code);
                    if DelegateOfficials.FindFirst then begin
                        repeat
                            if DelegateOfficials."Member Number" = '' then
                                Error('Member number cannot be empty');
                            // if DelegateOfficials.Position = '' then
                            //     Error('Position cannot be empty');
                        until DelegateOfficials.Next = 0;
                    end;

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Controls;
    end;

    var
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalButton: Boolean;
        SendApprovalButton: Boolean;
        CancelApprovalButton: Boolean;
        Officials: Boolean;
        TheGeneral: Boolean;
        DelegateOfficials: Record "Delegate Officials";

    local procedure Controls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            ApprovalButton := false;
            SendApprovalButton := true;
            CancelApprovalButton := false;
            TheGeneral := true;
            Officials := true;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            ApprovalButton := true;
            SendApprovalButton := false;
            CancelApprovalButton := true;
            TheGeneral := false;
            Officials := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            ApprovalButton := false;
            SendApprovalButton := false;
            CancelApprovalButton := false;
            TheGeneral := false;
            Officials := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            ApprovalButton := false;
            SendApprovalButton := false;
            CancelApprovalButton := false;
            TheGeneral := false;
            Officials := false;
        end;
    end;
}

