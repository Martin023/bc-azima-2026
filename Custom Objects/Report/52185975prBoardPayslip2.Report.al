#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185975 "prBoard Payslip 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prBoard Payslip 2.rdl';

    dataset
    {
        dataitem("prBoard Employees"; "Board members")
        {
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
            column(Names; "Member Name")
            {
            }
            column(Balnc; Balnc)
            {
            }
            column(Payee; payee)
            {
            }
            dataitem("PR Board Transactions"; "PR Board Transactions")
            {
                DataItemLink = "No." = field("No.");
                column(ReportForNavId_7; 7)
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
                column(Totalamnt; Totalamnt)
                {
                }
                column(PayPeriodText; PayPeriodtext)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Totalamnt:=Totalamnt+"PR Board Transactions".Amount;
                    //MESSAGE(FORMAT(Totalamnt));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Names := "prBoard Employees"."First Name" + ' ' + "prBoard Employees"."Middle Name" + ' ' + "prBoard Employees"."Last Name";


                BoardTransact.Reset;
                BoardTransact.SetRange(BoardTransact."No.", "prBoard Employees"."No.");
                BoardTransact.SetRange(BoardTransact.Date, SelectedPeriod);
                if BoardTransact.Find('-') then begin
                    repeat
                        Totalamnt := Totalamnt + BoardTransact.Amount;
                    until BoardTransact.Next = 0
                end;
                Board2.Reset;
                Board2.SetRange(Board2."No.", "prBoard Employees"."No.");
                Board2.SetRange(Board2.Date, SelectedPeriod);
                Board2.SetRange(Board2."Is Paye", true);
                if Board2.Find('-') then begin
                    repeat
                        payee := payee + Board2.Amount;
                    until Board2.Next = 0;
                end;
                Board2.Reset;
                Board2.SetRange(Board2."No.", "prBoard Employees"."No.");
                Board2.SetRange(Board2.Date, SelectedPeriod);
                Board2.SetRange(Board2."Is Net", true);
                if Board2.Find('-') then begin
                    repeat
                        Balnc := Balnc + Board2.Amount;
                    until Board2.Next = 0;
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
                    Caption = 'Payroll Period';
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        Totalamnt := 0;
        if SelectedPeriod = 0D then begin
            //select open perod
            PayPeriod.Reset;
            PayPeriod.SetRange(PayPeriod.Closed, false);
            if PayPeriod.Find('-') then
                SelectedPeriod := PayPeriod."Date Opened";
        end;
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
        PeriodName: Text[50];
        NetPay: Decimal;
        CompInfo: Record "Company Information";
        Names: Text[200];
        PRPayrollPeriods: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        Board: Record "PR Board NPAY & PAYE";
        Board2: Record "PR Board NPAY & PAYE";
        Earn: Record "prBoard Earnings";
        Emp: Record "Board members";
        CheckNo: Code[20];
        "Ref No": Code[20];
        Trans: Decimal;
        Desc: Text[100];
        PayDate: Date;
        Benefit: Text[100];
        TotalPay: Decimal;
        Earnings: Record "prBoard Earnings";
        payee: Decimal;
        amt: Decimal;
        EP: Record "Board members";
        Totalamnt: Decimal;
        Balnc: Decimal;
        PayPeriod: Record "PR Payroll Periods";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        DateSpecified: Date;
        Year: Integer;
        HoldDate: Date;
        EndDate: Date;
        BoardTransact: Record "PR Board Transactions";
        amt1: Decimal;
}
