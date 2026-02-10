page 52187410 "Lien Transactions"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Workflow Actions,Budgetary Control,Cancellation,References,Category8_caption,Workflow,Category10_caption';
    SourceTable = "Cashier Transactions";
    SourceTableView = SORTING(No)
                      ORDER(Descending);


    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                Editable = true;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin

                        Rec."Account No" := '';
                        if Rec."Account Type" = Rec."Account Type"::MPESA then
                            AccNo := false else
                            AccNo := true;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;


                    trigger OnValidate()
                    begin
                        SavingsAccounts.get(Rec."Account No");
                        Rec."Transaction Type" := '';
                        TransactionTypesR.Reset();
                        TransactionTypesR.SetRange(Type, TransactionTypesR.type::Lien);
                        TransactionTypesR.SetRange("Product Type", SavingsAccounts."Product Type");
                        if TransactionTypesR.Find('-') then begin
                            Rec."Product Type" := SavingsAccounts."Product Type";
                            Rec."Product Category" := SavingsAccounts."Product Category";
                            Rec."Transaction Type" := TransactionTypesR.Code;
                            Rec.Validate("Transaction Type");
                        end else
                            Error('Transaction Type Lien not set for this product type.');

                    end;


                }
                field(mNO; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                    TableRelation = "Transaction Types".Code WHERE("Product Type" = FIELD("Product Type"),
                                                            Type = CONST(Lien));
                    trigger OnValidate()
                    begin
                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        AllAmount := false;
                        DiscCH := false;
                        FLien := false;
                        if Rec.Type = Rec.Type::"Cheque Deposit" then begin
                            FChequeVisible := true;
                            DiscCH := true;
                        end;

                        if Rec.Type = Rec.Type::"Bankers Cheque" then
                            BChequeVisible := true;

                        if Rec.Type = Rec.Type::"Credit Receipt" then begin
                            BReceiptVisible := true;
                            AllAmount := true;
                        end;

                        if Rec.Type = Rec.Type::"Credit Cheque" then begin
                            FChequeVisible := true;
                            BOSAReceiptChequeVisible := true;
                            AllAmount := true;
                        end;

                        if Rec.Type = Rec.Type::Lien then begin
                            FLien := true;
                        end;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;

                    Editable = Amont;

                    trigger OnValidate()
                    var
                    // SkyMbanking: Codeunit "Sky Mbanking";
                    begin
                        if rec.Type = rec.Type::Lien then begin
                            SavingsAccounts.get(rec."Account No");
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < rec.Amount then
                                Message('There is no enough balance in the account to place a Lien!');
                        end;

                        Rec.TestField("Account No");
                        Rec.TestField("Transaction Type");

                    end;
                }
                // field("Currency Code"; Rec."Currency Code")
                // {
                //     ApplicationArea = Basic;

                //     Editable = Currr;
                // }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Project Member"; Rec."Project Member")
                {
                    ApplicationArea = Basic;

                    Editable = Rec."Account Type" = Rec."Account Type"::MPESA;
                }
                field("Project Vendor"; Rec."Project Vendor")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Account Type" = Rec."Account Type"::MPESA;

                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;


                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic;

                    }
                    field("Post Dated"; Rec."Post Dated")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Bankers Cheque No"; Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bankers Cheque No';

                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = Basic;

                        Editable = false;
                    }
                    field(Control49; Rec."Allocated Amount")
                    {
                        ApplicationArea = Basic;

                    }
                }
                group("Lien Transaction")
                {
                    Caption = '.';
                    Visible = FLien;
                    field("Expiry Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                        Editable = true;

                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;

                    }
                    field(BchequeNo; Rec."Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = ' Cheque No';

                    }
                    field("Bank Account"; Rec."Bank Account")
                    {
                        ApplicationArea = Basic;

                        Caption = 'Bank';
                        Visible = true;
                    }
                    field("Cheque Issueing Bank"; Rec."Cheque Issueing Bank")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cheque Status"; Rec."Cheque Status")
                    {
                        ApplicationArea = Basic;

                        Editable = false;
                    }
                    field("Expected Maturity Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;

                        Editable = false;
                    }
                    group(BOSAReceiptCheque)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = Basic;

                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("New Account Balance"; Rec."New Account Balance")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Deposited By"; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remarrrks;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;

                }
                field("Till Name"; Rec."Till Name")
                {
                    ApplicationArea = Basic;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Attempted Self Transaction"; Rec."Attempted Self Transaction")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            systempart(Control13; Links)
            {

                Visible = false;
            }
            systempart(Control12; Notes)
            {

                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group(Transaction)
            {
                Caption = 'Transaction';
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var


                    begin
                        Account.Reset;
                        Account.SetRange(Account."No.", Rec."Account No");
                        if Account.Find('-') then
                            REPORT.Run(Report::"Savings Statement", true, false, Account)
                    end;
                }
                action(
                    "Account Page")
                {
                    ApplicationArea = Basic;

                    Caption = 'Account Page';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Savings Account Card";
                    RunPageLink = "No." = FIELD("Account No");
                }


                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        ImageData.Reset;
                        ImageData.SetRange(ImageData."Member No", Rec."Member No.");
                        if ImageData.Find('-') then begin
                            PAGE.Run(Page::"Payroll Changes Requested", ImageData);
                        end;
                    end;
                }



                action("Allocated Amount")
                {
                    ApplicationArea = Basic;

                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Cashier Transaction Lines";
                    RunPageLink = "Transaction No" = FIELD(No);
                    Visible = AllAmount;
                }
                action(Signatories)
                {
                    ApplicationArea = Basic;
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Signatories List";
                    RunPageLink = "Account No" = FIELD("Member No.");
                }
            }
        }
        area(processing)
        {

            action("Reset Transaction Date")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin

                    Trans.Reset;
                    Trans.SetRange(Trans.Posted, false);
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        Rec."Transaction Date" := Today;
                        Rec."Transaction Time" := Time;
                        Rec.Modify;

                        Message('Transaction date updated');

                    end else
                        Error('Transaction already posted');
                end;
            }

            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin
                    if rec.Type = rec.Type::Lien then begin
                        SavingsAccounts.get(rec."Account No");
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < rec.Amount then
                            Message('There is no enough balance in the account to place a Lien!');
                    end;


                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    //Mark Transaction Posted...
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec.No);
                    if BankAccountLedgerEntry.FindFirst then begin
                        Rec.Posted := true;
                        Rec.Modify;
                    end;

                    if Rec.Posted = false then
                        SaccoT.InitPost(Rec);

                    CurrPage.Close;
                end;
            }
            action("Till Balance")
            {
                ApplicationArea = Basic;
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "Bank Account Card";
                RunPageLink = "No." = FIELD("Till Code");
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
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
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        if Rec.Amount <= 0 then Error('Amount must be greater than zero');

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // Rec.Status := rec.Status::"Approved";
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Discount Cheque")
                {
                    ApplicationArea = Basic;
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "Cheque Discounting";
                    RunPageLink = No = FIELD(No),
                                  Type = CONST("Cheque Deposit");
                    Visible = DiscCH;
                }
                action("Stop Cheque")
                {
                    ApplicationArea = Basic;
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SaccoT: Codeunit "Sacco Transactions";
                    begin

                        SaccoT.StopCheque(Rec);
                    end;
                }
                action("Clear Lien")
                {
                    ApplicationArea = Basic;
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        if Rec.Type <> Rec.Type::Lien then
                            Error('Only applicable to Lien');

                        // if rec.Type = rec.Type::Lien then
                        //     rec.Status := Rec.Status::Approved;

                        if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                            Rec."Cheque Status" := Rec."Cheque Status"::Honoured;
                            Rec."Date Cleared" := Today;
                            Rec."Cleared By" := UserId;
                            Rec.Modify;

                            Message('Lien processed successfully');

                        end;
                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Type := Rec.Type::Lien;
        if Trans.Get(Rec.No) then begin
            BankLedger.Reset;
            BankLedger.SetRange(BankLedger."Document No.", Trans.No);
            if BankLedger.Find('-') then begin
                if Trans.Posted = false then begin
                    Trans.Posted := true;
                    Trans."Date Posted" := Today;
                    Trans."Time Posted" := Time;
                    Trans."Posted By" := UserId;
                    Trans.Modify;

                    exit;
                end;
            end;
        end;
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        AllAmount := false;
        DiscCH := false;
        FLien := false;

        if Rec.Type = Rec.Type::"Cheque Deposit" then begin
            FChequeVisible := true;
            DiscCH := true;
        end;

        if Rec.Type = Rec.Type::"Bankers Cheque" then
            BChequeVisible := true;

        if Rec.Type = Rec.Type::"Credit Receipt" then begin
            BReceiptVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::Lien then begin
            FLien := true;
        end;

        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnInit()
    begin


        UpdateControl;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Lien;
        Temp.Get(UserId);
        Trans.Reset;
        Trans.SetRange(Trans.Cashier, UserId);
        Trans.SetRange(Status, Trans.Status::Open);
        Trans.SetRange(Type, Trans.Type::Lien);
        Trans.SetRange(Trans.Posted, false);
        if Trans.FindFirst then begin
            if Trans.Count >= Temp."No of Open Transactions" then begin
                Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::Lien;

        if Rec.Posted = true then
            CurrPage.Editable := false;

        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false;
        if Trans.Get(Rec.No) then begin
            BankLedger.Reset;
            BankLedger.SetRange(BankLedger."Document No.", Trans.No);
            if BankLedger.Find('-') then begin
                if Trans.Posted = false then begin
                    Trans.Posted := true;
                    Trans."Date Posted" := Today;
                    Trans."Time Posted" := Time;
                    Trans."Posted By" := UserId;
                    Trans.Modify;

                    exit;
                end;
            end;
        end;
        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false else
            AccNo := true;



        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false else
            AccNo := true;
    end;

    var

        FChequeVisible: Boolean;

        BChequeVisible: Boolean;

        BReceiptVisible: Boolean;

        BOSAReceiptChequeVisible: Boolean;
        FLien: Boolean;
        Account: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        Text0001: Label 'Ensure the Cashier journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Cashier journal Batch is set up in Banking User Setup';
        Text0003: Label 'Ensure the Default Bank is set up in Banking User Setup';
        Text0004: Label 'Ensure the Cashier Member no is set up in Banking User Setup';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        AccNo: Boolean;
        TransType: Boolean;
        Amont: Boolean;
        Remarrrks: Boolean;
        AllAmount: Boolean;
        Trans: Record "Cashier Transactions";
        Text0005: Label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: Label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        Currr: Boolean;
        ImageData: Record "Image Data";
        DiscCH: Boolean;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankLedger: Record "Bank Account Ledger Entry";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        TransactionTypesR: Record "Transaction Types";

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin

        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin

        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            Remarrrks := true;
            Amont := true;
            Currr := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;

        end;
    end;
}

