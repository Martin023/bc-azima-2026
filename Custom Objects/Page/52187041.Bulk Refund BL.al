page 52187041 "Bulk Refunds Card BL"
{
    ApplicationArea = All;
    Caption = 'Bulk Refunds Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Import,Post';
    SourceTable = "Refund,Account Transfer Header";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.';
                    Editable = false;
                }

                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description.';
                }
                field("Posting date"; Rec."Posting date")
                {
                    ToolTip = 'Specifies the value of the Posting date field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                    Visible = false;
                }

                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Caption = 'Scheduled Amount';
                    ToolTip = 'Specifies the value of the Scheduled Amount field.';
                }

                field(Validated; Rec.Validated)
                {
                    ToolTip = 'Specifies the value of the Validated field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { Editable = false; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { Editable = false; }
                field("Responsibility Center"; Rec."Responsibility Center") { Editable = false; }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                    Editable = false;
                }
            }
            part(Control17; "Bulk Account Transfers BL")
            {
                SubPageLink = "Refund Header No." = FIELD(No);
                ApplicationArea = Basic;
            }
        }

    }
    actions
    {
        area(creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Description);
                    Rec.TestField("Posting date");
                    Rec.CalcFields("Total Count", Rec."Scheduled Amount", Rec.Amount);
                    ValidateAccounts;

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                    CurrPage.Close();
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("XML IMPORT")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                caption = 'Import';
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = xmlport "Inter Account";
                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    if Rec.Status <> Rec.Status::Open then
                        Error('Status must be open.');
                END;

            }
            action("Post")
            {
                ApplicationArea = basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    BulkRefundPost(true);
                end;

            }
            action("Reset Transaction Date")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                var
                    trans: Record "Refund,Account Transfer Header";
                begin

                    Trans.Reset;
                    Trans.SetRange(Trans.Posted, false);
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        Rec."Date Entered" := Today;
                        Rec.Modify;

                        Message('Transaction date updated');

                    end else
                        Error('Transaction already posted');
                end;
            }

            action("Post Preview")
            {
                ApplicationArea = basic, Suite;
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Category6;
                Visible = false;
                trigger OnAction()
                begin
                    BulkRefundPost(false);
                end;
            }

            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                        Rec.TestField(Posted, false);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        CurrPage.Close();
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
                RunPageLink = "Header No." = field(No);
                RunPageView = where(Types = CONST(comment));
            }




        }

    }
    trigger OnOpenPage()
    begin
        editCard := true;
        if (rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            CurrPage.Editable := False;
            editCard := false;
        end else
            CurrPage.Editable := true;
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
    end;

    trigger OnAfterGetRecord()

    begin

        editCard := true;
        if (rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            CurrPage.Editable := False;
            editCard := false;
        end else
            CurrPage.Editable := true;
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Upload Option" := Rec."Upload Option"::"Single Line";
        Rec."Originating Unit" := Rec."Originating Unit"::"Business Loans";
        Rec."Refund Type" := Rec."Refund Type"::Refund;
    end;

    local procedure BulkRefundPost(PostTransaction: Boolean)
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        Pfact: Record "Product Factory";
        DailyLoansInterestBuffer: Record "Loans Interest Buffer";
        LoansProcess: Codeunit "Loans Process";
    begin
        Rec.TestField(Posted, false);
        if Rec."Originating Unit" = Rec."Originating Unit"::General then begin
            if Rec.Status <> Rec.Status::Approved then
                Error('Status must be approved before posting');
        end;
        Temp.Get(UserId);

        JTemplate := Temp."Transfer Journal Template";
        JBatch := Temp."Transfer Journal Batch";

        if JTemplate = '' then begin
            Error('Ensure the Transfer Journal Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Transfer Journal Batch is set up in Banking  User Setup')
        end;

        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := '';

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";

        DocNo := Rec.No;
        PDate := Rec."Posting date";

        LoanNo := '';
        TransType := Transtype::" ";

        SystCreated := true;

        if rec.Posted = true then begin
            Error(Text0001);
        end;

        SaccoT.InitJournal(JTemplate, JBatch);
        RunBal := 0;
        TransAmt := RefundLines.Amount;

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        if RefundLines.Find('-') then begin
            repeat
                //Debit Account
                RunBal := RefundLines.Amount;
                TransAmt := 0;
                TransAmt := RefundLines.Amount;
                AccNo := RefundLines."Source Account";
                Dim1 := RefundLines."Global Dimension 1 Code";
                Dim2 := RefundLines."Global Dimension 2 Code";
                // BalAccNo := RefundLines.AccNo;
                ExtDoc := RefundLines."Document No.";
                //if RefundLines.Description = '' then RefundLines.Description := Rec.Description;
                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines."Source Description", 1, 50), Balacctype::"G/L Account",
                '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

                //Credit Accounts
                if savingsAaacounts.get(RefundLines."Destination Account") then begin
                    TransAmt := 0;
                    TransAmt := RefundLines.Amount * -1;
                    AccNo := RefundLines."Destination Account";
                    Dim1 := RefundLines."Global Dimension 1 Code";
                    Dim2 := RefundLines."Global Dimension 2 Code";
                    // BalAccNo := RefundLines.AccNo;
                    ExtDoc := RefundLines."Document No.";
                    //if RefundLines."Destination Description" = '' then RefundLines."Destination Description" := Rec."Destination Description";

                    SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines."Destination Description", 1, 50), Balacctype::"G/L Account",
                    '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                end;
                //Credit Loans
                if MyLoans.get(RefundLines."Loan No.") then begin
                    MyLoans.CalcFields(MyLoans."Outstanding Balance", MyLoans."Outstanding Interest", "Daily Interest");

                    if PeriodicActivities.AmountClearsLoanIfPosted(MyLoans."Loan No.", RefundLines.Amount) then begin
                        if MyLoans."Daily Interest" > 0 then begin
                            If MyLoans."Outstanding Interest" < 0 then
                                MyLoans."Outstanding Interest" := 0;
                            // Accrue Interest;

                            TransAmt := MyLoans."Daily Interest";
                            Pfact.Get(MyLoans."Loan Product Type");
                            Pfact.TestField("Loan Interest Account [G/L]");
                            AcctType := Accttype::Credit;
                            TransType := Transtype::"Interest Due";
                            LineNo := LineNo + 10000;
                            AccNo := MyLoans."Loan Account";
                            BalAccType := BalAccType::"G/L Account";
                            BalAccNo := Pfact."Loan Interest Account [G/L]";

                            SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines."Source Description", 1, 50), Balacctype::"G/L Account",
                        BalAccNo, TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystCreated);

                            MyLoans."Outstanding Interest" += TransAmt;

                            if PostTransaction then
                                LoansProcess.ClearDailyInterest(Loans."Loan No.");

                        end;
                    end;

                    if MyLoans."Outstanding Interest" > 0 then begin
                        if RefundLines.Amount < MyLoans."Outstanding Interest" then
                            MyLoans."Outstanding Interest" := RefundLines.Amount;
                        TransAmt := 0;
                        TransAmt := MyLoans."Outstanding Interest" * -1;
                        AccNo := MyLoans."Loan Account";
                        Dim1 := RefundLines."Global Dimension 1 Code";
                        Dim2 := RefundLines."Global Dimension 2 Code";
                        // BalAccNo := RefundLines.AccNo;
                        ExtDoc := RefundLines."Document No.";
                        //if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                        SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines."Destination Description", 1, 50), Balacctype::"G/L Account",
                        '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystCreated);
                        RunBal += TransAmt;
                    end;
                    if RunBal > 0 then begin
                        TransAmt := 0;
                        TransAmt := RunBal * -1;
                        AccNo := MyLoans."Loan Account";
                        Dim1 := RefundLines."Global Dimension 1 Code";
                        Dim2 := RefundLines."Global Dimension 2 Code";
                        // BalAccNo := RefundLines.AccNo;
                        ExtDoc := RefundLines."Document No.";
                        //if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                        SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(RefundLines."Destination Description", 1, 50), Balacctype::"G/L Account",
                        '', TransAmt, ExtDoc, MyLoans."Loan No.", TransType::Repayment, Dim1, Dim2, SystCreated);

                    end;
                end;
            until RefundLines.Next() = 0;
        end;
        if PostTransaction then begin
            SaccoT.PostJournal(JTemplate, JBatch);
            Rec.Posted := true;
            Rec."Posted By" := UserId;
            Rec."Posting date" := Today;
            Rec.Modify;
            Message('Transaction Posted succesfully');
            exit;
        end else
            SaccoT.PreviewJournal(JTemplate, JBatch);

    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        RefundLines: Record "Refund,Account Transfer lines";

        SaccoT: Codeunit "Sacco Transactions";
        BankLed: Record "Cust. Ledger Entry";

        Temp: Record "Banking User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        // CashOfficeSetup: Record "Cash Office Setup";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        MyLoans: Record Loans;
        Text0001: label 'Transaction Already Posted';


        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Factory";
        LT: Text;
        AccountToCharge: Code[20];
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "General Set-Up";
        DepDesc: Text;
        MobileNo: Code[20];
        LengthWithin: Boolean;
        FosaAcc: Record "Savings Accounts";
        NewAccBalance: Decimal;
        BusinessAccount: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        BusinessProdCode: Code[30];
        AgentSavings: Record "Savings Accounts";
        AgentFloatAcc: Record "Savings Accounts";
        Agent: Record "Agent Applications";
        ReceipientPhoneNumber: Text;
        ReceipientsName: Text;
        LineNo: Integer;
        TransAmt: Decimal;
        editCard: Boolean;
        savingsAaacounts: Record "Savings Accounts";
        Loans: Record loans;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    procedure ValidateAccounts()
    var
        myInt: Integer;
        Savacc: Record "Savings Accounts";
    begin

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        RefundLines.SetFilter(Amount, '>%1', 0);
        if RefundLines.Find('-') then begin
            repeat
                Savacc.get(RefundLines."Source Account");
                if RefundLines.Amount > Savacc.GetAvailableBalance(Savacc."No.") then
                    Error('This Account :%1 has a balance of %2 insufficient to complete transfer of %3.', Savacc."No.", Savacc.GetAvailableBalance(Savacc."No."), RefundLines.Amount);
                if RefundLines.Amount <= 0 then Error('The %1 amount is invalid.', RefundLines.Amount);
            until RefundLines.Next = 0;
        end;
    end;


}
