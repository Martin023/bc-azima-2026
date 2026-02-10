namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186127 "Amounts Received - Deposit A/c"
{
    ApplicationArea = All;
    Caption = 'Amounts Received - Deposit A/c';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Amounts Received - Deposit Ac.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            Calcfields = "Balance (LCY)";
            RequestFilterFields = "Member No.", "Employer Code", "Product Category";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Balance__LCY_; "Balance (LCY)")
            {
            }
            column(Product_Category; "Product Category")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(AmountReceived; AmountReceived)
            {
            }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(EmployerName; EmployerName) { }
            column(PrimaryIDNo; PrimaryIDNo) { }
            column(MemberStatus; MemberStatus) { }

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
                PayrollStaffNo := '';
                EmployerCode := '';
                EmployerName := '';
                PrimaryIDNo := '';

                SavingsLedgerEntry.Reset();
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccounts."No.");
                SavingsLedgerEntry.SetRange("Reversed", FALSE);
                SavingsLedgerEntry.SetCurrentKey("Posting Date");
                SavingsLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                SavingsLedgerEntry.SetLoadFields("Amount (LCY)");
                if SavingsLedgerEntry.Find('-') then begin
                    SavingsLedgerEntry.CalcSums("Amount (LCY)");
                    AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                end;

                Members.RESET;
                Members.Setrange("No.", SavingsAccounts."Member No.");
                Members.SetLoadFields("Payroll/Staff No.", "Employer Code", "Employer Name", "Primary Identification", Status);
                if Members.Find('-') then begin
                    PayrollStaffNo := Members."Payroll/Staff No.";
                    EmployerCode := Members."Employer Code";
                    EmployerName := Members."Employer Name";
                    PrimaryIDNo := Members."Primary Identification";
                    MemberStatus := FORMAT(Members.Status);
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
        if StartDate = 0D then Error('Start Date must be entered');
        IF EndDate = 0D THEN Error('End Date must be entered');
        if StartDate > EndDate then Error('Start Date must be less than or equal to End Date');

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
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        AmountReceived: Decimal;
        Members: Record "Members";
        PayrollStaffNo: Code[50];
        EmployerCode: Code[50];
        EmployerName: Text;
        PrimaryIDNo: Code[50];
        MemberStatus: Text[50];
}

