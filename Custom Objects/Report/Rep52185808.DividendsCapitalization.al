namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185808 "Dividends Capitalization"
{
    ApplicationArea = All;
    Caption = 'Dividends Capitalization';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Dividends Capitalization.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DividendInstructionsMember; "Dividend Instructions - Member")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Savings));
            column(AccountNo; "Account No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Priority; Priority)
            {
            }
            column(ProductType; "Product Type")
            {
            }
            column(RecoveryType; "Recovery Type")
            {
            }
            column(RecurrentOverYears; "Recurrent Over Years")
            {
            }
            column(SentOnline; "Sent Online")
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(ProductName; ProductName)
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
            column(BonusIncentivePercentage; BonusIncentivePercentage)
            {

            }
            column(BonusIncentiveAmount; BonusIncentiveAmount)
            {

            }

            trigger OnAfterGetRecord()
            begin
                MemberName := '';
                ProductName := ProductName::" ";

                Members.Reset;
                Members.SetRange("No.", "Member No.");
                if Members.Find('-') then
                    MemberName := Members.Name;

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("No.", "Account No.");
                if SavingsAccounts.Find('-') then
                    ProductName := SavingsAccounts."Product Category";
                if ProductFactory.get(SavingsAccounts."Product Type") then begin
                    TransactionTypes.reset();
                    TransactionTypes.setrange("Product Type", ProductFactory."Product ID");
                    TransactionTypes.SetRange(Code, ProductFactory."Dividends Incentives");
                    if TransactionTypes.Find('-') then begin

                        TransactionCharges.reset();
                        TransactionCharges.setrange("Transaction Type", TransactionTypes.code);
                        If TransactionCharges.find('-') then begin
                            if TransactionTypes."Product Type" = '1' then begin
                                BonusIncentivePercentage := TransactionCharges."Percentage of Amount";
                                BonusIncentiveAmount := (BonusIncentivePercentage * Amount) / 100;
                            end else
                                if TransactionTypes."Product Type" = '2' then begin
                                    BonusIncentivePercentage := TransactionCharges."Percentage of Amount";
                                    BonusIncentiveAmount := (BonusIncentivePercentage * Amount) / 100;
                                end;

                        end;
                    end;
                end;
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    Var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        PayrollNo: Code[20];
        MemberName: Text;
        SavingsAccounts: Record "Savings Accounts";
        ProductName: Enum "Product Categories";
        BonusIncentivePercentage: decimal;
        BonusIncentiveAmount: decimal;
        ProductFactory: record "Product Factory";
        TransactionTypes: record "Transaction Types";
        TransactionCharges: record "Transaction Charges";

}
