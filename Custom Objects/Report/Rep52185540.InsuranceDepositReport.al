namespace AZIMA.AZIMA;

report 52185540 "Insurance Deposit Report"
{
    ApplicationArea = All;
    Caption = 'Insurance Deposit Report';
    UsageCategory = Lists;
    RDLCLayout = './bc-azima-2026/Layout/Insurance Deposit Report.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Payroll/Staff No.", "Employer Code", Status;
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Primary_Identification; "Primary Identification") { }
            column(DOB; "Date of Birth") { }
            column(Sno; Sno) { }
            column(DepositsCont; DepositsCont) { }
            trigger OnAfterGetRecord()
            begin
                Sno += 1;
                DepositsCont := 0;
                Deposits.Reset();
                Deposits.SetRange("Member No.", Members."No.");
                Deposits.SetRange("Product Category", Deposits."Product Category"::"BOSA Deposits");
                if Deposits.FindFirst() then begin
                    Deposits.CalcFields(Balance);
                    DepositsCont := Deposits.Balance;
                end;
                //Deposits.SetRange();
            end;
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
        Deposits: Record "Savings Accounts";
        Sno: Integer;
        DepositsCont: Decimal;
}
