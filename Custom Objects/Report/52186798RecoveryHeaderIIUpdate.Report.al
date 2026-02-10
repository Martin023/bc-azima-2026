#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186798 "Recovery Header II Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Rec Header Update.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Loan Recovery Header II"; "Loan Recovery Header II")
        {
            // RequestFilterFields = "Global Dimension 1 Code", "Code", "Electoral Zone";
            column(No_; "No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                OriginalLoan: Record Loans;
            begin
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                OriginalLoan.Reset();
                OriginalLoan.SetRange("Loan No.", "Loan Recovery Header II"."Loan No.");
                if OriginalLoan.FindFirst() then begin
                    OriginalLoan."Recovery Level" := OriginalLoan."Recovery Level"::"Level 1";
                    OriginalLoan.Defaulted := true;
                    OriginalLoan."Loan Recovery No." := "Loan Recovery Header II"."No.";
                    if OriginalLoan."Source Unit" <> OriginalLoan."Source Unit"::FOSA then begin
                        "Loan Recovery Header II"."Account to Use" := '1';
                        "Loan Recovery Header II".Modify();
                    end;
                    OriginalLoan.Modify();
                end;

                RecoveryHeaderII := "Loan Recovery Header II";
                RecoveryLinesII.Reset();
                RecoveryLinesII.SetRange("Header No.", RecoveryHeaderII."No.");
                RecoveryLinesII.SetRange("Recovery Type", RecoveryLinesII."Recovery Type"::"Guarantor Attachment");
                if RecoveryLinesII.Find('-') then begin
                    if NewLoans.Get(RecoveryLinesII."Loan No.") then begin
                        NewLoans."Loan Recovery No." := RecoveryHeaderII."No.";
                        NewLoans."Recovered Loan" := RecoveryHeaderII."Loan No.";
                        NewLoans.Modify();
                    end;
                end;

                RecoveryLinesII.Reset();
                RecoveryLinesII.SetRange("Header No.", "Loan Recovery Header II"."No.");
                if RecoveryLinesII.Find('-') then begin
                    repeat
                        OutBal := 0;
                        OutInt := 0;
                        TotalBal := 0;

                        // RecoveryLinesII."Original Attached Amount" := RecoveryLinesII."Opening Principle Balance";
                        if Loans.Get(RecoveryLinesII."Loan No.") then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            OutBal := Loans."Approved Amount";
                            OutInt := Loans."Outstanding Interest";
                            if Loans."Outstanding Interest" < 0 then OutInt := 0;

                            TotalBal := OutBal + OutInt;

                        end;
                        RecoveryLinesII."Opening Principle Balance" := TotalBal;
                        RecoveryLinesII.Modify();
                    until RecoveryLinesII.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
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
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {

            }
        }

        actions
        {
        }
    }

    labels
    {
    }


    var
        RecoveryHeaderII: Record "Loan Recovery Header II";
        NewLoans: Record Loans;
        RecoveryLinesII: Record "Loan Recovery Lines II";
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        oUTbAL: Decimal;
        OUTINT: Decimal;
        TotalBal: Decimal;

        //Progress Variables
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;


}
