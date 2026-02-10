#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186169 "Cashier Deposits Withdrawals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Cashier Deposits Withdrawals Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Bank Account No.";
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(RunningBalance; CustomerRunningbalalnce.CustomBankAccRunnBal("Bank Account Ledger Entry"))
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(AccountName; AccountName)
            {

            }
            column(AccountNo; AccountNo)
            {

            }
            column(TransType; TransType)
            {

            }
            column(BankBalance; BankBalance)
            {

            }
            column(OpenBal; OpenBal)
            {

            }

            trigger OnAfterGetRecord()
            begin
                Recount += 1;
                if Recount = 1 then begin
                    if "Bank Account Ledger Entry".GetFilters <> '' then begin
                        if "Bank Account Ledger Entry".GetFilters.Contains('Bank Account No.') then begin
                            if BankAcc.Get("Bank Account Ledger Entry"."Bank Account No.") then begin
                                BankLedgerEntryII.reset;
                                BankLedgerEntryII.SetRange("Bank Account No.", BankAcc."No.");
                                BankLedgerEntryII.Setfilter("Posting Date", '<%1', "Bank Account Ledger Entry"."Posting Date");
                                if BankLedgerEntryII.FindFirst() then begin
                                    BankLedgerEntryII.Calcsums("Amount (LCY)");
                                    OpenBal := BankLedgerEntryII."Amount (LCY)";
                                end
                                else
                                    OpenBal := 0;

                            end;
                        end
                        else
                            Error('Kindly filter with Teller / treasury Account');
                    end
                    else
                        Message('Kindly filter with Teller / treasury Account');
                end;

                CashierTrans.Reset();
                CashierTrans.SetRange(No, "Bank Account Ledger Entry"."Document No.");
                if CashierTrans.FindFirst() then begin
                    AccountNo := CashierTrans."Account No";
                    AccountName := CashierTrans."Account Name";
                    TransType := CashierTrans.Type;
                end
                else begin
                    AccountNo := '';
                    AccountName := '';
                    // TransType:= CashierTrans.Type::" ";
                end;


            end;

            trigger OnPreDataItem()
            begin

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
        OpenBal := 0;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        Recount := 0;
    end;

    trigger OnPostReport()
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        // CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        BankAcc: Record "Bank Account";
        CashierTrans: Record "Cashier Transactions";
        AccountNo: Code[100];
        AccountName: Text[100];
        TransType: Enum "Fosa Transaction Types";
        CustomerRunningbalalnce: Codeunit "Customer Running balalnce";
        BankBalance: Decimal;
        OpenBal: Decimal;
        Recount: Integer;
        BankLedgerEntryII: Record "Bank Account Ledger Entry";

}
