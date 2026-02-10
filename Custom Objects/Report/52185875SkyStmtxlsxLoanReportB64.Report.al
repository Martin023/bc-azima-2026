#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185875 "Sky Stmt xlsx Loan Report B64."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sky Stmt xlsx Loan Report B64..rdl';

    dataset
    {
        dataitem("Credit Ledger Entry"; "Credit Ledger Entry")
        {
            DataItemTableView = sorting("Posting Date") order(descending);
            column(ReportForNavId_1; 1)
            {
            }
            column(EntryNo_CreditLedgerEntry; "Credit Ledger Entry"."Entry No.")
            {
            }
            column(PostingDate_CreditLedgerEntry; "Credit Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."Document No.")
            {
            }
            column(Description_CreditLedgerEntry; "Credit Ledger Entry".Description)
            {
            }
            column(Amount_CreditLedgerEntry; "Credit Ledger Entry".Amount)
            {
            }
            column(DebitAmount_CreditLedgerEntry; "Credit Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_CreditLedgerEntry; "Credit Ledger Entry"."Credit Amount")
            {
            }
            column(RunningBalance; RunningBalance)
            {
            }
            column(EntryType; EntryType)
            {
            }
            column(SaccoName; SaccoName)
            {
            }
            column(SaccoAddress; SaccoAddress)
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(MemberAccountName; MemberAccountName)
            {
            }
            column(MemberAccountNumber; MemberAccountNumber)
            {
            }
            column(Slogan; Slogan)
            {
            }
            column(SaccoPhone; SaccoPhone)
            {
            }
            column(OpeningBal; OpeningBal)
            {
            }
            column(DateRange; DateRange)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(ClosingBal; ClosingBal)
            {
            }
            column(DateIssued; DateIssued)
            {
            }
            column(WholeDate; WholeDate)
            {
            }
            column(Image; Image)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(MemberPhone; MemberPhone)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // RunningBalance := MemPort.GetLoanRunningBal("Credit Ledger Entry"."Entry No.", "Credit Ledger Entry"."Loan No");
                // if "Credit Ledger Entry".Amount < 0 then EntryType := 'Credit';
                // if "Credit Ledger Entry".Amount > 0 then EntryType := 'Debit';
                // Amount := "Credit Ledger Entry".Amount;
                // Amount *= -1;
                // PostingDate := MemPort.FormatDate("Credit Ledger Entry"."Posting Date");
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
        SaccoName := CompanyInformation.Name;
        SaccoAddress := CompanyInformation.Address;
        SaccoPhone := CompanyInformation."Phone No.";
        Slogan := 'Your Future Our Concern';
        CompanyInformation.CalcFields(Picture);
        Image := Format(CompanyInformation.Picture);

        LoanNo := "Credit Ledger Entry".GetFilter("Loan No");
        Loan.Get(LoanNo);
        MemberAccountNumber := Loan."Member No.";
        //Ven.GET(MemberAccountNumber);
        MemberName := Loan."Member Name";
        //ProductFactory.GET(SavingsAccounts."Net Change");

        Members.Get(Loan."Member No.");

        MemberPhone := Members."Phone No.";
        if MemberPhone = '' then MemberPhone := Members."Phone No.";

        Product.Get(Loan."Loan Product Type");
        MemberAccountName := Loan."Loan Product Type Name";
        DateRange := "Credit Ledger Entry".GetFilter("Posting Date");

        if "Credit Ledger Entry".FindLast then begin
            FirstEntryNo := "Credit Ledger Entry"."Entry No.";
            GetBalances(LoanNo, "Credit Ledger Entry"."Entry No.", OpeningBal, TotalCredits, TotalDebits, FirstEntryNo, LastEntryNo);
            //Fromdate := MemPort.FormatDate("Credit Ledger Entry"."Posting Date");
        end;
        //MESSAGE('Opening Bal : %1 Closing Bal : %2',FORMAT(OpeningBal),FORMAT(ClosingBal));

        if "Credit Ledger Entry".FindFirst then begin
            LastEntryNo := "Credit Ledger Entry"."Entry No.";
            GetBalances(LoanNo, "Credit Ledger Entry"."Entry No.", ClosingBal, TotalCredits, TotalDebits, FirstEntryNo, LastEntryNo);
            //ToDate := MemPort.FormatDate("Credit Ledger Entry"."Posting Date");
        end;
        //MESSAGE('Opening Bal : %1 Closing Bal : %2',FORMAT(OpeningBal),FORMAT(ClosingBal));

        //DateIssued := MemPort.FormatDate(Today);
        //MESSAGE('Total Credits : %1 Total Debits : %2',FORMAT(TotalCredits),FORMAT(TotalDebits));
        WholeDate := 'For ' + Fromdate + ' to ' + ToDate;
    end;

    var
        RunningBalance: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        EntryType: Text;
        Amount: Decimal;
        SaccoName: Text;
        SaccoAddress: Text;
        MemberName: Text;
        MemberAccountName: Text;
        MemberAccountNumber: Code[30];
        DateRange: Text;
        Slogan: Text;
        SaccoPhone: Text;
        OpeningBal: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        ClosingBal: Decimal;
        DateIssued: Text;
        Members: Record "Members";
        CompanyInformation: Record "Company Information";
        ProductFactory: Record "Product Factory";
        MemberNo: Code[30];
        SavingsAccounts: Record "Savings Accounts";
        FirstEntryNo: Integer;
        LastEntryNo: Integer;
        Fromdate: Text;
        ToDate: Text;
        WholeDate: Text;
        Image: Text;
        // MemPort: Codeunit "Sky Harambee Portal";
        PostingDate: Text;
        Ven: Record Vendor;
        Loan: Record Loans;
        Product: Record "Product Factory";
        LoanNo: Code[30];
        MemberPhone: Text[50];

    local procedure GetBalances(LnNo: Code[30]; EntryNumber: Integer; var Balances: Decimal; var Crds: Decimal; var Dbts: Decimal; FirstEntry: Integer; LastEntry: Integer)
    var
        MemL: Record "Interest Due Period";
        OI: Decimal;
        PaidAmount: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        OB: Decimal;
    begin
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LnNo);
        CreditLedgerEntry.SetRange("Entry No.", FirstEntry, LastEntry);
        CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."transaction type"::Bills);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount, "Credit Amount", "Debit Amount");
            Dbts := CreditLedgerEntry."Debit Amount";
            Crds := CreditLedgerEntry."Credit Amount";
        end;

        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LnNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', FirstEntry);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::"Interest Due", "Credit Ledger Entry"."transaction type"::"Interest Paid");
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            OI := CreditLedgerEntry.Amount;
            if OI < 0 then OI := 0;
        end;
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LnNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', FirstEntry);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Repayment, "Credit Ledger Entry"."transaction type"::Loan);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            OB := CreditLedgerEntry.Amount;
        end;
        Balances := OB + OI;


        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LnNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', LastEntry);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::"Interest Due", "Credit Ledger Entry"."transaction type"::"Interest Paid");
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            OI := CreditLedgerEntry.Amount;
            if OI < 0 then OI := 0;
        end;
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LnNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', LastEntry);
        CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Repayment, "Credit Ledger Entry"."transaction type"::Loan);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            OB := CreditLedgerEntry.Amount;
        end;

        Balances := OB + OI;
    end;
}
