namespace AZIMA.AZIMA;

report 52185540 "Insurance Deposit Report"
{
    ApplicationArea = All;
    Caption = 'Insurance Deposit Report';
    UsageCategory = Lists;
    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
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
}
