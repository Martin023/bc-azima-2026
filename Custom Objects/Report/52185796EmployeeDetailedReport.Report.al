#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185796 "Employee Detailed Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Employee Detailed Report.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Gender_HREmployees; "HR Employees".Gender)
            {
            }
            column(DateOfBirth_HREmployees; "HR Employees"."Date Of Birth")
            {
            }
            column(Age_HREmployees; "HR Employees".Age)
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployees; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployees; "HR Employees"."Middle Name")
            {
            }
            column(LastName_HREmployees; "HR Employees"."Last Name")
            {
            }
            column(DateOfJoin_HREmployees; "HR Employees"."Date Of Join")
            {
            }
            column(JobTitle_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(Grade_HREmployees; "HR Employees".Grade)
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(FullName; EmpName)
            {
            }
            column(Age; EmpAge)
            {
            }
            column(num; num)
            {
            }

            trigger OnAfterGetRecord()
            begin

                num := num + 1;

                EmpAge := 0;
                HrEmp.Reset;
                HrEmp.SetRange("No.", "HR Employees"."No.");
                if HrEmp.Find('-') then begin
                    EmpName := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
                    if HrEmp."Date Of Birth" <> 0D then
                        EmpAge := (Today - HrEmp."Date Of Birth") / 365;
                end
            end;

            trigger OnPreDataItem()
            begin
                //OnViewCurrRec();
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
        num := 0;
        Message('Work oriented employee datails.');
    end;

    var
        CompanyInformation: Record "Company Information";
        EmpName: Text;
        HrEmp: Record "HR Employees";
        EmpAge: Decimal;
        num: Integer;


    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
