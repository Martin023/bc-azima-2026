Query 52185439 SavingsAccountsCRM
{

    elements
    {
        dataitem(Savings_accounts; "Savings Accounts")
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Phone_No; "Phone No.")
            {
            }
            column(Balance; Balance)
            {
            }
            column(Balance_Due; "Balance Due")
            {
            }
            column(Bank_Code; "Bank Code")
            {
            }
            column(Member_No; "Member No.")
            {
            }
            column(Account_Category; "Account Category")
            {
            }
            filter(Last_Date_Modified; "Last Date Modified")
            {
                ColumnFilter = Last_Date_Modified = const();
            }
        }
    }
}
