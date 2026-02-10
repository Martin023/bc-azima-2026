#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185974 "prBoard Payslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/prBoard Payslip.rdl';

    dataset
    {
        dataitem("PR Board Transactions"; "PR Board Transactions")
        {
            RequestFilterFields = Date, "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Cname; CompInfo.Name)
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(CAdress; CompInfo.Address)
            {
            }
            column(CCity; CompInfo.City)
            {
            }
            column(Names; Names)
            {
            }
            column(Amount_PRBoardTransactions; "PR Board Transactions".Amount)
            {
            }
            column(Description_PRBoardTransactions; "PR Board Transactions".Description)
            {
            }
            column(Date_PRBoardTransactions; "PR Board Transactions".Date)
            {
            }
            column(Name_PRBoardTransactions; "PR Board Transactions".Name)
            {
            }
            column(Balnc; Balnc)
            {
            }
            column(Payee; PAYE)
            {
            }
            column(Totalamnt; Totalamnt)
            {
            }
            column(PayPeriodText; PayPeriodtext)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get Earnings
                PRPeriodTransactions.Reset;
                PRPeriodTransactions.SetRange(PRPeriodTransactions."No.", "PR Board Transactions"."No.");
                PRPeriodTransactions.SetRange(PRPeriodTransactions.Date, SelectedPeriod);
                if PRPeriodTransactions.Find('-') then begin
                    repeat
                        if PRPeriodTransactions."Group Order" = 6 then
                            PAYE := PAYE + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 4 then
                            Totalamnt := Totalamnt + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 9 then
                            Balnc := Balnc + PRPeriodTransactions.Amount;

                    until PRPeriodTransactions.Next = 0;
                end;
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        //select open perod
        PayPeriod.Reset;
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            SelectedPeriod := PayPeriod."Date Opened";


        //Getpayperiodd;

        /*
          PayPeriodtext:="PR Board Transactions".GETFILTER("PR Board Transactions".Date);
          IF PayPeriodtext='' THEN
          ERROR('Pay period must be specified for this report');
          */

        DateSpecified := SelectedPeriod;//"PR Board Transactions".GETRANGEMIN(Date);
        HoldDate := SelectedPeriod;//"PR Board Transactions".GETRANGEMIN(Date);
        if PayPeriod.Get(DateSpecified) then
            PayPeriodtext := PayPeriod."Period Name";
        Year := Date2dmy(HoldDate, 3);

        PayPeriodtext := PayPeriodtext;//+'-'+ FORMAT(Year);

        // EndDate:=CALCDATE('1M',DateSpecified-1);

    end;

    var
        Totalamnt: Decimal;
        payee: Decimal;
        Balnc: Decimal;
        Names: Text[250];
        Year: Integer;
        PayPeriodtext: Text;
        HoldDate: Date;
        DateSpecified: Date;
        CompInfo: Record "Company Information";
        boardTransaction: Record "PR Board Transactions";
        strEmpName: Text[200];
        summary: Record "PR Board NPAY & PAYE";
        Allow: Decimal;
        Grosspay: Decimal;
        Nssf: Decimal;
        PAYE: Decimal;
        PRPeriodTransactions: Record "PR Board NPAY & PAYE";
        prEmployeeTransactions: Record "PR Board Transactions";
        prTransactionCodes: Record "prBoard Earnings";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        NetPay: Decimal;
        PayPeriod: Record "PR Payroll Periods";


    procedure Getpayperiodd()
    begin
    end;
}
