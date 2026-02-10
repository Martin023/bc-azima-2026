#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185757 "Premier Loan Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Premier Loan Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Loan No.") order(ascending) where("Outstanding Balance" = filter(<> 0));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Date Filter", "Member No.", "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(NO; NO)
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(ApprovalDate_Loans; Loans."Approval Date")
            {
            }
            column(Installment_Period; Loans.Installments)
            {
            }
            column(RepaymentStartDate_Loans; Loans."Repayment Start Date")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(BosaDeposit; BosaDeposit)
            {
            }
            column(LoanSecurityOption; LoanSecurityOption)
            {
            }
            column(SerialNumber; SeriNumber)
            {
            }
            column(OutStandingBalance; Loans."Outstanding Balance")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(InterestCharged; InterestCharged)
            {
            }
            column(InterestPaid; InterestPaid)
            {
            }
            column(OutstandingInterest; Loans."Outstanding Interest")
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                NO += 1;
                MemberCust.Reset;
                MemberCust.SetRange("No.", Loans."Member No.");
                // MemberCust.SetFilter("Member Category", '%1', 'PREMIER');
                if MemberCust.Find('-') then begin
                    SeriNumber := SeriNumber + 1;
                    BosaDeposit := 0;
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then
                        SavingsAccounts.CalcFields("Balance (LCY)");
                    BosaDeposit := SavingsAccounts."Balance (LCY)";


                    CreditLedgerEntry.Reset;
                    CreditLedgerEntry.SetRange("Member No.", Loans."Member No.");
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."transaction type"::"Interest Due");
                    if CreditLedgerEntry.Find('-') then
                        CreditLedgerEntry.CalcSums("Amount (LCY)");
                    InterestCharged := CreditLedgerEntry."Amount (LCY)";


                    CreditLedgerEntry.Reset;
                    CreditLedgerEntry.SetRange("Member No.", Loans."Member No.");
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."transaction type"::"Interest Paid");
                    if CreditLedgerEntry.Find('-') then
                        CreditLedgerEntry.CalcSums("Amount (LCY)");
                    InterestPaid := CreditLedgerEntry."Amount (LCY)";

                    /*

                    LoanSecurities.RESET;
                    LoanSecurities.SETRANGE("Member No",Loans."Member No.");
                    IF LoanSecurities.FIND('-') THEN
                      LoanSecurityOption := LoanSecurities."Guarantor Type";*/
                end else
                    CurrReport.Skip;

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
        BosaDeposit: Decimal;
        LoanSecurityOption: Option Guarantor,Collateral,Lien;
        LoanSecurities: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        SeriNumber: Integer;
        MemberCust: Record "Members";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        InterestCharged: Decimal;
        InterestPaid: Decimal;
        NO: Integer;
}
