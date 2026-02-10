#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185707 "User Posting Dates Update"
{
    ProcessingOnly = true;

    UsageCategory = Administration;
    dataset
    {
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

    trigger OnPreReport()
    begin
        UserSetups.RESET;
        IF UserSetups.FindSet() THEN BEGIN
            REPEAT
                IF UserSetups."Extended Posting Date" = false then
                    UserSetups."Allow Posting From" := TODAY;
                UserSetups."Allow Posting To" := TODAY;
                UserSetups.MODIFY;
            UNTIL UserSetups.NEXT = 0;
        END;

        /*
        OverDraftAuthorisation.RESET;
        OverDraftAuthorisation.SETRANGE(Posted,TRUE);
        //OverDraftAuthorisation.SETRANGE("No.",'OD00016');
        OverDraftAuthorisation.SETFILTER("Expiry Date",'<%1',TODAY);
        IF OverDraftAuthorisation.FIND('-') THEN BEGIN
        REPEAT
          OverDraftAuthorisation.Expired:=TRUE;
          OverDraftAuthorisation.MODIFY;
          UNTIL OverDraftAuthorisation.NEXT=0;
          END;*/

        // Loans.Reset;
        // Loans.SetRange(Posted, false);
        // if Loans.Find('-') then begin
        //     repeat
        //         CreditLedgerEntry.Reset;
        //         CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
        //         if CreditLedgerEntry.Find('-') then begin
        //             Loans.Posted := true;
        //             Loans.Modify;
        //         end;
        //     until Loans.Next = 0;
        // end;


        // Loans.RESET;
        // Loans.SETRANGE(Posted,TRUE);
        // Loans.SETRANGE("Recovery Mode",Loans."Recovery Mode"::" ");
        // IF Loans.FIND('-') THEN BEGIN
        // REPEAT
        // IF ProductFactory.GET(Loans."Loan Product Type") THEN BEGIN
        // //Loans."Recovery Mode":=
        // END;
        // UNTIL Loans.NEXT=0;
        // END;


        //RepayLoans;

    end;

    var
        UserSetups: Record "User Setup";
        OverDraftAuthorisation: Record "Over Draft Authorisation";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Loans: Record Loans;
        CashierTransactions: Record "Cashier Transactions";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills;
        AccNo: Code[20];
        BalAccNo: Code[20];
        Amt: Decimal;
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";

    local procedure RepayLoans()
    var
        Loans: Record Loans;
        JournalPosting: Codeunit "Journal Posting";
        BankingUserTemplate: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineNo: Integer;
        Amount: Decimal;
        GeneralSetUp: Record "General Set-Up";
        ProductF: Record "Product Factory";
        AmountPaid: Decimal;
    begin
        /*BankingUserTemplate.GET(USERID);
        JTemplate:=BankingUserTemplate."Cashier Journal Template";
        JBatch:=BankingUserTemplate."Cashier Journal Batch";
        
        JournalPosting.ClearJournalLines(JTemplate,JBatch);
        CashierTransactions.RESET;
        CashierTransactions.SETRANGE(Type,CashierTransactions.Type::Lien);
        CashierTransactions.SETRANGE(Posted,TRUE);
        CashierTransactions.SETRANGE("Cheque Status",CashierTransactions."Cheque Status"::Pending);
        IF CashierTransactions.FIND('-') THEN BEGIN
        REPEAT
              AmountPaid:=0;
          Loans.RESET;
          Loans.SETRANGE("Loan No.",CashierTransactions."Transaction Description");
          Loans.SETFILTER("Date Filter",'..'+FORMAT(TODAY));
          IF Loans.FIND('-') THEN  BEGIN
          CreditLedgerEntry.RESET;
          CreditLedgerEntry.SETRANGE("Loan No",Loans."Loan No.");
          CreditLedgerEntry.SETFILTER("Transaction Type",'%1|%2',CreditLedgerEntry."Transaction Type"::Repayment,CreditLedgerEntry."Transaction Type"::"Interest Paid");
          IF CreditLedgerEntry.FIND('-') THEN BEGIN
          CreditLedgerEntry.CALCSUMS("Amount (LCY)");
          AmountPaid:=-CreditLedgerEntry."Amount (LCY)";
          MESSAGE('%1',AmountPaid);
          IF AmountPaid>=Loans.Repayment THEN BEGIN
        CashierTransactions."Cheque Status":=CashierTransactions."Cheque Status"::Honoured;
        CashierTransactions.MODIFY;
        END;
        END;
        END;
        UNTIL CashierTransactions.NEXT=0;
        END;
        
        
        CashierTransactions.RESET;
        CashierTransactions.SETRANGE(Type,CashierTransactions.Type::Lien);
        CashierTransactions.SETRANGE(Posted,TRUE);
        CashierTransactions.SETRANGE("Cheque Status",CashierTransactions."Cheque Status"::Pending);
        IF CashierTransactions.FIND('-') THEN BEGIN
        REPEAT
          SavAcc.GET(CashierTransactions."Account No");
          SavAcc.Blocked:=SavAcc.Blocked::" ";
          SavAcc.CALCFIELDS("Balance (LCY)");
          SavAcc.MODIFY;
            SavAcc.CALCFIELDS("Balance (LCY)");
           IF SavAcc."Balance (LCY)">=CashierTransactions.Amount THEN BEGIN
          Loans.RESET;
          Loans.SETRANGE("Loan No.",CashierTransactions."Transaction Description");
          Loans.SETFILTER("Date Filter",'..'+FORMAT(TODAY));
          IF Loans.FIND('-') THEN  BEGIN
            IF CALCDATE('CM+1M',Loans."Disbursement Date")<=TODAY THEN BEGIN
        
            Loans.CALCFIELDS("Outstanding Balance","Outstanding Bills","Outstanding Interest");
            IF Loans."Outstanding Interest">0 THEN BEGIN
        
                Amount:=CashierTransactions.Amount;
        
                IF Loans."Outstanding Interest"<Amount THEN
                  Amt:=Loans."Outstanding Interest";
        
                LineNo+=100;
        
                //Loan Interest
                IF Amt>0 THEN
                JournalPosting.PostJournal(JTemplate,JBatch,LineNo,AcctType::Credit,CashierTransactions.No,'Loan Interest Paid',-Amt,
                Loans."Loan Account",TODAY,BalAccType::"G/L Account",'','',CashierTransactions."Global Dimension 1 Code",CashierTransactions."Global Dimension 2 Code",
                TransType::"Interest Paid",Loans."Loan No.",'','',0,'',0);
        
                Amount-=Amt;
        
                LineNo+=100;
                //Loan Repayment
                IF Amount>0 THEN
                JournalPosting.PostJournal(JTemplate,JBatch,LineNo,AcctType::Credit,CashierTransactions.No,'Loan Repayment',-Amount,
                Loans."Loan Account",TODAY,BalAccType::"G/L Account",'','',CashierTransactions."Global Dimension 1 Code",CashierTransactions."Global Dimension 2 Code",
                TransType::Repayment,Loans."Loan No.",'','',0,'',0);
        
        
                IF ProductF.GET(Loans."Loan Product Type") THEN BEGIN
                   ProductF.TESTFIELD(ProductF."Billed Account");
                   BalAccNo:=ProductF."Billed Account";
                 END;
                LineNo+=100;
                //Loan Bills
                IF Amount>0 THEN
                JournalPosting.PostJournal(JTemplate,JBatch,LineNo,AcctType::Credit,CashierTransactions.No,'Loan Repayment Bills',-Amount,
                Loans."Loan Account",TODAY,BalAccType::"G/L Account",BalAccNo,'',CashierTransactions."Global Dimension 1 Code",CashierTransactions."Global Dimension 2 Code",
                TransType::Bills,Loans."Loan No.",'','',0,'',0);
        
                LineNo+=100;
                //Debit Savings;
                JournalPosting.PostJournal(JTemplate,JBatch,LineNo,AcctType::Savings,CashierTransactions.No,'Loan Repayment',CashierTransactions.Amount,
                Loans."Disbursement Account No",TODAY,BalAccType::"G/L Account",'','',CashierTransactions."Global Dimension 1 Code",CashierTransactions."Global Dimension 2 Code",
                TransType::Repayment,Loans."Loan No.",'','',0,'',0);
        
                  CashierTransactions."Cheque Status":=CashierTransactions."Cheque Status"::Honoured;
                  CashierTransactions.MODIFY;
                END;
                END;
        
            END;
            END;
          UNTIL CashierTransactions.NEXT=0;
          JournalPosting.CompletePosting(JTemplate,JBatch);
         END;
         */

    end;
}
