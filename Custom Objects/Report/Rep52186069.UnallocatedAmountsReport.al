namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186069 "Unallocated Amounts Report"
{
    ApplicationArea = All;
    Caption = 'Unallocated Amounts Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Unallocated Amounts Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CheckoffLines; "Checkoff Lines")
        {
            DataItemTableView = where(Posted = const(true), "Refundable Amount" = filter(> 0));
            //Unallocated amounts report (Posting date, loan number, member number, loan type, amount, account in arrears).
            column(AccountNo; "Account No.")
            {
            }//MemberAccountNo
            column(Amount; Amount)
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Loan_No_; "Loan No.")
            {
            }
            column(LoanType; LoanType) { }
            COLUMN(PostingDate; PostingDate) { }
            column(RefundableAmount; "Refundable Amount")
            {
            }
            column(UnallocatedAmount; UnallocatedAmount) { }
            column(UnallocatedAccNo; UnallocatedAccNo) { }
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
                Loans.RESET;
                Loans.SetRange(Loans."Loan No.", CheckoffLines."Loan No.");
                if Loans.FindFirst() then begin
                    LoanType := Loans."Loan Product Type";
                end;


                CreditLedgerEntries.RESET;
                CreditLedgerEntries.SetRange(CreditLedgerEntries."Loan No", CheckoffLines."Loan No.");
                CreditLedgerEntries.SetRange(Reversed, false);
                if CreditLedgerEntries.Find('-') then begin
                    PostingDate := CreditLedgerEntries."Posting Date";
                end;

                SavingsAccounts.RESET;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", CheckoffLines."Member No.");
                SavingsAccounts.SetRange(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Unallocated Fund");
                //SavingsAccounts.SetRange(SavingsAccounts."No.", CheckoffLines."Account No.");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    UnallocatedAmount := SavingsAccounts."Balance (LCY)";
                    UnallocatedAccNo := SavingsAccounts."No.";
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
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
        Loans: Record "Loans";
        LoanType: Text[100];
        CreditLedgerEntries: Record "Credit Ledger Entry";
        PostingDate: Date;
        SavingsAccounts: Record "Savings Accounts";
        UnallocatedAmount: Decimal;
        UnallocatedAccNo: Code[150];
}
