#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185467 DVII
{

    trigger OnRun()
    begin
    end;

    var
        GeneralSetUp: Record "General Set-Up";
        DividendSetUp: Record "Dividend SetUp";
        Defaulter: Boolean;
        LoanApps: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        SavingsAccountNo: Code[20];
        SavingsProductID: Code[20];
        SavingsProductName: Text;
        RunBal: Decimal;
        DividendProgression: Record "Dividend Progression";
        CAmount: Decimal;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        TieredChargesLines: Record "Tiered Charges Lines";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        EntrNo: Integer;
        Temp: Record "Banking User Template";
        GenJLine: Record "Gen. Journal Line";
        AccType: Enum "Gen. Journal Account Type";
        PostingJnl: Codeunit "Journal Posting";
        TransactionTypes: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills;
        TopupShares: label 'Topup Share Capital :-';
        DividendEarned: label 'Dividend Earned :-';
        DividendDeductions: label 'Dividend Deductions :-';
        LoanInterest: label 'Loan Interest :-';
        LoanBills: label 'Loan Bill :-';
        LoanPrincipal: label 'Loan Principal :-';
        TransactionCharge: label 'Transaction Charge :-';
        ExciseDuty: label 'Excise Duty :-';
        GeneratepostLines: label 'Create Posting Lines :';
        MessageTxt: label 'Successfully processed.';
        Jtemplate: Code[10];
        JBatch: Code[10];
        DividendPostingBuffer: Record "Dividend Posting Buffer";
        ProductFactory: Record "Product Factory";
        Year: Integer;
        PreviousYear: Integer;
        Transactions: Record "Transaction Types";
        LineNo: Integer;
        JournalPosting: Codeunit "Journal Posting";
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        Amt: Decimal;
        BalAccNo: Code[20];

    local procedure MyProcedure()
    var
        myInt: Integer;
    begin

    end;

    local procedure FormatName(MName: Text): Text
    var
        I: Integer;
    begin
        FOR I := 1 TO STRLEN(MName) DO BEGIN
            IF I = 1 THEN
                EVALUATE(MName[I], UPPERCASE(FORMAT(MName[I])))
            ELSE
                EVALUATE(MName[I], LOWERCASE(FORMAT(MName[I])));
        END;
        EXIT(MName);
    end;

    procedure PostDiv(CustMembrNo: Code[20]; SendTEXT: Boolean)
    var
        CustMembr: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        SendSms: Codeunit SendSms;
        SourceType: enum "SMS Source";
        CompInfo: Record "Company Information";
        NetAmount: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        DividendPostingBuffer2: Record "Dividend Posting Buffer";
        DividendPostingBufferII: Record "Dividend Posting Buffer";
        CreditAccounts: Record "Credit Accounts";
        Loans: Record Loans;
        DividendAccountNo: Code[20];
        Div_DocumentNo: Code[20];
        MyDivs: Decimal;
        MemberName: Code[20];
        CapitaliazeAcc: Code[20];
        SavingsAcc: Record "Savings Accounts";
        // MobileBanking: Codeunit MobileBanking;
        PostingDate: Date;
        AmountRecovered: Decimal;
        DepoAmountPaid: Decimal;
        LoanRecoveryHeader: Record "Loan Recovery Header";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        SMSTrailer: Text[250];
        IsModified: Boolean;
        sendsmsvalue: Boolean;
    begin
        DividendSetUp.GET;
        DividendAccountNo := '';

        Temp.GET(USERID);
        Temp.TESTFIELD("Cashier Journal Template");
        Temp.TESTFIELD("Cashier Journal Batch");
        JBatch := Temp."Cashier Journal Batch";
        Jtemplate := Temp."Cashier Journal Template";

        GenJLine.SETRANGE("Journal Batch Name", JBatch);
        GenJLine.SETRANGE("Journal Template Name", Jtemplate);
        IF GenJLine.FINDLAST THEN
            EntrNo := GenJLine."Line No.";

        Div_DocumentNo := 'DIV-' + FORMAT(Date2DMY(DividendSetUp."End Date", 3));


        //MESSAGE('%1 and %2',Temp."Cashier Journal Batch",Temp."Cashier Journal Template");
        //EntrNo:=100;
        //**WITH CustMembr DO BEGIN
        MyDivs := 0;
        MemberName := '';
        CustMembr.SetCurrentKey("No.");
        CustMembr.SetRange("No.", CustMembrNo);
        CustMembr.SetLoadFields("Account Category", "No.", "First Name", "Global Dimension 1 Code", "Global Dimension 2 Code", Name, "Account Type", "Phone No.");
        IF CustMembr.FindFirst THEN BEGIN
            //Member Name
            IF CustMembr."Account Category" = CustMembr."Account Category"::Member THEN BEGIN
                MemberName := CustMembr."First Name";
                MemberName := FormatName(MemberName);
            END ELSE
                MemberName := 'Member';

            //**REPEAT
            DividendProgression.RESET;
            DividendProgression.SETRANGE("Member No", CustMembr."No.");
            //DividendProgression.SETRANGE("Processing Date", (CALCDATE('-CY', TODAY)), (CALCDATE('CY', TODAY)));
            DividendProgression.SetRange(Year, Date2DMY(DividendSetUp."End Date", 3));
            DividendProgression.CALCSUMS("Net Dividends");
            MyDivs := DividendProgression."Net Dividends";

            GlobalDim1 := CustMembr."Global Dimension 1 Code";
            GlobalDim2 := CustMembr."Global Dimension 2 Code";
            RunBal := 0;

            //++++++++++++++++++++Geting Savings Accounts
            SavingsAccounts.SetCurrentKey("Member No.", "Loan Disbursement Account");
            SavingsAccounts.SetRange("Member No.", CustMembr."No.");
            SavingsAccounts.SetRange("Loan Disbursement Account", true);
            SavingsAccounts.SetLoadFields("No.", "Product Type", "Product Name");

            IF SavingsAccounts.FindFirst THEN BEGIN
                SavingsAccountNo := SavingsAccounts."No.";
                SavingsProductID := SavingsAccounts."Product Type";
                SavingsProductName := SavingsAccounts."Product Name";
            END;

            //++++++++++++++++++++
            SavingsAcc.SetCurrentKey("Member No.", "Product Category");
            SavingsAcc.SetRange("Member No.", CustMembr."No.");
            SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
            SavingsAcc.SetLoadFields("No.");

            IF SavingsAcc.FindFirst THEN BEGIN
                CapitaliazeAcc := SavingsAcc."No.";
            END;

            //++++++++++++++++++++++++++++++++++++Posting Enteries From buffer
            //   Block_UnBlock(CustMembrNo,1);

            DividendPostingBuffer.SetCurrentKey("Member No.", Posted);
            DividendPostingBuffer.SetRange("Member No.", CustMembr."No.");
            DividendPostingBuffer.SetRange(Posted, false);
            IF DividendPostingBuffer.FindSet THEN BEGIN
                REPEAT
                    IF DividendPostingBuffer."Account Type" = DividendPostingBuffer."Account Type"::Savings THEN BEGIN
                        if SavingsAcc.get(DividendPostingBuffer."Account No.") then begin
                            if SavingsAcc.Blocked <> SavingsAcc.Blocked::" " then begin
                                SavingsAcc.Blocked := SavingsAcc.Blocked::" ";
                                SavingsAcc.Modify();
                            end;
                            EntrNo += 1;
                            GenJLine.INIT;
                            GenJLine."Line No." := EntrNo;
                            GenJLine."Journal Template Name" := Jtemplate;
                            GenJLine."Journal Batch Name" := JBatch;
                            GenJLine."Posting Date" := TODAY;
                            GenJLine."Document No." := Div_DocumentNo;
                            GenJLine."Account Type" := DividendPostingBuffer."Account Type";
                            GenJLine.VALIDATE(GenJLine."Account No.", DividendPostingBuffer."Account No.");
                            GenJLine.Description := PADSTR(DividendPostingBuffer.Description + CustMembr."No." + '-' + CustMembr.Name, 50);
                            GenJLine."Member No." := CustMembr."No.";
                            GenJLine.VALIDATE(GenJLine.Amount, DividendPostingBuffer.Amount);
                            GenJLine."Transaction Type" := DividendPostingBuffer."Transaction Type";
                            GenJLine."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type";
                            GenJLine.VALIDATE("Bal. Account No.", DividendPostingBuffer."Bal. Account No.");
                            GenJLine.VALIDATE(GenJLine."Loan No", DividendPostingBuffer."Loan No");
                            GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                            GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                            IF GenJLine.Amount <> 0 THEN
                                GenJLine.INSERT;

                            DividendAccountNo := DividendPostingBuffer."Account No.";

                        end;

                        //TYPE CREDIT
                    END

                    ELSE
                        IF (DividendPostingBuffer."Account Type" = DividendPostingBuffer."Account Type"::Credit) AND
                     (DividendPostingBuffer."Transaction Type" <> DividendPostingBuffer."Transaction Type"::Bills) THEN BEGIN//End of Saving Accounts
                            LoanApps.SetCurrentKey("Loan No.");
                            LoanApps.SetRange("Loan No.", DividendPostingBuffer."Loan No");
                            LoanApps.SetLoadFields("Loan No.", "Outstanding Balance", "Outstanding Interest");

                            IF LoanApps.FindFirst THEN BEGIN

                                if CreditAccounts.get(LoanApps."Loan Account") then
                                    if CreditAccounts.Blocked <> CreditAccounts.Blocked::" " then begin
                                        CreditAccounts.Blocked := CreditAccounts.Blocked::" ";
                                        CreditAccounts.Modify();
                                    end;

                                RunBal := ABS(DividendPostingBuffer.Amount);
                                LoanApps.CalcFields("Outstanding Balance", "Outstanding Interest");
                                IF LoanApps."Outstanding Interest" > 0 THEN BEGIN
                                    IF DividendPostingBuffer."Transaction Type" = DividendPostingBuffer."Transaction Type"::"Interest Paid"
                                      THEN BEGIN
                                        EntrNo += 1;
                                        GenJLine.INIT;
                                        GenJLine."Line No." := EntrNo;
                                        GenJLine."Journal Template Name" := Jtemplate;
                                        GenJLine."Journal Batch Name" := JBatch;
                                        GenJLine."Posting Date" := TODAY;
                                        GenJLine."Document No." := Div_DocumentNo;
                                        GenJLine."Account Type" := DividendPostingBuffer."Account Type";
                                        GenJLine.VALIDATE(GenJLine."Account No.", DividendPostingBuffer."Account No.");
                                        GenJLine.Description := PADSTR(DividendPostingBuffer.Description + CustMembr."No." + '-' + CustMembr.Name, 50);
                                        GenJLine."Member No." := CustMembr."No.";
                                        IF RunBal > LoanApps."Outstanding Interest" THEN
                                            GenJLine.VALIDATE(GenJLine.Amount, -LoanApps."Outstanding Interest")
                                        ELSE
                                            GenJLine.VALIDATE(GenJLine.Amount, -RunBal);
                                        GenJLine."Transaction Type" := GenJLine."Transaction Type"::"Interest Paid";
                                        GenJLine."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type";
                                        //GenJLine.VALIDATE("Bal. Account No.",DividendPostingBuffer."Bal. Account No.");
                                        //GenJLine.VALIDATE(GenJLine."Loan No",DividendPostingBuffer."Loan No");
                                        GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                        GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                        GenJLine."Loan No" := LoanApps."Loan No.";
                                        IF GenJLine.Amount <> 0 THEN
                                            GenJLine.INSERT;
                                        RunBal -= ABS(GenJLine.Amount);
                                    END;
                                END;

                                IF LoanApps."Outstanding Balance" > 0 THEN BEGIN
                                    IF DividendPostingBuffer."Transaction Type" = DividendPostingBuffer."Transaction Type"::Repayment
                                      THEN BEGIN
                                        //Repayments
                                        EntrNo += 1;
                                        GenJLine.INIT;
                                        GenJLine."Line No." := EntrNo;
                                        GenJLine."Journal Template Name" := Jtemplate;
                                        GenJLine."Journal Batch Name" := JBatch;
                                        GenJLine."Posting Date" := TODAY;
                                        GenJLine."Document No." := Div_DocumentNo;
                                        GenJLine."Account Type" := DividendPostingBuffer."Account Type";
                                        GenJLine.VALIDATE(GenJLine."Account No.", DividendPostingBuffer."Account No.");
                                        GenJLine.Description := PADSTR(DividendPostingBuffer.Description + CustMembr."No." + '-' + CustMembr.Name, 50);
                                        GenJLine."Member No." := CustMembr."No.";
                                        IF RunBal > LoanApps."Outstanding Balance" THEN
                                            GenJLine.VALIDATE(GenJLine.Amount, -LoanApps."Outstanding Balance")
                                        ELSE
                                            GenJLine.VALIDATE(GenJLine.Amount, -RunBal);
                                        GenJLine."Transaction Type" := GenJLine."Transaction Type"::Repayment;
                                        GenJLine."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type";
                                        //GenJLine.VALIDATE("Bal. Account No.",DividendPostingBuffer."Bal. Account No.");
                                        //GenJLine.VALIDATE(GenJLine."Loan No",DividendPostingBuffer."Loan No");
                                        GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                        GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                        GenJLine."Loan No" := DividendPostingBuffer."Loan No";
                                        IF GenJLine.Amount <> 0 THEN
                                            GenJLine.INSERT;

                                        RunBal -= ABS(GenJLine.Amount);
                                    END;
                                END;
                            END;

                            // MESSAGE('The run bal end is %1',RunBal);
                            //Incase loan/arreas are paid before posting

                            IF RunBal > 0 THEN BEGIN
                                EntrNo += 1;
                                GenJLine.INIT;
                                GenJLine."Line No." := EntrNo;
                                GenJLine."Journal Template Name" := Jtemplate;
                                GenJLine."Journal Batch Name" := JBatch;
                                GenJLine."Posting Date" := TODAY;
                                GenJLine."Document No." := Div_DocumentNo;
                                GenJLine."Account Type" := GenJLine."Account Type"::Savings;
                                GenJLine.VALIDATE(GenJLine."Account No.", SavingsAccountNo);
                                GenJLine.Description := PADSTR(DividendPostingBuffer.Description + '-Excess-Loan Recovery' + CustMembr."No." + '-' + CustMembr.Name, 50);
                                GenJLine."Member No." := CustMembr."No.";
                                GenJLine.VALIDATE(GenJLine.Amount, -RunBal);
                                GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                IF GenJLine.Amount <> 0 THEN
                                    GenJLine.INSERT;
                            END;//Excess After loan Clear}
                        END

                        ELSE
                            //              ELSE IF (DividendPostingBuffer."Account Type"<>DividendPostingBuffer."Account Type"::Credit) AND
                            //                      (DividendPostingBuffer."Account Type"<>DividendPostingBuffer."Account Type"::Savings) THEN  
                            //              
                            IF (DividendPostingBuffer."Transaction Type" <> DividendPostingBuffer."Transaction Type"::Bills) THEN BEGIN
                                ;//End of Credits Account
                                EntrNo += 1;
                                GenJLine.INIT;
                                GenJLine."Line No." := EntrNo;
                                GenJLine."Journal Template Name" := Jtemplate;
                                GenJLine."Journal Batch Name" := JBatch;
                                GenJLine."Posting Date" := TODAY;
                                GenJLine."Document No." := Div_DocumentNo;
                                GenJLine."Account Type" := DividendPostingBuffer."Account Type";
                                GenJLine.VALIDATE(GenJLine."Account No.", DividendPostingBuffer."Account No.");
                                GenJLine.Description := PADSTR(DividendPostingBuffer.Description + CustMembr."No." + '-' + CustMembr.Name, 50);
                                GenJLine."Member No." := CustMembr."No.";
                                GenJLine.VALIDATE(GenJLine.Amount, DividendPostingBuffer.Amount);
                                GenJLine."Transaction Type" := DividendPostingBuffer."Transaction Type";
                                GenJLine."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type";
                                GenJLine.VALIDATE("Bal. Account No.", DividendPostingBuffer."Bal. Account No.");
                                GenJLine.VALIDATE(GenJLine."Loan No", DividendPostingBuffer."Loan No");
                                GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                IF GenJLine.Amount <> 0 THEN
                                    GenJLine.INSERT;
                            END;
                    sendsmsvalue := true;
                UNTIL DividendPostingBuffer.NEXT = 0;
            END;//Populate to Journal
                //Post
            JournalPosting.CompletePosting(Jtemplate, JBatch);


            //end 

            //       Block_UnBlock(CustMembrNo,0);

            //Post

            //Place Lien on defaulters
            DividendSetUp.GET();
            DividendPostingBufferII.SetCurrentKey("Member No.", Posted, "Account Type");
            DividendPostingBufferII.SetRange(Posted, false);
            DividendPostingBufferII.SetRange("Member No.", CustMembrNo);
            DividendPostingBufferII.SetRange("Account Type", DividendPostingBufferII."Account Type"::Savings);
            DividendPostingBufferII.SetLoadFields("Member No.", Posted, "Account Type", Amount);
            DividendPostingBufferII.CalcSums(Amount);


            //IF CustMembr.Status = CustMembr.Status::Defaulter THEN
            //   PlaceLien(SavingsAccountNo, DividendPostingBufferII.Amount, Div_DocumentNo, Div_DocumentNo);


            AmountRecovered := 0;
            DepoAmountPaid := 0;
            LoanRecoveryHeader.SetCurrentKey("Posting Date", "Member No.");
            LoanRecoveryHeader.SetRange("Member No.", CustMembrNo);
            LoanRecoveryHeader.SetRange("Posting Date", DividendSetUp."Start Date", TODAY);
            IF LoanRecoveryHeader.FindSet THEN BEGIN
                SavingsLedgerEntry.SetCurrentKey("Customer No.", "Posting Date");
                SavingsLedgerEntry.SetRange("Customer No.", CapitaliazeAcc);
                SavingsLedgerEntry.SetFilter(Amount, '<%1', 0);
                SavingsLedgerEntry.SetRange(Reversed, false);
                SavingsLedgerEntry.SetRange("Posting Date", LoanRecoveryHeader."Posting Date", TODAY);
                SavingsLedgerEntry.SetLoadFields("Customer No.", Amount, Reversed, "Posting Date");
                SavingsLedgerEntry.CalcSums(Amount);

                AmountRecovered := LoanRecoveryHeader."Interest Balance" + LoanRecoveryHeader."Principle Balance" + SavingsLedgerEntry.Amount;
                // IF AmountRecovered > DividendPostingBufferII.Amount THEN
                //    AmountRecovered := DividendPostingBufferII.Amount;
                // PlaceLien(SavingsAccountNo, AmountRecovered, Div_DocumentNo, Div_DocumentNo);
            end;
            DividendPostingBuffer2.SetCurrentKey("Member No.");
            DividendPostingBuffer2.SetRange("Member No.", CustMembrNo);
            IF DividendPostingBuffer2.FindSet THEN BEGIN
                // Use a flag to track if any records were modified
                IsModified := false;
                REPEAT
                    DividendPostingBuffer2.Posted := TRUE;
                    DividendPostingBuffer2.Modify();
                    IsModified := TRUE;
                UNTIL DividendPostingBuffer2.Next = 0;

                // Commit all changes if any record was modified
                IF IsModified THEN
                    COMMIT;
            END;

            //Send SMS
            // if sendsmsvalue = true then begin
            //     IF CustMembr."Account Type" = CustMembr."Account Type"::"Single Member Account" THEN BEGIN
            //         MyDivs := ROUND(MyDivs, 0.01, '=');
            //         IF MyDivs > DividendSetUp."Minimum Capitalized" THEN BEGIN
            //             SendSms.SendSms(SourceType::Dividends, CustMembr."Phone No.", 'Dear ' + MemberName + ', ' +
            //             'your dividend of Kes. ' + FORMAT(MyDivs) + ' has been credited into your Account. ' + SMSTrailer, CustMembr."No.", CustMembr."No.", FALSE, 1, false, 'CBS', '', 'CBS');
            //         END ELSE BEGIN
            //             IF (MyDivs < DividendSetUp."Minimum Capitalized") AND (MyDivs > 0) THEN BEGIN
            //                 SendSms.SendSms(SourceType::Dividends, CustMembr."Phone No.", 'Dear ' + MemberName + ', ' +
            //                 'your dividend of Kes. ' + FORMAT(MyDivs) + ' has been capitalized. ' + SMSTrailer, CustMembr."No.", CustMembr."No.", FALSE, 1, false, 'CBS', '', 'CBS');
            //             END;
            //         END;
            //     END;
            // end;
        END; //With statement


        //**MESSAGE(MessageTxt);
    end;

    local procedure AdviceLoan(Loans: Record Loans; LoanAmount: Decimal)
    var
        iEntryNo: Integer;
        CheckoffAdvice: Record "Checkoff Advice Line";
        PaymentMethods: Record "Payment Methods";
        Memb: Record Members;
    begin
        Loans.CalcFields(Loans."Outstanding Balance");
        iEntryNo := 0;
        CheckoffAdvice.Reset;
        CheckoffAdvice.SetRange(CheckoffAdvice."Advice Date", Today);
        CheckoffAdvice.SetRange(CheckoffAdvice."Loan No.", Loans."Loan No.");
        if CheckoffAdvice.Find('-') then
            CheckoffAdvice.DeleteAll;

        CheckoffAdvice.Reset;
        if CheckoffAdvice.Find('+') then
            iEntryNo := CheckoffAdvice."Entry No" + 1;

        CheckoffAdvice.Init;
        CheckoffAdvice."Entry No" := iEntryNo;
        CheckoffAdvice."Account No." := Loans."Loan Account";
        CheckoffAdvice."Product Type" := Loans."Loan Product Type";
        CheckoffAdvice."Loan No." := Loans."Loan No.";
        if Memb.Get(Loans."Member No.") then
            CheckoffAdvice."ID No." := Memb."Primary Identification";
        CheckoffAdvice."Member No." := Loans."Member No.";
        CheckoffAdvice."Employer Code" := Loans."Employer Code";
        CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
        CheckoffAdvice.Names := Loans."Member Name";

        //Different Mode of Payment***************
        PaymentMethods.Reset;
        PaymentMethods.SetRange(PaymentMethods."Loan No.", Loans."Loan No.");
        PaymentMethods.SetRange(PaymentMethods."Member No.", Loans."Member No.");
        PaymentMethods.SetRange(PaymentMethods."Payment Method", PaymentMethods."payment method"::Checkoff);
        if PaymentMethods.Find('-') then begin
            CheckoffAdvice."Amount On" := PaymentMethods.Amount;
        end else
            CheckoffAdvice."Amount On" := Loans.Repayment;
        CheckoffAdvice."Balance On" := Loans."Outstanding Balance" - LoanAmount;
        CheckoffAdvice."Advice Date" := 20190105D;
        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
        CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
        if (Loans."Outstanding Balance" - LoanAmount) <= 0 then
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage
        else
            CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Adjustment;
        CheckoffAdvice.Insert;
    end;
}
