namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186392 " Loan Monthly Receipt "
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Monthly Receipt Per Category.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
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
            column(PrincipalRepayment; PrincipalRepayment)
            {

            }
            column(InterestRepayment; InterestRepayment)
            {

            }
            column(PriIntRepayment; PriIntRepayment)
            {

            }
            column(PriIntVariance; PriIntVariance)
            {

            }
            column(InterestVariance; InterestVariance)
            {

            }
            column(PrincipalVariance; PrincipalVariance)
            {

            }
            column(ExpInterest; ExpInterest)
            {

            }
            column(ExpPriInt; ExpPriInt)
            {

            }
            column(ExpPrincipal; ExpPrincipal)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                PrincipalRepayment := 0;
                InterestRepayment := 0;
                PriIntRepayment := 0;

                Loans.reset();
                Loans.setrange("Member No.", Members."No.");
                if Loans.FindFirst() then begin
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    repeat

                        Loans.SetFilter("Date Filter", '%1..%2', startDate, Enddate);

                        PrincipalRepayment += GetLoanPrincipalCredits(Loans."Loan No.");
                        InterestRepayment += GetLoanInterestCredits(Loans."Loan No.");
                        PriIntRepayment += GetLoanPICredits(Loans."Loan No.");

                        ExpPrincipal += Loans."Outstanding Balance";
                        ExpInterest += Loans."Outstanding Interest";
                        ExpPriInt += Loans.Repayment;


                    until Loans.next = 0;

                end;

                PrincipalVariance := ExpPrincipal - PrincipalRepayment;
                InterestVariance := ExpInterest - InterestRepayment;
                PriIntVariance := ExpPriInt - PriIntRepayment;

                // TotalPrincipal:=

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


    procedure GetLoanPrincipalCredits(LoanNo: code[50]): Decimal
    begin
        CreditLedgerEntry.reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.setrange("Posting Date", startDate, Enddate);
        CreditLedgerEntry.setrange(Reversed, false);
        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::Loan);
        CreditLedgerEntry.setfilter("Credit Amount (LCY)", '<>%1', 0);
        CreditLedgerEntry.CalcSums("Credit Amount (LCY)");
        exit(CreditLedgerEntry."Credit Amount (LCY)");
    end;

    procedure GetLoanInterestCredits(LoanNo: code[50]): Decimal
    begin
        CreditLedgerEntry.reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.setrange("Posting Date", startDate, Enddate);
        CreditLedgerEntry.setrange(Reversed, false);
        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
        CreditLedgerEntry.setfilter("Credit Amount (LCY)", '<>%1', 0);
        CreditLedgerEntry.CalcSums("Credit Amount (LCY)");
        exit(CreditLedgerEntry."Credit Amount (LCY)");
    end;

    procedure GetLoanPICredits(LoanNo: code[50]): Decimal
    begin
        CreditLedgerEntry.reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.setrange("Posting Date", startDate, Enddate);
        CreditLedgerEntry.setrange(Reversed, false);
        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::Armotised);
        CreditLedgerEntry.setfilter("Credit Amount (LCY)", '<>%1', 0);
        CreditLedgerEntry.CalcSums("Credit Amount (LCY)");
        exit(CreditLedgerEntry."Credit Amount (LCY)");
    end;


    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Loss: decimal;
        Watch: Decimal;
        SubStandard: decimal;
        Performing: decimal;
        SavingLedgerEntry: record "Savings Ledger Entry";
        Loans: record Loans;
        CreditLedgerEntry: record "Credit Ledger Entry";
        startDate: date;
        Enddate: date;
        PrincipalRepayment: Decimal;
        InterestRepayment: Decimal;
        PriIntRepayment: Decimal;
        PrincipalVariance: Decimal;
        InterestVariance: Decimal;
        PriIntVariance: Decimal;
        ExpPrincipal: Decimal;
        ExpInterest: Decimal;
        ExpPriInt: Decimal;
        TotalPrincipal: Decimal;
        TotalInterest: Decimal;
        TotalPriInt: Decimal;
        LoanReceivedCount: Integer;


}
