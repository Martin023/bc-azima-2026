#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185938 "Update Blank Loanee Name"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(LoanGuar; "Loan Guarantors and Security")
        {
            // DataItemTableView = where("Outstanding Balance" = filter(> 0), "Loanee Name" = filter(""), Name = filter(<> ""), "Amount Guaranteed" = filter(0));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Reset;
                Loans.SetRange("Loan No.", LoanGuar."Loan No");
                Loans.SetRange(Posted, true);
                if Loans.Find('-') then begin
                    LoanGuar."Loanee Name" := Loans."Member Name";
                    LoanGuar.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Successfully updated');
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
        Loans: Record Loans;
}
