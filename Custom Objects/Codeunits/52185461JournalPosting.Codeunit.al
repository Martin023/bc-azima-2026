#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185461 "Journal Posting"
{

    trigger OnRun()
    begin
    end;

    var
        GenJnl: Record "Gen. Journal Line";
        LoanInt: Record "Loans Interest";
        GenJournalBatch: Record "Gen. Journal Batch";


    procedure PostJournal(Template: Code[20]; BatchName: Code[20]; LineNo: Integer; AcctType: Enum "Gen. Journal Account Type"; DocNo: Code[20]; Descr: Text[50]; Amount: Decimal; AccNo: Code[20]; PostingDate: Date; BalAccType: Enum "Gen. Journal Account Type"; BalAccNo: Code[20]; ExtDocNo: Code[20]; Dim1: Code[20]; Dim2: Code[20]; TransactionType: Enum "Transaction Types"; LoanNo: Code[20]; GroupCode: Code[10]; AppliesToDocNo: Code[20]; DocType: Enum "Gen. Journal Document Type"; CurrCode: Code[20]; AppliesToDocType: Enum "Gen. Journal Document Type")
    var
        GenBatches: Record "Gen. Journal Batch";
    begin


        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", Template);
        GenBatches.SetRange(GenBatches.Name, BatchName);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := Template;
            GenBatches.Name := BatchName;
            GenBatches.Description := Descr;
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;

        GenJnl.Init;
        GenJnl."Journal Template Name" := Template;
        GenJnl."Journal Batch Name" := BatchName;
        GenJnl."Line No." := LineNo;
        GenJnl."Account Type" := AcctType;
        GenJnl."Document No." := DocNo;
        GenJnl."Posting Date" := PostingDate;
        GenJnl."Account No." := AccNo;
        GenJnl.Validate(GenJnl."Account No.");
        GenJnl.Description := Descr;
        GenJnl.Amount := Amount;
        GenJnl.Validate(GenJnl.Amount);
        GenJnl."Bal. Account Type" := BalAccType;
        GenJnl."Bal. Account No." := BalAccNo;
        GenJnl.Validate(GenJnl."Bal. Account No.");
        GenJnl."Loan No" := LoanNo;
        GenJnl."Transaction Type" := TransactionType;
        GenJnl."Group Code" := GroupCode;
        GenJnl."Applies-to Doc. No." := AppliesToDocNo;
        GenJnl."External Document No." := ExtDocNo;
        GenJnl.Validate(GenJnl."Applies-to Doc. No.");
        GenJnl."Document Type" := DocType;
        GenJnl."Currency Code" := CurrCode;
        GenJnl."Shortcut Dimension 1 Code" := Dim1;
        GenJnl."Shortcut Dimension 2 Code" := Dim2;
        GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
        GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
        GenJnl.Validate(GenJnl."Currency Code");
        GenJnl."Applies-to Doc. Type" := AppliesToDocType;
        if GenJnl.Amount <> 0 then
            GenJnl.Insert;
    end;


    procedure CompletePosting(Template: Code[20]; Batch: Code[20])
    begin
        /*GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE("Journal Template Name",Template);
        GenJournalBatch.SETRANGE(Name,Batch);
        IF GenJournalBatch.FINDFIRST THEN
          */
        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", Template);
        GenJnl.SetRange("Journal Batch Name", Batch);
        if GenJnl.FindFirst then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJnl);

    end;


    procedure ClearJournalLines(Template: Code[10]; Batch: Code[10])
    begin

        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", Template);
        GenJnl.SetRange("Journal Batch Name", Batch);
        GenJnl.DeleteAll;
    end;

    procedure ClearJournalLines(Template: Code[10]; Batch: Code[10]; CheckIfExists: Boolean)
    begin

        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", Template);
        GenJnl.SetRange("Journal Batch Name", Batch);
        if CheckIfExists then begin
            If GenJnl.FindFirst() then
                GenJnl.DeleteAll;
        end else
            GenJnl.DeleteAll();

    end;


    procedure LinesCompletePosting(Template: Code[20]; Batch: Code[20])
    begin
        GenJnl.Reset;
        GenJnl.SetRange(GenJnl."Journal Template Name", Template);
        GenJnl.SetRange(GenJnl."Journal Batch Name", Batch);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJnl);
    end;


    procedure InsertIntoInterestLines(LineNo: Code[80]; MemberNo: Code[100]; LoanNo: Code[100]; LoanType: Code[50]; AccNo: Code[100]; AccType: Enum "Gen. Journal Account Type"; Cashier: Code[100]; DateCaptured: Date; GlobalDim: Code[50]; ShortCutDim: Code[50]; IntAmt: Decimal; IntDate: Date; AccNoSusp: Code[100])
    begin

        LoanInt.Init;

        LoanInt.No := LineNo;
        LoanInt."Account No" := MemberNo;
        LoanInt."Loan No." := LoanNo;
        LoanInt."Loan Product type" := LoanType;
        LoanInt."Bal. Account No." := AccNo;
        LoanInt."Bal. Account Type" := AccType;
        LoanInt."Bal. Account No.(Suspended)" := AccNoSusp;
        LoanInt."User ID" := Cashier;
        LoanInt."Interest Amount" := IntAmt;
        LoanInt."Interest Date" := IntDate;
        LoanInt."Date Captured" := DateCaptured;
        LoanInt."Shortcut Dimension 1 Code" := GlobalDim;
        LoanInt."Shortcut Dimension 2 Code" := ShortCutDim;
        if LoanInt."Interest Amount" > 0 then
            LoanInt.Insert(true);
    end;

}
