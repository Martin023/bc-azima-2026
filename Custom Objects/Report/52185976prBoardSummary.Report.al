#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185976 "prBoard Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prBoard Summary.rdl';

    dataset
    {
        dataitem("prBoard Employees"; "Board members")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No_prBoardEmployees; "prBoard Employees"."No.")
            {
            }
            column(StaffName; "Member Name")
            {
            }

            column(CompinfoPicture; CompanyInfo.Picture)
            {
            }
            column(Allow; Allow)
            {
            }
            column(Grosspay; Grosspay)
            {
            }
            column(Nssf; NSSF)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(NetPay; NetPay)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //MESSAGE("prBoard Employees"."First Name" + "prBoard Employees"."No.");
                summary.Reset;


                Allow := 0;
                Grosspay := 0;
                NSSF := 0;
                PAYE := 0;
                NetPay := 0;


                //Get Earnings
                PRPeriodTransactions.Reset;
                PRPeriodTransactions.SetRange(PRPeriodTransactions."No.", "prBoard Employees"."No.");
                PRPeriodTransactions.SetRange(PRPeriodTransactions.Date, SelectedPeriod);
                if PRPeriodTransactions.Find('-') then begin
                    repeat
                        if PRPeriodTransactions."Group Order" = 3 then
                            Allow := Allow + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 6 then
                            PAYE := PAYE + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 4 then
                            Grosspay := Grosspay + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 9 then
                            NetPay := NetPay + PRPeriodTransactions.Amount;
                        if PRPeriodTransactions."Group Order" = 7 then
                            NSSF := NSSF + PRPeriodTransactions.Amount;

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
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "PR Payroll Periods"."Date Opened";
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

        //SelectedPeriod:=objPeriod.GETFILTER("Date Opened");
        SelectedPeriod := SelectedPeriod;//"prPeriod Transactions".GETRANGEMIN("Payroll Period");
        if SelectedPeriod = 0D then
            Error('Select A Period');
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
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
}
