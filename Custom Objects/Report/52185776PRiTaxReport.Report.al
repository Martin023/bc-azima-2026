#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185776 "PR iTax Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PR iTax Report.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "No.", "Posting Group";
            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeType_HREmployees; "HR Employees"."Employee Type")
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(PINNo_HREmployees; "HR Employees"."PIN No.")
            {
            }
            column(BPAY; BPAY)
            {
            }
            column(Residentialstatus_HREmployees; "HR Employees"."Residential status")
            {
            }
            column(TypeofEmployee_HREmployees; "HR Employees"."Type of Employee")
            {
            }
            column(HouseAllowance; HouseAllowance)
            {
            }
            column(TransportAllowance; TransportAllowance)
            {
            }
            column(LeaveAllowance; LeaveAllowance)
            {
            }
            column(DirectorsFee; DirectorsFee)
            {
            }
            column(OvertimeAllowance; OvertimeAllowance)
            {
            }
            column(Lumpsum; Lumpsum)
            {
            }
            column(OtherAllowances; OtherAllowances)
            {
            }
            column(TotalCashPay; TotalCashPay)
            {
            }
            column(ValueOfCar; ValueOfCar)
            {
            }
            column(OtherNonCash; OtherNonCash)
            {
            }
            column(TotalNonCash; TotalNonCash)
            {
            }
            column(GlobalIncome; GlobalIncome)
            {
            }
            column(GlobalIncome2; GlobalIncome2)
            {
            }
            column(TypeOfHousing; TypeOfHousing)
            {
            }
            column(RentOfHouse; RentOfHouse)
            {
            }
            column(ComputedRent; ComputedRent)
            {
            }
            column(RentRecovered; RentRecovered)
            {
            }
            column(NetValue; NetValue)
            {
            }
            column(TotalGross; TotalGross)
            {
            }
            column(ThirtyPCash; ThirtyPCash)
            {
            }
            column(ActualContr; ActualContr)
            {
            }
            column(PermissibleLimit; PermissibleLimit)
            {
            }
            column(MortgageIntrest; MortgageIntrest)
            {
            }
            column(HOSP; HOSP)
            {
            }
            column(AmountOfBenefit; AmountOfBenefit)
            {
            }
            column(TaxablePay; TaxablePay)
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
            column(TaxPayable; TaxPayable)
            {
            }
            column(MonthlyRelief; MonthlyRelief)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(TotBPay; TotBPay)
            {
            }
            column(ActCont; ActCont)
            {
            }
            column(TotPension; TotPension) { }

            trigger OnAfterGetRecord()
            begin
                //Init
                //    OnViewCurrRec();
                BPAY := 0;
                HouseAllowance := 0;
                TransportAllowance := 0;
                OvertimeAllowance := 0;
                DirectorsFee := 0;
                LeaveAllowance := 0;
                OvertimeAllowance := 0;
                Lumpsum := 0;
                OtherAllowances := 0;
                TotalCashPay := 0;
                ValueOfCar := 0;
                OtherNonCash := 0;
                TotalNonCash := 0;
                GlobalIncome := 0;
                ComputedRent := 0;
                RentRecovered := 0;
                NetValue := 0;
                TotalGross := 0;
                ThirtyPCash := 0;
                ActualContr := 0;
                PermissibleLimit := 0;
                MortgageIntrest := 0;
                AmountOfBenefit := 0;
                TaxablePay := 0;
                TaxPayable := 0;
                MonthlyRelief := 0;
                InsuranceRelief := 0;
                PAYE := 0;
                ActCont := 0;
                TotBPay := 0;
                GlobalIncome2 := 0;
                Pension := 0;
                TotPension := 0;
                TypeOfHousing := 'Benefit not given';



                //Actual contribution------------
                transCode.Reset;
                transCode.SetRange(transCode."Transaction Code", 'D03');
                if transCode.Find('-') then
                    repeat
                        PeriodTran1.Reset;
                        PeriodTran1.SetRange(PeriodTran1."Employee Code", "HR Employees"."No.");
                        PeriodTran1.SetRange(PeriodTran1."Transaction Code", transCode."Transaction Code");
                        PeriodTran1.SetRange(PeriodTran1."Payroll Period", "Period Filter");
                        PeriodTran1.SetRange(PeriodTran1."Payroll Code", "Payroll Code");
                        if PeriodTran1.Find('-') then begin
                            ActCont := ActCont + PeriodTran1.Amount;
                        end;
                    until transCode.Next = 0;







                //Basic Pay
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'BPAY', 'E21');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    BPAY := PRPeriodTrans.Amount;
                end;

                //House Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'E008', 'E12');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    HouseAllowance := PRPeriodTrans.Amount;
                end;

                //Transport Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'E013', 'E13');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    TransportAllowance := PRPeriodTrans.Amount;
                end;

                //Leave Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'E011', 'E10ARR');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    LeaveAllowance := PRPeriodTrans.Amount;
                end;

                //Overtime Allowance
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E005');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    OvertimeAllowance := PRPeriodTrans.Amount;
                end;

                //Directors Fee


                //Lumpsum
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E14');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Lumpsum := PRPeriodTrans.Amount;
                end;



                // //Other Allowances 1
                // fn_PeriodTrans;
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9'
                //               , 'E03', 'E03-ARREARS', 'E04', 'E04ARR', 'E05', 'E18', 'E06', 'E22', 'E08');
                // if PRPeriodTrans.Find('-') then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances := PRPeriodTrans.Amount;
                // end;

                //Other Allowances 2
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9'
                              , 'E030', 'E032', 'E001', 'E004', 'E007', 'E026', 'E028', 'E033', 'E035');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    OtherAllowances += PRPeriodTrans.Amount;
                end;

                // //Other Allowances 3
                // fn_PeriodTrans;
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6'
                //               , 'E26', 'E27', 'E28', 'E15', 'E16', 'E20');
                // if PRPeriodTrans.Find('-') then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances += PRPeriodTrans.Amount;
                // end;

                //Other Non Cash
                // PRTransCodes.Reset;
                // //PRTransCodes.SETRANGE(PRTransCodes."Transaction Type",PRTransCodes."Transaction Type"::Benefit);
                // if PRTransCodes.Find('-') then begin
                //     repeat
                //         fn_PeriodTrans;
                //         PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes."Transaction Code");
                //         if PRPeriodTrans.Find('-') then begin
                //             OtherNonCash += PRPeriodTrans.Amount;
                //         end;
                //     until PRTransCodes.Next = 0;
                // end;

                //Total Cash Pay
                TotalCashPay := BPAY + HouseAllowance + TransportAllowance + OvertimeAllowance
                              + DirectorsFee + LeaveAllowance + Lumpsum + OtherAllowances + OtherNonCash;


                //Value of Car


                //Total Non Cash
                TotalNonCash := OtherNonCash + ValueOfCar;

                //Globa Income
                GlobalIncome := TotalNonCash + TotalCashPay;

                //Type of Housing

                //Rent of House

                //Computed Rent

                //Rent Recovered

                //Net Value

                //Total Gross
                TotalGross := GlobalIncome;

                //30% of Cash
                ThirtyPCash := 0.3 * GlobalIncome;

                //Actual Contribution - Include Voluntary Pension & Voluntary NSSF & NSSF
                //PRTransCodes.Reset;
                //PRTransCodes.SETFILTER(PRTransCodes."Special Trans Deductions",'%1|%2'
                //,(PRTransCodes."Special Trans Deductions"::"Defined Contribution")
                //  ,(PRTransCodes."Special Trans Deductions"::"Voluntary Pension"));
                //if PRTransCodes.Find('-') then begin
                //repeat
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'D048', 'D078');
                if PRPeriodTrans.Find('-') then begin
                    Pension += PRPeriodTrans.Amount;
                end;
                //until PRTransCodes.Next = 0;
                //end;
                //Add NSSF too
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSF');
                if PRPeriodTrans.Find('-') then begin
                    ActualContr += PRPeriodTrans.Amount;
                end;
                TotPension := ActualContr + Pension;

                //Permissible Limit
                //PermissibleLimit := 20000;
                PermissibleLimit := 0;

                //Mortgage Intrest
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'MORG-RL');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    MortgageIntrest := PRPeriodTrans.Amount;
                end;

                //Amount of Benefit
                E1 := 0.3 * TotalCashPay;
                E2 := ActualContr;
                E3 := 20000;

                //Column G - Get least between e1,E2,e3
                if E1 > E2 then begin
                    AmountOfBenefit := E2;
                end else begin
                    AmountOfBenefit := E1;
                end;

                if E3 < AmountOfBenefit then begin
                    AmountOfBenefit := E3;
                end;
                AmountOfBenefit += MortgageIntrest;

                //Taxable Pay
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXBP');
                if PRPeriodTrans.Find('-') then begin
                    TaxablePay := PRPeriodTrans.Amount;
                end;

                //Tax Payable
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXCHRG');
                if PRPeriodTrans.Find('-') then begin
                    TaxPayable := PRPeriodTrans.Amount;
                end;

                //Monthly Relief
                fn_PeriodTrans;
                PRPeriodTrans.SetRange("Transaction Name", 'Personal Relief');
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'PSNR', 'TXCHRG');
                if PRPeriodTrans.Find('-') then begin
                    MonthlyRelief := PRPeriodTrans.Amount;
                end;

                //Insurance Relief
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NHIFR');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    InsuranceRelief := PRPeriodTrans.Amount;
                end;

                //PAYE
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                if PRPeriodTrans.Find('-') then begin
                    PAYE := PRPeriodTrans.Amount;
                end;

                TotBPay := OtherAllowances + BPAY + HouseAllowance + TransportAllowance + OvertimeAllowance;


                if TotalCashPay = 0 then CurrReport.Skip;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Filter';
                        TableRelation = "PR Payroll Periods";
                    }
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
        if PeriodFilter = 0D then Error('Please select payroll period');
        fnCompanyInfo;

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

    end;

    var
        CompInfo: Record "Company Information";
        PRPeriodTrans: Record "PR Period Transactions";
        PeriodFilter: Date;
        PRTransCodes: Record "PR Transaction Codes";
        BPAY: Decimal;
        HouseAllowance: Decimal;
        TransportAllowance: Decimal;
        LeaveAllowance: Decimal;
        OvertimeAllowance: Decimal;
        DirectorsFee: Decimal;
        Lumpsum: Decimal;
        OtherAllowances: Decimal;
        TotalCashPay: Decimal;
        ValueOfCar: Decimal;
        OtherNonCash: Decimal;
        TotalNonCash: Decimal;
        GlobalIncome: Decimal;
        TypeOfHousing: Text;
        RentOfHouse: Decimal;
        ComputedRent: Decimal;
        RentRecovered: Decimal;
        NetValue: Decimal;
        TotalGross: Decimal;
        ThirtyPCash: Decimal;
        ActualContr: Decimal;
        PermissibleLimit: Decimal;
        MortgageIntrest: Decimal;
        HOSP: Decimal;
        AmountOfBenefit: Decimal;
        E1: Decimal;
        E2: Decimal;
        E3: Decimal;
        TaxablePay: Decimal;
        TaxPayable: Decimal;
        MonthlyRelief: Decimal;
        InsuranceRelief: Decimal;
        PAYE: Decimal;
        TotBPay: Decimal;
        transCode: Record "PR Transaction Codes";
        PeriodTran1: Record "PR Period Transactions";
        ActCont: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        GlobalIncome2: decimal;
        Pension: Decimal;
        TotPension: Decimal;


    procedure fnCompanyInfo()
    begin
        CompInfo.Reset;
        if CompInfo.Get then
            CompInfo.CalcFields(CompInfo.Picture);
    end;

    local procedure fn_PeriodTrans()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
        PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "HR Employees"."No.");
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
    end;


    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
