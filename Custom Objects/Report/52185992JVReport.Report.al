#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185992 "JV Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/JV Report.rdl';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where(Reversed = filter(false));
            RequestFilterFields = "Posting Date", "User ID", "Document No.", "Journal Batch Name";
            column(ReportForNavId_1; 1)
            {
            }
            column(JournalBatchName_GLEntry; "G/L Entry"."Journal Batch Name")
            {
            }
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(DocumentType_GLEntry; "G/L Entry"."Document Type")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(BalAccountNo_GLEntry; "G/L Entry"."Bal. Account No.")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_GLEntrys; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(UserID_GLEntry; "G/L Entry"."User ID")
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(BalAccountType; "G/L Entry"."Bal. Account Type")
            {
            }
            column(TransType; TransType)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(AccountNo; SaveAccount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Creditledger.Reset;
                Creditledger.SetRange("Entry No.", "G/L Entry"."Entry No.");
                if Creditledger.Find('-') then begin
                    LoanNo := Creditledger."Loan No";
                    TransType := Creditledger."Transaction Type";
                end;
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Entry No.", "G/L Entry"."Entry No.");
                if SavingsLedgerEntry.Find('-') then begin
                    SaveAccount := SavingsLedgerEntry."Customer No.";
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

    var
        TransType: Enum "Transaction Types";
        Creditledger: Record "Credit Ledger Entry";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        SaveAccount: Code[50];
        LoanNo: Code[50];
}
