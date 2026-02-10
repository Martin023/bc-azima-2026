namespace ALProject.ALProject;

report 52186188 "LeaveCost to payroll"
{
    Caption = 'LeaveCost to payroll';
    ProcessingOnly = true;
    dataset
    {
        dataitem(HrEmployees; "Hr Employees")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(AllocatedLeaveDays; "Allocated Leave Days")
            {
            }
            Column(Monthly_Leave_Days; "Monthly Leave Days")
            {

            }
            column("LeaveCost"; Cost)
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
                LeaveToPayroll;
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

    end;



    var
        Formula: decimal;
        Month: Integer;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        HrSEtup: record "HR Setup";
        Payroll: codeunit "PR Payroll Processing";
        Cost: decimal;

    procedure fnGetOpenPeriod() dtOpenPeriod: Date
    var
        "prPayroll Periods": Record "PR Payroll Periods";
        intMonth: Integer;
        intYear: Integer;
    begin
        "prPayroll Periods".Reset;
        "prPayroll Periods".SetRange("prPayroll Periods".Closed, false);

        if "prPayroll Periods".Find('-') then begin
            dtOpenPeriod := "prPayroll Periods"."Date Opened";
            intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
            intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
        end
        else begin
            Error('There is no open payroll period');
        end
    end;

    procedure LeaveToPayroll()
    var
        PrTransactionCodes: record "PR Transaction Codes";
        PrEmployeeTransactions: record "PR Employee Transactions";
        dtOpenPeriod: date;
    begin
        PrEmployeeTransactions.reset;
        PrEmployeeTransactions.SetRange("Transaction Code", 'E029');
        if PrEmployeeTransactions.find then PrEmployeeTransactions.DeleteAll();
        dtOpenPeriod := fnGetOpenPeriod();
        PrEmployeeTransactions.Init();
        PrEmployeeTransactions."Employee Code" := HrEmployees."No.";
        PrEmployeeTransactions."Payroll Period" := dtOpenPeriod;
        PrEmployeeTransactions."Transaction Code" := 'E029';
        PrEmployeeTransactions.Validate("Transaction Code");
        PrEmployeeTransactions.Amount := Cost;
        PrEmployeeTransactions.Insert;
    end;


}
