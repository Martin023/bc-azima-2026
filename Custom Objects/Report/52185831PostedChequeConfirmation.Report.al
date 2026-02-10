#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185831 "Posted Cheque Confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Posted Cheque Confirmation.rdl';

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            column(ReportForNavId_1102755005; 1102755005)
            {
            }
            column(Payee_PaymentsHeader; "Payments Header".Payee)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
                column(CompanyInfoName; CompanyInfo.Name)
                {
                }
                column(CompanyInfoAdd; CompanyInfo.Address)
                {
                }
                column(CompanyInfoAdd2; CompanyInfo."Address 2")
                {
                }
                column(CompanyInfoPhone; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(SNo; SNo)
                {
                }
                column(BankName; Bank.Name)
                {
                }
                column(BankAdd; Bank.Address)
                {
                }
                column(BankCity; Bank.City)
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                    "Bank Account Ledger Entry".Amount := Abs("Bank Account Ledger Entry".Amount);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Bank.Get("Paying Bank Account");
                "Payments Header".TestField("Payments Header"."Cheque No.");
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        SNo := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        SNo: Integer;
        PaymentsHeader: Record "Payments Header";
}
