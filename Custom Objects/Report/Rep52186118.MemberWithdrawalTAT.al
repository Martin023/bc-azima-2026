namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186118 "Member Withdrawal TAT"
{
    ApplicationArea = All;
    Caption = 'Member Withdrawal TAT';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Withdrawal TAT Report.rdl';

    dataset
    {
        dataitem(MemberWithdrawalNotice; "Member Withdrawal Notice")
        {
            DataItemTableView = where(Status = filter(Approved));
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(CRMCreatedBy; "CRM Created By")
            {
            }
            column(CRMApplicationNo; "CRM Application No.")
            {
            }
            column(Employer; Employer)
            {
            }
            column(Finalized_By; "Finalized By")
            {

            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(TimeEntered; "Time Entered")
            {
            }
            column(withdrawaltime; "withdrawal time")
            {
            }
            column(WithdrawalNoticeDate; "Withdrawal Notice Date")
            {
            }
            column(DateTimeFinalized; "DateTime Finalized")
            {
            }
            column(DateEntered; "Date Entered")
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
            column(Entered_By; "Entered By")
            {

            }
            column(Maturity_Date; "Maturity Date")
            {

            }
            column(maturity_time; "maturity time")
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
            column(Time_Entered; "Time Entered")
            {

            }
            column(SLADays; SLADays)
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
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Membership Withdrawal");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (MemberWithdrawalNotice."Maturity Date" <> 0D) and (MemberWithdrawalNotice."Date Entered" <> 0D) and (MemberWithdrawalNotice."Time Entered" <> 0T) and (MemberWithdrawalNotice."Maturity time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(MemberWithdrawalNotice."Date Entered", MemberWithdrawalNotice."Time Entered", MemberWithdrawalNotice."Maturity Date", MemberWithdrawalNotice."Maturity Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - SLADays;
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(MemberWithdrawalNotice."Member No.") then
                    EmployerCode := Member."Employer Code";
                // if Loan.get(GuarantorsSubstitution."Loan No.") then
                //     LoanName := Loan."Loan Product Type Name";
                Closure.Reset();
                Closure.SetRange("Notice Number", MemberWithdrawalNotice."No.");
                if Closure.FindFirst() then begin
                    Comment.reset();
                    Comment.SetFILTER("Header No.", '%1|%2', MemberWithdrawalNotice."No.", Closure."Notice Number");
                    If Comment.FindLast() then begin
                        comments := Comment.Comment;
                    end;

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
        Comments: text[400];
        Comment: record Comments;
        Closure: record "Membership Closure";


}