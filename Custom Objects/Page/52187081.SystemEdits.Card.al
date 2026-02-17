page 52187081 "System Edits Card"
{
    ApplicationArea = All;
    Caption = 'System Edits Card';
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals,EDMS';
    PageType = Card;
    SourceTable = "System Edits";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = GeneralTabEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the primary key of the record.';
                    Editable = false;
                }
                field("CRM No"; Rec."CRM No")
                {
                    Editable = false;
                }
                field("M-Smart No"; Rec."M-Smart No")
                {
                    Editable = false;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the table undergoing the edits.';
                    ShowMandatory = true;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the table name.';
                    Editable = false;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ToolTip = 'Specifies the table caption.';
                    Editable = false;
                }
                field("Edits Reason"; Rec."Edits Reason")
                {
                    ShowMandatory = true;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Editable = false;
                }

                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Freetext to describe the change.';
                    MultiLine = true;
                    Caption = 'Other Comments';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
                field("Request Source"; Rec."Request Source")
                {
                    Editable = false;
                }

            }
            group("Card Control")
            {
                Editable = ControlTabEditable;
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                }
                field("Innitiating Officer"; Rec."Innitiating Officer")
                {
                    ToolTip = 'Specifies the value of who created the record.';
                    Editable = false;
                }
                field("Approving Officer"; Rec."Approving Officer")
                {
                    ToolTip = 'Specifies the value of who approved the record.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action(Filters)
            {
                ApplicationArea = all;
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "System Edits Filters";
                RunPageLink = "Record ID" = FIELD("No.");
                Visible = SetFiltersVisible;
            }
            action("Set Filter Fields")
            {
                ApplicationArea = all;
                Image = SetupList;
                Promoted = true;
                PromotedCategory = Process;
                Visible = SetFilterFieldsVisible;

                trigger OnAction()
                var
                    SystemEditsCodeunit: Codeunit "System Editss";
                    Action: Option SetFilter,PostChanges;
                begin
                    if Rec."Request Source" = Rec."Request Source"::"M-Portal" then begin
                        Message('Filter fields set successfully');
                        exit;
                    end;

                    if Rec.Status = Rec.Status::Open then
                        Message(SystemEditsCodeunit.SetFilterFields(Rec."Table ID", Rec."No.", Action::SetFilter, RecRef, RecRef))
                    else
                        Error('Status must be open to run this task');
                end;

            }
            action("Record Fields")
            {
                ApplicationArea = all;
                Image = EditList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "System Edits Fields";
                RunPageLink = "Record ID" = FIELD("No.");
            }

            action("Open Card")
            {
                ApplicationArea = all;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    DataTransfer.SetData(Rec."No.");
                    Page.Run(52187317, Rec);
                end;
            }

            action("Post Changes")
            {
                ApplicationArea = all;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = PostChangesEnabled;

                trigger OnAction()
                var
                    SystemEditsCodeunit: Codeunit "System Editss";
                    Action: Option SetFilter,PostChanges;
                    CRMMemberEdit: Record "CRM Member Edit";
                    MSmartMemberEdit: Record "M-Smart Member Edit";
                begin
                    if Rec.Status <> Rec.Status::Approved then error('The status has to be approved');
                    if Rec.Posted then Error('This record has already been posted');
                    Message(SystemEditsCodeunit.SetFilterFields(Rec."Table ID", Rec."No.", Action::PostChanges, RecRef, RecRef));

                    if Rec."Table ID" = 52185700 then
                        SMSMemberOnChange(Rec);

                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Posting Date" := CurrentDateTime;
                    rec."Posting Time" := Time;
                    if CRMMemberEdit.Get(Rec."CRM No") then begin
                        CRMMemberEdit."Change Complete" := true;
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Approved;
                        CRMMemberEdit.Modify(true);
                    end;

                    if MSmartMemberEdit.Get(Rec."M-Smart No") then begin
                        MSmartMemberEdit."Change Complete" := true;
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Approved;
                        MSmartMemberEdit.Modify(true);
                    end;
                    Rec.Modify(true);
                end;
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
                    Visible = SendApprovalVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin
                        Rec.TestField("Table ID");
                        Rec.TestField("Edits Reason");

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
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
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this record?') then exit;
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        if not Confirm('Are you sure you want to reject this request?') then exit;
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
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reaopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-Open (Return) Application';
                    Image = ReOpen;
                    Visible = ReopenVisible;

                    trigger OnAction()
                    var

                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        CurrPage.Update();
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    // Visible = DeferVisible;

                    trigger OnAction()
                    var
                        theRecord: Record "System Edits";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec.Posted then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;

                            theRecord.Get(Rec."No.");

                            VarVariant := Rec;
                            //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                            theRecord.Status := theRecord.Status::Deffered;
                            theRecord.Validate(Status);
                            theRecord.Modify(true);
                            Message('Record deffered successfully');
                        end else
                            Error('You cannot deffer a posted record');
                    end;
                }
                action(Archive)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archive Application';
                    Image = Archive;
                    // Visible = DeferVisible;

                    trigger OnAction()
                    var
                        theRecord: Record "System Edits";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec.Posted then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;

                            theRecord.Get(Rec."No.");
                            //GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                            theRecord.Status := theRecord.Status::Archived;
                            theRecord.Validate(Status);
                            theRecord.Modify(true);
                            Message('Record archive succsessfully');
                        end else
                            Error('You cannot archive a posted record');
                    end;
                }

                group(TaskAssignment)
                {
                    Caption = 'Assign Task';
                    action(AssinedUser)
                    {
                        ApplicationArea = all;
                        Image = Task;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "User Tasks";
                        RunPageLink = "Record ID" = FIELD("No.");
                        Caption = 'User Assigned';
                    }
                }

                group("EDMS Integration")
                {
                    Visible = HasEDMS;
                    Enabled = HasEDMS;
                    action("Import")
                    {
                        ApplicationArea = All;
                        Caption = 'Import File';
                        Promoted = true;
                        PromotedCategory = Category10;
                        Image = Import;

                        trigger OnAction()
                        var
                            Base64Convert: Codeunit "Base64 Convert";
                            TempBlob: Codeunit "Temp Blob";
                            InStr: InStream;
                            ApplicantMember: Record Members;

                            EDMSFunctions: Codeunit "EDMS Functions";
                            FileName: Text;
                            FileContentsB64: Text;

                            IDNumber: Text;
                            ApplicationType: Label 'ME'; // Member Edit
                            PFNumber: Text;
                            theMSmartMemberEdit: Record "M-Smart Member Edit";
                            theCRMMemberEdit: Record "CRM Member Edit";
                        begin
                            if Rec."No." <> '' then begin
                                FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                                TempBlob.CreateInStream(InStr);
                                FileContentsB64 := Base64Convert.ToBase64(InStr);

                                if FileContentsB64 <> '' then begin
                                    if theMSmartMemberEdit.Get(Rec."M-Smart No") then begin
                                        UploadToEDMS(theMSmartMemberEdit, FileName, FileContentsB64);
                                    end;

                                    if theCRMMemberEdit.Get(Rec."CRM No") then begin
                                        UploadToEDMS2(theCRMMemberEdit, FileName, FileContentsB64);
                                    end;
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
                        PromotedCategory = Category10;

                        trigger OnAction()
                        var
                            EDMSFiles: Record "EDMS Files";
                            theMSmartMemberEdit: Record "M-Smart Member Edit";
                            theCRMMemberEdit: Record "CRM Member Edit";
                        begin
                            EDMSFiles.Reset;



                            if theCRMMemberEdit.Get(Rec."CRM No") then begin
                                EDMSFiles.SetFilter("Application No.", '=%1', theCRMMemberEdit."No.");
                            end;

                            EDMSFiles.SetRange("EDMS Data Class Name", EDMSFiles."EDMS Data Class Name"::MemberFile);

                            Page.Run(Page::"EDMS Files List", EDMSFiles);
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        getControl;
    end;

    trigger OnAfterGetRecord()
    begin
        getControl;
        if not Rec.Posted then
            GlobalFunctions.PopUpCommentsIfCaseHas(Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        getControl;
    end;

    procedure UploadToEDMS(Rec: Record "M-Smart Member Edit"; FileName: Text; FileContentsB64: Text)
    var
        ApplicantMember: Record Members;
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'ME'; // Member Edit
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."No.",
                FileName,
                FileContentsB64
            );
        end;
    end;

    procedure UploadToEDMS2(Rec: Record "CRM Member Edit"; FileName: Text; FileContentsB64: Text)
    var
        ApplicantMember: Record Members;
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'ME'; // Member Edit
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."No.",
                FileName,
                FileContentsB64
            );
        end;
    end;

    procedure getControl()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        theMSmartMemberEdit: record "M-Smart Member Edit";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if Rec.Status = Rec.Status::Open then begin
            GeneralTabEditable := true;
            ControlTabEditable := true;
            SetFiltersVisible := true;
            SetFilterFieldsVisible := true;
            PostChangesEnabled := false;
            SendApprovalVisible := true;
            OpenApprovalEntriesExist := false;
            OpenApprovalEntriesExistForCurrUser := false;
            ReopenVisible := false;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            GeneralTabEditable := false;
            ControlTabEditable := false;
            SetFiltersVisible := false;
            SetFilterFieldsVisible := false;
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := true;
        end;
        if Rec.Status = Rec.Status::Deffered then begin
            GeneralTabEditable := false;
            ControlTabEditable := false;
            SetFiltersVisible := false;
            SetFilterFieldsVisible := false;
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            GeneralTabEditable := false;
            ControlTabEditable := false;
            SetFiltersVisible := false;
            SetFilterFieldsVisible := false;
            PostChangesEnabled := true;
            SendApprovalVisible := false;
            ReopenVisible := true;
        end;
        if Rec.Status = Rec.Status::Rejected then begin
            GeneralTabEditable := false;
            ControlTabEditable := false;
            SetFiltersVisible := false;
            SetFilterFieldsVisible := false;
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := false;
        end;
        if Rec.Posted then begin
            GeneralTabEditable := false;
            ControlTabEditable := false;
            SetFiltersVisible := false;
            SetFilterFieldsVisible := false;
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := false;
        end;




        if (Rec."CRM No" <> '') and (Rec."Table ID" = Database::Members) then begin
            HasEDMS := true;
        end;
    end;

    procedure SMSMemberOnChange(SystemEditsTable: Record "System Edits")
    var
        Members: Record Members;
        FieldName: Text;
        OldValue: Text;
        NewValue: Text;
        WholeText: Text;
        sms: Text[250];
        FirstName: Text;
        PhoneNumber: Text;
        Source: Enum "SMS Source";
        SendSMS: Codeunit SendSms;
        EditsHelper: Record "Edits Helper";
    begin
        SystemEditsFilters.Reset();
        SystemEditsFilters.SetRange("Record ID", SystemEditsTable."No.");
        if SystemEditsFilters.FindFirst() then begin

            EditsHelper.Reset();
            EditsHelper.SetRange(Posted, false);
            EditsHelper.SetRange("Record No.", SystemEditsFilters.Filter);
            EditsHelper.SetFilter("Edits Header No.", '<>%1', SystemEditsFilters."Record ID");
            if not EditsHelper.FindFirst() then
                if Members.Get(SystemEditsFilters.Filter) then begin
                    Members."Marked For Edits" := false;
                    Members.Modify(true);
                end;


            //Build Change String
            SystemFilterFields.Reset();
            SystemFilterFields.SetRange("Record ID", SystemEditsTable."No.");
            SystemFilterFields.SetRange("Generally Edited", true);
            if SystemFilterFields.Find('-') then begin
                repeat
                    FieldName := '';
                    FieldName := SystemFilterFields."Field Name";
                    OldValue := '';
                    OldValue := SystemFilterFields."Old Value";
                    if OldValue = '' then OldValue := 'Empty';
                    NewValue := '';
                    NewValue := SystemFilterFields."New Value";
                    if NewValue = '' then NewValue := 'Empty';

                    WholeText += FieldName + ': Old Value - ' + OldValue + '; New Value - ' + NewValue + '. ';
                until SystemFilterFields.Next() = 0;
            end;

            // if Members.Get(UpperCase(SystemEditsFilters.Filter)) then begin
            //     GlobalFunctions.GetMemberData(Members."No.", FirstName, PhoneNumber);
            //     sms := CopyStr('Dear ' + FirstName + ', your member register data has been effected as follows: ' + WholeText + 'Reference code ' + Rec."No.", 1, 250);

            //     SendSms.SendSms(Source::MEMBER_CHANGES, PhoneNumber, sms, Rec."No.", UpperCase(SystemEditsFilters.Filter), false, 250, false, 'CBS', '', 'CBS');

            // end;

        end;
    end;

    var
        SystemEditsFilters: Record "System Edits Filters";
        SystemFilterFields: Record "System Edits Fields";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        RecRef: RecordRef;
        GeneralTabEditable: Boolean;
        ControlTabEditable: Boolean;
        SetFiltersVisible: boolean;
        SetFilterFieldsVisible: boolean;
        PostChangesEnabled: Boolean;
        SendApprovalVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ReopenVisible: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        DataTransfer: Codeunit DataTransfer;

        HasEDMS: Boolean;
}
