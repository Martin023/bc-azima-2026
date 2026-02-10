#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185677 "Loan Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Statement.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            dataitem("Credit Ledger Entry"; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No" = field("Loan No.");
                DataItemTableView = sorting("Entry No.") order(ascending) where("Transaction Type" = filter(Loan | Repayment | "Interest Due" | "Interest Paid"));
                column(ReportForNavId_3; 3)
                {
                }
                column(Amount_CreditLedgerEntry; "Credit Ledger Entry".Amount)
                {
                }
                column(PostingDate_CreditLedgerEntry; "Credit Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_CreditLedgerEntry; "Credit Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."Document No.")
                {
                }
                column(Description_CreditLedgerEntry; "Credit Ledger Entry".Description)
                {
                }
                column(DebitAmount_CreditLedgerEntry; "Credit Ledger Entry"."Debit Amount")
                {
                }
                column(CreditAmount_CreditLedgerEntry; "Credit Ledger Entry"."Credit Amount")
                {
                }
                column(DebitAmountLCY_CreditLedgerEntry; "Credit Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_CreditLedgerEntry; "Credit Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(Amount_CreditLedgerEntrys; "Credit Ledger Entry".Amount)
                {
                }
            }
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
}
