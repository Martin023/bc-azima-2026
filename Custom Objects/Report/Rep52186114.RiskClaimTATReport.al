namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186114 "Risk Claim TAT Report"
{
    ApplicationArea = All;

    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Risk Claim TAT Report.rdl';
    dataset
    {
        dataitem(SinkfundReportInformation; "Sinkfund Report Information")
        {
            DataItemTableView = where("Claim Type" = filter("Risk Claim"));
            column(CRMApplicationNo; No)
            {
            }
            column(CRMCreatedBy; "CRM Created By")
            {
            }
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Approved_By; "Approved By")
            {

            }
            column(Date; "Date")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(OriginatingDepartment; "Originating Department")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(Status; Status)
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
            column(Priority; Priority)
            {

            }
            column(TAtStatus; TAtStatus)
            {

            }
            column(DelayDays; DelayDays)
            {

            }
            column(StatusComment; comments)
            {

            }

            column(WorkDays; WorkDays)
            {

            }
            column(EmployerCode; EmployerCode)
            {

            }
            column(Application_Time; "Application Time")
            {

            }
            column(Time_Posted; "Time Posted")
            {

            }
            column(SLADays; SLADays)
            {

            }

            trigger OnAfterGetRecord()
            var
                SLA: record "Defined SLA";
                Globalfunctions: Codeunit "Global Functions";
                Members: record Members;
            begin
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Risk Claim");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (SinkfundReportInformation."Date Posted" <> 0D) or (SinkfundReportInformation.Date <> 0D) or (SinkfundReportInformation."Application Time" <> 0T) or (SinkfundReportInformation."Time Posted" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(SinkfundReportInformation.Date, SinkfundReportInformation."Application Time", SinkfundReportInformation."Date Posted", SinkfundReportInformation."Time Posted", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Members.get(SinkfundReportInformation."Member No") then
                    EmployerCode := Members."Employer Code";
                Comment.reset();
                Comment.SetRange("Header No.", SinkfundReportInformation.No);
                If Comment.FindLast() then begin
                    comments := Comment.Comment;
                end;



            end;

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    Var
        DelayDays: duration;
        StatusComment: text[100];
        TAtStatus: Option open,closed;
        WorkDays: duration;
        ActionDate: date;
        Priority: Option Urgent,High,Normal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SLADays: duration;
        Duration: duration;
        WokedOnANonWorkingPeriod: Boolean;
        EmployerCode: code[50];
        Comment: record Comments;
        comments: text[300];

}
