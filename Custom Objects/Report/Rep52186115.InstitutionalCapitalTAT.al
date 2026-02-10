namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186115 "Institutional Capital TAT"
{
    ApplicationArea = All;
    Caption = 'Institutional Capital TAT';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Institutional Capital TAT Report.rdl';

    dataset
    {
        dataitem(ShareCapitalTransferBuffer; "Share Capital Transfer Buffer")
        {
            DataItemTableView = where(Posted = Filter(True));
            column(Source_Member_No; "Source Member No")
            {

            }
            column(Source_Member_Name; "Source Member Name")
            {

            }

            column(Application_Date; "Application Date")
            {

            }
            column(CRM_Application_No_; "Document No")
            {

            }
            column(CRM_Originating_Branch; "CRM Originating Branch")
            {

            }
            column(CRM_Created_By; "CRM Created By")
            {

            }
            column(Destination_Employer_Code; "Destination Employer Code")
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
            column(Status; Status)
            {

            }
            COLUMN(PostingDate; "Posting Date")
            {

            }
            column(ApprovedBy; "Approved By")
            {

            }
            column(Application_Time; "Application Time")
            {

            }
            column(PostingTime; "Posting Time")
            {

            }
            column(SLADays; SLADays)
            {

            }
            dataitem("Share Capital Transfer Lines"; "Share Capital Transfer Lines")
            {
                DataItemLink = "Document No." = field("Document No");
                column(Destination_Member_No_; "Destination Member No")
                {

                }
                column(Destination_Member_Name; "Destination Member Name")
                {

                }

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
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Institutional Capital");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (ShareCapitalTransferBuffer."Posting Date" <> 0D) or (ShareCapitalTransferBuffer."Application Date" <> 0D) or (ShareCapitalTransferBuffer."Application Time" <> 0T) or (ShareCapitalTransferBuffer."Posting Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(ShareCapitalTransferBuffer."Application Date", ShareCapitalTransferBuffer."Application Time", ShareCapitalTransferBuffer."Posting Date", ShareCapitalTransferBuffer."Posting Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Members.get(ShareCapitalTransferBuffer."Source Member No") then
                    EmployerCode := Members."Employer Code";
                Comment.reset();
                Comment.SetRange("Header No.", ShareCapitalTransferBuffer."Document No");
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
        Comment: Record Comments;
        comments: text[200];
}
