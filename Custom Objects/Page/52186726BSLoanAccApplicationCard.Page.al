
page 52186726 "B/S Loan Acc. Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Activities,WorkFlows,Category7_caption,Category8_caption,Category9_caption,Approvals,EDMS';
    SourceTable = "B/S Loan Account Application";

    layout
    {
        area(content)
        {
            group("General")
            {
                Editable = TabsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("CRM Application No."; Rec."CRM Application No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Application Type"; Rec."Application Type")
                {
                    trigger OnValidate()
                    begin
                        TransferVisible := false;
                        AccountDetailsVisible := false;
                        if Rec."Application Type" = Rec."Application Type"::New then begin
                            AccountDetailsVisible := true;
                            TransferVisible := false;
                        end else begin
                            AccountDetailsVisible := false;
                            TransferVisible := true;
                        end;
                        SetControlAppearance();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phone No.';
                    Editable = false;
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Created"; Rec."Account Created")
                {
                    Editable = false;
                }
            }
            group("Account Details")
            {
                Editable = TabsEditable;
                Visible = AccountDetailsVisible;
                field("Type of Business"; Rec."Type of Business")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();

                    end;
                }
                field("Business Location"; Rec."Business Location")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Relationship Manager"; Rec."Relationship Manager")
                {
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Wholesale/Retail"; Rec."Wholesale/Retail")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Current Capital"; Rec."Current Capital")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Annual Turnover"; Rec."Annual Turnover")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
            }
            group("Transfer Details")
            {
                Visible = TransferVisible;
                field("Destination Group No."; Rec."Destination Group No.")
                {
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Transfer Reason"; Rec."Transfer Reason")
                {
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Application Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Message('Show the document link');
                end;
            }
            action("Create Account ")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                Visible = CreateAccountVisible;

                trigger OnAction()
                var
                    RegistrationMngt: Codeunit "Registration Process";
                    Text002: Label 'Are you sure you want to convert this application to Account?';
                begin
                    Rec.TestField(Status, rec.Status::Approved);
                    if not Confirm(Text002) = true then exit;
                    Message(RegistrationMngt.BusinessLoanAccountRegistration(Rec));
                end;
            }
        }
        area(processing)
        {
            group("EDMS Integration")
            {
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
                        ApplicationType: Label 'LA'; // Loan Application
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
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

                                    EDMSFunctions.EDMSLoanFileUpload(
                                      IDNumber,
                                        ApplicantMember.Name,
                                        Format(Rec."Application Type"),
                                        PfNumber,
                                        ApplicantMember."No.",
                                        Rec."No.",
                                        Rec."No.",
                                        FileName,
                                        FileContentsB64,
                                        false
                                    );
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
                    begin
                        EDMSFiles.Reset;

                        
                        EDMSFiles.SetFilter("Application No.", '=%1', Rec."No.");
                        // end;

                        EDMSFiles.SetRange("EDMS Data Class Name", EDMSFiles."EDMS Data Class Name"::BusinessLoansFile);

                        Page.Run(Page::"EDMS Files List", EDMSFiles);
                    end;
                }
            }
            group(Workflows)
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Open);
                        Rec.TestField("Member No.");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.Testfield("Responsibility Center");
                        if Rec."Application Type" = Rec."Application Type"::New then begin
                            Rec.TestField("Type of Business");
                            Rec.TestField("Business Location");
                            //Rec.TestField("Relationship Manager");
                            Rec.TestField("Wholesale/Retail");
                            Rec.TestField("Current Capital");
                            Rec.TestField("No. of Employees");
                            Rec.TestField("Annual Turnover");
                        end else begin
                            Rec.TestField("Destination Group No.");
                            Rec.TestField("Transfer Reason");
                        end;
                        if not Confirm('Are you sure you want to send this document for approval') then exit;
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
                        if not Confirm('Are you sure you want to approve this document?') then exit;
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
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
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
                        if not Confirm('Are you sure you want to reject this this document?') then exit;
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
                        if not Confirm('Are you sure you want to delegate this approval request?') then exit;
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
                    Visible = false;//OpenApprovalEntriesExistForCurrUser;
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
                // action(Reaopen)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Reaopen Card';
                //     Image = ReOpen;
                //     Visible = ReopenVisible;

                //     trigger OnAction()
                //     var

                //     begin
                //         if not Confirm('Are you sure you want to open this document?') then exit;
                //         Rec.Status := Rec.Status::Open;
                //         Rec.Modify();
                //         CurrPage.Update();
                //     end;
                // }

                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen Card';
                    Image = ReOpen;
                    Visible = ReopenVisible;
                    PromotedCategory = Category5;
                    Promoted = true;
                    trigger OnAction()
                    var

                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec."Account Created" then begin
                            if not Confirm('Are you sure you want to open this record?') then exit;
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify(true);
                            CurrPage.Update();
                        end else
                            Error('You cannot open a created record');
                    end;
                }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var

                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec."Account Created" then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                            Rec.Status := Rec.Status::Deffered;
                            Rec.Validate(Status);
                            Rec.Modify(true);
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
                    //Visible = RejectVisible;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var

                    begin
                        if Rec.Status = Rec.Status::Archived then
                            Error(('This record is already in archived state.'));
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec."Account Created" then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                            Rec.Status := Rec.Status::Archived;
                            Rec.Validate(Status);
                            Rec.Modify(true);
                            Message('Record archived succsessfully');
                        end else
                            Error('You cannot archive a created record');
                    end;
                }

                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }

                action(Reset)
                {
                    ApplicationArea = Basic, Suite;
                    Image = StepOut;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        if (Rec.Status = Rec.Status::Open) then begin
                            Rec."Application Date" := Today;
                            Rec."Created By" := UserId;
                            Rec."Member No." := '';
                            Rec.Validate("Member No.");

                            if UserSetup.Get(UserId) then begin
                                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                                Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                                Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            end;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

    end;


    trigger OnOpenPage()
    begin
        SetControlAppearance();

    end;

    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if rec.Status = Rec.Status::Open then begin
            OpenApprovalEntriesExistForCurrUser := false;
            OpenApprovalEntriesExist := false;
            TabsEditable := true;
            AccountDetailsVisible := true;
            SendApprovalVisible := true;
            ReopenVisible := false;
            CreateAccountVisible := false;
        end;
        if rec.Status = Rec.Status::Pending then begin
            TabsEditable := false;
            AccountDetailsVisible := true;
            SendApprovalVisible := false;
            ReopenVisible := true;
            CreateAccountVisible := false;
        end;
        if rec.Status = Rec.Status::Approved then begin
            TabsEditable := false;
            AccountDetailsVisible := true;
            SendApprovalVisible := false;
            ReopenVisible := true;
            CreateAccountVisible := true;
        end;
        if rec.Status = Rec.Status::Rejected then begin
            TabsEditable := false;
            AccountDetailsVisible := true;
            SendApprovalVisible := false;
            ReopenVisible := true;
            CreateAccountVisible := false;
        end;
        if rec."Account Created" then begin
            TabsEditable := false;
            AccountDetailsVisible := true;
            SendApprovalVisible := false;
            ReopenVisible := false;
            CreateAccountVisible := false;
        end;
    end;

    var
        MicroGroupCode: Boolean;
        ParentEdit: Boolean;
        TypeHide: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //CustomApprovals: Codeunit "Custom Approvals Codeunit";
        FixedDeposit: Boolean;
        JuniorAccount: Boolean;
        ProductType: Record "Product Factory";
        MemberNoEdit: Boolean;
        DocumentErrorTxt: Label 'Some documents are missing for this application %1.';
        UserSetup: Record "User Setup";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        CardEditable: Boolean;
        AccountDetailsVisible: Boolean;
        TransferVisible: Boolean;
        SendApprovalVisible: Boolean;
        ReopenVisible: Boolean;
        TabsEditable: Boolean;
        CreateAccountVisible: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
}

