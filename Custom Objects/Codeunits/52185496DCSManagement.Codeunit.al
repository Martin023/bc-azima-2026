#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185496 "DCS Management"
{

    trigger OnRun()
    begin
        UpdateMemberData();
        UpdateLoanData();
    end;

    var
        MemberRec: Record "Savings Accounts";
        Topup: Record "Loan Charges";
        MemberTransactionRec: Record "DCS Member Transaction";


    procedure UpdateLoanData()
    var
        Loan: Record Loans;
        LoanRepSch: Record "Ideal Repayment Schedule";
        DCSLoan: Record "DCS Loan Summary";
        LoanSummary: Record "DCS Loan Summary";
        memb: Record "Savings Accounts";
    begin
        memb.Reset;
        memb.SetCurrentkey("Member No.", "No.", "Salary Through FOSA");
        memb.SetRange("Salary Through FOSA", true);
        if memb.Find('-') then begin
            repeat
                Loan.Reset;
                Loan.SetCurrentkey("Member No.", "Loan No.");
                Loan.SetRange("Member No.", memb."Member No.");
                Loan.SetRange(Posted, true);
                if Loan.Find('-') then
                    repeat
                        Loan.CalcFields("Outstanding Balance", Loan."Outstanding Interest", Loan."Outstanding Bills");
                        if ((Loan."Outstanding Balance" > 0) or (setLastRepayDate(Loan."Loan No.") = true)) and (Loan."Loan Product Type" <> 'DFTL') then begin
                            if DCSLoan.Get(Loan."Member No.", Loan."Loan No.", Loan."Loan Product Type") then begin
                                DCSLoan."Member No." := Loan."Member No.";
                                DCSLoan."Loan No" := Loan."Loan No.";
                                DCSLoan."Loan Product Type" := Loan."Loan Product Type";
                                DCSLoan."Issue Date" := Loan."Disbursement Date";
                                DCSLoan."Loan Amount" := Loan."Approved Amount";
                                DCSLoan."Outstanding Balance" := Loan."Outstanding Balance";
                                DCSLoan."Total Paid" := (Loan."Approved Amount" - Loan."Outstanding Balance") + (Loan."Outstanding Interest" * -1);
                                DCSLoan."Expected Repayment" := setExpectedRepay(Loan."Member No.", Loan."Loan No.", Loan."Approval Date", Loan."Loan Product Type");
                                if Loan."Outstanding Balance" <= 0 then
                                    DCSLoan."Expected Repayment" := 0;
                                DCSLoan.Source := Format(Loan.Source::BANKING);
                                DCSLoan."Account No" := Loan."Member No.";
                                if Loan.Source = Loan.Source::BANKING then begin
                                    memb.Reset;
                                    memb.SetRange("Member No.", Loan."Member No.");
                                    if memb.FindFirst then
                                        DCSLoan."Account No" := memb."No.";
                                end;
                                DCSLoan.Modify(true);
                            end else begin
                                DCSLoan.Init;
                                DCSLoan."Member No." := Loan."Member No.";
                                DCSLoan."Loan No" := Loan."Loan No.";
                                DCSLoan."Loan Product Type" := Loan."Loan Product Type";
                                DCSLoan."Issue Date" := Loan."Disbursement Date";
                                DCSLoan."Loan Amount" := Loan."Approved Amount";
                                DCSLoan."Outstanding Balance" := Loan."Outstanding Balance";
                                DCSLoan."Total Paid" := (Loan."Approved Amount" - Loan."Outstanding Balance") + (Loan."Outstanding Interest" * -1);
                                DCSLoan."Expected Repayment" := setExpectedRepay(Loan."Member No.", Loan."Loan No.", Loan."Approval Date", Loan."Loan Product Type");
                                if Loan."Outstanding Balance" <= 0 then
                                    DCSLoan."Expected Repayment" := 0;
                                DCSLoan.Source := Format(Loan.Source::BANKING);
                                DCSLoan."Account No" := Loan."Member No.";
                                if Loan.Source = Loan.Source::BANKING then begin
                                    memb.Reset;
                                    memb.SetRange("Member No.", Loan."Member No.");
                                    if memb.FindFirst then
                                        DCSLoan."Account No" := memb."No.";
                                end;
                                DCSLoan.Insert(true);
                            end;
                        end;
                    until Loan.Next = 0;
            until memb.Next = 0;
        end;
    end;


    procedure UpdateMemberData()
    var
        MemberTransactionRec: Record "DCS Member Transaction";
        MemberNo: Code[20];
        LoanBalance: Decimal;
        InterestDue: Decimal;
        ShareCapital: Decimal;
        DepositContribution: Decimal;
        TransFrequency: Integer;
        TransDate: Date;
        LastDepositDate: Date;
        LastLoanRepayment: Date;
        LastWithdrawalDate: Date;
        DateOfJoin: Date;
        memb: Record "Savings Accounts";
    begin
        memb.Reset;
        memb.SetCurrentkey("Member No.", "No.", "Salary Through FOSA");
        memb.SetRange("Salary Through FOSA", true);
        //memb.SETRANGE("Member No.",'0195843');
        if memb.Find('-') then begin
            repeat
                MemberRec.Reset;
                MemberRec.SetRange(Status, MemberRec.Status::Active);
                MemberRec.SetRange("Product Type", '505');
                MemberRec.SetRange("Member No.", memb."Member No.");
                //MemberRec.SETRANGE("Member No.",'0186022');
                //MemberRec.SETFILTER("No.",'>%1','50199');
                if MemberRec.Find('-') then begin
                    repeat
                        LoanBalance := 0;
                        InterestDue := 0;
                        ShareCapital := 0;
                        TransFrequency := 0;
                        TransDate := 0D;
                        //DateOfJoin:=0D;
                        DepositContribution := 0;
                        if MemberTransactionRec.Get(MemberRec."Member No.") then begin
                            MemberTransactionRec."Member No" := MemberRec."Member No.";
                            MemberTransactionRec."Last Update" := CreateDatetime(Today, Time);
                            MemberNo := MemberRec."Member No.";
                            GetLoanBalances(MemberRec."Member No.", LoanBalance, InterestDue, ShareCapital, DepositContribution);
                            MemberTransactionRec."Loan Balance" := LoanBalance + InterestDue;
                            MemberTransactionRec."Expected Loan Repayment" := LoanBalance;
                            setTransDate(MemberRec."Member No.", LastDepositDate, LastLoanRepayment, LastWithdrawalDate, DateOfJoin);
                            MemberTransactionRec."Last Repayment Date" := LastLoanRepayment;
                            MemberTransactionRec."Deposits Contribution" := DepositContribution;
                            MemberTransactionRec."Date of Join" := DateOfJoin;
                            MemberTransactionRec."Last Deposit Date" := LastDepositDate;
                            MemberTransactionRec."Share Capital" := ShareCapital;
                            setMSACCODet(MemberRec."Member No.", TransFrequency, TransDate);
                            MemberTransactionRec."MSACCO Trans Ferquency" := TransFrequency;
                            MemberTransactionRec."MSACCO Last Trans Date" := TransDate;

                            MemberTransactionRec.Modify;
                        end else begin
                            MemberTransactionRec.Init;
                            MemberTransactionRec."Member No" := MemberRec."Member No.";
                            MemberTransactionRec."Last Update" := CreateDatetime(Today, Time);
                            MemberNo := MemberRec."Member No.";
                            GetLoanBalances(MemberNo, LoanBalance, InterestDue, ShareCapital, DepositContribution);
                            MemberTransactionRec."Loan Balance" := LoanBalance + InterestDue;
                            MemberTransactionRec."Expected Loan Repayment" := LoanBalance;
                            setTransDate(MemberRec."No.", LastDepositDate, LastLoanRepayment, LastWithdrawalDate, DateOfJoin);
                            MemberTransactionRec."Last Repayment Date" := LastLoanRepayment;
                            MemberTransactionRec."Date of Join" := DateOfJoin;
                            MemberTransactionRec."Last Deposit Date" := LastDepositDate;
                            setMSACCODet(MemberRec."No.", TransFrequency, TransDate);
                            MemberTransactionRec."MSACCO Trans Ferquency" := TransFrequency;
                            MemberTransactionRec."MSACCO Last Trans Date" := TransDate;

                            MemberTransactionRec.Insert;

                        end;
                        Commit;
                    until MemberRec.Next = 0;
                end;
            until memb.Next = 0;
        end;
    end;


    procedure GetLoanBalances(MemberNo: Code[20]; var LoanBalance: Decimal; var InterestDue: Decimal; var ShareCapital: Decimal; var DepositContribution: Decimal)
    var
        MemberLedgEntry: Record "Credit Ledger Entry";
        SavingsLedgerEntry: Record "Savings Accounts";
    begin
        MemberLedgEntry.Reset;
        MemberLedgEntry.SetCurrentkey("Member No.");
        MemberLedgEntry.SetRange("Member No.", MemberNo);
        MemberLedgEntry.SetFilter("Transaction Type", '%1|%2', MemberLedgEntry."transaction type"::Loan, MemberLedgEntry."transaction type"::Repayment);
        MemberLedgEntry.CalcSums(MemberLedgEntry."Amount (LCY)");
        LoanBalance := MemberLedgEntry."Amount (LCY)";

        MemberLedgEntry.Reset;
        MemberLedgEntry.SetCurrentkey("Member No.");
        MemberLedgEntry.SetRange("Member No.", MemberNo);
        MemberLedgEntry.SetFilter("Transaction Type", '%1|%2', MemberLedgEntry."transaction type"::"Interest Due", MemberLedgEntry."transaction type"::"Interest Paid");
        MemberLedgEntry.CalcSums(MemberLedgEntry."Amount (LCY)");
        InterestDue := MemberLedgEntry."Amount (LCY)";

        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Member No.", MemberNo);
        SavingsLedgerEntry.SetRange(SavingsLedgerEntry."Product Type", '03');
        if SavingsLedgerEntry.FindFirst() then begin
            //SavingsLedgerEntry.CALCFIELDS(SavingsLedgerEntry.Balance);
            ShareCapital := 20000;
        end;

        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Member No.", MemberNo);
        SavingsLedgerEntry.SetRange("Product Type", '02');
        if SavingsLedgerEntry.FindFirst() then begin
            SavingsLedgerEntry.CalcFields(SavingsLedgerEntry.Balance);
            DepositContribution := SavingsLedgerEntry.Balance;
        end;
        /*
        MemberLedgEntry.RESET;
        MemberLedgEntry.SETCURRENTKEY("Customer No.");
        MemberLedgEntry.SETRANGE("Customer No.",MemberNo);
        MemberLedgEntry.SETRANGE("Transaction Type",MemberLedgEntry."Transaction Type"::"Deposit Contribution");
        MemberLedgEntry.CALCSUMS(Amount);
        DepositContribution:=ABS(MemberLedgEntry.Amount);
        */

    end;


    procedure setExpectedRepay(MembNo: Code[20]; LoanNo: Code[20]; StartDate: Date; Product: Code[20]) ExpectedRepay: Decimal
    var
        LoanRepSch: Record "Ideal Repayment Schedule";
        FirstDayDate: Text;
        LastDate: Date;
        LoanProd: Record "Product Factory";
    begin
        //FirstDayDate:=FORMAT(DATE2DMY(TODAY,2))+'/1/'+FORMAT(DATE2DMY(TODAY,3));
        FirstDayDate := '1/' + Format(Date2dmy(Today, 2)) + '/' + Format(Date2dmy(Today, 3));
        Evaluate(LastDate, FirstDayDate);
        LoanRepSch.Reset;
        LoanRepSch.SetRange("Loan No.", LoanNo);
        LoanRepSch.SetRange("Member No.", MembNo);
        LoanRepSch.SetRange("Repayment Date", StartDate, CalcDate('-1D', LastDate));
        if LoanRepSch.Find('-') then
            repeat
                //MESSAGE('the Bal %1 '+FORMAT(LoanRepSch."Monthly Repayment") +'==>'+LoanNo+'');
                if LoanProd.Get(Product) then
                    if LoanProd."Interest Calculation Method" = LoanProd."interest calculation method"::"Straight Line" then
                        ExpectedRepay := ExpectedRepay + LoanRepSch."Principal Repayment"
                    else
                        ExpectedRepay := ExpectedRepay + LoanRepSch."Monthly Repayment";
            until LoanRepSch.Next = 0;
    end;


    procedure ComputeBridge(MemberNo: Code[20]; var BridgeAmount: Decimal; LoanNo: Code[20]; TopupAmount: Decimal)
    begin
        /*
        Topup.SETCURRENTKEY("Loan No");
        Topup.SETRANGE("Loan No",LoanNo);
        Topup.CALCSUMS("Use Perc");
        Topup.CALCSUMS("Loan Type");
        BridgeAmount:=Topup."Use Perc"+Topup."Loan Type";
        */

    end;


    procedure ComputeTopup(MemberNo: Code[20]; var BridgeAmount: Decimal; LoanNo: Code[20]; TopupAmount: Decimal)
    begin
        /*
        Topup.SETCURRENTKEY("Loan No");
        Topup.SETRANGE("Loan No",LoanNo);
        Topup.CALCSUMS("Use Perc");
        Topup.CALCSUMS("Loan Type");
        BridgeAmount:=Topup."Use Perc"+Topup."Loan Type";
        */

    end;


    procedure ComputeSalaries(MemberNo: Code[20]; LoanNo: Code[20]; var Basic: Decimal; var Earnings: Decimal; var Deductions: Decimal; var NetSalary: Decimal)
    var
        SalDetails: Record "Appraisal Salary Details";
    begin
        //compute Basic
        SalDetails.Reset;
        SalDetails.SetRange(SalDetails."Client Code", MemberNo);
        SalDetails.SetRange(SalDetails."Loan No", LoanNo);
        SalDetails.SetRange(SalDetails.Type, SalDetails.Type::Basic);
        SalDetails.CalcSums(Amount);
        Basic := SalDetails.Amount;

        //Computer Earnings
        SalDetails.Reset;
        SalDetails.SetRange(SalDetails."Client Code", MemberNo);
        SalDetails.SetRange(SalDetails."Loan No", LoanNo);
        SalDetails.SetRange(SalDetails.Type, SalDetails.Type::Earnings);
        SalDetails.CalcSums(Amount);
        Earnings := SalDetails.Amount;

        //compute deduction
        SalDetails.Reset;
        SalDetails.SetRange(SalDetails."Client Code", MemberNo);
        SalDetails.SetRange(SalDetails."Loan No", LoanNo);
        SalDetails.SetRange(SalDetails.Type, SalDetails.Type::Deductions);
        SalDetails.CalcSums(Amount);
        Deductions := SalDetails.Amount;

        NetSalary := (Basic + Earnings) - Deductions;
    end;


    procedure UpdateSingleData(MemberNo: Code[20]; LoanNo: Code[20])
    var
        MemberTransactionRec: Record "DCS Member Transaction";
        LoanBalance: Decimal;
        InterestDue: Decimal;
        ShareCapital: Decimal;
        DepositContribution: Decimal;
        Basic: Decimal;
        Earnings: Decimal;
        Deductions: Decimal;
        NetSalary: Decimal;
        Installments: Decimal;
        InterestRate: Decimal;
        ApplicationAmt: Decimal;
        SecurityAmt: Decimal;
    begin
        LoanBalance := 0;
        InterestDue := 0;
        ShareCapital := 0;
        DepositContribution := 0;
        if MemberTransactionRec.Get(MemberNo) then begin
            MemberTransactionRec."Member No" := MemberNo;
            MemberTransactionRec."Last Update" := CreateDatetime(Today, Time);
            GetLoanBalances(MemberNo, LoanBalance, InterestDue, ShareCapital, DepositContribution);
            MemberTransactionRec."Loan Balance" := LoanBalance + InterestDue;
            MemberTransactionRec."Expected Loan Repayment" := LoanBalance;
            // MemberTransactionRec."Last Repayment Date":=InterestDue;
            MemberTransactionRec."Deposits Contribution" := DepositContribution;
            MemberTransactionRec."Share Capital" := ShareCapital;
            MemberTransactionRec."Deposits Contribution" := DepositContribution;
            MemberTransactionRec."Share Capital" := ShareCapital;
            ComputeSalaries(MemberNo, LoanNo, Basic, Earnings, Deductions, NetSalary);
            MemberTransactionRec."Gross Salary" := Basic + Earnings;
            MemberTransactionRec.Earnings := Earnings;
            MemberTransactionRec.Deductions := Deductions;
            MemberTransactionRec."Net Pay" := NetSalary;
            MemberTransactionRec.Basic := Basic;
            GetLoanData(LoanNo, Installments, InterestRate, ApplicationAmt);
            MemberTransactionRec.Installments := Installments;
            MemberTransactionRec."Interest Rate" := InterestRate;
            MemberTransactionRec."Requested Amount" := ApplicationAmt;
            GetSecurities(LoanNo, SecurityAmt);
            MemberTransactionRec."Loan Security" := SecurityAmt;
            MemberTransactionRec.Modify;
        end else begin
            MemberTransactionRec.Init;
            MemberTransactionRec."Member No" := MemberNo;
            MemberTransactionRec."Last Update" := CreateDatetime(Today, Time);
            GetLoanBalances(MemberNo, LoanBalance, InterestDue, ShareCapital, DepositContribution);
            MemberTransactionRec."Loan Balance" := LoanBalance + InterestDue;
            MemberTransactionRec."Expected Loan Repayment" := LoanBalance;
            //MemberTransactionRec."Last Repayment Date":=InterestDue;
            MemberTransactionRec."Deposits Contribution" := DepositContribution;
            MemberTransactionRec."Share Capital" := ShareCapital;
            MemberTransactionRec."Deposits Contribution" := DepositContribution;
            MemberTransactionRec."Share Capital" := ShareCapital;
            ComputeSalaries(MemberNo, LoanNo, Basic, Earnings, Deductions, NetSalary);
            MemberTransactionRec."Gross Salary" := Basic + Earnings;
            MemberTransactionRec.Earnings := Earnings;
            MemberTransactionRec.Deductions := Deductions;
            MemberTransactionRec."Net Pay" := NetSalary;
            MemberTransactionRec.Basic := Basic;
            GetLoanData(LoanNo, Installments, InterestRate, ApplicationAmt);
            MemberTransactionRec.Installments := Installments;
            MemberTransactionRec."Interest Rate" := InterestRate;
            MemberTransactionRec."Requested Amount" := ApplicationAmt;
            GetSecurities(LoanNo, SecurityAmt);
            MemberTransactionRec."Loan Security" := SecurityAmt;
            MemberTransactionRec.Insert;
        end;
    end;


    procedure GetLoanData(LoanNo: Code[20]; var Installments: Decimal; var InterestRate: Decimal; var ApplicationAmt: Decimal)
    var
        LoanRec: Record Loans;
    begin
        if LoanRec.Get(LoanNo) then begin
            Installments := LoanRec.Installments;
            InterestRate := LoanRec.Interest;
            ApplicationAmt := LoanRec."Requested Amount"
        end;
    end;


    procedure GetSecurities(LoanNo: Code[20]; var SecurityAmt: Decimal)
    var
        LoanSecurityRec: Record "Travel Destination";
    begin
        /*LoanSecurityRec.RESET;
        LoanSecurityRec.SETRANGE("Destination Code",LoanNo);
        LoanSecurityRec.CALCSUMS("Amount Guaranteed");
        SecurityAmt:=LoanSecurityRec."Amount Guaranteed";*/

    end;


    procedure setMSACCODet(AccountNo: Code[20]; var MSACCOTransF: Integer; var MSACCOLastDate: Date)
    var
        MSACCOTrans: Record "M-PESA Transactions";
        vend: Record "Savings Accounts";
    begin
        vend.Reset;
        vend.SetRange(vend."Member No.", AccountNo);
        if vend.FindFirst then begin
            MemberRec.Reset;
            MemberRec.SetCurrentkey("Member No.", "No.");
            MemberRec.SetRange("Member No.", AccountNo);
            MemberRec.SetRange(MemberRec."Product Type", '505');
            if MemberRec.FindFirst then begin
                MSACCOTrans.Reset;
                MSACCOTrans.SetView('SORTING(Transaction Date) ORDER(Descending) WHERE(Account No.=CONST(' + MemberRec."No." + '))');
                MSACCOTransF := MSACCOTrans.Count;
                if MSACCOTrans.FindFirst then
                    MSACCOLastDate := MSACCOTrans."Transaction Date";
            end;
        end;
    end;


    procedure setTransDate(MemberNo: Code[20]; var LastDepositdate: Date; var LastLoanRepayment: Date; var LastWithdrawalDate: Date; var DateOfJoin: Date)
    var
        MemberLedgEntry: Record "Credit Ledger Entry";
        MemberRec: Record "Savings Accounts";
        Members: Record Members;
    begin
        //Savings Account
        MemberRec.Reset;
        MemberRec.SetCurrentkey("Member No.", "Last Transaction Date");
        MemberRec.SetRange("Member No.", MemberNo);
        MemberRec.SetRange(MemberRec."Product Type", '02');
        if MemberRec.Find('-') then begin
            LastDepositdate := MemberRec."Last Transaction Date";
        end;
        //Credit Ledger Entry
        MemberLedgEntry.Reset;
        MemberLedgEntry.SetCurrentkey("Member No.", "Posting Date");
        MemberLedgEntry.SetRange("Member No.", MemberNo);
        MemberLedgEntry.SetRange(MemberLedgEntry."Transaction Type", MemberLedgEntry."transaction type"::Repayment);
        if MemberLedgEntry.Find('+') then begin
            LastLoanRepayment := MemberLedgEntry."Posting Date";
            //MESSAGE(FORMAT(LastLoanRepayment));
        end;
        //Savings Account
        MemberRec.Reset;
        MemberRec.SetCurrentkey("Member No.", "Last Transaction Date");
        MemberRec.SetRange("Member No.", MemberNo);
        MemberRec.SetRange(MemberRec."Product Type", '505');
        if MemberRec.Find('-') then begin
            LastWithdrawalDate := MemberRec."Last Transaction Date";
        end;
        //Members
        Members.Reset;
        Members.SetCurrentkey("No.", "Registration Date");
        Members.SetRange("No.", MemberNo);
        if Members.Find('-') then begin
            DateOfJoin := Members."Registration Date";
        end;
    end;


    procedure setLastRepayDate(LoanNo: Code[20]) InRange: Boolean
    var
        MemberLedger: Record "Credit Ledger Entry";
    begin
        MemberLedger.Reset;
        MemberLedger.SetCurrentkey("Transaction Type", "Loan No", "Posting Date", "Customer No.");
        MemberLedger.SetRange("Loan No", LoanNo);
        MemberLedger.SetRange("Transaction Type", MemberLedger."transaction type"::Repayment);
        MemberLedger.SetRange("Posting Date", CalcDate('-3D', Today), Today);
        if MemberLedger.FindFirst then
            InRange := true;
    end;
}
