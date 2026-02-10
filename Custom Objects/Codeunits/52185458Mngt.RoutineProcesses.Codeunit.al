#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185458 "Mngt. Routine Processes"
{

    trigger OnRun()
    begin
    end;

    var
        NextRunDate: Date;
        GeneralSetUp: Record "General Set-Up";
        SavingsAccounts: Record "Savings Accounts";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        ProductFactory: Record "Product Factory";
        TCharges: Decimal;
        AvailableBal: Decimal;
        RunBal: Decimal;
        AmountDedu: Decimal;
        BankingUserTemplate: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        GenJLine: Record "Gen. Journal Line";
        StandingOrderLines: Record "Standing Order Lines";
        LoanApps: Record Loans;
        DeductionStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        LoanInterest: Decimal;
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        SuccessfullyPosted: label 'Successfully Processed.';
        MsgOnConfirmDialog: label 'Are you want to Post this Application?';
        MsgOnPostCompletion: label 'Application No.-%1- , -%2-successfully posted.';


    procedure SOHP(NextRunDate: Date; SOH: Record "Standing Order Header")
    var
        JournalPosting: Codeunit "Journal Posting";
    begin
        JTemplate := '';
        JBatch := '';
        BankingUserTemplate.Get(UserId);
        JTemplate := BankingUserTemplate."Cashier Journal Template";
        JBatch := BankingUserTemplate."Cashier Journal Batch";

        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", JTemplate);
        GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
        GenJLine.DeleteAll;

        StandingOrdSRegister.Reset;
        StandingOrdSRegister.SetRange(StandingOrdSRegister."Date Processed", NextRunDate);
        StandingOrdSRegister.SetFilter(StandingOrdSRegister."Document No.", SOH."No.");
        if StandingOrdSRegister.Find('-') then
            StandingOrdSRegister.DeleteAll;

        GeneralSetUp.Get;

        if NextRunDate = 0D then
            NextRunDate := Today;

        AvailableBal := 0;
        RunBal := 0;

        if SavingsAccounts.Get(SOH."Source Account No.") then begin
            SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)", SavingsAccounts."Authorised Over Draft",
                                       SavingsAccounts."Uncleared Cheques", SavingsAccounts."ATM Transactions");

            GlobalDim1 := SavingsAccounts."Global Dimension 1 Code";
            GlobalDim2 := SavingsAccounts."Global Dimension 2 Code";

            getChargeAmount(SOH);

            if ProductFactory.Get(SavingsAccounts."Product Type") then
                AvailableBal := (SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                               (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" + ProductFactory."Minimum Balance" + TCharges);


            case SOH."Income Type" of
                SOH."income type"::Periodic:
                    begin
                        if SOH."Next Run Date" = NextRunDate then begin //MESSAGE(FORMAT(NextRunDate));
                            RunBal := AvailableBal; //MESSAGE(FORMAT(RunBal));
                            if not SOH."Allow Partial Deduction" then begin
                                if RunBal >= SOH.Amount then begin
                                    StandingOrderLines.Reset;
                                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", SOH."No.");
                                    if StandingOrderLines.Find('-') then begin
                                        repeat
                                            //MESSAGE('No :%1 Name :%2 Amount :%3',StandingOrderLines."Destination Account No.",StandingOrderLines."Destination Account Name",StandingOrderLines.Amount);
                                            case StandingOrderLines."Destination Account Type" of
                                                StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account":
                                                    begin
                                                        //MESSAGE('No :%1 Name :%2 Amount :%3',StandingOrderLines."Destination Account No.",StandingOrderLines."Destination Account Name",StandingOrderLines.Amount);
                                                        LineN += 1;
                                                        GenJLine.Init;
                                                        GenJLine."Journal Template Name" := JTemplate;
                                                        GenJLine."Journal Batch Name" := JBatch;
                                                        GenJLine."Line No." := LineN;
                                                        GenJLine."Posting Date" := NextRunDate;
                                                        GenJLine."Document No." := SOH."No.";
                                                        GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                        GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                        GenJLine.Description := PadStr('Destination:- ' + StandingOrderLines."Destination Account No." + '-' + StandingOrderLines."Destination Account Name", 50);
                                                        GenJLine.Validate(GenJLine.Amount, -StandingOrderLines.Amount);
                                                        GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                        if GenJLine.Amount <> 0 then
                                                            GenJLine.Insert;

                                                        RunBal -= Abs(GenJLine.Amount);
                                                        AmountDedu += Abs(GenJLine.Amount); //**//MESSAGE(FORMAT(AmountDedu));
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

                                                            //MESSAGE('No :%1 Name :%2 Amount :%3',StandingOrderLines."Destination Account No.",StandingOrderLines."Destination Account Name",StandingOrderLines.Amount);

                                                            LoanPrincipal := StandingOrderLines.Amount;

                                                            if LoanApps."Outstanding Interest" > 0 then begin
                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::"Interest Paid"), 50);

                                                                if LoanApps."Outstanding Interest" > StandingOrderLines.Amount then begin
                                                                    LoanInterest := StandingOrderLines.Amount;
                                                                    LoanPrincipal := StandingOrderLines.Amount - LoanInterest;
                                                                end else
                                                                    LoanInterest := LoanApps."Outstanding Interest";

                                                                if RunBal > LoanInterest then
                                                                    GenJLine.Validate(GenJLine.Amount, -LoanInterest)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::"Interest Paid";
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                RunBal -= Abs(GenJLine.Amount);
                                                                AmountDedu += Abs(GenJLine.Amount); //**//MESSAGE(FORMAT(AmountDedu));
                                                            end;

                                                            if (LoanApps."Outstanding Balance" > 0) and (LoanApps."Outstanding Bills" > 0) then begin
                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:- ' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::Bills), 50);

                                                                if LoanApps."Outstanding Bills" >= LoanPrincipal then
                                                                    LoanRepayment := LoanPrincipal
                                                                else
                                                                    LoanRepayment := LoanApps."Outstanding Bills";

                                                                if RunBal >= LoanRepayment then
                                                                    GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::Repayment), 50);

                                                                if LoanApps."Outstanding Bills" >= LoanPrincipal then
                                                                    LoanRepayment := LoanPrincipal
                                                                else
                                                                    LoanRepayment := LoanApps."Outstanding Bills";

                                                                if RunBal >= LoanRepayment then
                                                                    GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::Repayment;
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                RunBal -= Abs(GenJLine.Amount);
                                                                AmountDedu += Abs(GenJLine.Amount); //MESSAGE(FORMAT(AmountDedu));
                                                            end;

                                                            if (LoanApps."Outstanding Balance" > 0) and (LoanApps."Outstanding Bills" = 0) then begin
                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:- ACCRUAL ' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::Bills), 50);

                                                                if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                    LoanRepayment := LoanPrincipal
                                                                else
                                                                    LoanRepayment := LoanApps."Outstanding Balance";

                                                                //MESSAGE('Bill :%1 PPay :%2 RunBal :%3',LoanRepayment ,LoanPrincipal,Runbal);

                                                                if RunBal > LoanRepayment then
                                                                    GenJLine.Validate(GenJLine.Amount, LoanRepayment)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                                                                GenJLine.Validate(GenJLine."Bal. Account No.", GeneralSetUp."Bill Account");
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::Bills), 50);

                                                                if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                    LoanRepayment := LoanPrincipal
                                                                else
                                                                    LoanRepayment := LoanApps."Outstanding Balance";

                                                                if RunBal > LoanRepayment then
                                                                    GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                LineN += 1;
                                                                GenJLine.Init;
                                                                GenJLine."Journal Template Name" := JTemplate;
                                                                GenJLine."Journal Batch Name" := JBatch;
                                                                GenJLine."Line No." := LineN;
                                                                GenJLine."Posting Date" := NextRunDate;
                                                                GenJLine."Document No." := SOH."No.";
                                                                GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                                GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                             Format(GenJLine."transaction type"::Repayment), 50);

                                                                if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                    LoanRepayment := LoanPrincipal
                                                                else
                                                                    LoanRepayment := LoanApps."Outstanding Balance";

                                                                if RunBal > LoanRepayment then
                                                                    GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                                else
                                                                    GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                                GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                                GenJLine."Transaction Type" := GenJLine."transaction type"::Repayment;
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                                if GenJLine.Amount <> 0 then
                                                                    GenJLine.Insert;

                                                                RunBal -= Abs(GenJLine.Amount);
                                                                AmountDedu += Abs(GenJLine.Amount); //MESSAGE(FORMAT(AmountDedu));
                                                            end;
                                                        end;
                                                    end;
                                            end;
                                        until StandingOrderLines.Next = 0;
                                    end;
                                end;
                            end; //Non Partial

                            if SOH."Allow Partial Deduction" then begin //Partial Deduction
                                StandingOrderLines.Reset;
                                StandingOrderLines.SetRange(StandingOrderLines."Document No.", SOH."No.");
                                if StandingOrderLines.Find('-') then begin
                                    repeat
                                        case StandingOrderLines."Destination Account Type" of
                                            StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account":
                                                begin
                                                    LineN += 1;
                                                    GenJLine.Init;
                                                    GenJLine."Journal Template Name" := JTemplate;
                                                    GenJLine."Journal Batch Name" := JBatch;
                                                    GenJLine."Line No." := LineN;
                                                    GenJLine."Posting Date" := NextRunDate;
                                                    GenJLine."Document No." := SOH."No.";
                                                    GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    GenJLine.Description := PadStr('Destination:- ' + StandingOrderLines."Destination Account No." + '-' + StandingOrderLines."Destination Account Name", 50);

                                                    if RunBal >= StandingOrderLines.Amount then
                                                        GenJLine.Validate(GenJLine.Amount, -StandingOrderLines.Amount)
                                                    else
                                                        GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                    GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                    if GenJLine.Amount <> 0 then
                                                        GenJLine.Insert;

                                                    RunBal -= Abs(GenJLine.Amount);
                                                    AmountDedu += Abs(GenJLine.Amount); //**//MESSAGE(FORMAT(AmountDedu));
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
                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::"Interest Paid"), 50);

                                                            if LoanApps."Outstanding Interest" > StandingOrderLines.Amount then begin
                                                                LoanInterest := StandingOrderLines.Amount;
                                                                LoanPrincipal := StandingOrderLines.Amount - LoanInterest;
                                                            end else
                                                                LoanInterest := LoanApps."Outstanding Interest";

                                                            if RunBal > LoanInterest then
                                                                GenJLine.Validate(GenJLine.Amount, -LoanInterest)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::"Interest Paid";
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            RunBal -= Abs(GenJLine.Amount);
                                                            AmountDedu += Abs(GenJLine.Amount); //**//MESSAGE(FORMAT(AmountDedu));
                                                        end;

                                                        if (LoanApps."Outstanding Balance" > 0) and (LoanApps."Outstanding Bills" > 0) then begin
                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:- ' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::Bills), 50);

                                                            if LoanApps."Outstanding Bills" >= LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Bills";

                                                            if RunBal >= LoanRepayment then
                                                                GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::Repayment), 50);

                                                            if LoanApps."Outstanding Bills" >= LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Bills";

                                                            if RunBal >= LoanRepayment then
                                                                GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::Repayment;
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            RunBal -= Abs(GenJLine.Amount);
                                                            AmountDedu += Abs(GenJLine.Amount); //MESSAGE(FORMAT(AmountDedu));
                                                        end;

                                                        if (LoanApps."Outstanding Balance" > 0) and (LoanApps."Outstanding Bills" = 0) then begin
                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:- ACCRUAL' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::Bills), 50);

                                                            if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Balance";

                                                            //MESSAGE('Bill :%1 PPay :%2 RunBal :%3',LoanRepayment ,LoanPrincipal,Runbal);

                                                            if RunBal > LoanRepayment then
                                                                GenJLine.Validate(GenJLine.Amount, LoanRepayment)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                                                            GenJLine.Validate(GenJLine."Bal. Account No.", GeneralSetUp."Bill Account");
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::Bills), 50);

                                                            if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Balance";

                                                            if RunBal > LoanRepayment then
                                                                GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::Bills;
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            LineN += 1;
                                                            GenJLine.Init;
                                                            GenJLine."Journal Template Name" := JTemplate;
                                                            GenJLine."Journal Batch Name" := JBatch;
                                                            GenJLine."Line No." := LineN;
                                                            GenJLine."Posting Date" := NextRunDate;
                                                            GenJLine."Document No." := SOH."No.";
                                                            GenJLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJLine.Validate(GenJLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderLines."Destination Account No." + '-' +
                                                                                         Format(GenJLine."transaction type"::Repayment), 50);

                                                            if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Balance";

                                                            if RunBal > LoanRepayment then
                                                                GenJLine.Validate(GenJLine.Amount, -LoanRepayment)
                                                            else
                                                                GenJLine.Validate(GenJLine.Amount, -RunBal);

                                                            GenJLine.Validate(GenJLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJLine."Transaction Type" := GenJLine."transaction type"::Repayment;
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                                                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                                                            if GenJLine.Amount <> 0 then
                                                                GenJLine.Insert;

                                                            RunBal -= Abs(GenJLine.Amount);
                                                            AmountDedu += Abs(GenJLine.Amount); //MESSAGE(FORMAT(AmountDedu));
                                                        end;
                                                    end;
                                                end;
                                        end;
                                    until StandingOrderLines.Next = 0;
                                end;
                            end; //Partial Deduction

                            getTransactionCharges(SOH);

                            LineN += 1;
                            GenJLine.Init;
                            GenJLine."Journal Template Name" := JTemplate;
                            GenJLine."Journal Batch Name" := JBatch;
                            GenJLine."Line No." := LineN;
                            GenJLine."Posting Date" := NextRunDate;
                            GenJLine."Document No." := SOH."No.";
                            GenJLine."Account Type" := SOH."Source Account Type";
                            GenJLine.Validate(GenJLine."Account No.", SOH."Source Account No.");
                            GenJLine.Description := PadStr('Source:- ' + SOH."Source Account No." + '-' + SOH."Source Account Name", 50);
                            GenJLine.Validate(GenJLine.Amount, AmountDedu);
                            GenJLine.Validate(GenJLine."Loan No", '');
                            GenJLine."Transaction Type" := GenJLine."transaction type"::" ";
                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                            if GenJLine.Amount <> 0 then
                                GenJLine.Insert;
                        end;  //Next Run Date

                        //**SOH."Next Run Date":=CALCDATE(SOH."Frequency (Months)",SOH."Next Run Date"); SOH.MODIFY;

                    end;  //Income Type::Periodic
            end;   //Income Type

            //MESSAGE('JTemplate :%1 JBatch :%2',JTemplate,JBatch);

            GenJLine.Reset;
            GenJLine.SetRange(GenJLine."Journal Template Name", JTemplate);
            GenJLine.SetRange(GenJLine."Journal Template Name", JBatch);
            //**CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post New",GenJLine);
            //JournalPosting.CompletePosting(JTemplate,JBatch,GenJLine);

        end;    //Savings


        if not SOH."Allow Partial Deduction" then begin
            if AvailableBal >= SOH.Amount then
                DeductionStatus := Deductionstatus::Successfull
            else
                DeductionStatus := Deductionstatus::Failed;
        end;
        if SOH."Allow Partial Deduction" then begin
            if AvailableBal >= SOH.Amount then
                DeductionStatus := Deductionstatus::Successfull
            else
                DeductionStatus := Deductionstatus::"Partial Deduction";
        end;

        InitializeStandingOrderRegister('', Today, SOH."No.", '', SOH."Source Account No.", SOH."Source Account Name",
                                        SOH."Member No.", SOH."Payroll/Staff No.", SOH."Allow Partial Deduction",
                                        DeductionStatus, SOH.Amount, AvailableBal, SOH."Effective/Start Date", SOH."Duration (Months)",
                                        SOH."Frequency (Months)", SOH."End Date", SOH.Description, SOH."Transfered to EFT", false);
    end;


    procedure getChargeAmount(StandingOrderHeader: Record "Standing Order Header")
    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
    begin
        TCharges := 0;
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                ChargeAmount := 0;
                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                    ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransactionCharges."Charge Amount";

                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                    if TariffDetails.Find('-') then begin
                        repeat
                            if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" then
                                    ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                else
                                    ChargeAmount := TariffDetails."Charge Amount";
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;

                TChargeAmount += ChargeAmount;
            until TransactionCharges.Next = 0;
        end;
        TCharges := TChargeAmount;
    end;


    procedure getTransactionCharges(StandingOrderHeader: Record "Standing Order Header")
    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
    begin
        //*Charges Posting
        TCharges := 0;
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                ChargeAmount := 0;
                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                    ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransactionCharges."Charge Amount";

                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                    if TariffDetails.Find('-') then begin
                        repeat
                            if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" then
                                    ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                else
                                    ChargeAmount := TariffDetails."Charge Amount";
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;

                LineN += 1;
                GenJLine.Init;
                GenJLine."Journal Template Name" := JTemplate;
                GenJLine."Journal Batch Name" := JBatch;
                GenJLine."Line No." := LineN;
                GenJLine."Posting Date" := Today;
                GenJLine."Document No." := StandingOrderHeader."No.";
                GenJLine."External Document No." := StandingOrderHeader."Member No.";
                GenJLine."Account Type" := StandingOrderHeader."Source Account Type";
                GenJLine.Validate(GenJLine."Account No.", StandingOrderHeader."Source Account No.");
                GenJLine.Description := TransactionCharges.Description;
                GenJLine.Validate(GenJLine.Amount, ChargeAmount);
                GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                GenJLine.Validate(GenJLine."Bal. Account No.", TransactionCharges."G/L Account");
                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
                if GenJLine.Amount <> 0 then
                    GenJLine.Insert;

                TChargeAmount += ChargeAmount;
            until TransactionCharges.Next = 0;
        end;
        TCharges := TChargeAmount;
    end;


    procedure InitializeStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[10]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Text; Reft: Boolean; RTransferEft: Boolean)
    var
        LineNo: Code[10];
        StandingOrdSRegister: Record "Standing Order Register";
    begin
        StandingOrdSRegister.Init;
        StandingOrdSRegister."No." := RNo;
        StandingOrdSRegister."Date Processed" := RDateProcessed;
        StandingOrdSRegister."Document No." := RDocNo;
        StandingOrdSRegister."No. Series" := RNoSeries;
        StandingOrdSRegister."Source Account No." := RSourceAccountNo;
        StandingOrdSRegister."Source Account Name" := RSourceAccountName;
        StandingOrdSRegister."Member No" := RMemberNo;
        StandingOrdSRegister."Staff/Payroll No." := RStaffNo;
        StandingOrdSRegister."Allow Partial Deduction" := RPartialDeduction;
        StandingOrdSRegister."Deduction Status" := RDeductionStatus;
        StandingOrdSRegister.Amount := RDeductionAmount;
        StandingOrdSRegister."Amount Deducted" := RAmountDeducted;
        StandingOrdSRegister."Effective/Start Date" := RStartDate;
        StandingOrdSRegister.Duration := RDuration;
        StandingOrdSRegister.Frequency := RFrequency;
        StandingOrdSRegister."End Date" := REndDate;
        StandingOrdSRegister.Remarks := Rremarks;
        StandingOrdSRegister.EFT := Reft;
        StandingOrdSRegister."Transfered to EFT" := RTransferEft;
        StandingOrdSRegister.Insert(true);
    end;


    procedure GeneratePerformingLoanInt(IntHeader: Record "Interest Header")
    begin
        begin
            IntHeader.TestField(Description);
            IntHeader.TestField(Status, intheader.Status::Approved);
            IntHeader.TestField("Posting Date", Today);
            //Report.Run(Report::"Gen.Int-Performing Loans");
        end;
    end;


    procedure PostPerformingLoanInt(IntHeader: Record "Interest Header")
    var
        JournalPosting: Codeunit "Journal Posting";
        OfficeTemp: Record "Banking User Template";
        Template: Code[80];
        Batch: Code[80];
        InterestLines: Record "Loans Interest";
        LineNo: Integer;
        SusIntAccounts: Record "Suspended Interest Accounts";
    begin
        begin
            IntHeader.TestField("Posting Date", Today);
            IntHeader.TestField(Description);
            IntHeader.TestField(Status, intheader.Status::Approved);
            IntHeader.TestField(Posted, false);

            OfficeTemp.Get(UserId);
            OfficeTemp.TestField("Interest Account Template");
            OfficeTemp.TestField("Interest Account Batch");
            Template := OfficeTemp."Interest Account Template";
            Batch := OfficeTemp."Interest Account Batch";

            if Confirm(MsgOnConfirmDialog, true) = false then
                exit;

            JournalPosting.ClearJournalLines(Template, Batch);

            InterestLines.Reset;
            // InterestLines.SetRange(No, "No.");
            InterestLines.SetRange(Posted, false);
            InterestLines.SetFilter("Bal. Account No.", '<>%1', '');
            InterestLines.SetFilter("Bal. Account No.(Suspended)", '<>%1', '');
            if InterestLines.Find('-') then begin
                repeat
                    LineNo := LineNo + 1000;

                    // JournalPosting.PostJournal(Template, Batch, LineNo, 0, "No.", Description,
                    // InterestLines."Interest Amount" * -1, InterestLines."Bal. Account No.", "Posting Date", 0,
                    // InterestLines."Bal. Account No.(Suspended)", InterestLines."Loan No.", InterestLines."Shortcut Dimension 1 Code",
                    // "Shortcut Dimension 2 Code", 0, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    JournalPosting.LinesCompletePosting(Template, Batch);

                    InterestLines.Posted := true;
                    InterestLines.Transferred := true;
                    InterestLines.Modify;

                    if InterestLines.Posted = true then begin
                        SusIntAccounts.Reset;
                        SusIntAccounts.SetRange("Loan No.", InterestLines."Loan No.");
                        if SusIntAccounts.Find('-') then begin
                            SusIntAccounts.ModifyAll("Transferred to income Ac", true);
                        end;
                    end;

                until InterestLines.Next = 0;
            end;

            // Posted := true;
            // "Posted By" := UserId;
            // IntHeader.Modify;


            // if Posted = true then Message(MsgOnPostCompletion, "No.", Description);
        end;
    end;


    procedure PerformExemptionsOnLoanApplic(Loans: Record Loans)
    var
        ExemptionsDocApprvls: Codeunit "Journal Posting";
        DocExemptApprvls: Record "Document Exemptions Auth.";
    begin
        begin
            DocExemptApprvls.Reset;
            // DocExemptApprvls.SetRange("Document No.", "Loan No.");
            if DocExemptApprvls.Find('-') then begin
                DocExemptApprvls.DeleteAll;
            end;

            // ExemptionsDocApprvls.InsertIntoExemptApprvls('', 0, "Loan No.", 0, '', UserId,
            //   '', 0, CurrentDatetime, CurrentDatetime, UserId, true, Today, "Recommended Amount",
            //   "Approved Amount", 0, 0, "Amount To Disburse", Database::Loans, '', "Comment for Exemptions");
        end;
    end;


    procedure InsertNewValue(DocExempts: Record "Document Exemptions Auth.")
    var
        Loans: Record Loans;
    begin
        begin
            // if Loans.Get("Document No.") then
            //     Loans."Amount To Disburse" := "Available Credit Limit (LCY)";
            Loans.Modify;
        end;
    end;
}
