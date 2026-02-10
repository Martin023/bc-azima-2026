page 52186267 "Permission Requisition Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Permission Requisition";
    Caption = 'Permission Request Card';
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RequestType;

                    trigger OnValidate()
                    begin
                        if Rec.Status <> Rec.Status::Open then Error('You can only edit an open document');
                    end;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Approved"; Rec."Time Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Granted By"; Rec."Granted By")
                {
                }
            }
            part("Permission Requisition Lines"; "Permission Requisition Lines")
            {
                Editable = true;
                SubPageLink = "Header No" = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Approval Request';
                //Enabled = NOT OpenApprovalEntriesExist;
                Enabled = SendAppEdi;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    PermissionRequisitionLines.Reset;
                    PermissionRequisitionLines.SetRange("Header No", Rec.No);
                    if not PermissionRequisitionLines.FindFirst then
                        Error('You must have at least one line requesting permission');
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
                PromotedCategory = Category4;
                Enabled = CancelApp;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Approvals.")
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Grant Permission")
            {
                ApplicationArea = All;
                Caption = 'Grant Permission';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Permission: Record "Permission Requisition Lines";
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    VarVariant := Rec;

                    Permission.Reset();
                    Permission.SetRange("Header No", rec.No);
                    if Permission.FindFirst() then begin
                        repeat
                            Permission.Granted := true;
                            Permission."Granted\Denied By" := UserId;
                            Permission.Modify();
                        until Permission.Next = 0;
                    end;
                    rec."Granted By" := UserId;
                end;



            }

        }
    }

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ProcessMo: Boolean;
        SendAppEdi: Boolean;
        CancelApp: Boolean;
        RejectM: Boolean;
        PageEdi: Boolean;
        EdRej: Boolean;
        PermissionRequisitionLines: Record "Permission Requisition Lines";
        RequestType: Boolean;
        LinesEditable: Boolean;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetApparance();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetApparance();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetApparance();

    end;

    local procedure SetApparance()
    var
        myInt: Integer;
    begin
        case Rec.Status of
            rec.Status::Open:
                begin
                    //CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                end;
            rec.Status::"Pending Approval":
                begin
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;

                end;
        end;
    end;
}

