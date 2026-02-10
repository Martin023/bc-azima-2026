#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185899 "Loan Product Summaries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Product Summaries.rdl';

    dataset
    {
        //dataitem(52185690;52185690)
        dataitem("Product Factory"; "Product Factory")

        {
            DataItemTableView = where("Product Class Type" = const(Loan));
            column(ReportForNavId_1; 1)
            {
            }
            column(Loan_Type; "Product Factory"."Product ID")
            {
            }
            column(Loan_Type_Desciption; "Product Factory"."Product Description")
            {
            }
            column(Loan_Amount; LoanAmount)
            {
            }
            column(Cleared_Loans; ClearedLoans)
            {
            }
            column(Net_Deduction; NetDeduction)
            {
            }
            column(Net_Amount; NetAmount)
            {
            }
            column(Commissions; Comms)
            {
            }
            column(Speed_Charge; TotalSpeedCharge)
            {
            }
            column(Insurance; TotalInsurance)
            {
            }
            column(Cleared; TotalCleared)
            {
            }
            column(Commss; TotalComms)
            {
            }
            column(Net_Amt; TotalNet)
            {
            }
            column(Loan_Amt; TotLoanAmt)
            {
            }
            column(No_Of_Loans; NoOfLoans)
            {
            }
            column(CurrDate; Today)
            {

            }
            column(Start; StartDate)
            {
            }
            column("End"; EndDate)
            {
            }
            column(CPicture; compinf.picture)
            {
            }
            column(CName; compinf.Name)
            { }
            column(CAddress; compinf.Address)
            { }


            trigger OnAfterGetRecord()
            begin
                TotalSpeedCharge := 0;
                TotalInsurance := 0;
                TotalCleared := 0;
                TotalComms := 0;
                TotalNet := 0;
                TotLoanAmt := 0;
                NoOfLoans := 0;

                Loans.Reset;
                Loans.SetRange("Loan Product Type", "Product Factory"."Product ID");
                Loans.SetRange("Approval Date", StartDate, EndDate);
                Loans.SetRange(Posted, true);
                if Loans.Find('-') then begin
                    repeat

                        // MESSAGE(FORMAT(Loans."Disbursement Date"));
                        //I
                        Comms := 0;
                        NetDeduction := 0;
                        NetAmount := 0;
                        LoanAmount := 0;
                        TCharges := 0;
                        AllLoansTopup := 0;
                        SpeedChrg := 0;
                        ExternalEffects := 0;
                        SpeedCharge := 0;
                        Insurance := 0;
                        Comms := 0;

                        NoOfLoans := NoOfLoans + 1;


                        /*
                        //Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Top Up Amount");
                        IF Loans."Outstanding Balance">0 THEN BEGIN

                        NetDeduction:=0;
                        //charges for all products regarardless
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code","Product Factory"."Product ID");
                        PCharges.SETRANGE(PCharges."Nature Of Charge",PCharges."Nature Of Charge"::General);
                        IF PCharges.FIND('-') THEN BEGIN
                           REPEAT

                           IF (PCharges."Use Perc"=TRUE) AND (PCharges.Divisor>1) THEN
                               TCharges:=TCharges+(Loans."Approved Amount" * Loans.Installments*(PCharges.Percentage/100*1/PCharges.Divisor))
                           ELSE IF (PCharges."Use Perc"=TRUE) AND (PCharges.Divisor=1) THEN
                              TCharges:=TCharges+(Loans."Approved Amount"*(PCharges.Percentage/100*1/PCharges.Divisor))
                           ELSE
                               TCharges:=TCharges+PCharges.Amount;

                          IF PCharges.Code='5' THEN
                           Insurance:=(Loans."Approved Amount" * (PCharges.Percentage/100*1/10));


                           UNTIL PCharges.NEXT = 0;
                           END;




                          //End of general charges

                        //Check if it is loan clearance- Top up


                        IF Loans."Top Up Amount">0 THEN BEGIN
                        //Pass loan clearance principle and interest
                           LoanTopUp.RESET;
                           LoanTopUp.SETRANGE(LoanTopUp."Loan No.",Loans."Loan  No.");
                           LoanTopUp.SETRANGE(LoanTopUp."Client Code",Loans."Member No.");
                           IF LoanTopUp.FIND('-') THEN BEGIN
                              REPEAT
                              TotPrincLoan:=0;
                              TotIntOffset:=0;
                                 //Principle
                              TotPrincLoan:=TotPrincLoan+LoanTopUp."Principle Top Up";
                              TotIntOffset:=TotIntOffset+LoanTopUp."Interest Top Up";


                              AllLoansTopup:=AllLoansTopup+TotPrincLoan+TotIntOffset;
                              //MESSAGE('Total Offset %1 Loan No. %2',AllLoansTopup,Loans."Loan  No.");

                        //charges for clearance/topups
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code",Loans."Loan Product Type");
                        PCharges.SETRANGE(PCharges."Nature Of Charge",PCharges."Nature Of Charge"::"Loan Clearance");
                        IF PCharges.FIND('-') THEN BEGIN
                           REPEAT
                           IF PCharges."Charge Based on"=PCharges."Charge Based on"::"Approved Amount" THEN BEGIN
                           IF (PCharges."Use Perc"=TRUE) THEN
                               TCharges:=TCharges+(Loans."Approved Amount" * (PCharges.Percentage/100*1/PCharges.Divisor))
                           ELSE
                               TCharges:=TCharges+PCharges.Amount;
                           END ELSE
                           IF PCharges."Charge Based on"=PCharges."Charge Based on"::"Net Amount" THEN BEGIN
                           IF (PCharges."Use Perc"=TRUE) THEN
                               TCharges:=TCharges+((Loans."Approved Amount"-TCharges-AllLoansTopup) * (PCharges.Percentage/100*1/PCharges.Divisor))*-1
                           ELSE
                               TCharges:=TCharges+PCharges.Amount * -1;
                           END ELSE
                           IF (PCharges."Charge Based on"=PCharges."Charge Based on"::"Special Amounts") AND (PCharges."Premature Interest"=TRUE) THEN BEGIN
                           IF (PCharges."Use Perc"=TRUE) THEN
                               TCharges:=TCharges+LoanTopUp."One Month Interest"
                              // GenJournalLine.Amount:=((LoanTopUp."Premature Interest" * (PCharges.Percentage/100*1/PCharges.Divisor)))*-1
                           ELSE
                               TCharges:=TCharges+LoanTopUp."One Month Interest"
                           END ELSE
                           IF (PCharges."Charge Based on"=PCharges."Charge Based on"::"Special Amounts") AND (PCharges."Loan Clearance Commission"=TRUE) THEN BEGIN
                           IF (PCharges."Use Perc"=TRUE) THEN
                               TCharges:=TCharges+((TotPrincLoan * (PCharges.Percentage/100*1/PCharges.Divisor)))
                           ELSE
                              TCharges:=TCharges+((TotPrincLoan * (PCharges.Percentage/100*1/PCharges.Divisor)))

                           END ELSE

                           IF (PCharges."Charge Based on"=PCharges."Charge Based on"::"Special Amounts") AND (PCharges."Insurance Rebate"=TRUE) THEN BEGIN
                           IF (PCharges."Use Perc"=TRUE) THEN
                               TCharges:=TCharges+LoanTopUp."Insurance rebate"*0.7

                           ELSE
                              TCharges:=TCharges+LoanTopUp."Insurance rebate"*0.7
                           END;



                           UNTIL PCharges.NEXT = 0;
                           END;

                        UNTIL LoanTopUp.NEXT=0;
                        END;

                        END;



                        //Clearing external debts
                        OtherCommitments.RESET;
                        OtherCommitments.SETRANGE(OtherCommitments."Loan No.",Loans."Loan  No.");
                        IF OtherCommitments.FIND('-') THEN BEGIN
                        REPEAT

                               AllLoansTopup:=AllLoansTopup+OtherCommitments.Amount;

                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code",Loans."Loan Product Type");
                        PCharges.SETRANGE(PCharges."Nature Of Charge",PCharges."Nature Of Charge"::"External Commitments");
                        IF PCharges.FIND('-') THEN BEGIN
                           REPEAT
                           IF (PCharges."Use Perc"=TRUE) THEN
                               AllLoansTopup:=AllLoansTopup+(OtherCommitments.Amount * (PCharges.Percentage/100*1/PCharges.Divisor))
                           ELSE
                               AllLoansTopup:=AllLoansTopup+OtherCommitments.Amount;


                           //ExternalEffects:=ExternalEffects+ABS(GenJournalLine.Amount);
                           UNTIL PCharges.NEXT = 0;
                           END;





                        UNTIL OtherCommitments.NEXT=0;

                        END;
                        */








                        //I
                        Comms := TCharges - (SpeedCharge + Insurance);

                        NetDeduction := TCharges + AllLoansTopup + SpeedCharge;

                        NetAmount := Loans."Approved Amount" - NetDeduction;

                        LoanAmount := Loans."Approved Amount";


                        TotalSpeedCharge := TotalSpeedCharge + SpeedCharge;
                        TotalInsurance := TotalInsurance + Insurance;
                        TotalCleared := TotalCleared + AllLoansTopup;
                        TotalComms := TotalComms + Comms;
                        TotalNet := TotalNet + NetAmount;
                        TotLoanAmt := TotLoanAmt + LoanAmount;




                    //END;

                    until Loans.Next = 0;

                end;

            end;

            trigger
            OnPreDataItem()
            begin
                compinf.Get();
                compinf.CalcFields(Picture);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
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
        Commission: Decimal;
        ClearedLoans: Decimal;
        Insurance: Decimal;
        LoanAmount: Decimal;
        SpeedCharge: Decimal;
        NetDeduction: Decimal;
        NetAmount: Decimal;
        Loans: Record Loans;
        StartDate: Date;
        EndDate: Date;
        TCharges: Decimal;
        AllLoansTopup: Decimal;
        SpeedChrg: Decimal;
        ExternalEffects: Decimal;
        Comms: Decimal;
        PCharges: Record "Loan Product Charges";
        LoanTopUp: Record "Loans Top up";
        TotPrincLoan: Decimal;
        TotIntOffset: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
        CustRec: Record "Credit Accounts";
        TotalSpeedCharge: Decimal;
        TotalInsurance: Decimal;
        TotalCleared: Decimal;
        TotalComms: Decimal;
        TotalNet: Decimal;
        TotLoanAmt: Decimal;
        NoOfLoans: Integer;
        compinf: Record "Company Information";
}
