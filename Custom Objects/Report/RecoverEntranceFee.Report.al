report 52185557 "Recover Entrance Fee Report"
{
    ApplicationArea = All;
    Caption = 'Recover Entrance Fee Report';
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
                            OutstandingRegFeeBal := MemberClass."Entrance Fee";
                            
                            BosaAccountNo := SaccoTrans.GetMemberDepositAccount(Members);
                            FosaAccountNo := GlobalFunctions.GetFOSAAccount(Members."No.");

                            Clear(RegFeeBal);
                            RegFeeBal := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                            OutstandingRegFeeBal := OutstandingRegFeeBal - RegFeeBal;
                            
                            IF OutstandingRegFeeBal > 0 THEN BEGIN
                                BosaAvailable := 0;
                                FosaAvailable := 0;
                                
                                IF BosaAccountNo <> '' THEN
                                    BosaAvailable := SavingsAccounts.GetAvailableBalance(BosaAccountNo);
                                IF FosaAccountNo <> '' THEN
                                    FosaAvailable := SavingsAccounts.GetAvailableBalance(FosaAccountNo);
                                    
                                RecoverFromBosa := 0;
                                RecoverFromFosa := 0;
                                
                                // Cascade logic: check BOSA first, then FOSA
                                IF BosaAvailable >= OutstandingRegFeeBal THEN BEGIN
                                    RecoverFromBosa := OutstandingRegFeeBal;
                                    FundingSource := 'BOSA';
                                END ELSE IF FosaAvailable >= OutstandingRegFeeBal THEN BEGIN
                                    RecoverFromFosa := OutstandingRegFeeBal;
                                    FundingSource := 'FOSA';
                                END ELSE BEGIN
                                    CurrReport.Skip; // Insufficient funds in both (respecting Min Balance)
                                END;

                                // Credit the Entrance fee Account
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

                                // Debit the Source Account (BOSA or FOSA)
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
                                
                                IF RecoverFromBosa > 0 THEN BEGIN
                                    GenJnlLine.Description := 'Entrance fee recovered from BOSA on ' + format(Today);
                                    GenJnlLine."Account No." := BosaAccountNo;
                                    GenJnlLine."Amount" := RecoverFromBosa;
                                END ELSE BEGIN
                                    GenJnlLine.Description := 'Entrance fee recovered from FOSA on ' + format(Today);
                                    GenJnlLine."Account No." := FosaAccountNo;
                                    GenJnlLine."Amount" := RecoverFromFosa;
                                END;
                                
                                genJnlLine.Validate(Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := '';
                                GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                if GenJnlLine.amount <> 0 then
                                    GenJnlLine.INSERT(true);

                                // Complete posting Journal
                                JournalPosting.CompletePosting(Jtemplate, JBatch);
                            END ELSE BEGIN
                                FundingSource := 'Already Paid';
                            END;

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
                                (FosaBal >= FosaMinBal) and (RegFeeBal >= MemberClass."Entrance Fee") then begin
                                        Members.Status := Members.Status::Active;
                                        Members.MODIFY();
                                        if Members.Status = Members.Status::Active then begin
                                            SavAccount.reset;
                                            SavAccount.SetRange("Member No.", Members."No.");
                                            if SavAccount.FINDSET then begin
                                                repeat
                                                    SavAccount."Status" := SavAccount."Status"::Active;
                                                    SavAccount.Modify();
                                                until SavAccount.NEXT = 0;
                                            end;
                                        end;
                            end;
                            MembersRecovered := MembersRecovered + Members."No." + ' (' + FundingSource + '), ';
                            // end
                        end
                        else begin
                            CurrReport.Skip;
                        end;
                    end
                    else if members.Subflag = Members.Subflag::Rejoined then begin
                        GenSetup.Get;
                        OutstandingRejoinFeeBal := 0;
                        if MemberClass.get(Members."Member Class") then begin
                            OutstandingRejoinFeeBal := GenSetup."Rejoining Fee";
                            
                            BosaAccountNo := SaccoTrans.GetMemberDepositAccount(Members);
                            FosaAccountNo := GlobalFunctions.GetFOSAAccount(Members."No.");

                            Clear(RegFeeBal);
                            RegFeeBal := GlobalFunctions.GetPaidReadmissionFees(Members."No.", SavingsAccounts."No.", Members."Rejoinig Date");
                            OutstandingRejoinFeeBal := OutstandingRejoinFeeBal - RegFeeBal;
                            
                            IF OutstandingRejoinFeeBal > 0 THEN BEGIN
                                BosaAvailable := 0;
                                FosaAvailable := 0;
                                
                                IF BosaAccountNo <> '' THEN
                                    BosaAvailable := SavingsAccounts.GetAvailableBalance(BosaAccountNo);
                                IF FosaAccountNo <> '' THEN
                                    FosaAvailable := SavingsAccounts.GetAvailableBalance(FosaAccountNo);
                                    
                                RecoverFromBosa := 0;
                                RecoverFromFosa := 0;
                                
                                // Cascade logic: check BOSA first, then FOSA
                                IF BosaAvailable >= OutstandingRejoinFeeBal THEN BEGIN
                                    RecoverFromBosa := OutstandingRejoinFeeBal;
                                    FundingSource := 'BOSA';
                                END ELSE IF FosaAvailable >= OutstandingRejoinFeeBal THEN BEGIN
                                    RecoverFromFosa := OutstandingRejoinFeeBal;
                                    FundingSource := 'FOSA';
                                END ELSE BEGIN
                                    CurrReport.Skip;
                                END;

                                // Credit the Entrance fee Account
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

                                // Debit the Source Account (BOSA or FOSA)
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
                                
                                IF RecoverFromBosa > 0 THEN BEGIN
                                    GenJnlLine.Description := 'Rejoining fee recovered from BOSA on ' + format(Today);
                                    GenJnlLine."Account No." := BosaAccountNo;
                                    GenJnlLine."Amount" := RecoverFromBosa;
                                END ELSE BEGIN
                                    GenJnlLine.Description := 'Rejoining fee recovered from FOSA on ' + format(Today);
                                    GenJnlLine."Account No." := FosaAccountNo;
                                    GenJnlLine."Amount" := RecoverFromFosa;
                                END;
                                
                                genJnlLine.Validate(Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := '';
                                GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                if GenJnlLine.amount <> 0 then
                                    GenJnlLine.INSERT(true);

                                JournalPosting.CompletePosting(Jtemplate, JBatch);
                            END ELSE BEGIN
                                FundingSource := 'Already Paid';
                            END;

                            // Adam
                            // FOR MEMBER TO MOVE FROM NEW TO ACTIVE THE SYSTEM SHOULD CONSIDER
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
                                (FosaBal >= FosaMinBal) AND (RegFeeBal >= GenSetup."Rejoining Fee") then begin
                                        Members.Status := Members.Status::Active;
                                        Members.MODIFY();
                                        if Members.Status = Members.Status::Active then begin
                                            SavAccount.reset;
                                            SavAccount.SetRange("Member No.", Members."No.");
                                            if SavAccount.FINDSET then begin
                                                repeat
                                                    SavAccount."Status" := SavAccount."Status"::Active;
                                                    SavAccount.Modify();
                                                until SavAccount.NEXT = 0;
                                            end;
                                        end;
                            end;
                            MembersRecovered := MembersRecovered + Members."No." + ' (' + FundingSource + '), ';
                            // end
                        end
                        else begin
                            CurrReport.Skip;
                        end;
                    end
                    else begin
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
        if MembersRecovered <> '' then
            Message('Registration Fee Recovery Report has been processed successfully for :MemNo: %1', format(MembersRecovered))
        else
            Message('Recovery skipped for this member. Ensure they have sufficient minimum balance in BOSA or FOSA to recover the fee.');
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
        
        // --- NEW VARIABLES ---
        BosaAvailable: Decimal;
        FosaAvailable: Decimal;
        RecoverFromBosa: Decimal;
        RecoverFromFosa: Decimal;
        FundingSource: Text[50];
}