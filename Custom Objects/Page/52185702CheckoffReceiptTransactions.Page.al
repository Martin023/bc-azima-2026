page 52185702 "Checkoff Receipt Transactions"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Checkoff  Receipt Transactions";
    SourceTableView = SORTING(No)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Amont;
                }
                field(Control35; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Employer No"; Rec."Employer No")
                {
                    Caption = 'Employer No';
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer  Account Name"; Rec."Employer  Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Post Dated"; Rec."Post Dated")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Bankers Cheque No"; Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bankers Cheque No';
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                }
                group("Lien Transaction")
                {
                    Caption = '.';
                    Visible = FLien;
                    field("Expiry Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = true;
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(BchequeNo; Rec."Cheque No")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Cheque No';
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Cheque Status"; Rec."Cheque Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Expected Maturity Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    group(BOSAReceiptCheque)
                    {

                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Balance';
                    Editable = false;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remarks';
                    Editable = Remarrrks;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Till Name"; Rec."Till Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; Links)
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; Notes)
            {
                Visible = true;
                ApplicationArea = Basic, Suite;
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
                separator(Action9)
                {

                }
                action("Stop Cheque")
                {
                    Caption = 'Stop Cheque';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                action("Allocated Amount")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Checkoff Receipt Trans Lines";
                    RunPageLink = "Transaction No" = FIELD(No),
                                  "Member No" = FIELD("Account No");
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                action(Signatories)
                {
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Signatories List";
                    // RunPageLink = "Account No" = FIELD("Member No.");
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(processing)
        {
            action("Post & Print")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Periodic Activities";
                    BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                begin
                    //Mark Transaction Posted...
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec.No);
                    if BankAccountLedgerEntry.FindFirst then begin
                        Rec.Posted := true;
                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;
                    end else begin
                        Validate_B4_Posting();



                        //here//SaccoT.InitPost(Rec);

                        Commit;

                        Trans.Reset;
                        Trans.SetRange(Trans.No, Rec.No);
                        if Trans.Find('-') then begin
                            //REPORT.Run(52185947, false, true, Trans)
                        end;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Reset Transaction Date")
            {
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ApplicationArea = Basic, Suite;
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
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Periodic Activities";
                    Txt001: Label 'Receipt Posted Successfully';
                    BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                begin
                    //Mark Transaction Posted...
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec.No);
                    if BankAccountLedgerEntry.FindFirst then begin
                        Rec.Posted := true;
                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;
                    end else begin

                        Validate_B4_Posting();
                        //here//SaccoT.InitPost(Rec);

                        if Rec.Posted = true then begin
                            Message(Txt001);
                            Rec.Status := Rec.Status::Posted;
                        end;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Reprint Slip")
            {
                Caption = 'Reprint Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    Rec.TestField(Posted);

                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin
                        //REPORT.Run(52185947, true, true, Trans);
                    end;
                end;
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
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //    CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    // // //ApprovalEntries: Page "Approval Entries";
                    // approvalsMgmt: Codeunit 1535;
                    begin

                        //// ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;

        /*
        FChequeVisible :=FALSE;
        BChequeVisible :=FALSE;
        BReceiptVisible :=FALSE;
        BOSAReceiptChequeVisible :=FALSE;
        AllAmount:=FALSE;
        DiscCH:=FALSE;
        FLien:=FALSE;
        
        IF Type=Type::"Cheque Deposit" THEN BEGIN
        FChequeVisible :=TRUE;
        DiscCH:=TRUE;
        END;
        
        IF Type=Type::"Bankers Cheque" THEN
        BChequeVisible :=TRUE;
        
        IF Type=Type::"Credit Receipt" THEN BEGIN
        BReceiptVisible :=TRUE;
        AllAmount:=TRUE;
        END;
        
        IF Type=Type::"Credit Cheque" THEN BEGIN
        FChequeVisible:=TRUE;
        BOSAReceiptChequeVisible:=TRUE;
        AllAmount:=TRUE;
        END;
        
        IF Type=Type::Lien THEN BEGIN
        FLien:=TRUE;
        END;
        
        SetControlAppearance;
        UpdateControl;
        */

    end;

    trigger OnInit()
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Cashier Journal Template";
        Jbatch := Temp."Cashier Journal Batch";
        TillNo := Temp."Default  Bank";
        MemberNo := Temp."Member No.";
        Excess := Temp."Excess Account";
        Shortage := Temp."Shortage Account";

        if Jtemplate = '' then begin
            Error(Text0001);
        end;
        if Jbatch = '' then begin
            Error(Text0002);
        end;

        if TillNo = '' then begin
            Error(Text0003);
        end;
        /*
        IF MemberNo='' THEN
          BEGIN
            ERROR(Text0004);
          END;
        
        IF Shortage='' THEN
          BEGIN
            ERROR(Text0005);
          END;
        
        IF Excess='' THEN
          BEGIN
            ERROR(Text0006);
          END;
        */
        UpdateControl;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Temp.Get(UserId);
        //check for pending documents
        Trans.Reset;
        Trans.SetRange(Trans.Cashier, UserId);
        Trans.SetRange(Trans.Posted, false);
        if Trans.Count > Temp."No of Open Transactions" then begin
            Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        end;
    end;

    trigger OnOpenPage()
    begin

        if Rec.Posted = true then
            CurrPage.Editable := false;
        ReceiptsHeader.Reset;
        // ReceiptsHeader.SETRANGE("No.",ReceiptsHeader."No.");
        //ReceiptsHeader.SETRANGE("Pay Mode",ReceiptsHeader."Pay Mode"::Cheque);
        //ReceiptsHeader.SETFILTER(Posted,'=%1',FALSE);
        //ReceiptsHeader.SETRANGE("Email Sent",FALSE);
        //ReceiptsHeader.SETFILTER("Cheque Maturity Date",'=%1',TODAY);
        if ReceiptsHeader.FindFirst then begin
        end;
    end;

    var
        BankAccount: Record "Bank Account";

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
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        AccNo: Boolean;
        TransType: Boolean;
        Amont: Boolean;
        Remarrrks: Boolean;
        AllAmount: Boolean;
        Trans: Record "Checkoff  Receipt Transactions";
        Text0005: Label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: Label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        BosaLines: Record "Checkoff  Receipt Trans Lines";
        BosaLines2: Record "Checkoff  Receipt Trans Lines";
        Excess: Code[20];
        Shortage: Code[20];
        Currr: Boolean;
        ImageData: Record "Image Data";
        DiscCH: Boolean;
        Insurance: Label 'Invalid Account No for Insurance product %1';
        CustMembr: Record Members;
        Loans: Record Loans;
        ClearInterestFirst: Label 'Kindly clear the Outstanding Interest of %2 for Loan %1 before clearing the Outstanding Balance';
        Interest_Paid: Decimal;
        LoansTopup: Record "Loans Top up";
        LoansFinancing: Record Loans;
        Locked_TopUp: Label 'The loan (%1) has been locked for top-up by loan (%2) and all transactions have been restricted until the loan is posted.';
        ReceiptsHeader: Record "Receipts Header";

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
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

    local procedure Validate_B4_Posting()
    begin
        if UpperCase(Rec.Cashier) <> UpperCase(UserId) then Error('You cannot post a transaction that you did not initiate.');
        Rec.CalcFields("Allocated Amount");
        if Rec.Amount <= 0 then Error('Amount has to be more than zero for this transaction');
        if Rec.Amount <> Rec."Allocated Amount" then Error('Ensure Transaction Amount is equal to Allocated Amount');

        BosaLines.Reset;
        BosaLines.SetRange(BosaLines."Transaction No", Rec.No);
        if BosaLines.FindFirst then begin
            repeat

                Validate_Locked_4_TopUp(BosaLines."Loan No");

                if BosaLines.Amount <= 0 then Error('One of the Allocated amounts is zero. Kindly enter valid amount.');

                Interest_Paid := 0;
                if BosaLines."Transaction Type" = BosaLines."Transaction Type"::Repayment then begin
                    BosaLines.Validate("Loan No");
                    Loans.Reset;
                    Loans.SetRange(Loans."Loan No.", BosaLines."Loan No");
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

                        BosaLines2.Reset;
                        BosaLines2.SetRange(BosaLines2."Transaction No", Rec.No);
                        BosaLines2.SetRange(BosaLines2."Loan No", Loans."Loan No.");
                        BosaLines2.SetRange(BosaLines2."Transaction Type", BosaLines2."Transaction Type"::"Interest Paid");
                        if BosaLines2.FindFirst then begin
                            BosaLines2.CalcSums(Amount);
                            Interest_Paid := BosaLines2.Amount;
                        end;

                        if ((BosaLines.Amount - Loans."Outstanding Balance") >= 0) and (Loans."Outstanding Interest" > 0) and (Interest_Paid < Loans."Outstanding Interest") then
                            Error(ClearInterestFirst, BosaLines."Loan No", Loans."Outstanding Interest");
                    end;
                end;

            until BosaLines.Next = 0;
        end;
    end;

    local procedure Validate_Locked_4_TopUp(The_Loan_No: Code[20])
    begin
        Loans.Reset;
        Loans.SetRange(Loans."Loan No.", The_Loan_No);
        if Loans.FindFirst then begin
            LoansTopup.Reset;
            LoansTopup.SetRange(LoansTopup."Loan Top Up", The_Loan_No);
            if LoansTopup.FindFirst then begin
                LoansFinancing.Reset;
                LoansFinancing.SetRange(LoansFinancing."Loan No.", LoansTopup."Loan No.");
                if LoansFinancing.FindFirst then begin
                    if LoansFinancing.Posted = false then Error(Locked_TopUp, The_Loan_No, LoansFinancing."Loan No.");
                end;
            end;
        end;
    end;
}

