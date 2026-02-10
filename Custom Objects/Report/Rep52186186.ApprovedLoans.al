namespace mns.mns;
using Microsoft.Foundation.Company;

report 52186186 "Approved  Loans"
{
    ApplicationArea = All;
    Caption = 'Loan Appraised By';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Approved Loans.rdl';
    dataset
    {

        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = filter(true));
            RequestFilterFields = "Source Unit", "Loan Product Type", "Global Dimension 2 Code";

            column(LoanNo; "Loan No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
            {

            }
            column(Approved_Amount; "Approved Amount")
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
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Loan_Appraised_By; "Loan Appraised By")
            {

            }
        }
    }
    requestpage
    {
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

    var
        CreditLedgerEntries: record "Credit Ledger Entry";
        AmountPaid: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

}
