namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52185979 "ReceiptLIne Report"
{
    Caption = 'ReceiptLIne Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Cheque Allocation.rdl';
    dataset
    {
        dataitem(ReceiptLine; "Receipt Line")
        {
            RequestFilterFields = "Cheque/Deposit Slip No", No;
            column(No; No)
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(BranchCode; "Branch Code")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(Status; Status)
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(Type; "Type")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(TransactionNo; "Transaction No.")
            {
            }
            column(ChequeDepositSlipType; "Cheque/Deposit Slip Type")
            {
            }
            column(ChequeDepositSlipNo; "Cheque/Deposit Slip No")
            {
            }
            column(ChequeDepositSlipDate; "Cheque/Deposit Slip Date")
            {
            }
            column(ChequeDepositSlipBank; "Cheque/Deposit Slip Bank")
            {
            }
            column(Amount; Amount)
            {

            }
            column(Date; "Date")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Description; Description)
            {
            }
            column(Pay_Mode; "Pay Mode")
            {

            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
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
            dataitem("Receipts Header"; "Receipts Header")
            {

                DataItemLink = "No." = field(No);
                DataItemTableView = where(Posted = const(true));

                column(Posted; Posted)
                {

                }
                column(Date_Posted; "Date Posted")
                {

                }
            }
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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
