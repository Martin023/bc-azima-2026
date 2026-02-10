namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186108 " Loan Variation TAT"
{
    ApplicationArea = All;
    Caption = ' Loan Variation TAT';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Variation TAT Report.rdl';


    dataset
    {
        dataitem(ProductVariations; "Product Variations")
        {
            DataItemTableView = where("Variation Type" = filter(Loan));
            column(Variation_Type; "Variation Type")
            {

            }
            column(No_; "No.")
            {

            }
            column(CRM_Application_No_; "No.")
            {

            }
            column(CRM_Originating_Branch; "CRM Originating Branch")
            {

            }
            column(CRM_Created_By; "CRM Created By")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Product_Type; "Product Type")
            {

            }
            column(Product_Name; "Product Name")
            {

            }
            column(Application_Date; "Application Date")
            {

            }
            column(ActionDate; "Posting Date")
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
            column(Approved_By; "Approved By")
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
            column(Employer_Code; "Employer Code")
            {

            }
            column(Status; Status)
            {

            }
            column(Application_Time; VariationTime)
            {

            }
            column(PostingTime; "Posting Time")
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
                VariationTime := system.DT2Time(ProductVariations."Application Time");
                SLA.Reset();
                SLA.setrange("Origination Type", SLA."Origination Type"::"Loan Variation");
                If SLA.FindFirst() then begin
                    SLADays := SLA.SLA;
                    If (ProductVariations."Application Date" <> 0D) and (VariationTime <> 0T) and (ProductVariations."Posting Date" <> 0D) and (ProductVariations."Posting Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(ProductVariations."Application Date", VariationTime, ProductVariations."Posting Date", ProductVariations."Posting Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - SLADays;
                        IF DelayDays < 0 then DelayDays := 0;
                    end;


                end;
                Comment.reset();
                Comment.SetRange("Loan No.", ProductVariations."No.");
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
        ApplicationTime1: Time;
        VariationTime: Time;
        Comment: Record "Loan Appraisal Comments";
        comments: text[200];



}
