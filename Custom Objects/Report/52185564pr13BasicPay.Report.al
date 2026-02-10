#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185564 "pr1/3 Basic Pay"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/pr13 Basic Pay.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeCode; "PR Salary Card"."Employee Code")
            {
            }
            column(EmployeeName; EmployeName)
            {
            }
            column(BasicPay; "PR Salary Card"."Basic Pay")
            {
            }
            column(Picture; CI.Picture)
            {
            }
            column(Caption; Txt001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HREmp.Reset;
                if HREmp.Get("Employee Code") then
                    EmployeName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Reset;
        if CI.Get then
            CI.CalcFields(Picture);
    end;

    var
        HREmp: Record "HR Employees";
        EmployeName: Text[250];
        CI: Record "Company Information";
        Txt001: label '1/3 Basic Pay Report';
}
