namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186119 "Member Edit TAT Report"
{
    Caption = 'Member Edit TAT Report';
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Edit TAT Report.rdl';
    dataset
    {
        dataitem("CRM Member Edit"; "CRM Member Edit")
        {
            DataItemTableView = where(Status = filter(Approved));

            column(ApplicationDate_CRMMemberEdit; "Application Date")
            {
            }
            column(ApprovalDate_CRMMemberEdit; "Approval Date")
            {
            }
            column(ApprovedBy_CRMMemberEdit; "Approved By")
            {
            }
            column(CRMCreatedBy_CRMMemberEdit; "CRM Created By")
            {
            }
            column(CRMNo_CRMMemberEdit; "No.")
            {
            }
            column(CRMBranch_CRMMemberEdit; "CRM Branch")
            {
            }
            column(CreatedBy_CRMMemberEdit; "Created By")
            {
            }
            column(Employer_CRMMemberEdit; Employer)
            {
            }
            column(MemberName_CRMMemberEdit; "Member Name")
            {
            }
            column(MemberNo_CRMMemberEdit; "Member No.")
            {
            }
            column(Status_CRMMemberEdit; Status)
            {
            }
            column(TypeofEdit_CRMMemberEdit; "Type of Edit")
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
            column(Application_Time; "Application Time")
            { }
            column(Approval_Time; "Approval Time")
            {

            }
            column(SLADays; SLADays)
            {

            }
            trigger OnAfterGetRecord()
            var
                SLA: record "Defined SLA";
                Globalfunctions: Codeunit "Global Functions";
            begin
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Edit");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if ("CRM Member Edit"."Approval Date" <> 0D) and ("CRM Member Edit"."Application Date" <> 0D) and ("CRM Member Edit"."Application Time" <> 0T) and ("CRM Member Edit"."Approval Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods("CRM Member Edit"."Application Date", "CRM Member Edit"."Application Time", "CRM Member Edit"."Approval Date", "CRM Member Edit"."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                Comment.reset();
                Comment.SetRange("Header No.", "CRM Member Edit"."No.");
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
        Comments: text[400];
        Comment: record Comments;


}
