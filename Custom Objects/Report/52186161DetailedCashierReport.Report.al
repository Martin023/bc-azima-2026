#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186161 "Detailed Daily Cashier"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Detailed Daily Cashier.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";

            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(DateFilter_BankAccount; "Bank Account"."Date Filter")
            {
            }
            column(BankAccPostingGroup_BankAccount; "Bank Account"."Bank Acc. Posting Group")
            {
            }
            column(ResponsibilityCenter_BankAccount; "Bank Account"."Responsibility Center")
            {
            }
            column(MinBalance_BankAccount; "Bank Account"."Min. Balance")
            {
            }
            column(OpBal; OpBal)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(BankAccBalance; BankAccBalance)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") order(ascending);

                column(EntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                column(UserID_BankAccountLedgerEntry; "Bank Account Ledger Entry"."User ID")
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
                column(BalAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bal. Account No.")
                {
                }
                column(DocumentType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CashierTrans.Reset();
                    CashierTrans.SetRange(No, "Bank Account Ledger Entry"."Document No.");

                end;

                trigger OnPreDataItem()
                begin

                end;
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

    trigger OnInitReport()
    begin
        PageGroupNo := 1;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        BankAccFilter := "Bank Account".GetFilters;
        DateFilter_BankAccount := "Bank Account".GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text[250];
        DateFilter_BankAccount: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        MinDate: Date;
        OpBal: Decimal;
        BankAcc: Record "Bank Account";
        CashierTrans: record "Cashier Transactions";
        MemAccNo: Code[100];
}
