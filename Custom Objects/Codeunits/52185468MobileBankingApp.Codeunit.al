// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185468 MobileBankingApp
// {

//     trigger OnRun()
//     begin
//         //Msisdn := '254727865864';
//         //MESSAGE(GetmemberInfo(Msisdn));
//         Message(GetLoanTypes);
//         //MESSAGE(BalanceEnquiry(Msisdn));
//         //L01-00001
//         //MESSAGE(AccountBalance('5050174717000'));
//         // MESSAGE(EffectCharge(Msisdn,'10920171213234'));
//         //MESSAGE(Ministatement('254718023964'));
//         //MESSAGE(PaybillKeywords(Msisdn));
//         //MESSAGE(GetSavingProducts);
//         //MESSAGE(GetNextofKin('2547224706'));
//         //CreateSavingsAccount('0148031','511','Mtoto Mwema','',0,0,'123',TODAY);
//     end;

//     var
//         Msisdn: Text[50];
//         No: Text[30];
//         Loans: Record Loans;
//         LoanBalance: Decimal;
//         Member: Record "Savings Accounts";
//         GenJournalLine: Record "Gen. Journal Line";
//         GenBatches: Record "Gen. Journal Batch";
//         GenLedgerSetup: Record "General Set-Up";
//         LineNo: Integer;
//         MPesaAccount: Code[50];
//         MPesaCharges: Decimal;
//         MPesaChargesAccount: Code[50];
//         MPESAPaybill: Code[50];
//         TotalCharges: Decimal;
//         TariffCharges: Decimal;
//         AmountToCharge: Decimal;
//         //GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         Transtype: Text[30];
//         description: Text[30];
//         transdate: Date;
//         account: Text[30];
//         Amount: Integer;
//         Accounttypes: Record "Product Factory";
//         MiniBalance: Decimal;
//         i: Integer;
//         plus: Text[30];
//         // smses: Record "M-SACCO SMS Messages";
//         RunBal: Decimal;
//         AccBalance: Decimal;
//         source: Code[10];
//         Lastenquiry: Integer;
//         Venderdetails: Record "Savings Ledger Entry";
//         minicount: Integer;
//         Docno: Code[20];
//         Msaccocharge: Decimal;
//         Msaccoacc: Code[20];
//         MsaccoTransactions: Record "M-SACCO Transactions";
//         Exceciseduty: Decimal;
//         Interest: Decimal;
//         LoanType: Record "Loan Charges";
//         TRAmount: Decimal;
//         loanno: Code[20];
//         MPESATRANS1: Record "M-PESA Transactions";
//         MPESATRANS: Record "M-PESA Transactions";
//         DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         DashboardDataFilter: Date;
//         DateExpression: Text[20];
//         loanProductType: Record "Product Factory";
//         ProdFac: Record "Product Factory";
//         NoOfEntries: Integer;
//         TotSalarieies: Decimal;
//         AverageSal: Decimal;
//         QualifyingbeforeDed: Decimal;
//         TotLoanDed: Decimal;
//         OutsInt: Decimal;
//         GenSetUp: Record "Credit Nos. Series";
//         TotSTOs: Decimal;
//         QualifyingAfterDed: Decimal;
//         AccType: Integer;
//         SharesAccount1: Text;
//         SharesAccount2: Text;
//         SharesAccount6: Text;
//         S01Bal: Decimal;
//         S02Bal: Decimal;
//         S06Bal: Decimal;
//         SharesAmount: Text;
//         DepositsAmount: Text;
//         S03Bal: Decimal;
//         SharesAccount3: Text;
//         Charges: Record "Transaction Charges";
//         MsaccoChargesSetup: Record "M-SACCO Account Setup";
//         POSTJOURNAL: Codeunit "Journal Posting";
//         OptionsAccounts: Enum "Gen. Journal Account Type";
//         saccoAccount: Record "Savings Accounts";
//         OptionTransactionTypes: enum "Transaction Types";
//         OptionSMS: Option "Membership Approval","Savings Approval","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Guarantors","Loan Posted","Loan defaulted","Salary Posted","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO;
//         ExciseDutyGL: Text[30];
//         saccoAccount1: Record "Savings Accounts";


//     procedure GetmemberInfo("Phone No": Text[50]) memberInfo: Text[500]
//     begin


//         "Phone No" := '+' + "Phone No";
//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");
//         if Member.Find('-') then begin
//             memberInfo := 'Member No :::' + Member."No." + '#' + 'Name :::' + Member.Name + '#' + 'ID No :::' + Format(Member."ID No.") + '#' + 'Gender :::' + Format(Member.Gender) + '#' +
//             'DoB :::' + Format(Member."Date of Birth") + '#' + 'Email :::' + Member."E-Mail" + '#' + 'Reg. Date :::' + Format(Member."Registration Date");

//         end;
//     end;


//     procedure AccountBalance(SelectedAcc: Text[30]) AccountBal: Text[30]
//     begin

//         Member.Reset;
//         Member.SetRange(Member."No.", SelectedAcc);
//         if Member.Find('-') then begin

//             Accounttypes.Reset;
//             Accounttypes.SetRange(Accounttypes."Product ID", Member."Product Type");
//             if Accounttypes.Find('-') then begin
//                 MiniBalance := Accounttypes."Minimum Balance";
//             end;

//             Member.CalcFields(Member."Balance (LCY)");
//             Member.CalcFields(Member."ATM Transactions");
//             Member.CalcFields(Member."Uncleared Cheques");

//             AccountBal := Format(Member."Balance (LCY)" - (Member."ATM Transactions" + Member."Uncleared Cheques" + MiniBalance));

//         end
//     end;


//     procedure Ministatement("Phone No": Text[50]) statement: Text[500]
//     begin

//         "Phone No" := '+' + "Phone No";

//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");

//         if Member.Find('-') then begin
//             minicount := 1;

//             Venderdetails.SetCurrentkey(Venderdetails."Entry No.");
//             Venderdetails.Ascending(false);
//             Venderdetails.SetRange(Venderdetails."Customer No.", Member."No.");
//             // Venderdetails.SetRange(Venderdetails.Reversed, Venderdetails.Reversed::"0");

//             if Venderdetails.FindSet then begin
//                 statement := '';
//                 repeat

//                     // Venderdetails.CALCFIELDS(Venderdetails.Amount);
//                     statement := statement + Format(Venderdetails."Posting Date", 0, '<Day>-<Month>-<Year4>') + ':::' + CopyStr(Venderdetails.Description, 1, 25) + ':::' +
//                     Format(Venderdetails.Amount) + '::::';

//                     minicount := minicount + 1;
//                     if minicount > 10 then
//                         exit
//                  until Venderdetails.Next = 0;
//             end;
//         end;
//     end;


//     procedure GetBosaAccount("Phone No": Text[30]) BOSAAccNo: Text[30]
//     begin

//         "Phone No" := '+' + "Phone No";
//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");
//         if Member.Find('-') then begin

//             BOSAAccNo := Member."Member No.";
//         end;
//     end;


//     procedure GetFosaAccount("Phone No": Text[30]) FOSAAccts: Text[100]
//     begin
//         "Phone No" := '+' + "Phone No";

//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");
//         Member.SetRange(Member.Blocked, Member.Blocked::" ");
//         //saccoAccount.SETRANGE(saccoAccount.Status,saccoAccount.Status::Active);
//         Member.SetFilter(Member.Status, '%1|%2', Member.Status::Active, Member.Status::New);
//         FOSAAccts := '';
//         if Member.Find('-') then begin
//             if FOSAAccts = ''
//             then begin
//                 FOSAAccts := Format(Member."No.");
//             end
//             else
//                 repeat
//                     FOSAAccts := FOSAAccts + ':::' + Format(Member."No.");
//                 until Member.Next = 0;

//         end;
//     end;


//     procedure GetDashboardData("Phone No": Text[30]; "Last Entry": Integer) dashboardData: Text[1024]
//     begin
//         "Phone No" := '+' + "Phone No";
//         minicount := 0;
//         DateExpression := '<CD-9M>'; // Current date less 6 months
//         DashboardDataFilter := CalcDate(DateExpression, Today);

//         Member.Reset;
//         Member.SetRange(Member."Phone No.", "Phone No");
//         dashboardData := '';

//         if Member.FindSet then
//             repeat
//                 Venderdetails.SetCurrentkey(Venderdetails."Entry No.");
//                 Venderdetails.Ascending(false);
//                 Venderdetails.SetRange(Venderdetails."Customer No.", Member."No.");
//                 // Venderdetails.SetRange(Venderdetails.Reversed, Venderdetails.Reversed::"0");

//                 if Venderdetails.FindSet then
//                     repeat

//                         dashboardData := dashboardData + '#' +
//                         Format(Venderdetails."Entry No.") + ':::' +
//                         Member."Product Name" + ':::' +
//                         Format(Venderdetails."Posting Date") + ':::' +
//                         Format((Venderdetails."Posting Date"), 0, '<Month Text>') + ':::' +
//                         Format(Date2dmy((Venderdetails."Posting Date"), 3)) + ':::' +
//                         Format((Venderdetails."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
//                         Format((Venderdetails."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
//                         Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
//                         Format(Venderdetails."Journal Batch Name") + ':::' +
//                         'FOSA' + ':::' +
//                         Format(Venderdetails.Description);


//                         minicount := minicount + 1;
//                         if minicount > 7 then
//                             exit

// until Venderdetails.Next = 0;
//             until Member.Next = 0;
//     end;


//     procedure GetLoanTypes() loanTypes: Text[1024]
//     begin
//         loanProductType.Reset;
//         loanProductType.SetRange(loanProductType."Product Class Type", loanProductType."product class type"::Loan);
//         loanProductType.SetRange(Status, loanProductType.Status::Active);
//         loanProductType.SetFilter("Nature of Loan Type", '%1|%2', loanProductType."nature of loan type"::Normal, loanProductType."nature of loan type"::" ");
//         loanProductType.SetRange(loanProductType.AvailableOnMobile, true);
//         if loanProductType.Find('-') then begin
//             minicount := 1;

//             repeat
//                 if (loanProductType."Ordinary Default Intallments" > 1) then begin
//                     loanTypes := loanTypes + ':::' + loanProductType."Product Description" + ':' + Format(ROUND(loanProductType."Interest Rate (Max.)" / 12)) + ':' + loanProductType."Product ID" + ':' + Format(loanProductType.AvailableOnMobile)
//                     + ':' + Format(loanProductType."Interest Calculation Method");
//                 end
//                 else begin
//                     loanTypes := loanTypes + ':::' + loanProductType."Product Description" + ':' + Format(ROUND(loanProductType."Interest Rate (Max.)")) + ':' + loanProductType."Product ID" + ':' + Format(loanProductType.AvailableOnMobile)
//                     + ':' + Format(loanProductType."Interest Calculation Method");
//                 end;
//                 minicount := minicount + 1;
//                 if minicount > 50 then
//                     exit

//             until loanProductType.Next = 0;
//         end;
//         /*
//         loanProductType.RESET;
//         loanProductType.SETRANGE(loanProductType."Product Class Type",loanProductType."Product Class Type"::Loan);
//         IF loanProductType.FIND('-') THEN BEGIN
//         minicount:=1;
        
//           REPEAT
//             loanTypes:=loanTypes +':::'+loanProductType."Product Description";
        
//                minicount:= minicount +1;
//               IF   minicount>20 THEN
//               EXIT
        
//           UNTIL loanProductType.NEXT =0;
//         END
//         */

//     end;


//     procedure GetActiveLoans("Phone No": Text[50]) activeLoans: Text
//     var
//         loancount: Integer;
//     begin

//         "Phone No" := '+' + "Phone No";
//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");

//         if Member.Find('-') then begin

//             Accounttypes.Reset;
//             Accounttypes.SetRange(Accounttypes."Product ID", Member."Product Type");
//             if Accounttypes.Find('-') then begin
//                 MiniBalance := Accounttypes."Minimum Balance";
//             end;

//             Loans.SetRange(Loans."Member No.", Member."Member No.");

//             if Loans.Find('-') then begin
//                 repeat

//                     Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");

//                     if (Loans."Outstanding Balance" > 1) or (Loans."Outstanding Interest" > 1) then
//                         activeLoans := activeLoans + ':::' + Loans."Loan No." + ';' + Loans."Loan Product Type Name" + ';' + Format(Loans."Outstanding Balance" + Loans."Outstanding Interest");

//                 until Loans.Next = 0;
//             end;
//         end;
//     end;


//     procedure GetLoanStatus("Loan No": Text[100]; "Phone No": Text[100]) LoanStatus: Text[500]
//     begin

//         "Phone No" := '+' + "Phone No";

//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", "Phone No");

//         if Member.Find('-') then begin


//             Loans.Reset;
//             Loans.SetRange(Loans."Member No.", Member."Member No.");
//             Loans.SetRange("Loan No.", "Loan No");
//             Loans.SetRange(Loans.Posted, true);
//             if Loans.Find('-') then begin
//                 repeat
//                     Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
//                     if (Loans."Outstanding Balance" > 0) or (Loans."Outstanding Interest" > 0) then begin

//                         LoanStatus := Loans."Loan Product Type Name" + ':::' + Format(Loans.Status) + ':::' + Format(Loans.Source) + ':::' + Format(Loans.Repayment) + ':::' +
//                                  Format(Loans."Outstanding Balance") + ':::' + Format(Loans."Outstanding Interest");

//                     end
//                 until Loans.Next = 0;
//             end;

//         end;
//     end;


//     procedure BalanceEnquiry(Phone: Text[30]) Balance: Text
//     var
//         BalanceAccount: Text;
//     begin

//         Phone := '+' + Phone;

//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", Phone);
//         Member.SetFilter(Member.Status, '=%1|=%2', Member.Status::Active, Member.Status::New);
//         if Member.Find('-') then begin

//             Accounttypes.Reset;
//             Accounttypes.SetRange(Accounttypes."Product ID", Member."Product Type");
//             if Accounttypes.Find('-') then begin
//                 MiniBalance := Accounttypes."Minimum Balance";
//             end;

//             BalanceAccount := AccountBalance(Member."No.");

//             //MESSAGE('product name '+ FORMAT(Member."Product Name"));

//             Balance := Format(Member."Product Type") +
//              ':' + Format(BalanceAccount) + '#';
//             Message('deposits' + GetDeposits(Member."Member No."));
//             SharesAmount := GetShares(Member."Member No.");
//             DepositsAmount := GetDeposits(Member."Member No.");

//             Loans.Reset;
//             Loans.SetRange(Loans."Member No.", Member."Member No.");
//             if Loans.Find('-') then begin
//                 repeat
//                     Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");

//                     if (Loans."Outstanding Balance" > 1) or (Loans."Outstanding Interest" > 1) then
//                         Balance := Balance + Loans."Loan Product Type Name" + ':' + Format(Loans."Outstanding Balance" + Loans."Outstanding Interest") + '#';
//                 until Loans.Next = 0;
//             end;



//             Balance := Balance + 'Shares:' + SharesAmount + '#';
//             Balance := Balance + ' Deposits:' + DepositsAmount;
//             if (SharesAmount <> '0') then begin

//             end;



//             if (DepositsAmount <> '0') then begin

//             end;


//         end;
//     end;


//     procedure loanbalances(Phone: Text[30]) Loansbalances: Text
//     begin

//         Phone := '+' + Phone;

//         Member.Reset;
//         Member.SetRange(Member."Transactional Mobile No", Phone);
//         if Member.Find('-') then begin

//             Loans.SetRange(Loans."Member No.", Member."Member No.");
//             if Loans.Find('-') then begin
//                 repeat
//                     Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
//                     if (Loans."Outstanding Balance" > 0) or (Loans."Outstanding Interest" > 0) then begin
//                         Loansbalances := Loansbalances + '|' + Loans."Loan No." + ';' + Loans."Loan Product Type" + ';' + Format(Loans."Outstanding Balance" + Loans."Outstanding Interest");
//                     end;
//                 until Loans.Next = 0;
//             end;
//         end;
//     end;


//     procedure EffectCharge(StrTelephoneNo: Text; Reference: Text) Result: Text
//     begin

//         StrTelephoneNo := '+' + StrTelephoneNo;
//         saccoAccount.SetRange(saccoAccount."Transactional Mobile No", StrTelephoneNo);
//         saccoAccount.SetRange(saccoAccount."Product Type", '505');
//         if saccoAccount.Find('-') then begin

//             AccBalance := GetAccountBalance(saccoAccount."Member No.");

//             GenJournalLine.Reset;
//             GenJournalLine.SetRange("Journal Template Name", 'MSACCO');
//             GenJournalLine.SetRange("Journal Batch Name", 'MSBAL-OL');
//             GenJournalLine.DeleteAll;

//             Docno := Reference;


//             // Get Excise duty G/L
//             ExciseDutyGL := GetExciseDutyGL();

//             GenLedgerSetup.Reset;
//             GenLedgerSetup.Get;

//             Charges.Reset;
//             Charges.SetRange(Charges."Transaction Type", 'MSACCOBAL');
//             if Charges.Find('-') then begin
//                 Charges.TestField(Charges."G/L Account");
//                 MPesaCharges := Charges."Charge Amount";
//                 MPesaChargesAccount := Charges."G/L Account";
//             end;

//             // Get Coretec Vendor Account and Charge Amount

//             MsaccoChargesSetup.Reset;
//             MsaccoChargesSetup.SetRange(MsaccoChargesSetup."Account Type", 'CORETEC');
//             if MsaccoChargesSetup.Find('-') then begin
//                 MsaccoChargesSetup.TestField(MsaccoChargesSetup."Vendor No");
//                 Msaccocharge := MsaccoChargesSetup.ChargeAmount;
//                 Msaccoacc := MsaccoChargesSetup."Vendor No";
//             end;

//             TotalCharges := MPesaCharges + Msaccocharge;

//             if (AccBalance > TotalCharges) then begin


//                 //start posting

//                 GenJournalLine.Reset;
//                 GenJournalLine.SetRange("Journal Template Name", 'MSACCO');
//                 GenJournalLine.SetRange("Journal Batch Name", 'MSBAL-OL');
//                 GenJournalLine.DeleteAll;

//                 // prevent double posting
//                 Venderdetails.Reset;
//                 Venderdetails.SetRange(Venderdetails."Document No.", Reference);
//                 Venderdetails.SetRange(Venderdetails.Description, 'MSacco Balance Charges');
//                 Venderdetails.SetFilter(Venderdetails.Reversed, '=%1', false);
//                 if Venderdetails.Find('-') then begin
//                     //--
//                 end else begin
//                     //Cr Msacco Charges (Sacco G/L Account)
//                     LineNo := LineNo + 10000;
//                     POSTJOURNAL.PostJournal('MSACCO', 'MSBAL-OL', LineNo, Optionsaccounts::"G/L Account", Docno, 'MSacco Balance Charges', (MPesaCharges - Exceciseduty) * -1
//                     , MPesaChargesAccount, Today, Optionsaccounts::"G/L Account", '', '', saccoAccount."Global Dimension 1 Code", saccoAccount."Global Dimension 2 Code", Optiontransactiontypes::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


//                     //Cr Coretec Vendor with Msacco Charge
//                     LineNo := LineNo + 10000;
//                     POSTJOURNAL.PostJournal('MSACCO', 'MSBAL-OL', LineNo, Optionsaccounts::Vendor, Docno, 'MSacco Balance Charges', Msaccocharge * -1
//                     , Msaccoacc, Today, Optionsaccounts::"G/L Account", '', saccoAccount."No.", saccoAccount."Global Dimension 1 Code", saccoAccount."Global Dimension 2 Code", Optiontransactiontypes::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


//                     //Dr Member Total Charges
//                     LineNo := LineNo + 10000;
//                     POSTJOURNAL.PostJournal('MSACCO', 'MSBAL-OL', LineNo, Optionsaccounts::Savings, Docno, 'MSacco Balance Charges', TotalCharges - Exceciseduty
//                     , saccoAccount."No.", Today, Optionsaccounts::"G/L Account", '', 'MSACCO BAL', saccoAccount."Global Dimension 1 Code", saccoAccount."Global Dimension 2 Code", Optiontransactiontypes::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

//                     //Dr Member Exercise Duty
//                     LineNo := LineNo + 10000;
//                     POSTJOURNAL.PostJournal('MSACCO', 'MSBAL-OL', LineNo, Optionsaccounts::Savings, Docno, 'Exercise Duty', Exceciseduty
//                     , saccoAccount."No.", Today, Optionsaccounts::"G/L Account", '', 'MSACCO BAL', saccoAccount."Global Dimension 1 Code", saccoAccount."Global Dimension 2 Code", Optiontransactiontypes::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
//                     Message('test');
//                     //Cr Exercise Duty
//                     LineNo := LineNo + 10000;
//                     POSTJOURNAL.PostJournal('MSACCO', 'MSBAL-OL', LineNo, Optionsaccounts::"G/L Account", Docno, 'Exercise Duty', Exceciseduty * -1
//                     , ExciseDutyGL, Today, Optionsaccounts::"G/L Account", '', 'MSACCO BAL', saccoAccount."Global Dimension 1 Code", saccoAccount."Global Dimension 2 Code", Optiontransactiontypes::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

//                     //Complete Journal Posting
//                     POSTJOURNAL.CompletePosting('MSACCO', 'MSBAL-OL');

//                 end;
//                 MsaccoTransactions.Reset;
//                 if MsaccoTransactions.Find('+') then begin
//                     i := MsaccoTransactions."Entry No";
//                 end;

//                 i := i + 1;
//                 MsaccoTransactions.Init;
//                 MsaccoTransactions."Entry No" := i;
//                 MsaccoTransactions."Document No." := Reference;
//                 MsaccoTransactions.Description := 'Msacco ministatement Charges';
//                 MsaccoTransactions."Transaction Date" := Today;
//                 MsaccoTransactions."Account No." := Member."No.";
//                 MsaccoTransactions.Amount := Msaccocharge;
//                 MsaccoTransactions.Posted := true;
//                 MsaccoTransactions."Transaction Type" := MsaccoTransactions."transaction type"::Ministatement;
//                 MsaccoTransactions."Transaction Time" := Time;
//                 MsaccoTransactions.Insert;

//                 // end
//                 Result := 'success';
//             end else begin
//                 Result := 'fail';
//             end
//         end;
//     end;


//     procedure GetMaximumLoanAmount(Phone: Text) Amount: Text
//     begin
//         /*
//             Member.RESET;
//             Member.SETRANGE(Member."MPESA Mobile No",Phone);
//             Member.SETFILTER(Member.Status,'<>%1',vendor.Status::Dormant);
//             GenLedgerSetup.GET;

//             IF Member.FIND('-') THEN BEGIN



//             ProdFac.RESET;
//             ProdFac.SETRANGE(ProdFac."Product ID",GenLedgerSetup."Salary Advance Loan Type");

//             IF ProdFac.FIND('-') THEN BEGIN

//                 IF ProdFac."One Month Auto Option"=ProdFac."One Month Auto Option"::Average THEN BEGIN


//               NoOfEntries :=0;
//               SalBuffer.RESET;
//               SalBuffer.SETCURRENTKEY(Date);
//               SalBuffer.ASCENDING(FALSE);
//               SalBuffer.SETRANGE(SalBuffer."Member No.",Member."Member No.");
//               SalBuffer.SETRANGE(SalBuffer.Processed,TRUE);
//               IF SalBuffer.FIND('-') THEN BEGIN
//                 REPEAT
//                   NoOfEntries:=NoOfEntries+1;
//                   TotSalarieies:=TotSalarieies+SalBuffer.Amount;
//                 UNTIL (NoOfEntries=3) OR (SalBuffer.NEXT=0);
//               END;
//               AverageSal:=TotSalarieies/3;
//               QualifyingbeforeDed:=AverageSal;

//              MESSAGE('total salaries are '+ FORMAT(TotSalarieies));
//              MESSAGE('average salary is '+ FORMAT(AverageSal));

//             TotLoanDed:=0;
//             LoanDed.RESET;
//             LoanDed.SETCURRENTKEY(LoanDed."Recovery Priority");
//             LoanDed.SETCURRENTKEY(Source,"Member No.","Loan Product Type","Issued Date");
//             LoanDed.SETRANGE(LoanDed."Member No.",Member."Member No.");
//             LoanDed.SETRANGE(LoanDed."Loan Span",LoanDed."Loan Span"::"Short Term");
//             IF LoanDed.FIND('-') THEN BEGIN
//               REPEAT
//                 OutsInt:=0;
//                 LoanDed.CALCFIELDS(LoanDed."Outstanding Balance");
//                 IF LoanDed."Outstanding Balance">0 THEN BEGIN
//                   OutsInt:=LoanDed."Outstanding Balance"*LoanDed.Interest*0.01*1/12;
//                   IF LoanDed.Repayment > LoanDed."Outstanding Balance" THEN
//                     TotLoanDed:= TotLoanDed+LoanDed.Repayment +OutsInt
//                   ELSE
//                     TotLoanDed:=TotLoanDed+LoanDed.Repayment+OutsInt;
//                 END;
//               UNTIL LoanDed.NEXT = 0;
//             END;

//             GenSetUp.GET;
//             TotSTOs:=GenSetUp."Minimum FOSA Shares Contr";
//             QualifyingAfterDed:=QualifyingbeforeDed-(TotSTOs+TotLoanDed);
//             QualifyingAfterDed:=QualifyingAfterDed *  ProdFac."Percentage of Net Salary"*0.01;
//             Amount:= FORMAT(ROUND(QualifyingAfterDed,1));

//                 MESSAGE('total STOs '+ FORMAT(TotSTOs));
//                 MESSAGE('total loan deductions '+ FORMAT(TotLoanDed));

//                     END;
//                END;
//            END;

//     */

//     end;


//     procedure GetDeposits(MemberNo: Text) deposits: Text
//     begin
//         Member.Reset;
//         Member.SetRange(Member."Member No.", MemberNo);
//         Member.SetRange(Member."Product Category", Member."Product Category"::"BOSA Deposits");

//         if Member.Find('-') then begin
//             Member.CalcFields(Member.Balance);
//             Message(Format(Member.Balance));
//             deposits := Format(Member.Balance);
//         end;




//         /*
//                 Member.RESET;
//                 Member.SETRANGE(Member."Primary Identification",NationalId);
//                 Member.SETFILTER(Member.Status,'<>%1',vendor.Status::Dormant);
//                 IF Member.FIND('-') THEN BEGIN
//                        REPEAT
        
//                    AccType := STRPOS(Member."No.",'S02');
        
//                        IF(AccType = 1) THEN BEGIN
//                           SharesAccount2 := Member."No.";
//                        END;
        
//                      UNTIL Member.NEXT = 0;
//                 END;
        
        
//               Venderdetails.RESET;
//               Venderdetails.SETRANGE(Venderdetails."Transaction Types",Venderdetails."Transaction Types"::"Deposit Contribution");
//               Venderdetails.SETRANGE(Venderdetails."Customer No.",SharesAccount2);
        
//                IF(Venderdetails.FIND('-')) THEN BEGIN
//                  REPEAT
        
//                      S02Bal :=  S02Bal + (Venderdetails.Amount*-1);
        
//                   UNTIL  Venderdetails.NEXT=0;
//                END;
        
//               deposits := FORMAT(S02Bal);
        
//         */

//     end;


//     procedure GetShares(MemberNo: Text) Shares: Text
//     begin
//         Member.Reset;
//         Member.SetRange(Member."Member No.", MemberNo);
//         Member.SetRange("Product Category", Member."product category"::"Share Capital");

//         if Member.Find('-') then begin
//             Member.CalcFields(Member.Balance);
//             Shares := Format(Member.Balance);
//         end;


//         /*
//                 Member.RESET;
//                 Member.SETRANGE(Member."Primary Identification",NationalId);
//                 Member.SETFILTER(Member.Status,'<>%1',vendor.Status::Dormant);
//                 IF Member.FIND('-') THEN BEGIN
//                        REPEAT
        
//                    AccType := STRPOS(Member."No.",'S01');
        
//                        IF(AccType = 1) THEN BEGIN
//                           SharesAccount1 := Member."No.";
//                        END;
        
//                      UNTIL Member.NEXT = 0;
//                 END;
        
        
//               Venderdetails.RESET;
//               Venderdetails.SETRANGE(Venderdetails."Transaction Types",Venderdetails."Transaction Types"::"Share Capital");
//               Venderdetails.SETRANGE(Venderdetails."Customer No.",SharesAccount1);
        
//                IF(Venderdetails.FIND('-')) THEN BEGIN
//                  REPEAT
        
//                      S01Bal :=  S01Bal + (Venderdetails.Amount*-1);
        
//                   UNTIL  Venderdetails.NEXT=0;
//                END;
        
//               Shares := FORMAT(S01Bal);
        
//         */

//     end;


//     procedure GetAccountBalance(Account: Text[30]) AccountBal: Decimal
//     begin

//         Member.Reset;
//         Member.SetRange("Member No.", Account);
//         Member.SetRange(Member."Product Type", '505');

//         if Member.Find('-') then begin

//             Accounttypes.Reset;
//             Accounttypes.SetRange(Accounttypes."Product ID", Member."Product Type");
//             if Accounttypes.Find('-') then begin
//                 MiniBalance := Accounttypes."Minimum Balance";
//             end;

//             Member.CalcFields(Member."Balance (LCY)");
//             Member.CalcFields(Member."ATM Transactions");
//             Member.CalcFields(Member."Uncleared Cheques");

//             AccountBal := Member."Balance (LCY)" - (Member."ATM Transactions" + Member."Uncleared Cheques" + MiniBalance);

//         end
//         else begin
//             AccountBal := 0;
//         end
//     end;


//     procedure GetExciseDutyGL() account: Text[20]
//     begin

//         GenLedgerSetup.Reset;
//         GenLedgerSetup.Get;
//         GenLedgerSetup.TestField(GenLedgerSetup."Excise Duty G/L");
//         account := GenLedgerSetup."Excise Duty G/L";
//     end;


//     procedure PaybillKeywords(PhoneNo: Text) Keywords: Text
//     begin
//         PhoneNo := '+' + PhoneNo;
//         saccoAccount.Reset;
//         saccoAccount.SetRange(saccoAccount."Transactional Mobile No", PhoneNo);
//         saccoAccount.SetFilter(saccoAccount.Status, '%1|%2', saccoAccount.Status::Active, saccoAccount.Status::New);
//         saccoAccount.SetFilter(saccoAccount."Product Type", '%1', '505');
//         saccoAccount.SetRange(saccoAccount.Blocked, saccoAccount.Blocked::" ");
//         if saccoAccount.FindFirst() then begin
//             saccoAccount1.Reset;
//             saccoAccount1.SetRange(saccoAccount1.Blocked, saccoAccount1.Blocked::" ");
//             saccoAccount1.SetFilter(saccoAccount1.Status, '%1|%2', saccoAccount.Status::Active, saccoAccount.Status::New);
//             saccoAccount1.SetRange(saccoAccount1."Member No.", saccoAccount."Member No.");
//             saccoAccount1.SetFilter(saccoAccount1."Product Type", '%1|%2|%3|%4|%5|%6', '505', '02', '04', '07', '510', '03');
//             if saccoAccount1.Find('-') then begin
//                 repeat
//                     Keywords := Keywords + saccoAccount1."No." + ':' + saccoAccount1."Product Name" + '::';
//                 until saccoAccount1.Next = 0;
//             end
//         end
//     end;


//     procedure GetSavingProducts() ProductCode: Text[1024]
//     var
//         ProductFactory: Record "Product Factory";
//     begin
//         //---Get Product Start----
//         ProductCode := '';

//         ProductFactory.Reset;
//         ProductFactory.SetRange("Product Class Type", ProductFactory."product class type"::Savings);
//         ProductFactory.SetRange(Status, ProductFactory.Status::Active);
//         if ProductFactory.Find('-') then begin
//             repeat
//                 ProductCode := ProductCode + '|' + ProductFactory."Product ID" + '~' + ProductFactory."Product Description";
//             until ProductFactory.Next = 0;
//         end;

//         //----End-----------
//     end;


//     procedure CreateSavingsAccount(MemberNo: Code[20]; AccountType: Code[20]; Name: Text; FDType: Code[20]; Amount: Decimal; MaturityIntsruction: Integer; BirthCertificate: Code[20]; DateofBirth: Date) Results: Text[100]
//     var
//         SavingsAccountApplication: Record "Savings Account Application";
//         RegistrationMngt: Codeunit "Registration Process";
//     begin
//         //===============Create Account==========

//         SavingsAccountApplication.Init;
//         SavingsAccountApplication."No." := '';
//         SavingsAccountApplication."Member No." := MemberNo;
//         SavingsAccountApplication.Validate("Member No.");
//         SavingsAccountApplication."Product Type" := AccountType;
//         SavingsAccountApplication.Validate("Product Type");

//         // if SavingsAccountApplication."Product Category" = SavingsAccountApplication."product category"::"Junior Savings" then begin
//         //     //*************Juniour
//         //     SavingsAccountApplication.Name := Name;
//         //     SavingsAccountApplication."Birth Certificate No." := BirthCertificate;
//         //     SavingsAccountApplication."Date of Birth" := DateofBirth;
//         // end else
//             if SavingsAccountApplication."Product Category" = SavingsAccountApplication."product category"::"Fixed Deposit" then begin
//                 //***********FD Account
//                 SavingsAccountApplication."Fixed Deposit Type" := FDType;
//                 SavingsAccountApplication.Validate("Fixed Deposit Type");
//             end;

//         SavingsAccountApplication.Status := SavingsAccountApplication.Status::Approved;
//         SavingsAccountApplication.Insert(true);

//         //==================Create End.

//         //***********Create Process
//         RegistrationMngt.AccountRegistration(SavingsAccountApplication);

//         saccoAccount.Reset;
//         saccoAccount.SetRange("Member No.", MemberNo);
//         saccoAccount.SetRange("Product Type", AccountType);
//         if saccoAccount.FindFirst then
//             Results := 'Pass'
//         else
//             Results := 'Failed'
//     end;


//     procedure GetNextofKin(PhoneNo: Code[20]) NextKin: Text[1024]
//     var
//         NextofKIN: Record "Next of KIN";
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNumber: Code[20];
//         Beneficiary: Integer;
//     begin

//         //===================Get Next of Kin===========Start
//         if CopyStr(PhoneNo, 1, 1) <> '+' then
//             PhoneNo := '+' + PhoneNo;

//         SavingsAccounts.Reset;
//         SavingsAccounts.SetRange("Transactional Mobile No", PhoneNo);
//         if SavingsAccounts.FindFirst then begin
//             MemberNumber := SavingsAccounts."Member No.";
//         end;

//         //***********Next of Kin
//         NextofKIN.Reset;
//         NextofKIN.SetRange("Record ID", MemberNumber);
//         if NextofKIN.FindFirst then begin
//             repeat
//                 if NextofKIN."Is a Beneficiary" then
//                     Beneficiary := 1
//                 else
//                     Beneficiary := 0;

//                 NextKin := NextKin + '|' + NextofKIN.Name + '~' + NextofKIN.Relationship + '~' + Format(NextofKIN.Allocation) + '~'
//                 + NextofKIN.Identification + '~' + NextofKIN.Address + '~' + NextofKIN.Telephone + '~' + Format(Beneficiary);
//             until NextofKIN.Next = 0;
//         end;
//     end;


//     procedure CreateSaving(One: Integer; two: Integer) t: Text[20]
//     begin
//         Message('');
//         t := 'tEST';
//     end;
// }
