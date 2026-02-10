#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185664 "Bank Acc. Recon Manual"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Bank Acc. Recon Manual.rdl';

    dataset
    {
        dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
        {
            DataItemTableView = sorting(Reconciled, "Transaction Date") order(descending);
            RequestFilterFields = "Bank Account No.", "Statement Type", "Statement No.";
            column(ReportForNavId_1210; 1210)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(BankEndBalance; BankEndBalance)
            {
            }
            column(DiffrenceTotal; DiffrenceTotal)
            {
            }
            column(BankStatBalance; BankStatBalance)
            {
            }
            column(ReconCBBalance; ReconCBBalance)
            {
            }
            column(Bank_Acc__Reconciliation_Line__Bank_Account_No__; "Bank Account No.")
            {
            }
            column(CashBkBal; CashBkBal)
            {
            }
            column(CashBkBal_BankStatBalance; CashBkBal - BankStatBalance)
            {
            }
            column(BankName; BankName)
            {
            }
            column(VarBankRec__Statement_Date_; VarBankRec."Statement Date")
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CashBkBal_BankStatBalance_Control58; CashBkBal - BankStatBalance)
            {
            }
            column(TotalUnPresented_TotalDifference; TotalUnPresented + TotalDifference)
            {
            }
            column(Bank_Acc__Reconciliation_Line__Document_No__; "Document No.")
            {
            }
            column(Bank_Acc__Reconciliation_Line__Transaction_Date_; "Transaction Date")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Description; Description)
            {
            }
            column(Bank_Acc__Reconciliation_Line__Applied_Amount_; "Applied Amount")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Reconciled; Reconciled)
            {
            }
            column(Bank_Acc__Reconciliation_Line__Check_No__; "Check No.")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Difference; Difference)
            {
            }
            column(TotalUnPresented_TotalDifference_Control13; TotalUnPresented + TotalDifference)
            {
            }
            column(UncreditedChqs; UncreditedChqs)
            {
            }
            column(TotalUnpresentedChqs; TotalUnpresentedChqs)
            {
            }
            column(TotalDifference; TotalDifference)
            {
            }
            column(BANK_ACCOUNT_RECONCILIATION_REPORTCaption; BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Code_Caption; Bank_Code_CaptionLbl)
            {
            }
            column(Bank_Name_Caption; Bank_Name_CaptionLbl)
            {
            }
            column(Reconciliation_as_at_Caption; Reconciliation_as_at_CaptionLbl)
            {
            }
            column(Bank_Account_balance_as_per_Cash_Book_Caption; Bank_Account_balance_as_per_Cash_Book_CaptionLbl)
            {
            }
            column(Balance_on_Bank_Statement_Caption; Balance_on_Bank_Statement_CaptionLbl)
            {
            }
            column(Difference_to_be_Explained_Caption; Difference_to_be_Explained_CaptionLbl)
            {
            }
            column(Bank_Account_No_Caption; Bank_Account_No_CaptionLbl)
            {
            }
            column(Difference_between_Cash_book_and_Bank_Statement_BalanceCaption; Difference_between_Cash_book_and_Bank_Statement_BalanceCaptionLbl)
            {
            }
            column(Total_Unreconciling_itemsCaption; Total_Unreconciling_itemsCaptionLbl)
            {
            }
            column(Bank_Acc__Reconciliation_Line__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Bank_Acc__Reconciliation_Line_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ReconciledCaption; ReconciledCaptionLbl)
            {
            }
            column(Cheque_No_Caption; Cheque_No_CaptionLbl)
            {
            }
            column(Bank_Acc__Reconciliation_Line_DifferenceCaption; FieldCaption(Difference))
            {
            }
            column(Differences_Expalined_by_Uncredited_and_Unpresented_Cheques_Caption; Differences_Expalined_by_Uncredited_and_Unpresented_Cheques_CaptionLbl)
            {
            }
            column(Difference_ExplainedCaption; Difference_ExplainedCaptionLbl)
            {
            }
            column(Uncredited_ChequesCaption; Uncredited_ChequesCaptionLbl)
            {
            }
            column(Unpresented_ChequesCaption; Unpresented_ChequesCaptionLbl)
            {
            }
            column(Items_in_bank_statement_not_in_cash_bookCaption; Items_in_bank_statement_not_in_cash_bookCaptionLbl)
            {
            }
            column(FINANCE_OFFICERCaption; FINANCE_OFFICERCaptionLbl)
            {
            }
            // column(DataItem1102760002;Reviewed_by______________________________________________________________Date_______________________________________________CLbl)
            // {
            // }
            // column(FINANCIAL_CONTROLLERCaption;FINANCIAL_CONTROLLERCaptionLbl)
            // {
            // }
            // column(DataItem1102760004;Approved_by______________________________________________________________Date_______________________________________________CLbl)
            // {
            // }
            // column(DataItem1102760000;Prepared_by______________________________________________________________Date_______________________________________________CLbl)
            // {
            // }
            column(FINANCE____ADMIN_MANAGERCaption; FINANCE____ADMIN_MANAGERCaptionLbl)
            {
            }
            column(Bank_Acc__Reconciliation_Line_Statement_No_; "Statement No.")
            {
            }
            column(Bank_Acc__Reconciliation_Line_Statement_Line_No_; "Statement Line No.")
            {
            }
            column(Finished; Finished)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Bank Acc. Reconciliation Line".Reconciled = false then begin
                    UncreditedChqs := 0;
                    if "Bank Acc. Reconciliation Line"."Applied Amount" > 0 then begin
                        UncreditedChqs := UncreditedChqs + "Bank Acc. Reconciliation Line"."Applied Amount";
                    end;
                end;

                if "Bank Acc. Reconciliation Line".Reconciled = false then begin
                    TotalUnpresentedChqs := 0;
                    if "Bank Acc. Reconciliation Line"."Applied Amount" < 0 then begin
                        TotalUnpresentedChqs := TotalUnpresentedChqs + "Bank Acc. Reconciliation Line"."Applied Amount";
                    end;
                end;

                //Total Diffrence
                BankReconLine_2.Reset;
                BankReconLine_2.SetCurrentkey("Statement Type", "Bank Account No.", "Statement No.", "Statement Line No.");
                BankReconLine_2.SetRange("Bank Account No.", "Bank Acc. Reconciliation Line"."Bank Account No.");
                BankReconLine_2.SetRange("Statement No.", "Bank Acc. Reconciliation Line"."Statement No.");
                // BankReconLine_2.SetRange(Type, "Bank Acc. Reconciliation Line".Type::Difference);
                if BankReconLine_2.Find('-') then begin
                    DiffrenceTotal := 0;
                    BankReconLine_2.CalcSums(Difference);
                    DiffrenceTotal := BankReconLine_2.Difference;

                end;


                //IF (((CashBkBal + (TotalUnpresentedChqs*-1) - UncreditedChqs) + DiffrenceTotal ) = BankAccReconciliation."Statement Ending Balance") THEN
                if (CashBkBal = (BankAccReconciliation."Statement Ending Balance" + TotalUnpresentedChqs + UncreditedChqs - DiffrenceTotal)) then begin
                    ReconciliationStatement := ''
                end else begin
                    ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Bank Account No.");
                TotalPresentedFunc;
                TotalUnpresentedFunc;
                TotalDiffFunc;
                GetBank;

                "Bank Acc. Reconciliation Line".SetRange("Bank Acc. Reconciliation Line"."Bank Account No.", VarBankRec."Bank Account No.");
                "Bank Acc. Reconciliation Line".SetRange("Bank Acc. Reconciliation Line"."Statement No.", VarBankRec."Statement No.");
                if (TotalUnPresented + TotalDifference) = (CashBkBal - BankStatBalance) then Finished := true;

                if TotalUnPresented <> 0 then IsDifferent := true;

                TotalDifference := 0;
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

    trigger OnPreReport()
    begin
        Company.Get;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        VarBankRec: Record "Bank Acc. Reconciliation";
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        TotalPresented: Decimal;
        TotalUnPresented: Decimal;
        BankStatBalance: Decimal;
        BankLastBalance: Decimal;
        BankName: Text[50];
        BankAcc: Record "Bank Account";
        CashBkBal: Decimal;
        Difference: Decimal;
        Company: Record "Company Information";
        UncreditedChqs: Decimal;
        BankAccNo: Code[30];
        ReconciliationStatement: Text[250];
        Finished: Boolean;
        PrintWithRecon: Boolean;
        IsDifferent: Boolean;
        TotalUnpresentedChqs: Decimal;
        TotalDifference: Decimal;
        BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl: label 'BANK ACCOUNT RECONCILIATION REPORT';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Bank_Code_CaptionLbl: label 'Bank Code:';
        Bank_Name_CaptionLbl: label 'Bank Name:';
        Reconciliation_as_at_CaptionLbl: label 'Reconciliation as at:';
        Bank_Account_balance_as_per_Cash_Book_CaptionLbl: label 'Bank Account balance as per Cash Book:';
        Balance_on_Bank_Statement_CaptionLbl: label 'Balance on Bank Statement:';
        Difference_to_be_Explained_CaptionLbl: label 'Difference to be Explained:';
        Bank_Account_No_CaptionLbl: label 'Bank Account No:';
        Difference_between_Cash_book_and_Bank_Statement_BalanceCaptionLbl: label 'Difference between Cash book and Bank Statement Balance';
        Total_Unreconciling_itemsCaptionLbl: label 'Total Unreconciling items';
        DateCaptionLbl: label 'Date';
        AmountCaptionLbl: label 'Amount';
        ReconciledCaptionLbl: label 'Reconciled';
        Cheque_No_CaptionLbl: label 'Cheque No.';
        Differences_Expalined_by_Uncredited_and_Unpresented_Cheques_CaptionLbl: label 'Differences Expalined by Uncredited and Unpresented Cheques ';
        Difference_ExplainedCaptionLbl: label 'Difference Explained';
        Uncredited_ChequesCaptionLbl: label 'Uncredited Cheques';
        Unpresented_ChequesCaptionLbl: label 'Unpresented Cheques';
        Items_in_bank_statement_not_in_cash_bookCaptionLbl: label 'Items in bank statement not in cash book';
        FINANCE_OFFICERCaptionLbl: label 'FINANCE OFFICER';
        // Reviewed_by______________________________________________________________Date_______________________________________________CLbl: label 'Reviewed by:........................................                     Date...............................................';
        // FINANCIAL_CONTROLLERCaptionLbl: label 'FINANCIAL CONTROLLER';
        // Approved_by______________________________________________________________Date_______________________________________________CLbl: label 'Approved by:........................................                     Date...............................................';
        // Prepared_by______________________________________________________________Date_______________________________________________CLbl: label 'Prepared by:........................................                     Date...............................................';
        FINANCE____ADMIN_MANAGERCaptionLbl: label 'FINANCE && ADMIN MANAGER';
        DiffrenceTotal: Decimal;
        BankReconLine_2: Record "Bank Acc. Reconciliation Line";
        ReconCBBalance: Decimal;
        BankEndBalance: Decimal;
        BankAccReconciliation: Record "Bank Acc. Reconciliation";


    procedure getbankRec(var BankRec: Record "Bank Acc. Reconciliation"; var StatementBalance: Decimal)
    begin
        VarBankRec := BankRec;
        BankStatBalance := StatementBalance;
        BankEndBalance := BankRec."Statement Ending Balance";
        BankStatBalance := BankRec."Statement Ending Balance";
        BankLastBalance := BankRec."Balance Last Statement";
    end;


    procedure TotalPresentedFunc()
    begin
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", VarBankRec."Statement No.");
        BankRecPresented.SetRange(BankRecPresented.Reconciled, true);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalPresented := TotalPresented + BankRecPresented."Applied Amount";
            until BankRecPresented.Next = 0;
        end;
    end;


    procedure TotalUnpresentedFunc()
    begin
        BankRecUnPresented.SetRange(BankRecUnPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecUnPresented.SetRange(BankRecUnPresented."Statement No.", VarBankRec."Statement No.");
        BankRecUnPresented.SetRange(BankRecUnPresented.Reconciled, false);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalUnPresented := TotalUnPresented + BankRecUnPresented."Applied Amount";
            until BankRecUnPresented.Next = 0;
        end;
    end;


    procedure GetBank()
    begin
        if BankAcc.Get(VarBankRec."Bank Account No.") then begin
            BankAcc.SetRange(BankAcc."Date Filter", 0D, VarBankRec."Statement Date");
            BankAcc.CalcFields(BankAcc."Balance at Date");
            CashBkBal := BankAcc."Balance at Date";
            BankName := BankAcc.Name;
            BankAccNo := BankAcc."Bank Account No.";
        end;
    end;


    procedure TotalDiffFunc()
    begin
        /*
        TotalDifference:=0;
        
        BankRecPresented.RESET;
        BankRecPresented.SETRANGE(BankRecPresented."Bank Account No.",VarBankRec."Bank Account No.");
        BankRecPresented.SETRANGE(BankRecPresented."Statement No.",VarBankRec."Statement No.");
        BankRecPresented.SETRANGE(Reconciled,FALSE);
        BankRecPresented.SETRANGE(Type,BankRecPresented.Type::Difference);
        IF BankRecPresented.FIND('-') THEN
        BEGIN
            REPEAT
        
                TotalDifference:=TotalDifference + BankRecPresented.Difference;
               // ERROR('%1',TotalDifference);
            UNTIL BankRecPresented.NEXT=0;
        END;
        
        */

    end;
}

