#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185431 "PrPayroll Processing Casual"
{

    trigger OnRun()
    begin
    end;

    var
        PRPeriodTransactions: Record "PR Board NPAY & PAYE";
        prEmployeeTransactions: Record "PR Board Transactions";
        prTransactionCodes: Record "prBoard Earnings";


    procedure fnProcesspayroll(dtOpenPeriod: Date; strEmpCode: Code[50]; blnPaysNssf: Boolean)
    var
        curTotAllowances: Decimal;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[250];
        curNSSF: Decimal;
        TGroup: Text[250];
        curGrossPay: Decimal;
        CurPayee: Decimal;
        payee: Decimal;
        curNetPay: Decimal;
        TGroupOrder: Integer;
    begin
        TGroupOrder := 0;

        dtOpenPeriod := fnGetOpenPeriod();
        CurPayee := 0;
        //Delete all Records from the prPeriod Transactions for Reprocessing
        PRPeriodTransactions.Reset;
        PRPeriodTransactions.SetRange(PRPeriodTransactions."No.", strEmpCode);
        PRPeriodTransactions.SetRange(PRPeriodTransactions.Date, dtOpenPeriod);
        if PRPeriodTransactions.Find('-') then
            PRPeriodTransactions.DeleteAll;


        //Get Earnings
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Date, dtOpenPeriod);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspend, false); //Added DW to not process Stopped Transactions
        if prEmployeeTransactions.Find('-') then begin
            curTotAllowances := 0;
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes.Code, prEmployeeTransactions.Code);
                if prTransactionCodes.Find('-') then begin
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := ''; //strExtractedFrml := ''; curIncludeinNet:=0;4

                    curTransAmount := prEmployeeTransactions.Amount;
                    //Calc Payee
                    payee := 0;
                    if prTransactionCodes.Taxable then begin
                        if prTransactionCodes."Is Telephone Allowance" = true then begin
                            payee := (prEmployeeTransactions.Amount * 30 / 100) * (30 / 100);
                        end else begin
                            payee := prEmployeeTransactions.Amount * 30 / 100;
                        end;
                    end;
                    CurPayee := CurPayee + payee;

                end;

                curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                //END;
                TGroup := prEmployeeTransactions.Description;
                TGroupOrder := 3;
                fnUpdatePeriodTrans(prEmployeeTransactions.Code, TGroup, curTransAmount,
                                     dtOpenPeriod, prEmployeeTransactions."Is Net", prEmployeeTransactions."Is Paye", strEmpCode, TGroupOrder)
            until prEmployeeTransactions.Next = 0;
        end;

        //Get the NSSF amount
        if blnPaysNssf then begin
            curNSSF := 200;
            curTransAmount := curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES NSSF';
            TGroupOrder := 7; //TSubGroupOrder := 1;
            fnUpdatePeriodTrans('NSSF', TGroup, curTransAmount,
                                 dtOpenPeriod, false, false, strEmpCode, TGroupOrder);
        end;
        curGrossPay := 0;
        //Calc GrossPay
        curGrossPay := curTotAllowances;
        curTransAmount := ROUND(curGrossPay, 0.01, '>'); //curGrossPay;

        strTransDescription := 'Gross Pay';
        TGroup := 'GROSS PAY';
        TGroupOrder := 4; //TSubGroupOrder := 0;
        fnUpdatePeriodTrans('GPAY', TGroup, curTransAmount,
                                 dtOpenPeriod, false, false, strEmpCode, TGroupOrder);

        //payee Calc
        strTransDescription := 'P.A.Y.E';
        curTransAmount := CurPayee;
        TGroup := 'Tax Charged';
        TGroupOrder := 6;// TSubGroupOrder := 0;
        fnUpdatePeriodTrans('PAYE', TGroup, curTransAmount,
                                 dtOpenPeriod, false, true, strEmpCode, TGroupOrder);



        //net Pay

        curNetPay := curGrossPay - CurPayee; //Check here
        curNetPay := ROUND(curNetPay, 0.01, '>'); //Check here
        curTransAmount := curNetPay;
        strTransDescription := 'Net Pay';
        TGroup := 'NET PAY';
        TGroupOrder := 9; //TSubGroupOrder := 0;
        fnUpdatePeriodTrans('NPAY', TGroup, curTransAmount,
                                dtOpenPeriod, true, false, strEmpCode, TGroupOrder);
    end;

    local procedure fnUpdatePeriodTrans(TCode: Code[50]; Description: Text[150]; curAmount: Decimal; dtOpenPeriod: Date; Net: Boolean; Payee: Boolean; Empcode: Code[50]; TGroupOrder: Integer)
    begin
        if curAmount = 0 then exit;
        begin
            PRPeriodTransactions."No." := Empcode;
            PRPeriodTransactions.Date := dtOpenPeriod;
            PRPeriodTransactions.Code := TCode;
            PRPeriodTransactions.Description := Description;
            PRPeriodTransactions.Name := Description;
            PRPeriodTransactions.Amount := curAmount;
            PRPeriodTransactions."Is Net" := Net;
            PRPeriodTransactions."Is Paye" := Payee;
            PRPeriodTransactions."Group Order" := TGroupOrder;
            PRPeriodTransactions.Insert;
        end;
    end;


    procedure fnGetOpenPeriod() dtOpenPeriod: Date
    var
        "prPayroll Periods": Record "PR Payroll Periods";
        intMonth: Integer;
        intYear: Integer;
    begin
        "prPayroll Periods".Reset;
        "prPayroll Periods".SetRange("prPayroll Periods".Closed, false);

        if "prPayroll Periods".Find('-') then begin
            dtOpenPeriod := "prPayroll Periods"."Date Opened";
            intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
            intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
        end
        else begin
            Error('There is no open payroll period');
        end
    end;
}
