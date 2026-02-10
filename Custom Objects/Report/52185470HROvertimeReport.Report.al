#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185470 "HR Overtime Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Overtime Report.rdl';

    dataset
    {
        dataitem("HR Overtime Header"; "HR Overtime Header")
        {
            RequestFilterFields = "Application Code", "Staff No.";
            column(ReportForNavId_9002; 9002)
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
            column(HR_Jobs_UserID; UserId)
            {
            }
            // column(CI_Picture;CI.Picture)
            // {
            // }
            // column(CI_Address;CI.Address)
            // {
            // }
            // column(CI__Address_2______CI__Post_Code_;CI."Address 2"+' '+CI."Post Code")
            // {
            // }
            // column(CI_City;CI.City)
            // {
            // }
            // column(CI_PhoneNo;CI."Phone No.")
            // {
            // }
            // column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            // {
            // }
            // column(P_O__BoxCaption;P_O__BoxCaptionLbl)
            // {
            // }
            column(StaffNo_HROvertimeHeader; "HR Overtime Header"."Staff No.")
            {
            }
            column(StaffName_HROvertimeHeader; "HR Overtime Header"."Staff Name")
            {
            }
            column(ConvertTo_HROvertimeHeader; "HR Overtime Header"."Convert To?")
            {
            }
            column(ApplicationCode_HROvertimeHeader; "HR Overtime Header"."Application Code")
            {
            }
            column(ApplicationDate_HROvertimeHeader; "HR Overtime Header"."Application Date")
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

            dataitem("HR Overtime Lines"; "HR Overtime Lines")
            {
                DataItemLink = "Application Code" = field("Application Code");
                column(ReportForNavId_5; 5)
                {
                }
                column(OvertimeHours_HROvertimeLines; "HR Overtime Lines"."Overtime Hours")
                {
                }
                column(Date_HROvertimeLines; "HR Overtime Lines".Date)
                {
                }
                column(StartTime_HROvertimeLines; "HR Overtime Lines"."Start Time")
                {
                }
                column(EndTime_HROvertimeLines; "HR Overtime Lines"."End Time")
                {
                }
                column(WorkDone_HROvertimeLines; "HR Overtime Lines"."Work Done")
                {
                }
                column(OvertimeType_HROvertimeLines; "HR Overtime Lines"."Overtime Type")
                {
                }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_StatisticsCaptionLbl: label 'HR Job Statistics';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        MyUserID: Text;
        UserSetup: Record "User Setup";
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
