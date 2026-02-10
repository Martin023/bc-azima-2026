namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186144 "Member Lifetime Value"
{
    ApplicationArea = All;
    Caption = 'Member Lifetime Value';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Lifetime Value.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(MemberNo; "No.") { }
            column(MemberName; Name) { }
            column(BOSADeposits; BOSADeposits) { }
            column(SharesBal; SharesBal) { }
            column(OutstandingBalance; OutstandingBalance) { }
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
                BOSADeposits := 0;
                SharesBal := 0;
                OutstandingBalance := 0;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", Members."No.");
                SavingsAccount.SetFilter("Product Category", '%1|%2', SavingsAccount."Product Category"::"BOSA Deposits", SavingsAccount."Product Category"::"Share Capital");
                if SavingsAccount.Find('-') then begin
                    if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"BOSA Deposits" then
                        SavingsAccount.CalcFields("Balance (LCY)");
                    BOSADeposits := SavingsAccount."Balance (LCY)";
                    if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then
                        SavingsAccount.CalcFields("Balance (LCY)");
                    SharesBal := SavingsAccount."Balance (LCY)";
                end;

                Loans.RESET;
                Loans.SETRANGE("Member No.", Members."No.");
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                        OutstandingBalance := OutstandingBalance + Loans."Outstanding Balance" + Loans."Outstanding Interest";
                    until Loans.Next = 0;
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
        SavingsAccount: Record "Savings Accounts";
        BOSADeposits: Decimal;
        SharesBal: Decimal;
        Loans: Record Loans;
        OutstandingBalance: Decimal;
}
