#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185498 "VB Management"
{

    trigger OnRun()
    begin
        // RegerateSALSchedule;
        //Feel free to use
    end;


    procedure PostLoan(LoanRec: Record Loans) Posted: Boolean
    var
        GenJnlLn: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        vbSetup: Record "Savings Accounts";
        batchName: Code[10];
        memb: Record "Cash Office User Template";
        JBatch: Record "Gen. Journal Batch";
        Product: Record "Product Factory";
        vend: Record Vendor;
        LineNo: Integer;
        RevenueAmount: Decimal;
    begin

        Error('Posting not allowed');
        /*
        //Generate Schedule
        GenerateSchedule(LoanRec);
        vbSetup.GET(USERID);
        Product.GET(LoanRec."Loan Product Type");
        batchName:='L'+FORMAT(DATE2DMY(TODAY,1))+'-'+FORMAT(DATE2DMY(TODAY,2))+'-'+FORMAT(DATE2DMY(TODAY,3));
        LineNo:=0;
        //create Batch
        IF NOT JBatch.GET(vbSetup."Journal Template Loan",batchName) THEN BEGIN
         JBatch.INIT;
         JBatch."Journal Template Name":=vbSetup."Journal Template Loan";
         JBatch.Name :=batchName;
         JBatch.Status:=JBatch.Status::Approved;
         JBatch.INSERT;
        END;
        
        //Delete existig entries
        GenJnlLn.RESET;
        GenJnlLn.SETRANGE("Journal Template Name",vbSetup."Journal Template Loan");
        GenJnlLn.SETRANGE("Journal Batch Name",batchName);
        GenJnlLn.DELETEALL;
        
        //debit member
        GenJnlLn.INIT;
        GenJnlLn."Journal Template Name":=vbSetup."Journal Template Loan";
        GenJnlLn."Journal Batch Name":=batchName;
        LineNo+=10000;
        GenJnlLn."Line No.":=LineNo;
        GenJnlLn."Account Type":=GenJnlLn."Account Type"::Member;
        GenJnlLn."Account No.":=LoanRec."Client Code";
        GenJnlLn.VALIDATE("Account No.");
        GenJnlLn."Posting Date":=TODAY;
        GenJnlLn."Document No.":=LoanRec."Loan No.";
        GenJnlLn.Description:='Virtual Loan Disbursement '+LoanRec."Loan No.";
        GenJnlLn.Amount:=LoanRec."Approved Amount";
        GenJnlLn."Shortcut Dimension 1 Code":='';
        GenJnlLn."Transaction Type":=GenJnlLn."Transaction Type"::Loan;
        GenJnlLn."Loan No":=LoanRec."Loan No.";
        GenJnlLn."Loan Product Type":=LoanRec."Loan Product Type";
        IF GenJnlLn.Amount<>0 THEN
        GenJnlLn.INSERT;
        
        //credit vendor
        GenJnlLn.INIT;
        GenJnlLn."Journal Template Name":=vbSetup."Journal Template Loan";
        GenJnlLn."Journal Batch Name":=batchName;
        LineNo+=10000;
        GenJnlLn."Line No.":=LineNo;
        GenJnlLn."Posting Date":=TODAY;
        GenJnlLn."Document No.":=LoanRec."Loan No.";
        //get FOSA Account - Credit FOSA Account
        GenJnlLn."Account Type":=GenJnlLn."Account Type"::Vendor;
        GenJnlLn."Account No.":=LoanRec."Client Code";
        GenJnlLn.VALIDATE("Account No.");
        GenJnlLn.Description:='Virtual Loan Disbursement '+LoanRec."Loan No.";
        GenJnlLn.Amount:=LoanRec."Approved Amount"*-1;
        GenJnlLn."Shortcut Dimension 1 Code":='';
        GenJnlLn."Transaction Type":=GenJnlLn."Transaction Type"::Loan;
        GenJnlLn."Loan No":=LoanRec."Loan No.";
        GenJnlLn."Loan Product Type":=LoanRec."Loan Product Type";
        IF GenJnlLn.Amount<>0 THEN
        GenJnlLn.INSERT;
        
        //Dr vendorInterest
        GenJnlLn.INIT;
        GenJnlLn."Journal Template Name":=vbSetup."Journal Template Loan";
        GenJnlLn."Journal Batch Name":=batchName;
        LineNo+=10000;
        GenJnlLn."Line No.":=LineNo;
        GenJnlLn."Posting Date":=TODAY;
        GenJnlLn."Document No.":=LoanRec."Loan No.";
        //get FOSA Account - Credit FOSA Account
        GenJnlLn."Account Type":=GenJnlLn."Account Type"::Vendor;
        GenJnlLn."Account No.":=LoanRec."Client Code";
        GenJnlLn.VALIDATE("Account No.");
        GenJnlLn.Description:='Virtual Loan Disbursement '+LoanRec."Loan No.";
        GenJnlLn.Amount:=LoanRec.Interest;
        GenJnlLn."Shortcut Dimension 1 Code":='';
        GenJnlLn."Loan No":=LoanRec."Loan No.";
        GenJnlLn."Loan Product Type":=LoanRec."Loan Product Type";
        IF GenJnlLn.Amount<>0 THEN
        GenJnlLn.INSERT;
        
        
        //Cr Revenue Interest
        GenJnlLn.INIT;
        GenJnlLn."Journal Template Name":=vbSetup."Journal Template Loan";
        GenJnlLn."Journal Batch Name":=batchName;
        LineNo+=10000;
        GenJnlLn."Line No.":=LineNo;
        GenJnlLn."Account Type":=GenJnlLn."Account Type"::"G/L Account";
        GenJnlLn."Account No.":=Product."Loan Interest Account";
        GenJnlLn."Posting Date":=TODAY;
        GenJnlLn."Document No.":=LoanRec."Loan No.";
        GenJnlLn.Description:='Interest Revenue on Loan '+LoanRec."Loan No.";
        RevenueAmount:= LoanRec.Interest*Product."Service Tarrif Percentage";
        GenJnlLn.Amount:=RevenueAmount*-1;
        GenJnlLn."Shortcut Dimension 1 Code":='';
        GenJnlLn."Loan No":=LoanRec."Loan No.";
        GenJnlLn."Loan Product Type":=LoanRec."Loan Product Type";
        IF GenJnlLn.Amount<>0 THEN
        GenJnlLn.INSERT;
        
        //Cr Service Interest
        GenJnlLn.INIT;
        GenJnlLn."Journal Template Name":=vbSetup."Journal Template Loan";
        GenJnlLn."Journal Batch Name":=batchName;
        LineNo+=1000;
        GenJnlLn."Line No.":=LineNo;
        GenJnlLn."Account Type":=GenJnlLn."Account Type"::"G/L Account";
        GenJnlLn."Account No.":=Product."Revenue Share Account";
        GenJnlLn."Posting Date":=TODAY;
        GenJnlLn."Document No.":=LoanRec."Loan No.";
        GenJnlLn.Description:='CORETEC Interest Share ';
        GenJnlLn.Amount:=(LoanRec.Interest-RevenueAmount)*-1;
        GenJnlLn."Shortcut Dimension 1 Code":='';
        GenJnlLn."Loan No":=LoanRec."Loan No.";
        GenJnlLn."Loan Product Type":=LoanRec."Loan Product Type";
        IF GenJnlLn.Amount<>0 THEN
        GenJnlLn.INSERT;
        
        
        GenJnlLn.RESET;
        GenJnlLn.SETRANGE(GenJnlLn."Journal Template Name",vbSetup."Journal Template Loan");
        GenJnlLn.SETRANGE(GenJnlLn."Journal Batch Name",batchName);
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLn);
        
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Document No.","Posting Date");
        GLEntry.SETRANGE("Document No.",LoanRec."Loan No.");
        GLEntry.SETRANGE("Journal Batch Name",batchName);
        IF GLEntry.FINDSET THEN
        */
        Posted := true;

    end;


}
