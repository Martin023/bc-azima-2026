report 52186054 "Loan Fall Off"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Fall Off.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(MemberNo; "Member No.")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(AmountToDisburse; "Amount To Disburse")
            {
            }
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
}
