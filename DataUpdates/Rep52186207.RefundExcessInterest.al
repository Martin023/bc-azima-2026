namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Finance.GeneralLedger.Journal;

report 52186208 ClearLoanBalless100
{
    ApplicationArea = All;
    Caption = 'Clear Loan Bal With less 100';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {

            CalcFields = "Total Balance";
            //DataItemTableView = where("Total Balance" = filter(0 .. 100));
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                AmtDeducted := 0;
                Loans.CalcFields("Total Balance", "Amount In Arreas SACCO");
                RunBal := Loans."Net Amount";
                SavingAcc.reset();
                SavingAcc.setrange("Member No.", Loans."Member No.");
                SavingAcc.setrange(SavingAcc."Product Type", 'ODS');
                if SavingAcc.findfirst() then begin
                    if SavingAcc.GetAvailableBalance(SavingAcc."No.") <= RunBal then begin
                        RunBal := SavingAcc.GetAvailableBalance(SavingAcc."No.");
                        LoanArr.Reset();
                        LoanArr.setRange("Member No.", Loans."Member No.");
                        // LoanArr.SetCurrentKey("Disbursement Date");
                        // LoanArr.SetAscending("Disbursement Date", true);
                        LoanArr.SetFilter("Loan Product Type", '<>FGL&<>BGL');
                        LoanArr.CalcFields("Loans Category-SASRA");
                        LoanArr.SetFilter("Loans Category-SASRA", '<>%1', LoanArr."Loans Category-SASRA"::Perfoming);
                        LoanArr.CalcFields("Total Balance", "Amount In Arreas SASRA");
                        LoanArr.SetFilter("Total Balance", '>0');
                        LoanArr.setfilter("Amount In Arreas SASRA", '>0');
                        if LoanArr.findset() then begin
                            repeat
                                MaxAmt := 0;
                                AmtDeducted := 0;
                                LoanArr.CalcFields("Outstanding Balance", "Outstanding Interest", "Amount In Arreas SASRA");
                                MaxAmt := LoanArr."Amount In Arreas SASRA";
                                if RunBal > 0 then begin
                                    if RunBal <= MaxAmt then begin
                                        if (LoanArr."Outstanding Interest") > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine."Document No." := DocumentNo;
                                            GenJournalLine."External Document No." := Loans."Loan No.";
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                            GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                            GenJournalLine.Description := PadStr('Loan arrears-recovery from:-' + Loans."Loan No." + '-' +
                                                                         Format(GenJournalLine."transaction type"::"Interest Paid"), 50);


                                            if LoanArr."Outstanding Interest" >= RunBal then begin
                                                GenJournalLine.Amount := RunBal * -1;
                                                AmtDeducted += RunBal;
                                                RunBal := 0;
                                            end
                                            else begin
                                                GenJournalLine.Amount := LoanArr."Outstanding Interest" * -1;
                                                RunBal -= Abs(LoanArr."Outstanding Interest");
                                                AmtDeducted += Abs(LoanArr."Outstanding Interest");
                                            end;
                                            GenJournalLine.validate(Amount);
                                            GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;

                                        if (LoanArr."Outstanding Balance" > 0) then begin
                                            if RunBal > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine."Document No." := DocumentNo;
                                                GenJournalLine."External Document No." := Loans."Loan No.";
                                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                                GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                                GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::Repayment), 50);

                                                if LoanArr."Outstanding Balance" >= RunBal then begin
                                                    GenJournalLine.Amount := RunBal * -1;
                                                    AmtDeducted += RunBal;
                                                    RunBal := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanArr."Outstanding Balance" * -1;
                                                    RunBal -= Abs(LoanArr."Outstanding Balance");
                                                    AmtDeducted += Abs(LoanArr."Outstanding Balance");
                                                end;
                                                GenJournalLine.validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                            end;
                                        end;
                                    end
                                    else begin
                                        LoanArr.CalcFields("Total Balance", "Outstanding Balance", "Outstanding Interest");
                                        if LoanArr."Total Balance" > 0 then begin
                                            if (LoanArr."Outstanding Interest") > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine."Document No." := DocumentNo;
                                                GenJournalLine."External Document No." := Loans."Loan No.";
                                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                                GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                                GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                                if LoanArr."Outstanding Interest" >= MaxAmt then begin
                                                    GenJournalLine.Amount := MaxAmt * -1;
                                                    AmtDeducted += MaxAmt;
                                                    RunBal -= MaxAmt;
                                                    MaxAmt := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanArr."Outstanding Interest" * -1;
                                                    RunBal -= Abs(LoanArr."Outstanding Interest");
                                                    AmtDeducted += Abs(LoanArr."Outstanding Interest");
                                                    MaxAmt -= Abs(LoanArr."Outstanding Interest");
                                                end;
                                                GenJournalLine.Validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                            end;

                                            if (LoanArr."Outstanding Balance" > 0) then begin
                                                if RunBal > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := JBatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := Today;
                                                    GenJournalLine."Document No." := DocumentNo;
                                                    GenJournalLine."External Document No." := Loans."Loan No.";
                                                    GenJournalLine."Account Type" := genjournalline."Account Type"::Credit;
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                                    GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                    // if LoanApps."Outstanding Balance" >= RunBal then begin
                                                    //     GenJournalLine.Amount := RunBal * -1;
                                                    //     AmtDeducted += RunBal;
                                                    //     RunBal := 0;
                                                    // end
                                                    // else begin
                                                    //     GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                    //     RunBal -= Abs(LoanApps."Outstanding Balance");
                                                    //     AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                    // end;
                                                    if LoanArr."Outstanding Balance" >= MaxAmt then begin
                                                        GenJournalLine.Amount := MaxAmt * -1;
                                                        AmtDeducted += MaxAmt;
                                                        RunBal -= MaxAmt;
                                                        MaxAmt := 0;
                                                    end
                                                    else begin
                                                        GenJournalLine.Amount := LoanArr."Outstanding Balance" * -1;
                                                        RunBal -= Abs(LoanArr."Outstanding Balance");
                                                        AmtDeducted += Abs(LoanArr."Outstanding Balance");
                                                        MaxAmt -= Abs(LoanArr."Outstanding Balance");
                                                    end;
                                                    GenJournalLine.Validate(Amount);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                end;
                                            end;
                                        end;
                                    end;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."Document No." := 'LOANARREARSREC';
                                    GenJournalLine."External Document No." := loans."Loan No.";
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                                    GenJournalLine.Validate(GenJournalLine."Account No.", SavingAcc."No.");
                                    //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                                    GenJournalLine.Description := PadStr('Arrears recovery for ' + loanArr."Loan No.", 50);
                                    GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;

                            until LoanArr.next = 0;
                        end;
                        // if SavingAcc.GetAvailableBalance(SavingAcc."No.") >= Loans."Amount In Arreas SASRA" then begin
                        //     Loans.CalcFields("Outstanding Interest");
                        //     if Loans."Outstanding Interest" > 0 then begin
                        //         //if CreditLedgerEntry."Amount" <> 0 then begin
                        //         LineNo := LineNo + 10000;
                        //         GenJournalLine.Init;
                        //         GenJournalLine."Journal Template Name" := Jtemplate;
                        //         GenJournalLine."Journal Batch Name" := JBatch;
                        //         GenJournalLine."Document No." := DocumentNo;
                        //         GenJournalLine."Line No." := LineNo;
                        //         GenJournalLine."Account Type" := GenJournalLine."account type"::credit;
                        //         GenJournalLine."Account No." := Loans."Loan Account";
                        //         GenJournalLine."Loan No" := Loans."Loan No.";
                        //         GenJournalLine."External Document No." := Loans."Loan No.";
                        //         GenJournalLine.Validate(GenJournalLine."Account No.");
                        //         GenJournalLine."Posting Date" := Today;
                        //         GenJournalLine.Description := desc;
                        //         GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //         GenJournalLine.Amount := -Loans."Outstanding Interest";
                        //         GenJournalLine.Validate(GenJournalLine.Amount);
                        //         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        //         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        //         GenJournalLine."Bal. Account No." := '';
                        //         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //         GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                        //         GenJournalLine."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
                        //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //         if GenJournalLine.Amount <> 0 then
                        //             GenJournalLine.Insert;

                        //         AmtDeducted += Loans."Outstanding Interest";
                        //         //end;
                        //     end;
                        //     Loans.CalcFields("Outstanding Balance");
                        //     // else
                        //     if Loans."Outstanding Balance" > 0 then begin
                        //         LineNo := LineNo + 10000;
                        //         GenJournalLine.Init;
                        //         GenJournalLine."Journal Template Name" := Jtemplate;
                        //         GenJournalLine."Journal Batch Name" := JBatch;
                        //         GenJournalLine."Document No." := DocumentNo;
                        //         GenJournalLine."Line No." := LineNo;
                        //         GenJournalLine."Account Type" := GenJournalLine."account type"::credit;
                        //         GenJournalLine."Account No." := Loans."Loan Account";
                        //         GenJournalLine."External Document No." := Loans."Loan No.";
                        //         GenJournalLine."Loan No" := Loans."Loan No.";
                        //         GenJournalLine.Validate(GenJournalLine."Account No.");
                        //         GenJournalLine."Posting Date" := Today;
                        //         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                        //         GenJournalLine.Description := Desc;
                        //         GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //         GenJournalLine.Amount := -Loans."Outstanding Balance";
                        //         GenJournalLine.Validate(GenJournalLine.Amount);
                        //         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        //         GenJournalLine."Bal. Account No." := '';
                        //         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //         GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                        //         GenJournalLine."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
                        //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //         if GenJournalLine.Amount <> 0 then
                        //             GenJournalLine.Insert;

                        //         AmtDeducted += Loans."Outstanding Balance";
                        //     end;

                        //     LineNo := LineNo + 10000;
                        //     GenJournalLine.Init;
                        //     GenJournalLine."Journal Template Name" := Jtemplate;
                        //     GenJournalLine."Journal Batch Name" := JBatch;
                        //     GenJournalLine."Document No." := DocumentNo;
                        //     GenJournalLine."Line No." := LineNo;
                        //     GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        //     GenJournalLine."Account No." := SavingAcc."No.";
                        //     GenJournalLine."Loan No" := '';
                        //     GenJournalLine."External Document No." := Loans."Loan No.";
                        //     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //     GenJournalLine."Posting Date" := Today;
                        //     GenJournalLine.Description := desc;
                        //     GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //     GenJournalLine.Amount := AmtDeducted;
                        //     GenJournalLine.Validate(GenJournalLine.Amount);
                        //     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::" ";
                        //     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        //     GenJournalLine."Bal. Account No." := '';
                        //     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //     GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                        //     GenJournalLine."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
                        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //     if GenJournalLine.Amount <> 0 then
                        //         GenJournalLine.Insert;
                        //     //end;
                        // end;
                        // 
                    end;
                end;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DocumentNo; DocumentNo)
                    {
                        ShowMandatory = true;
                        Caption = 'Document No.';
                    }
                    field(Desc; Desc)
                    {
                        Caption = 'Description';
                        ShowMandatory = true;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        LineNo := 0;
        Temp.Get(UserId);

        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";

        if DocumentNo = '' then Error('Document Number must be provided');
        if Desc = '' then Error('Description must be provided');

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll();
    end;

    procedure CheckAllBalances(MemberNo: code[30])
    begin

    end;

    var

        SavingAcc: Record "Savings Accounts";
        ProdFact: record "Product Factory";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocumentNo: code[20];
        Desc: text[90];
        AmtDeducted: Decimal;
        LoanArr: Record loans;
        RunBal: Decimal;
        MaxAmt: Decimal;


}
