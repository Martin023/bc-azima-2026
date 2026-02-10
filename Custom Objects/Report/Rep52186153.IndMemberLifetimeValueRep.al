namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186153 "Ind Member Lifetime Value Rep"
{
    ApplicationArea = All;
    Caption = 'Ind. Member Lifetime Value Rep';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Ind Member Lifetime Value Rep.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(Member_No_; "No.") { }
            column(Name; "Name") { }
            column(Payroll_Staff_No_; "Payroll/Staff No.") { }
            column(BOSABal; BOSABal) { }
            column(BBFBal; BBFBal) { }
            column(RiskFundBal; RiskFundBal) { }
            column(SAYEBal; SAYEBal) { }
            column(FixedDepositsBal; FixedDepositsBal) { }
            column(HolidayAccBal; HolidayAccBal) { }
            column(BOSALoansBal; BOSALoansBal) { }
            column(BussLoansBal; BussLoansBal) { }
            column(FOSALoanBal; FOSALoanBal) { }
            column(HRLoanBal; HRLoanBal) { }

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
                BOSABal := 0;
                BBFBal := 0;
                RiskFundBal := 0;
                SAYEBal := 0;
                FixedDepositsBal := 0;
                BOSALoansBal := 0;
                BussLoansBal := 0;
                FOSALoanBal := 0;
                HRLoanBal := 0;

                if "Payroll/Staff No." = ' ' then begin
                    SavingsAccounts.RESET;
                    SavingsAccounts.SETRANGE("Member No.", "No.");
                    if SavingsAccounts.Find('-') then begin
                        "Payroll/Staff No." := SavingsAccounts."Payroll/Staff No.";
                    end;
                end;
                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE("Member No.", "No.");
                SavingsAccounts.SetFilter("Product Category", '%1|%2|%3|%4|%5', SavingsAccounts."Product Category"::"BOSA Deposits",
                SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::Risk, SavingsAccounts."Product Category"::SAYE, SavingsAccounts."Product Category"::"Fixed Deposit");
                if SavingsAccounts.Find('-') then begin
                    repeat
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            BOSABal := SavingsAccounts."Balance (LCY)";
                        end
                        else
                            BOSABal := 0;
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)" then begin
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            BBFBal := SavingsAccounts."Balance (LCY)";
                        end
                        else
                            BBFBal := 0;
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::Risk then begin
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            RiskFundBal := SavingsAccounts."Balance (LCY)";
                        end
                        ELSE
                            RiskFundBal := 0;
                        IF SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"SAYE" THEN BEGIN
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            SAYEBal := SavingsAccounts."Balance (LCY)";
                        END
                        else
                            SAYEBal := 0;
                        IF SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Fixed Deposit" THEN BEGIN
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            FixedDepositsBal := SavingsAccounts."Balance (LCY)";
                        END
                        else
                            FixedDepositsBal := 0;
                    until SavingsAccounts.Next = 0;
                end;

                Loans.RESET;
                Loans.Setrange("Member No.", SavingsAccounts."Member No.");
                if Loans.Find('-') then begin
                    repeat
                        if Loans."Source Unit" = Loans."Source Unit"::"BOSA" then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            BOSALoansBal += Loans."Outstanding Balance" + Loans."Outstanding Bills";
                        end
                        else
                            BOSALoansBal := 0;
                        if Loans."Source Unit" = Loans."Source Unit"::"BUSINESS LOANS" then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            BussLoansBal += Loans."Outstanding Balance" + Loans."Outstanding Bills";
                        end
                        else
                            BussLoansBal := 0;
                        if Loans."Source Unit" = Loans."Source Unit"::"FOSA" then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            FOSALoanBal += Loans."Outstanding Balance" + Loans."Outstanding Bills";
                        end
                        else
                            FOSALoanBal := 0;
                        if Loans."Source Unit" = Loans."Source Unit"::"HR LOANS" then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            HRLoanBal += Loans."Outstanding Balance" + Loans."Outstanding Bills";
                        end
                        else
                            HRLoanBal := 0;
                    Until Loans.Next = 0;
                end;
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
        BOSABal: Decimal;
        BBFBal: Decimal;
        RiskFundBal: Decimal;
        SAYEBal: Decimal;
        FixedDepositsBal: Decimal;
        HolidayAccBal: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Loans: Record Loans;
        BOSALoansBal: Decimal;
        BussLoansBal: Decimal;
        FOSALoanBal: Decimal;
        HRLoanBal: Decimal;
        SavingsAccounts: Record "Savings Accounts";
}
