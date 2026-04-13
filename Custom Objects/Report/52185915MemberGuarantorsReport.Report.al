

Report 52185915 "Member Guarantors Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Guarantors Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Posted = filter(Yes), Repayment = filter(<> 0));
            RequestFilterFields = "Loan No.", Repayment, "Application Date", "Loan Product Type", "Member No.", "Disbursement Date", Status, "Outstanding Balance", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(Loan_No; Loans."Loan No.")
            {
            }
            column(Member_No; Loans."Member No.")
            {
            }
            column(Mmember_name; Loans."Member Name")
            {
            }
            column(Loan_Type; Loans."Loan Product Type")
            {
            }
            column(Loan_TypeName; Loans."Loan Product Type Name")
            {
            }
            column(Approved_amount; Loans."Approved Amount")
            {
            }
            column(Outstanding_Balance; Loans."Outstanding Balance")
            {
            }
            column(Outstanding_Interest; Loans."Outstanding Interest")
            {
            }
            column(Arrears; Arreas)
            {
            }

            column(Monthly_installements; Loans.Repayment)
            {
            }
            column(Date_Issued; Loans."Disbursement Date")
            {
            }

            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Staff_No; Loans."Staff No")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(LoaneePhone; LoaneePhone)
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(Loan_Account; Loans."Loan Account")
            {
            }
            column(LoaneePhysical_Addr; LoaneeAddress)
            {
            }
            column(Loanee_Email; LoaneeEmail)
            {
            }
            column(Employer_Address; EmployerAddress)
            {
            }
            column(Loanee_Postal; LoaneePostal)
            {
            }
            column(Branch; LoaneeBranch)
            {
            }
            column(Employer_Code; EmployerCode)
            {
            }

            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No.");
                column(Loanee_Name; "Loanee Name")
                {

                }
                column(Guarantor_Type; "Guarantor Type")
                {

                }
                column(Guarantor_Status; "Guarantor Status")
                {
                }
                column(Amount_Guaranteed; "Amount Guaranteed")
                {

                }
                column(Percentage_Guaranteed; PercentageGur)
                {

                }
                column(Staff_Payroll_No_; "Staff/Payroll No.")
                {

                }
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        AmountPaid: Decimal;
        Arreas: Decimal;
        Days_Defaulted: Integer;
        LastPayDate: Date;
        Members: Record "Members";
        GuarEmail: Text;
        GuarPhone: Code[15];
        com: Integer;
        Company: Record "Company Information";
        CreditLedger: Record "Credit Ledger Entry";
        LoanGuara: Record "Loan Guarantors and Security";
        IDNo: Code[10];
        LoaneePhone: Code[15];
        LoaneeAddress: Text;
        LoaneeEmail: Text;
        LoaneeBranch: Text;
        EmployerAddress: Text;
        LoaneePostal: Code[10];
        GuarAddress: Text;
        EmployerCode: Code[10];
        GuarPFNO: Code[15];
}


