#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185659 "SASRA Loan Categorization"
{
    ProcessingOnly = true;
    UsageCategory = Administration;

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Balance", "Outstanding Interest";
            DataItemTableView = sorting("Loan No.") where("Dummy Appraisal" = filter(false), "Loan Product Type" = filter(<> ''));
            RequestFilterFields = "Loan No.", "Employer Code", "Date Filter", "Staff No", "Member No.", "Application Date";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                LoansProcess: Codeunit "Loans Process";
            begin

                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                DaysInArrears := LoansProcess.CalculateLoanArrears(Loans, AmountInArrearsSACCO, AmountInArrearsSASRA, AsAt, True);

                Counter := Counter + 1;

                // if Loans."Moratorium Loan" = true then begin
                //     Loans."Moratorium Loan" := false;
                // end;
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            var
            begin

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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UserSetup.Get(UserId);
        if UserSetup."Run Sasra Report" = false then
            Error(Text001);
        if AsAt = 0D then AsAt := today;
    end;


    var
        SaccoAcc: Record "Credit Accounts";
        AvailableBal: Decimal;
        SavAcc: Code[20];
        LineNo: Integer;
        RunLoan: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        DActivity: Code[10];
        PostingDate: Date;
        MoratoriumDate: Date;
        ProdF: Record "Account Closure Line";
        GenSetup: Record "Credit Nos. Series";
        MoratoriumLoan: Record "Moratorium Loan";
        BillAmount: Decimal;
        InterestAmount: Decimal;
        CountMonths: Decimal;
        ProgressWindow: Dialog;
        LoanRec: Record Loans;
        Counter: Integer;
        SASRACategory: Record "SASRA Categorization";
        NoDays: Integer;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        UserSetup: Record "User Setup";
        Text001: label 'You do not have permission to run this report kindly contact Credit Section staff on the said loan';
        ProductFactory: Record "Product Factory";
        AddOnRepayments: Integer;
        AsAt: Date;
        AmtPaid: Decimal;
        AmountInArrearsSACCO: Decimal;
        AmountInArrearsSASRA: Decimal;


        ArrearsDate: Date;
        DaysInArrears: Decimal;
        Schedule: Record "Ideal Repayment Schedule";
        SchAmt: Decimal;
        LoanAge: Integer;

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Categorising Loans';
        diaProgress: Dialog;
        intProgress: Integer;
}
