namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186843 "Separation dues"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Separation dues.rdl';
    dataset
    {
        dataitem(HREmployeeExitInterviews; "HR Employee Exit Interviews")
        {
            column(ExitInterviewNo; "Exit Interview No")
            {
            }
            column(ReasonForLeaving; "Reason For Leaving")
            {
            }
            column(Employee_No_; "Employee No.")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Status; Status)
            {
            }
            column(DateOfInterview; "Date Of Interview")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(Amount; Amount)
            {

            }
            column(NoticeDues; HREmployeeExitInterviews."Dues Amount")
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
            dataitem("HR Employees"; "HR Employees")
            {
                DataItemLink = "No." = field("Employee No.");
                column(Monthly_Leave_Days; "Monthly Leave Days")
                {

                }
                column(Cost; Cost)
                {

                }
                trigger OnAfterGetRecord()
                var

                begin

                    HREmp.Reset;
                    if HrEmp.Get("No.") then begin
                        PRSalaryCard.reset();
                        PRSalaryCard.setrange("Employee Code", HrEmp."No.");
                        if PRSalaryCard.FindSet() then begin
                            EmpCode := HrEmp."No.";
                            intMonth := Date2DMY(today, 2);
                            Intyear := Date2DMY(today, 3);
                            cost := 0;
                            curTransAmount := 0;
                            strExtractedFrml := '';
                            if HrSetup.get() then
                                IF COPYSTR(HrSEtup.Formula, 3, 4) = 'BPAY' then
                                    Bpay := CopyStr(HrSEtup.Formula, 1, 1) + Format(PRSalaryCard."Basic Pay") + CopyStr(HrSEtup.Formula, 8, 12);
                            curTransAmount := ROUND(Payroll.fnFormulaResult(Bpay), 0.01, '<');
                            Cost := curTransAmount * HrEmp."Monthly Leave Days";
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                EmployeeTransactions.reset();
                EmployeeTransactions.SetRange("Employee Code", HREmployeeExitInterviews."Employee No.");
                EmployeeTransactions.SetRange("Transaction Code", 'BPAY');
                if EmployeeTransactions.find('+') then begin
                    Amount := EmployeeTransactions.Amount;
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
        HrSEtup: record "HR Setup";
        Payroll: codeunit "PR Payroll Processing";
        Cost: decimal;
        PRSalaryCard: Record "PR Salary Card";
        HrEmp: Record "HR Employees";
        strExtractedFrml: Text[250];
        curTransAmount: Decimal;
        EmpCode: code[20];
        intMonth: Integer;
        intYear: Integer;
        Bpay: Text[200];
        Extract: text;
        EmployeeTransactions: Record "PR Period Transactions";
        Amount: decimal;
        NoticeDues: decimal;

}
