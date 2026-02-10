page 52185750 "RTGS Transfer Header"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Workflows,Standing order,Slalary ,Category7_caption,Category8_caption,Approvals,Category9_caption';
    SourceTable = "RTGS Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ValuesAllowed = "Electronic Fund Transfer", RTGS;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TransactionTypeEdit;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccountTypeEdit;
                    ShowMandatory = true;
                    ValuesAllowed = "Bank Account";
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccountNoEdit;
                    ShowMandatory = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StartDateEdit;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EndDateEdit;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RemarkEdit;
                    ShowMandatory = true;
                }
                field("Record Total"; Rec."Record Total")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Record Count"; Rec."Record Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        getControl;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Transferred"; Rec."Date Transferred")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1; "RTGS Transfer Lines")
            {
                Editable = RTGSLineEdit;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Process RTGS")
            {
                Caption = 'Process RTGS';
                action("View Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Schedule';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                }
                action("Generete RTGS File")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generete Transfer File';
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        RTGSDetails: Record "RTGS Transfer Lines";
                    begin
                        Rec.TestField(Status, Rec.Status::Transferred);
                        if not Confirm(RTGSFileTxt) = true then exit;
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Transferred) then begin
                            RTGSDetails.Reset;
                            RTGSDetails.SetRange(RTGSDetails."Document No.", Rec."No.");
                            if RTGSDetails.Find('-') then begin
                                repeat
                                    RTGSDetails.TestField(RTGSDetails."Account Type");
                                    RTGSDetails.TestField(RTGSDetails.Amount);
                                    RTGSDetails.TestField(RTGSDetails."External Account No.");
                                    RTGSDetails.TestField(RTGSDetails."External Account Name");
                                    RTGSDetails.TestField(RTGSDetails."Bank Code");
                                    //RTGSDetails.TESTFIELD(RTGSDetails."Branch Code");

                                    //For STIMA, replace staff No with stima
                                    GeneralSetUp.Get;

                                    if RTGSDetails.Amount <> Round(RTGSDetails.Amount, 1) then begin
                                        if RTGSDetails.Amount <> Round(RTGSDetails.Amount, 0.1) then begin
                                            RTGSDetails.ExportFormat := DelChr(
                                                                     PadStr('', 14 - StrLen(RTGSDetails."External Account No."), ' ') + RTGSDetails."External Account No." +
                                                                     PadStr('', 5, ' ') +
                                                                     PadStr('', 6 - StrLen((RTGSDetails."Bank Code")), ' ') + (RTGSDetails."Bank Code") + ' ' +
                                                                     RTGSDetails."External Account Name" + PadStr('', 30 - StrLen(RTGSDetails."External Account Name"), ' ') +
                                                                     PadStr('', 9 - StrLen(DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                            DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',') +
                                                                     PadStr('', 8 - StrLen(CopyStr(GeneralSetUp.Reference, 1, 8)), ' ') + GeneralSetUp.Reference
                                                                     , '=', '"');
                                        end else begin
                                            RTGSDetails.ExportFormat := DelChr(
                                                                     PadStr('', 14 - StrLen(RTGSDetails."External Account No."), ' ') + RTGSDetails."External Account No." +
                                                                     PadStr('', 5, ' ') +
                                                                     PadStr('', 6 - StrLen((RTGSDetails."Bank Code")), ' ') + (RTGSDetails."Bank Code") + ' ' +
                                                                     RTGSDetails."External Account Name" + PadStr('', 30 - StrLen(RTGSDetails."External Account Name"), ' ') +
                                                                     PadStr('', 8 - StrLen(DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                            DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                     PadStr('', 8 - StrLen(CopyStr(GeneralSetUp.Reference, 1, 8)), ' ') + GeneralSetUp.Reference
                                                                     , '=', '"');
                                        end;
                                    end else begin
                                        TextGen := Format(RTGSDetails."Member No.");

                                        RTGSDetails.ExportFormat := DelChr(
                                                                 PadStr('', 14 - StrLen(RTGSDetails."External Account No."), ' ') + RTGSDetails."External Account No." +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen((RTGSDetails."Bank Code")), ' ') + (RTGSDetails."Bank Code") + ' ' +
                                                                 RTGSDetails."External Account Name" + PadStr('', 30 - StrLen(RTGSDetails."External Account Name"), ' ') +
                                                                 PadStr('', 7 - StrLen(DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(RTGSDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                                 PadStr('', 8 - StrLen(CopyStr(GeneralSetUp.Reference, 1, 8)), ' ') + GeneralSetUp.Reference
                                                                 , '=', '"');
                                    end;
                                    RTGSDetails.Modify;
                                until RTGSDetails.Next = 0;
                            end;

                        end;

                        Commit;

                        RTGSDetails.Reset;
                        RTGSDetails.SetRange(RTGSDetails."Document No.", Rec."No.");
                        if RTGSDetails.Find('-') then
                            XMLPORT.Run(52185620, true, false, RTGSDetails);

                        Message(SuccessfulGeneration);
                    end;
                }
                action("Generate Salary RTGS")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Rec.Status = Rec.Status::Transferred then
                            Error('RTGS Batch already transfered. Please use another one.');


                        Rec.TestField("Transaction Type");

                        RTGSHeader.Reset;
                        RTGSHeader.SetRange(RTGSHeader."No.", Rec."No.");
                        if RTGSHeader.Find('-') then
                            REPORT.Run(Report::"Get Salary RTGS", true, true, RTGSHeader)
                    end;
                }
                action("Generate Standing Order RTGS")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin

                        Rec.TestField("Transaction Type");

                        if Rec."Standing Order RTGS Done" = true then
                            Error('The get standing order RTGS process has already been run for this batch');

                        RTGSHeader.Reset;
                        RTGSHeader.SetRange(RTGSHeader."No.", Rec."No.");
                        if RTGSHeader.Find('-') then
                            REPORT.Run(Report::"Standing Order RTGS", true, true, RTGSHeader)
                    end;
                }
                action("Multiple Account Report")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        RTGSHeader.Reset;
                        RTGSHeader.SetRange(RTGSHeader."No.", Rec."No.");
                        if RTGSHeader.Find('-') then
                            REPORT.Run(Report::"Duplicate RTGS Transfer Lines", true, true, RTGSHeader)
                    end;
                }
                action("RTGS Report")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        RTGSHeader.Reset;
                        RTGSHeader.SetRange(RTGSHeader."No.", Rec."No.");
                        if RTGSHeader.Find('-') then
                            REPORT.Run(Report::"RTGS Report", true, true, RTGSHeader)
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = TransferVisible;

                    trigger OnAction()
                    var
                        GlEntries: Record "G/L Entry";
                        ElectronicFundsH: Record "RTGS Transfer Header";
                    begin

                        Rec.TestField(Status, Rec.Status::Approved);
                        GlEntries.Reset;
                        GlEntries.SetRange(GlEntries."Document No.", Rec."No.");
                        if GlEntries.FindFirst() then begin
                            Message('This transaction has already been posted.');
                            ElectronicFundsH.Status := ElectronicFundsH.Status::Transferred;
                            ElectronicFundsH."Date Transferred" := Today;
                            ElectronicFundsH."Time Transferred" := Time;
                            ElectronicFundsH."Transferred By" := UserId;
                            ElectronicFundsH.Modify;
                            Message('Transaction Posted Successfully');
                        end
                        else
                            RTGSProcessing.ElectronicFundsProcessing(Rec);
                    end;
                }
                action("Send SMS")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send SMS';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    //Visible = TransferVisible;

                    trigger OnAction()
                    var
                        GlEntries: Record "G/L Entry";
                        ElectronicFundsH: Record "RTGS Transfer Header";
                        SavingsACC: record "Savings Accounts";
                        MobileNo: code[50];
                        Member: record Members;
                        msg: text;
                        SendSMS: Codeunit SendSms;
                        source: enum "SMS Source";
                        Text002: label 'Your application for fund transfer has been effect by ';
                        Text003: label 'Follow up using Reference No. ';
                    begin
                        rec.TestField(rec.Status, rec.Status::Transferred);
                        ElectronicFundsL.Reset;
                        ElectronicFundsL.SetRange(ElectronicFundsL."Document No.", ElectronicFundsH."No.");
                        ElectronicFundsL.SetRange(ElectronicFundsL.Transferred, false);
                        if ElectronicFundsL.FindSet() then begin
                            repeat

                                case ElectronicFundsL."Account Type" of
                                    ElectronicFundsL."account type"::Savings:
                                        begin
                                            if SavingsACC.Get(ElectronicFundsL."Account No.") then
                                                if SavingsACC."Transactional Mobile No" <> '' then
                                                    MobileNo := SavingsACC."Transactional Mobile No"
                                                else begin
                                                    if Member.Get(SavingsACC."Member No.") then begin
                                                        MobileNo := Member."Phone No.";
                                                    end;
                                                end;

                                            msg := Text002 + COMPANYNAME + ', ' + 'of ' + format(ElectronicFundsL.Amount) + '. ' + Text003 + ElectronicFundsH."No.";
                                            SendSMS.SendSms(Source::EFT_EFFECTED, MobileNo, msg, Format(ElectronicFundsH."No."), '', true, 0, false, 'CBS', ElectronicFundsH."No.", 'CBS');
                                        end;
                                end;
                            until ElectronicFundsL.next() = 0;
                        end;
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
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        //  ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    //   ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        //   // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    //  ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        //  ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    PromotedCategory = Category4;
                    Visible = SendApprovalRequestVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        MemWithdrawal: record "Member withdrawal Notice";
                        SavAcc: record "Savings Accounts";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Document Type");
                        Rec.TestField("Account No.");
                        Rec.TestField(Remarks);

                        ElectronicFundsL.Reset;
                        ElectronicFundsL.SetRange(ElectronicFundsL."Document No.", Rec."No.");
                        if ElectronicFundsL.Find('-') then begin
                            repeat
                                ElectronicFundsL.TestField(ElectronicFundsL."Account No.");
                                ElectronicFundsL.TestField(ElectronicFundsL."Account Name");
                                ElectronicFundsL.TestField(ElectronicFundsL.Amount);
                                ElectronicFundsL.TestField(ElectronicFundsL."Bank Code");
                                //ElectronicFundsL.TESTFIELD(ElectronicFundsL."Branch Code");
                                ElectronicFundsL.TestField(ElectronicFundsL."Bank Name");

                                if MemWithdrawal.GetTransactionCharge(rec."Transaction Type", ElectronicFundsL.Amount) > SavAcc.GetAvailableBalance(ElectronicFundsL."Account No.") then
                                    Error('Insufficient funds in account %1 to cater of eft charges', ElectronicFundsL."Account No.");
                            until ElectronicFundsL.Next = 0;
                        end;



                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // Rec.Status := Rec.Status::Approved;
                        // Rec.Modify;
                        // Message('RTGS Approved');
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
                    Visible = CancelApprovalRequestVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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
                        approvalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        approvalsMgmt: Codeunit 1535;
                    begin
                        if Rec.Status = Rec.Status::Transferred then
                            Error('This has already been Transferred hence cannot be opened');

                        if not Confirm(ConfirmMSG) then
                            exit;
                        ApprovalsMgmt.DeleteApprovalEntries(rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                // action(Approves)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = ReOpen;
                //     Promoted = true;
                //     PromotedCategory = Category9;

                //     trigger OnAction()
                //     begin
                //         Rec.Status := Rec.Status::Approved;
                //         Rec.Modify;
                //     end;
                // }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        getControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
    end;

    var
        RTGSProcessing: Codeunit "Sacco Transactions";
        DocumentTypeEdit: Boolean;
        TransactionTypeEdit: Boolean;
        AccountTypeEdit: Boolean;
        AccountNoEdit: Boolean;
        StartDateEdit: Boolean;
        EndDateEdit: Boolean;
        RemarkEdit: Boolean;
        RTGSLineEdit: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        SendApprovalRequestVisible: Boolean;
        CancelApprovalRequestVisible: Boolean;
        GenerateStandingOrdtVisible: Boolean;
        TransferVisible: Boolean;
        SuccessfulGeneration: Label 'Successfully Generated';
        GeneralSetUp: Record "General Set-Up";
        TextGen: Text[250];
        RTGSHeader: Record "RTGS Transfer Header";
        RTGSFileTxt: Label 'are you sure you want to generate RTGS File ?';
        ConfirmMSG: Label 'are you sure you want to set status of this document to open?';
        ElectronicFundsL: Record "RTGS Transfer Lines";

    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
    //  ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure getControl()
    begin
        if Rec.Status = Rec.Status::Transferred then begin
            SendApprovalRequestVisible := false;
            CancelApprovalRequestVisible := false;
            GenerateStandingOrdtVisible := false;
            TransferVisible := false;
        end else begin
            SendApprovalRequestVisible := true;
            CancelApprovalRequestVisible := true;
            GenerateStandingOrdtVisible := false;
            TransferVisible := true;
        end;

        case Rec.Status of
            Rec.Status::Open:
                begin
                    DocumentTypeEdit := true;
                    TransactionTypeEdit := true;
                    AccountTypeEdit := true;
                    AccountNoEdit := true;
                    StartDateEdit := true;
                    EndDateEdit := true;
                    RemarkEdit := true;
                    RTGSLineEdit := true;
                end;

            Rec.Status::Pending, Rec.Status::Rejected, Rec.Status::Approved:
                begin
                    DocumentTypeEdit := false;
                    TransactionTypeEdit := false;
                    AccountTypeEdit := false;
                    AccountNoEdit := false;
                    StartDateEdit := false;
                    EndDateEdit := false;
                    RemarkEdit := false;
                    RTGSLineEdit := false;
                end;
        end;
    end;
}

