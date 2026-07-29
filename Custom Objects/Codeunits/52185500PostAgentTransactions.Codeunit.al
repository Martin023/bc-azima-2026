#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185500 "Post Agent Transactions"
{

    trigger OnRun()
    begin
        InitAgencyPosting(/*'POS904705'*/'POS931641');//APOS2642462'); //
        //MESSAGE('tesssst');

    end;

    var
        JTemplate: Code[20];
        JBatch: Code[20];
        Agentcomm: Decimal;
        SaccoComm: Decimal;
        Vendorcomm: Decimal;
        Totalcomm: Decimal;
        AgentAccount: Code[20];
        SaccoCommAcc: Code[20];
        VendorCommAcc: Code[20];
        Err_FailedTransaction: label 'Transaction Failed. Try Again.';
        Err_UserNotFound: label 'User Setup not found!';
        Err_InvalidUserType: label 'This User is not authorised for that transaction.';
        Err_MissingParameters: label 'Kindly set the parameter value : %1';
        Err_InvalidParameter: label 'Invalid Parameter : %1';
        Err_TransactionLimits: label 'Sorry this amount is above the %1 limit.';
        Err_WithdrawalLimit: label 'Sorry the member has exhausted their daily withdrawal limit.';
        Err_DefaultBank: label 'User Default Bank Not Found';
        Err_NoAccountsFound: label 'System Could not find any %1 Account. Contact System Administrator.';
        Err_InactiveUser: label 'This User is not Active.';
        Err_TransactionNotFound: label 'System Could not find any transaction. Check parameters and try Again.';
        Err_RecordNotFound: label 'System Could not find any records. Check parameters and try Again.';
        Err_IncompleteSetup: label 'Kindy set the %1 in the DesktopPOS  User Setup';
        Err_InsufficientFunds: label 'Source account has insufficient funds.';
        Err_AccountExists: label 'This Member already has this account.';
        Err_TransactionExists: label 'This Transaction %1 Already Exists';
        Err_AccountBlocked: label 'This Account is Blocked.';
        Err_AccountBlockedDebit: label 'This Account is Blocked For Withdrawals';
        Err_AccountBlockedCredit: label 'This Account is Blocked For Deposits';
        Err_AccountDormant: label 'This Account is Dormant';
        Err_missing: label ' Cannot be N/A';
        Err_PaymentType: label 'Invalid Payment Type';
        Err_LoanOverpayment: label 'This Will result in overpayment of the Loan.';
        Info_RequestSent: label 'Your request was sent to ';
        Info_RequestRejected: label 'Transaction marked as Rejected.';
        Info_PostedSuccessfully: label 'Transaction Posted Successfully.';
        GlobalDim1: Text;
        GlobalDim2: Text[49];
        JournalPosting: Codeunit "Journal Posting";
        AgentCommAcc: Code[20];
        ExciseDutyAcc: Code[20];
        OptionsAccounts: Enum "Gen. Journal Account Type";
        ExciseDutyPercentage: Decimal;
        TxtAtrasDesc: label '%1 by Agent %2';
        AgentTransactionDescription: Text[50];
        LoanTransactionType: enum "Transaction Types";
        ChargeExciseDuty: Boolean;
        ChargeFromExternalAmount: Boolean;
        ProductFactory: Record "Product Factory";
        ThePostingOptionAccount: Enum "Gen. Journal Account Type";
        LineNo: Integer;
        CommissionPostedFromAgentControlAccount: Boolean;
        SendSms: Codeunit SendSms;
        TransType: Enum "Transaction Types";
        SmsSource: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit",InternetBanking,CRM,Agency;


    procedure InitAgencyPosting(TheDocumentNo: Text): Boolean
    var
        AgentTransactions: Record "Agent Transactions";
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        GenSetup: Record "General Set-Up";
        AgentApp: Record "Agent Applications";
        TariffHeader: Record "Agent Tarriff Header";
        TariffDetails: Record "Agent Tariff Details";
        txt_AgentTransactions: label 'Agent Transactions';
        SavingsAccounts: Record "Savings Accounts";
        Temp: Record "Banking User Template";
        ProductFactory: Record "Product Factory";
        BalAmnt: Decimal;
        SavAccount: Record "Savings Accounts";
    begin
        GenSetup.Get();

        GenSetup.TestField(GenSetup."Agency Posting Batch");
        GenSetup.TestField(GenSetup."Agency Posting Template");
        GenSetup.TestField("Sacco Commission Account");
        GenSetup.TestField("Vendor Commission Account");
        //GenSetup.TESTFIELD("Bill Account");
        JTemplate := GenSetup."Agency Posting Template";
        JBatch := GenSetup."Agency Posting Batch";


        /*Temp.GET(USERID);
        Temp.TESTFIELD("ATM Charges Journal Batch");
        Temp.TESTFIELD("ATM Charges Journal Template");
        
        JBatch:=Temp."ATM Charges Journal Batch";
        JTemplate:=Temp."ATM Charges Journal Template";
        */
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        AgentTransactions.Reset;
        AgentTransactions.SetRange("Document No.", TheDocumentNo);
        AgentTransactions.SetRange(AgentTransactions.Posted, false);
        //AgentTransactions.SETCURRENTKEY("Document No.");
        //AgentTransactions.SETASCENDING("Document No.",FALSE);
        if AgentTransactions.Find('-') then begin
            InitializeVariables;
            AgentApp.Reset;
            AgentApp.SetRange("Agent Code", AgentTransactions."Agent Code");
            //AgentApp.SETRANGE("Internal Agent",FALSE);
            if AgentApp.FindFirst then begin

                AgentAccount := AgentApp.Account;
                ThePostingOptionAccount := Thepostingoptionaccount::Savings;
                if AgentApp."Internal Agent" then begin
                    AgentAccount := AgentApp."Teller Account";
                    ThePostingOptionAccount := Thepostingoptionaccount::"Bank Account";
                end;
                AgentCommAcc := AgentApp."Comm Account";

                AgentTransactionDescription := PadStr(StrSubstNo(TxtAtrasDesc, AgentTransactions."Transaction Type", AgentTransactions."Agent Code"), 50);
                //Get Transaction Charges
                if not AgentApp."Internal Agent" then begin
                    TariffHeader.Reset;
                    TariffHeader.SetRange("Trans Type Agents", AgentTransactions."Transaction Type");
                    if TariffHeader.FindFirst then begin
                        SaccoCommAcc := GenSetup."Sacco Commission Account";
                        VendorCommAcc := GenSetup."Vendor Commission Account";
                        ExciseDutyAcc := GenSetup."Excise Duty G/L";
                        ExciseDutyPercentage := GenSetup."Excise Duty (%)";
                        ChargeExciseDuty := TariffHeader."Charge Excise Duty";


                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TariffHeader.Code, TariffHeader.Code);
                        TariffDetails.SetFilter(TariffDetails."Lower Limit", '<=%1', AgentTransactions.Amount);
                        TariffDetails.SetFilter(TariffDetails."Upper Limit", '>=%1', AgentTransactions.Amount);
                        if TariffDetails.FindFirst then begin
                            Agentcomm := TariffDetails."Agent Comm";
                            SaccoComm := TariffDetails."Sacco Comm";
                            Vendorcomm := TariffDetails."Vendor Comm";
                            Totalcomm := TariffDetails."Charge Amount";
                        end;
                    end;
                end;
            end;


            // Get Global dimensions
            if SavingsAccounts.Get(AgentTransactions."Account No.") then begin
                GlobalDim1 := SavingsAccounts."Global Dimension 1 Code";
                GlobalDim2 := SavingsAccounts."Global Dimension 2 Code";
            end;

            case AgentTransactions."Transaction Type" of

                //Deposit Transaction.
                AgentTransactions."transaction type"::Deposit, AgentTransactions."transaction type"::ShareDeposit:
                    exit(PostCashDeposit(AgentTransactions));

                //Withdrawal Transaction.
                AgentTransactions."transaction type"::Withdrawal:
                    begin
                        if SavAccount.Get(AgentTransactions."Account No.") then begin
                            SavAccount.CalcFields("Balance (LCY)");
                            if ProductFactory.Get(SavAccount."Product Type") then begin
                                BalAmnt := SavAccount."Balance (LCY)" - ProductFactory."Minimum Balance";
                                if (AgentTransactions.Amount > BalAmnt) or (SavAccount.Blocked = SavAccount.Blocked::Debit) then begin
                                    Message('Min Bal');
                                    exit(false);
                                end else begin
                                    if (SavAccount.Status = SavAccount.Status::Active) or (SavAccount.Status = SavAccount.Status::New) then
                                        exit(PostCashWithdrawal(AgentTransactions))
                                    else
                                        exit(false);
                                end;
                            end;
                        end;
                    end;

                //Register New Member.
                AgentTransactions."transaction type"::MemberRegistration:
                    exit(PostMemberRegistration(AgentTransactions));

                //Loan Repayment..
                AgentTransactions."transaction type"::LoanRepayment:
                    exit(PostCreditReceipt(AgentTransactions));

                // Micro Schedule
                AgentTransactions."transaction type"::"Micro-Group":
                    exit(PostMicroGroup(AgentTransactions));

                // Bio Registration
                AgentTransactions."transaction type"::BioRegistration:
                    exit(PostBioRegistration(AgentTransactions));

                // Loan Application
                AgentTransactions."transaction type"::LoanApplication:
                    exit(PostLoanApplication(AgentTransactions));

                // Account Opening
                AgentTransactions."transaction type"::"Account-Opening":
                    exit(PostAccountOpening(AgentTransactions));

                // Account Transfer
                AgentTransactions."transaction type"::Transfer:
                    exit(PostAccountTransfer(AgentTransactions));

                // Member activation, Ministatement
                // AgentTransactions."Transaction Type"::" MemberActivation"
                AgentTransactions."transaction type"::MiniStatement,
                AgentTransactions."transaction type"::MemberActivation,
                AgentTransactions."transaction type"::Balance:
                    begin
                        PostCommissions(1000, AgentTransactions);
                        if ChargeExciseDuty then
                            PostExciseDuty(LineNo, AgentTransactions);
                        PostJournal(JTemplate, JBatch);
                        CommitAgentTransaction(AgentTransactions);
                        exit(true);
                    end;


                else
                    exit(false);

            end;
        end;

    end;

    local procedure PostMemberRegistration(AgentTransactions: Record "Agent Transactions") Response: Boolean
    var
        MemberApplication: Record "Member Application";
        txt_Nationality: label 'KENYA';
        NOKApp: Record "Next of KIN Application";
        AgNOK: Record "Agent Next Of Kin Details";
        VirtualRegistrations: Record "Virtual Registrations";
        AgentBiometricData: Record "Agent Biometric Data";
        AutoOpenSavingAccs: Record "Savings Account Registration";
        AgentApp: Record "Agent Applications";
        StringName: Text;
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        NextofKIN: Record "Next of KIN Application";
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Employers: Record Customer;
    begin
        //IF VirtualRegistrations.GET(AgentTransactions."Id No") THEN;

        MemberApplication.Init;
        StringName := AgentTransactions."Account Name";
        MemberApplication.Name := AgentTransactions."Account Name";
        MemberApplication."First Name" := SplitThisString(StringName, ' ');
        MemberApplication."Middle Name" := SplitThisString(StringName, ' ');
        MemberApplication."Other Names" := SplitThisString(StringName, ' ') + ' ' +
        SplitThisString(StringName, ' ');
        MemberApplication.Salutation := AgentTransactions.Salutation;
        MemberApplication."Marital Status" := AgentTransactions."Marital Status";
        MemberApplication."Application Date" := AgentTransactions."Transaction Date";
        MemberApplication.Gender := AgentTransactions.Gender;
        MemberApplication.Nationality := 'KENYA';
        MemberApplication."Primary Identification" := AgentTransactions."Id No";
        MemberApplication."Phone No." := '+254' + AgentTransactions.Telephone;
        MemberApplication."Payroll/Staff No." := AgentTransactions."Payoll No";
        MemberApplication."E-Mail" := AgentTransactions."E-Mail";
        MemberApplication."Phone No." := '+254' + AgentTransactions.Telephone;
       
        MemberApplication."Date of Birth" := AgentTransactions."Date Of Birth";
        MemberApplication."Member Segment" := 'CHECKOFF';
        MemberApplication."Member Class" := 'A';
        MemberApplication.Validate("Employer Code", AgentTransactions."Employer Code");
        if Employers.Get(AgentTransactions."Employer Code") then
            MemberApplication."Employer Name" := Employers.Name;

        //MemberApplication."Administrative Village":=AgentTransactions."Nearest Market";
        // MemberApplication.Source := "Member Application Source"::CRM;
        if AgentBiometricData.Get(AgentTransactions."Id No") then begin
            AgentBiometricData.CalcFields(PassportPhoto, Signature);
            MemberApplication.Signature := AgentBiometricData.Signature;
            MemberApplication.Picture := AgentBiometricData.PassportPhoto;

        end;

        MemberApplication."Recruited by Type" := MemberApplication."recruited by type"::Others;
        MemberApplication."Recruited By" := AgentTransactions."Agent Code";
        if AgentApp.Get(AgentTransactions."Agent Code") then
            MemberApplication."Recruited By Name" := AgentApp.Name;
        MemberApplication."Branch Code" := AgentTransactions."Branch Code";
        MemberApplication."Responsibility Center" := AgentTransactions."Branch Code";
        // MemberApplication."Auto Apply Mobile Banking" := AgentTransactions."Auto Apply M-Banking";
        //MemberApplication."Read/Write":=MemberApplication."Read/Write"::Yes;
        //MemberApplication.VALIDATE("Self Employed",TRUE);
        //MemberApplication."Nearest Land Mark":=FORMAT(AgentTransactions.Latitude)+' x '+FORMAT(AgentTransactions.Longitude);

        if MemberApplication.Insert(true) then begin
            //PostTrans.InitAgencyPosting(DocumentNo);

            AgNOK.Reset;
            AgNOK.SetRange("Document No", AgentTransactions."Document No.");
            if AgNOK.FindFirst then
                repeat
                    NOKApp.Init;
                    NOKApp."Record ID" := MemberApplication."No.";
                    NOKApp.Name := AgNOK."Next Of Kin Name";
                    NOKApp.Relationship := AgNOK."Next Of Kin RelationShip";
                    NOKApp.Telephone := AgNOK."Next Of Kin Phone";
                    NOKApp.Identification := AgNOK."Next Of Kin ID";
                    NOKApp.Insert;
                until AgNOK.Next = 0;


            /*AutoOpenSavingAccs.INIT;
            AutoOpenSavingAccs."No.":=MemberApplication."No.";
            AutoOpenSavingAccs.VALIDATE(AutoOpenSavingAccs."Product Type",'106');
            AutoOpenSavingAccs.INSERT;*/

            VarVariant := MemberApplication;
            // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
            //     CustomApprovals.OnSendDocForApproval(VarVariant);

            PostRegistrationAmount(AgentTransactions);
            LineNo += 50000;
            CommissionPostedFromAgentControlAccount := true;
            PostCommissions(LineNo, AgentTransactions);
            CommitAgentTransaction(AgentTransactions);

            exit(true);

        end else
            exit(false);
        //end here

    end;

    local procedure PostCreditReceipt(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        CreditAccounts: Record "Credit Accounts";
        BankingSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        Loans: Record Loans;
        GenJournalLine: Record "Gen. Journal Line";
        BalRemaining: Decimal;
        InterestAmount: Decimal;
        LineNo: Integer;
    begin
        //Get Loan.
        Loans.Reset;
        Loans.SetRange(Loans."Loan No.", AgentTransactions."Loan No");
        if Loans.FindFirst then Loans.CalcFields("Outstanding Interest", "Outstanding Balance", "Outstanding Bills");
        LineNo += 10000;
        JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount
        , AgentAccount, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        BalRemaining := 0;
        BalRemaining := AgentTransactions.Amount;/* - Totalcomm*/
        ;
        //ChargeFromExternalAmount:=TRUE;  //Commented to charge from Savings Account
        if ChargeExciseDuty then //BalRemaining -= Totalcomm*(ExciseDutyPercentage/100); charge ex duty from savings account

            if Totalcomm <> 0 then begin
                PostCommissions(LineNo, AgentTransactions);
                if ChargeExciseDuty then
                    PostExciseDuty(LineNo, AgentTransactions);
            end;

        //Payable Interest.
        InterestAmount := Loans."Outstanding Interest";
        if InterestAmount > BalRemaining then
            InterestAmount := BalRemaining;

        //Payable Balance.
        if InterestAmount > 0 then
            BalRemaining -= InterestAmount;

        if BalRemaining > Loans."Outstanding Balance" then begin
            if Loans."Outstanding Balance" > 0 then begin
                PostExcessDeposit(60000, AgentTransactions, BalRemaining - Loans."Outstanding Balance");
                BalRemaining := Loans."Outstanding Balance";
            end else begin
                PostExcessDeposit(60000, AgentTransactions, BalRemaining);
                BalRemaining := 0;
            end;
        end;

        //Generate Journal Lines.
        if InterestAmount > 0 then GenerateLoansJournal(AgentTransactions, 1, InterestAmount, 102, JTemplate, JBatch, Loans."Loan Account");
        if BalRemaining > 0 then begin
            GenerateLoansJournal(AgentTransactions, 0, BalRemaining, 101, JTemplate, JBatch, Loans."Loan Account");
            if Loans."Outstanding Bills" > 0 then
                PostBills(80000, AgentTransactions, BalRemaining, Loans."Loan Account");
        end;

        //Post Journal Lines.
        if PostJournal(JTemplate, JBatch) then begin

            CommitAgentTransaction(AgentTransactions);
            exit(true);

        end else
            exit(false);

    end;

    local procedure GenerateLoansJournal(AgentTransactions: Record "Agent Transactions"; TheTransType: Option Repayment,"Interest "; LoanAmount: Decimal; LineNo: Integer; UserTemplate: Text; UserBatch: Text; LoanAccount: Text): Boolean
    var
        JournalLine: Record "Gen. Journal Line";
    begin
        if LoanAmount <> 0 then begin

            LoanTransactionType := LoanTransactionType::" ";
            case TheTransType of
                Thetranstype::"Interest ":
                    LoanTransactionType := Loantransactiontype::"Interest Paid";
                Thetranstype::Repayment:
                    LoanTransactionType := Loantransactiontype::Repayment;
            end;

            LineNo += 10000;
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Credit, AgentTransactions."Document No.", AgentTransactionDescription, -LoanAmount
            , LoanAccount, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType, AgentTransactions."Loan No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        end;
    end;

    local procedure PostCashDeposit(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount * -1
            , AgentTransactions."Account No.", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, ThePostingOptionAccount, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount
            , AgentAccount, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        if Totalcomm <> 0 then begin
            PostCommissions(LineNo, AgentTransactions);
            if ChargeExciseDuty then
                PostExciseDuty(LineNo, AgentTransactions);
        end;

        //Post Journal Lines.
        if PostJournal(JTemplate, JBatch) then begin

            CommitAgentTransaction(AgentTransactions);
            exit(true);

        end else
            exit(false);
    end;

    local procedure PostCashWithdrawal(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        GeneralSetUp: Record "General Set-Up";
    begin
        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount
            , AgentTransactions."Account No.", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount * -1
            , AgentAccount, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        if Totalcomm <> 0 then begin
            PostCommissions(LineNo, AgentTransactions);
            if ChargeExciseDuty then
                PostExciseDuty(LineNo, AgentTransactions);
        end;

        //Post Journal Lines.
        if PostJournal(JTemplate, JBatch) then begin

            CommitAgentTransaction(AgentTransactions);
            exit(true);

        end else
            exit(false);
    end;

    local procedure PostJournal(UserTemplate: Text; UserBatch: Text) JournalPosted: Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        JournalPosted := false;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", UserTemplate);
        GenJournalLine.SetRange("Journal Batch Name", UserBatch);
        if GenJournalLine.FindFirst then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            JournalPosted := true;
        end;
        exit(JournalPosted);
    end;

    local procedure PostBills(LineNo: Integer; AgentTransactions: Record "Agent Transactions"; Amount: Decimal; LoanAccount: Code[20])
    var
        GeneralSetUp: Record "General Set-Up";
        LoansBills: Record Loans;
    begin
        LoansBills.Get(AgentTransactions."Loan No");
        if ProductFactory.Get(LoansBills."Loan Product Type") then begin
            ProductFactory.TestField(ProductFactory."Billed Account");
            if Amount <> 0 then
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Credit, AgentTransactions."Document No.", AgentTransactionDescription,
              -Amount, LoanAccount, Today, Optionsaccounts::"G/L Account", ProductFactory."Billed Account", AgentTransactions."Document No.", GlobalDim1, GlobalDim2, Loantransactiontype::Bills, AgentTransactions."Loan No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        end;
    end;

    local procedure PostRegistrationAmount(AgentTrans: Record "Agent Transactions")
    var
        LineNo: Integer;
        GeneralSetUp: Record "General Set-Up";
    begin
        if AgentTrans.Amount > 0 then begin
            GeneralSetUp.Get;
            GeneralSetUp.TestField("Agency Control Account");
            LineNo += 10000;
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"G/L Account", AgentTrans."Document No.", AgentTransactionDescription, -AgentTrans.Amount
            , GeneralSetUp."Agency Control Account", Today, ThePostingOptionAccount, AgentAccount, AgentTrans."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            if Totalcomm <> 0 then begin
                PostCommissions(LineNo, AgentTrans);
                if ChargeExciseDuty then
                    PostExciseDuty(LineNo, AgentTrans);
            end;

            //Post Journal Lines.
            PostJournal(JTemplate, JBatch)

        end;
    end;

    local procedure PostLoanApplication(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        NewLoanRec: Record Loans;
        Memb: Record Members;
        LoansProcess: Codeunit "Loans Process";
        CreditAccounts: Record "Credit Accounts";
        AcctNo: Code[20];
        ProdFac: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        Amt: Decimal;
        LoanPostedSms: label 'Your %1 loan has been posted successfully';
    begin
        Memb.Reset;
        Memb.SetRange("Primary Identification", AgentTransactions."Id No");
        Memb.SetRange(Status, Memb.Status::Active);
        if Memb.FindFirst then;

        NewLoanRec.Reset;
        NewLoanRec.SetRange("Member No.", Memb."No.");
        NewLoanRec.SetRange(Posted, false);
        NewLoanRec.SetRange("Loan Product Type", AgentTransactions."Product Type");
        if NewLoanRec.FindFirst then
            NewLoanRec.DeleteAll;

        NewLoanRec.Init;
        if NewLoanRec.Insert(true) then begin
            NewLoanRec."Application Date" := AgentTransactions."Transaction Date";
            NewLoanRec.Validate("Member No.", Memb."No.");
            //NewLoanRec."Phone No":=AgentTransactions.Telephone;
            NewLoanRec."Global Dimension 1 Code" := 'FOSA';
            NewLoanRec."Global Dimension 2 Code" := '00';
            NewLoanRec.Validate("Loan Product Type", AgentTransactions."Product Type");
            NewLoanRec."Requested Amount" := AgentTransactions.Amount;
            NewLoanRec."Approved Amount" := AgentTransactions.Amount;
            NewLoanRec."Recommended Amount" := AgentTransactions.Amount;
            NewLoanRec."Recovery Mode" := NewLoanRec."recovery mode"::Salary;
            ProdFac.Get(AgentTransactions."Product Type");
            AcctNo := ProdFac."Account No. Prefix" + Memb."No." + ProdFac."Account No. Suffix";
            if not CreditAccounts.Get(AcctNo) then
                AcctNo := LoansProcess.CreateLoanAccount(Memb."No.", ProdFac."Product ID");
            NewLoanRec."Loan Account" := AcctNo;
            NewLoanRec.Status := NewLoanRec.Status::Approved;
            NewLoanRec.Posted := true;
            NewLoanRec."Disbursement Date" := Today;
            if NewLoanRec.Modify then begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Memb."No.");
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.FindFirst then
                    SavingsAccounts.TestField(Blocked, SavingsAccounts.Blocked::" ");

                //Debit loan
                LineNo += 10000;
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Credit, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount
                , AcctNo, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", NewLoanRec."Global Dimension 1 Code", NewLoanRec."Global Dimension 2 Code", Loantransactiontype::Loan, NewLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                // Credit savings;
                LineNo += 10000;
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, -AgentTransactions.Amount
                , SavingsAccounts."No.", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", NewLoanRec."Global Dimension 1 Code", NewLoanRec."Global Dimension 2 Code", LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //Accrue Interest
                Amt := 0;
                LineNo := LineNo + 10000;
                Amt := AgentTransactions.Amount * (ProdFac."Interest Rate (Max.)" / 12) * 0.01 * NewLoanRec.Installments;
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Credit, AgentTransactions."Document No.", AgentTransactionDescription, Amt, AcctNo, Today, Optionsaccounts::"G/L Account",
                ProdFac."Loan Interest Account [G/L]", AgentTransactions."Document No.", NewLoanRec."Global Dimension 1 Code", NewLoanRec."Global Dimension 2 Code", Loantransactiontype::"Interest Due", NewLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                if PostJournal(JTemplate, JBatch) then begin
                    // SendSms.SendSms(Smssource::Agency, Memb."Phone No.", StrSubstNo(LoanPostedSms, NewLoanRec."Loan Product Type Name"), '', '', false);
                    CommitAgentTransaction(AgentTransactions);
                end;
                exit(true);


            end;
        end;
    end;

    local procedure CommitAgentTransaction(Agent_Transactions: Record "Agent Transactions")
    begin
        Agent_Transactions.Posted := true;
        Agent_Transactions."Date Posted" := Today;
        Agent_Transactions."Time Posted" := Time;
        Agent_Transactions.Modify;
        Commit;
    end;

    local procedure PostCommissions(LineNo: Integer; AgentTransactions: Record "Agent Transactions")
    var
        TextCharge: label ' Charges';
        TextComm: label ' Commissions';
        AccNo: Code[20];
        GSetUp: Record "General Set-Up";
        TransAccNo: Code[20];
        SavingsAcc: Record "Savings Accounts";
        prodFactory: Record "Product Factory";
        SavingsAcc2: Record "Savings Accounts";
        Loans: Record Loans;
    begin
        //Post charges
        if not ChargeFromExternalAmount then begin
            GSetUp.Get;
            GSetUp.TestField("Agency Expense Account");
            LineNo := LineNo + 10000;
            OptionsAccounts := Optionsaccounts::Savings;
            AccNo := AgentTransactions."Account No.";
            if CommissionPostedFromAgentControlAccount then begin
                OptionsAccounts := Optionsaccounts::"G/L Account";
                //AccNo := GSetUp."Agency Expense Account";
                TransAccNo := GSetUp."Agency Expense Account";
            end else begin
                OptionsAccounts := Optionsaccounts::Savings;
            end;

            if SavingsAcc.Get(AgentTransactions."Account No.") then begin
                prodFactory.Reset;
                prodFactory.SetRange(prodFactory."Agency Charge Acc", true);
                if prodFactory.Find('-') then begin
                    if SavingsAcc."Product Type" = prodFactory."Product ID" then begin
                        TransAccNo := AgentTransactions."Account No.";
                    end else begin
                        TransAccNo := '';
                        SavingsAcc2.Reset;
                        SavingsAcc2.SetRange(SavingsAcc2."ID No.", SavingsAcc."ID No.");
                        SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                        if SavingsAcc2.Find('-') then
                            TransAccNo := SavingsAcc2."No.";
                    end;
                    if AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::LoanRepayment then begin
                        TransAccNo := '';
                        if Loans.Get(AgentTransactions."Loan No") then begin
                            SavingsAcc2.Reset;
                            SavingsAcc2.SetRange(SavingsAcc2."Payroll/Staff No.", Loans."Staff No");
                            SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                            if SavingsAcc2.Find('-') then
                                TransAccNo := SavingsAcc2."No.";
                        end
                    end;
                end;
            end;


            if Totalcomm <> 0 then
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, OptionsAccounts, AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextCharge, 50), Totalcomm
                , TransAccNo, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        end;

        //Post commissions
        //Agent
        LineNo := LineNo + 10000;
        if Agentcomm <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Vendor, AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextComm, 50), Agentcomm * -1
            , AgentCommAcc, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        //Vendor Commission
        LineNo := LineNo + 10000;
        if Vendorcomm <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Vendor, AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextComm, 50), Vendorcomm * -1
            , VendorCommAcc, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


        //Sacco Commission
        LineNo += 10000;
        if SaccoComm <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"G/L Account", AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextComm, 50), SaccoComm * -1
            , SaccoCommAcc, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        //ERROR('TESTPAGE');
        if (Totalcomm <> 0) or (SaccoComm <> 0) or (Agentcomm <> 0) or (Vendorcomm <> 0) then
            LogCommissions(AgentTransactions);
    end;

    local procedure PostExciseDuty(LineNo: Integer; AgentTransactions: Record "Agent Transactions")
    var
        TextExc: label ' Excise Duty';
        AccNo: Code[30];
        SavingsAcc: Record "Savings Accounts";
        prodFactory: Record "Product Factory";
        TransAccNo: Code[20];
        SavingsAcc2: Record "Savings Accounts";
        Loans: Record Loans;
    begin
        //Excise Duty.

        if SavingsAcc.Get(AgentTransactions."Account No.") then begin
            prodFactory.Reset;
            prodFactory.SetRange(prodFactory."Agency Charge Acc", true);
            if prodFactory.Find('-') then begin
                if SavingsAcc."Product Type" = prodFactory."Product ID" then begin
                    TransAccNo := AgentTransactions."Account No.";
                end else begin
                    TransAccNo := '';
                    SavingsAcc2.Reset;
                    SavingsAcc2.SetRange(SavingsAcc2."ID No.", SavingsAcc."ID No.");
                    SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                    if SavingsAcc2.Find('-') then
                        TransAccNo := SavingsAcc2."No."
                end;
            end;
            if AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::LoanRepayment then begin
                TransAccNo := '';
                if Loans.Get(AgentTransactions."Loan No") then begin
                    SavingsAcc2.Reset;
                    SavingsAcc2.SetRange(SavingsAcc2."Payroll/Staff No.", Loans."Staff No");
                    SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                    if SavingsAcc2.Find('-') then
                        TransAccNo := SavingsAcc2."No.";
                end
            end;
        end;
        LineNo += 1000;
        if Totalcomm <> 0 then begin
            if not ChargeFromExternalAmount then
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextExc, 50), Totalcomm * (ExciseDutyPercentage / 100)
                , TransAccNo, Today, Optionsaccounts::"G/L Account", ExciseDutyAcc, AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account")
            else
                JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"G/L Account", AgentTransactions."Document No.", PadStr(AgentTransactions.Description + TextExc, 50), -Totalcomm * (ExciseDutyPercentage / 100)
               , ExciseDutyAcc, Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        end;
    end;

    local procedure PostExcessDeposit(LineNo: Integer; AgentTransactions: Record "Agent Transactions"; ExcessDepositAmount: Decimal)
    var
        LoansData: Record Loans;
        SavAccounts: Record "Savings Accounts";
    begin
        if LoansData.Get(AgentTransactions."Loan No") then begin
            SavAccounts.Reset;
            SavAccounts.SetRange("Member No.", LoansData."Member No.");
            SavAccounts.SetRange("Product Category", SavAccounts."Product Category"::"BOSA Deposits");
            if SavAccounts.FindFirst then begin
                LineNo := LineNo + 10000;
                if ExcessDepositAmount <> 0 then
                    JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, ExcessDepositAmount * -1
                    , SavAccounts."No.", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            end;
        end
    end;

    local procedure InitializeVariables()
    begin
        Agentcomm := 0;
        SaccoComm := 0;
        Vendorcomm := 0;
        Totalcomm := 0;
        AgentAccount := '';
        SaccoCommAcc := '';
        VendorCommAcc := '';
        AgentCommAcc := '';
        ExciseDutyAcc := '';
        ExciseDutyPercentage := 0;
        GlobalDim1 := '';
        GlobalDim1 := '';
        AgentTransactionDescription := '';
        ChargeExciseDuty := false;
        ChargeFromExternalAmount := false;
        CommissionPostedFromAgentControlAccount := false;
    end;

    local procedure ValidateMemberRegistration(IdNo: Code[10])
    var
        Members: Record Members;
        TextErrorMem: label 'Member Id No Already Exists';
    begin
        Members.Reset;
        Members.SetRange("Primary Identification", IdNo);
        if Members.FindFirst then Error(TextErrorMem);
    end;

    local procedure PostMicroGroup(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        LineNo: Integer;
        AgentApp: Record "Agent Applications";
        AgentGroupSchedule: Record "Agent Group Schedule";
    begin
        LineNo += 10000;
        AgentApp.Get(AgentTransactions."Agent Code");
        AgentApp.TestField("Teller Account");
        AgentGroupSchedule.Get(AgentTransactions."Document No.");
        if AgentGroupSchedule."Total Group Paid Amount" <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentGroupSchedule."Total Group Paid Amount"
            , AgentTransactions."Account No.", Today, Optionsaccounts::"Bank Account", AgentApp."Teller Account", AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        if Totalcomm <> 0 then begin
            PostCommissions(LineNo, AgentTransactions);
            if ChargeExciseDuty then
                PostExciseDuty(LineNo, AgentTransactions);
        end;

        //Post Journal Lines.
        if PostJournal(JTemplate, JBatch) then begin

            CommitAgentTransaction(AgentTransactions);
            exit(true);

        end else
            exit(false);
    end;

    local procedure PostBioRegistration(AgentTrans: Record "Agent Transactions"): Boolean
    var
        ImageData: Record "Image Data";
        AgentBiometricData: Record "Agent Biometric Data";
        ImageDataRecExists: Boolean;
        Member: Record Members;
    begin
        if not AgentBiometricData.Get(AgentTrans."Id No") then exit(false);

        Member.Reset;
        Member.SetRange("Primary Identification", AgentTrans."Id No");
        if not Member.FindFirst then exit(false);

        ImageDataRecExists := true;
        ImageData.Reset;
        ImageData.SetRange("Member No", Member."No.");
        if not ImageData.FindFirst then begin
            ImageDataRecExists := false;
            ImageData.Init;
            ImageData."Member No" := Member."No.";
            ImageData."ID Number" := Member."Primary Identification";
        end;


        AgentBiometricData.CalcFields(FingerOne, FingerTwo, FingerThree, FingerFour);
        ImageData.FingerOne := AgentBiometricData.FingerOne;
        ImageData.FingerTwo := AgentBiometricData.FingerTwo;
        ImageData.FingerThree := AgentBiometricData.FingerThree;
        ImageData.FingerFour := AgentBiometricData.FingerFour;

        if ImageDataRecExists then
            ImageData.Modify
        else
            ImageData.Insert;

        // Member."BSS Registered" := true;
        Member.Modify;

        CommitAgentTransaction(AgentTrans);

        exit(true);
    end;

    local procedure PostAccountOpening(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        SacAccApp: Record "Savings Account Application";
        Memb: Record Members;
        RegProcess: Codeunit "Registration Process";
    begin
        Memb.Reset;
        Memb.SetRange("Primary Identification", AgentTransactions."Id No");
        Memb.SetRange(Status, Memb.Status::Active);
        Memb.FindFirst;

        SacAccApp.Init;
        if SacAccApp.Insert(true) then begin
            SacAccApp.Validate("Member No.", Memb."No.");
            SacAccApp.Validate("Product Type", AgentTransactions."Product Type");
            SacAccApp."Agent Code" := AgentTransactions."Agent Code";
            SacAccApp."Agent Document No" := AgentTransactions."Document No.";
            SacAccApp."Created By Agent" := true;
            SacAccApp.Status := SacAccApp.Status::Created;
            SacAccApp."Created By Agent" := true;
            SacAccApp."Created By" := UserId;
            /* IF SacAccApp."Product Category"=SacAccApp."Product Category"::"Micro Credit Deposits" THEN
                BEGIN
                    IF AgentTransactions."Group Code" <> '' THEN
                      SacAccApp.VALIDATE("Group Account No",AgentTransactions."Group Code");
                END;*/
            /* IF SacAccApp."Product Category"=SacAccApp."Product Category"::"Junior Savings" THEN
               BEGIN

                    SacAccApp."Junior Account Name":=AgentTransactions."Junior Acc Name";
                    SacAccApp."Junior Date of Birth":=AgentTransactions."Junior Acc Date Of Birth";
                 END;*/
            //SacAccApp.VALIDATE("Group Account No",AgentTransactions.gr

            RegProcess.AccountRegistration(SacAccApp);


            /*VarVariant := SacAccApp;
            IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
               CustomApprovals.OnSendDocForApproval(VarVariant);*/
            CommitAgentTransaction(AgentTransactions);
            exit(true);
        end;

    end;

    local procedure PostAccountTransfer(AgentTransactions: Record "Agent Transactions"): Boolean
    var
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
    begin
        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, AgentTransactions.Amount
            , AgentTransactions."Account No.", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        LineNo += 10000;
        if AgentTransactions.Amount <> 0 then
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTransactions."Document No.", AgentTransactionDescription, -AgentTransactions.Amount
            , AgentTransactions."Destination Account No", Today, Optionsaccounts::"G/L Account", '', AgentTransactions."Document No.", GlobalDim1, GlobalDim2, LoanTransactionType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        if Totalcomm <> 0 then begin
            PostCommissions(LineNo, AgentTransactions);
            if ChargeExciseDuty then
                PostExciseDuty(LineNo, AgentTransactions);
        end;

        //Post Journal Lines.
        if PostJournal(JTemplate, JBatch) then begin

            CommitAgentTransaction(AgentTransactions);
            exit(true);

        end;
    end;


    procedure SplitThisString(var Text: Text[100]; Separator: Text[1]) Token: Text[100]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);

        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;

    local procedure LogCommissions(ATrans: Record "Agent Transactions")
    var
        Location: Record Location;
        AgentTransactionsCharged: Record "Agent Transactions Charged";
    begin
        AgentTransactionsCharged.Init;
        AgentTransactionsCharged."Document No" := ATrans."Document No.";
        AgentTransactionsCharged."Total Commission" := Totalcomm;
        AgentTransactionsCharged."Sacco Commission" := SaccoComm;
        AgentTransactionsCharged."Vendor Commission" := Vendorcomm;
        AgentTransactionsCharged."Agent Comission" := Agentcomm;
        AgentTransactionsCharged."Date Logged" := ATrans."Transaction Date";
        AgentTransactionsCharged."Time Logged" := Dt2Time(ATrans."Transaction Time");
        AgentTransactionsCharged.Insert;
    end;

    local procedure CheckoffAdvice(LineNo: Integer; AgentTransactions: Record "Agent Transactions")
    var
        AccNo: Code[20];
        GSetUp: Record "General Set-Up";
        TransAccNo: Code[20];
        SavingsAcc: Record "Savings Accounts";
        prodFactory: Record "Product Factory";
        SavingsAcc2: Record "Savings Accounts";
        Loans: Record Loans;
        MemberNo: Code[20];
        Memb: Record Members;
        CheckOffadv: Record "Checkoff Advice Line";
    begin
        if SavingsAcc.Get(AgentTransactions."Account No.") then begin
            prodFactory.Reset;
            prodFactory.SetRange(prodFactory."Agency Charge Acc", true);
            if prodFactory.Find('-') then begin
                if SavingsAcc."Product Type" = prodFactory."Product ID" then begin
                    TransAccNo := AgentTransactions."Account No.";
                end else begin
                    TransAccNo := '';
                    SavingsAcc2.Reset;
                    SavingsAcc2.SetRange(SavingsAcc2."ID No.", SavingsAcc."ID No.");
                    SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                    if SavingsAcc2.Find('-') then begin
                        TransAccNo := SavingsAcc2."No.";
                        MemberNo := SavingsAcc2."Member No.";
                    end
                end;
                if AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::LoanRepayment then begin
                    TransAccNo := '';
                    if Loans.Get(AgentTransactions."Loan No") then begin
                        SavingsAcc2.Reset;
                        SavingsAcc2.SetRange(SavingsAcc2."Payroll/Staff No.", Loans."Staff No");
                        SavingsAcc2.SetRange(SavingsAcc2."Product Type", prodFactory."Product ID");
                        if SavingsAcc2.Find('-') then begin
                            TransAccNo := SavingsAcc2."No.";
                            MemberNo := SavingsAcc2."Member No.";
                        end
                    end
                end;
            end;
        end;

        if Memb.Get(MemberNo) then begin
            /*CheckOffadv.INIT
            CheckOffadv."Member No.":=
            CheckOffadv."Account No."
            CheckOffadv.Names
            CheckOffadv."Employer Code"
            IF AgentTransactions."Transaction Type" = AgentTransactions."Transaction Type"::LoanRepayment THEN
            CheckOffadv."Loan No.":=
            CheckOffadv."Amount On":=
            CheckOffadv."Amount Off":=
            CheckOffadv."Balance On":=
            CheckOffadv."Balance Off":=
            CheckOffadv."Product Type":=
            CheckOffadv."Advice Date":=AgentTransactions."Date Posted";
            CheckOffadv.Interest:=
            CheckOffadv.."Advice Method":=
            CheckOffadv."ID No.":=Memb."ID No.";
            CheckOffadv."Payroll No":=Memb."Payroll/Staff No.";
            CheckOffadv."Advice Type":=
            CheckOffadv."Employer Account No.":=
            CheckOffadv.Type:=
            CheckOffadv."Captured  By":=USERID;
            CheckOffadv."System Created":=TRUE;

            CheckOffadv.INSERT;*/


        end

    end;
}
