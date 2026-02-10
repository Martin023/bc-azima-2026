#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185636 "Clear Cheque Report"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Cashier Transactions"; "Cashier Transactions")
        {
            RequestFilterFields = Select;
            trigger OnAfterGetRecord()
            var
                Transactions: Record "Cashier Transactions";
                GenJournalLine: Record "Gen. Journal Line";
                Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
                Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
                TCharges: Decimal;
                TransactionCharges: Record "Transaction Charges";
                ChargeAmount: Decimal;
                TariffDetails: Record "Tiered Charges Lines";
                TChargeAmount: Decimal;
                Loans: Record Loans;
                CTransLines: Record "Cashier Transaction Lines";
                CreditLedger: Record "Credit Ledger Entry";
                Temp: Record "Banking User Template";
                GenSetup: Record "General Set-Up";
                JBatch: Code[20];
                Jtemplate: Code[20];
                LineNo: Integer;

            begin
                Temp.Get(UserId);
                GenSetup.Get;

                Jtemplate := Temp."Cashier Journal Template";
                JBatch := Temp."Cashier Journal Batch";

                if Jtemplate = '' then begin
                    Error(Text0001);
                end;

                if JBatch = '' then begin
                    Error(Text0002);
                end;

                Transactions.Reset;
                Transactions.SetRange(No, "Cashier Transactions".No);
                Transactions.SetRange(Posted, true);
                Transactions.SetFilter("Expected Maturity Date", '<=%1', Today);
                Transactions.SetRange(Transactions."Cheque Status", Transactions."cheque status"::Pending);
                if Transactions.Find('-') then begin
                    repeat
                        if (Transactions.Type = Transactions.Type::"Cheque Deposit") or (Transactions.Type = Transactions.Type::"Credit Cheque") then begin
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            GenJournalLine.DeleteAll;

                            CreditLedger.Reset;
                            CreditLedger.SetRange("Loan No", CTransLines."Loan No");
                            CreditLedger.SetRange("Document No.", CTransLines."Transaction No");
                            if not CreditLedger.Find('-') then begin
                                if Transactions.Type = Transactions.Type::"Credit Cheque" then begin
                                    PostCreditCheque(Transactions, Jtemplate, JBatch, Transactions."Account No", Transactions."Global Dimension 2 Code",
                                    Transactions."Global Dimension 1 Code");
                                end;
                            end;
                            //Recover Discounting
                            if Transactions."Discounted Amount" > 0 then begin
                                Loans.Reset;
                                Loans.SetRange(Loans.Remarks, Transactions.No);
                                Loans.SetRange(Loans."Member No.", Transactions."Member No.");
                                Loans.SetRange(Loans.Posted, true);
                                if Loans.Find('-') then begin
                                    repeat
                                        Loans.CalcFields(Loans."Outstanding Balance");
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := Transactions.No;
                                        GenJournalLine."External Document No." := Loans."Loan No.";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                                        GenJournalLine."Account No." := Loans."Loan Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Discounting Loan Recovery';
                                        GenJournalLine.Amount := -Loans."Outstanding Balance";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                        GenJournalLine."Loan No" := Loans."Loan No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := Transactions."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Transactions."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := Transactions.No;
                                        GenJournalLine."External Document No." := Loans."Loan No.";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                                        GenJournalLine."Account No." := Transactions."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Discounting Loan Recovery';
                                        GenJournalLine.Amount := (Loans."Outstanding Balance");
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := Transactions."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Transactions."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    until Loans.Next = 0;
                                end else
                                    Error('Discounting loan for %1 not found.', Transactions.No);
                            end;

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                            end;
                            //Post New
                            Transactions."Cheque Status" := Transactions."cheque status"::Cleared;
                            Transactions."Date Cleared" := Today;
                            Transactions."Cleared By" := UserId;
                            Transactions.Modify(true);
                        end;

                        CTransLines.Reset;
                        CTransLines.SetRange("Transaction No", Transactions.No);
                        if CTransLines.Find('-') then begin
                            repeat
                                if CTransLines."Transaction Type" = CTransLines."transaction type"::Repayment then begin
                                    if Loans.Get(CTransLines."Loan No") then
                                        Loans.Validate(Repayment);
                                end;
                            until CTransLines.Next = 0;
                        end;
                    until Transactions.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin

            end;
        }

    }

    // trigger OnPreReport()
    // begin
    //     if SELECT = 0D then
    //         NextRunDate := Today;
    // end;

    procedure PostCreditCheque(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        CTransLines: Record "Cashier Transaction Lines";
        GenJournalLine: Record "Gen. Journal Line";
        CreditLedger: Record "Credit Ledger Entry";
        LineNo: Integer;
    begin
        // with CashierTrans do
        begin
            CTransLines.Reset;
            CTransLines.SetRange(CTransLines."Transaction No", CashierTrans.No);
            if CTransLines.Find('-') then begin
                repeat
                    CreditLedger.Reset;
                    CreditLedger.SetRange("Document No.", CTransLines."Transaction No");
                    CreditLedger.SetRange("Loan No", CTransLines."Loan No");
                    if not CreditLedger.Find('-') then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."External Document No." := CashierTrans."Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := TillNo;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;//"Transaction Date";
                        GenJournalLine.Description := CashierTrans."Transaction Description";
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := CTransLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."External Document No." := CashierTrans."Cheque No";
                        GenJournalLine."Posting Date" := Today;//"Transaction Date";
                        if CTransLines.Type = CTransLines.Type::Credit then
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit
                        else
                            if CTransLines.Type = CTransLines.Type::Savings then
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                        GenJournalLine.Description := 'Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type");
                        GenJournalLine."Account No." := CTransLines."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Amount := -CTransLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine."Transaction Type" := CTransLines."Transaction Type";
                        GenJournalLine."Loan No" := CTransLines."Loan No";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                until CTransLines.Next = 0;
            end;
        end;
    end;
}
