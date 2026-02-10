#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185560 "Validate Salary Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Validate Salary Card.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            DataItemTableView = sorting("Employee Code");
            column(ReportForNavId_6207; 6207)
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
            column(prSalary_Card__Employee_Code_; "Employee Code")
            {
            }
            column(prSalary_Card__Basic_Pay_; "Basic Pay")
            {
            }
            column(prSalary_Card__Payment_Mode_; "Payment Mode")
            {
            }
            column(prSalary_CardCaption; prSalary_CardCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prSalary_Card__Employee_Code_Caption; "PR Salary Card".FieldCaption("Employee Code"))
            {
            }
            column(prSalary_Card__Basic_Pay_Caption; "PR Salary Card".FieldCaption("Basic Pay"))
            {
            }
            column(prSalary_Card__Payment_Mode_Caption; "PR Salary Card".FieldCaption("Payment Mode"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Employee.Get("PR Salary Card"."Employee Code") then begin
                    "PR Salary Card"."Identification Number" := Employee."Location/Division Code";
                    "PR Salary Card"."Mobile Number" := Employee."Department Code";
                    "PR Salary Card".Nationality := Employee."Cost Center Code";
                    //"PR Salary Card"."Date of Birth":=Employee."Salary Grade";
                    "PR Salary Card"."Scheme Code 2" := Employee."Salary Notch/Step";
                end;

                "PR Salary Card"."Pays NSSF" := false;
                "PR Salary Card"."Pays NHIF" := false;
                if SalaryGrades.Get("PR Salary Card"."Date of Birth") then
                    "PR Salary Card"."Pays NHIF" := SalaryGrades."Pays NHF";
                "PR Salary Card".Modify;
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
        Employee: Record "HR Employees";
        SalaryGrades: Record "Salary Grades";
        prSalary_CardCaptionLbl: label 'prSalary Card';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
