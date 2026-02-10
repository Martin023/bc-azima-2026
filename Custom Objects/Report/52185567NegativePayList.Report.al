#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185567 "Negative Pay List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Negative Pay List.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.") where("Net Pay" = filter(< 0));
            RequestFilterFields = "Current Month Filter";
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee__Department_Code_; "Department Code")
            {
            }
            column(HR_Employee__Job_Title_; "Job Title")
            {
            }
            column(HR_Employee__Net_Pay_; "Net Pay")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Negative_Pay_ListCaption; Negative_Pay_ListCaptionLbl)
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
            column(HR_Employee__Department_Code_Caption; "HR EMPLOYEES".FieldCaption("Department Code"))
            {
            }
            column(HR_Employee__Job_Title_Caption; "HR EMPLOYEES".FieldCaption("Job Title"))
            {
            }
            column(HR_Employee__Net_Pay_Caption; "HR EMPLOYEES".FieldCaption("Net Pay"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        CompanyInfo: Record "Company Information";
        Negative_Pay_ListCaptionLbl: label 'Negative Pay List';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NamesCaptionLbl: label 'Names';
}
