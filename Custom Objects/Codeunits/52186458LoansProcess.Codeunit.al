#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52186458 "Loans Process"
{

    trigger OnRun()
    begin
    end;

    var
        AcctNo: Code[20];
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        EndMonth: Date;
        BatchLines: Record "Loan Disbursement Lines";
        LoanApps: Record Loans;
        CustomerRecord: Record Members;
        TopUp: Record "Loans Top up";
        NetTopup: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        TCharges: Decimal;
        LineNo: Integer;
        PaySched: Record "Schedule of Loan Payment";
        PCharges: Record "Loan Product Charges";
        TotalComputedCharges: Decimal;
        TotalCleared: Decimal;
        OtherComms: Decimal;
        Difference: Decimal;
        TotalSched: Decimal;
        RemainingDays: Integer;
        TMonthDays: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Batches: Record "Loan Disbursement Header";
        TotOffset: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        TransType: Enum "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        Amt: Decimal;
        LoanProcess: Codeunit "Loans Process";
        ProdFac: Record "Product Factory";
        Loans2: Record Loans;
        Text0001: label 'The disbursement will exceed approved amount for loan no. %1';
        Descr: Text;
        GenSetup: Record "General Set-Up";
        Members: Record Members;
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        JournalPostingSucc: Codeunit "Journal Post Successful";
        Post: Boolean;
        FirstLoop: Integer;
        NewContr: Decimal;
        Text0002: label 'The amount to disburse must be greater than zero';
        DaysPast: Integer;
        ChargeExtraComms: Boolean;
        Text0003: label 'This member does not have a depoits account : Member No. %1';
        Cust: Record Customer;
        ExcemptCharges: Boolean;
        TariffDetails: Record "Tiered Charges Lines";
        BaseAmount: Decimal;
        GLEntry: Record "G/L Entry";
        TransactionCharges: Record "Transaction Charges";
        TransactionTypes: Record "Transaction Types";
        AssetFinanceLoan: Record "Asset Finance Loan";
        AssetFinComms: Decimal;
        TotalAssetFin: Decimal;
        NetToVendor: Decimal;
        TaxAmnt: Decimal;
        SaccoIncome: Decimal;
        DailyMortgageInterest: Record "Daily Mortgage Interest Buffer";
        BridgLoan: Decimal;
        BLoanNo: Code[20];
        BLoanRec: Record Loans;
        TotalTopUpCharges: Decimal;
        msg: Text;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        ProdFacTopup: Record "Product Factory";
        ExcemptProductCharges: record "Excempted Product Charges";



    procedure CreateLoanAccount(MemberNo: Code[20]; ProdType: Code[20]) LoanAcc: Code[20]
    var
        ProdFac: Record "Product Factory";
        Loans: Record Loans;
        Accounts: Record "Credit Accounts";
        Member: Record Members;
    begin

        if ProdFac.Get(ProdType) then begin
            if (ProdFac."Nature of Loan Type" = ProdFac."nature of loan type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."nature of loan type"::" ") then begin
                //if Confirm('Are you sure you want to create Loan Account', true) = false then
                //     exit;
            end;


            AcctNo := ProdFac."Account No. Prefix" + MemberNo + ProdFac."Account No. Suffix";


            if Accounts.Get(AcctNo) then
                //   Error('The account no. %1 for %2 already exists', Accounts."No.", Accounts.Name);
                exit(AcctNo);

            if Member.Get(MemberNo) then begin

                Accounts.Init;
                Accounts."No." := AcctNo;
                Accounts."Date of Birth" := Member."Date of Birth";
                Accounts.Name := Member."First Name" + ' ' + Member."Middle Name" + ' ' + Member."Other Names";
                Accounts.Validate(Accounts.Name);
                Accounts."ID No." := Member."Primary Identification";
                Accounts."Mobile Phone No" := Member."Phone No.";
                Accounts."Member No." := MemberNo;
                Accounts."Passport No." := Member."Secondary Identification";
                Accounts."Employer Code" := Member."Employer Code";
                Accounts.Status := Accounts.Status::New;
                Accounts."Account Category" := Member."Account Category";
                Accounts."Date of Birth" := Member."Date of Birth";
                Accounts."Current Address" := Member."Current Address";
                Accounts.City := Member.City;
                Accounts."Phone No." := Member."Phone No.";
                Accounts."Post Code" := Member."Post Code";
                Accounts.County := Member.County;
                Accounts."E-Mail" := Member."E-Mail";
                Accounts."Product Type" := ProdFac."Product ID";//*
                Accounts."Product Name" := ProdFac."Product Description";
                Accounts."Customer Posting Group" := ProdFac."Product Posting Group";
                Accounts.Insert(true);
            end;
            exit(AcctNo);
        end;
    end;

    procedure ComputeCharges(ApprovedAmt: Decimal; ProdType: Code[20]; LoanNo: Code[50]; CurrValue: Decimal): Decimal
    var
        upfrontrate: Decimal;
        TotalInterest: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
        ChargeAmount: Decimal;
        TotalCharges: Decimal;
        TotalExciseDuty: Decimal;
        ExciseDuty: Decimal;
        Balance: Decimal;
    begin
        ExciseDuty := 0;
        TotalExciseDuty := 0;
        TotalCharges := 0;
        ChargeAmount := 0;
        Balance := 0;
        TotalInterest := 0;
        // Form Fees
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProdType);
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Form Fees");
        if PCharges.Find('-') then begin
            repeat
                ExcemptProductCharges.Reset();
                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                ExcemptProductCharges.setrange(Excempt, true);
                if not ExcemptProductCharges.Find('-') then begin
                    //Non Prorate
                    if PCharges.Prorate = PCharges.Prorate::" " then begin

                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            ChargeAmount := (ApprovedAmt * (PCharges.Percentage / 100))
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                ChargeAmount := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                    PCharges.TestField(PCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            end
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                        TotalCharges += ChargeAmount;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.TestField("Excise Duty G/L");
                            GenSetup.TestField("Excise Duty (%)");
                            ExciseDuty := ChargeAmount * GenSetup."Excise Duty (%)" * 0.01;

                            TotalExciseDuty += ExciseDuty;
                        end;
                    end;
                end;

            until PCharges.Next = 0;
        end;


        // Form Fees
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProdType);
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Insurance Fees");
        if PCharges.Find('-') then begin
            repeat
                ExcemptProductCharges.Reset();
                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                ExcemptProductCharges.setrange(Excempt, true);
                if not ExcemptProductCharges.Find('-') then begin
                    //Non Prorate
                    if PCharges.Prorate = PCharges.Prorate::" " then begin

                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            ChargeAmount := (ApprovedAmt * (PCharges.Percentage / 100))
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                ChargeAmount := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                    PCharges.TestField(PCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (ApprovedAmt >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := ApprovedAmt * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            end
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                        TotalCharges += ChargeAmount;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.TestField("Excise Duty G/L");
                            GenSetup.TestField("Excise Duty (%)");
                            ExciseDuty := ChargeAmount * GenSetup."Excise Duty (%)" * 0.01;

                            TotalExciseDuty += ExciseDuty;
                        end;
                    end;
                end;

            until PCharges.Next = 0;
        end;



        // Form Fees
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProdType);
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
        if PCharges.Find('-') then begin
            repeat
                ExcemptProductCharges.Reset();
                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                ExcemptProductCharges.setrange(Excempt, true);
                if not ExcemptProductCharges.Find('-') then begin
                    //Non Prorate
                    if PCharges.Prorate = PCharges.Prorate::" " then begin

                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            ChargeAmount := (ApprovedAmt * (PCharges.Percentage / 100))
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                ChargeAmount := PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                    PCharges.TestField(PCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := ApprovedAmt * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            end
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                        TotalCharges += ChargeAmount;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                            GenSetup.TestField("Excise Duty G/L");
                            GenSetup.TestField("Excise Duty (%)");
                            ExciseDuty := ChargeAmount * GenSetup."Excise Duty (%)" * 0.01;

                            TotalExciseDuty += ExciseDuty;
                        end;
                    end;
                end;

            until PCharges.Next = 0;
        end;

        // Get upfront INTEREST
        IF ProdFac.Get(ProdType) then begin
            if ProdFac."Interest Recovered Upfront" then begin
                upfrontrate := ProdFac."Upfront Interest Rate";
                if upfrontrate <> 0 then begin
                    TotalInterest += Round(((upfrontrate / 100) * ApprovedAmt), 0.01, '>');
                end;
            end;
        end;

        Balance := ApprovedAmt - (TotalCharges + TotalExciseDuty + TotalInterest);

        if Balance < 0 then
            Balance := 0;

        exit(Balance);

    end;


    procedure PostDiscounting(LoanNo: Code[20]; DiscAmt: Decimal)
    var
        Loans: Record Loans;
        Loan2: Record Loans;
        LoanAcc: Code[20];
        Text0001: label 'The main Loan must be approved before discounting';
        Text0002: label 'There is no product defined for discounting';
        LoanPaymentOptions: Record "Schedule of Loan Payment";
    begin
        if Loans.Get(LoanNo) then begin
            if Loans.Status <> Loans.Status::Approved then
                Error(Text0001);


            //Create account for the loan
            ProdFac.Reset;
            ProdFac.SetRange(ProdFac."Type of Discounting", ProdFac."type of discounting"::"Loan Discounting");
            if ProdFac.Find('-') then begin

                if DiscAmt > 0 then begin
                    Loan2.Init;
                    Loan2."Application Date" := Today;
                    Loan2."Amount To Disburse" := DiscAmt;
                    Loan2."Approval Date" := Today;
                    //Loan2."Approved Amount":=DiscAmt;
                    Loan2."Member Name" := Loans."Member Name";
                    Loan2."Member No." := Loans."Member No.";
                    Loan2."Disbursement Date" := Today;
                    Loan2."Loan Product Type" := ProdFac."Product ID";
                    Loan2.Validate(Loan2."Loan Product Type");
                    Loan2."Disbursement Account No" := Loans."Disbursement Account No";
                    LoanAcc := '';
                    if Loan2."Loan Account" = '' then begin
                        //Loan2.TESTFIELD(Loans."Member No.",Loans."Loan Product Type");
                        LoanAcc := LoanProcess.CreateLoanAccount(Loans."Member No.", Loan2."Loan Product Type");
                        Loan2."Loan Account" := LoanAcc;
                    end;
                    Loan2."Recommended Amount" := DiscAmt;
                    Loan2."Requested Amount" := DiscAmt;
                    Loan2.Validate(Loan2."Requested Amount");
                    Loan2."Captured By" := UserId;
                    Loan2."Discounted Loan No." := Loans."Loan No.";
                    Loan2."Employer Code" := Loans."Employer Code";
                    Loan2."Fully Disbursed" := true;
                    Loan2."Installment Period" := Loans."Installment Period";
                    Loan2.Status := Loan2.Status::Approved;
                    Loan2.Validate(Loan2."Loan No.");
                    Loan2.Insert(true);

                    //Insert total to be posted under loan payment options
                    LoanPaymentOptions.Init;
                    LoanPaymentOptions."Loan No." := Loan2."Loan No.";
                    //LoanPaymentOptions."Payment Options":=LoanPaymentOptions."Payment Options"::;
                    LoanPaymentOptions.Amount := DiscAmt;
                    LoanPaymentOptions.Insert(true);


                    //MESSAGE('Disc Loan No. %1',Loan2."Loan No.");
                    LoanProcess.PostSingleLoan(Loan2."Loan No.");

                end;
            end else begin
                Error(Text0002);
            end
        end;
    end;


    procedure PostSingleLoan(LoanNo: Code[20])
    var
        Msaccocharge: Decimal;
        Msaccoacc: Code[20];
        MsaccoChargesSetup: Record "M-SACCO Account Setup";
        LoanApp: Record Loans;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        BaseAmount: Decimal;
        OtherLoans: Record Loans;
        DedAmount: decimal;
        OtherCommitments: Record "Other Commitements Clearance";
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Cash Office Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in the Cash Office Setup')
        end;

        //PRORATED DAYS
        EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := Date2dmy(EndMonth, 1);
        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;



        if LoanApps.Get(LoanNo) then begin
            GenSetup.Get;
            if CustomerRecord.Get(LoanApps."Member No.") then begin

                if LoanApps.Status <> LoanApps.Status::Approved then
                    Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan No.");
                ///RunningDate:=Batches."Posting Date";
                //Generate and post Approved Loan Amount
                if not GenBatch.Get(Jtemplate, JBatch) then begin
                    GenBatch.Init;
                    GenBatch."Journal Template Name" := Jtemplate;
                    GenBatch.Name := JBatch;
                    GenBatch.Insert;
                end;

                AccType := Acctype::Credit;
                AccNo := LoanApps."Loan Account";
                TransType := Transtype::Loan;
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                Amt := 0;
                LineNo := LineNo + 10000;
                Descr := '';
                Descr := ProdFac."Product Description" + ' ' + 'Loan';
                Descr := CopyStr(Descr, 1, 50);
                //Approved amount
                if LoanApps."Approved Amount" > 0 then
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, LoanApps."Amount To Disburse", AccNo, Today, BalAccType,
                  BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                if LoanApps."Mode of Disbursement" = LoanApps."mode of disbursement"::"Full Disbursement" then begin
                    PaySched.Reset;
                    PaySched.SetRange(PaySched."Loan No.", LoanApps."Loan No.");
                    if PaySched.Find('-') then begin
                        repeat
                            if (PaySched."Payment Options" = PaySched."payment options"::"M-PESA") or (PaySched."Payment Options" = PaySched."payment options"::"M-PESA") then begin
                                AccNo := '';
                                Amt := 0;
                                AccType := Acctype::"Bank Account";
                                if LoanApps."All Posting through Savings Ac" = true then begin
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                end else begin
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                end;
                                if PaySched."Payment Options" = PaySched."payment options"::"M-PESA" then
                                    AccNo := Temp."MPESA Disbursement A/c"
                                else
                                    AccNo := Temp."Cheque Disbursement A/c";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                LineNo := LineNo + 10000;
                                Descr := '';
                                Descr := ProdFac."Product Description" + ' ' + 'Loan';
                                Descr := CopyStr(Descr, 1, 50);
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -PaySched.Amount, AccNo,
                                Today, BalAccType, BalAccNo, '', '', '', TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end else begin
                                AccNo := LoanApps."Disbursement Account No";
                                AccType := Acctype::Savings;
                                BalAccType := Balacctype::"G/L Account";
                                BalAccNo := '';
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::"G/L Account";
                                LineNo := LineNo + 10000;
                                Descr := '';
                                Descr := ProdFac."Product Description" + ' ' + 'Loan';
                                Descr := CopyStr(Descr, 1, 50);
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -LoanApps."Amount To Disburse", AccNo,
                               Today, BalAccType, BalAccNo, '', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        until PaySched.Next = 0;
                    end else begin
                        //ERROR('Payment schedule must be provided');
                        AccNo := LoanApps."Disbursement Account No";
                        AccType := Acctype::Savings;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        LineNo := LineNo + 10000;
                        Descr := '';
                        Descr := ProdFac."Product Description" + ' ' + 'Loan';
                        Descr := CopyStr(Descr, 1, 50);
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -LoanApps."Amount To Disburse", AccNo,
                       Today, BalAccType, BalAccNo, '', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;
                end else begin
                    /*Yet to come
                    */



                end;


                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanApps."Loan No.");
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            AccNo := PCharges."Charges G_L Account";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::Savings;
                            BalAccNo := LoanApps."Disbursement Account No";
                            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                    Amt := PCharges."Charge Amount"
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                        PCharges.TestField(PCharges."Staggered Charge Code");

                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                        if TariffDetails.Find('-') then begin
                                            repeat
                                                if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        Amt := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;


                            if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                Amt := PCharges.Minimum;
                            if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                Amt := PCharges.Maximum;

                            Amt := Amt * -1;



                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, Today, BalAccType,
                          BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            //If excise duty involved
                            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                GenSetup.TestField("Excise Duty G/L");
                                GenSetup.TestField("Excise Duty (%)");
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := GenSetup."Excise Duty G/L";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description" + '- Excise Duty', Amt, AccNo, Today, BalAccType,
                                BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                            end;

                        end;
                    until PCharges.Next = 0;

                end;


                if LoanApps."Picked Mobile Loan" = true then begin
                    //Mobile Loans
                    MsaccoChargesSetup.Reset;
                    MsaccoChargesSetup.SetRange(MsaccoChargesSetup."Account Type", 'MOBILE');
                    if MsaccoChargesSetup.Find('-') then begin
                        MsaccoChargesSetup.TestField(MsaccoChargesSetup."Vendor No");
                        Msaccocharge := MsaccoChargesSetup.ChargeAmount;
                        Msaccoacc := MsaccoChargesSetup."Vendor No";
                    end;

                    //Dr Vendor Share Paid +++++++++++++++++++++++++
                    LineNo := LineNo + 10000;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Savings, LoanNo, 'EMR Loan Msacco Fee: ' + LoanApps."Loan No.", Msaccocharge
                    , LoanApps."Disbursement Account No", Today, Balacctype::"G/L Account", '', 'MSACCO LOANS', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code",
                    Transtype::" ", LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Cr Vendor Share Paid +++++++++++++++++++++++++
                    LineNo := LineNo + 10000;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Vendor, LoanNo, 'EMR Loan Msacco Fee : ' + LoanApps."Loan No.", Msaccocharge * -1
                    , Msaccoacc, Today, Balacctype::"G/L Account", '', 'MSACCO LOANS', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code",
                    Transtype::" ", LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                end;




                TotalCleared := 0;
                BridgLoan := 0;

                TopUp.Reset;
                TopUp.SetRange(TopUp."Loan No.", LoanApps."Loan No.");
                if TopUp.Find('-') then begin
                    repeat
                        TopUp.Validate(TopUp."Loan Top Up");



                        //Loan repayment
                        TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";



                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := TopUp."Loan Account";
                        TransType := Transtype::Repayment;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := TopUp."Principle Top Up" * -1;

                        // AdviceLoan(TopUp."Loan Top Up", true, LoanNo);


                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Top up Principle ' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                      BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        //Clear bills
                        if LoanApp.Get(TopUp."Loan Top Up") then begin
                            BaseAmount := 0;
                            if ProdFac.Get(LoanApp."Loan Product Type") then begin
                                LineNo := LineNo + 10000;
                                AccType := Acctype::Credit;
                                AccNo := TopUp."Loan Account";
                                TransType := Transtype::Bills;
                                BalAccType := Balacctype::"G/L Account";
                                BalAccNo := ProdFac."Billed Account";
                                Amt := TopUp."Outstanding Bill" * -1;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Outs. Bill' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                              BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end;

                        //Interest

                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := TopUp."Loan Account";
                        TransType := Transtype::"Interest Paid";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := (TopUp."Interest Top Up" + TopUp."Untransfered Interest") * -1;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Top up Interest ' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                        BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                        if PCharges.Find('-') then begin
                            repeat
                                ExcemptProductCharges.Reset();
                                ExcemptProductCharges.SetRange("Loan No.", LoanApps."Loan No.");
                                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                                ExcemptProductCharges.setrange(Excempt, true);
                                if not ExcemptProductCharges.Find('-') then begin
                                    if PCharges."Charging Option" = PCharges."Charging Option"::"On Approved Amount" then
                                        BaseAmount := LoanApp."Approved Amount" else
                                        BaseAmount := TopUp."Total Top Up";
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := PCharges."Charges G_L Account";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                        Amt := (BaseAmount * (PCharges.Percentage / 100))

                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                            Amt := PCharges."Charge Amount"
                                        else
                                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                                PCharges.TestField(PCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (BaseAmount >= TariffDetails."Lower Limit") and (BaseAmount <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                Amt := BaseAmount * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                Amt := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    Amt := Amt * -1;



                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + ':' + LoanApps."Loan No."), 1, 50), Amt, AccNo, Today, BalAccType,
                                  BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    //If excise duty involved
                                    if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                        GenSetup.TestField("Excise Duty G/L");
                                        GenSetup.TestField("Excise Duty (%)");
                                        LineNo := LineNo + 10000;
                                        AccType := Acctype::"G/L Account";
                                        AccNo := GenSetup."Excise Duty G/L";
                                        TransType := Transtype::" ";
                                        BalAccType := Balacctype::Savings;
                                        BalAccNo := LoanApps."Disbursement Account No";
                                        Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description" + '- Excise Duty', Amt, AccNo, Today, BalAccType,
                                        BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                    end;

                                end;
                            until PCharges.Next = 0;

                        end;


                    until TopUp.Next = 0;
                end;

                if TotalCleared > 0 then begin
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := LoanApps."Disbursement Account No";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Total Loan Offset- Loan Clearance Facility'), 1, 50), TotalCleared, AccNo, Today, BalAccType,
                    BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                end;

                //Balancing entry if disbursed via Savings
                //END;

                //GL
                //Added 06.05.2021
                if BridgLoan > 0 then begin
                    if BridgLoan > 50000 then BridgLoan := 50000;
                    LineNo := LineNo + 10000;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::"G/L Account", LoanNo, PCharges."Charge Description", -BridgLoan, TopUPGL, Today, BalAccType,
                    BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    BLoanNo := CreateBridgingLoan(LoanApps."Member No.", TotalCleared);
                    if BLoanNo <> '' then begin
                        if BLoanRec.Get(BLoanNo) then begin

                            AccType := Acctype::Credit;
                            AccNo := BLoanRec."Loan Account";
                            TransType := Transtype::Loan;
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';

                            LineNo := LineNo + 10001;
                            Descr := BLoanRec."Loan Product Type Name";

                            //Approved amount
                            if BLoanRec."Approved Amount" > 0 then begin

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, TotalCleared, AccNo, Today, BalAccType,
                                BalAccNo, BLoanRec."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                //TotalTopUpCharges += BLoanRec."Approved Amount";

                                BLoanRec.Posted := true;
                                BLoanRec.Modify(true);
                                //Bridging Loan Recovery

                                Members.Get(BLoanRec."Member No.");
                                /*IF MemberCat.GET(Members."Member Class") THEN
                                BEGIN*/
                                //MESSAGE(MemberCat."No.");
                                //ERROR(FORMAT(BLoanRec."Approved Amount"));
                                //IF MemberCat."Recover Fully on Bridging"=TRUE THEN BEGIN
                                LineNo := LineNo + 10001;
                                Descr := BLoanRec."Loan Product Type Name" + '- Repayment';
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Credit, LoanNo, Descr, TotalCleared * -1, BLoanRec."Loan Account", Today, BalAccType,
                                BalAccNo, BLoanRec."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                //Debit Fosa

                                LineNo := LineNo + 10001;
                                Descr := BLoanRec."Loan Product Type Name" + '- Interest Paid';
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Savings, LoanNo, Descr, BridgLoan * 1, LoanApps."Disbursement Account No", Today, BalAccType,
                                '', '', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", Transtype::" ", BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                //Interest Due
                                LineNo := LineNo + 10000;
                                Descr := BLoanRec."Loan Product Type Name" + '- Interest Due';
                                TransType := Transtype::"Interest Due";
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, BridgLoan, AccNo, Today, BalAccType,
                                BalAccNo, BLoanRec."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                //Interest Paid
                                LineNo := LineNo + 10000;
                                Descr := BLoanRec."Loan Product Type Name" + '- Interest Paid';
                                TransType := Transtype::"Interest Paid";
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, BridgLoan * -1, AccNo, Today, BalAccType,
                                BalAccNo, BLoanRec."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                // END;
                                //END;

                            end;
                        end;
                    end;
                    //END;
                    //End of 06.05.2021 Additions
                end;




                OtherComms := 0;
                //Clearing external debts
                OtherCommitments.Reset;
                OtherCommitments.SetRange(OtherCommitments."Loan No.", LoanApps."Loan No.");
                if OtherCommitments.Find('-') then begin
                    repeat
                        //  Temp.TestField(Temp."Bankers Cheque Account");

                        TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";
                        LineNo := LineNo + 10000;
                        AccType := OtherCommitments."Account Type";// Acctype::"Bank Account";
                        AccNo := OtherCommitments."Vendor No.";//Temp."Bankers Cheque Account";
                        TransType := Transtype::" ";
                        if LoanApps."All Posting through Savings Ac" = true then begin
                            BalAccType := Balacctype::Savings;
                            BalAccNo := LoanApps."Disbursement Account No";
                        end else begin
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                        end;

                        if OtherCommitments.Description = '' then
                            OtherCommitments.Description := 'External Loan Cleared';

                        if OtherCommitments."Account Type" = OtherCommitments."Account Type"::Credit then begin
                            OtherLoans.Get(OtherCommitments."Loan No.");
                            OtherLoans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            if OtherLoans."Outstanding Interest" > OtherCommitments.Amount then
                                OtherLoans."Outstanding Interest" := OtherCommitments.Amount;
                            if OtherLoans."Outstanding Interest" > 0 then
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, OtherCommitments.Description, OtherLoans."Outstanding Interest" * -1, AccNo, Today, BalAccType,
                                BalAccNo, OtherLoans."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::"Interest Paid", TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            DedAmount := OtherCommitments.Amount - OtherLoans."Outstanding Interest";
                            //Recover Principle
                            if DedAmount > 0 then begin
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, OtherCommitments.Description, DedAmount * -1, AccNo, Today, BalAccType,
                                BalAccNo, OtherLoans."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::Repayment, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end else begin
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, OtherCommitments.Description, OtherCommitments.Amount * -1, AccNo, Today, BalAccType,
                             BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;

                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
                        if PCharges.Find('-') then begin
                            repeat
                                ExcemptProductCharges.Reset();
                                ExcemptProductCharges.SetRange("Loan No.", LoanApps."Loan No.");
                                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                                ExcemptProductCharges.setrange(Excempt, true);
                                if not ExcemptProductCharges.Find('-') then begin
                                    PCharges.TestField(PCharges."Charges G_L Account");

                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := PCharges."Charges G_L Account";
                                    TransType := Transtype::" ";
                                    if LoanApps."All Posting through Savings Ac" = true then begin
                                        BalAccType := Balacctype::Savings;
                                        BalAccNo := LoanApps."Disbursement Account No";
                                    end else begin
                                        BalAccType := Balacctype::"G/L Account";
                                        BalAccNo := '';
                                    end;
                                    if (PCharges."Use Percentage" = true) then
                                        Amt := (OtherCommitments.Amount * (PCharges.Percentage / 100))
                                    else
                                        Amt := OtherCommitments.Amount;

                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    Amt := Amt * -1;



                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, Today, BalAccType,
                                   BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                        GenSetup.TestField("Excise Duty G/L");
                                        GenSetup.TestField("Excise Duty (%)");
                                        LineNo := LineNo + 10000;
                                        AccType := Acctype::"G/L Account";
                                        AccNo := GenSetup."Excise Duty G/L";
                                        TransType := Transtype::" ";
                                        BalAccType := Balacctype::Savings;
                                        BalAccNo := LoanApps."Disbursement Account No";
                                        Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, Today, BalAccType,
                                        BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                    end;

                                end;

                            until PCharges.Next = 0;
                        end;
                    until OtherCommitments.Next = 0;
                end;

                //Get if interest due is posted on disbursement from setups

                if ProdFac.Get(LoanApps."Loan Product Type") then begin
                    if ProdFac."Compute Interest Due on Postin" = ProdFac."compute interest due on postin"::"Full Interest" then begin
                        Amt := 0;
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := LoanApps."Loan Account";
                        TransType := Transtype::"Interest Due";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := ProdFac."Loan Interest Account [G/L]";
                        Amt := LoanApps."Amount To Disburse" * LoanApps.Interest / 12 * 0.01;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                        BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end else
                        if ProdFac."Compute Interest Due on Postin" = ProdFac."compute interest due on postin"::"Pro-rata" then begin
                            //PRORATED DAYS
                            EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
                            RemainingDays := DaysPast + (EndMonth - Today) + 1;
                            TMonthDays := Date2dmy(EndMonth, 1);
                            Amt := 0;
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Credit;
                            AccNo := LoanApps."Loan Account";
                            TransType := Transtype::"Interest Due";
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := ProdFac."Loan Interest Account [G/L]";
                            Amt := LoanApps."Amount To Disburse" * LoanApps.Interest / 12 * 0.01 * RemainingDays / TMonthDays;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                            BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        end else
                            IF ProdFac."Compute Interest Due on Postin" = ProdFac."Compute Interest Due on Postin"::"Full Period Interest" THEN BEGIN
                                Amt := 0;
                                LineNo := LineNo + 10000;
                                AccType := AccType::Credit;
                                AccNo := LoanApps."Loan Account";
                                TransType := TransType::"Interest Due";
                                BalAccType := BalAccType::"G/L Account";
                                BalAccNo := ProdFac."Loan Interest Account [G/L]";
                                Amt := LoanApps."Amount To Disburse" * LoanApps.Interest / 12 * 0.01 * LoanApps.Installments;
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                            BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            END;

                    //Bill if Upfront Bill
                    if ProdFac."Compute Bills on Posting" = ProdFac."compute bills on posting"::"Full Amount" then begin
                        Amt := 0;
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := LoanApps."Loan Account";
                        TransType := Transtype::Bills;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := ProdFac."Billed Account";
                        Amt := LoanApps."Amount To Disburse";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Bills' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                        BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end else
                        if ProdFac."Compute Bills on Posting" = ProdFac."compute bills on posting"::"One Installment" then begin
                            Amt := 0;
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Credit;
                            AccNo := LoanApps."Loan Account";
                            TransType := Transtype::Bills;
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := ProdFac."Billed Account";
                            Amt := LoanApps.Repayment - LoanApps."Loan Interest Repayment";
                            if Amt > 0 then begin
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Bills' + LoanApps."Loan No.", Amt, AccNo, Today, BalAccType,
                                BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end;

                end;
                GenSetup.Get;
                Members.Get(LoanApps."Member No.");
                if GenSetup."Disable Loan SMS" = false then
                    msg := 'Your Loan of ' + Format(LoanApps."Approved Amount") + ' ' + 'has been credited to your account';

                SendSMS.SendSms(Source::LOAN_POSTED, Members."Phone No.", msg, Format(LoanApps."Disbursement Account No"), '', true, 0, false, 'CBS', LoanApps."Disbursement Account No", 'CBS');


                LoanApps.Advice := true;
                LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                LoanApps."Disbursement Date" := Today;
                LoanApps.Validate("Disbursement Date");
                LoanApps.Posted := true;
                // DepositProrata(LoanApps."Loan No.");
                LoanApps.Modify(true);

                // AdviceLoan(LoanApps."Loan No.", false, LoanApps."Loan No.")

            end;
        end;





        //Post New
        /*GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
        GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
        IF GenJournalLine.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
        END;*/

        JournalPosting.CompletePosting(Jtemplate, JBatch);

        Commit;

        if LoanApps."Picked Mobile Loan" = false then
            Message('Posted successfully.');

    end;


    procedure "PostLoan Subsequent Disbursements"(BatchNo: Code[20])
    var
        PartialDisb: Record "Partial Disbursement Schedule";
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Cash Office Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in the Cash Office Setup')
        end;

        //PRORATED DAYS


        EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := Date2dmy(EndMonth, 1);
        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;



        BatchLines.Reset;
        BatchLines.SetRange(BatchLines.No, BatchNo);
        BatchLines.SetRange(BatchLines.Posted, false);
        if BatchLines.Find('-') then
            repeat
                if LoanApps.Get(BatchLines."Loan No.") then begin
                    ProdFac.Get(LoanApps."Loan Product Type");
                    if CustomerRecord.Get(LoanApps."Member No.") then begin

                        if LoanApps.Posted = false then
                            Error('Loan status must be posted for you to process this. - ' + LoanApps."Loan No.");

                        //check balance for Jenga loan
                        if ProdFac."Mortgage Loan" = true then
                            "CheckDisbursementA/CBalanceForMortgage"(LoanApps."Disbursement Account No");


                        ///RunningDate:=Batches."Posting Date";

                        //Generate and post Approved Loan Amount
                        if not GenBatch.Get(Jtemplate, JBatch) then begin
                            GenBatch.Init;
                            GenBatch."Journal Template Name" := Jtemplate;
                            GenBatch.Name := JBatch;
                            GenBatch.Insert;
                        end;

                        //Check that loan not fully disburses
                        LoanApps.CalcFields(LoanApps."Total Disbursed");

                        if LoanApps."Total Disbursed" + BatchLines."Disbursement Amount" > LoanApps."Approved Amount" then
                            Error(Text0001, LoanApps."Loan No.");


                        AccType := Acctype::Credit;
                        AccNo := LoanApps."Loan Account";
                        TransType := Transtype::Loan;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Amt := 0;
                        LineNo := LineNo + 10000;
                        Descr := '';
                        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
                        Descr := CopyStr(Descr, 1, 50);

                        //Approved amount
                        if BatchLines."Disbursement Amount" > 0 then
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BatchNo, Descr, BatchLines."Disbursement Amount", AccNo, Today, BalAccType,
                          BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                        PartialDisb.Reset;
                        PartialDisb.SetRange(PartialDisb."Loan No.", BatchLines."Loan No.");
                        PartialDisb.SetRange(PartialDisb."Entry No", BatchLines."Disbursement Serial - PD");
                        if PartialDisb.Find('-') then begin
                            if (PartialDisb."Disbursement Destination" = PartialDisb."disbursement destination"::Cheque) or (PartialDisb."Disbursement Destination" = PartialDisb."disbursement destination"::MPesa) then begin


                                AccNo := '';
                                Amt := 0;
                                AccType := Acctype::"Bank Account";

                                if PartialDisb."Disbursement Destination" = PartialDisb."disbursement destination"::MPesa then
                                    AccNo := Temp."MPESA Disbursement A/c"
                                else
                                    AccNo := Temp."Cheque Disbursement A/c";
                                TransType := Transtype::" ";
                                LineNo := LineNo + 10000;
                                Descr := '';
                                Descr := ProdFac."Product Description" + ' ' + 'Loan';
                                Descr := CopyStr(Descr, 1, 50);
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BatchNo, Descr, -PartialDisb.Amount, AccNo,
                                Today, BalAccType, BalAccNo, '', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                            end else begin

                                AccNo := LoanApps."Disbursement Account No";
                                AccType := Acctype::Savings;
                                BalAccType := Balacctype::"G/L Account";
                                BalAccNo := '';
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::"G/L Account";
                                LineNo := LineNo + 10000;
                                Descr := '';
                                Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
                                Descr := CopyStr(Descr, 1, 50);
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BatchNo, Descr, -PartialDisb.Amount, AccNo,
                                Today, BalAccType, BalAccNo, '', LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        end;



                    end;
                end;
            until BatchLines.Next = 0;




        //Post New
        JournalPosting.CompletePosting(Jtemplate, JBatch);


        //Update if succefully posted

        //IF Batches.GET(BatchNo) THEN BEGIN
        Post := false;
        Post := JournalPostingSucc.PostedSuccessfully;
        //END;

        if Post = true then begin
            BatchLines.Reset;
            BatchLines.SetRange(No, BatchNo);
            if BatchLines.Find('-') then begin
                repeat
                    // LoanApps.Reset;
                    // LoanApps.SetRange("Batch No.", BatchNo);
                    // if LoanApps.Find('-') then begin
                    //     repeat
                    //         LoanApps.Advice := true;
                    //         LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                    //         LoanApps.Posted := true;
                    //         DepositProrata(LoanApps."Loan No.");
                    //         LoanApps."Disbursement Date" := Today;
                    //         AdviceLoan(LoanApps."Loan No.", false, LoanApps."Loan No.");
                    //     until LoanApps.Next = 0;
                    // end;
                    BatchLines."Time Posted" := Time;
                    BatchLines."Date Posted" := Today;
                    BatchLines.Posted := true;
                    if Batches.Get(BatchNo) then begin
                        Batches.Posted := true;
                        Batches."Posted By" := UserId;
                        Batches.Modify;
                        Commit;
                    end;




                    PartialDisb.Reset;
                    PartialDisb.SetRange(PartialDisb."Loan No.", BatchLines."Loan No.");
                    PartialDisb.SetRange(PartialDisb."Entry No", BatchLines."Disbursement Serial - PD");
                    if PartialDisb.Find('-') then begin
                        PartialDisb."Date Posted" := Today;
                        PartialDisb."Time Posted" := Time;
                        PartialDisb."Posted By" := UserId;
                        PartialDisb.Posted := true;
                        PartialDisb.Modify;
                        Commit;
                    end;

                until BatchLines.Next = 0;
            end;
        end;

    end;


    procedure PostLien(PeriodFilter: Date; LoanApp: Record Loans)
    var
        SavingsAccounts: Record "Savings Accounts";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        Amt: Decimal;
        RunBal: Decimal;
        BaseAmount: Decimal;
    begin
        Temp.Get(UserId);
        Temp.TestField(Temp."Loans Template");
        Temp.TestField(Temp."Loans Batch");

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Loan No.", LoanApp."Loan No.");
        LoanApps.SetFilter(LoanApps.Posted, '%1', true);
        LoanApps.SetFilter(LoanApps."Date Filter", '%1', PeriodFilter);
        if LoanApps.Find('-') then begin
            LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Bills", LoanApps."Outstanding Balance");
            if (LoanApps."Outstanding Bills" > 0) or (LoanApps."Outstanding Interest" > 0) then begin

                if SavingsAccounts.Get(LoanApps."Disbursement Account No") then begin
                    SavingsAccounts.SetFilter(SavingsAccounts.Blocked, '%1', SavingsAccounts.Blocked::" ");
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)", SavingsAccounts."Authorised Over Draft",
                                               SavingsAccounts."Uncleared Cheques", SavingsAccounts."ATM Transactions");
                    GlobalDim1 := SavingsAccounts."Global Dimension 1 Code";
                    GlobalDim2 := SavingsAccounts."Global Dimension 2 Code";

                    if ProductFactory.Get(SavingsAccounts."Product Type") then
                        AvailableBal := (SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                                       (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" + ProductFactory."Minimum Balance" + TCharges);


                    if LoanApps."Outstanding Interest" > 0 then begin
                        if AvailableBal > LoanApps."Outstanding Interest" then
                            Amt := LoanApps."Outstanding Interest"
                        else
                            Amt := AvailableBal;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Interest Due Lien' + LoanApps."Loan No.", -Amt, AccNo, Today, BalAccType,
                                                   BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        RunBal -= Abs(Amt);
                    end;

                    if LoanApps."Outstanding Bills" > 0 then begin
                        if RunBal > LoanApps."Outstanding Bills" then
                            Amt := LoanApps."Outstanding Bills"
                        else
                            Amt := RunBal;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Repayment - Lien' + LoanApps."Loan No.", -Amt, AccNo, Today, BalAccType,
                                                   BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, SavingsAccounts."No.", 'Repayment - Lien' + LoanApps."Loan No.", -Amt, AccNo, Today, BalAccType,
                                               BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                end;

            end;

        end;
    end;


    procedure BusinessLoan(Loans: Record Loans)
    var
        BusinessIncome: Record "Business Income";
        ProductFactory: Record "Product Factory";
    begin
        begin
            BusinessIncome.Reset;
            BusinessIncome.SetRange(BusinessIncome."Loan No.", Loans."Loan No.");
            if BusinessIncome.Find('-') then begin
                BusinessIncome.CalcSums(BusinessIncome."Average Amount (Internal)", "Average Amount (External)");
                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    ProductFactory.TestField(ProductFactory."Computation %");
                    // "Recommended Amount" := (BusinessIncome."Average Amount (Internal)" + BusinessIncome."Average Amount (External)") * (ProductFactory."Computation %" / 100);
                    Loans.Modify;
                    Commit;
                end;
            end;
        end;
    end;






    // procedure AdviceTriggeredLoan(LoanNo: Code[20]; Topup: Boolean; AssociatedDocNo: Code[50])
    // var
    //     iEntryNo: Integer;
    //     CheckoffAdvice: Record "Triggered Advice Line";
    //     Memb: Record Members;
    //     Loans: Record Loans;
    //     InterestAmount: Decimal;
    //     InterestTotalsFlat: Decimal;
    //     NoOfMonths: Integer;
    //     MortgageInsurance: Decimal;
    // begin
    //     if Loans.Get(LoanNo) then begin

    //         ProdFac.Get(Loans."Loan Product Type");

    //         GenSetup.Get;
    //         if Loans."Recovery Mode" = Loans."Recovery Mode"::Checkoff then begin
    //             Loans.CalcFields(Loans."Outstanding Balance");
    //             InterestAmount := ((Loans."Outstanding Balance" * Loans.Interest / 1200) / Loans.Installments);
    //             if InterestAmount < 0 then
    //                 InterestAmount := 0;
    //             MortgageInsurance := 0;
    //             //MortgageInsurance:=GenSetup."Mortgage Insurance Amount";
    //             MortgageInsurance := Loans."Mortgage Insurance Amount";

    //             CheckoffAdvice.Reset;
    //             CheckoffAdvice.SetRange(CheckoffAdvice."Advice Date", Today);
    //             CheckoffAdvice.SetRange(CheckoffAdvice."Loan No.", Loans."Loan No.");
    //             if CheckoffAdvice.Find('-') then
    //                 CheckoffAdvice.DeleteAll;

    //             iEntryNo := 0;
    //             CheckoffAdvice.Reset;
    //             if CheckoffAdvice.Find('+') then
    //                 iEntryNo := CheckoffAdvice."Entry No" + 1;

    //             CheckoffAdvice.Init;
    //             CheckoffAdvice."Entry No" := iEntryNo;
    //             CheckoffAdvice."Account No." := Loans."Loan Account";
    //             CheckoffAdvice."Product Type" := Loans."Loan Product Type";
    //             CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
    //             CheckoffAdvice.Validate("Product Type");
    //             CheckoffAdvice."Loan No." := Loans."Loan No.";
    //             CheckoffAdvice.Validate("Loan No.");
    //             if Memb.Get(Loans."Member No.") then
    //                 CheckoffAdvice."ID No." := Memb."Primary Identification";
    //             CheckoffAdvice."Member No." := Loans."Member No.";
    //             CheckoffAdvice.Validate("Member No.");
    //             CheckoffAdvice."Employer Code" := Memb."Employer Code";
    //             //CheckoffAdvice.VALIDATE(CheckoffAdvice."Member No.");
    //             CheckoffAdvice.Names := Loans."Member Name";
    //             if Loans."Employer Loan No." <> '' then
    //                 CheckoffAdvice."Employer Account No." := Loans."Employer Loan No."
    //             else
    //                 CheckoffAdvice."Employer Account No." := Loans."Loan No.";
    //             CheckoffAdvice."Loan No." := Loans."Loan No.";
    //             CheckoffAdvice.Validate("Loan No.");

    //             //Different Mode of Payment***************
    //             PaymentMethods.Reset;
    //             PaymentMethods.SetRange(PaymentMethods."Loan No.", Loans."Loan No.");
    //             PaymentMethods.SetRange(PaymentMethods."Member No.", Loans."Member No.");
    //             PaymentMethods.SetRange(PaymentMethods."Payment Method", PaymentMethods."payment method"::Checkoff);
    //             if PaymentMethods.Find('-') then
    //                 CheckoffAdvice."Amount On" := PaymentMethods.Amount
    //             else
    //                 CheckoffAdvice."Amount On" := Loans.Repayment + MortgageInsurance;//-InterestAmount;

    //             if Topup = true then begin
    //                 CheckoffAdvice."Amount Off" := Loans.Repayment;
    //                 CheckoffAdvice."Amount On" := 0;

    //                 if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
    //                     InterestTotalsFlat := ((Loans.Repayment * Loans.Installments) - Loans."Approved Amount") / Loans.Installments;
    //                     NoOfMonths := ROUND((Loans."Approved Amount" - Loans."Outstanding Balance") / (Loans.Repayment - InterestTotalsFlat), 1, '>');
    //                     CheckoffAdvice."Balance Off" := Loans.Repayment * NoOfMonths;//Loans."Outstanding Balance";
    //                 end else
    //                     CheckoffAdvice."Balance Off" := Loans."Outstanding Balance";
    //                 CheckoffAdvice.Interest := 0;
    //                 CheckoffAdvice."Balance On" := 0;
    //             end else begin
    //                 /* IF Loans."Outstanding Interest">InterestAmount THEN
    //                    CheckoffAdvice.Interest:=Loans."Outstanding Interest"

    //                    ELSE*/
    //                 CheckoffAdvice.Interest := InterestAmount;
    //                 CheckoffAdvice."Balance On" := Loans.Repayment * Loans.Installments;//Loans."Outstanding Balance";
    //                 CheckoffAdvice."Balance Off" := 0;
    //                 CheckoffAdvice."Amount Off" := 0;
    //             end;
    //             if Loans."Employer Balance" <> 0 then
    //                 CheckoffAdvice."Balance Off" := Loans."Employer Balance";
    //             CheckoffAdvice."Advice Date" := Today;
    //             CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
    //             CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
    //             if Topup = false then
    //                 CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::"New Loan"
    //             else
    //                 CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage;
    //             CheckoffAdvice.Validate("Advice Type");
    //             CheckoffAdvice."Associated Document No" := AssociatedDocNo;
    //             CheckoffAdvice.Insert;
    //         end;
    //     end;

    // end;


    procedure RunSpecificConsolidatedCheckOffAdviceReport(MemberNo: Code[50]; AdviceDate: Date; AssociatedDocNo: Code[50])
    var
        CheckOffAdviceLine: Record "Checkoff Advice Line";
    begin

        CheckOffAdviceLine.Reset();
        CheckOffAdviceLine.SetRange("Member No.", MemberNo);
        CheckOffAdviceLine.SetRange("Advice Date", AdviceDate);
        CheckOffAdviceLine.setrange("Associated Document No", AssociatedDocNo);
        if CheckOffAdviceLine.Find('-') then begin
            Report.Run(52186856, true, false, CheckOffAdviceLine);
        end
        else
            Message('There is no checkoff line record associated with the document number provided : %1.', AssociatedDocNo);
    end;

    procedure RunSpecificConsolidatedCheckOffAdviceReport(AssociatedDocNo: Code[50])
    var
        CheckOffAdviceLine: Record "Checkoff Advice Line";
    begin

        CheckOffAdviceLine.Reset();
        CheckOffAdviceLine.SetRange("Associated Document No", AssociatedDocNo);
        if CheckOffAdviceLine.Find('-') then begin
            Report.Run(52186856, true, false, CheckOffAdviceLine);
        end;
    end;


    procedure AdviceTriggeredShares(SavingsAccounts: Record "Savings Accounts"; AmountOn: Decimal; AssociatedDocNo: Code[50])
    var
        CheckoffAdvice: Record "Triggered Advice Line";
        iEntryNo: Integer;
        MonthlyContribution: Decimal;
        Prorata: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
    begin
        SavingsAccounts.CalcFields("Balance (LCY)");

        CheckoffAdvice.Init;
        CheckoffAdvice."Account No." := SavingsAccounts."No.";
        CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
        CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
        CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;
        CheckoffAdvice."Advice Date" := Today;
        CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
        CheckoffAdvice."Employer Code" := SavingsAccounts."Employer Code";
        CheckoffAdvice.Names := SavingsAccounts.Name;
        CheckoffAdvice."Employer Account No." := SavingsAccounts."Employer Account No";
        CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
        CheckoffAdvice.Type := CheckoffAdvice.Type::Savings;
        if CheckoffAdvice."Employer Account No." = '' then
            CheckoffAdvice."Employer Account No." := SavingsAccounts."No.";

        //***********************Amount Off******************************************/
        MonthlyContribution := SavingsAccounts."Monthly Contribution";
        Prorata := CustomCuesCodeunit.Prorata(SavingsAccounts."Member No.", SavingsAccounts."Product Type");
        if Prorata > MonthlyContribution then MonthlyContribution := Prorata;
        CheckoffAdvice."Amount Off" := MonthlyContribution;
        if SavingsAccounts."Balance (LCY)" <= 0 then
            CheckoffAdvice."Amount Off" := 0;
        //***********************Amount Off******************************************/

        //***********************Amount On******************************************/
        if AmountOn = 0 then begin
            CheckoffAdvice."Amount On" := 0;
        end;
        if AmountOn > 0 then begin
            CheckoffAdvice."Amount On" := AmountOn;
            if CheckoffAdvice."Amount On" < SavingsAccounts."Monthly Contribution" then
                CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
        end;
        //***********************Amount On******************************************/

        //***********************Balance On******************************************/
        CheckoffAdvice."Balance On" := SavingsAccounts."Balance (LCY)";
        //***********************Balance On******************************************/

        //***********************Advice Type******************************************/
        if (CheckoffAdvice."Amount Off" = 0) and (AmountOn > 0) then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::New;

        if AmountOn = CheckoffAdvice."Amount Off" then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Adjustment;

        if AmountOn <> CheckoffAdvice."Amount Off" then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Variations;

        if CheckoffAdvice."Amount On" = 0 then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage;
        //***********************Advice Type******************************************/

        CheckoffAdvice.Insert;
    end;


    //Start of Variations
    procedure VariateAdviceLoan(Variations: Code[20])
    var
        iEntryNo: Integer;
        CheckoffAdvice: Record "Checkoff Advice Line";
        Memb: Record Members;
        Loans: Record Loans;
        InterestAmount: Decimal;
        InterestTotalsFlat: Decimal;
        NoOfMonths: Integer;
        VariationsRec: Record "Product Variations";
    begin
        if VariationsRec.Get(Variations) then begin
            if Loans.Get(VariationsRec."Account No") then begin

                ProdFac.Get(Loans."Loan Product Type");

                GenSetup.Get;
                if Loans."Recovery Mode" = Loans."recovery mode"::Checkoff then begin //KIgen Added to block non checkoff from advising
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                    CheckoffAdvice.Reset;
                    CheckoffAdvice.SetRange(CheckoffAdvice."Advice Date", Today);
                    CheckoffAdvice.SetRange(CheckoffAdvice."Loan No.", Loans."Loan No.");
                    if CheckoffAdvice.Find('-') then
                        CheckoffAdvice.DeleteAll;

                    iEntryNo := 0;
                    CheckoffAdvice.Reset;
                    if CheckoffAdvice.Find('+') then
                        iEntryNo := CheckoffAdvice."Entry No" + 1;

                    CheckoffAdvice.Init;
                    CheckoffAdvice."Entry No" := iEntryNo;
                    CheckoffAdvice."Advice Header No." := VariationsRec."No.";
                    CheckoffAdvice."Account No." := Loans."Loan Account";
                    CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                    CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
                    CheckoffAdvice.Validate("Product Type");
                    CheckoffAdvice."Loan No." := Loans."Loan No.";
                    CheckoffAdvice.Validate("Loan No.");
                    if Memb.Get(Loans."Member No.") then
                        CheckoffAdvice."ID No." := Memb."Primary Identification";
                    CheckoffAdvice."Member No." := Loans."Member No.";
                    CheckoffAdvice.Validate("Member No.");
                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                    //CheckoffAdvice.VALIDATE(CheckoffAdvice."Member No.");
                    CheckoffAdvice.Names := Loans."Member Name";
                    if Loans."Employer Loan No." <> '' then
                        CheckoffAdvice."Employer Account No." := Loans."Employer Loan No."
                    else
                        CheckoffAdvice."Employer Account No." := Loans."Loan No.";
                    CheckoffAdvice."Loan No." := Loans."Loan No.";
                    CheckoffAdvice.Validate("Loan No.");
                    CheckoffAdvice."Amount On" := Round(VariationsRec."Amount On", 1, '>');
                    CheckoffAdvice."Amount Off" := Round(VariationsRec."Amount Off", 1, '>');
                    CheckoffAdvice."Balance Off" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                    CheckoffAdvice."Balance On" := Round(Loans."Outstanding Balance" + Loans."Outstanding Interest", 1, '>');
                    CheckoffAdvice.Interest := InterestAmount;
                end;
                if Loans."Employer Balance" <> 0 then
                    CheckoffAdvice."Balance Off" := Loans."Employer Balance";
                CheckoffAdvice."Advice Date" := Today;
                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
                CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Variations;
                if checkoffAdvice."Amount On" = 0 then
                    CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage;
                CheckoffAdvice.Validate("Advice Type");
                CheckoffAdvice.Reference := VariationsRec.Reference;
                CheckoffAdvice."Variation Action" := VariationsRec."Variation Action";
                CheckoffAdvice."Associated Document No" := Variations;
                CheckoffAdvice.Insert;
            end;
        end;
    end;


    procedure VariationsAdviceShares(SavingsAccounts: Record "Savings Accounts"; ProdVariations: Record "Product Variations")
    var
        CheckoffAdvice: Record "Checkoff Advice Line";
        iEntryNo: Integer;
        SavingsAccount: Record "Savings Accounts";
        AmountOn: Decimal;
        BalanceOff: Decimal;
    begin
        iEntryNo := 0;
        CheckoffAdvice.Reset;
        if CheckoffAdvice.Find('+') then
            iEntryNo := CheckoffAdvice."Entry No" + 1;

        AmountOn := ProdVariations."Amount On";
        BalanceOff := ProdVariations."Amount Off";
        if AmountOn < CustomCuesCodeunit.Prorata(SavingsAccounts."Member No.", '1') then
            AmountOn := CustomCuesCodeunit.Prorata(SavingsAccounts."Member No.", '1');
        CheckoffAdvice.Init;
        CheckoffAdvice."Entry No" := iEntryNo;
        CheckoffAdvice."Account No." := SavingsAccounts."No.";
        CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
        CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
        CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
        SavingsAccount.Reset;
        SavingsAccount.SetRange("No.", SavingsAccounts."No.");
        if SavingsAccount.Find('-') then begin
            if SavingsAccount."Monthly Contribution" < AmountOn then
                CheckoffAdvice."Amount On" := Round(AmountOn, 1, '>')
            else
                CheckoffAdvice."Amount On" := Round(SavingsAccount."Monthly Contribution", 1, '>');
            CheckoffAdvice."Amount Off" := Round(SavingsAccount."Monthly Contribution", 1, '>');
            SavingsAccount.CalcFields("Balance (LCY)");
            CheckoffAdvice."Balance On" := Round(SavingsAccount."Balance (LCY)" + BalanceOff, 1, '>');
        end;

        SavingsAccount.Reset;
        SavingsAccount.SetRange("No.", SavingsAccounts."No.");
        SavingsAccount.SetRange("Product Category", SavingsAccount."product category"::"Share Capital");
        if SavingsAccount.Find('-') then begin
            SavingsAccount.CalcFields("Balance (LCY)");
            CheckoffAdvice."Balance On" := Round(SavingsAccount."Balance (LCY)" + CheckoffAdvice."Balance On", 1, '<');
        end;
        if SavingsAccounts."Employer Balance" <> 0 then
            CheckoffAdvice."Balance On" := Round(SavingsAccounts."Employer Balance" + SavingsAccount."Monthly Contribution" + BalanceOff, 1, '<');
        SavingsAccounts."Monthly Contribution" := AmountOn;
        SavingsAccounts.Modify;

        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;
        CheckoffAdvice."Advice Date" := Today;
        CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
        CheckoffAdvice."Employer Code" := SavingsAccounts."Employer Code";
        CheckoffAdvice.Names := SavingsAccounts.Name;
        if SavingsAccounts."Employer Account No" <> '' then
            CheckoffAdvice."Employer Account No." := SavingsAccounts."Employer Account No"
        else
            CheckoffAdvice."Employer Account No." := SavingsAccounts."No.";
        CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
        if AmountOn <> SavingsAccount."Monthly Contribution" then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Variations
        else
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::"Monthly Deduction";
        CheckoffAdvice.Type := CheckoffAdvice.Type::Savings;
        CheckoffAdvice.Reference := ProdVariations.Reference;
        CheckoffAdvice."Variation Action" := ProdVariations."Variation Action";
        CheckoffAdvice."Associated Document No" := ProdVariations."No.";
        // if (SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits") and
        if AmountOn = 0 then begin
            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::Stoppage;
            CheckoffAdvice.Insert;
        end else
            if (AmountOn >= SavingsAccounts."Monthly Contribution") or (BalanceOff > 0) then
                CheckoffAdvice.Insert;
    end;



    //End of Variations
    local procedure RegisterMortgageDocuments(LoanNo: Code[30])
    var
        MortgageLoansDocRegister: Record "Mortgage Loans Doc Register";
    begin
        if LoanApps.Get(LoanNo) then begin
            MortgageLoansDocRegister.Init;
            MortgageLoansDocRegister."Loan No." := LoanApps."Loan No.";
            MortgageLoansDocRegister."Member No" := LoanApps."Member No.";
            MortgageLoansDocRegister."Member Name" := LoanApps."Member Name";
            MortgageLoansDocRegister."Date Withheld" := Today;
            MortgageLoansDocRegister."User Registered" := UserId;
            MortgageLoansDocRegister."Document Type" := MortgageLoansDocRegister."document type"::"Lease/Title";
            MortgageLoansDocRegister."Document Withheld" := true;
            MortgageLoansDocRegister."Loan Type" := LoanApps."Loan Product Type";
            MortgageLoansDocRegister."Withheld Document No" := LoanApps."Title/Lease No";
            MortgageLoansDocRegister.Insert;
        end;
    end;

    local procedure "CheckDisbursementA/CBalanceForMortgage"(Account: Code[30])
    var
        cashierTransactions: Record "Cashier Transactions";
        lienAmount: Decimal;
        saccoAccount: Record "Savings Accounts";
        Accounttypes: Record "Product Factory";
        MiniBalance: Decimal;
        AccountBal: Decimal;
    begin
        GenSetup.Get;
        lienAmount := 0;
        saccoAccount.Reset;
        saccoAccount.SetRange(saccoAccount."No.", Account);
        //saccoAccount.SETRANGE(saccoAccount."Product Type",'505');
        if saccoAccount.Find('-') then begin
            Accounttypes.Reset;
            Accounttypes.SetRange(Accounttypes."Product ID", saccoAccount."Product Type");
            if Accounttypes.Find('-') then begin
                MiniBalance := Accounttypes."Minimum Balance";
            end;
            saccoAccount.CalcFields(saccoAccount."Balance (LCY)");
            saccoAccount.CalcFields(saccoAccount."ATM Transactions");
            saccoAccount.CalcFields(saccoAccount."Uncleared Cheques");


            cashierTransactions.Reset;
            cashierTransactions.SetRange("Account No", saccoAccount."No.");
            cashierTransactions.SetRange(Posted, true);
            cashierTransactions.SetRange(Type, cashierTransactions.Type::Lien);
            cashierTransactions.SetRange("Cheque Status", cashierTransactions."cheque status"::Pending);
            if cashierTransactions.Find('-') then begin
                repeat
                    lienAmount += cashierTransactions.Amount;
                until cashierTransactions.Next = 0;
            end;





            AccountBal := saccoAccount."Balance (LCY)" - (saccoAccount."ATM Transactions" + saccoAccount."Uncleared Cheques" + MiniBalance + lienAmount);

            if AccountBal < GenSetup."Mortgage FOSA Min Balance" then Error('Account No %1 balance must be over %2', Account, GenSetup."Mortgage FOSA Min Balance");
        end
    end;


    procedure CreateBridgingLoan(MemberNo: Code[20]; LoanAmt: Decimal) BridgingLoanNo: Code[20]
    var
        ProductFactory: Record "Product Factory";
        NewLoans: Record Loans;
        Credit: Record "Credit Accounts";
        Members: Record Members;
        LoanAccountNo: Code[20];
    begin
        if LoanAmt <= 0 then
            exit('');

        ProductFactory.Reset;
        ProductFactory.SetRange("Nature of Loan Type", ProductFactory."nature of loan type"::"Bridging Loan");
        if ProductFactory.Find('-') then begin
            if Credit.Get(ProductFactory."Account No. Prefix" + MemberNo + ProductFactory."Account No. Suffix") then
                LoanAccountNo := ProductFactory."Account No. Prefix" + MemberNo + ProductFactory."Account No. Suffix"
            else
                LoanAccountNo := CreateLoanAccount(MemberNo, ProductFactory."Product ID");

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", MemberNo);
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then
                NewLoans.DeleteAll;

            NewLoans.Init;
            NewLoans."Loan No." := '';
            NewLoans."Member No." := MemberNo;
            NewLoans."Member Name" := Members.Name;
            NewLoans."Staff No" := Members."Payroll/Staff No.";
            NewLoans."Employer Code" := Members."Employer Code";
            NewLoans."Application Date" := Today;
            NewLoans."Loan Product Type" := ProductFactory."Product ID";
            NewLoans."Loan Product Type Name" := ProductFactory."Product Description";
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans.Interest := ProductFactory."Interest Rate (Min.)";
            NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
            NewLoans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
            NewLoans."Loan Span" := ProductFactory."Loan Span";
            NewLoans.Installments := ProductFactory."Prefferential Default installm";
            NewLoans."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
            NewLoans."Repayment Frequency" := ProductFactory."Repayment Frequency";
            NewLoans."Recovery Mode" := ProductFactory."Repay Mode";
            NewLoans."Appraisal Parameter Type" := ProductFactory."Appraisal Parameter Type";
            NewLoans."Recovery Priority" := ProductFactory."Recovery Priority";
            NewLoans.Installments := ProductFactory."Prefferential Default installm";
            NewLoans."Requested Amount" := LoanAmt;
            NewLoans.Repayment := ROUND(LoanAmt / NewLoans.Installments, 1, '>');
            NewLoans."Loan Principle Repayment" := ROUND(LoanAmt / NewLoans.Installments, 1, '>');
            NewLoans."Approved Amount" := LoanAmt;
            //NewLoans.VALIDATE(NewLoans."Approved Amount");
            NewLoans.Status := NewLoans.Status::Approved;
            NewLoans."Disbursement Date" := Today;
            NewLoans."Repayment Start Date" := Today;
            NewLoans."Loan Account" := LoanAccountNo;
            NewLoans.Advice := true;
            NewLoans."Advice Type" := NewLoans."advice type"::"Fresh Loan";
            NewLoans.Insert(true);

            BridgingLoanNo := NewLoans."Loan No.";
            exit(BridgingLoanNo);
        end;
    end;

    procedure GetCapitalizedInterest("LoanCode": Code[30]) Capitalized: Decimal;
    var
        myInt: Integer;
        LoanRec: Record Loans;
        InterestBuffer: Record "Loans Daily Interest";
    begin
        Capitalized := 0;
        LoanRec.Reset();
        LoanRec.SetRange(LoanRec."Loan No.", LoanCode);
        LoanRec.SetRange(Posted, true);
        if LoanRec.FindFirst() then begin
            InterestBuffer.Reset();
            InterestBuffer.SetRange(InterestBuffer."Loan No.", LoanRec."Loan No.");
            InterestBuffer.SetRange(Posted, false);
            if InterestBuffer.FindFirst() then begin
                InterestBuffer.CalcSums(InterestBuffer."Interest Amount");
                Capitalized := InterestBuffer."Interest Amount";
            end;
        end;
        exit(Capitalized);
    end;

    procedure PostCapitalizedInterestDMU("LoanCode": Code[30]; DocNumber: Code[50])
    var
        myInt: Integer;
        LoanRec: Record Loans;
        InterestBuffer: Record "Loans Interest Buffer";
        SaccoTrans: Codeunit "Sacco Transactions";
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        Desc: Text[150];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        Amt: Decimal;
        ExtDocNo: Code[20];
        Loan: Code[20];
        TransType: enum "Transaction Types";
        Dim1: Code[20];
        Dim2: Code[20];
        SystemCreated: Boolean;
        UserSetup: Record "User Setup";
        Capitalized: Decimal;
        ProductFactory: Record "Product Factory";
    begin
        LoanRec.Reset();
        LoanRec.SetRange(LoanRec."Loan No.", LoanCode);
        LoanRec.SetRange(Posted, true);
        if LoanRec.FindFirst() then begin
            InterestBuffer.Reset();
            InterestBuffer.SetRange(InterestBuffer."Loan No.", LoanRec."Loan No.");
            InterestBuffer.SetRange(Posted, false);
            if InterestBuffer.Find('-') then begin

                InterestBuffer.CalcSums(InterestBuffer."Interest Amount");
                Capitalized := Round(InterestBuffer."Interest Amount", 0.01, '>');
                // if Capitalized > 0 then
                //     Message('This is just FYI:\ You are about to post accrued interest for Loan: %1 Amount: KES %2', LoanCode, Capitalized);


                ProductFactory.Get(LoanRec."Loan Product Type");

                Temp.Get(UserId);
                Temp.TestField("Loan Recovery Template");
                Temp.TestField("Loan Recovery Batch");
                Jtemplate := Temp."Loan Recovery Template";
                JBatch := Temp."Loan Recovery Batch";

                UserSetup.Get(UserId);
                Dim1 := LoanRec."Global Dimension 1 Code";
                Dim2 := LoanRec."Global Dimension 2 Code";
                DocNo := DocNumber;
                ExtDocNo := DocNumber;
                PDate := Today;
                Desc := 'Daily Interest Capitalized_' + LoanRec."Loan No.";
                Amt := Round(Capitalized, 0.01);
                AcctNo := LoanRec."Loan Account";
                BalAcctNo := ProductFactory."Loan Interest Account [G/L]";
                SaccoTrans.InitJournal(Jtemplate, JBatch);
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AcctNo, Desc, BalAcctType::"G/L Account",
                                        '', Amt, ExtDocNo, LoanRec."Loan No.", TransType::"Interest Due", Dim1, Dim2, SystemCreated); //4708138300
                AcctNo := ProductFactory."Loan Interest Account [G/L]";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"G/L Account", AcctNo, Desc, BalAcctType::"G/L Account",
                                        '', -Amt, ExtDocNo, '', TransType::" ", Dim1, Dim2, SystemCreated); //4708138300
                SaccoTrans.PostJournal(Jtemplate, JBatch);

                InterestBuffer.ModifyAll(Posted, true);
            end;
        end;
    end;

    procedure ComputeDaillyLoanInterest(LoanCode: Code[30]; PostingDate: date)
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        members: Record Members;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        //  LoanType: Record "Product Factory";
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        EndDate: Date;
        DontCharge: Boolean;
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Interest Due Period";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Loans Template is set up in Cash Office Setup';
        NoBatchErr: label 'Ensure the Loans Batch is set up in the Cash Office Setup';
        DailyIntrestBufferBuffer: Record "Daily Loans Interest Buffer";
        LoansRec: Record Loans;
        Gnljnline: Record "Gen. Journal Line";
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoanAmount: Decimal;
        CustMember: Record "Credit Accounts";
        CurrDate: Date;
        FirstMonthDate: Date;
        Temp: Record "Banking User Template";
        CurrMonth: Date;
        MidDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        DailyIntrestBuffer: Record "Daily Loans Interest Buffer";
        Memb: Record Members;
        diaProgress: Dialog;
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        GeneratingDividends: label 'Generating Interest :';
        IntrestBuffer: Record "Loans Interest Buffer";
        LoansInterest: Record "Loans Interest";
        Counter1: Integer;
        Counter2: Integer;
        ToDateS: Text;
        DateFilter: Text;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        InterestDuePeriod: Record "Interest Due Period";
        MonthDays: Integer;
        GeneralSetUp: Record "General Set-Up";
        Dim1: Code[50];
        Dim2: Code[50];
        UserSetup: Record "User Setup";
        iEntryNo: Integer;
        Noofdays: Integer;
        Selectedyear: Integer;
        TodaysMonth: Integer;
        InterestDate: Date;
        RunBilling: Boolean;
        LastNu: Code[100];
        MoratoriumLoan: Record "Moratorium Loan";
        ProductFactory: Record "Product Factory";
        LoanRepayments: Record "Credit Ledger Entry";
        LastRepaymentDate: Date;
    begin
        InterestDate := PostingDate;
        //Noofdays := (CalcDate('CM', PostingDate)) - (CalcDate('-CM', PostingDate)) + 1;
        GeneralSetUp.Get();
        // RunBilling := true;
        // MoratoriumLoan.Reset();
        // MoratoriumLoan.SetRange("Loan No", LoanCode);
        // MoratoriumLoan.SetRange(Status, MoratoriumLoan.Status::Approved);
        // MoratoriumLoan.SetRange(Processed, true);
        // MoratoriumLoan.SetFilter("End Date Moratorium", '>%1', PostingDate);
        // if MoratoriumLoan.Find('-') then
        //     RunBilling := false;
        // exit;
        // if RunBilling = false then exit;
        // if RunBilling = true then begin
        //kenpipe policy :stop interest 
        LoansRec.reset;
        LoansRec.SetRange("Loan No.", LoanCode);
        LoansRec.SetFilter("Date Filter", '..%1', PostingDate);
        // LoansRec.SetFilter("Compute Interest Due on Postin", '<>%1', LoansRec."Compute Interest Due on Postin"::"Full Period Interest");
        LoansRec.SetFilter("Last Interest Run Date", '<>%1', InterestDate);

        if LoansRec.find('-') then begin
            if ProductFactory.get(LoansRec."Loan Product Type") then begin
                if ProductFactory."Guarantor Loan" = false then begin //excempt guarantor loan from billing interest
                    if (ProductFactory."Interest Recovered Upfront" = false) then
                        if (ProductFactory."Compute Interest Due on Postin" <> ProductFactory."Compute Interest Due on Postin"::"Full Period Interest")
                        and (ProductFactory."No Interest Bills" = false)
                        and (ProductFactory."Product Class Type" = ProductFactory."Product Class Type"::Loan) then begin

                            LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Outstanding Interest");

                            if (LoansRec."Outstanding Balance") > 0 then begin
                                if LoansRec."Loan Account" <> '' then begin
                                    Members.Reset;
                                    Members.SetRange("No.", LoansRec."Member No.");
                                    Members.SetFilter(Status, '<>%1', Members.Status::Deceased);

                                    if Members.Find('-') then begin

                                        if LoansRec."Interest Calculation Method" = LoansRec."Interest Calculation Method"::"Straight Line" then
                                            IntCharged := LoansRec."Approved Amount" * ((LoansRec.Interest) / 1200) * 1
                                        else
                                            IntCharged := LoansRec."Outstanding Balance" * ((LoansRec.Interest) / 1200) * 1;

                                        // Fetch last repayment date
                                        LoanRepayments.Reset();
                                        LoanRepayments.SetRange("Loan No", LoansRec."Loan No.");
                                        LoanRepayments.SetRange("Transaction Type", LoanRepayments."Transaction Type"::Repayment);
                                        LoanRepayments.SetFilter("Posting Date", '<=%1', PostingDate);
                                        LoanRepayments.SetCurrentKey("Posting Date");

                                        if LoanRepayments.FindLast() then
                                            LastRepaymentDate := LoanRepayments."Posting Date"
                                        else
                                            // LastRepaymentDate := 0D; // No repayment made
                                            LastRepaymentDate := LoansRec."Disbursement Date";


                                        // Stop interest accrual if no payment for the past 3 monthsP

                                        // if (LastRepaymentDate <> 0D) then begin
                                        //     if (CalcDate('<+3M>', LastRepaymentDate) < PostingDate) then
                                        //         IntCharged := 0;
                                        // end;


                                        if IntCharged > 0 then begin
                                            LoansInterest.Reset();
                                            LoansInterest.SetRange("Loan No.", LoansRec."Loan No.");
                                            LoansInterest.SetRange(LoansInterest."Interest Date", InterestDate);

                                            if not LoansInterest.Find('-') then begin
                                                LoansInterest.Init;
                                                LoansInterest."Loan No." := LoansRec."Loan No.";
                                                LoansInterest."Account No" := LoansRec."Loan Account";
                                                LoansInterest."Emp code" := LoansRec."Employer Code";
                                                LoansInterest."Issued Date" := LoansRec."Disbursement Date";
                                                LoansInterest."Loan Product type" := LoansRec."Loan Product Type";
                                                LoansInterest."Interest Date" := InterestDate;
                                                LoansInterest."Issued Date" := LoansRec."Disbursement Date";

                                                // Grace Period Interest Handling
                                                if Format(ProductFactory."Grace Period - Interest") <> '' then begin
                                                    if CalcDate(ProductFactory."Grace Period - Interest", LoansRec."Disbursement Date") <= PostingDate then
                                                        LoansInterest."Interest Bill" := IntCharged
                                                    else
                                                        LoansInterest."Interest Bill" := 0;
                                                end else begin
                                                    LoansInterest."Interest Bill" := IntCharged;
                                                end;

                                                LoansInterest."Interest Amount" := IntCharged;
                                                LoansInterest."Member No" := LoansRec."Member No.";
                                                LoansInterest."Outstanding Balance" := LoansRec."Outstanding Balance";
                                                LoansInterest."Outstanding Interest" := LoansRec."Outstanding Interest";
                                                LoansInterest.Status := Members.Status;
                                                LoansInterest.Blocked := Members.Blocked;

                                                if LoansInterest."Interest Amount" > 0 then
                                                    LoansInterest.Insert;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                end;
            end;
        end;
    End;
    // end;

    procedure ComputeDaillyLoanInterestNew(LoanCode: Code[30]; PostingDate: date)
    var
        Members: Record Members;
        PDate: Date;
        LoanApp: record Loans;
        Noofdays: integer;
        ProductFactory: record "Product Factory";
        IntCharged: decimal;
        IntrestBuffer: Record "Loans Interest Buffer";

    begin
        if LoanApp.get(LoanCode) then begin
            LoanApp.CalcFields("Last Interest Run Date");
            if LoanApp."Last Interest Run Date" <> PostingDate then begin
                if Members.get(LoanApp."Member No.") then begin
                    if (Members.Status <> Members.status::Deceased) or (Members.Subflag <> Members.Subflag::Deceased) then begin
                        Noofdays := (CalcDate('CM', PostingDate)) - (CalcDate('-CM', PostingDate)) + 1;
                        if ProductFactory.get(LoanApp."Loan Product Type") then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                            if ((LoanApp."Outstanding Balance") > 0) and (LoanApp."Loan Account" <> '') then begin
                                if LoanApp."Interest Calculation Method" = LoanApp."interest calculation method"::"Straight Line" then
                                    IntCharged := LoanApp."Approved Amount" * ((LoanApp.Interest) / 1200) / Noofdays
                                else
                                    IntCharged := LoanApp."Outstanding Balance" * ((LoanApp.Interest) / 1200) / Noofdays;
                                if IntCharged > 0 then begin
                                    // IntrestBuffer.Reset;
                                    // IntrestBuffer.SetRange("Loan No.", LoanApp."Loan No.");
                                    // IntrestBuffer.SetRange(IntrestBuffer."Interest Date", PostingDate);
                                    // if not IntrestBuffer.Find('-') then begin
                                    IntrestBuffer.Init;
                                    IntrestBuffer."Loan No." := LoanApp."Loan No.";
                                    IntrestBuffer."Account No" := LoanApp."Loan Account";
                                    IntrestBuffer."Issued Date" := LoanApp."Disbursement Date";
                                    IntrestBuffer."Loan Product type" := LoanApp."Loan Product Type";
                                    IntrestBuffer."Interest Date" := PostingDate;
                                    IntrestBuffer."Issued Date" := LoanApp."Disbursement Date";
                                    IntrestBuffer."Interest Bill" := IntCharged;
                                    IntrestBuffer."Interest Amount" := IntCharged;
                                    IntrestBuffer."Member No" := LoanApp."Member No.";
                                    IntrestBuffer."Outstanding Balance" := LoanApp."Outstanding Balance";
                                    IntrestBuffer."Outstanding Interest" := LoanApp."Outstanding Interest";
                                    IntrestBuffer.Status := Members.Status;
                                    IntrestBuffer.Blocked := Members.Blocked;
                                    IF IntrestBuffer."Interest Amount" > 0 then
                                        IntrestBuffer.Insert;
                                    //    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

        end;
    end;

    procedure ComputeDaillyLoanInterests(LoanCode: Code[30]; PostingDate: date)
    var
        Members: Record Members;
        PDate: Date;
        LoanApp: record Loans;
        Noofdays: integer;
        ProductFactory: record "Product Factory";
        IntCharged: decimal;
        IntrestBuffer: Record "Loans Interest Buffer";//"Loans Daily Interest";

    begin
        if LoanApp.get(LoanCode) then begin
            LoanApp.CalcFields("Last Interest Run Date");
            if LoanApp."Last Interest Run Date" <> PostingDate then begin
                if Members.get(LoanApp."Member No.") then begin
                    if (Members.Status <> Members.status::Deceased) or (Members.Subflag <> Members.Subflag::Deceased) then begin
                        Noofdays := (CalcDate('CM', PostingDate)) - (CalcDate('-CM', PostingDate)) + 1;
                        if ProductFactory.get(LoanApp."Loan Product Type") then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            if ((LoanApp."Outstanding Balance") > 0) then begin
                                if LoanApp."Interest Calculation Method" = LoanApp."interest calculation method"::"Straight Line" then
                                    IntCharged := LoanApp."Approved Amount" * ((LoanApp.Interest) / 1200) / Noofdays
                                else
                                    IntCharged := LoanApp."Outstanding Balance" * ((LoanApp.Interest) / 1200) / Noofdays;
                                if IntCharged > 0 then begin
                                    // IntrestBuffer.Reset;
                                    // IntrestBuffer.SetRange("Loan No.", LoanApp."Loan No.");
                                    // IntrestBuffer.SetRange(IntrestBuffer."Interest Date", PostingDate);
                                    // if not IntrestBuffer.Find('-') then begin
                                    IntrestBuffer.Init;
                                    IntrestBuffer."Loan No." := LoanApp."Loan No.";
                                    IntrestBuffer."Interest Date" := PostingDate;
                                    IntrestBuffer."Interest Amount" := Round(IntCharged, 0.01, '>');
                                    IntrestBuffer."User ID" := UserId;
                                    IF IntrestBuffer."Interest Amount" > 0 then
                                        IntrestBuffer.Insert;
                                    // end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure ComputeDaillyLoanInterestII(LoanCode: Code[30])
    var
        members: Record Members;
        LoansRec: Record Loans;
        IntCharged: Decimal;
        IntrestBuffer: Record "Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Noofdays: Integer;
        TodaysMonth: Integer;
        InterestDate: Date;
        RunBilling: Boolean;
        MoratoriumLoan: Record "Moratorium Loan";
        ProductFactory: Record "Product Factory";
    begin
        InterestDate := Today;
        Noofdays := (CalcDate('CM', Today)) - (CalcDate('-CM', Today)) + 1;
        GeneralSetUp.Get();
        RunBilling := true;
        MoratoriumLoan.Reset();
        MoratoriumLoan.SetRange("Loan No", LoanCode);
        MoratoriumLoan.SetRange(Status, MoratoriumLoan.Status::Approved);
        MoratoriumLoan.SetRange(Processed, true);
        MoratoriumLoan.SetFilter("End Date Moratorium", '>%1', Today);
        if MoratoriumLoan.FindFirst() then begin
            RunBilling := false;
        end;
        if RunBilling = true then exit;
        LoansRec.Reset();
        LoansRec.SetRange("Loan No.", LoanCode);
        LoansRec.SetFilter("Loan Account", '<>%1', '');
        LoansRec.SetFilter("Last Interest Run Date", '<>%1', InterestDate);
        LoansRec.SetFilter("Compute Interest Due on Postin", '<>%1', LoansRec."Compute Interest Due on Postin"::"Full Period Interest");
        if LoansRec.FindFirst() then begin
            ProductFactory.Reset();
            ProductFactory.SetRange("Product ID", LoansRec."Loan Product Type");
            ProductFactory.SetRange("Interest Recovered Upfront", false);
            ProductFactory.SetFilter("Compute Interest Due on Postin", '<>%1', ProductFactory."Compute Interest Due on Postin"::"Full Period Interest");
            if ProductFactory.FindFirst() then begin
                LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Outstanding Interest", LoansRec."Loans Category-SASRA");
                if (LoansRec."Outstanding Balance" + LoansRec."Outstanding Interest") > 0 then begin
                    Members.Reset;
                    Members.SetRange("No.", LoansRec."Member No.");
                    Members.SetFilter(Status, '<>%1', Members.Status::Deceased);
                    if Members.FindFirst() then begin
                        if LoansRec."Interest Calculation Method" = LoansRec."interest calculation method"::"Straight Line" then
                            IntCharged := LoansRec."Approved Amount" * ((LoansRec.Interest) / 1200) * 1 / Noofdays
                        else
                            IntCharged := LoansRec."Outstanding Balance" * ((LoansRec.Interest) / 1200) * 1 / Noofdays;

                        if ProductFactory."No Interest Bills" = true then
                            IntCharged := 0;
                        // IntrestBuffer.Reset();
                        // IntrestBuffer.SetRange("Loan No.", LoansRec."Loan No.");
                        // IntrestBuffer.SetRange(IntrestBuffer."Interest Date", InterestDate);
                        // if not IntrestBuffer.FindFirst() then begin
                        IntrestBuffer.Init;
                        IntrestBuffer."Loan No." := LoansRec."Loan No.";
                        IntrestBuffer."Account Type" := IntrestBuffer."account type"::Credit;
                        IntrestBuffer."Account No" := LoansRec."Loan Account";
                        IntrestBuffer."Issued Date" := LoansRec."Disbursement Date";
                        IntrestBuffer."Loan Product type" := LoansRec."Loan Product Type";
                        IntrestBuffer."Interest Date" := InterestDate;
                        IntrestBuffer."Issued Date" := LoansRec."Disbursement Date";
                        //Grace Period Interest
                        if Format(ProductFactory."Grace Period - Interest") <> '' then begin
                            if CalcDate(ProductFactory."Grace Period - Interest", LoansRec."Disbursement Date") <= Today then
                                IntrestBuffer."Interest Bill" := IntCharged
                            else
                                IntrestBuffer."Interest Bill" := 0;
                        end else begin
                            IntrestBuffer."Interest Bill" := IntCharged;
                        end;

                        IntrestBuffer."Interest Amount" := IntCharged;
                        IntrestBuffer."Repayment Amount" := LoansRec.Repayment;
                        IntrestBuffer."Member No" := LoansRec."Member No.";
                        IntrestBuffer."Monthly Repayment" := IntrestBuffer."Repayment Bill" + IntrestBuffer."Interest Bill";
                        IntrestBuffer."Outstanding Balance" := LoansRec."Outstanding Balance";
                        IntrestBuffer."Outstanding Interest" := LoansRec."Outstanding Interest";
                        IntrestBuffer."Employer Code" := LoansRec."Employer Code";
                        IntrestBuffer."Loan Product type" := LoansRec."Loan Product Type";
                        if ProductFactory."No Interest Bills" = true then
                            IntrestBuffer."Interest Bill" := 0;
                        if ProductFactory."No Principle Bills" = true then
                            IntrestBuffer."Repayment Bill" := 0;

                        IntrestBuffer."Monthly Repayment" := IntrestBuffer."Repayment Bill" + IntrestBuffer."Interest Bill";
                        IntrestBuffer.Status := Members.Status;
                        IntrestBuffer.Blocked := Members.Blocked;
                        IF IntrestBuffer."Interest Amount" <> 0 then
                            IntrestBuffer.Insert;
                        //    end;
                    end;
                end;
            end;
        end;
    end;

    procedure ComputeDaillyLoanInterestServices()
    var
        members: Record Members;
        IntCharged: Decimal;
        IntrestBuffer: Record "Loans Interest Buffer";
        GeneralSetUp: Record "General Set-Up";
        Noofdays: Integer;
        TodaysMonth: Integer;
        InterestDate: Date;
        RunBilling: Boolean;
        MoratoriumLoan: Record "Moratorium Loan";
        ProductFactory: Record "Product Factory";
        loans: Record loans;
        LoggedEntries: Record "Sky Services Change Logs";
    begin
        if InterestDate = 0D then
            InterestDate := Today;
        loans.Reset();
        loans.SetRange(Posted, true);
        loans.SetFilter("Outstanding Balance", '>%1', 0);
        loans.SetFilter(Interest, '>%1', 0);
        loans.SetFilter("Last Interest Run Date", '<>%1', InterestDate);
        Loans.SetFilter("Compute Interest Due on Postin", '<>%1', Loans."Compute Interest Due on Postin"::"Full Period Interest");
        if loans.FindSet(false) then begin
            repeat

                // IntrestBuffer.Reset;
                // IntrestBuffer.SetRange("Loan No.", Loans."Loan No.");
                // IntrestBuffer.SetRange(IntrestBuffer."Interest Date", InterestDate);
                // if not IntrestBuffer.FindFirst() then begin
                //     Noofdays := (CalcDate('CM', Today)) - (CalcDate('-CM', Today)) + 1;
                GeneralSetUp.Get();
                RunBilling := true;
                MoratoriumLoan.Reset();
                MoratoriumLoan.SetRange("Loan No", loans."Loan No.");
                MoratoriumLoan.SetRange(Status, MoratoriumLoan.Status::Approved);
                MoratoriumLoan.SetRange(Processed, true);
                MoratoriumLoan.SetFilter("End Date Moratorium", '=%1', Today);
                if MoratoriumLoan.FindFirst() then begin
                    RunBilling := false;
                end;
                if RunBilling = true then begin
                    ProductFactory.Reset();
                    ProductFactory.SetRange("Product ID", Loans."Loan Product Type");
                    ProductFactory.SetRange("Interest Recovered Upfront", false);
                    ProductFactory.SetFilter("Compute Interest Due on Postin", '<>%1', ProductFactory."Compute Interest Due on Postin"::"Full Period Interest");
                    ProductFactory.SetRange("No Interest Bills", false);
                    if ProductFactory.FindFirst() then begin
                        Loans.CalcFields(Loans."Outstanding Balance");
                        if (Loans."Outstanding Balance") > 0 then begin
                            Members.Reset;
                            Members.SetRange("No.", Loans."Member No.");
                            Members.SetFilter(Status, '<>%1', Members.Status::Deceased);
                            if Members.FindFirst() then begin
                                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then
                                    IntCharged := Round((Loans."Approved Amount" * ((Loans.Interest) / 1200) * 1 / Noofdays), 0.01, '=')
                                else
                                    IntCharged := Round((Loans."Outstanding Balance" * ((Loans.Interest) / 1200) * 1 / Noofdays), 0.01, '=');
                                if IntCharged > 0 then begin
                                    IntrestBuffer.Init;
                                    IntrestBuffer."Loan No." := Loans."Loan No.";
                                    IntrestBuffer."Issued Date" := Loans."Disbursement Date";
                                    IntrestBuffer."Loan Product type" := Loans."Loan Product Type";
                                    IntrestBuffer."Interest Date" := InterestDate;
                                    IntrestBuffer."Interest Amount" := IntCharged;
                                    IntrestBuffer."Repayment Amount" := Loans.Repayment;
                                    IntrestBuffer."Outstanding Balance" := Loans."Outstanding Balance";
                                    IntrestBuffer."Employer Code" := Loans."Employer Code";
                                    IntrestBuffer."Loan Product type" := Loans."Loan Product Type";
                                    IntrestBuffer.Status := Members.Status;
                                    IF IntrestBuffer."Interest Amount" > 0 then
                                        IntrestBuffer.Insert;
                                    //    end;
                                end;
                            end;
                        end;
                    end;
                END;
            until loans.next = 0;
        end;

        //Log Daily Interest successfully
    end;

    //New with Date
    procedure ComputeDaillyLoanInterestSVCs(RunDate: Date)
    var
        members: Record Members;
        IntCharged: Decimal;
        IntrestBuffer: Record "Loans Interest Buffer";
        Noofdays: Integer;
        TodaysMonth: Integer;
        InterestDate: Date;
        loans: Record loans;
    begin
        InterestDate := RunDate;
        if InterestDate = 0D then
            InterestDate := Today;
        Noofdays := (CalcDate('CM', Today)) - (CalcDate('-CM', Today)) + 1;
        loans.Reset();
        //loans.SetRange(Posted, true);
        loans.SetFilter("Outstanding Balance", '>%1', 0);
        loans.SetFilter(Interest, '>%1', 0);
        loans.SetFilter("Compute Interest Due on Postin", '<>%1&<>%2', loans."Compute Interest Due on Postin"::"Full Period Interest", loans."Compute Interest Due on Postin"::"Full Interest");
        loans.SetAutoCalcFields("Outstanding Balance");
        if loans.FindSet(false) then begin
            repeat
                IntCharged := 0;
                IntrestBuffer.Reset;
                IntrestBuffer.SetRange("Loan No.", Loans."Loan No.");
                IntrestBuffer.SetRange(IntrestBuffer."Interest Date", InterestDate);
                if not IntrestBuffer.FindFirst() then begin

                    // ProductFactory.Reset();
                    // ProductFactory.SetRange("Product ID", Loans."Loan Product Type");
                    // ProductFactory.SetRange("Interest Recovered Upfront", false);
                    // ProductFactory.SetFilter("Compute Interest Due on Postin", '<>%1', ProductFactory."Compute Interest Due on Postin"::"Full Period Interest");
                    // ProductFactory.SetRange("No Interest Bills", false);
                    // if ProductFactory.FindFirst() then begin
                    if Members.Get(loans."Member No.") then begin
                        if Members.Status <> members.Status::Deceased then begin
                            if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then
                                IntCharged := Round((Loans."Approved Amount" * ((Loans.Interest) / 1200) / Noofdays), 0.01, '>')
                            else
                                IntCharged := Round((Loans."Outstanding Balance" * ((Loans.Interest) / 1200) / Noofdays), 0.01, '>');
                            if IntCharged > 0 then begin
                                IntrestBuffer.Init;
                                IntrestBuffer."Loan No." := Loans."Loan No.";
                                IntrestBuffer."Issued Date" := Loans."Disbursement Date";
                                IntrestBuffer."Loan Product type" := Loans."Loan Product Type";
                                IntrestBuffer."Interest Date" := InterestDate;
                                IntrestBuffer."Interest Amount" := IntCharged;
                                IntrestBuffer."Repayment Amount" := Loans.Repayment;
                                IntrestBuffer."Outstanding Balance" := Loans."Outstanding Balance";
                                IntrestBuffer."Employer Code" := Loans."Employer Code";
                                IntrestBuffer.Status := Members.Status;
                                IF IntrestBuffer."Interest Amount" > 0 then
                                    IntrestBuffer.Insert;
                                Commit();
                            end;
                        end;
                    end;
                    //end;
                END;
            until loans.next = 0;
        end;

        //Log Daily Interest successfully
    end;

    procedure PostLoanMoratorium(LoanNO: Code[20])
    var
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know Mobile Banking allows you to withdraw up to a maxmum of Kes 150,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        Dim2: Code[50];
        TransCharge: Record "Transaction Charges";
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::Loan;
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        Descr := '';
        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        Descr := CopyStr(Descr, 1, 50);
        //Approved amount
        Loans.Reset();
        Loans.SetRange(Loans."Loan No.", LoanNO);
        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
        if Loans.FindFirst() then begin
            if PCharges.Get(Loans."Loan Product Type") then
                if Loans."Outstanding Balance" > 1000 then begin
                    GenSetup.TestField("Excise Duty G/L");
                    GenSetup.TestField("Excise Duty (%)");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::"G/L Account";
                    AccNo := GenSetup."Excise Duty G/L";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := Loans."Disbursement Account No";
                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := Loans."Loan Account";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    LineNo += 1000;
                    AccType := AccType::"G/L Account";
                    AcctNo := PCharges."Charges G_L Account";
                    TransType := TransType::" ";
                    BalAccType := BalAccType::"G/L Account";
                    BalAccNo := '';
                    TransCharge.Reset();
                    TransCharge.SetRange(TransCharge."Transaction Type", 'Moratorium fee');
                    if TransCharge.FindFirst() then begin
                        Amt := TransCharge."Charge Amount";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Moratorium Loan fee'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo += 1000;
                        AccType := AccType::"G/L Account";
                        AcctNo := PCharges."Charges G_L Account";
                        TransType := TransType::" ";
                        BalAccType := BalAccType::"G/L Account";
                        AccNo := Loans."Loan Account";
                        BalAccNo := Loans."Disbursement Account No";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Moratorium Loan fee'), 1, 50), Amt, AccNo, Today, BalAccType,
                       BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                end;
        end;
    end;

    //postTransfershares


    procedure PostTransferShares(ShareNo: Code[20])
    var
        ShareTransfer: Record "Share Capital Transfer Buffer";
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know M-Sacco now allows you to withdraw up to a maxmum of Kes 70,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        SaccoTrans: Codeunit "Sacco Transactions";
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        ExtDoc: Code[30];
        Description: Text;
        Dim2: Code[50];
        RunAmt: Decimal;
        Sharelins: Record "Share Capital Transfer Lines";
        SystemCreated: Boolean;
        ExtDoCN: Code[20];
        fosaAcc: Code[100];
        TransferredAcc: Code[30];
        ChargType: Record "Transaction Types";
        Transch: Record "Transaction Charges";
        Sharecharge: Decimal;
        Savingsav: Record "Savings Accounts";
        AccBa: Decimal;
        Sendsms: Codeunit SendSms;
        Source: Enum "SMS Source";
        Pfact: Record "Product Factory";
        MembersII: Record Members;
        MemberRegistration: Codeunit "Registration Process";
        SCapAcc: Record "Savings Accounts";
        ReceiverDesc: Label 'Share cap. trf to';
        SellerDesc: Label 'Share cap. trf from';
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the loans Batch Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::" ";
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        Descr := '';
        //Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        //Descr := CopyStr(Descr, 1, 50);
        //Approved amount
        Sharelins.Reset();
        Sharelins.SetRange(Sharelins."Document No.", ShareNo);
        Sharelins.SetFilter(Sharelins."Allocation Amount", '>%1', 0);
        if Sharelins.FindFirst() then begin
            fosaAcc := '';
            repeat
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", Sharelins."Destination Member No");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
                if SavAcc.FindFirst() then begin
                    fosaAcc := SavAcc."No.";
                    AccBa := Savingsav.GetAvailableBalance(fosaAcc);
                end;
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", Sharelins."Destination Member No");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Share Capital");
                if SavAcc.FindFirst() then begin
                    TransferredAcc := SavAcc."No.";
                end else begin
                    // zzzz
                    Pfact.reset;
                    Pfact.SetRange("Product Category", Pfact."Product Category"::"Share Capital");
                    Pfact.SetRange(status, Pfact.status::Active);
                    if Pfact.find('-') then begin
                        MembersII.Get(Sharelins."Destination Member No");
                        TransferredAcc := MemberRegistration.CreateSavingsAccountNo(Pfact."Product ID", MembersII."Global Dimension 1 Code", MembersII."No.");
                        MemberRegistration.AutoCreateSavingsAccount(TransferredAcc, MembersII."No.", Pfact."Product ID");
                    end;
                end;

                ShareTransfer.Reset();
                ShareTransfer.SetRange("Document No", ShareNo);
                if ShareTransfer.FindFirst() then begin
                    Members.Reset();
                    Members.SetRange("No.", ShareTransfer."Source Member No");
                    if Members.FindFirst() then begin
                        if Members.Status = Members.Status::Active then
                            Error('Active members should no transfer Shares');
                    end;

                end;
                ChargType.Reset();
                ChargType.SetRange(ChargType.Code, GenSetup."Share Transfer Fee");
                if ChargType.FindFirst() then begin
                    Transch.Reset();
                    Transch.SetRange(Transch."Transaction Type", ChargType.Code);
                    if Transch.FindFirst() then
                        Sharecharge := Transch."Charge Amount";
                end;

                if AccBa < (Sharecharge + (Sharecharge * GenSetup."Excise Duty (%)" * 0.01)) then
                    Error('Member ' + Sharelins."Destination Member No" + ' does not have sufficient funds in the fosa account to complete this process');
                if ShareTransfer."Source Balance" > 0 then begin
                    GenSetup.TestField("Excise Duty G/L");
                    GenSetup.TestField("Excise Duty (%)");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::"G/L Account";
                    AccNo := GenSetup."Excise Duty G/L";
                    Amt := Sharecharge;
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";

                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr((ShareTransfer.Description + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                    BalAccNo, ShareTransfer."Document No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := fosaAcc;
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr((ShareTransfer.Description + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, ShareTransfer."Reference No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo += 1000;
                    AccType := AccType::"G/L Account";
                    AcctNo := Transch."G/L Account";
                    TransType := TransType::" ";
                    BalAccType := BalAccType::"G/L Account";
                    BalAccNo := '';
                    Amt := Sharecharge;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr((ShareTransfer.Description + '-Transfer Processing fee'), 1, 50), Amt * -1, AcctNo, Today, BalAccType,
                    BalAccNo, ShareTransfer."Reference No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo += 1000;
                    AccType := AccType::Savings;
                    TransType := TransType::" ";
                    BalAccType := BalAccType::"G/L Account";
                    AccNo := fosaAcc;
                    BalAccNo := '';
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr((ShareTransfer.Description + '- Transfer Processing fee'), 1, 50), Amt, AccNo, Today, BalAccType,
                   BalAccNo, ShareTransfer."Reference No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := ShareTransfer."Source Account No";
                    Amt := Sharelins."Allocation Amount";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := Sharelins."Allocation Amount";

                    if SCapAcc.Get(ShareTransfer."Source Account No") then begin
                        if SCapAcc.Blocked <> SCapAcc.Blocked::" " then begin
                            SCapAcc."Blocked Buffer" := SCapAcc.Blocked;
                            SCapAcc.Blocked := SCapAcc.Blocked::" ";
                            SCapAcc.Modify();
                        end;
                    end;

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr(('Share Capital Transfer to ' + Sharelins."Destination Member No"), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, ShareTransfer."Reference No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := TransferredAcc;
                    TransType := Transtype::" ";
                    BalAccNo := '';
                    BalAccType := Balacctype::"G/L Account";
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, ShareTransfer."Document No", CopyStr(('Share Capital Transfer from ' + ShareTransfer."Source Member No"), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                    BalAccNo, ShareTransfer."Reference No", Dim1, Dim2, TransType, ShareTransfer."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                end;
                if AccBa > Sharecharge then begin
                    msg := 'You have successfuly purchased sharecapital from member ' + Members."No." + ' ';
                    SendSMS.SendSms(Source::Shares, Sharelins."Mobile No", msg, Format(Sharelins."Document No."), '', true, 0, false, 'CBS', Sharelins."Document No.", 'CBS');
                    msg := 'You have successfuly transffered sharecapital to member ' + Sharelins."Mobile No" + ' ';
                    SendSMS.SendSms(Source::Shares, ShareTransfer."Source Mobile Number", msg, Format(Sharelins."Document No."), '', true, 0, false, 'CBS', Sharelins."Document No.", 'CBS');
                end;
                JournalPosting.CompletePosting(Jtemplate, JBatch);
            until Sharelins.Next() = 0;

            if SCapAcc.Get(ShareTransfer."Source Account No") then begin
                if SCapAcc."Blocked Buffer" <> SCapAcc."Blocked Buffer"::" " then begin
                    SCapAcc.Blocked := SCapAcc."Blocked Buffer";
                    SCapAcc."Blocked Buffer" := SCapAcc."Blocked Buffer"::" ";
                    SCapAcc.Modify();
                end;
            end;
            ShareTransfer.Reset();
            ShareTransfer.SetRange("Document No", ShareNo);
            if ShareTransfer.FindFirst() then begin
                Members.Reset();
                Members.SetRange("No.", ShareTransfer."Source Member No");
                if Members.FindFirst() then begin
                    Members.Status := Members.Status::Closed;
                    Members.Modify();
                end;
            end;
        end;
    end;

    procedure PostPayRoll(DocumentNO: Code[20])
    var
        BoardMember: Record "Board members";
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know M-Sacco now allows you to withdraw up to a maxmum of Kes 70,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        SaccoTrans: Codeunit "Sacco Transactions";
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        ExtDoc: Code[30];
        Description: Text;
        Dim2: Code[50];
        RunAmt: Decimal;
        BoardLine: Record "Board Payroll Deductions";
        SystemCreated: Boolean;
        ExtDoCN: Code[20];
        fosaAcc: Code[100];
        ChargType: Record "Transaction Types";
        Transch: Record "Transaction Charges";
        Sharecharge: Decimal;
        Savingsav: Record "Savings Accounts";
        AccBa: Decimal;
        Sendsms: Codeunit SendSms;
        Source: Enum "SMS Source";
        Loansrec: Record Loans;
        LoanAcc: Code[30];
        AmounttoPos: Decimal;
        RuNbal: Decimal;
        BoaAll2: Record "PR Board Transactions";
        Runbal2: Decimal;
        BoardEarnings: Record "prBoard Earnings";
        BAllw: Decimal;
        loaNN: Code[30];
        RunBal3: Decimal;
        Runbal4: Decimal;
        AmtTax: Decimal;
        TaxableAmountt: Decimal;
        TotaBoard: Decimal;
        BoardDed: Decimal;
        BoardAllw: Record "PR Board Transactions";
        GlAcc: Code[30];
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Salary Journal Template";
        JBatch := Temp."Salary Journal Batch";

        if Jtemplate = '' then begin
            Error('Ensure the salaries Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the salaries Batch Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::" ";
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        LoanAcc := '';
        AccBa := 0;
        fosaAcc := '';
        RunAmt := 0;
        BoardDed := 0;
        RuNbal := 0;
        Runbal2 := 0;
        Runbal4 := 0;
        RunBal3 := 0;
        Descr := '';
        BAllw := 0;
        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        Descr := CopyStr(Descr, 1, 50);
        BoardLine.Reset();
        BoardMember.SetRange(BoardMember."No.", DocumentNO);
        if BoardMember.FindFirst() then begin
            ChargType.Reset();
            ChargType.SetRange(Type, ChargType.Type::"Board Salary");
            if ChargType.FindFirst() then begin
                Transch.Reset();
                Transch.SetRange(Transch."Transaction Type", ChargType.Code);
                if Transch.FindFirst() then
                    Sharecharge := Transch."Charge Amount";
            end;
        end;
        BoardAllw.Reset();
        BoardAllw.setrange(BoardAllw."No.", DocumentNO);
        if BoardAllw.FindFirst() then begin
            repeat
                BoardEarnings.Reset();
                BoardEarnings.SetRange(BoardEarnings.Code, BoardAllw.Code);
                BoardEarnings.SetRange(BoardEarnings.Taxable, true);
                if BoardEarnings.FindFirst() then begin
                    BoaAll2.Reset();
                    BoaAll2.SetRange(BoaAll2.Code, BoardEarnings.Code);
                    if BoaAll2.FindFirst() then begin
                        AmtTax := AmtTax + BoaAll2.Amount;

                    end;
                end;
            until BoardAllw.Next() = 0;
        end;
        //kkaimor
        BoardMember.Reset();
        BoardMember.SetRange("No.", DocumentNO);
        if BoardMember.FindFirst() then begin
            TotaBoard := BoardMember."Board Retainer";

            ;
            SavAcc.Reset();
            SavAcc.SetRange("Member No.", BoardMember."Member No.");
            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
            if SavAcc.FindFirst() then begin
                fosaAcc := SavAcc."No.";
                AccBa := Savingsav.GetAvailableBalance(fosaAcc);
            end;

            if (TotaBoard + AmtTax) > 0 then begin
                GenSetup.TestField("Excise Duty G/L");
                GenSetup.TestField("Excise Duty (%)");
                LineNo := LineNo + 10000;
                AccType := Acctype::"G/L Account";
                AccNo := GenSetup."Withholding Tax Account";
                Amt := TotaBoard + AmtTax;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                Amt := Amt * GenSetup."Withholding %" * 0.01;
                RuNbal := TotaBoard + AmtTax - Amt;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-WithHolding Tax'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo := LineNo + 10000;
                AccType := Acctype::Savings;
                AccNo := fosaAcc;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-WithHolding Tax'), 1, 50), Amt, AccNo, Today, BalAccType,
                BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                LineNo := LineNo + 10000;
                AccType := Acctype::"G/L Account";
                AccNo := GenSetup."Excise Duty G/L";
                Amt := Sharecharge;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo := LineNo + 10000;
                AccType := Acctype::Savings;
                AccNo := fosaAcc;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
                BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo += 1000;
                AccType := AccType::"G/L Account";
                AcctNo := GenSetup."Board Salaries Account";
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                BalAccNo := '';
                Amt := Sharecharge;
                RuNbal := RuNbal - Sharecharge;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Board Salary Processing fee'), 1, 50), Amt * -1, AcctNo, Today, BalAccType,
                BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo += 1000;
                AccType := AccType::Savings;
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                AccNo := fosaAcc;
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '- Board Salary Processing fee'), 1, 50), Amt, AccNo, Today, BalAccType,
               BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            end;
        end;
        //Approved amount

        BoardAllw.Reset();
        BoardAllw.SetRange("No.", DocumentNO);
        BoardAllw.SetRange("Is Deduction", true);
        if BoardAllw.FindFirst() then begin
            repeat
                GenSetup.TestField("Excise Duty G/L");
                GenSetup.TestField("Excise Duty (%)");
                LineNo := LineNo + 1000;
                AccType := Acctype::"G/L Account";
                AccNo := GenSetup."Withholding Tax Account";
                Amt := BoardMember."Total earnings";
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                Amt := BoardAllw.Amount;
                RunBal3 := RunBal3 + Amt;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Dedcutcion'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo := LineNo + 1000;
                AccType := Acctype::Savings;
                AccNo := fosaAcc;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Dedcutcion'), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            until BoardAllw.Next() = 0;
        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("No.", DocumentNO);
        BoardAllw.SetRange("Is Deduction", false);
        if BoardAllw.FindFirst() then begin
            repeat
                Amt := 0;
                AccType := AccType::"G/L Account";
                LineNo += 1000;
                AcctNo := GenSetup."Board Salaries Account";
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                BalAccNo := '';
                Amt := BoardAllw.Amount;
                Runbal4 := Runbal4 + Amt;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Allowance'), 1, 50), Amt, AcctNo, Today, BalAccType,
                BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                LineNo += 1000;
                AccType := AccType::Savings;
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                AccNo := fosaAcc;
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Allowance'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
               BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            until BoardAllw.Next() = 0;
        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("No.", DocumentNO);
        BoardAllw.SetRange("Is Deduction", true);
        if BoardAllw.FindFirst() then begin

            BoardAllw.CalcSums(Amount);
            BoardDed := BoardAllw.Amount;

        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("No.", DocumentNO);
        BoardAllw.SetRange("Is Deduction", false);
        if BoardAllw.FindFirst() then begin
            BoardAllw.CalcSums(Amount);
            BAllw := BoardAllw.Amount;
        end;

        BoardLine.Reset();
        BoardLine.SetRange(BoardLine."Document No", DocumentNO);
        BoardLine.SetFilter(BoardLine."Amount LCY", '>%1', 0);
        if BoardLine.FindFirst() then begin
            repeat
                Loansrec.Reset();
                Loansrec.SetRange("Loan No.", BoardLine."Related No.");
                if Loansrec.FindFirst() then begin
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Loans then begin
                        LoanAcc := Loansrec."Loan Account";
                        loaNN := Loansrec."Loan No.";
                    end;
                end;

                // IF RuNbal < Sharecharge then
                //     Error('Total earnings cannot offset the charges');
                if RuNbal > 0 then begin
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Savings then begin
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := BoardLine."Related No.";
                        Amt := BoardLine."Amount LCY";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Runbal2 := Amt;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Board payment'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                        BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        TransType := Transtype::" ";
                        BalAccNo := '';
                        AccNo := fosaAcc;
                        BalAccType := Balacctype::"G/L Account";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Board Payment'), 1, 50), Amt, AccNo, Today, BalAccType,
                        BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Loans then
                        if LoanAcc <> '' then begin
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Credit;
                            AccNo := LoanAcc;
                            Amt := BoardLine."Amount LCY";
                            TransType := Transtype::Repayment;
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            RunAmt := Amt;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Loan Rapayment'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                            BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, loaNN, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            TransType := Transtype::" ";
                            BalAccNo := '';
                            AccNo := GenSetup."Board Salaries Account";
                            BalAccType := Balacctype::"G/L Account";
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Loan Rapayment'), 1, 50), Amt, AccNo, Today, BalAccType,
                            BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        end;
                end;
            until BoardLine.Next() = 0;

        end;
        //posttofosa
        AmounttoPos := RuNbal - RunAmt - Runbal2 - BoardDed;
        AmounttoPos := AmounttoPos + BAllw;
        BoardMember.Reset();
        BoardMember.SetRange("No.", DocumentNO);
        if BoardMember.FindFirst() then begin
            SavAcc.Reset();
            SavAcc.SetRange("Member No.", BoardMember."Member No.");
            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
            if SavAcc.FindFirst() then begin
                fosaAcc := SavAcc."No.";
                AccBa := Savingsav.GetAvailableBalance(fosaAcc);
            end;
            LineNo += 1000;
            AccType := AccType::"G/L Account";
            AcctNo := GenSetup."Board Salaries Account";
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            BalAccNo := '';
            Amt := AmounttoPos;
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description), 1, 50), Amt, AcctNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            LineNo += 1000;
            AccType := AccType::Savings;
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            AccNo := fosaAcc;
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description), 1, 50), Amt * -1, AccNo, Today, BalAccType,
           BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        end;
        JournalPosting.CompletePosting(Jtemplate, JBatch);
        Message('Board Payroll Payments Posted Successfully');

        if BoardMember."Withholding Tax Amount" <> 0 then begin

        end;
    end;

    procedure PostBoardPayments(PaymentLine: record "Payment Line Board")
    var
        BoardMember: Record "Board members";
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know M-Sacco now allows you to withdraw up to a maxmum of Kes 70,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        SaccoTrans: Codeunit "Sacco Transactions";
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        ExtDoc: Code[30];
        Description: Text;
        Dim2: Code[50];
        RunAmt: Decimal;
        BoardLine: Record "Board Payroll Deductions";
        SystemCreated: Boolean;
        ExtDoCN: Code[20];
        fosaAcc: Code[100];
        ChargType: Record "Transaction Types";
        Transch: Record "Transaction Charges";
        Sharecharge: Decimal;
        Savingsav: Record "Savings Accounts";
        AccBa: Decimal;
        Sendsms: Codeunit SendSms;
        Source: Enum "SMS Source";
        Loansrec: Record Loans;
        LoanAcc: Code[30];
        AmounttoPos: Decimal;
        RuNbal: Decimal;
        BoaAll2: Record "PR Board Transactions";
        Runbal2: Decimal;
        BoardEarnings: Record "prBoard Earnings";
        BAllw: Decimal;
        loaNN: Code[30];
        RunBal3: Decimal;
        Runbal4: Decimal;
        AmtTax: Decimal;
        TaxableAmountt: Decimal;
        TotaBoard: Decimal;
        BoardDed: Decimal;
        BoardAllw: Record "PR Board Transactions";
        GlAcc: Code[30];
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Salary Journal Template";
        JBatch := Temp."Salary Journal Batch";

        if Jtemplate = '' then begin
            Error('Ensure the salaries Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the salaries Batch Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::" ";
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        LoanAcc := '';
        AccBa := 0;
        fosaAcc := '';
        RunAmt := 0;
        BoardDed := 0;
        RuNbal := 0;
        Runbal2 := 0;
        Runbal4 := 0;
        RunBal3 := 0;
        Descr := '';
        BAllw := 0;
        Sharecharge := 0;

        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        Descr := CopyStr(Descr, 1, 50);
        //BoardLine.Reset();
        // BoardMember.SetRange(BoardMember."No.", DocumentNO);
        //if BoardMember.FindFirst() then begin
        ChargType.Reset();
        ChargType.SetRange(Type, ChargType.Type::"Board Salary");
        if ChargType.FindFirst() then begin
            Transch.Reset();
            Transch.SetRange(Transch."Transaction Type", ChargType.Code);
            if Transch.FindFirst() then
                Sharecharge := Sharecharge + Transch."Charge Amount";
        end;
        // end;
        BoardAllw.Reset();
        BoardAllw.setrange(BoardAllw."Payment No.", PaymentLine."Document No");
        BoardAllw.SetRange("No.", PaymentLine."Member No.");
        if BoardAllw.FindFirst() then begin
            repeat
                BoardEarnings.Reset();
                BoardEarnings.SetRange(BoardEarnings.Code, BoardAllw.Code);
                BoardEarnings.SetRange(BoardEarnings.Taxable, true);
                if BoardEarnings.FindFirst() then begin
                    BoaAll2.Reset();
                    BoaAll2.SetRange(BoaAll2.Code, BoardEarnings.Code);
                    if BoaAll2.FindFirst() then begin
                        AmtTax := AmtTax + BoaAll2.Amount;
                    end;
                end;
            until BoardAllw.Next() = 0;
        end;

        // get Total Retained Earning
        TotaBoard := PaymentLine.Amount;

        // Fetch the members' FOSA Account
        SavAcc.Reset();
        SavAcc.SetRange("Member No.", BoardMember."Member No.");
        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
        if SavAcc.FindFirst() then begin
            fosaAcc := SavAcc."No.";
            AccBa := Savingsav.GetAvailableBalance(fosaAcc);
        end;

        // Insert Into journal total the withholding tax form taxable earnings and retained earnings
        if (TotaBoard + AmtTax) > 0 then begin
            GenSetup.TestField("Excise Duty G/L");
            GenSetup.TestField("Excise Duty (%)");
            LineNo := LineNo + 10000;
            AccType := Acctype::"G/L Account";
            AccNo := GenSetup."Withholding Tax Account";
            Amt := TotaBoard + AmtTax;
            TransType := Transtype::" ";
            BalAccType := Balacctype::"G/L Account";
            Amt := Amt * GenSetup."Withholding %" * 0.01;
            RuNbal := TotaBoard + AmtTax - Amt;
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-WithHolding Tax'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            //Credit the FOSA Account
            LineNo := LineNo + 10000;
            AccType := Acctype::Savings;
            AccNo := fosaAcc;
            TransType := Transtype::" ";
            BalAccType := Balacctype::"G/L Account";
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-WithHolding Tax'), 1, 50), Amt, AccNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            // Excise duty for the earnings
            LineNo := LineNo + 10000;
            AccType := Acctype::"G/L Account";
            AccNo := GenSetup."Excise Duty G/L";
            Amt := Sharecharge;
            TransType := Transtype::" ";
            BalAccType := Balacctype::"G/L Account";
            Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            AccType := Acctype::Savings;
            AccNo := fosaAcc;
            TransType := Transtype::" ";
            BalAccType := Balacctype::"G/L Account";
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            LineNo += 1000;

            // Salary processing fee
            LineNo += 1000;
            AccType := AccType::"G/L Account";
            AcctNo := GenSetup."Board Salaries Account";
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            BalAccNo := '';
            Amt := Sharecharge;
            RuNbal := RuNbal - Sharecharge;
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '-Board Salary Processing fee'), 1, 50), Amt * -1, AcctNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            // 
            LineNo += 1000;
            AccType := AccType::Savings;
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            AccNo := fosaAcc;
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description + '- Board Salary Processing fee'), 1, 50), Amt, AccNo, Today, BalAccType,
           BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("Payment No.", PaymentLine."Document No");
        BoardAllw.SetRange("No.", PaymentLine."Member No.");
        BoardAllw.SetRange("Is Deduction", true);
        if BoardAllw.FindFirst() then begin
            repeat
                GenSetup.TestField("Excise Duty G/L");
                GenSetup.TestField("Excise Duty (%)");
                LineNo := LineNo + 1000;
                AccType := Acctype::"G/L Account";
                AccNo := GenSetup."Withholding Tax Account";
                Amt := BoardMember."Total earnings";
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                Amt := BoardAllw.Amount;
                RunBal3 := RunBal3 + Amt;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Dedcutcion'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                LineNo := LineNo + 1000;
                AccType := Acctype::Savings;
                AccNo := fosaAcc;
                TransType := Transtype::" ";
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Dedcutcion'), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            until BoardAllw.Next() = 0;
        end;

        // Allowances
        BoardAllw.Reset();
        BoardAllw.SetRange("Payment No.", PaymentLine."Document No");
        BoardAllw.SetRange("No.", PaymentLine."Member No.");
        BoardAllw.SetRange("Is Deduction", false);
        if BoardAllw.FindFirst() then begin
            repeat
                Amt := 0;
                AccType := AccType::"G/L Account";
                LineNo += 1000;
                AcctNo := GenSetup."Board Salaries Account";
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                BalAccNo := '';
                Amt := BoardAllw.Amount;
                Runbal4 := Runbal4 + Amt;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Allowance'), 1, 50), Amt, AcctNo, Today, BalAccType,
                BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                LineNo += 1000;
                AccType := AccType::Savings;
                TransType := TransType::" ";
                BalAccType := BalAccType::"G/L Account";
                AccNo := fosaAcc;
                BalAccNo := '';
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardAllw."No.", CopyStr((BoardAllw.Name + '-Allowance'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
               BalAccNo, BoardAllw."No.", Dim1, Dim2, TransType, BoardAllw."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            until BoardAllw.Next() = 0;
        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("Payment No.", PaymentLine."Document No");
        BoardAllw.SetRange("No.", PaymentLine."Member No.");
        BoardAllw.SetRange("Is Deduction", true);
        if BoardAllw.FindFirst() then begin

            BoardAllw.CalcSums(Amount);
            BoardDed := BoardAllw.Amount;
        end;
        BoardAllw.Reset();
        BoardAllw.SetRange("Payment No.", PaymentLine."Document No");
        BoardAllw.SetRange("No.", PaymentLine."Member No.");
        BoardAllw.SetRange("Is Deduction", false);
        if BoardAllw.FindFirst() then begin
            BoardAllw.CalcSums(Amount);
            BAllw := BoardAllw.Amount;
        end;
        BoardLine.Reset();
        BoardLine.SetRange(BoardLine."Document No", PaymentLine."Document No");
        BoardLine.SetRange("Member No", PaymentLine."Member No.");
        BoardLine.SetFilter(BoardLine."Amount LCY", '>%1', 0);
        if BoardLine.findfirst then begin
            repeat
                Loansrec.Reset();
                Loansrec.SetRange("Loan No.", BoardLine."Related No.");
                if Loansrec.FindFirst() then begin
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Loans then begin
                        LoanAcc := Loansrec."Loan Account";
                        loaNN := Loansrec."Loan No.";
                    end;
                end;
                if RuNbal > 0 then begin
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Savings then begin
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := BoardLine."Related No.";
                        Amt := BoardLine."Amount LCY";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        Runbal2 := Amt;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Board payment'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                        BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        TransType := Transtype::" ";
                        BalAccNo := '';
                        AccNo := fosaAcc;
                        BalAccType := Balacctype::"G/L Account";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Board Payment'), 1, 50), Amt, AccNo, Today, BalAccType,
                        BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;
                    if BoardLine."Deduction Type" = BoardLine."Deduction Type"::Loans then
                        if LoanAcc <> '' then begin
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Credit;
                            AccNo := LoanAcc;
                            Amt := BoardLine."Amount LCY";
                            TransType := Transtype::Repayment;
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            RunAmt := Amt;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Loan Rapayment'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                            BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, loaNN, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            TransType := Transtype::" ";
                            BalAccNo := '';
                            AccNo := GenSetup."Board Salaries Account";
                            BalAccType := Balacctype::"G/L Account";
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardLine."Related No.", CopyStr(('-Loan Rapayment'), 1, 50), Amt, AccNo, Today, BalAccType,
                            BalAccNo, BoardLine."Related No.", Dim1, Dim2, TransType, BoardLine."Related No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;
                end;
            until BoardLine.Next() = 0;
        end;
        AmounttoPos := RuNbal - RunAmt - Runbal2 - BoardDed;
        AmounttoPos := AmounttoPos + BAllw;
        SavAcc.Reset();
        SavAcc.SetRange("Member No.", PaymentLine."Member No.");
        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
        if SavAcc.FindFirst() then begin
            fosaAcc := SavAcc."No.";
            AccBa := Savingsav.GetAvailableBalance(fosaAcc);

            // Credit FOSA
            LineNo += 1000;
            AccType := AccType::"G/L Account";
            AcctNo := GenSetup."Board Salaries Account";
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            BalAccNo := '';
            Amt := AmounttoPos;
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description), 1, 50), Amt, AcctNo, Today, BalAccType,
            BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            LineNo += 1000;
            AccType := AccType::Savings;
            TransType := TransType::" ";
            BalAccType := BalAccType::"G/L Account";
            AccNo := fosaAcc;
            BalAccNo := '';
            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, BoardMember."No.", CopyStr((BoardMember.Description), 1, 50), Amt * -1, AccNo, Today, BalAccType,
           BalAccNo, BoardMember."No.", Dim1, Dim2, TransType, BoardMember."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        end
        else
            Error('Member has no FOSA Account');

        JournalPosting.CompletePosting(Jtemplate, JBatch);
        Message('Board Payroll Payments Posted Successfully');
    end;


    procedure PostLoanReshedule(LoanNO: Code[20])
    var
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know M-Sacco now allows you to withdraw up to a maxmum of Kes 70,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        UserSetup: Record "User Setup";
        FosaAcc: Code[30];
        Dim1: Code[50];
        Dim2: Code[50];
        TransCharge: Record "Transaction Charges";
        PrCharges: Record "Loan Product Charges";
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::Loan;
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        Descr := '';
        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        Descr := CopyStr(Descr, 1, 50);
        //Approved amount
        Loans.Reset();
        Loans.SetRange(Loans."Loan No.", LoanNO);
        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
        if Loans.FindFirst() then begin
            Loans.CalcFields(Loans."Outstanding Balance");
            SavAcc.Reset();
            SavAcc.SetRange("Member No.", Loans."Member No.");
            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
            if SavAcc.FindFirst() then
                FosaAcc := SavAcc."No.";
            PCharges.Reset();
            PCharges.SetRange(PCharges."Charge Type", PCharges."Charge Type"::"Loan Reschedule");
            PrCharges.SetRange("Product Code", Loans."Loan Product Type");
            if PCharges.FindFirst() then
                if Loans."Outstanding Balance" > 1000 then begin
                    GenSetup.TestField("Excise Duty G/L");
                    GenSetup.TestField("Excise Duty (%)");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::"G/L Account";
                    AccNo := GenSetup."Excise Duty G/L";

                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := PCharges."Charge Amount" * GenSetup."Excise Duty (%)" * 0.01;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := FosaAcc;
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
                    BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    LineNo += 1000;
                    AccType := AccType::"G/L Account";
                    AcctNo := PCharges."Charges G_L Account";
                    TransType := TransType::" ";
                    BalAccType := BalAccType::"G/L Account";
                    BalAccNo := '';
                    PrCharges.Reset();
                    PCharges.SetRange(PCharges."Charge Type", PCharges."Charge Type"::"Loan Reschedule");
                    PrCharges.SetRange("Product Code", Loans."Loan Product Type");
                    if TransCharge.FindFirst() then begin
                        Amt := TransCharge."Charge Amount";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Loan Reschedule'), 1, 50), Amt * -1, AcctNo, Today, BalAccType,
                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo += 1000;
                        AccType := AccType::Savings;
                        AcctNo := FosaAcc;
                        TransType := TransType::" ";
                        BalAccType := BalAccType::"G/L Account";
                        AccNo := FosaAcc;
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Loan Reschedule'), 1, 50), Amt, AcctNo, Today, BalAccType,
                       BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                end;
        end;
        JournalPosting.CompletePosting(Jtemplate, JBatch);
    end;

    procedure PostLoanStructure(LoanNO: Code[20])
    var
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Did you know M-Sacco now allows you to withdraw up to a maxmum of Kes 70,000?.';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        Dim2: Code[50];
        TransCharge: Record "Transaction Charges";
        ProCharges: Record "Loan Product Charges";
        FosaAcc: code[30];
        TaxableAmt: Decimal;
    begin
        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS

        //PRORATED DAYS

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        if not GenBatch.Get(Jtemplate, JBatch) then begin
            GenBatch.Init;
            GenBatch."Journal Template Name" := Jtemplate;
            GenBatch.Name := JBatch;
            GenBatch.Insert;
        end;
        GenSetup.Get;
        AccType := Acctype::"G/L Account";
        AccNo := LoanApps."Loan Account";
        TransType := Transtype::Loan;
        BalAccType := Balacctype::"G/L Account";
        BalAccNo := '';
        Amt := 0;
        LineNo := LineNo + 10000;
        Descr := '';
        Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
        Descr := CopyStr(Descr, 1, 50);
        //Approved amount
        Loans.Reset();
        Loans.SetRange(Loans."Loan No.", LoanNO);
        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
        if Loans.FindFirst() then begin
            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
            TaxableAmt := Loans."Outstanding Balance" + Loans."Outstanding Interest";
            SavAcc.Reset();
            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
            SavAcc.SetRange("Member No.", Loans."Member No.");
            if SavAcc.FindFirst() then
                FosaAcc := SavAcc."No.";

            Loans.CalcFields(Loans."Outstanding Balance");
            ProCharges.Reset();
            ProCharges.SetRange(ProCharges."Charge Type", ProCharges."Charge Type"::"Loan Restructure");
            //ProCharges.SetRange("Product Code", Loans."Loan Product Type");
            if ProCharges.FindFirst() then
                if Loans."Outstanding Balance" > 1000 then begin
                    GenSetup.TestField("Excise Duty G/L");
                    GenSetup.TestField("Excise Duty (%)");
                    LineNo := LineNo + 10000;
                    AccType := Acctype::"G/L Account";
                    AccNo := GenSetup."Excise Duty G/L";
                    TransType := Transtype::" ";
                    Amt := ProCharges."Charge Amount";
                    if Amt = 0 then
                        Amt := TaxableAmt;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                    if ProCharges."Effect Excise Duty" = ProCharges."Effect Excise Duty"::Yes then begin
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt * -1, AccNo, Today, BalAccType,
                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := FosaAcc;
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, Today, BalAccType,
                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                    LineNo += 1000;
                    AccType := AccType::"G/L Account";
                    AcctNo := ProCharges."Charges G_L Account";
                    TransType := TransType::" ";
                    BalAccType := BalAccType::"G/L Account";
                    BalAccNo := '';
                    ProCharges.Reset();
                    ProCharges.SetRange(ProCharges."Charge Type", ProCharges."Charge Type"::"Loan Restructure");
                    //ProCharges.SetRange("Product Code", Loans."Loan Product Type");
                    if ProCharges.FindFirst() then begin
                        Amt := TaxableAmt * ProCharges.Percentage * 0.01;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Loan Restructure Interest'), 1, 50), Amt * -1, AcctNo, Today, BalAccType,
                        BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo += 1000;
                        AccType := AccType::Savings;
                        TransType := TransType::" ";
                        BalAccType := BalAccType::"G/L Account";
                        AccNo := FosaAcc;
                        BalAccNo := '';

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, Loans."Loan No.", CopyStr((PCharges."Charge Description" + '-Loan Restructure Interest'), 1, 50), Amt, AccNo, Today, BalAccType,
                       BalAccNo, Loans."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                end;
        end;
        JournalPosting.CompletePosting(Jtemplate, JBatch);
    end;

    procedure DefaulterLoanRecovery(LoanRecoveryHeader: Record "Loan Rescheduling")
    var
        myInt: Integer;
        ConfMessage: label 'Are you sure you want to convert this loan to a defaulter loan?';
        Dim1: Code[20];
        Dim2: Code[20];
        GenJournalLine: record "Gen. Journal Line";
        Loans: Record loans;
        RunBal: Decimal;
        ProductFactory: Record "Product Factory";
        MainProductFactory: Record "Product Factory";
        mem: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccountNo: Code[20];
        CreditAcount: Record "Credit Accounts";
        NewLoans: Record loans;
        LoanRepaymentShedule: Record "Ideal Repayment Schedule";
        TransAmt: Decimal;
        Description: text[255];
        CompanyInfo: record "Company Information";
        IntstallMentPeriodText: Text[50];
        InstalmentPeriods: Text[50];
        UserSetup: Record "User Setup";
        AccountNo: Code[20];
        SaccoTrans: Codeunit "Sacco Transactions";
        AccountType: Enum "Gen. Journal Account Type";
        LoanGuar: Record "Loan Guarantors and Security";
        LoanGuarOld: Record "Loan Guarantors and Security";
    begin
        Temp.GET(USERID);
        RunBal := 0;
        AccountNo := '';
        Jtemplate := Temp."Loan Recovery Template";
        JBatch := Temp."Loan Recovery Batch";

        UserSetup.GET(USERID);

        Dim1 := UserSetup."Global Dimension 1 Code";
        Dim2 := UserSetup."Global Dimension 2 Code";

        //CLEAR BATCH
        GenJournalLine.SETRANGE("Journal Template Name", Jtemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", JBatch);
        GenJournalLine.DELETEALL;
        IF not CONFIRM(ConfMessage) THEN exit;
        IF Loans.GET(LoanRecoveryHeader."Loan No.") THEN BEGIN
            Loans.CALCFIELDS(Loans."Outstanding Balance", Loans."Outstanding Interest", loans."Daily Interest");
            RunBal := Loans."Outstanding Balance" + Loans."Outstanding Interest" + round(loans."Daily Interest", 0.01, '=');
            if Loans."Approved Amount" > RunBal then Loans."Approved Amount" := RunBal;
            mem.Get(LoanRecoveryHeader."Member No.");
            SavingsAccounts.reset;
            SavingsAccounts.SetRange("Member No.", mem."No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
            if SavingsAccounts.find('-') then
                AccountNo := SavingsAccounts."No.";

            MainProductFactory.Get(Loans."Loan Product Type");
            MainProductFactory.TestField("Deafulter Loan Product");
            if ProductFactory.Get(MainProductFactory."Deafulter Loan Product") then begin

                CreditAccountNo := ProductFactory."Account No. Prefix" + mem."No." + ProductFactory."Account No. Suffix";
                if not CreditAcount.Get(CreditAccountNo) then begin
                    CreditAccountNo := LoanProcess.CreateLoanAccount(mem."No.", ProductFactory."Product ID");
                end;

                NewLoans.Reset;
                NewLoans.SetRange(NewLoans."Member No.", mem."No.");
                NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
                NewLoans.SetFilter("Outstanding Balance", '=%1', 0);
                NewLoans.SetRange(NewLoans.Posted, false);
                if NewLoans.Find('-') then
                    NewLoans.DeleteAll;

                //Create Loan
                NewLoans.Init;
                NewLoans."Loan No." := '';
                NewLoans."Member No." := LoanRecoveryHeader."Member No.";
                if Members.Get(LoanRecoveryHeader."Member No.") then begin
                    NewLoans."Member Name" := Members.Name;
                    NewLoans."Staff No" := Members."Payroll/Staff No.";
                    NewLoans."Employer Code" := Members."Employer Code";
                    NewLoans."Application Date" := Today;
                end;
                NewLoans."Loan Product Type" := ProductFactory."Product ID";
                //NewLoans.VALIDATE(NewLoans."Loan Product Type");
                NewLoans."Loan Product Type Name" := ProductFactory."Product Description";
                NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
                NewLoans.Interest := ProductFactory."Interest Rate (Min.)";
                NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
                NewLoans."Interest Calculation Method" := Loans."Interest Calculation Method";
                Loans.CalcFields("Loan Span");
                NewLoans."Loan Span" := Loans."Loan Span";
                NewLoans.Installments := Loans.Installments;
                NewLoans."Compute Interest Due on Postin" := Loans."Compute Interest Due on Postin";
                NewLoans."Repayment Frequency" := Loans."Repayment Frequency";
                NewLoans."Recovery Mode" := Loans."Recovery Mode";
                NewLoans."Appraisal Parameter Type" := ProductFactory."Appraisal Parameter Type";
                NewLoans."Recovery Priority" := ProductFactory."Recovery Priority";
                NewLoans."Application Date" := Today;
                NewLoans."Requested Amount" := RunBal;
                NewLoans."Approved Amount" := RunBal;
                NewLoans.Validate(NewLoans."Approved Amount");
                NewLoans.Status := NewLoans.Status::Approved;
                NewLoans."Disbursement Date" := today;
                NewLoans."Repayment Start Date" := today;
                //compute expected end date based on application date
                if Format(ProductFactory."Grace Period - Principle") <> '' then begin
                    NewLoans."Repayment Start Date" := CalcDate(ProductFactory."Grace Period - Principle", NewLoans."Application Date");
                    NewLoans."Repayment Start Date" := CalcDate('CM', NewLoans."Repayment Start Date");
                    IntstallMentPeriodText := Format(NewLoans.Installments) + 'M';
                    Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                    NewLoans."Expected Date of Completion" := CalcDate(InstalmentPeriods, NewLoans."Repayment Start Date");
                end else begin
                    NewLoans."Repayment Start Date" := CalcDate('CM', NewLoans."Application Date");
                    IntstallMentPeriodText := Format(NewLoans.Installments) + 'M';
                    Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                    NewLoans."Expected Date of Completion" := CalcDate(InstalmentPeriods, NewLoans."Repayment Start Date");
                end;
                //NewLoans.batch"Batch No.":="Batch No.";
                NewLoans."Loan Account" := CreditAccountNo;
                NewLoans.Repayment := Loans.Repayment;
                NewLoans.Advice := true;
                NewLoans."Advice Type" := NewLoans."advice type"::"Fresh Loan";

                NewLoans."Loan Recovery No." := LoanRecoveryHeader."No.";
                NewLoans."Recovered Loan" := Loans."Loan No.";
                NewLoans."Source Unit" := ProductFactory."Source Unit";
                NewLoans.Insert(true);

                NewLoans.Reset;
                NewLoans.SetRange(NewLoans."Member No.", LoanRecoveryHeader."Member No.");
                NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
                NewLoans.SetRange(NewLoans.Posted, false);
                if NewLoans.Find('-') then begin
                    LoanRecoveryHeader.Rescheduled := true;
                    TransAmt := RunBal;
                    Description := 'Defaulted loan transfer from ' + Loans."Loan No.";
                    //CapitalizeDailyInterest(loans."Loan No.");
                    //Debit the new loan
                    if RunBal <> 0 then
                        SaccoTrans.JournalInsert(JTemplate, JBatch, LoanRecoveryHeader."No.", today, AccountType::Credit, NewLoans."Loan Account", CopyStr(Description, 1, 50), AccountType::"G/L Account",
                               '', TransAmt, LoanRecoveryHeader."No.", NewLoans."Loan No.", TransType::Loan, Dim1, Dim2, true);


                    if loans."Outstanding Balance" <> 0 then
                        SaccoTrans.JournalInsert(JTemplate, JBatch, LoanRecoveryHeader."No.", today, AccountType::Credit, Loans."Loan Account", CopyStr('Defaulted loan transfer to ' + NewLoans."Loan No.", 1, 50), AccountType::"G/L Account",
                               '', loans."Outstanding Balance" * -1, LoanRecoveryHeader."No.", loans."Loan No.", TransType::Repayment, Dim1, Dim2, true);

                    if (Loans."Outstanding Interest" + Loans."Daily Interest") <> 0 then
                        SaccoTrans.JournalInsert(JTemplate, JBatch, LoanRecoveryHeader."No.", today, AccountType::Credit, Loans."Loan Account", CopyStr('Defaulted loan Interest transfer to ' + NewLoans."Loan No.", 1, 50), AccountType::"G/L Account",
                               '', (Loans."Outstanding Interest" + Round(Loans."Daily Interest", 0.01, '=')) * -1, LoanRecoveryHeader."No.", loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, true);
                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                    NewLoans.Posted := true;
                    NewLoans.Modify;

                    //Generate Schedule
                    LoanProcess.GenerateSchedule(NewLoans, true);
                    Members.Get(NewLoans."Member No.");
                    msg := 'Dear member your ' + Loans."Loan Product Type Name" + ' loan of ' +
                    Format(ROUND(NewLoans."Approved Amount", 1, '=')) + ' ' + 'has been converted to a defaulted loan. If in dispute call ' + CompanyInfo."Phone No.";
                    SendSMS.SendSms(Source::LOAN_DEFAULTED, Members."Phone No.", CopyStr(msg, 1, 250), Format(NewLoans."Loan No."), '', true, 0, false, 'CBS', NewLoans."Loan No.", 'CBS');
                    //Guarantors
                    LoanGuarOld.Reset();
                    LoanGuarOld.SetRange("Loan No", LoanRecoveryHeader."Loan No.");
                    if LoanGuarOld.Find('-') then begin
                        repeat
                            LoanGuar.Init();
                            //       LoanGuar.TransferFields(LoanGuarOld);
                            LoanGuar."Loan No" := NewLoans."Loan No.";
                            LoanGuar."Account No." := LoanGuarOld."Account No.";
                            LoanGuar."Amount Guaranteed" := LoanGuarOld."Amount Guaranteed";
                            LoanGuar."Available Shares" := LoanGuarOld."Available Shares";
                            LoanGuar."Collateral Reg. No." := LoanGuarOld."Collateral Reg. No.";
                            LoanGuar."Collateral Value" := LoanGuarOld."Collateral Value";
                            LoanGuar.Comments := LoanGuarOld.Comments;
                            LoanGuar.Date := LoanGuarOld.Date;
                            LoanGuar."Date Substituted" := LoanGuarOld."Date Substituted";
                            LoanGuar.Deceased := LoanGuarOld.Deceased;
                            LoanGuar."Deposits/Shares" := LoanGuarOld."Deposits/Shares";
                            //LoanGuar."Guaranteed Balance" := LoanGuarOld."Guaranteed Balance";
                            LoanGuar."Guarantor Status" := LoanGuarOld."Guarantor Status";
                            LoanGuar."Guarantor Type" := LoanGuarOld."Guarantor Type";
                            LoanGuar."ID No." := LoanGuarOld."ID No.";
                            LoanGuar."Loan Balance" := LoanGuarOld."Loan Balance";
                            LoanGuar."Loan Type" := LoanGuarOld."Loan Type";
                            LoanGuar."Loanee Name" := LoanGuarOld."Loanee Name";
                            LoanGuar."Member Guaranteed" := LoanGuarOld."Member Guaranteed";
                            LoanGuar."Member No" := LoanGuarOld."Member No";
                            LoanGuar."Member Substituted" := LoanGuarOld."Member Substituted";
                            LoanGuar."Phone No." := LoanGuarOld."Phone No.";
                            LoanGuar."Staff/Payroll No." := LoanGuarOld."Staff/Payroll No.";
                            LoanGuar.Substituted := LoanGuarOld.Substituted;
                            LoanGuar."Self Guarantee" := LoanGuarOld."Self Guarantee";
                        until LoanGuarOld.next = 0;
                    end;
                    LoanRecoveryHeader.Rescheduled := true;
                    LoanRecoveryHeader."Rescheduled By" := UserId;
                    LoanRecoveryHeader."Rescheduling Date" := Today;
                    LoanRecoveryHeader.Modify();
                end;
            end else
                Error('Defaulter loan product does not exist');
        end;

    END;

    procedure CapitalizeDailyInterest(LoanNo: code[20]);
    var
        MyLoans: Record Loans;
        PFacts: Record "Product Factory";
    begin
        if MyLoans.get(LoanNo) then begin
            myloans.CalcFields("Daily Interest");
            if myloans."Daily Interest" > 0 then begin
                if PFacts.get(myloans."Loan Product Type") then begin
                    //Interest Due
                    Temp.Get(UserId);

                    Jtemplate := Temp."Bills Template";
                    JBatch := Temp."Bills Batch";

                    if Jtemplate = '' then begin
                        Error('Ensure the Bills Template is set up in Banking User Setup');
                    end;
                    if JBatch = '' then begin
                        Error('Ensure the Bills Batch is set up in Banking User Setup')
                    end;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := myloans."Loan Account";
                    TransType := Transtype::"Interest due";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := PFacts."Loan Interest Account [G/L]";
                    Amt := (myloans."Daily Interest");
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, myloans."Loan No.", 'Daily Interest Capitalized_' + myloans."Loan No.", Amt, AccNo, today, BalAccType,
                    BalAccNo, myloans."Loan No.", myloans."Global Dimension 1 Code", myloans."Global Dimension 2 Code", TransType, myloans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    //Clears all the daily interest buffer

                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                    ClearDailyInterest(myloans."Loan No.");

                end;
            end;
        end;
    end;

    procedure CapitalizeDailyInterestAuto(LoanNo: code[20]; Jtemplate: code[20]; JBatch: code[20]; DocNo: code[20]);
    var
        MyLoans: Record Loans;
        PFacts: Record "Product Factory";
    begin
        if MyLoans.get(LoanNo) then begin
            myloans.CalcFields("Daily Interest");
            if myloans."Daily Interest" > 0 then begin
                if PFacts.get(myloans."Loan Product Type") then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := myloans."Loan Account";
                    TransType := Transtype::"Interest due";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := PFacts."Loan Interest Account [G/L]";
                    Amt := (myloans."Daily Interest");
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, DocNo, 'Daily Interest Capitalized_' + myloans."Loan No.", Amt, AccNo, today, BalAccType,
                    BalAccNo, myloans."Loan No.", myloans."Global Dimension 1 Code", myloans."Global Dimension 2 Code", TransType, myloans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    //Clears all the daily interest buffer

                    JournalPosting.CompletePosting(Jtemplate, JBatch);
                    ClearDailyInterest(myloans."Loan No.");

                end;
            end;
        end;
    end;

    procedure ClearDailyInterest(LoanNo: Code[20])
    var
        DailyInterest: record "Loans Interest Buffer";
    begin
        DailyInterest.reset;
        DailyInterest.setrange("Loan No.", LoanNo);
        DailyInterest.SetRange(Posted, false);
        DailyInterest.ModifyAll(posted, true);
    end;

    procedure HoldOneMonthInstallment(LoanNo: Code[20])
    var
        myInt: Integer;
        HLoans: Record loans;
        OneMonthInstallment: Record "One Month Installment";
    begin
        if HLoans.Get(LoanNo) then begin
            OneMonthInstallment.Reset;
            OneMonthInstallment.SetRange("Record No.", LoanNo);
            OneMonthInstallment.deleteall;
            OneMonthInstallment.SetRange("Record No.", HLoans."Loan No.");
            if HLoans."Hold Installment(s)" then begin
                OneMonthInstallment.Init();
                OneMonthInstallment."Record No." := HLoans."Loan No.";
                OneMonthInstallment."Account No." := HLoans."Disbursement Account No";
                OneMonthInstallment."Member No." := HLoans."Member No.";
                OneMonthInstallment."Principal Amount" := HLoans."Loan Principle Repayment" * HLoans."Number Of Installment(s)";
                OneMonthInstallment."Interest Amount" := HLoans."Loan Interest Repayment" * HLoans."Number Of Installment(s)";
                OneMonthInstallment.Total := OneMonthInstallment."Principal Amount" + OneMonthInstallment."Interest Amount";
                if OneMonthInstallment.Total <= 0 then
                    OneMonthInstallment.Total := HLoans.Repayment;
                OneMonthInstallment."Created By" := UserId;
                OneMonthInstallment."Funds Status" := OneMonthInstallment."Funds Status"::WithHeld;
                OneMonthInstallment."Entry Date" := CurrentDateTime;
                OneMonthInstallment."Held Funds Comments" := HLoans."Held Funds Comments";
                OneMonthInstallment."Global Dimension 1 Code" := HLoans."Global Dimension 2 Code";
                OneMonthInstallment."Global Dimension 2 Code" := HLoans."Global Dimension 2 Code";
                if OneMonthInstallment.Total <> 0 then
                    OneMonthInstallment.Insert();
            end;
        end;


    end;

    procedure PostLoanNormal(LoanNo: Code[20])

    var
        LoanApp: Record Loans;
        SavAcc: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        Text001: label 'Mobile Banking Message';
        CashierTransactions: Record "Cashier Transactions";
        OldAmount: Decimal;
        TopUPGL: Code[20];
        "Topup%": Decimal;
        UserSetup: Record "User Setup";
        Dim1: Code[50];
        Dim2: Code[50];
        ShambaLoanProcFee: Decimal;
        ShambaLoanExcise: Decimal;
        CheoffAdd: Record "Checkoff Advice Line";
        OtherLoans: Record loans;
        DedAmount: Decimal;
        PDate: Date;
        LoansREc: Record Loans;
        ShreAmt: Decimal;
        proFac: Record "Product Factory";
        DepCont: Decimal;
        SkyMbank: Codeunit "Sky M-Banking Transactions";
        TotalInterest: Decimal;
        upfrontrate: Decimal;
        OtherLiabilities: Record "Other Commitements Clearance";
        OtherLiabilitiesII: record "Other Commitements Clearance";
        LoanGuar: record "Loan Guarantors and Security";
        GuarCount: Integer;
        GlobalFunctions: Codeunit "Global Functions";
    begin

        Temp.Get(UserId);

        Jtemplate := Temp."Loans Template";
        JBatch := Temp."Loans Batch";
        PDate := Today;


        if Jtemplate = '' then begin
            Error('Ensure the Loans Template is set up in Banking User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the Loans Batch is set up in Banking User Setup')
        end;

        //PRORATED DAYS
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        //Mark Posted Loans Already Posted.
        GLEntry.Reset;
        GLEntry.SetRange("Document No.", LoanNo);
        if GLEntry.FindFirst then begin
            LoanApps.Reset;
            LoanApps.SetRange("Loan No.", LoanNo);
            if LoanApps.Find('-') then begin
                repeat
                    LoanApps.Advice := true;
                    LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                    LoanApps."Disbursement Date" := Today;
                    LoanApps.Posted := true;
                    // DepositProrata(LoanApps."Loan No.");
                    HoldOneMonthInstallment(LoanApps."Loan No.");
                    LoanApps.Modify(true);
                // AdviceLoan(LoanApps."Loan No.", false, LoanApps."Loan No.");
                until LoanApps.Next = 0;
            end;
        end;
        //Mark Posted Loans Already Posted.

        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Loan No.", LoanNo);
        LoanApps.SetRange(LoanApps.Posted, false);
        if LoanApps.Find('-') then begin
            UserSetup.Reset;
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst then begin
                UserSetup.TestField("Global Dimension 1 Code");
                UserSetup.TestField("Global Dimension 2 Code");
                Dim1 := UserSetup."Global Dimension 1 Code";
                Dim2 := UserSetup."Global Dimension 2 Code";
            end;

            // LoanApps."Global Dimension 1 Code" := Dim1;
            // LoanApps."Global Dimension 2 Code" := Dim2;

            FirstLoop := FirstLoop + 1;
            ChargeExtraComms := false;
            ExcemptCharges := false;
            ProdFac.Get(LoanApps."Loan Product Type");

            if CustomerRecord.Get(LoanApps."Member No.") then begin
                //Check if excempted from charges
                if Cust.Get(CustomerRecord."No.") then begin
                    if Cust."Dont Charge Transactions" = true then
                        ExcemptCharges := true;
                end;

                if LoanApps.Status <> LoanApps.Status::Approved then
                    Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan No.");

                if LoanApps."Amount To Disburse" <= 0 then
                    Error(Text0002);

                DaysPast := 0;
                EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
                RemainingDays := (EndMonth - Today) + 1;
                TMonthDays := Date2dmy(EndMonth, 1);

                //where disbursement day is in the past
                DaysPast := Today - LoanApps."Disbursement Date";

                if DaysPast > 1 then
                    RemainingDays := RemainingDays + DaysPast;
                ///RunningDate:=Batches."Posting Date";

                //Generate and post Approved Loan Amount
                if not GenBatch.Get(Jtemplate, JBatch) then begin
                    GenBatch.Init;
                    GenBatch."Journal Template Name" := Jtemplate;
                    GenBatch.Name := JBatch;
                    GenBatch.Insert;
                end;

                TopUp.Reset;
                TopUp.SetRange(TopUp."Loan No.", LoanApps."Loan No.");
                if TopUp.Find('-') then begin
                    repeat
                        if TopUp."Additional Top Up Commission" = true then
                            ChargeExtraComms := true;
                    until TopUp.Next = 0;
                end;

                GenSetup.Get;
                AccType := Acctype::Credit;
                AccNo := LoanApps."Loan Account";
                TransType := Transtype::Loan;
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                Amt := 0;
                LineNo := LineNo + 10000;
                Descr := '';
                Descr := ProdFac."Product Description"/*+' '+'Loan'*/;
                Descr := CopyStr(Descr, 1, 50);
                //Approved amount
                if LoanApps."Amount To Disburse" > 0 then
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, LoanApps."Amount To Disburse", AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                // IF LoanApps."Mode of Disbursement"=LoanApps."Mode of Disbursement"::"Full Disbursement" THEN BEGIN
                PaySched.Reset;
                PaySched.SetRange(PaySched."Loan No.", LoanApps."Loan No.");
                if PaySched.Find('-') then begin
                    repeat
                        if (PaySched."Payment Options" = PaySched."payment options"::"M-PESA") or (PaySched."Payment Options" = PaySched."payment options"::Cheques) then begin

                            AccNo := '';
                            Amt := 0;
                            AccType := Acctype::"Bank Account";
                            if LoanApps."All Posting through Savings Ac" = true then begin
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                            end else begin
                                BalAccType := Balacctype::"G/L Account";
                                BalAccNo := '';
                            end;
                            if PaySched."Payment Options" = PaySched."payment options"::"M-PESA" then
                                AccNo := Temp."MPESA Disbursement A/c"
                            else
                                AccNo := Temp."Cheque Disbursement A/c";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::Savings;
                            LineNo := LineNo + 10000;
                            Descr := '';
                            Descr := ProdFac."Product Description" + ' ' + 'Loan';
                            Descr := CopyStr(Descr, 1, 50);
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -PaySched.Amount, AccNo,
                            PDate, BalAccType, BalAccNo, '', '', '', TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;
                    until PaySched.Next = 0;
                end;

                AccNo := LoanApps."Disbursement Account No";
                AccType := Acctype::Savings;
                BalAccType := Balacctype::"G/L Account";
                BalAccNo := '';
                TransType := Transtype::" ";
                LineNo := LineNo + 10000;
                Descr := '';
                Descr := ProdFac."Product Description" + ' ' + 'Loan';
                Descr := CopyStr(Descr, 1, 50);
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -LoanApps."Amount To Disburse", AccNo,
                PDate, BalAccType, BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                ShambaLoanProcFee := 0;
                ShambaLoanExcise := 0;

                // Form Fees
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Form Fees");
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            //Non Prorate
                            if PCharges.Prorate = PCharges.Prorate::" " then begin
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := PCharges."Charges G_L Account";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                        Amt := PCharges."Charge Amount"
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                            PCharges.TestField(PCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            Amt := TariffDetails."Charge Amount";
                                                        end;
                                                    end
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                    Amt := PCharges.Minimum;
                                if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                    Amt := PCharges.Maximum;

                                Amt := Amt * -1;

                                if ExcemptCharges = true then
                                    Amt := 0;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                ShambaLoanProcFee += Amt;

                                //If excise duty involved
                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.TestField("Excise Duty G/L");
                                    GenSetup.TestField("Excise Duty (%)");
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := GenSetup."Excise Duty G/L";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    ShambaLoanExcise += Amt;
                                end;
                            end else
                                if PCharges.Prorate = PCharges.Prorate::Appraisal then begin
                                    //Prorate
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Credit;
                                    AccNo := LoanApps."Loan Account";
                                    TransType := Transtype::Appraisal;
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                        Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                            Amt := PCharges."Charge Amount"
                                        else
                                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                                PCharges.TestField(PCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                Amt := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    LoanApps."Appraisal Fee" := Amt;
                                    Amt := Amt * -1;
                                    LoanApps."Disbursement Date" := Today;
                                    LoanApps."Posted By" := UserId;
                                    LoanApps.Validate("Disbursement Date");
                                    LoanApps.Modify;
                                    Commit;
                                    HoldOneMonthInstallment(LoanApps."Loan No.");
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    ShambaLoanProcFee += Amt;

                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Savings;
                                    AccNo := LoanApps."Disbursement Account No";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';

                                    Amt := Amt * -1;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                        end
                    until PCharges.Next = 0;
                end;

                // Insurance Fees
                // Form Fees
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Insurance Fees");
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            //Non Prorate
                            if PCharges.Prorate = PCharges.Prorate::" " then begin
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := PCharges."Charges G_L Account";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                        Amt := PCharges."Charge Amount"
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                            PCharges.TestField(PCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            Amt := TariffDetails."Charge Amount";
                                                        end;
                                                    end
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                    Amt := PCharges.Minimum;
                                if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                    Amt := PCharges.Maximum;

                                Amt := Amt * -1;

                                if ExcemptCharges = true then
                                    Amt := 0;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                ShambaLoanProcFee += Amt;

                                //If excise duty involved
                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.TestField("Excise Duty G/L");
                                    GenSetup.TestField("Excise Duty (%)");
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := GenSetup."Excise Duty G/L";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    ShambaLoanExcise += Amt;
                                end;
                            end else
                                if PCharges.Prorate = PCharges.Prorate::Appraisal then begin
                                    //Prorate
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Credit;
                                    AccNo := LoanApps."Loan Account";
                                    TransType := Transtype::Appraisal;
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                        Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                            Amt := PCharges."Charge Amount"
                                        else
                                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                                PCharges.TestField(PCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                Amt := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    LoanApps."Appraisal Fee" := Amt;
                                    Amt := Amt * -1;
                                    LoanApps."Disbursement Date" := Today;
                                    LoanApps."Posted By" := UserId;
                                    LoanApps.Validate("Disbursement Date");
                                    LoanApps.Modify;
                                    Commit;
                                    HoldOneMonthInstallment(LoanApps."Loan No.");
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    ShambaLoanProcFee += Amt;

                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Savings;
                                    AccNo := LoanApps."Disbursement Account No";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';

                                    Amt := Amt * -1;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                        end
                    until PCharges.Next = 0;
                end;


                //Other Charges
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            //Non Prorate
                            if PCharges.Prorate = PCharges.Prorate::" " then begin
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := PCharges."Charges G_L Account";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                        Amt := PCharges."Charge Amount"
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                            PCharges.TestField(PCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            Amt := TariffDetails."Charge Amount";
                                                        end;
                                                    end
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                    Amt := PCharges.Minimum;
                                if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                    Amt := PCharges.Maximum;

                                Amt := Amt * -1;

                                if ExcemptCharges = true then
                                    Amt := 0;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                ShambaLoanProcFee += Amt;

                                //If excise duty involved
                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.TestField("Excise Duty G/L");
                                    GenSetup.TestField("Excise Duty (%)");
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := GenSetup."Excise Duty G/L";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    ShambaLoanExcise += Amt;
                                end;
                            end else
                                if PCharges.Prorate = PCharges.Prorate::Appraisal then begin
                                    //Prorate
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Credit;
                                    AccNo := LoanApps."Loan Account";
                                    TransType := Transtype::Appraisal;
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                        Amt := (LoanApps."Approved Amount" * (PCharges.Percentage / 100))
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                            Amt := PCharges."Charge Amount"
                                        else
                                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                                PCharges.TestField(PCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (LoanApps."Approved Amount" >= TariffDetails."Lower Limit") and (LoanApps."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                Amt := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                Amt := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    LoanApps."Appraisal Fee" := Amt;
                                    Amt := Amt * -1;
                                    LoanApps."Disbursement Date" := Today;
                                    LoanApps."Posted By" := UserId;
                                    LoanApps.Validate("Disbursement Date");
                                    LoanApps.Modify;
                                    Commit;
                                    HoldOneMonthInstallment(LoanApps."Loan No.");
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    ShambaLoanProcFee += Amt;

                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::Savings;
                                    AccNo := LoanApps."Disbursement Account No";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';

                                    Amt := Amt * -1;

                                    if ExcemptCharges = true then
                                        Amt := 0;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                        end
                    until PCharges.Next = 0;
                end;



                if (ProdFac."Mortgage Loan" = true) and (LoanApps."Loan Product Type" <> '138') then begin
                    //denis this is to cater for mortgage loans
                    "CheckDisbursementA/CBalanceForMortgage"(LoanApps."Disbursement Account No");

                    AccNo := LoanApps."Disbursement Account No";
                    AccType := Acctype::Savings;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    LineNo := LineNo + 10000;
                    Descr := '';
                    Descr := ProdFac."Product Description" + ' ' + ' to Vendor ' + GenSetup."Mortgage Loan Vendor A/C";//;    GenSetup."Early Withdrawal %";
                    Descr := CopyStr(Descr, 1, 50);
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, LoanApps."Amount To Disburse", AccNo,
                    PDate, BalAccType, BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //amount to Vendor A/c
                    AccNo := GenSetup."Mortgage Loan Vendor A/C";//GenSetup."Early Withdrawal %";
                    AccType := Acctype::Vendor;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    LineNo := LineNo + 10000;
                    Descr := '';
                    Descr := ProdFac."Product Description" + ' ' + ' From ' + LoanApps."Disbursement Account No";
                    Descr := CopyStr(Descr, 1, 50);
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -LoanApps."Amount To Disburse", AccNo,
                    PDate, BalAccType, BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    RegisterMortgageDocuments(LoanApps."Loan No.");

                end;


                // Cater For Shamba Loan
                if (ProdFac."Shamba Loan" = true) then begin

                    //"CheckDisbursementA/CBalanceForMortgage"(LoanApps."Disbursement Account No");

                    AccNo := LoanApps."Disbursement Account No";
                    AccType := Acctype::Savings;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    LineNo := LineNo + 10000;
                    Descr := '';
                    Descr := ProdFac."Product Description" + ' ' + ' to Vendor ' + GenSetup."Shamba Loan Vendor A/C"; //GenSetup."Early Withdrawal %";
                    Descr := CopyStr(Descr, 1, 50);
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, LoanApps."Amount To Disburse" - (Abs(ShambaLoanProcFee) + Abs(ShambaLoanExcise)), AccNo,
                    PDate, BalAccType, BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //amount to Vendor A/c
                    AccNo := GenSetup."Shamba Loan Vendor A/C";//GenSetup."Early Withdrawal %";
                    AccType := Acctype::Vendor;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    LineNo := LineNo + 10000;
                    Descr := '';
                    Descr := ProdFac."Product Description" + ' ' + ' From ' + LoanApps."Disbursement Account No";
                    Descr := CopyStr(Descr, 1, 50);
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, -(LoanApps."Amount To Disburse" - (Abs(ShambaLoanProcFee) + Abs(ShambaLoanExcise))), AccNo,
                    PDate, BalAccType, BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    RegisterMortgageDocuments(LoanApps."Loan No.");

                end;
                //Deposit/share purchase
                if LoanApps."Loans - Deposit Purchase" > 0 then begin

                    //debit savings
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := LoanApps."Disbursement Account No";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := LoanApps."Loans - Deposit Purchase";


                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Deposit Purchase Boost', Amt, AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    //Credit deposits
                    AccNo := '';
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", LoanApps."Member No.");
                    if ProdFac."Loan Appraisal Account Code" = '' then
                        SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits") else
                        SavAcc.SetRange("Product Type", ProdFac."Loan Appraisal Account Code");
                    if SavAcc.Find('-') then
                        AccNo := SavAcc."No."
                    else
                        Error(Text0003, LoanApps."Member No.");


                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := LoanApps."Loans - Deposit Purchase";



                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Deposit Boost', -Amt, AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                    ///Advice ShareBoost


                    //Pass charges if defined

                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Boosting");
                    if PCharges.Find('-') then begin
                        repeat
                            ExcemptProductCharges.Reset();
                            ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                            ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                            ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                            ExcemptProductCharges.setrange(Excempt, true);
                            if not ExcemptProductCharges.Find('-') then begin
                                //Non Prorate
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := PCharges."Charges G_L Account";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := (LoanApps."Loans - Deposit Purchase" * (PCharges.Percentage / 100))
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                        Amt := PCharges."Charge Amount"
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                            PCharges.TestField(PCharges."Staggered Charge Code");

                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (LoanApps."Loans - Deposit Purchase" >= TariffDetails."Lower Limit") and (LoanApps."Loans - Deposit Purchase" <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            Amt := LoanApps."Loans - Deposit Purchase" * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            Amt := TariffDetails."Charge Amount";
                                                        end;
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;


                                if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                    Amt := PCharges.Minimum;
                                if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                    Amt := PCharges.Maximum;

                                Amt := Amt * -1;

                                if ExcemptCharges = true then
                                    Amt := 0;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                              BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                //If excise duty involved
                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.TestField("Excise Duty G/L");
                                    GenSetup.TestField("Excise Duty (%)");
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := GenSetup."Excise Duty G/L";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                end;
                            end;
                        until PCharges.Next = 0;

                    end;

                end;
            end;
            //if upfront
            // if interest is upfront then post interest:
            IF ProdFac.Get(LoanApps."Loan Product Type") then begin
                if ProdFac."Interest Recovered Upfront" then begin
                    upfrontrate := ProdFac."Upfront Interest Rate";
                    if upfrontrate <> 0 then begin
                        TotalInterest += Round(((upfrontrate / 100) * LoanApps."Approved Amount"), 0.01, '>');
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := LoanApps."Disbursement Account No";
                        TransType := Transtype::Repayment;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';


                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Upfront Interest ' + LoanApps."Loan No.", TotalInterest, AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApp."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        AccType := Acctype::"G/L Account";
                        AccNo := ProdFac."Loan Interest Account [G/L]";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Upfront Interest'), 1, 50), TotalInterest * -1, AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;

                end;
            end;

            //version 2

            //upfront
            //Recovershares
            // if LoanApps."Source Unit" = LoanApps."Source Unit"::BOSA then begin
            if LoanApps."Share Boosted Amount" > 0 then begin
                proFac.Reset();
                proFac.SetRange(proFac."Product Category", proFac."Product Category"::"Share Capital");
                if proFac.FindFirst() then begin
                    SavAcc.Reset();
                    SavAcc.SetRange("Member No.", LoanApps."Member No.");
                    SavAcc.setrange("Product Category", SavAcc."Product Category"::"Share Capital");
                    if SavAcc.FindFirst() then begin
                        SavAcc.CalcFields(SavAcc.Balance);
                        // if SavAcc.Balance < proFac."Minimum Contribution" then begin//anyone can share boost
                        // ShreAmt := proFac."Minimum Contribution" - SavAcc.Balance;
                        ShreAmt := LoanApps."Share Boosted Amount";
                        // if ShreAmt > 0 then begin

                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := LoanApps."Disbursement Account No";
                        TransType := Transtype::Repayment;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        // Amt := ShreAmt;

                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Shares Boosted' + LoanApps."Loan No.", LoanApps."Share Boosted Amount", AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApp."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := SavAcc."No.";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Shares Boosted '), 1, 50), LoanApps."Share Boosted Amount" * -1, AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        // end;
                    end;
                    // end;
                end;
            end;
            TotalCleared := 0;
            BridgLoan := 0;
            TopUp.Reset;
            TopUp.SetRange(TopUp."Loan No.", LoanApps."Loan No.");
            if TopUp.Find('-') then begin
                repeat
                    //TopUp.Validate(TopUp."Loan Top Up");
                    TotalCleared := 0;
                    //Loan repayment
                    TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := TopUp."Loan Account";
                    TransType := Transtype::Repayment;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := TopUp."Principle Top Up" * -1;

                    // AdviceLoan(TopUp."Loan Top Up", true, LoanApps."Loan No.");

                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Refinance Principle ' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    //Clear bills
                    if LoanApp.Get(TopUp."Loan Top Up") then begin
                        if ProdFac.Get(LoanApp."Loan Product Type") then begin
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Credit;
                            AccNo := TopUp."Loan Account";
                            TransType := Transtype::Bills;
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := ProdFac."Billed Account";
                            Amt := TopUp."Outstanding Bill" * -1;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Outs. Bill' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                          BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;
                    end;

                    //Interest

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := TopUp."Loan Account";
                    TransType := Transtype::"Interest Paid";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := (TopUp."Interest Top Up" + TopUp."Untransfered Interest") * -1;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Top up Interest ' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Savings;
                    AccNo := LoanApps."Disbursement Account No";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Total Loan Offset to ' + TopUp."Loan Top Up"), 1, 50), TotalCleared, AccNo, PDate, BalAccType,
                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    if (TopUp."Principle Top Up" + TopUp."Interest Top Up" + TopUp."Untransfered Interest") <> 0 then begin
                        //Top Up charges
                        BaseAmount := 0;
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                        if PCharges.Find('-') then begin
                            repeat
                                ExcemptProductCharges.Reset();
                                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                                ExcemptProductCharges.setrange(Excempt, true);
                                if not ExcemptProductCharges.Find('-') then begin
                                    if PCharges."Charging Option" = PCharges."Charging Option"::"On Approved Amount" then
                                        BaseAmount := LoanApp."Approved Amount" else
                                        BaseAmount := TopUp."Principle Top Up";
                                    //Non Prorate
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := PCharges."Charges G_L Account";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                        Amt := (BaseAmount * (PCharges.Percentage / 100))
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                            Amt := PCharges."Charge Amount"
                                        else
                                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                                PCharges.TestField(PCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (BaseAmount >= TariffDetails."Lower Limit") and (BaseAmount <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                Amt := BaseAmount * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                Amt := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                    if (Amt < PCharges.Minimum) and (PCharges.Minimum > 0) then
                                        Amt := PCharges.Minimum;
                                    if (Amt > PCharges.Maximum) and (PCharges.Maximum > 0) then
                                        Amt := PCharges.Maximum;

                                    Amt := Amt * -1;

                                    if ExcemptCharges = true then
                                        Amt := 0;


                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description" + ':' + TopUp."Loan Top Up", Amt, AccNo, PDate, BalAccType,
                                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    //If excise duty involved
                                    if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                        GenSetup.TestField("Excise Duty G/L");
                                        GenSetup.TestField("Excise Duty (%)");
                                        LineNo := LineNo + 10000;
                                        AccType := Acctype::"G/L Account";
                                        AccNo := GenSetup."Excise Duty G/L";
                                        TransType := Transtype::" ";
                                        BalAccType := Balacctype::Savings;
                                        BalAccNo := LoanApps."Disbursement Account No";
                                        Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + ':' + TopUp."Loan Top Up" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    end;

                                end;

                            until PCharges.Next = 0;

                        end;
                    end;



                // if TopUp."Daily Interest" > 0 then begin
                //     if ProdFacTopup.Get(TopUp."Loan Type") then begin
                //         if ProdFacTopup."Loan Interest Account [G/L]" <> '' then begin
                //             //Interest Due
                //             LineNo := LineNo + 10000;
                //             AccType := Acctype::Credit;
                //             AccNo := TopUp."Loan Account";
                //             TransType := Transtype::"Interest due";
                //             BalAccType := Balacctype::"G/L Account";
                //             BalAccNo := ProdFacTopup."Loan Interest Account [G/L]";
                //             Amt := (TopUp."Daily Interest");
                //             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Daily Interest Capitalized_' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                //             BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                //             //Clears all the daily interest buffer
                //             ClearDailyInterest(TopUp."Loan Top Up");
                //         end;
                //     end;
                // end;
                until TopUp.Next = 0;
            end;

            if not ProdFac."Exclude One Month Interest" then begin
                TopUp.Reset;
                TopUp.SetRange(TopUp."Loan No.", LoanApps."Loan No.");
                Topup.setfilter(TopUp."Principle Top Up", '>0');
                if TopUp.findset() then begin
                    repeat
                        if ProdFac.get(TopUp."Loan Type") then begin
                            //if (TopUp."Principle Top Up" + TopUp."Interest Top Up" + TopUp."Untransfered Interest") > 0 then begin
                            if ProdFac."Charge 1 month Interest" then begin
                                ProdFac.TestField("One Month Interest G/L");
                                //One month interest
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := ProdFac."One Month Interest G/L";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := LoanApps."Disbursement Account No";
                                Amt := -(TopUp."One Month Interest");

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'One month interest on ' + ': ' + TopUp."Loan Top Up", Amt, AccNo, PDate, BalAccType,
                                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                            //end;
                        end;
                    until TopUp.Next() = 0;
                end;
            end;



            //Balancing entry if disbursed via Savings
            //IF LoanApps."All Posting through Savings Ac"=TRUE THEN BEGIN
            // if TotalCleared > 0 then begin
            //     LineNo := LineNo + 10000;
            //     AccType := Acctype::Savings;
            //     AccNo := LoanApps."Disbursement Account No";
            //     TransType := Transtype::" ";
            //     BalAccType := Balacctype::"G/L Account";
            //     BalAccNo := '';
            //     JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Total Loan Offset- Loan Clearance Facility'), 1, 50), TotalCleared, AccNo, PDate, BalAccType,
            //     BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            // end;
            //GL
            //Added 06.05.2021
            if BridgLoan > 0 then begin
                //if BridgLoan > 50000 then BridgLoan := 50000;
                LineNo := LineNo + 10000;
                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::"G/L Account", LoanNo, PCharges."Charge Description", -BridgLoan, TopUPGL, PDate, BalAccType,
                BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                BLoanNo := CreateBridgingLoan(LoanApps."Member No.", TotalCleared);
                if BLoanNo <> '' then begin
                    if BLoanRec.Get(BLoanNo) then begin

                        AccType := Acctype::Credit;
                        AccNo := BLoanRec."Loan Account";
                        TransType := Transtype::Loan;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';

                        LineNo := LineNo + 10001;
                        Descr := BLoanRec."Loan Product Type Name";

                        //Approved amount
                        if BLoanRec."Approved Amount" > 0 then begin

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, TotalCleared, AccNo, PDate, BalAccType,
                            BalAccNo, BLoanRec."Loan No.", Dim1, Dim2, TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                            //TotalTopUpCharges += BLoanRec."Approved Amount";

                            BLoanRec.Posted := true;
                            BLoanRec.Modify(true);
                            HoldOneMonthInstallment(BLoanRec."Loan No.");
                            //Bridging Loan Recovery

                            Members.Get(BLoanRec."Member No.");
                            /*IF MemberCat.GET(Members."Member Class") THEN
                            BEGIN*/
                            //MESSAGE(MemberCat."No.");
                            //ERROR(FORMAT(BLoanRec."Approved Amount"));
                            //IF MemberCat."Recover Fully on Bridging"=TRUE THEN BEGIN
                            LineNo := LineNo + 10001;
                            Descr := BLoanRec."Loan Product Type Name" + '- Repayment';
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Credit, LoanNo, Descr, TotalCleared * -1, BLoanRec."Loan Account", PDate, BalAccType,
                            BalAccNo, BLoanRec."Loan No.", Dim1, Dim2, TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            //Debit Fosa

                            LineNo := LineNo + 10001;
                            Descr := BLoanRec."Loan Product Type Name" + '-Interest Paid';
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, Acctype::Savings, LoanNo, Descr, BridgLoan * 1, LoanApps."Disbursement Account No", PDate, BalAccType,
                            '', '', Dim1, Dim2, Transtype::" ", BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            //Interest Due
                            LineNo := LineNo + 10000;
                            Descr := BLoanRec."Loan Product Type Name" + '- Interest Due';
                            TransType := Transtype::"Interest Due";
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, BridgLoan, AccNo, PDate, BalAccType,
                            BalAccNo, BLoanRec."Loan No.", Dim1, Dim2, TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                            //Interest Paid
                            LineNo := LineNo + 10000;
                            Descr := BLoanRec."Loan Product Type Name" + '- Interest Paid';
                            TransType := Transtype::"Interest Paid";
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, Descr, BridgLoan * -1, AccNo, PDate, BalAccType,
                            BalAccNo, BLoanRec."Loan No.", Dim1, Dim2, TransType, BLoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        end;
                    end;
                end;
            end;

            OtherComms := 0;
            OtherLiabilities.Reset;
            OtherLiabilities.SetFilter(Amount, '>%1', 0);
            OtherLiabilities.SetRange(OtherLiabilities."Loan No.", LoanNo);
            OtherLiabilities.SetRange(Posted, false);
            if OtherLiabilities.Findset then begin
                repeat
                    ///TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";
                    AccType := OtherLiabilities."Account Type";// Acctype::"Bank Account";
                    AccNo := OtherLiabilities."Vendor No.";//Temp."Bankers Cheque Account";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    DedAmount := OtherLiabilities.Amount;

                    if OtherLiabilities."Account Type" = OtherLiabilities."Account Type"::Credit then begin
                        if OtherLoans.Get(OtherLiabilities."Destination Loan No.") then begin
                            OtherLoans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest", "Total Balance");

                            if OtherLoans."Total Balance" > 0 then begin
                                if OtherLoans."Outstanding Interest" > 0 then begin
                                    if OtherLiabilities.Amount >= OtherLoans."Outstanding Interest" then begin
                                        //Interest Repayment
                                        LineNo := LineNo + 10000;
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::credit, LoanNo, 'Interest payment to ' + OtherLoans."Member No." + ' Loan ' + OtherLoans."Loan No.", OtherLoans."Outstanding Interest" * -1, AccNo, PDate, BalAccType,
                                        BalAccNo, OtherLiabilities."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::"Interest Paid", OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        DedAmount -= OtherLoans."Outstanding Interest";
                                    end
                                    else begin
                                        OtherLoans."Outstanding Interest" := DedAmount;
                                        LineNo := LineNo + 10000;
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Credit, LoanNo, 'Interest payment to ' + OtherLoans."Member No." + ' Loan ' + OtherLoans."Loan No.", DedAmount * -1, AccNo, PDate, BalAccType,
                                        BalAccNo, OtherLiabilities."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::"Interest Paid", OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        DedAmount := 0;
                                    end;
                                    //Debit FOSA
                                    LineNo := LineNo + 10000;
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Savings, LoanNo, 'Interest payment from ' + LoanApps."Member No." + ' Loan ' + LoanApps."Loan No.", OtherLoans."Outstanding Interest", LoanApps."Disbursement Account No", PDate, BalAccType,
                                    BalAccNo, OtherLiabilities."Destination Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::" ", OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                end;
                                if DedAmount > 0 then
                                    if OtherLoans."Outstanding Balance" > 0 then begin
                                        if DedAmount >= OtherLoans."Outstanding Balance" then begin
                                            //Principle Repayment
                                            LineNo := LineNo + 10000;
                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::credit, LoanNo, 'Principle payment to ' + OtherLoans."Member No." + ' Loan ' + OtherLoans."Loan No.", OtherLoans."Outstanding Balance" * -1, AccNo, PDate, BalAccType,
                                            BalAccNo, OtherLiabilities."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::Repayment, OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            DedAmount -= OtherLoans."Outstanding Interest";
                                        end
                                        else begin
                                            OtherLoans."Outstanding Balance" := DedAmount;
                                            LineNo := LineNo + 10000;
                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Credit, LoanNo, 'Principle payment to ' + OtherLoans."Member No." + ' Loan ' + OtherLoans."Loan No.", DedAmount * -1, LoanApps."Disbursement Account No", PDate, BalAccType,
                                            BalAccNo, OtherLiabilities."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::Repayment, OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            DedAmount := 0;
                                        end;
                                        //Debit FOSA
                                        LineNo := LineNo + 10000;
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Savings, LoanNo, 'Principle payment from ' + LoanApps."Member No." + ' Loan ' + LoanApps."Loan No.", OtherLoans."Outstanding Balance", LoanApps."Disbursement Account No", PDate, BalAccType,
                                        BalAccNo, OtherLiabilities."Destination Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType::" ", OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    end;
                            end;
                        end;
                    end else begin
                        //Debit FOSA
                        LineNo := LineNo + 10000;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Savings, LoanNo, 'Payment to ' + AccNo + ' from Loan ' + LoanApps."Loan No.", OtherLiabilities.Amount * 1, LoanApps."Disbursement Account No", PDate, BalAccType,
                         BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Payment from ' + LoanApps."Member No." + ' Loan ' + LoanApps."Loan No.", OtherLiabilities.Amount * -1, AccNo, PDate, BalAccType,
                         BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, OtherLiabilities."Destination Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                    OtherLiabilities.Posted := true;
                    OtherLiabilities.Modify(true);
                until OtherLiabilities.Next = 0;
            end;


            //Asset Finance Deduction
            TotalAssetFin := 0;
            NetToVendor := 0;
            AssetFinanceLoan.Reset;
            AssetFinanceLoan.SetRange(AssetFinanceLoan."Loan No.", LoanApps."Loan No.");
            if AssetFinanceLoan.Find('-') then begin
                repeat
                    Temp.TestField(Temp."Bankers Cheque Account");
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Asset Finance");
                    if PCharges.Find('-') then begin
                        repeat
                            ExcemptProductCharges.Reset();
                            ExcemptProductCharges.SetRange("Loan No.", LoanApps."Loan No.");
                            ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                            ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                            ExcemptProductCharges.setrange(Excempt, true);
                            if not ExcemptProductCharges.Find('-') then begin
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := AssetFinanceLoan.Amount - (AssetFinanceLoan.Amount / (1 + PCharges.Percentage / 100));

                            end;
                        until PCharges.Next = 0;
                    end;


                    TotalAssetFin := TotalAssetFin + TopUp."Principle Top Up" + TopUp."Interest Top Up";
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Vendor;
                    AccNo := AssetFinanceLoan."Vendor No.";
                    TransType := Transtype::" ";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    NetToVendor := (AssetFinanceLoan.Amount - Amt);



                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((AssetFinanceLoan.Description + ' - ' + LoanApps."Member Name"), 1, 50), NetToVendor * -1, AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Pass entries to balancing account
                    if LoanApps."All Posting through Savings Ac" = true then begin
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := LoanApps."Disbursement Account No";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';


                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr(('Asset Finance Deduction' + AssetFinanceLoan."Vendor Name"), 1, 50), NetToVendor, AccNo, PDate, BalAccType,
                      BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, TopUp."Loan Top Up", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;
                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Asset Finance");
                    if PCharges.Find('-') then begin
                        repeat
                            ExcemptProductCharges.Reset();
                            ExcemptProductCharges.SetRange("Loan No.", LoanApps."Loan No.");
                            ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                            ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                            ExcemptProductCharges.setrange(Excempt, true);
                            if not ExcemptProductCharges.Find('-') then begin
                                PCharges.TestField(PCharges."Charges G_L Account");

                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := PCharges."Charges G_L Account";
                                TransType := Transtype::" ";
                                if LoanApps."All Posting through Savings Ac" = true then begin
                                    BalAccType := Balacctype::Savings;
                                    BalAccNo := LoanApps."Disbursement Account No";
                                end else begin
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := '';
                                end;
                                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                                    Amt := AssetFinanceLoan.Amount - (AssetFinanceLoan.Amount / (1 + PCharges.Percentage / 100))
                                else
                                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                        Amt := PCharges."Charge Amount"
                                    else
                                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                            PCharges.TestField(PCharges."Staggered Charge Code");

                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (AssetFinanceLoan.Amount >= TariffDetails."Lower Limit") and (AssetFinanceLoan.Amount <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            Amt := AssetFinanceLoan.Amount * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            Amt := TariffDetails."Charge Amount";
                                                        end;
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;


                                if (Amt) < PCharges.Minimum then
                                    Amt := PCharges.Minimum;

                                if (Amt) > PCharges.Maximum then
                                    Amt := PCharges.Maximum;

                                Amt := (Amt) * -1;
                                if ExcemptCharges = true then
                                    Amt := 0;


                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, PCharges."Charge Description", Amt, AccNo, PDate, BalAccType,
                              BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                //If excise duty involved
                                if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                                    GenSetup.TestField("Excise Duty G/L");
                                    GenSetup.TestField("Excise Duty (%)");
                                    LineNo := LineNo + 10000;
                                    AccType := Acctype::"G/L Account";
                                    AccNo := GenSetup."Excise Duty G/L";
                                    TransType := Transtype::" ";
                                    BalAccType := Balacctype::"G/L Account";
                                    BalAccNo := PCharges."Charges G_L Account";
                                    Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                                end;
                            end;

                        until PCharges.Next = 0;
                    end;
                until AssetFinanceLoan.Next = 0;
            end;

            //Recover discounting
            //IF LoanApps."Discounted Amount">0 THEN BEGIN
            Loans2.Reset;
            Loans2.SetRange(Loans2."Discounted Loan No.", LoanApps."Loan No.");
            if Loans2.Find('-') then begin
                repeat
                    Loans2.CalcFields(Loans2."Outstanding Interest", Loans2."Outstanding Balance");
                    Amt := 0;
                    //Loan repayment

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := Loans2."Loan Account";
                    TransType := Transtype::Repayment;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := Loans2."Outstanding Balance";


                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Disc. Paid' + LoanApps."Loan No.", -Amt, AccNo, PDate, BalAccType,
                  BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, Loans2."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    Amt := 0;

                    //Interest

                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := Loans2."Loan Account";
                    TransType := Transtype::"Interest Paid";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := '';
                    Amt := Loans2."Outstanding Interest";
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Disc. Interest' + LoanApps."Loan No.", -Amt, AccNo, PDate, BalAccType,
                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, Loans2."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    //Deduct from savings
                    if LoanApps."All Posting through Savings Ac" = true then begin
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := LoanApps."Disbursement Account No";
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Total Disc.Offset' + LoanApps."Loan No.", (Loans2."Outstanding Balance" + Loans2."Outstanding Interest"), AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    end;
                until Loans2.Next = 0;

            end;
            //Get if interest due is posted on disbursement from setups
            if ProdFac.Get(LoanApps."Loan Product Type") then begin
                if ProdFac."Compute Interest Due on Postin" = ProdFac."compute interest due on postin"::"Full Interest" then begin
                    Amt := 0;
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := LoanApps."Loan Account";
                    TransType := Transtype::"Interest Due";
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := ProdFac."Loan Interest Account [G/L]";
                    Amt := LoanApps."Approved Amount" * LoanApps.Interest / 12 * 0.01;
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                end else
                    if ProdFac."Compute Interest Due on Postin" = ProdFac."compute interest due on postin"::"Pro-rata" then begin
                        //PRORATED DAYS
                        EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
                        RemainingDays := DaysPast + (EndMonth - Today) + 1;
                        TMonthDays := Date2dmy(EndMonth, 1);
                        Amt := 0;
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := LoanApps."Loan Account";
                        TransType := Transtype::"Interest Due";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := ProdFac."Loan Interest Account [G/L]";
                        Amt := LoanApps."Approved Amount" * LoanApps.Interest / 12 * 0.01 * RemainingDays / TMonthDays;
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                        BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end
                    ELSE
                        IF ProdFac."Compute Interest Due on Postin" = ProdFac."Compute Interest Due on Postin"::"Full Period Interest" THEN BEGIN
                            Amt := 0;
                            LineNo := LineNo + 10000;
                            AccType := AccType::Credit;
                            AccNo := LoanApps."Loan Account";
                            TransType := TransType::"Interest Due";
                            BalAccType := BalAccType::"G/L Account";
                            BalAccNo := ProdFac."Loan Interest Account [G/L]";
                            Amt := LoanAppS."Approved Amount" * LoanApps.Interest / 12 * 0.01 * LoanApps.Installments;
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanApps."Loan No.", 'Interest Due' + LoanApps."Loan No.", Amt, AccNo, TODAY, BalAccType,
                             BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        END;

                //Bill if Upfront Bill
                if ProdFac."Compute Bills on Posting" = ProdFac."compute bills on posting"::"Full Amount" then begin
                    Amt := 0;
                    LineNo := LineNo + 10000;
                    AccType := Acctype::Credit;
                    AccNo := LoanApps."Loan Account";
                    TransType := Transtype::Bills;
                    BalAccType := Balacctype::"G/L Account";
                    BalAccNo := ProdFac."Billed Account";
                    Amt := LoanApps."Amount To Disburse";
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Bills' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                    BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                end else
                    if ProdFac."Compute Bills on Posting" = ProdFac."compute bills on posting"::"One Installment" then begin
                        Amt := 0;
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Credit;
                        AccNo := LoanApps."Loan Account";
                        TransType := Transtype::Bills;
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := ProdFac."Billed Account";
                        Amt := LoanApps.Repayment - LoanApps."Loan Interest Repayment";
                        if Amt > 0 then begin
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Bills' + LoanApps."Loan No.", Amt, AccNo, PDate, BalAccType,
                            BalAccNo, LoanApps."Loan No.", Dim1, Dim2, TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;
                    end;

            end;
            GenSetup.Get;
            Members.Get(LoanApps."Member No.");
            // Skip for API as channels already sends its own disbursement SMS.
            if (GenSetup."Disable Loan SMS" = false) and (not GlobalFunctions.SkipApiMsg()) then begin
                msg := 'Your Loan of KES ' + Format(LoanApps."Approved Amount") + ' ' + 'has been disbursed to your FOSA account. ' +
                                                GenSetup."Loan SMS Suffix";
                SendSMS.SendSms(Source::LOAN_POSTED, Members."Phone No.", msg, Format(LoanApps."Approved Amount"), '', true, 0, false, 'CBS', LoanApps."Disbursement Account No", 'CBS');

                //charges
                if Gensetup."Loan SMS Charge" <> '' then begin
                    GuarCount := 0;
                    LoanGuar.Reset;
                    LoanGuar.SetRange("Loan No", LoanApps."Loan No.");
                    LoanGuar.SetRange("Self Guarantee", false);
                    LoanGuar.Setrange(Substituted, False);
                    if LoanGuar.findfirst then begin
                        GuarCount := LoanGuar.Count;
                    end;
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."Loan SMS Charge");
                    if TransactionCharges.FindSet() then begin
                        repeat
                            LineNo := LineNo + 10000;
                            AccType := Acctype::Savings;
                            AccNo := LoanApps."Disbursement Account No";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'Loan Disbursement SMS Charges' + LoanApps."Loan No.", (TransactionCharges."Charge Amount" * (GuarCount + 1)), AccNo, PDate, TransactionCharges."Account Type",
                            TransactionCharges."G/L Account", LoanApps."Loan No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            //Excise duty
                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                        (TransactionCharges."Recover Excise Duty" = true) then begin
                                LineNo := LineNo + 10000;
                                AccType := Acctype::Savings;
                                AccNo := LoanApps."Disbursement Account No";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::"G/L Account";
                                BalAccNo := '';
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, LoanNo, 'SMS charge excise duty.' + LoanApps."Loan No.", round((TransactionCharges."Charge Amount" * Gensetup."Excise Duty (%)" * 0.01) * (GuarCount + 1), 0.01, '<'), AccNo, PDate, BalAccType,
                                GenSetup."Excise Duty G/L", LoanApps."Loan No.", Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;
            end;


            //Update Monthly contribution based on the product
            //contractual shares
            //Check if tiered
            IF ProdFac.Get(LoanApps."Loan Product Type") then begin
                if ProdFac."Minimum Deposit Tiered" then begin
                    //oldloans
                    LoansREc.Reset();
                    LoansREc.SetRange(LoansREc."Member No.", LoanApps."Member No.");
                    LoansREc.SetRange(Posted, true);
                    LoansREc.SetRange(LoansREc."Source Unit", LoansREc."Source Unit"::BOSA);
                    LoansREc.SetFilter(LoansREc."Outstanding Balance", '>%1', 0);
                    if LoansREc.FindFirst() then begin
                        //sharks
                        CheoffAdd.Reset();
                        CheoffAdd.SetRange(CheoffAdd."Member No.", LoansREc."Member No.");
                        CheoffAdd.SetRange(CheoffAdd.Type, CheoffAdd.Type::Savings);
                        CheoffAdd.SetCurrentKey("Amount On");
                        if CheoffAdd.FindLast() then
                            NewContr := CheoffAdd."Amount On";
                    end
                    else begin
                        DepCont := 0;
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", LoanApps."Member No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        if SavAcc.Find('-') then begin
                            DepCont := SavAcc.GetAvailableBalance(SavAcc."No.");
                            if LoanApps."Loans - Deposit Purchase" > 0 then
                                DepCont := DepCont + LoanApps."Loans - Deposit Purchase";
                            ProdFac.TestField("Minimum Deposit Tiered Code");
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, ProdFac."Minimum Deposit Tiered Code");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (DepCont >= TariffDetails."Lower Limit") and (DepCont <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            NewContr := LoanApps."Approved Amount" * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            NewContr := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                            if NewContr < CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1') then
                                NewContr := CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1');
                        end;
                    end;
                end;
            end;
        end;


        if GenSetup."Block Account for Ext.  Loan" = true then begin


            OtherLiabilitiesII.Reset;
            OtherLiabilitiesII.SetRange(OtherLiabilitiesII."Loan No.", LoanNo);
            if OtherLiabilitiesII.Find('-') then begin
                if SavAcc.Get(LoanApps."Disbursement Account No") then begin

                    //******Create a Lien for One Month Repayment.

                    CashierTransactions.Init;
                    CashierTransactions.No := '';
                    CashierTransactions."Account No" := SavAcc."No.";
                    CashierTransactions."Account Name" := SavAcc.Name;
                    CashierTransactions.Amount := LoanApps.Repayment;
                    CashierTransactions.Remarks := PadStr(LoanApps."Loan Product Type Name", 50);
                    CashierTransactions."Transaction Date" := Today;
                    CashierTransactions."Transaction Time" := Time;
                    CashierTransactions.Posted := true;
                    CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Pending;
                    CashierTransactions."Posted By" := UserId;
                    CashierTransactions.Cashier := UserId;
                    CashierTransactions.Type := CashierTransactions.Type::Lien;
                    CashierTransactions."Global Dimension 1 Code" := Dim1;
                    CashierTransactions."Global Dimension 2 Code" := Dim2;
                    CashierTransactions."ID No" := SavAcc."ID No.";
                    CashierTransactions."Responsibility Center" := LoanApps."Responsibility Centre";
                    CashierTransactions."Transaction Description" := LoanApps."Loan No.";
                    CashierTransactions."Employer Code" := SavAcc."Employer Code";
                    CashierTransactions.Insert(true);
                    //******Create a Lien for One Month Repayment.

                    SavAcc.Status := SavAcc.Status::Frozen;
                    SavAcc.Blocked := SavAcc.Blocked::All;
                    SavAcc."Status Change Reason" := 'Awaiting Bank Clearance';
                    SavAcc.Validate(Status);
                    SavAcc.MODIFY;
                end;
            end;

        end;
        //UNTIL BatchLines.NEXT=0;
        //Allow cancelling of posting midway
        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Loan No.", LoanNo);
        LoanApps.SetRange(LoanApps.status, LoanApps.status::Approved);
        if LoanApps.findfirst() then begin
            GenerateSchedule(LoanApps, True);
            JournalPosting.CompletePosting(Jtemplate, JBatch);
        end
        else begin
            Message('The loan application status is not approved and the posting process has been successfully aborted.');
            exit;
        end;

        // LoanApps.Reset;
        // LoanApps.SetRange(LoanApps."Loan No.", LoanNo);
        // LoanApps.SetRange(LoanApps.Posted, false);
        // if LoanApps.Find('-') then begin
        //     if LoanApps."Loans - Deposit Purchase" > 0 then begin
        //         SavAcc.Reset;
        //         SavAcc.SetRange(SavAcc."Member No.", LoanApps."Member No.");
        //         if ProdFac."Loan Appraisal Account Code" = '' then
        //             SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits") else
        //             SavAcc.SetRange("Product Type", ProdFac."Loan Appraisal Account Code");
        //         if SavAcc.Find('-') then begin
        //             if SavAcc."Monthly Contribution" < CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1') then
        //                 SavAcc."Monthly Contribution" := CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1');
        //             AdviceShares(SavAcc, SavAcc."Monthly Contribution", LoanApps."Loan No.");
        //         end;
        //     end;
        // end;


        //Post New
        Post := false;
        Post := JournalPostingSucc.PostedSuccessfully;

        // SavAcc.Modify;
        Commit;
        //if Post = true then begin
        LoanApps.Reset;
        LoanApps.SetRange("Loan No.", LoanNo);
        if LoanApps.Find('-') then begin
            repeat
                LoanApps.Advice := true;
                LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                LoanApps."Disbursement Date" := Today;
                LoanApps.Posted := true;
                // DepositProrata(LoanApps."Loan No.");
                HoldOneMonthInstallment(LoanApps."Loan No.");
                // AdviceLoan(LoanApps."Loan No.", false, LoanApps."Loan No.");
                LoanApps."Disbursement Date" := Today;
                LoanApps.Validate("Disbursement Date");
                LoanApps."Posted By" := UserId;
                LoanApps.Status := LoanApps.Status::Posted;
                LoanApps.Modify(true);
                Commit;
            until LoanApps.Next = 0;
        end;
        //end;

    end;

    // procedure DepositProrata(LoanNo: Code[20])
    // var
    //     MyLoans: Record Loans;
    //     ProductFactory: Record "Product Factory";
    //     Memb: Record members;
    //     SavAcc: Record "Savings Accounts";
    //     prorata: Record "Member Prorata_Contractual Dep";
    //     OldAmount: Decimal;
    // begin
    //     if MyLoans.Get(LoanNo) then begin
    //         if ProductFactory.get(MyLoans."Loan Product Type") then begin
    //             if ProdFac."Minimum Deposit Tiered" then begin
    //                 SavAcc.Reset;
    //                 SavAcc.SetRange("Member No.", MyLoans."Member No.");
    //                 SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
    //                 if SavAcc.Find('-') then begin
    //                     //  ProdFac.TestField("Minimum Deposit Tiered Code");
    //                     TariffDetails.Reset;
    //                     TariffDetails.SetRange(TariffDetails.Code, ProdFac."Minimum Deposit Tiered Code");
    //                     if TariffDetails.Find('-') then begin
    //                         repeat
    //                             if (MyLoans."Approved Amount" >= TariffDetails."Lower Limit") and (MyLoans."Approved Amount" <= TariffDetails."Upper Limit") then begin
    //                                 if TariffDetails."Use Percentage" = true then begin
    //                                     NewContr := MyLoans."Approved Amount" * TariffDetails.Percentage * 0.01;
    //                                 end else begin
    //                                     NewContr := TariffDetails."Charge Amount";
    //                                 end;
    //                             end;
    //                         until TariffDetails.Next = 0;
    //                     end;
    //                 end;
    //                 //Difference
    //                 ///Advice
    //                 if SavAcc."Monthly Contribution" < CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1') then
    //                     SavAcc."Monthly Contribution" := CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1');
    //                 if NewContr > SavAcc."Monthly Contribution" then
    //                     OldAmount := SavAcc."Monthly Contribution";
    //                 if NewContr < ProdFac."Minimum Deposit Contribution" then
    //                     NewContr := ProdFac."Minimum Deposit Contribution";
    //                 //Insert to Prorata
    //                 prorata.Reset();
    //                 prorata.SetRange("Entry Date", Today);
    //                 prorata.SetRange("Member No", MyLoans."Member No.");
    //                 prorata.DeleteAll;

    //                 prorata.Init();
    //                 prorata."Member No" := MyLoans."Member No.";
    //                 prorata."Loan No" := MyLoans."Loan No.";
    //                 prorata.Amount := NewContr;
    //                 prorata."Amount Off" := OldAmount;
    //                 prorata."Entry Date" := Today;
    //                 prorata."Captured By" := UserId;
    //                 prorata.Validate("Member No");
    //                 prorata."Effective Date" := today;
    //                 if NewContr > CustomCuesCodeunit.Prorata(SavAcc."Member No.", '1') then// if new contr is greater than the old amount
    //                     prorata.Insert(true);
    //             end;
    //         end;
    //     end;
    //     //    exit(NewContr);
    // end;


    procedure ComputeProrataQualification(LoanNo: Code[20]; DisposableIncome: Decimal): Decimal
    var
        MyLoans: Record Loans;
        ProductFactory: Record "Product Factory";
        Memb: Record members;
        SavAcc: Record "Savings Accounts";
        prorata: Record "Member Prorata_Contractual Dep";
        OldAmount: Decimal;
        LoansREc: Record Loans;
    begin
        if MyLoans.Get(LoanNo) then begin
            LoansREc.Reset();
            LoansREc.SetRange(LoansREc."Member No.", MyLoans."Member No.");
            LoansREc.SetRange(Posted, true);
            LoansREc.SetFilter(LoansREc."Approved Amount", '>%1', MyLoans."Approved Amount");
            if LoansREc.FindFirst() then begin
                if ProductFactory.Get(MyLoans."Loan Product Type") then begin
                    if ProductFactory."Loan Exclusive Factor" <> '' then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", MyLoans."Member No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        if SavAcc.Find('-') then begin
                            SavAcc.CalcFields(Balance);
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Exclusive Factor");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            NewContr := DisposableIncome * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            NewContr := TariffDetails."Charge Amount" * DisposableIncome;
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                    end;
                end;
            end else
                if ProductFactory.get(MyLoans."Loan Product Type") then begin
                    if ProductFactory."Loan Prorata Factor" <> '' then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", MyLoans."Member No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        if SavAcc.Find('-') then begin
                            SavAcc.CalcFields(Balance);
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Prorata Factor");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            NewContr := DisposableIncome * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            NewContr := TariffDetails."Charge Amount" * DisposableIncome;
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                    end;
                end;
        end;
        exit(NewContr);
    end;

    procedure ComputeChargesII(ApprovedAmt: Decimal; ProdType: Code[20]; LoanNo: Code[20]; CurrValue: Decimal): Decimal
    var
        LN: Record Loans;
        MyLoans: Record Loans;
        ProductFactory: Record "Product Factory";
        Memb: Record members;
        OtherCommitments: Record "Other Commitements Clearance";
    begin
        TotalComputedCharges := 0;
        ChargeExtraComms := FALSE;
        TopUp.RESET;
        TopUp.SETRANGE(TopUp."Loan No.", LoanNo);
        IF TopUp.FIND('-') THEN BEGIN
            REPEAT
                IF TopUp."Additional Top Up Commission" = TRUE THEN
                    ChargeExtraComms := TRUE;
            UNTIL TopUp.NEXT = 0;
        END;
        PCharges.RESET;
        PCharges.SETRANGE(PCharges."Product Code", ProdType);
        LN.GET(LoanNo);
        PCharges.SETRANGE(PCharges."Charge Type", PCharges."Charge Type"::General);
        IF PCharges.FIND('-') THEN BEGIN
            REPEAT
                ExcemptProductCharges.Reset();
                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                ExcemptProductCharges.setrange(Excempt, true);
                if not ExcemptProductCharges.Find('-') then begin
                    IF (PCharges."Use Percentage" = TRUE) THEN
                        TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * PCharges.Percentage / 100)
                    ELSE
                        TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                end;
            UNTIL PCharges.NEXT = 0;
        END;

        //MESSAGE('Running Charge general1 %1',TotalComputedCharges);
        MyLoans.GET(LoanNo);
        ProductFactory.GET(MyLoans."Loan Product Type");
        Memb.GET(MyLoans."Member No.");
        //MESSAGE('Reg Date %1',Memb."Registration Date");
        Memb.TESTFIELD("Registration Date");
        IF FORMAT(ProductFactory."Min. Re-application Period") <> '' THEN BEGIN

            IF CALCDATE(FORMAT(ProductFactory."Min. Re-application Period"), Memb."Registration Date") > TODAY THEN BEGIN
                //MESSAGE('heress %1',(CALCDATE(FORMAT(ProductFactory."Min. Re-application Period"),Memb."Registration Date")));
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", MyLoans."Loan Product Type");
                PCharges.SETRANGE(PCharges."Charge Type", PCharges."Charge Type"::General);
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            IF (PCharges."Use Percentage" = TRUE) THEN
                                TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * PCharges.Percentage / 100)
                            ELSE
                                TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                            //MESSAGE('Running Charge general %1',TotalComputedCharges);
                        end;
                    UNTIL PCharges.NEXT = 0;
                END;
            END;
        END;        //MESSAGE('Running Charge general2 %1',TotalComputedCharges);

        //End of general charges

        TotalCleared := 0;
        //Pass loan clearance principle and interest
        TopUp.RESET;
        TopUp.SETRANGE(TopUp."Loan No.", LoanNo);
        IF TopUp.FIND('-') THEN BEGIN
            REPEAT
                //TopUp.CALCSUMS(TopUp."Principle Top Up",TopUp."Interest Top Up");
                TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";// + TopUp."Additional Interest";

                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", ProdType);
                PCharges.SETRANGE(PCharges."Charge Type", PCharges."Charge Type"::"Top up");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            IF (PCharges."Use Percentage" = TRUE) AND (PCharges."Charging Option" = PCharges."Charging Option"::"On Approved Amount") THEN BEGIN
                                IF ChargeExtraComms = TRUE THEN
                                    TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                ELSE
                                    TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * (PCharges.Percentage / 100))
                            END ELSE
                                IF (PCharges."Use Percentage" = TRUE) AND (PCharges."Charging Option" = PCharges."Charging Option"::"On Net Amount") THEN BEGIN
                                    IF ChargeExtraComms = TRUE THEN
                                        TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                    ELSE
                                        TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage / 100))
                                END ELSE
                                    TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                            //MESSAGE('Running Charge topup %1',TotalComputedCharges);
                        end;
                    UNTIL PCharges.NEXT = 0;
                END;
            UNTIL TopUp.NEXT = 0;
        END;
        OtherComms := 0;
        //Clearing external debts
        OtherCommitments.RESET;
        OtherCommitments.SETRANGE(OtherCommitments."Loan No.", LoanNo);
        IF OtherCommitments.FIND('-') THEN BEGIN
            REPEAT
                TotalCleared := TotalCleared + OtherCommitments.Amount;
                //OtherCommitments.CALCSUMS(OtherCommitments.Amount);
                OtherComms := OtherCommitments.Amount;
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", ProdType);
                PCharges.SETRANGE(PCharges."Charge Type", PCharges."Charge Type"::"External Loan");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            IF (PCharges."Use Percentage" = TRUE) THEN BEGIN
                                IF ChargeExtraComms = TRUE THEN
                                    TotalComputedCharges := TotalComputedCharges + (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                ELSE
                                    TotalComputedCharges := TotalComputedCharges + (OtherCommitments.Amount * (PCharges.Percentage / 100))
                            END ELSE
                                TotalComputedCharges := TotalComputedCharges + OtherCommitments.Amount;
                            //MESSAGE('Running Charge  other comms%1',TotalComputedCharges);
                        end;
                    UNTIL PCharges.NEXT = 0;

                END;
            UNTIL OtherCommitments.NEXT = 0;
        END;

        LoanApps.RESET;
        LoanApps.SETRANGE("Loan No.", LoanNo);
        IF LoanApps.FIND('-') THEN BEGIN
            LoanApps."Total Charges and Commissions" := TotalComputedCharges;

            //IF (LoanApps."Appraisal Parameter Type" = LoanApps."Appraisal Parameter Type"::"Check Off") OR (LoanApps."Appraisal Parameter Type" = LoanApps."Appraisal Parameter Type"::"Corporate or Business") THEN
            TotalComputedCharges := TotalComputedCharges + LoanApps."Share Boosted Amount";
            //LoanApps.MODIFY;
        END;
        PaySched.RESET;
        PaySched.SETRANGE(PaySched."Loan No.", LoanNo);
        IF PaySched.FIND('-') THEN BEGIN
            PaySched.CALCSUMS(PaySched.Amount);
            TotalSched := PaySched.Amount;
        END;

        Difference := ApprovedAmt - (TotalSched + TotalComputedCharges + TotalCleared + CurrValue);


        //MESSAGE('Apr %1 TotSched %2 TotCompCha %3 OtherComms %4 TotCleared %5',ApprovedAmt,TotalSched,TotalComputedCharges,OtherComms,TotalCleared);
        EXIT(Difference);


    end;
    //Excise duty for all charges
    procedure ComputeExciseDuty(ApprovedAmt: Decimal; ProdType: Code[20]; LoanNo: Code[50]; CurrValue: Decimal): Decimal
    var
        IndividualCharge: Decimal;
        ExciseDutyCharges: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
    begin
        ExciseDutyCharges := 0;
        TotalComputedCharges := 0;
        ChargeExtraComms := false;
        TopUp.Reset;
        TopUp.SetRange(TopUp."Loan No.", LoanNo);
        if TopUp.Find('-') then begin
            repeat
                if TopUp."Additional Top Up Commission" = true then
                    ChargeExtraComms := true;
            until TopUp.Next = 0;
        end;
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProdType);
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
        // General charges-----------------------MIM
        if PCharges.Find('-') then begin
            repeat
                ExcemptProductCharges.Reset();
                ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                ExcemptProductCharges.setrange(Excempt, true);
                if not ExcemptProductCharges.Find('-') then begin
                    IndividualCharge := 0;

                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then begin
                        if (ApprovedAmt * PCharges.Percentage * 0.01) > PCharges.Minimum then begin
                            TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * PCharges.Percentage / 100);
                            IndividualCharge := ApprovedAmt * PCharges.Percentage / 100;
                        end
                        else begin
                            TotalComputedCharges := TotalComputedCharges + PCharges.Minimum;
                            IndividualCharge := PCharges.Minimum;
                        end;
                        IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                            GenSetup.get;
                            GenSetup.TESTFIELD("Excise Duty (%)");
                            ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=')
                        end;
                    end

                    else
                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then begin
                            TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                            IndividualCharge := PCharges."Charge Amount";

                            IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                                GenSetup.get;
                                GenSetup.TESTFIELD("Excise Duty (%)");

                                ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=')
                            end;
                        end
                        /// Excise duty not implemented for staggered charges MIM
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                PCharges.TestField(PCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (ApprovedAmt >= TariffDetails."Lower Limit") and (ApprovedAmt <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                IndividualCharge := ApprovedAmt * TariffDetails.Percentage * 0.01;

                                            end else begin
                                                IndividualCharge := TariffDetails."Charge Amount";
                                                // IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                                                //     GenSetup.get;
                                                //     GenSetup.TESTFIELD("Excise Duty (%)");
                                                //     ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=')
                                                // end;
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                                IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                                    GenSetup.get;
                                    GenSetup.TESTFIELD("Excise Duty (%)");
                                    ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=')
                                end;
                            end;
                end;
            until PCharges.Next = 0;
        end;

        ///MESSAGE('Running Charge general %1',TotalComputedCharges);


        //End of general charges

        TotalCleared := 0;
        //Pass loan clearance principle and interest
        TopUp.Reset;
        TopUp.SetRange(TopUp."Loan No.", LoanNo);
        if TopUp.Find('-') then begin
            repeat
                //TopUp.CALCSUMS(TopUp."Principle Top Up",TopUp."Interest Top Up");
                TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";

                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", ProdType);
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin

                            if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                if ChargeExtraComms = true then
                                    IndividualCharge := (ApprovedAmt * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                else
                                    IndividualCharge := (ApprovedAmt * (PCharges.Percentage / 100));
                            end else
                                if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                    if ChargeExtraComms = true then
                                        IndividualCharge := ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100));
                                end else
                                    IndividualCharge := +PCharges."Charge Amount";
                            IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                                GenSetup.get;
                                GenSetup.TESTFIELD("Excise Duty (%)");
                                ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=')
                            end;
                            // MESSAGE('Running Charge topup %1',TotalComputedCharges);
                        end;
                    until PCharges.Next = 0;
                end;
            until TopUp.Next = 0;
        end;
        //Appraisal Fee max is 200
        if TotalComputedCharges > 5000000 then
            TotalComputedCharges := 5000000;

        OtherComms := 0;
        //TotalCleared:=0;
        //TotalComputedCharges:=0;
        //Clearing external debts
        OtherCommitments.Reset;
        OtherCommitments.SetRange(OtherCommitments."Loan No.", LoanNo);
        if OtherCommitments.Find('-') then begin
            repeat
                TotalCleared := TotalCleared + OtherCommitments.Amount;
                //OtherCommitments.CALCSUMS(OtherCommitments.Amount);
                //OtherComms:=OtherCommitments.Amount;
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", ProdType);
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
                if PCharges.Find('-') then begin
                    repeat
                        ExcemptProductCharges.Reset();
                        ExcemptProductCharges.SetRange("Loan No.", LoanNo);
                        ExcemptProductCharges.SetRange("Product Code", PCharges."Product Code");
                        ExcemptProductCharges.setrange("Charge Code", PCharges."Charge Code");
                        ExcemptProductCharges.setrange(Excempt, true);
                        if not ExcemptProductCharges.Find('-') then begin
                            if (PCharges."Use Percentage" = true) then begin
                                if ChargeExtraComms = true then begin
                                    IndividualCharge := (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100));
                                end else begin
                                    IndividualCharge := (OtherCommitments.Amount * (PCharges.Percentage / 100));
                                end;
                            End else
                                IndividualCharge := (OtherCommitments.Amount * (PCharges.Percentage / 100));

                            IF PCharges."Effect Excise Duty" = PCharges."Effect Excise Duty"::Yes THEN BEGIN
                                GenSetup.get;
                                GenSetup.TESTFIELD("Excise Duty (%)");
                                ExciseDutyCharges := ExciseDutyCharges + ROUND(IndividualCharge * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=') //MIM
                            end;
                        end;
                    until PCharges.Next = 0;

                end;
            until OtherCommitments.Next = 0;
        end;


        /*//AssetFinComms
        AssetFinComms:=0;
        TotalAssetFin:=0;
        AssetFinanceLoan.RESET;
        AssetFinanceLoan.SETRANGE(AssetFinanceLoan."Loan No.",LoanNo);
        IF AssetFinanceLoan.FIND('-') THEN BEGIN
        REPEAT
          TotalAssetFin:=TotalAssetFin+AssetFinanceLoan.Amount;

        PCharges.RESET;
        PCharges.SETRANGE(PCharges."Product Code",ProdType);
        PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::"Asset Finance");
        IF PCharges.FIND('-') THEN BEGIN
           REPEAT
           IF (PCharges."Use Percentage"=TRUE) THEN BEGIN

               TotalComputedCharges :=TotalComputedCharges+(AssetFinanceLoan.Amount-(AssetFinanceLoan.Amount / (1+PCharges.Percentage/100)))
           END ELSE
               TotalComputedCharges:=TotalComputedCharges+AssetFinanceLoan.Amount;

           UNTIL PCharges.NEXT = 0;
           MESSAGE('Running Charge  other comms%1,%2',TotalComputedCharges,TotalAssetFin);
           END;

           TotalComputedCharges:=TotalAssetFin;
        UNTIL AssetFinanceLoan.NEXT=0;
        END;
        */

        LoanApps.Reset;
        LoanApps.SetRange("Loan No.", LoanNo);
        if LoanApps.Find('-') then begin
            LoanApps."Total Charges and Commissions" := TotalComputedCharges;

            //if (LoanApps."Appraisal Parameter Type" = LoanApps."appraisal parameter type"::"Check Off") or (LoanApps."Appraisal Parameter Type" = LoanApps."appraisal parameter type"::"Corporate or Business") then
            TotalComputedCharges := TotalComputedCharges + LoanApps."Share Boosted Amount";
            //LoanApps.MODIFY;
        end;
        // PaySched.Reset;
        // PaySched.SetRange(PaySched."Loan No.", LoanNo);
        // if PaySched.Find('-') then begin
        //     PaySched.CalcSums(PaySched.Amount);
        //     TotalSched := PaySched.Amount;
        // end;

        //Initially
        // Difference := ApprovedAmt - (/*TotalSched + TotalComputedCharges * 0.1 + */TotalComputedCharges + TotalCleared /*+ CurrValue*/);
        // Difference := ApprovedAmt - (TotalSched + /*TotalComputedCharges * 0.1 +*/ TotalComputedCharges + TotalCleared /*+ CurrValue*/);


        //MESSAGE('Apr %1 TotSched %2 TotCompCha %3 OtherComms %4 TotCleared %5',ApprovedAmt,TotalSched,TotalComputedCharges,OtherComms,TotalCleared);
        exit(ExciseDutyCharges);

    end;

    procedure LoanCategoryStage(DaysInArrears: Decimal) LoanCategory: Enum "Loan Sasra categories"
    var
        TariffDetails: Record "Agent Tariff Details";
        generalSetup: Record "General Set-Up";
        LoanCategories: Enum "Loan Sasra categories";
    begin
        generalSetup.get();
        generalSetup.TestField("Loan Categorization Code");
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code, generalSetup."Loan Categorization Code");
        IF TariffDetails.FIND('-') THEN BEGIN
            REPEAT
                IF (DaysInArrears >= TariffDetails."Lower Limit") AND (DaysInArrears <= TariffDetails."Upper Limit") THEN BEGIN

                    LoanCategories := TariffDetails."Loans Category-SASRA";
                END;
            UNTIL TariffDetails.NEXT = 0;
        END;
        exit(LoanCategories);
    end;

    procedure CalculateDaysInArrearsg(Loans: Record Loans; AsAt: Date; var RunLoan: Boolean) DaysInArrears: Decimal
    var
        MoratoriumLoan: Record "Moratorium Loan";
        ProgressWindow: Dialog;
        LoanRec: Record Loans;
        Counter: Integer;
        SASRACategory: Record "SASRA Categorization";
        ProductFactory: Record "Product Factory";
        AmtPaid: Decimal;
        ArrearsDate: Date;
        LnReshedule: Record "Ideal Repayment Schedule";
        SchAmt: Decimal;
        AddOnRepayments: Decimal;
    begin
        RunLoan := true;

        AddOnRepayments := 0;
        MoratoriumLoan.Reset();
        MoratoriumLoan.SetRange(Status, MoratoriumLoan.Status::Approved);
        MoratoriumLoan.SetRange(MoratoriumLoan."Loan No", Loans."Loan No.");
        MoratoriumLoan.SetFilter(MoratoriumLoan."End Date Moratorium", '>%1', Today);
        if MoratoriumLoan.FindFirst() then begin
            RunLoan := false;
        end;

        if Loans."Loan Product Type" = '' then RunLoan := false;

        if RunLoan = true then begin

            if ProductFactory.Get(Loans."Loan Product Type") then begin
                if ProductFactory."Interest Recovered Upfront" then
                    AddOnRepayments := ROUND((ProductFactory."Interest Rate (Max.)" / 1200) * Loans."Approved Amount", 1, '<');

                LoanRec.RESET;
                LoanRec.SETRANGE("Loan No.", Loans."Loan No.");
                LoanRec.SETRANGE("Disbursement Date", 0D, AsAt);
                LoanRec.SETFILTER("Date Filter", '..%1', AsAt);
                IF LoanRec.FINDFIRST THEN BEGIN

                    LoanRec.CALCFIELDS("Outstanding Balance", "Loans Category-SASRA", "Outstanding Interest");

                    AmtPaid := LoanRec."Approved Amount" - LoanRec."Outstanding Balance";
                    IF AmtPaid < 0 THEN
                        AmtPaid := 0;

                    ArrearsDate := 0D;
                    DaysInArrears := 0;

                    LnReshedule.RESET;
                    LnReshedule.SETRANGE("Loan No.", Loans."Loan No.");
                    LnReshedule.SETFILTER("Repayment Date", '..%1', AsAt);
                    IF LnReshedule.FIND('-') THEN BEGIN
                        SchAmt := 0;
                        REPEAT
                            SchAmt += LnReshedule."Principal Repayment";
                            IF SchAmt > AmtPaid THEN
                                ArrearsDate := LnReshedule."Repayment Date";
                        UNTIL (LnReshedule.NEXT = 0) OR (ArrearsDate <> 0D);
                    END;

                    IF ArrearsDate <> 0D THEN BEGIN
                        // ArrearsDate := CALCDATE('1M+CM+1D', ArrearsDate);
                        DaysInArrears := AsAt - ArrearsDate;
                    END;

                    IF LoanRec."Outstanding Balance" <= 0 THEN
                        DaysInArrears := 0;

                    IF DaysInArrears < 0 THEN
                        DaysInArrears := 0;
                end;
            end;
        end;
    end;

    procedure DateFormulaetoDays(DateFormulae: DateFormula): Integer
    begin
        exit((Today) - (CalcDate('-' + Format(DateFormulae), Today)));
    end;

    procedure CalculateLoanArrears(Loans: Record Loans; var AmountInArrearsSACCO: Decimal; var AmountInArrearsSASRA: Decimal; AsAt: Date; CreateEntry: Boolean) DaysInArrears: Decimal
    var
        MoratoriumLoan: Record "Moratorium Loan";
        ProductFactory: Record "Product Factory";
        AmtPaid: Decimal;
        LnReshedule: Record "Ideal Repayment Schedule";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        GraceDays: Integer;
        EmptyDateFormula: DateFormula;

        ActualPrincipleBal: Decimal;
        ActualInterestBal: Decimal;
        ActualTotalBal: Decimal;

        IdealPrincipleBal: Decimal;
        IdealInterestBal: Decimal;
        IdealTotalBal: Decimal;

        MonthlyPrinciple: Decimal;
        MonthlyInterest: Decimal;
        MonthlyRepayment: Decimal;

        DaysAfterSchedule: Integer;
        SASRACategory: Record "SASRA Categorization";
        LoanAge: Decimal;

        Schedule: Record "Ideal Repayment Schedule";
        InstallInArrears: Decimal;
        CreditLedger: record "Credit Ledger Entry";
        CurrMonthInt: Decimal;
    begin
        Schedule.Reset();
        Schedule.SetRange("Loan No.", Loans."Loan No.");
        if not Schedule.FindFirst() then
            GenerateSchedule(Loans, true);

        Loans.SetFilter("Date Filter", '..%1', AsAt);
        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
        if Loans."Expected Date of Completion" = 0D then begin
            Schedule.Reset();
            Schedule.SetRange("Loan No.", Loans."Loan No.");
            if Schedule.findlast then begin
                Loans."Expected Date of Completion" := Schedule."Repayment Date";
                Loans.Modify;
            end;
        end;
        // Loans with grace period - to change from 137
        if (Loans."Recovery Mode" <> Loans."Recovery Mode"::Dividend) then begin
            MoratoriumLoan.Reset();
            MoratoriumLoan.SetRange(Status, MoratoriumLoan.Status::Approved);
            MoratoriumLoan.SetRange(MoratoriumLoan."Loan No", Loans."Loan No.");
            if MoratoriumLoan.FindFirst() then begin
                if (MoratoriumLoan."End Date Moratorium" <> 0D) and (MoratoriumLoan."Start Date Moratorium" <> 0D) then
                    GraceDays := MoratoriumLoan."End Date Moratorium" - MoratoriumLoan."Start Date Moratorium";
            end;

            // if Loans."Grace Period" <> EmptyDateFormula then
            //     GraceDays := DateFormulaetoDays(Loans."Grace Period");

            ActualInterestBal := Loans."Outstanding Interest";
            ActualPrincipleBal := Loans."Outstanding Balance";
            ActualTotalBal := ActualInterestBal + ActualPrincipleBal;

            LnReshedule.Reset();
            LnReshedule.SetRange("Loan No.", Loans."Loan No.");
            if LnReshedule.FindFirst() then begin
                MonthlyInterest := LnReshedule."Monthly Interest";
                MonthlyPrinciple := LnReshedule."Principal Repayment";
                MonthlyRepayment := MonthlyInterest + MonthlyPrinciple;
            end;

            LnReshedule.Reset();
            LnReshedule.SetRange("Loan No.", Loans."Loan No.");
            LnReshedule.SetFilter("Repayment Date", '>=%1', AsAt);
            if LnReshedule.Find('-') then begin
                IdealInterestBal := Abs(LnReshedule."Monthly Interest");
                repeat
                    IdealPrincipleBal += Abs(LnReshedule."Principal Repayment");
                until LnReshedule.NEXT = 0;
            end else begin
                if Loans."Expected Date of Completion" <> 0D then
                    DaysAfterSchedule := AsAt - Loans."Expected Date of Completion";
            end;

            IdealTotalBal := IdealPrincipleBal;

            DaysInArrears := DaysAfterSchedule;
            InstallInArrears := round(DaysAfterSchedule / 30, 0.01, '=');

            CurrMonthInt := 0;
            CreditLedger.reset;
            CreditLedger.setrange("Loan No", Loans."Loan No.");
            CreditLedger.setfilter("Posting Date", '%1..%2', CalcDate('-CM', AsAt), calcdate('<CM>', AsAt));
            CreditLedger.setrange("Transaction Type", CreditLedger."Transaction Type"::"Interest Due");
            if CreditLedger.FindSet() then begin
                CreditLedger.CalcSums("Amount (LCY)");
                CurrMonthInt := CreditLedger."Amount (LCY)";
            end;

            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                AmountInArrearsSASRA := ActualPrincipleBal - IdealPrincipleBal;
                AmountInArrearsSACCO := (ActualPrincipleBal + ActualInterestBal) - (IdealPrincipleBal + CurrMonthInt);
                if MonthlyPrinciple <> 0 then begin
                    DaysInArrears += Round((AmountInArrearsSASRA / MonthlyPrinciple) * 30, 1, '>');
                    InstallInArrears += Round((AmountInArrearsSASRA / MonthlyPrinciple), 0.01, '=');
                end;

                // DaysInArrears += Round((round((AmountInArrearsSASRA / MonthlyPrinciple), 1, '<')) * 30, 1, '<');
            end else begin
                AmountInArrearsSASRA := ActualTotalBal - IdealTotalBal - CurrMonthInt;
                AmountInArrearsSACCO := AmountInArrearsSASRA;
                //if MonthlyRepayment <> 0 then
                //DaysInArrears += Round((AmountInArrearsSASRA / MonthlyRepayment) * 30, 1, '<'); Cyprian, commented to catch the divide by zero
                if MonthlyRepayment = 0 then MonthlyRepayment := MonthlyPrinciple;
                if MonthlyRepayment > 0 then begin
                    DaysInArrears += Round(((AmountInArrearsSASRA / MonthlyRepayment) * 30), 1, '>');
                    InstallInArrears += Round((AmountInArrearsSASRA / MonthlyRepayment), 0.01, '=');
                end;

            end;
            DaysInArrears := round(DaysInArrears, 1, '>');
            if AmountInArrearsSACCO <= 0 then AmountInArrearsSACCO := 0;
            if AmountInArrearsSASRA <= 0 then AmountInArrearsSASRA := 0;

            if DaysInArrears <= 0 then begin
                DaysInArrears := 0;
            end else begin
                // DaysInArrears -= GraceDays;
                if DaysInArrears <= 0 then
                    DaysInArrears := 0;
            end;
            if InstallInArrears <= 0 then
                InstallInArrears := 0;

        end else begin
            if Loans."Disbursement Date" = 0D then Loans."Disbursement Date" := (CalcDate('-12M', AsAt));
            if Loans."Disbursement Date" <> 0D then begin
                if (CalcDate('12M', Loans."Disbursement Date")) < AsAt then begin
                    AmountInArrearsSACCO := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                    AmountInArrearsSASRA := AmountInArrearsSACCO;
                    DaysInArrears := AsAt - Loans."Disbursement Date";
                    // One off loans not recovered in the year;
                    InstallInArrears := 12.1;
                end;
            end;

        end;

        if Loans."Repayment Start Date" <> 0D then
            if Loans."Repayment Start Date" > AsAt then begin
                DaysInArrears := 0;
                AmountInArrearsSACCO := 0;
                AmountInArrearsSASRA := 0;
                InstallInArrears := 0;
            end;

        if (Loans."Outstanding Balance" + Loans."Outstanding Interest" <= 0) then begin
            DaysInArrears := 0;
            AmountInArrearsSACCO := 0;
            AmountInArrearsSASRA := 0;
            InstallInArrears := 0;
        end;


        // Guarantor loans to always be in loss - FINANCE Kenneth.
        // if (Loans."Loan Product Type" = 'BGL') or (Loans."Loan Product Type" = 'FGL') then begin
        //     AmountInArrearsSACCO := Loans."Outstanding Balance" + Loans."Outstanding Interest";
        //     AmountInArrearsSASRA := AmountInArrearsSACCO;
        //     DaysInArrears := AsAt - Loans."Disbursement Date";
        //     // One off loans not recovered in the year;
        //     InstallInArrears := 12.1;
        // end;

        // DaysInArrears := LoansProcess.CalculateLoanArrears(Loans, AmountInArrearsSACCO, AmountInArrearsSASRA, AsAt);

        if CreateEntry then begin

            Loans."Loans Category-SASRA" := LoanCategoryStage(InstallInArrears);
            if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Perfoming then begin
                DaysInArrears := 0;
                AmountInArrearsSACCO := 0;
                AmountInArrearsSASRA := 0;
                InstallInArrears := 0;
            end;
            AmountInArrearsSACCO := round(AmountInArrearsSACCO, 0.01, '=');
            AmountInArrearsSASRA := round(AmountInArrearsSACCO, 0.01, '=');

            if not SASRACategory.Get(Loans."Loan No.") then begin
                SASRACategory.INIT;
                SASRACategory."Loan No." := Loans."Loan No.";
                SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                SASRACategory."Loan Age" := LoanAge;
                SASRACategory."Days In Arreas" := DaysInArrears;
                SASRACategory."Amount In Arears SACCO" := AmountInArrearsSACCO;
                SASRACategory."Amount In Arears SASRA" := AmountInArrearsSACCO;
                SASRACategory."Installments In Arrears" := InstallInArrears;
                SASRACategory."Installments In Fall Off" := round(InstallInArrears, 1, '=');
                SASRACategory.INSERT;
            end else begin
                SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                SASRACategory."Loan Age" := LoanAge;
                SASRACategory."Days In Arreas" := DaysInArrears;
                SASRACategory."Amount In Arears SACCO" := AmountInArrearsSACCO;
                SASRACategory."Amount In Arears SASRA" := AmountInArrearsSASRA;
                SASRACategory."Installments In Arrears" := InstallInArrears;
                SASRACategory."Installments In Fall Off" := round(InstallInArrears, 1, '>');
                SASRACategory.Modify();
            end;
        end;
    end;

    procedure CalculateMemberArrearsPerSourceUnit(MemberNo: Code[50]; AsAt: Date; SourceUnit: Integer) AmountInArrears: Decimal
    var
        MoratoriumLoan: Record "Moratorium Loan";
        ProgressWindow: Dialog;
        LoanRec: Record Loans;
        Counter: Integer;
        SASRACategory: Record "SASRA Categorization";
        ProductFactory: Record "Product Factory";
        AmtPaid: Decimal;
        ArrearsDate: Date;
        LnReshedule: Record "Ideal Repayment Schedule";
        SchAmt: Decimal;
        AddOnRepayments: Decimal;
        RunLoan: Boolean;
        SaccoArrears: Decimal;
        SasraArrears: Decimal;
    begin
        AmountInArrears := 0;
        LoanRec.Reset;
        LoanRec.SetRange("Member No.", MemberNo);
        LoanRec.SetRange("Source Unit", SourceUnit);
        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
        if LoanRec.FindSet then
            repeat
                // AmountInArrears := CalculateAmountInArrears(LoanRec, AsAt, RunLoan);
                CalculateLoanArrears(LoanRec, SaccoArrears, SasraArrears, Today, true);

                AmountInArrears += SasraArrears;
            until LoanRec.Next = 0;

    end;

    // procedure CalculateFallOffMonths(Loans: Record Loans; AsAt: Date): Integer
    // var
    //     SasraCat: Record "SASRA Categorization";
    //     CreditLedgerEntry: Record "Credit Ledger Entry";
    //     StartDate: Date;
    //     EndDate: Date;
    //     Members: Record Members;
    //     Employer: Record Customer;
    //     GeneralSetUp: Record "General Set-Up";
    //     CutoffDate: Integer;
    //     PreviousMonth: Date;
    //     CreditAmount: Decimal;
    //     Counter: Integer;
    //     CountFallOff: Boolean;
    //     LastCreditDate: Date;
    //     Schedule: Record "Ideal Repayment Schedule";
    //     TotalPaid: Decimal;
    //     TotalExpected: Decimal;
    //     Variance: Decimal;
    //     RunLoan: Boolean;
    //     SASRACategory: Record "SASRA Categorization";
    //     AmountInArreasSACCO: Decimal;
    //     AmountInArreasSASRA: Decimal;
    //     DaysInArrears: Integer;
    // begin
    //     DaysInArrears := LoanProcess.CalculateLoanArrears(Loans, AmountInArreasSACCO, AmountInArreasSASRA, Today, false);

    //     Loans.CalcFields("Outstanding Balance");
    //     GeneralSetUp.Get();
    //     GeneralSetUp.TestField("Checkoff Cuttoff Day");
    //     CutoffDate := GeneralSetUp."Checkoff Cuttoff Day";

    //     if Members.Get(Loans."Member No.") then begin
    //         if Employer.Get(Members."Employer Code") then begin
    //             if Employer."Checkoff Cuttoff Day" <> 0 then
    //                 CutoffDate := Employer."Checkoff Cuttoff Day";
    //         end;

    //         PreviousMonth := CalcDate('-1M', AsAt);
    //         CountFallOff := true;
    //         //If loan Application month is last month and todays date is less than cuttoff date then dont run
    //         if (Date2DMY(PreviousMonth, 2) = Date2DMY(Loans."Disbursement Date", 2)) and (Date2DMY(AsAt, 2) < CutoffDate) then
    //             CountFallOff := false;
    //         if (Date2DMY(AsAt, 2) = Date2DMY(Loans."Disbursement Date", 2)) and (Date2DMY(AsAt, 3) = Date2DMY(Loans."Disbursement Date", 3)) then
    //             CountFallOff := false;

    //         if Date2DMY(AsAt, 1) >= CutoffDate then begin
    //             EndDate := AsAt;
    //             StartDate := CalcDate('-CM', AsAt);
    //         end else begin
    //             EndDate := AsAt;
    //             StartDate := CalcDate('-1M-CM', EndDate);
    //         end;

    //         Counter := 0;
    //         CreditLedgerEntry.Reset();
    //         CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
    //         CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
    //         if CreditLedgerEntry.FindLast() then begin
    //             // LastCreditDate := CalcDate('1D', CreditLedgerEntry."Posting Date");
    //             LastCreditDate := CreditLedgerEntry."Posting Date";
    //         end;

    //         if LastCreditDate = 0D then begin
    //             Counter := Round(DaysInArrears / 30, 1, '<');
    //         end else begin
    //             repeat

    //                 //If last credit date is in-between the start and end dates then do not count
    //                 if CountFallOff then
    //                     if LastCreditDate < StartDate then
    //                         Counter += 1;

    //                 EndDate := DMY2Date(CutoffDate, Date2DMY(StartDate, 2), Date2DMY(StartDate, 3));
    //                 PreviousMonth := CalcDate('-1M', EndDate);
    //                 StartDate := CalcDate('-CM', PreviousMonth);


    //             until (StartDate <= LastCreditDate);
    //         end;
    //     end;

    //     if Loans."Outstanding Balance" <= 0 then Counter := 0;

    //     Loans."Loans Category-SASRA" := LoanProcess.LoanCategoryStage(DaysInArrears);

    //     if not SASRACategory.Get(Loans."Loan No.") then begin
    //         SASRACategory.INIT;
    //         SASRACategory."Loan No." := Loans."Loan No.";
    //         SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
    //         SASRACategory."Amount In Arears SACCO" := AmountInArreasSACCO;
    //         SASRACategory."Amount In Arears SASRA" := AmountInArreasSASRA;
    //         SASRACategory."Days In Arreas" := DaysInArrears;
    //         SASRACategory."Installments In Fall Off" := Counter;
    //         SASRACategory.INSERT;
    //     end else begin
    //         SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
    //         SASRACategory."Days In Arreas" := DaysInArrears;
    //         SASRACategory."Installments In Fall Off" := Counter;
    //         SASRACategory."Amount In Arears SACCO" := AmountInArreasSACCO;
    //         SASRACategory."Amount In Arears SASRA" := AmountInArreasSASRA;
    //         SASRACategory.Modify();
    //     end;
    //     exit(Counter);
    // end;


    procedure InsertLoanArreas(Loans: Record loans; Arrears: Decimal)
    var
        SASRACategory: Record "SASRA Categorization";
        LoansProcess: Codeunit "Loans Process";
    begin
        Loans."Loans Category-SASRA" := LoansProcess.LoanCategoryStage(Arrears);
        if not SASRACategory.Get(Loans."Loan No.") then begin
            SASRACategory.INIT;
            SASRACategory."Loan No." := Loans."Loan No.";
            SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
            SASRACategory."Days In Arreas" := Arrears;
            SASRACategory.INSERT;
        end else begin
            SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
            SASRACategory."Days In Arreas" := Arrears;
            SASRACategory.Modify();
        end;
    end;

    procedure ManageSMSAlerts(LoanNumber: Code[30]; NoOfDaysInArrears: Decimal; AsAtDate: Date; DefaulterLoan: Boolean)
    var
        SMSAlertsManager: Record "SMS Alerts Manager";
        NormalSMSDate: Date;
        CRBSMSDate: Date;
        GuarantorSMSDate: Date;
        sms: Text;
        Loans: Record Loans;
        FirstName: Text;
        TotalLoanBalance: Decimal;
        LoanGuarantors: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        GuarantorName: Text;
        AmountInArrears: Decimal;
        PhoneNumber: Text;
        // SkyMbanking: Codeunit "Sky Mbanking";
        Members: Record Members;
        Source: Enum "SMS Source";
        Priority: Integer;
        SecurityRegister: Record "Securities Register";
    begin
        Priority := 250;
        if not SMSAlertsManager.Get(LoanNumber) then begin
            SMSAlertsManager.Init();
            SMSAlertsManager."Loan Number" := LoanNumber;
            SMSAlertsManager."Last Alert Date" := AsAtDate;
            SMSAlertsManager."CRB Alert Date" := AsAtDate;
            SMSAlertsManager.Insert();
        end;

        if SMSAlertsManager.Get(LoanNumber) then begin
            Loans.Get(LoanNumber);
            if Members.Get(Loans."Member No.") then begin

                PhoneNumber := Members."Phone No.";



                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Last Repayment Date");
                TotalLoanBalance := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                if StrPos(Loans."Member Name", ' ') > 0 then
                    FirstName := CopyStr(Loans."Member Name", 1, StrPos(Loans."Member Name", ' ') - 1)
                else
                    FirstName := Loans."Member Name" + ' ';


                if (NoOfDaysInArrears > 0) and (NoOfDaysInArrears < 1) then begin
                    sms := 'Dear ' + FirstName + ', your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' is due.' +
                    ' The expected repayment rate is KES ' + Format(Loans.Repayment) + ' and you outstanding loan balance is KES ' + Format(Loans."Outstanding Balance") +
                    ' Kindly plan to repay your loan. For more info call 0710600999. Kenpipe SACCO';
                    SendSMS.SendSms(Source::MBANKING, PhoneNumber, sms, Format(LoanNumber), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');
                end;

                if Loans."Source Unit" <> Loans."Source Unit"::"BUSINESS LOANS" then begin
                    if SMSAlertsManager."Last Alert Date" <> 0D then begin
                        NormalSMSDate := SMSAlertsManager."Last Alert Date";

                        if NormalSMSDate <= AsAtDate then begin
                            //Send SMS and Update next SMS Date
                            CASE NoOfDaysInArrears OF
                                0:
                                    begin
                                        //in the next 60 days, i should send first alert
                                        SMSAlertsManager."Last Alert Date" := CalcDate('59D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();
                                    end;
                                1 .. 29:
                                    BEGIN
                                        //Update next alert with number of days
                                        //in the next 30 - DaysInArrears this member will need an SMS For first alert
                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(30 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                30 .. 59:
                                    BEGIN
                                        //First Alert
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +
                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + ' and you outstanding loan balance is KES ' + Format(Loans."Outstanding Balance") +
                                        ' Kindly plan to repay your loan as we are on the process of informing your guarantors.';// For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(LoanNumber), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');

                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(60 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                60 .. 89:
                                    BEGIN
                                        //Second Alert
                                        //In the next 90 - DaysInArrears this member will be a candidate for recovery
                                        sms := 'Dear' + FirstName + ', We have notified your guarantors of your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' current status and our intention to attach.' +
                                        ' Should you not pay within a period of 30 days, then our assumption shall be that you have conceded to the attachment of the loan to guarantors without any further reference to you.';
                                        //' For more info call 0710600999. Kenpipe SACCO.';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(LoanNumber), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');

                                        LoanGuarantors.Reset();
                                        LoanGuarantors.SetRange(Substituted, false);
                                        LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
                                        LoanGuarantors.SetRange("Loan No", LoanNumber);
                                        LoanGuarantors.SetRange("Self Guarantee", false);
                                        if LoanGuarantors.FindFirst() then begin
                                            repeat
                                                if SavingsAccounts.Get(LoanGuarantors."Savings Account No./Member No.") then begin
                                                    Members.Get(SavingsAccounts."Member No.");
                                                    PhoneNumber := Members."Phone No.";
                                                    if StrPos(SavingsAccounts.Name, ' ') > 0 then
                                                        GuarantorName := CopyStr(SavingsAccounts.Name, 1, StrPos(SavingsAccounts.Name, ' ') - 1)
                                                    else
                                                        GuarantorName := SavingsAccounts.Name + ' ';

                                                    sms := 'Dear ' + GuarantorName + ', the loan for ' + FirstName + '-' + Loans."Member No." + ' you guaranteed is in arrears of ' + Format(AmountInArrears) +
                                                    '. Should we not hear from you or the loanee within a period of 30 days, then our assumption shall be that you have conceded to the attachment' +
                                                    ' of your salary or shares without any further reference to you.';// For more info call 0710600999. Kenpipe SACCO.';
                                                    SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(GuarantorName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');

                                                end;
                                            until LoanGuarantors.Next() = 0;
                                        end;

                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(90 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                ELSE BEGIN
                                    //List for Recovery
                                    SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                    SMSAlertsManager."Attachment Candidate" := true;
                                    SMSAlertsManager.Modify();

                                END;
                            END;
                        end;
                    end;
                end;

                //Business Loans Notices
                if Loans."Source Unit" = Loans."Source Unit"::"BUSINESS LOANS" then begin
                    if SMSAlertsManager."Last Alert Date" <> 0D then begin
                        NormalSMSDate := SMSAlertsManager."Last Alert Date";

                        if NormalSMSDate <= AsAtDate then begin

                            //Send SMS and Update next SMS Date
                            CASE NoOfDaysInArrears OF
                                0 .. 6:
                                    begin
                                        //in the next 60 days, i should send first alert
                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(7 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();
                                    end;
                                7 .. 13:
                                    BEGIN
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +

                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + '. For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');


                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(14 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();
                                    END;
                                14 .. 27:
                                    BEGIN
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +
                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + '. For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');

                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(27 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                28 .. 39:
                                    BEGIN
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +

                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + '. For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');


                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(40 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                40 .. 89:
                                    BEGIN
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +

                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + '. For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');


                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(90 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();
                                    END;
                                90 .. 99:
                                    BEGIN
                                        //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                        sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +

                                        ' The expected repayment rate is KES ' + Format(Loans.Repayment) + 'In the next 10 days we shall reposses. For more info call 0710600999. Kenpipe SACCO';
                                        SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');


                                        SMSAlertsManager."Last Alert Date" := CalcDate(Format(100 - NoOfDaysInArrears) + 'D', AsAtDate);
                                        SMSAlertsManager."Attachment Candidate" := false;
                                        SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                        SMSAlertsManager.Modify();

                                    END;
                                ELSE BEGIN
                                    //List for Recovery
                                    SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                    SMSAlertsManager."Attachment Candidate" := true;
                                    SMSAlertsManager.Modify();

                                END;
                            END;
                        end;
                    end;
                end;

                //CRB NOTICES
                if SMSAlertsManager."Last Alert Date" <> 0D then begin

                    NormalSMSDate := SMSAlertsManager."Last Alert Date";


                    if NormalSMSDate <= AsAtDate then begin
                        //Send SMS and Update next SMS Date
                        CASE NoOfDaysInArrears OF

                            0 .. 49:
                                BEGIN
                                    //Update next alert with number of days
                                    //in the next 30 - DaysInArrears this member will need an SMS For first alert
                                    SMSAlertsManager."CRB Alert Date" := CalcDate(Format(50 - NoOfDaysInArrears) + 'D', AsAtDate);
                                    SMSAlertsManager."CRB Candidate" := false;
                                    SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                    SMSAlertsManager.Modify();

                                END;
                            50 .. 99:
                                BEGIN
                                    //First Alert
                                    //In the next 60 - DaysInArrears this member will need an SMS FOR second alert
                                    sms := 'Dear ' + FirstName + ', we have not received your ' + Loans."Loan Product Type Name" + '-' + LoanNumber + ' from ' + Format(Loans."Last Repayment Date") +
                                    ' The expected repayment rate is KES ' + Format(Loans.Repayment) + '. Kindly plan to repay before we list you in CRB. For more info call 0710600999. Kenpipe SACCO';
                                    SendSMS.SendSms(Source::DMU, PhoneNumber, sms, Format(FirstName), '', true, Priority, false, 'CBS', LoanNumber, 'CBS');

                                    SMSAlertsManager."CRB Alert Date" := CalcDate(Format(100 - NoOfDaysInArrears) + 'D', AsAtDate);
                                    SMSAlertsManager."CRB Candidate" := false;
                                    SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                    SMSAlertsManager.Modify();

                                end;
                            ELSE BEGIN
                                //List for Recovery
                                SMSAlertsManager."Days In Default" := NoOfDaysInArrears;
                                SMSAlertsManager."CRB Candidate" := true;
                                SMSAlertsManager.Modify();

                            END;
                        END;
                    end;
                end;

            end;
        end;
    end;


    procedure SendArrersSMS(Loans: Record Loans; SMSTemplates: Record "DMU SMS Templates"; NoOfDaysInArrears: Decimal; AsAtDate: Date; DefaulterLoan: Boolean)
    var
        SMSAlertsManager: Record "SMS Alerts Manager";
        NormalSMSDate: Date;
        CRBSMSDate: Date;
        GuarantorSMSDate: Date;
        sms: Text;
        TotalLoanBalance: Decimal;
        LoanGuarantors: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        GuarantorName: Text;
        PhoneNumber: Text;
        Members: Record Members;
        Source: Enum "SMS Source";
        Priority: Integer;
        SecurityRegister: Record "Securities Register";
        LoanRecHeader: Record "Loan Recovery Header";
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;


        ReceipientsName: Text;
        LoanDescription: Text;
        AmountInArrears: Decimal;
        TotalBal: Decimal;
        OutBal: Decimal;
        OutInt: Decimal;
        Prorata: Decimal;

    begin
        //Intervals and days in arrears
        Priority := 250;
        if not SMSAlertsManager.Get(Loans."Loan No.") then begin
            SMSAlertsManager.Init();
            SMSAlertsManager."Loan Number" := Loans."Loan No.";
            SMSAlertsManager."Last Alert Date" := CalcDate('-' + Format(SMSTemplates."SMS Days Intervals") + 'D', AsAtDate);
            SMSAlertsManager.Insert();
        end;

        Loans.CalcFields("Days In Arrears", "Amount In Arreas SACCO");
        if NoOfDaysInArrears = 0 then
            NoOfDaysInArrears := Loans."Days In Arrears";

        if (AsAtDate >= CalcDate(Format(SMSTemplates."SMS Days Intervals") + 'D', SMSAlertsManager."Last Alert Date"))
        and (Loans."Days In Arrears" >= SMSTemplates."Days in Arrears") then begin
            if Members.Get(Loans."Member No.") then begin

                PhoneNumber := Members."Phone No.";

                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Last Repayment Date", "Amount In Arreas SACCO");

                TotalLoanBalance := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                if StrPos(Loans."Member Name", ' ') > 0 then
                    ReceipientsName := CopyStr(Loans."Member Name", 1, StrPos(Loans."Member Name", ' ') - 1)
                else
                    ReceipientsName := Loans."Member Name" + ' ';
                LoanDescription := Loans."Loan Product Type Name";

                LoanRecHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                AmountInArrears := Loans."Amount In Arreas SACCO";

                TotalBal := Round(TotalBal, 0.01, '<');

                if AmountInArrears = 0 then
                    AmountInArrears := Round(Loans."Amount In Arreas SACCO", 0.01, '<');

                Prorata := CustomCuesCodeunit.Prorata(Loans."Member No.", '1');

                sms := StrSubstNo(SMSTemplates."Text SMS", ReceipientsName, LoanDescription, AmountInArrears, TotalBal,
                                ReceipientsName, Loans."Loan No.", Loans.Repayment, Loans."Expected Date of Completion", Loans."Loan No.",
                                OutBal, OutInt, AmountInArrears, Loans."Disbursement Date", Prorata);

                SendSMS.SendSms(Source::MBANKING, PhoneNumber, sms, Format(Loans."Loan No."), '', true, Priority, false, 'CBS', Loans."Loan No.", 'CBS');
            end;
        end;

        SMSAlertsManager."Last Alert Date" := AsAtDate;
        SMSAlertsManager.Modify();
    end;


    [TryFunction]
    procedure GenerateSchedule(LoansR: Record Loans; RecreateSchedule: boolean)
    var
        RSchedule: Record "Ideal Repayment Schedule";
        RSchedules: Record "Ideal Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        RepaymentDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GeneralSetUp: Record "General Set-Up";
        CreateSchedule: Boolean;
        Dateformula: DateFormula;
        NewDepoCont: Decimal;
        PeriodInterest: Decimal;
    begin
        if RecreateSchedule then begin
            RSchedule.Reset();
            RSchedule.SetRange("Loan No.", LoansR."Loan No.");
            if RSchedule.Find('-') then
                RSchedule.DeleteAll();
        end;

        RunDate := 0D;
        QCounter := 0;
        QCounter := 3;

        GeneralSetUp.Get;

        CreateSchedule := true;
        //or (LoansR.Interest = 0)
        if (LoansR."Disbursement Date" = 0D) or (LoansR.Installments = 0) then
            CreateSchedule := false;
        if CreateSchedule then begin
            if Prodfac.Get(LoansR."Loan Product Type") then begin
                LoanAmount := LoansR."Approved Amount";
                if (LoansR."Loan Rescheduled") and (LoansR."New Interest Rate" <> 0) then begin
                    InterestRate := LoansR."New Interest Rate";
                end else
                    InterestRate := LoansR.Interest;

                LoanAmount := LoansR."Approved Amount";
                LBalance := LoansR."Approved Amount";
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments;

                if Prodfac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::"Emergency Loan" then begin
                    if prodFac."Compute Interest Due on Postin" = Prodfac."Compute Interest Due on Postin"::"Full Period Interest" then begin
                        LoanAmount := LoansR."Approved Amount" + round((LoansR."Approved Amount" * LoansR.Interest / 12 * 0.01 * LoansR.Installments), 1, '>');
                        LBalance := LoansR."Approved Amount";
                    end;
                end;
                if LoansR."Grace Period" <> Dateformula then begin
                    // Apply grace period
                    RunDate := CalcDate(Format(LoansR."Grace Period"), LoansR."Disbursement Date");
                    // Apply repayment start date logic based on loan application date
                    if Date2DMY(RunDate, 1) <= 10 then
                        RunDate := CalcDate('CM', LoansR."Disbursement Date") // End of current month
                    else
                        RunDate := CalcDate('CM+1M', LoansR."Disbursement Date"); // End of following month

                end else begin
                    // No grace period, apply repayment start date logic
                    if Date2DMY(LoansR."Disbursement Date", 1) <= 10 then
                        RunDate := CalcDate('CM', LoansR."Disbursement Date") // End of current month
                    else
                        RunDate := CalcDate('CM+1M', LoansR."Disbursement Date"); // End of following month
                end;

                InstalNo := 0;
                repeat
                    InstalNo := InstalNo + 1;
                    if (Prodfac."Interest Recovered Upfront") or (ProdFac."Compute Interest Due on Postin" = ProdFac."Compute Interest Due on Postin"::"Full Period Interest") or (LoansR.Interest = 0) or (ProdFac."Interest Rate (Max.)" = 0) then begin
                        LInterest := 0;
                        LPrincipal := TotalMRepay - LInterest;
                    end
                    else begin
                        if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::Amortised then begin
                            TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        end else
                            if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Straight Line" then begin
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := (InterestRate / 12 / 100) * LoanAmount;
                            end else
                                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Balance" then begin
                                    LPrincipal := LoanAmount / RepayPeriod;
                                    LInterest := (InterestRate / 12 / 100) * LBalance;
                                end else
                                    if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Flat" then begin
                                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                                        LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                                    end else begin
                                        LPrincipal := LoanAmount / RepayPeriod;
                                        LInterest := (InterestRate / 12 / 100) * LoanAmount;
                                    end;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;
                    end;
                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;

                    Evaluate(RepayCode, Format(InstalNo));

                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Ideal Loan Bal" := LBalance;

                    RSchedule."Loan No." := LoansR."Loan No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Member No." := LoansR."Member No.";
                    RSchedule."Loan Category" := LoansR."Loan Product Type";
                    RSchedule.Insert;

                    // Repayment Frequency
                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M+CM', RunDate)
                            else
                                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate)
                                else
                                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::"Bi-Annual" then
                                        RunDate := CalcDate('6M', RunDate)
                                    else
                                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Yearly then
                                            RunDate := CalcDate('1Y', RunDate);

                until LBalance < 1;
            end;
        end;
    end;

    // procedure RescheduleLoanII(LoanRescheduling: Record "Loan Rescheduling")
    // var
    //     Loans: Record Loans;
    //     LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
    //     LastCount: Integer;
    //     InPeriod: DateFormula;
    //     QCounter: Integer;
    //     LoanAmount: Decimal;
    //     InterestRate: Decimal;
    //     RepayPeriod: Integer;
    //     InitialInstal: Integer;
    //     LBalance: Decimal;
    //     RunDate: Date;
    //     InstalNo: Integer;
    //     TotalMRepay: Decimal;
    //     LInterest: Decimal;
    //     LPrincipal: Decimal;
    //     RepayCode: Code[10];
    //     LoanSch: Record Loans;
    //     PaymentMethods: Record "Payment Methods";
    //     PaymentMethodsApplication: Record "Payment Methods Application";
    // begin
    //     //with LoanRescheduling do
    //     begin
    //         if Loans.Get(LoanRescheduling."Loan No.") then begin
    //             //Claer Reamaing Reschedule before creating the new Reschedule
    //             LoanRepaymentSchedule.Reset;
    //             LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
    //             //LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", LoanRescheduling."Rescheduling Date", 99991230D);
    //             if LoanRepaymentSchedule.Find('-') then begin
    //                 LoanRepaymentSchedule.DeleteAll;
    //             end;

    //             //Check last installment NO.

    //             LoanRepaymentSchedule.Reset;
    //             LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
    //             LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Repayment Date", 0D, 99991230D);
    //             if LoanRepaymentSchedule.FindLast then begin
    //                 LastCount := LoanRepaymentSchedule."Instalment No";
    //             end;

    //             // if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
    //             //     Evaluate(InPeriod, '1D')
    //             // else
    //             //     if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
    //             //         Evaluate(InPeriod, '1W')
    //             //     else
    //             //         if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
    //             //             Evaluate(InPeriod, '1M')
    //             //         else
    //             //             if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
    //             //                 Evaluate(InPeriod, '1Q');

    //             QCounter := 0;
    //             QCounter := 3;

    //             LoanRescheduling.TestField(LoanRescheduling."Rescheduling Date");
    //             LoanAmount := LoanRescheduling."Outstanding Balance";
    //             //InterestRate := Loans.Interest;
    //             InterestRate := LoanRescheduling."New Interest Rate";
    //             RepayPeriod := LoanRescheduling."New Installments";
    //             InitialInstal := LoanRescheduling."New Installments";
    //             LBalance := LoanRescheduling."Outstanding Balance";
    //             RunDate := calcdate('<CM>', LoanRescheduling."Rescheduling Date");

    //             InstalNo := LastCount;

    //             repeat
    //                 InstalNo := InstalNo + 1;
    //                 if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
    //                     Loans.TestField(Loans.Interest);
    //                     LoanRescheduling.TestField("New Installments");
    //                     TotalMRepay := ROUND((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
    //                     LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
    //                     LPrincipal := TotalMRepay - LInterest;

    //                     // //Update Reschedule
    //                     // Loans.Repayment := LInterest + LPrincipal;
    //                     // Loans."Loan Principle Repayment" := LPrincipal;
    //                     // Loans."Loan Interest Repayment" := LInterest;

    //                 end;

    //                 if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
    //                     Loans.TestField(Loans.Interest);
    //                     LoanRescheduling.TestField("New Installments");
    //                     LPrincipal := LoanAmount / RepayPeriod;
    //                     LInterest := (InterestRate / 1200) * LoanAmount;

    //                     // //Update Reschedule
    //                     // Loans.Repayment := LPrincipal;
    //                     // Loans."Loan Principle Repayment" := LPrincipal;
    //                     // Loans."Loan Interest Repayment" := LInterest;

    //                 end;

    //                 if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then begin
    //                     Loans.TestField(Loans.Interest);
    //                     LoanRescheduling.TestField("New Installments");
    //                     LPrincipal := LoanAmount / RepayPeriod;
    //                     LInterest := (InterestRate / 1200) * LBalance;
    //                     //Update Reschedue
    //                     // Loans.Repayment := LPrincipal;
    //                     // Loans."Loan Principle Repayment" := LPrincipal;
    //                     // Loans."Loan Interest Repayment" := LInterest;
    //                 end;

    //                 if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
    //                     Loans.TestField(Loans.Interest);
    //                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
    //                     LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
    //                     Loans.Repayment := LPrincipal + LInterest;
    //                     if LBalance < Loans.Repayment then
    //                         LPrincipal := LBalance
    //                     else
    //                         LPrincipal := Loans.Repayment;
    //                     LInterest := Loans.Interest;

    //                     //Update Reschedule
    //                     // Loans.Repayment := LPrincipal;

    //                 end;
    //                 //Loop the Balance
    //                 LBalance := LBalance - LPrincipal;

    //                 Evaluate(RepayCode, Format(InstalNo));

    //                 LoanRepaymentSchedule.Init;
    //                 LoanRepaymentSchedule."Repayment Code" := RepayCode;
    //                 LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
    //                 LoanRepaymentSchedule."Loan Amount" := LoanRescheduling."Outstanding Balance";
    //                 LoanRepaymentSchedule."Instalment No" := RepayPeriod;
    //                 LoanRepaymentSchedule."Repayment Date" := RunDate;
    //                 LoanRepaymentSchedule."Member No." := LoanRescheduling."Member No.";
    //                 LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
    //                 LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal;
    //                 LoanRepaymentSchedule."Ideal Loan Bal" := LBalance;
    //                 LoanRepaymentSchedule."Monthly Interest" := LInterest;
    //                 LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
    //                 LoanRepaymentSchedule."Reset Doc No." := LoanRescheduling."No.";
    //                 LoanRepaymentSchedule."Reset Schedule" := true;
    //                 LoanRepaymentSchedule.Insert;

    //                 // Repayment Frequency
    //                 //Repayment Frequency
    //                 if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
    //                     RunDate := CalcDate('1D', RunDate)
    //                 else
    //                     if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
    //                         RunDate := calcdate('<CW>', (CalcDate('1W', RunDate)))
    //                     else
    //                         if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
    //                             RunDate := calcdate('<CM>', (CalcDate('1M', RunDate)))
    //                         else
    //                             if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
    //                                 RunDate := calcdate('<CM>', (CalcDate('1Q', RunDate)));
    //             until LBalance < 1;
    //         end;
    //     end;
    // end;

    procedure GenerateActualSchedule(Loans: Record Loans)
    var
        //Tables
        LoanSchedule: Record "Ideal Repayment Schedule";
        CreditLedger: Record "Credit Ledger Entry";

        //Varibales
        LastPaymentDate: Date;
        i: Integer;
        PrRepaymentAmount: Decimal;
        IntRepaymentAmount: Decimal;
        TotalPrRepayment: Decimal;
        IdealLoanBal: Decimal;

        ExpectedRepayments: Decimal;

        ListOfDates: list of [Date];
        UntouchedMonths: list of [Decimal];
        UntouchedMonthsCount: Integer;

        RepaymentDates: list of [Date];

    begin
        //Determine Last Payment Date
        CreditLedger.Reset();
        CreditLedger.SetFilter("Transaction Type", '%1|%2', CreditLedger."Transaction Type"::Repayment, CreditLedger."Transaction Type"::Loan);
        CreditLedger.SetRange(Reversed, false);
        CreditLedger.SetRange("Loan No", Loans."Loan No.");
        if CreditLedger.FindLast() then
            LastPaymentDate := CreditLedger."Posting Date";

        LoanSchedule.Reset();
        LoanSchedule.SetRange("Loan No.", Loans."Loan No.");
        if LoanSchedule.Find('-') then begin
            repeat

                // if LastPaymentDate <= LoanSchedule."Repayment Date" then begin
                ExpectedRepayments += LoanSchedule."Principal Repayment";
                ListOfDates.Add(CalcDate('1D', LoanSchedule."Repayment Date"));

                PrRepaymentAmount := 0;
                IntRepaymentAmount := 0;

                i += 1;
                CreditLedger.Reset();
                CreditLedger.SetFilter("Transaction Type", '%1|%2', CreditLedger."Transaction Type"::Repayment, CreditLedger."Transaction Type"::"Interest Due");
                CreditLedger.SetRange(Reversed, false);
                CreditLedger.SetRange("Loan No", Loans."Loan No.");
                if i = 1 then
                    CreditLedger.SetFilter("Posting Date", '<=%1', LoanSchedule."Repayment Date")
                else
                    CreditLedger.SetRange("Posting Date", ListOfDates.Get(i - 1), LoanSchedule."Repayment Date");
                if CreditLedger.Find('-') then begin
                    repeat
                        if CreditLedger."Transaction Type" = CreditLedger."Transaction Type"::Repayment then begin
                            PrRepaymentAmount += Abs(CreditLedger.Amount);
                            TotalPrRepayment += Abs(CreditLedger.Amount);
                        end;
                        if CreditLedger."Transaction Type" = CreditLedger."Transaction Type"::"Interest Due" then begin
                            IntRepaymentAmount += Abs(CreditLedger.Amount);
                        end;
                    until CreditLedger.Next() = 0;
                end;

                if i = 1 then
                    IdealLoanBal := Loans."Approved Amount" - LoanSchedule."Principal Repayment"
                else
                    IdealLoanBal -= LoanSchedule."Principal Repayment";

                LoanSchedule."Actual Pr Repayment" := PrRepaymentAmount;
                LoanSchedule."Actual Int Repayment" := IntRepaymentAmount;
                LoanSchedule."Actual Loan Bal" := Loans."Approved Amount" - TotalPrRepayment;
                LoanSchedule."Ideal Loan Bal" := IdealLoanBal;
                LoanSchedule.Modify();
            // end;

            //  else begin
            //     //Save Normal Shedule Repayments
            //     UntouchedMonths.Add(LoanSchedule."Principal Repayment");
            // end;

            // //Futuristic Schedule
            // if Today <= LoanSchedule."Repayment Date" then begin
            //     UntouchedMonthsCount += 1;
            //     if UntouchedMonthsCount <= UntouchedMonths.Count then
            //         LoanSchedule."Actual Pr Repayment" := UntouchedMonths.Get(UntouchedMonthsCount);
            //     LoanSchedule."Actual Loan Bal" -= LoanSchedule."Actual Pr Repayment";
            //     LoanSchedule.Modify();
            //     // LoanSchedule."Actual Int Repayment" := IntRepaymentAmount;
            // end;

            until LoanSchedule.Next() = 0;
        end;
    end;



    procedure SubmitHRLoans(Hrloans: Record "Self Loan Application") StaffLoanNo: Code[20]
    var
        ProductFactory: Record "Product Factory";
        NewLoans: Record Loans;
        Credit: Record "Credit Accounts";
        Members: Record Members;
        LoanAccountNo: Code[20];
    begin
        if Hrloans."Requested Amount" <= 0 then
            Error('Requested amount should be greater than zero.');
        Members.Get(Hrloans."Member No.");
        ProductFactory.Reset;
        ProductFactory.SetRange("Product ID", Hrloans."Loan Type");
        if ProductFactory.Find('-') then begin
            if Credit.Get(ProductFactory."Account No. Prefix" + Hrloans."Member No." + ProductFactory."Account No. Suffix") then
                LoanAccountNo := ProductFactory."Account No. Prefix" + Hrloans."Member No." + ProductFactory."Account No. Suffix"
            else
                LoanAccountNo := CreateLoanAccount(Hrloans."Member No.", ProductFactory."Product ID");

            NewLoans.Reset;
            NewLoans.SetRange(NewLoans."Member No.", Hrloans."Member No.");
            NewLoans.SetRange(NewLoans."Loan Product Type", ProductFactory."Product ID");
            NewLoans.SetFilter(Status, '%1|%2|%3', NewLoans.Status::Open, NewLoans.Status::approved, NewLoans.Status::Pending);
            NewLoans.SetRange(NewLoans.Posted, false);
            if NewLoans.Find('-') then begin
                error('This member has an existing loan being processed. Loan No. %1:', NewLoans."Loan No.");
            end Else begin
                NewLoans.Init;
                NewLoans."Loan No." := '';
                NewLoans."Member No." := Hrloans."Member No.";
                NewLoans."ID No." := Hrloans."ID No";
                NewLoans."Member Name" := Members.Name;
                NewLoans."CRM Application No." := Hrloans."Application Code";
                NewLoans."Staff No" := Members."Payroll/Staff No.";
                NewLoans."Employer Code" := Members."Employer Code";
                NewLoans."Application Date" := Today;
                NewLoans."Member Deposits" := Hrloans."Member Deposits";
                NewLoans."Loan Product Type" := ProductFactory."Product ID";
                NewLoans."Loan Product Type Name" := ProductFactory."Product Description";
                NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
                NewLoans.Interest := ProductFactory."Interest Rate (Min.)";
                NewLoans."Grace Period" := ProductFactory."Grace Period - Interest";
                NewLoans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
                NewLoans."Loan Span" := ProductFactory."Loan Span";
                NewLoans."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
                NewLoans."Repayment Frequency" := ProductFactory."Repayment Frequency";
                NewLoans."Recovery Mode" := ProductFactory."Repay Mode";
                NewLoans."Appraisal Parameter Type" := ProductFactory."Appraisal Parameter Type";
                NewLoans."Recovery Priority" := ProductFactory."Recovery Priority";
                NewLoans."Requested Amount" := Hrloans."Requested Amount";
                NewLoans."Main Sector" := Hrloans."Main Sector";
                NewLoans."Main Sector Description" := Hrloans."Main Sector Description";
                NewLoans."Sub Sector Level1" := Hrloans."Sub Sector Level1";
                NewLoans."Sub Sector Level1 Description" := Hrloans."Sub Sector Level1 Description";
                NewLoans."Sub Sector Level2" := Hrloans."Sub Sector Level2";
                NewLoans."Sub Sector Level2 Description" := Hrloans."Sub Sector Level2 Description";
                NewLoans."Date of join" := Hrloans."Date Of Join";
                NewLoans."Date of retirement" := Hrloans."Retirement Date";
                NewLoans.Installments := ProductFactory."Ordinary Default Intallments";
                NewLoans."Approved Amount" := Hrloans."Requested Amount";
                NewLoans.VALIDATE(NewLoans."Approved Amount");
                NewLoans.VALIDATE("Member No.");
                NewLoans.Status := NewLoans.Status::Open;
                NewLoans."Disbursement Date" := Today;
                NewLoans."Purpose of Loan" := Hrloans."Purpose of Loan";
                NewLoans."Repayment Start Date" := Today;
                NewLoans."Loan Account" := LoanAccountNo;
                NewLoans.Advice := true;
                NewLoans."Source Unit" := NewLoans."Source Unit"::"HR LOANS";
                NewLoans."Advice Type" := NewLoans."advice type"::"Fresh Loan";
                NewLoans.Insert(true);

                StaffLoanNo := NewLoans."Loan No.";
                Message('Application Submitted Sucessfully and Loan No. %1 Created.', NewLoans."Loan No.");
            end;

        end;
    end;

    procedure GetTotalMemberLoanBalancePerUnit(MemberNo: Code[20]; SourceUnit: Integer; AsAt: Date) TotalLoanBalancePerUnit: Decimal
    var
        Loan: Record Loans;
    begin
        TotalLoanBalancePerUnit := 0;
        Loan.Reset();
        Loan.SetRange("Member No.", MemberNo);
        Loan.SetRange("Source Unit", SourceUnit);
        Loan.SetFilter("Date Filter", '..%1', AsAt);
        Loan.SetAutoCalcFields("Total Balance");
        Loan.SetFilter("Total Balance", '>0');
        if Loan.FindSet() then
            repeat
                TotalLoanBalancePerUnit += Loan."Total Balance";
            until Loan.Next() = 0;
    end;

    procedure GetTotalMemberLoanBalance(MemberNo: Code[20]; AsAt: Date) TotalLoanBalance: Decimal
    var
        Loan: Record Loans;
    begin
        TotalLoanBalance := 0;
        Loan.Reset();
        Loan.SetRange("Member No.", MemberNo);
        Loan.SetFilter("Date Filter", '..%1', AsAt);
        Loan.SetAutoCalcFields("Total Balance");
        Loan.SetFilter("Total Balance", '>0');
        Loan.SetAutoCalcFields("Total Balance");
        loan.setloadfields("Total Balance");
        if Loan.FindSet() then
            repeat
                TotalLoanBalance += Loan."Total Balance";
            until Loan.Next() = 0;
    end;

    procedure ComputeDividendsDiscounting(MemberNo: code[20]; ProductType: code[20]; SendText: Boolean) Qualification: Decimal
    var
        DivloanBal: decimal;
        DivDiscRem: Decimal;
        LNRec: record Loans;
        Members: Record Members;
        DivSetup: Record "Dividend SetUp";
        DividendProgression: Record "Dividend Progression";
        ProdFac: record "Product Factory";
        SavAcc: record "Savings Accounts";
        MemberClosure: Record "Membership Closure";
        SMSSource: enum "SMS Source";
    begin
        DivloanBal := 0;
        DivDiscRem := 0;

        if not ProdFac.get(ProductType) then begin
            exit(Qualification);
        end;
        if not DivSetup.GET then begin
            exit(Qualification);
        end;
        if not Members.Get(MemberNo) then begin
            exit(Qualification);
        end
        else begin
            if Members."Block Div Advance" = true then
                exit(Qualification);

            if Members."Rejoinig Date" <> 0D then begin
                if Date2DMY(Members."Rejoinig Date", 3) = Date2DMY(Today, 3) then begin
                    MemberClosure.Reset;
                    MemberClosure.Setrange("Member No.", Members."No.");
                    MemberClosure.Setrange(Posted, true);
                    if MemberClosure.findfirst() then begin
                        if SendText then begin
                            msg := 'Dear ' + Members."First Name" + ', you withdrew from the SACCO on ' + format(MemberClosure."Closing Date") + ' and rejoined the SACCO on date ' + format(Members."Rejoinig Date") + '. You therefore do not qualify for Dividends Advance Loan.';

                            SendSMS.SendSms(SMSSource::MBANKING, Members."Phone No.", msg, Format(Members."No."), '', true, 220, false, 'CBS', Members."No.", 'CBS');
                        end;
                        // Message('You withdrew from the SACCO on %1 and rejoined the SACCO on date %2. You therefore do not qualify for Dividends Advance Loan.', MemberClosure."Closing Date", Members."Rejoinig Date");
                    end;
                    exit(Qualification);
                end;
            end;

            if Members."Closure Date" <> 0D then begin
                if (Date2DMY(Members."Closure Date", 3) = Date2DMY(Today, 3)) OR ((Date2DMY(Members."Closure Date", 3)) = (Date2DMY(Members."Closure Date", 3) - 1))
                then begin
                    if SendText then begin
                        msg := 'Dear ' + Members."First Name" + ', you withdrew from the SACCO on ' + format(MemberClosure."Closing Date") + '. You therefore do not qualify for Dividends Advance Loan.';

                        SendSMS.SendSms(SMSSource::MBANKING, Members."Phone No.", msg, Format(Members."No."), '', true, 220, false, 'CBS', Members."No.", 'CBS');
                    end;
                    exit(Qualification);
                end;
            end;
        end;



        //Check if member has withdrawn any part of deposits
        DividendProgression.RESET;
        DividendProgression.SETRANGE("Member No", Members."No.");
        DividendProgression.SETRANGE("End Date", DivSetup."Discounting Start Date", DivSetup."Discounting End Date");
        DividendProgression.SetCurrentKey("Qualifying Shares");
        DividendProgression.SetAscending("Qualifying Shares", false);
        DividendProgression.setrange("Product Type", '1');
        if DividendProgression.FindFirst() then begin
            SavAcc.reset;
            SavAcc.setrange("Product Type", '1');
            SavAcc.setrange("Member No.", MemberNo);
            if SavAcc.FindFirst() then begin
                SavAcc.CalcFields("Balance (LCY)");
                if (DividendProgression."Qualifying Shares" > SavAcc."Balance (LCY)") or (SavAcc."Balance (LCY)" = 0) then begin
                    if SendText then begin
                        msg := 'Dear ' + Members."First Name" + ', your current depoists ' + format(SavAcc."Balance (LCY)") + ' are less than end year deposit contribution  ' + format(DividendProgression."Qualifying Shares") + '. You therefore do not qualify for Dividends Advance Loan.';

                        SendSMS.SendSms(SMSSource::MBANKING, Members."Phone No.", msg, Format(Members."No."), '', true, 220, false, 'CBS', Members."No.", 'CBS');
                    end;
                    exit(Qualification);
                end;

            end;
        end;

        LNRec.RESET;
        LNRec.SETRANGE(LNRec."Member No.", Members."No.");
        LNRec.Setfilter(LNRec."Recovery Mode", '=%1', LNRec."Recovery Mode"::Dividend);
        // LNRec.SetFilter(LNRec."Loan Product Type", '<>%1|<>%2', 'BGL', 'FGL');
        LNRec.SETFILTER(LNRec."Outstanding Balance", '>0');

        LNRec.SetLoadFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
        LNRec.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
        IF LNRec.FINDSET THEN BEGIN
            REPEAT
                DivloanBal := DivloanBal + (LNRec."Outstanding Balance");// + LNRec."Outstanding Interest" + LNRec."Daily Interest");
            UNTIL LNRec.NEXT = 0;
        END;


        DividendProgression.RESET;
        DividendProgression.SETRANGE("Member No", Members."No.");
        DividendProgression.SETRANGE("End Date", DivSetup."Discounting Start Date", DivSetup."Discounting End Date");
        // DividendProgression.CALCSUMS("Gross Dividends", "Net Dividends");
        DividendProgression.CALCSUMS("Net Dividends");
        if Members."Div Advance %" > 0 then begin
            DivDiscRem := (Members."Div Advance %" / 100 * DividendProgression."Net Dividends") - DivloanBal;
        end
        else
            DivDiscRem := (ProdFac."Discounting %" / 100 * DividendProgression."Net Dividends") - DivloanBal;

        if DivDiscRem < 0 then DivDiscRem := 0;
        exit(Round(DivDiscRem, 1, '<'));
    end;

    procedure GetAppraisalDeposits(MemberNo: code[20]; ProductType: code[20]) MemberDepositss: Decimal
    var
        myInt: Integer;
        ProductFactory: Record "Product Factory";
        Otherdeposits: Decimal;
        OtherAppraisals: Record "Other Apprails products";
        SavingsAccounts: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        MemberDeposits: Decimal;
        Members: Record Members;
        Mdeposits: decimal;
    begin
        Otherdeposits := 0;
        Mdeposits := 0;
        if Members.get(MemberNo) then begin
            if ProductFactory.Get(ProductType) then begin
                OtherAppraisals.Reset();
                OtherAppraisals.SetRange(OtherAppraisals."Product ID", ProductFactory."Product ID");
                if OtherAppraisals.Find('-') then begin
                    repeat
                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange("Member No.", MemberNo);
                        SavingsAccounts.SetRange("Product Type", OtherAppraisals."Product code");
                        if SavingsAccounts.Find('-') then begin
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            Otherdeposits += SavingsAccounts."Balance (LCY)";
                        end;
                    until OtherAppraisals.Next() = 0;
                end;
                if ProductFactory."Loan Appraisal Account Code" <> '' then begin
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", Members."No.");
                    SavAcc.SetRange(SavAcc."Product Type", ProductFactory."Loan Appraisal Account Code");
                    if SavAcc.find('-') then begin
                        SavAcc.CalcFields(SavAcc."Balance (LCY)");
                        Mdeposits := SavAcc."Balance (LCY)";
                    end;
                end;
                MemberDeposits := Mdeposits + Otherdeposits;
            end;
        end;

        exit(MemberDeposits);
    end;

    // procedure LoanBulkClearence(MemberNo: code[20])
    // var
    //     myInt: Integer;
    //     BLoans: Record loans;
    //     BCreditLed: Record "Credit Ledger Entry";
    //     generalSetup: Record "General Set-Up";
    // begin
    //     generalSetup.Get();
    //     BLoans.reset;
    //     BLoans.setrange("Member No.", MemberNo);
    //     BLoans.SetRange(Posted, true);
    //     if BLoans.find('-') then begin
    //         repeat
    //             BCreditLed.RESET;
    //             BCreditLed.SetRange("Loan No", BLoans."Loan No.");
    //             BCreditLed.SETRANGE("Transaction Type", BCreditLed."Transaction Type"::Repayment);
    //             if Format(generalSetup."Boosting Maturity") = '' then
    //                 BCreditLed.SetRange("Posting Date", CalcDate('-1M', Today), Today) else
    //                 BCreditLed.SetRange("Posting Date", CalcDate(('-' + format(generalSetup."Boosting Maturity")), Today), Today);
    //             BCreditLed.SetRange(Reversed, false);
    //             IF BCreditLed.FIND('-') then begin
    //                 if BLoans."Loan Principle Repayment" <= 0 then
    //                     BLoans."Loan Principle Repayment" := BLoans.Repayment;
    //                 if (Abs(BCreditLed.Amount)) > BLoans."Loan Principle Repayment" then begin
    //                     Message('This member made a bulk payment of %1 against normal repayment of %2 on %3 to loan No %4.', (Abs(BCreditLed.Amount)), BLoans."Loan Principle Repayment", BCreditLed."Posting Date", BCreditLed."Loan No");
    //                 end;
    //             end;

    //         until BLoans.next = 0;
    //     end;

    // end;

}
