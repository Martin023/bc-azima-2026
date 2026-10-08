codeunit 52185457 "Membership Closure Mgmt"
{

    procedure PostMemberShipClosure(MembershipClosure: Record "Membership Closure")
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ErrTxt0000: Label 'Account already Posted';
        ErrTxt0001: Label 'Account cannot be closed, insufficient funds';
        ErrTxt0002: Label 'The request must be approved';
        Trans: Record "Membership closure";
        EarlyWithrawalFee: Decimal;
        Members: Record Members;
        ConfmTxt0003: Label 'Are you sure you want to recover the loans from the members shares?';
        GeneralSetUp: Record "General Set-Up";
        BankingUserTemplate: Record "Banking User Template";
        Jtemplate, JBatch : Code[20];
        Totalrecovered, TotalSaving, AvailableSharesd, Funeral : Decimal;
        Gnljnline: Record "Gen. Journal Line";
        ClosureAccounts: Record "Account Closure Line";
        ClosureAccountsII: Record "Account Closure Line";
        AvailableShares: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        ProdutFactory: Record "Product Factory";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        AccNo: Code[10];
        BalAccNo: Code[10];
        Amt: Decimal;
        MCAcc: Record Vendor;
        LineNo: Integer;
        Txt0004: Label 'Member closure';
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        RecoverLoan: Boolean;
        Interest: Decimal;
        LRepayment: Decimal;
        Txt0005: Label 'Interest Recovery from deposits';
        Txt0006: Label 'Principle Recovery from deposits';
        Txt0007: Label 'Member Withdrawal Account No';
        Txt0008: Label 'Funeral Expenses';
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        Txt0000: Label 'Checkoff has been posted';
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TransactionTypes: Record "Transaction Types";
        Txt0001: Label 'Excise Duty';
        Txt0002: Label 'Member cannot close the account before clearing the loans';
        UserSetup: Record "User Setup";
        Dim1: Code[10];
        Dim2: Code[10];
        Txt0009: Label 'Withdrawal Fee';
        Txt00011: Label 'TSC/Liability Clearance ';
        AccountClosureFee: Decimal;
        Txt0010: Label 'Account Closure Fee';
        Text000010: Label 'Early Wtihdrawal Fee';
        "-": Integer;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        Amount: array[2] of Decimal;
        SavingsAccounts2: Record "Savings Accounts";
        ShareCapAmount: Decimal;
        Txt0011: Label 'Share Capital Reovery';
        RegistrationFee: Decimal;
        Txt0012: Label 'Registration Fee Recovery';
        PeriodicAcc: Codeunit "Periodic Activities";
        LoansProcess: Codeunit "Loans Process";
        SinkFund: Decimal;
        Txt0013: Label 'Closure Line does not belong to this member';
        TrasPosted: Label 'The transaction has already been posted.';
        EOFAccountClosure: Boolean;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal";
        SendSms: Codeunit SendSms;
        NetAmount: Decimal;
        ClearBills: Decimal;
        Txt0014: Label 'Bills Cleared on Accounts Closure';
        AccLine: Record "Account Closure Line";
        GenSetup: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        LoanTotal: Decimal;
        IntTotal: Decimal;
        TotalLoan: Decimal;
        BBF: Decimal;
        Loans2: Record Loans;
        LoanGuar: Record "Loan Guarantors and Security";
        ProductType: Text;
        AppAmount: Decimal;
        CompInfo: Record "Company Information";
        VisiblePArt: Boolean;
        Source: Enum "SMS Source";
        JnlPost: Codeunit "Journal Posting";
        RunBal: Decimal;
        msg: Text;
        Text0005: Label 'Dear member, Your shares refund of KES ';
        Text0006: Label ' has been credited to your FOSA account. Access via mobile banking or ATM.';
        WithdrawalExciseDuty: Decimal;
        ErrSavAcc: Label 'No FOSA Savings Account found for the member. Please ensure that the member has a FOSA savings account before proceeding';
        GlobalFunctions: Codeunit "Global Functions";

    begin

        // with MembershipClosure do begin

        MembershipClosure.TestField(Posted, false);
        //if not Confirm('Kindly Ensure you have updated this closure before proceeding. Are you sure you wish to continue?', false) then Error('Kindly ensure you have updated the record before proceeding');

        Loans.Reset;
        Loans.SetRange(Loans."Member No.", MembershipClosure."Member No.");
        Loans.SetFilter("Total Loan Balance", '>0');
        Loans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest");
        if Loans.Find('-') then begin
            repeat
                LoansProcess.CapitalizeDailyInterest(Loans."Loan No.");
            until Loans.Next() = 0;
        end;

        if MembershipClosure."Closure Type" in [MembershipClosure."Closure Type"::"Withdrawal - 1st Partial",
        MembershipClosure."Closure Type"::"Withdrawal - 2nd Partial"] then begin
            PostPartialWithdrawals(MembershipClosure);
        end else begin

            SavingsLedgerEntry.Reset;
            SavingsLedgerEntry.SetRange(Reversed, False);
            SavingsLedgerEntry.SetRange("Document No.", MembershipClosure."No.");
            if SavingsLedgerEntry.FindFirst() then begin
                MembershipClosure.Posted := true;
                MembershipClosure.Modify;
                Message(TrasPosted);
                exit;
            end else begin

                MembershipClosure.TestField("Closing Date");
                MembershipClosure.TestField(Posted, false);

                BankingUserTemplate.Get(UserId);
                BankingUserTemplate.TestField("Transfer Journal Template");
                BankingUserTemplate.TestField("Transfer Journal Batch");

                Jtemplate := BankingUserTemplate."Transfer Journal Template";
                JBatch := BankingUserTemplate."Transfer Journal Batch";

                GeneralSetUp.Get();
                GeneralSetUp.TestField("Withdrawal Fee Account");

                if UserSetup.Get(UserId) then begin
                    Dim1 := UserSetup."Global Dimension 1 Code";
                    Dim2 := UserSetup."Global Dimension 2 Code";
                end;

                JnlPost.ClearJournalLines(Jtemplate, JBatch, true);

                if MembershipClosure."Deposit Refundable" <= 0 then
                    Error(ErrTxt0001);

                ClosureAccountsII.Reset;
                ClosureAccountsII.SetRange(ClosureAccountsII."No.", MembershipClosure."No.");
                ClosureAccountsII.SetRange(ClosureAccountsII.Close, true);
                if ClosureAccountsII.Find('-') then begin
                    repeat
                        ClosureAccountsII.Validate("Account No.");
                    until ClosureAccountsII.Next = 0;
                end;

                Members.Get(MembershipClosure."Member No.");

                JnlPost.ClearJournalLines(Jtemplate, JBatch, true);
                //Close Accounts
                ClosureAccounts.Reset;
                ClosureAccounts.SetRange(ClosureAccounts."No.", MembershipClosure."No.");
                ClosureAccounts.SetRange(ClosureAccounts.Close, true);
                if ClosureAccounts.Findset() then begin
                    repeat
                        if ProdutFactory.Get(ClosureAccounts."Product Type") then begin
                            LineNo := LineNo + 10000;
                            AcctType := AcctType::Savings;
                            TransType := TransType::" ";
                            Amt := ClosureAccounts.Balance;
                            BalAccNo := '';
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                            Txt0004 + ' ' + Format(MembershipClosure."Member No."), Amt, ClosureAccounts."Account No.", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            TotalSaving := TotalSaving + Amt;

                            if SavingsAccounts.Get(ClosureAccounts."Account No.") then begin
                                SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                                SavingsAccounts.Modify;
                            end;
                        end;
                    until ClosureAccounts.Next = 0;
                end;
            end;

            if TotalSaving > 0 then begin

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
                if SavingsAccounts.FindFirst then begin

                    LineNo := LineNo + 10000;
                    Amt := TotalSaving;
                    AcctType := AcctType::Savings;
                    TransType := TransType::" ";
                    BalAccNo := '';
                    RunBal := TotalSaving;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                    CopyStr((('Member Closure ' + MembershipClosure.Remarks) + ClosureAccounts."No."), 1, 50), -(Amt), SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Withdrawal Fee
                    // Early Withdrawal Fee

                    if MembershipClosure."Early Withdrawal" then
                        if GeneralSetUp."Early Withdrawal Fee" <> '' then begin
                            Amt := 0;
                            TransactionTypes.Reset();
                            TransactionTypes.setrange(Code, GeneralSetUp."Early Withdrawal Fee");
                            if TransactionTypes.FindFirst() then begin
                                TransactionCharges.Reset();
                                TransactionCharges.SetRange("Transaction Type", TransactionTypes.code);
                                if TransactionCharges.findfirst() then begin
                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::"G/L Account";
                                    TransType := TransType::" ";
                                    BalAccNo := TransactionCharges."G/L Account";

                                    if TransactionCharges."Percentage of Amount" <> 0 then
                                        Amt := (MembershipClosure."Member Savings" - (MembershipClosure."Total Loan" + MembershipClosure."Total Interest" + MembershipClosure."TSC Clearance")) * TransactionCharges."Percentage of Amount" * 0.01
                                    else
                                        if TransactionCharges."Charge Amount" <> 0 then
                                            Amt := TransactionCharges."Charge Amount";

                                    if Amt > RunBal then
                                        Amt := RunBal;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                                    Txt0009 + ' ' + Format(MembershipClosure."Member No."), Amt, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                                    BalAccNo, Members."No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    RunBal -= Amt;

                                    if TransactionCharges."Recover Excise Duty" then begin
                                        GeneralSetUp.TestField(GeneralSetUp."Excise Duty (%)");
                                        GeneralSetUp.TestField(GeneralSetUp."Excise Duty G/L");
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::"G/L Account";
                                        TransType := TransType::" ";
                                        BalAccNo := GeneralSetUp."Excise Duty G/L";

                                        WithdrawalExciseDuty := Amt * GeneralSetUp."Excise Duty (%)" * 0.01;
                                        if WithdrawalExciseDuty > RunBal then
                                            WithdrawalExciseDuty := RunBal;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                                        Txt0009 + ' Excise Duty ' + Format(MembershipClosure."Member No."), WithdrawalExciseDuty, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, Members."No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                        RunBal -= WithdrawalExciseDuty;
                                    end;
                                end;
                                //GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");
                            end;

                        end;
                end;
                // SMS Charges
                Amt := 0;
                TransactionTypes.Reset();
                TransactionTypes.setrange(Code, MembershipClosure."SMS Charge");
                if TransactionTypes.FindFirst() then begin
                    TransactionCharges.Reset();
                    TransactionCharges.SetRange("Transaction Type", TransactionTypes.code);
                    if TransactionCharges.findfirst() then begin
                        LineNo := LineNo + 10000;
                        AcctType := AcctType::"G/L Account";
                        TransType := TransType::" ";
                        BalAccNo := TransactionCharges."G/L Account";

                        if TransactionCharges."Percentage of Amount" <> 0 then
                            Amt := (MembershipClosure."Member Savings" - (MembershipClosure."Total Loan" + MembershipClosure."Total Interest" + MembershipClosure."TSC Clearance")) * TransactionCharges."Percentage of Amount" * 0.01
                        else
                            if TransactionCharges."Charge Amount" <> 0 then
                                Amt := TransactionCharges."Charge Amount";

                        if Amt > RunBal then
                            Amt := RunBal;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                        Txt0009 + ' ' + Format(MembershipClosure."Member No."), Amt, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                        BalAccNo, Members."No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        RunBal -= Amt;

                        if TransactionCharges."Recover Excise Duty" then begin
                            GeneralSetUp.TestField(GeneralSetUp."Excise Duty (%)");
                            GeneralSetUp.TestField(GeneralSetUp."Excise Duty G/L");
                            LineNo := LineNo + 10000;
                            AcctType := AcctType::"G/L Account";
                            TransType := TransType::" ";
                            BalAccNo := GeneralSetUp."Excise Duty G/L";

                            WithdrawalExciseDuty := Amt * GeneralSetUp."Excise Duty (%)" * 0.01;
                            if WithdrawalExciseDuty > RunBal then
                                WithdrawalExciseDuty := RunBal;

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                            Txt0009 + ' Excise Duty ' + Format(MembershipClosure."Member No."), WithdrawalExciseDuty, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, Members."No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            RunBal -= WithdrawalExciseDuty;
                        end;
                    end;
                    //GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");
                end;

                if MembershipClosure."TSC Clearance" > 0 then begin
                    LineNo := LineNo + 10000;
                    AcctType := AcctType::Customer;
                    TransType := TransType::" ";
                    BalAccNo := '';

                    if MembershipClosure."TSC Clearance" > RunBal then
                        MembershipClosure."TSC Clearance" := RunBal;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                    Txt00011 + ' ' + Format(MembershipClosure."Member No."), -MembershipClosure."TSC Clearance", MembershipClosure."TSC Clearance Account", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                    Txt00011 + ' ' + Format(MembershipClosure."Member No."), MembershipClosure."TSC Clearance", SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    RunBal -= MembershipClosure."TSC Clearance";
                end;

                // LoansProcess.CapitalizeDailyInterest();();

                Loans.Reset;
                Loans.SetRange(Loans."Member No.", MembershipClosure."Member No.");
                Loans.SetFilter("Total Loan Balance", '>0');
                Loans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest");
                if Loans.Find('-') then begin
                    repeat
                        if Loans."Outstanding Interest" > 0 then begin

                            Interest := Loans."Outstanding Interest";

                            if Interest > RunBal then
                                Interest := RunBal;

                            if (Interest > 0) then begin

                                //Interest Recovery
                                LineNo := LineNo + 10000;
                                AcctType := AcctType::Credit;
                                TransType := TransType::"Interest Paid";
                                BalAccNo := '';
                                Amt := Interest;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                'Closure Interest Recovery  ' + Format(MembershipClosure."Member No."), -Amt, Loans."Loan Account", MembershipClosure."Closing Date", BalAccType,
                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                LineNo := LineNo + 10000;
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                                'Closure Interest Recovery ' + Format(MembershipClosure."Member No."), Amt, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                                BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                RunBal -= Amt;

                            end;
                        end;


                        if Loans."Outstanding Balance" > 0 then
                            LRepayment := Loans."Outstanding Balance"
                        else
                            LRepayment := 0;

                        if (LRepayment > 0) then begin

                            LineNo := LineNo + 10000;
                            AcctType := AcctType::Credit;
                            TransType := TransType::Repayment;
                            BalAccNo := '';
                            if LRepayment > RunBal then
                                LRepayment := RunBal;
                            Amt := LRepayment;

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                            'Closure Principal Recovery' + ' ' + Format(MembershipClosure."Member No."), -Amt, Loans."Loan Account", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            LineNo := LineNo + 10000;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                            'Closure Principal Recovery ' + Format(MembershipClosure."Member No."), Amt, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            RunBal -= Amt;
                        end;
                    until Loans.Next = 0;
                end;

            end else
                Error(ErrSavAcc);

            //Post New
            JournalPosting.CompletePosting(Jtemplate, JBatch);
            //Post New
            // SavingsAccounts.Reset();
            // SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
            // SavingsAccounts.SetFilter(SavingsAccounts."Product Category", '%1|%2|%3',
            // SavingsAccounts."Product Category"::"BOSA Deposits", SavingsAccounts."Product Category"::Risk, SavingsAccounts."Product Category"::"Benevolent (BBF)");
            // if SavingsAccounts.Find('-') then begin
            //     repeat
            //         LoansProcess.AdviceShares(SavingsAccounts, 0, MembershipClosure."No.");
            //     until SavingsAccounts.Next() = 0;
            // end;

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
            SavingsAccounts.setfilter(SavingsAccounts."Product Category", '<>%1&<>%2', SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"FOSA Account");
            if SavingsAccounts.Find('-') then begin
                repeat
                    //if SavingsAccounts."Product Category" <>  and  then begin
                    //if SavingsAccounts."Loan Disbursement Account" = false then begin
                    SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                    SavingsAccounts.Blocked := SavingsAccounts.Blocked::All;
                    SavingsAccounts.Modify;
                //end;
                //end;
                until SavingsAccounts.Next = 0;
            end;
            //--------
            if Members.Get(MembershipClosure."Member No.") then begin

                // if Members.Subflag = Members.Subflag::"Pending Withdrawal" then begin
                //     Members.Blocked := Members.Blocked::All;
                // end;
                MembershipClosure.Posted := true;
                MembershipClosure."Date Posted" := Today;
                MembershipClosure."Posted By" := UserId;

                msg := 'Dear ' + Members.Name + ', Your membership withdrawal has been processed successfully!';
                SendSMS.SendSms(Source::WITHDRAWAL, Members."Phone No.", msg, MembershipClosure."No.", Members."No.", true, 0, false, 'CBS', Members."No.", 'CBS');
                Members.Subflag := Members.Subflag::Withdrawal;
                Members.Status := Members.Status::Withdrawn;
                Members.Blocked := Members.Blocked::All;
                Members.Modify;
            end;
            MembershipClosure.Modify;
        end;
        // end;

        MembershipClosure.MarkNoticeAsFinalized();

        Message('Closure posted successfully.');
    end;



    procedure PostPartialWithdrawals(MembershipClosure: Record "Membership Closure")
    var
        Text0005: Label 'Dear member, Your partial withdrawal has been processed successfully! ';
        Text0006: Label ' has been credited to your FOSA account. Access via Mobile Banking or ATM.';
        MCAcc: Record Vendor;
        TotalDebits: Decimal;
        TotaLoan: Decimal;
        LoanBalTota: Decimal;
        FosaAccount: Code[20];
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ErrTxt0000: Label 'Account already Posted';
        ErrTxt0001: Label 'Account cannot be closed, insufficient funds';
        ErrTxt0002: Label 'The request must be approved';
        Trans: Record "Membership closure";
        EarlyWithrawalFee: Decimal;
        Members: Record Members;
        ConfmTxt0003: Label 'Are you sure you want to recover the loans from the members shares?';
        GeneralSetUp: Record "General Set-Up";
        BankingUserTemplate: Record "Banking User Template";
        Jtemplate, JBatch : Code[20];
        Totalrecovered, TotalSaving, AvailableSharesd, Funeral : Decimal;
        Gnljnline: Record "Gen. Journal Line";
        ClosureAccounts: Record "Account Closure Line";
        ClosureAccountsII: Record "Account Closure Line";
        AvailableShares: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        //ProdutFactory: Record "Product Factory";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        AccNo: Code[10];
        BalAccNo: Code[10];
        Amt: Decimal;
        LineNo: Integer;
        Txt0004: Label 'Member closure';
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        RecoverLoan: Boolean;
        Interest: Decimal;
        LRepayment: Decimal;
        Txt0005: Label 'Interest Recovery from deposits';
        Txt0006: Label 'Principle Recovery from deposits';
        Txt0007: Label 'Member Withdrawal Account No';
        Txt0008: Label 'Funeral Expenses';
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        Txt0000: Label 'Checkoff has been posted';
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TransactionTypes: Record "Transaction Types";
        Txt0001: Label 'Excise Duty';
        Txt0002: Label 'Member cannot close the account before clearing the loans';
        UserSetup: Record "User Setup";
        Dim1: Code[10];
        Dim2: Code[10];
        Txt0009: Label 'Withdrawal Fee';
        AccountClosureFee: Decimal;
        Txt0010: Label 'Account Closure Fee';
        Text000010: Label 'Early Wtihdrawal Fee';
        "-": Integer;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        Amount: array[2] of Decimal;
        SavingsAccounts2: Record "Savings Accounts";
        ShareCapAmount: Decimal;
        Txt0011: Label 'Share Capital Reovery';
        RegistrationFee: Decimal;
        Txt0012: Label 'Registration Fee Recovery';
        PeriodicAcc: Codeunit "Periodic Activities";
        LoansProcess: Codeunit "Loans Process";
        SinkFund: Decimal;
        Txt0013: Label 'Closure Line does not belong to this member';
        TrasPosted: Label 'The transaction has already been posted.';
        EOFAccountClosure: Boolean;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal";
        SendSms: Codeunit SendSms;
        NetAmount: Decimal;
        ClearBills: Decimal;
        Txt0014: Label 'Bills Cleared on Accounts Closure';
        AccLine: Record "Account Closure Line";
        GenSetup: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        LoanTotal: Decimal;
        IntTotal: Decimal;
        TotalLoan: Decimal;
        BBF: Decimal;
        Loans2: Record Loans;
        LoanGuar: Record "Loan Guarantors and Security";
        ProductType: Text;
        AppAmount: Decimal;
        CompInfo: Record "Company Information";
        VisiblePArt: Boolean;
        Source: Enum "SMS Source";
        JnlPost: Codeunit "Journal Posting";
        msg: Text;
        WithdrawalExciseDuty: Decimal;
        ClosureFee: Decimal;
        RunBal: Decimal;
        ErrSavAcc: Label 'No FOSA Savings Account found for the member. Please ensure that the member has a FOSA savings account before proceeding';
        Txt00011: Label 'TSC/Liability Clearance ';
        TotalDepoCap: Decimal;
        RegistrProcess: Codeunit "Registration Process";
        TotalLiabilities: Decimal;
        BOSAAccNo: Code[50];
    begin
        // with MembershipClosure do begin

        MembershipClosure.TestField(Posted, false);

        MembershipClosure.TestField("Closing Date");
        if MembershipClosure.Status <> MembershipClosure.Status::Approved then
            Error(ErrTxt0002);

        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Document No.", MembershipClosure."No.");
        SavingsLedgerEntry.SetRange("Posting Date", MembershipClosure."Closing Date");
        if SavingsLedgerEntry.Find('-') then begin
            MembershipClosure.Posted := true;
            MembershipClosure.Modify;
            exit;
        end;

        BankingUserTemplate.Get(UserId);
        BankingUserTemplate.TestField("Transfer Journal Template");
        BankingUserTemplate.TestField("Transfer Journal Batch");

        Jtemplate := BankingUserTemplate."Transfer Journal Template";
        JBatch := BankingUserTemplate."Transfer Journal Batch";

        GeneralSetUp.Get();
        GeneralSetUp.TestField("Partial Account Fee");

        if UserSetup.Get(UserId) then begin
            Dim1 := UserSetup."Global Dimension 1 Code";
            Dim2 := UserSetup."Global Dimension 2 Code";
        end;

        JnlPost.ClearJournalLines(Jtemplate, JBatch, true);

        if MembershipClosure."Partial Deposit Refundable" <= 0 then
            Error(ErrTxt0001);

        ClosureAccountsII.Reset;
        ClosureAccountsII.SetRange(ClosureAccountsII."No.", MembershipClosure."No.");
        ClosureAccountsII.SetRange(ClosureAccountsII.Close, true);
        if ClosureAccountsII.Find('-') then begin
            repeat
                ClosureAccountsII.Validate("Account No.");
            until ClosureAccountsII.Next = 0;
        end;

        Members.Get(MembershipClosure."Member No.");
        TotalSaving := 0;
        TotalDepoCap := 0;
        ClosureAccounts.Reset;
        ClosureAccounts.SetRange(ClosureAccounts."No.", MembershipClosure."No.");
        ClosureAccounts.SetRange(ClosureAccounts.Close, true);
        if ClosureAccounts.FindSet() then begin
            repeat
                if ProductFactory.Get(ClosureAccounts."Product Type") then begin
                    if ProductFactory."Product Category" <> ProductFactory."Product Category"::"BOSA Deposits" then begin
                        LineNo := LineNo + 10000;
                        AcctType := AcctType::Savings;
                        TransType := TransType::" ";
                        Amt := ClosureAccounts.Balance;
                        //* MembershipClosure."% of Refunds" * 0.01;
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                        CopyStr(('Partial Withdrawal - ' + MembershipClosure.Remarks), 1, 50), Amt, ClosureAccounts."Account No.", MembershipClosure."Closing Date", BalAccType,
                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        // end;
                        TotalDepoCap := TotalDepoCap + Amt;
                    end;
                end;
            until ClosureAccounts.Next = 0;
        end;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
        SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.Find('-') then begin
            LineNo := LineNo + 10000;
            AcctType := AcctType::Savings;
            TransType := TransType::" ";
            Amt := -TotalDepoCap;
            //* MembershipClosure."% of Refunds" * 0.01;
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
            CopyStr(('Partial Withdrawal dep cap - ' + MembershipClosure.Remarks), 1, 50), Amt, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            // end;
        end
        else begin
            AccNo := RegistrProcess.CreateSavingsAccountNo('1', '201', Members."No.");
            LineNo := LineNo + 10000;
            AcctType := AcctType::Savings;
            TransType := TransType::" ";
            Amt := -TotalDepoCap;
            //* MembershipClosure."% of Refunds" * 0.01;
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
            CopyStr(('Partial Withdrawal - ' + MembershipClosure.Remarks), 1, 50), Amt, AccNo, MembershipClosure."Closing Date", BalAccType,
            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        end;

        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
        SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)");
            TotalSaving := SavingsAccounts."Balance (LCY)";
            BOSAAccNo := SavingsAccounts."No.";
        end
        else
            TotalSaving := 0;

        TotalLiabilities := 0;

        if TotalSaving > 0 then begin

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
            SavingsAccounts.SetRange("Product Type", '191');
            if SavingsAccounts.Find('-') then begin

                //ClosureFee := GetTransactionCharge(GeneralSetUp."Partial Account Fee", "Member Savings");
                WithdrawalExciseDuty := ClosureFee * GeneralSetUp."Excise Duty (%)" * 0.01;
                // debit bosa account
                LineNo := LineNo + 10000;
                AcctType := AcctType::Savings;
                TransType := TransType::" ";
                BalAccNo := '';
                //Amt := MembershipClosure."Total Loan" + MembershipClosure."Total Interest" + MembershipClosure."TSC Clearance" + MembershipClosure."Partial Deposit Refundable" + ClosureFee + WithdrawalExciseDuty;

                Amt := MembershipClosure."TSC Clearance" + MembershipClosure."Partial Deposit Refundable" + ClosureFee + WithdrawalExciseDuty;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
               CopyStr((('Partial Withdrawal debit from Bosa Acc- ' + MembershipClosure.Remarks) + ClosureAccounts."No."), 1, 50), (Amt), BOSAAccNo, MembershipClosure."Closing Date", BalAccType,
               BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                //Credit Fosa acc
                LineNo := LineNo + 10000;
                Amt := (MembershipClosure."TSC Clearance" + MembershipClosure."Partial Deposit Refundable" + ClosureFee + WithdrawalExciseDuty);
                AcctType := AcctType::Savings;
                TransType := TransType::" ";
                BalAccNo := '';
                FosaAccount := SavingsAccounts."No.";
                RunBal := TotalSaving;

                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                CopyStr((('Partial Withdrawal Gross to Fosa Acc- ' + MembershipClosure.Remarks) + ClosureAccounts."No."), 1, 50), -(Amt), SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //ClosureFee := GetTransactionCharge(GeneralSetUp."Partial Account Fee", "Member Savings");
                TotalLiabilities := TotalLiabilities + ClosureFee;

                //Withdrawal Fee
                if ClosureFee > 0 then begin

                    LineNo := LineNo + 10000;
                    AcctType := AcctType::Savings;
                    TransType := TransType::" ";
                    GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");
                    BalAccNo := GeneralSetUp."Withdrawal Fee Account";

                    if ClosureFee > RunBal then
                        ClosureFee := RunBal;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                    'Partial ' + Txt0009 + ClosureAccounts."No.", ClosureFee, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, SavingsAccounts."Member No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    TotalDebits += ClosureFee;
                    RunBal -= ClosureFee;

                    LineNo := LineNo + 10000;
                    AcctType := AcctType::Savings;
                    TransType := TransType::" ";
                    GeneralSetUp.TestField(GeneralSetUp."Excise Duty (%)");
                    GeneralSetUp.TestField(GeneralSetUp."Excise Duty G/L");
                    BalAccNo := GeneralSetUp."Excise Duty G/L";
                    WithdrawalExciseDuty := ClosureFee * GeneralSetUp."Excise Duty (%)" * 0.01;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                    'Partial ' + Txt0009 + ' Excise Duty ' + Format(MembershipClosure."Member No."), WithdrawalExciseDuty, SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, Members."No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    TotalDebits += Abs(WithdrawalExciseDuty);
                    RunBal -= WithdrawalExciseDuty;

                    TotalLiabilities := TotalLiabilities + WithdrawalExciseDuty;

                end;

                if MembershipClosure."TSC Clearance" > 0 then begin
                    LineNo := LineNo + 10000;
                    AcctType := AcctType::Customer;
                    TransType := TransType::" ";
                    BalAccNo := '';

                    if MembershipClosure."TSC Clearance" > RunBal then
                        MembershipClosure."TSC Clearance" := RunBal;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                    Txt00011 + ' ' + Format(MembershipClosure."Member No."), -MembershipClosure."TSC Clearance", MembershipClosure."TSC Clearance Account", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, MembershipClosure."No.",
                    Txt00011 + ' ' + Format(MembershipClosure."Member No."), MembershipClosure."TSC Clearance", SavingsAccounts."No.", MembershipClosure."Closing Date", BalAccType,
                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    RunBal -= MembershipClosure."TSC Clearance";

                    TotalLiabilities := TotalLiabilities + MembershipClosure."TSC Clearance";
                end;

                // Exclude loans

                // Loans.Reset;
                // Loans.SetRange(Loans."Member No.", "Member No.");
                // Loans.SetFilter("Total Loan Balance", '>%1', 0);
                // Loans.SetAutoCalcFields("Outstanding Interest", "Outstanding Balance");
                // if Loans.Find('-') then begin
                //     repeat
                //         Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                //         Amt := 0;
                //         Interest := 0;
                //         if Loans."Outstanding Interest" > 0 then begin
                //             Interest := Loans."Outstanding Interest";
                //             LineNo := LineNo + 10000;
                //             AcctType := AcctType::Credit;
                //             TransType := TransType::"Interest Paid";
                //             if Interest > RunBal then
                //                 Interest := RunBal;
                //             Amt := Interest;
                //             BalAccNo := '';
                //             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, "No.",
                //             CopyStr((('Partial Withrawal Interest- ' + Remarks) + ClosureAccounts."No."), 1, 50), Amt * -1, Loans."Loan Account", "Closing Date", BalAccType,
                //             BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //             LineNo := LineNo + 10000;
                //             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, "No.",
                //             CopyStr((('Partial Withrawal Interest- ' + Remarks) + ClosureAccounts."No."), 1, 50), Amt, SavingsAccounts."No.", "Closing Date", BalAccType,
                //             BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //             RunBal -= Amt;
                //             TotalLiabilities := TotalLiabilities + Amt;
                //         end;

                //         if (Loans."Outstanding Balance" > 0) and (RunBal > 0) then begin
                //             LineNo := LineNo + 10000;
                //             AcctType := AcctType::Credit;
                //             TransType := TransType::Repayment;
                //             BalAccNo := '';
                //             Amt := Loans."Outstanding Balance";
                //             if Amt > RunBal then
                //                 Amt := RunBal;

                //             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, "No.",
                //             CopyStr((('Partial Withrawal Principal- ' + Remarks) + ClosureAccounts."No."), 1, 50), -Amt, Loans."Loan Account", "Closing Date", BalAccType,
                //             BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //             LineNo := LineNo + 10000;
                //             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType::Savings, "No.",
                //             CopyStr((('Partial Withrawal Principal- ' + Remarks) + ClosureAccounts."No."), 1, 50), Amt, SavingsAccounts."No.", "Closing Date", BalAccType,
                //             BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //             RunBal -= Amt;

                //             TotalLiabilities := TotalLiabilities + Amt;

                //         end;
                //     until Loans.Next = 0;
                // end;

            end else
                Error(ErrSavAcc);
        end
        else
            Error('Member deposits are less than 0');
        //Post New
        JournalPosting.CompletePosting(Jtemplate, JBatch);
        //--------
        Members.Status := Members.Status::Active;
        Members.Blocked := Members.Blocked::" ";
        Members.Subflag := Members.Subflag::"Partial withdrawn";
        Members.Modify();

        MembershipClosure.Posted := true;
        MembershipClosure."Posted By" := UserId;
        MembershipClosure."Date Posted" := Today;
        MembershipClosure.Modify;

        SendSMS.SendSms(Source::WITHDRAWAL, SavingsAccounts."Phone No.", Text0005, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
        MembershipClosure.MarkNoticeAsFinalized();
        Message('Partial Closure posted successfully.!');

    end;
    // end;

    local procedure CommentedWithDrawalFuneralCode()
    var
        myInt: Integer;
    begin
        /*
         else begin

                            //Death Withdrawal loan Recovery
                            Loans.Reset;
                            Loans.SetRange(Loans."Member No.", MembershipClosure."Member No.");
                            if Loans.Find('-') then begin
                                repeat
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Outstanding Bills");

                                    //Recover Interest
                                    if Loans."Outstanding Interest" > 0 then begin
                                        //**Interest:=0;
                                        Interest := Loans."Outstanding Interest";
                                        LRepayment := Loans."Outstanding Balance";
                                        if Interest > 0 then begin
                                            //Interest Recovery
                                            LineNo := LineNo + 10000;
                                            AcctType := AcctType::Credit;
                                            TransType := TransType::"Interest Due";
                                            BalAccNo := '';

                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                            Txt0005, Interest * -1, Loans."Loan Account", MembershipClosure."Closing Date", BalAccType,
                                            BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            Totalrecovered := Totalrecovered + (Interest);

                                        end;
                                    end;
                                    //Recover Repayment
                                    //**LRepayment:=0;
                                    LRepayment := Loans."Outstanding Balance";

                                    //IF (AvailableShares > 0) AND (LRepayment > 0) THEN BEGIN
                                    if LRepayment > 0 then begin
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Credit;
                                        TransType := TransType::Repayment;
                                        BalAccNo := '';

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                        Txt0006, LRepayment * -1, Loans."Loan Account", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                        Totalrecovered := Totalrecovered + (LRepayment);

                                    end;

                                    //bills
                                    if Loans."Outstanding Bills" <> 0 then begin
                                        ClearBills := Loans."Outstanding Bills";

                                        ProdutFactory.Reset;
                                        ProdutFactory.SetRange("Product ID", Loans."Loan Product Type");
                                        if ProdutFactory.Find('-') then begin
                                            BalAccNo := ProdutFactory."Billed Account";
                                        end;
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Credit;
                                        TransType := TransType::Bills;
                                        BalAccType := BalAccType::"G/L Account";
                                        Amt := -1 * ClearBills;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                        Txt0014, Amt, Loans."Loan Account", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        Amt := 0;
                                    end;
                                until Loans.Next = 0;
                            end;

                            //Funeral Fee
                            if GeneralSetUp."Funeral Amount" > 0 then begin

                                LineNo := LineNo + 10000;
                                AcctType := AcctType::"G/L Account";
                                TransType := TransType::" ";
                                BalAccNo := '';
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                Txt0008 + ClosureAccounts."No.", GeneralSetUp."Funeral Amount", GeneralSetUp."Unloged Claims Account", MembershipClosure."Closing Date", BalAccType,
                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                TotalSaving := TotalSaving - (GeneralSetUp."Funeral Amount");
                            end;

                            //Unlogge Claims

                            LineNo := LineNo + 10000;
                            AcctType := AcctType::"G/L Account";
                            TransType := TransType::" ";
                            GeneralSetUp.TestField("Unloged Claims Account");
                            GeneralSetUp.TestField("Insurance Name");
                            BalAccNo := '';
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                            GeneralSetUp."Insurance Name" + MembershipClosure."No.", Totalrecovered, GeneralSetUp."Unloged Claims Account", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            //Withdrawal Fee
                            if GeneralSetUp."Withdrawal Fee" > 0 then begin
                                LineNo := LineNo + 10000;
                                AcctType := AcctType::"G/L Account";
                                TransType := TransType::" ";
                                BalAccNo := '';
                                GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                Txt0009 + ClosureAccounts."No.", -GeneralSetUp."Withdrawal Fee", GeneralSetUp."Withdrawal Fee Account", MembershipClosure."Closing Date", BalAccType,
                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                TotalSaving := TotalSaving - (GeneralSetUp."Withdrawal Fee");

                            end;

                            //Start Recover Unpaid Dues
                            ShareCapAmount := 0;
                            RegistrationFee := 0;
                            SinkFund := 0;
                            SavingsAccounts2.Reset;
                            SavingsAccounts2.SetRange("Member No.", MembershipClosure."Member No.");
                            SavingsAccounts2.SetRange("Product Category", SavingsAccounts2."Product Category"::"Share Capital");
                            if SavingsAccounts2.Find('-') then begin
                                if ProdutFactory.Get(SavingsAccounts2."Product Type") then begin
                                    SavingsAccounts2.CalcFields("Balance (LCY)");
                                    if SavingsAccounts2."Balance (LCY)" < ProdutFactory."Minimum Balance" then begin
                                        ShareCapAmount := ProdutFactory."Minimum Balance" - SavingsAccounts2."Balance (LCY)";

                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Savings;
                                        TransType := TransType::" ";
                                        BalAccNo := '';
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                        Txt0011 + ClosureAccounts."No.", -(ShareCapAmount), SavingsAccounts2."No.", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    end;
                                end;
                            end;


                            SavingsAccounts2.Reset;
                            SavingsAccounts2.SetRange("Member No.", MembershipClosure."Member No.");
                            SavingsAccounts2.SetRange("Product Category", SavingsAccounts2."product category"::"Entrance Fee");
                            if SavingsAccounts2.Find('-') then begin
                                if ProdutFactory.Get(SavingsAccounts2."Product Type") then begin
                                    SavingsAccounts2.CalcFields("Balance (LCY)");
                                    if SavingsAccounts2."Balance (LCY)" < 0 then begin
                                        RegistrationFee := SavingsAccounts2."Balance (LCY)" * -1;

                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Savings;
                                        TransType := TransType::" ";
                                        BalAccNo := '';

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                        Txt0012 + ClosureAccounts."No.", -RegistrationFee, SavingsAccounts2."No.", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    end;
                                end;
                            end;

                            SavingsAccounts2.Reset;
                            SavingsAccounts2.SetRange("Member No.", MembershipClosure."Member No.");
                            SavingsAccounts2.SetRange("Product Category", SavingsAccounts2."Product Category"::"Benevolent (BBF)");
                            if SavingsAccounts2.Find('-') then begin
                                if ProdutFactory.Get(SavingsAccounts2."Product Type") then begin
                                    SavingsAccounts2.CalcFields("Balance (LCY)");
                                    if SavingsAccounts2."Balance (LCY)" < 0 then begin
                                        SinkFund := SavingsAccounts2."Balance (LCY)" * -1;
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Savings;
                                        TransType := TransType::" ";
                                        BalAccNo := '';

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                        Txt0012 + ClosureAccounts."No.", -SinkFund, SavingsAccounts2."No.", MembershipClosure."Closing Date", BalAccType,
                                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    end;
                                end;
                            end;
                            //End Recover Unpaid Dues


                            //Recover Through MC Account


                            MCAcc.Reset;
                            MCAcc.SetRange("No.", 'MC-' + SavingsAccounts."Member No.");
                            if not MCAcc.Find('-') then begin
                                MCAcc."No." := 'MC-' + SavingsAccounts."Member No.";
                                MCAcc.Name := SavingsAccounts.Name;
                                MCAcc."Post Code" := SavingsAccounts."Post Code";
                                MCAcc.Address := SavingsAccounts."Post Code";
                                MCAcc."Vendor Posting Group" := 'EXMEMBER';
                                MCAcc.Blocked := MCAcc.Blocked::" ";
                                MCAcc.Insert;//(TRUE);
                            end;


                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
                            if SavingsAccounts.Find('-') then begin
                                SavingsAccounts.Status := SavingsAccounts.Status::Deceased;
                            end;

                            LineNo := LineNo + 10000;
                            AcctType := AcctType::Vendor;
                            TransType := TransType::" ";
                            BalAccNo := '';

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                            Txt0007 + ClosureAccounts."No.", -(TotalSaving - ChargeAmount), 'MC-' + SavingsAccounts."Member No.", MembershipClosure."Closing Date", BalAccType,
                            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                            //Changes^^^^^^
                            //CLosure Fee
                            //*Oketch AccountClosureFee:=ProdutFactory."Closure Fee";
                            AccountClosureFee := 0;
                            Amount[2] := 0;
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", MembershipClosure."Member No.");
                            if SavingsAccounts.Find('-') then begin
                                if ProdutFactory.Get(SavingsAccounts."Product Type") then begin
                                    AccountClosureFee := 0;
                                    TransactionCharges.Reset;
                                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", ProdutFactory."Closure Fee");
                                    if TransactionCharges.Find('-') then begin
                                        repeat
                                            Amount[1] := 0;
                                            //Amount[2]:=0;
                                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" then
                                                Amount[1] := ((TotalSaving - ChargeAmount) * TransactionCharges."Percentage of Amount") * 0.01
                                            else
                                                Amount[1] := TransactionCharges."Charge Amount";

                                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin
                                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if ((TotalSaving - ChargeAmount) >= TariffDetails."Lower Limit") and
                                                            ((TotalSaving - ChargeAmount) <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" then
                                                                Amount[1] := (TotalSaving - ChargeAmount) * TariffDetails.Percentage * 0.01
                                                            else
                                                                Amount[1] := TariffDetails."Charge Amount";
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;
                                            Amount[2] += Amount[1];
                                        until TransactionCharges.Next = 0;
                                    end;
                                    AccountClosureFee := Amount[2];


                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::Vendor;
                                    TransType := TransType::" ";

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                    TransactionCharges.Description + ClosureAccounts."No.", AccountClosureFee, 'MC-' + SavingsAccounts."Member No.", MembershipClosure."Closing Date", BalAccType,
                                    TransactionCharges."G/L Account", '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                    //Excise Duty

                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::Vendor;
                                    TransType := TransType::" ";

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, MembershipClosure."No.",
                                    Txt0001 + ClosureAccounts."No.", (AccountClosureFee * GeneralSetUp."Excise Duty (%)") * 0.01, 'MC-' + SavingsAccounts."Member No.", MembershipClosure."Closing Date", BalAccType,
                                    GeneralSetUp."Excise Duty G/L", '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                            end;

                            //Change^^^^


                        end;
        */
    end;


}
