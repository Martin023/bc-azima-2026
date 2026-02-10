#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186086 "Process STO"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Standing Order Header"; "Standing Order Header")
        {

            RequestFilterFields = "Member No.", "No.", "Source Account No.";
            trigger OnAfterGetRecord()
            var
                SalHeaD: Record "Salary Header";
                DocNo: Code[20];
                PDate: Date;
                DActivity2: Code[20];
                DBranch2: Code[20];
                Jtemplate: Code[20];
                Jbatch: Code[20];
                RunBal: Decimal;
                MemberNo: Code[20];
                LineNo: Integer;
                Salaccno: Code[20];
                SavingsAccounts: Record "Savings Accounts";
                ProductFactory: Record "Product Factory";
                AvailableBal: Decimal;
                GenJournalLine: Record "Gen. Journal Line";
                BalAccountType: Enum "Gen. Journal Account Type";
                StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
                StandingOrdSRegister: Record "Standing Order Register";
                TCharges: Decimal;
                SalLines: Record "Salary Lines";
                STOHeaderNo: Code[20];
                StandingOrderLines: Record "Standing Order Lines";
                StandingOrderLinesII: Record "Standing Order Lines";
                LoanApps: Record Loans;
                LoanInterest: Decimal;
                LoanPrinciple: Decimal;
                STOHead: Record "Standing Order Header";
                STOlinesname: Text[80];
                TransactionCharges: Record "Transaction Charges";
                ChargeAmount: Decimal;
                TariffDetails: Record "Tiered Charges Lines";
                TChargeAmount: Decimal;
                AmountDedu: Decimal;
                LoanPrincipal: Decimal;
                LoanRepayment: Decimal;
                TransTypes: Record "Transaction Types";
                DeductedSTO: Decimal;
                SavingsACCS: Record "Savings Accounts";
                STR: Date;
                SkipSTO: Boolean;
                GenSetup: Record "General Set-Up";
                SaccoTrans: Codeunit "Sacco Transactions";
                msg: Text[100];
                SendSMS: Codeunit SendSms;
                Source: Enum "SMS Source";
                Memb: Record Members;
                AmtDeducted: Decimal;
                TransactionTypes: record "Transaction Types";
                Txt004: label 'Dear Member your  standing order towards (senior saver loan) repayment was unsuccessful.';
            begin
                //with SalHeaD do 
                begin

                    GenSetup.Get;

                    "Standing Order Header".Reset;
                    "Standing Order Header".SetCurrentkey("Standing Order Header"."No.");
                    "Standing Order Header".SetRange("Standing Order Header"."Member No.", MemberNo);
                    "Standing Order Header".SetRange("Standing Order Header".Status, "Standing Order Header".Status::Approved);
                    "Standing Order Header".SetFilter("Standing Order Header"."Income Type", '%1|%2|%3|%4', "Standing Order Header"."income type"::Salary,
                                                  "Standing Order Header"."income type"::Pension, "Standing Order Header"."income type"::"Direct Debit", "Standing Order Header"."income type"::SAYE);
                    if "Standing Order Header".Find('-') then begin //*Header Info

                        repeat
                            SkipSTO := false;
                            LineNo += 1;
                            StandingOrdSRegister.Reset();
                            StandingOrdSRegister.SetRange("Document No.", "Standing Order Header"."No.");
                            if StandingOrdSRegister.FindFirst() then begin
                                repeat
                                    AmtDeducted += StandingOrdSRegister."Amount Deducted";
                                until StandingOrdSRegister.Next() = 0;
                            end;
                            // if AmtDeducted >= "Standing Order Header"."Target Amount" then begin
                            //     SkipSTO := true;
                            //     "Standing Order Header".Status := "Standing Order Header".Status::Stopped;
                            //     "Standing Order Header".Modify();
                            // end;

                            // AmountToDeduct := "Standing Order Header"."Target Amount" - AmountDeducted;

                            STR := (CalcDate('-5D', PDate));

                            //For non partial
                            StandingOrdSRegister.Reset;
                            StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                            StandingOrdSRegister.SetRange("Document No.", "Standing Order Header"."No.");
                            StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::Successful);
                            if StandingOrdSRegister.FindLast then begin
                                if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
                                    SkipSTO := true;
                            end;

                            StandingOrderLinesII.reset;
                            StandingOrderLinesII.SetRange("Destination Account Type", StandingOrderLinesII."Destination Account Type"::Credit);
                            StandingOrderLinesII.SetRange(StandingOrderLinesII."Document No.", STOHeaderNo);
                            if StandingOrderLinesII.Find('-') then begin
                                repeat
                                    if not LoanApps.get(StandingOrderLinesII."Loan No.") then
                                        SkipSTO := true;
                                until
                                StandingOrderLinesII.Next = 0;
                            end;

                            //Taking into consideration double salary for partial
                            StandingOrdSRegister.Reset;
                            StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                            StandingOrdSRegister.SetRange("Document No.", "Standing Order Header"."No.");
                            StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
                            StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
                            if StandingOrdSRegister.FindLast then begin
                                if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) and (StandingOrdSRegister."Amount Deducted" >= "Standing Order Header".Amount) then
                                    SkipSTO := true;
                            end;
                            if SkipSTO = false then begin
                                STOHeaderNo := '';
                                STOHeaderNo := "Standing Order Header"."No.";
                                //*
                                /*StandingOrdSRegister.RESET;
                                StandingOrdSRegister.SETRANGE(StandingOrdSRegister."Date Processed",TODAY);
                                StandingOrdSRegister.SETRANGE("Document No.","Standing Order Header"."No.");
                                IF StandingOrdSRegister.FIND('-') THEN
                                StandingOrdSRegister.DELETEALL;*///27.04.2021

                                //*
                                //ERROR(FORMAT("Standing Order Header"."Allow Partial Deduction"));
                                if not "Standing Order Header"."Allow Partial Deduction" then begin

                                    if RunBal < "Standing Order Header".Amount then begin

                                        //Sto Charges on failure
                                        GenSetup.Get;

                                        TCharges := 0;
                                        TransactionTypes.Reset;
                                        TransactionTypes.SetRange(Code, GenSetup."Failed STO Fee");
                                        if TransactionTypes.Find('-') then begin
                                            TransactionCharges.Reset;
                                            TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                                            //TransactionCharges.SetRange("Transaction Type", "Standing Order Header"."Transaction Type");
                                            // TransactionCharges.SetRange(TransactionCharges."Transaction Charge Category",TransactionCharges."Transaction Charge Category"::"Failed STO Charge");
                                            if TransactionCharges.Find('-') then begin
                                                repeat
                                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Failed STO Charge") then begin

                                                        ChargeAmount := 0;
                                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"Flat Amount" then
                                                            ChargeAmount := TransactionCharges."Charge Amount";

                                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                            ChargeAmount := ("Standing Order Header".Amount * TransactionCharges."Percentage of Amount") * 0.01;


                                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                            TariffDetails.Reset;
                                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                            if TariffDetails.Find('-') then begin
                                                                repeat
                                                                    if ("Standing Order Header".Amount >= TariffDetails."Lower Limit") and
                                                                        ("Standing Order Header".Amount <= TariffDetails."Upper Limit") then begin
                                                                        if TariffDetails."Use Percentage" then
                                                                            ChargeAmount := "Standing Order Header".Amount * TariffDetails.Percentage * 0.01
                                                                        else
                                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                                    end;
                                                                until TariffDetails.Next = 0;
                                                            end;
                                                        end;

                                                        LineNo := LineNo + 10000;

                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                        GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                        GenJournalLine.Description := TransactionCharges.Description;
                                                        GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                                            //Excise
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                            GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                            GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                            GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;
                                                            //Excise
                                                        end;
                                                        TChargeAmount += ChargeAmount;
                                                    end;
                                                until TransactionCharges.Next = 0;
                                            end;
                                        end;
                                        TCharges := TChargeAmount;

                                        SaccoTrans.UpdateStandingOrderRegister('', Today, "Standing Order Header"."No.", '', "Standing Order Header"."Source Account No.", "Standing Order Header"."Source Account Name",
                                                                            "Standing Order Header"."Member No.", "Standing Order Header"."Payroll/Staff No.", "Standing Order Header"."Allow Partial Deduction",
                                                                            Standingorddeductstatus::Failed, "Standing Order Header".Amount, 0, "Standing Order Header"."Effective/Start Date", "Standing Order Header"."Duration (Months)",
                                                                            "Standing Order Header"."Frequency (Months)", "Standing Order Header"."End Date", "Standing Order Header".Description, "Standing Order Header"."Transfered to EFT", false, "Standing Order Header"."No.");
                                        //SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Mobile Phone No", Txt004, Format("Standing Order Header"."No."), '', true, 0, false, 'CBS', "Standing Order Header"."No.", 'CBS');
                                        // StandingOrdSRegister.Reset();
                                        // StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
                                        // StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
                                        // StandingOrdSRegister.SetRange("Member No", "Standing Order Header"."Member No.");
                                        // StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
                                        // if StandingOrdSRegister.FindFirst() then begin
                                        //     msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards (senior saver loan) repayment was unsuccessful.';
                                        //     SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
                                        // end;

                                        //Sto Charges on failure
                                    end else begin

                                        SaccoTrans.UpdateStandingOrderRegister('', Today, "Standing Order Header"."No.", '', "Standing Order Header"."Source Account No.", "Standing Order Header"."Source Account Name",
                                                                        "Standing Order Header"."Member No.", "Standing Order Header"."Payroll/Staff No.", "Standing Order Header"."Allow Partial Deduction",
                                                                        Standingorddeductstatus::Successfull, "Standing Order Header".Amount, "Standing Order Header".Amount, "Standing Order Header"."Effective/Start Date", "Standing Order Header"."Duration (Months)",
                                                                        "Standing Order Header"."Frequency (Months)", "Standing Order Header"."End Date", "Standing Order Header".Description, "Standing Order Header"."Transfered to EFT", false, "Standing Order Header"."No.");


                                        STOlinesname := '';
                                        AmountDedu := 0;

                                        //*Line Posting
                                        StandingOrderLines.Reset;
                                        //StandingOrderLines.SETCURRENTKEY("Destination Account Type","Destination Account Type"::Internal);
                                        StandingOrderLines.SetRange(StandingOrderLines."Document No.", STOHeaderNo);

                                        if StandingOrderLines.Find('-') then begin
                                            repeat
                                                StandingOrderLines.CalcFields("OutStanding Bills");


                                                case StandingOrderLines."Destination Account Type" of
                                                    //*Credit Entries
                                                    StandingOrderLines."destination account type"::Credit:
                                                        begin

                                                            LoanApps.Reset;
                                                            LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                                            //LoanApps.SETFILTER(LoanApps."Outstanding Interest",'>0');
                                                            if LoanApps.Find('-') then begin
                                                                LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Balance", "Outstanding Bills");

                                                                LineNo := LineNo + 10000;

                                                                GenJournalLine.Init;
                                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                                GenJournalLine."Line No." := LineNo;
                                                                GenJournalLine."Posting Date" := PDate;
                                                                GenJournalLine."Document No." := DocNo;
                                                                GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
                                                                GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format("Standing Order Header"."Source Account Name"), 50);
                                                                if LoanApps."Outstanding Interest" > StandingOrderLines.Amount then begin
                                                                    LoanInterest := StandingOrderLines.Amount;
                                                                    LoanPrinciple := 0;
                                                                end else begin
                                                                    LoanPrinciple := StandingOrderLines.Amount - LoanApps."Outstanding Interest";
                                                                    LoanInterest := LoanApps."Outstanding Interest";
                                                                end;
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest);
                                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                                if GenJournalLine.Amount <> 0 then
                                                                    GenJournalLine.Insert;
                                                                RunBal -= Abs(GenJournalLine.Amount);
                                                                AmountDedu += Abs(GenJournalLine.Amount);


                                                                if LoanPrinciple > LoanApps."Outstanding Balance" then
                                                                    LoanPrinciple := LoanApps."Outstanding Balance";

                                                                //repayment
                                                                LineNo := LineNo + 10000;

                                                                GenJournalLine.Init;
                                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                                GenJournalLine."Line No." := LineNo;
                                                                GenJournalLine."Posting Date" := PDate;
                                                                GenJournalLine."Document No." := DocNo;
                                                                GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
                                                                GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format("Standing Order Header"."Source Account Name"), 50);
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -LoanPrinciple);
                                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                                if GenJournalLine.Amount <> 0 then
                                                                    GenJournalLine.Insert;
                                                                RunBal -= Abs(GenJournalLine.Amount);
                                                                AmountDedu += Abs(GenJournalLine.Amount);

                                                            end;
                                                        end;//Credit Entries



                                                    //*Internal,External Entries
                                                    StandingOrderLines."destination account type"::"G/L Account", StandingOrderLines."destination account type"::Savings:
                                                        begin

                                                            LineNo := LineNo + 10000;

                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;

                                                            GenJournalLine."Line No." := LineNo;

                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := "Standing Order Header"."No.";

                                                            case StandingOrderLines."Destination Account Type" of

                                                                StandingOrderLines."destination account type"::"G/L Account":
                                                                    begin
                                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                                        GenJournalLine.Validate(GenJournalLine."Account No.", GenSetup."External STO Account No.");
                                                                    end;


                                                                StandingOrderLines."destination account type"::Savings:
                                                                    begin
                                                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                    end;
                                                            end;

                                                            //GenJournalLine.Description:='Destination:-'+StandingOrderLines."Destination Account Name";
                                                            GenJournalLine.Description := PadStr('STO:-' + Format("Standing Order Header"."No.") + '-' + Format("Standing Order Header"."Source Account Name"), 50);

                                                            if RunBal >= StandingOrderLines.Amount then
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
                                                            else
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;
                                                            RunBal -= Abs(GenJournalLine.Amount);
                                                            AmountDedu += Abs(GenJournalLine.Amount);
                                                        end;//*Internal,External Entries


                                                end;
                                            until StandingOrderLines.Next = 0;
                                        end;


                                        //*Header Posting

                                        if STOHead.Get(STOHeaderNo) then begin

                                            //**********************
                                            GenSetup.Get;


                                            TCharges := 0;
                                            TransactionCharges.Reset;
                                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Standing Order Header"."Transaction Type");
                                            if TransactionCharges.Find('-') then begin
                                                repeat

                                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                                        ChargeAmount := 0;
                                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                            ChargeAmount := ("Standing Order Header".Amount * TransactionCharges."Percentage of Amount") * 0.01
                                                        else
                                                            ChargeAmount := TransactionCharges."Charge Amount";

                                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                            TariffDetails.Reset;
                                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                            if TariffDetails.Find('-') then begin
                                                                repeat
                                                                    if ("Standing Order Header".Amount >= TariffDetails."Lower Limit") and
                                                                        ("Standing Order Header".Amount <= TariffDetails."Upper Limit") then begin
                                                                        if TariffDetails."Use Percentage" then
                                                                            ChargeAmount := "Standing Order Header".Amount * TariffDetails.Percentage * 0.01
                                                                        else
                                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                                    end;
                                                                until TariffDetails.Next = 0;
                                                            end;
                                                        end;

                                                        LineNo := LineNo + 10000;

                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                        GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                        GenJournalLine.Description := TransactionCharges.Description;
                                                        GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                                            //Excise
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                            GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                            GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                            GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;
                                                            //Excise
                                                        end;
                                                        TChargeAmount += ChargeAmount;
                                                    end;
                                                until TransactionCharges.Next = 0;
                                            end;
                                            TCharges := TChargeAmount;
                                            //**********************

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;

                                            GenJournalLine."Line No." := LineNo;

                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := STOHead."No.";
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                                            GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                                            //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                                            GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                                            if AmountDedu > 0 then
                                                GenJournalLine.Validate(GenJournalLine.Amount, STOHead.Amount);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;
                                end else begin
                                    //Partial
                                    AmountDedu := 0;
                                    DeductedSTO := 0;

                                    //Taking into consideration double salary
                                    StandingOrdSRegister.Reset;
                                    StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                                    StandingOrdSRegister.SetRange("Document No.", "Standing Order Header"."No.");
                                    StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
                                    StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
                                    if StandingOrdSRegister.FindLast then begin
                                        if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
                                            "Standing Order Header".Amount -= StandingOrdSRegister."Amount Deducted";
                                    end;


                                    if RunBal > "Standing Order Header".Amount then begin
                                        DeductedSTO := "Standing Order Header".Amount;
                                        StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                                    end else begin
                                        DeductedSTO := RunBal;
                                        StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";

                                    end;
                                    if DeductedSTO < 0 then
                                        DeductedSTO := 0;
                                    //  ERROR(FORMAT(StandingOrdDeductStatus));
                                    SaccoTrans.UpdateStandingOrderRegister('', Today, "Standing Order Header"."No.", '', "Standing Order Header"."Source Account No.", "Standing Order Header"."Source Account Name",
                                                                "Standing Order Header"."Member No.", "Standing Order Header"."Payroll/Staff No.", "Standing Order Header"."Allow Partial Deduction",
                                                                StandingOrdDeductStatus, "Standing Order Header".Amount, DeductedSTO, "Standing Order Header"."Effective/Start Date", "Standing Order Header"."Duration (Months)",
                                                                "Standing Order Header"."Frequency (Months)", "Standing Order Header"."End Date", "Standing Order Header".Description, "Standing Order Header"."Transfered to EFT", false, "Standing Order Header"."No.");


                                    if "Standing Order Header"."Allow Partial Deduction" then begin //Partial Deduction
                                        StandingOrderLines.Reset;
                                        StandingOrderLines.SetRange(StandingOrderLines."Document No.", "Standing Order Header"."No.");
                                        if StandingOrderLines.Find('-') then begin
                                            repeat
                                                STOlinesname := StandingOrderLines."Destination Account Name";
                                                //   MESSAGE('The Lines name is %1',STOlinesname);
                                                case StandingOrderLines."Destination Account Type" of
                                                    StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account":
                                                        begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := STOHead."No.";
                                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            //GenJournalLine.Description:=PADSTR('Destination:- '+"Standing Order Header"."Source Account No."+'-'+"Standing Order Header"."Source Account Name",50);
                                                            GenJournalLine.Description := PadStr('STO:-' + Format("Standing Order Header"."No.") + '-' + Format("Standing Order Header"."Source Account Name"), 50);
                                                            if RunBal >= StandingOrderLines.Amount then
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
                                                            else
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                            RunBal -= Abs(GenJournalLine.Amount);
                                                            AmountDedu += Abs(GenJournalLine.Amount); //MESSAGE('TE5 :%1',AmountDedu);
                                                        end;

                                                    StandingOrderLines."destination account type"::Credit:
                                                        begin

                                                            LoanInterest := 0;
                                                            LoanPrincipal := 0;
                                                            LoanRepayment := 0;

                                                            LoanApps.Reset;
                                                            LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                                            if LoanApps.Find('-') then begin
                                                                LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Bills", LoanApps."Outstanding Balance");

                                                                LoanPrincipal := StandingOrderLines.Amount;

                                                                if LoanApps."Outstanding Interest" > 0 then begin
                                                                    LineNo := LineNo + 10000;
                                                                    GenJournalLine.Init;
                                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                                    GenJournalLine."Line No." := LineNo;
                                                                    GenJournalLine."Posting Date" := PDate;
                                                                    GenJournalLine."Document No." := DocNo;
                                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                    GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + "Standing Order Header"."Source Account No." + '-' +
                                                                                                 Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                                                    if LoanApps."Outstanding Interest" > StandingOrderLines.Amount then begin
                                                                        LoanInterest := StandingOrderLines.Amount;
                                                                        LoanPrincipal := StandingOrderLines.Amount - LoanInterest;
                                                                    end else
                                                                        LoanInterest := LoanApps."Outstanding Interest";

                                                                    if RunBal > LoanInterest then
                                                                        GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest)
                                                                    else
                                                                        GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                                    if GenJournalLine.Amount <> 0 then
                                                                        GenJournalLine.Insert;

                                                                    RunBal -= Abs(GenJournalLine.Amount);
                                                                    AmountDedu += Abs(GenJournalLine.Amount); //MESSAGE('TE6 :%1',AmountDedu);
                                                                end;

                                                                if (LoanApps."Outstanding Balance" > 0) then begin//and (LoanApps."Outstanding Bills" = 0) then begin
                                                                    LineNo := LineNo + 10000;
                                                                    LineNo := LineNo + 10000;
                                                                    GenJournalLine.Init;
                                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                                    GenJournalLine."Line No." := LineNo;
                                                                    GenJournalLine."Posting Date" := PDate;
                                                                    GenJournalLine."Document No." := DocNo;
                                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                    GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + "Standing Order Header"."Source Account No." + '-' +
                                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                                    if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                        LoanRepayment := LoanPrincipal
                                                                    else
                                                                        LoanRepayment := LoanApps."Outstanding Balance";

                                                                    if RunBal > LoanRepayment then
                                                                        GenJournalLine.Validate(GenJournalLine.Amount, -LoanRepayment)
                                                                    else
                                                                        GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                                    if GenJournalLine.Amount <> 0 then
                                                                        GenJournalLine.Insert;

                                                                    RunBal -= Abs(GenJournalLine.Amount);
                                                                    AmountDedu += Abs(GenJournalLine.Amount);  //MESSAGE('TE8 :%1',AmountDedu);
                                                                end;
                                                            end;
                                                        end;
                                                end;
                                            until StandingOrderLines.Next = 0;
                                        end;
                                        //--Partial End***
                                    end;

                                    //*Header Posting

                                    if STOHead.Get(STOHeaderNo) then begin


                                        //Charges
                                        STOlinesname := StandingOrderLines."Destination Account Name";


                                        GenSetup.Get;


                                        TCharges := 0;
                                        TransactionCharges.Reset;
                                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Standing Order Header"."Transaction Type");
                                        if TransactionCharges.Find('-') then begin
                                            repeat

                                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                                    ChargeAmount := 0;
                                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                        ChargeAmount := ("Standing Order Header".Amount * TransactionCharges."Percentage of Amount") * 0.01
                                                    else
                                                        ChargeAmount := TransactionCharges."Charge Amount";

                                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                        TariffDetails.Reset;
                                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                        if TariffDetails.Find('-') then begin
                                                            repeat
                                                                if ("Standing Order Header".Amount >= TariffDetails."Lower Limit") and
                                                                    ("Standing Order Header".Amount <= TariffDetails."Upper Limit") then begin
                                                                    if TariffDetails."Use Percentage" then
                                                                        ChargeAmount := "Standing Order Header".Amount * TariffDetails.Percentage * 0.01
                                                                    else
                                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                                end;
                                                            until TariffDetails.Next = 0;
                                                        end;
                                                    end;

                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                    GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                    GenJournalLine.Description := TransactionCharges.Description;
                                                    GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                        (TransactionCharges."Recover Excise Duty" = true) then begin
                                                        //Excise
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := "Standing Order Header"."No.";
                                                        GenJournalLine."Account Type" := "Standing Order Header"."Source Account Type";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", "Standing Order Header"."Source Account No.");
                                                        GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                        GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        //Excise
                                                    end;
                                                    TChargeAmount += ChargeAmount;
                                                end;
                                            until TransactionCharges.Next = 0;
                                        end;
                                        TCharges := TChargeAmount;
                                        //Charges
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;

                                        GenJournalLine."Line No." := LineNo;

                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := STOHead."No.";
                                        GenJournalLine."Account Type" := STOHead."Source Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                                        GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                                        GenJournalLine.Validate(GenJournalLine.Amount, AmountDedu);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;

                                StandingOrdSRegister.Reset();
                                StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
                                StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
                                StandingOrdSRegister.SetRange("Member No", "Standing Order Header"."Member No.");
                                StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
                                if StandingOrdSRegister.FindFirst() then begin
                                    msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards (senior saver loan) repayment was unsuccessful.';
                                    SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
                                end;
                            end;//All Successful STOS Exempt

                        until "Standing Order Header".Next = 0;
                    end;//*Header Info
                end;



                //PostLoansArreas(SalHeaD,DocNo,PDate,DActivity2,DBranch2,Jtemplate,Jbatch,RunBal,MemberNo,LineNo,Salaccno);

            end;

            trigger OnPostDataItem()
            begin
                ProgressWindow.Close;
                Message('Done!!!');
            end;

            // trigger OnPreDataItem()
            // begin
            //     Counter := 0;
            //     ProgressWindow.Open('Processing #1#######');

            //     if SimulatedTodaysDate = 0D then SimulatedTodaysDate := Today;
            // end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            // area(content)
            // {
            //     field(SimulatedTodaysDate; SimulatedTodaysDate)
            //     {
            //     }
            //     field(SimulatedDaysInArreas; SimulatedDaysInArreas)
            //     {
            //     }

            // }
        }
    }

    trigger OnPreReport()
    begin
        // AsAt := today;
    end;

    var
        ProgressWindow: Dialog;
}
