#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185483 "HR Leave Applications List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Leave Applications List.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            column(ReportForNavId_3725; 3725)
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
            column(HR_Leave_Application__Application_Code_; "Application Code")
            {
            }
            column(HR_Leave_Application__Application_Date_; "Application Date")
            {
            }
            column(HR_Leave_Application__Employee_No_; "Applicant Staff No.")
            {
            }
            column(Names_HRLeaveApplication; "HR Leave Application".Names)
            {
            }
            column(HR_Leave_Application__Job_Tittle_; "Job Tittle")
            {
            }
            column(HR_Leave_Application_Supervisor; "Applicant Supervisor")
            {
            }
            column(HR_Leave_Application__Leave_Type_; "Leave Type")
            {
            }
            column(HR_Leave_Application__Days_Applied_; "Days Applied")
            {
            }
            column(HR_Leave_Application__Start_Date_; "Start Date")
            {
            }
            column(HR_Leave_Application__Return_Date_; "Return Date")
            {
            }
            column(HR_Leave_Application_Reliever; Reliever)
            {
            }
            column(CurrentBalance_HRLeaveApplication; "HR Leave Application"."Current Balance")
            {
            }
            column(HR_Leave_Application__Reliever_Name_; "Reliever Name")
            {
            }
            column(HR_Leave_ApplicationCaption; HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(HR_Leave_Application__Application_Code_Caption;UnknownTable52185532.FieldCaption("Application Code"))
            // {
            // }
            // column(HR_Leave_Application__Application_Date_Caption;UnknownTable52185532.FieldCaption("Application Date"))
            // {
            // }
            // column(HR_Leave_Application__Employee_No_Caption;UnknownTable52185532.FieldCaption("Applicant Staff No."))
            // {
            // }
            // column(HR_Leave_Application__Job_Tittle_Caption;UnknownTable52185532.FieldCaption("Job Tittle"))
            // {
            // }
            // column(HR_Leave_Application_SupervisorCaption;UnknownTable52185532.FieldCaption("Applicant Supervisor"))
            // {
            // }
            // column(HR_Leave_Application__Leave_Type_Caption;UnknownTable52185532.FieldCaption("Leave Type"))
            // {
            // }
            // column(HR_Leave_Application__Days_Applied_Caption;UnknownTable52185532.FieldCaption("Days Applied"))
            // {
            // }
            // column(HR_Leave_Application__Start_Date_Caption;UnknownTable52185532.FieldCaption("Start Date"))
            // {
            // }
            // column(HR_Leave_Application__Return_Date_Caption;UnknownTable52185532.FieldCaption("Return Date"))
            // {
            // }
            // column(HR_Leave_Application_RelieverCaption;UnknownTable52185532.FieldCaption(Reliever))
            // {
            // }
            // column(HR_Leave_Application__Reliever_Name_Caption;UnknownTable52185532.FieldCaption("Reliever Name"))
            // {
            // }
            column(Picture; CI.Picture)
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
        CI.Reset;
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        HR_Leave_ApplicationCaptionLbl: label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CI: Record "Company Information";
}
