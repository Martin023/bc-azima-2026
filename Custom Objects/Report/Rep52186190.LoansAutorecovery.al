namespace MNSProjectMwanga.MNSProjectMwanga;

report 52186190 "Loans Autorecovery"
{
    ApplicationArea = All;
    Caption = 'Loans Autorecovery';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Source Unit", "Loan Product Type";
            DataItemTableView = where(posted = filter(true), "Total Balance" = filter(> 0));
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SkyMbanking: Codeunit "Sky M-Banking Transactions";
            begin
                SkyMbanking.LoanAutoRecovery(loans);
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
}
