report 52187320 "PRSalaryAdvanceSchedule"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/PRSalaryAdvanceSchedule.rdl';

    dataset
    {
        dataitem("prSalary Advance"; "prSalary Advance")
        {
            column(Employee_No; "prSalary Advance"."Employee No")
            {
            }
            column(Employee_Name; "prSalary Advance"."Employee Names")
            {
            }
            column(Loan_No; "prSalary Advance"."Loan No.")
            {
            }
            column(Loan_Type; "prSalary Advance"."Loan Type")
            {
            }
            column(Instalments_Amount; "Instalments Amount")
            {
            }
            column(Interest_Rate; "Interest Rate")
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(Loan_Balance; "prSalary Advance".Balance)
            {
            }
            column(Loan_Status; "prSalary Advance".Status)
            {
            }
            column(Advance_Amount; "prSalary Advance"."Advance Amount Requested")
            {
            }
            column(Loan_Principal_Repayment; "prSalary Advance"."Loan Principal Repayment")
            {
            }
            column(Repayment_Period; "Repayment Period")
            {
            }
            column(Repayment_Frequency; "Repayment Frequency")
            {
            }
            column(Amount_Approved; "prSalary Advance"."Amount Approved")
            {
            }
            column(Loan_Disbursment_Date; "prSalary Advance"."Loan Disbursement Date")
            {
            }
            column(Total_Loan_Repayment_Amount; "Total Loan Repayment Amount")
            {
            }
            column(Amount_Paid; "Amount Paid")
            {
            }
            column(Balance; "Balance")
            {
            }
            column(Third_Basic_Salary; "1/3/ of Basic Salary")
            {
            }
            column(Grace_Period_Interest; "prSalary Advance"."Grace Period - Interest (M)")
            {
            }
            column(Grace_Period_Principle; "prSalary Advance"."Grace Period - Principle (M)")
            {
            }
            // column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            // {
            // }
            // column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            // {
            // }
            // column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            // {
            // }
            // column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            // {
            // }



        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}