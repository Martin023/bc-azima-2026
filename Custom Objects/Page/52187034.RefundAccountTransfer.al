page 52187034 "Refund,Account Transfer "
{
    ApplicationArea = All;
    Caption = 'Refund And Account Transfer';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Import,Post,Reset Transaction Date';
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
                field("Refund Type"; Rec."Refund Type")
                {

                    trigger OnValidate()
                    begin
                        PageControl();
                    end;
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
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Debits';
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Caption = 'Total Credits';
                    ToolTip = 'Specifies the value of the Scheduled Amount field.';
                }

                field(Validated; Rec.Validated)
                {
                    ToolTip = 'Specifies the value of the Validated field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Comments/Remartks"; Rec."Comments/Remartks")
                {
                    ToolTip = 'Specifies the value of the Comments/Remartks field.';
                    ShowMandatory = true;
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


            part(Control17; "Refund,Account Transfer Lines")
            {
                SubPageLink = "Refund Header No." = FIELD(No);
                ApplicationArea = Basic;
                //Visible = RefundLinesVisible;
                Visible = (rec."Responsibility Center" <> 'FINANCE') and RefundLinesVisible;
            }

            part(Control19; "Bulk Refund Account Transfers")
            {
                SubPageLink = "Refund Header No." = FIELD(No);
                ApplicationArea = Basic;
                Visible = (rec."Responsibility Center" = 'FINANCE') and RefundLinesVisible;

            }
            part(Control18; "Loan Clearance Lines")
            {
                SubPageLink = "Header No." = FIELD(No);
                ApplicationArea = Basic;
                Visible = LoanClearanceLinesVisible;
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
                    Rec.TestField("Comments/Remartks");
                    Rec.TestField("Document No");
                    Rec.TestField(Description);
                    Rec.TestField("Posting date");
                    Rec.CalcFields("Total Count", Rec."Scheduled Amount", Rec.Amount);
                    ValidateAccounts;
                    if Rec."Scheduled Amount" = 0 then Error('Ensure amounts are captured proprely before proceeding');
                    // if (Rec."Scheduled Amount") <> 0 then Error('This transaction is out of balance by %1.', (Rec.Amount + Rec."Scheduled Amount"));
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
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = xmlport "Refund_Account_ Transfer";
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
                    Rec.TestField(Posted, false);
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Kindly Approve the document before posting');
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
                    PDate := Rec."Date Entered";

                    LoanNo := '';
                    TransType := Transtype::" ";

                    SystCreated := true;

                    if rec.Posted = true then begin
                        Error(Text0001);
                    end;

                    SaccoT.InitJournal(JTemplate, JBatch);
                    TransAmt := RefundLines.Amount;

                    RefundLines.Reset;
                    RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
                    if RefundLines.Find('-') then begin
                        repeat
                            TransAmt := 0;
                            TransAmt := RefundLines.Amount;
                            AccNo := RefundLines."Account No.";
                            Dim1 := RefundLines."Global Dimension 1 Code";
                            Dim2 := RefundLines."Global Dimension 2 Code";
                            // BalAccNo := RefundLines.AccNo;
                            ExtDoc := RefundLines."Document No.";
                            //if RefundLines.Description = '' then RefundLines.Description := Rec.Description;

                            if Rec."Refund Type" = Rec."Refund Type"::Refund then begin

                                SaccoT.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(RefundLines."Source Description", 1, 50), Balacctype::"G/L Account",
                                '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                            end;

                        until RefundLines.Next() = 0;
                    end;

                    SaccoT.PostJournal(JTemplate, JBatch);

                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Posting date" := Today;
                    Rec.Modify;
                    Message('Transaction Posted succesfully');
                    exit;
                end;

            }


        }


        area(Navigation)
        {
            action(Comments)
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

        PageControl();
    end;

    trigger OnAfterGetRecord()
    begin
        editCard := true;

        if (rec.Posted = true) or (Rec.Status <> Rec.Status::Open) then begin
            CurrPage.Editable := False;
            editCard := false;
        end else
            CurrPage.Editable := true;
        PageControl();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PageControl();
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
        Loans: Record Loans;
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

        //Controls
        RefundLinesVisible: Boolean;
        LoanClearanceLinesVisible: Boolean;
        RefundAccTranHeader: record "Refund,Account Transfer Header";


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
        loans: Record loans;
    begin

        RefundLines.Reset;
        RefundLines.SetRange(RefundLines."Refund Header No.", Rec.No);
        RefundLines.SetFilter(Amount, '>%1', 0);
        if RefundLines.Find('-') then begin
            repeat
                if Savacc.get(RefundLines."Account No.") then begin
                    if RefundLines.Amount > Savacc.GetAvailableBalance(Savacc."No.") then
                        Error('This Account :%1 has a balance of %2 insufficient to complete transfer of %3.', Savacc."No.", Savacc.GetAvailableBalance(Savacc."No."), RefundLines.Amount);
                end;
                if Loans.get(RefundLines."Loan No.") then begin
                    loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    if RefundLines.Amount > (loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance") then
                        Error('This transaction will lead to overpayment of Loan %1. Current total loan balance is %2.', loans."Loan No.", (loans."Outstanding Interest" + loans."Daily Interest" + loans."Outstanding Balance"));
                end;
            until RefundLines.Next = 0;
        end;
    end;

    local procedure PageControl()
    begin
        if Rec."Refund Type" = Rec."Refund Type"::"Loan Clearance" then begin
            RefundLinesVisible := false;
            LoanClearanceLinesVisible := true;
        end;
        if Rec."Refund Type" = Rec."Refund Type"::Refund then begin
            RefundLinesVisible := true;
            LoanClearanceLinesVisible := false;
        end;

        CurrPage.Update();
    end;


}
