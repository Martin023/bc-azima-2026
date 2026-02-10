report 52187009 "Dailly Billing Process"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'GeneratecDaily Interest Entries';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Dailly Billing Process.rdl';
    dataset
    {

        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), Interest = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Source Unit", "Loan Product Type";//
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(ApplicationDate; Loans."Application Date")
            {
            }
            column(LoanProductType; Loans."Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            var
                Loanprocess: Codeunit "Loans Process";
            begin
                // intProgressI += 1;
                // if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                //     NoOfProgressed := NoOfProgressed + intProgressI;
                //     diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                //     intProgressI := 0;
                //     TimeProgress := TIME;
                // end;
                Loanprocess.ComputeDaillyLoanInterest(Loans."Loan No.", PostingDate);
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
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin

        // intProgressTotal := Loans.Count;

        // intProgressI := 0;
        // TimeProgress := TIME;
        // NoOfRecsProgress := intProgressTotal DIV 100;
        // NoOfProgressed := 0;

        // diaProgress.OPEN('Processing ... ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
        if PostingDate = 0D Then PostingDate := today;

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        // diaProgress.Close();

        // Message('Daily bills Generated Successfully');
    end;



    var
        myInt: Integer;

        //Progress Bar
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
        PostingDate: Date;


}