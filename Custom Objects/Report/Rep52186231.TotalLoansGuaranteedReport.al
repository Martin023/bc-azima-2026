namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Foundation.Company;

report 52186231 "Total Loans Guaranteed Report"
{
    ApplicationArea = All;
    Caption = 'Total Loans Guaranteed Report';
    UsageCategory = Lists;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Total Loans Guaranteed Report.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Subflag = filter(<> Deceased & <> Withdrawal));

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
            column(No; "No.")
            {
            }
            column(Name; Name) { }
            column(EmployerCode; "Employer Code")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(BOSA_Deposit; "BOSA Deposit") { }
            column(GuarantorLoanBal; GuarantorLoanBal) { }
            column(LoanTypes; LoanTypes) { }
            column(NoOfLoans; NoOfLoans) { }
            column(TotalGuaranteed; TotalGuaranteed) { }

            trigger OnAfterGetRecord()
            begin
                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                BosaBal := 0;
                GuarantorLoanBal := 0;
                LoanTypes := '';
                NoOfLoans := 0;
                TotalGuaranteed := 0;
                Members.CalcFields("BOSA Deposit");

                LoanGuar.Reset();
                LoanGuar.SetRange("Member No", members."No.");
                LoanGuar.CalcFields("Outstanding Balance");
                LoanGuar.SetFilter("Outstanding Balance", '>0');
                LoanGuar.SetRange(Substituted, false);
                if LoanGuar.FindSet() then begin
                    repeat
                        if Loans.get(LoanGuar."Loan No") then begin
                            Loans.CalcFields("Outstanding Balance");
                            if Loans."Outstanding Balance" > 0 then begin
                                GuarantorLoanBal += Loans."Outstanding Balance";
                                NoOfLoans += 1;
                                if LoanTypes = '' then
                                    LoanTypes += Loans."Loan Product Type"
                                else
                                    LoanTypes += ', ' + Loans."Loan Product Type";
                                TotalGuaranteed += LoanGuar."Amount Guaranteed";
                            end;
                        end;
                    until LoanGuar.Next() = 0;
                end;
                if NoOfLoans = 0 then CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Loans: record Loans;
        SavingsAcc: record "Savings Accounts";
        GuarantorLoanBal: decimal;
        NoOfLoans: integer;
        LoanTypes: text;
        TotalGuaranteed: Decimal;
        BosaBal: decimal;
        LoanGuar: record "Loan Guarantors and Security";
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Generating Lines';
        diaProgress: Dialog;
        intProgress: Integer;

}
