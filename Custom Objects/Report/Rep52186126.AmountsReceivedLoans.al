namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186126 "Amounts Received - Loans"
{
    ApplicationArea = All;
    Caption = 'Amounts Received - Loans';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Amounts Received - Loans.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Employer Code", "Loan Product Type", "Loan Product Type Name";
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(PayrollNo; PayrollNo) { }
            column(EmployerCode; EmployerCode) { }
            column(EmployerName; EmployerName) { }
            column(PrimaryIDNo; PrimaryIDNo) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(AmountReceived; AmountReceived)
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
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                AmountReceived := 0;
                PayrollNo := '';
                EmployerCode := '';
                EmployerName := '';
                PrimaryIDNo := '';

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

                Members.RESET;
                Members.Setrange("No.", Loans."Member No.");
                if Members.Find('-') then begin
                    PayrollNo := Members."Payroll/Staff No.";
                    EmployerCode := Members."Employer Code";
                    EmployerName := Members."Employer Name";
                    PrimaryIDNo := Members."Primary Identification";
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
                    field(StartDate; StartDate) { }
                    field(EndDate; EndDate) { }
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
        Members: Record "Members";
        PayrollNo: Code[50];
        EmployerCode: CODE[50];
        EmployerName: Text;
        PrimaryIDNo: Text;
}
