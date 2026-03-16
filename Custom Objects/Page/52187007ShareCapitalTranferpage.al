page 52187007 "Share Capital Transfer Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Share Capital Transfer Buffer";
    //SourceTableView = where(Transfered = const(false));
    Caption = 'Share Capital Transfer';
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,reports,Approvals,Transfer Shares,Reject Transfer,CRM Actions,EDMS';
    layout
    {
        area(Content)
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
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Account No"; Rec."Source Account No")
                {
                    ApplicationArea = All;
                }
                // field("Transaction Type"; Rec."Transaction Type")
                // {
                //     ApplicationArea = all;
                // }
                field("Source Member No"; Rec."Source Member No")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                // field("Reference No"; Rec."Reference No")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Doc Reference No';
                // }
                // field("Receipt Amount"; Rec."Receipt Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Document Description';
                    Visible = false;
                }
                field("Source Member Name"; Rec."Source Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Source Balance"; Rec."Source Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount to transfer"; Rec."Amount to transfer")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }

                field("Dimension Code1"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Dimension Code2"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {
                //     Editable = false;
                // }
            }
            part(Transferlins; "Share capital Transfer Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("Document No");
                Editable = ShareLine;
            }


        }
    }

    actions
    {
        area(Processing)
        {

            // action("Assign Digit Custodian")
            // {
            //     ApplicationArea = all;
            //     Image = OrderTracking;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     trigger OnAction()
            //     var
            //         GlobalFunctions: Codeunit "Global Functions";
            //     begin
            //         if Rec."Source Member No" = '' then Error('Kindly fill the member number');
            //         GlobalFunctions.AssignDigitCustodianTask(Rec."Document No", Rec."Source Member No", "Sub Module"::"Share Capital Transfer");
            //         CurrPage.Update();
            //         Message('Digit custodian asigned successfullygit ');
            //     end;
            // }
            // action(AssinedUser)
            // {
            //     ApplicationArea = all;
            //     Image = Task;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "User Tasks";
            //     RunPageLink = "Record ID" = FIELD("Document No");
            //     Caption = 'User Assigned';
            // }
            action("Send Approval")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                //Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = SendAppEdi;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                    Sharelines: Record "Share Capital Transfer Lines";
                    AppraisaComme: Record "Loan Appraisal Comments";
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Transfered, false);
                    rec.TestField(Status, Rec.Status::Open);
                    // AppraisaComme.Reset();
                    // AppraisaComme.SetRange("Loan No.", Rec."Document No");
                    // AppraisaComme.SetRange(Commented, false);
                    // if AppraisaComme.FindFirst() then begin
                    //     repeat
                    //         AppraisaComme.Commented := true;
                    //         AppraisaComme.Modify();
                    //     until AppraisaComme.next = 0;
                    // end;
                    Sharelines.Reset();
                    Sharelines.SetRange(Sharelines."Document No.", Rec."Document No");
                    if Sharelines.FindFirst() then begin
                        Sharelines.CalcSums("Allocation Amount");
                        if Sharelines."Allocation Amount" <= 0 then
                            Error('Allocation amount must have a value');
                        if Sharelines."Allocation Amount" <> Rec."Amount to transfer" then begin
                            Error('Allocation amount to transfer is not equal to amount available to be transfered');
                        end;
                    end;
                    if Confirm('Do You want to send this document for approval?') = false then
                        exit;
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                //Enabled = NOT OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = CancelApp;
                trigger OnAction()
                var
                    myInt: Integer;
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    varvariant: Variant;
                begin
                    Rec.TestField(Transfered, false);
                    if Confirm('Do you want to cancel this approval?') = true then begin
                        varvariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(varvariant);
                    end;

                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                Enabled = RejectM;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(ReOpen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re Open';
                Promoted = true;
                PromotedCategory = Category4;
                Image = OpenWorksheet;

                trigger OnAction()
                var

                begin
                    if not confirm('Are you sure you want to reopen this document?') then exit;
                    if rec.posted then Error('This document is already processed!');
                    Rec."Approved By" := '';
                    Rec.Status := Rec.Status::Open;
                    rec.modify(true);
                    Message('The document have been opened successfully.');
                end;
            }

            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Document Comments';
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Document No");
                RunPageView = where(Types = CONST(comment));
            }
            // action("Transfer Comments")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     PromotedIsBig = true;
            //     RunObject = Page "52187231Loan Appr. Comments";
            //     RunPageLink = "Loan No." = field("Document No");
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
            //         Rec.TestField(Status, Rec.Status::Open);

            //         AppraisaComme.Reset();
            //         AppraisaComme.SetRange("Loan No.", Rec."Document No");
            //         AppraisaComme.SetRange(Commented, false);
            //         if not AppraisaComme.FindFirst() then
            //             Error('Comments Must have a value')
            //         else
            //             if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
            //                 Rec."Sent Back to CRM" := true;
            //                 Rec.Modify;
            //                 Message('Document has been sent back to CRM');
            //                 AppraisaComme.Reset();
            //                 AppraisaComme.SetRange("Loan No.", Rec."Document No");
            //                 AppraisaComme.SetRange(Commented, false);
            //                 if AppraisaComme.FindFirst() then begin
            //                     repeat
            //                         AppraisaComme.Commented := true;
            //                         AppraisaComme.Modify();
            //                     until AppraisaComme.next = 0;
            //                 end;
            //             end;
            //         CurrPage.Close();
            //     end;
            // }
            action("Transfer Shares")
            {
                Caption = ' Post Transfer';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = Document;
                Enabled = PostPor;
                trigger OnAction()
                var
                    myInt: Integer;
                    Loans: Record Loans;
                    Seriesset: Record "Credit Nos. Series";
                    TakeNos: Code[20];
                    LoanProcess: Codeunit "Loans Process";
                    Transfer: Boolean;
                    Members: Record Members;
                    GLEntry: Record "G/L Entry";
                    SavAcc: record "Savings Accounts";
                begin
                    rec.TestField(Posted, false);
                    GLEntry.Reset;
                    GLEntry.SetRange("Document No.", rec."Document No");
                    GLEntry.SetLoadFields("Entry No.");
                    if GLEntry.FindFirst then begin
                        Rec.Transfered := true;
                        Rec.Posted := true;
                        Rec."Posting Date" := Today;
                        Rec."Posting Time" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                    end;

                    Transfer := true;
                    rec.TestField("Document No");
                    rec.TestField(status, rec.Status::Approved);
                    Rec.TestField(Transfered, false);
                    if not confirm('Do You want to transfer this share capital?') then
                        exit;
                    LoanProcess.PostTransferShares(Rec."Document No");
                    Transfer := true;
                    if Transfer = true then begin
                        Rec.Transfered := true;
                        Rec.Posted := true;
                        Rec."Posting Date" := Today;
                        Rec."Posting Time" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                    end;

                    if Members.Get(Rec."Source Member No") then begin
                        // if Members.Subflag = Members.Subflag::"Pending Share Capital Transfer" then begin
                        //Members.Subflag := Members.Subflag::Closed;
                        Members.validate(Subflag, Members.Subflag::Closed);
                        Members.Modify();

                        SavAcc.reset();
                        SavAcc.SetRange("Member No.", rec."Source Member No");
                        SavAcc.SetFilter("Product Type", '<>ODS');
                        SavAcc.ModifyAll(Status, SavAcc.Status::Closed);
                        // end
                        // else
                        //     Message('The member has not yet claimed insurance');
                    end
                    else
                        error('Member was not found in Members table');
                    AppraisaComme.Reset();
                    AppraisaComme.SetRange("Loan No.", Rec."Document No");
                    AppraisaComme.SetRange(Commented, false);
                    if AppraisaComme.FindFirst() then begin
                        repeat
                            AppraisaComme.Commented := true;
                            AppraisaComme.Modify();
                        until AppraisaComme.next = 0;
                    end;
                    Message('Shares Transferred Successfully');
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Share Capital Transfer';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = RejectM;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    AppraisaComme.Reset();
                    AppraisaComme.SetRange("Loan No.", Rec."Document No");
                    AppraisaComme.SetRange(Commented, false);
                    if not AppraisaComme.FindFirst() then
                        Error('Comments Must have a value');
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    AppraisaComme.Reset();
                    AppraisaComme.SetRange("Loan No.", Rec."Document No");
                    AppraisaComme.SetRange(Commented, false);
                    if AppraisaComme.FindFirst() then begin
                        repeat
                            AppraisaComme.Commented := true;
                            AppraisaComme.Modify();
                        until AppraisaComme.next = 0;
                    end;
                end;
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

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;
            //         begin
            //             if Rec."Document No" <> '' then begin
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
            //         RunPageLink = "Application No." = field("Document No");
            //         // RunPageMode = Create;
            //     }
            // }

        }


    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            CRmEdit := true else
            CRmEdit := false;
        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    PageEdi := true;
                    EdRej := false;
                    PostPor := false;
                    ShareLine := true;

                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := false;
                    PostPor := true;
                    ShareLine := false;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := true;
                    PostPor := false;
                    ShareLine := false;
                end;
        end;
        if Rec.Transfered = true then begin
            PostPor := false;
            CurrPage.Editable := false;
        end;


        //DigitCustodianControl();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            CRmEdit := true else
            CRmEdit := false;
        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    PageEdi := true;
                    EdRej := false;
                    PostPor := false;
                    ShareLine := true;

                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := false;
                    PostPor := true;
                    ShareLine := false;
                end;
            rec.Status::Pending:
                begin
                    //CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := true;
                    PostPor := false;
                    ShareLine := false;
                end;
        end;
        if Rec.Transfered = true then
            PostPor := false;

        //DigitCustodianControl();
        MinShareTransNot;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            CRmEdit := true else
            CRmEdit := false;
        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    PageEdi := true;
                    EdRej := false;
                    PostPor := false;
                    ShareLine := true;


                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    PageEdi := false;
                    PostPor := true;
                    EdRej := false;
                    ShareLine := false;
                end;
            rec.Status::Pending:
                begin
                    // CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    PostPor := false;
                    EdRej := true;
                    PageEdi := false;
                    ShareLine := false;

                end;
        end;
        if Rec.Transfered = true then
            PostPor := false;

        //DigitCustodianControl();

    end;

    // procedure DigitCustodianControl()
    // begin
    //     Rec.CalcFields("Responsible Officer");
    //     if UserId <> Rec."Responsible Officer" then
    //         CurrPage.Editable := false
    //     else
    //         CurrPage.Editable := true;
    // end;

    procedure MinShareTransNot()
    begin
        if rec."Source Balance" < 30000 then
            Message('Minimum share transfer amount should be 30000');
    end;

    procedure UploadToEDMS(Rec: Record "Share Capital Transfer Buffer"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'ST'; // Share Transfer
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Source Member No");

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
                    Rec."Document No",
                    FileName,
                    FileContentsB64
                );
        end;
    end;

    var
        SendAppEdi: Boolean;
        CancelApp: Boolean;
        ProcessMo: Boolean;
        RejectM: Boolean;
        PageEdi: Boolean;
        EdRej: Boolean;
        PostPor: Boolean;
        CRmEdit: Boolean;
        ShareLine: Boolean;
        AppraisaComme: Record "Loan Appraisal Comments";

}