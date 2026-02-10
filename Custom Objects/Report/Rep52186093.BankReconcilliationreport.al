report 52186093 "Bank Reconcilliation report"
{
    ApplicationArea = All;
    Caption = 'Bank Reconcilliation report';
    UsageCategory = ReportsAndAnalysis;
    RdlcLayout = './bc-azima-2026/Layout/Bank Reconcilliation report.rdl';
    dataset
    {
        dataitem(BankAccReconciliation; "Bank Acc. Reconciliation")
        {
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankAccountName; "Bank Account Name")
            {
            }
            column(BankAccountBalanceLCY; "Bank Account Balance (LCY)")
            {
            }
            column(BalanceLastStatement; "Balance Last Statement")
            {
            }
            column(StatementNo; "Statement No.")
            {
            }
            column(StatementDate; "Statement Date")
            {
            }
            column(StatementEndingBalance; "Statement Ending Balance")
            {
            }
            column(TotalAppliedAmount; "Total Applied Amount")
            {
            }
            column(TotalDifference; "Total Difference")
            {
            }
            column(TotalBalanceonBankAccount; "Total Balance on Bank Account")
            {
            }
            dataitem(BankAccReconciliationLine; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                column(Document_No_; "Document No.")
                {
                }

                column(Applied_Amount; "Applied Amount")
                {
                }
                column(Applied_Entries; "Applied Entries")
                {
                }
                column(External_Document_No; "External Document No")
                {
                }
                column(Transaction_Date; "Transaction Date")
                {
                }
                column(Description; "Description")
                {
                }
                column(Debit_Amount; "Debit Amount")
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }

            }
            dataitem("Apply Bank Acc. Ledger Entries"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                DataItemTableView = where(Open = const(true));

                column(AppliedDocument_No_; "Document No.")
                {
                }
                column(AppliedExternal_Document_No; "External Document No.")
                {
                }
                column(AppliedTransaction_Date; "Posting Date")
                {
                }
                column(AppliedDescription; "Description")
                {
                }
                column(AppliedDebit_Amount; "Debit Amount")
                {
                }
                column(AppliedCredit_Amount; "Credit Amount")
                {
                }
                column(StatementStatus; "Statement Status")
                {
                }
                column(IsApplied; "Apply Bank Acc. Ledger Entries".GetAppliedStatementNo <> '')
                {
                }
                trigger OnPreDataItem()
                begin
                    if BankAccReconciliation."Statement Date" <> 0D then
                        "Apply Bank Acc. Ledger Entries".SetFilter("Posting date", '<=%1', BankAccReconciliation."Statement Date")
                    else
                        "Apply Bank Acc. Ledger Entries".SetFilter("Posting date", '<=%1', TODAY);
                end;
            }
        }

    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
