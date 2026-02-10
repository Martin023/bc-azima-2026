#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185530 "prMonthly Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prMonthly Variance.rdl';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }

            column(PreviousAmount; PreviousAmount)
            {

            }
            column(CurrentAmount; CurrentAmount)
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

            column(Bpay; Bpay)
            {

            }
            column(Variance; Variance)
            {

            }
            column(CurrentPeriod; CurrentPeriod)
            {

            }
            column(PreviousPeriod; PreviousPeriod)
            {

            }
            dataitem("PR Transaction Codes"; "PR Transaction Codes")
            {
                column(Transaction_Code; "Transaction Code")
                {

                }
                column(Transaction_Name; "Transaction Name")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    PreviousAmount := 0;
                    CurrentAmount := 0;
                    Variance := 0;
                    TransactionCode := '';
                    TransactionName := '';

                    PayPeriods.Reset();
                    PayPeriods.SetRange("Employee Code", "HR Employees"."No.");
                    PayPeriods.Setfilter("Payroll Period", '%1|%2', PreviousPeriod, CurrentPeriod);
                    PayPeriods.SetRange("Transaction Code", "PR Transaction Codes"."Transaction Code");
                    if PayPeriods.Find('-') then begin
                        repeat
                            if PayPeriods."Payroll Period" = PreviousPeriod then
                                PreviousAmount := PayPeriods.Amount;
                            if PayPeriods."Payroll Period" = CurrentPeriod then
                                CurrentAmount := PayPeriods.Amount;
                            PrMonthlyVariance.reset;
                            PrMonthlyVariance.SetRange("Trans Code", PayPeriods."Transaction Code");
                            PrMonthlyVariance.SetRange("Current Period", CurrentPeriod);
                            PrMonthlyVariance.SetRange("Previous Period", PreviousPeriod);
                            PrMonthlyVariance.SetRange("Employee code", PayPeriods."Employee Code");
                            if PrMonthlyVariance.find('-') then
                                PrMonthlyVariance.DeleteAll();

                            Clear(PrMonthlyVariance);
                            PrMonthlyVariance.Init;
                            PrMonthlyVariance."Previous Period" := PreviousPeriod;
                            PrMonthlyVariance."Prev Amount" := PreviousAmount;
                            PrMonthlyVariance."Current Period" := CurrentPeriod;
                            PrMonthlyVariance."Curr Amount" := CurrentAmount;
                            PrMonthlyVariance.Variance := Variance;
                            PrMonthlyVariance."Employee code" := PayPeriods."Employee Code";
                            PrMonthlyVariance."Trans Code" := PayPeriods."Transaction Code";
                            PrMonthlyVariance."Trans Name" := PayPeriods."Transaction Name";
                            PrMonthlyVariance.insert(true);

                        until PayPeriods.next = 0;
                    end else
                        CurrReport.skip;

                    Variance := CurrentAmount - PreviousAmount;



                end;

            }
            trigger OnAfterGetRecord()
            begin
                SalInfo.reset();


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
                field(CurrentPeriod; CurrentPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Period';
                    TableRelation = "PR Payroll Periods";
                }
                field(PreviousPeriod; PreviousPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Previous Period';
                    TableRelation = "PR Payroll Periods";

                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        // if (CurrentPeriod = 0D) and (PreviousPeriod = 0D) then Error('You must specify the period filter');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

        PreviousPeriodName: Text[50];
        CurrentPeriodName: Text[50];
        PreviousAmount: decimal;
        PreviousPeriod: date;
        CurrentPeriod: date;
        CurrentAmount: decimal;
        Variance: decimal;
        Bpay: decimal;
        TransactionCode: code[30];
        TransactionName: text[100];


        SalInfo: record "PR Salary Card";
        CI: Record "Company Information";
        //Variance: Record "PrMonthly Variance";
        PayPeriods: Record "PR Employee Transactions";
        CompanyInformation: record "Company Information";
        PrMonthlyVariance: record "PrMonthly Variance";

}
