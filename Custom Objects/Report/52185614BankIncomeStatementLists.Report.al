#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185614 "Bank Income Statement Lists"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Bank Income Statement Lists.rdl';
    Caption = 'Posted Bank Account Reconciliation Report';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(CashBookBalance_BankAccountStatement; "Bank Account Statement"."Cash Book Balance")
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                // DataItemTableView = where(Reconciled = d=const(No));
                column(ReportForNavId_14; 14)
                {
                }
                column(BankAccountNo_BankAccountStatementLine; "Bank Account Statement Line"."Bank Account No.")
                {
                }
                column(StatementNo_BankAccountStatementLine; "Bank Account Statement Line"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Account Statement Line".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine; "Bank Account Statement Line"."Document No.")
                {
                }
                column(Debit_BankAccountStatementLine; "Bank Account Statement Line"."Notes Line 2")
                {
                }
                column(Credit_BankAccountStatementLine; "Bank Account Statement Line"."Notes Line 3")
                {
                }
                column(OpenType_BankAccountStatementLine; "Bank Account Statement Line"."Notes Line 4")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //  IF  "Bank Account Statement Line"."Statement Amount">0 THEN CurrReport.SKIP;
                    if "Bank Account Statement Line"."Statement Amount" > 0 then
                        "Bank Account Statement Line"."Notes Line 4" := "Bank Account Statement Line"."Notes Line 4";
                    if "Bank Account Statement Line"."Statement Amount" < 0 then
                        "Bank Account Statement Line"."Notes Line 4" := "Bank Account Statement Line"."Notes Line 4";
                    "Bank Account Statement Line".Modify;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account Statement"."Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.CalcFields(Bank.Balance);
                    BankAccountBalanceasperCashBook := Bank.Balance;

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Bank Account Statement"."Statement No.");
                    BankStatementLine.SetRange(BankStatementLine.Reconciled, false);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Account Statement Line";
        CompanyInfo: Record "Company Information";
}
