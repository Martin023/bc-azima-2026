page 52187162 "M-Banking Whitelist App. Card"
{
    ApplicationArea = All;
    Caption = 'M-Banking Whitelist App. Card';
    PageType = Card;
    SourceTable = "M-Banking Whitelist App";

    PromotedActionCategories = ',,,Comments,EDMS,Workflows';

    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                ToolTip = 'Specifies the value of the No. field.', Comment = '%';
            }
            group(CRM)
            {
                Caption = 'CRM';

                field("CRM Created By"; Rec."CRM Created By")
                {
                    ToolTip = 'Specifies the value of the CRM Created By field.', Comment = '%';
                }
                field("CRM Originating Branch"; Rec."CRM Originating Branch")
                {
                    ToolTip = 'Specifies the value of the CRM Originating Branch field.', Comment = '%';
                }
                field("CRM Notes"; Rec."CRM Notes")
                {
                    ToolTip = 'Specifies the value of the CRM Notes field.', Comment = '%';
                    MultiLine = true;
                }
            }
            group("Member Details")
            {
                Caption = 'Member Details';

                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Transactional Mobile No."; Rec."Transactional Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Transactional Mobile No. field.', Comment = '%';
                }
                field("Full Names"; Rec."Full Names")
                {
                    ToolTip = 'Specifies the value of the Full Names field.', Comment = '%';
                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Type field.', Comment = '%';
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ToolTip = 'Specifies the value of the Primary Identification field.', Comment = '%';
                }
            }
            group(General)
            {
                Caption = 'General';

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Is Whitelisted"; Rec."Is Whitelisted")
                {
                    ToolTip = 'Specifies the value of the Is Whitelisted? field.', Comment = '%';
                    Editable = WhitelistEditable;
                }
                field("Whitelist Reference ID"; Rec."Whitelist Reference ID")
                {
                    ToolTip = 'Specifies the value of the Whitelist Reference ID field.', Comment = '%';
                    Editable = WhitelistEditable;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved/Rejected By field.', Comment = '%';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approved/Rejected By field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Workflows)
            {
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Send A&pproval Request';
                    Visible = Rec.Status = Rec.Status::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        VarVariant: Variant;
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        if not Confirm('Are you sure you want to send this application for approval?') then exit;

                        ApprovalsMgmt.Run();

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    end;
                }

                action(Approve)
                {
                    ApplicationArea = all;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this record?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        GlobalFunctions: Codeunit "Global Functions";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Confirm('Are you sure you want to reject this application?') then exit;
                        // Rec.TestField(Status, Rec.Status::Pending);
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify(true);
                        Message('Application rejected sucessfully.');
                        // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }

            group("Comments Group")
            {
                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MBW'; // Mobile Banking Whitelist
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No.");
                    // RunPageMode = Create;
                }
            }
        }
    }

    procedure UploadToEDMS(Rec: Record "M-Banking Whitelist App"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'MBW'; // Mobile Banking Whitelist
        PFNumber: Text;
    begin
        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::"ID Number" then begin
            IDNumber := Rec."Primary Identification";
        end else begin
            IDNumber := Rec."Primary Identification";
        end;

        PFNumber := Rec."No.";

        EDMSFunctions.EDMSMemberFileUpload(
            IDNumber,
            Rec."Full Names",
            ApplicationType,
            PfNumber,
            Rec."Member No.",
            Rec."No.",
            FileName,
            FileContentsB64
        );
    end;

    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesExist := false;

        case Rec.Status of
            Rec.Status::Open, Rec.Status::Pending:
                OpenApprovalEntriesExist := true;
            else
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();

        if (Rec.Status = Rec.Status::Approved) and not (Rec."Is Whitelisted") then begin
            WhitelistEditable := true;
        end;
    end;


    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        WhitelistEditable: Boolean;
}
