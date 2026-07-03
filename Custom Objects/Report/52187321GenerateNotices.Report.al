// report 52187325 "Generate Loans Lines"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;


//     dataset
//     {

//         dataitem("SMS Alerts Header"; "SMS Alerts Header")
//         {

//             trigger OnPreDataItem()
//             begin

//             end;

//         }
//         dataitem(Loans; Loans)
//         {
//             RequestFilterFields = "Loan No.", "Outstanding Balance", "Disbursement Date", "Employer Code";
//             DataItemTableView = where(Posted = const(true));
//             column(Loan_No_; "Loan No.")
//             {
//             }
//             column(SMS; SMSMessage)
//             {
//             }
//             column(SMS_Sent; "SMS Sent")
//             {
//             }
//             column(Sent_At; Sent_At)
//             {
//             }

//             trigger OnAfterGetRecord()
//             var
//                 LoanProcess: Codeunit "Loans Process";
//                 RunLoan: Boolean;
//                 DaysInArreas: Integer;
//                 FallOff: Integer;
//             begin
//                 intProgressI += 1;

//                 IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
//                     NoOfProgressed := NoOfProgressed + intProgressI;
//                     diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
//                     intProgressI := 0;
//                     TimeProgress := TIME;
//                 END;

//                 Loans.CalcFields("Days In Arrears", "Installments FallOff", "Loans Category-SASRA");

//                 DaysInArreas := Loans."Days In Arrears";
//                 FallOff := Loans."Installments FallOff";

//                 if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"1st & 2nd Notice" then begin
//                     if FallOff > 0 then begin
//                         InsertLoanLines(Loans, "SMS Alerts Header");
//                     end;
//                 end;

//                 if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"CRB Notice" then begin
//                     DaysInArreas := LoanProcess.CalculateLoanArrears(Loans, Loans."Amount In Arreas SACCO", "Amount In Arreas SASRA", Today, true);
//                     if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
//                         InsertLoanLines(Loans, "SMS Alerts Header");
//                     end;
//                 end;
//                 if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"CRB Listing" then begin
//                     DaysInArreas := LoanProcess.CalculateLoanArrears(Loans, Loans."Amount In Arreas SACCO", "Amount In Arreas SASRA", Today, true);
//                     if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
//                         InsertLoanLines(Loans, "SMS Alerts Header");
//                     end;
//                 end;
//                 if "SMS Alerts Header"."Notice Type" = "SMS Alerts Header"."Notice Type"::"Arrears Alert" then begin
//                     DaysInArreas := LoanProcess.CalculateLoanArrears(Loans, Loans."Amount In Arreas SACCO", "Amount In Arreas SASRA", Today, true);

//                     if (DaysInArreas >= "SMS Alerts Header"."Days From") and (DaysInArreas <= "SMS Alerts Header"."Days From") then begin
//                         InsertLoanLines(Loans, "SMS Alerts Header");
//                     end;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if "SMS Alerts Header"."Employer Code" <> '' then
//                     Loans.SetFilter("Employer Code", "SMS Alerts Header"."Employer Code");
//                 SMS_Alerts_Lines.Reset();
//                 SMS_Alerts_Lines.SetRange("Header No", "SMS Alerts Header"."No.");
//                 SMS_Alerts_Lines.DeleteAll();

//                 AlertLoanLines.Reset();
//                 AlertLoanLines.SetRange("Header No.", "SMS Alerts Header"."No.");
//                 AlertLoanLines.DeleteAll();

//                 intProgressTotal := COUNT;

//                 intProgressI := 0;
//                 TimeProgress := TIME;
//                 NoOfRecsProgress := intProgressTotal DIV 100;
//                 NoOfProgressed := 0;

//                 diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
//             end;

//             trigger OnPostDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 diaProgress.Close();
//             end;

//         }

//     }

//     procedure InsertLoanLines(Loans: Record Loans; AlertsHeader: Record "SMS Alerts Header")
//     begin
//         AlertLoanLines.Init();
//         AlertLoanLines."Header No." := AlertsHeader."No.";
//         AlertLoanLines."Loan No." := Loans."Loan No.";
//         AlertLoanLines.Period := "SMS Alerts Header".Period;
//         AlertLoanLines.Validate("Loan No.");
//         AlertLoanLines."Process Case" := true;
//         AlertLoanLines.Insert(true);
//     end;


//     var
//         myInt: Integer;
//         SMSMessage: Text[100];
//         Sent_At: DateTime;
//         DefaultSMS: label 'Dear %1, We have notified your guarantor of your %2-%3 Current status and our intention to attach. Should we not hear from you within a period of 30 days, then our assumption shall be that you have conceded to the attachment of the loan to guarantors without any further reference to you. For more info call 0710600999. Kenpipe SACCO.';
//         SMS_Alerts_Lines: Record "SMS Alerts Lines";
//         DefaultFrom: Integer;
//         DefaultTo: Integer;
//         AlertLoanLines: Record "Alerts Loan Lines";

//         intProgressTotal: Integer;
//         intProgressI: Integer;
//         TimeProgress: TIME;
//         NoOfRecsProgress: Decimal;
//         NoOfProgressed: Integer;
//         Generating: Label 'Generating Loan Lines';
//         diaProgress: Dialog;
//         intProgress: Integer;
// }