report 52186079 "CRM Savings's Statement"
{
    Caption = 'CRM Savings''s Statement';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CRM Savings''s Statement.rdl';
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            RequestFilterFields = "No.";
            column(Name; Name)
            {

            }
            column(No_; "No.")
            {

            }

            column(ID_No_; "ID No.")
            {

            }

            column(Product_Type; "Product Type")
            {

            }
            column(DateIssued; DateIssued)
            {

            }
            column(AccountString; AccountString)
            {

            }

            dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = where(Reversed = const(false));

                column(Debit_Amount; "Debit Amount")
                {

                }
                column(Credit_Amount; "Credit Amount")
                {

                }
                column(Amount; Amount)
                {

                }
                column(RunningBalance; RunningBalance)
                {

                }

                column(Document_No_; "Document No.")
                {

                }

                column(MyDate; MyDate)
                {

                }
                column(Description; Description)
                {

                }

                trigger OnAfterGetRecord()
                var
                    SavingsLedgerEntry: Record "Savings Ledger Entry";
                begin
                    SavingsLedgerEntry.RESET;
                    SavingsLedgerEntry.SETRANGE("Customer No.", "Savings Ledger Entry"."Customer No.");
                    SavingsLedgerEntry.SETFILTER("Entry No.", '<=%1', "Savings Ledger Entry"."Entry No.");
                    IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                        SavingsLedgerEntry.CALCSUMS(Amount);
                        RunningBalance := SavingsLedgerEntry.Amount;
                        RunningBalance *= -1;
                    END;

                    MyDate := FormatDate("Savings Ledger Entry"."Posting Date");

                end;
            }

            trigger OnAfterGetRecord()
            var
                ProductFactory: Record "Product Factory";

            begin
                if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                    AccountString := ProductFactory."Product Description" + '-' + SavingsAccounts."No.";
                end;
            end;

            trigger OnPostDataItem()
            var
            begin
                DateIssued := FormatDate(Today);
            end;
        }


    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        RunningBalance: Decimal;
        MyDate: Text;
        DateIssued: Text;
        AccountString: Text;

    local procedure FormatDate(RealDate: Date): Text
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
        FormatedMonth: Text;
        DateText: Text;
    begin
        IF RealDate <> 0D THEN BEGIN
            Day := DATE2DMY(RealDate, 1);
            Month := DATE2DMY(RealDate, 2);
            Year := DATE2DMY(RealDate, 3);
        END;

        IF Month = 1 THEN FormatedMonth := 'Jan';
        IF Month = 2 THEN FormatedMonth := 'Feb';
        IF Month = 3 THEN FormatedMonth := 'Mar';
        IF Month = 4 THEN FormatedMonth := 'Apr';
        IF Month = 5 THEN FormatedMonth := 'May';
        IF Month = 6 THEN FormatedMonth := 'June';
        IF Month = 7 THEN FormatedMonth := 'July';
        IF Month = 8 THEN FormatedMonth := 'Aug';
        IF Month = 9 THEN FormatedMonth := 'Sept';
        IF Month = 10 THEN FormatedMonth := 'Oct';
        IF Month = 11 THEN FormatedMonth := 'Nov';
        IF Month = 12 THEN FormatedMonth := 'Dec';


        DateText := FORMAT(Day) + ' ' + FormatedMonth + ' ' + FORMAT(Year);

        IF RealDate = 0D THEN DateText := '';
        exit(DateText);
    end;
}
