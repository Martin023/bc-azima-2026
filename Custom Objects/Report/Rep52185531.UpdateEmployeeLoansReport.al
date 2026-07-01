namespace AzimaCBS.AzimaCBS;

report 52185531 "Update Employee Loans Report"
{
    ApplicationArea = All;
    Caption = 'Update Employee Loans Report';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HREmployees; "HR Employees")
        {
            column(MemberNo; "Member No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Loans.reset;
                Loans.SetRange("Member No.", HREmployees."Member No.");
                loans.setfilter("Source Unit", '<>%1', Loans."Source Unit"::FOSA);
                Loans.Setfilter("Disbursement Date", '..%1', CutOffDate);
                Loans.SetFilter(Loans."Total Balance", '>0');
                if Loans.FindSet() then begin
                    repeat
                        PRTransactionCodes.Reset;
                        PRTransactionCodes.SetRange("Loan Product Type", Loans."Loan Product Type");
                        if PRTransactionCodes.Find('-') then begin
                            repeat
                                PREmployeeTransactions.Reset();
                                PREmployeeTransactions.SetRange("Employee Code", HREmployees."No.");
                                PREmployeeTransactions.SetRange("Transaction Code", PRTransactionCodes."Transaction Code");
                                PREmployeeTransactions.SetRange("Loan Number", Loans."Loan No.");
                                if PREmployeeTransactions.FindFirst then begin
                                    PREmployeeTransactions.DeleteAll();
                                end;
                                PREmployeeTransactions.Init();
                                PREmployeeTransactions."Employee Code" := HREmployees."No.";
                                PREmployeeTransactions."Transaction Code" := PRTransactionCodes."Transaction Code";
                                PREmployeeTransactions."Loan Number" := Loans."Loan No.";
                                PREmployeeTransactions."Interest Due" := Loans."Outstanding Interest";
                                PREmployeeTransactions."Loan Interest Rate" := Loans.interest;
                                PREmployeeTransactions.Balance := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                                PREmployeeTransactions.Amount := Loans.Repayment;
                                PREmployeeTransactions."Original Amount" := Loans."Approved Amount";
                                PREmployeeTransactions."Start Date" := Loans."Repayment Start Date";
                                PREmployeeTransactions."End Date" := Loans."Expected Date of Completion";
                                PREmployeeTransactions."Loan Interest Rate" := Loans.Interest;
                                PREmployeeTransactions."Period Month" := PeriodMonth;
                                PREmployeeTransactions."Period Year" := PeriodYear;
                                PREmployeeTransactions.Insert();

                            until PRTransactionCodes.next = 0;
                        end
                        else
                            CurrReport.Skip;
                    until Loans.next() = 0;
                end;

            end;
        }


    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Cut-off Date';
                    field(CutOffDate; CutOffDate)
                    {
                        ApplicationArea = Basic;
                    }

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
        if CutOffDate = 0D then
            Error('Please enter a valid cut-off date.');

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";

        end;
    end;

    var
        CutOffDate: Date;
        PRTransactionCodes: Record "PR Transaction Codes";
        PREmployeeTransactions: Record "PR Employee Transactions";
        Loans: Record Loans;
        objPeriod: record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;

}