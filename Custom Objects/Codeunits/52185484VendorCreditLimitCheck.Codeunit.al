#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185484 "Vendor Credit Limit Check"
{

    trigger OnRun()
    begin
    end;

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        VendDateFilter: array[4] of Text[30];
        VendDateName: array[4] of Text[30];
        TotalAmountLCY: Decimal;
        CurrentDate: Date;
        VendPurchLCY: array[4] of Decimal;
        VendInvDiscAmountLCY: array[4] of Decimal;
        VendPaymentDiscLCY: array[4] of Decimal;
        VendPaymentDiscTolLCY: array[4] of Decimal;
        VendPaymentTolLCY: array[4] of Decimal;
        VendReminderChargeAmtLCY: array[4] of Decimal;
        VendFinChargeAmtLCY: array[4] of Decimal;
        VendCrMemoAmountsLCY: array[4] of Decimal;
        VendPaymentsLCY: array[4] of Decimal;
        VendRefundsLCY: array[4] of Decimal;
        VendOtherAmountsLCY: array[4] of Decimal;
        i: Integer;
        InvAmountsLCY: array[4] of Decimal;


    procedure CheckVendorCreditLimit(var Rec: Record Vendor)
    begin
        begin
            Rec.SetRange(Rec."No.");

            if CurrentDate <> WorkDate then begin
                CurrentDate := WorkDate;
                DateFilterCalc.CreateAccountingPeriodFilter(VendDateFilter[1], VendDateName[1], CurrentDate, 0);
                DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[2], VendDateName[2], CurrentDate, 0);
                DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[3], VendDateName[3], CurrentDate, -1);
            end;

            Rec.SetRange(Rec."Date Filter", 0D, CurrentDate);
            Rec.CalcFields(
              Rec.Balance, Rec."Balance (LCY)", Rec."Balance Due", Rec."Balance Due (LCY)",
              Rec."Outstanding Orders (LCY)", Rec."Amt. Rcd. Not Invoiced (LCY)",
              Rec."Reminder Amounts (LCY)");

            TotalAmountLCY := Rec."Balance (LCY)" + Rec."Outstanding Orders (LCY)" + Rec."Amt. Rcd. Not Invoiced (LCY)" + Rec."Outstanding Invoices (LCY)";

            for i := 1 to 4 do begin
                Rec.SetFilter(Rec."Date Filter", VendDateFilter[i]);
                Rec.CalcFields(
                  Rec."Purchases (LCY)", Rec."Inv. Discounts (LCY)", Rec."Inv. Amounts (LCY)", Rec."Pmt. Discounts (LCY)",
                  Rec."Pmt. Disc. Tolerance (LCY)", Rec."Pmt. Tolerance (LCY)",
                  Rec."Fin. Charge Memo Amounts (LCY)", Rec."Cr. Memo Amounts (LCY)", Rec."Payments (LCY)",
                  Rec."Reminder Amounts (LCY)", Rec."Refunds (LCY)", Rec."Other Amounts (LCY)");
                VendPurchLCY[i] := Rec."Purchases (LCY)";
                VendInvDiscAmountLCY[i] := Rec."Inv. Discounts (LCY)";
                InvAmountsLCY[i] := Rec."Inv. Amounts (LCY)";
                VendPaymentDiscLCY[i] := Rec."Pmt. Discounts (LCY)";
                VendPaymentDiscTolLCY[i] := Rec."Pmt. Disc. Tolerance (LCY)";
                VendPaymentTolLCY[i] := Rec."Pmt. Tolerance (LCY)";
                VendReminderChargeAmtLCY[i] := Rec."Reminder Amounts (LCY)";
                VendFinChargeAmtLCY[i] := Rec."Fin. Charge Memo Amounts (LCY)";
                VendCrMemoAmountsLCY[i] := Rec."Cr. Memo Amounts (LCY)";
                VendPaymentsLCY[i] := Rec."Payments (LCY)";
                VendRefundsLCY[i] := Rec."Refunds (LCY)";
                VendOtherAmountsLCY[i] := Rec."Other Amounts (LCY)";
            end;
            Rec.SetRange(Rec."Date Filter", 0D, CurrentDate);

            Commit;
            //Message if Total Exceeds the Credit Limit
            if (Rec."Vendor Credit Limit(LCY)") <= 0 then
                exit;
            if (Rec."Vendor Credit Limit(LCY)") < (TotalAmountLCY) then begin
                if Page.RunModal(39006082, Rec) = Action::No then begin
                    Error('User Action Cancelled');
                end;
            end;
        end;
    end;
}
