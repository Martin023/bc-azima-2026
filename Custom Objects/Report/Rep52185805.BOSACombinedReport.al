namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185805 "BOSA Combined Report"
{
    ApplicationArea = All;
    Caption = 'BOSA Combined Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/BOSA Combined Report.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Payroll/Staff No.";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(CreatedBy; CreatedBy)
            {

            }

            column(No_; "No.")
            {
            }
            column(PayrollNo; PayrollNo)
            {
            }
            column(Name; Name)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {

            }
            column(TotalBosaLoans; TotalBosaLoans)
            {

            }
            column(variance; variance)
            {

            }

            trigger OnAfterGetRecord()
            begin
                TotalBosaLoans := 0;
                TotalDeposits := 0;
                variance := 0;
                PayrollNo := '';

                Loans.Reset();
                Loans.SetRange("Member No.", "No.");
                Loans.SetFilter("Outstanding Balance", '>0');
                Loans.SetRange("Source Unit", Loans."Source Unit"::BOSA);
                Loans.SetLoadFields("Loan No.");
                if Loans.Findset() then begin
                    repeat
                        RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
                        TotalBosaLoans += TotalBal;
                    until Loans.Next() = 0;
                end;
                if TotalBosaLoans <= 0 then
                    CurrReport.Skip();

                //deposits balance
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", "No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                SavingsAccounts.SetLoadFields(Balance);
                SavingsAccounts.SetAutoCalcFields(Balance);
                if SavingsAccounts.FindFirst() then begin
                    TotalDeposits := SavingsAccounts.Balance;
                end;

                variance := TotalBosaLoans - TotalDeposits;

                PayrollNo := "Payroll/Staff No.";
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
        CompanyInformation.Get;
        //    CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);

    end;


    Var
        //Columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        CreatedBy: Text;
        TotalDeposits: Decimal;
        TotalBosaLoans: Decimal;

        PayrollNo: Code[20];
        productVariations: Record "Product Variations";
        variance: Decimal;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        LoansProcess: Codeunit "Loans Process";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;

        //Task Progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

}
