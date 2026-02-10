namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186145 "Loan Products Report"
{
    ApplicationArea = All;
    Caption = 'Loan Products Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Products Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Product Factory"; "Product Factory")
        {
            DataItemTableView = where("Product Class Type" = Const(Loan));
            RequestFilterFields = "Product ID";
            column(Product_ID; "Product ID") { }
            column(Product_Category; "Product Description") { }
            column(Product_Class_Type; "Product Class Type") { }
            column(Interest_Rate__Min__; "Interest Rate (Min.)") { }
            column(LoansCount; LoansCount) { }
            column(TotalAmountBorrowed; TotalAmountBorrowed) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(Repay_Mode; "Repay Mode") { }
            column(Interest_Rate__Max__; "Interest Rate (Max.)") { }
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
                LoansCount := 0;

                Loans.RESET;
                Loans.SETRANGE("Loan Product Type", "Product ID");
                Loans.SetRange("Posted", true);
                Loans.SetFilter("Disbursement Date", '%1..%2', StartDate, EndDate);
                if Loans.Find('-') then begin
                    LoansCount := Loans.Count;
                    TotalAmountBorrowed := TotalAmountBorrowed + Loans."Approved Amount";
                end
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
                field(StartDate; StartDate) { }
                field(EndDate; EndDate) { }
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
        OutstandingBalance: Decimal;
        ProductSetup: Record "Product Factory";
        InterestRate: Decimal;
        StartDate: Date;
        EndDate: Date;
        Loans: Record Loans;
        LoansCount: Integer;
        TotalAmountBorrowed: Decimal;

}