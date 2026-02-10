page 52186647 "Dependancies Applications Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Activities, ,Category7_caption,Category8_caption,Category9_caption,Approvals,EDMS';
    SourceTable = "Dependancies Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Source Application"; Rec."Source Application")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("CRM No"; Rec."CRM No")
                // {
                //     Editable = false;
                // }
                // field("M-Smart No"; Rec."M-Smart No")
                // {
                //     Editable = false;
                // }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Time"; Rec."Application Time")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        StatusControl();
                    end;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                    end;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }

                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Created; Rec.Created)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            systempart(Control13; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control14; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control15; Links)
            {
                ApplicationArea = Basic, Suite;
            }




        }
    }

    actions
    {
        area(processing)
        {
            group(Action31)
            {
                action(Signatories)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Signatories Application";
                    RunPageLink = "Account No" = FIELD("No.");
                    Visible = SignatoryVisible;
                }
                action(ASignatories)
                {
                    Caption = 'Account Signatories';
                    ApplicationArea = Basic, Suite;
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Signatories List";
                    RunPageLink = "Account No" = FIELD("Member No.");
                    Visible = AccountSignatory;
                }
                action("Next Of KIN")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Relationship;
                    Caption = 'Dependancies List';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Next of KIN Application";
                    RunPageLink = "Record ID" = FIELD("No.");

                }
                action("Post Changes")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RegistrationProcess: Codeunit "Registration Process";
                    begin
                        Rec.TestField(Created, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        PostNextofKIN(Rec);
                        Rec.Created := true;
                        Rec.Modify(true);
                        Message('Updated successfully');
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

                group("Certificate Management")
                {
                    action(Passport)
                    {
                        ApplicationArea = all;
                        Image = Certificate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Certificate Management";
                        RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter(Passport);
                        Visible = PassportVisible;
                    }
                    action("Tax Exemption")
                    {
                        ApplicationArea = all;
                        Image = Certificate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Certificate Management";
                        RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter("Tax Exemption");
                        Visible = TaxExemptionVisible;
                    }

                }
            }
            // action("Picture & Signature")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Picture;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     //RunObject = Page "MemberChanges Pic & Sig";
            //     // RunPageLink = "No." = FIELD("No.");
            // }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

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
                    ApplicationArea = Basic, Suite;
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
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        if not Confirm('Are you sure you want to reject this request?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                        theRecord: Record "Dependancies Applications";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec.Created then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;

                            theRecord.Get(Rec."No.");
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                            theRecord.Status := theRecord.Status::Deffered;
                            theRecord.Validate(Status);
                            theRecord.Modify(true);
                            Message('Record deffered succsessfully');
                        end else
                            Error('You cannot deffer a created record');
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
                        theRecord: Record "Dependancies Applications";
                    begin

                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if ((Rec.Status <> Rec.Status::Approved) or (Rec.Status <> Rec.Status::Rejected)) then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;

                            theRecord.Get(Rec."No.");
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                            theRecord.Status := theRecord.Status::Archived;
                            theRecord.Validate(Status);
                            theRecord.Modify(true);
                            Message('Record archive succsessfully');
                        end else
                            Error('You cannot archive an approved or rejected record');
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: Label 'You must specify next of Kin for this application.';
                        CertificateManagement: Record "Certificate Management";
                        Members: Record Members;
                        CertMngt: Record "Certificate Management";
                        NokApp: Record "Next of KIN Application";
                        AccSignatories: Record "Account Signatories";
                    begin

                        if rec."Account Type" = rec."Account Type"::"Group Account" then begin
                            AccSignatories.Reset();
                            AccSignatories.SetRange("Account No", rec."Member No.");
                            if AccSignatories.Count < 3 then
                                Error('A Group Account must have atleast three Signatories.');
                        end else

                            if rec."Account Type" = rec."Account Type"::"Joint Account" then begin
                                AccSignatories.Reset();
                                AccSignatories.SetRange("Account No", rec."Member No.");
                                if AccSignatories.Count > 2 then
                                    Error('A Joint Account can only have two signatories.');
                            end;

                        if (rec."Account Type" = rec."Account Type"::"Joint Account") OR
                        (rec."Account Type" = rec."Account Type"::"Group Account") then begin

                            AccSignatories.Reset();
                            AccSignatories.SetRange("Account No", rec."Member No.");
                            if not AccSignatories.FindFirst() then
                                Error('You must add atleast one signatory')
                            else begin
                                repeat
                                    AccSignatories.Reset();
                                    AccSignatories.SetRange("Account No", rec."Member No.");
                                    AccSignatories.CalcFields(Picture, Signature);
                                    if not AccSignatories.Picture.HasValue or not AccSignatories.Signature.HasValue then
                                        Error('Kindly ensure both Picture and Signature are captured for all signatories.');
                                until AccSignatories.Next() = 0;
                            end;
                        end;

                        NokApp.Reset();
                        NokApp.SetRange("Record ID", Rec."No.");
                        NokApp.SetRange(Deceased, false);
                        NokApp.SetRange(Removed, false);
                        if NokApp.FindSet() then begin
                            repeat
                                if NokApp.Name = '' then Error('One of the dependancies is missing a name');
                                if NokApp."Identification Type" = NokApp."Identification Type"::" " then Error('Indetification type must have a value for %1', NokApp.Name);
                                // NokApp.TestField(Identification);
                                NokApp.TestField(Relationship);
                                if (not NokApp."Is a Beneficiary") and (not NokApp."Is Contact Person") and (not NokApp."Is Nominee") then
                                    Error('Is a Beneficiary : %1\Is a Contact Person: %2\Is a Nominee: %3\One of the above must be true for %4', NokApp."Is a Beneficiary", NokApp."Is Contact Person", NokApp."Is Nominee");
                            until NokApp.Next() = 0;
                        end;

                        NokApp.Reset();
                        NokApp.SetRange(Removed, false);
                        NokApp.SetRange(Deceased, false);
                        NokApp.SetRange("Record ID", Rec."No.");
                        NokApp.SetRange("Is Nominee", true);
                        if NokApp.FindSet() then begin
                            NokApp.CalcSums(NokApp.Allocation);
                            if NokApp.Allocation <> 100 then Error('Alocation must sum up to 100%');
                        end;

                        if Rec."Account Type" = Rec."Account Type"::" " then Error('Account type must have a value');
                        CertificateManagement.Reset();
                        CertificateManagement.SetRange("Record ID", Rec."No.");
                        if CertificateManagement.FindSet() then begin
                            repeat
                                CertMngt.Reset();
                                CertMngt.SetRange("Record ID", Rec."Member No.");
                                CertMngt.SetRange("Document Type", CertificateManagement."Document Type");
                                if CertMngt.FindFirst() then begin
                                    if CertMngt."End Date" > Today then Error('The current %1 has not yet expired', CertMngt."Document Type");
                                    if CertificateManagement."Start Date" < CertMngt."End Date" then
                                        Error('The current %1 end date %2 is later than %3', CertMngt."Document Type", CertMngt."End Date", CertificateManagement."Start Date");
                                end;
                            until CertificateManagement.Next() = 0;
                        end;

                        if Rec.Description = '' then Error('Description must have a value');

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");

                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-Open (Return) Application';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        theRecord: Record "Dependancies Applications";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure yu want to open this application?') then exit;

                        theRecord.Get(Rec."No.");
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);

                        theRecord.Status := theRecord.Status::Open;
                        theRecord.Modify(true);
                        Message('Record edited successfully');
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
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
        StatusControl;
    end;

    trigger OnAfterGetRecord()
    begin
        StatusControl();
        // if not Rec.Created then
        //     GlobalFunctions.PopUpCommentsIfCaseHas(Rec."No.");
    end;

    trigger OnOpenPage()
    begin

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            if Rec."Application Time" = 0T then rec."Application Time" := Time;
            if Rec."Application Date" = 0D then rec."Application Date" := Today;
            if (Rec."Global Dimension 1 Code" = '') or (Rec."Global Dimension 2 Code" = '') then Error('Activity code or Branch code must not be empty in user setup');
        end else
            Error('You must be set up in user setup');

        StatusControl();
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

    var
        "-": Integer;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UserSetup: Record "User Setup";
        SignatoryVisible: Boolean;
        NextOfKinVisible: Boolean;
        PassportVisible: Boolean;
        TaxExemptionVisible: Boolean;
        NextOfKinEnabled: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        AccountSignatory: Boolean;
        HasEDMS: Boolean;

    procedure StatusControl()
    var
        theMSmartMemberEdit: record "M-Smart Member Edit";
    begin
        if (Rec."Account Type" = Rec."Account Type"::"Group Account") OR (Rec."Account Type" = Rec."Account Type"::"Joint Account") then begin
            NextOfKinVisible := false;
            SignatoryVisible := false;
            TaxExemptionVisible := false;
            PassportVisible := false;
            AccountSignatory := true;
        end;

        if Rec."Account Type" = Rec."Account Type"::"Single Member Account" then begin
            NextOfKinVisible := true;
            SignatoryVisible := false;
            TaxExemptionVisible := true;
            PassportVisible := true;
        end;
        if (rec."Account Type" = Rec."Account Type"::"Business Loan Account") then begin
            NextOfKinVisible := false;
            SignatoryVisible := true;
            TaxExemptionVisible := false;
            PassportVisible := false;
        end;
        if Rec.Status = Rec.Status::Open then begin
            CurrPage.Editable := true;
            NextOfKinEnabled := false;

        end else begin
            CurrPage.Editable := false;
        end;

        if Rec."CRM No" <> '' then begin
            HasEDMS := true;
        end;
    end;

    procedure PostNextofKIN(DependancyApplication: Record "Dependancies Applications")
    var
        NOK: Record "Next of KIN";
        NOKApp: Record "Next of KIN Application";
    begin
        NOK.Reset();
        NOK.SetRange(Deceased, false);
        NOK.SetRange("Record ID", DependancyApplication."Member No.");
        if NOK.Find('-') then NOK.DeleteAll();

        NOKApp.Reset();
        NOKApp.SetRange("Record ID", DependancyApplication."No.");
        if NOKApp.Find('-') then begin
            repeat
                if not NOK.Get(DependancyApplication."Member No.", NOKApp.Identification) then begin
                    NOK.Init();
                    NOK."Record ID" := DependancyApplication."Member No.";
                    NOK."Identification Type" := NOKApp."Identification Type";
                    NOK.Identification := NOKApp.Identification;
                    NOK.Name := NOKApp.Name;
                    NOK.Relationship := NOKApp.Relationship;
                    NOK."Is a Beneficiary" := NOKApp."Is a Beneficiary";
                    NOK."Is Next of Kin" := NOKApp."Is Next of Kin";
                    NOK."Is Nominee" := NOKApp."Is Nominee";
                    NOK."Is Contact Person" := NOKApp."Is Contact Person";
                    NOK."Date of Birth" := NOKApp."Date of Birth";
                    NOK.Address := NOKApp.Address;
                    NOK.Telephone := NOKApp.Telephone;
                    NOK.Email := NOKApp.Email;
                    NOK.Allocation := NOKApp.Allocation;
                    NOK.Removed := NOKApp.Removed;
                    NOK.Insert(true);
                end;
            until NOKApp.Next() = 0;
        end;

        NOKApp.Reset();
        NOKApp.SetRange("Record ID", DependancyApplication."No.");
        //NOKApp.SetRange(Deceased, false);
        NOKApp.SetRange(Removed, True);
        if NOKApp.Find('-') then begin
            repeat
                IF NOK.Get(DependancyApplication."Member No.", NOKApp.Identification) THEN BEGIN
                    NOK.Removed := true;
                    NOK.Modify(true);
                END;
            until NOKApp.Next() = 0;
        end;
        //Removed N.O.K
        end;
}

