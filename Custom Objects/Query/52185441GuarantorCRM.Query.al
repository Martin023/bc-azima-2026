Query 52185441 GuarantorCRM
{

    elements
    {
        dataitem(loan_guarantors_and_security; "Loan Guarantors and Security")
        {
            column(Loan_No; "Loan No")
            {
            }
            column(Savings_Account_No_Member_No; "Savings Account No./Member No.")
            {
            }
            column(Deposits_Shares; "Deposits/Shares")
            {
            }
            column(No_Of_Loans_Guaranteed; "No Of Loans Guaranteed")
            {
            }
            column(Substituted; Substituted)
            {
            }
            column(Shares_Recovery; "Shares Recovery")
            {
            }
            column(Self_Guarantee; "Self Guarantee")
            {
            }
            column(Member_Guaranteed; "Member Guaranteed")
            {
            }
            column(Percentage_Guaranteed; "Percentage Guaranteed")
            {
            }
            column(Available_Shares; "Available Shares")
            {
            }
            column(Collateral_Reg_No; "Collateral Reg. No.")
            {
            }
            column(Total_Guaranteed; "Total Guaranteed")
            {
            }
            column(Amount_Guaranteed; "Amount Guaranteed")
            {
            }
            column(Member_No; "Member No")
            {
            }
            column(ID_No; "ID No.")
            {
            }
            filter(Date; Date)
            {
                ColumnFilter = Date = const();
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Loan No." = Loan_Guarantors_and_Security."Loan No";
                column(Application_Date; "Application Date")
                {
                }
                column(Loan_Product_Type; "Loan Product Type")
                {
                }
                column(Loan_Product_Type_Name; "Loan Product Type Name")
                {
                }
                column(Loans_Category_SASRA; "Loans Category-SASRA")
                {
                }
                column(Member_Name; "Member Name")
                {
                }
                column(Disbursement_Date; "Disbursement Date")
                {
                }
                column(Approved_Amount; "Approved Amount")
                {
                }
                column(Outstanding_Balance; "Outstanding Balance")
                {
                }
                column(Expected_Date_of_Completion; "Expected Date of Completion")
                {
                }
            }
        }
    }
}
