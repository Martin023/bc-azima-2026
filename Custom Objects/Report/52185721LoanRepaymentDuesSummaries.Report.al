#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185721 "Loan Repayment Dues Summaries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Repayment Dues Summaries.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = CONST(Employer));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Repayment; RepaymentAmnt)
            {
            }
            column(OutstandingBill; Bills)
            {
            }
            column(OutstandingIntestt; Int)
            {
            }
            column(OverDueAmnt; OverDueAmnt)
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
            column(LoanBal; LoanBal)
            {
            }

            trigger OnAfterGetRecord()
            begin


                OverDueAmnt := 0;
                Bills := 0;
                RepaymentAmnt := 0;
                Int := 0;
                LoanBal := 0;
                Loans.Reset;
                Loans.SetFilter("Outstanding Balance", '>0');
                Loans.SetRange("Employer Code", Customer."No.");
                if Loans.Find('-') then begin
                    repeat
                        Countl := Loans.Count;
                        Loans.CalcFields("Outstanding Balance", "Outstanding Bills", "Outstanding Interest");
                        Bills := Bills + Loans."Outstanding Bills";
                        Int := Int + Loans."Outstanding Interest";
                        RepaymentAmnt := RepaymentAmnt + Loans.Repayment;
                        LoanBal := LoanBal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;

                OverDueAmnt := (Bills + Int) - RepaymentAmnt;
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
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Loans: Record Loans;
        RepaymentAmnt: Decimal;
        Bills: Decimal;
        Int: Decimal;
        OverDueAmnt: Decimal;
        Countl: Integer;
        LoanBal: Decimal;
        Company: Record "Company Information";
}
