#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185714 "Sasra Loan Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Sasra Loan Register.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_30; 30)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemLinkReference = Members;
                //DataItemTableView = where(Posted = filter(Yes));
                RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(MemberNo_Loans; Loans."Member No.")
                {
                }
                column(MemberName_Loans; Loans."Member Name")
                {
                }
                column(Installemnt; Loans.Installments)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount; Loans."Approved Amount")
                {
                }
                column(OutBal; Loans."Outstanding Balance")
                {
                }
                column(OutInt; Loans."Outstanding Interest")
                {
                }
                column(OutBill; Loans."Outstanding Bills")
                {
                }
                column(Picture; Company.Picture)
                {
                }
                column(Address; Company.Address)
                {
                }
                column(Company_Name; Company.Name)
                {
                }
                column(EmployerLoanNo; Loans."Employer Loan No.")
                {
                }
                column(BatchNo_Loans; Loans."Batch No.")
                {
                }
                column(ShareBoostedAmount; Loans."Share Boosted Amount")
                {
                }
                column(ShareBoostedAmount1; Loans."Loans - Deposit Purchase")
                {
                }
                column(EmployerCode; Loans."Employer Code")
                {
                }
                column(AmntTp; AmntTp)
                {
                }
                column(StaffNo; Loans."Staff No")
                {
                }
                column(Days; CountMonths)
                {
                }
                column(ProductType; ProductType)
                {
                }
                column(EmployerName; EmployerName)
                {
                }
                column(OutstandingBills_Loans; Loans."Outstanding Bills")
                {
                }
                column(AccountCategory; AccountCategory)
                {
                }
                column(InterestCalculationMethod; Loans."Interest Calculation Method")
                {
                }
                column(Interest_Loans; Loans.Interest)
                {
                }
                column(RepaymentFrequency_Loans; Loans."Repayment Frequency")
                {
                }
                column(LoansCategorySASRA; Loans."Loans Category-SASRA")
                {
                }
                column(DisbursmentDate; DisbursmentDate)
                {
                }
                column(ExpectedDateofCompletion_Loans; Loans."Expected Date of Completion")
                {
                }
                column(LoanMaturity; LoanMaturity)
                {
                }
                column(FirstPayDate; FirstPayDate)
                {
                }
                column(LastPayDate; LastPayDate)
                {
                }
                column(TotalLastPay; TotalLastPay)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AmntTp := 0;
                    EmployerName := '';
                    ProductType := '';


                    ExpdRepayment := 0;
                    LoanAge := 0;
                    AmtInArrears := 0;
                    AmtPaid := 0;
                    IssueDate := 0D;
                    DaysInArrears := 0;
                    PrincipalRepay := 0;
                    DefaultedDays := 0;
                    DaysDefaulted := 0;
                    LoanAge := 0;
                    InterestPaid := 0;
                    CountMonths := 0;
                    NoDays := 0;
                    if Loans.Repayment <> 0 then begin
                        Loans.CalcFields("Loan Span");
                        if Loans."Loan Span" = Loans."loan span"::"Major" then begin
                            CountMonths := ROUND((Loans."Outstanding Bills" + Loans."Outstanding Interest") / (Loans.Repayment));
                            if CountMonths < 0 then
                                CountMonths := 0;
                            if Loans."Outstanding Balance" <= 0 then
                                CountMonths := 0;
                        end else
                            if Loans."Loan Span" = Loans."loan span"::"Minor" then begin
                                if Loans."Loan Principle Repayment" = 0 then
                                    CountMonths := ROUND((Loans."Outstanding Bills") / (Loans.Repayment)) else
                                    CountMonths := ROUND((Loans."Outstanding Bills") / (Loans."Loan Principle Repayment"));
                                if CountMonths < 0 then
                                    CountMonths := 0;
                                if Loans."Outstanding Balance" <= 0 then
                                    CountMonths := 0;

                            end else begin
                                CountMonths := ROUND((Loans."Outstanding Bills" + Loans."Outstanding Interest") / (Loans.Repayment));
                                if CountMonths < 0 then
                                    CountMonths := 0;
                                if Loans."Outstanding Balance" <= 0 then
                                    CountMonths := 0;
                            end;
                        FirstPayDate := 0D;
                        LastPayAmnt := 0;
                        LastPayDate := 0D;
                        LastIntPaid := 0;
                        TotalLastPay := 0;
                        CreditLedgerEntry.Reset;
                        CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                        CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::Repayment);
                        if CreditLedgerEntry.Find('+') then begin
                            LastPayAmnt := CreditLedgerEntry.Amount * -1;
                            LastPayDate := CreditLedgerEntry."Posting Date";

                        end;

                        CreditLedgerEntry.Reset;
                        CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                        CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::"Interest Paid");
                        if CreditLedgerEntry.Find('+') then begin
                            LastIntPaid := CreditLedgerEntry.Amount * -1;

                        end;
                        CreditLedgerEntry.Reset;
                        CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                        CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::"Interest Paid");
                        if CreditLedgerEntry.Find('-') then begin
                            FirstPayDate := CreditLedgerEntry."Posting Date";

                        end;

                        TotalLastPay := LastIntPaid + LastPayAmnt;




                        if (Loans."Loan Product Type" = '126') or (Loans."Loan Product Type" = '123') then begin
                            if Loans."Outstanding Balance" > 0 then begin
                                CreditLedgerEntry.Reset;
                                CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                                CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::Loan);
                                if CreditLedgerEntry.Find('+') then begin
                                    NoDays := Loans.GetRangemax("Date Filter") - CreditLedgerEntry."Posting Date";
                                end else
                                    NoDays := Loans.GetRangemax("Date Filter") - Loans."Disbursement Date";

                                CountMonths := ROUND(NoDays / 30);
                                if CountMonths < 0 then
                                    CountMonths := 0;
                                if Loans."Outstanding Balance" <= 0 then
                                    CountMonths := 0;
                            end;
                        end;



                        OtherCommitementsClearance.Reset;
                        OtherCommitementsClearance.SetRange("Loan No.", Loans."Loan No.");
                        if OtherCommitementsClearance.Find('-') then begin
                            OtherCommitementsClearance.CalcSums(Amount);
                            AmntTp := AmntTp + OtherCommitementsClearance.Amount;
                        end;

                        Days := 0;
                        if Loans."Disbursement Date" <> 0D then
                            Days := Today - Loans."Disbursement Date";
                        if ProductFactory.Get(Loans."Loan Product Type") then
                            ProductType := ProductFactory."Product Description";
                        if Customer.Get(Loans."Employer Code") then
                            EmployerName := Customer.Name;
                        if Member.Get(Loans."Member No.") then
                            AccountCategory := Member."Account Category";
                        if Loans."Disbursement Date" = 0D then
                            DisbursmentDate := Loans."Application Date" else
                            DisbursmentDate := Loans."Disbursement Date";
                    end;

                    if Installments > 1000 then begin
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        LoanMaturity := CalcDate(InstalmentPeriods, DisbursmentDate);
                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
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
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        Customer: Record Customer;
        EmployerName: Text;
        ProductFactory: Record "Product Factory";
        AccountCategory: enum "Account Category";
        Member: Record "Members";
        DisbursmentDate: Date;
        LoanMaturity: Date;
        IntstallMentPeriodText: Text;
        InstalmentPeriods: DateFormula;
        LnReshedule: Record "Ideal Repayment Schedule";
        DateFilter: Text[100];
        FromDate: Text[100];
        ToDate: Text[100];
        StartDate: Date;
        EndDate: Date;
        ExpdRepayment: Decimal;
        LoanAge: Integer;
        LoanNo: Code[20];
        CutOffDate: Date;
        AmtPaid: Decimal;
        AmtInArrears: Decimal;
        IssueDate: Date;
        DaysInArrears: Decimal;
        PrincipalRepay: Decimal;
        DefaultedDays: Integer;
        DaysDefaulted: Decimal;
        InterestPaid: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        CountMonths: Decimal;
        NoDays: Decimal;
        FirstPayDate: Date;
        LastPayDate: Date;
        LastPayAmnt: Decimal;
        LastIntPaid: Decimal;
        TotalLastPay: Decimal;
}
