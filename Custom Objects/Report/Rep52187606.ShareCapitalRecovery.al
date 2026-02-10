report 52187416 "Share Capital Recovery"
{
    ApplicationArea = All;
    Caption = 'Share Capital Recovery';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Registration Date", "No.", Name, Status, "Member Class";
            //DataItemTableView = where("Account Type" = filter("Single Member Account"));
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
                DataItemTableView = where("Product Category" = filter("Share Capital"));
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
                    PostingAmount := 0;
                    BOSABal := 0;
                    // MinimumShareCap := 0;
                    // ContributionAmt := 0;

                    // if SavingsAccounts."Monthly Contribution" <> 0 then begin
                    //     ContributionAmt := SavingsAccounts."Monthly Contribution";
                    //     Message('Contribution Amount from Monthly Contribution %1', ContributionAmt);
                    // end
                    // else
                    //     if ProductSetUp.Get(SavingsAccounts."Product Type") then begin
                    //         ContributionAmt := ProductSetUp."Minimum Contribution";
                    //         Message('Contribution Amount from Product Setup %1', ContributionAmt);
                    //     end;
                    // if MemberClass.get(Members."Member Class") then begin
                    //     MinimumShareCap := MemberClass."Share Capital";
                    //     if GlobalFunc.CheckHowLongOneHasBeenAMember(Members."No.") < 365 then begin
                    //         PostingAmount := ContributionAmt;
                    //         Message('Posting Amount from Contribution Amount %1', PostingAmount);
                    //     end
                    //     else begin
                    // PostingAmount := RequiredShares - SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                    // Message('Posting Amount from Share Capital - Available Balance %1', PostingAmount);
                    // end;
                    if RequiredShares > SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") then begin
                        PostingAmount := RequiredShares - SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        BosaAccountNo := SaccoTrans.GetMemberDepositAccount(Members);
                        if BosaAccountNo = '' then begin
                            //Message('BOSA Account not found for member %1', Members."No.");
                            currReport.Skip;
                        end;

                        // RequiredShares := MemberClass."Share Capital" - SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");

                        // if (RequiredShares > 0) and (ContributionAmt > 0) then begin
                        if PostingAmount > 0 then begin
                            BOSABal := SavingsAccounts.GetAvailableBalance(BosaAccountNo);
                            if BOSABal > 0 then begin
                                if BOSABal < PostingAmount
                                          then
                                    PostingAmount := BOSABal;

                                // Credit the ShareCapital Account
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
                                GenJnlLine."Posting Date" := Pdate;
                                GenJnlLine."Document No." := 'SHAREREC';
                                GenJnlLine.Description := 'Share capital recovery on ' + format(Today);
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                GenJnlLine."Account No." := SavingsAccounts."No.";
                                GenJnlLine."Amount" := -PostingAmount;
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
                                GenJnlLine."Posting Date" := Pdate;
                                GenJnlLine."Document No." := 'SHAREREC';
                                GenJnlLine.Description := 'Share capital recovery on ' + format(Today);
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Savings;
                                GenJnlLine."Account No." := BosaAccountNo;
                                GenJnlLine."Amount" := PostingAmount;/* RequiredShares;*/ //MemberClass."Share Capital";
                                genJnlLine.Validate(Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := '';
                                GenJnlLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                if GenJnlLine.amount <> 0 then
                                    GenJnlLine.INSERT(true);
                            end;
                        end;
                    end
                    else begin
                        //Message('Insufficient funds for member %1', Members."No.");
                        CurrReport.Skip;
                    end;
                end;
                // end;
                // else begin
                //     Message('Member Class not found for member %1 ', Members."No.");
                //     CurrReport.Skip;
                // end;
                // end;
            }
            trigger OnPreDataItem()
            begin
                BosaAccountNo := '';
                Members.setfilter("Registration Date", '..%1', Pdate);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(RequiredShares; RequiredShares)
                    {
                        Caption = 'Required Shares to be Recovered';
                    }
                    field(Pdate; Pdate)
                    {
                        Caption = 'Posting Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostReport()
    begin
        if SaccoTrans.PostJournal(JTemplate, JBatch) then
            Message('Share Recovery Processed Successfully') else
            Message('No Lines to be posted');
    end;

    trigger OnPreReport()
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Recover Share & Entrance Fee", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);

        if (RequiredShares = 0) or (RequiredShares > 30000) then
            Error('Please specify the Required Shares to be recovered before running the report.');
        if Pdate = 0D then
            error('Please specify the Posting Date before running the report.');
        BankingUserTemp.get(UserId);
        if BankingUserTemp.Get(UserId) then begin
            BankingUserTemp.testfield("Cashier Journal Template");
            BankingUserTemp.testfield("Cashier Journal Batch");
            JTemplate := BankingUserTemp."Cashier Journal Template";
            JBatch := BankingUserTemp."Cashier Journal Batch";

            SaccoTrans.InitJournal(JTemplate, JBatch);
        end else
            Error('You are not set up as a cashier in Banking User Template : %1 ', UserId);
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
        //SavingaAccountList: record "Savings Accounts";
        RequiredShares: Decimal;
        // MinimumShareCap: Decimal;
        BOSABal: Decimal;
        GlobalFunc: Codeunit "Global Functions";
        PostingAmount: Decimal;
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to recover Share Capital. Kindly contact system administrator for assistance.';
        Pdate: Date;

}
