#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185775 "HR Loan Repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Loan Repayment Schedule.rdl';

    dataset
    {
        dataitem("prSalary Advance"; "prSalary Advance")
        {
            RequestFilterFields = "Requisition No.", "Employee No";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(Loans_Loans__Loan__No__; "prSalary Advance"."Requisition No.")
            {
            }
            column(Loans_Loans__Issued_Date_; "prSalary Advance"."Application Date")
            {
            }
            column(LoanTypes_prSalaryAdvance; "prSalary Advance"."Loan Types")
            {
            }
            column(Loans_Loans__Client_Code_; "prSalary Advance"."Employee No")
            {
            }
            column(Loans_Loans__Client_Name_; "prSalary Advance"."Employee Names")
            {
            }
            column(IDNo_prSalaryAdvance; "prSalary Advance"."ID No.")
            {
            }
            column(Designation_prSalaryAdvance; "prSalary Advance".Designation)
            {
            }
            column(AdvanceAmountRequested_prSalaryAdvance; "prSalary Advance"."Advance Amount Requested")
            {
            }
            column(ReasonsforAdvanceAmount_prSalaryAdvance; "prSalary Advance"."Reasons for Advance Amount")
            {
            }
            column(Status_prSalaryAdvance; "prSalary Advance".Status)
            {
            }
            column(Eligible_prSalaryAdvance; "prSalary Advance".Eligible)
            {
            }
            column(NoSeries_prSalaryAdvance; "prSalary Advance"."No. Series")
            {
            }
            column(RepaymentPeriod_prSalaryAdvance; "prSalary Advance"."Repayment Period")
            {
            }
            column(InstalmentsAmount_prSalaryAdvance; "prSalary Advance"."Instalments Amount")
            {
            }
            column(Loans_Loans_Interest; "prSalary Advance"."Interest Rate")
            {
            }
            column(ExpectedRepaymentAmount_prSalaryAdvance; "prSalary Advance"."Expected Repayment Amount")
            {
            }
            column(ResponsibilityCenter_prSalaryAdvance; "prSalary Advance"."Responsibility Center")
            {
            }
            column(County_prSalaryAdvance; "prSalary Advance".County)
            {
            }
            column(Department_prSalaryAdvance; "prSalary Advance".Department)
            {
            }
            column(BasicSalary_prSalaryAdvance; "prSalary Advance"."Basic Salary")
            {
            }
            column(V13ofBasicSalary_prSalaryAdvance; "prSalary Advance"."1/3/ of Basic Salary")
            {
            }
            column(NetPay_prSalaryAdvance; "prSalary Advance"."Net Pay")
            {
            }
            column(Contracttype_prSalaryAdvance; "prSalary Advance"."Contract type")
            {
            }
            column(MonthsSalary_prSalaryAdvance; "prSalary Advance"."Months Salary")
            {
            }
            column(LoanType_prSalaryAdvance; "prSalary Advance"."Loan Type")
            {
            }
            column(Loans_Loans__Loan_Product_Type_Name_; "prSalary Advance"."Loan Description")
            {
            }
            column(Loans_Installments__Grace_Period___Principle__M__; "prSalary Advance"."No of Instalments")
            {
            }
            column(RepaymentFrequency_prSalaryAdvance; "prSalary Advance"."Repayment Frequency")
            {
            }
            column(GracePeriodPrincipleM_prSalaryAdvance; "prSalary Advance"."Grace Period - Principle (M)")
            {
            }
            column(GracePeriodInterestM_prSalaryAdvance; "prSalary Advance"."Grace Period - Interest (M)")
            {
            }
            column(Loans__Repayment_Method_; "prSalary Advance"."Repayment Method")
            {
            }
            column(PayrollCode_prSalaryAdvance; "prSalary Advance"."Payroll Code")
            {
            }
            column(Posted_prSalaryAdvance; "prSalary Advance".Posted)
            {
            }
            column(LoanNo_prSalaryAdvance; "prSalary Advance"."Loan No.")
            {
            }
            column(Loans_Loans__Approved_Amount_; "prSalary Advance"."Amount Approved")
            {
            }
            column(LoanPrincipalRepayment_prSalaryAdvance; "prSalary Advance"."Loan Principal Repayment")
            {
            }
            column(LoanInterestRepayment_prSalaryAdvance; "prSalary Advance"."Loan Interest Repayment")
            {
            }
            column(UserID_prSalaryAdvance; "prSalary Advance"."User ID")
            {
            }
            column(Account_prSalaryAdvance; "prSalary Advance".Account)
            {
            }
            column(AmountPaid_prSalaryAdvance; "prSalary Advance"."Amount Paid")
            {
            }
            column(Balance_prSalaryAdvance; "prSalary Advance".Balance)
            {
            }
            column(Picture_prSalaryAdvance; "prSalary Advance".Picture)
            {
            }
            column(SupervisorEmail_prSalaryAdvance; "prSalary Advance"."Supervisor Email")
            {
            }
            column(Supervisor_prSalaryAdvance; "prSalary Advance".Supervisor)
            {
            }
            column(Repayment_prSalaryAdvance; "prSalary Advance".Repayment)
            {
            }
            column(TotalLoanRepaymentAmount_prSalaryAdvance; "prSalary Advance"."Total Loan Repayment Amount")
            {
            }
            column(Loans__Repayment_Method_Caption; FieldCaption("Repayment Method"))
            {
            }
            column(COMPANY_NAME; COMPANYNAME)
            {
            }
            dataitem("HR Loan Repayment Schedule"; "HR Loan Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Loan No.", "Staff No.", "Repayment Date");
                RequestFilterFields = "Staff No.", "Loan No.";
                column(ReportForNavId_9169; 9169)
                {
                }
                column(ROUND__Monthly_Repayment__10_____; ROUND("Monthly Repayment"))
                {
                }
                column(FORMAT__Repayment_Date__0_4_; Format("Repayment Date", 0, 4))
                {
                }
                column(ROUND__Principal_Repayment__10_____; ROUND("Principal Repayment"))
                {
                }
                column(ROUND__Monthly_Interest__10_____; ROUND("Monthly Interest"))
                {
                }
                column(LoanBalance; ROUND(LoanBalance))
                {
                }
                column(Loan_Repayment_Schedule__Repayment_Code_; "Repayment Code")
                {
                }
                column(ROUND__Monthly_Repayment__10______Control1000000043; ROUND("Monthly Repayment", 10, '='))
                {
                }
                column(ROUND__Principal_Repayment__10______Control1000000014; ROUND("Principal Repayment", 10, '='))
                {
                }
                column(ROUND__Monthly_Interest__10______Control1000000015; ROUND("Monthly Interest", 10, '='))
                {
                }
                column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
                {
                }
                column(InterestCaption; InterestCaptionLbl)
                {
                }
                column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
                {
                }
                column(Due_DateCaption; Due_DateCaptionLbl)
                {
                }
                column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
                {
                }
                column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Loan_Repayment_Schedule_Loan_No_; "Loan No.")
                {
                }
                column(Loan_Repayment_Schedule_Member_No_; "HR Loan Repayment Schedule"."Staff No.")
                {
                }
                column(Loan_Repayment_Schedule_Repayment_Date; "Repayment Date")
                {
                }
                column(InsuranceCharge; "HR Loan Repayment Schedule"."Actual Interest Paid")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;

                    TotalPrincipalRepayment := TotalPrincipalRepayment + "HR Loan Repayment Schedule"."Principal Repayment";

                    if i = 1 then
                        LoanBalance := "HR Loan Repayment Schedule"."Loan Amount"
                    else begin
                        LoanBalance := "HR Loan Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment +
                        "HR Loan Repayment Schedule"."Principal Repayment";
                    end;

                    CumInterest := CumInterest + "HR Loan Repayment Schedule"."Monthly Interest";
                    CumMonthlyRepayment := CumMonthlyRepayment + "HR Loan Repayment Schedule"."Monthly Repayment";
                    CumPrincipalRepayment := CumPrincipalRepayment + "HR Loan Repayment Schedule"."Principal Repayment";
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Staff No.");
                    i := 0;
                    j := 0;
                end;
            }

            // trigger OnAfterGetRecord()
            // //begin
            //     //BankDetails := '';
            //     //if LoanCategory.Get("prSalary Advance"."Loan Types") then
            //         //BankDetails:=LoanCategory."Bank Account Details";

            //         //if Cust.Get("prSalary Advance"."Employee No") then
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        Duration: Integer;
        MemberLoan: Record "HR Employees";
        IssuedDate: Date;
        LoanCategory: Record "Staff Loan Types";
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record "prSalary Advance";
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record "HR Employees";
        Intallments__Months_CaptionLbl: label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: label 'Disbursment Date';
        Current_InterestCaptionLbl: label 'Current Interest';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Loan_ProductCaptionLbl: label 'Loan Product';
        Loan_No_CaptionLbl: label 'Loan No.';
        Account_No_CaptionLbl: label 'Account No.';
        Monthly_RepaymentCaptionLbl: label 'Monthly Repayment';
        InterestCaptionLbl: label 'Interest';
        Principal_RepaymentCaptionLbl: label 'Principal Repayment';
        Due_DateCaptionLbl: label 'Due Date';
        Loan_BalanceCaptionLbl: label 'Loan Balance';
        Loan_RepaymentCaptionLbl: label 'Loan Repayment';
        TotalCaptionLbl: label 'Total';
}

