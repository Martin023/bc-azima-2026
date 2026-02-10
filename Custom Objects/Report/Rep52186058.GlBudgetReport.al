report 52186058 "G/l Budget Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/GL Budget Report.rdl';
    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            column(Balance; Balance)
            {
            }
            column(BalanceatDate; "Balance at Date")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(BudgetControlAccount; "Budget Control Account")
            {
            }
            column(BudgetControlled; "Budget Controlled")
            {
            }
            column(BudgetReporting; "Budget Reporting")
            {
            }
            column(BudgetatDate; "Budget at Date")
            {
            }
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(BudgetedAmount; "Budgeted Amount")
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
            column(Variance; Variance)
            {

            }
            trigger OnAfterGetRecord()
            begin
                Variance := GLAccount."Budgeted Amount" - GLAccount."Balance at Date";
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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Variance: decimal;
}
