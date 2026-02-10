#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185576 "Mark Employee as Discharged"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Mark Employee as Discharged.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = Status, "Status Change Date", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
            column(ReportForNavId_8631; 8631)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(GETFILTERS; "HR EMPLOYEES".GetFilters)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Gender; Gender)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(HR_Employee__Job_Title_; "Job Title")
            {
            }
            column(HR_Employee_Status; Status)
            {
            }
            column(HR_Employee__Status_Change_Date_; "Status Change Date")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; "HR EMPLOYEES".FieldCaption("No."))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(HR_Employee_GenderCaption; "HR EMPLOYEES".FieldCaption(Gender))
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(HR_Employee__Job_Title_Caption; "HR EMPLOYEES".FieldCaption("Job Title"))
            {
            }
            column(HR_Employee_StatusCaption; "HR EMPLOYEES".FieldCaption(Status))
            {
            }
            column(HR_Employee__Status_Change_Date_Caption; "HR EMPLOYEES".FieldCaption("Status Change Date"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
                DeptName := '';

                DValue.Reset;
                DValue.SetRange(DValue."Dimension Code", 'DEPARTMENT');
                DValue.SetRange(DValue.Code, "HR Employees"."Department Code");
                if DValue.Find('-') then
                    DeptName := DValue.Name;

                "HR Employees".Status := "HR Employees".Status::Active;
                "HR Employees".Modify;
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

    var
        RCount: Integer;
        DeptName: Text[200];
        DValue: Record "Dimension Value";
        Employee_ListCaptionLbl: label 'Employee List';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NamesCaptionLbl: label 'Names';
        DepartmentCaptionLbl: label 'Department';
}
