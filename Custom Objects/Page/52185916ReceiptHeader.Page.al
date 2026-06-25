page 52185916 "Receipt Header"
{
    DeleteAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE("Receipt Type" = CONST(Bank));
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;
    PromotedActionCategories = 'Import';

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
                    // Editable = rec.statuseditable;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = statuseditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = statuseditable;

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
                    // Editable = statuseditable;

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
                // field(BudgetCenterName; Rec.BudgetCenterName)//here
                // {
                //     Caption = 'Description';
                //     Editable = false;
                // }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic, Suite;

                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = true;
                    trigger OnValidate()
                    begin
                        ReceiptLine.reset();
                        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                        if ReceiptLine.FindFirst() then begin
                            repeat
                                if ReceiptLine.Description = '' then begin
                                    ReceiptLine.description := Rec.Dim4;
                                    ReceiptLine.modify();
                                end;
                            until ReceiptLine.Next() = 0;
                        end;
                    end;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = statuseditable;
                }
                // field("Currency Code"; Rec."Currency Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     // Editable = statuseditable;
                // }
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
                    // Editable = statuseditable;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;

                    trigger OnValidate()
                    var
                        Members: Record Members;
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."Member No");
                        if Members.Find('-') then begin
                            Rec."Group Name" := Members.Name;

                        end;
                        rec."Received From" := '';
                    end;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Name"; Rec."Group Name")
                {
                    Caption = 'Group/Member Name';
                    Editable = false;
                }

                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    // Editable = statuseditable;
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = statuseditable;
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
                // field("Group Code"; Rec."Group Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Group Name"; Rec."Group Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
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
                // field("Creation Doc Type"; Rec."Creation Doc Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }
                // field("Creation Doc No."; Rec."Creation Doc No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }

            }

            group(RemainingAmount)
            {
                ShowCaption = false;
                field("Remaining Amount"; Rec."Amount Recieved" - Rec."Total Amount")
                {
                    Caption = 'Unallocated Amount';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control1000000000; "Receipts Line")
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
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    msg: Text;
                    Customer: Record Customer;
                    Lease: Record Lease;
                    SalesInvoice: Record "Sales Header";
                    SalesLines: Record "Sales Line";
                    SendSMS: Codeunit SendSms;
                    Source: enum "SMS Source";
                begin
                    //Check Post Dated
                    if CheckPostDated then
                        Message('One of the Receipt Lines is Post Dated');
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec."No.");
                    if BankAccountLedgerEntry.Find('-') then begin
                        rec.Posted := true;
                        rec.Modify;
                        Commit();
                        Message('Receipt Posted Succesfully.');
                        CurrPage.close;
                    end else begin
                        //Post the transaction into the database
                        if rec.Posted = false then begin
                            ValidateLineAmounts(rec);
                            //Rec.TestField("Creation Doc Type");
                            CheckEmptyLines(rec);

                            PerformPost();
                            Message('Receipt Posted Succesfully.');
                            currPage.close;
                        end;
                    end;
                end;
            }
            action("Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post & Print';
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
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec."No.");
                    if BankAccountLedgerEntry.Find('-') then begin
                        rec.Posted := true;
                        rec.Modify;
                        Commit;
                        Message('Transaction Posted Succesfully.');
                        CurrPage.Close;
                    end else begin
                        ValidateLineAmounts(rec);
                        PerformPost();
                        Commit;
                        CurrPage.Close;
                    end;
                    // if rec.Posted = false then Error('Post the receipt before printing.');
                    rec.Reset;
                    rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::Receipt, true, true, Rec);
                    rec.Reset;
                end;
            }
            action("Suggest Credit Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestVendorBills;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Suggest Member loans';

                trigger OnAction()
                begin
                    // if Rec."Group Code" <> '' then begin
                    //     if not Confirm('Suggest Credit accounts for %1', true, Rec."Group Code") then exit;
                    // // end else begin
                    // //     if not Confirm('Suggest Savings accounts for %1', true, Rec."Member No") then exit;
                    // end;
                    if rec."Member No" = '' then begin
                        Error('Please select a member');
                    end;
                    if not Confirm('Suggest loans accounts for %1', true, Rec."Member No") then exit;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SetRange(ReceiptLine.Type, 'LOAN');
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Clear any line
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SetRange(ReceiptLine.Type, 'LOAN');
                    if ReceiptLine.Find('-') then begin
                        repeat
                            ReceiptLine.Delete;
                        until ReceiptLine.Next = 0;
                    end;
                    //Insert new accounts

                    CreditAccounts.Reset;
                    CreditAccounts.SetLoadFields("Total Balance");
                    CreditAccounts.SetRange(CreditAccounts."Member No.", Rec."Member No");
                    CreditAccounts.SetFilter("Total Balance", '>%1', 0);
                    if CreditAccounts.Find('-') then begin
                        repeat
                            CreditAccounts.calcfields("Outstanding Balance", "Outstanding Interest", "Total Balance");
                            if ReceiptLine.FindLast then
                                Line := ReceiptLine."Line No." + 1 else
                                Line += 1;
                            ReceiptLine.Init;
                            ReceiptLine.No := Rec."No.";
                            ReceiptLine.Type := 'LOAN';
                            ReceiptLine.Validate(Type);
                            ReceiptLine."Line No." := Line;
                            ReceiptLine."Account No." := CreditAccounts."Loan Account";
                            ReceiptLine."Account Name" := CreditAccounts."Loan Product Type Name";
                            ReceiptLine."Loan No." := CreditAccounts."Loan No.";
                            ReceiptLine."Transaction Type" := ReceiptLine."Transaction Type"::Armotised;
                            ReceiptLine.Validate("Loan No.");
                            ReceiptLine.Validate("Account No.");
                            // ReceiptLine."Amount Payable" := CreditAccounts.Repayment;
                            // ReceiptLine."Loan Oustanding Principal" := CreditAccounts."Outstanding Balance";
                            // ReceiptLine."Loan Outstanding Interest" := CreditAccounts."Outstanding Interest";
                            // ReceiptLine."Total Outstanding Loan" := CreditAccounts."Total Balance";
                            // ReceiptLine."Daily Interest" := CreditAccounts."Daily Interest";

                            ReceiptLine.Description := Rec.Dim4;
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
                var
                    ReceiptSetup: Record "Receipts and Payment Types";
                begin
                    if rec."Member No" = '' then begin
                        Error('Please select a member');
                    end;
                    if not Confirm('Suggest Savings accounts for %1', true, Rec."Member No") then exit;
                    // end;

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
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No");
                    SavingsAccounts.Setfilter("Product Category", '');
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
                            ReceiptLine."Account Name" := SavingsAccounts."Product Name";
                            ReceiptLine.Validate(Type);
                            ReceiptLine."Account No." := SavingsAccounts."No.";
                            ReceiptLine.Validate("Account No.");
                            ReceiptLine.Description := Rec.Dim4;
                            ReceiptLine."Amount Payable" := SavingsAccounts."Monthly Contribution";
                            ReceiptLine."Transaction Type" := ReceiptLine."Transaction Type"::" ";
                            ReceiptLine."Loan No." := '';
                            ReceiptLine."Total Outstanding Loan" := 0;
                            ReceiptLine."Loan Oustanding Principal" := 0;
                            ReceiptLine."Loan Outstanding Interest" := 0;
                            ReceiptLine."Daily Interest" := 0;
                            ReceiptLine.Insert(true);
                        until SavingsAccounts.Next = 0;
                    end;
                end;
            }

            action("Suggest Group Member Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestPayment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ReceiptSetup: Record "Receipts and Payment Types";
                    Signatories: record "Account Signatories";
                begin
                    if rec."Group Code" = '' then begin
                        Error('Please select a MFI no.');
                    end;
                    if not Confirm('Suggest Savings accounts for %1', true, Rec."Group Code") then exit;
                    // end;

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
                    Signatories.Reset();
                    Signatories.SetRange("Account No", Rec."Group Code");
                    if Signatories.findset() then begin
                        repeat
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Signatories."Member No.");
                            SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Chama Investment Account");
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
                                    ReceiptLine."Account Name" := SavingsAccounts."Product Name";
                                    ReceiptLine.Validate(Type);
                                    ReceiptLine."Account No." := SavingsAccounts."No.";
                                    ReceiptLine.Validate("Account No.");
                                    ReceiptLine.Description := Rec.Dim4;
                                    ReceiptLine."Amount Payable" := SavingsAccounts."Monthly Contribution";
                                    ReceiptLine."Transaction Type" := ReceiptLine."Transaction Type"::" ";
                                    ReceiptLine."Loan No." := '';
                                    ReceiptLine."Total Outstanding Loan" := 0;
                                    ReceiptLine."Loan Oustanding Principal" := 0;
                                    ReceiptLine."Loan Outstanding Interest" := 0;
                                    ReceiptLine."Daily Interest" := 0;
                                    ReceiptLine.Insert(true);
                                until SavingsAccounts.Next = 0;
                            end;
                        until Signatories.next = 0;
                    end;
                end;
            }
            // action("Suggest Previous Receipt")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = SuggestCustomerPayments;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     var
            //         ReceiptSetup: Record "Receipts and Payment Types";
            //         ReceiptHdr: record "Receipts Header";
            //         ReceiptLineII: Record "Receipt Line";
            //     begin
            //         if rec."Member No" = '' then begin
            //             Error('Please select a member');
            //         end;
            //         if not Confirm('Suggest Prevoius receipt for member -  %1', true, Rec."Member No") then exit;
            //         // end;

            //         ReceiptHdr.Reset();
            //         ReceiptHdr.SetRange(ReceiptHdr."Member No", Rec."Member No");
            //         ReceiptHdr.SetRange(Posted, true);
            //         if ReceiptHdr.FindLast() then begin
            //             ReceiptLineII.Reset();
            //             ReceiptLineII.SetRange(ReceiptLineII.No, ReceiptHdr."No.");
            //             if ReceiptLineII.FindFirst() then begin
            //                 ReceiptLine.Reset;
            //                 ReceiptLine.SetRange(No, Rec."No.");
            //                 if ReceiptLine.FindSet()
            //                 then
            //                     ReceiptLine.DeleteAll();
            //                 repeat
            //                     ReceiptLine.Init;
            //                     ReceiptLine.No := Rec."No.";
            //                     if ReceiptLine.FindLast then
            //                         Line := ReceiptLine."Line No." + 1 else
            //                         Line += 1;
            //                     ReceiptLine."Account Type" := ReceiptLineII."Account Type";
            //                     ReceiptLine."Line No." := Line;
            //                     ReceiptLine.Type := ReceiptLineII.Type;
            //                     ReceiptLine."Account Name" := ReceiptLineII."Account Name";
            //                     ReceiptLine.Validate(Type);
            //                     ReceiptLine."Account No." := ReceiptLineII."Account No.";
            //                     ReceiptLine.Validate("Account No.");
            //                     if rec.Dim4 <> '' then
            //                         ReceiptLine.Description := Rec.Dim4
            //                     else
            //                         ReceiptLine.Description := ReceiptLineII.Description;
            //                     if ReceiptLine."Account Type" = ReceiptLine."Account Type"::Savings then begin

            //                         ReceiptLine."Transaction Type" := ReceiptLine."Transaction Type"::" ";
            //                         ReceiptLine."Loan No." := '';
            //                         ReceiptLine."Total Outstanding Loan" := 0;
            //                         ReceiptLine."Loan Oustanding Principal" := 0;
            //                         ReceiptLine."Loan Outstanding Interest" := 0;
            //                         ReceiptLine."Daily Interest" := 0;
            //                     end
            //                     else
            //                         if ReceiptLine."Account Type" = ReceiptLine."Account Type"::Credit then begin
            //                             ReceiptLine."Loan No." := ReceiptLineII."Loan No.";
            //                             ReceiptLine."Transaction Type" := ReceiptLineII."Transaction Type";
            //                             ReceiptLine.Validate("Loan No.");
            //                             ReceiptLine.Validate("Account No.");
            //                         end;
            //                     ReceiptLine."Amount Payable" := ReceiptLineII."Amount Payable";
            //                     ReceiptLine.Amount := ReceiptLineII.Amount;
            //                     ReceiptLine.Insert(true);
            //                 until ReceiptLineII.next = 0;
            //             end;
            //         end;
            //     end;
            // }
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ReceiptSetup: Record "Receipts and Payment Types";
                begin
                    rec.Validate(Dim4);
                    rec.Validate("Total Amount");
                    CurrPage.Update;
                    Message('Page Refreshed');
                    //Clear any line
                end;
            }
            action("Clear unused Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear unused Lines';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ReceiptLine: Record "Receipt Line";
                begin
                    if not Confirm('Do you wish to clear all lines?', false) then exit;

                    rec.TestField(Posted, false);
                    ReceiptLine.Reset();
                    ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SetRange(ReceiptLine.Amount, 0);
                    if ReceiptLine.FindFirst() then
                        ReceiptLine.DeleteAll();
                    Message('Lines have been successfully cleared');
                end;
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = New;
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
            //             if Rec."No." <> '' then begin
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
            //         PromotedCategory = New;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
            group("Import Lines")
            {
                action(Import)
                {
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = Basic, Suite;

                    RunObject = XMLport "Receipt ";
                    trigger OnAction()
                    var
                        RecLines: Record "Receipt Line";
                    begin
                        if rec.Posted then error('You cannot import lines for a posted batch');
                        RecLines.Reset;
                        RecLines.SetRange(No, rec."No.");
                        if RecLines.findfirst() then
                            error('You cannot import receipt lines for a batch that has already been imported. Kindly clear lines first');
                    end;

                }
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
            ERROR('Please contact the system administrator to be setup as a receipting user');
        end;
        if UserSetup."Default Receipts Bank" = '' then begin
            Rec."Account Type" := Rec."Account Type"::"Bank Account";
            //ERROR('Please contact the system administrator to be setup as a receipting user');
        end;
    end;

    var
        noser: codeunit "No. Series";
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

        StatusEditable: Boolean;
        DocNoVisible: Boolean;
        Line: Integer;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record Loans;
        CheckoffAdvice: Codeunit "Periodic Activities";
        Loans: Record Loans;
        BankAccountLedgerEntry: Record "G/L Entry";
        SendSMS: Codeunit SendSms;
        LoanProcess: Codeunit "Loans Process";
        ProductFactory: record "Product Factory";
        JournalPosting: Codeunit "Journal Posting";
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";

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
        RemainingAmount: Decimal;
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
                Error('Please ensure that the Receipt Journal Template has avalue in Cash Office User Temp.');
            end;
            if USetup."Receipt Journal Batch" = '' then begin
                Error('Please ensure that the Receipt Journal Batch has avalue in Cash Office User Temp.');
            end;
        end
        else begin
            Error('Please ensure that the Administrator sets you up as a cashier in Cash office User Temp and assigns you a journal template and batch for receipting');
        end;

        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        rec.CalcFields("Total Amount");
        if (round(Rec."Total Amount", 0.01, '>')) <> (Rec."Amount Recieved") then begin
            Error('Please note that the Total Amount: %1 and the Amount Received: %2 Must be the same', Rec."Total Amount", Rec."Amount Recieved");
        end;

        //if any then the amount to be posted must be less the post dated amount
        if rec.Posted = true then begin
            Error('A Transaction Posted cannot be posted again');
        end;

        //check if the person received from has been selected
        //rec.TestField(Date);
        rec.TestField("Account No.");//"Bank Code");
                                     // rec.TestField("Global Dimension 1 Code");
                                     // rec.TestField("Shortcut Dimension 2 Code");
        rec.TestField("Received From");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(rec."Bank Code", Rec."Currency Code");

        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetFilter(Amount, '>0');
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine.Type = '' then
                    Error('Please ensure that the Receipt Type is inserted');

                //  if ReceiptLine.Type=ReceiptLine.Type::
                // if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then
                //     Error('Paymode is Mandatory on the Receipt Line');

                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                    // if ReceiptLine."Transaction No." = '' then begin
                    //     Error('Please ensure that the Transaction Number is inserted');
                    // end;

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
        end
        else begin
            Error('Please enter the amount on atleast one line');
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

        Rec.CalcFields("Total Amount");
        /*Insert the bank transaction*/
        //if tAmount > 0 then begin
        if Rec."Total Amount" > 0 then begin
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'CASHRECJNL';
            GenJnlLine."Line No." := 1;
            GenJnlLine."Posting Date" := rec.Date;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."External Document No." := Rec."Cheque No.";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."Account Type" := Rec."Account Type";//GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Rec."Account No.";//"Bank Code";//USetup."Default Receipts Bank";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := Rec."Total Amount";// (tAmount);
            GenJnlLine.Validate(GenJnlLine.Amount);

            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

            GenJnlLine.Description := CopyStr(rec.Dim4, 1, 90);
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;

            //insert the transaction lines into the database
            ReceiptLine.Reset;
            ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);
            ReceiptLine.setfilter(Amount, '>0');
            if ReceiptLine.Find('-') then begin
                repeat
                    RemainingAmount := 0;

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
                        if ReceiptLine."Transaction Type" <> ReceiptLine."Transaction Type"::Armotised then begin
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := JTemplate;
                            GenJnlLine."Journal Batch Name" := JBatch;
                            GenJnlLine."Source Code" := 'CASHRECJNL';
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := rec.Date;
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
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                GenJnlLine.Validate("Applies-to Doc. No.");
                                GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                            end;

                            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                            GenJnlLine.Description := CopyStr(ReceiptLine.Description, 1, 90);
                            GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            //                  GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                            //                  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                            GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                        end else
                            if ReceiptLine."Transaction Type" = ReceiptLine."Transaction Type"::Armotised then begin
                                //Armotize Interest
                                ReceiptLine.TestField("Account Type", ReceiptLine."Account Type"::Credit);
                                ReceiptLine.TestField("Loan No.");
                                Loans.get(ReceiptLine."Loan No.");
                                Loans.CalcFields("Daily Interest", "Outstanding Balance", "Outstanding Interest");
                                if Loans."Daily Interest" > 0 then begin
                                    if ProductFactory.Get(Loans."Loan Product Type") then begin
                                        ProductFactory.TestField("Loan Interest Account [G/L]");
                                        if ProductFactory."Loan Interest Account [G/L]" <> '' then begin
                                            //Daily Interest Due
                                            LineNo := LineNo + 1;
                                            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, "Gen. Journal Account Type"::Credit, receiptline.No, 'Daily Interest Capitalized ' + Loan."Loan No.", Loans."Daily Interest", Loans."Loan Account", rec.Date, "Gen. Journal Account Type"::"G/L Account",
                                            ProductFactory."Loan Interest Account [G/L]", ReceiptLine."Loan No.", ReceiptLine."Global Dimension 1 Code", ReceiptLine."Shortcut Dimension 2 Code", ReceiptLine."Transaction Type"::"Interest Due", ReceiptLine."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        end
                                        else
                                            Error('The product you are Armotize interest for %1, Does not have a valid Interest Receivable Account', Loans."Loan No.");
                                    end else
                                        Dialog.Error('The product you are Armotize interest for %1, Does not have a valid product in the setup', Loans."Loan No.");
                                end;
                                Loans.Validate("Outstanding Interest");
                                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                                RemainingAmount := ReceiptLine.Amount;

                                if GLine.Find('+') then begin LineNo := GLine."Line No."; end;
                                LineNo := LineNo + 1;

                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account No.";
                                GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type"::"Interest Paid";//Sacco
                                GenJnlLine."Loan No" := ReceiptLine."Loan No.";//Sacco
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                if RemainingAmount >= (Loans."Outstanding Interest" + Loans."Daily Interest") then begin
                                    GenJnlLine.Amount := -(Loans."Outstanding Interest" + Loans."Daily Interest");
                                    RemainingAmount := RemainingAmount - (Loans."Outstanding Interest" + Loans."Daily Interest");
                                end
                                else begin
                                    GenJnlLine.Amount := -RemainingAmount;
                                    RemainingAmount := 0;
                                end;
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                if ReceiptLine."Customer Payment On Account" then begin
                                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                    GenJnlLine.Validate("Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                                end;

                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := CopyStr(ReceiptLine.Description, 1, 90);
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                //                  GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                //                  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                                // Recover Principal
                                GenJnlLine.Reset();
                                GenJnlLine.SetRange("Journal Template Name", JTemplate);
                                GenJnlLine.SetRange("Journal Batch Name", JBatch);
                                if GenJnlLine.FindLast() then
                                    LineNo := LineNo + 1000
                                else
                                    LineNo := 1000;

                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account No.";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type"::Repayment;
                                GenJnlLine."Loan No" := ReceiptLine."Loan No.";
                                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                if (RemainingAmount > 0) then begin
                                    if RemainingAmount > Loans."Outstanding Balance" then begin
                                        if Dialog.Confirm('The transaction on line %1 for Loan : %2 will result to an overpayment. Do you wish to adjust the amount to pay?', false, ReceiptLine."Line No.", ReceiptLine."Loan No.") then
                                            exit;
                                        GenJnlLine.Amount := -RemainingAmount;
                                    end
                                    else
                                        GenJnlLine.Amount := -RemainingAmount;
                                end
                                else
                                    GenJnlLine.Amount := 0;

                                //GenJnlLine.Amount := (ReceiptLine.Amount - ReceiptLine."Loan Outstanding Interest") * -1;
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := CopyStr((ReceiptLine.Description) +
                                  ' Repayment', 1, 90);
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";
                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                            end;
                    end
                    else
                        if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                            ReceiptLine.Validate("Cheque/Deposit Slip Date");
                            if (ReceiptLine."Cheque/Deposit Slip Date" <= Today) then begin
                                if ReceiptLine."Transaction Type" <> ReceiptLine."Transaction Type"::Armotised then begin
                                    if GLine.Find('+') then begin LineNo := GLine."Line No."; end;
                                    LineNo := LineNo + 1;

                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine."Source Code" := 'CASHRECJNL';
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := rec.Date;
                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."Document Date" := Rec."Document Date";
                                    GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                    GenJnlLine."Account No." := ReceiptLine."Account No.";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
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
                                    GenJnlLine.Description := CopyStr(ReceiptLine.Description, 1, 90);
                                    GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    //                    GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                    //                    GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                    GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                end
                                else
                                    if ReceiptLine."Transaction Type" = ReceiptLine."Transaction Type"::Armotised then begin
                                        ReceiptLine.TestField("Account Type", ReceiptLine."Account Type"::Credit);
                                        ReceiptLine.TestField("Loan No.");
                                        Loans.Get(ReceiptLine."Loan No.");
                                        Loans.CalcFields("Daily Interest", "Outstanding Balance", "Outstanding Interest");
                                        if Loans."Daily Interest" > 0 then begin
                                            if ProductFactory.Get(Loans."Loan Product Type") then begin
                                                ProductFactory.TestField("Loan Interest Account [G/L]");
                                                if ProductFactory."Loan Interest Account [G/L]" <> '' then begin
                                                    //Interest Due
                                                    LineNo := LineNo + 1;
                                                    JournalPosting.PostJournal(JTemplate, JBatch, LineNo, "Gen. Journal Account Type"::Credit, receiptline.No, 'Daily Interest Capitalized ' + Loan."Loan No.", Loans."Daily Interest", Loans."Loan Account", rec.Date, "Gen. Journal Account Type"::"G/L Account",
                                                    ProductFactory."Loan Interest Account [G/L]", ReceiptLine."Loan No.", ReceiptLine."Global Dimension 1 Code", ReceiptLine."Shortcut Dimension 2 Code", ReceiptLine."Transaction Type"::"Interest due", ReceiptLine."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                                end
                                                else
                                                    Error('The product you are Armotize interest for %1, Does not have a valid Interest Receivable Account', Loans."Loan No.");
                                            end else
                                                Dialog.Error('The product you are Armotize interest for %1, Does not have a valid product', Loans."Loan No.");
                                        end;
                                        Loans.Validate("Outstanding Interest");
                                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");

                                        RemainingAmount := ReceiptLine.Amount;

                                        GenJnlLine.Reset();
                                        GenJnlLine.SetRange("Journal Template Name", JTemplate);
                                        GenJnlLine.SetRange("Journal Batch Name", JBatch);
                                        if GenJnlLine.FindLast() then
                                            LineNo := LineNo + 1000
                                        else
                                            LineNo := 1000;

                                        GenJnlLine.Init;
                                        GenJnlLine."Journal Template Name" := JTemplate;
                                        GenJnlLine."Journal Batch Name" := JBatch;
                                        GenJnlLine."Source Code" := 'CASHRECJNL';
                                        GenJnlLine."Line No." := LineNo;
                                        GenJnlLine."Posting Date" := rec.Date;
                                        GenJnlLine."Document No." := ReceiptLine.No;
                                        GenJnlLine."Document Date" := Rec."Document Date";
                                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                                        GenJnlLine.Validate(GenJnlLine."Account No.");
                                        GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type"::"Interest Paid";//Sacco
                                        GenJnlLine."Loan No" := ReceiptLine."Loan No.";//Sacco
                                        GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                        GenJnlLine."Currency Code" := Rec."Currency Code";
                                        GenJnlLine.Validate(GenJnlLine."Currency Code");

                                        if RemainingAmount >= (Loans."Outstanding Interest" + Loans."Daily Interest") then begin
                                            GenJnlLine.Amount := -(Loans."Outstanding Interest" + Loans."Daily Interest");
                                            RemainingAmount := RemainingAmount - (Loans."Outstanding Interest" + Loans."Daily Interest");
                                        end
                                        else begin
                                            GenJnlLine.Amount := -RemainingAmount;
                                            RemainingAmount := 0;
                                        end;
                                        GenJnlLine.Validate(GenJnlLine.Amount);
                                        if ReceiptLine."Customer Payment On Account" then begin
                                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                            GenJnlLine.Validate("Applies-to Doc. No.");
                                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                            GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                                        end;
                                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                        GenJnlLine.Description := CopyStr(ReceiptLine.Description, 1, 90);
                                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                        //                    GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                        //                    GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                        GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";

                                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                                        GenJnlLine.Reset();
                                        GenJnlLine.SetRange("Journal Template Name", JTemplate);
                                        GenJnlLine.SetRange("Journal Batch Name", JBatch);
                                        if GenJnlLine.FindLast() then
                                            LineNo := LineNo + 1000
                                        else
                                            LineNo := 1000;

                                        GenJnlLine.Init;
                                        GenJnlLine."Journal Template Name" := JTemplate;
                                        GenJnlLine."Journal Batch Name" := JBatch;
                                        GenJnlLine."Source Code" := 'CASHRECJNL';
                                        GenJnlLine."Line No." := LineNo;
                                        GenJnlLine."Posting Date" := rec.Date;
                                        GenJnlLine."Document No." := ReceiptLine.No;
                                        GenJnlLine."Document Date" := Rec."Document Date";
                                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                                        GenJnlLine.Validate(GenJnlLine."Account No.");
                                        GenJnlLine."Transaction Type" := ReceiptLine."Transaction Type"::Repayment;
                                        GenJnlLine."Loan No" := ReceiptLine."Loan No.";
                                        GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                        GenJnlLine."Currency Code" := Rec."Currency Code";
                                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                                        if (RemainingAmount > 0) then begin
                                            if RemainingAmount > Loans."Outstanding Balance" then begin
                                                if Dialog.Confirm('The transaction on line %1 for Loan : %2 will result to an overpayment. Do you wish to adjust the amount to pay?', false, ReceiptLine."Line No.", ReceiptLine."Loan No.") then
                                                    exit;
                                                GenJnlLine.Amount := -RemainingAmount;
                                            end
                                            else
                                                GenJnlLine.Amount := -RemainingAmount;
                                        end
                                        else
                                            GenJnlLine.Amount := 0;

                                        GenJnlLine.Validate(GenJnlLine.Amount);
                                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                        GenJnlLine.Description := CopyStr((ReceiptLine.Description) +
                                          ' Repayment' + StrInvoices, 1, 90);
                                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                        GenJnlLine."Dimension Set ID" := ReceiptLine."Dimension Set ID";
                                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                    end;
                            end
                            else
                                error('Cheque Date cannot be greater than today');
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

            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post New", GenJnlLine);
            Post := JournalPosted.PostedSuccessfully();

            //if Post then begin
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
                    if receiptline."Transaction Type" = ReceiptLine."Transaction Type"::Armotised then
                        LoanProcess.ClearDailyInterest(ReceiptLine."Loan No.");
                until ReceiptLine.Next = 0;
            end;
            //  IF CONFIRM('Do you want to send SMS notifications to Member?', FALSE)=TRUE THEN BEGIN
            // if Rec."Insurance Claim no" = '' then begin
            //     if Rec."Member No" <> '' then begin
            //         if ReceiptsHeader.Get(rec."No.") then begin

            //             if Members.Get(rec."Member No") then begin

            //                 CompInfo.Get;
            //                 //     SendSMS.SendSms(SourceType::"Deposit Confirmation", Members."Phone No.", 'You have Deposited KSH ' + Format("Amount Recieved") + ', on' + Format(Today) + ' ' + Format(Time) +
            //                 //    '. to your account at ' + ' ' + CompInfo.Name, Rec."No.", Rec."Member No", false);
            //                 // msg := 'Dear ' + Customer.Name + ', Your receipt for the month of this month' + ' is ' + Format(rec."Amount Recieved") + ' has been received. ';
            //                 // SendSMS.SendSms(Source::Tenants, Customer."Phone No.", msg, Format(Customer."No."), '', true, 0, false, 'CBS', Format(Customer."No."), 'CBS');
            //             end;
            //         end;
            //     end;
            // end;
            rec.Posted := true;
            rec.Modify(true);
            //Message('Receipt Posted Successfully');

            //end;
        end;

    end;


    procedure ValidateLineAmounts(ReceiptHeader: record "Receipts Header")
    var
        ReceiptLines: Record "Receipt Line";
    begin
        ReceiptLines.reset;
        ReceiptLines.SetRange(No, ReceiptHeader."No.");
        ReceiptLines.SetRange(Posted, FALSE);
        ReceiptLines.SetFilter(Amount, '>%1', 0);
        If ReceiptLines.FindFirst() then begin
            repeat
                if ReceiptLines."Pay Mode" = ReceiptLines."Pay Mode"::" " then
                    error('Please select a payment mode for line %1', ReceiptLines."Line No.");
                ReceiptLines.Validate(ReceiptLines.Amount);
            until ReceiptLines.Next() = 0;
        end;
    end;

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


    local procedure CheckEmptyLines(ReceiptHeader: record "Receipts Header")
    var
        ReceiptLines: Record "Receipt Line";
    begin
        ReceiptLines.reset;
        ReceiptLines.SetRange(No, ReceiptHeader."No.");
        ReceiptLines.SetRange(Posted, FALSE);
        ReceiptLines.setrange(Amount, 0);
        If ReceiptLines.FindFirst() then begin
            repeat
                Error('Please Clear any lines with zero amount using action provided');
            until ReceiptLines.Next() = 0;
        end;
    end;
}

