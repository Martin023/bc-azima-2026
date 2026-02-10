#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185978 "Defaulter Notice-3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Defaulter Notice-3.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            //column(CompName; CompName)
            //{
            //}
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                RequestFilterFields = "Loan No.";
                column(ReportForNavId_2; 2)
                {
                }
                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
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
                column(OutstandingInterest_Loans; Loans."Outstanding Interest")
                {
                }
                column(OutstandingBills_Loans; Loans."Outstanding Bills")
                {
                }
                column(Installments_Loans; Loans.Installments)
                {
                }
                //dataitem(52185739; 52185739)
                dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
                {
                    DataItemLink = "Loan No" = field("Loan No.");
                    column(ReportForNavId_19; 19)
                    {
                    }
                    column(LoanNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loan No")
                    {
                    }
                    column(SavingsAccountNoMemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Savings Account No./Member No.")
                    {
                    }
                    column(Name_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Name)
                    {
                    }
                    column(LoanBalance_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loan Balance")
                    {
                    }
                    column(Shares_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Deposits/Shares")
                    {
                    }
                    column(NoOfLoansGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."No Of Loans Guaranteed")
                    {
                    }
                    column(Substituted_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Substituted)
                    {
                    }
                    column(Date_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Date)
                    {
                    }
                    column(SharesRecovery_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Shares Recovery")
                    {
                    }
                    column(NewUpload_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."New Upload")
                    {
                    }
                    column(AmountGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Amount Guaranteed")
                    {
                    }
                    column(StaffPayrollNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Staff/Payroll No.")
                    {
                    }
                    column(AccountNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Account No.")
                    {
                    }
                    column(SelfGuarantee_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Self Guarantee")
                    {
                    }
                    column(IDNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."ID No.")
                    {
                    }
                    column(OutstandingBalance_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Outstanding Balance")
                    {
                    }
                    column(MemberGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member Guaranteed")
                    {
                    }
                    column(PercentageGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Percentage Guaranteed")
                    {
                    }
                    column(TotalGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Total Guaranteed")
                    {
                    }
                    column(AvailableShares_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Available Shares")
                    {
                    }
                    column(Signature_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Signature)
                    {
                    }
                    column(MemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member No")
                    {
                    }
                    column(LoanType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loan Type")
                    {
                    }
                    column(GuaranteedBalance_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guaranteed Balance")
                    {
                    }
                    column(LoaneeName_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loanee Name")
                    {
                    }
                    column(GuarantorType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Type")
                    {
                    }
                    column(CollateralRegNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Collateral Reg. No.")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompName := COMPANYNAME;
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
        CompName: Text[100];
}
