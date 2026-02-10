namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186216 "Business Loans TAT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Business Loans TAT Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = filter(true), "Source Unit" = filter("BUSINESS LOANS"));
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(CRMApplicationNo; "Loan No.")
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
            column(StatusComment; comments)
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
            column(Application_Time; "Application Time")
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
                SLA.SetRange("Origination Type", SLA."Origination Type"::"BUSINESS LOANS");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (Loans."Disbursement Date" <> 0D) or (Loans."Application Date" <> 0D) or (Loans."Application Time" <> 0T) or (Loans."disbursement time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(Loans."Application Date", Loans."Application Time", Loans."Disbursement Date", Loans."disbursement time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                Comment.reset();
                Comment.SetRange("Loan No.", Loans."Loan No.");
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
        comments: text[400];
        Comment: record "Loan Appraisal Comments";


}