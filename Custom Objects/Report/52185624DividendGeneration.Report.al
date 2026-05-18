#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185624 "Dividend Generation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            //DataItemTableView = WHERE("Product Type" = FILTER('|SCS'));
            RequestFilterFields = "Member No.", "Employer Code", "Product Type";
            trigger OnAfterGetRecord()
            begin
                DividendSetUp.Get();
                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression.Year, Date2DMY(DividendSetUp."End Date", 3));
                DividendProgression.SetRange("Account No", "Savings Accounts"."No.");
                DividendProgression.DeleteAll(true);

                if ProductFactory.Get("Savings Accounts"."Product Type") then begin
                    if ProductFactory."Dividend Calc. Method" <> ProductFactory."dividend calc. method"::" " then begin
                        intProgressI += 1;
                        if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                            NoOfProgressed := NoOfProgressed + intProgressI;
                            diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                            intProgressI := 0;
                            TimeProgress := Time;
                        end;
                        DividendProcess.generateDivdends("Savings Accounts");
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.Close;
                Message('Transaction generated succesfully');
            end;

            trigger OnPreDataItem()
            begin
                //"Savings Accounts".SetFilter("Product Type", 'DCS|SCS');
                intProgressTotal := "Savings Accounts".Count;
                intProgressI := 0;
                TimeProgress := Time;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.Open(GeneratingDividends + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

                // if Codeunit.Run(Codeunit::"Dividends Job Queue Manager", "Savings Accounts") then begin
                //     Message('Dividend generation process initiated successfully. It will run in the background');
                // end;
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

            }
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
        DividendProgression: Record "Dividend Progression";
        ProductFactory: Record "Product Factory";
        post: boolean;
        DividendPostingBuffer: record "Dividend Posting Buffer";
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
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";

        ExtDoc: Code[20];
        LoanNo: Code[20];

        SystCreated: Boolean;
        TransAmt: Decimal;
        Description: Text;
        SaccoTransactions: codeunit "Sacco Transactions";
}
