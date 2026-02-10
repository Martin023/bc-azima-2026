#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185477 "HR Staff Supervisor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/HR Employees Statistics.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "No.", Status;
            DataItemTableView = where(Status = const(active));
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
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(Designation_HREmployees; "HR Employees".Position)
            {
            }
            column(FullName_HREmployees; "HR Employees".FullName)
            {
            }
            column(Status_HREmployees; "HR Employees".Status)
            {
            }
            column(DateOfBirth_HREmployees; "HR Employees"."Date Of Birth")
            {
            }
            column(Job_Title; HREmp."Job Title")
            {
            }
            column(JobDescription_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(Gender_HREmployees; "HR Employees".Gender)
            {
            }
            column(MaritalStatus_HREmployees; "HR Employees"."Marital Status")
            {
            }
            column(FullPartTime_HREmployees; "HR Employees"."Full / Part Time")
            {
            }
            column(PensionFundAdministrator_HREmployees; HREmp."Last Name")
            {
            }
            column(Grade_HREmployees; "HR Employees"."Salary Grade")
            {
            }
            column(SalaryStep_HREmployees; HREmp."Postal Address")
            {
            }
            column(EmployeeCategory_HREmployees; HREmp."Work Phone Number")
            {
            }
            column(Pension_House; "HR Employees"."Pension House")
            {
            }
            column(HR_Status; "HR Employees".Status)
            {
            }
            column(HR_Supervisor; "HR Employees"."Supervisor Name")
            {
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
