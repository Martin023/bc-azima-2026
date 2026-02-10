#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185922 "Batch Loan Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Batch Loan Register.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where("Batch No." = filter(<> ""));
            RequestFilterFields = "Batch No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(ApplicationDate; Loans."Application Date")
            {
            }
            column(LoanProductType; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(InterestCalculationMethod; Loans."Interest Calculation Method")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(Interest; Loans.Interest)
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(OutstandingBalance; Loans."Outstanding Balance")
            {
            }
            column(OutstandingInterest; Loans."Outstanding Interest")
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(BatchNo; Loans."Batch No.")
            {
            }
            column(CapturedBy; Loans."Captured By")
            {
            }
            column(ApprovedBy; Loans."Approved By")
            {
            }
            dataitem("Loan Disbursement Header"; "Loan Disbursement Header")
            {
                DataItemLink = "No." = field("Batch No.");
                column(ReportForNavId_6; 6)
                {
                }
                column(PostedBy; "Loan Disbursement Header"."Posted By")
                {
                }
                column(DatePosted; "Loan Disbursement Header"."Date Posted")
                {
                }
                column(Branch; "Loan Disbursement Header"."Global Dimension 2 Code")
                {
                }
            }
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
        if CI.Get() then
            CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
}
