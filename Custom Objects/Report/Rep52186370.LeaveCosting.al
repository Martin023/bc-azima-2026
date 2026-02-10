report 52186370 "Leave Costing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Leave Costing.rdl';
    dataset
    {
        dataitem(Hremployees; "Hr employees")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            Column(Monthly_Leave_Days; "Monthly Leave Days")
            {

            }
            column(Reimbursed_Leave_Days; "Reimbursed Leave Days")
            {

            }
            column("LeaveCost"; Cost)
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
            dataitem("PR Salary Card"; "PR Salary Card")
            {
                DataItemLink = "Employee Code" = field("No.");
                column(Basic_Pay; "Basic Pay")
                {

                }

            }
            trigger OnAfterGetRecord()
            var
                PRSalaryCard: Record "PR Salary Card";
                HrEmp: Record "HR Employees";
                strExtractedFrml: Text[250];
                curTransAmount: Decimal;
                EmpCode: code[20];
                intMonth: Integer;
                intYear: Integer;
                Bpay: Text[200];
                Extract: text;

            begin
                cost := 0;
                curTransAmount := 0;
                HREmp.Reset;
                if HrEmp.Get("No.") then begin
                    HrEmp.CalcFields("Reimbursed Leave Days");
                    PRSalaryCard.reset();
                    PRSalaryCard.setrange("Employee Code", HrEmp."No.");
                    if PRSalaryCard.FindSet() then begin
                        EmpCode := HrEmp."No.";
                        intMonth := Date2DMY(today, 2);
                        Intyear := Date2DMY(today, 3);
                        curTransAmount := 0;
                        strExtractedFrml := '';
                        if HrSetup.get() then
                            IF COPYSTR(HrSEtup.Formula, 3, 4) = 'BPAY' then
                                Bpay := CopyStr(HrSEtup.Formula, 1, 1) + Format(PRSalaryCard."Basic Pay") + CopyStr(HrSEtup.Formula, 8, 12);
                        curTransAmount := ROUND(Payroll.fnFormulaResult(Bpay), 1, '<');
                        Cost := Round((curTransAmount * (HrEmp."Monthly Leave Days" + HrEmp."Reimbursed Leave Days")), 0.01, '<');
                    end;
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
                group(Period)
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
        Formula: decimal;
        Month: Integer;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        HrSEtup: record "HR Setup";
        Payroll: codeunit "PR Payroll Processing";
        Cost: decimal;


}
