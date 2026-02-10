#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186730 "Process Interest Calculation"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            CalcFields = "Balance (LCY)";
            DataItemTableView = where("Balance (LCY)" = filter(< 0), "Product Category" = filter("FOSA Account"));

            trigger OnAfterGetRecord()
            var
                ProdFact: Record "Product Factory";
                SavAcc: Record "Savings Accounts";
                InterestAmt: Decimal;
            begin
                PDate := 0D;
                DocNo := '';
                DActivity2 := '';
                DBranch2 := '';

                Temp.Get(UserId);
                Jtemplate := Temp."Cashier Journal Template";
                JBatch := Temp."Cashier Journal Batch";
                LineNo := 0;
                InterestAmt := 0;

                if Jtemplate = '' then begin
                    Error('Ensure the Cashier Journal Template is set up in Banking User Setup');
                end;

                if JBatch = '' then begin
                    Error('Ensure the Cashier Journal Batch is set up in Banking User Setup');
                end;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;

                if SavAcc.Get(SavingsAccounts."No.") then begin
                    if not (SavAcc."Last ov int Charged Date" >= (CalcDate('-CM', Today))) and not (SavAcc."Last ov int Charged Date" <= (CalcDate('CM', Today))) or (SavAcc."Last ov int Charged Date" = 0D) then begin
                        SavAcc.CalcFields("Balance (LCY)");
                        If SavAcc."Balance (LCY)" < 0 then begin
                            ProdFact.Get(SavAcc."Product Type");
                            //if SavAcc."Product Category" = ProdFact."Product Category"::"FOSA Account" then begin
                            if ProdFact."Over Draft Interest %" > 0 then
                                ProdFact.TestField("Over Draft Interest Account");
                            InterestAmt := ((ProdFact."Over Draft Interest %") * (SavAcc."Balance (LCY)")) / 100;

                            PDate := Today;
                            DocNo := SavAcc."No.";
                            DActivity2 := SavAcc."Global Dimension 1 Code";
                            DBranch2 := SavAcc."Global Dimension 2 Code";

                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            AccNo := ProdFact."Over Draft Interest Account";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            Amt := InterestAmt;
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, 'Desc' + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                          BalAccNo, '', DActivity2, DBranch2, TransType, SavAcc."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            LineNo := LineNo + 10000;
                            AccType := Acctype::Savings;
                            AccNo := SavAcc."No.";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::"G/L Account";
                            BalAccNo := '';
                            Amt := -InterestAmt;

                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, 'Desc' + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                          BalAccNo, '', DActivity2, DBranch2, TransType, SavAcc."No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            JournalPosting.CompletePosting(Jtemplate, Jbatch);
                            SavAcc."Last ov int Charged Date" := Today;
                            SavAcc.Modify();
                            //end;
                        end;
                    end;
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


        GenJournalLine: Record "Gen. Journal Line";

        DefaultBatch: Record "Gen. Journal Batch";
        Temp: Record "Banking User Template";
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        GenSetup: Record "General Set-Up";
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


}

