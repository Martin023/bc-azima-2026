#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187016 "Member and loan Statement"
{

    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Member statement';
    RDLCLayout = './bc-azima-2026/Layout/Member Statement New.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(TimeT; TimeT)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyAddress2; CompanyAddress2)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {

            }
            column(FOSAAccount; FOSAAccount)
            {

            }

            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Website; Website)
            {
            }

            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            { }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(Employer_Name; "Employer Name")
            {

            }

            column(EndDate; EndDate) { }
            column(StartDate; StartDate) { }

            column(MystartDate; MystartDate) { }
            column(StartDateII; StartDate) { }
            column(StartDateIII; StartDate) { }
            column(AllSavingsAmount; AllSavingsAmount) { }
            column(AllCreditsAmount; AllCreditsAmount) { }
            column(AllInterests; AllInterests) { }
            column(SourceUnit; SourceUnit) { }
            column(DisplayOptions; DisplayOptions) { }
            // column(BalanceDisplayOptions; BalanceDisplayOptions) { }
            column(ShowReversed; ShowReversed) { }



            dataitem(SavingsAccounts; "Savings Accounts")
            {

                RequestFilterFields = "Member No.", "Product Category", "Account Category", "No.", "Product Type", "Global Dimension 2 Code", "Global Dimension 1 Code", Status;
                DataItemLink = "Member No." = field("No."), "Date Filter" = field("Date Filter");
                DataItemTableView = where("Product Category" = filter(<> "Unallocated Fund" & <> "Entrance Fee"));
                column(No_SavingsAccounts;
                "No.")
                {
                }
                column(Name_SavingsAccounts; "Product Name")
                {
                }
                column(MemberNo_SavingsAccounts; "Member No.")
                {
                }
                column(Balance__LCY_; "Balance (LCY)")
                {
                }
                column(DepoContrib; DepoContrib) { }
                column(SortOrder; SortOrder) { }
                column(ShareContrib; ShareContrib) { }
                column(ChrismassContrib; ChrismassContrib) { }
                column(AcctBal; AcctBal) { }
                dataitem(LSavingsLedgerEntry; "Savings Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No.");
                    DataItemTableView = SORTING("Posting Date", "Entry No.") ORDER(Ascending) where("Posting Date" = filter(<> 0D));//, Reversed = filter(false));
                    column(PostingDate_SavingsLedgerEntry; "Posting Date")
                    {
                    }
                    column(DocumentNo_SavingsLedgerEntry; "Document No.")
                    {
                    }
                    column(Description_SavingsLedgerEntry; Description)
                    {
                    }
                    column(Document_Date; "Document Date")
                    {
                    }
                    column(DebitAmountLCY_SavingsLedgerEntry; "Debit Amount (LCY)")
                    {
                    }
                    column(CreditAmountLCY_SavingsLedgerEntry; "Credit Amount (LCY)")
                    {
                    }
                    column(AmountLCY_SavingsLedgerEntry; "Amount (LCY)")
                    {
                    }
                    column(Creation_DateSaingsLedger; "Creation Date")
                    {
                    }
                    column(LineBalance; LineBalance) { }
                    column(SOpeningBal; SOpeningBal) { }
                    column(BalanceBF; BalanceBF) { }

                    trigger OnPreDataItem()
                    begin
                        LSavingsLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                        if ShowReversed = false then
                            LSavingsLedgerEntry.SetFilter(Reversed, '%1', false);

                    end;

                    trigger OnAfterGetRecord()
                    begin
                        // LineBalance := LineBalance + (LSavingsLedgerEntry."Credit Amount" - LSavingsLedgerEntry."Debit Amount");
                        // LineBalance:=LineBalance+BalanceBF;
                        SOpeningBal += -LSavingsLedgerEntry."Amount (LCY)";
                        LineBalance := SOpeningBal + BalanceBF;

                        if (LSavingsLedgerEntry."Debit Amount (LCY)" = 0) and (LSavingsLedgerEntry."Credit Amount (LCY)" = 0) then
                            if LSavingsLedgerEntry."Amount (LCY)" > 0 then
                                LSavingsLedgerEntry."Debit Amount (LCY)" := abs(LSavingsLedgerEntry."Amount (LCY)")
                            else
                                LSavingsLedgerEntry."Credit Amount (LCY)" := abs(LSavingsLedgerEntry."Amount (LCY)");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    AcctBal := 0;
                    LineBalance := 0;
                    SOpeningBal := 0;
                    SortOrder := 999;
                    BalanceBF := 0;
                    SavingsAccounts.calcfields("Balance (LCY)", Balance);
                    if ProductFactory.get(SavingsAccounts."Product Type") then begin
                        SortOrder := ProductFactory."Sort Order";
                    end;
                    AcctBal := SavingsAccounts."Balance (LCY)";
                    IF StartDate = 0D THEN StartDate := 19900101D;
                    IF EndDate = 0D THEN EndDate := 99990101D;
                    SavingsAccounts.SETRANGE(SavingsAccounts."Date Filter", 0D, CALCDATE('-1D', StartDate));
                    SavingsAccounts.CALCFIELDS(SavingsAccounts."Balance (LCY)");
                    if BalanceDisplayOptions = BalanceDisplayOptions::"<=0" then
                        SavingsAccounts.SetFilter("Balance", '<=%1', 0);
                    if BalanceDisplayOptions = BalanceDisplayOptions::">0" then
                        SavingsAccounts.SetFilter("Balance", '>%1', 0);

                    BalanceBF := SavingsAccounts."Balance (LCY)";
                    if StartDate = 19900101D then MystartDate := '' else MystartDate := GlobalFunc.DMUDateFormatDate(StartDate);

                    if (GetLoansFilter <> '') and (GetSavingFilter = '') then currReport.skip;
                end;

                trigger OnPreDataItem()
                begin
                    //SavingsAccounts.SetFilter(sou);
                    SavingsAccounts.CalcFields("Source Unit");
                    if SourceUnit <> SourceUnit::" " then
                        SavingsAccounts.SetFilter("Source Unit", '%1', SourceUnit);
                    if DisplayOptions = DisplayOptions::Loans then
                        SavingsAccounts.SetFilter("No.", '%1', 'SourceUnit');
                    prodFilter := SavingsAccounts.GetFilter("Product Type");
                end;
            }

            //Unalocated Funds
            dataitem(SavingsAccountsU; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No."), "Date Filter" = field("Date Filter");
                DataItemTableView = where("Product Category" = filter("Unallocated Fund"));
                column(No_SavingsAccountsU; "No.")
                {
                }
                column(Name_SavingsAccountsU; "Product Name")
                {
                }
                column(MemberNo_SavingsAccountsU; "Member No.")
                {
                }
                column(Balance__LCY_U; "Balance (LCY)")
                {
                }
                column(DepoContribU; DepoContrib) { }
                column(SortOrderU; SortOrder) { }
                column(ShareContribU; ShareContrib) { }
                column(ChrismassContribU; ChrismassContrib) { }
                column(AcctBalU; AcctBal) { }
                dataitem(LSavingsLedgerEntryU; "Savings Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No.");
                    DataItemTableView = SORTING("Posting Date", "Entry No.") ORDER(Ascending) where("Posting Date" = filter(<> 0D));//, Reversed = filter(false));
                    column(PostingDate_SavingsLedgerEntryU; "Posting Date")
                    {
                    }
                    column(DocumentNo_SavingsLedgerEntryU; "Document No.")
                    {
                    }
                    column(Description_SavingsLedgerEntryU; Description)
                    {
                    }
                    column(Document_DateU; "Document Date")
                    {
                    }
                    column(DebitAmountLCY_SavingsLedgerEntryU; "Debit Amount (LCY)")
                    {
                    }
                    column(CreditAmountLCY_SavingsLedgerEntryU; "Credit Amount (LCY)")
                    {
                    }
                    column(AmountLCY_SavingsLedgerEntryU; "Amount (LCY)")
                    {
                    }
                    column(Creation_DateSaingsLedgerU; "Creation Date")
                    {
                    }
                    column(LineBalanceU; LineBalance) { }
                    column(SOpeningBalU; SOpeningBal) { }
                    column(BalanceBFU; BalanceBF) { }

                    trigger OnPreDataItem()
                    begin
                        LSavingsLedgerEntryU.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                        if ShowReversed = false then
                            LSavingsLedgerEntryU.SetFilter(Reversed, '%1', false);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        // LineBalance := LineBalance + (LSavingsLedgerEntry."Credit Amount" - LSavingsLedgerEntry."Debit Amount");
                        // LineBalance:=LineBalance+BalanceBF;
                        SOpeningBal += -LSavingsLedgerEntryU."Amount (LCY)";
                        LineBalance := SOpeningBal + BalanceBF;

                        if (LSavingsLedgerEntryU."Debit Amount (LCY)" = 0) and (LSavingsLedgerEntryU."Credit Amount (LCY)" = 0) then
                            if LSavingsLedgerEntryU."Amount (LCY)" > 0 then
                                LSavingsLedgerEntryU."Debit Amount (LCY)" := abs(LSavingsLedgerEntryU."Amount (LCY)")
                            else
                                LSavingsLedgerEntryU."Credit Amount (LCY)" := abs(LSavingsLedgerEntryU."Amount (LCY)");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    AcctBal := 0;
                    LineBalance := 0;
                    SOpeningBal := 0;
                    SortOrder := 999;
                    BalanceBF := 0;
                    SavingsAccountsU.calcfields("Balance (LCY)", Balance);
                    if ProductFactory.get(SavingsAccountsU."Product Type") then begin
                        SortOrder := ProductFactory."Sort Order";
                    end;
                    AcctBal := SavingsAccountsU."Balance (LCY)";
                    IF StartDate = 0D THEN StartDate := 19900101D;
                    IF EndDate = 0D THEN EndDate := 99990101D;
                    SavingsAccountsU.SETRANGE(SavingsAccountsU."Date Filter", 0D, CALCDATE('-1D', StartDate));
                    SavingsAccountsU.CALCFIELDS(SavingsAccountsU."Balance (LCY)");
                    if BalanceDisplayOptions = BalanceDisplayOptions::"<=0" then
                        SavingsAccountsU.SetFilter("Balance", '<=%1', 0);
                    if BalanceDisplayOptions = BalanceDisplayOptions::">0" then
                        SavingsAccountsU.SetFilter("Balance", '>%1', 0);
                    BalanceBF := SavingsAccountsU."Balance (LCY)";
                    if StartDate = 19900101D then MystartDate := '' else MystartDate := GlobalFunc.DMUDateFormatDate(StartDate);

                    if (GetLoansFilter <> '') and (GetSavingFilter = '') then currReport.skip;
                end;

                trigger OnPreDataItem()
                begin
                    //SavingsAccounts.SetFilter(sou);
                    SavingsAccountsU.CalcFields("Source Unit");
                    if SourceUnit <> SourceUnit::" " then
                        SavingsAccountsU.SetFilter("Source Unit", '%1', SourceUnit);
                    if DisplayOptions = DisplayOptions::Loans then
                        SavingsAccountsU.SetFilter("No.", '%1', 'SourceUnit');
                    if prodFilter <> '' then
                        SavingsAccountsU.SetFilter("Product Type", prodFilter);
                end;
            }
            //End Of Unnalocated Funds


            dataitem(CreditAccounts; Loans)
            {


                DataItemLink = "Member No." = field("No.");
                RequestFilterFields = "Loan No.", "Loan Product Type", "Global Dimension 2 Code", "Outstanding Balance";
                DataItemTableView = where(Posted = filter(true));


                column(CreditAccNo; CreditAccounts."Loan No.") { }
                column(CreditAccountName; CreditAccounts."Loan Product Type Name") { }
                column(CreditAccountType; CreditAccounts."Loan Product Type") { }
                column(LoanOutstandingBal; LoanOutstandingBal) { }
                column(Requested_Amount; "Requested Amount")
                {

                }
                column(Approved_Amount; "Approved Amount")
                {

                }
                column(Loan_Product_Type_Name; "Loan Product Type Name")
                {

                }
                column(Loan_Product_Type; "Loan Product Type")
                {

                }
                column(Expected_Date_of_Completion; "Expected Date of Completion")
                {

                }
                column(Disbursement_Date; "Disbursement Date")
                {
                }
                column(CreditSortOrder; CreditSortOrder) { }
                dataitem(CreditLedgerEntry; "Credit Ledger Entry")
                {
                    DataItemLink = "Loan No" = field("Loan No.");
                    DataItemTableView = SORTING("Posting Date", "Entry No.") ORDER(Ascending) where("Posting Date" = filter(<> 0D));
                    ;//, Reversed = filter(false));
                    column(CreditAmountLCY; "Amount (LCY)")
                    {
                    }

                    column(CreditAmountcreditledger; "Credit Amount (LCY)")
                    {
                    }
                    column(CreditDocumentNo; "Document No.")
                    {
                    }
                    column(CreditPostingDate; "Posting Date")
                    {
                    }
                    column(Credit_Document_Date; "Document Date")
                    {
                    }
                    column(CreditDebitAmountLCY; "Debit Amount (LCY)")
                    {
                    }
                    column(Creation_DateCreditLedger; "Creation Date")
                    {
                    }
                    column(Description; Description)
                    {

                    }
                    column(Transaction_Type; "Transaction Type") { }
                    column(CreditTotals; CreditTotals) { }
                    column(PrevOutstanding; PrevOutstanding) { }
                    column(Loan_No; "Loan No") { }


                    trigger OnAfterGetRecord()
                    begin
                        if (CreditLedgerEntry."Debit Amount (LCY)" = 0) and (CreditLedgerEntry."Credit Amount (LCY)" = 0) then
                            if CreditLedgerEntry."Amount (LCY)" > 0 then
                                CreditLedgerEntry."Debit Amount (LCY)" := abs(CreditLedgerEntry."Amount (LCY)")
                            else
                                CreditLedgerEntry."Credit Amount (LCY)" := abs(CreditLedgerEntry."Amount (LCY)");

                        NCreditLedgerEntry.Reset();
                        NCreditLedgerEntry.SetRange("Loan No", CreditAccounts."Loan No.");
                        NCreditLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
                        if NCreditLedgerEntry.FindFirst() then begin
                            repeat
                                if (NCreditLedgerEntry."Debit Amount (LCY)" = 0) and (NCreditLedgerEntry."Credit Amount (LCY)" = 0) then
                                    if NCreditLedgerEntry."Amount (LCY)" > 0 then
                                        NCreditLedgerEntry."Debit Amount (LCY)" := abs(NCreditLedgerEntry."Amount (LCY)")
                                    else
                                        NCreditLedgerEntry."Credit Amount (LCY)" := abs(NCreditLedgerEntry."Amount (LCY)");

                                CreditTotals := CreditTotals + (NCreditLedgerEntry."Debit Amount (LCY)" - NCreditLedgerEntry."Credit Amount (LCY)")
                                                       until NCreditLedgerEntry.Next() = 0;
                            PrevOutstanding := CreditTotals;
                        end;

                        CreditTotals := CreditTotals + (CreditLedgerEntry."Debit Amount (LCY)" - CreditLedgerEntry."Credit Amount (LCY)");
                    end;

                    trigger OnPreDataItem()
                    begin
                        CreditLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                        if ShowReversed = false then
                            CreditLedgerEntry.SetFilter(Reversed, '%1', false);

                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    LoanOutstandingBal := 0;
                    PrevOutstanding := 0;
                    CreditTotals := 0;
                    CreditSortOrder := 999;
                    CreditAccounts.CalcFields("Outstanding Interest", "Outstanding Balance");
                    LoanOutstandingBal := CreditAccounts."Outstanding Balance" + CreditAccounts."Outstanding Interest";
                    if ProductFactory.get(CreditAccounts."Loan Product Type") then begin
                        CreditSortOrder := ProductFactory."Sort Order";
                    end;
                    // TotalLoanPaid
                end;

                trigger OnPreDataItem()
                begin
                    if SourceUnit <> SourceUnit::" " then
                        CreditAccounts.SetFilter("Source Unit", '%1', SourceUnit);
                    //CreditAccounts.Source::
                    //CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
                    // CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
                    // CreditAccounts.SetFilter("Outstanding Interest", '>%1', 0, '|');
                    if DisplayOptions = DisplayOptions::Savings then
                        CreditAccounts.SetFilter("Loan No.", '%1', 'SourceUnit');
                    LoansFilter := CreditAccounts.GetFilter(CreditAccounts."Loan Product Type");
                    if BalanceDisplayOptions = BalanceDisplayOptions::"<=0" then
                        CreditAccounts.SetFilter("Total Balance", '<=%1', 0);
                    if BalanceDisplayOptions = BalanceDisplayOptions::">0" then
                        CreditAccounts.SetFilter("Total Balance", '>%1', 0);
                end;
            }

            //Loan Interest
            // dataitem(CreditAccountsI; Loans)
            // {
            //     DataItemLink = "Member No." = field("No.");
            //     RequestFilterFields = "Loan No.", "Loan Product Type", "Global Dimension 2 Code", "Global Dimension 1 Code", "Approved Amount", "Outstanding Interest", "Total Balance";
            //     DataItemTableView = where(Posted = filter(true));

            //     column(CreditAccNoI; CreditAccountsI."Loan No.") { }
            //     column(CreditAccountNameI; CreditAccountsI."Loan Product Type Name") { }
            //     column(CreditAccountTypeI; CreditAccountsI."Loan Product Type") { }
            //     column(LoanOutstandingBalI; LoanOutstandingBal) { }
            //     column(Requested_AmountI; "Requested Amount")
            //     {

            //     }
            //     column(Approved_AmountI; "Approved Amount")
            //     {

            //     }
            //     column(Loan_Product_Type_NameI; "Loan Product Type Name")
            //     {

            //     }
            //     column(Loan_Product_TypeI; "Loan Product Type")
            //     {

            //     }
            //     column(Expected_Date_of_CompletionI; "Expected Date of Completion")
            //     {

            //     }
            //     column(Disbursement_DateI; "Disbursement Date")
            //     {

            //     }
            //     column(ICreditSortOrder; ICreditSortOrder)
            //     { }
            //     column(Daily_Interest; "Daily Interest")
            //     { }


            //     dataitem(CreditLedgerEntryI; "Credit Ledger Entry")
            //     {
            //         DataItemLink = "Loan No" = field("Loan No.");
            //         DataItemTableView = SORTING("Posting Date", "Entry No.") ORDER(Ascending) where("Posting Date" = filter(<> 0D), "Transaction Type" = filter("Interest due" | "Interest Paid"));//, Reversed = filter(false));
            //         column(CreditAmountLCYI; "Amount (LCY)")
            //         {
            //         }

            //         column(CreditAmountcreditledgerI; "Credit Amount (LCY)")
            //         {
            //         }
            //         column(CreditDocumentNoI; "Document No.")
            //         {
            //         }
            //         column(CreditPostingDateI; "Posting Date")
            //         {
            //         }
            //         column(Credit_Document_DateI; "Document Date")
            //         {
            //         }
            //         column(CreditDebitAmountLCYI; "Debit Amount (LCY)")
            //         {
            //         }
            //         column(Creation_DateCreditLedgerI; "Creation Date")
            //         {
            //         }
            //         column(DescriptionI; Description)
            //         {

            //         }

            //         column(Transaction_TypeI; "Transaction Type") { }
            //         column(CreditTotalsI; CreditTotals) { }
            //         column(PrevOutstandingI; PrevOutstandingI) { }
            //         column(Loan_NoI; "Loan No") { }


            //         trigger OnAfterGetRecord()
            //         begin
            //             iCreditSortOrder := 999;
            //             NCreditLedgerEntry.Reset();
            //             NCreditLedgerEntry.SetRange("Loan No", CreditAccountsI."Loan No.");
            //             NCreditLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
            //             NCreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', NCreditLedgerEntry."Transaction Type"::"Interest Due", NCreditLedgerEntry."Transaction Type"::"Interest Paid");
            //             if NCreditLedgerEntry.FindFirst() then begin
            //                 repeat
            //                     CreditTotals := CreditTotals + (NCreditLedgerEntry."Debit Amount (LCY)" - NCreditLedgerEntry."Credit Amount (LCY)")
            //                                            until NCreditLedgerEntry.Next() = 0;
            //                 PrevOutstandingI := CreditTotals;
            //             end;
            //             if ProductFactory.get(CreditAccountsI."Loan Product Type") then begin
            //                 iCreditSortOrder := ProductFactory."Sort Order";
            //             end;

            //             CreditTotals := CreditTotals + (CreditLedgerEntryI."Debit Amount (LCY)" - CreditLedgerEntryI."Credit Amount (LCY)");
            //         end;

            //         trigger OnPreDataItem()
            //         begin
            //             CreditLedgerEntryI.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
            //             if ShowReversed = false then
            //                 CreditLedgerEntryI.SetFilter(Reversed, '%1', false);
            //         end;
            //     }
            //     trigger OnAfterGetRecord()
            //     begin
            //         LoanOutstandingBalI := 0;
            //         PrevOutstandingI := 0;
            //         CreditTotals := 0;
            //         CreditAccountsI.CalcFields("Outstanding Interest", "Outstanding Balance");
            //         LoanOutstandingBalI := CreditAccountsI."Outstanding Balance" + CreditAccountsI."Outstanding Interest";

            //         if (GetSavingFilter <> '') and (GetLoansFilter = '') then currReport.skip;
            //         // TotalLoanPaid
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         if SourceUnit <> SourceUnit::" " then
            //             CreditAccountsI.SetFilter("Source Unit", '%1', SourceUnit);
            //         //CreditAccounts.Source::
            //         //CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
            //         // CreditAccounts.SetFilter("Outstanding Balance", '>%1', 0);
            //         // CreditAccounts.SetFilter("Outstanding Interest", '>%1', 0, '|');
            //         if DisplayOptions = DisplayOptions::Savings then
            //             CreditAccountsI.SetFilter("Loan Account", '%1', 'SourceUnit');
            //         CreditAccountsI.SetFilter("Loan Product Type", LoansFilter);

            //         if BalanceDisplayOptions = BalanceDisplayOptions::"<=0" then
            //             CreditAccountsI.SetFilter("Outstanding Interest", '<=%1', 0);
            //         if BalanceDisplayOptions = BalanceDisplayOptions::">0" then
            //             CreditAccountsI.SetFilter("Outstanding Interest", '>%1', 0);
            //     end;


            //     //chacha
            // }


            trigger OnAfterGetRecord()
            var
                GlobalFunctions: Codeunit "Global Functions";
            begin

                AllSavingsAmount := 0;
                AllCreditsAmount := 0;
                AllLoanBalances := 0;
                AllInterests := 0;
                DepoContrib := 0;
                ShareContrib := 0;
                ChrismassContrib := 0;

                GlobalFunctions.FlagAccounts(Members."No.");

                // Savings
                SavingsAccounts.Reset();
                SavingsAccounts.setrange(SavingsAccounts."Member No.", Members."No.");
                //SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3', "Product Category"::Dividend, "Product Category"::"Registration Fee", "Product Category"::"Insurance Contribution");

                if SavingsAccounts.FindFirst() then begin
                    repeat
                        SavingsAccounts.calcfields("Balance (LCY)", Balance);
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then
                            DepoContrib := SavingsAccounts."Balance (LCY)" else
                            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Share Capital" then
                                ShareContrib := SavingsAccounts."Balance (LCY)" else
                                if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account" then
                                    ChrismassContrib := SavingsAccounts."Balance (LCY)";
                        //Message('%1', SavingsAccounts."Balance (LCY)");                   
                        // repeat
                        //     SavingsAccounts.CalcFields("Balance (LCY)");
                        //     AllSavingsAmount := AllSavingsAmount + SavingsAccounts."Balance (LCY)";
                        if (SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"FOSA Account") and SavingsAccounts."Loan Disbursement Account" then
                            FOSAAccount := SavingsAccounts."No.";
                    until SavingsAccounts.Next() = 0;
                    //Message('%1', AllSavingsAmount);
                end else
                    AllSavingsAmount := 0;
                // credits principal outstanding balances
                CreditAccounts.Reset();
                CreditAccounts.SetRange(CreditAccounts."Member No.", Members."No.");
                if CreditAccounts.FindFirst() then begin
                    repeat
                        CreditAccounts.CalcFields("Outstanding Balance");
                        AllCreditsAmount := AllCreditsAmount + CreditAccounts."Outstanding Balance";
                    until CreditAccounts.Next() = 0;
                end else
                    AllCreditsAmount := 0;
                // Interests 
                CreditAccounts.Reset();
                CreditAccounts.SetRange(CreditAccounts."Member No.", Members."No.");
                if CreditAccounts.FindFirst() then begin
                    repeat
                        CreditAccounts.CalcFields("Outstanding Interest");
                        AllInterests := AllInterests + CreditAccounts."Outstanding Interest";
                    until CreditAccounts.Next() = 0;
                end
                else
                    AllInterests := 0;
                AllLoanBalances := AllInterests + AllCreditsAmount;

                SavAccII.reset;
                SavAccII.setrange("Member No.", Members."No.");
                SavAccII.SetRange("Product Type", '191');
                if SavAccII.FindFirst() then begin
                    AcctBal := SavAccII.GetAvailableBalance(SavAccII."No.");
                    if StatementCharge then begin
                        PostStmtCharges(StatementTypeII, AcctBal, Members, SavAccII."No.",NumberOfPages);
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
            area(content)
            {
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field(SourceUnit; SourceUnit)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Display Options"; DisplayOptions)
                    {
                        ApplicationArea = Basic;
                    }
                    // field("Balance Display"; BalanceDisplayOptions)
                    // { ApplicationArea = Basic; }
                    field("Show Reversed"; ShowReversed)
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Statement Charges")
                {
                    field("Charge"; StatementCharge)
                    {
                        Caption = 'Charge';
                        ApplicationArea = Basic;
                    }
                    field(StatementTypeII; StatementTypeII)
                    {
                        Caption = 'Statement Type.';
                        ApplicationArea = basic;
                    }
                    field(NumberOfPages; NumberOfPages)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Number of Pages to Charge';
                    }
                }
            }
        }

    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if (StatementCharge = true) and (StatementTypeII = StatementTypeII::Certified) then begin
            if NumberOfPages <= 0 then
                Error('Number of pages to charge must be greater than zero');
        end;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address;
        CompanyAddress2 := CompanyInformation."Post Code" + ' ' + CompanyInformation.City + ' ' + CompanyInformation."Country/Region Code";

        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '.';
        Website := ' ' + CompanyInformation."Home Page";
        StartDateII := StartDate;
        if StartDate = 0D then
            StartDateIII := '' else
            StartDateIII := format(StartDate);
        if (StartDate = 0D) or (EndDate = 0D) then begin
            StartDate := 19900101D;
            EndDate := Today;
            if StartDate = 19900101D then MystartDate := '' else MystartDate := GlobalFunc.DMUDateFormatDate(StartDate);
        end;
        if StartDate = 19900101D then
            StartDateII := 0D;
        if StartDate = 19900101D then MystartDate := '' else MystartDate := GlobalFunc.DMUDateFormatDate(StartDate);
        // Initialize all variables 

        LineBalance := 0;

        // Ensure unfiltered records are not shown.
        GetLoansFilter := CreditAccounts.getfilters();
        GetSavingFilter := SavingsAccounts.getfilters();
        TimeT := time;
    end;

    var
        BalanceBF: Decimal;
        BalanceBFL: Decimal;
        SavingsAccountName: Text;
        SavingsAccountRunBal: Decimal;
        CreditAccountRunBal: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Website: Text;
        MmberStaffN: Code[30];
        StartDate: Date;
        StartDateII: Date;
        StartDateIII: Text;
        MystartDate: Text;
        EndDate: Date;
        CumBalanceL: Decimal;
        LineBalance: Decimal;
        OutstandinBalances: Decimal;
        HrEmploy: Record "HR Employees";
        SavingsTotal: Decimal;
        CreditTotals: Decimal;
        AllSavingsAmount: Decimal;
        SavingsLedgerEntry: record "Savings Ledger Entry";
        AmountLCY_SavingsLedgerEntry: Decimal;
        Description_SavingsLedgerEntry: Text;
        DocumentNo_SavingsLedgerEntry: Text;
        PostingDate_SavingsLedgerEntry: Date;
        NCreditLedgerEntry: Record "Credit Ledger Entry";
        ProductFactory: Record "Product Factory";
        SOpeningBal: Decimal;
        PrevOutstanding: Decimal;
        PrevOutstandingI: Decimal;
        AllCreditsAmount: Decimal;
        LoanOutstandingBalI: Decimal;
        AllInterests: Decimal;
        AllLoanBalances: Decimal;
        DepoContrib: Decimal;
        ShareContrib: Decimal;
        ChrismassContrib: Decimal;
        LoanOutstandingBal: Decimal;
        AcctBal: Decimal;
        SortOrder: Integer;
        CreditSortOrder: Integer;
        ICreditSortOrder: Integer;
        GetLoansFilter: Text;
        GetSavingFilter: Text;
        FOSAAccount: Code[20];
        SourceUnit: Option " ",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        GlobalFunc: Codeunit "Global Functions";
        TimeT: Time;
        DisplayOptions: Option All,Loans,Savings;
        BalanceDisplayOptions: Option All,">0","<=0";
        LoansFilter: Text;
        ShowReversed: Boolean;
        prodFilter: Text;
        //Charges        AvailableBal: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TCharges: Decimal;
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        GenJLine: Record "Gen. Journal Line";
        JournalPosting: Codeunit "Journal Posting";
        GenSetup: Record "General Set-Up";
        StatementCharge: Boolean;
        StatementTypeII: Option Uncertified,Certified;
        SavAccII: record "Savings Accounts";
        NumberOfPages : Integer;
        ExciseDuty : Decimal;
        SaccoCharge : Decimal;


    // Post Statement Charges
    procedure PostStmtCharges(StatementType: Option Uncertified,Certified; AvailableBal: Decimal; Member: record Members; AccNo: Code[20];NumberOfPages: Integer)
    begin
        //Charges
        GenSetup.Get();
        Temp.Get(UserId);
        Temp.TestField(Temp."Cashier Journal Template");
        Temp.TestField(Temp."Cashier Journal Batch");
        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";

        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", Temp."Cashier Journal Template");
        GenJLine.SetRange(GenJLine."Journal Batch Name", Temp."Cashier Journal Batch");
        GenJLine.DeleteAll;

        if ProductFactory.get('191') then begin
            TCharges := 0;
            TransactionCharges.Reset;
            if StatementTypeII = StatementType::Certified then
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", ProductFactory."Certified Statement Charge")
            else
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", ProductFactory."Statement Charge");
            if TransactionCharges.Find('-') then begin
                repeat
                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                        ChargeAmount := (AvailableBal * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (AvailableBal >= TariffDetails."Lower Limit") and
                                   (AvailableBal <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" then
                                        ChargeAmount := AvailableBal * TariffDetails.Percentage * 0.01
                                    else
                                        ChargeAmount := TariffDetails."Charge Amount";
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;

                    if NumberOfPages > 0 then
                    ChargeAmount := (ChargeAmount * NumberOfPages);                   
                    
                    LineN += 1;
                    GenJLine.Init;
                    GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                    GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                    GenJLine."Line No." := LineN;
                    GenJLine."Posting Date" := Today;
                    GenJLine."Document No." := CopyStr(('S-FEE_' + Member."No."), 1, 20);
                    GenJLine."External Document No." := Member."No.";
                    GenJLine."Account Type" := GenJLine."account type"::Savings;
                    GenJLine.Validate(GenJLine."Account No.", AccNo);
                    GenJLine.Description := TransactionCharges.Description;
                    GenJLine.Validate(GenJLine.Amount, ChargeAmount);
                    GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Bal. Account No.", '');
                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", Member."Global Dimension 1 Code");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", Member."Global Dimension 2 Code");
                    if GenJLine.Amount <> 0 then
                        GenJLine.Insert;
                    
                    LineN += 1;
                    GenJLine.Init;
                    GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                    GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                    GenJLine."Line No." := LineN;
                    GenJLine."Posting Date" := Today;
                    GenJLine."Document No." := CopyStr(('S-FEE_' + Member."No."), 1, 20);
                    GenJLine."External Document No." := Member."No.";
                    GenJLine."Account Type" := GenJLine."account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Account No.", TransactionCharges."G/L Account");
                    GenJLine.Description := TransactionCharges.Description;
                    GenJLine.Validate(GenJLine.Amount, -(ChargeAmount));
                    GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Bal. Account No.", '');
                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", Member."Global Dimension 1 Code");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", Member."Global Dimension 2 Code");
                    if GenJLine.Amount <> 0 then
                        GenJLine.Insert;

                    TCharges+=ChargeAmount;

                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                        (TransactionCharges."Recover Excise Duty" = true) then begin
                        //Excise
                        LineN += 1;
                            GenJLine.Init;
                            GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                            GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                            GenJLine."Line No." := LineN;
                            GenJLine."Posting Date" := Today;
                            GenJLine."Document No." := CopyStr(('S-FEE_' + Member."No."), 1, 20);
                            GenJLine."External Document No." := Member."No.";
                            GenJLine."Account Type" := GenJLine."account type"::Savings;
                            GenJLine.Validate(GenJLine."Account No.", AccNo);
                            GenJLine.Description := TransactionCharges.Description + ' Excise Duty';
                            GenJLine.Validate(GenJLine.Amount, (TCharges * GenSetup."Excise Duty (%)") * 0.01);
                            GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                            GenJLine.Validate(GenJLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                            GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", SavingsAccounts."Global Dimension 1 Code");
                            GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", SavingsAccounts."Global Dimension 2 Code");
                            if GenJLine.Amount <> 0 then
                                GenJLine.Insert;
                    end;
                    
                until TransactionCharges.Next = 0;
            end;

            if AvailableBal >= TCharges then begin
                
                GenJLine.Reset;
                GenJLine.SetRange(GenJLine."Journal Template Name", Temp."Cashier Journal Template");
                GenJLine.SetRange(GenJLine."Journal Batch Name", Temp."Cashier Journal Batch");
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJLine);

            end
            else
                error('Member has insufficient Balance hence charges Cannot be applied!')
        end;
    end;

}
