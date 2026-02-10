page 52186397 "DCS Account Details"
{
    PageType = List;
    SourceTable = "Savings Accounts";
    SourceTableView = WHERE("Transactional Mobile No" = CONST('<>'''));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BOSA Account No"; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'BOSA Account No';
                }
                field("MPESA Mobile No"; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'MPESA Mobile No';
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Deposit Contribution"; Rec.GetDepositContribution)
                // {
                //     Caption = 'Deposit Contribution';
                // }
                // field("Share Capital"; Rec.GetShareCapital)
                // {
                //     Caption = 'Share Capital';
                // }
                // field("Registration Fees"; Rec.GetRegistrationFee)
                // {
                //     Caption = 'Registration Fees';
                // }
                // field("Gross Salary"; Rec.GetGrossSalary)
                // {
                //     Caption = 'Gross Salary';
                // }
                // field("Net Salary"; Rec.GetNetSalary)
                // {
                //     Caption = 'Net Salary';

                //     trigger OnValidate()
                //     begin
                //         Vendor.Reset;
                //     end;
                // }
                // field(Deductions; Rec.GetDeductions)
                // {
                //     Caption = 'Deductions';
                // }
                // field("Expected Loan Repayments"; Rec.GetExpectedLoanRepayment)
                // {
                //     Caption = 'Expected Loan Repayments';
                // }
                // field("Last Loan Repayment Date"; Rec.GetLastRepaymentDate)
                // {
                //     Caption = 'Last Loan Repayment Date';
                // }
                // field("Total Loan repayments"; Rec.GetTotalLoanRepayments)
                // {
                //     Caption = 'Total Loan repayments';
                // }
                // field("No of Active Loans"; Rec.GetNumberOfActiveLoans)
                // {
                //     Caption = 'No of Active Loans';
                // }
                // field("Date of Join"; Rec.GetDateOfJoin)
                // {
                //     Caption = 'Date of Join';
                // }
                // field("Loan Balances - Filtered"; Rec.GetFilteredLoanBalance)
                // {
                //     Caption = 'Loan Balances - Filtered';
                // }
                // field(Defaulter; Rec.IsDefaulter)
                // {
                // }
                // field("Standing Orders"; Rec.GetStandingOrders)
                // {
                // }
                // field("Direct Debits"; Rec.GetDirectDebits)
                // {
                // }
                // field("Loan Repayment Frequency"; Rec.GetLoanRepaymentFrequency)
                // {
                // }
                // field("Deposits Guaranteed"; Rec.GetDepositGuaranteed)
                // {
                // }
                // field("Other Income"; Rec.GetOtherIncome)
                // {
                // }
                // field("Qualified Amount"; Rec.GetQualifiedAmount)
                // {
                // }
                // field(Bridge; Rec.GetBridge)
                // {
                // }
                // field("Present VAF"; Rec.GetPresentVAF)
                // {
                // }
                // field("Loan Security"; Rec.GetLoanSecurity)
                // {
                // }
                // field("Has FOSA Commitments"; Rec.HasFOSACommitments)
                // {
                // }
                // field("FOSA Commitments"; Rec.GetFOSACommitments)
                // {
                // }
                // field("Salary Processed"; Rec.IsSalaryProcessed)
                // {
                // }
                // field("Last Deposit Date"; Rec.GetLastDepositDate)
                // {
                // }
                // field("Msacco Trans Frequency"; Rec.GetMSACCOTransFrequency)
                // {
                // }
                // field("Msacco Last Trans Date"; Rec.GetMSACCOLastTransDate)
                // {
                // }
                // field("FOSA Deposits"; Rec."GetFOSA Deposits")
                // {
                // }
                // field("FOSA Transactions 1M"; Rec.GetFOSATransactions1M)
                // {
                // }
                // field("Instant Loan Limit"; Rec.GetInstantLoanlimit)
                // {
                // }
                // field("Class B Shares"; Rec."GetClass B Shares")
                // {
                // }
                // field("Instant Loan Balance"; Rec.GetInstantLoanBalance)
                // {
                // }
                // field("Instant Loans Paid"; Rec.GetInstantLoansPaid)
                // {
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //SETFILTER("Member No.",'0056882');
    end;

    trigger OnInit()
    begin
        //Member.GET(187584);
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER("Member No.",'0052273');
    end;

    var
        Member: Record Members;
        Vendor: Record Vendor;
        saccoAccount: Record "Savings Accounts";
        Loans: Record Loans;

    local procedure GetDepositContribution() depositContribution: Decimal
    begin
        saccoAccount.Reset;
        saccoAccount.SetRange("Product Type", '02');
        saccoAccount.SetRange("Member No.", Rec."Member No.");
        if saccoAccount.Find('-') then begin
            saccoAccount.CalcFields(Balance);
            depositContribution := saccoAccount.Balance;
        end;
    end;

    local procedure GetShareCapital() shareCapital: Decimal
    begin
        saccoAccount.Reset;
        saccoAccount.SetRange("Product Type", '03');
        saccoAccount.SetRange("Member No.", Rec."Member No.");
        if saccoAccount.Find('-') then begin
            saccoAccount.CalcFields(Balance);
            shareCapital := saccoAccount.Balance;
        end;
    end;

    local procedure GetRegistrationFee() regFee: Decimal
    begin
        saccoAccount.Reset;
        saccoAccount.SetRange("Product Type", '01');
        saccoAccount.SetRange("Member No.", Rec."Member No.");
        if saccoAccount.Find('-') then begin
            saccoAccount.CalcFields(Balance);
            regFee := saccoAccount.Balance;
        end;
    end;

    local procedure GetGrossSalary() grossSal: Decimal
    begin
    end;

    local procedure GetNetSalary() netSal: Decimal
    var
        SalaryBuff: Record "Salary Lines";
        LoanRepayment: Decimal;
        ScoreIncrease: Decimal;
        CreditLedgEntry: Record "Credit Ledger Entry";
        lastPayDate: Date;
    begin
        lastPayDate := 0D;
        SalaryBuff.Reset;
        SalaryBuff.SetRange("Account No.", Rec."No.");
        SalaryBuff.SetRange(SalaryBuff.Posted, true);
        SalaryBuff.SetFilter(SalaryBuff."Posting Date", '%1..%2', CalcDate('-100D', Today), Today);
        SalaryBuff.CalcSums(SalaryBuff.Amount);

        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetFilter("Loan Product Type", '%1', '119');
        Loans.SetFilter("Outstanding Balance", '>0');
        if Loans.Find('-') then begin
            LoanRepayment := Loans.Repayment;
        end;
        netSal := Abs(SalaryBuff.Amount) / 3 - GetStandingOrders() - LoanRepayment;
        if netSal < 10000 then
            netSal := 10000;





        //COVID-19.. Allow members without salary up to 10K

        SalaryBuff.Reset;
        SalaryBuff.SetRange("Account No.", Rec."No.");
        SalaryBuff.SetRange(SalaryBuff.Posted, true);
        SalaryBuff.SetFilter(SalaryBuff."Posting Date", '%1..%2', CalcDate('-100D', Today), Today);
        if not SalaryBuff.Find('-') then begin

            ScoreIncrease := 0;
            //netSal:=10000;
            Loans.Reset;
            Loans.SetCurrentKey("Disbursement Date");
            Loans.Ascending(false);
            Loans.SetRange("Member No.", Rec."Member No.");
            Loans.SetRange(Posted, true);
            Loans.SetRange("Loan Product Type", '126');
            Loans.SetFilter("Outstanding Balance", '<=0');
            if Loans.Find('+') then begin
                repeat
                    CreditLedgEntry.Reset;
                    CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                    CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgEntry.SetRange("Transaction Type", CreditLedgEntry."Transaction Type"::Repayment);
                    CreditLedgEntry.SetCurrentKey("Posting Date");
                    if CreditLedgEntry.FindLast then begin
                        lastPayDate := CreditLedgEntry."Posting Date";
                        if (lastPayDate - Loans."Disbursement Date") < 35 then begin
                            ScoreIncrease := 10000;
                        end;
                    end;
                until Loans.Next = 0;
            end;


            netSal := 10000;
        end;

        //By Pass Cases -0054125,0123289,0124776,0158698,0178025,0186110,0122902,0195951,0156995,0052273,0186110
        if (Rec."Member No." = '0186110') then
            netSal := 30000;
    end;

    local procedure GetDeductions() deductions: Decimal
    begin
    end;

    local procedure GetExpectedLoanRepayment() expectedLoanRepay: Decimal
    var
        Loans: Record Loans;
        LoanRepSch: Record "Ideal Repayment Schedule";
    begin
        expectedLoanRepay := 0;

        Loans.Reset;
        Loans.SetRange(Loans."Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance" > 0 then begin
                    LoanRepSch.Reset;
                    LoanRepSch.SetRange(LoanRepSch."Loan No.", Loans."Loan No.");
                    LoanRepSch.SetRange("Member No.", Rec."Member No.");
                    LoanRepSch.SetFilter("Repayment Date", '%1..%2', Loans."Disbursement Date", CalcDate('-1M', Today));
                    if LoanRepSch.Find('-') then
                        repeat

                            // IF LoanProd."Interest Calculation Method"=LoanProd."Interest Calculation Method"::"Instant Recovery" THEN
                            expectedLoanRepay := expectedLoanRepay + LoanRepSch."Principal Repayment"
                        //ELSE
                        //ExpectedRepay:=ExpectedRepay+LoanRepSch."Monthly Repayment";

                        until LoanRepSch.Next = 0;
                end;
            until Loans.Next = 0;
        end
    end;

    local procedure GetLastRepaymentDate() lastRepayDate: Date
    begin
    end;

    local procedure GetTotalLoanRepayments() totalLoanRepay: Decimal
    var
        Loans: Record Loans;
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance" > 0 then begin
                    totalLoanRepay += Loans."Approved Amount" - Loans."Outstanding Balance";
                end;
            until Loans.Next = 0;
        end;

        /*MemberLedgentry.RESET;
        MemberLedgentry.SETCURRENTKEY("Customer No.");
        MemberLedgentry.SETRANGE("Customer No.","Member No.");
        MemberLedgentry.SETFILTER("Transaction Type",'%1|%2',MemberLedgentry."Transaction Type"::Loan,MemberLedgentry."Transaction Type"::Repayment);
        MemberLedgentry.CALCSUMS(Amount);
        totalLoanRepay+=MemberLedgentry.Amount;

      MemberLedgentry.RESET;
      MemberLedgentry.SETCURRENTKEY("Customer No.");
      MemberLedgentry.SETRANGE("Customer No.","Member No.");
      MemberLedgentry.SETFILTER("Transaction Type",'%1|%2',MemberLedgentry."Transaction Type"::"Interest Due",MemberLedgentry."Transaction Type"::"Interest Paid" );
      MemberLedgentry.CALCSUMS(Amount);
      totalLoanRepay+=MemberLedgentry.Amount;
         */

    end;

    local procedure GetNumberOfActiveLoans() activeLoans: Integer
    begin
    end;

    local procedure GetDateOfJoin() joinDate: Date
    begin
        if Member.Get(Rec."Member No.") then begin
            joinDate := Member."Registration Date"
        end;
    end;

    local procedure GetTotalLoanBalance() loanBal: Decimal
    begin
    end;

    local procedure GetFilteredLoanBalance() loanBal: Decimal
    begin
    end;

    local procedure IsDefaulter() defaulter: Boolean
    var
        Loans: Record Loans;
        CreditLedgEntry: Record "Credit Ledger Entry";
        lastPayDate: Date;
    begin
        defaulter := false;
        lastPayDate := 20200101D;
        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", "Loans Category-SASRA");
                if Loans."Outstanding Balance" > 0 then begin
                    if Loans."Loans Category-SASRA" <> Loans."Loans Category-SASRA"::Perfoming then begin
                        CreditLedgEntry.Reset;
                        CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                        CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgEntry.SetRange("Transaction Type", CreditLedgEntry."Transaction Type"::Repayment);
                        CreditLedgEntry.SetCurrentKey("Posting Date");
                        CreditLedgEntry.Ascending(false);
                        if CreditLedgEntry.FindFirst() then begin
                            lastPayDate := CreditLedgEntry."Posting Date";
                        end;

                        if (Today - lastPayDate) > 31 then
                            defaulter := true;
                    end;
                end;
            until Loans.Next = 0;
        end;
    end;

    local procedure GetStandingOrders() sto: Decimal
    var
        StandingOrders: Record "Standing Order Lines";
        StandingOrderHeader: Record "Standing Order Header";
    begin
        //MESSAGE('%1',"No.");
        StandingOrderHeader.Reset;
        //StandingOrderHeader.SETRANGE("Member No.","Member No.");
        StandingOrderHeader.SetRange(Status, StandingOrderHeader.Status::Approved);
        StandingOrderHeader.SetRange("Source Account No.", Rec."No.");
        if StandingOrderHeader.Find('-') then begin
            repeat
                StandingOrders.Reset;
                StandingOrders.SetRange("Document No.", StandingOrderHeader."No.");
                //StandingOrders.SETRANGE(StandingOrders."Destination Account No.","No.");
                //StandingOrders.SETRANGE(s", StandingOrders.Status::Approved);
                if StandingOrders.FindFirst then begin
                    StandingOrders.CalcSums(StandingOrders.Amount);
                    sto := StandingOrders.Amount + sto;
                end;
            //MESSAGE('%1',sto);
            until StandingOrderHeader.Next = 0;
        end;
        //sto:=20;
    end;

    local procedure GetDirectDebits() dDebits: Decimal
    begin
    end;

    local procedure GetLoanRepaymentFrequency() frequency: Integer
    begin
    end;

    local procedure GetDepositGuaranteed() deposits: Decimal
    begin
    end;

    local procedure GetOtherIncome() income: Decimal
    begin
    end;

    local procedure GetQualifiedAmount() qual: Decimal
    begin
    end;

    local procedure GetBridge() bridge: Decimal
    begin
    end;

    local procedure GetPresentVAF() presentVaf: Decimal
    begin
    end;

    local procedure GetLoanSecurity() lSecurity: Decimal
    begin
    end;

    local procedure HasFOSACommitments() fosaCommitments: Boolean
    begin
    end;

    local procedure GetFOSACommitments() fosaCommitments: Decimal
    begin
    end;

    local procedure IsSalaryProcessed() salProcessed: Boolean
    begin
    end;

    local procedure GetNoOfActiveLoans() activeLoans: Integer
    begin
    end;

    local procedure GetLastDepositDate() lastDepDate: Date
    begin
    end;

    local procedure GetMSACCOTransFrequency() msaccoTransFrequency: Integer
    begin
    end;

    local procedure GetMSACCOLastTransDate() lastTransDate: Date
    begin
    end;

    local procedure "GetFOSA Deposits"() fosaDeposits: Decimal
    begin
    end;

    local procedure GetFOSATransactions1M() fosaTrans: Decimal
    begin
    end;

    local procedure "GetClass B Shares"() classBShares: Decimal
    begin
    end;

    local procedure GetInstantLoanlimit() loanLimit: Decimal
    var
        loansDefaulted: Integer;
        Loans: Record Loans;
        CreditLedgEntry: Record "Credit Ledger Entry";
        lastPayDate: Date;
        ProdFac: Record "Product Factory";
        ScoreIncrease: Decimal;
        LoanCount: Integer;
        Found: Boolean;
        Members: Record Members;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        SavingsAccounts: Record "Savings Accounts";
        SalaryBuff: Record "Salary Lines";
    begin

        if ProdFac.Get(126) then begin
            loanLimit := 10000;//ProdFac."Maximum Loan Amount";
            loansDefaulted := 0;


            Loans.Reset;
            Loans.SetRange("Member No.", Rec."Member No.");
            Loans.SetRange(Posted, true);
            Loans.SetRange("Loan Product Type", ProdFac."Product ID");
            Loans.SetFilter("Outstanding Balance", '=0');
            Loans.SetCurrentKey("Disbursement Date");
            if Loans.Find('+') then begin
                repeat
                    //MESSAGE('%1 AND %2 Loan No %3',ScoreIncrease,ProdFac."Product ID",Loans."Loan No.");
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if Loans."Outstanding Balance" <= 0 then begin
                        CreditLedgEntry.Reset;
                        CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                        CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgEntry.SetRange("Transaction Type", CreditLedgEntry."Transaction Type"::Repayment);
                        CreditLedgEntry.SetCurrentKey("Posting Date");
                        CreditLedgEntry.Ascending(false);
                        if CreditLedgEntry.FindFirst() then begin
                            lastPayDate := CreditLedgEntry."Posting Date";
                        end;
                        if lastPayDate = 0D then begin
                            lastPayDate := CalcDate('-1M', Today);
                        end;
                        if (lastPayDate - Loans."Disbursement Date") >= 35 then begin
                            loansDefaulted += 1;
                            // MESSAGE('%1 an %2',loansDefaulted,Loans."Loan No.");
                        end else begin
                            // loansPaid := 0;
                        end;
                    end;
                until Loans.Next = 0;

                if (loansDefaulted > 0) then begin
                    //loanLimit := ROUND(ProdFac."Maximum Loan Amount"/(2*loansDefaulted),1,'=');
                end;
            end;

            //__*********Check for well paid loan and add limit by **5000**
            //__---------Start

            ScoreIncrease := 0;
            Found := false;
            LoanCount := 0;
            Loans.Reset;
            Loans.SetCurrentKey("Disbursement Date");
            Loans.Ascending(false);
            Loans.SetRange("Member No.", Rec."Member No.");
            Loans.SetRange(Posted, true);
            Loans.SetRange("Loan Product Type", ProdFac."Product ID");
            Loans.SetFilter("Outstanding Balance", '<=0');
            if Loans.Find('-') then begin
                repeat
                    if (LoanCount <= 4) and (Found = false) and (loansDefaulted = 0) then begin
                        // MESSAGE('%1 and %2',ScoreIncrease, Loans."Loan No.");
                        CreditLedgEntry.Reset;
                        CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                        CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgEntry.SetRange("Transaction Type", CreditLedgEntry."Transaction Type"::Repayment);
                        CreditLedgEntry.SetCurrentKey("Posting Date");
                        if CreditLedgEntry.FindLast then begin
                            lastPayDate := CreditLedgEntry."Posting Date";
                            if (lastPayDate - Loans."Disbursement Date") < 35 then begin
                                ScoreIncrease := ScoreIncrease + 5000;
                            end else begin
                                Found := true;
                            end;
                        end else
                            Found := true;
                        LoanCount := LoanCount + 1;
                    end;
                until Loans.Next = 0;
            end;

            loanLimit := ScoreIncrease + loanLimit;


            if Members.Get(saccoAccount."Member No.") then begin
                if (Members.Status <> Members.Status::Active) and (Members.Status <> Members.Status::New) then begin
                    loanLimit := 0;
                end;
                if (Members."Employer Code" = '9901') or (Members."Employer Code" = '9902') then
                    loanLimit := 0;
            end;
        end;


        //  QualifiedAmountFinal := '-1|0|0|You do not qualify for this product';




        //COVID-19 Added---

        SalaryBuff.Reset;
        SalaryBuff.SetRange("Account No.", Rec."No.");
        SalaryBuff.SetRange(SalaryBuff.Posted, true);
        SalaryBuff.SetFilter(SalaryBuff."Posting Date", '%1..%2', CalcDate('-100D', Today), Today);
        if not SalaryBuff.Find('-') then begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", saccoAccount."Member No.");
            //SavingsAccounts.SETRANGE("Product Category",SavingsAccounts."Product Category"::"BOSA Deposits");
            SavingsAccounts.SetRange("Product Type", '02');
            if SavingsAccounts.Find('-') then begin
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccounts."No.");
                SavingsLedgerEntry.SetFilter("Document No.", '%1', 'RECOVERY OF MB LOAN');
                //SavingsLedgerEntry.SETFILTER("Posting Date",'%1..%2', CALCDATE('-60D',TODAY), TODAY);
                if SavingsLedgerEntry.Find('-') then begin
                    loanLimit := 0;
                end;
            end;
        end;


        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", "Loans Category-SASRA");
                if Loans."Outstanding Balance" > 0 then begin
                    if Loans."Loans Category-SASRA" <> Loans."Loans Category-SASRA"::Perfoming then begin
                        CreditLedgEntry.Reset;
                        CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                        CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgEntry."Transaction Type"::Repayment, CreditLedgEntry."Transaction Type"::Loan);
                        CreditLedgEntry.SetCurrentKey("Posting Date");
                        CreditLedgEntry.Ascending(false);
                        if CreditLedgEntry.FindLast then begin
                            lastPayDate := CreditLedgEntry."Posting Date";
                        end;

                        if (Today - lastPayDate) > 31 then
                            loanLimit := 0;
                    end;
                end;
            until Loans.Next = 0;
        end;

        //COVID-19 END.


        //By Pass Case 0054125,0123289,0105404,0125694,0124776,0158698,0178025,0186110,0122902,0195951,0156995,0052273,0186110
        if (Rec."Member No." = '0186110') then
            loanLimit := 30000;


        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", saccoAccount."Member No.");
        SavingsAccounts.SetRange("Loan Disbursement Account", true);
        SavingsAccounts.SetRange("Mobile Loan Blocked", true);
        if SavingsAccounts.Find('-') then begin
            loanLimit := 0;
        end;
    end;

    local procedure GetInstantLoanBalance() loanBalance: Decimal
    var
        Loans: Record Loans;
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        Loans.SetRange("Loan Product Type", '126');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance" > 0 then begin
                    loanBalance += Loans."Outstanding Balance";
                end;
            until Loans.Next = 0;
        end;
    end;

    local procedure GetInstantLoansPaid() loansPaid: Integer
    var
        Loans: Record Loans;
        CreditLedgEntry: Record "Credit Ledger Entry";
        lastPayDate: Date;
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetRange(Posted, true);
        Loans.SetRange("Loan Product Type", '126');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance" <= 0 then begin
                    CreditLedgEntry.Reset;
                    CreditLedgEntry.SetRange("Member No.", Loans."Member No.");
                    CreditLedgEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgEntry.SetRange("Transaction Type", CreditLedgEntry."Transaction Type"::Repayment);
                    CreditLedgEntry.SetCurrentKey("Posting Date");
                    CreditLedgEntry.Ascending(false);
                    if CreditLedgEntry.FindFirst then begin
                        lastPayDate := CreditLedgEntry."Posting Date";
                    end;
                    if lastPayDate = 0D then begin
                        lastPayDate := CalcDate('-3M', Today);
                    end;
                    if (lastPayDate - Loans."Disbursement Date") <= 35 then begin
                        loansPaid += 1;
                    end else begin
                        loansPaid := 0;
                    end;
                end;
            until Loans.Next = 0;
        end;
    end;
}

