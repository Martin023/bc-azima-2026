page 52185600 "Savings Variations"
{
    ApplicationArea = All;
    Caption = 'Savings Variations';
    PageType = Card;
    SourceTable = "Product Variations";
    PromotedActionCategories = 'New,Process,Reports,Post Changes,Approval Request,Re-Open Document,CRM Actions,EDMS';
    DeleteAllowed = false;
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
            //     field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            // }
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field("Application Date"; Rec."Application Date")
                {

                }
                field("Variation Type"; Rec."Variation Type")
                {
                    OptionCaption = ' ,Loan,Savings';
                    trigger OnValidate()
                    begin
                        Rec."Product Type" := '';
                        Rec."Account No" := '';
                        Rec."Payroll No" := '';
                        Rec."Product Name" := '';
                        Rec."Account No" := '';
                        Rec."Amount Off" := 0;
                        Rec."Amount On" := 0;
                    end;

                }

                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                    trigger OnValidate()
                    begin
                        Rec."Product Type" := '';
                        Rec."Account No" := '';
                        Rec."Payroll No" := '';
                        Rec."Product Name" := '';
                        Rec."Account No" := '';
                        Rec."Amount Off" := 0;
                        Rec."Amount On" := 0;
                        Rec.Reference := '';
                        if Members.Get(Rec."Member No.") then begin
                            Rec."Member Name" := Members.Name;
                            Rec."Payroll No" := Members."Payroll/Staff No.";
                        end;

                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }

                field("Payroll No"; Rec."Payroll No")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.';
                    Editable = false;
                }
                // field(Prorata; Rec.Prorata)
                // {
                //     ToolTip = 'Specifies the value of the Prorata field.';
                // }



                field("Account No"; Rec."Account No")
                {

                    ApplicationArea = all;

                }
                field("Product Type"; Rec."Product Type")
                {
                    Editable = false;
                    trigger OnValidate()
                    begin
                        Rec."Account No" := '';
                        Rec."Amount Off" := 0;
                        Rec."Amount On" := 0;
                        Rec."Product Name" := '';
                        if Productfactory.Get(Rec."Product Type") then
                            Rec."Product Name" := Productfactory."Product Description";
                    end;
                }
                field("Product Name"; Rec."Product Name")
                {
                    Editable = false;
                    ApplicationArea = all;

                }
                field("Amount Off"; Rec."Amount Off")

                {
                    Caption = 'Amount Off';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount Off field.';
                }
                field("Amount On"; Rec."Amount On")

                {
                    ToolTip = 'Specifies the value of the Amount On field.';
                    Caption = 'Amount On';
                    Editable = true;
                }
                field("Effective Date"; Rec."Effective Month")
                {
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                }
                field("Variation Action"; Rec."Variation Action")
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = all;
                }
                field(posted; Rec.posted) { }

            }

        }
    }
    actions
    {
        area(creation)
        {
            // action("Assign Digit Custodian")
            // {
            //     ApplicationArea = all;
            //     Image = OrderTracking;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     trigger OnAction()
            //     var
            //         GlobalFunctions: Codeunit "Global Functions";
            //     begin
            //         if Rec."Member No." = '' then Error('Kindly fill the member number');
            //         GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Savings Variations");
            //         CurrPage.Update();
            //         Message('Digit custodian asigned successfullygit ');
            //     end;
            // }
            action(AssinedUser)
            {
                ApplicationArea = all;
                Image = Task;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "User Tasks";
                RunPageLink = "Record ID" = FIELD("No.");
                Caption = 'User Assigned';
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Rec."Amount On");
                    Rec.TestField(Status, Rec.Status::Open);
                    // Rec.TestField("Amount On");
                    //  Rec.TestField("Amount Off");

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                        CurrPage.Close();
                    end;
                end;

            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    CurrPage.close;
                end;
            }
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                Image = ReOpen;
                trigger OnAction()
                begin
                    rec.TestField(posted, false);
                    if Confirm('Are you sure you want to re-open this document?') then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Document Reopened Sucessfully.');
                        CurrPage.close;
                    end;
                end;
            }

            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("No.");
                RunPageView = where(Types = CONST(comment));
            }
            // action(" CRM Variation Appraisal Comments")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     PromotedIsBig = true;
            //     RunObject = Page "52187231Loan Appr. Comments";
            //     RunPageLink = "Loan No." = field("No.");
            // }
            // action("Send Back to CRM")
            // {
            //     ApplicationArea = all;
            //     Image = Return;
            //     Enabled = CRmEdit;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     trigger OnAction()
            //     var
            //         AppraisaComme: Record "Loan Appraisal Comments";
            //     begin
            //         AppraisaComme.Reset();
            //         AppraisaComme.SetRange("Loan No.", Rec."No.");
            //         AppraisaComme.SetRange(Commented, false);
            //         if not AppraisaComme.FindFirst() then
            //             Error('Comments Must have a value')
            //         else begin
            //             Rec.TestField(Status, Rec.Status::Open);
            //             if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
            //                 Rec."Sent Back to CRM" := true;
            //                 Rec.Status := Rec.Status::Open;
            //                 Rec.Modify;
            //                 Message('Comment has been sent back to CRM');
            //                 AppraisaComme.Reset();
            //                 AppraisaComme.SetRange("Loan No.", Rec."No.");
            //                 AppraisaComme.SetRange(Commented, false);
            //                 if AppraisaComme.FindFirst() then begin
            //                     repeat
            //                         AppraisaComme.Commented := true;
            //                         AppraisaComme.Modify();
            //                     until AppraisaComme.next = 0;
            //                 end;
            //                 CurrPage.Close();
            //             end;
            //         end;
            //     end;
            // }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //// //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(UpdateChanges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Changes';
                Enabled = true;
                Image = PostedPutAway;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    LoanProcess: Codeunit "Loans Process";
                    SavingsAccounts: Record "Savings Accounts";
                    SendSms: Codeunit SendSms;
                    SmsSource: Enum "SMS Source";
                    Memba: Record Members;
                    Loan: Record Loans;
                    Sav: Record "Savings Accounts";
                    VariationSmsToSend: Label 'Dear %1, a variation of %2 on your %3 account. Account Number: %4, has been effected successfully!';
                begin
                    Rec.TestField(posted, false);
                    Rec.TestField("Variation Type");
                    Rec.TestField(Rec.Status, Rec.Status::Approved);
                    if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
                        //LoanProcess.VariateAdviceLoan(Rec."No.");
                        Loan.Get(Rec."Account No");
                        Loan.Get(Rec."Account No");
                        Loan."Variated Amount" := rec."Amount On";
                        Loan."Variated By" := UserId;
                        Loan.Modify(false);
                        Memba.Get(Loan."Member No.");
                    end else begin
                        SavingsAccounts.get(Rec."Account No");
                        LoanProcess.VariationsAdviceShares(SavingsAccounts, Rec);
                        Sav.Get(Rec."Account No");
                        Memba.Get(Sav."Member No.");
                    end;

                    SendSms.SendSms(SmsSource::VARIATIONS, Memba."Phone No.", StrSubStNo(VariationSmsToSend, Memba."First Name", Rec."Amount On", Rec."Variation Type", Rec."Account No"),
                    Rec."No.", Rec."Account No", false, 250, false, 'CBS', '', 'CBS');
                    Rec.posted := true;
                    Rec."Posting Date" := Today;
                    Rec."Posting Time" := Time;
                    Rec.Modify();
                    Message('Variations Completed');
                    CurrPage.Close();
                end;
            }

            action("Run Generated Advice")
            {
                ApplicationArea = Basic, Suite;
                Image = Installments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoansProcess: Codeunit "Loans Process";
                begin
                    rec.TestField(posted, true);
                    LoansProcess.RunSpecificConsolidatedCheckOffAdviceReport(Rec."Member No.", Rec."Posting Date", Rec."No.");
                end;
            }
            action("Variation Appraisal Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "52187231Loan Appr. Comments";
                RunPageLink = "Loan No." = field("No.");
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category8;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;
            //             ApplicantMember: Record Members;
            //             Loan: Record Loans;

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
            //         PromotedCategory = Category8;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
        }

    }
    local procedure StatusCont()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            CRmEdit := true else
            CRmEdit := false;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    trigger OnOpenPage()
    begin
        rec."Variation Type" := Rec."Variation Type"::Savings;
        if Rec.Status <> Rec.Status::Open
        then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        StatusCont();
        if (Rec.Status <> Rec.Status::Open) or (Rec."Sent Back to CRM") then
            CurrPage.Editable := false;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Variation Type" := Rec."Variation Type"::Savings;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        StatusCont();
        if (Rec.Status <> Rec.Status::Open) or (Rec."Sent Back to CRM") then
            CurrPage.Editable := false;
    end;

    procedure UploadToEDMS(Rec: Record "Product Variations"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;
        Loan: Record Loans;

        IDNumber: Text;
        ApplicationType: Label 'PV'; // Product Variations
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

            if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
                Loan.Reset;
                Loan.SetRange("Loan No.", Rec."Account No");

                if Loan.FindFirst then begin
                    EDMSFunctions.EDMSLoanFileUpload(
                        IDNumber,
                        ApplicantMember.Name,
                        Loan."Loan Product Type Name",
                        PfNumber,
                        ApplicantMember."No.",
                        Rec."No.",
                        Rec."Account No",
                        FileName,
                        FileContentsB64,
                        false
                    );
                end;
            end;

            if Rec."Variation Type" = Rec."Variation Type"::Savings then begin
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
    end;


    var

        VarVariant: Variant;
        CRmEdit: Boolean;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";

        Productfactory: Record "Product Factory";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        Members: Record Members;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}