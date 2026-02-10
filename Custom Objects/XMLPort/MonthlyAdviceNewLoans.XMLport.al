#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185498 "Monthly Advice New Loans"
{
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Advice Header"; "Checkoff Advice Header")
            {
                XmlName = 'Hadvice';
            }
            tableelement("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                // LinkFields = Field17=field(No);
                LinkTable = "Checkoff Advice Header";
                XmlName = 'Advice';
                fieldelement(StaffNo; "Checkoff Advice Line"."Payroll No")
                {
                }
                fieldelement(MemberNo; "Checkoff Advice Line"."Member No.")
                {
                }
                fieldelement(Name; "Checkoff Advice Line".Names)
                {
                }
                fieldelement(EmployerCode; "Checkoff Advice Line"."Employer Code")
                {
                }
                fieldelement(LoanNo; "Checkoff Advice Line"."Loan No.")
                {
                }
                fieldelement(Period; "Checkoff Advice Line".Period)
                {
                }
                fieldelement(AmountOn; "Checkoff Advice Line"."Amount On")
                {
                }
                fieldelement(AmountOff; "Checkoff Advice Line"."Amount Off")
                {
                }
                fieldelement(BalanceOn; "Checkoff Advice Line"."Balance On")
                {
                }
                fieldelement(BalaceOff; "Checkoff Advice Line"."Balance Off")
                {
                }
                fieldelement(CheckOFF; "Checkoff Advice Line"."Advice Header No.")
                {
                }
            }
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
}
