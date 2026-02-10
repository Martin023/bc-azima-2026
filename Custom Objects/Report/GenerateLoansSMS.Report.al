report 52187321 "Generate Loans"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {

        dataitem("SMS Alerts Header"; "SMS Alerts Header")
        {
            trigger OnPreDataItem()
            begin

            end;

        }
        dataitem(Loans; Loans)
        {
            CalcFields = "Total Balance";
            RequestFilterFields = "Loan No.", "Loan Product Type", "Amount In Arreas SACCO", "Employer Code", "Days In Arrears", "Source Unit", "Member No.", "Installments FallOff", "Mobile Loan";
            DataItemTableView = where("Total Balance" = filter(> 0));
            column(Loan_No_; "Loan No.")
            {
            }
            column(SMS; SMSMessage)
            {
            }
            column(SMS_Sent; "SMS Sent")
            {
            }
            column(Sent_At; Sent_At)
            {
            }

            trigger OnAfterGetRecord()
            var
                LoanProcess: Codeunit "Loans Process";
                RunLoan: Boolean;
                DaysInArreas: Decimal;
                FallOff: Decimal;
                InsertLoan: Boolean;
            begin
                InsertLoan := true;
                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                //if not "SMS Alerts Header".CheckIfLoanISPresentAndInsert(Loans."Loan No.", "SMS Alerts Header"."No.") then begin

                Loans.CalcFields("Days In Arrears", "Installments FallOff", "Loans Category-SASRA");

                DaysInArreas := Round(Loans."Days In Arrears", 1);
                FallOff := Round(Loans."Installments FallOff", 1);

                //Should not insert loans in other headers
                // ThiPeriodAlertLoanLines.Reset();
                // ThiPeriodAlertLoanLines.SetRange("Loan No.", Loans."Loan No.");
                // ThiPeriodAlertLoanLines.SetRange(Period, "SMS Alerts Header".Period);
                // ThiPeriodAlertLoanLines.SetRange("Header No.", '<>%1', "SMS Alerts Header"."No.");
                // if ThiPeriodAlertLoanLines.Find('-') then begin
                //     if ThisPeriodHeaders.Get(ThiPeriodAlertLoanLines."Header No.") then begin
                //         if (ThisPeriodHeaders.Posted) and (ThiPeriodAlertLoanLines."Process Case") then
                //             InsertLoan := false;

                //         if not ThisPeriodHeaders.posted then
                //             if (ThisPeriodHeaders.Status <> ThisPeriodHeaders.Status::Rejected) then
                //                 InsertLoan := false;
                //     end;
                // end;


                if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"1st & 2nd Notice" then begin
                    // if FallOff > 0 then begin
                    //     if InsertLoan then
                    InsertLoanLines(Loans, "SMS Alerts Header");
                    // end;
                end;

                if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"CRB Notice" then begin
                    // DaysInArreas := LoanProcess.CalculateDaysInArrears(Loans, Today, RunLoan);
                    // if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
                    InsertLoanLines(Loans, "SMS Alerts Header");
                    // end;
                end;
                if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"CRB Listing" then begin
                    // DaysInArreas := LoanProcess.CalculateDaysInArrears(Loans, Today, RunLoan);
                    // if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
                    InsertLoanLines(Loans, "SMS Alerts Header");
                    // end;
                end;
                if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"Arrears Alert" then begin
                    // DaysInArreas := LoanProcess.CalculateDaysInArrears(Loans, Today, RunLoan);
                    // if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
                    InsertLoanLines(Loans, "SMS Alerts Header");
                    // end;
                end;
                //end;
            end;

            trigger OnPreDataItem()
            begin
                SkippedLoanNumbers.Reset();
                SkippedLoanNumbers.SetRange("Header No.", "SMS Alerts Header"."No.");
                if SkippedLoanNumbers.Find('-') then
                    SkippedLoanNumbers.DeleteAll();

                // if "SMS Alerts Header"."Employer Code" <> '' then
                //     Loans.SetFilter("Employer Code", "SMS Alerts Header"."Employer Code");
                SMS_Alerts_Lines.Reset();
                SMS_Alerts_Lines.SetRange("Header No", "SMS Alerts Header"."No.");
                SMS_Alerts_Lines.DeleteAll();

                AlertLoanLines.Reset();
                AlertLoanLines.SetRange("Header No.", "SMS Alerts Header"."No.");
                AlertLoanLines.DeleteAll();

                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                diaProgress.Close();
            end;

        }

    }

    procedure InsertLoanLines(Loans: Record Loans; AlertsHeader: Record "SMS Alerts Header")
    begin
        AlertLoanLines.Init();
        AlertLoanLines."Header No." := AlertsHeader."No.";
        AlertLoanLines."Loan No." := Loans."Loan No.";
        AlertLoanLines.Period := AlertsHeader.Period;
        AlertLoanLines.Validate("Loan No.");
        AlertLoanLines."System Generated" := true;
        AlertLoanLines.Insert(true);
    end;

    Procedure SetDataItem(AlertsHeader: Record "SMS Alerts Header")
    begin

    end;


    var
        myInt: Integer;
        SMSMessage: Text[100];
        Sent_At: DateTime;
        DefaultSMS: label 'Dear %1, We have notified your guarantor of your %2-%3 Current status and our intention to attach. Should we not hear from you within a period of 30 days, then our assumption shall be that you have conceded to the attachment of the loan to guarantors without any further reference to you. For more info call 0710600999. Kenpipe SACCO.';
        SMS_Alerts_Lines: Record "SMS Alerts Lines";
        DefaultFrom: Integer;
        DefaultTo: Integer;
        AlertLoanLines: Record "Alerts Loan Lines";
        ThiPeriodAlertLoanLines: Record "Alerts Loan Lines";
        ThisPeriodHeaders: Record "SMS Alerts Header";
        SkippedLoanNumbers: Record "Skipped Loans";


        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Generating Loan Lines';
        diaProgress: Dialog;
        intProgress: Integer;
}