#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 52185510 "Tellers Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/TellersJournal.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Tellers Journal';
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = sorting("Bank Account No.", "Posting Date");
            RequestFilterFields = "Posting Date", "Bank Account No.";

            column(Bank_Account_No_; "Bank Account No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_No_; "Document No.") { }
            column(Description; ReportDescription) { }
            column(Debit_Amount; ReportDebitAmt) { }
            column(Credit_Amount; ReportCreditAmt) { }
            column(RunningBalance; CustomerRunningbalalnce.CustomBankAccRunnBal("Bank Account Ledger Entry")) { }

            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }
            column(ReportTitle; 'Tellers Journal') { }

            column(AccountName; AccountName) { }
            column(AccountNo; AccountNo) { }
            column(TransType; TransType) { }
            column(BankBalance; BankBalance) { }
            column(OpenBal; OpenBal) { }

            trigger OnAfterGetRecord()
            begin
                if not BankAcc.Get("Bank Account Ledger Entry"."Bank Account No.") then
                    CurrReport.Skip();

                if BankAcc."Bank Type" <> BankAcc."Bank Type"::Cashier then
                    CurrReport.Skip();

                if LastBankAccNo <> "Bank Account Ledger Entry"."Bank Account No." then begin
                    OpenBal := 0;
                    if "Bank Account Ledger Entry".GetFilter("Posting Date") <> '' then begin
                        BankLedgerEntryII.Reset();
                        BankLedgerEntryII.SetRange("Bank Account No.", "Bank Account Ledger Entry"."Bank Account No.");
                        BankLedgerEntryII.SetFilter("Posting Date", '<%1', "Bank Account Ledger Entry".GetRangeMin("Posting Date"));
                        
                        BankLedgerEntryII.CalcSums("Amount (LCY)");
                        OpenBal := BankLedgerEntryII."Amount (LCY)";
                    end else begin
                        OpenBal := 0;
                    end;
                    
                    LastBankAccNo := "Bank Account Ledger Entry"."Bank Account No.";
                end;

                CashierTrans.Reset();
                CashierTrans.SetRange(No, "Bank Account Ledger Entry"."Document No.");
                if CashierTrans.FindFirst() then begin
                    AccountNo := CashierTrans."Account No";
                    AccountName := CashierTrans."Account Name";
                    TransType := CashierTrans.Type;
                end else begin
                    AccountNo := '';
                    AccountName := '';
                end;

                ReportDescription := "Bank Account Ledger Entry".Description;
                ReportDebitAmt := "Bank Account Ledger Entry"."Debit Amount";
                ReportCreditAmt := "Bank Account Ledger Entry"."Credit Amount";

                if ReportCreditAmt < 0 then begin
                    ReportDebitAmt := Abs(ReportCreditAmt);
                    ReportCreditAmt := 0;
                    if StrPos(ReportDescription, 'Reversed - ') = 0 then
                        ReportDescription := 'Reversed - ' + ReportDescription;
                end else if ReportDebitAmt < 0 then begin
                    ReportCreditAmt := Abs(ReportDebitAmt);
                    ReportDebitAmt := 0;
                    if StrPos(ReportDescription, 'Reversed - ') = 0 then
                        ReportDescription := 'Reversed - ' + ReportDescription;
                end else if "Bank Account Ledger Entry".Reversed then begin
                    if StrPos(ReportDescription, 'Reversed - ') = 0 then
                        ReportDescription := 'Reversed - ' + ReportDescription;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }

        trigger OnOpenPage()
        begin
            if "Bank Account Ledger Entry".GetFilter("Bank Account No.") = '' then begin
                if BankingSetup.Get(UserId) then begin
                    if BankingSetup.Type = BankingSetup.Type::Cashier then
                        "Bank Account Ledger Entry".SetRange("Bank Account No.", BankingSetup."Default  Bank");
                end;
            end;
        end;
    }

    trigger OnPreReport()
    begin
        OpenBal := 0;
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        BankAcc: Record "Bank Account";
        BankAccRec: Record "Bank Account";
        CashierTrans: Record "Cashier Transactions";
        BankingSetup: Record "Banking User Template";
        AccountNo: Code[100];
        AccountName: Text[100];
        TransType: Enum "Fosa Transaction Types";
        CustomerRunningbalalnce: Codeunit "Customer Running balalnce";
        BankBalance: Decimal;
        OpenBal: Decimal;
        LastBankAccNo: Code[20];
        BankLedgerEntryII: Record "Bank Account Ledger Entry";
        ReportDebitAmt: Decimal;
        ReportCreditAmt: Decimal;
        ReportDescription: Text[150];
}