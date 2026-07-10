namespace AZIMA.AZIMA;

report 52185479 "Next of kin Allocation Report"
{
    ApplicationArea = All;
    Caption = 'Next of kin Allocation Report';
    RDLCLayout = './bc-azima-2026/Layout/Next of kin Allocation Report.rdl';
    UsageCategory = ReportsAndAnalysis;
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
            column(EmployerCode; "Employer Code")
            {
            }
            column(AllocationPercentage; AlocationPercentage)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AlocationPercentage := 0;
                NextOfKin.Reset();
                NextOfKin.SetRange("Record ID", Members."No.");
                if NextOfKin.FindSet() then begin
                    repeat
                        AlocationPercentage += NextOfKin.Allocation;
                    until NextOfKin.Next() = 0;
                end;
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
        NextOfKin: record "Next of KIN";
        AlocationPercentage: Decimal;
}
