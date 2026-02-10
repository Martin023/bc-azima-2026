#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185701 "Loan Repayment Dues"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Repayment Dues.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Balance", "Outstanding Interest", "Outstanding Bills";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(LoanType; Loans."Loan Product Type")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
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
            column(Balance; Loans."Outstanding Balance")
            {
            }
            column(InterestDue; Loans."Outstanding Interest")
            {
            }
            column(Bills; Loans."Outstanding Bills")
            {
            }
            column(Overdue; Overdue)
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(LoanTypeName; Loans."Loan Product Type Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Overdue := 0;
                Overdue := (Loans."Outstanding Bills" + Loans."Outstanding Interest");
                Customer.Reset;
                Customer.SetRange("Account Type", Customer."account type"::Employer);
                Customer.SetRange("No.", Loans."Employer Code");
                if Customer.Find('-') then begin
                    EmployerName := Customer.Name;
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

    trigger OnPreReport()
    begin
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        Overdue: Decimal;
        Customer: Record Customer;
        EmployerName: Text;
}
