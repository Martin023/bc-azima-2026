Report 52185676 "Member Loan Statement II"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Loan Statement II.rdl';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Member Loan Statement';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(IDNo_Members; Members."Primary Identification")
            {
            }
            column(Primary_Identification; "Primary Identification")
            {

            }
            column(Department; Members."Employer Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(MobilePhoneNo_Members; Members."Phone No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Loan No.") where(Posted = const(true));
                RequestFilterFields = "Date Filter", "Loan No.", "Loan Product Type";
                column(ReportForNavId_1102755024; 1102755024)
                {
                }
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan No.")
                {
                }
                column(ProductType; Loans."Loan Product Type")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(TotalBalance_Loans; Loans."Total Balance")
                {
                }
                dataitem(loan; "Credit Ledger Entry")
                {
                    DataItemLink = "Loan No" = field("Loan No.");
                    DataItemTableView = sorting("Entry No.") order(ascending) where("Transaction Type" = filter(Repayment | Loan | "Interest Due" | "Interest Paid"), Reversed = const(false));
                    column(ReportForNavId_1102755031; 1102755031)
                    {
                    }
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLosingBalance := CLosingBalance + loan.Amount;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*PrincipleBF:=0;
                    
                    IF DateFilterBF <> '' THEN BEGIN
                    LoansR.RESET;
                    LoansR.SETRANGE(LoansR."Loan  No.","Loan  No.");
                    LoansR.SETFILTER(LoansR."Date filter",DateFilterBF);
                    IF LoansR.FIND('-') THEN BEGIN
                    LoansR.CALCFIELDS(LoansR."Loan Balances");
                    PrincipleBF:=LoansR."Loan Balances";
                    END;
                    END;
                        */

                end;
            }
            dataitem(LoansI; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Loan No.") where(Posted = const(true));
                RequestFilterFields = "Date Filter";
                column(ReportForNavId_24; 24)
                {
                }
                column(PrincipleBFI; PrincipleBFI)
                {
                }
                column(LoanNumberI; LoansI."Loan No.")
                {
                }
                column(ProductTypeI; LoansI."Loan Product Type")
                {
                }
                column(LoanProductTypeName_LoansI; LoansI."Loan Product Type Name")
                {
                }
                column(RequestedAmountI; LoansI."Requested Amount")
                {
                }
                column(InterestI; LoansI.Interest)
                {
                }
                column(InstallmentsI; LoansI.Installments)
                {
                }
                column(LoanPrincipleRepaymentI; LoansI."Loan Principle Repayment")
                {
                }
                column(TotalBalance_LoansI; LoansI."Total Balance")
                {
                }
                column(OutstandingBalance_LoansI; LoansI."Outstanding Balance")
                {
                }
                column(OutstandingInterest_LoansI; LoansI."Outstanding Interest")
                {
                }
                dataitem(loanI; "Credit Ledger Entry")
                {
                    DataItemLink = "Loan No" = field("Loan No.");
                    DataItemTableView = sorting("Entry No.") order(ascending) where("Transaction Type" = filter("Interest Due" | "Interest Paid"), Reversed = const(false));
                    column(ReportForNavId_15; 15)
                    {
                    }
                    column(PostingDate_loanI; loanI."Posting Date")
                    {
                    }
                    column(DocumentNo_loanI; loanI."Document No.")
                    {
                    }
                    column(Description_loanI; loanI.Description)
                    {
                    }
                    column(DebitAmount_LoanI; loanI."Debit Amount")
                    {
                    }
                    column(CreditAmount_LoanI; loanI."Credit Amount")
                    {
                    }
                    column(Amount_LoanI; loanI.Amount)
                    {
                    }
                    column(openBalance_loanI; OpenBalanceI)
                    {
                    }
                    column(CLosingBalance_loanI; CLosingBalanceI)
                    {
                    }
                    column(TransactionType_loanI; loanI."Transaction Type")
                    {
                    }
                    column(LoanNoI; loanI."Loan No")
                    {
                    }
                    column(PrincipleBF_loansI; PrincipleBFI)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLosingBalanceI := CLosingBalanceI + loanI.Amount;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalanceI := PrincipleBFI;
                        OpeningBali := PrincipleBFI;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*PrincipleBF:=0;
                    
                    IF DateFilterBF <> '' THEN BEGIN
                    LoansR.RESET;
                    LoansR.SETRANGE(LoansR."Loan  No.","Loan  No.");
                    LoansR.SETFILTER(LoansR."Date filter",DateFilterBF);
                    IF LoansR.FIND('-') THEN BEGIN
                    LoansR.CALCFIELDS(LoansR."Loan Balances");
                    PrincipleBF:=LoansR."Loan Balances";
                    END;
                    END;
                        */

                end;
            }

            trigger OnAfterGetRecord()
            begin

                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                XmasBF := 0;
                UnnalocatedBF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                    end;
                end;
                // cHarges
                SavAccII.reset;
                SavAccII.setrange("Member No.", Members."No.");
                SavAccII.SetRange("Product Type", '191');
                if SavAccII.FindFirst() then begin
                    AcctBal := SavAccII.GetAvailableBalance(SavAccII."No.");
                    if StatementCharge then begin
                        PostStmtCharges(StatementTypeII, AcctBal, Members, SavAccII."No.");
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if Members.GetFilter(Members."Date Filter") <> '' then
                    //DateFilterBF:='..'+ FORMAT(CALCDATE('-1D',Members.GETRANGEMIN(Members."Date Filter")));
                    DateFilterBF := '..' + Format(Members.GetRangeMin(Members."Date Filter"));
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
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

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        no: Integer;
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Members;
        OpeningBal: Decimal;
        OpeningBali: Decimal;
        PrincipleBFI: Decimal;
        CLosingBalanceI: Decimal;
        OpenBalanceI: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record Loans;
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        XmasBF: Decimal;
        Company: Record "Company Information";
        OpenBalInt: Decimal;
        ClosingBalInt: Decimal;
        IntBF: Integer;
        UnnalocatedBF: Decimal;
        ClosingBalUnna: Decimal;
        // charges
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
        ProductFactory: record "Product Factory";
        AcctBal: Decimal;

    procedure PostStmtCharges(StatementType: Option Uncertified,Certified; AvailableBal: Decimal; Members: record Members; AccNo: Code[20])
    begin
        //Charges
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

                    TChargeAmount += ChargeAmount;
                until TransactionCharges.Next = 0;
            end;
            TCharges := TChargeAmount;
            Temp.Get(UserId);
            Temp.TestField(Temp."Cashier Journal Template");
            Temp.TestField(Temp."Cashier Journal Batch");
            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";

            GenJLine.Reset;
            GenJLine.SetRange(GenJLine."Journal Template Name", Temp."Cashier Journal Template");
            GenJLine.SetRange(GenJLine."Journal Batch Name", Temp."Cashier Journal Batch");
            GenJLine.DeleteAll;

            if AvailableBal >= TCharges then begin
                LineN += 1;
                GenJLine.Init;
                GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                GenJLine."Line No." := LineN;
                GenJLine."Posting Date" := Today;
                GenJLine."Document No." := CopyStr(('S-FEE_' + Format(time)), 1, 20);
                GenJLine."External Document No." := Members."No.";
                GenJLine."Account Type" := GenJLine."account type"::Savings;
                GenJLine.Validate(GenJLine."Account No.", AccNo);
                GenJLine.Description := TransactionCharges.Description;
                GenJLine.Validate(GenJLine.Amount, TCharges);
                GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                GenJLine.Validate(GenJLine."Bal. Account No.", TransactionCharges."G/L Account");
                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", Members."Global Dimension 1 Code");
                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", Members."Global Dimension 2 Code");
                if GenJLine.Amount <> 0 then
                    GenJLine.Insert;

                //To be rechecked based on the existing setups

                //Excise Duty
                GenSetup.Get();
                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                    (TransactionCharges."Recover Excise Duty" = true) then begin
                    //Excise
                    LineN += 1;
                    GenJLine.Init;
                    GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                    GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                    GenJLine."Line No." := LineN;
                    GenJLine."Posting Date" := Today;
                    GenJLine."Document No." := CopyStr(('S-FEE_' + Format(time)), 1, 20);
                    GenJLine."External Document No." := members."No.";
                    GenJLine."Account Type" := GenJLine."account type"::Savings;
                    GenJLine.Validate(GenJLine."Account No.", AccNo);
                    GenJLine.Description := TransactionCharges.Description + ' Excise Duty';
                    GenJLine.Validate(GenJLine.Amount, (TCharges * GenSetup."Excise Duty (%)") * 0.01);
                    GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                    GenJLine.Validate(GenJLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", members."Global Dimension 1 Code");
                    GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", Members."Global Dimension 2 Code");
                    if GenJLine.Amount <> 0 then
                        GenJLine.Insert;
                    //Excise
                end;

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

