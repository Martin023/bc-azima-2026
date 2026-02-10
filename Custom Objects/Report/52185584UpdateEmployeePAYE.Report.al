#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185584 "Update Employee PAYE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Update Employee PAYE.rdl';

    dataset
    {
        dataitem("Salary Step/Notch Transactions"; "Salary Step/Notch Transactions")
        {
            //DataItemTableView = sorting("Salary Grade", "Salary Step/Notch", "Entry No") where("Transaction Code" = const(PAYE));
            column(ReportForNavId_7604; 7604)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Grade_; "Salary Grade")
            {
            }
            column(Salary_Step_Notch_Transactions__Salary_Step_Notch_; "Salary Step/Notch")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(Salary_Step_Notch_Transactions__Transaction_Type_; "Transaction Type")
            {
            }
            column(Salary_Step_Notch_Transactions_Amount; Amount)
            {
            }
            column(Salary_Step_Notch_TransactionsCaption; Salary_Step_Notch_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(Salary_Step_Notch_Transactions__Salary_Grade_Caption; UnknownTable52185657.FieldCaption("Salary Grade"))
            // {
            // }
            // column(Salary_Step_Notch_Transactions__Salary_Step_Notch_Caption; UnknownTable52185657.FieldCaption("Salary Step/Notch"))
            // {
            // }
            // column(Salary_Step_Notch_Transactions__Transaction_Code_Caption; UnknownTable52185657.FieldCaption("Transaction Code"))
            // {
            // }
            // column(Salary_Step_Notch_Transactions__Transaction_Name_Caption; UnknownTable52185657.FieldCaption("Transaction Name"))
            // {
            // }
            // column(Salary_Step_Notch_Transactions__Transaction_Type_Caption; UnknownTable52185657.FieldCaption("Transaction Type"))
            // {
            // }
            // column(Salary_Step_Notch_Transactions_AmountCaption; UnknownTable52185657.FieldCaption(Amount))
            // {
            // }
            column(Salary_Step_Notch_Transactions_Entry_No; "Entry No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."Salary Grade", "Salary Step/Notch Transactions"."Salary Grade");
                Employee.SetRange(Employee."Salary Notch/Step", "Salary Step/Notch Transactions"."Salary Step/Notch");
                if Employee.Find('-') then begin
                    repeat

                        objPayrollPeriod.Reset;
                        objPayrollPeriod.SetRange(objPayrollPeriod.Closed, false);
                        if objPayrollPeriod.Find('-') then begin
                            EmpTrans.Reset;
                            EmpTrans.SetCurrentkey(EmpTrans."Employee Code", EmpTrans."Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Employee Code", Employee."No.");
                            EmpTrans.SetRange(EmpTrans."Transaction Code", "Transaction Code");
                            EmpTrans.SetRange(EmpTrans."Payroll Period", objPayrollPeriod."Date Opened");
                            if EmpTrans.Find('-') then begin
                                EmpTrans.Amount := Amount;
                                EmpTrans.Modify;
                            end else begin
                                EmpTransR.Init;
                                EmpTransR."Employee Code" := Employee."No.";
                                EmpTransR."Transaction Code" := "Transaction Code";
                                EmpTransR."Period Month" := objPayrollPeriod."Period Month";
                                EmpTransR."Period Year" := objPayrollPeriod."Period Year";
                                EmpTransR."Payroll Period" := objPayrollPeriod."Date Opened";
                                EmpTransR."Transaction Name" := "Transaction Name";
                                EmpTransR.Amount := Amount;
                                EmpTransR.Insert;

                            end;

                        end;

                    until Employee.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        objPayrollPeriod: Record "PR Payroll Periods";
        EmpTrans: Record "PR Employee Transactions";
        EmpTransR: Record "PR Employee Transactions";
        Employee: Record "HR Employees";
        Salary_Step_Notch_TransactionsCaptionLbl: label 'Salary Step/Notch Transactions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
