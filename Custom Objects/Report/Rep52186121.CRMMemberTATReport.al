namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186121 "CRM Member TAT Report "
{
    Caption = 'CRM Member TAT Report ';
    RDLCLayout = './bc-kenpipe-2024/Layout/ CRM Member TAT Report.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Account Type" = filter("Single Member Account"), Status = filter(<> Open));

            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(CRMApplicationNo; "CRM Application No.")
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
            dataitem("Member Application"; "Member Application")
            {

                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where(Status = filter(Approved));
                column(Application_Date; "Application Date")
                {

                }
                column(Application_Time; "Application Time")
                {

                }
                column(Date_Approved; "Date Approved")
                {

                }
                column(Approval_Time; "Approval Time")
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
                column(CRM_Application_No_; "CRM Application No.")
                {

                }
                column(CRM_Created_By; "CRM Created By")
                {

                }
                column(CRM_Originating_Branch; "CRM Originating Branch")
                {

                }
                column(Employer_Code; "Employer Code")
                {

                }


                trigger OnAfterGetRecord()
                var
                    SLA: record "Defined SLA";
                    Globalfunctions: Codeunit "Global Functions";
                    Comment: record Comments;
                    MemberApplication: record "Member Application";
                begin
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"New Registration");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if ("Member Application"."Date Approved" <> 0D) and ("Member Application"."Application Date" <> 0D) and ("Member Application"."Application Time" <> 0T) and ("Member Application"."Approval Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods("Member Application"."Application Date", "Member Application"."Application Time", "Member Application"."Date Approved", "Member Application"."Approval Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - SLADays;
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", "Member Application"."No.");
                    If Comment.FindLast() then begin
                        comments := Comment.Comment;
                    end;

                end;

            }
            column(SLADays; SLADays)
            {

            }


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
        comments: text[300];


}
