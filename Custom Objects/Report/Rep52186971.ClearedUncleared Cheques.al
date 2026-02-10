namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186971 "ClearedUncleared Cheques"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Uncleared Cheques.rdl';
    dataset
    {
        dataitem(CashierTransactions; "Cashier Transactions")
        {
            DataItemTableView = where("Cheque Status" = Filter(<> Cleared));
            column(No; No)
            {
            }
            column(AccountNo; "Account No")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(ChequeNo; "Cheque No")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(ExpectedMaturityDate; "Expected Maturity Date")
            {
            }
            column(DateBanked; "Date Banked")
            {
            }
            column(DateCleared; "Date Cleared")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Date; "Transaction Date")
            {
            }
            column(MemberNo; MemberNo)
            {

            }
            column(CustomerNo; CustomerNo)
            {

            }
            column(description; CashierTransactions."Transaction Description")
            {

            }
            column(chequestatus; CashierTransactions."Cheque Status")
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
            Var
                Savings: Record "Savings Accounts";
            begin
                Savings.reset();
                Savings.setrange("No.", CashierTransactions."Account No");
                If Savings.findfirst then begin
                    MemberNo := Savings."Member No.";
                    CustomerNo := Savings."Employer Code";
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MemberNo: code[40];
        CustomerNo: code[40];
}
