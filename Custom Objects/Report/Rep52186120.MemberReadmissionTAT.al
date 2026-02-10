namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186220 "Member Readmission TAT"
{
    ApplicationArea = All;
    Caption = 'Member Readmission TAT';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Readmission TAT Report.rdl';
    dataset
    {
        dataitem(Memberapplication; "Member application")
        {
            DataItemTableView = where("Type of Application" = filter(Readmission), Status = filter(Approved));
            column(CRMApplicationNo; "No.")
            {
            }
            column(CRMCreatedBy; "CRM Created By")
            {
            }
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApplicationTime; "Application Time")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(DateApproved; "Date Approved")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Status; Status)
            {
            }
            column(TypeofApplication; "Type of Application")
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
            column(StatusComment; Comments)
            {

            }

            column(WorkDays; WorkDays)
            {

            }
            column(Date_Approved; "Date Approved")
            {

            }
            column(Approved_By; "Approved By")
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(Application_Time; "Application Time")
            {

            }
            column(Approval_Time; "Approval Time")
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
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Readmission");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (Memberapplication."Date Approved" <> 0D) or (Memberapplication."Application Date" <> 0D) or (Memberapplication."Application Time" <> 0T) or (Memberapplication."Approval Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(Memberapplication."Application Date", Memberapplication."Application Time", Memberapplication."Date Approved", Memberapplication."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                Comment.reset();
                Comment.SetRange("Header No.", Memberapplication."No.");
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
