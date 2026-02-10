report 52186102 "Loans TAT Report"
{
    ApplicationArea = All;
    Caption = 'Loans TAT Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loans TAT Report.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Disbursement Date", "Loan No.";

            column(Loan_No_; "Loan No.")
            {

            }
            column(Application_Date; "Application Date")
            {

            }
            column(Application_Time; "Application Time")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Installment_Period; "Installment Period")
            {

            }
            column(Interest; Interest)
            {

            }

            column(TimeVariance; TimeVariance)
            {
            }
            column(WokedOnANonWorkingPeriod; WokedOnANonWorkingPeriod)
            {

            }
            column(Disbursement_Date; "Disbursement Date")
            {
            }
            column(CRM_Priority; "CRM Priority")
            {

            }
            column(disbursement_time; "disbursement time")
            {

            }
            column(Duration; Duration)
            {

            }
            column(SLADuration; SLADuration)
            {

            }
            column(comments; comments)
            {

            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                SLADuration := 0;
                Duration := 0;
                TimeVariance := 0;

                //SLA
                Loanproduct.Reset();
                Loanproduct.SetRange(Loanproduct."Product ID", "Loan Product Type");
                if Loanproduct.FindFirst() then begin
                    SLADuration := Loanproduct."Product SLA";
                end;
                //TAT
                begin
                    Globalfunctions.HoursBetweenPeriods("Application Date", "Application Time", "Disbursement Date", "disbursement time", Duration, WokedOnANonWorkingPeriod);
                    //Vatiance
                    TimeVariance := SLADuration - Duration;
                end;
                StatusComment.reset();
                StatusComment.SetRange("Loan No.", Loans."Loan No.");
                If StatusComment.FindLast() then begin
                    comments := StatusComment.Comment;
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Globalfunctions: Codeunit "Global Functions";
        Duration: duration;

        WokedOnANonWorkingPeriod: Boolean;
        SLA: Record "Defined SLA";

        SLADuration: Duration;

        TimeVariance: Duration;
        Loanproduct: Record "Product Factory";
        comments: text[400];
        StatusComment: record "Loan Appraisal Comments";


}
