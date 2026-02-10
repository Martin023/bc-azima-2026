namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186125 "Detailed Loan TAT Report"
{
    ApplicationArea = All;
    Caption = 'Detailed Loan TAT Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Detailed Loan TAT Report.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = filter(true));
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(CRMApplicationNo; "CRM Application No.")
            {
            }
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(Status; Status)
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApprovalDate; "Approval Date")
            {
            }
            column(CRMCreatedBy; "CRM Created By")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(EmployerCode; "Employer Code")
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
            column(StatusComment; StatusComment)
            {

            }
            column(ActionDate; Loans."Disbursement Date")
            {

            }
            column(WorkDays; WorkDays)
            {

            }
            column(disbursement_time; "disbursement time")
            {

            }
            column(Disbursement_Date; "Disbursement Date")
            {

            }
            column(ApplicationTime; "Application Time")
            {

            }
            column(Approval_Time; "Approval Time")
            {

            }
            column(workDays1; workDays1)
            {

            }
            COLUMN(WorkDays2; WorkDays2)
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
                SLA.SetRange("Origination Type", SLA."Origination Type"::Loans);
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (Loans."Disbursement Date" <> 0D) and (Loans."Application Date" <> 0D) and (Loans."Application Time" <> 0T) and (Loans."disbursement time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(Loans."Application Date", Loans."Application Time", Loans."Disbursement Date", Loans."disbursement time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                if (Loans."Approval Date" <> 0D) and (Loans."Application Date" <> 0D) and (Loans."Application Time" <> 0T) and (Loans."Approval Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(Loans."Application Date", Loans."Application Time", Loans."Approval Date", Loans."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays1 := Duration;
                    DelayDays := WorkDays1 - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                if (Loans."Approval Date" <> 0D) and (Loans."Disbursement Date" <> 0D) and (Loans."Approval Time" <> 0T) and (Loans."Disbursement Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(Loans."Approval Date", Loans."Approval Time", Loans."Disbursement Date", Loans."Disbursement Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays2 := Duration;
                    DelayDays := WorkDays2 - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
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
        workDays1: duration;
        WorkDays2: Duration;



}
