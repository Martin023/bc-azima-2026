namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186129 "Amounts Receiv Summary - Loans"
{
    ApplicationArea = All;
    Caption = 'Amounts Receiv Summary - Loans';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Amounts Receiv Summary - Loans.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Employer Code", "Loan Product Type", "Loan Product Type Name";
            DataItemTableView = WHERE(Posted = const(True));
            column(LoanNo; "Loan No.")
            {
            }
            column(Loan_Product_Type; "Loan Product Type") { }
            column(Loan_Product_Type_Name; "Loan Product Type Name") { }
            column(Source_Unit; "Source Unit") { }
            column(Employer_Code; "Employer Code") { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
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
                AmountReceived := 0;

                CreditLedgerEntries.Reset();
                CreditLedgerEntries.SetRange("Member No.", Loans."Member No.");
                CreditLedgerEntries.SetRange("Loan No", Loans."Loan No.");
                CreditLedgerEntries.SetRange("Reversed", FALSE);
                CreditLedgerEntries.SetCurrentKey("Posting Date");
                CreditLedgerEntries.SetRange("Posting Date", StartDate, EndDate);
                if CreditLedgerEntries.find('-') then begin
                    CreditLedgerEntries.CalcSums("Amount (LCY)");
                    AmountReceived := CreditLedgerEntries."Amount (LCY)" * -1;
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

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CreditLedgerEntries: Record "Credit Ledger Entry";
        AmountReceived: Decimal;
        StartDate: Date;
        EndDate: Date;
}
