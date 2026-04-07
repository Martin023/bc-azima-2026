namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Finance.GeneralLedger.Journal;

report 52186243 "Dividend SMS"
{
    ApplicationArea = All;
    Caption = 'Dividend SMS';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }

            trigger OnAfterGetRecord()

            begin
                GenJournalLine.reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.FindSet() then
                    GenJournalLine.DeleteAll();

                DocNo := 'DIVSMS' + '-' + format(Members."No.");
                DivPostingBuffer.Reset;
                DivPostingBuffer.SetRange("Member No.", Members."No.");
                DivPostingBuffer.SetRange("Posted", true);
                DivPostingBuffer.SetRange("Product Type", '191');
                DivPostingBuffer.SetRange(Year, Year);
                DivPostingBuffer.setfilter(Amount, '<0');
                if DivPostingBuffer.Findfirst then begin
                    if Account.get(DivPostingBuffer."Account No.") then begin
                        AccBal := GlobalFunctions.GetSavingsAccountAvailableBalance(Account, true);
                        if AccBal < 0 then
                            AccBal := 0;
                        msg := 'Dear ' + Members."First Name" + ', your gross Dividends for the year ' + format((Date2DMY(today, 3) - 1)) + ' is KES ' + format(Abs(DivPostingBuffer.Amount)) + ' has been credited to your ordinary account. Your new Ordinary account balance is KES ' + Format(AccBal) + ' after deductions.';

                        SendSMS.SendSms(Source::SALARY_PROCESSING, Members."Phone No.", msg, Account."No.", '', true, 0, false, 'CBS', Account."No.", 'CBS');

                        Gensetup.Get();
                        if Gensetup."Loan SMS Charge" <> '' then begin
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."Loan SMS Charge");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    LineNo := 0;


                                    LineNo := LineNo + 10000;
                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (Abs(DivPostingBuffer.Amount) * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (Abs(DivPostingBuffer.Amount) >= TariffDetails."Lower Limit") and (Abs(DivPostingBuffer.Amount) <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := Abs(DivPostingBuffer.Amount) * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := DivPostingBuffer."Account No.";
                                    //GenJournalLine."External Document No.":="ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert(false);

                                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise Duty
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;

                                        //if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                        // else
                                        //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := DivPostingBuffer."Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert(false);
                                    end;
                                until TransactionCharges.Next = 0;
                            end;
                        end;
                    end;
                end;
                GenJournalLine.reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.FindSet() then
                    generalpostnew.Run(GenJournalLine);
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
                    field(Year; Year)
                    {
                        Caption = 'Year';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field(PDate; PDate)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
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
    var
        myInt: Integer;
    begin
        Temp.GET(USERID);
        Temp.TESTFIELD("Cashier Journal Template");
        Temp.TESTFIELD("Cashier Journal Batch");
        JBatch := Temp."Cashier Journal Batch";
        Jtemplate := Temp."Cashier Journal Template";

        if Year = 0 then
            Error('Please select Year to proceed');
    end;

    trigger OnPostReport()
    begin
        message('Dividend SMS sending process completed successfully.');
    end;

    var
        DivPostingBuffer: record "Dividend Posting Buffer";
        genjournalline: record "Gen. Journal Line";
        Account: record "Savings Accounts";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        Gensetup: Record "General Set-Up";
        LineNo: Integer;
        PDate: Date;
        DocNo: Code[20];
        GlobalFunctions: Codeunit "Global Functions";
        msg: Text[950];
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        Temp: record "Banking User Template";
        Jtemplate: Code[10];
        JBatch: Code[10];
        Year: Integer;
        generalpostnew: Codeunit "Gen. Jnl.-Post New";
        AccBal: Decimal;

}
