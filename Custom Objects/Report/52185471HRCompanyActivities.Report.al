#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185471 "HR Company Activities"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Company Activities.rdl';

    dataset
    {
        dataitem("HR Company Activities"; "HR Company Activities")
        {
            RequestFilterFields = "Code", "Employee Responsible";
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
            column(ActivityStatus_HRCompanyActivities; "HR Company Activities"."Activity Status")
            {
            }
            column(Code_HRCompanyActivities; "HR Company Activities".Code)
            {
            }
            column(AcitivityDescription_HRCompanyActivities; "HR Company Activities"."Acitivity Description")
            {
            }
            column(Jobs; Jobs)
            {

            }
            column(Costs; Costs)
            {

            }
            column(Date_HRCompanyActivities; "HR Company Activities".Date)
            {
            }
            column(Venue_HRCompanyActivities; "HR Company Activities".Venue)
            {
            }
            dataitem("HR Activity Participants"; "HR Activity Participants")
            {
                DataItemLink = "Document No." = field(Code);
                column(ReportForNavId_5; 5)
                {
                }
                column(Participant_HRActivityParticipants; "HR Activity Participants".Participant)
                {
                }
                column(Notified_HRActivityParticipants; "HR Activity Participants".Notified)
                {
                }
                column(Contribution_HRActivityParticipants; "HR Activity Participants".Contribution)
                {
                }
                column(ParticipantName_HRActivityParticipants; "HR Activity Participants"."Participant Name")
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
