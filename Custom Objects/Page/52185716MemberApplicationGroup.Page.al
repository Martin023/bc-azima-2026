page 52185716 "Member Application Group"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,EDMS';
    SourceTable = "Member Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FastTabsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = EmployerEdit;
                // }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Membership Date';
                    Editable = false;
                }
                field("Company Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PINNumberEdit;
                }

                field("Account Type"; Rec."Account Type")
                {
                    ValuesAllowed = "Group Account";
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        if Rec."Account Type" = Rec."Account Type"::"Group Account" then
                            DefaultSavingsVisible := true
                        else begin
                            DefaultSavingsVisible := false;
                            AutoOpenSavingAccs.Reset();
                            AutoOpenSavingAccs.SetRange("No.", Rec."No.");
                            if AutoOpenSavingAccs.FindSet() then AutoOpenSavingAccs.DeleteAll();
                        end;
                    end;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GroupTypeEdit;
                    ShowMandatory = true;
                }   
                field(Name; Rec.Name)
                {
                    Caption = 'Group Account Name';
                    ApplicationArea = Basic, Suite;
                    Editable = FirstNameEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Application Date" := Today;
                    end;
                }

                field("P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PINNumberEdit;
                }


                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusControl();
                    end;
                }


                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowMandatory = true;
                }
                // field("Allocated Officer"; Rec."Allocated Officer")
                // {
                //     Caption = 'Account Manager';
                // }

            }
            group(Business)
            {
                Visible = BusinessEdit;

                field("Business Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GroupRegistrationNoEdit;
                    //ShowMandatory = true;
                }

            }
            group("Communication Details")
            {
                Editable = FastTabsEditable;
                field(Nationality; Rec.Nationality)
                {
                    Caption = 'Country of Operation';
                    ApplicationArea = Basic, Suite;
                    Editable = NationalityEdit;
                    ShowMandatory = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PostCodeEdit;
                    Importance = Promoted;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'City';
                    Editable = CityEdit;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CountyEdit;
                    ShowMandatory = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Communication Phone Number';
                    ApplicationArea = Basic, Suite;
                    Editable = MobileNoEdit;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        CountryRegion: Record "Country/Region";
                    begin


                        if CountryRegion.Get(Rec.Nationality) then begin
                            if CountryRegion."County Phone Code" <> CopyStr(Rec."Phone No.", 1, StrLen(CountryRegion."County Phone Code")) then
                                Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                        end;
                    end;
                }

                field("Transactional Mobile Number"; Rec."Transactional Mobile Number")
                {
                    // ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        CountryRegion: Record "Country/Region";
                    begin


                        if CountryRegion.Get(Rec.Nationality) then begin
                            if CountryRegion."County Phone Code" <> CopyStr(Rec."Transactional Mobile Number", 1, StrLen(CountryRegion."County Phone Code")) then
                                Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                        end;
                    end;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EmailEdit;
                }
                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P.O. BOX';
                    Editable = AddressEdit;
                }
            }
            group("Bank Details")
            {
                Editable = FastTabsEditable;
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = BankEdit;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = BranchEdit;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = BankAccountNoEdit;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Default Savings Product")
            {
                ApplicationArea = all;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Savings Account Registration";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Group Members")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Signatories Application";
                RunPageLink = "Account No" = FIELD("No.");
            }

            action("Create Group")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                Visible = CreateGroupVisible;


                trigger OnAction()
                var

                    RegistrationMngt: Codeunit "Registration Process";
                    Text002: Label 'Are you sure you want to convert this application to group membership?';
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Created = true then
                        error('This member has already been created.');
                    if not Confirm(Text002) then exit;
                    RegistrationMngt.MemberRegistration(Rec, true);
                    Rec.Created := true;
                    Message('Group account registered successfully');
                end;
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Visible = SendApprovalVisible;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        i: Integer;
                        MinimumGroupMembers: Integer;
                        Cahirman: Boolean;
                        Secretary: Boolean;
                        Treasurer: Boolean;
                        Signatory: Integer;
                        Members: Record Members;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Name);
                        Rec.TestField("Group Type");
                        //Rec.TestField("Relationship Manager");

                        SignatoriesApplication.Reset;
                        SignatoriesApplication.SetRange(SignatoriesApplication."Account No", Rec."No.");
                        SignatoriesApplication.SetFilter("Member No.", '<>%1', '');
                        ;
                        if SignatoriesApplication.Find('-') then begin
                            repeat
                                if SignatoriesApplication.Type = SignatoriesApplication.Type::"Chair Person" then
                                    Cahirman := true;
                                if SignatoriesApplication.Type = SignatoriesApplication.Type::Treasurer then
                                    Treasurer := true;
                                if SignatoriesApplication.Type = SignatoriesApplication.Type::Secretary then
                                    Secretary := true;
                                if SignatoriesApplication.Signatory then
                                    Signatory += 1;
                                i += 1;
                            // if Members.Get(SignatoriesApplication."Member No.") then begin
                            //     if not Members."Has Joined Business Loans" then
                            //         Error('Membership class for group member %1 must be business loan', Members.Name);
                            // end;
                            until SignatoriesApplication.Next = 0;
                        end;
                        GenSetup.Get;
                        MinimumGroupMembers := GenSetup."Minimum No of Group Members";
                        if i < MinimumGroupMembers then
                            Error('Minimun number of Group Members is %1, Please add %2 more Members', GenSetup."Minimum No of Group Members", MinimumGroupMembers - i);

                        // if not Secretary then Error('You must have a secretary');
                        // if not Cahirman then Error('You must have a chair person');
                        // if not Treasurer then Error('You must have a treasurer');
                        // if Signatory = 0 then Error('You must have at least one signatory');

                        if UserSetup.Get(UserId) then begin
                            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec."Application Date" := Today;
                            Rec."Created By" := UserId;
                            Rec.Modify;
                        end;
                        if not Confirm('Are you sure you want to send this document for approval?') then exit;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

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
                        if not Confirm('Are you sure you want to send this document for approval?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
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
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure you want to cancel this approval request?') then exit;
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
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure you want to cancel this approval request?') then exit;
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
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure you want to delegate this approval request?') then exit;
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                        ApprovalCommentLine: Record "Approval Comment Line";
                    begin
                        ApprovalCommentLine.SetRange("Table ID", 52185690);
                        ApprovalCommentLine.SetRange("Record ID to Approve", Rec.RecordId);
                        PAGE.Run(PAGE::"Approval Comments", ApprovalCommentLine);
                    end;
                }
            }

            action("MEMBER [FILE]")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;

                trigger OnAction()
                var
                    DMS: Record EDMS;
                begin
                    DMS.Reset;
                    DMS.SetRange(DMS.Key, DMS.Key::"member App");
                    if DMS.Find('-') then begin
                        HyperLink(DMS."url path" + Rec."No.");
                    end;
                end;
            }
            action("Reopen Document")
            {
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to re-open document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category9;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl();

    end;

    trigger OnAfterGetRecord()
    begin
        StatusControl();

    end;

    trigger OnOpenPage()
    begin
        StatusControl();
        if MemberApplication.Get(Rec."No.") then begin
            ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
            ProductFactory.SetFilter(ProductFactory."Auto Open Group Account", '%1', true);
            ProductFactory.SetFilter(ProductFactory."Product Category", '<>%1', ProductFactory."Product Category"::"Fixed Deposit");
            if ProductFactory.Find('-') then begin
                repeat
                    AutoOpenSavingAccs.Reset;
                    AutoOpenSavingAccs.SetRange("No.", MemberApplication."No.");
                    AutoOpenSavingAccs.SetRange("Product Type", ProductFactory."Product ID");
                    if AutoOpenSavingAccs.Find('-') then begin
                        if AutoOpenSavingAccs."Monthly Contribution" = 0 then
                            AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                        AutoOpenSavingAccs.Modify;
                    end;
                until ProductFactory.Next = 0;
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Account Type" := rec."Account Type"::"Group Account";
    end;

    procedure UploadToEDMS(Rec: Record "Member Application"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'MA'; // Member Application
        PFNumber: Text;
    begin
        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::"ID Number" then begin
            IDNumber := Rec."Primary Identification";
        end else
            if Rec."Secondary Identification Type" = Rec."Secondary Identification Type"::"ID Number" then begin
                IDNumber := Rec."Secondary Identification";
            end else begin
                if Rec."Company Registration No." = '' then begin
                    IDNumber := Rec."Company Registration No.";
                end else begin
                    IDNumber := Rec."Primary Identification";
                end;
            end;

        if Rec."Payroll/Staff No." <> '' then begin
            PFNumber := Rec."Payroll/Staff No.";
        end else begin
            PFNumber := IDNumber;
        end;

        if IDNumber = '' then begin
            IDNumber := Rec."No.";
        end;
        if PFNumber = '' then begin
            PFNumber := Rec."No.";
        end;

        EDMSFunctions.EDMSMemberFileUpload(
            IDNumber,
            Rec.Name,
            ApplicationType,
            PfNumber,
            Rec."No.",
            Rec."No.",
            FileName,
            FileContentsB64
        );
    end;

    var
        GenSetup: Record "General Set-Up";

        MultipleEdit: Boolean;
        BusinessEdit: Boolean;
        ApplicationDateEdit: Boolean;
        MemberType: Boolean;
        FirstNameEdit: Boolean;
        AddressEdit: Boolean;
        EmployerEdit: Boolean;
        GlobalDim1Edit: Boolean;
        GlobalDim2Edit: Boolean;
        SalesEdit: Boolean;
        PINNumberEdit: Boolean;
        SegmentEdit: Boolean;
        MemberClassEdit: Boolean;
        GroupTypeEdit: Boolean;
        NatureofGroupEdit: Boolean;
        GroupRegistrationNoEdit: Boolean;
        GroupRegistrationDateEdit: Boolean;
        GroupLocationEdit: Boolean;
        GroupPlotBuildingStreetEdit: Boolean;
        BusinessOwnershipTypeEdit: Boolean;
        OtherBusinessTypeEdit: Boolean;
        RelationshipManager: Boolean;
        EmailEdit: Boolean;
        ElectrolZoneEdit: Boolean;
        AreaServiceCenterEdit: Boolean;
        RespCenterEdit: Boolean;
        PhoneEdit: Boolean;
        MobileNoEdit: Boolean;
        PostCodeEdit: Boolean;
        CityEdit: Boolean;
        NationalityEdit: Boolean;
        CountyEdit: Boolean;
        BankEdit: Boolean;
        BranchEdit: Boolean;
        BankAccountNoEdit: Boolean;
        CreateVisible: Boolean;
        SignatoriesApplication: Record "Signatory Application";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Text003: Label 'You must provide either ID Number, Passport No., P.I.N Number or Birth Cerificate No.';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        MembersegmentEdit: Boolean;
        MemberApplication: Record "Member Application";
        MemberClass: Record "Agent Next Of Kin Details";
        ProductFactory: Record "Product Factory";
        AutoOpenSavingAccs: Record "Savings Account Registration";
        ApplicationDocumentSetup: Record "Application Document Setup";
        ApplicationDocuments: Record "Application Documents";
        AccountSignatories: Record "Account Signatories";
        UserSetup: Record "User Setup";
        DefaultSavingsVisible: Boolean;
        SendApprovalVisible: Boolean;
        CreateGroupVisible: Boolean;
        FastTabsEditable: Boolean;




    local procedure StatusControl()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if Rec.Created = true then
            CreateGroupVisible := false else
            CreateGroupVisible := true;
        case Rec.Status of
            Rec.Status::Open:
                begin
                    OpenApprovalEntriesExist := false;
                    OpenApprovalEntriesExistForCurrUser := false;
                    FastTabsEditable := true;
                    CreateGroupVisible := false;
                    SendApprovalVisible := true;
                    ApplicationDateEdit := true;
                    MemberType := true;
                    FirstNameEdit := true;
                    PINNumberEdit := true;
                    SegmentEdit := true;
                    RespCenterEdit := true;
                    CreateVisible := false;
                    EmployerEdit := true;
                    GlobalDim1Edit := true;
                    GlobalDim2Edit := true;
                    SalesEdit := true;
                    MemberClassEdit := true;

                    GroupTypeEdit := true;
                    NatureofGroupEdit := true;
                    GroupRegistrationNoEdit := true;
                    GroupRegistrationDateEdit := true;
                    GroupLocationEdit := true;
                    GroupPlotBuildingStreetEdit := true;
                    BusinessOwnershipTypeEdit := true;
                    OtherBusinessTypeEdit := true;

                    PhoneEdit := true;
                    MobileNoEdit := true;
                    EmailEdit := true;
                    AddressEdit := true;
                    PostCodeEdit := true;
                    CityEdit := false;
                    NationalityEdit := true;
                    CountyEdit := true;
                    RelationshipManager := true;
                    ElectrolZoneEdit := true;
                    AreaServiceCenterEdit := true;
                    EmployerEdit := true;
                    GlobalDim1Edit := true;
                    GlobalDim2Edit := true;
                    SalesEdit := true;

                    BankEdit := true;
                    BranchEdit := true;
                    BankAccountNoEdit := true;
                end;

            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected:
                begin
                    FastTabsEditable := false;
                    if Rec.Created = false then
                        CreateGroupVisible := true;
                    SendApprovalVisible := false;

                    ApplicationDateEdit := false;
                    MemberType := false;
                    FirstNameEdit := false;
                    PINNumberEdit := false;
                    SegmentEdit := false;
                    RespCenterEdit := false;
                    EmployerEdit := false;
                    GlobalDim1Edit := false;
                    GlobalDim2Edit := false;
                    SalesEdit := false;
                    MemberClassEdit := false;

                    GroupTypeEdit := false;
                    NatureofGroupEdit := false;
                    GroupRegistrationNoEdit := false;
                    GroupRegistrationDateEdit := false;
                    GroupLocationEdit := false;
                    GroupPlotBuildingStreetEdit := false;
                    BusinessOwnershipTypeEdit := false;
                    OtherBusinessTypeEdit := false;

                    PhoneEdit := false;
                    MobileNoEdit := false;
                    EmailEdit := false;
                    AddressEdit := false;
                    PostCodeEdit := false;
                    CityEdit := false;
                    NationalityEdit := false;
                    CountyEdit := false;
                    RelationshipManager := false;
                    ElectrolZoneEdit := false;
                    AreaServiceCenterEdit := false;

                    EmployerEdit := false;
                    GlobalDim1Edit := false;
                    GlobalDim2Edit := false;
                    SalesEdit := false;

                    BankEdit := false;
                    BranchEdit := false;
                    BankAccountNoEdit := false;
                end;

        end;
    end;


}

