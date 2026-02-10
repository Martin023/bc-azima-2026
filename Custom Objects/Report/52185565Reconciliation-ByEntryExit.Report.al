#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185565 "Reconciliation - By Entry/Exit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Reconciliation - By EntryExit.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Current Month Filter", "Gross Income Variation", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
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
            // column(GETFILTERS; UnknownTable"HR EMPLOYEES".GetFilters)
            // {
            // }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Status; Status)
            {
            }
            column(HR_Employee__Prev__Gross_Pay_; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay_; "Curr. Gross Pay")
            {
            }
            column(HR_Employee__Gross_Income_Variation_; "Gross Income Variation")
            {
            }
            column(VariationRemarks; VariationRemarks)
            {
            }
            column(HR_Employee__No___Control1102755016; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name__Control1102755017; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Status_Control1102755025; Status)
            {
            }
            column(HR_Employee__Prev__Gross_Pay__Control1102755026; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay__Control1102755027; "Curr. Gross Pay")
            {
            }
            column(HR_Employee__Gross_Income_Variation__Control1102755028; "Gross Income Variation")
            {
            }
            column(VariationRemarks_Control1102755031; VariationRemarks)
            {
            }
            column(HR_Employee__Gross_Income_Variation__Control1102755024; "Gross Income Variation")
            {
            }
            column(RCount; RCount)
            {
            }
            column(HR_Employee__Prev__Gross_Pay__Control1102755034; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay__Control1102755035; "Curr. Gross Pay")
            {
            }
            column(Salary_Reconciliations___By_Staff_Entry_ExitsCaption; Salary_Reconciliations___By_Staff_Entry_ExitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(HR_Employee__No__Caption; UnknownTable"HR EMPLOYEES".FieldCaption("No."))
            // {
            // }
            // column(NamesCaption; NamesCaptionLbl)
            // {
            // }
            // column(HR_Employee_StatusCaption; UnknownTable"HR EMPLOYEES".FieldCaption(Status))
            // {
            // }
            // column(HR_Employee__Prev__Gross_Pay_Caption; UnknownTable"HR EMPLOYEES".FieldCaption("Prev. Gross Pay"))
            // {
            // }
            // column(HR_Employee__Curr__Gross_Pay_Caption; UnknownTable"HR EMPLOYEES".FieldCaption("Curr. Gross Pay"))
            // {
            // }
            // column(HR_Employee__Gross_Income_Variation_Caption; UnknownTable"HR EMPLOYEES".FieldCaption("Gross Income Variation"))
            // {
            // }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                VariationRemarks := '';

                if ("HR Employees"."Prev. Gross Pay" = 0) and ("HR Employees"."Curr. Gross Pay" = 0) then
                    CurrReport.Skip;


                if ("HR Employees"."Prev. Gross Pay" > 0) and ("HR Employees"."Curr. Gross Pay" > 0) then
                    CurrReport.Skip;


                if "HR Employees"."Gross Income Variation" <> 0 then begin
                    MonthlyRecon.Reset;
                    MonthlyRecon.SetCurrentkey(MonthlyRecon.Employee);
                    MonthlyRecon.SetRange(MonthlyRecon.Employee, "HR Employees"."No.");
                    MonthlyRecon.SetFilter(MonthlyRecon."Group Order", '=1|=3');
                    if MonthlyRecon.Find('-') then begin
                        repeat
                            if StrLen(VariationRemarks + ', ' + MonthlyRecon.Description + '[]' + Format(MonthlyRecon.Difference)) < 1000 then begin
                                if VariationRemarks = '' then
                                    VariationRemarks := MonthlyRecon.Description + '[' + Format(MonthlyRecon.Difference) + ']'
                                else
                                    VariationRemarks := VariationRemarks + ', ' + MonthlyRecon.Description + '[' + Format(MonthlyRecon.Difference) + ']';
                            end;

                        until MonthlyRecon.Next = 0;
                    end;
                end;

                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if "HR Employees".GetFilter("HR Employees"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                //Evaluate(SelectedPeriod, UnknownTable"HR EMPLOYEES".GetFilter("HR Employees"."Current Month Filter"));

                "HR Employees".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));

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
        VariationRemarks: Text[1000];
        MonthlyRecon: Record "Monthly Reconcilliation";
        SelectedPeriod: Date;
        CompanyInfo: Record "Company Information";
        Salary_Reconciliations___By_Staff_Entry_ExitsCaptionLbl: label 'Salary Reconciliations - By Staff Entry/Exits';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NamesCaptionLbl: label 'Names';
        RemarksCaptionLbl: label 'Remarks';
}
