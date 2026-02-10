report 52186059 "Discrepancies Report "
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Discrepancies Report.rdl';
    dataset
    {
        dataitem(BankAccReconciliation; "Bank Acc. Reconciliation")
        {
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(StatementDate; "Statement Date")
            {
            }
            column(StatementNo; "Statement No.")
            {
            }
            column(BalanceLastStatement; "Balance Last Statement")
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
            dataitem("Bank Acc. Statement Line"; "Bank Acc. Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");

            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                column(total; "Bank Acc. Reconciliation Line".Difference)
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
