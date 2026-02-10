#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185541 "prGross Reconcilliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prGross Reconcilliation.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "Current Month Filter";
            column(ReportForNavId_8631; 8631)
            {
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
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR Employees"."No.")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(GrossPayPREV; GrossPayPREV)
            {
            }
            column(BasicPayPREV; BasicPayPREV)
            {
            }
            column(Payment_ReconcilliationCaption; Payment_ReconcilliationCaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
            {
            }
            column(Prev_Gross_Pay_Caption; Prev_Gross_Pay_CaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Prev_Basic_Pay_Caption; Prev_Basic_Pay_CaptionLbl)
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
            dataitem("Monthly Reconcilliation"; "Monthly Reconcilliation")
            {
                DataItemLink = Employee = field("No.");
                DataItemTableView = sorting(Employee, TransCode) order(ascending);
                column(ReportForNavId_5750; 5750)
                {
                }
                column(Monthly_Reconcilliation_TransCode; TransCode)
                {
                }
                column(Monthly_Reconcilliation_Description; Description)
                {
                }
                column(Monthly_Reconcilliation_CurrAmount; CurrAmount)
                {
                }
                column(Monthly_Reconcilliation_PrevAmount; PrevAmount)
                {
                }
                column(No; No)
                {
                }
                column(CurrAmount_PrevAmount; CurrAmount - PrevAmount)
                {
                }
                column(Monthly_Reconcilliation_Employee; Employee)
                {
                }
                column(Monthly_Reconcilliation_Group_Order; "Group Order")
                {
                }
                column(Monthly_Reconcilliation_Refference_Code; "Refference Code")
                {
                }
                column(Monthly_Reconcilliation_Entry_Exit; "Entry/Exit")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No += 1;
                end;

                trigger OnPreDataItem()
                begin
                    No := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "HR Employees"."No.");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                BasicPay := 0;
                GrossPay := 0;
                NetPay := 0;
                TotalDed := 0;
                BasicPayPREV := 0;
                GrossPayPREV := 0;
                NetPayPREV := 0;
                TotalDedPREV := 0;

                "Entry/Exit" := false;

                NetPay := 0;

                PeriodTrans.Reset;
                PeriodTrans.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'BPAY|GPAY|NPAY|TOT-DED');
                //PeriodTrans.SETFILTER(PeriodTrans."Group Order",'=1|=4|=9|=8');
                //PeriodTrans.SETFILTER(PeriodTrans."Sub Group Order",'<=1');
                if PeriodTrans.Find('-') then begin
                    repeat
                        if PeriodTrans."Group Order" = 1 then begin
                            BasicPay := PeriodTrans.Amount;
                        end;

                        if PeriodTrans."Group Order" = 4 then begin
                            GrossPay := PeriodTrans.Amount; //Gross pay
                        end;

                        if PeriodTrans."Group Order" = 9 then begin
                            NetPay := PeriodTrans.Amount; //Net pay
                        end;

                        if PeriodTrans."Transaction Code" = 'TOT-DED' then begin
                            TotalDed := PeriodTrans.Amount; //Total Deductions
                        end;

                    until PeriodTrans.Next = 0;
                end;

                PeriodTransPREV.Reset;
                PeriodTransPREV.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", "HR Employees"."No.");
                PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                PeriodTransPREV.SetFilter(PeriodTransPREV."Transaction Code", 'BPAY|GPAY|NPAY|TOT-DED');
                //PeriodTransPREV.SETFILTER(PeriodTransPREV."Group Order",'=1|=4|=9');
                //PeriodTransPREV.SETFILTER(PeriodTransPREV."Sub Group Order",'<=1');
                if PeriodTransPREV.Find('-') then begin
                    repeat
                        if PeriodTransPREV."Group Order" = 1 then begin
                            BasicPayPREV := PeriodTransPREV.Amount;
                        end;

                        if PeriodTransPREV."Group Order" = 4 then begin
                            GrossPayPREV := PeriodTransPREV.Amount; //Gross pay
                        end;

                        if PeriodTransPREV."Group Order" = 9 then begin
                            NetPayPREV := PeriodTransPREV.Amount; //Net pay
                        end;

                        if PeriodTransPREV."Transaction Code" = 'TOT-DED' then begin
                            TotalDedPREV := PeriodTransPREV.Amount; //Total Deductions
                        end;

                    until PeriodTransPREV.Next = 0;
                end;

                //
                if (GrossPayPREV = GrossPay) and (NetPayPREV = NetPay) and (TotalDed = TotalDedPREV) then
                    CurrReport.Skip;

                if (GrossPayPREV <> GrossPay) or (NetPayPREV <> NetPay) or (TotalDed <> TotalDedPREV) then begin
                    if (GrossPayPREV = 0) or (GrossPay = 0) then
                        "Entry/Exit" := true;

                    PeriodTransPREV.Reset;
                    PeriodTransPREV.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                    PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", "HR Employees"."No.");
                    PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                    if PeriodTransPREV.Find('-') then begin
                        repeat
                            PeriodTrans.Reset;
                            PeriodTrans.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                            PeriodTrans.SetRange(PeriodTrans."Employee Code", PeriodTransPREV."Employee Code");
                            PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                            PeriodTrans.SetRange(PeriodTrans."Transaction Code", PeriodTransPREV."Transaction Code");
                            PeriodTrans.SetRange(PeriodTrans."Reference No", PeriodTransPREV."Reference No");
                            if PeriodTrans.Find('-') then begin
                                if PeriodTransPREV.Amount <> PeriodTrans.Amount then begin
                                    ReconcilliationTable.Init;
                                    ReconcilliationTable.Employee := "HR Employees"."No.";
                                    ReconcilliationTable.TransCode := PeriodTransPREV."Transaction Code";
                                    ReconcilliationTable."Refference Code" := PeriodTransPREV."Reference No";
                                    ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                    ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                    ReconcilliationTable.Description := 'Changes in ' + PeriodTransPREV."Transaction Name";
                                    ReconcilliationTable.Difference := ReconcilliationTable.CurrAmount - ReconcilliationTable.PrevAmount;
                                    ReconcilliationTable."Group Order" := PeriodTransPREV."Group Order";
                                    ReconcilliationTable."Sub Group Order" := PeriodTransPREV."Sub Group Order";
                                    if (ReconcilliationTable."Group Order" <= 3) then
                                        ReconcilliationTable."Entry/Exit" := "Entry/Exit"
                                    else
                                        ReconcilliationTable."Entry/Exit" := false;
                                    ReconcilliationTable.Insert;
                                end;
                            end else begin
                                ReconcilliationTable.Init;
                                ReconcilliationTable.Employee := "HR Employees"."No.";
                                ReconcilliationTable.TransCode := PeriodTransPREV."Transaction Code";
                                ReconcilliationTable."Refference Code" := PeriodTransPREV."Reference No";
                                ReconcilliationTable.CurrAmount := 0;
                                ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                ReconcilliationTable.Difference := ReconcilliationTable.CurrAmount - ReconcilliationTable.PrevAmount;
                                ReconcilliationTable.Description := 'Changes in ' + PeriodTransPREV."Transaction Name";
                                ReconcilliationTable."Group Order" := PeriodTransPREV."Group Order";
                                ReconcilliationTable."Sub Group Order" := PeriodTransPREV."Sub Group Order";
                                if (ReconcilliationTable."Group Order" <= 3) then
                                    ReconcilliationTable."Entry/Exit" := "Entry/Exit"
                                else
                                    ReconcilliationTable."Entry/Exit" := false;
                                ReconcilliationTable.Insert;

                            end;

                        until PeriodTransPREV.Next = 0;


                    end;

                    PeriodTrans.Reset;
                    PeriodTrans.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR Employees"."No.");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    if PeriodTrans.Find('-') then begin
                        repeat
                            PeriodTransPREV.Reset;
                            PeriodTransPREV.SetCurrentkey("Transaction Code", "Employee Code", "Payroll Period", "Reference No");
                            PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", PeriodTrans."Employee Code");
                            PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                            PeriodTransPREV.SetRange(PeriodTransPREV."Transaction Code", PeriodTrans."Transaction Code");
                            PeriodTransPREV.SetRange(PeriodTransPREV."Reference No", PeriodTrans."Reference No");
                            if PeriodTransPREV.Find('-') = false then begin
                                ReconcilliationTable.Init;
                                ReconcilliationTable.Employee := "HR Employees"."No.";
                                ReconcilliationTable.TransCode := PeriodTrans."Transaction Code";
                                ReconcilliationTable."Refference Code" := PeriodTrans."Reference No";
                                ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                ReconcilliationTable.PrevAmount := 0;
                                ReconcilliationTable.Difference := ReconcilliationTable.CurrAmount - ReconcilliationTable.PrevAmount;
                                ReconcilliationTable.Description := 'Changes in ' + PeriodTrans."Transaction Name";
                                ReconcilliationTable."Group Order" := PeriodTrans."Group Order";
                                ReconcilliationTable."Sub Group Order" := PeriodTrans."Sub Group Order";
                                if (ReconcilliationTable."Group Order" <= 3) then
                                    ReconcilliationTable."Entry/Exit" := "Entry/Exit"
                                else
                                    ReconcilliationTable."Entry/Exit" := false;
                                ReconcilliationTable.Insert;

                            end;

                        until PeriodTrans.Next = 0;


                    end;
                end;

                //IF NetPay<=0 THEN
                //CurrReport.SKIP;
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;
            end;

            trigger OnPreDataItem()
            begin
                ReconcilliationTable.DeleteAll;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
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
        PeriodFilter := "HR Employees".GetFilter("Current Month Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "HR Employees".GetRangeMin("Current Month Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";
    end;

    var
        PeriodTrans: Record "PR Period Transactions";
        BasicPay: Decimal;
        GrossPay: Decimal;
        NetPay: Decimal;
        TotBasicPay: Decimal;
        TotGrossPay: Decimal;
        TotNetPay: Decimal;
        EmployeeName: Text[200];
        objEmp: Record "HR Employees";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        PeriodTransPREV: Record "PR Period Transactions";
        BasicPayPREV: Decimal;
        GrossPayPREV: Decimal;
        NetPayPREV: Decimal;
        ReconcilliationTable: Record "Monthly Reconcilliation";
        No: Integer;
        "Entry/Exit": Boolean;
        TotalDed: Decimal;
        TotalDedPREV: Decimal;
        Payment_ReconcilliationCaptionLbl: label 'Payment Reconcilliation';
        Basic_Pay_CaptionLbl: label 'Basic Pay:';
        Gross_Pay_CaptionLbl: label 'Gross Pay:';
        Prev_Gross_Pay_CaptionLbl: label 'Prev Gross Pay:';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Prev_Basic_Pay_CaptionLbl: label 'Prev Basic Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
}
