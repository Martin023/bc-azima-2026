namespace mns.mns;
using Microsoft.Foundation.Company;

report 52186165 "Loan Variance Report"
{
    ApplicationArea = All;
    Caption = 'Loan Variance Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Variance Report.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {

            DataItemTableView = where(Posted = const(true), "Total Balance" = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Employer Code", "Disbursement Date", "Source Unit";


            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(Repayment; Repayment)
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(EmployerCode_Loans; Loans."Employer Code")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(Repayment_Loans; Loans.Repayment)
            {
            }
            column(RecoveryMode_Loans; Loans."Recovery Mode")
            {
            }
            column(TotalBalance_Loans; Loans."Total Balance")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
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
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Variance; Variance)
            { }
            column(PaidAmount; PaidAmount)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Variance := 0;
                PaidAmount := 0;
                CreditledgerEntry.reset();
                CreditledgerEntry.SetRange(CreditledgerEntry."Loan No", Loans."Loan No.");
                CreditledgerEntry.SetFilter("Posting Date", '%1..%2', Startdate, Enddate);
                if CreditledgerEntry.Find('-') then begin
                    CreditledgerEntry.CalcSums("Amount (LCY)");
                    PaidAmount := ABS(CreditledgerEntry."Amount (LCY)");
                end else
                    PaidAmount := 0;
                Variance := PaidAmount - Loans.Repayment;

            end;

            trigger OnPreDataItem()
            begin

                if startDate = 0D then
                    startDate := 19900101D;

                if Enddate = 0D then
                    Enddate := Today;


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
        CreditledgerEntry: record "Credit Ledger Entry";
        PaidAmount: decimal;
        Startdate: date;
        Enddate: date;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInformation: record "Company Information";
        Variance: decimal;

}
