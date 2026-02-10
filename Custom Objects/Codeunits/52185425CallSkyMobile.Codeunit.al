// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185425 "Call Sky Mobile"
// {

//     trigger OnRun()
//     begin

//         RecoverMboosta;
//         Commit;
//         UpdateSalaryLoanAppraisal;
//     end;

//     var
//         SkyMbanking: Codeunit "Sky Mbanking";


//     procedure RecoverMboosta()
//     begin
//         SkyMbanking.MboostaRecovery;
//     end;


//     procedure UpdateSalaryLoanAppraisal()
//     var
//         Member: Record Members;
//         Vendor: Record Vendor;
//         SavingsAccounts: Record "Savings Accounts";
//         Loans: Record Loans;
//         MBoosta: Decimal;
//         SalaryInAdvance: Decimal;
//         FinjeChapChap: Decimal;
//         JisortAdvance: Decimal;
//         SalaryAdvance: Decimal;
//         ProductFactory: Record "Product Factory";
//         SkyMbanking: Codeunit "Sky Mbanking";
//         MBoostaMsg: Text;
//         SalaryInAdvanceMsg: Text;
//         FinjeChapChapMsg: Text;
//         JisortAdvanceMsg: Text;
//         SalaryAdvanceMsg: Text;
//         Appraisal: Record "Sky Mobile Loan Appraisal";
//         dWindow: Dialog;
//         LastName: Text;
//         TotalLines: Integer;
//         Success: Boolean;
//         Msg: Text;
//         LoanLimit: Decimal;
//         QualifiedAmt: Decimal;
//         TopUp: Decimal;
//         k: Integer;
//         Salary: array[3] of Decimal;
//         SalDates: array[3] of Date;
//     begin


//         dWindow.Open('Generating Entries:       #1#############');
//         SavingsAccounts.Reset;
//         SavingsAccounts.SetFilter("Transactional Mobile No", '<>%1', '');
//         if SavingsAccounts.FindFirst then begin
//             TotalLines := SavingsAccounts.Count;
//             //\ERROR('%1',TotalLines);
//             repeat

//                 TotalLines -= 1;

//                 SavingsAccounts.CalcFields("Balance (LCY)");
//                 if Appraisal.Get(SavingsAccounts."No.") then begin
//                     Appraisal."User ID" := UserId;
//                     Appraisal."Account No." := SavingsAccounts."No.";
//                     Appraisal.Name := SavingsAccounts.Name;
//                     Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
//                     Appraisal.Email := SavingsAccounts."E-Mail";
//                     Appraisal."Member No." := SavingsAccounts."Member No.";
//                     Appraisal."ID No." := SavingsAccounts."ID No.";
//                     Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
//                     Appraisal."As At" := Today;
//                     Appraisal."Date-Time" := CurrentDatetime;

//                     MBoosta := 0;
//                     ProductFactory.Get('126');
//                     SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
//                     MBoosta := QualifiedAmt;
//                     MBoostaMsg := Msg;



//                     for k := 3 downto 1 do begin
//                         Salary[k] := 0;
//                         SalDates[k] := 0D;
//                     end;

//                     SalaryInAdvance := 0;
//                     ProductFactory.Get('123');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     SalaryInAdvance := QualifiedAmt;
//                     SalaryInAdvanceMsg := Msg;

//                     FinjeChapChap := 0;
//                     ProductFactory.Get('120');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     FinjeChapChap := QualifiedAmt;
//                     FinjeChapChapMsg := Msg;


//                     JisortAdvance := 0;
//                     ProductFactory.Get('121');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     JisortAdvance := QualifiedAmt;
//                     JisortAdvanceMsg := Msg;


//                     SalaryAdvance := 0;
//                     ProductFactory.Get('119');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     SalaryAdvance := QualifiedAmt;
//                     SalaryAdvanceMsg := Msg;



//                     Appraisal.MBoosta := MBoosta;
//                     Appraisal."MBoosta Msg" := MBoostaMsg;
//                     Appraisal."Salary In Advance" := SalaryInAdvance;
//                     Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
//                     Appraisal."Finje Chap Chap" := FinjeChapChap;
//                     Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
//                     Appraisal."Jisort Advance" := JisortAdvance;
//                     Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
//                     Appraisal."Salary Advance" := SalaryAdvance;
//                     Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

//                     Appraisal."Salary 1" := Salary[1];
//                     Appraisal."Salary Date 1" := SalDates[1];
//                     Appraisal."Salary 2" := Salary[2];
//                     Appraisal."Salary Date 2" := SalDates[2];
//                     Appraisal."Salary 3" := Salary[3];
//                     Appraisal."Salary Date 3" := SalDates[3];


//                     Appraisal.Modify;
//                     Commit;
//                 end
//                 else begin

//                     Appraisal.Init;
//                     Appraisal."User ID" := UserId;
//                     Appraisal."Account No." := SavingsAccounts."No.";
//                     Appraisal.Name := SavingsAccounts.Name;
//                     Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
//                     Appraisal.Email := SavingsAccounts."E-Mail";
//                     Appraisal."Member No." := SavingsAccounts."Member No.";
//                     Appraisal."ID No." := SavingsAccounts."ID No.";
//                     Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
//                     Appraisal."As At" := Today;
//                     Appraisal."Date-Time" := CurrentDatetime;

//                     MBoosta := 0;
//                     ProductFactory.Get('126');
//                     SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
//                     MBoosta := QualifiedAmt;
//                     MBoostaMsg := Msg;



//                     SalaryInAdvance := 0;
//                     ProductFactory.Get('123');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     SalaryInAdvance := QualifiedAmt;
//                     SalaryInAdvanceMsg := Msg;

//                     FinjeChapChap := 0;
//                     ProductFactory.Get('120');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     FinjeChapChap := QualifiedAmt;
//                     FinjeChapChapMsg := Msg;


//                     JisortAdvance := 0;
//                     ProductFactory.Get('121');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     JisortAdvance := QualifiedAmt;
//                     JisortAdvanceMsg := Msg;


//                     SalaryAdvance := 0;
//                     ProductFactory.Get('119');
//                     SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
//                     SalaryAdvance := QualifiedAmt;
//                     SalaryAdvanceMsg := Msg;



//                     Appraisal.MBoosta := MBoosta;
//                     Appraisal."MBoosta Msg" := MBoostaMsg;
//                     Appraisal."Salary In Advance" := SalaryInAdvance;
//                     Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
//                     Appraisal."Finje Chap Chap" := FinjeChapChap;
//                     Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
//                     Appraisal."Jisort Advance" := JisortAdvance;
//                     Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
//                     Appraisal."Salary Advance" := SalaryAdvance;
//                     Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

//                     Appraisal."Salary 1" := Salary[1];
//                     Appraisal."Salary Date 1" := SalDates[1];
//                     Appraisal."Salary 2" := Salary[2];
//                     Appraisal."Salary Date 2" := SalDates[2];
//                     Appraisal."Salary 3" := Salary[3];
//                     Appraisal."Salary Date 3" := SalDates[3];


//                     Appraisal.Insert;
//                     Commit;
//                 end;
//                 dWindow.Update(1, TotalLines);

//             until SavingsAccounts.Next = 0;

//         end;

//         dWindow.Close;
//     end;
// }
