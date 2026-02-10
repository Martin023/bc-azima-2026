#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185750 "Employers Expected Due"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Employers Expected Due.rdl';

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
            column(LoanBalance; LoanBal)
            {
            }
            column(InterestBalance; InterestBal)
            {
            }
            column(DepostAmoun; DepositAmnt)
            {
            }
            column(SinkFundAmount; SinkFund)
            {
            }
            column(PrincipaleRep; PrincipaleRep)
            {
            }
            column(IntRep; IntRep)
            {
            }
            column(JoiningFee; JoiningFee)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoanBal := 0;
                PrincipaleRep := 0;
                InterestBal := 0;
                DepositAmnt := 0;
                SinkFund := 0;
                LoanInterestRepayment := 0;
                LoanPrincilpleRepayment := 0;
                JoiningFee := 0;

                Loans.Reset;
                Loans.SetRange("Employer Code", Customer."No.");
                Loans.SetFilter("Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
                        Loans.CalcSums("Loan Principle Repayment", "Loan Interest Repayment");
                        //LoanBal+=Loans."Outstanding Balance";
                        //PrincipaleRep+=Loans."Outstanding Bills";
                        //InterestBal+=Loans."Outstanding Interest";

                        LoansInterest.Reset;
                        LoansInterest.SetRange("Loan No.", Loans."Loan No.");
                        LoansInterest.SetFilter("Interest Date", Customer.GetFilter(Customer."Date Filter"));
                        if LoansInterest.Find('-') then begin
                            LoansInterest.CalcSums("Interest Bill", "Repayment Bill");
                            PrincipaleRep += LoansInterest."Repayment Bill";
                            IntRep += LoansInterest."Interest Bill"

                        end;
                    until Loans.Next = 0;
                end;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Employer Code", Customer."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                SavingsAccounts.SetFilter(Status, '%1|%2|%3|%4', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant, SavingsAccounts.Status::New, SavingsAccounts.Status::Defaulter);
                if SavingsAccounts.Find('-') then begin
                    repeat
                        SavingsAccounts.CalcSums("Monthly Contribution");
                        DepositAmnt := SavingsAccounts."Monthly Contribution";
                    until SavingsAccounts.Next = 0;
                end;


                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Employer Code", Customer."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Benevolent (BBF)");
                SavingsAccounts.SetFilter(Status, '%1|%2|%3|%4', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant, SavingsAccounts.Status::New, SavingsAccounts.Status::Defaulter);
                if SavingsAccounts.Find('-') then begin
                    repeat
                        SavingsAccounts.CalcSums("Monthly Contribution");
                        SinkFund := SavingsAccounts."Monthly Contribution";
                    until SavingsAccounts.Next = 0;
                end;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Employer Code", Customer."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Entrance Fee");
                SavingsAccounts.SetFilter("Registration Date", Customer.GetFilter(Customer."Date Filter"));
                SavingsAccounts.SetFilter(Status, '%1|%2|%3|%4', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant, SavingsAccounts.Status::New, SavingsAccounts.Status::Defaulter);
                if SavingsAccounts.Find('-') then begin
                    repeat
                        SavingsAccounts.CalcSums("Monthly Contribution");
                        JoiningFee := SavingsAccounts."Monthly Contribution";
                    until SavingsAccounts.Next = 0;
                end;
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
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        LoanBal: Decimal;
        PrincipaleRep: Decimal;
        IntRep: Decimal;
        DepositAmnt: Decimal;
        SinkFund: Decimal;
        InterestBal: Decimal;
        LoanPrincilpleRepayment: Decimal;
        LoanInterestRepayment: Decimal;
        LoansInterest: Record "Loans Interest";
        JoiningFee: Decimal;
}
