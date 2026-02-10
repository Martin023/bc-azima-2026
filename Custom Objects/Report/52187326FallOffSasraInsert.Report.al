report 52187326 "FallOff SASRA and Insert"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("DMU Case Forwarding"; "DMU Case Forwarding")
        {
            RequestFilterFields = "Employer Code";
        }

        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Application Date", "Disbursement Date", "Source Unit", "Member No.";
            DataItemTableView = where(Posted = const(true));
            trigger OnAfterGetRecord()
            var

            begin
                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                Loans.CalcFields("Installments FallOff");
                FallOff := Loans."Installments FallOff";

                if FallOff > 0 then begin
                    LoanNumbers.Add(Loans."Loan No.");
                end;
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
                i: Integer;
                Members: Record Members;
            begin
                diaProgress.CLOSE;

                //Hanle the insert here
                DMUCFLines.Reset();
                DMUCFLines.SetRange("Header No.", "DMU Case Forwarding"."No.");
                if DMUCFLines.Find('-') then DMUCFLines.DeleteAll();

                intProgressTotal := LoanNumbers.Count;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN('Inserting Lines ... ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

                for i := 1 to LoanNumbers.Count do begin
                    intProgressI += 1;
                    if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                        NoOfProgressed := NoOfProgressed + intProgressI;
                        diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                        intProgressI := 0;
                        TimeProgress := TIME;
                    end;

                    if LoansTable.Get(LoanNumbers.Get(i)) then begin
                        Clear(DMUCFLines);
                        Members.Get(LoansTable."Member No.");
                        if Members.Status <> Members.Status::Deceased then begin
                            DMUCFLines.Init();
                            DMUCFLines."Header No." := "DMU Case Forwarding"."No.";
                            DMUCFLines."Loan Number" := LoansTable."Loan No.";
                            DMUCFLines.Validate("Loan Number");
                            DMUCFLines."System Generated" := true;
                            DMUCFLines.Period := "DMU Case Forwarding".Period;
                            DMUCFLines.Insert(true);
                            Clear(DMUCFLines);
                        end;
                    end;
                end;
                diaProgress.CLOSE;
            end;

        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                // field(AsAt; AsAt)
                // {

                // }
                field(ProcessFallOff; ProcessFallOff)
                {
                    Caption = 'Process FallOff';
                }
                // field(RunCategorisation; RunCategorisation)
                // {
                //     Caption = 'Run SASRA Categorization';
                // }
                // field(LoadLoanLines; LoadLoanLines)
                // {
                //     Caption = 'Load CF Lines';
                // }

            }
        }
    }

    trigger OnInitReport()
    var
    begin
        AsAt := Today;
        ProcessFallOff := true;
        LoadLoanLines := true;
    end;


    var
        LoanProcess: Codeunit "Loans Process";
        SASRACategory: Record "SASRA Categorization";
        DMUCFLines: Record "DMU Case Forwarding Lines";
        LoansTable: Record Loans;
        LoanNumbers: list of [Code[50]];
        RunLoan: Boolean;
        DaysInArreas: Decimal;
        FallOff: Integer;
        AsAt: Date;
        Period: Date;

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Sorting ...';
        diaProgress: Dialog;
        intProgress: Integer;
        RunCategorisation: Boolean;
        ProcessFallOff: Boolean;
        LoadLoanLines: Boolean;
        AmountInArrearsSACCO: Decimal;
        AmountInArrearsSASRA: Decimal;
        BulkProcessing: Codeunit "Bulk Processing";
}