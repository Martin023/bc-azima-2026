#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185755 "Compute Daily Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                begin
                    //Initiate Variables
                    //DateDiff:=0;
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans."Compute Interest Due on Postin", Loans."compute interest due on postin"::"Pro-rata");
                    if Loans.Find('-') then begin
                        LoanType.Get(Loans."Loan Product Type");
                        repeat
                            //DateDiff:=1;//TODAY-Loans."Application Date" ELSE
                            //DateDiff:=TODAY-Loans."Disbursement Date";
                            MontDays := (CalcDate('CM', Pdate)) - (CalcDate('-CM', Pdate));
                            DailyLoansBuffer.Init;
                            DailyLoansBuffer."Loan No." := Loans."Loan No.";
                            DailyLoansBuffer."Interest Date" := Pdate;//CALCDATE('-1d',TODAY);
                            DailyLoansBuffer."Account No" := Loans."Loan Account";
                            DailyLoansBuffer."Account Type" := DailyLoansBuffer."account type"::Credit;
                            DailyLoansBuffer."Loan Product type" := Loans."Loan Product Type";
                            DailyLoansBuffer."User ID" := UserId;
                            //Compute Interest
                            if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                                if Format(LoanType."Grace Period - Interest") <> '' then
                                    //BEGIN
                                    if CalcDate(LoanType."Grace Period - Interest", Loans."Disbursement Date") >= Pdate then
                                        DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                                    else
                                        DailyLoansBuffer."Interest Amount" := 0;
                            end else begin
                                if Format(LoanType."Grace Period - Interest") <> '' then begin
                                    if CalcDate(LoanType."Grace Period - Interest", Loans."Disbursement Date") >= Pdate then
                                        DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                                    else
                                        DailyLoansBuffer."Interest Amount" := 0;
                                end else begin
                                    DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                                end;
                            end;
                            //end of interest computations
                            if Format(LoanType."Grace Period - Principle") <> '' then begin
                                if CalcDate(LoanType."Grace Period - Principle", Loans."Disbursement Date") >= Pdate then
                                    DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays) else
                                    DailyLoansBuffer."Repayment Amount" := 0;
                            end else begin
                                DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays)
                            end;
                            DailyLoansBuffer."Monthly Repayment" := DailyLoansBuffer."Repayment Amount" + DailyLoansBuffer."Interest Amount";
                            if DailyLoansBuffer."Monthly Repayment" <> 0 then
                                DailyLoansBuffer.Insert;
                        until Loans.Next = 0;
                    end;
                end;
                //END;
                //END;
            end;

            trigger OnPreDataItem()
            begin
                if Pdate = 0D then Pdate := Today else Pdate := Pdate;
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
                field("Posting Date"; Pdate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
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

    var
        //PeriodicActivities: Codeunit periodic;
        DailyLoansInterestBuffer: Record "Daily Loans Interest Buffer";
        Pdate: Date;
        MontDays: Integer;
        DailyLoansBuffer: Record "Daily Loans Interest Buffer";
        PdateErr: label 'Posting date must have a value';
        EntriesGenMSG: label 'Entries Generated Succesfully';
        LoanType: Record "Product Factory";
}
