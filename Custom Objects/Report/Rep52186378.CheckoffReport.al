report 52186378 "Checkoff Report"
{
    ApplicationArea = All;
    Caption = 'Checkoff Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/CheckoffReport.rdl';
    dataset
    {
        dataitem(CheckoffHeader; "Checkoff Header")
        {
            column(No; "No.")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(ScheduledAmount; "Scheduled Amount")
            {
            }
            column(TotalCount; "Total Count")
            {
            }
            column(Description; Description)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Pic; CompInfo.Picture)
            {
            }
            dataitem("Checkoff Lines"; "Checkoff Lines")
            {
                DataItemLink = "Checkoff Header" = field("No.");
                column(Type_CheckoffLines; "Type")
                {
                }
                column(AccountNo_CheckoffLines; "Account No.")
                {
                }
                column(Amount_CheckoffLines; Amount)
                {
                }
                column(CheckoffHeader_CheckoffLines; "Checkoff Header")
                {
                }
                column(MemberNo_CheckoffLines; "Member No.")
                {
                }
                column(PayrollNo_CheckoffLines; "Payroll No.")
                {
                }
                column(Name_CheckoffLines; Name)
                {
                }
                column(LoanNo_CheckoffLines; "Loan No.")
                {
                }
                column(CreditAccount_CheckoffLines; "Credit Account")
                {
                }
                column(Posted_CheckoffLines; Posted)
                {
                }
                column(SavingsAccount_CheckoffLines; "Savings Account")
                {
                }
                column(EmployerCode_CheckoffLines; "Employer Code")
                {
                }
                column(Multiple_CheckoffLines; Multiple)
                {
                }
            }
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }
    }
    var
        CompInfo: Record "Company Information";

}
