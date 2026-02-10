#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185739 "Loans Movement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loans Movement Report.rdl';

    dataset
    {
        dataitem(Loan; Loans)
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "Date Filter", "Global Dimension 2 Code", "Global Dimension 1 Code", "Loan Product Type", "Source Unit";
            column(ReportForNavId_1; 1)
            {
            }
            column(Product_ID; Loans."Loan Product Type")
            {
            }
            column(Loan_Type; ProductName)
            {
            }
            column(Balance_BF; BalanceBF)
            {
            }
            column(Total_Loan_Issued; TotalLoanIssued)
            {
            }
            column(Total_Interest_Paid; TotalIntPaid)
            {
            }
            column(Balance_CF; BalanceCF)
            {
            }
            column(Total_Principle_Paid; TotalPrincPaid)
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
            column(DateFilter; DateFilter)
            {
            }
            column(Branch; BranchCode)
            {
            }
            column(Activity; Actvity)
            {
            }
            column(LoanCount; LoanCount)
            {
            }
            column(LoanNo_Loan; Loan."Loan No.")
            {
            }
            column(ProductName; ProductName)
            {
            }
            column(MemberName_Loan; Loan."Member Name")
            {
            }
            column(MemberNo_Loan; Loan."Member No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                BalanceBF := 0;
                TotalLoanIssued := 0;
                TotalIntPaid := 0;
                TotalPrincPaid := 0;
                BalanceCF := 0;
                ProductName := '';
                if ProductFactory.Get(Loan."Loan Product Type") then
                    ProductName := ProductFactory."Product Description";
                LowerDateLimit := CalcDate('-1D', Loan.GetRangeMin("Date Filter"));
                UpperDateLimit := Loan.GetRangemax("Date Filter");

                BalanceBF := 0;
                //Loans.RESET;
                //Loans.SETRANGE("Global Dimension 2 Code","Product Factory".GETFILTER("Global Dimension 1 Filter"));
                //Loans.SETFILTER("Date Filter","Product Factory"."Date Filter");
                Loans.Reset;
                Loans.SetRange("Loan No.", Loan."Loan No.");
                Loans.SetRange(Posted, true);
                Loans.SetFilter("Date Filter", '..' + Format(LowerDateLimit));
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance");
                    BalanceBF := Loans."Outstanding Balance";
                end;
                Loans.Reset;
                Loans.SetRange("Loan No.", Loan."Loan No.");
                Loans.SetRange(Posted, true);
                Loans.SetFilter("Date Filter", (Format(LowerDateLimit) + '..' + Format(UpperDateLimit)));
                if Loans.Find('-') then begin
                    Loans.CalcFields("Loan Amount");
                    TotalLoanIssued := Loans."Loan Amount";
                end;

                //Int Paid
                Loans.Reset;
                Loans.SetRange("Loan No.", Loan."Loan No.");
                Loans.SetRange(Posted, true);
                Loans.SetFilter("Date Filter", (Format(LowerDateLimit) + '..' + Format(UpperDateLimit)));
                if Loans.Find('-') then begin
                    Loans.CalcFields("Interest Paid");
                    TotalIntPaid := Loans."Interest Paid";
                end;
                //Repayments
                Loans.Reset;
                Loans.SetRange("Loan No.", Loan."Loan No.");
                Loans.SetRange(Posted, true);
                Loans.SetFilter("Date Filter", (Format(LowerDateLimit) + '..' + Format(UpperDateLimit)));
                if Loans.Find('-') then begin
                    Loans.CalcFields("Principle Paid");
                    TotalPrincPaid := Loans."Principle Paid";
                end;
                //Balance CF
                Loans.Reset;
                Loans.SetRange("Loan No.", Loan."Loan No.");
                Loans.SetRange(Posted, true);
                Loans.SetFilter("Date Filter", '..' + Format(UpperDateLimit));
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance");
                    BalanceCF := Loans."Outstanding Balance";
                end;
                //LoanCount:=Loans.COUNT;
                //IF LoanCount=0 THEN CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Company.Picture);
                DateFilter := Loan.GetFilter("Date Filter");
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

    var
        BalanceBF: Decimal;
        TotalLoanIssued: Decimal;
        TotalIntPaid: Decimal;
        TotalPrincPaid: Decimal;
        BalanceCF: Decimal;
        LowerDateLimit: Date;
        UpperDateLimit: Date;
        CreditLedger: Record "Credit Ledger Entry";
        LoansCount: Integer;
        Company: Record "Company Information";
        DateFilter: Text;
        Actvity: Text;
        BranchCode: Text;
        LoanCount: Integer;
        Loans: Record Loans;
        ProductName: Text;
        ProductFactory: Record "Product Factory";
}
