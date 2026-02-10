#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185522 "PR Payroll Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/PR Payroll Summary.rdl';


    dataset
    {
        dataitem(PRPeriodTrns; "PR Period Transactions")
        {

            column(Employee_Code; "Employee Code")
            {

            }
            column(Transaction_Code; "Transaction Code")
            {

            }
            column(Transaction_Name; "Transaction Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(PeriodFilter; PeriodFilter)
            {

            }
            COLUMN(Header1; Header1)
            {

            }
            column(Header2; Header2)
            {

            }

            trigger OnAfterGetRecord()
            begin

                // Amount := 0;
                // PRPeriodTrans.Reset;
                // // PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                // PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRPeriodTrns."Transaction Code");
                // PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                // if PRPeriodTrans.Find('-') then begin
                //     repeat
                // IF PRPeriodTrns."Transaction Code" = 'b'
                //         PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //         Header1:='BPAY';
                if PRPeriodTrns."Transaction Code" = 'BPAY' THEN BEGIN
                    Amount += PRPeriodTrans.Amount;
                    //TransactionCode := PRPeriodTrans."Transaction Code";
                END;
                Header2 := 'GPAY';
                if PRPeriodTrns."Transaction Code" = 'GPAY' THEN BEGIN
                    // Amount := PRPeriodTrans.Amount;
                END;


                // until prperiodTrans.next = 0;

            end;

            // if Amount = 0 then CurrReport.Skip;
            // end;

            trigger OnPreDataItem()
            begin
                //    OnViewCurrRec();

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
                field(PeriodFilter; PeriodFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Filter';
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
        if PeriodFilter = 0D then Error('Please specify period filter');
    end;

    var
        PRPeriodTrans: Record "PR Period Transactions";
        PeriodFilter: Date;
        Amount: Decimal;
        EmpTransactions: record "PR Employee Transactions";
        TransactionCode: code[40];
        Header2: code[40];
        Header1: code[40];


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
