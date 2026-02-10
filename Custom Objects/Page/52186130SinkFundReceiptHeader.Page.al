page 52186130 "SinkFund Receipt Header"
{
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE("Receipt Type" = CONST(Bank),
                            "SinkFund Receipt" = CONST(true));

                            PromotedActionCategories = 'EDMS';

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("CIC Claim No(External)"; Rec."CIC Claim No(External)")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Consolidated Doc No"; Rec."Consolidated Doc No")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."Member No");
                        if Members.Find('-') then begin
                            Rec."Received From" := 'CIC Insurance-' + Members."No." + ' ' + Members.Name;
                            Rec."On Behalf Of" := 'CIC Insurance-' + Members."No." + ' ' + Members.Name;
                        end;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;

                    trigger OnValidate()
                    begin
                        FunctionName := '';
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 1);
                        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
                        if DimVal.Find('-') then begin
                            FunctionName := DimVal.Name;
                        end;
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
                    Editable = statuseditable;

                    trigger OnValidate()
                    begin
                        BudgetCenterName := '';
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 2);
                        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
                        if DimVal.Find('-') then begin
                            BudgetCenterName := DimVal.Name;
                        end;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
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

                    trigger OnValidate()
                    begin
                        if Rec."Account No." <> 'BNK0000054' then
                            Rec."Account No." := '';
                    end;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("SinkFund Account  Balance"; Rec."SinkFund Account  Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;

                    trigger OnValidate()
                    var
                        BankAccount: Record "Bank Account";
                        BalAmount: Decimal;
                    begin
                        BalAmount := 0;
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", Rec."Account No.");
                        if BankAccount.Find('-') then begin
                            BankAccount.CalcFields("Balance (LCY)");
                            BalAmount := BankAccount."Balance (LCY)" * -1;
                        end;

                        if Rec."Amount Recieved" > (BalAmount) then
                            Rec."Amount Recieved" := 0;
                        if Rec."Amount Recieved" > (BalAmount) then
                            Message('Contact Finance to Credit your Account with Receipts from CIC');
                    end;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Insurance Claim no"; Rec."Insurance Claim no")
                {
                    ApplicationArea = Basic, Suite;
                    //DrillDownPageID = "SinkFund Notice";
                    Lookup = true;
                    //LookupPageID = "SinkFund Notice";
                }
                field("Claim For"; Rec."Claim For")
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
            }
            part(Control1000000000; "Sinkfund Receipts Line")
            {
                Editable = statuseditable;
                SubPageLink = No = FIELD("No.");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF rec.Posted = FALSE THEN ERROR('Post the receipt before printing.');
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(39005883, true, true, Rec);
                    Rec.Reset;
                end;
            }
            // action(Post)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Post';
            //     Image = Post;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ShortCutKey = 'F9';

            //     trigger OnAction()
            //     begin
            //         //Check Post Dated
            //         if CheckPostDated then
            //             Error('One of the Receipt Lines is Post Dated');
            //         BankAccountLedgerEntry.Reset;
            //         BankAccountLedgerEntry.SetRange("Document No.", Rec."No.");
            //         if BankAccountLedgerEntry.FindFirst then begin
            //             Post := true;
            //             Rec.Modify;
            //         end else
            //             //Post the transaction into the database
            //             if Post = false then
            //                 PerformPost();
            //     end;
            // }
            action("Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    //Check Post Dated
                    if CheckPostDated then
                        Error('One of the Receipt Lines is Post Dated');

                    //Post the transaction into the database
                    PerformPost();
                    Commit;
                    rec.Posted := true;
                    rec."Date Posted":=Today;
                    rec."Time Posted":=Time;
                    rec.modify;
                    if Rec.Posted = false then Error('Post the receipt before printing.');
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(39005883, true, true, Rec);
                    Rec.Reset;
                end;
            }
            action("Suggest Credit Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestVendorBills;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm('Suggest Credit accounts for %1', true, Rec."Group Code") then exit;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(No, Rec."No.");
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(No, Rec."No.");
                    ReceiptLine.SetRange(Type, 'CREDIT');
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Insert new accounts

                    CreditAccounts.Reset;
                    CreditAccounts.SetRange(CreditAccounts."Group Account No", Rec."Group Code");
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
                            ReceiptLine."Account No." := CreditAccounts."No.";
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

                trigger OnAction()
                begin
                    if not Confirm('Suggest Savings accounts for %1', true, Rec."Group Code") then exit;
                    //Clear any line
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
                    SavingsAccounts.SetRange(SavingsAccounts."Group Account No", Rec."Group Code");
                    if SavingsAccounts.Find('-') then begin
                        repeat

                            ReceiptLine.Init;
                            ReceiptLine.No := Rec."No.";
                            if ReceiptLine.FindLast then
                                Line := ReceiptLine."Line No." + 1 else
                                Line += 1;
                            ReceiptLine.Type := 'SAVINGS';
                            ReceiptLine.Validate(Type);
                            ReceiptLine."Line No." := Line;
                            ReceiptLine."Account No." := SavingsAccounts."No.";
                            ReceiptLine.Validate("Account No.");
                            ReceiptLine.Insert(true);
                        until SavingsAccounts.Next = 0;
                    end;
                end;
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = New;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MA'; // Member Application
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                // UploadToEDMS(Rec, FileName, FileContentsB64);
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
                    PromotedCategory = New;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No.");
                    // RunPageMode = Create;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfGetCurrRecord;
        CurrPageUpdate;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //********************************JACK**********************************//

        Rcpt.Reset;
        Rcpt.SetRange(Rcpt.Posted, false);
        Rcpt.SetRange(Rcpt."Created By", UserId);
        if Rcpt.Count > 0 then begin
            if Confirm('There are still some unposted receipts. Continue?', false) = false then begin
                Error('There are still some unposted receipts. Please utilise them first');
            end;
        end;

        //********************************END **********************************//
        //CurrPage.UPDATE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // "Responsibility Center" := UserMgt.GetSalesFilter();
        // //Add dimensions if set by default here
        // "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        // "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        // "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        // Validate("Shortcut Dimension 3 Code");
        // "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        Rec.Status := Rec.Status::" ";
        Rec."Receipt Type" := Rec."Receipt Type"::Bank;
        Rec."SinkFund Receipt" := true;
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
        Rec."Account No." := 'BNK0000054';
        Rec."Bank Name" := 'CIC Receipts Cashier Holding Account';
        BankAcc.Reset;
        if BankAcc.Get('BNK0000054') then begin
            BankAcc.CalcFields("Balance (LCY)");
            Rec."SinkFund Account  Balance" := BankAcc."Balance (LCY)";
            Rec."Account Type" := Rec."Account Type"::"Bank Account";
        end;
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin

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
        // if UserMgt.GetSalesFilter() <> '' then begin
        //     FilterGroup(2);
        //     SetRange("Responsibility Center", UserMgt.GetSalesFilter());
        //     FilterGroup(0);
        // end;

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
        //PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        USetup: Record "Cash Office User Template";
        //RegMgt: Codeunit "Register Management";
        RegisterNumber: Integer;
        FromNumber: Integer;
        ToNumber: Integer;
        StrInvoices: Text[250];
        // UserMgt: Codeunit "User Setup Management BR";
        // JournalPosted: Codeunit "Journal Post Successful";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        IsCashAccount: Boolean;

        StatusEditable: Boolean;
        DocNoVisible: Boolean;
        Line: Integer;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        //CheckoffAdvice: Codeunit "Periodic Activities";
        Loans: Record Loans;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        SinkFundReportInformation: Record "SinkFund Report Information";
        //SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        ReceiptsHeader: Record "Receipts Header";
        Members: Record Members;
        CompInfo: Record "Company Information";

    //[Scope('OnPrem')]
    procedure PerformPost()
    begin

        IsCashAccount := false;
        BankAcc.Reset;
        if BankAcc.Get(Rec."Bank Code") then begin
            if BankAcc."Bank Type" = BankAcc."Bank Type"::Cash then
                IsCashAccount := true;
        end;

        USetup.Reset;
        USetup.SetRange(USetup.UserID, UserId);
        if USetup.FindFirst then begin
            if USetup."Receipt Journal Template" = '' then begin
                Error('Please ensure that the Administrator sets you up as a cashier');
            end;
            if USetup."Receipt Journal Batch" = '' then begin
                Error('Please ensure that the Administrator sets you up as a cashier');
            end;
            if USetup."Default Receipts Bank" = '' then begin
                Error('Please ensure that the Administrator sets you up as a cashier');
            end;
        end
        else begin
            Error('Please ensure that the Administrator sets you up as a cashier');
        end;


        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        Rec.CalcFields(Rec."Total Amount");
        if Rec."Total Amount" <> Rec."Amount Recieved" then begin
            Error('Please note that the Total Amount and the Amount Received Must be the same');
        end;

        //if any then the amount to be posted must be less the post dated amount
        if Rec.Posted = true then begin
            Error('A Transaction Posted cannot be posted again');
        end;

        //check if the person received from has been selected
        Rec.TestField(Date);
        Rec.TestField("Account No.");//"Bank Code");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
        Rec.TestField("Received From");
        Rec.TestField("Insurance Claim no");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");

        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::" " then
                    Error('Paymode is Mandatory on the Receipt Line');

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
            GenJnlLine."Posting Date" := Rec.Date;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."Account Type" := Rec."Account Type";
            GenJnlLine."Account No." := Rec."Account No.";
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

            GenJnlLine.Description := CopyStr(Rec."Received From" + 'Invoices:' + StrInvoices, 1, 50);
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
                        GenJnlLine."Posting Date" := Rec.Date;
                        GenJnlLine."Document No." := ReceiptLine.No;
                        GenJnlLine."Document Date" := Rec."Document Date";

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
                            //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                            GenJnlLine.Validate("Applies-to Doc. No.");
                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                            GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                        end;

                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") +
                          ' Invoices:' + StrInvoices, 1, 50);
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        //                  GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                        //                  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                        GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                    end
                    else
                        if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                            if ReceiptLine."Cheque/Deposit Slip Date" <= Today then begin
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";


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
                                GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode")
                                + ' Invoices:' + StrInvoices, 1, 50);
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                //                    GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                //                    GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                            end;
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
            //Post := JournalPosted.PostedSuccessfully();
            if Post then begin
                //Update Header
                Rec.Cashier := UserId;
                //"Bank Code":=USetup."Default Receipts Bank";
                Rec.Posted := true;
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
                if Rec."Insurance Claim no" <> '' then begin
                    if Rec."Member No" <> '' then begin
                        if ReceiptsHeader.Get(Rec."No.") then begin

                            if Members.Get(Rec."Member No") then begin

                                CompInfo.Get;
                                //SendSMS.SendSms(SourceType::"Deposit Confirmation", Members."Phone No.", 'Dear Member,your claim has been received from Insurance on ' + Format(Today) + ' ' + Format(Time) +
                                //'. Contact any of our branches ' + ' ' + CompInfo.Name, "No.", "Member No", false);
                            end;
                        end;
                    end;
                end;
                // SinkFundReportInformation.Reset;
                // SinkFundReportInformation.SetRange(No, Rec."Insurance Claim no");
                // SinkFundReportInformation.SetRange("Insurance Payment Status", SinkFundReportInformation."Insurance Payment Status"::"Pending Payment");
                // if SinkFundReportInformation.Find('-') then begin
                //     SinkFundReportInformation."Insurance Payment Status" := SinkFundReportInformation."Insurance Payment Status"::"Insurance Paid";
                //     SinkFundReportInformation.Modify;
                // end;


                // SinkFundReportInformation.Reset;
                // SinkFundReportInformation.SetRange(No, Rec."Insurance Claim no");
                // SinkFundReportInformation.SetRange("Insurance Payment Status", SinkFundReportInformation."Insurance Payment Status"::"Principal Amount Paid");
                // if SinkFundReportInformation.Find('-') then begin
                //     SinkFundReportInformation."Insurance Payment Status" := SinkFundReportInformation."Insurance Payment Status"::"Beneficiary Claim Paid";
                //     SinkFundReportInformation.Modify;
                // end;
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
        if Rec.Posted = false then
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
    // DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer;
    begin
        //DocNoVisible := DocumentNoVisibility.FundsMgtDocumentNoIsVisible(DocType::Receipt,"No.");
    end;
}

