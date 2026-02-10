namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186146 "Deposits Accumulated Over Time"
{
    ApplicationArea = All;
    Caption = 'Deposits Accumulated Over Time';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Deposits Accumulated Over Time.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            column(No_; "No.") { }
            column(Name; "Name") { }
            column(ShareCapital; ShareCapital) { }
            column(BOSADeposits; BOSADeposits) { }
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
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                SavingsAccounts.RESET;
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetFilter("Product Category", '%1|%2', SavingsAccounts."Product Category"::"BOSA Deposits", SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                        BOSADeposits := SavingsAccounts."Balance (LCY)";
                    end;
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Share Capital" then begin
                        ShareCapital := SavingsAccounts."Balance (LCY)";
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
        SavingsAccounts: Record "Savings Accounts";
        ShareCapital: Decimal;
        BOSADeposits: Decimal;
}
