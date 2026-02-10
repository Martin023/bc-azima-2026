page 52186829 "Tenant Receipt"
{
    DeleteAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Receipts Header";
    // SourceTableView = WHERE("Receipt Type" = CONST(Bank));
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."Customer Type" := Rec."Customer Type"::Tenant;
                    end;
                }
                field("Rent Type"; Rec."Rent Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {

                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = rec.statuseditable;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        // FunctionName := '';
                        // DimVal.Reset;
                        // DimVal.SetRange(DimVal."Global Dimension No.", 1);
                        // DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
                        // if DimVal.Find('-') then begin
                        //     FunctionName := DimVal.Name;
                        // end;
                    end;
                }
                // field(FunctionName; Rec.FunctionName)
                // {
                //     Caption = 'Description';
                //     Editable = false;
                // }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        // BudgetCenterName := '';
                        // DimVal.Reset;
                        // DimVal.SetRange(DimVal."Global Dimension No.", 2);
                        // DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
                        // if DimVal.Find('-') then begin
                        //     BudgetCenterName := DimVal.Name;
                        // end;
                    end;
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = true;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }


                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."Account Type" := Rec."Account Type"::"Bank Account";
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Tenant; Rec.Tenant)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Customer.Reset();
                        Customer.SetRange(Customer."No.", Rec.Tenant);
                        if Customer.FindFirst() then begin
                            LoaneeInfomationBase.Reset();
                            LoaneeInfomationBase.SetRange("Member No.", Customer."No.");
                            LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
                            if LoaneeInfomationBase.Find('-') then begin
                                repeat
                                    if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                                        Message(LoaneeInfomationBase.Info);
                                until LoaneeInfomationBase.Next = 0;
                            end;

                        end;
                    end;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Invoices; Rec.Invoices)
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Amount Invoiced"; Rec."Amount Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Creation Doc Type"; Rec."Creation Doc Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
            }
            part(Control1000000000; "Tenant Receipts Line")
            {
                // Editable = statuseditable;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {

            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    //Check Post Dated
                    if CheckPostDated then
                        Message('One of the Receipt Lines is Post Dated');
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec."No.");
                    if BankAccountLedgerEntry.FindFirst then begin
                        Post := true;
                        rec.posted := true;
                        rec.Modify;
                    end;
                    //Post the transaction into the database
                    if Post = false then
                        PerformPost();
                end;
            }
            action("Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Shift+F9';
                Visible = true;

                trigger OnAction()
                begin
                    //Check Post Dated
                    if CheckPostDated then
                        Message('One of the Receipt Lines is Post Dated');

                    //Post the transaction into the database
                    if rec.Posted = false then Error('Post the receipt before printing.');
                    rec.Reset;
                    rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Tenant Printout", true, true, Rec);
                    rec.Reset;
                end;
            }
            action("Suggest Credit Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestVendorBills;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if not Confirm('Suggest Credit accounts for %1', true, Rec."Group Code") then exit;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SetRange(ReceiptLine.Type, 'CREDIT');
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Insert new accounts

                    CreditAccounts.Reset;
                    CreditAccounts.SetRange(CreditAccounts."Member No.", Rec."Member No");
                    CreditAccounts.SetFilter("Total Balance", '>%1', 0);
                    if CreditAccounts.Find('-') then begin
                        repeat

                            ReceiptLine.Init;
                            ReceiptLine.No := Rec."No.";
                            if ReceiptLine.FindLast then
                                Line := ReceiptLine."Line No." + 1 else
                                Line += 1;
                            ReceiptLine.Type := 'CREDIT';
                            ReceiptLine.Validate(Type);
                            ReceiptLine."Line No." := Line;
                            ReceiptLine."Account No." := CreditAccounts."Loan Account";
                            ReceiptLine."Loan No." := CreditAccounts."Loan No.";
                            ReceiptLine."Transaction Type" := ReceiptLine."Transaction Type"::Repayment;
                            ReceiptLine.Validate("Account No.");
                            ReceiptLine.Insert(true);
                        until CreditAccounts.Next = 0;
                    end;
                end;
            }
            action("Suggest Savings Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestPayment;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    ReceiptSetup: Record "Receipts and Payment Types";
                begin
                    if not Confirm('Suggest Savings accounts for %1', true, Rec."Group Code") then exit;
                    //Clear any line
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account" then
                        ReceiptLine.Reset;
                    ReceiptLine.SetRange(No, Rec."No.");
                    ReceiptLine.SetRange(Type, 'SAVINGS');
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Insert new accounts

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No");
                    if SavingsAccounts.Find('-') then begin
                        repeat

                            ReceiptLine.Init;
                            ReceiptLine.No := Rec."No.";
                            if ReceiptLine.FindLast then
                                Line := ReceiptLine."Line No." + 1 else
                                Line += 1;
                            ReceiptLine."Account Type" := ReceiptSetup."Account Type"::Savings;
                            ReceiptLine."Line No." := Line;
                            ReceiptLine.Type := 'SAVINGS';
                            ReceiptLine.Validate(Type);
                            ReceiptLine."Account No." := SavingsAccounts."No.";
                            ReceiptLine.Validate("Account No.");
                            ReceiptLine.Insert(true);
                        until SavingsAccounts.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfGetCurrRecord;
        CurrPageUpdate;
    end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     //********************************JACK**********************************//

    //     Rcpt.Reset;
    //     Rcpt.SetRange(Rcpt.Posted, false);
    //     Rcpt.SetRange(Rcpt."Created By", UserId);
    //     if Rcpt.Count > 0 then begin
    //         if Confirm('There are still some unposted receipts. Continue?', false) = false then begin
    //             Error('There are still some unposted receipts. Please utilise them first');
    //         end;
    //     end;

    //     //********************************END **********************************//
    //     //CurrPage.UPDATE;
    // end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        rec.Validate("Shortcut Dimension 4 Code");
        rec.Status := rec.Status::" ";
        Rec."Receipt Type" := Rec."Receipt Type"::Bank;
        rec."Customer Type" := Rec."Customer Type"::Tenant;

        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if rec.Posted = true then
            CurrPage.Editable := false;
        // if rec.Status = rec.Status::Approved then
        // CurrPage.Editable := false;

        UserSetup.Reset;

        if UserSetup.Get(UserId) then begin
            JTemplate := UserSetup."Receipt Journal Template";
            JBatch := UserSetup."Receipt Journal Batch";
        end;
        if (JTemplate = '') or (JBatch = '') then begin
            //ERROR('Please contact the system administrator to be setup as a receipting user');
        end;
        if UserSetup."Default Receipts Bank" = '' then begin
            Rec."Account Type" := Rec."Account Type"::"Bank Account";
            //ERROR('Please contact the system administrator to be setup as a receipting user');
        end;

        //***************************JACK***************************//
        //  SETRANGE("Created By",USERID);
        if UserMgt.GetSalesFilter() <> '' then begin
            rec.FilterGroup(2);
            rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            rec.FilterGroup(0);
        end;

        //***************************END ***************************//
        //SetDocNoVisible;
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        ReceiptLine: Record "Receipt Line";
        tAmount: Decimal;
        DefaultBatch: Record "Gen. Journal Batch";
        FunctionName: Text[100];
        BudgetCenterName: Text[100];
        BankName: Text[100];
        Rcpt: Record "Receipts Header";
        RcptNo: Code[20];
        DimVal: Record "Dimension Value";
        BankAcc: Record "Bank Account";
        UserSetup: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        GLine: Record "Gen. Journal Line";
        LineNo: Integer;
        BAmount: Decimal;
        SRSetup: Record "Sales & Receivables Setup";
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        USetup: Record "Cash Office User Template";
        RegMgt: Codeunit "Register Management";
        RegisterNumber: Integer;
        FromNumber: Integer;
        ToNumber: Integer;
        StrInvoices: Text[250];
        UserMgt: Codeunit "User Setup Management BR";
        JournalPosted: Codeunit "Journal Post Successful";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        IsCashAccount: Boolean;
        Tenant: Boolean;
        Investment: Boolean;

        StatusEditable: Boolean;
        DocNoVisible: Boolean;
        Line: Integer;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record Loans;
        CheckoffAdvice: Codeunit "Periodic Activities";
        Loans: Record Loans;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        SendSMS: Codeunit SendSms;
        LoaneeInfomationBase: Record "Loanee Infomation Base";
        Customer: Record Customer;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";

    //[Scope('OnPrem')]
    procedure PerformPost()
    var
        LoanGua: Record "Loan Guarantors and Security";
        Members: Record Members;
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Loan: Record Loans;
        CompInfo: Record "Company Information";
        SendM: Boolean;
        ReceiptsHeader: Record "Receipts Header";
        msg: Text;
        Customer: Record Customer;
        Lease: Record Lease;
        SalesInvoice: Record "Sales Header";
        SalesLines: Record "Sales Line";
        // SendSMS: Codeunit SendSms;
        Source: enum "SMS Source";
        TarriffCodes: Record "Tariff Code s";
    begin
        //get all the invoices that have been paid for using the receipt
        /*
        StrInvoices:='';
        Appl.RESET;
        Appl.SETRANGE(Appl."Document Type",Appl."Document Type"::"1");
        Appl.SETRANGE(Appl."Document No.","No.");
        IF Appl.FINDFIRST THEN
          BEGIN
            REPEAT
              StrInvoices:=StrInvoices + ',' + Appl."Appl. Doc. No";
            UNTIL Appl.NEXT=0;
          END;
        */
        //Cater for Cash Accounts
        IsCashAccount := false;
        BankAcc.Reset;
        if BankAcc.Get(rec."Bank Code") then begin
            if BankAcc."Bank Type" = BankAcc."Bank Type"::Cash then
                IsCashAccount := true;
        end;

        //IF IsCashAccount THEN
        //TESTFIELD(Date,WORKDATE);
        //End Cater for Cash Account


        USetup.Reset;
        USetup.SetRange(USetup.UserID, UserId);
        if USetup.FindFirst then begin
            if USetup."Receipt Journal Template" = '' then begin
                Message('Please ensure that the Administrator sets you up as a cashier');
            end;
            if USetup."Receipt Journal Batch" = '' then begin
                Message('Please ensure that the Administrator sets you up as a cashier');
            end;
            if USetup."Default Receipts Bank" = '' then begin
                Message('Please ensure that the Administrator sets you up as a cashier');
            end;
        end
        else begin
            Message('Please ensure that the Administrator sets you up as a cashier');
        end;


        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        rec.CalcFields(rec."Total Amount");
        if Rec."Total Amount" <> Rec."Amount Recieved" then begin
            Error('Please note that the Total Amount and the Amount Received Must be the same');
        end;

        //if any then the amount to be posted must be less the post dated amount
        if rec.Posted = true then begin
            Error('A Transaction Posted cannot be posted again');
        end;

        //check if the person received from has been selected
        //rec.TestField(Date);
        rec.TestField("Account No.");//"Bank Code");
        rec.TestField(Tenant);
        // rec.TestField("Global Dimension 1 Code");
        // rec.TestField("Shortcut Dimension 2 Code");
        rec.TestField("Received From");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(rec."Bank Code", Rec."Currency Code");

        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then begin
            repeat
                // if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then
                //     Error('Paymode is Mandatory on the Receipt Line');

                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                    if ReceiptLine."Transaction No." = '' then begin
                        Error('Please ensure that the Transaction Number is inserted');
                    end;
                    if ReceiptLine.Type = '' then
                        Error('Please ensure that the Receipt Type is inserted');

                end;

                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;

                    // IF ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque THEN BEGIN
                    //     IF STRLEN(ReceiptLine."Cheque/Deposit Slip No") <> 6 THEN BEGIN
                    //         ERROR('Invalid Cheque Number inserted');
                    //     END;
                    // END;

                end;
                tAmount := tAmount + ReceiptLine.Amount;
            until ReceiptLine.Next = 0;
        end;



        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;

        if DefaultBatch.Get(JTemplate, JBatch) then
            DefaultBatch.Delete;

        DefaultBatch.Reset;
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.Insert;

        /*Insert the bank transaction*/
        if BAmount < tAmount then begin
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'CASHRECJNL';
            GenJnlLine."Line No." := 1;
            GenJnlLine."Posting Date" := rec.Date;
            GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."Account Type" := Rec."Account Type";//GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Rec."Account No.";//"Bank Code";//USetup."Default Receipts Bank";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := (tAmount);
            GenJnlLine.Validate(GenJnlLine.Amount);

            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

            GenJnlLine.Description := Rec.Dim4;
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;




            //insert the transaction lines into the database
            ReceiptLine.Reset;
            ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);

            if ReceiptLine.Find('-') then begin
                repeat
                    if ReceiptLine.Amount = 0 then Error('Please enter amount.');

                    if ReceiptLine.Amount < 0 then Error('Amount cannot be less than zero.');

                    ReceiptLine.TestField(ReceiptLine."Global Dimension 1 Code");

                    ReceiptLine.TestField(ReceiptLine."Shortcut Dimension 2 Code");

                    //get the last line number from the general journal line
                    GLine.Reset;
                    GLine.SetRange(GLine."Journal Template Name", JTemplate);
                    GLine.SetRange(GLine."Journal Batch Name", JBatch);
                    LineNo := 0;
                    if GLine.Find('+') then begin LineNo := GLine."Line No."; end;
                    LineNo := LineNo + 1;
                    if ReceiptLine."Pay Mode" <> ReceiptLine."Pay Mode"::Cheque then begin
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := rec.Date;
                        GenJnlLine."Document No." := ReceiptLine.No;
                        GenJnlLine."Document Date" := Rec."Document Date";
                        /*IF ReceiptLine."Customer Payment On Account" THEN
                          BEGIN
                            {SRSetup.GET();
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";}

                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";

                          END
                        ELSE
                          BEGIN
                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";
                          END;*/
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";

                        GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type";//Sacco
                        GenJnlLine."Loan No" := ReceiptLine."Loan No.";//Sacco
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                        GenJnlLine."Currency Code" := Rec."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");

                        GenJnlLine.Amount := -ReceiptLine.Amount;
                        GenJnlLine.Validate(GenJnlLine.Amount);

                        if ReceiptLine."Customer Payment On Account" = false then begin
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                            GenJnlLine.Validate("Applies-to Doc. No.");
                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                            GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                        end;

                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := ReceiptLine.Description;
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        //                  GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                        //                  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                        GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                        //Withholding tax
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code, ReceiptLine."Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                            TarriffCodes.TestField(TarriffCodes."Account No.");
                            LineNo := LineNo + 1000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := JTemplate;
                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                            GenJnlLine."Journal Batch Name" := JBatch;
                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                            GenJnlLine."Source Code" := 'CASHRECJNL';
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := Rec.Date;

                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";

                            GenJnlLine."Document No." := ReceiptLine.No;
                            GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                            GenJnlLine."Account Type" := TarriffCodes."Account Type";
                            GenJnlLine."Account No." := TarriffCodes."Account No.";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.Validate(GenJnlLine."Currency Code");
                            //CurrFactor
                            // GenJnlLine."Currency Factor" := Payments."Currency Factor";
                            // GenJnlLine.Validate("Currency Factor");

                            // debit the withholding tax account
                            GenJnlLine.Amount := ReceiptLine."Withholding Tax Amount";
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                            GenJnlLine."Bal. Account No." := '';
                            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                            GenJnlLine.Description := CopyStr('W/Tax:: ' + Format(ReceiptLine."Account Name"), 1, 50);
                            GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";
                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                            //GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Apply to";
                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;
                        end;
                    end
                    else
                        if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                            if ReceiptLine."Cheque/Deposit Slip Date" <= Today then begin
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                /*IF ReceiptLine."Customer Payment On Account" THEN
                                  BEGIN
                                    SRSetup.GET();
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";
                                  END
                                ELSE
                                  BEGIN
                                    GenJnlLine."Account Type":=ReceiptLine."Account Type";
                                    GenJnlLine."Account No.":=ReceiptLine."Account No.";
                                  END;*/

                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account No.";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type";//Sacco
                                GenJnlLine."Loan No" := ReceiptLine."Loan No.";//Sacco
                                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");

                                GenJnlLine.Amount := -ReceiptLine.Amount;
                                GenJnlLine.Validate(GenJnlLine.Amount);

                                if ReceiptLine."Customer Payment On Account" = false then begin
                                    //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                    GenJnlLine.Validate("Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                                end;
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := ReceiptLine.Description;
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                //                    GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                //                    GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                                //Withholding tax
                                TarriffCodes.Reset;
                                TarriffCodes.SetRange(TarriffCodes.Code, ReceiptLine."Withholding Tax Code");
                                if TarriffCodes.Find('-') then begin
                                    TarriffCodes.TestField(TarriffCodes."Account No.");
                                    LineNo := LineNo + 1000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Source Code" := 'CASHRECJNL';
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := Rec.Date;

                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";

                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                    GenJnlLine."Account Type" := TarriffCodes."Account Type";
                                    GenJnlLine."Account No." := TarriffCodes."Account No.";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                                    //CurrFactor
                                    // GenJnlLine."Currency Factor" := Payments."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");

                                    // debit the withholding tax account
                                    GenJnlLine.Amount := ReceiptLine."Withholding Tax Amount";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                    GenJnlLine."Bal. Account No." := '';
                                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                    GenJnlLine.Description := CopyStr('W/Tax:: ' + Format(ReceiptLine."Account Name"), 1, 50);
                                    GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";
                                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                    //GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Apply to";
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;
                                end;
                            end
                            else
                                error('Cheque is Post Dated');
                        end;


                until ReceiptLine.Next = 0;
            end;

            /*Post the transactions*/
            Post := false;
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances

            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            Post := JournalPosted.PostedSuccessfully();
            if Post then begin
                //Update Header
                rec.Cashier := UserId;
                //"Bank Code":=USetup."Default Receipts Bank";
                rec.Posted := true;
                Rec."Date Posted" := Today;
                Rec."Time Posted" := Time;
                Rec."Posted By" := UserId;
                Rec.Modify;


                //Update Lines
                ReceiptLine.Reset;
                ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                ReceiptLine.SetRange(ReceiptLine.Posted, false);
                if ReceiptLine.Find('-') then begin
                    repeat
                        ReceiptLine.Posted := true;
                        ReceiptLine."Date Posted" := Today;
                        ReceiptLine."Time Posted" := Time;
                        ReceiptLine."Posted By" := UserId;
                        ReceiptLine.Modify;
                        if ReceiptLine."Transaction Type" = ReceiptLine."Transaction Type"::Repayment then begin
                            if Loans.Get(ReceiptLine."Loan No.") then
                                Loans.Validate(Repayment);
                        end;
                    until ReceiptLine.Next = 0;
                end;
                IF CONFIRM('Do you want to send SMS notifications to Tenant?', FALSE) = TRUE THEN BEGIN
                    //if Rec."Insurance Claim no" = '' then begin
                    Customer.Reset();
                    if Customer.get(rec.Tenant) then begin
                        CompInfo.Get;
                        //     SendSMS.SendSms(SourceType::"Deposit Confirmation", Members."Phone No.", 'You have Deposited KSH ' + Format("Amount Recieved") + ', on' + Format(Today) + ' ' + Format(Time) +
                        //    '. to your account at ' + ' ' + CompInfo.Name, Rec."No.", Rec."Member No", false);
                        msg := 'Dear ' + Customer.Name + ', Your receipt for the month of this month' + ' is ' + Format(rec."Amount Recieved") + ' has been received. ';
                        SendSMS.SendSms(Source::Tenants, Customer."Phone No.", msg, Format(Customer."No."), '', true, 0, false, 'CBS', Format(Customer."No."), 'CBS');
                    end;
                end;
                rec.Posted := true;
                rec.Modify(true);
                Message('Receipt Posted Successfully');
            end;
        end;

    end;

    //[Scope('OnPrem')]
    procedure PerformPostLine()
    begin
    end;

    //[Scope('OnPrem')]
    procedure CheckPostDated() Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetRange(ReceiptLine."Pay Mode", ReceiptLine."Pay Mode"::Cheque);
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine."Cheque/Deposit Slip Date" > Today then begin
                    Exists := true;
                    exit;
                    //cheque is post dated
                    // BAmount:=BAmount + ReceiptLine.Amount;
                end;
            until ReceiptLine.Next = 0;
        end;
    end;

    //[Scope('OnPrem')]
    procedure CheckBnkCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset;
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    local procedure OnAfGetCurrRecord()
    begin
        //xRec := Rec;
        FunctionName := '';
        DimVal.Reset;
        DimVal.SetRange(DimVal."Global Dimension No.", 1);
        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
        if DimVal.Find('-') then begin
            FunctionName := DimVal.Name;
        end;
        BudgetCenterName := '';
        DimVal.Reset;
        DimVal.SetRange(DimVal."Global Dimension No.", 2);
        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
        if DimVal.Find('-') then begin
            BudgetCenterName := DimVal.Name;
        end;
        BankName := '';
        BankAcc.Reset;
        BankAcc.SetRange(BankAcc."No.", Rec."Bank Code");
        if BankAcc.Find('-') then begin
            BankName := BankAcc.Name;
        end;
    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        // if rec."Customer Type"=rec."Customer Type"::Investment

        if rec.Posted = false then
            StatusEditable := true
        else
            StatusEditable := false;
    end;

    //[Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        OnAfGetCurrRecord;
        //CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        // DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer;
    begin
        //DocNoVisible := DocumentNoVisibility.FundsMgtDocumentNoIsVisible(DocType::Receipt,"No.");
    end;
}

