namespace mns.mns;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 52186175 "Deposit Fall Off"
{
    ApplicationArea = All;
    Caption = 'BOSA Savings Fall Off';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Deposit Fall-Off.rdl';
    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "Employer Code", "Product Category", "Date Filter";
            DataItemTableView = where("Product Category" = Filter("BOSA Deposits" | Risk | "Benevolent (BBF)"), "Member Status" = filter(<> Deceased), "Member Sub Status" = filter(<> Withdrawal));

            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(Name; Name)
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
            column(Product_Name; "Product Name")
            {

            }
            column(Product_Category; "Product Category")
            {

            }
            column(Product_Type; "Product Type")
            {

            }

            column(Status; Status)
            {
            }
            column(Member_No_; "Member No.")
            {

            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {

            }
            column(ID_No_; "ID No.")
            {

            }
            column(Amount; Amount)
            {

            }
            column(ExpectedAmount; ExpectedAmount)
            {

            }
            column(Member_Status; "Member Status")
            {

            }
            column(Member_Sub_Status; "Member Sub Status")
            {

            }
            COLUMN(PostingDate; PostingDate)
            {


            }
            column(Date_Filter; "Date Filter")
            {

            }
            column(Balance__LCY_; "Balance (LCY)")
            {

            }
            column(Credit_Amount__LCY_; "Credit Amount (LCY)")
            {


            }
            COLUMN(Monthly_Contribution; "Monthly Contribution")
            {

            }
            COLUMN(LastTransactionDate; LastTransactionDate)
            {

            }
            column(EmployerName; EmployerName)
            {

            }
            column(GetfiltersR; GetfiltersR) { }
            column(Balance; Balance) { }
            column(BBFArrears; BBFArrears) { }
            column(Arrears; Arrears) { }
            column(SavingArrears; SavingArrears) { }

            trigger OnAfterGetRecord()
            var
                Customer: record Customer;
            begin
                Amount := 0;
                ExpectedAmount := 0;
                PostingDate := 0D;
                Prorata := 0;
                EmployerName := '';
                Balance := 0;
                BBFArrears := 0;
                Arrears := 0;
                SavingArrears := 0;
                Range := 0;
                Range1 := 0;

                "Savings Accounts".SetFilter("Date Filter", '..' + Format(Today));
                "Savings Accounts".CalcFields("Balance (LCY)", "Last Transaction Date");
                Balance := "Savings Accounts"."Balance (LCY)";
                LastTransactionDate := "Savings Accounts"."Last Transaction Date";
                Member.get("Savings Accounts"."Member No.");
                Range1 := Today - CalcDate('-CY', Today);
                Evaluate(PeriodRange, ('<' + Format(Range1) + 'D>'));
                if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::Risk then
                    Arrears := RegnProcess.CalculateSavingArrears("Savings Accounts"."Member No.", '5', PeriodRange, Today);
                if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Benevolent (BBF)" then
                    Arrears := RegnProcess.CalculateSavingArrears("Savings Accounts"."Member No.", '4', PeriodRange, Today);

                "Savings Accounts".SetFilter("Date Filter", format(startDate) + '..' + Format(Enddate));
                "Savings Accounts".CalcFields("Credit Amount (LCY)");
                Amount := "Savings Accounts"."Credit Amount (LCY)";
                Range := Enddate - startDate;
                Evaluate(SavingsRange, ('<' + Format(Range) + 'D>'));

                if Amount <> 0 then CurrReport.Skip();

                ExpectedAmount := "Savings Accounts"."Monthly Contribution";
                if Customer.get("Savings Accounts"."Employer Code") then EmployerName := Customer.Name;

                if Member.get("Savings Accounts"."Member No.") then begin
                    if Member.Status <> Member.Status::Deceased then begin
                        if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"BOSA Deposits" then begin
                            Prorata := CustomCues.Prorata(Member."No.", '1');
                            if Prorata > "Savings Accounts"."Monthly Contribution" then
                                ExpectedAmount := Prorata;
                            Arrears := RegnProcess.CalculateSavingArrears("Savings Accounts"."Member No.", '1', SavingsRange, Enddate);
                        end else if ("Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::Risk) or ("Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Benevolent (BBF)") then begin
                            if ProductFactory.get("Savings Accounts"."Product Type") THEN BEGIN
                                MonthlyLogs.reset();
                                MonthlyLogs.SetRange("Product ID", ProductFactory."Product ID");
                                //MonthlyLogs.SetRange("Effective Date", Enddate);
                                if MonthlyLogs.Find('-') then
                                    repeat
                                        if Enddate in [MonthlyLogs."Effective Date" .. MonthlyLogs."End Date"] then
                                            ExpectedAmount := MonthlyLogs."Monthly Contribution";
                                    until MonthlyLogs.Next = 0;
                            end;
                        end;
                    end;
                    GetfiltersR := "Savings Accounts".getfilters();



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

                group("Date Filter")
                {

                    field(startDate; startDate)
                    {

                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(Enddate; Enddate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                }

            }

        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if (startDate = 0D) and (Enddate = 0D) then Error('You must specify the period filter');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

    end;

    var

        Member: record Members;
        SelectedPeriod: date;
        CheckoffLines: record "Checkoff Lines";
        Amount: decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CheckoffHeader: record "Checkoff Header";
        ProductFactory: record "Product Factory";
        ExpectedAmount: decimal;
        PostingDate: date;
        MonthlyLogs: record "Monthly Contrib Logs";
        startDate: date;
        Enddate: date;
        SavingsAccount: record "Savings Accounts";
        customCues: Codeunit CustomCuesCodeunit;
        Prorata: decimal;
        LastTransactionDate: date;
        Range1: integer;

        EmployerName: text;
        GetfiltersR: Text;
        Balance: decimal;
        Arrears: decimal;
        BBFArrears: decimal;
        SavingArrears: decimal;
        RegnProcess: Codeunit "Registration Process";
        PeriodRange: DateFormula;
        Range: integer;
        SavingsRange: DateFormula;




}
