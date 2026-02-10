#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185921 "Detailed Payroll Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Detailed Payroll Transactions.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "HR Employees"."No.")
            {
            }
            column(FullName; "HR Employees"."Full Name")
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(PayrollPeriod; PayrollPeriod)
            {
            }
            dataitem("PR Transaction Codes"; "PR Transaction Codes")
            {
                RequestFilterFields = "Transaction Type";
                column(ReportForNavId_8; 8)
                {
                }
                column(TransCode; "PR Transaction Codes"."Transaction Code")
                {
                }
                column(TransName; "PR Transaction Codes"."Transaction Name")
                {
                }
                dataitem(Transaction; "PR Transaction Codes")
                {
                    DataItemLink = "Transaction Code" = field("Transaction Code");
                    column(ReportForNavId_4; 4)
                    {
                    }
                    column(TransAmount; amount)
                    {
                    }
                    column(TransType; "PR Transaction Codes"."Transaction Type")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        amount := 0;
                        if "PR Transaction Codes".Get(Transaction."Transaction Code") then begin
                            EmployeeTransactions.Reset;
                            EmployeeTransactions.SetRange("Employee Code", STAFFNO);
                            EmployeeTransactions.SetRange("Payroll Period", PayrollPeriod);
                            EmployeeTransactions.SetRange("Transaction Code", Transaction."Transaction Code");
                            if EmployeeTransactions.Find('-') then begin

                                amount := EmployeeTransactions.Amount;

                            end;
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                STAFFNO := "HR Employees"."No.";
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
                field(PayrollPeriod; PayrollPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'PayrollPeriod';
                    TableRelation = "PR Payroll Periods" where(Closed = const(True));
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if PayrollPeriod = 0D then Error('You must specify the period filter');
        if CI.Get() then
            CI.CalcFields(CI.Picture);
    end;

    var
        GenJnl: Record "Gen. Journal Line";
        Codes: Record "PR Transaction Codes";
        amount: Decimal;
        EmployeeTransactions: Record "PR Employee Transactions";
        Staff: Record "HR Employees";
        STAFFNO: Code[20];
        PayrollPeriod: Date;
        CI: Record "Company Information";
}
