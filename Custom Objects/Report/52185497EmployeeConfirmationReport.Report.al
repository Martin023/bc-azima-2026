#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185497 "Employee Confirmation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Employee Confirmation Report.rdl';

    dataset
    {
        dataitem("HR Employee Confirmation"; "HR Employee Confirmation")
        {
            RequestFilterFields = No;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(ProbationStartDate_HREmployeeConfirmation; "HR Employee Confirmation"."Probation Start Date")
            // {
            // }
            // column(ProbationEndDate_HREmployeeConfirmation; "HR Employee Confirmation"."Probation End Date")
            // {
            // }
            // column(ConfirmationDate_HREmployeeConfirmation; "HR Employee Confirmation"."Confirmation Date")
            // {
            // }
            // column(Designation_HREmployeeConfirmation; "HR Employee Confirmation".Designation)
            // {
            // }
            // column(No_HREmployeeConfirmation; "HR Employee Confirmation".No)
            // {
            // }
            // column(EmployeeNumber_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Number")
            // {
            // }
            // column(EmployeeName_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Name")
            // {
            // }
            // column(RequestDate_HREmployeeConfirmation; "HR Employee Confirmation"."Request Date")
            // {
            // }
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
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HREmp: Record "HR Employees";
}
