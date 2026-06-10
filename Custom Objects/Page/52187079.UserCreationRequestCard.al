page 52187079 "User Creation Request Card"
{
    ApplicationArea = All;
    Caption = 'User Access Request';
    PageType = Card;
    SourceTable = "User Creation Requests";
    UsageCategory = Documents;

    PromotedActionCategories = 'Process,Report';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Editable = false;
                }

                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SetControlVisibility();
                        CurrPage.Update(false);
                    end;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StatusStyle;
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Requester User ID"; Rec."Requester User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Employee Information")
            {
                Caption = 'Employee Information';
                Visible = ShowEmployeeInfo;

                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Employee: Record Employee;
                    begin
                        if Employee.Get(Rec."Staff No.") then begin
                            Rec."Full Name" := Employee."First Name" + ' ' + Employee."Last Name";
                            Rec."Department Name" := Employee."Global Dimension 1 Code";
                            Rec."Employment Type" := Employee."Emplymt. Contract Code";
                            Rec."Phone No." := Employee."Phone No.";
                        end else
                            Rec.TestField("Staff No.");
                    end;
                }
                field("Service No."; Rec."Service No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Department Name"; Rec."Department Name") { ApplicationArea = All; Editable = false; }
                field("Employment Type"; Rec."Employment Type") { ApplicationArea = All; Editable = false; }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }

            group("Account Information")
            {
                Caption = 'Account Information';
                Visible = ShowAccountInfo;

                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireUserFields;
                }
                field("Full Name2"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireUserFields;
                    Editable = true;
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireUserFields;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireUserFields;
                    Editable = true;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Visible = ShowUserFields;
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = ShowVendorFields;
                    ShowMandatory = RequireVendorFields;

                    trigger OnValidate()
                    var
                        Vendor: Record Vendor;
                    begin
                        if Vendor.Get(Rec."Vendor No.") then begin
                            Rec."Vendor Name" := Vendor.Name;
                            Rec."Vendor Email" := Vendor."E-Mail";
                        end;
                    end;
                }

                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Visible = ShowVendorFields;
                    ShowMandatory = RequireVendorFields;
                }

                field("Vendor Email"; Rec."Vendor Email")
                {
                    ApplicationArea = All;
                    Visible = ShowVendorFields;
                    ShowMandatory = RequireVendorFields;
                }
            }

            group("Requested Access")
            {
                Caption = 'Requested Access';
                Visible = ShowRequestedAccess;

                part("System Access Lines"; "User Access Request Subpage")
                {
                    ApplicationArea = All;
                    Caption = 'System Access & Roles';
                    SubPageLink = "Request ID" = FIELD("Request ID");
                    UpdatePropagation = Both;
                }
            }

            group("Governance & Compliance")
            {
                Caption = 'Governance & Compliance';

                field("SoD Conflict"; Rec."SoD Conflict")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Business Justification"; Rec."Business Justification")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }

            group("SLA & Tracking")
            {
                Caption = 'SLA & Tracking';

                field("Due Date Time"; Rec."Due Date Time")
                {
                    ApplicationArea = All;
                }

                field("Completion Date Time"; Rec."Completion Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = SendApprovalEnabled;

                trigger OnAction()
                begin
                    ValidateMandatoryFields();
                    Rec.TestField(Status, Rec.Status::Open);
                    VarVariant := Rec;
                    CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }

            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CancelApprovalEnabled;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Pending);
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }

            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }

            action("Create BC User")
            {
                ApplicationArea = All;
                Caption = 'Create BC User';
                Image = User;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CreateUserEnabled;

                trigger OnAction()
                var
                    BCUser: Record User;
                    AccessLine: Record "User Access Request Lines";
                    AccessControl: Record "Access Control";
                    ExistingAccess: Record "Access Control";
                    IdentityManagement: Codeunit "Identity Management";
                    UserSID: Text;
                    ResolvedUserName: Text;
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("User Name");
                    Rec.TestField("Full Name");

                    // === Replicate ValidateWindowsUserName ===
                    if Rec."User Name" = '' then begin
                    end else begin

                        // Resolve SID from the entered username
                        UserSID := Sid(Rec."User Name");

                        // Normalize username back from SID
                        ResolvedUserName := IdentityManagement.UserName(UserSID);

                        if ResolvedUserName <> '' then begin
                            // Store normalized username back on the request
                            Rec."User Name" := ResolvedUserName;

                            // ValidateSid — block forbidden SIDs and duplicates
                            if (UserSID = 'S-1-1-0') or (UserSID = 'S-1-5-7') or (UserSID = 'S-1-5-32-544') then
                                Error('The account %1 is not allowed.', Rec."User Name");

                            BCUser.Reset();
                            BCUser.SetFilter("Windows Security ID", UserSID);
                            if not BCUser.IsEmpty() then
                                Error('The account %1 already exists.', Rec."User Name");

                        end else
                            Error('The account %1 is not a valid Windows account.', Rec."User Name");
                    end;

                    // Check if BC user already exists — skip creation, still assign permissions
                    BCUser.Reset();
                    BCUser.SetRange("User Name", Rec."User Name");

                    if BCUser.FindFirst() then
                        Message('User %1 already exists. Proceeding to assign permissions.', Rec."User Name")
                    else begin
                        BCUser.Init();
                        BCUser."User Security ID" := CreateGuid();
                        BCUser."User Name" := Rec."User Name";
                        BCUser."Full Name" := Rec."Full Name";
                        BCUser."Windows Security ID" := UserSID;
                        BCUser.State := BCUser.State::Enabled;
                        BCUser.Insert(true);
                        Message('User %1 created successfully.', Rec."User Name");
                    end;

                    // Reload user after creation
                    BCUser.Reset();
                    BCUser.SetRange("User Name", Rec."User Name");
                    if not BCUser.FindFirst() then
                        Error('User could not be found after creation.');

                    // Assign pending permission sets from request lines
                    AccessLine.Reset();
                    AccessLine.SetRange("Request ID", Rec."Request ID");
                    AccessLine.SetRange(Provisioned, false);

                    if AccessLine.FindSet() then
                        repeat
                            if AccessLine."Permission Set" <> '' then begin
                                ExistingAccess.Reset();
                                ExistingAccess.SetRange("User Security ID", BCUser."User Security ID");
                                ExistingAccess.SetRange("Role ID", AccessLine."Permission Set");

                                if not ExistingAccess.FindFirst() then begin
                                    AccessControl.Init();
                                    AccessControl."User Security ID" := BCUser."User Security ID";
                                    AccessControl."Role ID" := AccessLine."Permission Set";
                                    AccessControl.Insert(true);
                                end;
                            end;

                            AccessLine.Provisioned := true;
                            AccessLine."Provisioned By" := UserId();
                            AccessLine."Provisioning Date" := CurrentDateTime;
                            AccessLine.Modify();
                        until AccessLine.Next() = 0;

                    Rec."Completion Date Time" := CurrentDateTime;
                    Rec.Modify();

                    Message('User provisioning completed successfully for %1.', Rec."User Name");
                end;
            }

            // action("Generate PDF")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Generate PDF';
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     begin
            //         Report.RunModal(
            //             Report::"User Access Request Form",
            //             true,
            //             true,
            //             Rec
            //         );
            //     end;
            // }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlVisibility();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SendApprovalEnabled := Rec.Status = Rec.Status::Open;
        CancelApprovalEnabled := Rec.Status = Rec.Status::Pending;
        CreateUserEnabled := (Rec.Status = Rec.Status::Approved) and (Rec."Completion Date Time" = 0DT);

        SetControlVisibility();

        case Rec.Status of
            Rec.Status::Open:
                StatusStyle := 'Standard';
            Rec.Status::Pending:
                StatusStyle := 'Ambiguous';
            Rec.Status::Approved:
                StatusStyle := 'Favorable';
            Rec.Status::Rejected:
                StatusStyle := 'Unfavorable';
        end;
    end;

    local procedure SetControlVisibility()
    begin
        // DEFAULT = Staff
        ShowEmployeeInfo := true;
        ShowAccountInfo := true;
        ShowRequestedAccess := true;

        ShowUserFields := true;
        ShowVendorFields := false;

        RequireUserFields := true;
        RequireVendorFields := false;

        case Rec."Request Type" of

            Rec."Request Type"::"Vendor Account":
                begin
                    // SHOW EVERYTHING EXCEPT EMPLOYEE INFO
                    ShowEmployeeInfo := false;
                    ShowAccountInfo := true;
                    ShowRequestedAccess := true;

                    // Switch Account section to Vendor mode
                    ShowUserFields := true;
                    ShowVendorFields := true;

                    RequireUserFields := false;
                    RequireVendorFields := true;
                end;

            Rec."Request Type"::"Deactivate User":
                begin
                    ShowEmployeeInfo := false;
                    ShowAccountInfo := false;
                    ShowRequestedAccess := false;

                    ShowUserFields := false;
                    ShowVendorFields := false;

                    RequireUserFields := false;
                    RequireVendorFields := false;
                end;
        end;
    end;

    local procedure ValidateMandatoryFields()
    begin
        Rec.TestField("Business Justification");

        if Rec."Request Type" = Rec."Request Type"::"Vendor Account" then begin
            Rec.TestField("Vendor No.");
            Rec.TestField("Vendor Email");
        end else begin
            Rec.TestField("Staff No.");
            Rec.TestField("User Name");
            Rec.TestField("Contact Email");
        end;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;

        SendApprovalEnabled: Boolean;
        CancelApprovalEnabled: Boolean;

        ShowEmployeeInfo: Boolean;
        ShowAccountInfo: Boolean;
        ShowRequestedAccess: Boolean;

        ShowUserFields: Boolean;
        ShowVendorFields: Boolean;

        RequireUserFields: Boolean;
        RequireVendorFields: Boolean;

        CreateUserEnabled: Boolean;

        StatusStyle: Text;
}