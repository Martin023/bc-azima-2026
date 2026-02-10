#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185556 "Validate Employee Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Validate Employee Transactions.rdl';

    dataset
    {
        dataitem("PR Employee Transactions"; "PR Employee Transactions")
        {
            DataItemTableView = sorting("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No");
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_5642; 5642)
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
            column(prEmployee_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prEmployee_Transactions_Amount; Amount)
            {
            }
            column(prEmployee_TransactionsCaption; prEmployee_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(prEmployee_Transactions__Employee_Code_Caption; UnknownTable52185623.FieldCaption("Employee Code"))
            // {
            // }
            // column(prEmployee_Transactions__Transaction_Code_Caption; UnknownTable52185623.FieldCaption("Transaction Code"))
            // {
            // }
            // column(prEmployee_Transactions__Transaction_Name_Caption; UnknownTable52185623.FieldCaption("Transaction Name"))
            // {
            // }
            // column(prEmployee_Transactions_AmountCaption; UnknownTable52185623.FieldCaption(Amount))
            // {
            // }
            column(prEmployee_Transactions_Period_Month; "Period Month")
            {
            }
            column(prEmployee_Transactions_Period_Year; "Period Year")
            {
            }
            column(prEmployee_Transactions_Payroll_Period; "Payroll Period")
            {
            }
            column(prEmployee_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."No.", "PR Employee Transactions"."Employee Code");
                if HREmployee.Find('-') then begin
                    if HREmployee.Status <> HREmployee.Status::New then begin
                        "PR Employee Transactions".Delete;
                        CurrReport.Skip;
                    end;
                end else begin
                    "PR Employee Transactions".Delete;
                    CurrReport.Skip;
                end;

                if Trans.Get("PR Employee Transactions"."Transaction Code") then begin
                    "PR Employee Transactions"."Transaction Name" := Trans."Transaction Name";
                    "PR Employee Transactions".Modify;
                    if "PR Employee Transactions".Balance <> 0 then begin

                        if AdjustRunningBal = Adjustrunningbal::"Increase 1 Installment" then begin
                            if Trans."Transaction Type" = Trans."transaction type"::Income then
                                "PR Employee Transactions".Balance := "PR Employee Transactions".Balance + "PR Employee Transactions".Amount
                            else
                                "PR Employee Transactions".Balance := "PR Employee Transactions".Balance - "PR Employee Transactions".Amount;

                            "PR Employee Transactions".Modify;
                        end;


                        if AdjustRunningBal = Adjustrunningbal::"Reduce 1 Installment" then begin
                            if Trans."Transaction Type" = Trans."transaction type"::Income then
                                "PR Employee Transactions".Balance := "PR Employee Transactions".Balance - "PR Employee Transactions".Amount
                            else
                                "PR Employee Transactions".Balance := "PR Employee Transactions".Balance + "PR Employee Transactions".Amount;
                            "PR Employee Transactions".Modify;

                        end;

                    end;
                    //IF Trans.Pension = TRUE THEN BEGIN
                    "PR Employee Transactions"."Employer Amount" := "PR Employee Transactions".Amount;
                    "PR Employee Transactions"."Employer Balance" := "PR Employee Transactions".Balance;
                    "PR Employee Transactions".Modify;
                    //END;
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
        HREmployee: Record "HR Employees";
        AdjustRunningBal: Option " ","Reduce 1 Installment","Increase 1 Installment";
        Trans: Record "PR Transaction Codes";
        prEmployee_TransactionsCaptionLbl: label 'prEmployee Transactions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
