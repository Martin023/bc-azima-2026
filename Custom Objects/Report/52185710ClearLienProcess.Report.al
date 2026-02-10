#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185710 "Clear Lien Process"
{
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Employer; Employer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer';
                    TableRelation = Customer."No." where("Account Type" = filter(Employer));
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //Counter:=0;
    end;

    trigger OnPreReport()
    begin
        ProgressWindow.Open('Processing Loan No. #1#######');
        RepayLoans;
    end;

    var
        UserSetups: Record "User Setup";
        OverDraftAuthorisation: Record "Over Draft Authorisation";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Loans: Record Loans;
        CashierTransactions: Record "Cashier Transactions";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills;
        AccNo: Code[20];
        BalAccNo: Code[20];
        Amt: Decimal;
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        ProgressWindow: Dialog;
        Counter: Integer;
        Employer: Code[30];

    local procedure RepayLoans()
    var
        Loans: Record Loans;
        JournalPosting: Codeunit "Journal Posting";
        BankingUserTemplate: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineNo: Integer;
        Amount: Decimal;
        GeneralSetUp: Record "General Set-Up";
        ProductF: Record "Product Factory";
        AmountPaid: Decimal;
    begin


        BankingUserTemplate.Get(UserId);
        JTemplate := BankingUserTemplate."Cashier Journal Template";
        JBatch := BankingUserTemplate."Cashier Journal Batch";

        //JournalPosting.ClearJournalLines(JTemplate, JBatch);
        CashierTransactions.Reset;
        CashierTransactions.SetRange(Type, CashierTransactions.Type::Lien);
        CashierTransactions.SetRange(Posted, true);
        CashierTransactions.SetRange("Cheque Status", CashierTransactions."cheque status"::Pending);
        //?CashierTransactions.SETRANGE("Employer Code",Employer);
        if CashierTransactions.Find('-') then begin
            Counter := CashierTransactions.Count;

            repeat
                AmountPaid := 0;
                Loans.Reset;
                Loans.SetRange("Loan No.", CashierTransactions."Transaction Description");
                //Loans.SETFILTER("Date Filter",'..'+FORMAT(TODAY));

                if Loans.Find('-') then begin
                    CreditLedgerEntry.Reset;
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."transaction type"::Repayment, CreditLedgerEntry."transaction type"::"Interest Paid");
                    if CreditLedgerEntry.Find('-') then begin
                        CreditLedgerEntry.CalcSums("Amount (LCY)");
                        AmountPaid := -CreditLedgerEntry."Amount (LCY)";
                    end;
                    //MESSAGE('%1',AmountPaid);
                    if AmountPaid >= Loans.Repayment then begin
                        CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                        CashierTransactions.Modify;
                    end else begin
                        SavAcc.Get(CashierTransactions."Account No");
                        SavAcc.Blocked := SavAcc.Blocked::" ";
                        SavAcc.CalcFields("Balance (LCY)");
                        SavAcc.Modify;
                        SavAcc.CalcFields("Balance (LCY)");
                        if SavAcc."Balance (LCY)" >= CashierTransactions.Amount then begin
                            if CalcDate('CM+1M', Loans."Disbursement Date") <= Today then begin

                                Loans.CalcFields("Outstanding Balance", "Outstanding Bills", "Outstanding Interest");
                                if Loans."Outstanding Interest" > 0 then begin

                                    Amount := CashierTransactions.Amount;
                                    //ERROR('%1',Amount);

                                    if Loans."Outstanding Interest" < Amount then
                                        Amt := Loans."Outstanding Interest"
                                    else
                                        Amt := Amount;

                                    LineNo += 100;

                                    //Loan Interest
                                    // if Amt > 0 then
                                    //     JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Accttype::Credit, CashierTransactions.No, 'Loan Interest Paid', -Amt,
                                    //     Loans."Loan Account", Today, Balacctype::"G/L Account", '', '', CashierTransactions."Global Dimension 1 Code", CashierTransactions."Global Dimension 2 Code",
                                    //     Transtype::"Interest Paid", Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    Amount -= Amt;

                                    LineNo += 100;
                                    //Loan Repayment
                                    // if Amount > 0 then
                                    //     JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Accttype::Credit, CashierTransactions.No, 'Loan Repayment', -Amount,
                                    //     Loans."Loan Account", Today, Balacctype::"G/L Account", '', '', CashierTransactions."Global Dimension 1 Code", CashierTransactions."Global Dimension 2 Code",
                                    //     Transtype::Repayment, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                    if ProductF.Get(Loans."Loan Product Type") then begin
                                        ProductF.TestField(ProductF."Billed Account");
                                        BalAccNo := ProductF."Billed Account";
                                    end;
                                    LineNo += 100;
                                    //Loan Bills
                                    // if Amount > 0 then
                                    //     JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Accttype::Credit, CashierTransactions.No, 'Loan Repayment Bills', -Amount,
                                    //     Loans."Loan Account", Today, Balacctype::"G/L Account", BalAccNo, '', CashierTransactions."Global Dimension 1 Code", CashierTransactions."Global Dimension 2 Code",
                                    //     Transtype::Bills, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    LineNo += 100;
                                    //Debit Savings;
                                    // JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Accttype::Savings, CashierTransactions.No, 'Loan Repayment', CashierTransactions.Amount,
                                    // Loans."Disbursement Account No", Today, Balacctype::"G/L Account", '', '', CashierTransactions."Global Dimension 1 Code", CashierTransactions."Global Dimension 2 Code",
                                    // Transtype::Repayment, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    // CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                                    // CashierTransactions.Modify;
                                end;
                            end;
                        end;
                    end;
                end;
            until CashierTransactions.Next = 0;
            //JournalPosting.CompletePosting(JTemplate, JBatch);

            ProgressWindow.Update(1, (Counter - 1));
        end;
        ProgressWindow.Close;
    end;
}
