namespace AZIMA.AZIMA;

report 52185532 "Member Balances Report"
{
    ApplicationArea = All;
    Caption = 'Member Balances Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Member Balances Report.rdl';


    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(EmployerCode; "Employer Code")
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

    var
        MemberDeposits: Decimal;
        MFIDeposits: Decimal;
        ShareCapital: Decimal;
        
}
