page 52185738 "Savings Acc. Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Activities,CRM Actions,Category7_caption,Category8_caption,Category9_caption,Approvals,EDMS';
    SourceTable = "Savings Account Application";

    layout
    {
        area(content)
        {
            // group(CRM)
            // {
            //     Caption = 'CRM Information';
            //     field("CRM Application No."; Rec."CRM Application No.")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Created By"; Rec."CRM Created By")
            //     {
            //         Editable = false;
            //     }
            //         field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            //     field("Sent Back to CRM"; Rec."Sent Back to CRM")
            //     {
            //         Editable = false;
            //     }
            // }
            group("Member Details")
            {
                Editable = PageEdit;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                    OptionCaption = 'Individual Account,Joint Account,Group Account,SavCol Account';
                    trigger OnValidate()
                    begin
                        if rec."Application Type" = rec."Application Type"::"Individual Account" then
                            GroupEdit := false
                        else
                            GroupEdit := true;

                    end;
                }
                // field("Effective Date"; Rec."Effective Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = PageEdit;
                // }
                group(Control17)
                {
                    ShowCaption = false;
                    //Visible = MemberNoEdit;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = PageEdit;
                        // ShowMandatory = true;
                    }
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Account Name';
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        getControl;
                    end;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccNoEdit;
                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Monthly Contribution"; Rec."Monthly Contribution")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ShowMandatory = true;
                //     Editable = PageEdit;
                // }
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
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEdit;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        getControl;
                        CurrPage.Update(true);
                    end;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                group("Recruiter Information")
                {
                    Caption = 'Recruiter Information';
                    field("Recruited by Type"; Rec."Recruited by Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = PageEdit;
                    }
                    field("Recruited By"; Rec."Recruited By")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = PageEdit;
                        trigger OnValidate()
                        var
                            HREmployees : Record "HR Employees";
                            Members: Record Members;
                            DelegateMemberss: Record "Delegate Members";
                        begin
                            // Handle 'Others'
                            if Rec."Recruited by Type" = Rec."Recruited by Type"::Others then begin
                                Members.Reset;
                                Members.SetRange("No.", Rec."Recruited By");
                                if Members.FindFirst then
                                    Rec."Recruited By Name" := Members.Name;
                            end;

                            // Handle 'Delegates'
                            if Rec."Recruited by Type" = Rec."Recruited by Type"::Delegates then begin
                                DelegateMemberss.Reset;
                                DelegateMemberss.SetRange("Delegate MNO.", Rec."Recruited By");
                                if DelegateMemberss.FindFirst then
                                    Rec."Recruited By Name" := DelegateMemberss."Delegate Name";
                            end;

                            // Handle 'Staff'
                            if Rec."Recruited by Type" = Rec."Recruited by Type"::Staff then begin
                                HREmployees.Reset;
                                HREmployees.SetRange("No.", Rec."Recruited By");
                                if HREmployees.FindFirst then
                                    Rec."Recruited By Name" := HREmployees."Full Name";
                            end;

                        end;
                    }
                    field("Recruited By Name"; Rec."Recruited By Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                }
            }

            group("Account Details")
            {
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("Fixed Deposit Details")
            {
                Visible = false;
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = true;
                }

                field("Fixed Deposit Amount"; Rec."Fixed Deposit Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Maturity Instructions"; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit cert. no"; Rec."Fixed Deposit cert. no")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Junior Account Details")
            {
                Visible = false;
                field("Parent Account No."; Rec."Parent Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = true;
                }
                field("Birth Certificate No."; Rec."Birth Certificate No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Communication)
            {
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Office Telephone No.';
                    Editable = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Mobile No"; Rec."Transaction Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("Foreign Trade")
            {
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
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
            separator(Action8)
            {
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ProductTypeID: Code[20];
                    IDNumber: Code[20];
                    ImageData: Record "Image Data";
                    sImageData: Record "Savings Account Application";
                    PictureError: Label 'This member has not registered Picture with the Society.';
                begin
                    case Rec."Product Category" of
                    /*"Product Category"::"Junior Savings" :
                     BEGIN
                      sImageData.RESET;
                      sImageData.SETRANGE(sImageData."No.",IDNumber);
                      IF sImageData.FIND('-') THEN BEGIN
                        PAGE.RUN(52185709,ImageData);
                     // PAGE.RUN(52185687,sImageData);
                      END;
                     END;*/

                    //here
                    // "Product Category"::"0", "Product Category"::"Junior Savings", "Product Category"::"Share Capital", "Product Category"::"BOSA Deposits", "Product Category"::"Fixed Deposit":
                    //     begin
                    //         if "Member No." = '' then
                    //             IDNumber := "ID No."
                    //         else
                    //             IDNumber := "Member No.";

                    //         ImageData.Reset;
                    //         ImageData.SetRange(ImageData."Member No", IDNumber);
                    //         if ImageData.Find('-') then begin
                    //             PAGE.Run(52185709, ImageData);
                    //         end else
                    //             Message(PictureError);
                    //     end;

                    end;

                end;
            }
            separator(Action9)
            {
            }
            action("Application Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Application Documents";
                RunPageLink = "Reference No." = FIELD("No.");
            }
            separator(Action19)
            {
            }
            action("Create Account ")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    RegistrationMngt: Codeunit "Registration Process";
                    Text002: Label 'Are you sure you want to convert this application to Account?';
                    SavAcc: Record "Savings Accounts";
                begin

                    // Rec.TestField(Status, rec.Status::Approved);
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This application is not approved yet');
                    if not Confirm(Text002) = true then exit;
                    RegistrationMngt.AccountRegistration(Rec);
                end;
            }
            action(Signatories)
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Signatories Application";
                RunPageLink = "Account No" = FIELD("No.");
                Visible = GroupEdit;
            }
        }
        area(processing)
        {
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
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
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
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approval Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    //Visible = OpenApprovalEntriesExistForCurrUser;
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
                        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                        SignApplication: Record "Signatory Application";
                        ProdFac: record "Product Factory";
                        Gensetup: record "General Set-Up";
                    begin
                        Gensetup.Get();
                        if rec."Recruited by Type" = rec."Recruited by Type"::"None" then
                            Error('Recruiter Type and Recruited by must have a value');

                        if rec."Application Type" = rec."Application Type"::"Group Account" then begin
                            Gensetup.TestField("Minimum No of Group Members");
                            SignApplication.Reset();
                            SignApplication.SetRange("Account No", rec."No.");
                            if SignApplication.Count < Gensetup."Minimum No of Group Members" then
                                Error('A Group Account must have atleast %1 Signatories.', Gensetup."Minimum No of Group Members");
                        end;

                        if rec."Application Type" = rec."Application Type"::"Joint Account" then begin
                            Gensetup.TestField("Minimum No of Joint Members");
                            SignApplication.Reset();
                            SignApplication.SetRange("Account No", rec."No.");
                            if SignApplication.Count < Gensetup."Minimum No of Joint Members" then
                                Error('A Joint Account must have atleast %1 signatories.', Gensetup."Minimum No of Joint Members");
                        end;

                        if (rec."Application Type" = rec."Application Type"::"Joint Account") OR
                           (rec."Application Type" = rec."Application Type"::"Group Account") then begin

                            SignApplication.Reset();
                            SignApplication.SetRange("Account No", rec."No.");
                            if not SignApplication.FindFirst() then
                                Error('You must add atleast one signatory')
                            else begin
                                repeat
                                    SignApplication.CalcFields(Picture, Signature);
                                    if not SignApplication.Picture.HasValue or not SignApplication.Signature.HasValue then
                                        Error('Kindly ensure both Picture and Signature are captured for all signatories.');
                                until SignApplication.Next() = 0;
                            end;
                        end;

                        if ProdFac.get(rec."Product Type") then
                            if ProdFac."Account Creation Method" = ProdFac."Account Creation Method"::Manual then
                                rec.TestField("Savings Account No.");

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re Open';
                    Promoted = true;
                    PromotedCategory = Category9;
                    Image = OpenWorksheet;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        VarVariant := Rec;
                        if not confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
                        rec.modify;
                        Message('The document have been opened successfully.');
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;

                }
                action(SendText)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SavingsAccounts: Record "Savings Accounts";
                        ReturndFieldName: Text;
                        Separator: Text;
                        Value: Text;
                        WorkString: Text;
                        String1: Text;
                        String2: Text;
                        String3: Text;
                        String4: Text;
                        String5: Text;
                        SetupCode: Text;
                        MsgBodyCode: Text;
                        // RegistrationMngt: Codeunit "Registration Process";
                        // SendSms: Codeunit SendSms;
                        ActualMsg: Text[130];
                    begin
                        //Get the Field Name----------|
                        ReturndFieldName := SavingsAccounts.GetSMSFieldName(SavingsAccounts);

                        //Split the Field Name--------|

                        String1 := Token(ReturndFieldName, '[');

                        //Get the Code----------------|
                        SetupCode := SavingsAccounts.GetSMSCode(SavingsAccounts, String1);

                        //Get the SMS Codes-----------|
                        MsgBodyCode := SavingsAccounts.GetSMSFormat();
                        MsgBodyCode := Token(MsgBodyCode, ']');

                        //Get the actual Message
                        ActualMsg := SavingsAccounts.GetAcualSMSFormat();

                        //Validate
                        if MsgBodyCode <> SetupCode then
                            Error('Kindly check whether message body code and SMS Setup code are the same');

                        //Process the SMS.------------|
                        //*RegistrationMngt.DormancyP(String1,MsgBodyCode,ActualMsg,SavingsAccounts);
                    end;
                }
                action(Reset)
                {
                    ApplicationArea = Basic, Suite;
                    Image = StepOut;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if (Rec.Status = Rec.Status::Open) then begin
                            Rec."Application Date" := Today;
                            Rec."Created By" := UserId;
                            Rec."Member No." := '';
                            Rec."Product Type" := '';
                            Rec.Validate("Member No.");
                            Rec.Validate("Product Type");

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
            // group("CRM Integration")
            // {
            //     Visible = false;
            //     action("CRM Comment")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Comment;
            //         Promoted = true;
            //         PromotedCategory = Category5;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field("No.");
            //         RunPageView = where(Types = CONST(comment));
            //         // RunPageMode = Create;

            //         Visible = IsNotSentBackToCRM;
            //     }
            //     action("Send Back to CRM")
            //     {
            //         ApplicationArea = all;
            //         Image = Return;
            //         Promoted = true;
            //         PromotedCategory = Category5;

            //         Visible = IsNotSentBackToCRM;

            //         trigger OnAction()
            //         var
            //             Comments: Record Comments;
            //         begin
            //             Rec.TestField(Status, Rec.Status::Open);

            //             Comments.Reset;
            //             Comments.SetRange("Header No.", Rec."No.");
            //             Comments.SetAscending("Entry No.", true);

            //             if Comments.FindLast then begin
            //                 if (Comments."Commented By" <> UserId) then begin
            //                     Error('Comment is required before sending the application back to CRM');
            //                 end else begin
            //                     if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
            //                         Rec."Sent Back to CRM" := true;
            //                         Rec.Modify;

            //                         Message('Comment has been sent back to CRM');

            //                         CurrPage.Close();
            //                     end;
            //                 end;
            //             end else begin
            //                 Error('Comment is required before sending the application back to CRM');
            //             end;
            //             ;
            //         end;
            //     }
            // }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category10;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;
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
            //         PromotedCategory = Category10;

            //         // RunObject = page "EDMS Files List";
            //         // RunPageMode = Create;
            //         trigger OnAction()
            //         var
            //             EDMSFiles: Record "EDMS Files";
            //         begin
            //             EDMSFiles.Reset;



            //             Page.Run(Page::"EDMS Files List", EDMSFiles);
            //         end;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        getControl;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        getControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::Navision;
    end;

    trigger OnOpenPage()
    begin
        getControl;

        if Rec."Sent Back to CRM" then begin
            IsNotSentBackToCRM := false;
        end else begin
            IsNotSentBackToCRM := true;
        end;
    end;

    procedure UploadToEDMS(Rec: Record "Savings Account Application"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'SA'; // Sub Accounts
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
        IsNotSentBackToCRM: Boolean;
        MicroGroupCode: Boolean;
        ParentEdit: Boolean;
        TypeHide: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        FixedDeposit: Boolean;
        JuniorAccount: Boolean;
        ProductType: Record "Product Factory";
        MemberNoEdit: Boolean;
        DocumentErrorTxt: Label 'Some documents are missing for this application %1.';
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        GroupEdit: Boolean;
        AccountSignatory: Record "Account Signatories";
        SignApplication: Record "Signatory Application";
        AccNoEdit: Boolean;

    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure getControl()
    begin

        if Rec.Status = Rec.Status::Open then begin
            PageEdit := true;
        end;


        if Rec.Status = Rec.Status::Pending then begin
            PageEdit := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            PageEdit := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            PageEdit := false;
        end;
        if rec."Application Type" = rec."Application Type"::"Individual Account" then
            GroupEdit := false
        else
            GroupEdit := true;
        // CurrPage.Editable := true
        // else
        // CurrPage.Editable := false;

        if Rec."Product Type" = '' then
            MemberNoEdit := true
        else begin

            if ProductType.Get(Rec."Product Type") then begin
                if ProductType."Product Category" = ProductType."Product Category"::"Fixed Deposit" then begin
                    FixedDeposit := true;
                    MemberNoEdit := false;
                end else
                    FixedDeposit := false;



                if (ProductType."Product Category") in [ProductType."Product Category"::" ", ProductType."Product Category"::"BOSA Deposits",
                                                        ProductType."product category"::"Entrance Fee", ProductType."Product Category"::"Share Capital"] then
                    MemberNoEdit := true;

                if ProductType."Account Creation Method" = ProductType."Account Creation Method"::Manual
                then begin
                    AccNoEdit := true;
                end
                else
                    AccNoEdit := false;
            end;

        end;
    end;

    //[Scope('OnPrem')]
    procedure Token(var Text: Text; Separator: Text) Token: Text[250]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;
}

