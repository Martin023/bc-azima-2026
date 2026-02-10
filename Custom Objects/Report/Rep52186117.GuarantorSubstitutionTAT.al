namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186117 "Guarantor Substitution TAT"
{
    ApplicationArea = All;
    Caption = 'Guarantor Substitution TAT';
    RDLCLayout = './bc-kenpipe-2024/Layout/Guarantor Substitution TAT Report.rdl';

    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(GuarantorsSubstitution; "Guarantors Substitution")
        {
            DataItemTableView = where(posted = filter(true));
            column(ApprovalDate; "Approval Date")
            {
            }
            column(ApprovedDate; "Approved Date")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(CRMApplicationNo; "No.")
            {
            }
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(Date; "Date")
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
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(RejectedBy; "Rejected By")
            {
            }
            column(Status; Status)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(CRMCreatedBy; "CRM Created By")
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
            column(LoanName; LoanName)
            {

            }
            column(AppLication_Time; "AppLication Time")
            {

            }
            column(Approval_Time; "Approval Time")
            {

            }
            trigger OnAfterGetRecord()
            var
                SLA: record "Defined SLA";
                Globalfunctions: Codeunit "Global Functions";
                Member: record Members;
                Loan: record Loans;
            begin
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                LoanName := '';
                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Guarantor Substitution");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (GuarantorsSubstitution."Approval Date" <> 0D) or (GuarantorsSubstitution.Date <> 0D) or (GuarantorsSubstitution."Application Time" <> 0T) or (GuarantorsSubstitution."Approval time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(GuarantorsSubstitution.Date, GuarantorsSubstitution."Application Time", GuarantorsSubstitution."Approval Date", GuarantorsSubstitution."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(GuarantorsSubstitution."Member No.") then
                    EmployerCode := Member."Employer Code";
                if Loan.get(GuarantorsSubstitution."Loan No.") then
                    LoanName := Loan."Loan Product Type Name";

                Comment.reset();
                Comment.SetRange("Header No.", GuarantorsSubstitution."No.");
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
        EmployerCode: code[60];
        LoanName: text[100];
        comments: text[250];
        Comment: record Comments;


}