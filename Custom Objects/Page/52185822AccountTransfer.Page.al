page 52185822 "Account Transfer"
{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Account Transfer Header";
    PromotedActionCategories = 'New,Process,Reports,Workflow Actions,Member Accounts,Clear Destination Accounts,Refresh,Send SMS';
    DeleteAllowed = FALSE;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = HeaderA;
                    ApplicationArea = Basic, Suite;
                    visible = false;
                }
                field("Member No"; Rec."Member No")
                {
                    Editable = HeaderA;
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Editable = HeaderA;
                    ApplicationArea = Basic, Suite;
                }
                field("Recover Arrears"; Rec."Recover Arrears")
                {
                    Editable = HeaderA;
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                // field(Remarks; Rec.Remarks)
                // {
                //     Editable = HeaderA;
                //     ApplicationArea = Basic, Suite;
                // }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;

                    // trigger OnValidate()
                    // begin
                    //     AControl;
                    // end;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }

                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Debits"; Rec."Total Debits")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;

                }
                field("Total Credits"; Rec."Total Credits")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    Enabled = RejectApproved;
                    ApplicationArea = Basic, Suite;
                }

            }
            // group(Control17)
            // {
            //     ShowCaption = false;

            part("Account Transfers-Source [ Debit ]"; "Account Transfer Source")
            {
                Caption = 'Account Transfers-Source [ Debit ]';
                Editable = SourceA;
                SubPageLink = "No." = FIELD(No);
                ApplicationArea = Basic, Suite;
            }
            part("Account Transfers-Destination [ Credit ]"; "Account Transfer Destination")
            {
                Caption = 'Account Transfers-Destination [ Credit ]';
                Editable = DestinationA;
                SubPageLink = "No." = FIELD(No);
                ApplicationArea = Basic, Suite;
            }
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action("Print Transfer")
                {
                    Caption = 'Print Transfer';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        TransferRec: Record "Account Transfer Header";
                    begin
                        TransferRec.Reset();
                        TransferRec.SetRange(No, Rec.No);
                        if TransferRec.FindFirst() then
                            Report.Run(Report::"Account Transfer", true, false, TransferRec);
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
                        TransDestination: record "Account Transfer Destination";
                        TransType: record "Transaction Types";
                        TransCharges: record "Transaction Charges";
                        SavLedger: record "Savings Ledger Entry";
                        OtherAccTransfers: record "Account Transfer Header";
                        UsersetUp: record "User Setup";
                        CreditAcc: record "Credit Accounts";
                    begin
                        if rec.Status <> rec.Status::Approved then
                            Error(DocMustbeApproved);
                        UsersetUp.get(UserId);
                        //CalcCharges;
                        AccountTransferSource.Reset;
                        AccountTransferSource.SetRange(AccountTransferSource."No.", rec.No);
                        AccountTransferSource.setfilter(AccountTransferSource."Source Amount", '>0');
                        if AccountTransferSource.Find('-') then begin
                            repeat
                                if Account.Get(AccountTransferSource."Source Account No.") then begin
                                    if Account."Member No." = UsersetUp."Member No." then Error('You are not allowed to transact on your own account.');
                                end;
                                if CreditAcc.get(AccountTransferSource."Source Account No.") then begin
                                    if Account."Member No." = UsersetUp."Member No." then Error('You are not allowed to transact on your own account.');
                                end;
                            until AccountTransferSource.Next = 0;
                        end;
                        TransDestination.Reset;
                        TransDestination.SetRange(TransDestination."No.", rec.No);
                        TransDestination.setfilter(TransDestination."Destination Amount", '>0');
                        if TransDestination.Find('-') then begin
                            repeat
                                if Account.Get(TransDestination."Destination Account No.") then begin
                                    if Account."Member No." = UsersetUp."Member No." then Error('You are not allowed to transact on your own account.');
                                end;
                                if CreditAcc.get(TransDestination."Destination Account No.") then begin
                                    if Account."Member No." = UsersetUp."Member No." then Error('You are not allowed to transact on your own account.');
                                end;
                            until TransDestination.Next = 0;
                        end;

                        //Mark Transaction Posted...
                        //IF AccountTransferHeader.GET(No) THEN
                        AccountTransferHeader.Reset;
                        AccountTransferHeader.SetRange(AccountTransferHeader.No, Rec.No);
                        if AccountTransferHeader.Find('-') then begin
                            SavingsLedgerEntry.Reset;
                            SavingsLedgerEntry.SetRange("Document No.", AccountTransferHeader.No);
                            if SavingsLedgerEntry.Find('-') then begin
                                Message('This Requisition is already paid');
                                AccountTransferHeader.Posted := true;
                                AccountTransferHeader."Time Posted" := time;
                                AccountTransferHeader."Date Posted" := today;
                                AccountTransferHeader.Modify;
                                exit;
                            end;
                        end;
                        SaccoT.PostTransfers(Rec);
                        CurrPage.Close();
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
                // action(Print)
                // {
                //     Caption = 'Print';
                //     Image = Print;
                //     ApplicationArea = Basic, Suite;

                //     trigger OnAction()
                //     begin
                //         /*BTRANS.RESET;
                //         BTRANS.SETRANGE(BTRANS.No,No);
                //         IF BTRANS.FIND('-') THEN BEGIN
                //         //REPORT.Run(52185861,TRUE,TRUE,BTRANS);
                //         END;
                //         */

                //     end;
                // }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic, Suite;

                    // trigger OnAction()
                    // var
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    // end;
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RecordId);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action("Re-Open ")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        if rec.Posted then error('Document already posted');
                        if (rec.Status = rec.Status::Approved) or (rec.Status = rec.Status::Rejected) then begin
                            rec.Status := rec.Status::Open;
                            rec.Modify;
                            Message('Document open successfuly');
                        end
                        else
                            Error('This document must either be approved or rejected!');
                    end;
                }
                // action(Comment)
                // {
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     // RunObject = Page "Approval Comments";
                //     // Visible = OpenApprovalEntriesExistForCurrUser;
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        TransactionCharges: Record "Transaction Charges";
                        AccountTypes: Record "Product Factory";
                        SavingsACC: Record "Savings Accounts";
                        GenSetup: Record "General Set-Up";
                        transdest: Record "Account Transfer Destination";
                        Loans: record Loans;
                        PrevPostedTransfers: record "Account Transfer Source";
                        TariffDetails: Record "Tiered Charges Lines";
                        TChargeAmount: Decimal;
                        ChargeAmount: Decimal;
                        TransSource: record "Account Transfer Source";
                        ExciseDuty: Decimal;
                    begin

                        BSched.Reset;
                        BSched.SetRange(BSched."No.", Rec.No);
                        BSched.SetRange(BSched."Source Account Type", BSched."source account type"::Savings);
                        BSched.Setfilter("Source Amount", '>0');
                        if BSched.FindSet() then begin
                            repeat
                                if SavingsACC.get(BSched."Source Account No.") then begin
                                    if AccountTypes.Get(SavingsACC."Product Type") then begin
                                        if AccountTypes."Account Transfer Charges" <> '' then begin

                                            if Format(AccountTypes."Account Transfer Charge Period") <> '' then begin

                                                PrevPostedTransfers.Reset;
                                                PrevPostedTransfers.setrange("Source Account No.", BSched."Source Account No.");
                                                PrevPostedTransfers.setcurrentkey("Date Posted");
                                                PrevPostedTransfers.SetAscending("Date Posted", false);
                                                PrevPostedTransfers.setrange(posted, true);
                                                if PrevPostedTransfers.find('-') then begin
                                                    if calcdate(AccountTypes."Account Transfer Charge Period", PrevPostedTransfers."Date Posted") > Rec."Transaction Date" then begin
                                                        GenSetup.Get;
                                                        //Charges
                                                        TChargeAmount := 0;

                                                        //Account transfer Header -posted precviously for the account

                                                        TransactionCharges.Reset;
                                                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", AccountTypes."Account Transfer Charges");
                                                        if TransactionCharges.FindSet() then begin
                                                            repeat

                                                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                                                    ChargeAmount := 0;
                                                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                                                        ChargeAmount := (BSched."Source Amount" * TransactionCharges."Percentage of Amount") * 0.01
                                                                    else
                                                                        ChargeAmount := TransactionCharges."Charge Amount";

                                                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                                                        TariffDetails.Reset;
                                                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                                        if TariffDetails.FindSet() then begin
                                                                            repeat
                                                                                if (BSched."Source Amount" >= TariffDetails."Lower Limit") and (BSched."Source Amount" <= TariffDetails."Upper Limit") then begin
                                                                                    if TariffDetails."Use Percentage" = true then begin
                                                                                        ChargeAmount := BSched."Source Amount" * TariffDetails.Percentage * 0.01;
                                                                                    end else begin
                                                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                                                    end;
                                                                                end;
                                                                            until TariffDetails.Next = 0;
                                                                        end;
                                                                    end;
                                                                    TChargeAmount := TChargeAmount + ChargeAmount;

                                                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty")
                                                                      and (TransactionCharges."Recover Excise Duty" = true) then begin
                                                                        ExciseDuty := Gensetup."Excise Duty (%)" * ChargeAmount * 0.01 + ChargeAmount;
                                                                        TChargeAmount := TChargeAmount + ChargeAmount;
                                                                    end;
                                                                end;
                                                            until TransactionCharges.Next = 0;
                                                        end;
                                                    end;
                                                end
                                            end;
                                        end;
                                    end;
                                end;

                            until BSched.Next = 0;
                        end;

                        if rec.Status <> rec.Status::Open then
                            Error(DocMustbeOpen);

                        //rec.TestField(rec."Transaction Type");


                        rec.CalcFields(rec."Total Credits", rec."Total Debits");
                        if rec."Total Credits" <> rec."Total Debits" then
                            Error(AmountErrorTxt);

                        rec."Created By" := UserId;
                        rec."Transaction Date" := Today;
                        rec."Transaction Time" := Time;
                        rec.Modify;

                        TransSource.reset;
                        TransSource.setrange("No.", rec.No);
                        if not TransSource.find('-') then
                            Error('No Source Account Specified');

                        TransDest.reset;
                        TransDest.setrange("No.", rec.No);
                        if not TransDest.find('-') then
                            Error('No Destination Account Specified')
                        else begin
                            repeat
                                if TransDest."Destination Loan No." <> '' then
                                    if TransDest."Destination Transaction Type" = TransDest."Destination Transaction Type"::" " then Error('Destination Transaction Type is required for all loan transactions.');
                            until TransDest.next = 0;
                        end;

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest/Reopen';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // if rec.Status <> rec.Status::"Pending Approval" then begin
                        //     if not confirm('Do you wish to re-open this document?') then
                        //         exit
                        //     else begin
                        //         if rec.Posted then error('Document already posted');
                        //         rec.Status := Rec.Status::Open;
                        //         rec.Modify();
                        //         Message('Document re-opened successfully');
                        //     end;
                        // end
                        // else begin
                        if rec.Posted then Error('Document already posted');
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        // end;
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(No);
                    RunPageView = where(Types = CONST(comment));
                }
                action("Reject Approved Document")
                {
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = RejectApproved;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        if DelChr(rec."Rejection Reason", '=', ' ') = '' then Error('Specify reason for rejection');
                        //rec.TestField(rec.Status, rec.Status::Approved);
                        rec.TestField(rec.Posted, false);
                        rec.TestField(rec."Rejection Reason");
                        if Confirm('Do you want to reject the document?') then begin
                            rec.Status := rec.Status::Rejected;
                            rec.Modify;
                        end;
                    end;
                }
            }
            group("Suggest Member Accounts")
            {
                action("Suggest Savings Accounts")
                {
                    Caption = 'Suggest Source Accounts';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        SavingsREC: Record "Savings Accounts";
                        TransSource: Record "Account Transfer Source";
                    begin
                        rec.TestField(posted, false);
                        rec.testfield(status, rec.status::open);

                        TransSource.reset;
                        TransSource.setrange("No.", rec.No);
                        if TransSource.find('-') then
                            TransSource.deleteall;

                        SavingsREC.Reset;
                        SavingsREC.SetRange(SavingsREC."Member No.", rec."Member No");
                        SavingsREC.setfilter("Product Category", '<>%1', SavingsREC."Product Category"::"Entrance Fee");
                        SavingsREC.SetLoadFields("Balance (LCY)");
                        if SavingsREC.Find('-') then begin
                            repeat
                                TransSource.Init;
                                TransSource."Entry No." := TransSource."Entry No." + 1;
                                TransSource."No." := rec.No;
                                TransSource."Source Account Type" := TransSource."Source Account Type"::Savings;
                                TransSource."Source Account No." := SavingsREC."No.";
                                TransSource."Source Account Name" := SavingsREC.Name;
                                TransSource."Product Name" := SavingsREC."Product Name";
                                TransSource."Product Code" := SavingsREC."Product Type";
                                TransSource."Transfer Type" := rec."Transfer Type";
                                TransSource."Member No." := SavingsREC."Member No.";
                                TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::" ";
                                TransSource.Insert(true);
                                TransSource.Validate(TransSource."Source Account No.");
                                TransSource.Modify;
                            until SavingsREC.Next = 0;
                        end;
                        Message('Source Accounts Updated Successfully');

                    end;
                }
                action("Suggest Loans")
                {
                    Caption = 'Suggest Source Loans';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        CreditAcc: Record Loans;
                        TransSource: Record "Account Transfer Source";
                    begin
                        rec.TestField(posted, false);
                        rec.testfield(status, rec.status::open);
                        TransSource.reset;
                        TransSource.setrange("No.", rec.No);
                        if TransSource.find('-') then
                            TransSource.deleteall;


                        CreditAcc.Reset;
                        CreditAcc.SetRange(CreditAcc."Member No.", rec."Member No");
                        CreditAcc.SetRange(posted, true);
                        //CreditAcc.setfilter("Product Category", '<>%1&<>%2', SavingsREC."Product Category"::"Unallocated Fund", SavingsREC."Product Category"::"Entrance Fee");
                        if CreditAcc.Find('-') then begin
                            repeat
                                CreditAcc.CalcFields("Total Balance");
                                if CreditAcc."Total Balance" <> 0 then begin
                                    TransSource.Init;
                                    TransSource."Entry No." := TransSource."Entry No." + 1;
                                    TransSource."No." := rec.No;
                                    TransSource."Source Account Type" := TransSource."Source Account Type"::Credit;
                                    TransSource."Source Account No." := CreditAcc."Loan Account";
                                    TransSource."Source Account Name" := CreditAcc."Member Name";
                                    TransSource."Product Name" := CreditAcc."Loan Product Type Name";
                                    TransSource."Product Code" := CreditAcc."Loan Product Type";
                                    TransSource."Transfer Type" := rec."Transfer Type";
                                    TransSource."Member No." := CreditAcc."Member No.";
                                    TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::Loan;
                                    TransSource.Validate(TransSource."Source Loan No.", CreditAcc."Loan No.");
                                    TransSource.Insert(true);
                                    TransSource.Modify;
                                end;
                            until CreditAcc.Next = 0;
                        end;
                        Message('Source loan Accounts Updated Successfully');
                    end;
                }
                action("Suggest Group Member Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suggest Group Member Destinations';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        Signatories: record "Account Signatories";
                        SavingsREC: Record "Savings Accounts";
                        TransSource: Record "Account Transfer Source";
                        TransDestin: Record "Account Transfer Destination";
                        CreditREC: Record "Loans";
                    begin

                        rec.TestField(posted, false);
                        rec.testfield(status, rec.status::open);
                        //Clear any line
                        TransDestin.reset;
                        TransDestin.setrange("No.", rec.No);
                        if TransDestin.find('-') then
                            TransDestin.deleteall;

                        //Insert new accounts
                        Signatories.Reset();
                        Signatories.SetRange("Account No", Rec."Member No");
                        if Signatories.findset() then begin
                            repeat
                                SavingsREC.Reset;
                                SavingsREC.SetRange(SavingsREC."Member No.", Signatories."Member No.");
                                SavingsREC.SetRange(SavingsREC."Product Category", SavingsREC."Product Category"::"Chama Investment Account");
                                if SavingsREC.Find('-') then begin
                                    repeat
                                        TransDestin.Init;
                                        TransDestin."Entry No." := GetNextEntryNo(Rec.No);
                                        TransDestin."No." := Rec.No;
                                        TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Savings;
                                        TransDestin."Destination Account No." := SavingsREC."No.";
                                        TransDestin."Destination Account Name" := SavingsREC.Name;
                                        TransDestin."Product Name" := SavingsREC."Product Name";
                                        TransDestin."Product Code" := SavingsREC."Product Type";
                                        TransDestin."Transfer Type" := Rec."Transfer Type";
                                        TransDestin."Member No." := SavingsREC."Member No.";
                                        TransDestin.Insert(true);
                                        TransDestin.Validate(TransDestin."Destination Account No.");
                                    until SavingsREC.Next = 0;
                                end;

                                CreditREC.Reset;
                                CreditREC.SetRange(CreditREC."Member No.", Signatories."Member No.");
                                if CreditREC.Find('-') then begin
                                    repeat
                                        CreditREC.CalcFields(CreditREC."Total Balance");
                                        if CreditREC."Total Balance" > 0 then begin
                                            TransDestin.Init;
                                            TransDestin."Entry No." := GetNextEntryNo(Rec.No);
                                            TransDestin."No." := Rec.No;
                                            TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Credit;
                                            TransDestin."Destination Account No." := CreditREC."Loan Account";
                                            TransDestin."Destination Account Name" := CreditREC."Member Name";
                                            TransDestin."Product Name" := CreditREC."Loan Product Type Name";
                                            TransDestin."Product Code" := CreditREC."Loan Product Type";
                                            TransDestin."Transfer Type" := Rec."Transfer Type";
                                            TransDestin."Destination Transaction Type" := TransDestin."Destination Transaction Type"::Armotised;
                                            TransDestin."Member No." := CreditREC."Member No.";
                                            TransDestin.Insert(true);
                                            TransDestin.Validate(TransDestin."Destination Loan No.", Creditrec."Loan No.");
                                            TransDestin.Modify;
                                        end;
                                    until CreditREC.Next = 0;
                                end;
                            until Signatories.next = 0;
                        end;
                        Message('Destination Accounts Updated Successfully');
                    end;
                }

            }


            group("Clear lines")
            {
                action("Clear Source Accounts")
                {
                    Caption = 'Clear Source Accounts';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        TransSource: Record "Account Transfer Source";
                    begin
                        rec.TestField(posted, false);
                        rec.testfield(status, rec.status::open);
                        TransSource.reset;
                        TransSource.setrange("No.", rec.No);
                        if TransSource.find('-') then
                            TransSource.deleteall;
                        Message('Source Accounts Cleared');
                    end;
                }

                action("Clear Destination Accounts")
                {
                    Caption = 'Clear Destination Accounts';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        TransDest: Record "Account Transfer Destination";
                    begin
                        rec.TestField(posted, false);
                        rec.testfield(status, rec.status::open);
                        TransDest.reset;
                        TransDest.setrange("No.", rec.No);
                        if TransDest.find('-') then
                            TransDest.deleteall;
                        Message('Destination Accounts Cleared');
                    end;
                }

                action("Refresh")
                {
                    Caption = 'Refresh';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        TransDest: Record "Account Transfer Destination";
                    begin
                        Currpage.update;
                        Message('Page Refreshed');
                    end;
                }
            }
            action("Send SMS")
            {
                Caption = 'Send SMS';
                Image = Account;
                Promoted = true;
                PromotedCategory = Category8;
                ApplicationArea = Basic, Suite;
                //
                // Ticket - 867 SMS Notifications for Kenya Pipeline Pension Account

                trigger OnAction()
                var
                    TransDest: Record "Account Transfer Destination";
                    BSched: record "Account Transfer Source";
                    msg: text;
                    Member: record Members;
                    memb: record Members;
                    MembAccounts: text;
                    SavingsACC: record "Savings Accounts";
                    LoansII: record loans;
                    SendSMS: codeunit SendSMS;
                    Source: enum "SMS Source";
                begin
                    rec.TestField(Posted, true);
                    BSched.Reset;
                    BSched.SetRange(BSched."No.", rec.No);
                    BSched.SetRange(BSched."Source Account Type", BSched."source account type"::Savings);
                    //BSched.SetFilter(BSched."Source Amount", '>0');
                    BSched.SetFilter("Source Amount", '>0');
                    if BSched.Find('-') then begin
                        repeat
                            if Member.Get(BSched."Member No.") then begin
                                //if Member."Phone No." <> '' then begin
                                BSchedDestin.Reset;
                                BSchedDestin.SetRange(BSchedDestin."No.", Rec.No);
                                BSchedDestin.SetFilter("Destination Amount", '>0');
                                if BSchedDestin.FindSet() then begin
                                    MembAccounts := '';
                                    repeat
                                        if BSchedDestin."destination account type" = BSchedDestin."destination account type"::Savings then begin
                                            if SavingsACC.Get(BSchedDestin."Destination Account No.") then begin
                                                if Memb.Get(SavingsACC."Member No.") then begin
                                                    if Memb."Phone No." <> '' then begin
                                                        if not (Member."No." = Memb."No.") then begin
                                                            if Member."First Name" <> '' then begin
                                                                if Memb."First Name" <> '' then
                                                                    msg := 'Dear ' + Memb."First Name" + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member."First Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                                else
                                                                    msg := 'Dear ' + Memb.Name + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member."First Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                            end
                                                            else begin
                                                                if Memb."First Name" <> '' then
                                                                    msg := 'Dear ' + Memb."First Name" + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member."First Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                                else
                                                                    msg := 'Dear ' + Memb.Name + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member.Name + ' on ' + Format(Today) + ' ' + Format(Time)

                                                                // msg := 'Dear ' + Memb."First Name" + ', ' + Member.Name + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                //                                                            BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)

                                                            end;

                                                            SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Memb."No.", 'CBS');

                                                            if MembAccounts <> '' then
                                                                MembAccounts += ', ';
                                                            MembAccounts += Format(BSchedDestin."Destination Amount") + ' to ' + Memb."First Name" + ' ' + BSchedDestin."Product Name";
                                                        end
                                                        else begin
                                                            if MembAccounts <> '' then
                                                                MembAccounts += ', ';
                                                            MembAccounts += Format(BSchedDestin."Destination Amount") + ' to your ' + BSchedDestin."Product Name";
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end
                                        else if BSchedDestin."destination account type" = BSchedDestin."destination account type"::Credit then begin
                                            if LoansII.Get(BSchedDestin."Destination Loan No.") then begin
                                                if Memb.Get(LoansII."Member No.") then
                                                    if Memb."Phone No." <> '' then
                                                        if not (Member."No." = Memb."No.") then begin
                                                            if Rec."Recover Arrears" then begin
                                                                if Member."First Name" <> '' then
                                                                    msg := 'Dear ' + Memb."First Name" + ', arrears of KES ' + Format(BSchedDestin."Destination Amount") + ' has been recovered from your ' +
                                                                        BSchedDestin."Product Name" + ' by ' + Member."First Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                                else
                                                                    msg := 'Dear ' + Memb."First Name" + ', arrears of KES ' + Format(BSchedDestin."Destination Amount") + ' has been recovered from your ' +
                                                                        BSchedDestin."Product Name" + ' by ' + Member.Name + ' on ' + Format(Today) + ' ' + Format(Time);
                                                            end else begin
                                                                if Member."First Name" <> '' then
                                                                    msg := 'Dear ' + Memb."First Name" + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member."First Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                                else
                                                                    msg := 'Dear ' + Memb."First Name" + ', you have received KES ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                            BSchedDestin."Product Name" + ' from ' + Member.Name + ' on ' + Format(Today) + ' ' + Format(Time);
                                                            end;

                                                            SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Memb."No.", 'CBS');

                                                            if MembAccounts <> '' then
                                                                MembAccounts += ', ';
                                                            MembAccounts += Format(BSchedDestin."Destination Amount") + ' to ' + Memb."First Name" + ' ' + BSchedDestin."Product Name";
                                                        end
                                                        else begin
                                                            if MembAccounts <> '' then
                                                                MembAccounts += ', ';
                                                            MembAccounts += Format(BSchedDestin."Destination Amount") + ' to your ' + BSchedDestin."Product Name";
                                                        end;
                                            end;
                                        end;

                                    until BSchedDestin.next = 0;
                                    if Member."First Name" <> '' then begin
                                        if Rec."Recover Arrears" then
                                            msg := 'Dear ' + Member."First Name" + ', arrears of ' + format(BSchedDestin."Destination Amount") + ' has been recovered for ' + BSchedDestin."Product Name" + ': ' + BSchedDestin."Destination Loan No." + ' on ' + Format(Today) + ' ' + Format(Time)
                                        // msg := 'Dear ' + Member."First Name" + ', you have recovered arrears: ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                        else
                                            msg := 'Dear ' + Member."First Name" + ', you have successfully transferred ' + MembAccounts + ' from your ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                    end
                                    else begin
                                        if Rec."Recover Arrears" then
                                            msg := 'Dear ' + Member."First Name" + ', arrears of ' + format(BSchedDestin."Destination Amount") + ' has been recovered for ' + BSchedDestin."Product Name" + ': ' + BSchedDestin."Destination Loan No." + ' on ' + Format(rec."Date Posted") + ' ' + Format(rec."Time Posted")
                                        // msg := 'Dear ' + Member.Name + ', you have recovered arrears: ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                        else
                                            msg := 'Dear ' + Member.Name + ', you have successfully transferred ' + MembAccounts + ' from your ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time);
                                    end;
                                    SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Member."Phone No.", msg, Format(Member."No."), '', true, 0, false, 'CBS', Member."No.", 'CBS');
                                end;
                            end;
                        until BSched.next = 0;
                    end;
                    Message('SMS Notifications Sent Successfully');
                end;
            }        
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AControl;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Account Transfer Source";
        BTRANS: Record "Account Transfer Header";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        BSchedDestin: Record "Account Transfer Destination";
        BSchedPch: Record "Account Transfer Source";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        SaccoT: Codeunit "Sacco Transactions";
        DocMustbeApproved: Label 'This document must be approved before posting';
        HeaderA: Boolean;
        SourceA: Boolean;
        DestinationA: Boolean;
        AmountErrorTxt: Label 'Total Debits must be equal to Total Credits.';
        AccountTransferHeader: Record "Account Transfer Header";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        Account: Record "Savings Accounts";
        AccountTransferSource: Record "Account Transfer Source";
        ProdType: Record "Product Factory";
        RejectApproved: Boolean;
        Trans: Record "Account Transfer Header";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
    end;

    procedure AControl()
    begin
        case rec.Status of
            rec.Status::Open:
                begin
                    SourceA := true;
                    DestinationA := true;
                    HeaderA := true;
                end;

            rec.Status::"Pending Approval", rec.Status::Approved, rec.Status::Rejected:
                begin
                    SourceA := false;
                    DestinationA := false;
                    HeaderA := false;
                end;
        end;

        if (rec.Status = rec.Status::Approved) and (rec.Posted = false) then
            RejectApproved := true
        else
            RejectApproved := false;
    end;

    procedure GetNextEntryNo(DocNo: Code[100]): Integer
    var
        TD: Record "Account Transfer Destination";
    begin
        TD.Reset();
        TD.SetRange("No.", DocNo);
        if TD.FindLast() then
            exit(TD."Entry No." + 1);
        exit(1);
    end;
}

