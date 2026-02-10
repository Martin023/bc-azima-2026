#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185582 "Mark as DOES NOT pay PAYE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Mark as DOES NOT pay PAYE.rdl';

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
            column(prSalary_Card__Pays_PAYE_; "Pays PAYE")
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
            column(prSalary_Card__Pays_PAYE_Caption; "PR Salary Card".FieldCaption("Pays PAYE"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                "PR Salary Card"."Pays PAYE" := false;
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
        prSalary_CardCaptionLbl: label 'prSalary Card';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
