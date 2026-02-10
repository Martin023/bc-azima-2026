report 52186043 "Staff Member Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Staff Member Balance Report.rdl';

    dataset
    {
        dataitem(HREmployees; "HR Employees")
        {

            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }
            column(ID_Number; "ID Number")
            {

            }


            column(MemberNo; HREmployees."Member No.")
            {

            }



            dataitem(Deposit; "Savings Accounts")
            {
                dataitemLink = "Payroll/Staff No." = field("No.");
                //DataItemTableView=where("Product Category"=Filter("BOSA Deposits" |"FOSA Account"| "Share Capital" | "Risk" | "Business Deposits" | "Benevolent (BBF)"));
                column(Balance__LCY_; "Balance (LCY)")
                {

                }
            }
            dataitem(Loans; Loans)
            {
                dataitemLink = "Staff No" = field("No.");
                column(Total_Balance; "Total Balance")
                {

                }
            }
            trigger OnAfterGetRecord()
            begin
                // Deposits.Reset;
                // Deposits.setrange("Payroll/Staff No.","No.");
                // if Deposits.FindSet() then 
                // DepositBalance


            end;

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


    var
        myInt: Integer;

        Deposits: record "Savings Accounts";

        DepositBalance: Decimal;
        LoanBalance: Decimal;

}