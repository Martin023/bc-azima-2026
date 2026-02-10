namespace KenpipeCBS.KenpipeCBS;

report 52186213 "Loans without STO"
{
    ApplicationArea = All;
    Caption = 'Loans without STO';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan without STO.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(Loans; Loans)
        {
            Dataitemtableview = where("Recovery Mode" = filter(Hybrid), "Total Loan Balance" = filter(> 0));
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(MemberName; loans."Member Name")
            {
            }
            column(Checkoff_Amount; "Checkoff Amount")
            {
            }
            column(Salary_Amount; "Salary Amount")
            {
            }
            column(Total_Loan_Balance; "Total Loan Balance")
            {

            }
            trigger OnAfterGetRecord()
            begin
                STONo := '';
                STOAmt := 0;
                CheckoffAmt := 0;
                STOLines.reset;
                STOLines.setrange("Loan No.", Loans."Loan No.");
                STOLines.SetAutoCalcFields(status);
                STOLines.setrange(status, STOLines.status::Approved);
                if not STOLines.IsEmpty() then begin
                    CurrReport.skip;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        STOLines: record "Standing Order Lines";
        STONo: Code[20];
        STOAmt: Decimal;
        CheckoffAmt: Decimal;
}
