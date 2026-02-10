#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185644 "Loan Disbursement Schedule"
{
    // show the following: member no, employer code, applied and approved amount,external clearnce, top up and place to sign
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Disbursement Schedule.rdl';


    dataset
    {
        //dataitem(52185736;52185736)
        dataitem("Loan Disbursement Header"; "Loan Disbursement Header")
        {
            column(ReportForNavId_1; 1)
            {
            }

            column(HeaderNo; "Loan Disbursement Header"."No.")
            {
            }
            column(DisDate; "Loan Disbursement Header"."Date Posted")
            {
            }
            column(TotalAmount_LoanDisbursementHeader; "Loan Disbursement Header"."Total Amount")
            {
            }
            column(GlobalDimension1Code_LoanDisbursementHeader; "Loan Disbursement Header"."Global Dimension 1 Code")
            {
            }
            column(Status_LoanDisbursementHeader; "Loan Disbursement Header".Status)
            {
            }
            column(PaymentType_LoanDisbursementHeader; "Loan Disbursement Header"."Payment Type")
            {
            }
            column(GlobalDimension2Code_LoanDisbursementHeader; "Loan Disbursement Header"."Global Dimension 2 Code")
            {
            }
            column(ResponsibilityCenter_LoanDisbursementHeader; "Loan Disbursement Header"."Responsibility Center")
            {
            }
            column(NoofLoans_LoanDisbursementHeader; "Loan Disbursement Header"."No of Loans")
            {
            }
            column(DateCreated_LoanDisbursementHeader; "Loan Disbursement Header"."Date Created")
            {
            }
            column(PreparedBy_LoanDisbursementHeader; "Loan Disbursement Header"."Prepared By")
            {
            }
            dataitem("Loan Disbursement Lines"; "Loan Disbursement Lines")
            {
                DataItemLink = No = field("No.");
                column(ReportForNavId_12; 12)
                {
                }
                column(PayMode_LoanDisbursementLines; "Loan Disbursement Lines"."Pay Mode")
                {
                }
                column(ChequeNo_LoanDisbursementLines; "Loan Disbursement Lines"."Cheque No")
                {
                }
                column(ChequeDate_LoanDisbursementLines; "Loan Disbursement Lines"."Cheque Date")
                {
                }
                column(BankCode_LoanDisbursementLines; "Loan Disbursement Lines"."Bank Code")
                {
                }
                column(AccountNo_LoanDisbursementLines; "Loan Disbursement Lines"."Account No.")
                {
                }
                column(NoSeries_LoanDisbursementLines; "Loan Disbursement Lines"."No. Series")
                {
                }
                column(AccountName_LoanDisbursementLines; "Loan Disbursement Lines"."Account Name")
                {
                }
                column(Posted_LoanDisbursementLines; "Loan Disbursement Lines".Posted)
                {
                }
                column(DatePosted_LoanDisbursementLines; "Loan Disbursement Lines"."Date Posted")
                {
                }
                column(TimePosted_LoanDisbursementLines; "Loan Disbursement Lines"."Time Posted")
                {
                }
                column(PostedBy_LoanDisbursementLines; "Loan Disbursement Lines"."Posted By")
                {
                }
                column(Amount_LoanDisbursementLines; "Loan Disbursement Lines"."Disbursement Amount")
                {
                }
                column(GlobalDimension1Code_LoanDisbursementLines; "Loan Disbursement Lines"."Global Dimension 1 Code")
                {
                }
                column(LoanNo_LoanDisbursementLines; "Loan Disbursement Lines"."Loan No.")
                {
                }
                column(GlobalDimension2Code_LoanDisbursementLines; "Loan Disbursement Lines"."Global Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    MemberNo := '';
                    EmployerCode := '';
                    Topups := 0;
                    ApprovedAmount := 0;
                    ExternalClearance := 0;
                    AssetFinAmount := 0;

                    CreditAccounts.Reset;
                    CreditAccounts.SetRange("No.", "Loan Disbursement Lines"."Account No.");
                    if CreditAccounts.Find('-') then begin
                        MemberNo := CreditAccounts."Member No.";
                        EmployerCode := CreditAccounts."Employer Code";
                    end;
                    AssetFinanceLoan.Reset;
                    AssetFinanceLoan.SetRange("Loan No.", "Loan Disbursement Lines"."Loan No.");
                    if AssetFinanceLoan.Find('-') then begin
                        AssetFinanceLoan.CalcSums(Amount);
                        AssetFinAmount := AssetFinanceLoan.Amount;
                    end;



                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Loan Disbursement Lines"."Loan No.");
                    if Loans.Find('-') then begin
                        ApprovedAmount := Loans."Approved Amount";
                        NetAmount := LoansProcess.ComputeCharges(Loans."Approved Amount", Loans."Loan Product Type", Loans."Loan No.", 0);
                        if Loans."Net Amount" <> 0 then
                            NetAmount := Loans."Net Amount" - AssetFinAmount;
                        BoostingAmt := Loans."Share Boosted Amount";
                    end;

                    OtherCommitementsClearance.Reset;
                    OtherCommitementsClearance.SetRange("Loan No.", "Loan Disbursement Lines"."Loan No.");
                    if OtherCommitementsClearance.Find('-') then begin
                        OtherCommitementsClearance.CalcSums(Amount);
                        ExternalClearance := OtherCommitementsClearance.Amount;
                        ExternalBank := OtherCommitementsClearance."Vendor Name";
                    end;




                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", "Loan Disbursement Lines"."Loan No.");
                    if LoansTopup.Find('-') then begin
                        LoansTopup.CalcSums("Total Top Up");
                        Topups := LoansTopup."Total Top Up";
                    end;

                    if Loans.Get("Loan Disbursement Lines"."Loan No.") then begin
                        Instalments := Loans.Installments;
                    end;
                    /*
                    IF OtherCommitementsClearance.GET("Loan Disbursement Lines"."Loan No.") THEN BEGIN
                    ExternalBank:=OtherCommitementsClearance."Vendor Name";
                      END;
                      */

                end;

                trigger OnPreDataItem()
                begin
                    /*
                    IF loanapps.GET("Loan Disbursement Lines"."Loan No.") THEN begin
                    TotalComputedCharges:=0;
                    ChargeExtraComms:=FALSE;
                          TopUp.RESET;
                          TopUp.SETRANGE(TopUp."Loan No.",LoanNo);
                          IF TopUp.FIND('-') THEN BEGIN
                            REPEAT
                              IF TopUp."Additional Top Up Commission"=TRUE THEN
                                ChargeExtraComms:=TRUE;
                            UNTIL TopUp.NEXT=0;
                          END;
                    PCharges.RESET;
                    PCharges.SETRANGE(PCharges."Product Code",ProdType);
                    PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::General);
                    IF PCharges.FIND('-') THEN BEGIN
                       REPEAT
                        IF (PCharges."Charge Method"=PCharges."Charge Method"::"% of Amount") THEN
                           TotalComputedCharges:=TotalComputedCharges+(ApprovedAmt *PCharges.Percentage/100)
                        ELSE IF PCharges."Charge Method"=PCharges."Charge Method"::"Flat Amount" THEN
                           TotalComputedCharges:=TotalComputedCharges+PCharges."Charge Amount"
                        ELSE IF PCharges."Charge Method"=PCharges."Charge Method"::Staggered THEN BEGIN
                    
                          PCharges.TESTFIELD(PCharges."Staggered Charge Code");
                    
                          TariffDetails.RESET;
                          TariffDetails.SETRANGE(TariffDetails.Code,PCharges."Staggered Charge Code");
                          IF TariffDetails.FIND('-') THEN BEGIN
                            REPEAT
                            IF (ApprovedAmt >= TariffDetails."Lower Limit") AND (ApprovedAmt <= TariffDetails."Upper Limit") THEN BEGIN
                            IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
                              TotalComputedCharges:=TotalComputedCharges+ApprovedAmt*TariffDetails.Percentage*0.01;
                            END ELSE BEGIN
                            TotalComputedCharges := TotalComputedCharges+TariffDetails."Charge Amount";
                            END;
                            END;
                            UNTIL TariffDetails.NEXT =0;
                          END;
                          END;
                       UNTIL PCharges.NEXT = 0;
                    END;
                    
                    
                    
                    
                      //End of general charges
                    
                    TotalCleared:=0;
                    //Pass loan clearance principle and interest
                       TopUp.RESET;
                       TopUp.SETRANGE(TopUp."Loan No.",LoanNo);
                       IF TopUp.FIND('-') THEN BEGIN
                          REPEAT
                            //TopUp.CALCSUMS(TopUp."Principle Top Up",TopUp."Interest Top Up");
                            TotalCleared:=TotalCleared+TopUp."Principle Top Up"+TopUp."Interest Top Up";
                    
                            PCharges.RESET;
                            PCharges.SETRANGE(PCharges."Product Code",ProdType);
                            PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::"Top up");
                            IF PCharges.FIND('-') THEN BEGIN
                              REPEAT
                    
                               IF (PCharges."Use Percentage" =TRUE) AND (PCharges."Charging Option"=PCharges."Charging Option"::"On Approved Amount") THEN BEGIN
                                IF ChargeExtraComms=TRUE THEN
                                  TotalComputedCharges:=TotalComputedCharges+(ApprovedAmt * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
                                ELSE
                                  TotalComputedCharges:=TotalComputedCharges+( ApprovedAmt* (PCharges.Percentage/100))
                               END ELSE IF (PCharges."Use Percentage" =TRUE) AND (PCharges."Charging Option"=PCharges."Charging Option"::"On Net Amount") THEN BEGIN
                                 IF ChargeExtraComms=TRUE THEN
                                   TotalComputedCharges:=TotalComputedCharges+((TopUp."Principle Top Up"+TopUp."Interest Top Up") * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
                                 ELSE
                                   TotalComputedCharges:=TotalComputedCharges+((TopUp."Principle Top Up"+TopUp."Interest Top Up") * (PCharges.Percentage/100))
                               END ELSE
                                TotalComputedCharges:=TotalComputedCharges+PCharges."Charge Amount";
                    
                       UNTIL PCharges.NEXT = 0;
                       END;
                    UNTIL TopUp.NEXT=0;
                    END;
                    
                    
                    
                    OtherComms:=0;
                    //Clearing external debts
                    OtherCommitments.RESET;
                    OtherCommitments.SETRANGE(OtherCommitments."Loan No.",LoanNo);
                    IF OtherCommitments.FIND('-') THEN BEGIN
                    REPEAT
                      TotalCleared:=TotalCleared+OtherCommitments.Amount;
                    //OtherCommitments.CALCSUMS(OtherCommitments.Amount);
                    OtherComms:=OtherCommitments.Amount;
                    
                    
                    PCharges.RESET;
                    PCharges.SETRANGE(PCharges."Product Code",ProdType);
                    PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::"External Loan");
                    IF PCharges.FIND('-') THEN BEGIN
                       REPEAT
                       IF (PCharges."Use Percentage"=TRUE) THEN BEGIN
                         IF ChargeExtraComms=TRUE THEN
                          TotalComputedCharges :=TotalComputedCharges+(OtherCommitments.Amount * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
                         ELSE
                           TotalComputedCharges :=TotalComputedCharges+(OtherCommitments.Amount * (PCharges.Percentage/100))
                       END ELSE
                           TotalComputedCharges:=TotalComputedCharges+OtherCommitments.Amount;
                    
                       UNTIL PCharges.NEXT = 0;
                    
                       END;
                    UNTIL OtherCommitments.NEXT=0;
                    END;
                    
                    LoanApps.RESET;
                    LoanApps.SETRANGE("Loan No.",LoanNo);
                    IF LoanApps.FIND('-') THEN BEGIN
                      LoanApps."Total Charges and Commissions":=TotalComputedCharges;
                    
                      IF (LoanApps."Appraisal Parameter Type"=LoanApps."Appraisal Parameter Type"::"Check Off") OR (LoanApps."Appraisal Parameter Type"=LoanApps."Appraisal Parameter Type"::"Corporate or Business") THEN
                         TotalComputedCharges:=TotalComputedCharges+LoanApps."Share Boosted Amount";
                    //LoanApps.MODIFY;
                    END;
                    PaySched.RESET;
                    PaySched.SETRANGE(PaySched."Loan No.",LoanNo);
                    IF PaySched.FIND('-') THEN BEGIN
                      PaySched.CALCSUMS(PaySched.Amount);
                      TotalSched:=PaySched.Amount;
                    END;
                    
                    END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyCode.Get;
                CompanyCode.CalcFields(CompanyCode.Picture);


                if ProductType.Get("Loan Disbursement Header"."Loan Product Type") then begin
                    ProductName := ProductType."Product Description";
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

    var
        CompanyCode: Record "Company Information";
        LoanApps: Record Loans;
        CreditAccounts: Record "Credit Accounts";
        MemberNo: Code[20];
        EmployerCode: Code[20];
        Loans: Record Loans;
        ApprovedAmount: Decimal;
        ExternalClearance: Decimal;
        Topups: Decimal;
        NetAmount: Decimal;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        LoansTopup: Record "Loans Top up";
        LoansProcess: Codeunit "Loans Process";
        BoostingAmt: Decimal;
        ProductName: Text;
        ProductType: Record "Product Factory";
        Instalments: Decimal;
        ExternalBank: Text;
        AssetFinanceLoan: Record "Asset Finance Loan";
        AssetFinAmount: Decimal;
}
