namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186147 "Savings Products Report"
{
    ApplicationArea = All;
    Caption = 'Savings Products Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Savings Products Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("SAYE" | "Fixed Deposit" | "Junior Account"));
            column(No_; "No.") { }
            column(Name; "Name") { }
            //column(Balance; "Balance (LCY)") { }
            column(Product_Category; "Product Category") { }
            column(SAYE; SAYE) { }
            column(FixedDeposit; FixedDeposit) { }
            column(JuniorAccount; JuniorAccount) { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Interest_Earned; "Interest Earned") { }
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
            column(FD_Duration; "FD Duration") { }
            column(Balance__LCY_; "Balance (LCY)") { }

            trigger OnAfterGetRecord()
            begin

                InterestRate := 0;

                ProductSetup.Reset();
                ProductSetup.SetRange("Product ID", "Product Type");
                if ProductSetup.FindFirst() then begin
                    InterestRate := ProductSetup."Interest Rate (Min.)";
                end;

                SavingsAccounts.CalcFields(Balance, "Balance (LCY)");
                if "Product Category" = SavingsAccounts."Product Category"::"SAYE" then begin
                    SAYE := SavingsAccounts."Balance (LCY)";
                end;
                if "Product Category" = SavingsAccounts."Product Category"::"Fixed Deposit" then begin
                    FixedDeposit := SavingsAccounts."Balance (LCY)";
                end;
                if "Product Category" = SavingsAccounts."Product Category"::"Junior Account" then begin
                    JuniorAccount := SavingsAccounts."Balance (LCY)";
                end;

            end;


        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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
        CompanyInformation: Record "Company Information";
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SAYE: Decimal;
        FixedDeposit: Decimal;
        JuniorAccount: Decimal;

        ProductSetup: Record "Product Factory";
        InterestRate: Integer;
}
