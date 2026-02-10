#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185787 "Daily Cashier Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Daily Cashier Summary.rdl';

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
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") order(ascending) where("Document Type" = const(Invoice));

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
                    if not PrintReversedEntries and "Bank Account Ledger Entry".Reversed then
                        CurrReport.Skip;
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + "Bank Account Ledger Entry".Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Bank Account Ledger Entry"."Amount (LCY)"
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                    CurrReport.CreateTotals("Bank Account Ledger Entry".Amount, "Bank Account Ledger Entry"."Amount (LCY)");
                end;
            }
            dataitem(Receipts; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") order(ascending) where("Document Type" = const(" "), Amount = filter(> 0));
                column(ReportForNavId_1000000019; 1000000019)
                {
                }
                column(EntryNo_Receipts; Receipts."Entry No.")
                {
                }
                column(PostingDate_Receipts; Receipts."Posting Date")
                {
                }
                column(DocumentNo_Receipts; Receipts."Document No.")
                {
                }
                column(Description_Receipts; Receipts.Description)
                {
                }
                column(BalAccountNo_Receipts; Receipts."Bal. Account No.")
                {
                }
                column(Amount_Receipts; Receipts.Amount)
                {
                }
                column(UserID_Receipts; Receipts."User ID")
                {
                }
            }
            dataitem(Other_Payments; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") order(ascending) where("Document Type" = filter(<> Invoice), Amount = filter(< 0));
                column(ReportForNavId_1000000011; 1000000011)
                {
                }
                column(EntryNo_OtherPayments; Other_Payments."Entry No.")
                {
                }
                column(PostingDate_OtherPayments; Other_Payments."Posting Date")
                {
                }
                column(DocumentNo_OtherPayments; Other_Payments."Document No.")
                {
                }
                column(Description_OtherPayments; Other_Payments.Description)
                {
                }
                column(UserID_OtherPayments; Other_Payments."User ID")
                {
                }
                column(BalAccountNo_OtherPayments; Other_Payments."Bal. Account No.")
                {
                }
                column(Amount_OtherPayments; Other_Payments.Amount)
                {
                }
            }
            dataitem(IOU_Payments; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") order(ascending) where("Document Type" = const(Invoice), Amount = filter(< 0));
                column(ReportForNavId_1000000013; 1000000013)
                {
                }
                column(EntryNo_IOUPayments; IOU_Payments."Entry No.")
                {
                }
                column(Amount_IOUPayments; IOU_Payments.Amount)
                {
                }
                column(PostingDate_IOUPayments; IOU_Payments."Posting Date")
                {
                }
                column(DocumentNo_IOUPayments; IOU_Payments."Document No.")
                {
                }
                column(Description_IOUPayments; IOU_Payments.Description)
                {
                }
                column(UserID_IOUPayments; IOU_Payments."User ID")
                {
                }
                column(BalAccountNo_IOUPayments; IOU_Payments."Bal. Account No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                if DateFilter_BankAccount <> '' then
                    if "Bank Account".GetRangeMin("Bank Account"."Date Filter") <> 0D then begin
                        "Bank Account".SetRange("Bank Account"."Date Filter", 0D, "Bank Account".GetRangeMin("Bank Account"."Date Filter") - 1);
                        "Bank Account".CalcFields("Bank Account"."Net Change", "Bank Account"."Net Change (LCY)");
                        StartBalance := "Bank Account"."Net Change";
                        StartBalanceLCY := "Bank Account"."Net Change (LCY)";
                        "Bank Account".SetFilter("Bank Account"."Date Filter", DateFilter_BankAccount);
                    end;
                //CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;
                OpBal := StartBalance;

                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Bank Account Ledger Entry"."Amount (LCY)", StartBalanceLCY);
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
}
