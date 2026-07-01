report 52187076 "Registration Fee Recovery"
{
    ApplicationArea = All;
    Caption = 'Registration Fee Recovery';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(status = filter(New));
            RequestFilterFields = "No.", Name, Status, "Member Class";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Status; Status)
            {
            }
            column(Member_Class; "Member Class")
            {
            }

            dataitem(SavingsAccounts; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Product Category" = filter("Entrance Fee"));
                column(savacctNo; "No.")
                {
                }
                column(ProductName; "Product Name")
                {
                }
                column(BalanceLCY; "Balance (LCY)")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Members.Subflag = Members.Subflag::"First time" then begin
                        OutstandingRegFeeBal := 0;
                        if MemberClass.get(Members."Member Class") then begin
                            //if MemberClass."Entrance Fee" >= SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") then begin

                            // we dont even check for pending entrance fee - caters for rejoined members
                            OutstandingRegFeeBal := MemberClass."Entrance Fee";
                            // - SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                            BosaAccountNo := SaccoTrans.GetMemberDepositAccount(Members);
                            if BosaAccountNo = '' then begin
                                Message('BOSA Account not found for member %1', Members."No.");
                                currReport.Skip;
                            end;

                            Clear(RegFeeBal);
                            RegFeeBal := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                            OutstandingRegFeeBal := OutstandingRegFeeBal - RegFeeBal;
                            if (SavingsAccounts.GetAvailableBalance(BosaAccountNo) >= MemberClass."Entrance Fee") then begin
                                // Credit the Entrance fee Account
                                IF OutstandingRegFeeBal > 0 THEN BEGIN
                                    GenJnlLine.reset;
                                    GenJnlLine.setrange("Journal Template Name", JTemplate);
                                    GenJnlLine.setrange("Journal Batch Name", JBatch);
                                    if GenJnlLine.find('+') then
                                        LineNo := GenJnlLine."Line No." + 10000 else
                                        LineNo := 10000;

                                    GenJnlLine.INIT;
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine."Posting Date" := Today;
                                    GenJnlLine."Document No." := 'REGFEEREC';
                                    GenJnlLine.Description := 'Entrance fee recovered on ' + format(Today);
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                    GenJnlLine."Account No." := SavingsAccounts."No.";
                                    GenJnlLine."Amount" := -OutstandingRegFeeBal;
                                    genJnlLine.Validate(Amount);
                                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                    GenJnlLine."Bal. Account No." := '';
                                    GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    if GenJnlLine.amount <> 0 then
                                        GenJnlLine.INSERT(true);

                                    // Debit the BOSA Account
                                    GenJnlLine.reset;
                                    GenJnlLine.setrange("Journal Template Name", JTemplate);
                                    GenJnlLine.setrange("Journal Batch Name", JBatch);
                                    if GenJnlLine.find('+') then
                                        LineNo := GenJnlLine."Line No." + 10000 else
                                        LineNo := 10000;

                                    GenJnlLine.INIT;
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine."Posting Date" := Today;
                                    GenJnlLine."Document No." := 'REGFEEREC';
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                    GenJnlLine.Description := 'Entrance fee recovered on ' + format(Today);
                                    GenJnlLine."Account No." := BosaAccountNo;
                                    GenJnlLine."Amount" := OutstandingRegFeeBal;
                                    genJnlLine.Validate(Amount);
                                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                    GenJnlLine."Bal. Account No." := '';
                                    GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    if GenJnlLine.amount <> 0 then
                                        GenJnlLine.INSERT(true);

                                    // Activate first time member
                                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                                end;
                                    // Adam
                                    // FOR MEMBER TO MOVE FROM NEW TO ACTIVE THE SYSTEM SHOULD CONSIDER
                                    // MINIMUM DEPOSITS 1000
                                    // REG FEE 600
                                    // SHARE CAPITAL 250
                                    // FOSA MIN BAL 500
                                    Clear(FosaAccountNo);
                                    clear(fosaBal);
                                    Clear(BosaDepositAcct);
                                    Clear(BosaDepBal);
                                    clear(ShareCptAccountNo);
                                    Clear(ShareCptBal);
                                    Clear(FosaMinBal);

                                    FosaAccountNo := GlobalFunctions.GetFOSAAccount(Members."No.");
                                    if FosaAccountNo <> '' then
                                        FosaBal := SavingsAccounts.GetAvailableBalance(FosaAccountNo);
                                    
                                    BosaDepositAcct := GlobalFunctions.GetDepositAccount(Members);
                                    if BosaDepositAcct <> '' then
                                        BosaDepBal := SavingsAccounts.GetAvailableBalance(BosaDepositAcct);

                                    ShareCptAccountNo := GlobalFunctions.GetShareCptAccount(Members);
                                    if ShareCptAccountNo <> '' then 
                                        ShareCptBal := SavingsAccounts.GetAvailableBalance(ShareCptAccountNo);

                                    Clear(RegFeeBal);
                                    RegFeeBal := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                                    
                                    ProductSetUp.reset;
                                    ProductSetUp.SetRange("Product ID",'191');
                                    if ProductSetUp.FindFirst() then
                                        FosaMinBal := ProductSetUp."Minimum Balance";
                                        
                                    if (BosaDepBal >= MemberClass."Default BOSA Deposit") and
                                        (ShareCptBal >= MemberClass."Default Share Capital") and
                                        (FosaBal >=FosaMinBal) and (RegFeeBal >= MemberClass."Entrance Fee") then begin
                                                Members.Status := Members.Status::Active;
                                                Members.MODIFY();
                                                if Members.Status = Members.Status::Active then begin
                                                    SavAccount.reset;
                                                    SavAccount.SetRange("Member No.", Members."No.");
                                                    //SavAccount.SetFilter(SavAccount."Product Category", '%1|%2', SavAccount."Product Category"::"BOSA Deposits", SavAccount."Product Category"::"Entrance Fee");
                                                    if SavAccount.FINDSET then begin
                                                        repeat
                                                            SavAccount."Status" := SavAccount."Status"::Active;
                                                            SavAccount.Modify();
                                                        until SavAccount.NEXT = 0;
                                                    end;
                                                end;
                                    end;
                                    MembersRecovered := MembersRecovered + Members."No." + ', ';
                                    // end
                                end
                                else begin
                                    //Message('Insufficient funds for member %1', Members."No.");
                                    CurrReport.Skip;
                                end;
                                // end;
                            end
                        end
                        else if members.Subflag = Members.Subflag::Rejoined then begin
                            GenSetup.Get;
                            OutstandingRejoinFeeBal := 0;
                            if MemberClass.get(Members."Member Class") then begin
                                //if MemberClass."Entrance Fee" >= SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") then begin

                                // we dont even check for pending entrance fee - caters for rejoined members
                                OutstandingRejoinFeeBal := GenSetup."Rejoining Fee";
                                // - SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                                BosaAccountNo := SaccoTrans.GetMemberDepositAccount(Members);
                                if BosaAccountNo = '' then begin
                                    Error('BOSA Account not found for member %1', Members."No.");
                                    currReport.Skip;
                                end;
                                Clear(RegFeeBal);
                                RegFeeBal := GlobalFunctions.GetPaidReadmissionFees(Members."No.", SavingsAccounts."No.", Members."Rejoinig Date");
                                OutstandingRejoinFeeBal := OutstandingRejoinFeeBal - RegFeeBal;
                                if (SavingsAccounts.GetAvailableBalance(BosaAccountNo) >= GenSetup."Rejoining Fee") then begin
                                    // Credit the Entrance fee Account
                                    if OutstandingRejoinFeeBal > 0 then begin
                                        GenJnlLine.reset;
                                        GenJnlLine.setrange("Journal Template Name", JTemplate);
                                        GenJnlLine.setrange("Journal Batch Name", JBatch);
                                        if GenJnlLine.find('+') then
                                            LineNo := GenJnlLine."Line No." + 10000 else
                                            LineNo := 10000;

                                        GenJnlLine.INIT;
                                        GenJnlLine."Line No." := LineNo;
                                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                                        GenJnlLine."Journal Template Name" := JTemplate;
                                        GenJnlLine."Journal Batch Name" := JBatch;
                                        GenJnlLine."Posting Date" := Today;
                                        GenJnlLine."Document No." := 'REJOINFEEREC';
                                        GenJnlLine.Description := 'Rejoining fee recovered on ' + format(Today);
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                        GenJnlLine."Account No." := SavingsAccounts."No.";
                                        GenJnlLine."Amount" := -OutstandingRejoinFeeBal;
                                        genJnlLine.Validate(Amount);
                                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                        GenJnlLine."Bal. Account No." := '';
                                        GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                        if GenJnlLine.amount <> 0 then
                                            GenJnlLine.INSERT(true);

                                        // Debit the BOSA Account
                                        GenJnlLine.reset;
                                        GenJnlLine.setrange("Journal Template Name", JTemplate);
                                        GenJnlLine.setrange("Journal Batch Name", JBatch);
                                        if GenJnlLine.find('+') then
                                            LineNo := GenJnlLine."Line No." + 10000 else
                                            LineNo := 10000;

                                        GenJnlLine.INIT;
                                        GenJnlLine."Line No." := LineNo;
                                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                                        GenJnlLine."Journal Template Name" := JTemplate;
                                        GenJnlLine."Journal Batch Name" := JBatch;
                                        GenJnlLine."Posting Date" := Today;
                                        GenJnlLine."Document No." := 'REJOINFEEREC';
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                        GenJnlLine.Description := 'Rejoining fee recovered on ' + format(Today);
                                        GenJnlLine."Account No." := BosaAccountNo;
                                        GenJnlLine."Amount" := OutstandingRejoinFeeBal;
                                        genJnlLine.Validate(Amount);
                                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                        GenJnlLine."Bal. Account No." := '';
                                        GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                        if GenJnlLine.amount <> 0 then
                                            GenJnlLine.INSERT(true);

                                        // Activate first time member
                                        JournalPosting.CompletePosting(Jtemplate, JBatch);
                                end;
                                // Adam
                                // FOR MEMBER TO MOVE FROM NEW TO ACTIVE THE SYSTEM SHOULD CONSIDER
                                // MINIMUM DEPOSITS 1000
                                // REG FEE 600
                                // SHARE CAPITAL 250
                                // FOSA MIN BAL 500
                                
                                Clear(FosaAccountNo);
                                clear(fosaBal);
                                Clear(BosaDepositAcct);
                                Clear(BosaDepBal);
                                clear(ShareCptAccountNo);
                                Clear(ShareCptBal);
                                Clear(FosaMinBal);
                                
                                FosaAccountNo := GlobalFunctions.GetFOSAAccount(Members."No.");
                                if FosaAccountNo <> '' then
                                    FosaBal := SavingsAccounts.GetAvailableBalance(FosaAccountNo);
                                
                                BosaDepositAcct := GlobalFunctions.GetDepositAccount(Members);
                                if BosaDepositAcct <> '' then
                                    BosaDepBal := SavingsAccounts.GetAvailableBalance(BosaDepositAcct);

                                ShareCptAccountNo := GlobalFunctions.GetShareCptAccount(Members);
                                if ShareCptAccountNo <> '' then 
                                    ShareCptBal := SavingsAccounts.GetAvailableBalance(ShareCptAccountNo);

                                Clear(RegFeeBal);
                                RegFeeBal := GlobalFunctions.GetPaidReadmissionFees(Members."No.", SavingsAccounts."No.", Members."Rejoinig Date");
                                
                                ProductSetUp.reset;
                                ProductSetUp.SetRange("Product ID",'191');
                                if ProductSetUp.FindFirst() then
                                    FosaMinBal := ProductSetUp."Minimum Balance";

                                if (BosaDepBal >= MemberClass."Default BOSA Deposit") and
                                    (ShareCptBal >= MemberClass."Default Share Capital") and
                                    (FosaBal >= FosaMinBal) AND (RegFeeBal >=GenSetup."Rejoining Fee") then begin
                                            Members.Status := Members.Status::Active;
                                            Members.MODIFY();
                                            if Members.Status = Members.Status::Active then begin
                                                SavAccount.reset;
                                                SavAccount.SetRange("Member No.", Members."No.");
                                                //SavAccount.SetFilter(SavAccount."Product Category", '%1|%2', SavAccount."Product Category"::"BOSA Deposits", SavAccount."Product Category"::"Entrance Fee");
                                                if SavAccount.FINDSET then begin
                                                    repeat
                                                        SavAccount."Status" := SavAccount."Status"::Active;
                                                        SavAccount.Modify();
                                                    until SavAccount.NEXT = 0;
                                                end;
                                            end;
                                end;
                                MembersRecovered := MembersRecovered + Members."No." + ', ';
                                // end
                            end
                            else begin
                                //Message('Insufficient funds for member %1', Members."No.");
                                CurrReport.Skip;
                            end;
                            // end;
                        end
                    end
                    else begin
                        //Message('Member Class not found for member/s: %1 ', Members."No.");
                        CurrReport.Skip;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // create entrance fee acc where none
                AccNo := '';
                ProductSetUp.reset;
                ProductSetUp.SetRange("Product Category", ProductSetUp."Product Category"::"Entrance Fee");
                if ProductSetUp.FINDFIRST then begin
                    EntranceFeeAccount.reset();
                    EntranceFeeAccount.SetRange("Member No.", Members."No.");
                    EntranceFeeAccount.SetRange("Product Category", EntranceFeeAccount."Product Category"::"Entrance Fee");
                    if not EntranceFeeAccount.FINDFIRST then begin
                        AccNo := RegistrationProcessCU.CreateSavingsAccountNo(ProductSetUp."Product ID", Members."Global Dimension 1 Code", Members."No.");
                        RegistrationProcessCU.AutoCreateSavingsAccount(AccNo, Members."No.", ProductSetUp."Product ID");
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                BosaAccountNo := '';
            end;
        }
    }
    trigger OnPostReport()
    begin
        Message('Registration Fee Recovery Report has been processed successfully for :MemNo: %1', format(MembersRecovered));
    end;

    trigger OnPreReport()
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Recover Share & Entrance Fee", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);

        BankingUserTemp.Get(UserId);
        if BankingUserTemp.Get(UserId) then begin
            BankingUserTemp.testfield("Cashier Journal Template");
            BankingUserTemp.testfield("Cashier Journal Batch");
            JTemplate := BankingUserTemp."Cashier Journal Template";
            JBatch := BankingUserTemp."Cashier Journal Batch";

            SaccoTrans.InitJournal(JTemplate, JBatch);
        end else
            Error('You are not set up as a cashier in Banking User Template : %1 ', UserId);

        MembersRecovered := '';
    end;

    var
        MemberClass: record "Member Classes";
        ProductSetUp: record "Product Factory";
        GenJnlLine: record "Gen. Journal Line";
        JTemplate: code[50];
        JBatch: code[50];
        BankingUserTemp: record "Banking User Template";
        LineNo: Integer;
        SaccoTrans: codeunit "Sacco Transactions";
        BosaAccountNo: code[50];
        MembersRecovered: Text[1000];
        OutstandingRegFeeBal: Decimal;
        EntranceFeeAccount: record "Savings Accounts";
        RegistrationProcessCU: codeunit "Registration Process";
        AccNo: code[50];
        JournalPosting: Codeunit "Journal Posting";
        SavAccount: record "Savings Accounts";
        GenSetup: Record "General Set-Up";
        OutstandingRejoinFeeBal: Decimal;
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to recover registration fee. Kindly contact system administrator for assistance.';
        GlobalFunctions: Codeunit "Global Functions";
        FosaAccountNo: code[50];
        BosaDepositAcct : code[50];
        ShareCptAccountNo: code[50];
        FosaBal : Decimal;
        BosaDepBal : Decimal;
        ShareCptBal : Decimal;
        RegFeeBal : Decimal;
        FosaMinBal : Decimal;
}
