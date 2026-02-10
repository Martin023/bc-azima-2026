report 52186520 "Mobile Loans Repayment Update"
{
    ApplicationArea = All;
    Caption = 'Mobile Loans Repayment Update';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Mobile Loan" = const(true), Repayment = const(0));
            column(LoanNo; "Loan No.")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(MobileLoan; "Mobile Loan")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Validate("Approved Amount");
                Loans.Modify;

                Commit;
            end;
        }
    }

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Mobile loans have been updated successfully');
    end;
}
