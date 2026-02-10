report 52186840 AllTransactions
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Transactions Report.rdl';
    dataset
    {



        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Transaction Code";
            DataItemTableView = where("Group Order" = filter(8));

            column(Transaction_Code; "Transaction Code")
            {

            }
            column(Transaction_Name; "Transaction Name")
            {

            }
            column(Transaction_Type; "Transaction Type")
            {

            }
            column(Employee_Code; "Employee Code")
            {

            }
            column(EmployeeName; EmployeeName)
            {

            }
            column(Amount; Amount)
            {

            }
            column(Balance; Balance)
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
            column(PeriodFilter; PeriodFilter)
            {

            }
            column(Group_Order; "Group Order")
            {

            }
            column(Sub_Group_Order; "Sub Group Order")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "PR Period Transactions".reset;
                "PR Period Transactions".setrange("Payroll Period", PeriodFilter);

                HrEmp.reset();
                HrEmp.setrange("No.", "PR Period Transactions"."Employee Code");
                if HrEmp.Find('-') then begin
                    EmployeeName := HrEmp.FullName;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin


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
                field(PeriodFilter; PeriodFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Filter';
                    TableRelation = "PR Payroll Periods";
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
        if PeriodFilter = 0D then Error('Please specify period filter');

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
        PeriodFilter: Date;
        HrEmp: record "HR Employees";
        EmployeeName: text[100];

}
