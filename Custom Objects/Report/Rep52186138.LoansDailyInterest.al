namespace MNSProjectMwanga.MNSProjectMwanga;

report 52186138 "Loans Daily Interest"
{
    ApplicationArea = All;
    Caption = 'Manual Daily Interest Generation';
    //UsageCategory = Tasks;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loans Daily Interest.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), Interest = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Source Unit", "Loan Product Type";
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            trigger OnAfterGetRecord()
            var
                Loanprocess: Codeunit "Loans Process";
            begin
                Loanprocess.ComputeDaillyLoanInterests(Loans."Loan No.", PostingDate);
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
