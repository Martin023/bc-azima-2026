namespace MNSProjectMwanga.MNSProjectMwanga;

using System.Utilities;

report 52186196 "Slary List Report"
{
    ApplicationArea = All;
    Caption = 'Salary List Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
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
    trigger OnPreReport()
    var
        myInt: Integer;
        SalaryLines: Query "Salary Lines";
    begin
        SalaryLines.open();
    end;
}
