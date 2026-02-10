page 52185980 "SinkFund Notice"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Information,CRM Actions,EDMS';
    SourceTable = "SinkFund Report Information";
    SourceTableView = where("Claim Type" = filter(" " | "BBF - Dependant Claim" | "BBF - Principle Claim" | "BBF - Insurance Claim"));

    layout
    {
        area(content)
        {
            group(CRM)
            {
                Caption = 'CRM Information';
                field("CRM Application No."; Rec."CRM Application No.")
                {
                    Editable = false;
                }
                field("CRM Created By"; Rec."CRM Created By")
                {
                    Editable = false;
                }
                field("CRM Originating Branch"; Rec."CRM Originating Branch")
                {
                    Editable = false;
                }
                field("CRM Notes"; Rec."CRM Notes")
                {
                    Editable = false;
                    MultiLine = true;
                }
                field("Sent Back to CRM"; Rec."Sent Back to CRM")
                {
                    Editable = false;
                }
            }
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                FIELD("Claim Type"; Rec."Claim Type")
                {
                    ValuesAllowed = " ", "BBF - Dependant Claim", "BBF - Principle Claim", "BBF - Insurance Claim";
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Date of Death"; Rec."Date of Death")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibily Center"; Rec."Responsibily Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Claim Amout"; Rec."BBF Claim Amount")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
            group("Reported By")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Visible = ReportedByVisible;
                field("Reported By Name"; Rec."Reported By Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reported By ID No"; Rec."Reported By ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reported By Relationship"; Rec."Reported By Relationship")
                {
                    ApplicationArea = Basic, Suite;
                }
            }

            group("Balances & Liabilites")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Visible = BalancesVisible;
                field("Total Assets"; Rec."Total Savings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Liablities"; Rec."Total Loans")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Effects"; Rec."Net Effects")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Receipt Document Number"; Rec."Receipt Document Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Document Number field.';
                    LookupPageId = "Posted Receipt List";
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field("Total Amount Allocated"; Rec."Total Amount Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Allocated field.';
                }
                field("Available Beneficiary Amount"; Rec."Available Beneficiary Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Beneficiary Amount field.';
                }
            }
            part("BBF Claims Lines"; "BBF Claims Lines")
            {
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = Basic, Suite;
                Visible = LinesPageVisible;
                SubPageLink = "Header No." = FIELD(No);
            }
            part("NextofKin Payment Allocation"; "NextofKin Payment Allocation")
            {
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = Basic, Suite;
                Visible = LinesPageVisible;
                SubPageLink = "Header No." = FIELD(No);
            }
            group("Deceased Information")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Visible = DeceasedInformationVisible;
                field("Next of KIN"; Rec."Next of KIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NOK Name"; Rec."NOK Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }


    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        Rec.TestField("BBF Claim Amount");

                        Rec.PostClaim();

                        if Rec."Claim Type" = Rec."Claim Type"::"BBF - Dependant Claim" then begin
                            NextofKIN.Reset();
                            NextofKIN.SetRange("Record ID", Rec."Member No");
                            NextofKIN.SetRange(Identification, Rec."Next of KIN");
                            if NextofKIN.FindFirst() then begin
                                NextofKIN.Deceased := true;
                                NextofKIN.Modify();
                            end;
                        end;

                        if Rec."Claim Type" = Rec."Claim Type"::"BBF - Insurance Claim" then begin
                            NextofKIN.Reset();
                            NextofKIN.SetRange("Record ID", Rec."Member No");
                            NextofKIN.SetRange(Identification, Rec."Next of KIN");
                            if NextofKIN.FindFirst() then begin
                                NextofKIN."Insurance Claim Paid" := true;
                                NextofKIN.Modify();
                            end;
                        end;

                        Members.Get(Rec."Member No");
                        if (Rec."Claim Type" = Rec."Claim Type"::"BBF - Principle Claim") then begin
                            Members.Subflag := Members.Subflag::"Pending Risk Claim";
                            Members.Status := Members.Status::Deceased;
                            Members.Modify();
                        end;
                        if (Rec."Claim Type" = Rec."Claim Type"::"Risk Claim") then begin
                            Members.Subflag := Members.Subflag::"Pending Share Capital Transfer";
                            Members.Status := Members.Status::Deceased;
                            Members.Modify();
                        end;
                        Rec.Posted := true;
                        rec."Date Posted" := Today;
                        rec."Time Posted" := Time;
                        Rec.Modify(true);
                        if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then
                            Message('Risk Claim has been posted successfully')
                        else
                            Message('BBF Claim posted successfully');
                    end;

                }

                action("ReOpen Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ReOpen Document';
                    Image = ReOpen;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        MsgOnDoc: Label 'Document has been Opened. Please send approval request before you can continue.';
                    begin
                        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending) then error('Not available for status %1.', Rec.Status);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Document reopened Scuccessfully.');
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
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
                    begin
                        Rec.TestField("Claim Type");
                        Rec.TestField("Member No");
                        Rec.TestField("Sent Back to CRM", false);
                        Rec.TestField("Reported By ID No");
                        Rec.TestField(Posted, false);
                        Rec.TestField(Rec.Status, Rec.Status::Open);

                        Rec.TestField("BBF Claim Amount");
                        if (Rec."Claim Type" = Rec."Claim Type"::"BBF - Dependant Claim") or (Rec."Claim Type" = Rec."Claim Type"::"BBF - Insurance Claim") then begin
                            Rec.TestField("Next of KIN");
                            Rec.TestField("NOK Name");
                        end;
                        NextofKinPmtAlloc.Reset();
                        NextofKinPmtAlloc.SetRange("Header No.", Rec.No);
                        NextofKinPmtAlloc.SetFilter("Beneficiary Amount", '>0');
                        NextofKinPmtAlloc.SetFilter("Disbursement Account", '<>%1', '');
                        if NextofKinPmtAlloc.FindSet() then
                            repeat
                                NextofKinPmtAlloc.TestField("Beneficiary Amount");
                            until NextofKinPmtAlloc.Next = 0;
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
                    PromotedCategory = Category4;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    //     CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    // begin
                    //     Rec.TestField(Posted, false);
                    //     VarVariant := Rec;
                    //     CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    // end;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Posted, false);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;

                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }

            }
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
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(52185888),
                    "Document No." = FIELD("No. Series");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()

                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Approved);
                        if Rec.Status = Rec.Status::Approved then begin
                            if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify;
                            end;
                        end;
                    end;
                }
                action("Member Card")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Single";
                    RunPageLink = "No." = FIELD("Member No");
                }
                action("Print Claim")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        SinkFundRptInfo: Record "SinkFund Report Information";
                    begin
                        SinkFundRptInfo.Reset();
                        SinkFundRptInfo.SetRange(No, Rec.No);
                        if SinkFundRptInfo.FindFirst() then
                            REPORT.Run(Report::"Benevolent Claim Slip", true, true, SinkFundRptInfo);
                    end;
                }
            }
            action("Next of KINs")
            {
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "Next of KIN";
                RunPageLink = "Record ID" = FIELD("Member No");
            }
        }
        area(Creation)
        {
            group("CRM Integration")
            {
                action("CRM Comment")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category6;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No");
                    RunPageView = where(Types = CONST(comment));
                    // RunPageMode = Create;

                    Visible = IsNotSentBackToCRM;
                }
                action("Send Back to CRM")
                {
                    ApplicationArea = all;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category6;

                    Visible = IsNotSentBackToCRM;

                    trigger OnAction()
                    var
                        Comments: Record Comments;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        Comments.Reset;
                        Comments.SetRange("Header No.", Rec."No");
                        Comments.SetAscending("Entry No.", true);

                        if Comments.FindLast then begin
                            if (Comments."Commented By" <> UserId) then begin
                                Error('Comment is required before sending the application back to CRM');
                            end else begin
                                if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
                                    Rec."Sent Back to CRM" := true;
                                    Rec.Modify;

                                    Message('Comment has been sent back to CRM');

                                    CurrPage.Close();
                                end;
                            end;
                        end else begin
                            Error('Comment is required before sending the application back to CRM');
                        end;
                        ;
                    end;
                }
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category7;
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
                    begin
                        if Rec.No <> '' then begin
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
                    PromotedCategory = Category7;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No");
                    // RunPageMode = Create;
                }
            }

        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then
            Error('Status must be Open');
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Status <> Rec.Status::Open THEN
            CurrPage.EDITABLE := FALSE;
        SetControlAppearance;

        if Rec."Sent Back to CRM" then begin
            IsNotSentBackToCRM := false;
        end else begin
            IsNotSentBackToCRM := true;
        end;
    end;

    procedure UploadToEDMS(Rec: Record "SinkFund Report Information"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";
        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'BBF'; // BBF
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No");

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
                Rec."No",
                FileName,
                FileContentsB64
            );
        end;
    end;


    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;


        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDetailsEdit := true;
                    ApprovedEdit := true;
                end;

            Rec.Status::Approved:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Pending:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Rejected:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
        end;

        if Rec."Claim Type" in [Rec."Claim Type"::"BBF - Dependant Claim", Rec."Claim Type"::"BBF - Insurance Claim"] then begin
            DeceasedInformationVisible := true;
            ReportedByVisible := true;
            DateEditable := true;
            BalancesVisible := false;
            LinesPageVisible := false;
        end;
        if Rec."Claim Type" = Rec."Claim Type"::"BBF - Principle Claim" then begin
            DeceasedInformationVisible := false;
            ReportedByVisible := true;
            DateEditable := true;
            BalancesVisible := false;
            LinesPageVisible := false;
        end;
        if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
            DeceasedInformationVisible := false;
            ReportedByVisible := true;
            LinesPageVisible := true;
            DateEditable := false;
            BalancesVisible := true;
        end;
    end;

    var
        IsNotSentBackToCRM: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ReqDocs: Record "Loan Required Documents";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        BBFRequisationHeader: Record "BBF Requisation Header";
        BBFRequisationLines: Record "BBF Requisation Lines";
        JournlPosted: Codeunit "Journal Post Successful";
        CashOfficeSetup: Record "Cash Office Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        SendSms: Codeunit SendSms;
        PayLine: Record "SinkFund Report Information";
        NextofKIN: Record "Next of KIN";
        Err0001: Label 'Member does not have next of kin details';
        ImageData: Record "Image Data";
        BBFEntitlement: Record "BBF Entitlement";
        ApplicationDetailsEdit: Boolean;
        ApprovedEdit: Boolean;
        // SendSMSS: Codeunit SendSms;
        SourceTypes: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Rec.Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        CompanyInformation: Record "Company Information";
        Members: Record Members;
        SavingsAccount: Record "Savings Accounts";
        MyComment: Text;
        Source: Enum "SMS Source";
        DeceasedInformationVisible: Boolean;
        ReportedByVisible: Boolean;
        LinesPageVisible: Boolean;
        DateEditable: boolean;
        BalancesVisible: Boolean;
}

