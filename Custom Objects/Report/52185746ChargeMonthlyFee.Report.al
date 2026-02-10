#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185746 "Charge Monthly Fee"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where(Blocked = filter(<> All | Debit));
            column(ReportForNavId_2; 2)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ProductFactory.SetRange("Product ID", "Savings Accounts"."Product Type");
                ProductFactory.SetRange("Accrue Monthly", true);
                if ProductFactory.Find('-') then begin
                    //Accrue Registration Fee
                    // IF ProductFactory."Product Category"=ProductFactory."product category"::"Entrance Fee" THEN
                    //  BEGIN
                    AccountNo := "Savings Accounts"."No.";
                    ;
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := DocumentNo;//"Savings Accounts"."No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                    GenJournalLine."Account No." := "Savings Accounts"."No.";
                    GenJournalLine."External Document No." := AccountNo;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := PostingDAte;
                    GenJournalLine.Description := 'Accrued Fee' + AccountNo;
                    GenJournalLine.Amount := ProductFactory."Monthly Charges";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := ProductFactory."Accrual Fee Acc. (Income)";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := "Savings Accounts"."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := "Savings Accounts"."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //  END;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    //Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
                //Post
                Message('Posted Successful');
            end;

            trigger OnPreDataItem()
            begin
                if not Confirm('Do you want to apply charges for the accounts?') then exit;
                if DocumentNo = '' then Error('Document No must be filled');
                if PostingDAte = 0D then PostingDAte := Today;
                Temp.Get(UserId);
                AccountNo := '';
                Jtemplate := Temp."Accrual. Fee.Journal Template";
                JBatch := Temp."Accrual. Fee. Journal Batch";
                if Jtemplate = '' then begin
                    Error(Text0001);
                end;
                if JBatch = '' then begin
                    Error(Text0002);
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;
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
                field("Document No."; DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date."; PostingDAte)
                {
                    ApplicationArea = Basic;
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
        ProductFactory: Record "Product Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        AccountNo: Code[50];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        DocumentNo: Code[10];
        PostingDAte: Date;
}
