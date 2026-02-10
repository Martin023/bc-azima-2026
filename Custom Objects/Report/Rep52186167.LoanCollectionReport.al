namespace mns.mns;
using Microsoft.Foundation.Company;

report 52186167 "Loan Collection Report"
{
    ApplicationArea = All;
    Caption = 'Loan Collection Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Collection.rdl';
    dataset
    {

        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = filter(true));
            RequestFilterFields = "Source Unit", "Loan Product Type", "Global Dimension 2 Code";
            column(ApprovedAmount_Loans; "Approved Amount")
            {
            }
            column(DisbursementDate_Loans; "Disbursement Date")
            {
            }
            column(OutstandingBalance_Loans; "Outstanding Balance")
            {
            }
            column(MemberNo_Loans; "Member No.")
            {
            }
            column(MemberName_Loans; "Member Name")
            {
            }
            column(OutstandingInterest_Loans; "Outstanding Interest")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
            {

            }
            column(Amount_In_Arreas_SACCO; "Amount In Arreas SACCO")
            {

            }
            column(Total_Loan_Balance; "Total Loan Balance")
            {

            }
            column(Relation_Officer; "Relation Officer")
            {

            }
            column(AmountPaid; AmountPaid)
            {

            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Loan_Product_Type; Loans."Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
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
            column(FosaBalance; FosaBalance)
            {

            }
            column(BosaAccount; BusinessLoanAccountBalance)
            {

            }
            column(BosaDeposits; BusinessDepositsBalance)
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                AmountPaid := 0;
                FosaBalance := 0;
                BusinessDepositsBalance := 0;
                BusinessLoanAccountBalance := 0;
                CreditLedgerEntries.Reset();
                CreditLedgerEntries.SetRange("Loan No", Loans."Loan No.");
                CreditLedgerEntries.SetFilter("Posting Date", '%1..%2', Startdate, Enddate);
                CreditLedgerEntries.CalcSums("Credit Amount (LCY)");
                AmountPaid := CreditLedgerEntries."Credit Amount (LCY)";
                Savings.reset();
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetFilter("Product Type", '%1|%2|%3', '002', '011', '080');
                Savings.SetLoadFields("Balance (LCY)");
                if Savings.FindSet() then begin
                    repeat
                        Savings.CalcFields("Balance (LCY)");
                        if Savings."Product Type" = '002' then
                            FosaBalance := Savings."Balance (LCY)";
                        if Savings."Product Type" = '011' then
                            BusinessLoanAccountBalance := Savings."Balance (LCY)";
                        if Savings."Product Type" = '080' then
                            BusinessDepositsBalance := Savings."Balance (LCY)";
                    until Savings.next = 0;
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
                group("Date Filter")
                {
                    field(startDate; startDate)
                    {

                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(Enddate; Enddate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
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
        CreditLedgerEntries: record "Credit Ledger Entry";
        AmountPaid: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        FosaBalance: decimal;
        Savings: Record "Savings Accounts";
        Startdate: date;
        Enddate: date;
        BusinessLoanAccountBalance: decimal;
        BusinessDepositsBalance: decimal;

}
