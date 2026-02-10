#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185528 "prPayroll Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prPayroll Details.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Position, "Department Code", Office;
            column(ReportForNavId_7769; 7769)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Employee_No; "HR Employees"."No.")
            {
            }
            column(Employee_Name; EmployeeName)
            {
            }
            column(Basic_Salary; BasicSalary)
            {
            }
            column(Allowances; Allowances)
            {
            }
            column(Gross_Salary; GrossSalary)
            {
            }
            column(Employee_SSF; EmployeeSSF)
            {
            }
            column(Provident_Fund; ProvidentFund)
            {
            }
            column(Taxable_Pay; TaxablePay)
            {
            }
            column(Income_Tax; IncomeTax)
            {
            }
            column(Deductions; Deductions)
            {
            }
            column(Net_Salary; NetSalary)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmployeeName := ' ';

                BasicSalary := 0;
                Allowances := 0;
                GrossSalary := 0;
                EmployeeSSF := 0;
                ProvidentFund := 0;
                TaxablePay := 0;
                IncomeTax := 0;
                Deductions := 0;
                NetSalary := 0;

                EmployeeName := "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name" + ' ' + "HR Employees"."Last Name";

                //Basic Salary
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'BPAY');
                if PeriodTrans.Find('-') then begin
                    BasicSalary := PeriodTrans.Amount;
                end;

                //Allowances
                TransCodes.Reset();
                TransCodes.SetRange("Transaction Type", TransCodes."Transaction Type"::Income);
                if TransCodes.Find('-') then begin
                    repeat
                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCodes."Transaction Code");
                        IF PeriodTrans.Find('-') THEN BEGIN
                            Allowances := PeriodTrans.Amount;
                        end;
                    until TransCodes.Next() = 0;
                end;


                // PeriodTrans.Reset;
                // PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                // PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                // PeriodTrans.SetRange(PeriodTrans."Group Text", 'ALLOWANCE');
                // if PeriodTrans.Find('-') then begin
                //     repeat
                //         Allowances := Allowances + PeriodTrans.Amount;
                //     until PeriodTrans.Next = 0;
                // end;

                //Gross Salary
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'GPAY');
                if PeriodTrans.Find('-') then begin
                    GrossSalary := PeriodTrans.Amount;
                end;

                //Employee SSF
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NSSF');
                if PeriodTrans.Find('-') then begin
                    EmployeeSSF := PeriodTrans.Amount;
                end;

                //Provident Fund
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'PF');
                if PeriodTrans.Find('-') then begin
                    ProvidentFund := PeriodTrans.Amount;
                end;

                //Taxable Pay
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'TXBP');
                if PeriodTrans.Find('-') then begin
                    TaxablePay := PeriodTrans.Amount;
                end;

                //Income Tax
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'PAYE');
                if PeriodTrans.Find('-') then begin
                    IncomeTax := PeriodTrans.Amount;
                end;

                //Deductions
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Text", 'DEDUCTIONS');
                if PeriodTrans.Find('-') then begin
                    repeat
                        if PeriodTrans."Transaction Code" <> 'TOT-DED' then
                            Deductions := Deductions + PeriodTrans.Amount;
                    until PeriodTrans.Next = 0;
                end;

                //Net Salary
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NPAY');
                if PeriodTrans.Find('-') then begin
                    NetSalary := PeriodTrans.Amount;
                end;



                if NetSalary <= 0 then
                    CurrReport.Skip;
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
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Selected Period';
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
        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CI.Get() then
            CI.CalcFields(CI.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        PeriodTrans: Record "PR Period Transactions";
        TransCodes: Record "prTransaction Codes";
        GroupOrder: label '3';
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
        Allowances_ReportCaptionLbl: label 'Allowances Report';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        EmployeeName: Text[100];
        CI: Record "Company Information";
        BasicSalary: Decimal;
        Allowances: Decimal;
        GrossSalary: Decimal;
        EmployeeSSF: Decimal;
        ProvidentFund: Decimal;
        TaxablePay: Decimal;
        IncomeTax: Decimal;
        Deductions: Decimal;
        NetSalary: Decimal;
}
