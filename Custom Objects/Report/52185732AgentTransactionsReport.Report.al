#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185732 "Agent Transactions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Agent Transactions Report.rdl';

    dataset
    {
        dataitem("Agent Transactions"; "Agent Transactions")
        {
            RequestFilterFields = "Agent Code", "Transaction Type", "Date Posted";
            column(ReportForNavId_1; 1)
            {
            }
            column(DocumentNo_AgentTransactions; "Agent Transactions"."Document No.")
            {
            }
            column(TransactionDate_AgentTransactions; "Agent Transactions"."Transaction Date")
            {
            }
            column(AccountNo_AgentTransactions; "Agent Transactions"."Account No.")
            {
            }
            column(Description_AgentTransactions; "Agent Transactions".Description)
            {
            }
            column(Amount_AgentTransactions; "Agent Transactions".Amount)
            {
            }
            column(Posted_AgentTransactions; "Agent Transactions".Posted)
            {
            }
            column(TransactionType_AgentTransactions; "Agent Transactions"."Transaction Type")
            {
            }
            column(AgentCode_AgentTransactions; "Agent Transactions"."Agent Code")
            {
            }
            column(LoanNo_AgentTransactions; "Agent Transactions"."Loan No")
            {
            }
            column(Company_Picture; CompanyInformation.Picture)
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(IDNO; IDNO)
            {
            }
            column(AccountName; AccountName)
            {
            }
            column(StaffNo; StaffNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if SavingsAccounts.Get("Agent Transactions"."Account No.") then begin
                    AccountName := SavingsAccounts.Name;
                    MemberNo := SavingsAccounts."Member No.";
                    IDNO := SavingsAccounts."ID No.";
                    StaffNo := SavingsAccounts."Payroll/Staff No.";
                end;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        SavingsAccounts: Record "Savings Accounts";
        AccountName: Text[100];
        MemberNo: Code[20];
        IDNO: Code[10];
        StaffNo: Code[10];
}
