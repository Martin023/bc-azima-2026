namespace MNSProjectMwanga.MNSProjectMwanga;

report 52186133 "Generate Daily Interest (NEW)"
{
    ApplicationArea = All;
    Caption = 'Generate Daily Interest (NEW)';
    //UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), Interest = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Source Unit", "Loan Product Type";
            trigger OnAfterGetRecord()
            var
                Loanprocess: Codeunit "Loans Process";
            begin
                //Loanprocess.ComputeDaillyLoanInterestNew(Loans."Loan No.", PostingDate);
                Loanprocess.ComputeDaillyLoanInterestSVCs((PostingDate));
            end;
        }

    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
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

    trigger OnPreReport()
    var
        myInt: Integer;
    begin

        if PostingDate = 0D Then PostingDate := today;

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

    end;



    var
        PostingDate: Date;
}
