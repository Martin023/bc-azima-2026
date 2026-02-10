page 52186328 "Delegates Payment Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegates Payment";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Check Budgetary Availability,EDMS';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralEditable;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minute No."; Rec."Minute No.")
                {
                    Caption = 'Meeting No.';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Total Payment"; Rec."Total Payment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
            }
            part(Control25; "Delegates Payment Line List")
            {
                Editable = GeneralEditable;
                ApplicationArea = Basic, Suite;
                // Editable = PageEditable;
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = rec.Status = rec.Status::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField("Minute No.");
                        Rec.CalcFields("Total Payment");
                        Rec.TestField("Total Payment");

                        // Commitments.Reset;
                        // Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Delegate Payment");
                        // Commitments.SetRange(Commitments."Document No.", Rec.Code);
                        // if not Commitments.Find('-') then error('Kindly Check Budgetary Availability before sending for approval');

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Approval Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(code);
                    RunPageView = where(Types = CONST(comment));
                }
                action(Refresh)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    begin
                        rec.Validate(Status);
                        CurrPage.Update();
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
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExist;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
            }

            // action("Check Budgetary Availability")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Check Budgetary Availability';
            //     Image = Balance;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     var
            //         BCSetup: Record "Budgetary Control Setup";
            //     begin
            //         if not (Rec.Status = Rec.Status::Open) then begin
            //             Error('Document must be Open');
            //         end;

            //         BCSetup.Get;
            //         if not BCSetup.Mandatory then begin
            //             if Confirm('Budgetary Control is not Mandatory, Do you wish to continue checking for Budget?', false) = false then exit;
            //         end;

            //         // if not AllFieldsEntered then
            //         //     Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
            //         //First Check whether other lines are already committed.
            //         Commitments.Reset;
            //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Delegate Payment");
            //         Commitments.SetRange(Commitments."Document No.", Rec.Code);
            //         if Commitments.Find('-') then begin
            //             if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
            //             Commitments.Reset;
            //             Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Delegate Payment");
            //             Commitments.SetRange(Commitments."Document No.", Rec.Code);
            //             Commitments.DeleteAll;
            //         end;
            //         CheckBudgetAvail.CheckDelegatePayments(Rec);
            //     end;
            // }
            // action("Cancel Budget Commitment")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Cancel Budget Commitment';
            //     Image = CancelAllLines;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     begin
            //         if not (Rec.Status = Rec.Status::Pending) then begin
            //             Error('Document must be Pending/Open');
            //         end;

            //         if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

            //         Commitments.Reset;
            //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Delegate Payment");
            //         Commitments.SetRange(Commitments."Document No.", Rec.Code);
            //         Commitments.DeleteAll;

            //         PayLine.Reset;
            //         PayLine.SetRange(PayLine.No, Rec.code);
            //         if PayLine.Find('-') then begin
            //             repeat
            //                 PayLine.Committed := false;
            //                 PayLine.Modify;
            //             until PayLine.Next = 0;
            //         end;
            //         Message('Commitment Entries Cancelled Successfully');
            //     end;
            // }
            group(Approval)
            {
                Caption = 'Approval';
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Posted, false);
                        if not Confirm('Are you sure you want to reopen this document?') then
                            exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                // action(Comment)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Approval Comments";
                //     RunPageLink = "Table ID" = CONST(52185888),
                //     "Document No." = FIELD("No. Series");
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                // }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Minutes: Record "Delegates Minutes Header";
                        BankLed: record "G/L Entry";
                    begin

                        Rec.TestField(Posted, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        if not Confirm('Are you sure you want to post this transaction?') then exit;
                        //SaccoTransactions
                        BankLed.Reset;
                        BankLed.SetRange("Document No.", Rec.code);
                        //BankLed.SetRange(BankLed."Posting Date", Rec.o);
                        if BankLed.Find('-') then begin
                            // Rec.Posted := true;
                            // Rec."Posted By" := UserId;
                            // Rec."Date Posted" := Today;
                            // Rec.Modify;
                            // if Minutes.Get(Rec."Minute No.") then begin
                            //     Minutes."Meeting Paid" := true;  
                            //     Minutes.Modify();
                            // end;
                            // Message('Transaction Posted succesfully');
                            // exit;
                        end;

                        PostPayment();

                        if Minutes.Get(Rec."Minute No.") then begin
                            Minutes."Meeting Paid" := true;
                            Minutes.Modify();
                        end;

                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Date Posted" := Today;
                        Rec.Modify;
                        Message('Posted Successfully');

                    end;
                }
                action("Payment Slip")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Minute No.");
                        DelegatePaymentLines.Reset();
                        DelegatePaymentLines.SetRange(Code, Rec.Code);
                        if not DelegatePaymentLines.Find('-') then error('No Payment Lines Exists for this payment, Please regenerate lines');

                        DelegateMinutes.Reset;
                        DelegateMinutes.SetRange(Code, Rec."Minute No.");
                        if DelegateMinutes.Find('-') then
                            REPORT.Run(Report::"Delegates Payment Voucher", true, true, DelegateMinutes);
                    end;

                    // trigger OnAction()
                    // begin
                    //     DelegatePayments.Reset;
                    //     DelegatePayments.SetRange(DelegatePayments.Code, Rec.Code);
                    //     if DelegatePayments.FindFirst() then
                    //     begin
                    //         REPORT.Run(Report::"Delegates Payment Voucher", true, false, DelegatePayments);
                    //     end;    
                    // end;
                    // trigger OnAction()
                    // var
                    //     myInt: Integer;
                    // begin
                    //     DelegatePayments.Reset();
                    //     DelegatePayments.SetRange(Code, DelegatePaymentLines.Code);
                    //     IF DelegatePayments.find('-') then begin
                    //         REPORT.Run(Report::"Delegates Payment Voucher", true, false, DelegatePayments);
                    //     end;
                    // end;
                }
                action(RegenerateEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Regenerate Entries';

                    trigger OnAction()
                    begin
                        Rec.TestField("Minute No.");
                        Rec.GenerateDelegatePaymentLines(rec.Code, rec."Minute No.");
                    end;
                }
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category6;
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
            //             if Rec.Code <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
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
            //         PromotedCategory = Category6;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field(Code);
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }

    local procedure PostPayment()
    var
        MinutesHeader: Record "Delegates Minutes Header";
        MeetingAttendees: Record "Delegates Meeting Attendees";
        PaymentLine: Record "Delegate Payment Line";
        MeetingTypes: Record "Meeting Types";
        Allowances: Record "Allowed Allowances";
        TransactionCharges: Record "Transaction Charges";
        WithHoldingTax: Decimal;
        GlobalFunctions: Codeunit "Global Functions";
        ChargeAmount: Decimal;
        ChargeGL: Code[50];
        ExciseDuty: Decimal;
        ExciseGL: Code[50];
        DocNo: Code[50];
        PDate: Date;
        AccountType: Enum "Gen. Journal Account Type";
        Description: Text[500];
        BalAccountType: Enum "Gen. Journal Account Type";
        TransAmt: Decimal;
        ExtDoc: Code[50];
        LoanNo: Code[50];
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        FOSAAccnt: Code[50];
        GenSetup: Record "General Set-Up";
        DelegateWTAX: record "Deleg. Payment Withholding Tax";
        EntryNo: Integer;
    begin
        Temp.Get(UserId);
        Jtemplate := Temp."Delegates Pay.Journal Template";
        JBatch := Temp."Delegates Pay. Journal Batch";
        ExciseGL := GenSetup."Excise Duty G/L";

        GenSetup.Get();
        if Jtemplate = '' then begin
            Error(Text0001);
        end;

        if JBatch = '' then begin
            Error(Text0002);
        end;

        SaccoTransactions.InitJournal(Jtemplate, JBatch);
        DocNo := Rec.Code;
        PDate := Today;

        MinutesHeader.Get(Rec."Minute No.");

        DelegatePaymentLine.Reset();
        DelegatePaymentLine.SetRange(Code, Rec.Code);
        if DelegatePaymentLine.Find('-') then begin
            DelegateWTAX.reset;
            if DelegateWTAX.FindLast() then
                EntryNo := DelegateWTAX.No + 1
            else
                EntryNo := 1;

            repeat
                FOSAAccnt := '';
                Dim1 := '';
                Dim2 := '';
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", DelegatePaymentLine."Delegate MNO.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                if SavingsAccounts.FindFirst() then begin
                    FOSAAccnt := SavingsAccounts."No.";
                    Dim1 := SavingsAccounts."Global Dimension 1 Code";
                    Dim2 := SavingsAccounts."Global Dimension 2 Code";
                end;

                Allowances.Reset();
                Allowances.SetRange("Allowance Code", DelegatePaymentLine."Allowance Code");
                if Allowances.Findfirst() then begin
                    Allowances.CalcFields("Charge Code", Description, "G/L Account");
                    TransAmt := 0;
                    TransAmt := DelegatePaymentLine.Amount;
                    //Description := Rec.Code + ' MNO.: ' + MeetingAttendees."Delegate No." + ' ' + Allowances.Description + format(rec."Minute No.");
                    Description := Rec."Payment Narration";

                    SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    Allowances."G/L Account", -TransAmt, DocNo, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    ChargeGL := DelegatePaymentLine."Withholding G\L Acc";
                    TransAmt := 0;
                    TransAmt := DelegatePaymentLine."Withholding Tax";
                    //Description := Rec.Code + ' MNO.: ' + MeetingAttendees."Delegate No." + ' ' + ' Withholding Tax';
                    Description := Rec."Payment Narration" + ' Withholding Tax';

                    SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    ChargeGL, TransAmt, DocNo, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                    TransAmt := 0;
                    TransAmt := DelegatePaymentLine."Excise Duty";
                    //Description := Rec.Code + ' MNO.: ' + MeetingAttendees."Delegate No." + ' ' + TransactionCharges.Description + '-Excise Duty';
                    Description := Rec."Payment Narration" + '-Excise Duty';

                    SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    ExciseGL, TransAmt, DocNo, LoanNo, TransType::" ", Dim1, Dim2, SystemCreated);

                end;
            until DelegatePaymentLine.Next() = 0;
            SaccoTransactions.PostJournal(Jtemplate, JBatch);
        end;
        // withholding logs
        DelegatePaymentLine.Reset();
        DelegatePaymentLine.SetRange(Code, Rec.Code);
        if DelegatePaymentLine.Find('-') then begin
            repeat
                if DelegatePaymentLine."Withholding Tax" > 0 then begin

                    DelegateWTAX.init;
                    DelegateWTAX.No := EntryNo;
                    DelegateWTAX."Payment No" := DelegatePaymentLine.Code;
                    DelegateWTAX."Member No" := DelegatePaymentLine."Delegate MNO.";
                    DelegateWTAX.Validate("Member No");
                    DelegateWTAX."Total Payment" := DelegatePaymentLine.Amount;
                    DelegateWTAX."Withholding Tax Amount" := DelegatePaymentLine."Withholding Tax";
                    DelegateWTAX."Withholding Tax Acc." := DelegatePaymentLine."Withholding G\L Acc";
                    DelegateWTAX."Date paid" := Rec."Date Posted";
                    DelegateWTAX."User ID" := UserId;
                    DelegateWTAX.Insert;
                    EntryNo += 1;
                end;
            until DelegatePaymentLine.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    var
        DPay: Record "Delegates Payment";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        HasLines: Boolean;
        PageEditable: Boolean;
        DelegateMembersRetirementss: Record "Delegate Members Retirementss";
        DelegateMemberss: Record "Delegate Members";
        SaccoTransactions: Codeunit "Sacco Transactions";
        Temp: Record "Banking User Template";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DelegatePaymentLine: Record "Delegate Payment Line";
        DelegatePaymentLines: Record "Delegate Payment Line";
        DActivity: Code[20];
        Tillno: Code[20];
        CmemberNo: Code[20];
        Excess: Code[20];
        Shortage: Code[20];
        Text0001: Label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        GenSetup: Record "General Set-Up";
        Acc: Record "Savings Accounts";
        DelegatesTariff: Record "Delegates Tariff";
        BankSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Factory";
        ProdType: Record "Product Factory";
        TransType: Record "Transaction Types";
        Employer: Record Customer;
        AccountNo: Code[20];
        Members: Record Members;
        JournalPosting: Codeunit "Journal Posting";
        AcctNo: Code[20];
        AccNo: Code[20];
        AccType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        Descr: Text;
        TransTypes: Enum "Transaction Types";
        Loans: Record Loans;
        Interest: Decimal;
        Principle: Decimal;
        RunBal: Decimal;
        Err0001: Label 'Amount must be equal to Total pay';
        Dim1: Code[20];
        Dim2: Code[20];
        DelegatesMinutesHeader: Record "Delegates Minutes Header";
        CompInfo: Record "Company Information";
        SendSms: Codeunit SendSms;
        SavingsAccounts: Record "Savings Accounts";
        Source: Enum "SMS Source";
        msg: Text;
        GeneralEditable: Boolean;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        PayLine: Record "Payment Line";
        DelegateMinutes: Record "Delegates Minutes Header";
        DelegatePayments: Record "Delegates Payment";

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Delegate Members Retirementss";
    begin
        HasLines := false;
        DelegatePaymentLine.Reset;
        DelegatePaymentLine.SetRange(DelegatePaymentLine.Code, Rec.Code);
        if DelegatePaymentLine.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure UpdateControls()
    var
        DelegatePaymentLine: Record "Delegate Payment Line";
    begin
        GeneralEditable := true;
        if (Rec.Status <> Rec.Status::Open) then
            GeneralEditable := false;

        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin
            Rec."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            if Rec."Global Dimension 1 Code" = '' then Error('Please set up Global Dimension 1 Code in user setup');
            if Rec."Global Dimension 2 Code" = '' then Error('Please set up Global Dimension 2 Code in user setup');
        end else
            Error('You are not set up in user setup');
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


}

