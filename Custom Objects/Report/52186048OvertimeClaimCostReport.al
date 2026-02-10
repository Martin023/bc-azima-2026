#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186048 "Overtime Claim Cost"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Overtime Claim Cost.rdl';

    dataset
    {
        dataitem(OvertimeClaim; "Overtime Claim Header")
        {
            RequestFilterFields = Status, Name;

            //DataItemTableView = where(status=const(approved));

            column(ReportForNavId_9162; 9162)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(Cost; OvertimeClaim.Amount)
            {

            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Name; Name)
            {

            }
            column(Staff_No_; OvertimeClaim."Staff No.")
            {

            }
            column(Amount; Amount)
            {

            }
            Column(Claim_No; "Claim No")
            {

            }
            column(Date_Created; "Date Created")
            {

            }
            column(Total_Overtime_Hrs; "Total Overtime Hrs")
            {

            }
            column(Total_Overtime_Week_Days; "Total Overtime Week Days")
            {

            }
            dataitem("Overtime Claim Lines"; "Overtime Claim Lines")
            {
                DataItemLink = "Claim No" = field("Claim No");
                column(Work_Description_Reason; "Work Description/Reason")
                {

                }
                column(Overtime_Type; "Overtime Type")
                {

                }
                column(Time_From; "Time From")
                {

                }
                column(Time_To; "Time To")
                {

                }
            }


            // column(Payroll_Variations__Employee_Code_Caption; UnknownTable52185655.FieldCaption("Employee Code"))
            // {
            // }
            // column(Payroll_Variations__Payroll_Period_Caption; UnknownTable52185655.FieldCaption("Payroll Period"))
            // {
            // }
            // column(Payroll_Variations__Effective_Date_Caption; UnknownTable52185655.FieldCaption("Effective Date"))
            // {
            // }
            // column(NamesCaption; NamesCaptionLbl)
            // {
            // }
            // column(Payroll_Variations__Hrs_Worked_Caption; UnknownTable52185655.FieldCaption("Hrs Worked"))
            // {
            // }
            // column(Payroll_Variations__Overtime_Type_Caption; UnknownTable52185655.FieldCaption("Overtime Type"))
            // {
            // }

            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

            end;

            // trigger OnPreDataItem()
            // begin
            //     LastFieldNo := UnknownTable52185655.FieldNo("Employee Code");
            //     "Payroll Variations".SetRange("Payroll Variations".Type, "Payroll Variations".Type::"Overtime Claim")
            // end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Month:"; Month)
                {

                }
            }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        Month := Date2DMY(OvertimeClaim."Date Created", 2)
    end;


    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
        "Hr-Employee": Record "HR Employees";
        Month: Integer;
        Names: Text[100];
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Overtime_Claim_DetailsCaptionLbl: label 'Overtime Claim Details';


        NamesCaptionLbl: label 'Names';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
}
