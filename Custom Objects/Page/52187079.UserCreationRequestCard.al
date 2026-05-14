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
                        ShowAccountInfo := Rec."Request Type" <> Rec."Request Type"::"Deactivate User";
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

                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Employee: Record Employee;
                    begin
                        case Employee.Get(Rec."Staff No.") of
                            true:
                                begin
                                    Rec."Full Name" := Employee."First Name" + ' ' + Employee."Last Name";
                                    Rec."Department Name" := Employee."Global Dimension 1 Code";
                                    Rec."Employment Type" := Employee."Emplymt. Contract Code";
                                    Rec."Phone No." := Employee."Phone No.";
                                end;
                            false:
                                Rec.TestField("Staff No.");
                        end;
                    end;
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Account Information")
            {
                Caption = 'Account Information';
                Visible = ShowAccountInfo;

                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Requested Access")
            {
                Caption = 'Requested Access';

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

            action("Generate PDF")
            {
                ApplicationArea = All;
                Caption = 'Generate PDF';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    // wire report here
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SendApprovalEnabled := Rec.Status = Rec.Status::Open;
        CancelApprovalEnabled := Rec.Status = Rec.Status::Pending;
        ShowAccountInfo := Rec."Request Type" <> Rec."Request Type"::"Deactivate User";

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

    local procedure ValidateMandatoryFields()
    begin
        Rec.TestField("Staff No.");
        Rec.TestField("User Name");
        Rec.TestField("Contact Email");
        Rec.TestField("Business Justification");
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        SendApprovalEnabled: Boolean;
        CancelApprovalEnabled: Boolean;
        ShowAccountInfo: Boolean;
        StatusStyle: Text;
}