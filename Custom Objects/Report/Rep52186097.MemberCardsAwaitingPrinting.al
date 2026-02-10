namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186097 "Member Cards Awaiting Printing"
{
    ApplicationArea = All;
    Caption = 'Member Cards Awaiting Printing';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Cards Awaiting Printing.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Branch Code", Gender;
            column(MemberNo; "No.") { }
            column(Name; Name) { }
            column(PrimmaryIdentificationType; "Primary Identification Type") { }
            column(PrimaryIdentification; "Primary Identification") { }
            column(Payroll_Staff_No_; "Payroll/Staff No.") { }
            column(Phone_No_; "Phone No.") { }
            column(Age; Age) { }
            column(Branch_Code; "Branch Code") { }
            column(Registration_Date; "Registration Date") { }
            column(FOSAAccNo; FOSAAccNo) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
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
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                FOSAAccNo := '';

                MemberCardLog.Reset;
                MemberCardLog.SETRANGE("Record ID", Members."No.");
                if MemberCardLog.FIND('-') then
                    CurrReport.SKIP;

                if SavingsAccounts.GET(Members."No.") then
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                if SavingsAccounts.FINDFIRST then
                    FOSAAccNo := SavingsAccounts."No.";

            end;

            trigger OnPreDataItem()
            begin
                Members.SetFilter("Registration Date", '%1..%2', StartDate, EndDate);
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
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
        if StartDate = 0D then Error('Kindly set the start date');
        if EndDate = 0D then Error('Kindly set the end date');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'Email: ' + CompanyInformation."E-Mail" + ' -Website: ' + CompanyInformation."Website";
    end;


    var
        MemberCardLog: Record "Member Card Printing Log";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccounts: Record "Savings Accounts";
        FOSAAccNo: Code[200];
        StartDate: Date;
        EndDate: Date;
}
