#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187393 "Dividend Provision"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {

            DataItemTableView = WHERE("Product Type" = FILTER(1 | 2 | 3));
            trigger OnAfterGetRecord()
            begin
                DividendSetUp.Get();



                if ProductFactory.Get("Savings Accounts"."Product Type") then begin
                    if ProductFactory."Dividend Calc. Method" <> ProductFactory."dividend calc. method"::" " then begin
                        DividendProvision.Reset;
                        DividendProvision.SetRange(DividendProvision.Year, Date2dmy(DividendSetUp."Start Date", 3));
                        DividendProvision.SetRange("Account No", "Savings Accounts"."No.");
                        DividendProvision.SetRange(DividendProvision.Month, I);
                        DividendProvision.SetRange(Posted, false);
                        if DividendProvision.Find('-') then
                            DividendProvision.DeleteAll;



                        intProgressI += 1;

                        if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                            NoOfProgressed := NoOfProgressed + intProgressI;
                            diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                            intProgressI := 0;
                            TimeProgress := Time;
                        end;


                        DividendProcess.generateProvision("Savings Accounts", I, '');
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
                diaProgress.Close;
                DividendProvision.reset;
                DividendProvision.SetRange(Month, I);
                DividendProvision.SetRange(Year, Date2dmy(DividendSetUp."Start Date", 3));
                if DividendProvision.FindSet() then begin
                    DividendProvision.CalcSums("Gross Dividends");
                    Totals := DividendProvision."Gross Dividends";//By reference
                end;
                Message('Dividend for %1\Totals:  KES %2', PeriodMonth, Totals);
                if (post = true) then begin
                    Temp.Get(UserId);
                    Jtemplate := Temp."Delegates Pay.Journal Template";
                    JBatch := Temp."Delegates Pay. Journal Batch";



                    AccountNo := '';

                    // Tillno := Temp."Default  Bank";
                    // CmemberNo := Temp."Member No.";
                    // Excess := Temp."Excess Account";
                    // Shortage := Temp."Shortage Account";

                    if Jtemplate = '' then begin
                        Error(Text0001);
                    end;

                    if JBatch = '' then begin
                        Error(Text0002);
                    end;

                    IF I = 12 THEN
                        DocNo := 'DIV-PROVBBF' + Format(Date2dmy(DividendSetUp."Start Date", 3))
                    ELSE
                        DocNo := 'DIV-PROV' + UpperCase(Format(PeriodMonth)) + '-' + Format(Date2dmy(DividendSetUp."Start Date", 3));


                    LoanNo := '';
                    TransType := Transtype::" ";

                    SystCreated := true;

                    SaccoTransactions.InitJournal(JTemplate, JBatch);

                    DividendProvision.Reset;
                    DividendProvision.SetRange(Month, I);
                    DividendProvision.SetRange(Year, Date2dmy(DividendSetUp."Start Date", 3));
                    DividendProvision.SetRange(Posted, false);
                    if DividendProvision.FindSet() then begin
                        repeat
                            PDate := DividendProvision."Processing Date";
                            ProductFactory.get(DividendProvision."Product Type");
                            AccNo := ProductFactory."Interest Expense Account";
                            TransAmt := 0;
                            TransAmt := DividendProvision."Gross Dividends";
                            Account.get(DividendProvision."Account No");
                            Dim1 := Account."Global Dimension 1 Code";
                            Dim2 := Account."Global Dimension 2 Code";
                            BalAccNo := ProductFactory."Interest Payable Account";
                            ExtDoc := DocNo;
                            IF I = 12 THEN
                                Description := 'DIV-PROVBBF' + Format(Date2dmy(DividendSetUp."Start Date", 3)) + ' ' + "Member No."
                            ELSE
                                Description := 'DIV-PROV' + Format(PeriodMonth) + '-' + Format(Date2dmy(DividendSetUp."Start Date", 3)) + ' ' + "Member No.";

                            SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccNo, CopyStr(Description, 1, 50), Balacctype::"G/L Account",
                            BalAccNo, TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
                            SaccoTransactions.PostJournal(JTemplate, JBatch);
                            DividendProvision.Posted := true;
                            DividendProvision.modify;
                        until DividendProvision.Next() = 0;
                    end;


                    Message('TransactionS Posted succesfully');
                    exit;
                end;
            end;


            trigger OnPreDataItem()
            begin


                if PeriodMonth = PeriodMonth::January then I := 12;
                if PeriodMonth = PeriodMonth::February then I := 11;
                if PeriodMonth = PeriodMonth::March then I := 10;
                if PeriodMonth = PeriodMonth::April then I := 9;
                if PeriodMonth = PeriodMonth::May then I := 8;
                if PeriodMonth = PeriodMonth::June then I := 7;
                if PeriodMonth = PeriodMonth::July then I := 6;
                if PeriodMonth = PeriodMonth::August then I := 5;
                if PeriodMonth = PeriodMonth::September then I := 4;
                if PeriodMonth = PeriodMonth::October then I := 3;
                if PeriodMonth = PeriodMonth::November then I := 2;
                if PeriodMonth = PeriodMonth::December then I := 1;
                intProgressTotal := "Savings Accounts".Count;

                intProgressI := 0;
                TimeProgress := Time;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.Open(GeneratingDividends + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);


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
                group("Dividends")
                {
                    field("Month :"; PeriodMonth)
                    {



                    }

                    field("Post :"; Post)
                    {


                    }

                }
            }
        }

        actions
        {
        }
    }


    labels
    {
    }


    trigger OnPostReport()
    var
        DividendProcess: Codeunit "Dividend Process";
        Members: Record "Members";
    begin
        //ERROR('Contact ICT');
    end;

    trigger OnPreReport()
    var
        DividendProcess: Codeunit "Dividend Process";
        SavingsAccounts: Record "Savings Accounts";
    begin
    end;

    local procedure MonthTxtToInt(): Integer

    begin

        if PeriodMonth = PeriodMonth::January then I := 12;
        if PeriodMonth = PeriodMonth::February then I := 11;
        if PeriodMonth = PeriodMonth::March then I := 10;
        if PeriodMonth = PeriodMonth::April then I := 9;
        if PeriodMonth = PeriodMonth::May then I := 8;
        if PeriodMonth = PeriodMonth::June then I := 7;
        if PeriodMonth = PeriodMonth::July then I := 6;
        if PeriodMonth = PeriodMonth::August then I := 5;
        if PeriodMonth = PeriodMonth::September then I := 4;
        if PeriodMonth = PeriodMonth::October then I := 3;
        if PeriodMonth = PeriodMonth::November then I := 2;
        if PeriodMonth = PeriodMonth::December then I := 1;
    end;

    var
        Text001: label 'Successfully Processed.';
        DividendProcess: Codeunit "Dividend Process";
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        GeneratingDividends: label 'Generating Dividends';
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
        DividendSetUp: Record "Dividend SetUp";
        DividendProvision: Record "Dividend Provision";
        ProductFactory: Record "Product Factory";
        I: Integer;
        PeriodMonth: Option ,January,February,March,April,May,June,July,August,September,October,November,December;
        Post: Boolean;
        Totals: Decimal;
        SaccoTransactions: Codeunit "Sacco Transactions";
        Temp: Record "Banking User Template";

        Jtemplate: Code[30];
        JBatch: Code[30];
        Shortage: Code[20];
        Text0001: Label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        GenSetup: Record "General Set-Up";
        Acc: Record "Savings Accounts";
        DelegatesTariff: Record "Delegates Tariff";
        BankSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Factory";
        ProdType: Record "Product Factory";
        TransType: Enum "Transaction Types";
        Employer: Record Customer;
        AccountNo: Code[20];
        Members: Record Members;
        JournalPosting: Codeunit "Journal Posting";
        AcctNo: Code[20];
        AccNo: Code[20];
        AccType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        Descr: Text;
        TransTypes: Enum "Transaction Types";
        Loans: Record Loans;
        Interest: Decimal;
        Principle: Decimal;
        RunBal: Decimal;
        Err0001: Label 'Amount must be equal to Total pay';
        Dim1: Code[20];
        Dim2: Code[20];
        BankOfficeSetup: record "Banking No Setup";

        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";

        ExtDoc: Code[20];
        LoanNo: Code[20];

        SystCreated: Boolean;
        TransAmt: Decimal;
        Description: Text;

}
