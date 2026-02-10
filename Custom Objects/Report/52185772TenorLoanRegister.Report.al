#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185772 "Tenor Loan Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tenor Loan Register.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where("Outstanding Balance" = filter(> 0), Posted = const(Yes));
            RequestFilterFields = "Member No.", "Loan Product Type", "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(Interest_Loans; Loans.Interest)
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(ApprovalDate_Loans; Loans."Approval Date")
            {
            }
            column(Installments_Loans; Loans.Installments)
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Balance")
            {
            }
            column(LoanAccount_Loans; Loans."Loan Account")
            {
            }
            column(RemanindPeriod; RemainingP)
            {
            }
            column(HouseholdIncome; HouseholdIncome)
            {
            }
            column(LoanProductType; Loans."Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoanAge := 0;
                RemainingP := 0;
                HouseholdIncome := 0;
                Dfilter := Loans.GetRangemax("Date Filter");
                LoanAge := (Dfilter - "Disbursement Date");
                LoanAge := ROUND(LoanAge / 30, 1, '=');
                RemainingP := (Loans.Installments - LoanAge);
                if RemainingP < 0 then
                    RemainingP := 0;
                AppraisalSalaryDetails.Reset;
                AppraisalSalaryDetails.SetRange("Loan No", Loans."Loan No.");
                AppraisalSalaryDetails.SetFilter(Type, '%1', AppraisalSalaryDetails.Type::"Gross Pay");
                if AppraisalSalaryDetails.Find('-') then begin
                    HouseholdIncome := AppraisalSalaryDetails.Amount;
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
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LoanAge: Decimal;
        Dfilter: Date;
        RemainingP: Decimal;
        AppraisalSalaryDetails: Record "Appraisal Salary Details";
        HouseholdIncome: Decimal;
        LoanType: Code[10];
}
